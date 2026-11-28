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
        local ____isFiniteN_result_0
        if __isFiniteN(v) then
            ____isFiniteN_result_0 = math.max(
                a,
                math.min(b, v)
            )
        else
            ____isFiniteN_result_0 = def
        end
        return ____isFiniteN_result_0
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
        local ____t_result_4
        local ____t_3 = __t
        local ____opt_1 = window.Game
        if ____opt_1 ~= nil then
            ____opt_1 = ____opt_1.soundOn
        end
        if ____t_3(____opt_1) then
            ____t_result_4 = window.Game:soundOn()
        else
            ____t_result_4 = true
        end
        return ____t_result_4
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
                    local ____newExpr_6 = __newExpr
                    local ____t_result_5
                    if __t(window.AudioContext) then
                        ____t_result_5 = window.AudioContext
                    else
                        ____t_result_5 = window.webkitAudioContext
                    end
                    ctx = ____newExpr_6(____t_result_5)
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
        local ____out_gain_9 = out.gain
        local ____temp_8 = 0.05 * vol.sfx
        local ____t_result_7
        if __t(opts.volume) then
            ____t_result_7 = opts.volume
        else
            ____t_result_7 = 1
        end
        ____out_gain_9.value = ____temp_8 * ____t_result_7
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
                                    local ____this_11
                                    ____this_11 = n
                                    local ____opt_10 = ____this_11.stop
                                    if ____opt_10 ~= nil then
                                        ____opt_10(____this_11)
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
            fl.Q.value = ____type == "bandpass" and 0.7 or 0.5
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
        local ____t_13 = __t
        local ____t_result_12
        if __t(night) then
            ____t_result_12 = kind == "passaro" or kind == "galinha"
        else
            ____t_result_12 = night
        end
        if ____t_13(____t_result_12) then
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
        local ____t_result_20
        local ____t_19 = __t
        local ____opt_16 = window.DarocaMusicas
        if ____opt_16 ~= nil then
            ____opt_16 = ____opt_16.ambient
        end
        local ____opt_result_18
        if ____opt_16 ~= nil then
            ____opt_result_18 = ____opt_16(____opt_16)
        end
        __O[2327] = ____opt_result_18
        if ____t_19(____opt_result_18) then
            ____t_result_20 = __O[2327]
        else
            ____t_result_20 = {}
        end
        local map = ____t_result_20
        local p = __get(PROFILES, scene)
        local ____t_result_24
        if __t(p) then
            local ____t_result_23
            local ____t_22 = __t
            local ____get_result_21 = __get(map, p.name)
            __O[2328] = ____get_result_21
            if ____t_22(____get_result_21) then
                ____t_result_23 = __O[2328]
            else
                ____t_result_23 = nil
            end
            ____t_result_24 = ____t_result_23
        else
            ____t_result_24 = nil
        end
        return ____t_result_24
    end
    local function tick(self)
        local st = nil
        do
            pcall(function()
                local ____opt_27 = window.Game
                if ____opt_27 ~= nil then
                    ____opt_27 = ____opt_27.getAudioState
                end
                local ____opt_result_29
                if ____opt_27 ~= nil then
                    ____opt_result_29 = ____opt_27(____opt_27)
                end
                st = ____opt_result_29
            end)
        end
        local ____opt_32 = window.Fliperama
        if ____opt_32 ~= nil then
            ____opt_32 = ____opt_32.isOpen
        end
        local ____opt_result_34
        if ____opt_32 ~= nil then
            ____opt_result_34 = ____opt_32(____opt_32)
        end
        local fl = ____opt_result_34
        local ____t_result_53
        local ____t_52 = __t
        local ____t_result_51
        local ____t_50 = __t
        local ____t_result_49
        local ____t_48 = __t
        local ____t_result_47
        local ____t_46 = __t
        local ____t_result_45
        local ____t_44 = __t
        local ____t_result_43
        local ____t_42 = __t
        local ____t_result_41
        local ____t_40 = __t
        local ____t_result_39
        local ____t_38 = __t
        local ____t_result_37
        local ____t_36 = __t
        local ____temp_35 = not not __t(st)
        __O[2329] = ____temp_35
        if ____t_36(____temp_35) then
            ____t_result_37 = st.started
        else
            ____t_result_37 = __O[2329]
        end
        __O[2330] = ____t_result_37
        if ____t_38(____t_result_37) then
            ____t_result_39 = st.playing ~= false
        else
            ____t_result_39 = __O[2330]
        end
        __O[2331] = ____t_result_39
        if ____t_40(____t_result_39) then
            ____t_result_41 = not __t(st.paused)
        else
            ____t_result_41 = __O[2331]
        end
        __O[2332] = ____t_result_41
        if ____t_42(____t_result_41) then
            ____t_result_43 = not __t(st.cutscene)
        else
            ____t_result_43 = __O[2332]
        end
        __O[2333] = ____t_result_43
        if ____t_44(____t_result_43) then
            ____t_result_45 = not __t(st.room)
        else
            ____t_result_45 = __O[2333]
        end
        __O[2334] = ____t_result_45
        if ____t_46(____t_result_45) then
            ____t_result_47 = not __t(fl)
        else
            ____t_result_47 = __O[2334]
        end
        __O[2335] = ____t_result_47
        if ____t_48(____t_result_47) then
            ____t_result_49 = soundOn(nil)
        else
            ____t_result_49 = __O[2335]
        end
        __O[2336] = ____t_result_49
        if ____t_50(____t_result_49) then
            ____t_result_51 = vol.ambient
        else
            ____t_result_51 = __O[2336]
        end
        __O[2337] = ____t_result_51
        if ____t_52(____t_result_51) then
            ____t_result_53 = vol.sfx > 0
        else
            ____t_result_53 = __O[2337]
        end
        local live = ____t_result_53
        local ____t_result_54
        if __t(live) then
            ____t_result_54 = __TS__Number(st.scene)
        else
            ____t_result_54 = -1
        end
        local scene = ____t_result_54
        local ____opt_57 = window.DayTime
        if ____opt_57 ~= nil then
            ____opt_57 = ____opt_57.state
        end
        local ____opt_result_59
        if ____opt_57 ~= nil then
            ____opt_result_59 = ____opt_57(____opt_57)
        end
        local s = ____opt_result_59
        local night = not not __t(s) and __gt(s.night, 0.55)
        local ____t_result_60
        if __t(live) then
            ____t_result_60 = fileAmbient(nil, scene)
        else
            ____t_result_60 = nil
        end
        local file = ____t_result_60
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
            fileAmb.volume = math.min(
                1,
                0.5 * vol.sfx * (__t(st.boss) and 0.4 or 1)
            )
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
        local ____t_result_69
        local ____t_68 = __t
        local ____t_result_67
        local ____t_66 = __t
        local ____t_result_65
        local ____t_64 = __t
        local ____temp_63 = not __t(file)
        __O[2338] = ____temp_63
        if ____t_64(____temp_63) then
            ____t_result_65 = live
        else
            ____t_result_65 = __O[2338]
        end
        __O[2339] = ____t_result_65
        if ____t_66(____t_result_65) then
            ____t_result_67 = __get(PROFILES, scene)
        else
            ____t_result_67 = __O[2339]
        end
        if ____t_68(____t_result_67) then
            ____t_result_69 = __add(scene, "")
        else
            ____t_result_69 = ""
        end
        local key = ____t_result_69
        if key ~= lastKey then
            lastKey = key
            stopAmb(nil)
            if __t(key) then
                startAmb(nil, scene, night)
            end
        end
        local ____t_71 = __t
        local ____t_result_70
        if __t(amb) then
            ____t_result_70 = ctx
        else
            ____t_result_70 = amb
        end
        if ____t_71(____t_result_70) then
            local ____temp_76 = 0.07 * vol.sfx
            local ____t_75 = __t
            local ____opt_result_74
            if st ~= nil then
                ____opt_result_74 = st.boss
            end
            local level = ____temp_76 * (____t_75(____opt_result_74) and 0.35 or 1)
            amb.gain.gain:setTargetAtTime(level, ctx.currentTime, 0.6)
            local ____t_result_86
            local ____t_85 = __t
            local ____opt_81 = window.Weather
            if ____opt_81 ~= nil then
                ____opt_81 = ____opt_81.state
            end
            local ____opt_result_83
            if ____opt_81 ~= nil then
                ____opt_result_83 = ____opt_81(____opt_81)
            end
            local ____opt_result_84
            if ____opt_result_83 ~= nil then
                ____opt_result_84 = ____opt_result_83.rain
            end
            __O[2340] = ____opt_result_84
            if ____t_85(____opt_result_84) then
                ____t_result_86 = __O[2340]
            else
                ____t_result_86 = 0
            end
            local rain = ____t_result_86
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
                local ____t_90 = __t
                local ____t_result_89
                local ____t_88 = __t
                local ____lenq_result_87 = __lenq(ev)
                __O[2341] = ____lenq_result_87
                if ____t_88(____lenq_result_87) then
                    ____t_result_89 = math.random() < 0.8
                else
                    ____t_result_89 = __O[2341]
                end
                if ____t_90(____t_result_89) then
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
                local ____t_result_94
                if __t(amb) then
                    local ____opt_91 = __get(PROFILES, amb.scene)
                    if ____opt_91 ~= nil then
                        ____opt_91 = ____opt_91.name
                    end
                    ____t_result_94 = ____opt_91
                else
                    local ____t_result_93
                    if __t(fileAmbKey) then
                        ____t_result_93 = fileAmbKey
                    else
                        ____t_result_93 = nil
                    end
                    ____t_result_94 = ____t_result_93
                end
                local ____t_98 = __t
                local ____opt_result_97
                if amb ~= nil then
                    ____opt_result_97 = amb.rain
                end
                local ____temp_104 = not not ____t_98(____opt_result_97)
                local ____t_result_103
                local ____t_102 = __t
                local ____opt_result_101
                if ctx ~= nil then
                    ____opt_result_101 = ctx.state
                end
                __O[2342] = ____opt_result_101
                if ____t_102(____opt_result_101) then
                    ____t_result_103 = __O[2342]
                else
                    ____t_result_103 = "sem áudio"
                end
                return {ambiente = ____t_result_94, chuva = ____temp_104, contexto = ____t_result_103}
            end
        },
        "music,sfx,ambientOn,setMusic,setSfx,setAmbient,onChange,play,status"
    )
end)(nil)
return ____exports
