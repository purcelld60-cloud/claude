--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __D = {}
local __newExpr, __hasOwnV, __StringV, __fcall, __lt, __le, __gt, __ge, __objCreate, __isFiniteN, __isInteger, __mod = __JSR.__newExpr, __JSR.__hasOwnV, __JSR.__StringV, __JSR.__fcall, __JSR.__lt, __JSR.__le, __JSR.__gt, __JSR.__ge, __JSR.__objCreate, __JSR.__isFiniteN, __JSR.__isInteger, __JSR.__mod
local __ord, __arrL, __iterar, __t, __get, __set, __len, __call, __add, __new, __iter, __keys = __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__set, __JSR.__len, __JSR.__call, __JSR.__add, __JSR.__new, __JSR.__iter, __JSR.__keys
local __values, __assign, __isArray, __bor, __re, __re_test, __re_replace = __JSR.__values, __JSR.__assign, __JSR.__isArray, __JSR.__bor, __JSR.__re, __JSR.__re_test, __JSR.__re_replace
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__Number = ____lualib.__TS__Number
local Error = ____lualib.Error
local RangeError = ____lualib.RangeError
local ReferenceError = ____lualib.ReferenceError
local SyntaxError = ____lualib.SyntaxError
local TypeError = ____lualib.TypeError
local URIError = ____lualib.URIError
local __TS__New = ____lualib.__TS__New
local __TS__AsyncAwaiter = ____lualib.__TS__AsyncAwaiter
local __TS__Await = ____lualib.__TS__Await
local __TS__PromiseAll = ____lualib.__TS__PromiseAll
local __TS__Spread = ____lualib.__TS__Spread
local ____exports = {}
local __O = {};
(function()
    local headBox, drawPortrait, release, camAt, actorAt, falante, linhas, balao, retratoCache, syncOverlay, W, H, clamp, ease, lerp, EXT, scripts, headCache, forced, lastDraw, corNome, rcCanvas, rcKey, portraitCv, lastSync, clearer, ajuda
    function headBox(self, ____type)
        if __t(__get(headCache, ____type)) then
            return __get(headCache, ____type)
        end
        local c = window.document:createElement("canvas")
        c.width = 200
        c.height = 240
        local x = c:getContext("2d")
        local box = {top = 150, cx = 100}
        do
            pcall(function()
                window.Art:drawCharacter(
                    x,
                    ____type,
                    100,
                    220,
                    {facing = 1, frame = 0, scale = 1, grounded = true}
                )
                local d = x:getImageData(0, 0, 200, 240).data
                local __rot1_outer = 0
                do
                    local y = 0
                    while y < 240 do
                        do
                            local i = 0
                            while i < 200 do
                                if __get(d, (y * 200 + i) * 4 + 3) > 220 then
                                    box.top = y
                                    do
                                        __rot1_outer = 1
                                        break
                                    end
                                end
                                i = i + 1
                            end
                        end
                        if __rot1_outer == 1 then
                            break
                        end
                        if __rot1_outer == 2 then
                            __rot1_outer = 0
                            continue
                        end
                        y = y + 1
                    end
                end
                local sx = 0
                local n = 0
                do
                    local y = box.top
                    while __t(y < box.top + 14 and y < 240) do
                        do
                            local i = 0
                            while i < 200 do
                                if __get(d, (y * 200 + i) * 4 + 3) > 220 then
                                    sx = sx + i
                                    n = n + 1
                                end
                                i = i + 1
                            end
                        end
                        y = y + 1
                    end
                end
                if __t(n) then
                    box.cx = sx / n
                end
            end)
        end
        return __set(headCache, ____type, box)
    end
    function drawPortrait(self, c, ____type, size, t, emotion)
        c:save()
        c.imageSmoothingEnabled = false
        c:clearRect(0, 0, size, size)
        local g = c:createLinearGradient(0, 0, 0, size)
        g:addColorStop(0, "#f3d79a")
        g:addColorStop(1, "#c98f52")
        c.fillStyle = g
        c:fillRect(0, 0, size, size)
        c.fillStyle = "#e6b878"
        do
            local y = 0
            while __lt(y, size) do
                do
                    local x = if __t(__mod(y / 4, 2)) then 2 else 0
                    while __lt(x, size) do
                        c:fillRect(x, y, 2, 2)
                        x = x + 4
                    end
                end
                y = y + 4
            end
        end
        local ____t_98 = __t
        local ____t_97 = __t
        local ____t_95 = __t
        local ____opt_93 = window.Art
        if ____opt_93 ~= nil then
            ____opt_93 = ____opt_93.drawCharacter
        end
        __O[750] = ____opt_93
        local ____temp_96 = if ____t_95(____opt_93) then ____type else __O[750]
        __O[751] = ____temp_96
        if ____t_98(if ____t_97(____temp_96) then ____type ~= "narrador" else __O[751]) then
            local b = headBox(nil, ____type)
            local S = size / 40
            local tall = 220 - b.top > 110
            window.Art:drawCharacter(
                c,
                ____type,
                math.floor(size / 2 - (b.cx - 100) * S + 0.5),
                math.floor(size * if __t(tall) then 0.02 else 0.06 + (220 - b.top) * S + 0.5),
                {
                    facing = 1,
                    frame = t,
                    scale = S,
                    grounded = true,
                    emotion = emotion
                }
            )
        end
        c:restore()
    end
    function release(self)
        if __t(forced) then
            forced = false
            do
                pcall(function()
                    local ____opt_117 = window.DayTime
                    if ____opt_117 ~= nil then
                        ____opt_117 = ____opt_117.force
                    end
                    if ____opt_117 ~= nil then
                        ____opt_117(____opt_117, nil)
                    end
                end)
            end
        end
    end
    function camAt(self, shot, t)
        local k = if shot.camCurve == "linear" then clamp(nil, t / shot.camTime, 0, 1) else ease(nil, t / shot.camTime)
        return {
            x = lerp(nil, shot.camFrom.x, shot.camTo.x, k),
            y = lerp(nil, shot.camFrom.y, shot.camTo.y, k),
            zoom = lerp(nil, shot.camFrom.zoom, shot.camTo.zoom, k)
        }
    end
    function actorAt(self, a, t, speaking)
        local k = if a.to == nil then 0 else (t - a.t0) / (a.t1 - a.t0)
        local ____t_120 = __t
        local ____temp_119 = a.to ~= nil and k > 0
        __O[759] = ____temp_119
        local moving = if ____t_120(____temp_119) then k < 1 else __O[759]
        local x = if a.to == nil then a.x else lerp(
            nil,
            a.x,
            a.to,
            clamp(nil, k, 0, 1)
        )
        local y = a.y - if __t(if __t(moving) then a.jump else moving) then math.sin(clamp(nil, k, 0, 1) * math.pi) * a.jump else 0
        local ____assign_123 = __assign
        local ____temp_122 = {}
        local ____a_facing_121 = a.facing
        if ____a_facing_121 == nil then
            ____a_facing_121 = if __t(a.to ~= nil and __lt(a.to, a.x)) then -1 else 1
        end
        local o = ____assign_123(
            ____temp_122,
            {
                facing = ____a_facing_121,
                frame = t,
                scale = a.scale,
                grounded = not __t(if __t(moving) then a.jump else moving),
                moving = moving,
                emotion = a.emotion
            },
            a.opts
        )
        local anims = __call(a.anim, "split", "+")
        local ____assign_128 = __assign
        local ____temp_126 = {}
        local ____a_127 = a
        local ____t_125 = __t
        local ____call_result_124 = __call(
            anims,
            "find",
            function(____, n) return __call(
                __arrL({
                    "pulando",
                    "andando",
                    "correndo",
                    "ataque",
                    "tremendo",
                    "voando"
                }, 6),
                "includes",
                n
            ) end
        )
        __O[760] = ____call_result_124
        a = ____assign_128(____temp_126, ____a_127, {anim = if ____t_125(____call_result_124) then __O[760] else ""})
        if a.anim == "pulando" then
            y = y - math.abs(math.sin(t * 5)) * 18
            o.grounded = false
            o.vy = if math.cos(t * 5) > 0 then -100 else 100
        end
        if __t(a.anim == "andando" or a.anim == "correndo") then
            o.moving = true
            if a.anim == "correndo" then
                o.frame = t * 1.8
            end
        end
        if a.anim == "ataque" then
            o.attack = true
            o.attackProgress = __mod(t * 1.4, 1)
        end
        if a.anim == "tremendo" then
            o.hit = math.sin(t * 40) > 0
        end
        if a.anim == "voando" then
            y = y - (40 + math.sin(t * 2) * 8)
            o.flight = true
            o.grounded = false
        end
        local ____t_131 = __t
        local ____t_130 = __t
        local ____call_result_129 = __call(anims, "includes", "tremendo")
        __O[761] = ____call_result_129
        if ____t_131(if ____t_130(____call_result_129) then a.anim ~= "tremendo" else __O[761]) then
            o.hit = math.sin(t * 40) > 0
        end
        local ____t_134 = __t
        local ____t_133 = __t
        local ____temp_132 = if __t(speaking) then not __t(o.moving) else speaking
        __O[762] = ____temp_132
        if ____t_134(if ____t_133(____temp_132) then o.grounded ~= false else __O[762]) then
            y = y - math.abs(math.sin(t * 9)) * 2
        end
        local alpha = 1
        if __ge(a.appear, 0) then
            alpha = clamp(nil, (t - a.appear) / 0.35, 0, 1)
        end
        if __gt(t, a.vanish) then
            alpha = math.min(
                alpha,
                clamp(nil, 1 - (t - a.vanish) / 0.35, 0, 1)
            )
        end
        if alpha < 1 then
            o.opacity = alpha
        end
        return {
            x = x,
            y = y,
            o = o,
            visible = alpha > 0,
            extras = __call(
                anims,
                "filter",
                function(____, n) return __get(EXT.anims, n) end
            ),
            alpha = alpha
        }
    end
    function falante(self, sc, shot, b, t)
        local alias = {
            jorge = __arrL({"jorge", "jorge_celular", "jorge_gordo"}, 3),
            daroca = __arrL({"daroca", "carro"}, 2)
        }
        local ____t_178 = __t
        local ____get_result_177 = __get(alias, b.who)
        __O[772] = ____get_result_177
        local nomes = if ____t_178(____get_result_177) then __O[772] else __arrL({b.who}, 1)
        local ____t_180 = __t
        local ____call_result_179 = __call(
            shot.actors,
            "find",
            function(____, x) return __call(nomes, "includes", x.type) end
        )
        __O[773] = ____call_result_179
        local a = if ____t_180(____call_result_179) then __O[773] else __call(
            shot.actors,
            "find",
            function(____, x) return __re_replace(
                x.type,
                __re("^(crianca|pre)_", ""),
                ""
            ) == __re_replace(
                b.who,
                __re("^(crianca|pre)_", ""),
                ""
            ) end
        )
        if not __t(a) then
            return nil
        end
        local p = actorAt(nil, a, t, true)
        if not __t(p.visible) then
            return nil
        end
        local cam = camAt(nil, shot, t)
        local camX = math.floor(cam.x - W / 2 + 0.5)
        local z = cam.zoom
        local fy = clamp(nil, cam.y, 0, H)
        local sx = (W - W / z) / 2
        local sy = fy - fy / z
        sx = clamp(
            nil,
            sx,
            math.min(0, W - W / z),
            math.max(0, W - W / z)
        )
        sy = clamp(
            nil,
            sy,
            math.min(0, H - H / z),
            math.max(0, H - H / z)
        )
        local hb = headBox(nil, a.type)
        local alto = (220 - hb.top) * if __t(a.scale) then a.scale else 1
        local hx = p.x
        local hy = p.y - alto
        local by = p.y - alto * 0.72
        for ____, nome in __iterar((__call(
            tostring(if __t(a.anim) then a.anim else ""),
            "split",
            "+"
        ))) do
            local ____opt_181 = __get(EXT.anims, nome)
            if ____opt_181 ~= nil then
                ____opt_181 = ____opt_181.cabeca
            end
            local f = ____opt_181
            if __t(f) then
                local r = f(nil, {x = p.x, y = p.y, alto = alto, facing = p.o.facing})
                hx = r.x
                hy = r.y - 10
                by = r.y
            end
        end
        local x = (hx - camX - sx) * z
        local cabeca = (hy - sy) * z
        local boca = (by - sy) * z
        local ____x_185 = x
        local ____cabeca_186 = cabeca
        local ____boca_187 = boca
        local ____t_184 = __t
        local ____temp_183 = x < -20 or x > W + 20
        __O[774] = ____temp_183
        return {x = ____x_185, cabeca = ____cabeca_186, boca = ____boca_187, fora = if ____t_184(____temp_183) then __O[774] else cabeca > H}
    end
    function linhas(self, c, txt, max)
        local out = __arrL({}, 0)
        local l = ""
        for ____, w2 in __iterar((__call(txt, "split", " "))) do
            local tst = if __t(l) then __add(
                __add(l, " "),
                w2
            ) else w2
            local ____t_190 = __t
            local ____t_189 = __t
            local ____gt_result_188 = __gt(
                c:measureText(tst).width,
                max
            )
            __O[775] = ____gt_result_188
            if ____t_190(if ____t_189(____gt_result_188) then l else __O[775]) then
                __call(out, "push", l)
                l = w2
            else
                l = tst
            end
        end
        if __t(l) then
            __call(out, "push", l)
        end
        return out
    end
    function balao(self, c, s, sc, shot, b, t)
        local n = math.min(
            __len(b.text),
            math.floor(s.typed)
        )
        local texto = __call(b.text, "slice", 0, n)
        local cheio = b.text
        local letras = __re_replace(
            cheio,
            __re("[^A-Za-zÀ-ú]", "g"),
            ""
        )
        local ____t_192 = __t
        local ____temp_191 = __gt(
            __len(letras),
            3
        ) and letras == __call(letras, "toUpperCase")
        __O[776] = ____temp_191
        local grito = if ____t_192(____temp_191) then __O[776] else __re_test(
            __re("!!|\\?!|!\\?", ""),
            cheio
        )
        local pensa = __re_test(
            __re("^\\(.*\\)$", ""),
            __call(cheio, "trim")
        )
        local cochicho = __re_test(
            __re("^\\.\\.\\.?$|^…$", ""),
            __call(cheio, "trim")
        ) or __call(cheio, "trim") == "..."
        c:save()
        c.imageSmoothingEnabled = false
        c.textAlign = "left"
        c.textBaseline = "alphabetic"
        local tam = if __t(grito) then 18 else 16
        c.font = (if __t(grito) then "bold " else "" .. tostring(tam)) .. "px Space, Arial, sans-serif"
        if __t(b.who == "narrador" or b.who == "nenhum") then
            local ls = linhas(nil, c, cheio, 560)
            local bw = math.min(
                600,
                math.max(__TS__Spread(__iter(__call(
                    ls,
                    "map",
                    function(____, l) return c:measureText(l).width end
                )))) + 36
            )
            local bh = __len(ls) * 22 + 26
            local bx = 24
            local by = 34
            c.fillStyle = "rgba(0,0,0,.35)"
            c:fillRect(bx + 4, by + 4, bw, bh)
            c.fillStyle = "#2a1a10"
            c:fillRect(bx - 3, by - 3, bw + 6, bh + 6)
            c.fillStyle = "#f2dc9a"
            c:fillRect(bx, by, bw, bh)
            c.fillStyle = "#e2c47a"
            c:fillRect(bx, by + bh - 4, bw, 4)
            if __t(if __t(b.speaker) then b.speaker ~= "Narrador" else b.speaker) then
                c.font = "10px Pixel, monospace"
                c.fillStyle = "#7a4a2a"
                c:fillText(
                    __call(b.speaker, "toUpperCase"),
                    bx + 14,
                    by + 16
                )
            end
            c.font = tostring(tam) .. "px Space, Arial, sans-serif"
            c.fillStyle = "#3a2412"
            c.textBaseline = "top"
            __call(
                linhas(nil, c, texto, 560),
                "forEach",
                function(____, l, i) return c:fillText(l, bx + 18, by + 13 + if __t(if __t(b.speaker) then b.speaker ~= "Narrador" else b.speaker) then 8 else 0 + i * 22) end
            )
            c:restore()
            return
        end
        local pos = falante(
            nil,
            sc,
            shot,
            b,
            t
        )
        local max = if __t(grito) then 330 else 300
        local ls = linhas(nil, c, cheio, max)
        local lw = math.max(
            80,
            __TS__Spread(__iter(__call(
                ls,
                "map",
                function(____, l) return c:measureText(l).width end
            )))
        )
        local bw = math.floor(lw + 32 + 0.5)
        local bh = math.floor(__len(ls) * (tam + 6) + 26 + 0.5)
        local bx
        local by
        local tx
        local ty
        local lado = "baixo"
        if __t(if __t(pos) then not __t(pos.fora) else pos) then
            tx = clamp(nil, pos.x, 10, W - 10)
            ty = clamp(nil, pos.boca, 40, H - 30)
            bx = clamp(nil, pos.x - bw / 2 + if pos.x < W / 2 then 40 else -40, 14, W - bw - 14)
            by = math.floor(pos.cabeca - 30 - bh + 0.5)
            if by < 30 then
                by = clamp(
                    nil,
                    math.floor(pos.boca - bh / 2 + 0.5),
                    30,
                    H - 26 - bh
                )
                lado = if pos.x < W / 2 then "esq" else "dir"
                bx = if lado == "esq" then math.min(
                    W - bw - 14,
                    math.floor(pos.x + 46 + 0.5)
                ) else math.max(
                    14,
                    math.floor(pos.x - 46 - bw + 0.5)
                )
            end
        else
            bx = math.floor(W / 2 - bw / 2 + 30 + 0.5)
            by = H - 40 - bh
            lado = "nenhum"
        end
        local tre = if __t(grito) then math.floor(math.sin(t * 50) * 1.5 + 0.5) else 0
        bx = bx + tre
        local borda = if __t(grito) then "#8a1a1a" else "#2a1a10"
        local fundo = if __t(pensa) then "#f6f6fa" else "#fff6dc"
        if lado ~= "nenhum" then
            c.fillStyle = borda
            local ax = clamp(nil, tx, bx + 18, bx + bw - 18)
            if __t(pensa) then
                do
                    local k = 0
                    while k < 3 do
                        local q = (k + 1) / 4
                        local cx = lerp(nil, ax, tx, q)
                        local cy = lerp(nil, by + bh, ty - 10, q)
                        local r = 7 - k * 2
                        c:beginPath()
                        c:arc(
                            cx,
                            cy,
                            r + 2,
                            0,
                            math.pi * 2
                        )
                        __call(c, "fill")
                        c.fillStyle = fundo
                        c:beginPath()
                        c:arc(
                            cx,
                            cy,
                            r,
                            0,
                            math.pi * 2
                        )
                        __call(c, "fill")
                        c.fillStyle = borda
                        k = k + 1
                    end
                end
            else
                local base = if lado == "baixo" then __arrL(
                    {
                        __arrL({ax - 12, by + bh - 2}, 2),
                        __arrL({ax + 12, by + bh - 2}, 2)
                    },
                    2
                ) else if lado == "esq" then __arrL(
                    {
                        __arrL({bx + 2, by + bh / 2 - 12}, 2),
                        __arrL({bx + 2, by + bh / 2 + 12}, 2)
                    },
                    2
                ) else __arrL(
                    {
                        __arrL({bx + bw - 2, by + bh / 2 - 12}, 2),
                        __arrL({bx + bw - 2, by + bh / 2 + 12}, 2)
                    },
                    2
                )
                local pt = __arrL({tx + if lado == "esq" then 10 else if lado == "dir" then -10 else 0, ty - if lado == "baixo" then 14 else 0}, 2)
                c:beginPath()
                c:moveTo(
                    __get(
                        __get(base, 0),
                        0
                    ) - 3,
                    __get(
                        __get(base, 0),
                        1
                    )
                )
                c:lineTo(
                    __get(pt, 0),
                    __get(pt, 1) + 3
                )
                c:lineTo(
                    __get(
                        __get(base, 1),
                        0
                    ) + 3,
                    __get(
                        __get(base, 1),
                        1
                    )
                )
                __call(c, "fill")
                c.fillStyle = fundo
                c:beginPath()
                c:moveTo(
                    __get(
                        __get(base, 0),
                        0
                    ) + 1,
                    __get(
                        __get(base, 0),
                        1
                    ) - 3
                )
                c:lineTo(
                    __get(pt, 0),
                    __get(pt, 1) - 2
                )
                c:lineTo(
                    __get(
                        __get(base, 1),
                        0
                    ) - 1,
                    __get(
                        __get(base, 1),
                        1
                    ) - 3
                )
                __call(c, "fill")
            end
        end
        local function corpo(____, x, y, w, h, col)
            c.fillStyle = col
            c:fillRect(x + 6, y, w - 12, h)
            c:fillRect(x + 2, y + 2, w - 4, h - 4)
            c:fillRect(x, y + 6, w, h - 12)
        end
        c.fillStyle = "rgba(0,0,0,.28)"
        corpo(
            nil,
            bx + 4,
            by + 5,
            bw,
            bh,
            "rgba(0,0,0,.28)"
        )
        corpo(
            nil,
            bx - 3,
            by - 3,
            bw + 6,
            bh + 6,
            borda
        )
        corpo(
            nil,
            bx,
            by,
            bw,
            bh,
            fundo
        )
        if __t(grito) then
            c.fillStyle = borda
            do
                local k = 0
                while k < bw do
                    c:beginPath()
                    c:moveTo(bx + k, by - 2)
                    c:lineTo(bx + k + 8, by - 10)
                    c:lineTo(bx + k + 14, by - 2)
                    __call(c, "fill")
                    c:beginPath()
                    c:moveTo(bx + k + 6, by + bh + 2)
                    c:lineTo(bx + k + 12, by + bh + 9)
                    c:lineTo(bx + k + 18, by + bh + 2)
                    __call(c, "fill")
                    k = k + 22
                end
            end
        end
        if __t(cochicho) then
            c.strokeStyle = "#ffffff"
            c:setLineDash(__arrL({6, 6}, 2))
            c.lineWidth = 3
            c:strokeRect(bx - 2, by - 2, bw + 4, bh + 4)
            c:setLineDash(__arrL({}, 0))
        end
        c.fillStyle = "rgba(255,255,255,.55)"
        c:fillRect(bx + 8, by + 3, bw - 16, 2)
        c.font = "10px Pixel, monospace"
        local nome = __call(
            tostring(if __t(b.speaker) then b.speaker else ""),
            "toUpperCase"
        )
        local nw = math.ceil(c:measureText(nome).width) + 14
        local cor = corNome(nil, b.who)
        c.fillStyle = "#2a1a10"
        c:fillRect(bx + 10, by - 12, nw + 4, 18)
        c.fillStyle = cor
        c:fillRect(bx + 12, by - 10, nw, 14)
        c.fillStyle = "rgba(255,255,255,.25)"
        c:fillRect(bx + 12, by - 10, nw, 2)
        c.fillStyle = "#ffffff"
        c.textBaseline = "middle"
        c:fillText(nome, bx + 19, by - 2)
        local ____t_195 = __t
        local ____t_194 = __t
        local ____temp_193 = lado == "nenhum"
        __O[777] = ____temp_193
        if ____t_195(if ____t_194(____temp_193) then b.portrait else __O[777]) then
            local pc = retratoCache(nil, b.who, b.emotion, t)
            c.fillStyle = "#2a1a10"
            c:fillRect(bx - 66, by + bh / 2 - 30, 60, 60)
            c:drawImage(
                pc,
                bx - 63,
                by + bh / 2 - 27,
                54,
                54
            )
        end
        c.font = (if __t(grito) then "bold " else "" .. tostring(tam)) .. "px Space, Arial, sans-serif"
        c.fillStyle = if __t(grito) then "#7a1010" else if __t(pensa) then "#4a4a6a" else "#4a2e1a"
        c.textBaseline = "top"
        __call(
            linhas(nil, c, texto, max),
            "forEach",
            function(____, l, i) return c:fillText(l, bx + 16, by + 14 + i * (tam + 6)) end
        )
        local ____t_198 = __t
        local ____t_197 = __t
        local ____ge_result_196 = __ge(
            n,
            __len(cheio)
        )
        __O[778] = ____ge_result_196
        __D[1] = if ____t_198(if ____t_197(____ge_result_196) then __mod(
            math.floor(t * 2.5),
            2
        ) else __O[778]) then
            c.fillStyle = borda
            c:beginPath()
            c:moveTo(bx + bw - 22, by + bh - 14)
            c:lineTo(bx + bw - 10, by + bh - 14)
            c:lineTo(bx + bw - 16, by + bh - 7)
            __call(c, "fill")
        end
        c:restore()
    end
    function retratoCache(self, who, emo, t)
        if not __t(rcCanvas) then
            rcCanvas = window.document:createElement("canvas")
            local ____rcCanvas_199 = rcCanvas
            rcCanvas.height = 64
            ____rcCanvas_199.width = 64
        end
        local k = __add(who, emo)
        if k ~= rcKey then
            rcKey = k
            drawPortrait(
                nil,
                rcCanvas:getContext("2d"),
                who,
                64,
                0,
                emo
            )
        end
        return rcCanvas
    end
    function syncOverlay(self, s, b)
        local overlay = window.document:getElementById("cinematicOverlay")
        if not __t(overlay) then
            return
        end
        __call(overlay.classList, "add", "is-roteiro")
        overlay.classList:toggle(
            "roteiro-sem-fala",
            not __t(b.text)
        )
        local ____self_203 = overlay.classList
        local ____self_203_toggle_204 = ____self_203.toggle
        local ____t_202 = __t
        local ____opt_200 = __get(scripts, s.kind)
        if ____opt_200 ~= nil then
            ____opt_200 = ____opt_200.balao
        end
        ____self_203_toggle_204(
            ____self_203,
            "roteiro-balao",
            not not ____t_202(____opt_200)
        )
        overlay.classList:toggle(
            "roteiro-com-retrato",
            not not __t(if __t(b.text) then b.portrait else b.text)
        )
        if __t(if __t(b.text) then b.portrait else b.text) then
            if not __t(portraitCv) then
                portraitCv = window.document:createElement("canvas")
                portraitCv.width = 64
                portraitCv.height = 64
                portraitCv.className = "roteiro-retrato"
                portraitCv:setAttribute("aria-hidden", "true")
            end
            local cap = overlay:querySelector(".cinematic-caption")
            if __t(if __t(cap) then portraitCv.parentNode ~= cap else cap) then
                cap:insertBefore(portraitCv, cap.firstChild)
            end
            drawPortrait(
                nil,
                portraitCv:getContext("2d"),
                b.who,
                64,
                s.shotTime,
                b.emotion
            )
        end
        local p = window.document:getElementById("cinematicText")
        if __t(if __t(p) then b.text else p) then
            local n = math.min(
                __len(b.text),
                math.floor(s.typed)
            )
            local key = __add(
                __add(
                    __add(s.kind, s.index),
                    ":"
                ),
                n
            )
            if key ~= lastSync then
                lastSync = key
                p.textContent = __call(b.text, "slice", 0, n)
                p:setAttribute("aria-label", b.text)
            end
        end
        if not __t(clearer) then
            clearer = window:setInterval(
                function()
                    if window.performance:now() - lastDraw > 300 then
                        overlay.classList:remove("is-roteiro", "roteiro-sem-fala", "roteiro-com-retrato", "roteiro-balao")
                    end
                end,
                250
            )
        end
    end
    local ____ = "use strict"
    if __t(window.Roteiro) then
        return
    end
    W = 960
    H = 540
    local FLOOR = 440
    local BASE = "roteiros/"
    clamp = function(____, v, a, b) return math.max(
        a,
        math.min(b, v)
    ) end
    ease = function(____, k)
        k = clamp(nil, k, 0, 1)
        return k * k * (3 - 2 * k)
    end
    lerp = function(____, a, b, k) return a + (b - a) * k end
    local function hash(____, n)
        local x = math.sin(n * 127.1 + 311.7) * 43758.5453
        return x - math.floor(x)
    end
    local ____arrL_result_0 = __arrL({}, 0)
    window.__roteiroErrors = ____arrL_result_0
    local errors = ____arrL_result_0
    local function warn(____, where, msg)
        local m = __add(
            __add(
                __add("Roteiro ", where),
                ": "
            ),
            msg
        )
        __call(errors, "push", m)
        do
            pcall(function()
                print(m)
            end)
        end
    end
    local SCENES = __ord({
        roca = 0,
        escola = 1,
        academia = 2,
        quadra = 3,
        praca = 4,
        favela = 5,
        caderno = 6,
        tinta = 6,
        campo = 7,
        bigodon = 8,
        patio = 9,
        rayssa = 10,
        baile = 11
    }, "roca,escola,academia,quadra,praca,favela,caderno,tinta,campo,bigodon,patio,rayssa,baile")
    local OUTDOOR = __arrL({
        0,
        1,
        3,
        4,
        5,
        7,
        9
    }, 7)
    local NAMES = __ord({
        daroca = "Da Roça",
        lucas = "Lucas · o Sapo",
        nikolas = "Nikolas Arroganti",
        reeis = "Reeis",
        reeisBoss = "Reeis",
        menezes = "Menezes",
        caleb = "Caleb",
        kaua = "Kaua",
        marco = "Marco",
        ravid = "Ravid",
        mota = "Gabriel Mota",
        almiro = "Professor Almiro",
        miqueias = "Professor Miqueias",
        davi = "Davi Costa",
        vitor = "Vitor",
        freddy = "Freddy",
        nicolas = "Nicolas Carvalho",
        dede = "Dedé",
        aica = "Aica",
        ravile = "Ravile",
        arthur = "Arthur",
        allef = "Allef",
        eloisa = "Eloisa",
        giselle = "Giselle",
        rayssa = "Rayssa",
        analaura = "Ana Laura",
        igor = "Igor",
        kaique = "Kaique",
        ollyan = "Ollyan",
        giant = "Colosso Six Seven",
        narrador = "Narrador"
    }, "daroca,lucas,nikolas,reeis,reeisBoss,menezes,caleb,kaua,marco,ravid,mota,almiro,miqueias,davi,vitor,freddy,nicolas,dede,aica,ravile,arthur,allef,eloisa,giselle,rayssa,analaura,igor,kaique,ollyan,giant,narrador")
    EXT = __ord(
        {
            cenarios = {},
            nomes = {},
            fundos = {},
            efeitos = {},
            anims = {},
            sons = {},
            ganchos = __arrL({}, 0)
        },
        "cenarios,nomes,fundos,efeitos,anims,sons,ganchos"
    )
    local function estender(self, o)
        if o == nil then
            o = {}
        end
        for ____, k in __iterar((__arrL({
            "cenarios",
            "nomes",
            "fundos",
            "efeitos",
            "anims",
            "sons"
        }, 6))) do
            local ____t_3 = __t
            local ____t_2 = __t
            local ____get_result_1 = __get(o, k)
            __O[735] = ____get_result_1
            if ____t_3(if ____t_2(____get_result_1) then type(__get(o, k)) == "table" else __O[735]) then
                __assign(
                    __get(EXT, k),
                    __get(o, k)
                )
            end
        end
        if __t(o.gancho) then
            __call(EXT.ganchos, "push", o.gancho)
        end
    end
    local function sceneOk(____, n)
        local ____t_5 = __t
        local ____temp_4 = __isInteger(n) and __ge(n, 0)
        __O[739] = ____temp_4
        local ____t_7 = __t
        local ____le_result_6 = __le(n, 11)
        __O[738] = ____le_result_6
        local ____t_9 = __t
        local ____le_result_8 = __le(n, 99)
        __O[737] = ____le_result_8
        local ____t_17 = __t
        local ____gt_15 = __gt
        local ____opt_12 = window.CampanhaCenarios
        if ____opt_12 ~= nil then
            ____opt_12 = ____opt_12.largura
        end
        local ____opt_result_14
        if ____opt_12 ~= nil then
            ____opt_result_14 = ____opt_12(____opt_12, n)
        end
        local ____gt_15_result_16 = ____gt_15(____opt_result_14, 0)
        __O[736] = ____gt_15_result_16
        local ____opt_20 = window.CampanhaCenarios
        if ____opt_20 ~= nil then
            ____opt_20 = ____opt_20.layout
        end
        local ____opt_result_22
        if ____opt_20 ~= nil then
            ____opt_result_22 = ____opt_20(____opt_20, n)
        end
        return if ____t_5(____temp_4) then if ____t_7(____le_result_6) then __O[738] else if ____t_9(____le_result_8) then if ____t_17(____gt_15_result_16) then __O[736] else ____opt_result_22 else __O[737] else __O[739]
    end
    local function bgName(____, bg)
        return if __t(if __t(bg) then type(bg) == "table" else bg) then tostring(if __t(bg.nome) then bg.nome else "") else if __t(bg) then tostring(bg) else ""
    end
    scripts = __objCreate(nil)
    local ready = false
    local function num(____, v, d)
        local ____t_25 = __t
        local ____t_24 = __t
        local ____temp_23 = __isFiniteN(__TS__Number(v)) and v ~= nil
        __O[740] = ____temp_23
        return if ____t_25(if ____t_24(____temp_23) then v ~= "" else __O[740]) then __TS__Number(v) else d
    end
    local function camPoint(self, p, prev)
        p = if __t(p) then p else {}
        local ____p_x_30 = p.x
        local ____opt_result_28
        if prev ~= nil then
            ____opt_result_28 = prev.x
        end
        local ____opt_result_28_29 = ____opt_result_28
        if ____opt_result_28_29 == nil then
            ____opt_result_28_29 = 480
        end
        local ____num_result_41 = num(nil, ____p_x_30, ____opt_result_28_29)
        local ____p_y_35 = p.y
        local ____opt_result_33
        if prev ~= nil then
            ____opt_result_33 = prev.y
        end
        local ____opt_result_33_34 = ____opt_result_33
        if ____opt_result_33_34 == nil then
            ____opt_result_33_34 = 380
        end
        local ____num_result_42 = num(nil, ____p_y_35, ____opt_result_33_34)
        local ____p_zoom_40 = p.zoom
        local ____opt_result_38
        if prev ~= nil then
            ____opt_result_38 = prev.zoom
        end
        local ____opt_result_38_39 = ____opt_result_38
        if ____opt_result_38_39 == nil then
            ____opt_result_38_39 = 1
        end
        return {
            x = ____num_result_41,
            y = ____num_result_42,
            zoom = clamp(
                nil,
                num(nil, ____p_zoom_40, ____opt_result_38_39),
                0.5,
                4
            )
        }
    end
    local function normalize(self, raw, file)
        if __t(not __t(raw) or type(raw) ~= "table") then
            error(
                __TS__New(Error, "o arquivo não é um objeto JSON"),
                0
            )
        end
        local id = __call(
            tostring(if __t(raw.id) then raw.id else ""),
            "trim"
        )
        if not __re_test(
            __re("^[a-z0-9_]+$", ""),
            id
        ) then
            error(
                __TS__New(Error, "\"id\" precisa ter só letras minúsculas, números e _ (ex.: \"chegada_praca\")"),
                0
            )
        end
        if __t(not __isArray(raw.cenas) or not __t(__len(raw.cenas))) then
            error(
                __TS__New(Error, "falta a lista \"cenas\""),
                0
            )
        end
        local beats = __arrL({}, 0)
        local shots = __arrL({}, 0)
        __call(
            raw.cenas,
            "forEach",
            function(____, c, i)
                if __t(not __t(c) or type(c) ~= "table") then
                    error(
                        __TS__New(
                            Error,
                            __add(
                                __add("a cena ", i + 1),
                                " não é um objeto"
                            )
                        ),
                        0
                    )
                end
                local ____c_cenario_45 = c.cenario
                if ____c_cenario_45 == nil then
                    local ____opt_43 = __get(shots, i - 1)
                    if ____opt_43 ~= nil then
                        ____opt_43 = ____opt_43.scene
                    end
                    ____c_cenario_45 = ____opt_43
                end
                local ____c_cenario_45_46 = ____c_cenario_45
                if ____c_cenario_45_46 == nil then
                    ____c_cenario_45_46 = 0
                end
                local scene = ____c_cenario_45_46
                if type(scene) == "string" then
                    local key = __re_replace(
                        __call(
                            __call(scene, "toLowerCase"),
                            "normalize",
                            "NFD"
                        ),
                        __re("[̀-ͯ]", "g"),
                        ""
                    )
                    local ____get_result_47 = __get(SCENES, key)
                    if ____get_result_47 == nil then
                        ____get_result_47 = __get(EXT.cenarios, key)
                    end
                    local ____get_result_47_48 = ____get_result_47
                    if ____get_result_47_48 == nil then
                        ____get_result_47_48 = __TS__Number(scene)
                    end
                    scene = ____get_result_47_48
                end
                local pintado = not not __t(__get(
                    EXT.fundos,
                    bgName(nil, c.fundo)
                ))
                if __t(not __t(pintado) and not __t(sceneOk(nil, scene))) then
                    error(
                        __TS__New(
                            Error,
                            __add(
                                __add("cena ", i + 1),
                                ": \"cenario\" inválido (use 0 a 11, um nome como \"praca\" ou uma fase da Campanha 2)"
                            )
                        ),
                        0
                    )
                end
                if __t(if __t(pintado) then not __t(sceneOk(nil, scene)) else pintado) then
                    scene = 0
                end
                local cam = if __t(c.camera) then c.camera else {}
                local ____camPoint_52 = camPoint
                local ____temp_51 = if __t(cam.de) then cam.de else cam
                local ____opt_49 = __get(shots, i - 1)
                if ____opt_49 ~= nil then
                    ____opt_49 = ____opt_49.camTo
                end
                local from = ____camPoint_52(nil, ____temp_51, ____opt_49)
                local ____camPoint_55 = camPoint
                local ____t_54 = __t
                local ____temp_53 = if __t(cam.para) then cam.para else cam.de
                __O[741] = ____temp_53
                local to = ____camPoint_55(nil, if ____t_54(____temp_53) then __O[741] else cam, from)
                local actors = __call(
                    if __isArray(c.atores) then c.atores else __arrL({}, 0),
                    "map",
                    function(____, a, k)
                        local ____t_57 = __t
                        local ____temp_56 = if __t(a.quem) then a.quem else a.tipo
                        __O[742] = ____temp_56
                        local ____type = tostring(if ____t_57(____temp_56) then __O[742] else "")
                        if not __t(____type) then
                            error(
                                __TS__New(
                                    Error,
                                    __add(
                                        __add(
                                            __add(
                                                __add("cena ", i + 1),
                                                ": ator "
                                            ),
                                            k + 1
                                        ),
                                        " sem \"quem\""
                                    )
                                ),
                                0
                            )
                        end
                        local t = if __isArray(a.tempo) then a.tempo else __arrL({0, 2.5}, 2)
                        return {
                            type = ____type,
                            x = num(nil, a.x, 480),
                            y = num(nil, a.y, FLOOR),
                            to = if a.ate ~= nil then num(nil, a.ate, nil) else nil,
                            t0 = num(
                                nil,
                                __get(t, 0),
                                0
                            ),
                            t1 = math.max(
                                num(
                                    nil,
                                    __get(t, 0),
                                    0
                                ) + 0.05,
                                num(
                                    nil,
                                    __get(t, 1),
                                    2.5
                                )
                            ),
                            facing = if a.olhando == nil then nil else if __t(__TS__Number(a.olhando) < 0 or a.olhando == "esquerda") then -1 else 1,
                            scale = clamp(
                                nil,
                                num(nil, a.escala, 1),
                                0.2,
                                6
                            ),
                            emotion = if __t(a.emocao) then a.emocao else nil,
                            jump = num(nil, a.pulo, 0),
                            anim = tostring(if __t(a.anim) then a.anim else ""),
                            appear = num(nil, a.aparece, -1),
                            vanish = num(nil, a.some, math.huge),
                            z = num(nil, a.camada, 0),
                            opts = if __t(if __t(a.opcoes) then type(a.opcoes) == "table" else a.opcoes) then a.opcoes else {}
                        }
                    end
                )
                local fx = __call(
                    __call(
                        if __isArray(c.efeitos) then c.efeitos else __arrL({}, 0),
                        "map",
                        function(____, e) return if type(e) == "string" then {tipo = e} else __assign({}, e) end
                    ),
                    "filter",
                    function(____, e) return e.tipo end
                )
                local sounds = __call(
                    __call(
                        if __isArray(c.sons) then c.sons else __arrL({}, 0),
                        "map",
                        function(____, s) return if type(s) == "string" then {som = s, t = 0} else {
                            som = s.som,
                            t = num(nil, s.t, 0)
                        } end
                    ),
                    "filter",
                    function(____, s) return s.som end
                )
                local ____i_60 = i
                local ____scene_61 = scene
                local ____t_59 = __t
                local ____temp_58 = if __t(c.titulo) then c.titulo else raw.titulo
                __O[743] = ____temp_58
                local shot = {
                    index = ____i_60,
                    scene = ____scene_61,
                    title = tostring(if ____t_59(____temp_58) then __O[743] else ""),
                    hour = if c.hora == nil then nil else num(nil, c.hora, nil),
                    hourTo = if c.hora_ate == nil then nil else num(nil, c.hora_ate, nil),
                    camFrom = from,
                    camTo = to,
                    camTime = math.max(
                        0.1,
                        num(
                            nil,
                            cam.tempo,
                            num(nil, c.duracao, 4)
                        )
                    ),
                    camCurve = if cam.curva == "linear" then "linear" else "suave",
                    duration = math.max(
                        0.3,
                        num(nil, c.duracao, 3.5)
                    ),
                    actors = actors,
                    fx = fx,
                    sounds = sounds,
                    bg = if __t(c.fundo) then c.fundo else nil,
                    raw = c
                }
                __call(shots, "push", shot)
                local lines = if __isArray(c.falas) then c.falas else __arrL({}, 0)
                if not __t(__len(lines)) then
                    __call(beats, "push", {
                        shot = i,
                        title = shot.title,
                        speaker = "",
                        who = "",
                        text = "",
                        duration = shot.duration,
                        first = true
                    })
                end
                __call(
                    lines,
                    "forEach",
                    function(____, f, k)
                        if __t(not __t(f) or type(f) ~= "table") then
                            error(
                                __TS__New(
                                    Error,
                                    __add(
                                        __add(
                                            __add(
                                                __add("cena ", i + 1),
                                                ": fala "
                                            ),
                                            k + 1
                                        ),
                                        " não é um objeto"
                                    )
                                ),
                                0
                            )
                        end
                        local who = tostring(if __t(f.quem) then f.quem else "narrador")
                        local text = tostring(if __t(f.texto) then f.texto else "")
                        if not __t(text) then
                            error(
                                __TS__New(
                                    Error,
                                    __add(
                                        __add(
                                            __add(
                                                __add("cena ", i + 1),
                                                ": fala "
                                            ),
                                            k + 1
                                        ),
                                        " sem \"texto\""
                                    )
                                ),
                                0
                            )
                        end
                        local ____call_73 = __call
                        local ____i_68 = i
                        local ____tostring_result_69 = tostring(if __t(f.titulo) then f.titulo else shot.title)
                        local ____who_70 = who
                        local ____t_65 = __t
                        local ____t_63 = __t
                        local ____temp_62 = if __t(f.nome) then f.nome else __get(NAMES, who)
                        __O[744] = ____temp_62
                        local ____temp_64 = if ____t_63(____temp_62) then __O[744] else __get(EXT.nomes, who)
                        __O[745] = ____temp_64
                        local ____tostring_result_71 = tostring(if ____t_65(____temp_64) then __O[745] else who)
                        local ____text_72 = text
                        local ____t_67 = __t
                        local ____temp_66 = f.retrato ~= false and who ~= "narrador"
                        __O[746] = ____temp_66
                        ____call_73(
                            beats,
                            "push",
                            {
                                shot = ____i_68,
                                title = ____tostring_result_69,
                                who = ____who_70,
                                speaker = ____tostring_result_71,
                                text = ____text_72,
                                portrait = if ____t_67(____temp_66) then who ~= "nenhum" else __O[746],
                                emotion = f.emocao,
                                duration = num(
                                    nil,
                                    f.duracao,
                                    math.floor(clamp(
                                        nil,
                                        __len(text) / 19 + 1.35,
                                        3,
                                        9
                                    ) * 100 + 0.5) / 100
                                ),
                                first = k == 0
                            }
                        )
                    end
                )
            end
        )
        local start = 0
        for ____, b in __iterar((beats)) do
            b.start = start
            start = start + b.duration
        end
        local music = if __isArray(raw.musica) then __call(raw.musica, "map", __StringV) else if __t(raw.musica) then __arrL(
            {tostring(raw.musica)},
            1
        ) else __arrL({}, 0)
        return {
            id = id,
            file = file,
            raw = raw,
            title = tostring(if __t(raw.titulo) then raw.titulo else id),
            before = if __t(raw.antes) then tostring(raw.antes) else nil,
            after = if __t(raw.depois) then tostring(raw.depois) else nil,
            arrival = if raw.chegada == nil then nil else __TS__Number(raw.chegada),
            balao = not not __t(raw.balao),
            once = not not __t(raw.uma_vez),
            replace = not not __t(raw.substituir),
            auto = not not __t(raw.automatico),
            music = music,
            shots = shots,
            beats = __call(
                beats,
                "map",
                function(____, b) return b end
            ),
            duration = math.floor(start * 100 + 0.5) / 100
        }
    end
    local function register(self, raw, file)
        do
            local function ____catch(e)
                warn(nil, file, e.message)
                return true, nil
            end
            local ____try, ____hasReturned, ____returnValue = pcall(function()
                local s = normalize(nil, raw, file)
                local ____t_76 = __t
                local ____opt_74 = window.Cinematics
                if ____opt_74 ~= nil then
                    ____opt_74 = ____opt_74.metadata
                end
                __O[747] = ____opt_74
                local builtin = if ____t_76(____opt_74) then __fcall(__hasOwnV, window.Cinematics.metadata, s.id) else __O[747]
                if __t(if __t(builtin) then not __t(s.replace) else builtin) then
                    warn(
                        nil,
                        file,
                        __add(
                            __add("o id \"", s.id),
                            "\" já é uma cena do jogo. Use outro id ou \"substituir\": true."
                        )
                    )
                    return true, nil
                end
                __set(scripts, s.id, s)
                do
                    pcall(function()
                        local ____t_79 = __t
                        local ____opt_77 = window.Cinematics
                        if ____opt_77 ~= nil then
                            ____opt_77 = ____opt_77.metadata
                        end
                        if ____t_79(____opt_77) then
                            __set(
                                window.Cinematics.metadata,
                                s.id,
                                __call(
                                    s.beats,
                                    "map",
                                    function(____, b) return {title = b.title, speaker = b.speaker, text = b.text} end
                                )
                            )
                        end
                    end)
                end
                return true, s
            end)
            if not ____try then
                ____hasReturned, ____returnValue = ____catch(____hasReturned)
            end
            if ____hasReturned then
                return ____returnValue
            end
        end
    end
    local function load(self)
        return __TS__AsyncAwaiter(function(____awaiter_resolve)
            local ____try = __TS__AsyncAwaiter(function()
                local res = __TS__Await(window:fetch(
                    __add(BASE, "lista.json"),
                    {cache = "no-cache"}
                ))
                if not __t(res.ok) then
                    error(
                        __TS__New(Error, "lista.json não encontrada"),
                        0
                    )
                end
                local list = __TS__Await(res:json())
                local files = if __isArray(list) then list else if __t(list.roteiros) then list.roteiros else __arrL({}, 0)
                __TS__Await(__TS__PromiseAll(__call(
                    files,
                    "map",
                    function(____, f)
                        return __TS__AsyncAwaiter(function(____awaiter_resolve)
                            local ____try = __TS__AsyncAwaiter(function()
                                local r = __TS__Await(window:fetch(
                                    __add(BASE, f),
                                    {cache = "no-cache"}
                                ))
                                if not __t(r.ok) then
                                    error(
                                        __TS__New(Error, "arquivo não encontrado"),
                                        0
                                    )
                                end
                                register(
                                    nil,
                                    __TS__Await(r:json()),
                                    f
                                )
                            end)
                            ____try = ____try.catch(
                                ____try,
                                function(____, e)
                                    return __TS__AsyncAwaiter(function()
                                        warn(nil, f, if __t(__call(e.message, "includes", "JSON")) then "JSON com erro de digitação (vírgula ou aspas faltando?)" else e.message)
                                    end)
                                end
                            )
                            __TS__Await(____try)
                        end)
                    end
                )))
            end)
            ____try = ____try.catch(
                ____try,
                function(____, e)
                    return __TS__AsyncAwaiter(function()
                        warn(nil, "lista.json", e.message)
                    end)
                end
            )
            __TS__Await(____try)
            ready = true
            local ____try = __TS__AsyncAwaiter(function()
                window:dispatchEvent(__new(
                    "CustomEvent",
                    "roteiros-prontos",
                    {detail = {ids = __keys(scripts)}}
                ))
            end)
            ____try = ____try.catch(
                ____try,
                function(____, e)
                    return __TS__AsyncAwaiter(function()
                    end)
                end
            )
            __TS__Await(____try)
        end)
    end
    local actx = nil
    local function sfx(self, name)
        local ____t_85 = __t
        local ____t_84 = __t
        local ____t_82 = __t
        local ____opt_80 = window.Game
        if ____opt_80 ~= nil then
            ____opt_80 = ____opt_80.soundOn
        end
        __O[748] = ____opt_80
        local ____temp_83 = if ____t_82(____opt_80) then not __t(window.Game:soundOn()) else __O[748]
        __O[749] = ____temp_83
        if ____t_85(if ____t_84(____temp_83) then not __t(window.__somCutscene) else __O[749]) then
            return
        end
        do
            pcall(function()
                actx = if __t(actx) then actx else __newExpr(if __t(window.AudioContext) then window.AudioContext else window.webkitAudioContext)
                if actx.state == "suspended" then
                    actx:resume()
                end
                local now = actx.currentTime
                local out = actx:createGain()
                local ____out_gain_92 = out.gain
                local ____opt_88 = window.DarocaAudio
                if ____opt_88 ~= nil then
                    ____opt_88 = ____opt_88.sfx
                end
                local ____opt_result_90
                if ____opt_88 ~= nil then
                    ____opt_result_90 = ____opt_88(____opt_88)
                end
                local ____opt_result_90_91 = ____opt_result_90
                if ____opt_result_90_91 == nil then
                    ____opt_result_90_91 = 1
                end
                ____out_gain_92.value = 0.05 * ____opt_result_90_91
                out:connect(actx.destination)
                local function tone(____, f, f2, d, ____type, at, vol)
                    if ____type == nil then
                        ____type = "square"
                    end
                    if at == nil then
                        at = 0
                    end
                    if vol == nil then
                        vol = 1
                    end
                    local o = actx:createOscillator()
                    local g = actx:createGain()
                    o.type = ____type
                    o.frequency:setValueAtTime(f, now + at)
                    if __t(f2) then
                        o.frequency:exponentialRampToValueAtTime(
                            math.max(30, f2),
                            __add(now + at, d)
                        )
                    end
                    g.gain:setValueAtTime(vol, now + at)
                    g.gain:exponentialRampToValueAtTime(
                        0.001,
                        __add(now + at, d)
                    )
                    o:connect(g)
                    g:connect(out)
                    o:start(now + at)
                    o:stop(__add(now + at, d) + 0.02)
                end
                local function noise(____, d, vol, at, hp)
                    if vol == nil then
                        vol = 1
                    end
                    if at == nil then
                        at = 0
                    end
                    if hp == nil then
                        hp = 0
                    end
                    local len = math.floor(actx.sampleRate * d)
                    local buf = actx:createBuffer(1, len, actx.sampleRate)
                    local ch = buf:getChannelData(0)
                    do
                        local i = 0
                        while i < len do
                            __set(
                                ch,
                                i,
                                (math.random() * 2 - 1) * (1 - i / len)
                            )
                            i = i + 1
                        end
                    end
                    local src = actx:createBufferSource()
                    local g = actx:createGain()
                    src.buffer = buf
                    g.gain.value = vol
                    local node = src
                    if __t(hp) then
                        local f = actx:createBiquadFilter()
                        f.type = "highpass"
                        f.frequency.value = hp
                        src:connect(f)
                        node = f
                    end
                    node:connect(g)
                    g:connect(out)
                    src:start(now + at)
                end
                repeat
                    local ____switch68 = name
                    local ____cond68 = ____switch68 == "sino"
                    if ____cond68 then
                        tone(
                            nil,
                            880,
                            870,
                            1.2,
                            "sine"
                        )
                        tone(
                            nil,
                            1320,
                            1300,
                            0.9,
                            "sine",
                            0,
                            0.5
                        )
                        break
                    end
                    ____cond68 = ____cond68 or ____switch68 == "plim"
                    if ____cond68 then
                        tone(
                            nil,
                            1046,
                            1040,
                            0.25,
                            "square"
                        )
                        tone(
                            nil,
                            1568,
                            1560,
                            0.35,
                            "square",
                            0.08
                        )
                        break
                    end
                    ____cond68 = ____cond68 or ____switch68 == "impacto"
                    if ____cond68 then
                        tone(
                            nil,
                            140,
                            40,
                            0.35,
                            "square"
                        )
                        noise(nil, 0.25, 0.8)
                        break
                    end
                    ____cond68 = ____cond68 or ____switch68 == "whoosh"
                    if ____cond68 then
                        noise(
                            nil,
                            0.45,
                            0.7,
                            0,
                            900
                        )
                        break
                    end
                    ____cond68 = ____cond68 or ____switch68 == "passos"
                    if ____cond68 then
                        do
                            local i = 0
                            while i < 4 do
                                noise(
                                    nil,
                                    0.05,
                                    0.6,
                                    i * 0.22,
                                    300
                                )
                                i = i + 1
                            end
                        end
                        break
                    end
                    ____cond68 = ____cond68 or ____switch68 == "trovao"
                    if ____cond68 then
                        noise(nil, 1.6, 1.2)
                        tone(
                            nil,
                            60,
                            30,
                            1.4,
                            "sawtooth",
                            0,
                            0.6
                        )
                        break
                    end
                    ____cond68 = ____cond68 or ____switch68 == "buzina"
                    if ____cond68 then
                        tone(
                            nil,
                            392,
                            392,
                            0.18,
                            "sawtooth"
                        )
                        tone(
                            nil,
                            392,
                            392,
                            0.3,
                            "sawtooth",
                            0.24
                        )
                        break
                    end
                    ____cond68 = ____cond68 or ____switch68 == "galo"
                    if ____cond68 then
                        tone(
                            nil,
                            520,
                            900,
                            0.18,
                            "sawtooth"
                        )
                        tone(
                            nil,
                            900,
                            700,
                            0.25,
                            "sawtooth",
                            0.2
                        )
                        tone(
                            nil,
                            760,
                            420,
                            0.5,
                            "sawtooth",
                            0.46
                        )
                        break
                    end
                    ____cond68 = ____cond68 or ____switch68 == "tambor"
                    if ____cond68 then
                        tone(
                            nil,
                            110,
                            50,
                            0.3,
                            "sine",
                            0,
                            1.4
                        )
                        tone(
                            nil,
                            110,
                            50,
                            0.3,
                            "sine",
                            0.3,
                            1.4
                        )
                        tone(
                            nil,
                            160,
                            60,
                            0.4,
                            "sine",
                            0.55,
                            1.6
                        )
                        break
                    end
                    ____cond68 = ____cond68 or ____switch68 == "fanfarra"
                    if ____cond68 then
                        __call(
                            __arrL({523, 659, 784, 1046}, 4),
                            "forEach",
                            function(____, f, i) return tone(
                                nil,
                                f,
                                f,
                                0.3,
                                "square",
                                i * 0.14
                            ) end
                        )
                        break
                    end
                    ____cond68 = ____cond68 or ____switch68 == "misterio"
                    if ____cond68 then
                        tone(
                            nil,
                            220,
                            200,
                            1.2,
                            "triangle"
                        )
                        tone(
                            nil,
                            233,
                            210,
                            1.2,
                            "triangle",
                            0.1
                        )
                        break
                    end
                    ____cond68 = ____cond68 or ____switch68 == "risada"
                    if ____cond68 then
                        do
                            local i = 0
                            while i < 4 do
                                tone(
                                    nil,
                                    500 - i * 40,
                                    420 - i * 40,
                                    0.1,
                                    "square",
                                    i * 0.13
                                )
                                i = i + 1
                            end
                        end
                        break
                    end
                    do
                        if __t(__get(EXT.sons, name)) then
                            __get(EXT.sons, name)(nil, {
                                tone = tone,
                                noise = noise,
                                actx = actx,
                                out = out,
                                now = now
                            })
                        else
                            tone(
                                nil,
                                660,
                                600,
                                0.15,
                                "square"
                            )
                        end
                    end
                until true
            end)
        end
    end
    headCache = {}
    local function has(____, id)
        return not not __t(__get(scripts, id))
    end
    local function create(self, id, options)
        if options == nil then
            options = {}
        end
        return {
            kind = id,
            roteiro = true,
            index = 0,
            time = 0,
            shotTime = 0,
            elapsed = 0,
            typed = 0,
            fired = {},
            done = false,
            options = __assign({}, options)
        }
    end
    local function beatOf(____, s)
        return __get(
            __get(scripts, s.kind).beats,
            clamp(
                nil,
                __bor(s.index, 0),
                0,
                __len(__get(scripts, s.kind).beats) - 1
            )
        )
    end
    local function next(self, s)
        local sc = __get(scripts, s.kind)
        local prev = beatOf(nil, s)
        if __ge(
            s.index + 1,
            __len(sc.beats)
        ) then
            s.done = true
            release(nil)
            return false
        end
        s.index = s.index + 1
        s.time = 0
        s.typed = 0
        if beatOf(nil, s).shot ~= prev.shot then
            s.shotTime = 0
            s.fired = {}
        end
        return true
    end
    local function update(self, s, dt)
        local ____t_101 = __t
        local ____t_100 = __t
        local ____temp_99 = not __t(s)
        __O[752] = ____temp_99
        if ____t_101(if ____t_100(____temp_99) then __O[752] else s.done) then
            return
        end
        local ____t_103 = __t
        local ____TS__Number_result_102 = __TS__Number(dt)
        __O[753] = ____TS__Number_result_102
        dt = clamp(nil, if ____t_103(____TS__Number_result_102) then __O[753] else 0, 0, 0.1)
        local sc = __get(scripts, s.kind)
        local b = beatOf(nil, s)
        local shot = __get(sc.shots, b.shot)
        s.time = __add(s.time, dt)
        s.shotTime = __add(s.shotTime, dt)
        s.elapsed = __add(s.elapsed, dt)
        s.typed = s.typed + dt * 48
        for ____, snd in __iterar((shot.sounds)) do
            local key = __add(
                __add(snd.som, "@"),
                snd.t
            )
            if __t(not __t(__get(s.fired, key)) and __ge(s.shotTime, snd.t)) then
                __set(s.fired, key, 1)
                sfx(nil, snd.som)
            end
        end
        local ____t_109 = __t
        local ____t_107 = __t
        local ____t_105 = __t
        local ____temp_104 = not __t(b.text)
        __O[754] = ____temp_104
        local ____temp_106 = if ____t_105(____temp_104) then __O[754] else s.options.musicTimed
        __O[755] = ____temp_106
        local ____temp_108 = if ____t_107(____temp_106) then __O[755] else sc.auto
        __O[756] = ____temp_108
        local auto = if ____t_109(____temp_108) then __O[756] else s.options.auto
        if __t(if __t(auto) then __ge(s.time, b.duration) else auto) then
            next(nil, s)
        end
    end
    local function advance(self, s)
        local ____t_112 = __t
        local ____t_111 = __t
        local ____temp_110 = not __t(s)
        __O[757] = ____temp_110
        if ____t_112(if ____t_111(____temp_110) then __O[757] else s.done) then
            return false
        end
        local b = beatOf(nil, s)
        __D[1] = if __t(if __t(b.text) then __lt(
            s.typed,
            __len(b.text)
        ) else b.text) then
            s.typed = 1000000000
            return true
        end
        return next(nil, s)
    end
    local function beat(self, s)
        local sc = __get(scripts, s.kind)
        local b = beatOf(nil, s)
        return {
            title = b.title,
            speaker = b.speaker,
            text = b.text,
            index = s.index,
            number = s.index + 1,
            total = __len(sc.beats),
            roteiro = true,
            cinematic = not __t(b.text)
        }
    end
    local function timeline(self, id)
        local sc = __get(scripts, id)
        if not __t(sc) then
            return nil
        end
        return {
            id = id,
            duration = sc.duration,
            manualDefault = not __t(sc.auto),
            shots = __call(
                sc.beats,
                "map",
                function(____, b, i) return {
                    id = tostring(i),
                    index = i,
                    start = b.start,
                    duration = b.duration,
                    label = if __t(b.title) then b.title else __add("Quadro ", i + 1),
                    speaker = b.speaker,
                    text = b.text
                } end
            )
        }
    end
    local function stateAt(self, id, seconds, options)
        if seconds == nil then
            seconds = 0
        end
        if options == nil then
            options = {}
        end
        local sc = __get(scripts, id)
        if not __t(sc) then
            return nil
        end
        local ____t_114 = __t
        local ____TS__Number_result_113 = __TS__Number(seconds)
        __O[758] = ____TS__Number_result_113
        local el = clamp(nil, if ____t_114(____TS__Number_result_113) then __O[758] else 0, 0, sc.duration)
        local i = __call(
            sc.beats,
            "findIndex",
            function(____, b) return __lt(
                el,
                __add(b.start, b.duration)
            ) end
        )
        if __lt(i, 0) then
            i = __len(sc.beats) - 1
        end
        local b = __get(sc.beats, i)
        local shotStart = b.start
        do
            local k = i
            while __t(__ge(k, 0) and __get(sc.beats, k).shot == b.shot) do
                shotStart = __get(sc.beats, k).start
                k = k - 1
            end
        end
        return __assign(
            {},
            create(
                nil,
                id,
                __assign({}, options, {musicTimed = true})
            ),
            {
                index = i,
                time = el - b.start,
                shotTime = el - shotStart,
                elapsed = el,
                typed = 1000000000,
                done = __ge(el, sc.duration)
            }
        )
    end
    forced = false
    lastDraw = 0
    window:setInterval(
        function()
            if __t(if __t(forced) then window.performance:now() - lastDraw > 400 else forced) then
                release(nil)
            end
        end,
        300
    )
    local world = nil
    local function P(____, c, x, y, w, h, col)
        c.fillStyle = col
        c:fillRect(
            math.floor(x / 2 + 0.5) * 2,
            math.floor(y / 2 + 0.5) * 2,
            w,
            h
        )
    end
    local function fxWindow(self, e, t, def)
        local t0 = num(nil, e.t, 0)
        local d = num(nil, e.dur, def)
        return {
            on = __ge(t, t0) and __le(
                t,
                __add(t0, d)
            ),
            k = clamp(nil, (t - t0) / d, 0, 1),
            t0 = t0,
            d = d
        }
    end
    local function drawWorld(self, c, sc, shot, s, t, b)
        if not __t(world) then
            world = window.document:createElement("canvas")
            world.width = W
            world.height = H
        end
        local w = world:getContext("2d")
        local cam = camAt(nil, shot, t)
        local zoom = cam.zoom
        for ____, e in __iterar((shot.fx)) do
            if e.tipo == "zoom_soco" then
                local t0 = num(nil, e.t, 0)
                if __ge(t, t0) then
                    zoom = zoom + num(nil, e.forca, 0.18) * math.exp(-(t - t0) * 7) * if t - t0 < 0.05 then (t - t0) / 0.05 else 1
                end
            end
        end
        local camX = math.floor(cam.x - W / 2 + 0.5)
        w:save()
        w.imageSmoothingEnabled = false
        w:clearRect(0, 0, W, H)
        local pintor = __get(
            EXT.fundos,
            bgName(nil, shot.bg)
        )
        if __t(pintor) then
            w:save()
            w:translate(-camX, 0)
            do
                local function ____catch(e)
                    w.fillStyle = "#0b0d10"
                    w:fillRect(camX, 0, W, H)
                end
                local ____try, ____hasReturned = pcall(function()
                    pintor(nil, w, {
                        t = t,
                        tt = s.elapsed,
                        shot = shot,
                        s = s,
                        p = if type(shot.bg) == "table" then shot.bg else {},
                        cam = cam,
                        W = W,
                        H = H,
                        ajuda = ajuda
                    })
                end)
                if not ____try then
                    ____catch(____hasReturned)
                end
            end
            w:restore()
        elseif shot.bg == "preto" then
            w.fillStyle = "#0b0d10"
            w:fillRect(0, 0, W, H)
        else
            local ____t_137 = __t
            local ____opt_135 = window.Art
            if ____opt_135 ~= nil then
                ____opt_135 = ____opt_135.drawScene
            end
            if ____t_137(____opt_135) then
                window.Art:drawScene(w, shot.scene, camX, s.elapsed)
            else
                w.fillStyle = "#8ec7e1"
                w:fillRect(0, 0, W, H)
            end
        end
        local list = __call(
            __call(
                __call(
                    shot.actors,
                    "map",
                    function(____, a, i) return {
                        a = a,
                        i = i,
                        p = actorAt(nil, a, t, b.who == a.type)
                    } end
                ),
                "filter",
                function(____, r) return r.p.visible end
            ),
            "sort",
            function(____, p, q)
                local ____t_141 = __t
                local ____t_139 = __t
                local ____temp_138 = p.a.z - q.a.z
                __O[763] = ____temp_138
                local ____temp_140 = if ____t_139(____temp_138) then __O[763] else p.p.y - q.p.y
                __O[764] = ____temp_140
                return if ____t_141(____temp_140) then __O[764] else p.i - q.i
            end
        )
        for ____, r in __iterar((list)) do
            local sx = r.p.x - camX
            if __t(sx < -200 or sx > W + 200) then
                continue
            end
            w.fillStyle = "rgba(20,24,18,.28)"
            w:fillRect(
                math.floor((sx - 16 * r.a.scale) / 2 + 0.5) * 2,
                math.floor(r.a.y / 2 + 0.5) * 2 - 2,
                math.floor(32 * r.a.scale / 2 + 0.5) * 2,
                4
            )
            do
                pcall(function()
                    local ____t_146 = __t
                    local ____t_143 = __t
                    local ____temp_142 = r.a.type == "carro"
                    __O[765] = ____temp_142
                    local ____opt_144 = window.Art
                    if ____opt_144 ~= nil then
                        ____opt_144 = ____opt_144.drawVehicle
                    end
                    if ____t_146(if ____t_143(____temp_142) then ____opt_144 else __O[765]) then
                        local vf = if __lt(r.p.o.facing, 0) then -1 else 1
                        local bob = if __t(r.p.o.moving) then math.floor(math.sin(t * 18) + 0.5) else 0
                        w:save()
                        w:translate(
                            math.floor(sx + 0.5),
                            0
                        )
                        w:scale(vf, 1)
                        window.Art:drawVehicle(w, 0, r.p.y + bob, t)
                        w:restore()
                        window.Art:drawCharacter(
                            w,
                            "daroca",
                            sx + 4 * vf,
                            r.p.y - 22 + bob,
                            __assign({}, r.p.o, {moving = false, scale = 0.8 * r.a.scale})
                        )
                    else
                        local ctx = {
                            x = sx,
                            y = r.p.y,
                            t = t,
                            a = r.a,
                            o = r.p.o,
                            alpha = r.p.alpha,
                            head = headBox(nil, r.a.type),
                            ajuda = ajuda
                        }
                        for ____, n in __iterar((r.p.extras)) do
                            local ____this_148
                            ____this_148 = __get(EXT.anims, n)
                            local ____opt_147 = ____this_148.antes
                            if ____opt_147 ~= nil then
                                ____opt_147(____this_148, w, ctx)
                            end
                        end
                        local ____opt_151 = window.Art
                        if ____opt_151 ~= nil then
                            ____opt_151 = ____opt_151.drawCharacter
                        end
                        if ____opt_151 ~= nil then
                            ____opt_151(
                                ____opt_151,
                                w,
                                r.a.type,
                                sx,
                                r.p.y,
                                r.p.o
                            )
                        end
                        for ____, n in __iterar((__call(
                            __call(r.p.extras, "slice"),
                            "reverse"
                        ))) do
                            local ____this_154
                            ____this_154 = __get(EXT.anims, n)
                            local ____opt_153 = ____this_154.depois
                            if ____opt_153 ~= nil then
                                ____opt_153(____this_154, w, ctx)
                            end
                        end
                    end
                end)
            end
        end
        local ____t_161 = __t
        local ____t_160 = __t
        local ____t_156 = __t
        local ____temp_155 = not __t(pintor) and shot.bg ~= "preto"
        __O[766] = ____temp_155
        local ____opt_157 = window.HdScene
        if ____opt_157 ~= nil then
            ____opt_157 = ____opt_157.drawAmbient
        end
        local ____temp_159 = if ____t_156(____temp_155) then ____opt_157 else __O[766]
        __O[767] = ____temp_159
        if ____t_161(if ____t_160(____temp_159) then __call(OUTDOOR, "includes", shot.scene) else __O[767]) then
            do
                pcall(function()
                    window.HdScene:drawAmbient(
                        w,
                        s.elapsed,
                        W / 2,
                        FLOOR - 40,
                        shot.scene
                    )
                end)
            end
        end
        w:restore()
        local shake = 0
        for ____, e in __iterar((shot.fx)) do
            if e.tipo == "tremer" then
                local f = fxWindow(nil, e, t, 0.6)
                if __t(f.on) then
                    shake = math.max(
                        shake,
                        num(nil, e.forca, 8) * (1 - f.k)
                    )
                end
            end
        end
        local sw = W / zoom
        local sh = H / zoom
        local fy = clamp(nil, cam.y, 0, H)
        local sx = (W - sw) / 2
        local sy = fy - fy / zoom
        sx = clamp(
            nil,
            sx,
            math.min(0, W - sw),
            math.max(0, W - sw)
        )
        sy = clamp(
            nil,
            sy,
            math.min(0, H - sh),
            math.max(0, H - sh)
        )
        local dx = if __t(shake) then math.floor((hash(nil, t * 60) - 0.5) * shake * 2 / 2 + 0.5) * 2 else 0
        local dy = if __t(shake) then math.floor((hash(nil, t * 60 + 9) - 0.5) * shake * 2 / 2 + 0.5) * 2 else 0
        c:save()
        c.imageSmoothingEnabled = false
        c.fillStyle = "#0b0d10"
        c:fillRect(0, 0, W, H)
        c:drawImage(
            world,
            sx,
            sy,
            sw,
            sh,
            dx,
            dy,
            W,
            H
        )
        c:restore()
    end
    local function card(self, c, text, sub, a, y)
        if y == nil then
            y = 230
        end
        c:save()
        c.globalAlpha = a
        c.textAlign = "center"
        c.textBaseline = "middle"
        c.fillStyle = "rgba(12,16,14,.72)"
        c:fillRect(0, y - 46, W, if __t(sub) then 104 else 84)
        c.fillStyle = "#e8c27a"
        c:fillRect(0, y - 46, W, 4)
        c:fillRect(0, y + if __t(sub) then 54 else 34, W, 4)
        c.font = "bold 30px Pixel, monospace"
        c.fillStyle = "#2a1c10"
        c:fillText(text, W / 2 + 4, y + 4)
        c.fillStyle = "#ffe9b0"
        c:fillText(text, W / 2, y)
        if __t(sub) then
            c.font = "13px Pixel, monospace"
            c.fillStyle = "#d7e7a0"
            c:fillText(sub, W / 2, y + 36)
        end
        c:restore()
    end
    local function drawFx(self, c, shot, t, s)
        local tt = s.elapsed
        for ____, e in __iterar((shot.fx)) do
            local tipo = e.tipo
            if tipo == "vinheta" then
                local g = c:createRadialGradient(
                    W / 2,
                    H / 2,
                    200,
                    W / 2,
                    H / 2,
                    620
                )
                g:addColorStop(0, "rgba(0,0,0,0)")
                g:addColorStop(
                    1,
                    ("rgba(8,6,4," .. tostring(num(nil, e.forca, 0.6))) .. ")"
                )
                c.fillStyle = g
                c:fillRect(0, 0, W, H)
            elseif tipo == "memoria" then
                c.fillStyle = "rgba(150,110,60,.32)"
                c:fillRect(0, 0, W, H)
                c.fillStyle = "rgba(255,240,200,.08)"
                do
                    local y = 0
                    while y < H do
                        c:fillRect(0, y, W, 2)
                        y = y + 4
                    end
                end
                do
                    local i = 0
                    while i < 26 do
                        P(
                            nil,
                            c,
                            hash(
                                nil,
                                i + math.floor(tt * 12)
                            ) * W,
                            hash(
                                nil,
                                i * 3 + math.floor(tt * 12)
                            ) * H,
                            2,
                            2,
                            "rgba(255,240,210,.35)"
                        )
                        i = i + 1
                    end
                end
            elseif tipo == "noite" then
                c.fillStyle = "rgba(20,30,70,.38)"
                c:fillRect(0, 0, W, H)
            elseif tipo == "confete" then
                do
                    local i = 0
                    while i < 70 do
                        local x = __mod(
                            hash(nil, i) * W + math.sin(tt * 2 + i) * 20 + W,
                            W
                        )
                        local y = __mod(
                            hash(nil, i + 5) * H + tt * (60 + hash(nil, i + 2) * 70),
                            H
                        )
                        P(
                            nil,
                            c,
                            x,
                            y,
                            4,
                            4,
                            __get(
                                __arrL({
                                    "#f2c14e",
                                    "#e85d75",
                                    "#5bc0eb",
                                    "#9bc53d",
                                    "#fff"
                                }, 5),
                                __mod(i, 5)
                            )
                        )
                        i = i + 1
                    end
                end
            elseif tipo == "coracoes" then
                do
                    local i = 0
                    while i < 9 do
                        local x = 160 + hash(nil, i) * 640
                        local y = H - __mod(
                            tt * 40 + hash(nil, i + 1) * H,
                            H
                        )
                        local col = "#e85d75"
                        P(
                            nil,
                            c,
                            x,
                            y,
                            4,
                            4,
                            col
                        )
                        P(
                            nil,
                            c,
                            x + 6,
                            y,
                            4,
                            4,
                            col
                        )
                        P(
                            nil,
                            c,
                            x - 2,
                            y + 4,
                            14,
                            4,
                            col
                        )
                        P(
                            nil,
                            c,
                            x,
                            y + 8,
                            10,
                            2,
                            col
                        )
                        P(
                            nil,
                            c,
                            x + 2,
                            y + 10,
                            6,
                            2,
                            col
                        )
                        i = i + 1
                    end
                end
            elseif tipo == "brilhos" then
                do
                    local i = 0
                    while i < 18 do
                        local on = math.sin(tt * 4 + i * 1.7) > 0.3
                        if not __t(on) then
                            continue
                        end
                        local x = hash(nil, i + 30) * W
                        local y = 60 + hash(nil, i + 31) * 340
                        P(
                            nil,
                            c,
                            x,
                            y - 4,
                            2,
                            10,
                            "#fff3a8"
                        )
                        P(
                            nil,
                            c,
                            x - 4,
                            y,
                            10,
                            2,
                            "#fff3a8"
                        )
                        i = i + 1
                    end
                end
            elseif tipo == "folhas" then
                do
                    local i = 0
                    while i < 16 do
                        local x = __mod(
                            hash(nil, i + 40) * 1100 + tt * (90 + hash(nil, i) * 70),
                            1100
                        ) - 70
                        local y = 80 + hash(nil, i + 41) * 300 + math.sin(tt * 2 + i) * 20
                        local col = __get(
                            __arrL({"#6aa850", "#c9a24a", "#d8783a"}, 3),
                            __mod(i, 3)
                        )
                        P(
                            nil,
                            c,
                            x,
                            y,
                            4,
                            2,
                            col
                        )
                        P(
                            nil,
                            c,
                            x + 2,
                            y - 2,
                            2,
                            2,
                            col
                        )
                        i = i + 1
                    end
                end
            elseif tipo == "chuva" then
                c.fillStyle = "rgba(40,52,80,.22)"
                c:fillRect(0, 0, W, H)
                do
                    local i = 0
                    while i < 140 do
                        local y = __mod(
                            hash(nil, i + 3) * H + tt * (700 + hash(nil, i) * 300),
                            H + 40
                        ) - 20
                        local x = __mod(
                            hash(nil, i + 7) * 1000 + y * 0.3,
                            1000
                        ) - 20
                        P(
                            nil,
                            c,
                            x,
                            y,
                            2,
                            10,
                            "rgba(210,225,250,.6)"
                        )
                        i = i + 1
                    end
                end
            elseif tipo == "raios" then
                c:save()
                c.globalCompositeOperation = "lighter"
                do
                    local i = 0
                    while i < 5 do
                        local x = 120 + i * 170 + math.sin(tt * 0.5 + i) * 20
                        c.fillStyle = ("rgba(255,228,160," .. tostring(0.06 + 0.03 * math.sin(tt + i))) .. ")"
                        c:beginPath()
                        c:moveTo(x, 0)
                        c:lineTo(x + 50, 0)
                        c:lineTo(x - 90, H)
                        c:lineTo(x - 170, H)
                        __call(c, "fill")
                        i = i + 1
                    end
                end
                c:restore()
            end
        end
        for ____, e in __iterar((shot.fx)) do
            local tipo = e.tipo
            if tipo == "cartao" then
                local f = fxWindow(nil, e, t, 3)
                if __t(f.on) then
                    card(
                        nil,
                        c,
                        tostring(if __t(e.texto) then e.texto else ""),
                        if __t(e.sub) then tostring(e.sub) else "",
                        math.min(
                            1,
                            (t - f.t0) / 0.3,
                            (__add(f.t0, f.d) - t) / 0.3
                        ),
                        num(nil, e.y, 230)
                    )
                end
            elseif tipo == "letreiro" then
                local f = fxWindow(nil, e, t, 3.2)
                if __t(f.on) then
                    local a = math.min(
                        1,
                        (t - f.t0) / 0.3,
                        (__add(f.t0, f.d) - t) / 0.3
                    )
                    local slide = (1 - ease(nil, (t - f.t0) / 0.45)) * -340
                    c:save()
                    c.globalAlpha = a
                    c.fillStyle = "rgba(14,20,16,.8)"
                    c:fillRect(slide, 58, 380, 62)
                    c.fillStyle = "#e8c27a"
                    c:fillRect(slide, 58, 6, 62)
                    c.textBaseline = "middle"
                    c.textAlign = "left"
                    c.font = "11px Pixel, monospace"
                    c.fillStyle = "#d7e7a0"
                    c:fillText(
                        tostring(if __t(e.sub) then e.sub else "VOCÊ CHEGOU"),
                        slide + 22,
                        76
                    )
                    c.font = "bold 19px Pixel, monospace"
                    c.fillStyle = "#fff1ca"
                    c:fillText(
                        tostring(if __t(e.texto) then e.texto else ""),
                        slide + 22,
                        102
                    )
                    c:restore()
                end
            elseif tipo == "texto" then
                local f = fxWindow(nil, e, t, 1.2)
                if __t(f.on) then
                    local pop = 1 + math.max(0, 0.35 - (t - f.t0)) * 1.4
                    c:save()
                    c:translate(
                        num(nil, e.x, 480),
                        num(nil, e.y, 200)
                    )
                    c:scale(pop, pop)
                    c:rotate(num(nil, e.giro, -0.06))
                    c.textAlign = "center"
                    c.textBaseline = "middle"
                    c.font = ("bold " .. tostring(num(nil, e.tamanho, 34))) .. "px Pixel, monospace"
                    c.globalAlpha = math.min(
                        1,
                        (__add(f.t0, f.d) - t) / 0.25
                    )
                    c.fillStyle = "#1b130c"
                    c:fillText(
                        tostring(if __t(e.texto) then e.texto else ""),
                        4,
                        4
                    )
                    c.fillStyle = if __t(e.cor) then e.cor else "#ffd166"
                    c:fillText(
                        tostring(if __t(e.texto) then e.texto else ""),
                        0,
                        0
                    )
                    c:restore()
                end
            elseif tipo == "flash" then
                local f = fxWindow(nil, e, t, 0.35)
                if __t(f.on) then
                    c.fillStyle = ((("rgba(" .. if e.cor == "vermelho" then "255,80,60" else "255,250,235") .. ",") .. tostring((1 - f.k) * 0.85)) .. ")"
                    c:fillRect(0, 0, W, H)
                end
            elseif tipo == "entrada" then
                local d = num(nil, e.dur, 0.9)
                local t0 = num(nil, e.t, 0)
                if __lt(
                    t,
                    __add(t0, d)
                ) then
                    c.fillStyle = ("rgba(8,8,10," .. tostring(if __lt(t, t0) then 1 else 1 - (t - t0) / d)) .. ")"
                    c:fillRect(0, 0, W, H)
                end
            elseif __t(__get(EXT.efeitos, tipo)) then
                do
                    pcall(function()
                        __get(EXT.efeitos, tipo)(
                            nil,
                            c,
                            e,
                            t,
                            {
                                shot = shot,
                                s = s,
                                W = W,
                                H = H,
                                win = function(____, d) return fxWindow(nil, e, t, d) end,
                                num = num,
                                P = P,
                                card = card,
                                ease = ease,
                                clamp = clamp,
                                lerp = lerp,
                                hash = hash,
                                ajuda = ajuda
                            }
                        )
                    end)
                end
            elseif tipo == "saida" then
                local t0 = num(
                    nil,
                    e.t,
                    math.max(0, shot.duration - 0.9)
                )
                local d = num(nil, e.dur, 0.9)
                if __ge(t, t0) then
                    c.fillStyle = ("rgba(8,8,10," .. tostring(clamp(nil, (t - t0) / d, 0, 1))) .. ")"
                    c:fillRect(0, 0, W, H)
                end
            end
        end
    end
    local function draw(self, c, s)
        if __t(not __t(c) or not __t(s)) then
            return
        end
        local sc = __get(scripts, s.kind)
        if not __t(sc) then
            return
        end
        local b = beatOf(nil, s)
        local shot = __get(sc.shots, b.shot)
        local t = s.shotTime
        lastDraw = window.performance:now()
        if shot.hour ~= nil then
            do
                pcall(function()
                    local ____opt_164 = window.DayTime
                    if ____opt_164 ~= nil then
                        ____opt_164 = ____opt_164.force
                    end
                    if ____opt_164 ~= nil then
                        ____opt_164(____opt_164, if shot.hourTo == nil then shot.hour else lerp(
                            nil,
                            shot.hour,
                            shot.hourTo,
                            ease(nil, t / shot.camTime)
                        ))
                    end
                    forced = true
                end)
            end
        else
            release(nil)
        end
        c:save()
        c:clearRect(0, 0, W, H)
        drawWorld(
            nil,
            c,
            sc,
            shot,
            s,
            t,
            b
        )
        drawFx(
            nil,
            c,
            shot,
            t,
            s
        )
        for ____, g in __iterar((EXT.ganchos)) do
            do
                pcall(function()
                    local ____opt_166 = g.quadro
                    if ____opt_166 ~= nil then
                        ____opt_166(
                            g,
                            s,
                            sc,
                            shot,
                            t
                        )
                    end
                end)
            end
        end
        c.fillStyle = "#10241ff0"
        c:fillRect(0, 0, W, 24)
        c.fillStyle = "#10241fe0"
        c:fillRect(0, H - 20, W, 20)
        local ____t_170 = __t
        local ____t_169 = __t
        local ____temp_168 = if __t(b.first) then __lt(s.time, 0.25) else b.first
        __O[768] = ____temp_168
        __D[1] = if ____t_170(if ____t_169(____temp_168) then not __t(__call(
            shot.fx,
            "some",
            function(____, e) return e.tipo == "entrada" end
        )) else __O[768]) then
            c.fillStyle = ("rgba(13,29,24," .. tostring((1 - s.time / 0.25) * 0.6)) .. ")"
            c:fillRect(0, 24, W, H - 44)
        end
        if __t(if __t(sc.balao) then b.text else sc.balao) then
            do
                pcall(function()
                    balao(
                        nil,
                        c,
                        s,
                        sc,
                        shot,
                        b,
                        t
                    )
                end)
            end
        end
        c:restore()
        if not __t(s.preview) then
            syncOverlay(nil, s, b)
        end
    end
    local function anchor(self, s)
        local sc = __get(scripts, s.kind)
        local b = beatOf(nil, s)
        local shot = __get(sc.shots, b.shot)
        local t = s.shotTime
        local cam = camAt(nil, shot, t)
        local a = __call(
            shot.actors,
            "find",
            function(____, x)
                local ____t_172 = __t
                local ____temp_171 = x.type == b.who
                __O[769] = ____temp_171
                return if ____t_172(____temp_171) then __O[769] else x.type == "carro" and b.who == "daroca"
            end
        )
        if not __t(a) then
            return {
                x = 480,
                y = 52,
                width = 520,
                speakerX = 480,
                speakerY = 300,
                tail = "left"
            }
        end
        local p = actorAt(nil, a, t, true)
        local camX = math.floor(cam.x - W / 2 + 0.5)
        local z = cam.zoom
        local fy = clamp(nil, cam.y, 0, H)
        local sx = (W - W / z) / 2
        local sy = fy - fy / z
        sx = clamp(
            nil,
            sx,
            math.min(0, W - W / z),
            math.max(0, W - W / z)
        )
        sy = clamp(
            nil,
            sy,
            math.min(0, H - H / z),
            math.max(0, H - H / z)
        )
        local headY = p.y - if a.type == "carro" then 90 else 70 * a.scale
        local x = clamp(nil, (p.x - camX - sx) * z, 60, W - 60)
        local y = clamp(nil, (headY - sy) * z, 120, 470)
        local left = x < W / 2
        return {
            x = if __t(left) then clamp(nil, x + 150, 290, 600) else clamp(nil, x - 150, 360, 670),
            y = 52,
            width = 500,
            speakerX = x,
            speakerY = y,
            tail = if __t(left) then "left" else "right"
        }
    end
    local CORES_NOME = __ord({
        daroca = "#b8862a",
        reeis = "#2f7a46",
        jorge = "#6a4a98",
        jorge_gordo = "#6a4a98",
        jorge_celular = "#6a4a98",
        miguel = "#2c6ab8",
        fred_conquista = "#b8902a",
        narrador = "#5a4a3a"
    }, "daroca,reeis,jorge,jorge_gordo,jorge_celular,miguel,fred_conquista,narrador")
    corNome = function(____, who)
        local ____t_176 = __t
        local ____t_174 = __t
        local ____get_result_173 = __get(CORES_NOME, who)
        __O[770] = ____get_result_173
        local ____temp_175 = if ____t_174(____get_result_173) then __O[770] else __get(
            CORES_NOME,
            __re_replace(
                tostring(who),
                __re("^(crianca|pre)_", ""),
                ""
            )
        )
        __O[771] = ____temp_175
        return if ____t_176(____temp_175) then __O[771] else __get(
            __arrL({
                "#a8443a",
                "#3c6a8a",
                "#7a4a8a",
                "#3c7a5a",
                "#a8642a",
                "#5a5aa8"
            }, 6),
            math.floor(hash(
                nil,
                __len(tostring(who)) * 7.3 + __call(
                    tostring(who),
                    "charCodeAt",
                    0
                )
            ) * 6)
        )
    end
    rcCanvas = nil
    rcKey = ""
    portraitCv = nil
    lastSync = ""
    clearer = nil
    local function seen(____, q)
        local ____t_208 = __t
        local ____t_206 = __t
        local ____temp_205 = if __t(q) then type(q.roteiros) == "table" else q
        __O[779] = ____temp_205
        local ____temp_207 = if ____t_206(____temp_205) then q.roteiros else __O[779]
        __O[780] = ____temp_207
        return if ____t_208(____temp_207) then __O[780] else {}
    end
    local function allowed(____, s, q)
        return if __t(s) then not __t(s.once) or not __t(__get(
            seen(nil, q),
            s.id
        )) else s
    end
    local function find(____, fn, q)
        local ____t_213 = __t
        local ____opt_209 = __call(
            __values(scripts),
            "find",
            function(____, s)
                local ____t_212 = __t
                local ____fn_result_211 = fn(nil, s)
                __O[781] = ____fn_result_211
                return if ____t_212(____fn_result_211) then allowed(nil, s, q) else __O[781]
            end
        )
        if ____opt_209 ~= nil then
            ____opt_209 = ____opt_209.id
        end
        __O[782] = ____opt_209
        return if ____t_213(____opt_209) then __O[782] else nil
    end
    local api = __ord(
        {
            ready = function() return ready end,
            list = function() return __keys(scripts) end,
            has = has,
            get = function(____, id)
                local ____t_215 = __t
                local ____get_result_214 = __get(scripts, id)
                __O[783] = ____get_result_214
                return if ____t_215(____get_result_214) then __O[783] else nil
            end,
            errors = function() return __call(errors, "slice") end,
            antes = function(____, kind, q) return find(
                nil,
                function(____, s) return s.before == kind end,
                q
            ) end,
            depois = function(____, kind, q) return find(
                nil,
                function(____, s) return s.after == kind end,
                q
            ) end,
            chegada = function(____, scene, q) return find(
                nil,
                function(____, s) return s.arrival == __TS__Number(scene) end,
                q
            ) end,
            visto = function(____, id, q)
                if __t(not __t(q) or not __t(__get(scripts, id))) then
                    return
                end
                if __t(not __t(q.roteiros) or type(q.roteiros) ~= "table") then
                    q.roteiros = {}
                end
                __set(q.roteiros, id, 1)
            end,
            musicFor = function(____, id)
                local ____t_218 = __t
                local ____opt_216 = __get(scripts, id)
                if ____opt_216 ~= nil then
                    ____opt_216 = ____opt_216.music
                end
                __O[784] = ____opt_216
                return if ____t_218(____opt_216) then __O[784] else __arrL({}, 0)
            end,
            create = create,
            update = update,
            advance = advance,
            beat = beat,
            draw = draw,
            timeline = timeline,
            stateAt = stateAt,
            timelinePosition = function(____, s)
                local ____t_221 = __t
                local ____opt_219 = __get(scripts, s.kind)
                if ____opt_219 ~= nil then
                    ____opt_219 = ____opt_219.duration
                end
                __O[785] = ____opt_219
                return if __t(s) then if __t(s.done) then if ____t_221(____opt_219) then __O[785] else 0 else s.elapsed else 0
            end,
            sfx = sfx,
            load = load,
            register = register,
            portrait = drawPortrait,
            estender = estender,
            cabeca = headBox
        },
        "ready,list,has,get,errors,antes,depois,chegada,visto,musicFor,create,update,advance,beat,draw,timeline,stateAt,timelinePosition,sfx,load,register,portrait,estender,cabeca"
    )
    ajuda = __ord({
        portrait = drawPortrait,
        head = headBox,
        sfx = sfx,
        hash = hash,
        ease = ease,
        clamp = clamp,
        lerp = lerp
    }, "portrait,head,sfx,hash,ease,clamp,lerp")
    local function wrap(self)
        local C = window.Cinematics
        local ____t_224 = __t
        local ____t_223 = __t
        local ____temp_222 = not __t(C)
        __O[786] = ____temp_222
        if ____t_224(if ____t_223(____temp_222) then __O[786] else C.__roteiro) then
            return
        end
        local o = __assign({}, C)
        local function mine(____, s)
            local ____t_226 = __t
            local ____temp_225 = if __t(s) then s.roteiro else s
            __O[787] = ____temp_225
            return if ____t_226(____temp_225) then __get(scripts, s.kind) else __O[787]
        end
        C.create = function(____, kind, opt) return if __t(has(nil, kind)) then create(nil, kind, opt) else o:create(kind, opt) end
        C.update = function(____, s, dt) return if __t(mine(nil, s)) then update(nil, s, dt) else o:update(s, dt) end
        C.advance = function(____, s) return if __t(mine(nil, s)) then advance(nil, s) else o:advance(s) end
        C.beat = function(____, s) return if __t(mine(nil, s)) then beat(nil, s) else o:beat(s) end
        C.draw = function(____, c, s) return if __t(mine(nil, s)) then draw(nil, c, s) else o:draw(c, s) end
        C.anchor = function(____, s) return if __t(mine(nil, s)) then anchor(nil, s) else o:anchor(s) end
        C.timeline = function(____, k)
            local ____t_229 = __t
            local ____t_228 = __t
            local ____temp_227 = type(k) == "string"
            __O[788] = ____temp_227
            local ____t_232 = __t
            local ____t_231 = __t
            local ____temp_230 = if __t(k) then type(k) == "table" else k
            __O[789] = ____temp_230
            return if ____t_229(if ____t_228(____temp_227) then has(nil, k) else __O[788]) then timeline(nil, k) else if ____t_232(if ____t_231(____temp_230) then mine(nil, k) else __O[789]) then api:timelinePosition(k) else o:timeline(k)
        end
        C.timelinePosition = function(____, s) return if __t(mine(nil, s)) then api:timelinePosition(s) else o:timelinePosition(s) end
        C.stateAt = function(____, k, sec, opt) return if __t(has(nil, k)) then stateAt(nil, k, sec, opt) else o:stateAt(k, sec, opt) end
        C.__roteiro = true
    end
    wrap(nil)
    local function preview(self, id)
        local key
        local sc = __get(scripts, id)
        if not __t(sc) then
            local ____window_237 = window
            local ____window_alert_238 = window.alert
            local ____add_236 = __add
            local ____add_result_235 = __add(
                __add("Roteiro \"", id),
                "\" não encontrado.\n"
            )
            local ____t_234 = __t
            local ____call_result_233 = __call(errors, "join", "\n")
            __O[790] = ____call_result_233
            ____window_alert_238(
                ____window_237,
                ____add_236(____add_result_235, if ____t_234(____call_result_233) then __O[790] else "Confira o id e a lista.json.")
            )
            return
        end
        local cv = window.document:createElement("canvas")
        cv.width = W
        cv.height = H
        cv.style.cssText = "position:fixed;inset:0;margin:auto;width:min(100vw,177.8vh);height:min(56.25vw,100vh);z-index:99999;background:#000;image-rendering:pixelated"
        window.document.body:appendChild(cv)
        local c = cv:getContext("2d")
        local pc = window.document:createElement("canvas")
        pc.height = 64
        pc.width = 64
        local s = create(nil, id, {})
        s.preview = true
        local last = window.performance:now()
        local stop = false
        local function close()
            stop = true
            cv:remove()
            release(nil)
            window:removeEventListener("keydown", key)
        end
        local function step()
            if __t(s.done) then
                s = create(nil, id, {})
                s.preview = true
            else
                advance(nil, s)
            end
        end
        key = function(____, e)
            if e.key == "Escape" then
                close(nil)
            elseif __t(__call(
                __arrL({
                    " ",
                    "Enter",
                    "e",
                    "E",
                    "ArrowRight"
                }, 5),
                "includes",
                e.key
            )) then
                e:preventDefault()
                step(nil)
            end
        end
        window:addEventListener("keydown", key)
        cv:addEventListener("click", step)
        local loop
        loop = function(____, now)
            if __t(stop) then
                return
            end
            local dt = math.min(0.1, (now - last) / 1000)
            last = now
            if not __t(s.done) then
                update(nil, s, dt)
            end
            if not __t(s.done) then
                draw(nil, c, s)
                local b = beatOf(nil, s)
                if __t(if __t(b.text) then not __t(sc.balao) else b.text) then
                    local x0 = if __t(b.portrait) then 120 else 40
                    c.fillStyle = "rgba(16,30,24,.92)"
                    c:fillRect(30, 388, 900, 120)
                    c.fillStyle = "#bacf82"
                    c:fillRect(30, 388, 900, 3)
                    if __t(b.portrait) then
                        drawPortrait(
                            nil,
                            pc:getContext("2d"),
                            b.who,
                            64,
                            s.shotTime,
                            b.emotion
                        )
                        c.imageSmoothingEnabled = false
                        c:drawImage(
                            pc,
                            44,
                            404,
                            64,
                            64
                        )
                    end
                    c.textAlign = "left"
                    c.textBaseline = "top"
                    c.font = "12px Pixel, monospace"
                    c.fillStyle = "#d7e7a0"
                    c:fillText(b.speaker, x0, 402)
                    c.font = "16px Arial, sans-serif"
                    c.fillStyle = "#eff0d9"
                    local words = __call(
                        __call(
                            b.text,
                            "slice",
                            0,
                            math.floor(s.typed)
                        ),
                        "split",
                        " "
                    )
                    local line = ""
                    local y = 428
                    for ____, w2 in __iterar((words)) do
                        if c:measureText(__add(line, w2)).width > 780 - x0 then
                            c:fillText(line, x0, y)
                            line = ""
                            y = y + 22
                        end
                        line = __add(
                            line,
                            __add(w2, " ")
                        )
                    end
                    c:fillText(line, x0, y)
                end
                c.textAlign = "right"
                c.font = "10px Pixel, monospace"
                c.fillStyle = "#ffffffaa"
                c:fillText(
                    ((((tostring(sc.title) .. " · ") .. tostring(s.index + 1)) .. "/") .. tostring(__len(sc.beats))) .. " · clique ou Enter avança · Esc fecha",
                    950,
                    6
                )
            else
                c.fillStyle = "#000"
                c:fillRect(0, 0, W, H)
                c.fillStyle = "#fff"
                c.textAlign = "center"
                c.font = "14px Pixel, monospace"
                c:fillText("FIM · clique para ver de novo · Esc fecha", W / 2, H / 2)
            end
            window:requestAnimationFrame(loop)
        end
        window:requestAnimationFrame(loop)
    end
    window.Roteiro = __assign({}, api, {preview = preview})
    local ____self_239 = load(nil)
    ____self_239["then"](
        ____self_239,
        function()
            do
                pcall(function()
                    local id = __call(
                        __new("URLSearchParams", window.location.search),
                        "get",
                        "roteiro"
                    )
                    if __t(id) then
                        preview(nil, id)
                    end
                end)
            end
        end
    )
end)(nil)
return ____exports
