--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __newExpr, __gt, __isFiniteN, __lenq, __ord, __arrL, __iterar, __t, __get, __set, __len, __call = __JSR.__newExpr, __JSR.__gt, __JSR.__isFiniteN, __JSR.__lenq, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__set, __JSR.__len, __JSR.__call
local __add, __new, __assign, __bor = __JSR.__add, __JSR.__new, __JSR.__assign, __JSR.__bor
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Number = ____lualib.__TS__Number
local Set = ____lualib.Set
local __TS__New = ____lualib.__TS__New
local __TS__Iterator = ____lualib.__TS__Iterator
local ____exports = {}
local __O = {};
(function()
    local clamp
    function clamp(self, v, a, b, def)
        return if __isFiniteN(v) then math.max(
            a,
            math.min(b, v)
        ) else def
    end
    local ____ = "use strict"
    if __t(window.DarocaAudio) then
        return
    end
    local KEY = "daroca-volumes-v1"
    local vol = __ord({music = 1, sfx = 1, ambient = true}, "music,sfx,ambient")
    do
        pcall(function()
            local d = window.JSON:parse(window.localStorage:getItem(KEY))
            if __t(d) then
                vol = __ord(
                    {
                        music = clamp(
                            nil,
                            __TS__Number(d.music),
                            0,
                            1,
                            1
                        ),
                        sfx = clamp(
                            nil,
                            __TS__Number(d.sfx),
                            0,
                            1,
                            1
                        ),
                        ambient = d.ambient ~= false
                    },
                    "music,sfx,ambient"
                )
            end
        end)
    end
    local listeners = __TS__New(Set)
    local function save()
        do
            pcall(function()
                window.localStorage:setItem(
                    KEY,
                    window.JSON:stringify(vol)
                )
            end)
        end
        __call(
            listeners,
            "forEach",
            function(____, fn)
                do
                    pcall(function()
                        fn(
                            nil,
                            __assign({}, vol)
                        )
                    end)
                end
            end
        )
    end
    local function soundOn()
        local ____t_2 = __t
        local ____opt_0 = window.Game
        if ____opt_0 ~= nil then
            ____opt_0 = ____opt_0.soundOn
        end
        return if ____t_2(____opt_0) then window.Game:soundOn() else true
    end
    local ctx = nil
    local master = nil
    local function ac(self)
        if not __t(ctx) then
            do
                local function ____catch(e)
                    return true, nil
                end
                local ____try, ____hasReturned, ____returnValue = pcall(function()
                    ctx = __newExpr(if __t(window.AudioContext) then window.AudioContext else window.webkitAudioContext)
                    master = ctx:createGain()
                    master:connect(ctx.destination)
                end)
                if not ____try then
                    ____hasReturned, ____returnValue = ____catch(____hasReturned)
                end
                if ____hasReturned then
                    return ____returnValue
                end
            end
        end
        if ctx.state == "suspended" then
            ctx:resume():catch(function()
            end)
        end
        return ctx
    end
    local function play(self, name, opts)
        if opts == nil then
            opts = {}
        end
        if __t(not __t(soundOn(nil)) or vol.sfx <= 0) then
            return
        end
        local a = ac(nil)
        if not __t(a) then
            return
        end
        local now = a.currentTime
        local out = a:createGain()
        out.gain.value = 0.05 * vol.sfx * if __t(opts.volume) then opts.volume else 1
        out:connect(master)
        local function tone(____, f, f2, d, ____type, at, v)
            if ____type == nil then
                ____type = "square"
            end
            if at == nil then
                at = 0
            end
            if v == nil then
                v = 1
            end
            local o = a:createOscillator()
            local g = a:createGain()
            o.type = ____type
            o.frequency:setValueAtTime(f, now + at)
            if __t(f2) then
                o.frequency:exponentialRampToValueAtTime(
                    math.max(30, f2),
                    __add(now + at, d)
                )
            end
            g.gain:setValueAtTime(v, now + at)
            g.gain:exponentialRampToValueAtTime(
                0.001,
                __add(now + at, d)
            )
            o:connect(g)
            g:connect(out)
            o:start(now + at)
            o:stop(__add(now + at, d) + 0.02)
        end
        local function noise(____, d, v, at, f, ____type)
            if v == nil then
                v = 1
            end
            if at == nil then
                at = 0
            end
            if f == nil then
                f = 0
            end
            if ____type == nil then
                ____type = "highpass"
            end
            local len = math.max(
                1,
                math.floor(a.sampleRate * d)
            )
            local buf = a:createBuffer(1, len, a.sampleRate)
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
            local s = a:createBufferSource()
            local g = a:createGain()
            s.buffer = buf
            g.gain.value = v
            local n = s
            if __t(f) then
                local fl = a:createBiquadFilter()
                fl.type = ____type
                fl.frequency.value = f
                s:connect(fl)
                n = fl
            end
            n:connect(g)
            g:connect(out)
            s:start(now + at)
        end
        repeat
            local ____switch27 = name
            local ____cond27 = ____switch27 == "quebra"
            if ____cond27 then
                noise(
                    nil,
                    0.18,
                    1.2,
                    0,
                    900
                )
                tone(
                    nil,
                    220,
                    90,
                    0.14,
                    "triangle",
                    0,
                    0.8
                )
                noise(
                    nil,
                    0.08,
                    0.6,
                    0.06,
                    2400
                )
                break
            end
            ____cond27 = ____cond27 or ____switch27 == "porta"
            if ____cond27 then
                tone(
                    nil,
                    180,
                    140,
                    0.25,
                    "sawtooth",
                    0,
                    0.35
                )
                tone(
                    nil,
                    320,
                    260,
                    0.2,
                    "triangle",
                    0.05,
                    0.3
                )
                noise(
                    nil,
                    0.06,
                    0.5,
                    0.25,
                    300,
                    "lowpass"
                )
                break
            end
            ____cond27 = ____cond27 or ____switch27 == "alavanca"
            if ____cond27 then
                tone(
                    nil,
                    400,
                    600,
                    0.06,
                    "square"
                )
                tone(
                    nil,
                    900,
                    900,
                    0.05,
                    "square",
                    0.08
                )
                break
            end
            ____cond27 = ____cond27 or ____switch27 == "agua"
            if ____cond27 then
                noise(
                    nil,
                    0.25,
                    0.9,
                    0,
                    1200,
                    "bandpass"
                )
                tone(
                    nil,
                    700,
                    300,
                    0.12,
                    "sine",
                    0,
                    0.6
                )
                break
            end
            ____cond27 = ____cond27 or ____switch27 == "mato"
            if ____cond27 then
                noise(
                    nil,
                    0.16,
                    0.7,
                    0,
                    3400
                )
                noise(
                    nil,
                    0.12,
                    0.5,
                    0.05,
                    1500,
                    "bandpass"
                )
                break
            end
            ____cond27 = ____cond27 or ____switch27 == "tac"
            if ____cond27 then
                tone(
                    nil,
                    1400,
                    800,
                    0.04,
                    "square"
                )
                noise(
                    nil,
                    0.04,
                    0.7,
                    0,
                    3000
                )
                break
            end
            ____cond27 = ____cond27 or ____switch27 == "fogo"
            if ____cond27 then
                noise(
                    nil,
                    0.5,
                    0.8,
                    0,
                    500,
                    "lowpass"
                )
                noise(
                    nil,
                    0.3,
                    0.4,
                    0.1,
                    2000
                )
                break
            end
            ____cond27 = ____cond27 or ____switch27 == "moeda"
            if ____cond27 then
                tone(
                    nil,
                    988,
                    988,
                    0.07,
                    "square"
                )
                tone(
                    nil,
                    1319,
                    1319,
                    0.14,
                    "square",
                    0.07
                )
                break
            end
            ____cond27 = ____cond27 or ____switch27 == "pulo"
            if ____cond27 then
                tone(
                    nil,
                    300,
                    600,
                    0.1,
                    "square",
                    0,
                    0.6
                )
                break
            end
            ____cond27 = ____cond27 or ____switch27 == "impacto"
            if ____cond27 then
                tone(
                    nil,
                    140,
                    40,
                    0.3,
                    "square"
                )
                noise(nil, 0.2, 0.8)
                break
            end
            ____cond27 = ____cond27 or ____switch27 == "sino"
            if ____cond27 then
                tone(
                    nil,
                    880,
                    870,
                    1,
                    "sine"
                )
                tone(
                    nil,
                    1320,
                    1300,
                    0.8,
                    "sine",
                    0,
                    0.5
                )
                break
            end
            ____cond27 = ____cond27 or ____switch27 == "buzina"
            if ____cond27 then
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
                    0.28,
                    "sawtooth",
                    0.22
                )
                break
            end
            do
                tone(
                    nil,
                    660,
                    600,
                    0.1,
                    "square"
                )
            end
        until true
    end
    local PROFILES = {
        ["0"] = __ord(
            {
                name = "roca",
                beds = __arrL(
                    {__arrL({"lowpass", 380, 0.5, 0.12}, 4)},
                    1
                ),
                events = __arrL({"passaro", "passaro", "galinha"}, 3)
            },
            "name,beds,events"
        ),
        ["1"] = __ord(
            {
                name = "escola",
                beds = __arrL(
                    {__arrL({"bandpass", 700, 0.25, 0.5}, 4)},
                    1
                ),
                events = __arrL({"criancas"}, 1)
            },
            "name,beds,events"
        ),
        ["2"] = __ord(
            {
                name = "academia",
                beds = __arrL(
                    {__arrL({"lowpass", 120, 0.45, 0.05}, 4)},
                    1
                ),
                events = __arrL({"ferro"}, 1)
            },
            "name,beds,events"
        ),
        ["3"] = __ord(
            {
                name = "quadra",
                beds = __arrL(
                    {__arrL({"bandpass", 520, 0.4, 0.7}, 4)},
                    1
                ),
                events = __arrL({"apito", "torcida"}, 2)
            },
            "name,beds,events"
        ),
        ["4"] = __ord(
            {
                name = "praca",
                beds = __arrL(
                    {
                        __arrL({"bandpass", 900, 0.5, 0.2}, 4),
                        __arrL({"lowpass", 160, 0.2, 0.05}, 4)
                    },
                    2
                ),
                events = __arrL({"passaro"}, 1)
            },
            "name,beds,events"
        ),
        ["5"] = __ord(
            {
                name = "favela",
                beds = __arrL(
                    {__arrL({"bandpass", 650, 0.3, 0.5}, 4)},
                    1
                ),
                events = __arrL({"cachorro", "criancas"}, 2)
            },
            "name,beds,events"
        ),
        ["6"] = __ord(
            {
                name = "caderno",
                beds = __arrL(
                    {__arrL({"lowpass", 90, 0.6, 0.03}, 4)},
                    1
                ),
                drone = true,
                events = __arrL({"sussurro"}, 1)
            },
            "name,beds,drone,events"
        ),
        ["7"] = __ord(
            {
                name = "campo",
                beds = __arrL(
                    {__arrL({"bandpass", 480, 0.45, 0.7}, 4)},
                    1
                ),
                events = __arrL({"apito", "torcida"}, 2)
            },
            "name,beds,events"
        ),
        ["8"] = __ord(
            {
                name = "bigodon",
                beds = __arrL(
                    {__arrL({"lowpass", 140, 0.3, 0.05}, 4)},
                    1
                ),
                events = __arrL({"maquina"}, 1)
            },
            "name,beds,events"
        ),
        ["9"] = __ord(
            {
                name = "patio",
                beds = __arrL(
                    {__arrL({"bandpass", 760, 0.3, 0.5}, 4)},
                    1
                ),
                events = __arrL({"criancas"}, 1)
            },
            "name,beds,events"
        ),
        ["10"] = __ord(
            {
                name = "rayssa",
                beds = __arrL(
                    {__arrL({"lowpass", 110, 0.25, 0.04}, 4)},
                    1
                ),
                events = __arrL({"relogio"}, 1)
            },
            "name,beds,events"
        )
    }
    local amb = nil
    local ambNoise = nil
    local fileAmb = nil
    local fileAmbKey = ""
    local nextEvent = 0
    local lastKey = ""
    local function noiseBuffer(self, a)
        if __t(ambNoise) then
            return ambNoise
        end
        local len = a.sampleRate * 3
        local buf = a:createBuffer(1, len, a.sampleRate)
        local ch = buf:getChannelData(0)
        local b = 0
        do
            local i = 0
            while i < len do
                b = b * 0.97 + (math.random() * 2 - 1) * 0.03
                __set(
                    ch,
                    i,
                    (math.random() * 2 - 1) * 0.6 + b * 6
                )
                i = i + 1
            end
        end
        ambNoise = buf
        return ambNoise
    end
    local function stopAmb(self)
        if not __t(amb) then
            return
        end
        local old = amb
        amb = nil
        do
            pcall(function()
                old.gain.gain:cancelScheduledValues(old.ctx.currentTime)
                old.gain.gain:setTargetAtTime(0, old.ctx.currentTime, 0.4)
                window:setTimeout(
                    function() return __call(
                        old.nodes,
                        "forEach",
                        function(____, n)
                            do
                                pcall(function()
                                    local ____this_4
                                    ____this_4 = n
                                    local ____opt_3 = ____this_4.stop
                                    if ____opt_3 ~= nil then
                                        ____opt_3(____this_4)
                                    end
                                    n:disconnect()
                                end)
                            end
                        end
                    ) end,
                    2500
                )
            end)
        end
    end
    local function startAmb(self, scene, night)
        local a = ac(nil)
        local p = __get(PROFILES, scene)
        if __t(not __t(a) or not __t(p)) then
            return
        end
        local gain = a:createGain()
        gain.gain.value = 0
        gain:connect(master)
        local nodes = __arrL({gain}, 1)
        for ____, ____value in __iterar((p.beds)) do
            local ____type = ____value[1]
            local f = ____value[2]
            local v = ____value[3]
            local mod = ____value[4]
            local s = a:createBufferSource()
            s.buffer = noiseBuffer(nil, a)
            s.loop = true
            local fl = a:createBiquadFilter()
            fl.type = ____type
            fl.frequency.value = f
            fl.Q.value = if ____type == "bandpass" then 0.7 else 0.5
            local g = a:createGain()
            g.gain.value = v
            if __t(mod) then
                local lfo = a:createOscillator()
                local lg = a:createGain()
                lfo.frequency.value = 0.07 + math.random() * 0.1
                lg.gain.value = v * mod
                lfo:connect(lg)
                lg:connect(g.gain)
                lfo:start()
                __call(nodes, "push", lfo)
            end
            s:connect(fl)
            fl:connect(g)
            g:connect(gain)
            s:start(
                0,
                math.random() * 2
            )
            __call(
                nodes,
                "push",
                s,
                fl,
                g
            )
        end
        if __t(p.drone) then
            for ____, f in __iterar((__arrL({55, 58.3, 110.4}, 3))) do
                local o = a:createOscillator()
                local g = a:createGain()
                o.type = "sine"
                o.frequency.value = f
                g.gain.value = 0.12
                o:connect(g)
                g:connect(gain)
                o:start()
                __call(nodes, "push", o, g)
            end
        end
        amb = {
            scene = scene,
            night = night,
            ctx = a,
            gain = gain,
            nodes = nodes,
            rain = nil
        }
    end
    local function ambEvent(self, kind, night)
        local a = ctx
        if __t(not __t(a) or not __t(amb)) then
            return
        end
        local now = a.currentTime
        local out = a:createGain()
        out.gain.value = 0.5
        out:connect(amb.gain)
        local function chirp(____, f, f2, d, at, v, ____type)
            if v == nil then
                v = 0.5
            end
            if ____type == nil then
                ____type = "sine"
            end
            local o = a:createOscillator()
            local g = a:createGain()
            o.type = ____type
            o.frequency:setValueAtTime(
                f,
                __add(now, at)
            )
            o.frequency:exponentialRampToValueAtTime(
                f2,
                __add(
                    __add(now, at),
                    d
                )
            )
            g.gain:setValueAtTime(
                0,
                __add(now, at)
            )
            g.gain:linearRampToValueAtTime(
                v,
                __add(now, at) + d * 0.2
            )
            g.gain:exponentialRampToValueAtTime(
                0.001,
                __add(
                    __add(now, at),
                    d
                )
            )
            o:connect(g)
            g:connect(out)
            o:start(__add(now, at))
            o:stop(__add(
                __add(now, at),
                d
            ) + 0.05)
        end
        if __t(if __t(night) then kind == "passaro" or kind == "galinha" else night) then
            kind = "grilo"
        end
        repeat
            local ____switch50 = kind
            local ____cond50 = ____switch50 == "passaro"
            if ____cond50 then
                do
                    local base = 2400 + math.random() * 1600
                    do
                        local i = 0
                        while i < 2 + __bor(
                            math.random() * 3,
                            0
                        ) do
                            chirp(
                                nil,
                                base,
                                base * (1.2 + math.random() * 0.4),
                                0.08,
                                i * 0.13,
                                0.25
                            )
                            i = i + 1
                        end
                    end
                    break
                end
            end
            ____cond50 = ____cond50 or ____switch50 == "galinha"
            if ____cond50 then
                chirp(
                    nil,
                    700,
                    600,
                    0.12,
                    0,
                    0.2,
                    "sawtooth"
                )
                chirp(
                    nil,
                    750,
                    520,
                    0.18,
                    0.16,
                    0.2,
                    "sawtooth"
                )
                break
            end
            ____cond50 = ____cond50 or ____switch50 == "grilo"
            if ____cond50 then
                do
                    local i = 0
                    while i < 6 do
                        chirp(
                            nil,
                            4600,
                            4500,
                            0.03,
                            i * 0.06,
                            0.12,
                            "square"
                        )
                        i = i + 1
                    end
                end
                break
            end
            ____cond50 = ____cond50 or ____switch50 == "apito"
            if ____cond50 then
                chirp(
                    nil,
                    2500,
                    2450,
                    0.35,
                    0,
                    0.2
                )
                break
            end
            ____cond50 = ____cond50 or ____switch50 == "torcida"
            if ____cond50 then
                do
                    local s = a:createBufferSource()
                    s.buffer = noiseBuffer(nil, a)
                    local fl = a:createBiquadFilter()
                    fl.type = "bandpass"
                    fl.frequency.value = 600
                    local g = a:createGain()
                    g.gain:setValueAtTime(0, now)
                    g.gain:linearRampToValueAtTime(0.9, now + 0.4)
                    g.gain:linearRampToValueAtTime(0, now + 1.8)
                    s:connect(fl)
                    fl:connect(g)
                    g:connect(out)
                    s:start(
                        now,
                        math.random()
                    )
                    s:stop(now + 2)
                    break
                end
            end
            ____cond50 = ____cond50 or ____switch50 == "criancas"
            if ____cond50 then
                do
                    local i = 0
                    while i < 3 do
                        chirp(
                            nil,
                            500 + math.random() * 300,
                            650 + math.random() * 300,
                            0.15,
                            i * 0.2,
                            0.06,
                            "triangle"
                        )
                        i = i + 1
                    end
                end
                break
            end
            ____cond50 = ____cond50 or ____switch50 == "cachorro"
            if ____cond50 then
                chirp(
                    nil,
                    420,
                    260,
                    0.14,
                    0,
                    0.25,
                    "sawtooth"
                )
                chirp(
                    nil,
                    440,
                    250,
                    0.14,
                    0.25,
                    0.25,
                    "sawtooth"
                )
                break
            end
            ____cond50 = ____cond50 or ____switch50 == "ferro"
            if ____cond50 then
                chirp(
                    nil,
                    320,
                    300,
                    0.5,
                    0,
                    0.2,
                    "triangle"
                )
                chirp(
                    nil,
                    900,
                    880,
                    0.3,
                    0,
                    0.08,
                    "square"
                )
                break
            end
            ____cond50 = ____cond50 or ____switch50 == "sussurro"
            if ____cond50 then
                chirp(
                    nil,
                    180,
                    120,
                    1.2,
                    0,
                    0.1,
                    "triangle"
                )
                break
            end
            ____cond50 = ____cond50 or ____switch50 == "maquina"
            if ____cond50 then
                chirp(
                    nil,
                    110,
                    112,
                    1.2,
                    0,
                    0.08,
                    "sawtooth"
                )
                break
            end
            ____cond50 = ____cond50 or ____switch50 == "relogio"
            if ____cond50 then
                chirp(
                    nil,
                    1800,
                    1800,
                    0.02,
                    0,
                    0.15,
                    "square"
                )
                chirp(
                    nil,
                    1500,
                    1500,
                    0.02,
                    0.5,
                    0.12,
                    "square"
                )
                break
            end
        until true
    end
    local function fileAmbient(self, scene)
        local ____t_10 = __t
        local ____opt_7 = window.DarocaMusicas
        if ____opt_7 ~= nil then
            ____opt_7 = ____opt_7.ambient
        end
        local ____opt_result_9
        if ____opt_7 ~= nil then
            ____opt_result_9 = ____opt_7(____opt_7)
        end
        __O[2300] = ____opt_result_9
        local map = if ____t_10(____opt_result_9) then __O[2300] else {}
        local p = __get(PROFILES, scene)
        local ____t_12 = __t
        local ____get_result_11 = __get(map, p.name)
        __O[2301] = ____get_result_11
        return if __t(p) then if ____t_12(____get_result_11) then __O[2301] else nil else nil
    end
    local function tick(self)
        local st = nil
        do
            pcall(function()
                local ____opt_15 = window.Game
                if ____opt_15 ~= nil then
                    ____opt_15 = ____opt_15.getAudioState
                end
                local ____opt_result_17
                if ____opt_15 ~= nil then
                    ____opt_result_17 = ____opt_15(____opt_15)
                end
                st = ____opt_result_17
            end)
        end
        local ____opt_20 = window.Fliperama
        if ____opt_20 ~= nil then
            ____opt_20 = ____opt_20.isOpen
        end
        local ____opt_result_22
        if ____opt_20 ~= nil then
            ____opt_result_22 = ____opt_20(____opt_20)
        end
        local fl = ____opt_result_22
        local ____t_40 = __t
        local ____t_38 = __t
        local ____t_36 = __t
        local ____t_34 = __t
        local ____t_32 = __t
        local ____t_30 = __t
        local ____t_28 = __t
        local ____t_26 = __t
        local ____t_24 = __t
        local ____temp_23 = not not __t(st)
        __O[2302] = ____temp_23
        local ____temp_25 = if ____t_24(____temp_23) then st.started else __O[2302]
        __O[2303] = ____temp_25
        local ____temp_27 = if ____t_26(____temp_25) then st.playing ~= false else __O[2303]
        __O[2304] = ____temp_27
        local ____temp_29 = if ____t_28(____temp_27) then not __t(st.paused) else __O[2304]
        __O[2305] = ____temp_29
        local ____temp_31 = if ____t_30(____temp_29) then not __t(st.cutscene) else __O[2305]
        __O[2306] = ____temp_31
        local ____temp_33 = if ____t_32(____temp_31) then not __t(st.room) else __O[2306]
        __O[2307] = ____temp_33
        local ____temp_35 = if ____t_34(____temp_33) then not __t(fl) else __O[2307]
        __O[2308] = ____temp_35
        local ____temp_37 = if ____t_36(____temp_35) then soundOn(nil) else __O[2308]
        __O[2309] = ____temp_37
        local ____temp_39 = if ____t_38(____temp_37) then vol.ambient else __O[2309]
        __O[2310] = ____temp_39
        local live = if ____t_40(____temp_39) then vol.sfx > 0 else __O[2310]
        local scene = if __t(live) then __TS__Number(st.scene) else -1
        local ____opt_43 = window.DayTime
        if ____opt_43 ~= nil then
            ____opt_43 = ____opt_43.state
        end
        local ____opt_result_45
        if ____opt_43 ~= nil then
            ____opt_result_45 = ____opt_43(____opt_43)
        end
        local s = ____opt_result_45
        local night = not not __t(s) and __gt(s.night, 0.55)
        local file = if __t(live) then fileAmbient(nil, scene) else nil
        if __t(file) then
            if fileAmbKey ~= file then
                do
                    pcall(function()
                        if fileAmb ~= nil then
                            fileAmb:pause()
                        end
                    end)
                end
                fileAmb = __new("Audio", file)
                fileAmb.loop = true
                fileAmbKey = file
                fileAmb:play():catch(function()
                end)
            end
            fileAmb.volume = math.min(1, 0.5 * vol.sfx * if __t(st.boss) then 0.4 else 1)
            if __t(amb) then
                stopAmb(nil)
            end
        elseif __t(fileAmb) then
            do
                pcall(function()
                    fileAmb:pause()
                end)
            end
            fileAmb = nil
            fileAmbKey = ""
        end
        local ____t_52 = __t
        local ____t_51 = __t
        local ____t_49 = __t
        local ____temp_48 = not __t(file)
        __O[2311] = ____temp_48
        local ____temp_50 = if ____t_49(____temp_48) then live else __O[2311]
        __O[2312] = ____temp_50
        local key = if ____t_52(if ____t_51(____temp_50) then __get(PROFILES, scene) else __O[2312]) then __add(scene, "") else ""
        if key ~= lastKey then
            lastKey = key
            stopAmb(nil)
            if __t(key) then
                startAmb(nil, scene, night)
            end
        end
        if __t(if __t(amb) then ctx else amb) then
            local ____temp_57 = 0.07 * vol.sfx
            local ____t_56 = __t
            local ____opt_result_55
            if st ~= nil then
                ____opt_result_55 = st.boss
            end
            local level = ____temp_57 * if ____t_56(____opt_result_55) then 0.35 else 1
            amb.gain.gain:setTargetAtTime(level, ctx.currentTime, 0.6)
            local ____t_66 = __t
            local ____opt_62 = window.Weather
            if ____opt_62 ~= nil then
                ____opt_62 = ____opt_62.state
            end
            local ____opt_result_64
            if ____opt_62 ~= nil then
                ____opt_result_64 = ____opt_62(____opt_62)
            end
            local ____opt_result_65
            if ____opt_result_64 ~= nil then
                ____opt_result_65 = ____opt_result_64.rain
            end
            __O[2313] = ____opt_result_65
            local rain = if ____t_66(____opt_result_65) then __O[2313] else 0
            if __t(__gt(rain, 0.15) and not __t(amb.rain)) then
                local s2 = ctx:createBufferSource()
                s2.buffer = noiseBuffer(nil, ctx)
                s2.loop = true
                local f = ctx:createBiquadFilter()
                f.type = "highpass"
                f.frequency.value = 1400
                local g = ctx:createGain()
                g.gain.value = 0
                s2:connect(f)
                f:connect(g)
                g:connect(amb.gain)
                s2:start()
                amb.rain = g
                __call(
                    amb.nodes,
                    "push",
                    s2,
                    f,
                    g
                )
            end
            if __t(amb.rain) then
                amb.rain.gain:setTargetAtTime(
                    math.min(1.2, rain * 1.4),
                    ctx.currentTime,
                    1
                )
            end
            local t = window.performance:now()
            if t > nextEvent then
                nextEvent = t + 1500 + math.random() * 4500
                local ev = __get(PROFILES, amb.scene).events
                local ____t_69 = __t
                local ____t_68 = __t
                local ____lenq_result_67 = __lenq(ev)
                __O[2314] = ____lenq_result_67
                if ____t_69(if ____t_68(____lenq_result_67) then math.random() < 0.8 else __O[2314]) then
                    ambEvent(
                        nil,
                        __get(
                            ev,
                            __bor(
                                math.random() * __len(ev),
                                0
                            )
                        ),
                        night
                    )
                end
            end
        end
    end
    window:setInterval(tick, 400)
    local function unlock()
        if __t(soundOn(nil)) then
            ac(nil)
        end
    end
    window:addEventListener("pointerdown", unlock, {passive = true})
    window:addEventListener("keydown", unlock)
    window.DarocaAudio = __ord(
        {
            music = function() return vol.music end,
            sfx = function() return vol.sfx end,
            ambientOn = function() return vol.ambient end,
            setMusic = function(____, v)
                vol.music = clamp(
                    nil,
                    __TS__Number(v),
                    0,
                    1,
                    1
                )
                save(nil)
            end,
            setSfx = function(____, v)
                vol.sfx = clamp(
                    nil,
                    __TS__Number(v),
                    0,
                    1,
                    1
                )
                save(nil)
            end,
            setAmbient = function(____, on)
                vol.ambient = not not __t(on)
                save(nil)
            end,
            onChange = function(____, fn)
                __call(listeners, "add", fn)
                return function() return __call(listeners, "delete", fn) end
            end,
            play = play,
            status = function()
                local ____opt_70 = __get(PROFILES, amb.scene)
                if ____opt_70 ~= nil then
                    ____opt_70 = ____opt_70.name
                end
                local ____temp_80 = if __t(amb) then ____opt_70 else if __t(fileAmbKey) then fileAmbKey else nil
                local ____t_75 = __t
                local ____opt_result_74
                if amb ~= nil then
                    ____opt_result_74 = amb.rain
                end
                local ____temp_81 = not not ____t_75(____opt_result_74)
                local ____t_79 = __t
                local ____opt_result_78
                if ctx ~= nil then
                    ____opt_result_78 = ctx.state
                end
                __O[2315] = ____opt_result_78
                return {ambiente = ____temp_80, chuva = ____temp_81, contexto = if ____t_79(____opt_result_78) then __O[2315] else "sem áudio"}
            end
        },
        "music,sfx,ambientOn,setMusic,setSfx,setAmbient,onChange,play,status"
    )
end)(nil)
return ____exports
