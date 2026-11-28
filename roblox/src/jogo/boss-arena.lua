--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __mod, __ord, __arrL, __iterar, __t, __get, __call, __add, __keys = __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__call, __JSR.__add, __JSR.__keys
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Number = ____lualib.__TS__Number
local __TS__Iterator = ____lualib.__TS__Iterator
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    local ____t_3 = __t
    local ____t_result_2
    local ____t_1 = __t
    local ____temp_0 = not __t(window.Art) or not __t(window.Art.drawArena)
    __O[2706] = ____temp_0
    if ____t_1(____temp_0) then
        ____t_result_2 = __O[2706]
    else
        ____t_result_2 = window.BossArena
    end
    if ____t_3(____t_result_2) then
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
                do
                    local x = __mod(
                        i * 23 + __mod(i, 3) * 7,
                        1000
                    ) - 20
                    local depth = __mod(i, 2)
                    local y = 440 - (__t(depth) and 6 or 0)
                    local h = 44 + rnd(nil, i) * 16 - depth * 6
                    local jump = math.max(
                        0,
                        math.sin(beat * math.pi + i * 1.7)
                    ) * (__t(cheer) and 7 or 3)
                    if __t(math.abs(x - center) < 150 and not __t(depth)) then
                        do i = i + 1 continue end
                    end
                    local yy = y - jump
                    local ____t_result_4
                    if __t(depth) then
                        ____t_result_4 = col
                    else
                        ____t_result_4 = __add(col, "ee")
                    end
                    local shade = ____t_result_4
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
                        yy - h + (__t(up) and -20 or 2),
                        4,
                        __t(up) and 22 or 16,
                        shade
                    )
                    R(
                        nil,
                        c,
                        x + 7,
                        yy - h + (__t(up) and -22 or 4),
                        4,
                        __t(up) and 24 or 14,
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
            local n = kind == "paper" and 16 or 60
            do
                local i = 0
                while i < n do
                    local sp = kind == "paper" and 40 or 160
                    local a = t * (kind == "paper" and 0.3 or 1.4) + i
                    local ____temp_5
                    if kind == "paper" then
                        ____temp_5 = __mod(
                            rnd(nil, i) * 1100 + t * sp,
                            1100
                        ) - 70
                    else
                        ____temp_5 = center + math.cos(a) * (120 + rnd(nil, i) * 300)
                    end
                    local x = ____temp_5
                    local ____temp_6
                    if kind == "paper" then
                        ____temp_6 = 80 + rnd(nil, i * 3) * 300 + math.sin(t * 2 + i) * 20
                    else
                        ____temp_6 = 260 + math.sin(a * 1.3) * (60 + rnd(nil, i * 5) * 150)
                    end
                    local y = ____temp_6
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
                    local dir = __t(__mod(i, 2)) and 1 or -1
                    local ____temp_7
                    if dir > 0 then
                        ____temp_7 = x
                    else
                        ____temp_7 = 960 - x
                    end
                    local xx = ____temp_7
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
                        __t(__mod(i, 3)) and "#ffb347" or "#ffe08a"
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
                        __t(__mod(i, 2)) and "#7aa84a" or "#c9a24a"
                    )
                    i = i + 1
                end
            end
        end
        c:restore()
    end
    local function overlay(self, c, ____type, camera, t, homeX, hd)
        local ____t_result_12
        local ____t_11 = __t
        local ____t_result_10
        local ____t_9 = __t
        local ____t_result_8
        if __t(____type) then
            ____t_result_8 = type(____type) == "table"
        else
            ____t_result_8 = ____type
        end
        __O[2707] = ____t_result_8
        if ____t_9(____t_result_8) then
            ____t_result_10 = ____type.light
        else
            ____t_result_10 = __O[2707]
        end
        if ____t_11(____t_result_10) then
            ____t_result_12 = ____type
        else
            ____t_result_12 = __get(THEME, ____type)
        end
        local th = ____t_result_12
        if not __t(th) then
            return
        end
        local ____t_result_13
        if __t(homeX) then
            ____t_result_13 = homeX - camera
        else
            ____t_result_13 = 480
        end
        local center = ____t_result_13
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
                while i < (__t(hd) and 0 or 6) do
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
                a > 0.5 and "#ff3a3a" or "#7a1a1a"
            )
        end
        particles(
            nil,
            c,
            th.parts,
            t,
            center
        )
        local ____t_15 = __t
        local ____t_result_14
        if __t(th.crowd) then
            ____t_result_14 = not __t(hd)
        else
            ____t_result_14 = th.crowd
        end
        if ____t_15(____t_result_14) then
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
        local ____t_23 = __t
        local ____t_result_22
        local ____t_21 = __t
        local ____opt_18 = window.HdMaps
        if ____opt_18 ~= nil then
            ____opt_18 = ____opt_18.arenaHandles
        end
        local ____opt_result_20
        if ____opt_18 ~= nil then
            ____opt_result_20 = ____opt_18(____opt_18, ____type)
        end
        __O[2708] = ____opt_result_20
        if ____t_21(____opt_result_20) then
            ____t_result_22 = window.HdMaps:drawArena(
                c,
                ____type,
                camera,
                t,
                homeX
            )
        else
            ____t_result_22 = __O[2708]
        end
        if ____t_23(____t_result_22) then
            do
                pcall(function()
                    local ____overlay_35 = overlay
                    local ____c_34 = c
                    local ____temp_24
                    if type(____type) == "table" then
                        ____temp_24 = ____type.type
                    else
                        ____temp_24 = ____type
                    end
                    local ____t_result_27
                    local ____t_26 = __t
                    local ____TS__Number_result_25 = __TS__Number(camera)
                    __O[2709] = ____TS__Number_result_25
                    if ____t_26(____TS__Number_result_25) then
                        ____t_result_27 = __O[2709]
                    else
                        ____t_result_27 = 0
                    end
                    local ____t_result_30
                    local ____t_29 = __t
                    local ____TS__Number_result_28 = __TS__Number(t)
                    __O[2710] = ____TS__Number_result_28
                    if ____t_29(____TS__Number_result_28) then
                        ____t_result_30 = __O[2710]
                    else
                        ____t_result_30 = 0
                    end
                    local ____t_result_33
                    local ____t_32 = __t
                    local ____TS__Number_result_31 = __TS__Number(homeX)
                    __O[2711] = ____TS__Number_result_31
                    if ____t_32(____TS__Number_result_31) then
                        ____t_result_33 = __O[2711]
                    else
                        ____t_result_33 = 0
                    end
                    ____overlay_35(
                        nil,
                        ____c_34,
                        ____temp_24,
                        ____t_result_27,
                        ____t_result_30,
                        ____t_result_33,
                        true
                    )
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
        local ____t_48 = __t
        local ____t_result_47
        local ____t_41 = __t
        local ____opt_38 = window.Graphics
        if ____opt_38 ~= nil then
            ____opt_38 = ____opt_38.isLite
        end
        local ____opt_result_40
        if ____opt_38 ~= nil then
            ____opt_result_40 = ____opt_38(____opt_38)
        end
        __O[2712] = ____opt_result_40
        if ____t_41(____opt_result_40) then
            ____t_result_47 = __O[2712]
        else
            local ____opt_44 = window.HdScene
            if ____opt_44 ~= nil then
                ____opt_44 = ____opt_44.active
            end
            local ____opt_result_46
            if ____opt_44 ~= nil then
                ____opt_result_46 = ____opt_44(____opt_44, ____type)
            end
            ____t_result_47 = ____opt_result_46
        end
        if ____t_48(____t_result_47) then
            return
        end
        do
            pcall(function()
                local ____overlay_60 = overlay
                local ____c_59 = c
                local ____temp_49
                if type(____type) == "table" then
                    ____temp_49 = ____type.type
                else
                    ____temp_49 = ____type
                end
                local ____t_result_52
                local ____t_51 = __t
                local ____TS__Number_result_50 = __TS__Number(camera)
                __O[2713] = ____TS__Number_result_50
                if ____t_51(____TS__Number_result_50) then
                    ____t_result_52 = __O[2713]
                else
                    ____t_result_52 = 0
                end
                local ____t_result_55
                local ____t_54 = __t
                local ____TS__Number_result_53 = __TS__Number(t)
                __O[2714] = ____TS__Number_result_53
                if ____t_54(____TS__Number_result_53) then
                    ____t_result_55 = __O[2714]
                else
                    ____t_result_55 = 0
                end
                local ____t_result_58
                local ____t_57 = __t
                local ____TS__Number_result_56 = __TS__Number(homeX)
                __O[2715] = ____TS__Number_result_56
                if ____t_57(____TS__Number_result_56) then
                    ____t_result_58 = __O[2715]
                else
                    ____t_result_58 = 0
                end
                ____overlay_60(
                    nil,
                    ____c_59,
                    ____temp_49,
                    ____t_result_52,
                    ____t_result_55,
                    ____t_result_58
                )
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
        local ____t_66 = __t
        local ____opt_63 = window.Graphics
        if ____opt_63 ~= nil then
            ____opt_63 = ____opt_63.isLite
        end
        local ____opt_result_65
        if ____opt_63 ~= nil then
            ____opt_result_65 = ____opt_63(____opt_63)
        end
        if ____t_66(____opt_result_65) then
            return
        end
        do
            pcall(function()
                local ____overlay_80 = overlay
                local ____c_79 = c
                local ____t_result_69
                local ____t_68 = __t
                local ____get_result_67 = __get(C2, tema)
                __O[2716] = ____get_result_67
                if ____t_68(____get_result_67) then
                    ____t_result_69 = __O[2716]
                else
                    ____t_result_69 = C2.creuza
                end
                local ____t_result_72
                local ____t_71 = __t
                local ____TS__Number_result_70 = __TS__Number(camera)
                __O[2717] = ____TS__Number_result_70
                if ____t_71(____TS__Number_result_70) then
                    ____t_result_72 = __O[2717]
                else
                    ____t_result_72 = 0
                end
                local ____t_result_75
                local ____t_74 = __t
                local ____TS__Number_result_73 = __TS__Number(t)
                __O[2718] = ____TS__Number_result_73
                if ____t_74(____TS__Number_result_73) then
                    ____t_result_75 = __O[2718]
                else
                    ____t_result_75 = 0
                end
                local ____t_result_78
                local ____t_77 = __t
                local ____TS__Number_result_76 = __TS__Number(homeX)
                __O[2719] = ____TS__Number_result_76
                if ____t_77(____TS__Number_result_76) then
                    ____t_result_78 = __O[2719]
                else
                    ____t_result_78 = 0
                end
                ____overlay_80(
                    nil,
                    ____c_79,
                    ____t_result_69,
                    ____t_result_72,
                    ____t_result_75,
                    ____t_result_78
                )
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
