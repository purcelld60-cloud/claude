--!native
--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __gt, __mod, __ord, __arrL, __iterar, __t, __get, __set, __len, __call, __assign = __JSR.__lt, __JSR.__gt, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__set, __JSR.__len, __JSR.__call, __JSR.__assign
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__Number = ____lualib.__TS__Number
local __TS__MathSign = ____lualib.__TS__MathSign
local ____exports = {}
local __O = {};
(function()
    local ground, FLOOR, hash, st, prints, bits, rings, lastStepX, prevGround, lastSplash, printScene, P
    function ground(self, c, o, t, cam, k)
        local pl = o.player
        local dt = math.max(
            0,
            math.min(0.1, t - if __t(ground.lt) then ground.lt else t)
        )
        ground.lt = t
        if o.scene ~= printScene then
            prints = __arrL({}, 0)
            bits = __arrL({}, 0)
            rings = __arrL({}, 0)
            printScene = o.scene
            lastStepX = nil
        end
        if st.rain > 0.1 then
            local g = c:createLinearGradient(0, 340, 0, 470)
            g:addColorStop(0, "rgba(200,212,228,0)")
            g:addColorStop(
                0.6,
                ("rgba(200,212,228," .. tostring(0.2 * st.rain)) .. ")"
            )
            g:addColorStop(
                1,
                ("rgba(200,212,228," .. tostring(0.1 * st.rain)) .. ")"
            )
            c.fillStyle = g
            c:fillRect(0, 340, 960, 130)
            do
                local i = 0
                while i < 6 do
                    local x = __mod(
                        __mod(
                            hash(nil, i + 140) * 1400 + t * (10 + hash(nil, i) * 14) - cam * 0.6,
                            1400
                        ) + 1400,
                        1400
                    ) - 220
                    local y = 400 + hash(nil, i + 141) * 50
                    local w = 160 + hash(nil, i + 142) * 200
                    c.fillStyle = ("rgba(220,228,240," .. tostring(0.08 * st.rain)) .. ")"
                    do
                        local r = 0
                        while r < 4 do
                            c:fillRect(
                                math.floor((x + r * 14) / 2 + 0.5) * 2,
                                math.floor((y - r * 4) / 2 + 0.5) * 2,
                                math.floor((w - r * 28) / 2 + 0.5) * 2,
                                4
                            )
                            r = r + 1
                        end
                    end
                    i = i + 1
                end
            end
        end
        if st.wet > 0.04 then
            local a = math.min(1, st.wet * 1.4)
            do
                local i = 0
                while i < 40 do
                    local wx = 160 + i * 240 + hash(nil, i + 170) * 120
                    local w = (44 + hash(nil, i + 171) * 70) * a
                    local x = wx - cam
                    if __t(x < -120 or x > 1080) then
                        continue
                    end
                    c.fillStyle = ("rgba(38,52,80," .. tostring(0.45 * a)) .. ")"
                    c:fillRect(
                        math.floor((x - w / 2) / 2 + 0.5) * 2,
                        FLOOR + 4,
                        math.floor(w / 2 + 0.5) * 2,
                        4
                    )
                    c:fillRect(
                        math.floor((x - w / 2 + 6) / 2 + 0.5) * 2,
                        FLOOR + 2,
                        math.floor((w - 12) / 2 + 0.5) * 2,
                        2
                    )
                    c:fillRect(
                        math.floor((x - w / 2 + 6) / 2 + 0.5) * 2,
                        FLOOR + 8,
                        math.floor((w - 12) / 2 + 0.5) * 2,
                        2
                    )
                    c.fillStyle = ("rgba(190,210,240," .. tostring(0.35 * a)) .. ")"
                    c:fillRect(
                        math.floor((x - w / 3) / 2 + 0.5) * 2,
                        FLOOR + 4,
                        math.floor(w / 4 / 2 + 0.5) * 2,
                        2
                    )
                    c:fillRect(
                        math.floor((x + w / 12) / 2 + 0.5) * 2,
                        FLOOR + 6,
                        math.floor(w / 6 / 2 + 0.5) * 2,
                        2
                    )
                    if __t(st.rain > 0.2 and math.random() < 0.25 * st.rain * k) then
                        __call(
                            rings,
                            "push",
                            {
                                x = wx + (math.random() - 0.5) * w * 0.8,
                                t0 = t
                            }
                        )
                    end
                    local ____t_21 = __t
                    local ____t_20 = __t
                    local ____t_18 = __t
                    local ____t_16 = __t
                    local ____t_14 = __t
                    local ____temp_13 = if __t(pl) then pl.ground else pl
                    __O[51] = ____temp_13
                    local ____temp_15 = if ____t_14(____temp_13) then math.abs(pl.y - FLOOR) < 3 else __O[51]
                    __O[52] = ____temp_15
                    local ____temp_17 = if ____t_16(____temp_15) then math.abs(pl.x - wx) < w / 2 else __O[52]
                    __O[53] = ____temp_17
                    local ____temp_19 = if ____t_18(____temp_17) then math.abs(pl.vx) > 40 else __O[53]
                    __O[54] = ____temp_19
                    if ____t_21(if ____t_20(____temp_19) then t - lastSplash > 0.18 else __O[54]) then
                        lastSplash = t
                        do
                            local j = 0
                            while j < 7 do
                                __call(
                                    bits,
                                    "push",
                                    {
                                        x = pl.x + (math.random() - 0.5) * 10,
                                        y = FLOOR + 2,
                                        vx = (math.random() - 0.5) * 120 + pl.vx * 0.2,
                                        vy = -60 - math.random() * 110,
                                        life = 0.45,
                                        col = "rgba(200,220,255,.9)"
                                    }
                                )
                                j = j + 1
                            end
                        end
                        do
                            pcall(function()
                                local ____opt_24 = window.DarocaAudio
                                if ____opt_24 ~= nil then
                                    ____opt_24 = ____opt_24.play
                                end
                                if ____opt_24 ~= nil then
                                    ____opt_24(____opt_24, "agua", {volume = 0.6})
                                end
                            end)
                        end
                    end
                    i = i + 1
                end
            end
        end
        rings = __call(
            rings,
            "filter",
            function(____, r) return t - r.t0 < 0.5 end
        )
        for ____, r in __iterar((rings)) do
            local u = (t - r.t0) / 0.5
            local x = r.x - cam
            local rw = 4 + u * 14
            c.fillStyle = ("rgba(210,225,255," .. tostring(0.5 * (1 - u))) .. ")"
            c:fillRect(
                math.floor((x - rw) / 2 + 0.5) * 2,
                FLOOR + 4,
                2,
                2
            )
            c:fillRect(
                math.floor((x + rw) / 2 + 0.5) * 2,
                FLOOR + 4,
                2,
                2
            )
            c:fillRect(
                math.floor((x - rw * 0.6) / 2 + 0.5) * 2,
                FLOOR + 2,
                math.floor(rw * 1.2 / 2 + 0.5) * 2,
                2
            )
        end
        if __t(if __t(pl) then st.cover > 0.15 else pl) then
            local onFloor = if __t(pl.ground) then math.abs(pl.y - FLOOR) < 3 else pl.ground
            if __t(onFloor) then
                if lastStepX == nil then
                    lastStepX = pl.x
                end
                if math.abs(pl.x - lastStepX) > 15 then
                    lastStepX = pl.x
                    __call(prints, "push", {x = pl.x, side = if __t(__mod(
                        __len(prints),
                        2
                    )) then 1 else -1, t0 = t})
                    if __len(prints) > 80 then
                        __call(prints, "shift")
                    end
                    if math.random() < 0.5 then
                        __call(
                            bits,
                            "push",
                            {
                                x = pl.x - __TS__MathSign(pl.vx) * 8,
                                y = FLOOR - 2,
                                vx = __TS__Number(-pl.vx) * 0.15 + (math.random() - 0.5) * 30,
                                vy = -40 - math.random() * 40,
                                life = 0.5,
                                col = "#ffffff"
                            }
                        )
                    end
                end
            else
                lastStepX = nil
            end
            if __t(if __t(onFloor) then not __t(prevGround) else onFloor) then
                do
                    local j = 0
                    while j < 12 do
                        __call(
                            bits,
                            "push",
                            {
                                x = pl.x + (math.random() - 0.5) * 26,
                                y = FLOOR - 2,
                                vx = (math.random() - 0.5) * 140,
                                vy = -50 - math.random() * 90,
                                life = 0.6,
                                col = "#ffffff"
                            }
                        )
                        j = j + 1
                    end
                end
            end
            prevGround = pl.ground
            local refill = 18 / (0.4 + st.snow)
            prints = __call(
                prints,
                "filter",
                function(____, f) return t - f.t0 < refill end
            )
            for ____, f in __iterar((prints)) do
                local x = f.x + f.side * 4 - cam
                if __t(x < -10 or x > 970) then
                    continue
                end
                local a = (1 - (t - f.t0) / refill) * math.min(1, st.cover * 1.5)
                c.fillStyle = ("rgba(92,112,155," .. tostring(0.75 * a)) .. ")"
                c:fillRect(
                    math.floor((x - 4) / 2 + 0.5) * 2,
                    FLOOR - 2,
                    8,
                    2
                )
                c:fillRect(
                    math.floor((x - 3) / 2 + 0.5) * 2,
                    FLOOR - 4,
                    6,
                    2
                )
                c.fillStyle = ("rgba(140,160,200," .. tostring(0.5 * a)) .. ")"
                c:fillRect(
                    math.floor((x - 4) / 2 + 0.5) * 2,
                    FLOOR - 6,
                    8,
                    2
                )
            end
        elseif __t(pl) then
            prevGround = pl.ground
        end
        for ____, b in __iterar((bits)) do
            b.life = b.life - dt
            b.x = b.x + b.vx * dt
            b.y = b.y + b.vy * dt
            b.vy = b.vy + 420 * dt
            if __gt(b.life, 0) then
                P(
                    nil,
                    c,
                    b.x - cam,
                    b.y,
                    2,
                    2,
                    b.col
                )
            end
        end
        bits = __call(
            bits,
            "filter",
            function(____, b) return __gt(b.life, 0) and __lt(b.y, FLOOR + 12) end
        )
    end
    local ____ = "use strict"
    if __t(window.Weather) then
        return
    end
    local KEY = "daroca-weather-v1"
    FLOOR = 440
    local MODES = __arrL(
        {
            __ord({id = "auto", label = "AUTOMÁTICO", text = "O tempo muda sozinho: sol, vento, chuva e poeira."}, "id,label,text"),
            __ord({id = "sol", label = "SOL", text = "Céu limpo o tempo todo."}, "id,label,text"),
            __ord({id = "chuva", label = "CHUVA", text = "Chuva com respingos, poças e trovões."}, "id,label,text"),
            __ord({id = "neve", label = "NEVE", text = "Uma frente fria impossível: neve na Bahia."}, "id,label,text"),
            __ord({id = "vento", label = "VENTO", text = "Rajadas com folhas e poeira voando."}, "id,label,text")
        },
        5
    )
    local OUTDOOR = __arrL({
        0,
        1,
        3,
        4,
        5,
        7,
        9
    }, 7)
    local DUSTY = {["3"] = 1, ["5"] = 1, ["7"] = 1}
    local mode = "auto"
    do
        pcall(function()
            local v = window.localStorage:getItem(KEY)
            if __t(__call(
                MODES,
                "some",
                function(____, m) return m.id == v end
            )) then
                mode = v
            end
        end)
    end
    hash = function(____, n)
        local x = math.sin(n * 127.1 + 311.7) * 43758.5453
        return x - math.floor(x)
    end
    st = __ord({
        rain = 0,
        snow = 0,
        wind = 0,
        dust = 0,
        cover = 0,
        flash = 0,
        wet = 0
    }, "rain,snow,wind,dust,cover,flash,wet")
    prints = __arrL({}, 0)
    bits = __arrL({}, 0)
    rings = __arrL({}, 0)
    lastStepX = nil
    prevGround = true
    lastSplash = 0
    printScene = -1
    local target = __ord({rain = 0, snow = 0, wind = 0.2, dust = 0}, "rain,snow,wind,dust")
    local nextChange = 0
    local lastT = 0
    local splashes = __arrL({}, 0)
    local seedAuto = math.floor(math.random() * 1000)
    local function pickAuto(self, t, scene)
        local r = hash(
            nil,
            seedAuto + math.floor(t / 150)
        )
        if r < 0.55 then
            return {
                rain = 0,
                snow = 0,
                wind = 0.15 + hash(nil, seedAuto + 3) * 0.2,
                dust = if __t(__get(DUSTY, scene)) then 0.3 else 0
            }
        end
        if r < 0.72 then
            return {rain = 0, snow = 0, wind = 0.9, dust = if __t(__get(DUSTY, scene)) then 0.9 else 0.3}
        end
        if r < 0.92 then
            return {
                rain = 0.55 + hash(
                    nil,
                    seedAuto + math.floor(t / 150) + 9
                ) * 0.45,
                snow = 0,
                wind = 0.35,
                dust = 0
            }
        end
        return {rain = 0, snow = 0, wind = 0.5, dust = if __t(__get(DUSTY, scene)) then 0.6 else 0.1}
    end
    local function update(self, t, scene)
        local dt = math.max(
            0,
            math.min(0.1, t - lastT)
        )
        lastT = t
        if mode == "auto" then
            target = pickAuto(nil, t, scene)
        elseif mode == "sol" then
            target = {rain = 0, snow = 0, wind = 0.1, dust = 0}
        elseif mode == "chuva" then
            target = {rain = 1, snow = 0, wind = 0.4, dust = 0}
        elseif mode == "neve" then
            target = {rain = 0, snow = 1, wind = 0.25, dust = 0}
        else
            target = {rain = 0, snow = 0, wind = 1, dust = if __t(__get(DUSTY, scene)) then 1 else 0.4}
        end
        for ____, k in __iterar((__arrL({"rain", "snow", "wind", "dust"}, 4))) do
            __set(
                st,
                k,
                __get(st, k) + (__get(target, k) - __get(st, k)) * math.min(1, dt * 0.35)
            )
        end
        st.cover = math.max(
            0,
            math.min(1, st.cover + if st.snow > 0.5 then dt * 0.035 else -dt * 0.03)
        )
        st.flash = math.max(0, st.flash - dt * 3)
        st.wet = math.max(
            0,
            math.min(1, st.wet + if st.rain > 0.15 then dt * 0.07 * st.rain else -dt * 0.012)
        )
        if __t(st.rain > 0.7 and hash(
            nil,
            math.floor(t * 2) + 77
        ) > 0.996) then
            st.flash = 1
        end
    end
    P = function(____, c, x, y, w, h, col)
        c.fillStyle = col
        c:fillRect(
            math.floor(x / 2 + 0.5) * 2,
            math.floor(y / 2 + 0.5) * 2,
            w,
            h
        )
    end
    local function draw(self, c, o)
        local ____t_5 = __t
        local ____opt_2 = window.Graphics
        if ____opt_2 ~= nil then
            ____opt_2 = ____opt_2.profile
        end
        local ____opt_result_4
        if ____opt_2 ~= nil then
            ____opt_result_4 = ____opt_2(____opt_2)
        end
        __O[47] = ____opt_result_4
        local prof = if ____t_5(____opt_result_4) then __O[47] else {particles = 1, weather = true}
        local scene = __TS__Number(o.scene)
        local ____t_7 = __t
        local ____TS__Number_result_6 = __TS__Number(o.time)
        __O[48] = ____TS__Number_result_6
        local t = if ____t_7(____TS__Number_result_6) then __O[48] else 0
        local ____t_10 = __t
        local ____t_9 = __t
        local ____temp_8 = not __t(prof.weather) or not __t(__call(OUTDOOR, "includes", scene))
        __O[49] = ____temp_8
        if ____t_10(if ____t_9(____temp_8) then __O[49] else not __t(o.outdoor)) then
            lastT = t
            return
        end
        update(nil, t, scene)
        local k = prof.particles
        local ____t_12 = __t
        local ____TS__Number_result_11 = __TS__Number(o.camera)
        __O[50] = ____TS__Number_result_11
        local cam = if ____t_12(____TS__Number_result_11) then __O[50] else 0
        local wind = st.wind * (math.sin(t * 0.3) * 0.3 + 0.7)
        local lean = 0.25 + wind * 0.55
        c:save()
        if st.rain > 0.02 then
            do
                local g = c:createLinearGradient(0, 0, 0, 330)
                g:addColorStop(
                    0,
                    ("rgba(70,78,96," .. tostring(st.rain * 0.8)) .. ")"
                )
                g:addColorStop(
                    1,
                    ("rgba(70,78,96," .. tostring(st.rain * 0.25)) .. ")"
                )
                c.fillStyle = g
                c:fillRect(0, 0, 960, 330)
                do
                    local i = 0
                    while i < 7 do
                        local x = __mod(i * 190 + t * 9 - cam * 0.05, 1300) - 170
                        local y = 20 + __mod(i, 3) * 34
                        c.fillStyle = ("rgba(52,58,74," .. tostring(st.rain * 0.6)) .. ")"
                        c:fillRect(
                            math.floor(x / 2 + 0.5) * 2,
                            y,
                            220,
                            18
                        )
                        c:fillRect(
                            math.floor(x / 2 + 0.5) * 2 + 30,
                            y - 10,
                            140,
                            10
                        )
                        c.fillStyle = ("rgba(96,104,124," .. tostring(st.rain * 0.5)) .. ")"
                        c:fillRect(
                            math.floor(x / 2 + 0.5) * 2 + 30,
                            y - 10,
                            140,
                            2
                        )
                        i = i + 1
                    end
                end
            end
            c.fillStyle = ("rgba(40,52,80," .. tostring(st.rain * 0.2)) .. ")"
            c:fillRect(0, 0, 960, 540)
            local n = math.floor(260 * st.rain * k + 0.5)
            do
                local i = 0
                while i < n do
                    local sp = 700 + hash(nil, i) * 300
                    local y = __mod(
                        hash(nil, i + 3) * 540 + t * sp,
                        600
                    ) - 60
                    local x = __mod(
                        __mod(
                            hash(nil, i + 7) * 1100 - cam * 0.2 + y * lean,
                            1000
                        ) + 1000,
                        1000
                    ) - 20
                    c.fillStyle = if __t(__mod(i, 3)) then "rgba(200,218,245,.6)" else "rgba(235,242,255,.85)"
                    do
                        local s2 = 0
                        while s2 < 6 do
                            c:fillRect(
                                math.floor((x - s2 * lean * 4) / 2 + 0.5) * 2,
                                math.floor((y - s2 * 4) / 2 + 0.5) * 2,
                                2,
                                4
                            )
                            s2 = s2 + 1
                        end
                    end
                    i = i + 1
                end
            end
            if hash(
                nil,
                math.floor(t * 30)
            ) < st.rain * k then
                do
                    local j = 0
                    while j < 3 do
                        __call(
                            splashes,
                            "push",
                            {
                                x = math.random() * 960,
                                t0 = t
                            }
                        )
                        j = j + 1
                    end
                end
            end
            splashes = __call(
                splashes,
                "filter",
                function(____, s2) return t - s2.t0 < 0.25 end
            )
            for ____, s2 in __iterar((splashes)) do
                local u = (t - s2.t0) / 0.25
                local a = 1 - u
                P(
                    nil,
                    c,
                    s2.x - 4 - u * 6,
                    FLOOR - 2 - u * 4,
                    2,
                    2,
                    ("rgba(220,235,255," .. tostring(a)) .. ")"
                )
                P(
                    nil,
                    c,
                    s2.x + 4 + u * 6,
                    FLOOR - 2 - u * 4,
                    2,
                    2,
                    ("rgba(220,235,255," .. tostring(a)) .. ")"
                )
                P(
                    nil,
                    c,
                    s2.x,
                    FLOOR - 4 - u * 8,
                    2,
                    2,
                    ("rgba(220,235,255," .. tostring(a)) .. ")"
                )
            end
            do
                local i = 0
                while i < 9 do
                    local x = __mod(
                        __mod(
                            hash(nil, i + 40) * 1400 - cam,
                            1400
                        ) + 1400,
                        1400
                    ) - 200
                    local w = 40 + hash(nil, i + 41) * 60
                    local sh = math.sin(t * 3 + i) * 0.5 + 0.5
                    c.fillStyle = ("rgba(200,220,255," .. tostring(st.rain * (0.18 + sh * 0.12))) .. ")"
                    c:fillRect(
                        math.floor(x / 2 + 0.5) * 2,
                        FLOOR + 6 + __mod(i, 3) * 6,
                        math.floor(w / 2 + 0.5) * 2,
                        2
                    )
                    i = i + 1
                end
            end
            if st.flash > 0 then
                c.fillStyle = ("rgba(230,240,255," .. tostring(st.flash * 0.35)) .. ")"
                c:fillRect(0, 0, 960, 540)
            end
        end
        if st.snow > 0.02 then
            do
                local g = c:createLinearGradient(0, 0, 0, 330)
                g:addColorStop(
                    0,
                    ("rgba(190,200,220," .. tostring(st.snow * 0.6)) .. ")"
                )
                g:addColorStop(
                    1,
                    ("rgba(190,200,220," .. tostring(st.snow * 0.15)) .. ")"
                )
                c.fillStyle = g
                c:fillRect(0, 0, 960, 330)
            end
            c.fillStyle = ("rgba(200,215,240," .. tostring(st.snow * 0.12)) .. ")"
            c:fillRect(0, 0, 960, 540)
            local n = math.floor(200 * st.snow * k + 0.5)
            do
                local i = 0
                while i < n do
                    local sp = 40 + hash(nil, i) * 60
                    local y = __mod(
                        hash(nil, i + 3) * 540 + t * sp,
                        580
                    ) - 20
                    local x = __mod(
                        __mod(
                            hash(nil, i + 7) * 1100 - cam * (0.15 + hash(nil, i) * 0.3) + math.sin(t * 1.3 + i) * 14 + t * wind * 50,
                            1000
                        ) + 1000,
                        1000
                    ) - 20
                    local big = hash(nil, i + 11) > 0.6
                    P(
                        nil,
                        c,
                        x + 2,
                        y + 2,
                        if __t(big) then 6 else 4,
                        if __t(big) then 6 else 4,
                        "rgba(110,130,170,.35)"
                    )
                    P(
                        nil,
                        c,
                        x,
                        y,
                        if __t(big) then 6 else 4,
                        if __t(big) then 6 else 4,
                        "#ffffff"
                    )
                    i = i + 1
                end
            end
        end
        if st.cover > 0.01 then
            local a = math.min(1, st.cover * 1.4)
            do
                local x = 0
                while x < 960 do
                    local h = 2 + math.floor((math.sin((x + cam) * 0.05) + math.sin((x + cam) * 0.13)) * 1.2 + 2.6 + 0.5) * 3 * st.cover
                    c.fillStyle = ("rgba(245,250,255," .. tostring(a)) .. ")"
                    c:fillRect(x, FLOOR - h + 2, 2, h)
                    x = x + 2
                end
            end
        end
        if st.wind > 0.3 then
            local n = math.floor(24 * (st.wind - 0.3) * k + 0.5)
            do
                local i = 0
                while i < n do
                    local y = 60 + hash(nil, i + 5) * 380
                    local x = __mod(
                        hash(nil, i + 9) * 1200 + t * (500 + hash(nil, i) * 300),
                        1300
                    ) - 150
                    local len = 30 + hash(nil, i + 2) * 60
                    c.fillStyle = ("rgba(255,255,255," .. tostring(0.12 + hash(nil, i + 4) * 0.1)) .. ")"
                    c:fillRect(
                        math.floor(x / 2 + 0.5) * 2,
                        math.floor((y + math.sin(t * 2 + i) * 6) / 2 + 0.5) * 2,
                        math.floor(len / 2 + 0.5) * 2,
                        2
                    )
                    i = i + 1
                end
            end
            local leaves = math.floor(18 * st.wind * k + 0.5)
            do
                local i = 0
                while i < leaves do
                    local x = __mod(
                        hash(nil, i + 21) * 1200 + t * (260 + hash(nil, i) * 200),
                        1300
                    ) - 150
                    local y = 120 + hash(nil, i + 22) * 300 + math.sin(t * 3 + i * 2) * 26
                    local col = __get(
                        __arrL({"#6aa850", "#c9a24a", "#a8c060", "#d8783a"}, 4),
                        __mod(i, 4)
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
        end
        if st.dust > 0.05 then
            local g = c:createLinearGradient(0, 300, 0, FLOOR)
            g:addColorStop(0, "rgba(214,190,150,0)")
            g:addColorStop(
                1,
                ("rgba(214,190,150," .. tostring(st.dust * 0.22)) .. ")"
            )
            c.fillStyle = g
            c:fillRect(0, 300, 960, FLOOR - 300)
            local n = math.floor(80 * st.dust * k + 0.5)
            do
                local i = 0
                while i < n do
                    local x = __mod(
                        hash(nil, i + 61) * 1200 + t * (120 + hash(nil, i) * 260) * (0.4 + st.wind),
                        1260
                    ) - 150
                    local y = FLOOR - 4 - hash(nil, i + 62) * 120 + math.sin(t * 2 + i) * 8
                    P(
                        nil,
                        c,
                        x,
                        y,
                        2,
                        2,
                        ("rgba(226,204,160," .. tostring(0.35 + hash(nil, i + 63) * 0.4)) .. ")"
                    )
                    i = i + 1
                end
            end
        end
        ground(
            nil,
            c,
            o,
            t,
            cam,
            k
        )
        c:restore()
    end
    local function next(self)
        local i = __call(
            MODES,
            "findIndex",
            function(____, m) return m.id == mode end
        )
        mode = __get(
            MODES,
            __mod(
                i + 1,
                __len(MODES)
            )
        ).id
        do
            pcall(function()
                window.localStorage:setItem(KEY, mode)
            end)
        end
        return mode
    end
    local function cur()
        local ____t_27 = __t
        local ____call_result_26 = __call(
            MODES,
            "find",
            function(____, m) return m.id == mode end
        )
        __O[55] = ____call_result_26
        return if ____t_27(____call_result_26) then __O[55] else __get(MODES, 0)
    end
    window.Weather = __ord(
        {
            draw = function(____, c, o)
                do
                    pcall(function()
                        draw(nil, c, if __t(o) then o else {})
                    end)
                end
            end,
            state = function() return __assign({}, st) end,
            next = next,
            mode = function() return mode end,
            label = function() return cur(nil).label end,
            describe = function() return cur(nil).text end,
            set = function(____, m)
                if __t(__call(
                    MODES,
                    "some",
                    function(____, x) return x.id == m end
                )) then
                    mode = m
                    do
                        pcall(function()
                            window.localStorage:setItem(KEY, mode)
                        end)
                    end
                end
            end
        },
        "draw,state,next,mode,label,describe,set"
    )
end)(nil)
return ____exports
