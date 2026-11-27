--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __newExpr, __mod, __ord, __arrL, __iterar, __t, __get, __len, __call, __add, __new, __arrayFrom = __JSR.__newExpr, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__len, __JSR.__call, __JSR.__add, __JSR.__new, __JSR.__arrayFrom
local ____lualib = require(script.Parent.lualib_bundle)
local Map = ____lualib.Map
local __TS__New = ____lualib.__TS__New
local __TS__Promise = ____lualib.__TS__Promise
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__Number = ____lualib.__TS__Number
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    local SILENCE = "data:audio/wav;base64,UklGRigAAABXQVZFZm10IBAAAAABAAEAQB8AAEAfAAABAAgAZGF0YQQAAACAgICA"
    local voices = __arrayFrom(
        {length = 2},
        function() return {audio = nil, serial = 0} end
    )
    local seen = __TS__New(Map)
    local context = nil
    local unlocked = false
    local index = 0
    local function enabled()
        local ____opt_2 = window.GameMusic
        if ____opt_2 ~= nil then
            ____opt_2 = ____opt_2.getStatus
        end
        local ____opt_result_4
        if ____opt_2 ~= nil then
            ____opt_result_4 = ____opt_2(____opt_2).enabled
        end
        local ____opt_result_4_7 = ____opt_result_4
        if ____opt_result_4_7 == nil then
            local ____opt_5 = window.document:getElementById("soundBtn")
            ____opt_result_4_7 = (____opt_5 and ____opt_5:getAttribute("aria-pressed")) == "true"
        end
        return ____opt_result_4_7
    end
    local function audioFor(self, voice)
        if not __t(voice.audio) then
            voice.audio = __new("Audio")
            voice.audio.preload = "auto"
            voice.audio:setAttribute("playsinline", "")
            voice.audio.playsInline = true
        end
        return voice.audio
    end
    local function unlock(self)
        if __t(unlocked) then
            return
        end
        unlocked = true
        do
            pcall(function()
                local Context = if __t(window.AudioContext) then window.AudioContext else window.webkitAudioContext
                if __t(Context) then
                    context = __newExpr(Context)
                    local ____opt_8 = context:resume()
                    if ____opt_8 ~= nil then
                        ____opt_8:catch(function()
                        end)
                    end
                end
            end)
        end
        for ____, voice in __iterar((voices)) do
            local audio = audioFor(nil, voice)
            local ____voice_10, ____serial_11 = voice, "serial"
            local ____voice_serial_12 = ____voice_10[____serial_11] + 1
            ____voice_10[____serial_11] = ____voice_serial_12
            local serial = ____voice_serial_12
            audio.src = SILENCE
            local ____self_13 = __TS__Promise.resolve(audio:play())
            ____self_13["then"](
                ____self_13,
                function()
                    if voice.serial == serial then
                        audio:pause()
                    end
                end
            ):catch(function()
            end)
        end
    end
    local function sound(self, name, options)
        if options == nil then
            options = {}
        end
        local ____t_16 = __t
        local ____t_15 = __t
        local ____temp_14 = not __t(enabled(nil))
        __O[2717] = ____temp_14
        if ____t_16(if ____t_15(____temp_14) then __O[2717] else window.document.hidden) then
            return false
        end
        local id = options.id
        if id ~= nil then
            if __t(__call(seen, "has", id)) then
                return false
            end
            __call(
                seen,
                "set",
                id,
                window.performance:now()
            )
            if seen.size > 200 then
                __call(
                    seen,
                    "delete",
                    __call(seen, "keys"):next().value
                )
            end
        end
        if __t(not __t(unlocked) and window.location.protocol == "file:") then
            unlock(nil)
        end
        if __t(name == "biuriful" or name == "gugu-dada") then
            local ____get_19 = __get
            local ____mod_18 = __mod
            local ____index_17 = index
            index = ____index_17 + 1
            local voice = ____get_19(
                voices,
                ____mod_18(
                    ____index_17,
                    __len(voices)
                )
            )
            local audio = audioFor(nil, voice)
            voice.serial = voice.serial + 1
            audio:pause()
            audio.src = __add(
                __add("assets/sfx/", name),
                ".mp3"
            )
            local ____t_21 = __t
            local ____TS__Number_result_20 = __TS__Number(options.volume)
            __O[2718] = ____TS__Number_result_20
            local ____temp_28 = if ____t_21(____TS__Number_result_20) then __O[2718] else 0.72
            local ____opt_24 = window.DarocaAudio
            if ____opt_24 ~= nil then
                ____opt_24 = ____opt_24.sfx
            end
            local ____opt_result_26
            if ____opt_24 ~= nil then
                ____opt_result_26 = ____opt_24(____opt_24)
            end
            local ____opt_result_26_27 = ____opt_result_26
            if ____opt_result_26_27 == nil then
                ____opt_result_26_27 = 1
            end
            audio.volume = math.max(
                0,
                math.min(1, ____temp_28 * ____opt_result_26_27)
            )
            local ____t_30 = __t
            local ____TS__Number_result_29 = __TS__Number(options.pitch)
            __O[2719] = ____TS__Number_result_29
            audio.playbackRate = math.max(
                0.8,
                math.min(1.3, if ____t_30(____TS__Number_result_29) then __O[2719] else 1)
            )
            __TS__Promise.resolve(audio:play()):catch(function()
            end)
            return true
        end
        if __t(not __t(context) or context.state ~= "running") then
            return false
        end
        local frequencies = {
            hit = __arrL({155, 65, 0.09}, 3),
            combo = __arrL({390, 92, 0.22}, 3),
            ko = __arrL({460, 45, 0.36}, 3),
            jump = __arrL({240, 540, 0.08}, 3),
            dash = __arrL({370, 130, 0.07}, 3),
            emote = __arrL({660, 880, 0.12}, 3)
        }
        local ____t_32 = __t
        local ____get_result_31 = __get(frequencies, name)
        __O[2720] = ____get_result_31
        local values = if ____t_32(____get_result_31) then __O[2720] else frequencies.hit
        do
            local function ____catch()
                return true, false
            end
            local ____try, ____hasReturned, ____returnValue = pcall(function()
                local at = context.currentTime
                local osc = context:createOscillator()
                local gain = context:createGain()
                osc.type = if name == "combo" then "sawtooth" else "triangle"
                osc.frequency:setValueAtTime(
                    __get(values, 0),
                    at
                )
                osc.frequency:exponentialRampToValueAtTime(
                    __get(values, 1),
                    __add(
                        at,
                        __get(values, 2)
                    )
                )
                local ____self_41 = gain.gain
                local ____self_41_setValueAtTime_42 = ____self_41.setValueAtTime
                local ____opt_35 = window.DarocaAudio
                if ____opt_35 ~= nil then
                    ____opt_35 = ____opt_35.sfx
                end
                local ____opt_result_37
                if ____opt_35 ~= nil then
                    ____opt_result_37 = ____opt_35(____opt_35)
                end
                local ____opt_result_37_38 = ____opt_result_37
                if ____opt_result_37_38 == nil then
                    ____opt_result_37_38 = 1
                end
                local ____t_40 = __t
                local ____TS__Number_result_39 = __TS__Number(options.volume)
                __O[2721] = ____TS__Number_result_39
                ____self_41_setValueAtTime_42(
                    ____self_41,
                    math.max(
                        0.001,
                        ____opt_result_37_38 * math.min(0.12, if ____t_40(____TS__Number_result_39) then __O[2721] else 0.055)
                    ),
                    at
                )
                gain.gain:exponentialRampToValueAtTime(
                    0.001,
                    __add(
                        at,
                        __get(values, 2)
                    )
                )
                osc:connect(gain)
                gain:connect(context.destination)
                osc:start(at)
                osc:stop(__add(
                    at,
                    __get(values, 2)
                ))
                osc.onended = function()
                    osc:disconnect()
                    gain:disconnect()
                end
                return true, true
            end)
            if not ____try then
                ____hasReturned, ____returnValue = ____catch()
            end
            if ____hasReturned then
                return ____returnValue
            end
        end
    end
    window.document:addEventListener(
        "pointerdown",
        function(____, event)
            if __t(event.isTrusted) then
                unlock(nil)
            end
        end,
        __ord({capture = true, passive = true}, "capture,passive")
    )
    window.document:addEventListener(
        "keydown",
        function(____, event)
            if __t(event.isTrusted) then
                unlock(nil)
            end
        end,
        {capture = true}
    )
    window:addEventListener(
        "arena-sfx",
        function(____, event)
            local ____sound_46 = sound
            local ____t_45 = __t
            local ____opt_43 = event.detail
            if ____opt_43 ~= nil then
                ____opt_43 = ____opt_43.name
            end
            __O[2722] = ____opt_43
            return ____sound_46(nil, if ____t_45(____opt_43) then __O[2722] else "hit", if __t(event.detail) then event.detail else {})
        end
    )
    window:addEventListener(
        "arena-open",
        function() return __call(seen, "clear") end
    )
    window:addEventListener(
        "daroca-native-resume",
        function()
            if __t(enabled(nil)) then
                local ____opt_result_51
                if context ~= nil then
                    ____opt_result_51 = context:resume()
                end
                if ____opt_result_51 ~= nil then
                    ____opt_result_51:catch(function()
                    end)
                end
            end
        end
    )
    local ____opt_52 = window.document:getElementById("soundBtn")
    if ____opt_52 ~= nil then
        ____opt_52:addEventListener(
            "click",
            function()
                if not __t(enabled(nil)) then
                    for ____, voice in __iterar((voices)) do
                        local ____opt_53 = voice.audio
                        if ____opt_53 ~= nil then
                            ____opt_53:pause()
                        end
                    end
                end
            end
        )
    end
    window.ArenaSound = __ord(
        {
            play = sound,
            reset = function() return __call(seen, "clear") end,
            unlock = unlock
        },
        "play,reset,unlock"
    )
end)(nil)
return ____exports
