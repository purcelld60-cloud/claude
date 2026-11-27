--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __identV, __lt, __gt, __ge, __mod, __ord, __arrL, __iterar, __t, __get, __arr, __len = __JSR.__identV, __JSR.__lt, __JSR.__gt, __JSR.__ge, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__arr, __JSR.__len
local __call, __add, __iter, __assign, __hypot, __re, __re_replace = __JSR.__call, __JSR.__add, __JSR.__iter, __JSR.__assign, __JSR.__hypot, __JSR.__re, __JSR.__re_replace
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Spread = ____lualib.__TS__Spread
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__Number = ____lualib.__TS__Number
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    local SHOTS = __call(
        __arrL(
            {
                __ord({
                    id = "afterglow",
                    duration = 7,
                    title = "DEPOIS DA FESTA",
                    speaker = "Da Roça",
                    text = "Pera… acabou?"
                }, "id,duration,title,speaker,text"),
                __ord({
                    id = "empty",
                    duration = 7.5,
                    title = "O SILÊNCIO FICOU",
                    speaker = "Da Roça",
                    text = "Pq eu ainda me sinto vazio?"
                }, "id,duration,title,speaker,text"),
                __ord({
                    id = "vibration",
                    duration = 4.5,
                    title = "UMA VIBRAÇÃO NO BOLSO",
                    speaker = "",
                    text = "O celular começa a vibrar."
                }, "id,duration,title,speaker,text"),
                __ord({
                    id = "reach",
                    duration = 5,
                    title = "A LIGAÇÃO",
                    speaker = "",
                    text = "Da Roça tira o celular do bolso."
                }, "id,duration,title,speaker,text"),
                __ord({
                    id = "caller",
                    duration = 5,
                    title = "CHAMADA RECEBIDA",
                    speaker = "",
                    text = "JORGE"
                }, "id,duration,title,speaker,text"),
                __ord({
                    id = "recognition",
                    duration = 3.5,
                    title = "ELE CONHECE ESSE NOME",
                    speaker = "Da Roça",
                    text = "JORGE…"
                }, "id,duration,title,speaker,text"),
                __ord({
                    id = "tremor",
                    duration = 4,
                    title = "O CORPO NÃO RESPONDE",
                    speaker = "",
                    text = "Os olhos se arregalam. A mão começa a tremer."
                }, "id,duration,title,speaker,text"),
                __ord({
                    id = "falling",
                    duration = 4,
                    title = "A QUEDA",
                    speaker = "",
                    text = "O celular escapa da mão."
                }, "id,duration,title,speaker,text"),
                __ord({
                    id = "kneeling",
                    duration = 5.5,
                    title = "SEM PALAVRAS",
                    speaker = "",
                    text = "Da Roça cai de joelhos no escuro."
                }, "id,duration,title,speaker,text"),
                __ord({
                    id = "eyes",
                    duration = 8,
                    title = "O PRÓXIMO CAPÍTULO",
                    speaker = "",
                    text = "FIM DE JOGO, aguardando nova atualização…"
                }, "id,duration,title,speaker,text")
            },
            10
        ),
        "map",
        __identV
    )
    local TOTAL = __call(
        SHOTS,
        "reduce",
        function(____, n, s) return __add(n, s.duration) end,
        0
    )
    local function clamp(____, v, a, b)
        if a == nil then
            a = 0
        end
        if b == nil then
            b = 1
        end
        return math.max(
            a,
            math.min(b, v)
        )
    end
    local function smooth(____, v)
        v = clamp(nil, v)
        return v * v * (3 - 2 * v)
    end
    local function lerp(____, a, b, p)
        return a + (b - a) * p
    end
    local function poly(____, c, points, color)
        c.fillStyle = color
        c:beginPath()
        __call(
            points,
            "forEach",
            function(____, p, i) return if __t(i) then c:lineTo(__TS__Spread(__iter(p))) else c:moveTo(__TS__Spread(__iter(p))) end
        )
        c:closePath()
        __call(c, "fill")
    end
    local function stroke(self, c, points, color, width)
        if width == nil then
            width = 2
        end
        c:beginPath()
        __call(
            points,
            "forEach",
            function(____, p, i) return if __t(i) then c:lineTo(__TS__Spread(__iter(p))) else c:moveTo(__TS__Spread(__iter(p))) end
        )
        c.strokeStyle = color
        c.lineWidth = width
        c.lineCap = "round"
        c.lineJoin = "round"
        c:stroke()
    end
    local function ellipse(self, c, x, y, rx, ry, color)
        c.fillStyle = color
        c:beginPath()
        c:ellipse(
            x,
            y,
            math.max(0.01, rx),
            math.max(0.01, ry),
            0,
            0,
            math.pi * 2
        )
        __call(c, "fill")
    end
    local function text(self, c, value, x, y, size, color, align, weight)
        if color == nil then
            color = "#f5ebdc"
        end
        if align == nil then
            align = "left"
        end
        if weight == nil then
            weight = 500
        end
        c.font = ((tostring(weight) .. " ") .. tostring(size)) .. "px Space,Arial,sans-serif"
        c.textAlign = align
        c.textBaseline = "middle"
        c.fillStyle = color
        c:fillText(value, x, y)
    end
    local function tracked(self, c, value, x, y, size, spacing, color)
        if size == nil then
            size = 11
        end
        if spacing == nil then
            spacing = 3
        end
        if color == nil then
            color = "#a49bb9"
        end
        c.font = ("600 " .. tostring(size)) .. "px Space,Arial,sans-serif"
        local chars = __arr(__TS__Spread(__iter(value)))
        local width = __call(
            chars,
            "reduce",
            function(____, n, l) return __add(
                n,
                c:measureText(l).width
            ) end,
            0
        ) + (__len(chars) - 1) * spacing
        local at = x - width / 2
        c.fillStyle = color
        c.textBaseline = "middle"
        for ____, l in __iterar((chars)) do
            c:fillText(l, at, y)
            at = at + (c:measureText(l).width + spacing)
        end
    end
    local function glow(self, c, x, y, r, color, alpha)
        if alpha == nil then
            alpha = 0.3
        end
        c:save()
        c.globalAlpha = c.globalAlpha * alpha
        local g = c:createRadialGradient(
            x,
            y,
            0,
            x,
            y,
            r
        )
        g:addColorStop(0, color)
        g:addColorStop(1, "#00000000")
        c.fillStyle = g
        c:fillRect(x - r, y - r, r * 2, r * 2)
        c:restore()
    end
    local function atmosphere(self, c, t, amount)
        if amount == nil then
            amount = 24
        end
        do
            local i = 0
            while i < amount do
                local x = __mod(
                    i * 127.31 + math.sin(t * 0.17 + i) * 23 + 1100,
                    960
                )
                local y = __mod(
                    i * 79.17 - t * (3 + __mod(i, 5)) + 2200,
                    540
                )
                c:save()
                c.globalAlpha = 0.06 + __mod(i, 4) * 0.015
                ellipse(
                    nil,
                    c,
                    x,
                    y,
                    if __mod(i, 3) == 0 then 1.4 else 0.7,
                    if __mod(i, 3) == 0 then 1.4 else 0.7,
                    "#d5bdff"
                )
                c:restore()
                i = i + 1
            end
        end
    end
    local function grain(self, c, t)
        c:save()
        c.globalAlpha = 0.033
        local tick = math.floor(t * 12)
        do
            local i = 0
            while i < 190 do
                local x = __mod(i * 191 + tick * 7, 960)
                local y = __mod(i * i * 17 + tick * 31, 540)
                c.fillStyle = if __t(__mod(i, 2)) then "#d3c2d9" else "#050509"
                c:fillRect(
                    x,
                    y,
                    1 + (__mod(i, 3) == 0),
                    1
                )
                i = i + 1
            end
        end
        c:restore()
    end
    local function ground(self, c, x, y, w)
        if w == nil then
            w = 270
        end
        c:save()
        c:translate(x, y)
        c:scale(1, 0.2)
        local g = c:createRadialGradient(
            0,
            0,
            0,
            0,
            0,
            w
        )
        g:addColorStop(0, "#75618345")
        g:addColorStop(0.5, "#33264024")
        g:addColorStop(1, "#00000000")
        c.fillStyle = g
        c:fillRect(-w, -w, w * 2, w * 2)
        c:restore()
    end
    local function eye(self, c, x, y, side, openness, pupil, t, lookX, blink)
        if openness == nil then
            openness = 0
        end
        if pupil == nil then
            pupil = 0.6
        end
        if t == nil then
            t = 0
        end
        if lookX == nil then
            lookX = 0
        end
        if blink == nil then
            blink = 0
        end
        local h = math.max(
            1.2,
            lerp(
                nil,
                9,
                29,
                clamp(nil, openness)
            ) * (1 - clamp(nil, blink) * 0.94)
        )
        local left = x - 35
        local right = x + 35
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({left, y + 1}, 2),
                    __arrL({x - 20, y - h * 0.75}, 2),
                    __arrL({x + 17, y - h}, 2),
                    __arrL({right, y - 2}, 2),
                    __arrL({x + 23, y + h * 0.62}, 2),
                    __arrL({x - 15, y + h * 0.72}, 2)
                },
                6
            ),
            "#111016"
        )
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({left + 5, y + 1}, 2),
                    __arrL({x - 18, y - h * 0.62}, 2),
                    __arrL({x + 17, y - h * 0.82}, 2),
                    __arrL({right - 5, y - 1}, 2),
                    __arrL({x + 20, y + h * 0.48}, 2),
                    __arrL({x - 14, y + h * 0.55}, 2)
                },
                6
            ),
            "#eadfd4"
        )
        if blink < 0.9 then
            ellipse(
                nil,
                c,
                x + lookX,
                y + openness,
                lerp(nil, 12, 11, openness),
                math.min(14, h * 0.72),
                "#624a35"
            )
            ellipse(
                nil,
                c,
                x + lookX,
                y + openness,
                lerp(nil, 5.8, 3.8, openness),
                math.min(5.8, h * 0.52),
                "#151318"
            )
            ellipse(
                nil,
                c,
                x + lookX - 3,
                y - 3,
                2.2,
                math.min(2.9, h * 0.4),
                "#fff2d9"
            )
            local ____t_5 = __t
            local ____opt_2 = window.Graphics
            if ____opt_2 ~= nil then
                ____opt_2 = ____opt_2.isLite
            end
            local ____opt_result_4
            if ____opt_2 ~= nil then
                ____opt_result_4 = ____opt_2(____opt_2)
            end
            if not ____t_5(____opt_result_4) then
                c:save()
                c:beginPath()
                c:ellipse(
                    x + lookX,
                    y + openness,
                    lerp(nil, 12, 11, openness),
                    math.min(14, h * 0.72),
                    0,
                    0,
                    math.pi * 2
                )
                c:clip()
                local ir = c:createRadialGradient(
                    x + lookX,
                    y + openness,
                    1,
                    x + lookX,
                    y + openness,
                    13
                )
                ir:addColorStop(0, "rgba(170,120,70,0)")
                ir:addColorStop(0.55, "rgba(150,100,55,.35)")
                ir:addColorStop(1, "rgba(30,18,12,.75)")
                c.fillStyle = ir
                c:fillRect(x - 20, y - 20, 40, 40)
                do
                    local i = 0
                    while i < 10 do
                        local a = i / 10 * math.pi * 2
                        c.strokeStyle = "rgba(40,25,15,.35)"
                        c.lineWidth = 0.8
                        c:beginPath()
                        c:moveTo(
                            x + lookX + math.cos(a) * 5,
                            y + openness + math.sin(a) * 5
                        )
                        c:lineTo(
                            x + lookX + math.cos(a) * 10,
                            y + openness + math.sin(a) * 10
                        )
                        c:stroke()
                        i = i + 1
                    end
                end
                c:restore()
                ellipse(
                    nil,
                    c,
                    x + lookX - 3,
                    y - 3,
                    2.2,
                    math.min(2.9, h * 0.4),
                    "#fff8ea"
                )
                ellipse(
                    nil,
                    c,
                    x + lookX + 4,
                    y + 4,
                    1.1,
                    1.1,
                    "rgba(255,248,234,.7)"
                )
            end
        end
        local ____t_11 = __t
        local ____opt_8 = window.Graphics
        if ____opt_8 ~= nil then
            ____opt_8 = ____opt_8.isLite
        end
        local ____opt_result_10
        if ____opt_8 ~= nil then
            ____opt_result_10 = ____opt_8(____opt_8)
        end
        if not ____t_11(____opt_result_10) then
            c:save()
            c:beginPath()
            c:moveTo(left + 5, y + 1)
            c:lineTo(x - 18, y - h * 0.62)
            c:lineTo(x + 17, y - h * 0.82)
            c:lineTo(right - 5, y - 1)
            c:lineTo(x + 20, y + h * 0.48)
            c:lineTo(x - 14, y + h * 0.55)
            c:closePath()
            c:clip()
            local lid = c:createLinearGradient(0, y - h, 0, y + h * 0.2)
            lid:addColorStop(0, "rgba(40,24,22,.55)")
            lid:addColorStop(1, "rgba(40,24,22,0)")
            c.fillStyle = lid
            c:fillRect(left, y - h, 70, h * 1.2)
            c:restore()
            stroke(
                nil,
                c,
                __arrL(
                    {
                        __arrL({x - 14, y + h * 0.6}, 2),
                        __arrL({x + 2, y + h * 0.68}, 2),
                        __arrL({x + 20, y + h * 0.54}, 2)
                    },
                    3
                ),
                "rgba(255,214,200,.55)",
                1.2
            )
        end
        stroke(
            nil,
            c,
            __arrL(
                {
                    __arrL({left, y + 1}, 2),
                    __arrL({x - 18, y - h * 0.77}, 2),
                    __arrL({x + 17, y - h}, 2),
                    __arrL({right, y - 2}, 2)
                },
                4
            ),
            "#18131a",
            4
        )
        local base = y - 9 - 18
        local outer = base - openness * 10
        local inner = base - openness * 27
        stroke(
            nil,
            c,
            if __lt(side, 0) then __arrL(
                {
                    __arrL({left - 2, outer}, 2),
                    __arrL({x - 17, base - 6 - openness * 16}, 2),
                    __arrL({right - 1, inner}, 2)
                },
                3
            ) else __arrL(
                {
                    __arrL({left - 2, inner}, 2),
                    __arrL({x + 13, base - 6 - openness * 16}, 2),
                    __arrL({right - 1, outer}, 2)
                },
                3
            ),
            "#251c1d",
            8
        )
        if openness > 0.7 then
            stroke(
                nil,
                c,
                __arrL(
                    {
                        __arrL({left + 4, y + h + 7}, 2),
                        __arrL({x - 5, y + h + 11}, 2),
                        __arrL({right - 4, y + h + 6}, 2)
                    },
                    3
                ),
                "#8e5a47",
                1.6
            )
        end
    end
    local function hat(self, c, t, tilt)
        if tilt == nil then
            tilt = 0
        end
        c:save()
        c:translate(0, -105)
        c:rotate(tilt)
        ellipse(
            nil,
            c,
            1,
            0,
            181,
            33,
            "#4c3023"
        )
        ellipse(
            nil,
            c,
            -2,
            -7,
            177,
            31,
            "#a77d43"
        )
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-94, -13}, 2),
                    __arrL({-80, -91}, 2),
                    __arrL({-57, -107}, 2),
                    __arrL({58, -108}, 2),
                    __arrL({91, -87}, 2),
                    __arrL({105, -8}, 2)
                },
                6
            ),
            "#a67e43"
        )
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-80, -16}, 2),
                    __arrL({-68, -86}, 2),
                    __arrL({-52, -98}, 2),
                    __arrL({51, -100}, 2),
                    __arrL({78, -80}, 2),
                    __arrL({91, -13}, 2)
                },
                6
            ),
            "#d6b56f"
        )
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-65, -89}, 2),
                    __arrL({-43, -98}, 2),
                    __arrL({44, -99}, 2),
                    __arrL({68, -82}, 2),
                    __arrL({22, -85}, 2)
                },
                5
            ),
            "#ebcd85"
        )
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({45, -99}, 2),
                    __arrL({77, -79}, 2),
                    __arrL({90, -13}, 2),
                    __arrL({55, -12}, 2)
                },
                4
            ),
            "#b18a4c"
        )
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-87, -35}, 2),
                    __arrL({96, -32}, 2),
                    __arrL({99, -14}, 2),
                    __arrL({-91, -16}, 2)
                },
                4
            ),
            "#6c422c"
        )
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-84, -32}, 2),
                    __arrL({57, -30}, 2),
                    __arrL({58, -18}, 2),
                    __arrL({-87, -20}, 2)
                },
                4
            ),
            "#9b5b34"
        )
        ellipse(
            nil,
            c,
            -2,
            -6,
            172,
            24,
            "#d4b06a"
        )
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-168, -5}, 2),
                    __arrL({-84, -17}, 2),
                    __arrL({45, -17}, 2),
                    __arrL({169, -1}, 2),
                    __arrL({102, 6}, 2),
                    __arrL({-69, 8}, 2)
                },
                6
            ),
            "#e7c27c"
        )
        stroke(
            nil,
            c,
            __arrL(
                {
                    __arrL({-165, -3}, 2),
                    __arrL({-81, -15}, 2),
                    __arrL({60, -13}, 2),
                    __arrL({162, 0}, 2)
                },
                4
            ),
            "#f6d892",
            2
        )
        do
            local i = -6
            while i < 7 do
                stroke(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({i * 22, -16}, 2),
                            __arrL({i * 24, 5}, 2)
                        },
                        2
                    ),
                    "#a9834c",
                    1
                )
                i = i + 1
            end
        end
        do
            local i = -3
            while i < 4 do
                stroke(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({i * 18, -91}, 2),
                            __arrL({i * 22, -39}, 2)
                        },
                        2
                    ),
                    "#b99456",
                    1
                )
                i = i + 1
            end
        end
        c:restore()
    end
    local function face(self, c, x, y, s, t, o)
        if o == nil then
            o = {}
        end
        c:save()
        c:translate(
            x,
            y + math.sin(t * 1.65) * if __gt(o.fear, 0.5) then 0.5 else 1.5
        )
        c:scale(s, s)
        c:rotate(if __t(o.tilt) then o.tilt else 0)
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-80, 112}, 2),
                    __arrL({-72, 163}, 2),
                    __arrL({69, 168}, 2),
                    __arrL({78, 111}, 2)
                },
                4
            ),
            "#89523a"
        )
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-58, 116}, 2),
                    __arrL({-51, 159}, 2),
                    __arrL({24, 169}, 2),
                    __arrL({65, 150}, 2),
                    __arrL({63, 107}, 2)
                },
                5
            ),
            "#b87950"
        )
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-130, 155}, 2),
                    __arrL({-72, 135}, 2),
                    __arrL({-20, 172}, 2),
                    __arrL({29, 174}, 2),
                    __arrL({77, 132}, 2),
                    __arrL({140, 161}, 2),
                    __arrL({177, 342}, 2),
                    __arrL({-174, 342}, 2)
                },
                8
            ),
            "#9c4d2e"
        )
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-128, 159}, 2),
                    __arrL({-82, 143}, 2),
                    __arrL({-23, 183}, 2),
                    __arrL({28, 185}, 2),
                    __arrL({78, 143}, 2),
                    __arrL({132, 165}, 2),
                    __arrL({153, 342}, 2),
                    __arrL({-151, 342}, 2)
                },
                8
            ),
            "#ce7540"
        )
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({78, 145}, 2),
                    __arrL({126, 163}, 2),
                    __arrL({150, 342}, 2),
                    __arrL({93, 342}, 2)
                },
                4
            ),
            "#713729"
        )
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-100, 155}, 2),
                    __arrL({-67, 174}, 2),
                    __arrL({-35, 230}, 2),
                    __arrL({-80, 210}, 2)
                },
                4
            ),
            "#e59958"
        )
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-22, 180}, 2),
                    __arrL({-10, 342}, 2),
                    __arrL({14, 342}, 2),
                    __arrL({27, 181}, 2)
                },
                4
            ),
            "#965032"
        )
        stroke(
            nil,
            c,
            __arrL(
                {
                    __arrL({-98, 214}, 2),
                    __arrL({-69, 266}, 2),
                    __arrL({-78, 319}, 2)
                },
                3
            ),
            "#9e4c2c",
            3
        )
        stroke(
            nil,
            c,
            __arrL(
                {
                    __arrL({83, 217}, 2),
                    __arrL({63, 281}, 2),
                    __arrL({80, 333}, 2)
                },
                3
            ),
            "#ed9a54",
            2
        )
        ellipse(
            nil,
            c,
            -102,
            17,
            22,
            37,
            "#8f563c"
        )
        ellipse(
            nil,
            c,
            102,
            18,
            23,
            37,
            "#7e4936"
        )
        ellipse(
            nil,
            c,
            -103,
            16,
            12,
            24,
            "#bf8055"
        )
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-102, -87}, 2),
                    __arrL({-72, -119}, 2),
                    __arrL({60, -122}, 2),
                    __arrL({101, -87}, 2),
                    __arrL({103, 50}, 2),
                    __arrL({73, 112}, 2),
                    __arrL({26, 141}, 2),
                    __arrL({-18, 140}, 2),
                    __arrL({-75, 111}, 2),
                    __arrL({-104, 54}, 2)
                },
                10
            ),
            "#714231"
        )
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-94, -81}, 2),
                    __arrL({-67, -109}, 2),
                    __arrL({58, -111}, 2),
                    __arrL({94, -81}, 2),
                    __arrL({93, 47}, 2),
                    __arrL({65, 105}, 2),
                    __arrL({23, 131}, 2),
                    __arrL({-16, 130}, 2),
                    __arrL({-68, 104}, 2),
                    __arrL({-95, 49}, 2)
                },
                10
            ),
            "#bf8259"
        )
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-94, -81}, 2),
                    __arrL({-66, -107}, 2),
                    __arrL({-17, -110}, 2),
                    __arrL({-31, 40}, 2),
                    __arrL({-18, 128}, 2),
                    __arrL({-67, 103}, 2),
                    __arrL({-95, 49}, 2)
                },
                7
            ),
            "#d39a68"
        )
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({52, -109}, 2),
                    __arrL({93, -79}, 2),
                    __arrL({93, 48}, 2),
                    __arrL({65, 106}, 2),
                    __arrL({24, 132}, 2),
                    __arrL({34, 54}, 2)
                },
                6
            ),
            "#9b6045"
        )
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({69, -49}, 2),
                    __arrL({93, -76}, 2),
                    __arrL({93, 48}, 2),
                    __arrL({66, 103}, 2),
                    __arrL({73, 36}, 2)
                },
                5
            ),
            "#704233"
        )
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-84, 58}, 2),
                    __arrL({-63, 97}, 2),
                    __arrL({-18, 122}, 2),
                    __arrL({-21, 106}, 2),
                    __arrL({-64, 71}, 2)
                },
                5
            ),
            "#b3714f"
        )
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-13, 1}, 2),
                    __arrL({-17, 49}, 2),
                    __arrL({2, 59}, 2),
                    __arrL({24, 49}, 2),
                    __arrL({5, 43}, 2),
                    __arrL({1, 0}, 2)
                },
                6
            ),
            "#93583f"
        )
        stroke(
            nil,
            c,
            __arrL(
                {
                    __arrL({2, 3}, 2),
                    __arrL({6, 42}, 2),
                    __arrL({23, 48}, 2)
                },
                3
            ),
            "#dfaa78",
            2
        )
        if __gt(o.fear, 0.6) then
            local quiver = math.sin(t * 31) * 0.7
            ellipse(
                nil,
                c,
                2,
                97 + quiver,
                17,
                15,
                "#342126"
            )
            stroke(
                nil,
                c,
                __arrL(
                    {
                        __arrL({-20, 94 + quiver}, 2),
                        __arrL({-9, 86}, 2),
                        __arrL({10, 87}, 2),
                        __arrL({21, 93 + quiver}, 2)
                    },
                    4
                ),
                "#8a5142",
                2
            )
            poly(
                nil,
                c,
                __arrL(
                    {
                        __arrL({-10, 86}, 2),
                        __arrL({12, 87}, 2),
                        __arrL({11, 90}, 2),
                        __arrL({-9, 89}, 2)
                    },
                    4
                ),
                "#d6b295"
            )
        else
            stroke(
                nil,
                c,
                __arrL(
                    {
                        __arrL({-30, 97}, 2),
                        __arrL({0, 91}, 2),
                        __arrL({28, 96}, 2)
                    },
                    3
                ),
                "#744333",
                2.5
            )
            stroke(
                nil,
                c,
                __arrL(
                    {
                        __arrL({-10, 103}, 2),
                        __arrL({7, 104}, 2)
                    },
                    2
                ),
                "#a5684e",
                1
            )
        end
        local blink = if __gt(o.fear, 0.4) then 0 else clamp(
            nil,
            1 - math.abs(t - 3.9) / 0.18
        )
        local look = if __gt(o.fear, 0.4) then 0 else -2.5
        eye(
            nil,
            c,
            -48,
            13,
            -1,
            if __t(o.fear) then o.fear else 0,
            if __gt(o.fear, 0.5) then 0.42 else 0.9,
            t,
            look,
            blink
        )
        eye(
            nil,
            c,
            47,
            10,
            1,
            if __t(o.fear) then o.fear else 0,
            if __gt(o.fear, 0.5) then 0.42 else 0.9,
            t,
            look,
            blink
        )
        local ____t_17 = __t
        local ____opt_14 = window.Graphics
        if ____opt_14 ~= nil then
            ____opt_14 = ____opt_14.isLite
        end
        local ____opt_result_16
        if ____opt_14 ~= nil then
            ____opt_result_16 = ____opt_14(____opt_14)
        end
        if not ____t_17(____opt_result_16) then
            c:save()
            c:beginPath()
            __call(
                __arrL(
                    {
                        __arrL({-102, -87}, 2),
                        __arrL({-72, -119}, 2),
                        __arrL({60, -122}, 2),
                        __arrL({101, -87}, 2),
                        __arrL({103, 50}, 2),
                        __arrL({73, 112}, 2),
                        __arrL({26, 141}, 2),
                        __arrL({-18, 140}, 2),
                        __arrL({-75, 111}, 2),
                        __arrL({-104, 54}, 2)
                    },
                    10
                ),
                "forEach",
                function(____, p, i) return if __t(i) then c:lineTo(
                    __get(p, 0),
                    __get(p, 1)
                ) else c:moveTo(
                    __get(p, 0),
                    __get(p, 1)
                ) end
            )
            c:closePath()
            c:clip()
            local function blob(____, x, y, r, col)
                local g = c:createRadialGradient(
                    x,
                    y,
                    1,
                    x,
                    y,
                    r
                )
                g:addColorStop(0, col)
                g:addColorStop(
                    1,
                    __re_replace(
                        col,
                        __re("[\\d.]+\\)$", ""),
                        "0)"
                    )
                )
                c.fillStyle = g
                c:fillRect(x - r, y - r, r * 2, r * 2)
            end
            blob(
                nil,
                -58,
                62,
                38,
                "rgba(214,104,86,.22)"
            )
            blob(
                nil,
                58,
                58,
                34,
                "rgba(190,90,80,.18)"
            )
            blob(
                nil,
                -30,
                -58,
                60,
                "rgba(255,226,186,.16)"
            )
            blob(
                nil,
                0,
                150,
                70,
                "rgba(40,20,20,.35)"
            )
            blob(
                nil,
                96,
                10,
                60,
                "rgba(30,20,40,.28)"
            )
            blob(
                nil,
                -6,
                58,
                16,
                "rgba(70,35,25,.35)"
            )
            ellipse(
                nil,
                c,
                -8,
                55,
                3.4,
                2.2,
                "rgba(45,22,18,.7)"
            )
            ellipse(
                nil,
                c,
                12,
                54,
                3.4,
                2.2,
                "rgba(45,22,18,.7)"
            )
            stroke(
                nil,
                c,
                __arrL(
                    {
                        __arrL({-24, 58}, 2),
                        __arrL({-34, 84}, 2),
                        __arrL({-30, 104}, 2)
                    },
                    3
                ),
                "rgba(110,60,40,.35)",
                2
            )
            stroke(
                nil,
                c,
                __arrL(
                    {
                        __arrL({26, 56}, 2),
                        __arrL({36, 82}, 2),
                        __arrL({32, 102}, 2)
                    },
                    3
                ),
                "rgba(110,60,40,.3)",
                2
            )
            c.fillStyle = "rgba(50,30,25,.28)"
            do
                local i = 0
                while i < 140 do
                    local a = __mod(i * 137.5, 360) * math.pi / 180
                    local rr = 60 + __mod(i * 37, 40)
                    local sx = math.cos(a) * rr * 0.85
                    local sy = 70 + math.abs(math.sin(a)) * rr * 0.55
                    if __t(sy > 75 and math.abs(sx) < 85) then
                        c:fillRect(sx, sy, 1.4, 1.4)
                    end
                    i = i + 1
                end
            end
            if __gt(o.fear, 0.5) then
                blob(
                    nil,
                    -48,
                    34,
                    20,
                    "rgba(80,50,70,.3)"
                )
                blob(
                    nil,
                    47,
                    31,
                    20,
                    "rgba(80,50,70,.3)"
                )
                do
                    local i = 0
                    while i < 4 do
                        local p = __mod(t * 0.4 + i * 0.27, 1)
                        ellipse(
                            nil,
                            c,
                            -70 + i * 45,
                            -60 + p * 30 + __mod(i * 13, 20),
                            2.2,
                            3,
                            "rgba(220,235,240,.55)"
                        )
                        i = i + 1
                    end
                end
            end
            c:restore()
        end
        local shade = c:createLinearGradient(0, -80, 0, 75)
        shade:addColorStop(0, "#17131bd9")
        shade:addColorStop(0.65, "#19141c44")
        shade:addColorStop(1, "#17131b00")
        c.fillStyle = shade
        c:fillRect(-98, -88, 197, 147)
        stroke(
            nil,
            c,
            __arrL(
                {
                    __arrL({-96, -67}, 2),
                    __arrL({-97, 41}, 2),
                    __arrL({-67, 102}, 2)
                },
                3
            ),
            "#edbd82",
            2
        )
        stroke(
            nil,
            c,
            __arrL(
                {
                    __arrL({94, -58}, 2),
                    __arrL({94, 42}, 2),
                    __arrL({66, 104}, 2)
                },
                3
            ),
            "#a28cbd",
            1.7
        )
        if __t(o.sweat) then
            local p = __mod(t * 0.28, 1)
            c:save()
            c.globalAlpha = 0.65
            poly(
                nil,
                c,
                __arrL(
                    {
                        __arrL({77, 31 + p * 42}, 2),
                        __arrL({73, 42 + p * 42}, 2),
                        __arrL({77, 47 + p * 42}, 2),
                        __arrL({81, 42 + p * 42}, 2)
                    },
                    4
                ),
                "#c3d8df"
            )
            c:restore()
        end
        hat(nil, c, t, if __t(o.hatTilt) then o.hatTilt else 0)
        c:restore()
    end
    local function palm(self, c, x, y, s, rotation)
        if s == nil then
            s = 1
        end
        if rotation == nil then
            rotation = 0
        end
        c:save()
        c:translate(x, y)
        c:rotate(rotation)
        c:scale(s, s)
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-27, -8}, 2),
                    __arrL({-22, -41}, 2),
                    __arrL({-9, -45}, 2),
                    __arrL({-7, -10}, 2),
                    __arrL({0, -54}, 2),
                    __arrL({12, -52}, 2),
                    __arrL({13, -9}, 2),
                    __arrL({21, -46}, 2),
                    __arrL({32, -42}, 2),
                    __arrL({28, 2}, 2),
                    __arrL({35, -25}, 2),
                    __arrL({46, -18}, 2),
                    __arrL({35, 26}, 2),
                    __arrL({14, 48}, 2),
                    __arrL({-15, 39}, 2),
                    __arrL({-31, 15}, 2)
                },
                16
            ),
            "#6e4438"
        )
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-22, -7}, 2),
                    __arrL({-18, -35}, 2),
                    __arrL({-12, -37}, 2),
                    __arrL({-10, 1}, 2),
                    __arrL({4, -47}, 2),
                    __arrL({9, -46}, 2),
                    __arrL({9, -2}, 2),
                    __arrL({24, -39}, 2),
                    __arrL({28, -36}, 2),
                    __arrL({23, 9}, 2),
                    __arrL({37, -17}, 2),
                    __arrL({41, -13}, 2),
                    __arrL({31, 22}, 2),
                    __arrL({13, 40}, 2),
                    __arrL({-11, 33}, 2),
                    __arrL({-25, 12}, 2)
                },
                16
            ),
            "#c38a63"
        )
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-17, 11}, 2),
                    __arrL({-6, 6}, 2),
                    __arrL({17, 16}, 2),
                    __arrL({12, 35}, 2),
                    __arrL({-10, 29}, 2)
                },
                5
            ),
            "#d7a277"
        )
        stroke(
            nil,
            c,
            __arrL(
                {
                    __arrL({-9, 14}, 2),
                    __arrL({8, 9}, 2),
                    __arrL({20, 14}, 2)
                },
                3
            ),
            "#a66d50",
            2
        )
        c:restore()
    end
    local function phone(self, c, x, y, scale, t, o)
        if o == nil then
            o = {}
        end
        c:save()
        c:translate(x, y)
        c:rotate(if __t(o.angle) then o.angle else 0)
        c:scale(scale, scale)
        c:transform(
            1,
            if __t(o.skew) then o.skew else 0,
            if __t(o.perspective) then o.perspective else 0,
            1,
            0,
            0
        )
        local w = 232
        local h = 420
        if __t(o.hand) then
            palm(
                nil,
                c,
                -81,
                121,
                2,
                -0.18
            )
        end
        c:save()
        c.shadowColor = "#8163b8"
        c.shadowBlur = if __t(o.glow) then 28 else 8
        c.fillStyle = "#15141e"
        c:fillRect(-w / 2 - 5, -h / 2 + 8, w + 12, h + 4)
        c:restore()
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-w / 2, -h / 2}, 2),
                    __arrL({w / 2, -h / 2}, 2),
                    __arrL({w / 2 + 7, -h / 2 + 9}, 2),
                    __arrL({w / 2 + 7, h / 2 + 5}, 2),
                    __arrL({-w / 2, h / 2}, 2)
                },
                5
            ),
            "#5e5d71"
        )
        c.fillStyle = "#252330"
        c:fillRect(-w / 2, -h / 2, w, h)
        local glass = c:createLinearGradient(0, -h / 2, 0, h / 2)
        glass:addColorStop(0, "#17202d")
        glass:addColorStop(0.55, "#11141e")
        glass:addColorStop(1, "#080a11")
        c.fillStyle = glass
        c:fillRect(-w / 2 + 6, -h / 2 + 7, w - 12, h - 14)
        stroke(
            nil,
            c,
            __arrL(
                {
                    __arrL({-w / 2 + 2, h / 2 - 3}, 2),
                    __arrL({-w / 2 + 2, -h / 2 + 2}, 2),
                    __arrL({w / 2 - 2, -h / 2 + 2}, 2)
                },
                3
            ),
            "#bab8c3",
            1.5
        )
        c.fillStyle = "#080912"
        c:fillRect(-35, -h / 2 + 10, 70, 12)
        ellipse(
            nil,
            c,
            43,
            -h / 2 + 16,
            4,
            4,
            "#464958"
        )
        text(
            nil,
            c,
            "CHAMADA RECEBIDA",
            0,
            -127,
            11,
            "#c0c3d4",
            "center",
            600
        )
        text(
            nil,
            c,
            if __t(o.concealCaller) then "…" else "JORGE",
            0,
            -81,
            38,
            "#f5f3ff",
            "center",
            650
        )
        text(
            nil,
            c,
            "celular",
            0,
            -47,
            11,
            "#81889f",
            "center"
        )
        ellipse(
            nil,
            c,
            0,
            20,
            47,
            47,
            "#252938"
        )
        ellipse(
            nil,
            c,
            0,
            8,
            14,
            16,
            "#8991a4"
        )
        ellipse(
            nil,
            c,
            0,
            39,
            26,
            15,
            "#8991a4"
        )
        for ____, side in __iterar((__arrL({-1, 1}, 2))) do
            local xx = side * 58
            ellipse(
                nil,
                c,
                xx,
                132,
                24,
                24,
                if side < 0 then "#9f4859" else "#4a8b74"
            )
            c:save()
            c:translate(xx, 132)
            c:rotate(if side < 0 then math.pi else 0)
            stroke(
                nil,
                c,
                __arrL(
                    {
                        __arrL({-11, -3}, 2),
                        __arrL({-7, -8}, 2),
                        __arrL({1, -9}, 2),
                        __arrL({9, -4}, 2)
                    },
                    4
                ),
                "#f4efec",
                4
            )
            c.fillStyle = "#f4efec"
            c:fillRect(-14, -3, 5, 8)
            c:fillRect(7, -3, 5, 8)
            c:restore()
            text(
                nil,
                c,
                if side < 0 then "Recusar" else "Atender",
                xx,
                168,
                10,
                "#b7becf",
                "center"
            )
        end
        c:save()
        c.globalAlpha = 0.1
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-w / 2 + 7, -h / 2 + 8}, 2),
                    __arrL({-w / 2 + 78, -h / 2 + 8}, 2),
                    __arrL({w / 2 - 7, 120}, 2),
                    __arrL({w / 2 - 7, 202}, 2)
                },
                4
            ),
            "#a6b7dc"
        )
        c:restore()
        if __t(o.hand) then
            poly(
                nil,
                c,
                __arrL(
                    {
                        __arrL({99, 55}, 2),
                        __arrL({122, 71}, 2),
                        __arrL({111, 140}, 2),
                        __arrL({84, 158}, 2),
                        __arrL({72, 151}, 2),
                        __arrL({84, 111}, 2)
                    },
                    6
                ),
                "#b17a58"
            )
            stroke(
                nil,
                c,
                __arrL(
                    {
                        __arrL({108, 71}, 2),
                        __arrL({95, 127}, 2),
                        __arrL({84, 145}, 2)
                    },
                    3
                ),
                "#dbab7f",
                3
            )
        end
        c:restore()
    end
    local function pocket(self, c, t, p)
        c:save()
        c:translate(485, 278)
        c:rotate(-0.07)
        c:scale(1.6, 1.6)
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-150, -142}, 2),
                    __arrL({-48, -163}, 2),
                    __arrL({88, -137}, 2),
                    __arrL({157, 162}, 2),
                    __arrL({-153, 163}, 2)
                },
                5
            ),
            "#713a2b"
        )
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-139, -135}, 2),
                    __arrL({-47, -152}, 2),
                    __arrL({78, -129}, 2),
                    __arrL({136, 163}, 2),
                    __arrL({-143, 163}, 2)
                },
                5
            ),
            "#c57543"
        )
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({17, -140}, 2),
                    __arrL({76, -126}, 2),
                    __arrL({134, 163}, 2),
                    __arrL({45, 163}, 2)
                },
                4
            ),
            "#9c4d32"
        )
        stroke(
            nil,
            c,
            __arrL(
                {
                    __arrL({-99, -111}, 2),
                    __arrL({-84, 23}, 2),
                    __arrL({-104, 139}, 2)
                },
                3
            ),
            "#e3a365",
            3
        )
        stroke(
            nil,
            c,
            __arrL(
                {
                    __arrL({18, -112}, 2),
                    __arrL({35, 158}, 2)
                },
                2
            ),
            "#76402e",
            4
        )
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-15, -6}, 2),
                    __arrL({83, -14}, 2),
                    __arrL({91, 81}, 2),
                    __arrL({-3, 90}, 2)
                },
                4
            ),
            "#8c4a32"
        )
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-12, 0}, 2),
                    __arrL({79, -8}, 2),
                    __arrL({84, 75}, 2),
                    __arrL({2, 81}, 2)
                },
                4
            ),
            "#af623d"
        )
        stroke(
            nil,
            c,
            __arrL(
                {
                    __arrL({-13, -2}, 2),
                    __arrL({81, -10}, 2)
                },
                2
            ),
            "#e3a468",
            3
        )
        local shake = math.sin(t * 51) * 2.1 + math.sin(t * 29)
        c:save()
        c:translate(35 + shake, 12)
        c:rotate(0.16)
        c.fillStyle = "#26232f"
        c:fillRect(-20, -42, 43, 60)
        c.fillStyle = "#6f7184"
        c:fillRect(-17, -39, 37, 4)
        c:restore()
        if __gt(p, 0.05) then
            palm(
                nil,
                c,
                92 - p * 38,
                -97 + p * 103,
                1.75,
                -0.2 - p * 0.2
            )
        end
        c:restore()
        for ____, side in __iterar((__arrL({-1, 1}, 2))) do
            local x = 525 + side * 101
            stroke(
                nil,
                c,
                __arrL(
                    {
                        __arrL({x, 290}, 2),
                        __arrL({x + side * 8, 299}, 2),
                        __arrL({x, 311}, 2),
                        __arrL({x + side * 8, 322}, 2)
                    },
                    4
                ),
                "#a8a0bf",
                2
            )
        end
        tracked(
            nil,
            c,
            "brr…  brr…",
            518,
            428,
            13,
            3,
            "#b5a9c9"
        )
    end
    local function purpleEye(self, c, x, y, side, t)
        c:save()
        c:translate(x, y)
        c:scale(side, 1)
        glow(
            nil,
            c,
            0,
            0,
            170,
            "#9455ef",
            0.23
        )
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-122, -18}, 2),
                    __arrL({-61, -40}, 2),
                    __arrL({10, -22}, 2),
                    __arrL({112, 10}, 2),
                    __arrL({49, 34}, 2),
                    __arrL({-23, 37}, 2),
                    __arrL({-88, 18}, 2)
                },
                7
            ),
            "#4b2480"
        )
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-113, -14}, 2),
                    __arrL({-57, -31}, 2),
                    __arrL({10, -16}, 2),
                    __arrL({103, 9}, 2),
                    __arrL({47, 26}, 2),
                    __arrL({-19, 28}, 2),
                    __arrL({-83, 12}, 2)
                },
                7
            ),
            "#ae6aff"
        )
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-98, -9}, 2),
                    __arrL({-50, -22}, 2),
                    __arrL({9, -9}, 2),
                    __arrL({86, 10}, 2),
                    __arrL({44, 18}, 2),
                    __arrL({-17, 20}, 2),
                    __arrL({-74, 9}, 2)
                },
                7
            ),
            "#d5a6ff"
        )
        ellipse(
            nil,
            c,
            0,
            2,
            12,
            28,
            "#2b123f"
        )
        ellipse(
            nil,
            c,
            -2,
            0,
            3.5,
            25,
            "#09050f"
        )
        ellipse(
            nil,
            c,
            -7,
            -10,
            3,
            5,
            "#f0d2ff"
        )
        stroke(
            nil,
            c,
            __arrL(
                {
                    __arrL({-126, -26}, 2),
                    __arrL({-66, -51}, 2),
                    __arrL({6, -32}, 2),
                    __arrL({117, 4}, 2)
                },
                4
            ),
            "#a574ed",
            4
        )
        stroke(
            nil,
            c,
            __arrL(
                {
                    __arrL({-89, 22}, 2),
                    __arrL({-23, 44}, 2),
                    __arrL({53, 39}, 2),
                    __arrL({115, 15}, 2)
                },
                4
            ),
            "#6a3498",
            2
        )
        do
            local i = 0
            while i < 5 do
                local phase = __mod(t * 0.15 + i * 0.21, 1)
                c:save()
                c.globalAlpha = (1 - phase) * 0.23
                local yy = -32 - phase * 80
                local xx = -70 + i * 39 + math.sin(t + i) * 11
                ellipse(
                    nil,
                    c,
                    xx,
                    yy,
                    2,
                    3,
                    "#d5a5ff"
                )
                c:restore()
                i = i + 1
            end
        end
        c:restore()
    end
    local function drawEnd(self, c, t)
        if t == nil then
            t = 8
        end
        c:save()
        c.fillStyle = "#030207"
        c:fillRect(0, 0, 960, 540)
        local eyes = smooth(nil, (t - 0.35) / 1.7)
        c:save()
        c.globalAlpha = eyes
        purpleEye(
            nil,
            c,
            282,
            199,
            1,
            t
        )
        purpleEye(
            nil,
            c,
            678,
            199,
            -1,
            t + 0.7
        )
        c:restore()
        local words = smooth(nil, (t - 1.8) / 1.8)
        c:save()
        c.globalAlpha = words
        text(
            nil,
            c,
            "FIM DE JOGO",
            480,
            351,
            35,
            "#eee6f7",
            "center",
            650
        )
        text(
            nil,
            c,
            "aguardando nova atualização…",
            480,
            393,
            18,
            "#aa95bf",
            "center",
            400
        )
        tracked(
            nil,
            c,
            "UM NOVO CAPÍTULO VAI COMEÇAR",
            480,
            448,
            9,
            3,
            "#705e82"
        )
        c:restore()
        grain(nil, c, t)
        c:restore()
    end
    local function trouserLimb(self, c, a, b, wa, wb, near)
        if near == nil then
            near = false
        end
        local dx = __get(b, 0) - __get(a, 0)
        local dy = __get(b, 1) - __get(a, 1)
        local ____t_19 = __t
        local ____hypot_result_18 = __hypot(dx, dy)
        __O[691] = ____hypot_result_18
        local len = if ____t_19(____hypot_result_18) then __O[691] else 1
        local nx = -dy / len
        local ny = dx / len
        local function edge(____, p, w, side)
            return __arrL(
                {
                    __get(p, 0) + nx * w * side,
                    __get(p, 1) + ny * w * side
                },
                2
            )
        end
        poly(
            nil,
            c,
            __arrL(
                {
                    edge(nil, a, wa, 1),
                    edge(nil, b, wb, 1),
                    edge(nil, b, wb, -1),
                    edge(nil, a, wa, -1)
                },
                4
            ),
            "#171e2b"
        )
        poly(
            nil,
            c,
            __arrL(
                {
                    edge(nil, a, wa - 3, 1),
                    edge(nil, b, wb - 3, 1),
                    edge(nil, b, wb - 3, -1),
                    edge(nil, a, wa - 3, -1)
                },
                4
            ),
            if __t(near) then "#435570" else "#2e3c52"
        )
        stroke(
            nil,
            c,
            __arrL(
                {
                    __arrL(
                        {
                            __get(a, 0) - nx * (wa - 5),
                            __get(a, 1) - ny * (wa - 5)
                        },
                        2
                    ),
                    __arrL(
                        {
                            lerp(
                                nil,
                                __get(a, 0),
                                __get(b, 0),
                                0.72
                            ) - nx * (wb - 4),
                            lerp(
                                nil,
                                __get(a, 1),
                                __get(b, 1),
                                0.72
                            ) - ny * (wb - 4)
                        },
                        2
                    )
                },
                2
            ),
            if __t(near) then "#718096" else "#4d5b73",
            2
        )
    end
    local function kneelingShoe(self, c, ankle, p, near)
        if near == nil then
            near = false
        end
        c:save()
        c:translate(
            __get(ankle, 0),
            __get(ankle, 1)
        )
        local heel = lerp(nil, 10, 13, p)
        local toe = lerp(nil, -18, -31, p)
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({toe, -3}, 2),
                    __arrL({toe + 5, -10}, 2),
                    __arrL({2, -12}, 2),
                    __arrL({heel, -7}, 2),
                    __arrL({heel, 6}, 2),
                    __arrL({toe - 2, 6}, 2)
                },
                6
            ),
            "#151a25"
        )
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({toe + 3, -3}, 2),
                    __arrL({toe + 7, -7}, 2),
                    __arrL({1, -9}, 2),
                    __arrL({heel - 3, -5}, 2),
                    __arrL({heel - 3, 2}, 2),
                    __arrL({toe + 1, 2}, 2)
                },
                6
            ),
            if __t(near) then "#a9b8c7" else "#738396"
        )
        stroke(
            nil,
            c,
            __arrL(
                {
                    __arrL({toe, 5}, 2),
                    __arrL({heel - 1, 5}, 2)
                },
                2
            ),
            if __t(near) then "#d8d9d8" else "#9cabb9",
            3
        )
        stroke(
            nil,
            c,
            __arrL(
                {
                    __arrL({-6, -6}, 2),
                    __arrL({1, -4}, 2),
                    __arrL({-7, -2}, 2)
                },
                3
            ),
            "#384354",
            1.5
        )
        c:restore()
    end
    local function kneel(self, c, t, p)
        if p == nil then
            p = 1
        end
        local drop = smooth(nil, p)
        local landing = clamp(nil, (p - 0.78) / 0.22)
        local breath = math.sin(t * 2.1)
        local tremble = math.sin(t * 19) * 0.45 * drop
        ground(
            nil,
            c,
            475,
            473,
            295
        )
        glow(
            nil,
            c,
            551,
            386,
            150,
            "#66608e",
            0.055
        )
        c:save()
        c:translate(464, 467)
        c:scale(0.95, 0.95)
        ellipse(
            nil,
            c,
            13,
            7,
            106,
            10,
            "#0b0b1488"
        )
        local farHip = __arrL(
            {
                lerp(nil, -17, -12, drop),
                lerp(nil, -146, -74, drop)
            },
            2
        )
        local nearHip = __arrL(
            {
                lerp(nil, 17, 13, drop),
                lerp(nil, -145, -68, drop)
            },
            2
        )
        local farKnee = __arrL(
            {
                lerp(nil, -23, 24, drop),
                lerp(nil, -75, -15, drop)
            },
            2
        )
        local nearKnee = __arrL(
            {
                lerp(nil, 26, 57, drop),
                lerp(nil, -76, -5, drop)
            },
            2
        )
        local farAnkle = __arrL(
            {
                lerp(nil, -27, -48, drop),
                lerp(nil, -9, -13, drop)
            },
            2
        )
        local nearAnkle = __arrL(
            {
                lerp(nil, 38, -28, drop),
                lerp(nil, -7, -3, drop)
            },
            2
        )
        kneelingShoe(nil, c, farAnkle, drop)
        trouserLimb(
            nil,
            c,
            farKnee,
            farAnkle,
            13,
            9
        )
        kneelingShoe(
            nil,
            c,
            nearAnkle,
            drop,
            true
        )
        trouserLimb(
            nil,
            c,
            nearKnee,
            nearAnkle,
            16,
            10,
            true
        )
        trouserLimb(
            nil,
            c,
            farHip,
            farKnee,
            18,
            15
        )
        ellipse(
            nil,
            c,
            __get(farKnee, 0),
            __get(farKnee, 1),
            15,
            13,
            "#263347"
        )
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL(
                        {
                            __get(farHip, 0) - 15,
                            __get(farHip, 1) - 10
                        },
                        2
                    ),
                    __arrL(
                        {
                            __get(nearHip, 0) + 18,
                            __get(nearHip, 1) - 11
                        },
                        2
                    ),
                    __arrL(
                        {
                            __get(nearHip, 0) + 15,
                            __get(nearHip, 1) + 16
                        },
                        2
                    ),
                    __arrL(
                        {
                            __get(farHip, 0) - 12,
                            __get(farHip, 1) + 14
                        },
                        2
                    )
                },
                4
            ),
            "#29364a"
        )
        trouserLimb(
            nil,
            c,
            nearHip,
            nearKnee,
            21,
            18,
            true
        )
        ellipse(
            nil,
            c,
            __get(nearKnee, 0),
            __get(nearKnee, 1),
            18,
            14,
            "#35465f"
        )
        stroke(
            nil,
            c,
            __arrL(
                {
                    __arrL(
                        {
                            __get(nearKnee, 0) - 10,
                            __get(nearKnee, 1) - 8
                        },
                        2
                    ),
                    __arrL(
                        {
                            __get(nearKnee, 0) + 3,
                            __get(nearKnee, 1) - 10
                        },
                        2
                    ),
                    __arrL(
                        {
                            __get(nearKnee, 0) + 11,
                            __get(nearKnee, 1) - 4
                        },
                        2
                    )
                },
                3
            ),
            "#8991a2",
            2
        )
        stroke(
            nil,
            c,
            __arrL(
                {
                    __arrL(
                        {
                            __get(nearHip, 0) + 6,
                            __get(nearHip, 1) + 17
                        },
                        2
                    ),
                    __arrL(
                        {
                            __get(nearKnee, 0) - 10,
                            __get(nearKnee, 1) - 10
                        },
                        2
                    )
                },
                2
            ),
            "#263248",
            2
        )
        if landing > 0.9 then
            ellipse(
                nil,
                c,
                __get(farKnee, 0),
                3,
                20,
                3,
                "#100e1b66"
            )
            ellipse(
                nil,
                c,
                __get(nearKnee, 0),
                9,
                22,
                3,
                "#100e1b77"
            )
        end
        local hipY = __add(
            __get(farHip, 1),
            __get(nearHip, 1)
        ) / 2
        c:translate(
            lerp(nil, 0, 5, drop) + tremble,
            hipY + 34 + breath * 0.7 * drop
        )
        c:rotate(lerp(nil, -0.035, 0.16, drop) + math.sin(t * 1.7) * 0.008 * drop)
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-44, -141}, 2),
                    __arrL({-70, -118}, 2),
                    __arrL({-55, -47}, 2),
                    __arrL({-21, -30}, 2),
                    __arrL({34, -32}, 2),
                    __arrL({63, -54}, 2),
                    __arrL({72, -117}, 2),
                    __arrL({44, -143}, 2)
                },
                8
            ),
            "#75412f"
        )
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-37, -132}, 2),
                    __arrL({-58, -112}, 2),
                    __arrL({-47, -52}, 2),
                    __arrL({-19, -40}, 2),
                    __arrL({28, -42}, 2),
                    __arrL({51, -59}, 2),
                    __arrL({58, -113}, 2),
                    __arrL({35, -136}, 2)
                },
                8
            ),
            "#c37a42"
        )
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({32, -134}, 2),
                    __arrL({57, -112}, 2),
                    __arrL({50, -59}, 2),
                    __arrL({29, -42}, 2),
                    __arrL({18, -74}, 2)
                },
                5
            ),
            "#975332"
        )
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-37, -130}, 2),
                    __arrL({-13, -119}, 2),
                    __arrL({-20, -66}, 2),
                    __arrL({-35, -73}, 2),
                    __arrL({-45, -108}, 2)
                },
                5
            ),
            "#d58c4e"
        )
        stroke(
            nil,
            c,
            __arrL(
                {
                    __arrL({-37, -97}, 2),
                    __arrL({-17, -76}, 2),
                    __arrL({-23, -46}, 2)
                },
                3
            ),
            "#e7a05a",
            2
        )
        stroke(
            nil,
            c,
            __arrL(
                {
                    __arrL({21, -103}, 2),
                    __arrL({11, -57}, 2)
                },
                2
            ),
            "#734329",
            3
        )
        stroke(
            nil,
            c,
            __arrL(
                {
                    __arrL({-32, -58}, 2),
                    __arrL({-6, -53}, 2),
                    __arrL({9, -57}, 2)
                },
                3
            ),
            "#8f4e32",
            2
        )
        stroke(
            nil,
            c,
            __arrL(
                {
                    __arrL({27, -79}, 2),
                    __arrL({36, -69}, 2),
                    __arrL({31, -52}, 2)
                },
                3
            ),
            "#b66a3c",
            2
        )
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-64, -113}, 2),
                    __arrL({-77, -73}, 2),
                    __arrL({-65, -23}, 2),
                    __arrL({-48, -24}, 2),
                    __arrL({-58, -70}, 2),
                    __arrL({-39, -109}, 2)
                },
                6
            ),
            "#965839"
        )
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({57, -112}, 2),
                    __arrL({82, -76}, 2),
                    __arrL({74, -18}, 2),
                    __arrL({57, -19}, 2),
                    __arrL({59, -68}, 2),
                    __arrL({36, -109}, 2)
                },
                6
            ),
            "#9f603f"
        )
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-65, -28}, 2),
                    __arrL({-69, -10}, 2),
                    __arrL({-61, 3}, 2),
                    __arrL({-47, 1}, 2),
                    __arrL({-44, -12}, 2),
                    __arrL({-48, -29}, 2)
                },
                6
            ),
            "#bc825c"
        )
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({57, -24}, 2),
                    __arrL({54, -6}, 2),
                    __arrL({61, 8}, 2),
                    __arrL({74, 5}, 2),
                    __arrL({81, -8}, 2),
                    __arrL({74, -25}, 2)
                },
                6
            ),
            "#b9805a"
        )
        stroke(
            nil,
            c,
            __arrL(
                {
                    __arrL({-61, -8}, 2),
                    __arrL({-58, 0}, 2),
                    __arrL({-54, -1}, 2)
                },
                3
            ),
            "#d9a478",
            1.4
        )
        stroke(
            nil,
            c,
            __arrL(
                {
                    __arrL({61, -6}, 2),
                    __arrL({64, 3}, 2),
                    __arrL({69, 1}, 2)
                },
                3
            ),
            "#d9a478",
            1.4
        )
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-25, -151}, 2),
                    __arrL({-24, -129}, 2),
                    __arrL({-5, -117}, 2),
                    __arrL({24, -132}, 2),
                    __arrL({27, -153}, 2)
                },
                5
            ),
            "#82533b"
        )
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-31, -193}, 2),
                    __arrL({-34, -169}, 2),
                    __arrL({-26, -148}, 2),
                    __arrL({-6, -135}, 2),
                    __arrL({24, -147}, 2),
                    __arrL({34, -171}, 2),
                    __arrL({30, -194}, 2)
                },
                7
            ),
            "#8f5e43"
        )
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-28, -189}, 2),
                    __arrL({-27, -165}, 2),
                    __arrL({-18, -148}, 2),
                    __arrL({-5, -141}, 2),
                    __arrL({17, -150}, 2),
                    __arrL({26, -173}, 2),
                    __arrL({25, -192}, 2)
                },
                7
            ),
            "#b17a50"
        )
        stroke(
            nil,
            c,
            __arrL(
                {
                    __arrL({-27, -178}, 2),
                    __arrL({-23, -160}, 2),
                    __arrL({-13, -150}, 2)
                },
                3
            ),
            "#d5a373",
            1.5
        )
        stroke(
            nil,
            c,
            __arrL(
                {
                    __arrL({17, -164}, 2),
                    __arrL({22, -155}, 2),
                    __arrL({17, -147}, 2)
                },
                3
            ),
            "#674633",
            1.3
        )
        c:save()
        c:translate(0, -124)
        c:scale(0.72, 0.72)
        hat(nil, c, t, 0.13 + drop * 0.025)
        c:restore()
        c:restore()
    end
    local function impactRing(self, c, x, y, t, at, strength)
        if strength == nil then
            strength = 1
        end
        local age = t - at
        if __t(age < 0 or age > 1.05) then
            return
        end
        local p = age / 1.05
        c:save()
        c.globalAlpha = (1 - p) * 0.3 * strength
        c.strokeStyle = "#b8a3ca"
        c.lineWidth = 1.3
        c:beginPath()
        c:ellipse(
            x,
            y,
            13 + p * 90,
            2 + p * 13,
            0,
            0,
            math.pi * 2
        )
        c:stroke()
        do
            local i = 0
            while i < 7 do
                local a = i * 0.9
                c.globalAlpha = (1 - p) * 0.2 * strength
                ellipse(
                    nil,
                    c,
                    x + math.cos(a) * (18 + p * 62),
                    y - 2 - math.sin(p * math.pi) * (4 + __mod(i, 3)),
                    1.2,
                    1,
                    "#bcb0c8"
                )
                i = i + 1
            end
        end
        c:restore()
    end
    local function draw(self, c, s)
        if __t(not __t(c) or not __t(s)) then
            return
        end
        c:save()
        c.imageSmoothingEnabled = true
        c.fillStyle = "#020207"
        c:fillRect(0, 0, 960, 540)
        local shot = __get(
            SHOTS,
            clamp(
                nil,
                math.floor(if __t(s.index) then s.index else 0),
                0,
                __len(SHOTS) - 1
            )
        )
        local ____t_21 = __t
        local ____TS__Number_result_20 = __TS__Number(s.time)
        __O[692] = ____TS__Number_result_20
        local t = math.max(0, if ____t_21(____TS__Number_result_20) then __O[692] else 0)
        local p = clamp(nil, t / shot.duration)
        local u = smooth(nil, p)
        local ____t_23 = __t
        local ____TS__Number_result_22 = __TS__Number(s.elapsed)
        __O[693] = ____TS__Number_result_22
        local elapsed = if ____t_23(____TS__Number_result_22) then __O[693] else t
        if shot.id == "eyes" then
            drawEnd(nil, c, t)
            c:restore()
            return
        end
        glow(
            nil,
            c,
            547,
            260,
            330,
            "#39293f",
            0.2
        )
        atmosphere(nil, c, elapsed)
        if shot.id == "afterglow" then
            local scale = lerp(nil, 0.9, 1.04, u)
            c:save()
            c.globalAlpha = smooth(nil, t / 1.6)
            face(
                nil,
                c,
                555,
                278,
                scale,
                t,
                {tilt = -0.025}
            )
            c:restore()
            c:save()
            c.globalAlpha = smooth(nil, (t - 1.1) / 1.4)
            text(
                nil,
                c,
                "Pera… acabou?",
                67,
                431,
                28,
                "#e9dfd2",
                "left",
                450
            )
            c:restore()
            tracked(
                nil,
                c,
                "DEPOIS DO ÚLTIMO PEDAÇO",
                244,
                476,
                9,
                2.4,
                "#7f7187"
            )
        elseif shot.id == "empty" then
            face(
                nil,
                c,
                536,
                281,
                lerp(nil, 1.08, 1.23, u),
                t,
                {tilt = -0.018}
            )
            c:save()
            c.globalAlpha = smooth(nil, (t - 0.5) / 1.5)
            text(
                nil,
                c,
                "Pq eu ainda me sinto vazio?",
                56,
                466,
                26,
                "#e2d7da",
                "left",
                450
            )
            c:restore()
        elseif shot.id == "vibration" then
            pocket(
                nil,
                c,
                t,
                smooth(nil, (t - 1.9) / 1.8)
            )
        elseif shot.id == "reach" then
            phone(
                nil,
                c,
                lerp(nil, 590, 486, u),
                lerp(nil, 555, 278, u),
                lerp(nil, 0.48, 0.96, u),
                t,
                {
                    angle = lerp(nil, 0.6, -0.09, u),
                    skew = lerp(nil, 0.16, 0.035, u),
                    perspective = lerp(nil, 0.1, -0.035, u),
                    hand = true,
                    glow = true,
                    concealCaller = true
                }
            )
            if t < 1.2 then
                c:save()
                c.globalAlpha = 1 - smooth(nil, t / 1.2)
                text(
                    nil,
                    c,
                    "brr…",
                    730,
                    420,
                    15,
                    "#93869e",
                    "center"
                )
                c:restore()
            end
        elseif shot.id == "caller" then
            glow(
                nil,
                c,
                480,
                267,
                330,
                "#5f407d",
                0.13
            )
            phone(
                nil,
                c,
                480 + math.sin(t * 45) * 1.3,
                273,
                lerp(nil, 1.05, 1.13, u),
                t,
                {
                    angle = math.sin(t * 8) * 0.004,
                    hand = true,
                    glow = true
                }
            )
        elseif shot.id == "recognition" then
            c:save()
            c:translate(
                math.sin(t * 27) * 1.5,
                math.cos(t * 21) * 0.9
            )
            face(
                nil,
                c,
                492,
                271,
                2.32,
                t,
                {
                    fear = smooth(nil, t / 0.5),
                    sweat = true
                }
            )
            c:restore()
            if t < 0.12 then
                c:save()
                c.globalAlpha = (1 - t / 0.12) * 0.5
                c.fillStyle = "#e9e1ed"
                c:fillRect(0, 0, 960, 540)
                c:restore()
            end
            c:save()
            c.globalAlpha = smooth(nil, (t - 0.65) / 0.7)
            text(
                nil,
                c,
                "JORGE…",
                791,
                469,
                20,
                "#ac97c3",
                "center",
                600
            )
            c:restore()
        elseif shot.id == "tremor" then
            local quake = (1 + p) * 2.2
            face(
                nil,
                c,
                478 + math.sin(t * 35) * quake,
                267 + math.cos(t * 24) * 1.5,
                1.25,
                t,
                {fear = 1, sweat = true, tilt = 0.025, hatTilt = -0.025}
            )
            local leave = smooth(nil, (t - 1.7) / 1.7)
            phone(
                nil,
                c,
                735 + leave * 87,
                lerp(nil, 326, 580, leave),
                0.56,
                t,
                {angle = -0.1 + leave * 0.9, hand = leave < 0.25, glow = false}
            )
        elseif shot.id == "falling" then
            local contact = 2.45
            local impact = clamp(
                nil,
                1 - math.abs(t - contact) / 0.25
            )
            local shake = math.sin(t * 61) * impact * 2
            c:save()
            c:translate(
                shake,
                math.cos(t * 47) * impact
            )
            kneel(
                nil,
                c,
                t,
                clamp(nil, (t - 0.55) / 1.9)
            )
            c:restore()
            local fall = clamp(nil, t / 1.95)
            local drop = fall * fall
            local bounce = if t > 1.95 then math.sin(clamp(nil, (t - 1.95) / 0.38) * math.pi) * 8 else 0
            local y = lerp(nil, 120, 461, drop) - bounce
            local spin = lerp(
                nil,
                -0.2,
                1.65,
                smooth(nil, fall)
            )
            local scale = lerp(nil, 0.7, 0.31, drop)
            phone(
                nil,
                c,
                lerp(
                    nil,
                    620,
                    722,
                    smooth(nil, fall)
                ),
                y,
                scale,
                t,
                {angle = spin, skew = 0.1 * (1 - drop), perspective = 0.1 * (1 - drop)}
            )
            impactRing(
                nil,
                c,
                725,
                473,
                t,
                1.95,
                0.75
            )
            impactRing(
                nil,
                c,
                507,
                475,
                t,
                contact,
                0.9
            )
        elseif shot.id == "kneeling" then
            kneel(nil, c, t + 4, 1)
            phone(
                nil,
                c,
                722,
                461,
                0.31,
                t,
                {angle = 1.65}
            )
            local darkness = smooth(nil, (t - 2.4) / 3.1)
            c:save()
            c.globalAlpha = darkness * 0.95
            c.fillStyle = "#020207"
            c:fillRect(0, 0, 960, 540)
            c:restore()
        end
        local vignette = c:createRadialGradient(
            480,
            270,
            160,
            480,
            270,
            560
        )
        vignette:addColorStop(0, "#00000000")
        vignette:addColorStop(1, "#000000bd")
        c.fillStyle = vignette
        c:fillRect(0, 0, 960, 540)
        grain(nil, c, elapsed)
        c:restore()
    end
    local function create(self, options)
        if options == nil then
            options = {}
        end
        return {
            kind = "jorge_epilogue",
            index = 0,
            time = 0,
            elapsed = 0,
            done = false,
            options = __assign({}, options)
        }
    end
    local function beat(self, s)
        local ____t_28 = __t
        local ____opt_result_26
        if s ~= nil then
            ____opt_result_26 = s.index
        end
        local ____TS__Number_result_27 = __TS__Number(____opt_result_26)
        __O[694] = ____TS__Number_result_27
        local index = clamp(
            nil,
            math.floor(if ____t_28(____TS__Number_result_27) then __O[694] else 0),
            0,
            __len(SHOTS) - 1
        )
        return __assign(
            {},
            __get(SHOTS, index),
            {
                index = index,
                number = index + 1,
                total = __len(SHOTS),
                cinematic = true
            }
        )
    end
    local function advance(self, s)
        local ____t_31 = __t
        local ____t_30 = __t
        local ____temp_29 = not __t(s)
        __O[695] = ____temp_29
        if ____t_31(if ____t_30(____temp_29) then __O[695] else s.done) then
            return false
        end
        if __ge(
            s.index + 1,
            __len(SHOTS)
        ) then
            s.done = true
            return false
        end
        s.index = s.index + 1
        s.time = 0
        return true
    end
    local function update(self, s, dt)
        local ____t_34 = __t
        local ____t_33 = __t
        local ____temp_32 = not __t(s)
        __O[696] = ____temp_32
        if ____t_34(if ____t_33(____temp_32) then __O[696] else s.done) then
            return
        end
        local ____t_36 = __t
        local ____TS__Number_result_35 = __TS__Number(dt)
        __O[697] = ____TS__Number_result_35
        dt = clamp(nil, if ____t_36(____TS__Number_result_35) then __O[697] else 0, 0, 0.1)
        s.time = __add(s.time, dt)
        s.elapsed = __add(if __t(s.elapsed) then s.elapsed else 0, dt)
        while __t(__ge(
            s.time,
            __get(SHOTS, s.index).duration
        ) and not __t(s.done)) do
            s.time = s.time - __get(SHOTS, s.index).duration
            if __ge(
                s.index + 1,
                __len(SHOTS)
            ) then
                s.done = true
                s.time = __get(SHOTS, s.index).duration
                break
            end
            s.index = s.index + 1
        end
    end
    window.JorgeEpilogue = __ord(
        {
            create = create,
            update = update,
            advance = advance,
            beat = beat,
            draw = draw,
            drawEnd = drawEnd,
            shots = __call(
                SHOTS,
                "map",
                function(____, s) return __assign({}, s) end
            ),
            duration = TOTAL
        },
        "create,update,advance,beat,draw,drawEnd,shots,duration"
    )
end)(nil)
return ____exports
