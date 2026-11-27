--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __mod, __ord, __arrL, __iterar, __t, __get, __call, __add, __keys = __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__call, __JSR.__add, __JSR.__keys
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Number = ____lualib.__TS__Number
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__SparseArrayNew = ____lualib.__TS__SparseArrayNew
local __TS__SparseArrayPush = ____lualib.__TS__SparseArrayPush
local __TS__SparseArraySpread = ____lualib.__TS__SparseArraySpread
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    local ____t_2 = __t
    local ____t_1 = __t
    local ____temp_0 = not __t(window.Art) or not __t(window.Art.drawArena)
    __O[2683] = ____temp_0
    if ____t_2(if ____t_1(____temp_0) then __O[2683] else window.BossArena) then
        return
    end
    local orig = window.Art.drawArena
    local function rnd(____, n)
        local x = math.sin(n * 78.233 + 12.9898) * 43758.5453
        return x - math.floor(x)
    end
    local function R(____, c, x, y, w, h, col)
        c.fillStyle = col
        c:fillRect(
            math.floor(x + 0.5),
            math.floor(y + 0.5),
            math.floor(w + 0.5),
            math.floor(h + 0.5)
        )
    end
    local THEME = __ord(
        {
            igor = __ord({light = "255,190,120", crowd = "#22344a", parts = "steam", spot = true}, "light,crowd,parts,spot"),
            kaique = __ord({
                light = "255,90,90",
                crowd = "#22344a",
                parts = "paper",
                spot = true,
                alarm = true
            }, "light,crowd,parts,spot,alarm"),
            arthur = __ord({
                light = "255,220,150",
                crowd = "#24384e",
                parts = "leaves",
                spot = false,
                chant = true
            }, "light,crowd,parts,spot,chant"),
            marco = __ord({light = "255,80,110", crowd = nil, parts = "ink", spot = true}, "light,crowd,parts,spot"),
            menezes = __ord({light = "255,200,230", crowd = "#2a1a24", parts = "rats", spot = true}, "light,crowd,parts,spot"),
            nikolas = __ord({
                light = "170,230,90",
                crowd = nil,
                parts = "slime",
                spot = false,
                storm = true
            }, "light,crowd,parts,spot,storm"),
            reeisBoss = __ord({light = "255,210,110", crowd = "#3a2a26", parts = "embers", spot = true}, "light,crowd,parts,spot"),
            freddy = __ord({light = "255,160,90", crowd = "#3a2a2e", parts = "embers", spot = true}, "light,crowd,parts,spot"),
            giant = __ord({light = "210,170,255", crowd = nil, parts = "paperstorm", spot = false}, "light,crowd,parts,spot"),
            nicolas = __ord({
                light = "255,240,170",
                crowd = nil,
                parts = "feathers",
                spot = false,
                rays = true
            }, "light,crowd,parts,spot,rays"),
            dede = __ord({light = "190,220,200", crowd = "#1e2a2a", parts = "smoke", spot = true}, "light,crowd,parts,spot")
        },
        "igor,kaique,arthur,marco,menezes,nikolas,reeisBoss,freddy,giant,nicolas,dede"
    )
    local function cone(self, c, x, top, ang, len, w, rgb, a)
        c:save()
        c:translate(x, top)
        c:rotate(ang)
        local g = c:createLinearGradient(0, 0, 0, len)
        g:addColorStop(
            0,
            ((("rgba(" .. tostring(rgb)) .. ",") .. tostring(a)) .. ")"
        )
        g:addColorStop(
            1,
            ("rgba(" .. tostring(rgb)) .. ",0)"
        )
        c.fillStyle = g
        c:beginPath()
        c:moveTo(-8, 0)
        c:lineTo(8, 0)
        c:lineTo(w, len)
        c:lineTo(
            __TS__Number(-w),
            len
        )
        c:closePath()
        __call(c, "fill")
        c:restore()
    end
    local function crowd(self, c, col, t, center, cheer)
        local beat = t * 2.4
        do
            local i = 0
            while i < 46 do
                local x = __mod(
                    i * 23 + __mod(i, 3) * 7,
                    1000
                ) - 20
                local depth = __mod(i, 2)
                local y = 440 - if __t(depth) then 6 else 0
                local h = 44 + rnd(nil, i) * 16 - depth * 6
                local jump = math.max(
                    0,
                    math.sin(beat * math.pi + i * 1.7)
                ) * if __t(cheer) then 7 else 3
                if __t(math.abs(x - center) < 150 and not __t(depth)) then
                    continue
                end
                local yy = y - jump
                local shade = if __t(depth) then col else __add(col, "ee")
                R(
                    nil,
                    c,
                    x - 7,
                    yy - h,
                    14,
                    h,
                    shade
                )
                R(
                    nil,
                    c,
                    x - 6,
                    yy - h - 12,
                    12,
                    12,
                    shade
                )
                local up = __mod(
                    i + math.floor(beat),
                    3
                ) == 0
                R(
                    nil,
                    c,
                    x - 11,
                    yy - h + if __t(up) then -20 else 2,
                    4,
                    if __t(up) then 22 else 16,
                    shade
                )
                R(
                    nil,
                    c,
                    x + 7,
                    yy - h + if __t(up) then -22 else 4,
                    4,
                    if __t(up) then 24 else 14,
                    shade
                )
                if rnd(
                    nil,
                    i * 3 + math.floor(t * 3)
                ) > 0.985 then
                    c:save()
                    c.globalAlpha = 0.9
                    R(
                        nil,
                        c,
                        x + 6,
                        yy - h - 30,
                        5,
                        7,
                        "#ffffff"
                    )
                    c.globalCompositeOperation = "lighter"
                    local g = c:createRadialGradient(
                        x + 8,
                        yy - h - 27,
                        1,
                        x + 8,
                        yy - h - 27,
                        22
                    )
                    g:addColorStop(0, "rgba(255,255,255,.6)")
                    g:addColorStop(1, "rgba(255,255,255,0)")
                    c.fillStyle = g
                    c:fillRect(x - 14, yy - h - 49, 44, 44)
                    c:restore()
                elseif __mod(i, 5) == 0 then
                    R(
                        nil,
                        c,
                        x + 6,
                        yy - h - 26,
                        4,
                        6,
                        "#9fd0ff"
                    )
                end
                i = i + 1
            end
        end
    end
    local function particles(self, c, kind, t, center)
        c:save()
        if kind == "steam" then
            do
                local i = 0
                while i < 14 do
                    local k = __mod(
                        t * 0.25 + rnd(nil, i),
                        1
                    )
                    c.globalAlpha = (1 - k) * 0.3
                    R(
                        nil,
                        c,
                        110 + rnd(nil, i * 2) * 140 + math.sin(t + i) * 8,
                        260 - k * 160,
                        10 + k * 14,
                        8 + k * 10,
                        "#ffffff"
                    )
                    i = i + 1
                end
            end
        end
        if __t(kind == "paper" or kind == "paperstorm") then
            local n = if kind == "paper" then 16 else 60
            do
                local i = 0
                while i < n do
                    local sp = if kind == "paper" then 40 else 160
                    local a = t * if kind == "paper" then 0.3 else 1.4 + i
                    local x = if kind == "paper" then __mod(
                        rnd(nil, i) * 1100 + t * sp,
                        1100
                    ) - 70 else center + math.cos(a) * (120 + rnd(nil, i) * 300)
                    local y = if kind == "paper" then 80 + rnd(nil, i * 3) * 300 + math.sin(t * 2 + i) * 20 else 260 + math.sin(a * 1.3) * (60 + rnd(nil, i * 5) * 150)
                    c:save()
                    c:translate(x, y)
                    c:rotate(a * 2)
                    c.globalAlpha = 0.85
                    R(
                        nil,
                        c,
                        -6,
                        -4,
                        12,
                        8,
                        "#f1ecdf"
                    )
                    R(
                        nil,
                        c,
                        -4,
                        -2,
                        8,
                        1,
                        "#9aa4b8"
                    )
                    R(
                        nil,
                        c,
                        -4,
                        1,
                        6,
                        1,
                        "#9aa4b8"
                    )
                    c:restore()
                    i = i + 1
                end
            end
        end
        if kind == "ink" then
            do
                local i = 0
                while i < 18 do
                    local x = rnd(nil, i) * 960
                    local len = 20 + __mod(
                        t * 30 * (0.5 + rnd(nil, i * 2)),
                        160
                    )
                    R(
                        nil,
                        c,
                        x,
                        0,
                        4,
                        len,
                        "#2a0f2a"
                    )
                    R(
                        nil,
                        c,
                        x - 1,
                        len - 4,
                        6,
                        6,
                        "#3a1238"
                    )
                    i = i + 1
                end
            end
        end
        if kind == "rats" then
            do
                local i = 0
                while i < 4 do
                    local x = __mod(t * (120 + i * 30) + i * 300, 1200) - 120
                    local dir = if __t(__mod(i, 2)) then 1 else -1
                    local xx = if dir > 0 then x else 960 - x
                    R(
                        nil,
                        c,
                        xx - 8,
                        430,
                        16,
                        7,
                        "#5a4a52"
                    )
                    R(
                        nil,
                        c,
                        xx + dir * 8,
                        432,
                        5,
                        4,
                        "#5a4a52"
                    )
                    R(
                        nil,
                        c,
                        xx - dir * 14,
                        434,
                        8,
                        2,
                        "#c9a0a8"
                    )
                    R(
                        nil,
                        c,
                        xx + dir * 10,
                        432,
                        1,
                        1,
                        "#ff5a6a"
                    )
                    i = i + 1
                end
            end
        end
        if kind == "slime" then
            do
                local i = 0
                while i < 20 do
                    local k = __mod(
                        t * 0.35 + rnd(nil, i),
                        1
                    )
                    c.globalAlpha = 0.7
                    R(
                        nil,
                        c,
                        rnd(nil, i * 2) * 960,
                        -10 + k * 460,
                        5,
                        8,
                        "#a6d05d"
                    )
                    i = i + 1
                end
            end
        end
        if kind == "embers" then
            do
                local i = 0
                while i < 26 do
                    local k = __mod(
                        t * 0.2 + rnd(nil, i),
                        1
                    )
                    c.globalAlpha = (1 - k) * 0.9
                    R(
                        nil,
                        c,
                        rnd(nil, i * 4) * 960 + math.sin(t * 2 + i) * 14,
                        440 - k * 380,
                        3,
                        3,
                        if __t(__mod(i, 3)) then "#ffb347" else "#ffe08a"
                    )
                    i = i + 1
                end
            end
        end
        if kind == "feathers" then
            do
                local i = 0
                while i < 16 do
                    local k = __mod(
                        t * 0.08 + rnd(nil, i),
                        1
                    )
                    c:save()
                    c:translate(
                        rnd(nil, i * 3) * 960 + math.sin(t + i) * 30,
                        k * 460
                    )
                    c:rotate(math.sin(t * 2 + i) * 0.8)
                    c.globalAlpha = 0.8
                    R(
                        nil,
                        c,
                        -2,
                        -8,
                        4,
                        16,
                        "#fff8e0"
                    )
                    R(
                        nil,
                        c,
                        -5,
                        -6,
                        3,
                        10,
                        "#f2e6c0"
                    )
                    c:restore()
                    i = i + 1
                end
            end
        end
        if kind == "smoke" then
            do
                local i = 0
                while i < 10 do
                    local x = __mod(i * 160 + t * 18, 1300) - 170
                    local y = 220 + __mod(i, 4) * 50
                    c.globalAlpha = 0.14
                    c.fillStyle = "#d9e4dc"
                    c:beginPath()
                    c:ellipse(
                        x,
                        y,
                        120,
                        34,
                        0,
                        0,
                        math.pi * 2
                    )
                    __call(c, "fill")
                    i = i + 1
                end
            end
        end
        if kind == "leaves" then
            do
                local i = 0
                while i < 12 do
                    local k = __mod(
                        t * 0.1 + rnd(nil, i),
                        1
                    )
                    c.globalAlpha = 0.9
                    R(
                        nil,
                        c,
                        __mod(
                            rnd(nil, i) * 960 + t * 30,
                            960
                        ),
                        k * 440,
                        5,
                        3,
                        if __t(__mod(i, 2)) then "#7aa84a" else "#c9a24a"
                    )
                    i = i + 1
                end
            end
        end
        c:restore()
    end
    local function overlay(self, c, ____type, camera, t, homeX, hd)
        local ____t_5 = __t
        local ____t_4 = __t
        local ____temp_3 = if __t(____type) then type(____type) == "table" else ____type
        __O[2684] = ____temp_3
        local th = if ____t_5(if ____t_4(____temp_3) then ____type.light else __O[2684]) then ____type else __get(THEME, ____type)
        if not __t(th) then
            return
        end
        local center = if __t(homeX) then homeX - camera else 480
        c:save()
        if __t(th.storm) then
            if not __t(hd) then
                local g = c:createLinearGradient(0, 0, 0, 300)
                g:addColorStop(0, "rgba(20,40,10,.6)")
                g:addColorStop(1, "rgba(20,40,10,0)")
                c.fillStyle = g
                c:fillRect(0, 0, 960, 300)
            end
            do
                local i = 0
                while i < if __t(hd) then 0 else 6 do
                    c.globalAlpha = 0.35
                    c.fillStyle = "#1e2e14"
                    c:beginPath()
                    c:ellipse(
                        __mod(i * 210 + t * 22, 1300) - 170,
                        40 + __mod(i, 3) * 30,
                        160,
                        40,
                        0,
                        0,
                        math.pi * 2
                    )
                    __call(c, "fill")
                    i = i + 1
                end
            end
            c.globalAlpha = 1
            local ph = __mod(t, 4.2)
            if ph < 0.1 then
                c.fillStyle = "rgba(210,255,170,.35)"
                c:fillRect(0, 0, 960, 540)
                c.strokeStyle = "#e8ffd0"
                c.lineWidth = 3
                c:beginPath()
                local x = 200 + __mod(
                    math.floor(t / 4.2) * 337,
                    600
                )
                local y = 0
                c:moveTo(x, y)
                while y < 300 do
                    x = x + (rnd(nil, y + t) - 0.5) * 60
                    y = y + 30
                    c:lineTo(x, y)
                end
                c:stroke()
            end
        end
        if __t(th.rays) then
            c.globalCompositeOperation = "lighter"
            do
                local i = 0
                while i < 10 do
                    local a = i / 10 * math.pi * 2 + t * 0.12
                    cone(
                        nil,
                        c,
                        center,
                        171,
                        a,
                        520,
                        70,
                        th.light,
                        0.08
                    )
                    i = i + 1
                end
            end
            c.globalCompositeOperation = "source-over"
        end
        if __t(th.spot) then
            c.globalCompositeOperation = "lighter"
            cone(
                nil,
                c,
                120,
                -10,
                -0.55 + math.sin(t * 0.7) * 0.35,
                560,
                90,
                th.light,
                0.16
            )
            cone(
                nil,
                c,
                840,
                -10,
                0.55 + math.sin(t * 0.6 + 1) * 0.35,
                560,
                90,
                th.light,
                0.16
            )
            cone(
                nil,
                c,
                center,
                -10,
                math.sin(t * 0.5) * 0.15,
                520,
                70,
                "255,255,255",
                0.08
            )
            c.globalCompositeOperation = "source-over"
        end
        if __t(th.alarm) then
            local a = (math.sin(t * 6) + 1) / 2
            c.fillStyle = ("rgba(255,40,40," .. tostring(a * 0.1)) .. ")"
            c:fillRect(0, 0, 960, 440)
            R(
                nil,
                c,
                470,
                92,
                20,
                10,
                if a > 0.5 then "#ff3a3a" else "#7a1a1a"
            )
        end
        particles(
            nil,
            c,
            th.parts,
            t,
            center
        )
        if __t(if __t(th.crowd) then not __t(hd) else th.crowd) then
            crowd(
                nil,
                c,
                th.crowd,
                t,
                center,
                true
            )
        end
        if __t(th.chant) then
            local k = __mod(t * 0.5, 1)
            if k < 0.6 then
                c.globalAlpha = 1 - k / 0.6
                c.font = "900 22px monospace"
                c.textAlign = "center"
                c.fillStyle = "#ffe36b"
                c.strokeStyle = "#1a1a1a"
                c.lineWidth = 4
                local y = 280 - k * 30
                for ____, ____value in __iterar((__arrL(
                    {
                        __arrL({140, "BRIGA!"}, 2),
                        __arrL({820, "BRIGA!"}, 2),
                        __arrL({480, "UUUUH!"}, 2)
                    },
                    3
                ))) do
                    local x = ____value[1]
                    local s = ____value[2]
                    c:strokeText(s, x, y)
                    c:fillText(s, x, y)
                end
                c.globalAlpha = 1
            end
        end
        local fl = c:createLinearGradient(0, 440, 0, 540)
        fl:addColorStop(
            0,
            ("rgba(" .. tostring(th.light)) .. ",.18)"
        )
        fl:addColorStop(
            1,
            ("rgba(" .. tostring(th.light)) .. ",0)"
        )
        c.fillStyle = fl
        c:fillRect(0, 440, 960, 100)
        local v = c:createRadialGradient(
            480,
            300,
            200,
            480,
            300,
            640
        )
        v:addColorStop(0, "rgba(0,0,0,0)")
        v:addColorStop(1, "rgba(0,0,0,.42)")
        c.fillStyle = v
        c:fillRect(0, 0, 960, 540)
        c:restore()
    end
    window.Art.drawArena = function(self, c, ____type, camera, t, homeX)
        if camera == nil then
            camera = 0
        end
        if t == nil then
            t = 0
        end
        if homeX == nil then
            homeX = 0
        end
        local ____t_12 = __t
        local ____t_11 = __t
        local ____opt_8 = window.HdMaps
        if ____opt_8 ~= nil then
            ____opt_8 = ____opt_8.arenaHandles
        end
        local ____opt_result_10
        if ____opt_8 ~= nil then
            ____opt_result_10 = ____opt_8(____opt_8, ____type)
        end
        __O[2685] = ____opt_result_10
        if ____t_12(if ____t_11(____opt_result_10) then window.HdMaps:drawArena(
            c,
            ____type,
            camera,
            t,
            homeX
        ) else __O[2685]) then
            do
                pcall(function()
                    local ____overlay_20 = overlay
                    local ____array_19 = __TS__SparseArrayNew(nil, c, if type(____type) == "table" then ____type.type else ____type)
                    local ____t_14 = __t
                    local ____TS__Number_result_13 = __TS__Number(camera)
                    __O[2686] = ____TS__Number_result_13
                    __TS__SparseArrayPush(____array_19, if ____t_14(____TS__Number_result_13) then __O[2686] else 0)
                    local ____t_16 = __t
                    local ____TS__Number_result_15 = __TS__Number(t)
                    __O[2687] = ____TS__Number_result_15
                    __TS__SparseArrayPush(____array_19, if ____t_16(____TS__Number_result_15) then __O[2687] else 0)
                    local ____t_18 = __t
                    local ____TS__Number_result_17 = __TS__Number(homeX)
                    __O[2688] = ____TS__Number_result_17
                    __TS__SparseArrayPush(____array_19, if ____t_18(____TS__Number_result_17) then __O[2688] else 0, true)
                    ____overlay_20(__TS__SparseArraySpread(____array_19))
                end)
            end
            return
        end
        orig(
            nil,
            c,
            ____type,
            camera,
            t,
            homeX
        )
        local ____t_32 = __t
        local ____t_26 = __t
        local ____opt_23 = window.Graphics
        if ____opt_23 ~= nil then
            ____opt_23 = ____opt_23.isLite
        end
        local ____opt_result_25
        if ____opt_23 ~= nil then
            ____opt_result_25 = ____opt_23(____opt_23)
        end
        __O[2689] = ____opt_result_25
        local ____opt_29 = window.HdScene
        if ____opt_29 ~= nil then
            ____opt_29 = ____opt_29.active
        end
        local ____opt_result_31
        if ____opt_29 ~= nil then
            ____opt_result_31 = ____opt_29(____opt_29, ____type)
        end
        if ____t_32(if ____t_26(____opt_result_25) then __O[2689] else ____opt_result_31) then
            return
        end
        do
            pcall(function()
                local ____overlay_40 = overlay
                local ____array_39 = __TS__SparseArrayNew(nil, c, if type(____type) == "table" then ____type.type else ____type)
                local ____t_34 = __t
                local ____TS__Number_result_33 = __TS__Number(camera)
                __O[2690] = ____TS__Number_result_33
                __TS__SparseArrayPush(____array_39, if ____t_34(____TS__Number_result_33) then __O[2690] else 0)
                local ____t_36 = __t
                local ____TS__Number_result_35 = __TS__Number(t)
                __O[2691] = ____TS__Number_result_35
                __TS__SparseArrayPush(____array_39, if ____t_36(____TS__Number_result_35) then __O[2691] else 0)
                local ____t_38 = __t
                local ____TS__Number_result_37 = __TS__Number(homeX)
                __O[2692] = ____TS__Number_result_37
                __TS__SparseArrayPush(____array_39, if ____t_38(____TS__Number_result_37) then __O[2692] else 0)
                ____overlay_40(__TS__SparseArraySpread(____array_39))
            end)
        end
    end
    local C2 = __ord(
        {
            creuza = __ord({
                light = "255,170,210",
                crowd = "#3a2430",
                parts = "paper",
                spot = true,
                chant = false
            }, "light,crowd,parts,spot,chant"),
            tonhao = __ord({
                light = "255,170,90",
                crowd = "#2a2a32",
                parts = "smoke",
                spot = true,
                alarm = true
            }, "light,crowd,parts,spot,alarm"),
            valdomiro = __ord({light = "255,220,150", crowd = "#3a2a1e", parts = "leaves", spot = true}, "light,crowd,parts,spot"),
            kaua = __ord({
                light = "200,220,255",
                crowd = "#20263a",
                parts = "paperstorm",
                spot = true,
                rays = true
            }, "light,crowd,parts,spot,rays"),
            barao = __ord({light = "230,180,120", crowd = "#2e2218", parts = "steam", spot = true}, "light,crowd,parts,spot"),
            breno = __ord({light = "255,110,90", crowd = "#341e1e", parts = "embers", spot = true}, "light,crowd,parts,spot"),
            gemeos = __ord({
                light = "120,240,220",
                crowd = "#18282a",
                parts = "paper",
                spot = true,
                alarm = true
            }, "light,crowd,parts,spot,alarm"),
            fred = __ord({
                light = "255,230,150",
                crowd = "#2e2a1a",
                parts = "feathers",
                spot = true,
                rays = true
            }, "light,crowd,parts,spot,rays"),
            jorge = __ord({
                light = "190,150,255",
                crowd = nil,
                parts = "ink",
                spot = true,
                rays = true
            }, "light,crowd,parts,spot,rays")
        },
        "creuza,tonhao,valdomiro,kaua,barao,breno,gemeos,fred,jorge"
    )
    local function palco(self, c, tema, camera, t, homeX)
        if camera == nil then
            camera = 0
        end
        if t == nil then
            t = 0
        end
        if homeX == nil then
            homeX = 0
        end
        local ____t_46 = __t
        local ____opt_43 = window.Graphics
        if ____opt_43 ~= nil then
            ____opt_43 = ____opt_43.isLite
        end
        local ____opt_result_45
        if ____opt_43 ~= nil then
            ____opt_result_45 = ____opt_43(____opt_43)
        end
        if ____t_46(____opt_result_45) then
            return
        end
        do
            pcall(function()
                local ____overlay_56 = overlay
                local ____array_55 = __TS__SparseArrayNew(nil, c)
                local ____t_48 = __t
                local ____get_result_47 = __get(C2, tema)
                __O[2693] = ____get_result_47
                __TS__SparseArrayPush(____array_55, if ____t_48(____get_result_47) then __O[2693] else C2.creuza)
                local ____t_50 = __t
                local ____TS__Number_result_49 = __TS__Number(camera)
                __O[2694] = ____TS__Number_result_49
                __TS__SparseArrayPush(____array_55, if ____t_50(____TS__Number_result_49) then __O[2694] else 0)
                local ____t_52 = __t
                local ____TS__Number_result_51 = __TS__Number(t)
                __O[2695] = ____TS__Number_result_51
                __TS__SparseArrayPush(____array_55, if ____t_52(____TS__Number_result_51) then __O[2695] else 0)
                local ____t_54 = __t
                local ____TS__Number_result_53 = __TS__Number(homeX)
                __O[2696] = ____TS__Number_result_53
                __TS__SparseArrayPush(____array_55, if ____t_54(____TS__Number_result_53) then __O[2696] else 0)
                ____overlay_56(__TS__SparseArraySpread(____array_55))
            end)
        end
    end
    window.BossArena = __ord(
        {
            themes = __keys(THEME),
            palco = palco,
            temasC2 = __keys(C2)
        },
        "themes,palco,temasC2"
    )
end)(nil)
return ____exports
