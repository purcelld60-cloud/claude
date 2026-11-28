--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
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
                                do y = y + 1 continue end
                            end
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
                    local x = __t(__mod(y / 4, 2)) and 2 or 0
                    while __lt(x, size) do
                        c:fillRect(x, y, 2, 2)
                        x = x + 4
                    end
                end
                y = y + 4
            end
        end
        local ____t_184 = __t
        local ____t_result_183
        local ____t_182 = __t
        local ____t_result_181
        local ____t_180 = __t
        local ____opt_178 = window.Art
        if ____opt_178 ~= nil then
            ____opt_178 = ____opt_178.drawCharacter
        end
        __O[755] = ____opt_178
        if ____t_180(____opt_178) then
            ____t_result_181 = ____type
        else
            ____t_result_181 = __O[755]
        end
        __O[756] = ____t_result_181
        if ____t_182(____t_result_181) then
            ____t_result_183 = ____type ~= "narrador"
        else
            ____t_result_183 = __O[756]
        end
        if ____t_184(____t_result_183) then
            local b = headBox(nil, ____type)
            local S = size / 40
            local tall = 220 - b.top > 110
            window.Art:drawCharacter(
                c,
                ____type,
                math.floor(size / 2 - (b.cx - 100) * S + 0.5),
                math.floor(size * (__t(tall) and 0.02 or 0.06) + (220 - b.top) * S + 0.5),
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
                    local ____opt_217 = window.DayTime
                    if ____opt_217 ~= nil then
                        ____opt_217 = ____opt_217.force
                    end
                    if ____opt_217 ~= nil then
                        ____opt_217(____opt_217, nil)
                    end
                end)
            end
        end
    end
    function camAt(self, shot, t)
        local ____temp_221
        if shot.camCurve == "linear" then
            ____temp_221 = clamp(nil, t / shot.camTime, 0, 1)
        else
            ____temp_221 = ease(nil, t / shot.camTime)
        end
        local k = ____temp_221
        return {
            x = lerp(nil, shot.camFrom.x, shot.camTo.x, k),
            y = lerp(nil, shot.camFrom.y, shot.camTo.y, k),
            zoom = lerp(nil, shot.camFrom.zoom, shot.camTo.zoom, k)
        }
    end
    function actorAt(self, a, t, speaking)
        local k = a.to == nil and 0 or (t - a.t0) / (a.t1 - a.t0)
        local ____t_result_224
        local ____t_223 = __t
        local ____temp_222 = a.to ~= nil and k > 0
        __O[764] = ____temp_222
        if ____t_223(____temp_222) then
            ____t_result_224 = k < 1
        else
            ____t_result_224 = __O[764]
        end
        local moving = ____t_result_224
        local ____temp_225
        if a.to == nil then
            ____temp_225 = a.x
        else
            ____temp_225 = lerp(
                nil,
                a.x,
                a.to,
                clamp(nil, k, 0, 1)
            )
        end
        local x = ____temp_225
        local ____a_y_229 = a.y
        local ____t_result_228
        local ____t_227 = __t
        local ____t_result_226
        if __t(moving) then
            ____t_result_226 = a.jump
        else
            ____t_result_226 = moving
        end
        if ____t_227(____t_result_226) then
            ____t_result_228 = math.sin(clamp(nil, k, 0, 1) * math.pi) * a.jump
        else
            ____t_result_228 = 0
        end
        local y = ____a_y_229 - ____t_result_228
        local ____assign_236 = __assign
        local ____temp_235 = {}
        local ____a_facing_230 = a.facing
        if ____a_facing_230 == nil then
            ____a_facing_230 = __t(a.to ~= nil and __lt(a.to, a.x)) and -1 or 1
        end
        local ____t_233 = t
        local ____a_scale_234 = a.scale
        local ____t_232 = __t
        local ____t_result_231
        if __t(moving) then
            ____t_result_231 = a.jump
        else
            ____t_result_231 = moving
        end
        local o = ____assign_236(
            ____temp_235,
            {
                facing = ____a_facing_230,
                frame = ____t_233,
                scale = ____a_scale_234,
                grounded = not ____t_232(____t_result_231),
                moving = moving,
                emotion = a.emotion
            },
            a.opts
        )
        local anims = __call(a.anim, "split", "+")
        local ____assign_242 = __assign
        local ____temp_240 = {}
        local ____a_241 = a
        local ____t_result_239
        local ____t_238 = __t
        local ____call_result_237 = __call(
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
        __O[765] = ____call_result_237
        if ____t_238(____call_result_237) then
            ____t_result_239 = __O[765]
        else
            ____t_result_239 = ""
        end
        a = ____assign_242(____temp_240, ____a_241, {anim = ____t_result_239})
        if a.anim == "pulando" then
            y = y - math.abs(math.sin(t * 5)) * 18
            o.grounded = false
            o.vy = math.cos(t * 5) > 0 and -100 or 100
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
        local ____t_246 = __t
        local ____t_result_245
        local ____t_244 = __t
        local ____call_result_243 = __call(anims, "includes", "tremendo")
        __O[766] = ____call_result_243
        if ____t_244(____call_result_243) then
            ____t_result_245 = a.anim ~= "tremendo"
        else
            ____t_result_245 = __O[766]
        end
        if ____t_246(____t_result_245) then
            o.hit = math.sin(t * 40) > 0
        end
        local ____t_250 = __t
        local ____t_result_249
        local ____t_248 = __t
        local ____t_result_247
        if __t(speaking) then
            ____t_result_247 = not __t(o.moving)
        else
            ____t_result_247 = speaking
        end
        __O[767] = ____t_result_247
        if ____t_248(____t_result_247) then
            ____t_result_249 = o.grounded ~= false
        else
            ____t_result_249 = __O[767]
        end
        if ____t_250(____t_result_249) then
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
        local ____t_result_334
        local ____t_333 = __t
        local ____get_result_332 = __get(alias, b.who)
        __O[777] = ____get_result_332
        if ____t_333(____get_result_332) then
            ____t_result_334 = __O[777]
        else
            ____t_result_334 = __arrL({b.who}, 1)
        end
        local nomes = ____t_result_334
        local ____t_result_337
        local ____t_336 = __t
        local ____call_result_335 = __call(
            shot.actors,
            "find",
            function(____, x) return __call(nomes, "includes", x.type) end
        )
        __O[778] = ____call_result_335
        if ____t_336(____call_result_335) then
            ____t_result_337 = __O[778]
        else
            ____t_result_337 = __call(
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
        end
        local a = ____t_result_337
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
        local ____temp_339 = 220 - hb.top
        local ____t_result_338
        if __t(a.scale) then
            ____t_result_338 = a.scale
        else
            ____t_result_338 = 1
        end
        local alto = ____temp_339 * ____t_result_338
        local hx = p.x
        local hy = p.y - alto
        local by = p.y - alto * 0.72
        local ____iter_344 = __iter
        local ____call_343 = __call
        local ____t_result_342
        if __t(a.anim) then
            ____t_result_342 = a.anim
        else
            ____t_result_342 = ""
        end
        for ____, nome in __TS__Iterator(____iter_344(____call_343(
            tostring(____t_result_342),
            "split",
            "+"
        ))) do
            local ____opt_340 = __get(EXT.anims, nome)
            if ____opt_340 ~= nil then
                ____opt_340 = ____opt_340.cabeca
            end
            local f = ____opt_340
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
        local ____x_348 = x
        local ____cabeca_349 = cabeca
        local ____boca_350 = boca
        local ____t_result_347
        local ____t_346 = __t
        local ____temp_345 = x < -20 or x > W + 20
        __O[779] = ____temp_345
        if ____t_346(____temp_345) then
            ____t_result_347 = __O[779]
        else
            ____t_result_347 = cabeca > H
        end
        return {x = ____x_348, cabeca = ____cabeca_349, boca = ____boca_350, fora = ____t_result_347}
    end
    function linhas(self, c, txt, max)
        local out = __arrL({}, 0)
        local l = ""
        for ____, w2 in __iterar((__call(txt, "split", " "))) do
            local ____t_result_351
            if __t(l) then
                ____t_result_351 = __add(
                    __add(l, " "),
                    w2
                )
            else
                ____t_result_351 = w2
            end
            local tst = ____t_result_351
            local ____t_355 = __t
            local ____t_result_354
            local ____t_353 = __t
            local ____gt_result_352 = __gt(
                c:measureText(tst).width,
                max
            )
            __O[780] = ____gt_result_352
            if ____t_353(____gt_result_352) then
                ____t_result_354 = l
            else
                ____t_result_354 = __O[780]
            end
            if ____t_355(____t_result_354) then
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
        local ____t_result_358
        local ____t_357 = __t
        local ____temp_356 = __gt(
            __len(letras),
            3
        ) and letras == __call(letras, "toUpperCase")
        __O[781] = ____temp_356
        if ____t_357(____temp_356) then
            ____t_result_358 = __O[781]
        else
            ____t_result_358 = __re_test(
                __re("!!|\\?!|!\\?", ""),
                cheio
            )
        end
        local grito = ____t_result_358
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
        local tam = __t(grito) and 18 or 16
        c.font = ((__t(grito) and "bold " or "") .. tostring(tam)) .. "px Space, Arial, sans-serif"
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
            local ____t_360 = __t
            local ____t_result_359
            if __t(b.speaker) then
                ____t_result_359 = b.speaker ~= "Narrador"
            else
                ____t_result_359 = b.speaker
            end
            if ____t_360(____t_result_359) then
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
                function(____, l, i)
                    local ____c_366 = c
                    local ____c_fillText_367 = c.fillText
                    local ____l_364 = l
                    local ____temp_365 = bx + 18
                    local ____temp_363 = by + 13
                    local ____t_362 = __t
                    local ____t_result_361
                    if __t(b.speaker) then
                        ____t_result_361 = b.speaker ~= "Narrador"
                    else
                        ____t_result_361 = b.speaker
                    end
                    return ____c_fillText_367(
                        ____c_366,
                        ____l_364,
                        ____temp_365,
                        ____temp_363 + (____t_362(____t_result_361) and 8 or 0) + i * 22
                    )
                end
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
        local max = __t(grito) and 330 or 300
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
        local ____t_369 = __t
        local ____t_result_368
        if __t(pos) then
            ____t_result_368 = not __t(pos.fora)
        else
            ____t_result_368 = pos
        end
        if ____t_369(____t_result_368) then
            tx = clamp(nil, pos.x, 10, W - 10)
            ty = clamp(nil, pos.boca, 40, H - 30)
            bx = clamp(nil, pos.x - bw / 2 + (pos.x < W / 2 and 40 or -40), 14, W - bw - 14)
            by = math.floor(pos.cabeca - 30 - bh + 0.5)
            if by < 30 then
                by = clamp(
                    nil,
                    math.floor(pos.boca - bh / 2 + 0.5),
                    30,
                    H - 26 - bh
                )
                lado = pos.x < W / 2 and "esq" or "dir"
                local ____temp_370
                if lado == "esq" then
                    ____temp_370 = math.min(
                        W - bw - 14,
                        math.floor(pos.x + 46 + 0.5)
                    )
                else
                    ____temp_370 = math.max(
                        14,
                        math.floor(pos.x - 46 - bw + 0.5)
                    )
                end
                bx = ____temp_370
            end
        else
            bx = math.floor(W / 2 - bw / 2 + 30 + 0.5)
            by = H - 40 - bh
            lado = "nenhum"
        end
        local ____t_result_371
        if __t(grito) then
            ____t_result_371 = math.floor(math.sin(t * 50) * 1.5 + 0.5)
        else
            ____t_result_371 = 0
        end
        local tre = ____t_result_371
        bx = bx + tre
        local borda = __t(grito) and "#8a1a1a" or "#2a1a10"
        local fundo = __t(pensa) and "#f6f6fa" or "#fff6dc"
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
                local ____temp_373
                if lado == "baixo" then
                    ____temp_373 = __arrL(
                        {
                            __arrL({ax - 12, by + bh - 2}, 2),
                            __arrL({ax + 12, by + bh - 2}, 2)
                        },
                        2
                    )
                else
                    local ____temp_372
                    if lado == "esq" then
                        ____temp_372 = __arrL(
                            {
                                __arrL({bx + 2, by + bh / 2 - 12}, 2),
                                __arrL({bx + 2, by + bh / 2 + 12}, 2)
                            },
                            2
                        )
                    else
                        ____temp_372 = __arrL(
                            {
                                __arrL({bx + bw - 2, by + bh / 2 - 12}, 2),
                                __arrL({bx + bw - 2, by + bh / 2 + 12}, 2)
                            },
                            2
                        )
                    end
                    ____temp_373 = ____temp_372
                end
                local base = ____temp_373
                local pt = __arrL({tx + (lado == "esq" and 10 or (lado == "dir" and -10 or 0)), ty - (lado == "baixo" and 14 or 0)}, 2)
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
        local ____call_375 = __call
        local ____t_result_374
        if __t(b.speaker) then
            ____t_result_374 = b.speaker
        else
            ____t_result_374 = ""
        end
        local nome = ____call_375(
            tostring(____t_result_374),
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
        local ____t_379 = __t
        local ____t_result_378
        local ____t_377 = __t
        local ____temp_376 = lado == "nenhum"
        __O[782] = ____temp_376
        if ____t_377(____temp_376) then
            ____t_result_378 = b.portrait
        else
            ____t_result_378 = __O[782]
        end
        if ____t_379(____t_result_378) then
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
        c.font = ((__t(grito) and "bold " or "") .. tostring(tam)) .. "px Space, Arial, sans-serif"
        c.fillStyle = __t(grito) and "#7a1010" or (__t(pensa) and "#4a4a6a" or "#4a2e1a")
        c.textBaseline = "top"
        __call(
            linhas(nil, c, texto, max),
            "forEach",
            function(____, l, i) return c:fillText(l, bx + 16, by + 14 + i * (tam + 6)) end
        )
        local ____t_383 = __t
        local ____t_result_382
        local ____t_381 = __t
        local ____ge_result_380 = __ge(
            n,
            __len(cheio)
        )
        __O[783] = ____ge_result_380
        if ____t_381(____ge_result_380) then
            ____t_result_382 = __mod(
                math.floor(t * 2.5),
                2
            )
        else
            ____t_result_382 = __O[783]
        end
        if ____t_383(____t_result_382) then
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
            local ____rcCanvas_384 = rcCanvas
            rcCanvas.height = 64
            ____rcCanvas_384.width = 64
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
        local ____self_388 = overlay.classList
        local ____self_388_toggle_389 = ____self_388.toggle
        local ____t_387 = __t
        local ____opt_385 = __get(scripts, s.kind)
        if ____opt_385 ~= nil then
            ____opt_385 = ____opt_385.balao
        end
        ____self_388_toggle_389(
            ____self_388,
            "roteiro-balao",
            not not ____t_387(____opt_385)
        )
        local ____self_392 = overlay.classList
        local ____self_392_toggle_393 = ____self_392.toggle
        local ____t_391 = __t
        local ____t_result_390
        if __t(b.text) then
            ____t_result_390 = b.portrait
        else
            ____t_result_390 = b.text
        end
        ____self_392_toggle_393(
            ____self_392,
            "roteiro-com-retrato",
            not not ____t_391(____t_result_390)
        )
        local ____t_395 = __t
        local ____t_result_394
        if __t(b.text) then
            ____t_result_394 = b.portrait
        else
            ____t_result_394 = b.text
        end
        if ____t_395(____t_result_394) then
            if not __t(portraitCv) then
                portraitCv = window.document:createElement("canvas")
                portraitCv.width = 64
                portraitCv.height = 64
                portraitCv.className = "roteiro-retrato"
                portraitCv:setAttribute("aria-hidden", "true")
            end
            local cap = overlay:querySelector(".cinematic-caption")
            local ____t_397 = __t
            local ____t_result_396
            if __t(cap) then
                ____t_result_396 = portraitCv.parentNode ~= cap
            else
                ____t_result_396 = cap
            end
            if ____t_397(____t_result_396) then
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
        local ____t_399 = __t
        local ____t_result_398
        if __t(p) then
            ____t_result_398 = b.text
        else
            ____t_result_398 = p
        end
        if ____t_399(____t_result_398) then
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
            local ____t_4 = __t
            local ____t_result_3
            local ____t_2 = __t
            local ____get_result_1 = __get(o, k)
            __O[740] = ____get_result_1
            if ____t_2(____get_result_1) then
                ____t_result_3 = type(__get(o, k)) == "table"
            else
                ____t_result_3 = __O[740]
            end
            if ____t_4(____t_result_3) then
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
        local ____t_result_27
        local ____t_6 = __t
        local ____temp_5 = __isInteger(n) and __ge(n, 0)
        __O[744] = ____temp_5
        if ____t_6(____temp_5) then
            local ____t_result_26
            local ____t_8 = __t
            local ____le_result_7 = __le(n, 11)
            __O[743] = ____le_result_7
            if ____t_8(____le_result_7) then
                ____t_result_26 = __O[743]
            else
                local ____t_result_25
                local ____t_10 = __t
                local ____le_result_9 = __le(n, 99)
                __O[742] = ____le_result_9
                if ____t_10(____le_result_9) then
                    local ____t_result_24
                    local ____t_18 = __t
                    local ____gt_16 = __gt
                    local ____opt_13 = window.CampanhaCenarios
                    if ____opt_13 ~= nil then
                        ____opt_13 = ____opt_13.largura
                    end
                    local ____opt_result_15
                    if ____opt_13 ~= nil then
                        ____opt_result_15 = ____opt_13(____opt_13, n)
                    end
                    local ____gt_16_result_17 = ____gt_16(____opt_result_15, 0)
                    __O[741] = ____gt_16_result_17
                    if ____t_18(____gt_16_result_17) then
                        ____t_result_24 = __O[741]
                    else
                        local ____opt_21 = window.CampanhaCenarios
                        if ____opt_21 ~= nil then
                            ____opt_21 = ____opt_21.layout
                        end
                        local ____opt_result_23
                        if ____opt_21 ~= nil then
                            ____opt_result_23 = ____opt_21(____opt_21, n)
                        end
                        ____t_result_24 = ____opt_result_23
                    end
                    ____t_result_25 = ____t_result_24
                else
                    ____t_result_25 = __O[742]
                end
                ____t_result_26 = ____t_result_25
            end
            ____t_result_27 = ____t_result_26
        else
            ____t_result_27 = __O[744]
        end
        return ____t_result_27
    end
    local function bgName(____, bg)
        local ____t_result_32
        local ____t_29 = __t
        local ____t_result_28
        if __t(bg) then
            ____t_result_28 = type(bg) == "table"
        else
            ____t_result_28 = bg
        end
        if ____t_29(____t_result_28) then
            local ____t_result_30
            if __t(bg.nome) then
                ____t_result_30 = bg.nome
            else
                ____t_result_30 = ""
            end
            ____t_result_32 = tostring(____t_result_30)
        else
            local ____t_result_31
            if __t(bg) then
                ____t_result_31 = tostring(bg)
            else
                ____t_result_31 = ""
            end
            ____t_result_32 = ____t_result_31
        end
        return ____t_result_32
    end
    scripts = __objCreate(nil)
    local ready = false
    local function num(____, v, d)
        local ____t_result_37
        local ____t_36 = __t
        local ____t_result_35
        local ____t_34 = __t
        local ____temp_33 = __isFiniteN(__TS__Number(v)) and v ~= nil
        __O[745] = ____temp_33
        if ____t_34(____temp_33) then
            ____t_result_35 = v ~= ""
        else
            ____t_result_35 = __O[745]
        end
        if ____t_36(____t_result_35) then
            ____t_result_37 = __TS__Number(v)
        else
            ____t_result_37 = d
        end
        return ____t_result_37
    end
    local function camPoint(self, p, prev)
        local ____t_result_38
        if __t(p) then
            ____t_result_38 = p
        else
            ____t_result_38 = {}
        end
        p = ____t_result_38
        local ____p_x_43 = p.x
        local ____opt_result_41
        if prev ~= nil then
            ____opt_result_41 = prev.x
        end
        local ____opt_result_41_42 = ____opt_result_41
        if ____opt_result_41_42 == nil then
            ____opt_result_41_42 = 480
        end
        local ____num_result_54 = num(nil, ____p_x_43, ____opt_result_41_42)
        local ____p_y_48 = p.y
        local ____opt_result_46
        if prev ~= nil then
            ____opt_result_46 = prev.y
        end
        local ____opt_result_46_47 = ____opt_result_46
        if ____opt_result_46_47 == nil then
            ____opt_result_46_47 = 380
        end
        local ____num_result_55 = num(nil, ____p_y_48, ____opt_result_46_47)
        local ____p_zoom_53 = p.zoom
        local ____opt_result_51
        if prev ~= nil then
            ____opt_result_51 = prev.zoom
        end
        local ____opt_result_51_52 = ____opt_result_51
        if ____opt_result_51_52 == nil then
            ____opt_result_51_52 = 1
        end
        return {
            x = ____num_result_54,
            y = ____num_result_55,
            zoom = clamp(
                nil,
                num(nil, ____p_zoom_53, ____opt_result_51_52),
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
        local ____call_57 = __call
        local ____t_result_56
        if __t(raw.id) then
            ____t_result_56 = raw.id
        else
            ____t_result_56 = ""
        end
        local id = ____call_57(
            tostring(____t_result_56),
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
                local ____c_cenario_60 = c.cenario
                if ____c_cenario_60 == nil then
                    local ____opt_58 = __get(shots, i - 1)
                    if ____opt_58 ~= nil then
                        ____opt_58 = ____opt_58.scene
                    end
                    ____c_cenario_60 = ____opt_58
                end
                local ____c_cenario_60_61 = ____c_cenario_60
                if ____c_cenario_60_61 == nil then
                    ____c_cenario_60_61 = 0
                end
                local scene = ____c_cenario_60_61
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
                    local ____get_result_62 = __get(SCENES, key)
                    if ____get_result_62 == nil then
                        ____get_result_62 = __get(EXT.cenarios, key)
                    end
                    local ____get_result_62_63 = ____get_result_62
                    if ____get_result_62_63 == nil then
                        ____get_result_62_63 = __TS__Number(scene)
                    end
                    scene = ____get_result_62_63
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
                local ____t_65 = __t
                local ____t_result_64
                if __t(pintado) then
                    ____t_result_64 = not __t(sceneOk(nil, scene))
                else
                    ____t_result_64 = pintado
                end
                if ____t_65(____t_result_64) then
                    scene = 0
                end
                local ____t_result_66
                if __t(c.camera) then
                    ____t_result_66 = c.camera
                else
                    ____t_result_66 = {}
                end
                local cam = ____t_result_66
                local ____camPoint_70 = camPoint
                local ____t_result_67
                if __t(cam.de) then
                    ____t_result_67 = cam.de
                else
                    ____t_result_67 = cam
                end
                local ____opt_68 = __get(shots, i - 1)
                if ____opt_68 ~= nil then
                    ____opt_68 = ____opt_68.camTo
                end
                local from = ____camPoint_70(nil, ____t_result_67, ____opt_68)
                local ____camPoint_74 = camPoint
                local ____t_result_73
                local ____t_72 = __t
                local ____t_result_71
                if __t(cam.para) then
                    ____t_result_71 = cam.para
                else
                    ____t_result_71 = cam.de
                end
                __O[746] = ____t_result_71
                if ____t_72(____t_result_71) then
                    ____t_result_73 = __O[746]
                else
                    ____t_result_73 = cam
                end
                local to = ____camPoint_74(nil, ____t_result_73, from)
                local ____call_98 = __call
                local ____isArray_result_75
                if __isArray(c.atores) then
                    ____isArray_result_75 = c.atores
                else
                    ____isArray_result_75 = __arrL({}, 0)
                end
                local actors = ____call_98(
                    ____isArray_result_75,
                    "map",
                    function(____, a, k)
                        local ____t_result_78
                        local ____t_77 = __t
                        local ____t_result_76
                        if __t(a.quem) then
                            ____t_result_76 = a.quem
                        else
                            ____t_result_76 = a.tipo
                        end
                        __O[747] = ____t_result_76
                        if ____t_77(____t_result_76) then
                            ____t_result_78 = __O[747]
                        else
                            ____t_result_78 = ""
                        end
                        local ____type = tostring(____t_result_78)
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
                        local ____isArray_result_79
                        if __isArray(a.tempo) then
                            ____isArray_result_79 = a.tempo
                        else
                            ____isArray_result_79 = __arrL({0, 2.5}, 2)
                        end
                        local t = ____isArray_result_79
                        local ____type_87 = ____type
                        local ____num_result_88 = num(nil, a.x, 480)
                        local ____num_result_89 = num(nil, a.y, FLOOR)
                        local ____temp_80
                        if a.ate ~= nil then
                            ____temp_80 = num(nil, a.ate, nil)
                        else
                            ____temp_80 = nil
                        end
                        local ____num_result_90 = num(
                            nil,
                            __get(t, 0),
                            0
                        )
                        local ____math_max_result_91 = math.max(
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
                        )
                        local ____temp_81
                        if a.olhando == nil then
                            ____temp_81 = nil
                        else
                            ____temp_81 = __t(__TS__Number(a.olhando) < 0 or a.olhando == "esquerda") and -1 or 1
                        end
                        local ____clamp_result_92 = clamp(
                            nil,
                            num(nil, a.escala, 1),
                            0.2,
                            6
                        )
                        local ____t_result_82
                        if __t(a.emocao) then
                            ____t_result_82 = a.emocao
                        else
                            ____t_result_82 = nil
                        end
                        local ____num_result_93 = num(nil, a.pulo, 0)
                        local ____t_result_83
                        if __t(a.anim) then
                            ____t_result_83 = a.anim
                        else
                            ____t_result_83 = ""
                        end
                        local ____tostring_result_94 = tostring(____t_result_83)
                        local ____num_result_95 = num(nil, a.aparece, -1)
                        local ____num_result_96 = num(nil, a.some, math.huge)
                        local ____num_result_97 = num(nil, a.camada, 0)
                        local ____t_result_86
                        local ____t_85 = __t
                        local ____t_result_84
                        if __t(a.opcoes) then
                            ____t_result_84 = type(a.opcoes) == "table"
                        else
                            ____t_result_84 = a.opcoes
                        end
                        if ____t_85(____t_result_84) then
                            ____t_result_86 = a.opcoes
                        else
                            ____t_result_86 = {}
                        end
                        return {
                            type = ____type_87,
                            x = ____num_result_88,
                            y = ____num_result_89,
                            to = ____temp_80,
                            t0 = ____num_result_90,
                            t1 = ____math_max_result_91,
                            facing = ____temp_81,
                            scale = ____clamp_result_92,
                            emotion = ____t_result_82,
                            jump = ____num_result_93,
                            anim = ____tostring_result_94,
                            appear = ____num_result_95,
                            vanish = ____num_result_96,
                            z = ____num_result_97,
                            opts = ____t_result_86
                        }
                    end
                )
                local ____call_102 = __call
                local ____call_101 = __call
                local ____isArray_result_99
                if __isArray(c.efeitos) then
                    ____isArray_result_99 = c.efeitos
                else
                    ____isArray_result_99 = __arrL({}, 0)
                end
                local fx = ____call_102(
                    ____call_101(
                        ____isArray_result_99,
                        "map",
                        function(____, e)
                            local ____temp_100
                            if type(e) == "string" then
                                ____temp_100 = {tipo = e}
                            else
                                ____temp_100 = __assign({}, e)
                            end
                            return ____temp_100
                        end
                    ),
                    "filter",
                    function(____, e) return e.tipo end
                )
                local ____call_106 = __call
                local ____call_105 = __call
                local ____isArray_result_103
                if __isArray(c.sons) then
                    ____isArray_result_103 = c.sons
                else
                    ____isArray_result_103 = __arrL({}, 0)
                end
                local sounds = ____call_106(
                    ____call_105(
                        ____isArray_result_103,
                        "map",
                        function(____, s)
                            local ____temp_104
                            if type(s) == "string" then
                                ____temp_104 = {som = s, t = 0}
                            else
                                ____temp_104 = {
                                    som = s.som,
                                    t = num(nil, s.t, 0)
                                }
                            end
                            return ____temp_104
                        end
                    ),
                    "filter",
                    function(____, s) return s.som end
                )
                local ____i_113 = i
                local ____scene_114 = scene
                local ____t_result_109
                local ____t_108 = __t
                local ____t_result_107
                if __t(c.titulo) then
                    ____t_result_107 = c.titulo
                else
                    ____t_result_107 = raw.titulo
                end
                __O[748] = ____t_result_107
                if ____t_108(____t_result_107) then
                    ____t_result_109 = __O[748]
                else
                    ____t_result_109 = ""
                end
                local ____tostring_result_115 = tostring(____t_result_109)
                local ____temp_110
                if c.hora == nil then
                    ____temp_110 = nil
                else
                    ____temp_110 = num(nil, c.hora, nil)
                end
                local ____temp_111
                if c.hora_ate == nil then
                    ____temp_111 = nil
                else
                    ____temp_111 = num(nil, c.hora_ate, nil)
                end
                local ____math_max_result_116 = math.max(
                    0.1,
                    num(
                        nil,
                        cam.tempo,
                        num(nil, c.duracao, 4)
                    )
                )
                local ____temp_117 = cam.curva == "linear" and "linear" or "suave"
                local ____math_max_result_118 = math.max(
                    0.3,
                    num(nil, c.duracao, 3.5)
                )
                local ____actors_119 = actors
                local ____fx_120 = fx
                local ____sounds_121 = sounds
                local ____t_result_112
                if __t(c.fundo) then
                    ____t_result_112 = c.fundo
                else
                    ____t_result_112 = nil
                end
                local shot = {
                    index = ____i_113,
                    scene = ____scene_114,
                    title = ____tostring_result_115,
                    hour = ____temp_110,
                    hourTo = ____temp_111,
                    camFrom = from,
                    camTo = to,
                    camTime = ____math_max_result_116,
                    camCurve = ____temp_117,
                    duration = ____math_max_result_118,
                    actors = ____actors_119,
                    fx = ____fx_120,
                    sounds = ____sounds_121,
                    bg = ____t_result_112,
                    raw = c
                }
                __call(shots, "push", shot)
                local ____isArray_result_122
                if __isArray(c.falas) then
                    ____isArray_result_122 = c.falas
                else
                    ____isArray_result_122 = __arrL({}, 0)
                end
                local lines = ____isArray_result_122
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
                        local ____t_result_123
                        if __t(f.quem) then
                            ____t_result_123 = f.quem
                        else
                            ____t_result_123 = "narrador"
                        end
                        local who = tostring(____t_result_123)
                        local ____t_result_124
                        if __t(f.texto) then
                            ____t_result_124 = f.texto
                        else
                            ____t_result_124 = ""
                        end
                        local text = tostring(____t_result_124)
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
                        local ____call_139 = __call
                        local ____i_134 = i
                        local ____t_result_125
                        if __t(f.titulo) then
                            ____t_result_125 = f.titulo
                        else
                            ____t_result_125 = shot.title
                        end
                        local ____tostring_result_135 = tostring(____t_result_125)
                        local ____who_136 = who
                        local ____t_result_130
                        local ____t_129 = __t
                        local ____t_result_128
                        local ____t_127 = __t
                        local ____t_result_126
                        if __t(f.nome) then
                            ____t_result_126 = f.nome
                        else
                            ____t_result_126 = __get(NAMES, who)
                        end
                        __O[749] = ____t_result_126
                        if ____t_127(____t_result_126) then
                            ____t_result_128 = __O[749]
                        else
                            ____t_result_128 = __get(EXT.nomes, who)
                        end
                        __O[750] = ____t_result_128
                        if ____t_129(____t_result_128) then
                            ____t_result_130 = __O[750]
                        else
                            ____t_result_130 = who
                        end
                        local ____tostring_result_137 = tostring(____t_result_130)
                        local ____text_138 = text
                        local ____t_result_133
                        local ____t_132 = __t
                        local ____temp_131 = f.retrato ~= false and who ~= "narrador"
                        __O[751] = ____temp_131
                        if ____t_132(____temp_131) then
                            ____t_result_133 = who ~= "nenhum"
                        else
                            ____t_result_133 = __O[751]
                        end
                        ____call_139(
                            beats,
                            "push",
                            {
                                shot = ____i_134,
                                title = ____tostring_result_135,
                                who = ____who_136,
                                speaker = ____tostring_result_137,
                                text = ____text_138,
                                portrait = ____t_result_133,
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
        local ____isArray_result_141
        if __isArray(raw.musica) then
            ____isArray_result_141 = __call(raw.musica, "map", __StringV)
        else
            local ____t_result_140
            if __t(raw.musica) then
                ____t_result_140 = __arrL(
                    {tostring(raw.musica)},
                    1
                )
            else
                ____t_result_140 = __arrL({}, 0)
            end
            ____isArray_result_141 = ____t_result_140
        end
        local music = ____isArray_result_141
        local ____id_146 = id
        local ____file_147 = file
        local ____raw_148 = raw
        local ____t_result_142
        if __t(raw.titulo) then
            ____t_result_142 = raw.titulo
        else
            ____t_result_142 = id
        end
        local ____tostring_result_149 = tostring(____t_result_142)
        local ____t_result_143
        if __t(raw.antes) then
            ____t_result_143 = tostring(raw.antes)
        else
            ____t_result_143 = nil
        end
        local ____t_result_144
        if __t(raw.depois) then
            ____t_result_144 = tostring(raw.depois)
        else
            ____t_result_144 = nil
        end
        local ____temp_145
        if raw.chegada == nil then
            ____temp_145 = nil
        else
            ____temp_145 = __TS__Number(raw.chegada)
        end
        return {
            id = ____id_146,
            file = ____file_147,
            raw = ____raw_148,
            title = ____tostring_result_149,
            before = ____t_result_143,
            after = ____t_result_144,
            arrival = ____temp_145,
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
                local ____t_result_153
                local ____t_152 = __t
                local ____opt_150 = window.Cinematics
                if ____opt_150 ~= nil then
                    ____opt_150 = ____opt_150.metadata
                end
                __O[752] = ____opt_150
                if ____t_152(____opt_150) then
                    ____t_result_153 = __fcall(__hasOwnV, window.Cinematics.metadata, s.id)
                else
                    ____t_result_153 = __O[752]
                end
                local builtin = ____t_result_153
                local ____t_155 = __t
                local ____t_result_154
                if __t(builtin) then
                    ____t_result_154 = not __t(s.replace)
                else
                    ____t_result_154 = builtin
                end
                if ____t_155(____t_result_154) then
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
                        local ____t_158 = __t
                        local ____opt_156 = window.Cinematics
                        if ____opt_156 ~= nil then
                            ____opt_156 = ____opt_156.metadata
                        end
                        if ____t_158(____opt_156) then
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
                local ____isArray_result_160
                if __isArray(list) then
                    ____isArray_result_160 = list
                else
                    local ____t_result_159
                    if __t(list.roteiros) then
                        ____t_result_159 = list.roteiros
                    else
                        ____t_result_159 = __arrL({}, 0)
                    end
                    ____isArray_result_160 = ____t_result_159
                end
                local files = ____isArray_result_160
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
                                        warn(
                                            nil,
                                            f,
                                            __t(__call(e.message, "includes", "JSON")) and "JSON com erro de digitação (vírgula ou aspas faltando?)" or e.message
                                        )
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
        local ____t_167 = __t
        local ____t_result_166
        local ____t_165 = __t
        local ____t_result_164
        local ____t_163 = __t
        local ____opt_161 = window.Game
        if ____opt_161 ~= nil then
            ____opt_161 = ____opt_161.soundOn
        end
        __O[753] = ____opt_161
        if ____t_163(____opt_161) then
            ____t_result_164 = not __t(window.Game:soundOn())
        else
            ____t_result_164 = __O[753]
        end
        __O[754] = ____t_result_164
        if ____t_165(____t_result_164) then
            ____t_result_166 = not __t(window.__somCutscene)
        else
            ____t_result_166 = __O[754]
        end
        if ____t_167(____t_result_166) then
            return
        end
        do
            pcall(function()
                local ____t_result_170
                if __t(actx) then
                    ____t_result_170 = actx
                else
                    local ____newExpr_169 = __newExpr
                    local ____t_result_168
                    if __t(window.AudioContext) then
                        ____t_result_168 = window.AudioContext
                    else
                        ____t_result_168 = window.webkitAudioContext
                    end
                    ____t_result_170 = ____newExpr_169(____t_result_168)
                end
                actx = ____t_result_170
                if actx.state == "suspended" then
                    actx:resume()
                end
                local now = actx.currentTime
                local out = actx:createGain()
                local ____out_gain_177 = out.gain
                local ____opt_173 = window.DarocaAudio
                if ____opt_173 ~= nil then
                    ____opt_173 = ____opt_173.sfx
                end
                local ____opt_result_175
                if ____opt_173 ~= nil then
                    ____opt_result_175 = ____opt_173(____opt_173)
                end
                local ____opt_result_175_176 = ____opt_result_175
                if ____opt_result_175_176 == nil then
                    ____opt_result_175_176 = 1
                end
                ____out_gain_177.value = 0.05 * ____opt_result_175_176
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
        local ____t_188 = __t
        local ____t_result_187
        local ____t_186 = __t
        local ____temp_185 = not __t(s)
        __O[757] = ____temp_185
        if ____t_186(____temp_185) then
            ____t_result_187 = __O[757]
        else
            ____t_result_187 = s.done
        end
        if ____t_188(____t_result_187) then
            return
        end
        local ____t_result_191
        local ____t_190 = __t
        local ____TS__Number_result_189 = __TS__Number(dt)
        __O[758] = ____TS__Number_result_189
        if ____t_190(____TS__Number_result_189) then
            ____t_result_191 = __O[758]
        else
            ____t_result_191 = 0
        end
        dt = clamp(nil, ____t_result_191, 0, 0.1)
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
        local ____t_result_198
        local ____t_197 = __t
        local ____t_result_196
        local ____t_195 = __t
        local ____t_result_194
        local ____t_193 = __t
        local ____temp_192 = not __t(b.text)
        __O[759] = ____temp_192
        if ____t_193(____temp_192) then
            ____t_result_194 = __O[759]
        else
            ____t_result_194 = s.options.musicTimed
        end
        __O[760] = ____t_result_194
        if ____t_195(____t_result_194) then
            ____t_result_196 = __O[760]
        else
            ____t_result_196 = sc.auto
        end
        __O[761] = ____t_result_196
        if ____t_197(____t_result_196) then
            ____t_result_198 = __O[761]
        else
            ____t_result_198 = s.options.auto
        end
        local auto = ____t_result_198
        local ____t_200 = __t
        local ____t_result_199
        if __t(auto) then
            ____t_result_199 = __ge(s.time, b.duration)
        else
            ____t_result_199 = auto
        end
        if ____t_200(____t_result_199) then
            next(nil, s)
        end
    end
    local function advance(self, s)
        local ____t_204 = __t
        local ____t_result_203
        local ____t_202 = __t
        local ____temp_201 = not __t(s)
        __O[762] = ____temp_201
        if ____t_202(____temp_201) then
            ____t_result_203 = __O[762]
        else
            ____t_result_203 = s.done
        end
        if ____t_204(____t_result_203) then
            return false
        end
        local b = beatOf(nil, s)
        local ____t_206 = __t
        local ____t_result_205
        if __t(b.text) then
            ____t_result_205 = __lt(
                s.typed,
                __len(b.text)
            )
        else
            ____t_result_205 = b.text
        end
        if ____t_206(____t_result_205) then
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
                function(____, b, i)
                    local ____tostring_result_208 = tostring(i)
                    local ____i_209 = i
                    local ____b_start_210 = b.start
                    local ____b_duration_211 = b.duration
                    local ____t_result_207
                    if __t(b.title) then
                        ____t_result_207 = b.title
                    else
                        ____t_result_207 = __add("Quadro ", i + 1)
                    end
                    return {
                        id = ____tostring_result_208,
                        index = ____i_209,
                        start = ____b_start_210,
                        duration = ____b_duration_211,
                        label = ____t_result_207,
                        speaker = b.speaker,
                        text = b.text
                    }
                end
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
        local ____t_result_214
        local ____t_213 = __t
        local ____TS__Number_result_212 = __TS__Number(seconds)
        __O[763] = ____TS__Number_result_212
        if ____t_213(____TS__Number_result_212) then
            ____t_result_214 = __O[763]
        else
            ____t_result_214 = 0
        end
        local el = clamp(nil, ____t_result_214, 0, sc.duration)
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
            local ____t_220 = __t
            local ____t_result_219
            if __t(forced) then
                ____t_result_219 = window.performance:now() - lastDraw > 400
            else
                ____t_result_219 = forced
            end
            if ____t_220(____t_result_219) then
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
                    local ____temp_252 = num(nil, e.forca, 0.18) * math.exp(-(t - t0) * 7)
                    local ____temp_251
                    if t - t0 < 0.05 then
                        ____temp_251 = (t - t0) / 0.05
                    else
                        ____temp_251 = 1
                    end
                    zoom = zoom + ____temp_252 * ____temp_251
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
                    local ____t_254 = t
                    local ____s_elapsed_255 = s.elapsed
                    local ____shot_256 = shot
                    local ____s_257 = s
                    local ____temp_253
                    if type(shot.bg) == "table" then
                        ____temp_253 = shot.bg
                    else
                        ____temp_253 = {}
                    end
                    pintor(nil, w, {
                        t = ____t_254,
                        tt = ____s_elapsed_255,
                        shot = ____shot_256,
                        s = ____s_257,
                        p = ____temp_253,
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
            local ____t_260 = __t
            local ____opt_258 = window.Art
            if ____opt_258 ~= nil then
                ____opt_258 = ____opt_258.drawScene
            end
            if ____t_260(____opt_258) then
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
                local ____t_result_265
                local ____t_264 = __t
                local ____t_result_263
                local ____t_262 = __t
                local ____temp_261 = p.a.z - q.a.z
                __O[768] = ____temp_261
                if ____t_262(____temp_261) then
                    ____t_result_263 = __O[768]
                else
                    ____t_result_263 = p.p.y - q.p.y
                end
                __O[769] = ____t_result_263
                if ____t_264(____t_result_263) then
                    ____t_result_265 = __O[769]
                else
                    ____t_result_265 = p.i - q.i
                end
                return ____t_result_265
            end
        )
        for ____, r in __iterar((list)) do
            do
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
                        local ____t_271 = __t
                        local ____t_result_270
                        local ____t_267 = __t
                        local ____temp_266 = r.a.type == "carro"
                        __O[770] = ____temp_266
                        if ____t_267(____temp_266) then
                            local ____opt_268 = window.Art
                            if ____opt_268 ~= nil then
                                ____opt_268 = ____opt_268.drawVehicle
                            end
                            ____t_result_270 = ____opt_268
                        else
                            ____t_result_270 = __O[770]
                        end
                        if ____t_271(____t_result_270) then
                            local vf = __lt(r.p.o.facing, 0) and -1 or 1
                            local ____t_result_272
                            if __t(r.p.o.moving) then
                                ____t_result_272 = math.floor(math.sin(t * 18) + 0.5)
                            else
                                ____t_result_272 = 0
                            end
                            local bob = ____t_result_272
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
                                local ____this_274
                                ____this_274 = __get(EXT.anims, n)
                                local ____opt_273 = ____this_274.antes
                                if ____opt_273 ~= nil then
                                    ____opt_273(____this_274, w, ctx)
                                end
                            end
                            local ____opt_277 = window.Art
                            if ____opt_277 ~= nil then
                                ____opt_277 = ____opt_277.drawCharacter
                            end
                            if ____opt_277 ~= nil then
                                ____opt_277(
                                    ____opt_277,
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
                                local ____this_280
                                ____this_280 = __get(EXT.anims, n)
                                local ____opt_279 = ____this_280.depois
                                if ____opt_279 ~= nil then
                                    ____opt_279(____this_280, w, ctx)
                                end
                            end
                        end
                    end)
                end
            end
        end
        local ____t_288 = __t
        local ____t_result_287
        local ____t_286 = __t
        local ____t_result_285
        local ____t_282 = __t
        local ____temp_281 = not __t(pintor) and shot.bg ~= "preto"
        __O[771] = ____temp_281
        if ____t_282(____temp_281) then
            local ____opt_283 = window.HdScene
            if ____opt_283 ~= nil then
                ____opt_283 = ____opt_283.drawAmbient
            end
            ____t_result_285 = ____opt_283
        else
            ____t_result_285 = __O[771]
        end
        __O[772] = ____t_result_285
        if ____t_286(____t_result_285) then
            ____t_result_287 = __call(OUTDOOR, "includes", shot.scene)
        else
            ____t_result_287 = __O[772]
        end
        if ____t_288(____t_result_287) then
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
        local ____t_result_289
        if __t(shake) then
            ____t_result_289 = math.floor((hash(nil, t * 60) - 0.5) * shake * 2 / 2 + 0.5) * 2
        else
            ____t_result_289 = 0
        end
        local dx = ____t_result_289
        local ____t_result_290
        if __t(shake) then
            ____t_result_290 = math.floor((hash(nil, t * 60 + 9) - 0.5) * shake * 2 / 2 + 0.5) * 2
        else
            ____t_result_290 = 0
        end
        local dy = ____t_result_290
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
        c:fillRect(
            0,
            y - 46,
            W,
            __t(sub) and 104 or 84
        )
        c.fillStyle = "#e8c27a"
        c:fillRect(0, y - 46, W, 4)
        c:fillRect(
            0,
            y + (__t(sub) and 54 or 34),
            W,
            4
        )
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
                        do
                            local on = math.sin(tt * 4 + i * 1.7) > 0.3
                            if not __t(on) then
                                do i = i + 1 continue end
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
                        end
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
                    local ____card_295 = card
                    local ____c_293 = c
                    local ____t_result_291
                    if __t(e.texto) then
                        ____t_result_291 = e.texto
                    else
                        ____t_result_291 = ""
                    end
                    local ____tostring_result_294 = tostring(____t_result_291)
                    local ____t_result_292
                    if __t(e.sub) then
                        ____t_result_292 = tostring(e.sub)
                    else
                        ____t_result_292 = ""
                    end
                    ____card_295(
                        nil,
                        ____c_293,
                        ____tostring_result_294,
                        ____t_result_292,
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
                    local ____c_297 = c
                    local ____c_fillText_298 = c.fillText
                    local ____t_result_296
                    if __t(e.sub) then
                        ____t_result_296 = e.sub
                    else
                        ____t_result_296 = "VOCÊ CHEGOU"
                    end
                    ____c_fillText_298(
                        ____c_297,
                        tostring(____t_result_296),
                        slide + 22,
                        76
                    )
                    c.font = "bold 19px Pixel, monospace"
                    c.fillStyle = "#fff1ca"
                    local ____c_300 = c
                    local ____c_fillText_301 = c.fillText
                    local ____t_result_299
                    if __t(e.texto) then
                        ____t_result_299 = e.texto
                    else
                        ____t_result_299 = ""
                    end
                    ____c_fillText_301(
                        ____c_300,
                        tostring(____t_result_299),
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
                    local ____c_303 = c
                    local ____c_fillText_304 = c.fillText
                    local ____t_result_302
                    if __t(e.texto) then
                        ____t_result_302 = e.texto
                    else
                        ____t_result_302 = ""
                    end
                    ____c_fillText_304(
                        ____c_303,
                        tostring(____t_result_302),
                        4,
                        4
                    )
                    local ____c_306 = c
                    local ____t_result_305
                    if __t(e.cor) then
                        ____t_result_305 = e.cor
                    else
                        ____t_result_305 = "#ffd166"
                    end
                    ____c_306.fillStyle = ____t_result_305
                    local ____c_308 = c
                    local ____c_fillText_309 = c.fillText
                    local ____t_result_307
                    if __t(e.texto) then
                        ____t_result_307 = e.texto
                    else
                        ____t_result_307 = ""
                    end
                    ____c_fillText_309(
                        ____c_308,
                        tostring(____t_result_307),
                        0,
                        0
                    )
                    c:restore()
                end
            elseif tipo == "flash" then
                local f = fxWindow(nil, e, t, 0.35)
                if __t(f.on) then
                    c.fillStyle = ((("rgba(" .. (e.cor == "vermelho" and "255,80,60" or "255,250,235")) .. ",") .. tostring((1 - f.k) * 0.85)) .. ")"
                    c:fillRect(0, 0, W, H)
                end
            elseif tipo == "entrada" then
                local d = num(nil, e.dur, 0.9)
                local t0 = num(nil, e.t, 0)
                if __lt(
                    t,
                    __add(t0, d)
                ) then
                    c.fillStyle = ("rgba(8,8,10," .. tostring(__lt(t, t0) and 1 or 1 - (t - t0) / d)) .. ")"
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
                    local ____opt_313 = window.DayTime
                    if ____opt_313 ~= nil then
                        ____opt_313 = ____opt_313.force
                    end
                    if ____opt_313 ~= nil then
                        local ____temp_311
                        if shot.hourTo == nil then
                            ____temp_311 = shot.hour
                        else
                            ____temp_311 = lerp(
                                nil,
                                shot.hour,
                                shot.hourTo,
                                ease(nil, t / shot.camTime)
                            )
                        end
                        ____opt_313(____opt_313, ____temp_311)
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
                    local ____opt_315 = g.quadro
                    if ____opt_315 ~= nil then
                        ____opt_315(
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
        local ____t_320 = __t
        local ____t_result_319
        local ____t_318 = __t
        local ____t_result_317
        if __t(b.first) then
            ____t_result_317 = __lt(s.time, 0.25)
        else
            ____t_result_317 = b.first
        end
        __O[773] = ____t_result_317
        if ____t_318(____t_result_317) then
            ____t_result_319 = not __t(__call(
                shot.fx,
                "some",
                function(____, e) return e.tipo == "entrada" end
            ))
        else
            ____t_result_319 = __O[773]
        end
        if ____t_320(____t_result_319) then
            c.fillStyle = ("rgba(13,29,24," .. tostring((1 - s.time / 0.25) * 0.6)) .. ")"
            c:fillRect(0, 24, W, H - 44)
        end
        local ____t_322 = __t
        local ____t_result_321
        if __t(sc.balao) then
            ____t_result_321 = b.text
        else
            ____t_result_321 = sc.balao
        end
        if ____t_322(____t_result_321) then
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
                local ____t_result_325
                local ____t_324 = __t
                local ____temp_323 = x.type == b.who
                __O[774] = ____temp_323
                if ____t_324(____temp_323) then
                    ____t_result_325 = __O[774]
                else
                    ____t_result_325 = x.type == "carro" and b.who == "daroca"
                end
                return ____t_result_325
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
        local headY = p.y - (a.type == "carro" and 90 or 70) * a.scale
        local x = clamp(nil, (p.x - camX - sx) * z, 60, W - 60)
        local y = clamp(nil, (headY - sy) * z, 120, 470)
        local left = x < W / 2
        local ____t_result_326
        if __t(left) then
            ____t_result_326 = clamp(nil, x + 150, 290, 600)
        else
            ____t_result_326 = clamp(nil, x - 150, 360, 670)
        end
        return {
            x = ____t_result_326,
            y = 52,
            width = 500,
            speakerX = x,
            speakerY = y,
            tail = __t(left) and "left" or "right"
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
        local ____t_result_331
        local ____t_330 = __t
        local ____t_result_329
        local ____t_328 = __t
        local ____get_result_327 = __get(CORES_NOME, who)
        __O[775] = ____get_result_327
        if ____t_328(____get_result_327) then
            ____t_result_329 = __O[775]
        else
            ____t_result_329 = __get(
                CORES_NOME,
                __re_replace(
                    tostring(who),
                    __re("^(crianca|pre)_", ""),
                    ""
                )
            )
        end
        __O[776] = ____t_result_329
        if ____t_330(____t_result_329) then
            ____t_result_331 = __O[776]
        else
            ____t_result_331 = __get(
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
        return ____t_result_331
    end
    rcCanvas = nil
    rcKey = ""
    portraitCv = nil
    lastSync = ""
    clearer = nil
    local function seen(____, q)
        local ____t_result_404
        local ____t_403 = __t
        local ____t_result_402
        local ____t_401 = __t
        local ____t_result_400
        if __t(q) then
            ____t_result_400 = type(q.roteiros) == "table"
        else
            ____t_result_400 = q
        end
        __O[784] = ____t_result_400
        if ____t_401(____t_result_400) then
            ____t_result_402 = q.roteiros
        else
            ____t_result_402 = __O[784]
        end
        __O[785] = ____t_result_402
        if ____t_403(____t_result_402) then
            ____t_result_404 = __O[785]
        else
            ____t_result_404 = {}
        end
        return ____t_result_404
    end
    local function allowed(____, s, q)
        local ____t_result_405
        if __t(s) then
            ____t_result_405 = not __t(s.once) or not __t(__get(
                seen(nil, q),
                s.id
            ))
        else
            ____t_result_405 = s
        end
        return ____t_result_405
    end
    local function find(____, fn, q)
        local ____t_result_412
        local ____t_411 = __t
        local ____opt_406 = __call(
            __values(scripts),
            "find",
            function(____, s)
                local ____t_result_410
                local ____t_409 = __t
                local ____fn_result_408 = fn(nil, s)
                __O[786] = ____fn_result_408
                if ____t_409(____fn_result_408) then
                    ____t_result_410 = allowed(nil, s, q)
                else
                    ____t_result_410 = __O[786]
                end
                return ____t_result_410
            end
        )
        if ____opt_406 ~= nil then
            ____opt_406 = ____opt_406.id
        end
        __O[787] = ____opt_406
        if ____t_411(____opt_406) then
            ____t_result_412 = __O[787]
        else
            ____t_result_412 = nil
        end
        return ____t_result_412
    end
    local api = __ord(
        {
            ready = function() return ready end,
            list = function() return __keys(scripts) end,
            has = has,
            get = function(____, id)
                local ____t_result_415
                local ____t_414 = __t
                local ____get_result_413 = __get(scripts, id)
                __O[788] = ____get_result_413
                if ____t_414(____get_result_413) then
                    ____t_result_415 = __O[788]
                else
                    ____t_result_415 = nil
                end
                return ____t_result_415
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
                local ____t_result_419
                local ____t_418 = __t
                local ____opt_416 = __get(scripts, id)
                if ____opt_416 ~= nil then
                    ____opt_416 = ____opt_416.music
                end
                __O[789] = ____opt_416
                if ____t_418(____opt_416) then
                    ____t_result_419 = __O[789]
                else
                    ____t_result_419 = __arrL({}, 0)
                end
                return ____t_result_419
            end,
            create = create,
            update = update,
            advance = advance,
            beat = beat,
            draw = draw,
            timeline = timeline,
            stateAt = stateAt,
            timelinePosition = function(____, s)
                local ____t_result_425
                if __t(s) then
                    local ____t_result_424
                    if __t(s.done) then
                        local ____t_result_423
                        local ____t_422 = __t
                        local ____opt_420 = __get(scripts, s.kind)
                        if ____opt_420 ~= nil then
                            ____opt_420 = ____opt_420.duration
                        end
                        __O[790] = ____opt_420
                        if ____t_422(____opt_420) then
                            ____t_result_423 = __O[790]
                        else
                            ____t_result_423 = 0
                        end
                        ____t_result_424 = ____t_result_423
                    else
                        ____t_result_424 = s.elapsed
                    end
                    ____t_result_425 = ____t_result_424
                else
                    ____t_result_425 = 0
                end
                return ____t_result_425
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
        local ____t_429 = __t
        local ____t_result_428
        local ____t_427 = __t
        local ____temp_426 = not __t(C)
        __O[791] = ____temp_426
        if ____t_427(____temp_426) then
            ____t_result_428 = __O[791]
        else
            ____t_result_428 = C.__roteiro
        end
        if ____t_429(____t_result_428) then
            return
        end
        local o = __assign({}, C)
        local function mine(____, s)
            local ____t_result_432
            local ____t_431 = __t
            local ____t_result_430
            if __t(s) then
                ____t_result_430 = s.roteiro
            else
                ____t_result_430 = s
            end
            __O[792] = ____t_result_430
            if ____t_431(____t_result_430) then
                ____t_result_432 = __get(scripts, s.kind)
            else
                ____t_result_432 = __O[792]
            end
            return ____t_result_432
        end
        C.create = function(____, kind, opt)
            local ____t_result_433
            if __t(has(nil, kind)) then
                ____t_result_433 = create(nil, kind, opt)
            else
                ____t_result_433 = o:create(kind, opt)
            end
            return ____t_result_433
        end
        C.update = function(____, s, dt)
            local ____t_result_434
            if __t(mine(nil, s)) then
                ____t_result_434 = update(nil, s, dt)
            else
                ____t_result_434 = o:update(s, dt)
            end
            return ____t_result_434
        end
        C.advance = function(____, s)
            local ____t_result_435
            if __t(mine(nil, s)) then
                ____t_result_435 = advance(nil, s)
            else
                ____t_result_435 = o:advance(s)
            end
            return ____t_result_435
        end
        C.beat = function(____, s)
            local ____t_result_436
            if __t(mine(nil, s)) then
                ____t_result_436 = beat(nil, s)
            else
                ____t_result_436 = o:beat(s)
            end
            return ____t_result_436
        end
        C.draw = function(____, c, s)
            local ____t_result_437
            if __t(mine(nil, s)) then
                ____t_result_437 = draw(nil, c, s)
            else
                ____t_result_437 = o:draw(c, s)
            end
            return ____t_result_437
        end
        C.anchor = function(____, s)
            local ____t_result_438
            if __t(mine(nil, s)) then
                ____t_result_438 = anchor(nil, s)
            else
                ____t_result_438 = o:anchor(s)
            end
            return ____t_result_438
        end
        C.timeline = function(____, k)
            local ____t_result_448
            local ____t_442 = __t
            local ____t_result_441
            local ____t_440 = __t
            local ____temp_439 = type(k) == "string"
            __O[793] = ____temp_439
            if ____t_440(____temp_439) then
                ____t_result_441 = has(nil, k)
            else
                ____t_result_441 = __O[793]
            end
            if ____t_442(____t_result_441) then
                ____t_result_448 = timeline(nil, k)
            else
                local ____t_result_447
                local ____t_446 = __t
                local ____t_result_445
                local ____t_444 = __t
                local ____t_result_443
                if __t(k) then
                    ____t_result_443 = type(k) == "table"
                else
                    ____t_result_443 = k
                end
                __O[794] = ____t_result_443
                if ____t_444(____t_result_443) then
                    ____t_result_445 = mine(nil, k)
                else
                    ____t_result_445 = __O[794]
                end
                if ____t_446(____t_result_445) then
                    ____t_result_447 = api:timelinePosition(k)
                else
                    ____t_result_447 = o:timeline(k)
                end
                ____t_result_448 = ____t_result_447
            end
            return ____t_result_448
        end
        C.timelinePosition = function(____, s)
            local ____t_result_449
            if __t(mine(nil, s)) then
                ____t_result_449 = api:timelinePosition(s)
            else
                ____t_result_449 = o:timelinePosition(s)
            end
            return ____t_result_449
        end
        C.stateAt = function(____, k, sec, opt)
            local ____t_result_450
            if __t(has(nil, k)) then
                ____t_result_450 = stateAt(nil, k, sec, opt)
            else
                ____t_result_450 = o:stateAt(k, sec, opt)
            end
            return ____t_result_450
        end
        C.__roteiro = true
    end
    wrap(nil)
    local function preview(self, id)
        local key
        local sc = __get(scripts, id)
        if not __t(sc) then
            local ____window_456 = window
            local ____window_alert_457 = window.alert
            local ____add_455 = __add
            local ____add_result_454 = __add(
                __add("Roteiro \"", id),
                "\" não encontrado.\n"
            )
            local ____t_result_453
            local ____t_452 = __t
            local ____call_result_451 = __call(errors, "join", "\n")
            __O[795] = ____call_result_451
            if ____t_452(____call_result_451) then
                ____t_result_453 = __O[795]
            else
                ____t_result_453 = "Confira o id e a lista.json."
            end
            ____window_alert_457(
                ____window_456,
                ____add_455(____add_result_454, ____t_result_453)
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
                local ____t_459 = __t
                local ____t_result_458
                if __t(b.text) then
                    ____t_result_458 = not __t(sc.balao)
                else
                    ____t_result_458 = b.text
                end
                if ____t_459(____t_result_458) then
                    local x0 = __t(b.portrait) and 120 or 40
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
    local ____self_460 = load(nil)
    ____self_460["then"](
        ____self_460,
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
