--!native
--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __le, __gt, __ge, __mod, __ord, __arrL, __iterar, __t, __get, __set, __del = __JSR.__lt, __JSR.__le, __JSR.__gt, __JSR.__ge, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__set, __JSR.__del
local __len, __call, __add, __iter = __JSR.__len, __JSR.__call, __JSR.__add, __JSR.__iter
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__Number = ____lualib.__TS__Number
local __TS__MathSign = ____lualib.__TS__MathSign
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    if __t(window.CampanhaPlantas) then
        return
    end
    local FLOOR = 440
    local function hash(____, i)
        local x = math.sin(i * 127.1 + 311.7) * 43758.5453
        return x - math.floor(x)
    end
    local function cl(____, v, a, b)
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
    local function P2(____, v)
        return math.floor(v / 2 + 0.5) * 2
    end
    local function R(____, c, x, y, w, h, col)
        c.fillStyle = col
        c:fillRect(
            P2(nil, x),
            P2(nil, y),
            math.max(
                2,
                P2(nil, w)
            ),
            math.max(
                2,
                P2(nil, h)
            )
        )
    end
    local PATCHES = {
        ["12"] = __arrL(
            {
                __arrL({"floreira", 240, 120}, 3),
                __arrL({"floreira", 1240, 90}, 3),
                __arrL({"floreira", 3040, 140}, 3),
                __arrL({"floreira", 4100, 120}, 3),
                __arrL({"capim", 2160, 120}, 3)
            },
            5
        ),
        ["13"] = __arrL(
            {
                __arrL({"mato", 160, 70}, 3),
                __arrL({"flores", 520, 110}, 3),
                __arrL({"mato", 1380, 60}, 3),
                __arrL({"capim", 2050, 120}, 3),
                __arrL({"flores", 2940, 90}, 3),
                __arrL({"mato", 3460, 70}, 3),
                __arrL({"flores", 3880, 120}, 3)
            },
            7
        ),
        ["14"] = __arrL(
            {
                __arrL({"flores", 1840, 160}, 3),
                __arrL({"flores", 2300, 120}, 3),
                __arrL({"capim", 2700, 140}, 3),
                __arrL({"flores", 3100, 110}, 3),
                __arrL({"mato", 420, 60}, 3),
                __arrL({"mato", 4300, 70}, 3),
                __arrL({"mato", 4700, 60}, 3)
            },
            7
        ),
        ["15"] = __arrL(
            {
                __arrL({"capim", 120, 200}, 3),
                __arrL({"flores", 480, 120}, 3),
                __arrL({"cacto", 760, 60}, 3),
                __arrL({"samambaia", 1250, 90}, 3),
                __arrL({"capim", 1700, 220}, 3),
                __arrL({"cacto", 2150, 50}, 3),
                __arrL({"flores", 2560, 140}, 3),
                __arrL({"capim", 3120, 180}, 3),
                __arrL({"cacto", 3500, 60}, 3),
                __arrL({"samambaia", 3900, 100}, 3),
                __arrL({"flores", 4300, 160}, 3)
            },
            11
        ),
        ["16"] = __arrL(
            {
                __arrL({"mato", 300, 70}, 3),
                __arrL({"capim", 1500, 120}, 3),
                __arrL({"flores", 2900, 140}, 3),
                __arrL({"flores", 3100, 120}, 3),
                __arrL({"mato", 3900, 60}, 3),
                __arrL({"capim", 4600, 100}, 3),
                __arrL({"mato", 5500, 70}, 3)
            },
            7
        ),
        ["17"] = __arrL(
            {
                __arrL({"flores", 260, 90}, 3),
                __arrL({"mato", 1000, 60}, 3),
                __arrL({"capim", 2060, 80}, 3),
                __arrL({"flores", 3600, 100}, 3),
                __arrL({"mato", 4100, 60}, 3)
            },
            5
        ),
        ["18"] = __arrL(
            {
                __arrL({"cafe", 400, 160}, 3),
                __arrL({"capim", 900, 160}, 3),
                __arrL({"flores", 1300, 100}, 3),
                __arrL({"cafe", 2100, 200}, 3),
                __arrL({"samambaia", 2900, 80}, 3),
                __arrL({"capim", 3400, 200}, 3),
                __arrL({"cafe", 4300, 180}, 3),
                __arrL({"flores", 4800, 120}, 3)
            },
            8
        ),
        ["19"] = __arrL(
            {
                __arrL({"flores", 300, 140}, 3),
                __arrL({"capim", 1300, 90}, 3),
                __arrL({"flores", 2600, 120}, 3),
                __arrL({"samambaia", 3300, 80}, 3),
                __arrL({"flores", 3900, 140}, 3)
            },
            5
        ),
        ["20"] = __arrL(
            {
                __arrL({"floreira", 160, 120}, 3),
                __arrL({"floreira", 1150, 100}, 3),
                __arrL({"floreira", 2960, 120}, 3),
                __arrL({"floreira", 4520, 110}, 3)
            },
            4
        ),
        ["21"] = __arrL(
            {
                __arrL({"capim", 200, 160}, 3),
                __arrL({"flores", 900, 140}, 3),
                __arrL({"capim", 1700, 120}, 3),
                __arrL({"flores", 2140, 110}, 3),
                __arrL({"capim", 3100, 160}, 3),
                __arrL({"flores", 4060, 120}, 3),
                __arrL({"mato", 4900, 70}, 3)
            },
            7
        )
    }
    local FLOWER = __arrL({
        "#e86a8a",
        "#f2c94c",
        "#f6f2ea",
        "#b86ad8",
        "#f08a4a",
        "#e84a4a",
        "#7ab8f0"
    }, 7)
    local sets = {}
    local parts = __arrL({}, 0)
    local lastT = 0
    local lastSound = 0
    local said = 0
    local function build(self, scene)
        local out = __arrL({}, 0)
        local ____iter_2 = __iter
        local ____t_1 = __t
        local ____get_result_0 = __get(PATCHES, scene)
        __O[402] = ____get_result_0
        for ____, ____value in __TS__Iterator(____iter_2(if ____t_1(____get_result_0) then __O[402] else __arrL({}, 0))) do
            local ____type = ____value[1]
            local x0 = ____value[2]
            local w = ____value[3]
            local step = if ____type == "cacto" then 18 else if ____type == "cafe" then 16 else if ____type == "floreira" then 7 else if ____type == "samambaia" then 12 else if ____type == "mato" then 6 else 5
            do
                local x = x0
                while __lt(
                    x,
                    __add(x0, w)
                ) do
                    local i = __len(out) + 1
                    local r = hash(nil, i + scene * 97 + x)
                    local r2 = hash(nil, i * 7 + x)
                    local edge = cl(
                        nil,
                        math.min(
                            x - x0,
                            __add(x0, w) - x
                        ) / 24 + 0.35
                    )
                    local base = FLOOR - 4 + math.floor(r2 * 5 + 0.5) * 2
                    local h = __get({
                        capim = 12 + r * 14,
                        flores = 10 + r * 12,
                        mato = 6 + r * 6,
                        samambaia = 14 + r * 8,
                        cafe = 16 + r * 8,
                        cacto = 10 + r * 4,
                        floreira = 10 + r * 10
                    }, ____type) * edge
                    __call(
                        out,
                        "push",
                        {
                            type = ____type,
                            x = x + (r2 - 0.5) * step * 0.7,
                            base = if ____type == "floreira" then FLOOR - 2 + if r2 > 0.5 then 4 else 0 else base,
                            h = h,
                            hh = h,
                            ph = r * 6.28,
                            tone = r2,
                            a = 0,
                            w = 0,
                            cut = 0,
                            col = __get(
                                FLOWER,
                                math.floor(r * 7)
                            ),
                            seeds = ____type == "mato" and r > 0.55
                        }
                    )
                    x = x + step
                end
            end
        end
        __call(
            out,
            "sort",
            function(____, a, b) return a.base - b.base end
        )
        local ____call_5 = __call
        local ____t_4 = __t
        local ____get_result_3 = __get(PATCHES, scene)
        __O[403] = ____get_result_3
        return {
            stems = out,
            pots = ____call_5(
                if ____t_4(____get_result_3) then __O[403] else __arrL({}, 0),
                "filter",
                function(____, p) return __get(p, 0) == "floreira" end
            )
        }
    end
    local function get(____, scene)
        if not __t(__get(PATCHES, scene)) then
            return nil
        end
        if not __t(__get(sets, scene)) then
            __set(
                sets,
                scene,
                build(nil, scene)
            )
        end
        return __get(sets, scene)
    end
    local function burst(self, s, n, kind)
        local ____t_11 = __t
        local ____opt_8 = window.Graphics
        if ____opt_8 ~= nil then
            ____opt_8 = ____opt_8.isLite
        end
        local ____opt_result_10
        if ____opt_8 ~= nil then
            ____opt_result_10 = ____opt_8(____opt_8)
        end
        local lite = not not ____t_11(____opt_result_10)
        if __t(lite) then
            n = math.ceil(n / 3)
        end
        if __len(parts) > 120 then
            __call(
                parts,
                "splice",
                0,
                __len(parts) - 120
            )
        end
        local tx = s.x + math.sin(s.a) * s.h
        local ty = s.base - math.cos(s.a) * s.h
        do
            local k = 0
            while __lt(k, n) do
                __call(
                    parts,
                    "push",
                    {
                        x = tx + (math.random() - 0.5) * 6,
                        y = ty,
                        vx = (math.random() - 0.5) * 70,
                        vy = if kind == "semente" then -30 - math.random() * 30 else -60 - math.random() * 60,
                        life = if kind == "semente" then 2.5 + math.random() * 2 else 1 + math.random() * 0.8,
                        kind = kind,
                        col = if kind == "petala" then s.col else if kind == "grao" then "#d8343a" else if kind == "semente" then "#f4f2ea" else if __gt(s.tone, 0.5) then "#5f9a46" else "#7ab04a"
                    }
                )
                k = k + 1
            end
        end
    end
    local function say(self, text, x, y)
        if window.performance:now() - said < 900 then
            return
        end
        said = window.performance:now()
        __call(parts, "push", {
            x = x,
            y = y,
            vx = 0,
            vy = -30,
            life = 1.1,
            kind = "texto",
            text = text
        })
    end
    local function update(self, o, dt)
        local S = get(nil, o.scene)
        if not __t(S) then
            return
        end
        local p = if __t(o.player) then o.player else {}
        local ____t_13 = __t
        local ____TS__Number_result_12 = __TS__Number(p.x)
        __O[404] = ____TS__Number_result_12
        local px = if ____t_13(____TS__Number_result_12) then __O[404] else 0
        local ____t_15 = __t
        local ____TS__Number_result_14 = __TS__Number(p.y)
        __O[405] = ____TS__Number_result_14
        local py = if ____t_15(____TS__Number_result_14) then __O[405] else FLOOR
        local ____t_17 = __t
        local ____TS__Number_result_16 = __TS__Number(p.vx)
        __O[406] = ____TS__Number_result_16
        local vx = if ____t_17(____TS__Number_result_16) then __O[406] else 0
        local ____t_19 = __t
        local ____TS__Number_result_18 = __TS__Number(o.time)
        __O[407] = ____TS__Number_result_18
        local t = if ____t_19(____TS__Number_result_18) then __O[407] else 0
        local atk = __TS__Number(p.attack) > 0
        local face = if __lt(p.facing, 0) then -1 else 1
        local ____t_29 = __t
        local ____opt_24 = window.Weather
        if ____opt_24 ~= nil then
            ____opt_24 = ____opt_24.state
        end
        local ____opt_result_26
        if ____opt_24 ~= nil then
            ____opt_result_26 = ____opt_24(____opt_24)
        end
        local ____opt_result_27
        if ____opt_result_26 ~= nil then
            ____opt_result_27 = ____opt_result_26.wind
        end
        local ____TS__Number_result_28 = __TS__Number(____opt_result_27)
        __O[408] = ____TS__Number_result_28
        local wind = if ____t_29(____TS__Number_result_28) then __O[408] else 0.25 * 0.6 + 0.15
        local touched = false
        for ____, s in __iterar((S.stems)) do
            if math.abs(s.x - (o.camera + 480)) > 620 then
                continue
            end
            local gust = math.sin(t * 1.4 - s.x * 0.05 + s.ph * 0.3) * 0.5 + 0.5
            local target = if s.type == "cacto" then 0 else wind * (0.15 + gust * 0.35) * if s.type == "floreira" then 0.3 else 1 + math.sin(t * 2.2 + s.ph) * 0.04
            local d = s.x - px
            local R0 = if s.type == "cacto" then 12 else 16
            if __t(math.abs(d) < R0 + 6 and py > s.base - s.h * 1.2) then
                local f = cl(
                    nil,
                    1 - math.abs(d) / R0
                )
                local side = if d > 1 then 1 else if d < -1 then -1 else if vx >= 0 then 1 else -1
                if f > 0 then
                    touched = true
                    if s.type == "cacto" then
                        s.w = s.w + side * dt * 20 * f
                        if math.abs(vx) > 40 then
                            say(nil, "AI!", s.x, s.base - 30)
                        end
                    else
                        target = side * (0.6 + 0.7 * math.sqrt(f)) + vx * 0.001 * f
                        if __t(math.abs(vx) > 90 and math.random() < dt * 6 * f) then
                            burst(nil, s, 1, if __t(s.type == "flores" or s.type == "floreira") then "petala" else if __t(s.seeds) then "semente" else if s.type == "cafe" then "grao" else "folha")
                        end
                    end
                end
            end
            local ____t_38 = __t
            local ____t_37 = __t
            local ____t_35 = __t
            local ____t_33 = __t
            local ____t_31 = __t
            local ____temp_30 = if __t(atk) then __lt(s.cut, 0.5) else atk
            __O[409] = ____temp_30
            local ____temp_32 = if ____t_31(____temp_30) then __TS__MathSign(d) == face else __O[409]
            __O[410] = ____temp_32
            local ____temp_34 = if ____t_33(____temp_32) then math.abs(d) < 90 else __O[410]
            __O[411] = ____temp_34
            local ____temp_36 = if ____t_35(____temp_34) then py > s.base - 60 else __O[411]
            __O[412] = ____temp_36
            if ____t_38(if ____t_37(____temp_36) then s.type ~= "cacto" else __O[412]) then
                s.cut = 1
                s.w = s.w + face * 8
                burst(nil, s, 4, if __t(s.type == "flores" or s.type == "floreira") then "petala" else if __t(s.seeds) then "semente" else if s.type == "cafe" then "grao" else "folha")
            end
            s.cut = math.max(0, s.cut - dt * 0.18)
            s.hh = s.h * (1 - s.cut * 0.65)
            local acc = (target - s.a) * if s.type == "cacto" then 40 else 70 - s.w * 7
            s.w = s.w + acc * dt
            s.a = cl(nil, s.a + s.w * dt, -1.3, 1.3)
        end
        local ____t_41 = __t
        local ____t_40 = __t
        local ____temp_39 = if __t(touched) then math.abs(vx) > 60 else touched
        __O[413] = ____temp_39
        if ____t_41(if ____t_40(____temp_39) then t - lastSound > 0.22 else __O[413]) then
            lastSound = t
            do
                pcall(function()
                    local ____opt_44 = window.DarocaAudio
                    if ____opt_44 ~= nil then
                        ____opt_44 = ____opt_44.play
                    end
                    if ____opt_44 ~= nil then
                        ____opt_44(____opt_44, "mato", {volume = 0.35})
                    end
                end)
            end
        end
        do
            local i = __len(parts) - 1
            while i >= 0 do
                local q = __get(parts, i)
                q.life = q.life - dt
                if q.kind == "semente" then
                    q.vx = q.vx + (wind * 40 - q.vx) * dt
                    q.vy = q.vy + (-6 - q.vy) * dt
                    q.x = q.x + (q.vx * dt + math.sin(t * 3 + i) * 8 * dt)
                    q.y = q.y + q.vy * dt
                elseif q.kind == "texto" then
                    q.y = q.y + q.vy * dt
                else
                    q.vy = q.vy + 160 * dt
                    q.vx = q.vx * (1 - dt * 1.5)
                    q.x = q.x + (q.vx * dt + if q.kind == "petala" then math.sin(t * 5 + i) * 14 * dt else 0)
                    q.y = q.y + q.vy * dt
                    if __gt(q.y, FLOOR + 6) then
                        q.y = FLOOR + 6
                        q.vy = 0
                        q.vx = 0
                    end
                end
                if __le(q.life, 0) then
                    __call(parts, "splice", i, 1)
                end
                i = i - 1
            end
        end
    end
    local function stem(self, c, s, t)
        local n = math.max(
            3,
            math.floor(s.hh / 2 + 0.5)
        )
        local sa = math.sin(s.a)
        local ca = math.cos(s.a * 0.9)
        local function pt(____, k)
            return __arrL({s.x + sa * s.hh * (k / n) ^ 1.6, s.base - k * 2 * ca}, 2)
        end
        repeat
            local ____switch48 = s.type
            local ____cond48 = ____switch48 == "capim"
            if ____cond48 then
                do
                    local cols = if __gt(s.tone, 0.6) then __arrL({"#6f9a3a", "#9cc45a"}, 2) else if __gt(s.tone, 0.25) then __arrL({"#4f8a3a", "#79b04a"}, 2) else __arrL({"#a8a04a", "#d0c06a"}, 2)
                    for ____, off in __iterar((__arrL({-2, 0, 2}, 3))) do
                        do
                            local k = 0
                            while k <= n do
                                local x, y = table.unpack(
                                    pt(nil, k),
                                    1,
                                    2
                                )
                                R(
                                    nil,
                                    c,
                                    x + off * (1 - k / n) * 1.5,
                                    y,
                                    2,
                                    2,
                                    if k > n * 0.6 then __get(cols, 1) else __get(cols, 0)
                                )
                                k = k + 1
                            end
                        end
                    end
                    break
                end
            end
            ____cond48 = ____cond48 or ____switch48 == "mato"
            if ____cond48 then
                do
                    do
                        local k = 0
                        while k <= n do
                            local x, y = table.unpack(
                                pt(nil, k),
                                1,
                                2
                            )
                            R(
                                nil,
                                c,
                                x,
                                y,
                                2,
                                2,
                                "#5a8a3a"
                            )
                            if k == math.floor(n / 2) then
                                R(
                                    nil,
                                    c,
                                    x - 2,
                                    y,
                                    2,
                                    2,
                                    "#6f9a46"
                                )
                                R(
                                    nil,
                                    c,
                                    x + 2,
                                    y - 2,
                                    2,
                                    2,
                                    "#6f9a46"
                                )
                            end
                            k = k + 1
                        end
                    end
                    local x, y = table.unpack(
                        pt(nil, n),
                        1,
                        2
                    )
                    if __t(if __t(s.seeds) then __lt(s.cut, 0.3) else s.seeds) then
                        R(
                            nil,
                            c,
                            x - 2,
                            y - 4,
                            6,
                            6,
                            "#f4f2ea"
                        )
                        R(
                            nil,
                            c,
                            x,
                            y - 2,
                            2,
                            2,
                            "#d8d4c8"
                        )
                    else
                        R(
                            nil,
                            c,
                            x - 2,
                            y - 2,
                            6,
                            4,
                            "#f2c94c"
                        )
                    end
                    break
                end
            end
            ____cond48 = ____cond48 or (____switch48 == "flores" or ____switch48 == "floreira")
            if ____cond48 then
                do
                    do
                        local k = 0
                        while k <= n do
                            local x, y = table.unpack(
                                pt(nil, k),
                                1,
                                2
                            )
                            R(
                                nil,
                                c,
                                x,
                                y,
                                2,
                                2,
                                "#4f8a3a"
                            )
                            if k == math.floor(n * 0.4) then
                                R(
                                    nil,
                                    c,
                                    x - 4,
                                    y,
                                    4,
                                    2,
                                    "#5f9a46"
                                )
                                R(
                                    nil,
                                    c,
                                    x + 2,
                                    y - 2,
                                    4,
                                    2,
                                    "#6aa64a"
                                )
                            end
                            k = k + 1
                        end
                    end
                    if __lt(s.cut, 0.4) then
                        local x, y = table.unpack(
                            pt(nil, n),
                            1,
                            2
                        )
                        R(
                            nil,
                            c,
                            x - 4,
                            y - 2,
                            10,
                            4,
                            s.col
                        )
                        R(
                            nil,
                            c,
                            x - 2,
                            y - 4,
                            6,
                            8,
                            s.col
                        )
                        R(
                            nil,
                            c,
                            x,
                            y - 2,
                            2,
                            2,
                            if s.col == "#f2c94c" then "#c47a35" else "#f2e06a"
                        )
                    end
                    break
                end
            end
            ____cond48 = ____cond48 or ____switch48 == "samambaia"
            if ____cond48 then
                do
                    for ____, dir in __iterar((__arrL({-1, 1}, 2))) do
                        do
                            local k = 0
                            while k <= n do
                                local u = k / n
                                local x = s.x + dir * u * s.hh * 0.7 + sa * s.hh * u * u
                                local y = s.base - math.sin(u * math.pi * 0.8) * s.hh * 0.8 * ca
                                R(
                                    nil,
                                    c,
                                    x,
                                    y,
                                    2,
                                    2,
                                    "#3f7a3c"
                                )
                                if __t(__mod(k, 2) == 0 and k < n) then
                                    R(
                                        nil,
                                        c,
                                        x,
                                        y - 2,
                                        2,
                                        2,
                                        "#5f9a52"
                                    )
                                end
                                k = k + 1
                            end
                        end
                    end
                    R(
                        nil,
                        c,
                        s.x - 2,
                        s.base - 2,
                        6,
                        2,
                        "#2f5f30"
                    )
                    break
                end
            end
            ____cond48 = ____cond48 or ____switch48 == "cafe"
            if ____cond48 then
                do
                    do
                        local k = 0
                        while k <= n do
                            local x, y = table.unpack(
                                pt(nil, k),
                                1,
                                2
                            )
                            R(
                                nil,
                                c,
                                x,
                                y,
                                2,
                                2,
                                "#6a4a2a"
                            )
                            if __t(k > 2 and __mod(k, 2) == 0) then
                                R(
                                    nil,
                                    c,
                                    x - 6,
                                    y,
                                    6,
                                    4,
                                    "#2f5a34"
                                )
                                R(
                                    nil,
                                    c,
                                    x + 2,
                                    y - 2,
                                    6,
                                    4,
                                    "#3a6a3c"
                                )
                                if __t(__lt(s.cut, 0.4) and __mod(
                                    k + math.floor(s.tone * 4 + 0.5),
                                    4
                                ) == 0) then
                                    R(
                                        nil,
                                        c,
                                        x - 4,
                                        y + 2,
                                        2,
                                        2,
                                        "#d8343a"
                                    )
                                    R(
                                        nil,
                                        c,
                                        x + 4,
                                        y + 2,
                                        2,
                                        2,
                                        "#c42a2a"
                                    )
                                end
                            end
                            k = k + 1
                        end
                    end
                    break
                end
            end
            ____cond48 = ____cond48 or ____switch48 == "cacto"
            if ____cond48 then
                do
                    local x = s.x + s.a * 3
                    local y = s.base
                    R(
                        nil,
                        c,
                        x - 6,
                        y - 12,
                        14,
                        12,
                        "#2f6a3a"
                    )
                    R(
                        nil,
                        c,
                        x - 4,
                        y - 14,
                        10,
                        14,
                        "#3f7a4a"
                    )
                    do
                        local k = -4
                        while k <= 4 do
                            R(
                                nil,
                                c,
                                x + k,
                                y - 12,
                                2,
                                12,
                                "#2a5a32"
                            )
                            k = k + 4
                        end
                    end
                    R(
                        nil,
                        c,
                        x - 4,
                        y - 18,
                        10,
                        4,
                        "#c43c5a"
                    )
                    R(
                        nil,
                        c,
                        x - 2,
                        y - 20,
                        6,
                        2,
                        "#e86a7a"
                    )
                    do
                        local k = -6
                        while k <= 6 do
                            R(
                                nil,
                                c,
                                x + k,
                                y - 8,
                                2,
                                2,
                                "#f2efe6"
                            )
                            k = k + 6
                        end
                    end
                    break
                end
            end
        until true
    end
    local function pot(self, c, x, w)
        R(
            nil,
            c,
            x - 4,
            FLOOR - 10,
            w + 8,
            12,
            "#8a8478"
        )
        R(
            nil,
            c,
            x - 4,
            FLOOR - 10,
            w + 8,
            2,
            "#b4ae9e"
        )
        R(
            nil,
            c,
            x - 2,
            FLOOR - 8,
            w + 4,
            2,
            "#5a4232"
        )
    end
    local function visible(____, o)
        local ____t_47 = __t
        local ____temp_46 = __ge(o.scene, 12) and not __t(o.arena)
        __O[414] = ____temp_46
        return if ____t_47(____temp_46) then not __t(o.room) else __O[414]
    end
    local function drawBack(self, ctx, o)
        if not __t(visible(nil, o)) then
            return
        end
        local S = get(nil, o.scene)
        if not __t(S) then
            return
        end
        local ____t_49 = __t
        local ____TS__Number_result_48 = __TS__Number(o.time)
        __O[415] = ____TS__Number_result_48
        local t = if ____t_49(____TS__Number_result_48) then __O[415] else 0
        local dt = math.max(
            0,
            math.min(0.05, t - lastT)
        )
        lastT = t
        update(nil, o, dt)
        ctx:save()
        ctx.imageSmoothingEnabled = false
        for ____, ____value in __iterar((S.pots)) do
            local x = ____value[2]
            local w = ____value[3]
            if __t(__gt(
                __add(x, w),
                o.camera - 40
            ) and __lt(x, o.camera + 1000)) then
                pot(nil, ctx, x, w)
            end
        end
        for ____, s in __iterar((S.stems)) do
            local ____t_52 = __t
            local ____t_51 = __t
            local ____temp_50 = __lt(s.base, FLOOR) and __gt(s.x, o.camera - 40)
            __O[416] = ____temp_50
            if ____t_52(if ____t_51(____temp_50) then __lt(s.x, o.camera + 1000) else __O[416]) then
                stem(nil, ctx, s, t)
            end
        end
        ctx:restore()
    end
    local function drawFront(self, ctx, o)
        if not __t(visible(nil, o)) then
            return
        end
        local S = get(nil, o.scene)
        if not __t(S) then
            return
        end
        local ____t_54 = __t
        local ____TS__Number_result_53 = __TS__Number(o.time)
        __O[417] = ____TS__Number_result_53
        local t = if ____t_54(____TS__Number_result_53) then __O[417] else 0
        ctx:save()
        ctx.imageSmoothingEnabled = false
        for ____, s in __iterar((S.stems)) do
            local ____t_57 = __t
            local ____t_56 = __t
            local ____temp_55 = __ge(s.base, FLOOR) and __gt(s.x, o.camera - 40)
            __O[418] = ____temp_55
            if ____t_57(if ____t_56(____temp_55) then __lt(s.x, o.camera + 1000) else __O[418]) then
                stem(nil, ctx, s, t)
            end
        end
        for ____, q in __iterar((parts)) do
            if q.kind == "texto" then
                ctx.globalAlpha = cl(nil, q.life * 2)
                ctx.font = "12px Pixel, monospace"
                ctx.textAlign = "center"
                ctx.fillStyle = "#2a1a14"
                ctx:fillText(q.text, q.x + 2, q.y + 2)
                ctx.fillStyle = "#ffe2a0"
                ctx:fillText(q.text, q.x, q.y)
                continue
            end
            ctx.globalAlpha = cl(nil, q.life * 1.5)
            R(
                nil,
                ctx,
                q.x,
                q.y,
                if q.kind == "semente" then 2 else 4,
                2,
                q.col
            )
            if q.kind == "semente" then
                R(
                    nil,
                    ctx,
                    q.x - 2,
                    q.y - 2,
                    6,
                    2,
                    "rgba(244,242,234,.6)"
                )
            end
        end
        ctx:restore()
    end
    window.CampanhaPlantas = __ord(
        {
            drawBack = drawBack,
            drawFront = drawFront,
            adicionar = function(____, scene, lista)
                __set(
                    PATCHES,
                    scene,
                    __call(
                        lista,
                        "map",
                        function(____, p) return __call(p, "slice") end
                    )
                )
                __del(sets, scene)
            end,
            canteiros = function(____, scene)
                local ____call_60 = __call
                local ____t_59 = __t
                local ____get_result_58 = __get(PATCHES, scene)
                __O[419] = ____get_result_58
                return ____call_60(
                    if ____t_59(____get_result_58) then __O[419] else __arrL({}, 0),
                    "map",
                    function(____, p) return __call(p, "slice") end
                )
            end,
            stats = function() return {particulas = __len(parts)} end
        },
        "drawBack,drawFront,adicionar,canteiros,stats"
    )
end)(nil)
return ____exports
