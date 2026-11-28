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
                local ____t_result_8
                if __t(window.AudioContext) then
                    ____t_result_8 = window.AudioContext
                else
                    ____t_result_8 = window.webkitAudioContext
                end
                local Context = ____t_result_8
                if __t(Context) then
                    context = __newExpr(Context)
                    local ____opt_9 = context:resume()
                    if ____opt_9 ~= nil then
                        ____opt_9:catch(function()
                        end)
                    end
                end
            end)
        end
        for ____, voice in __iterar((voices)) do
            local audio = audioFor(nil, voice)
            local ____voice_11, ____serial_12 = voice, "serial"
            local ____voice_serial_13 = ____voice_11[____serial_12] + 1
            ____voice_11[____serial_12] = ____voice_serial_13
            local serial = ____voice_serial_13
            audio.src = SILENCE
            local ____self_14 = __TS__Promise.resolve(audio:play())
            ____self_14["then"](
                ____self_14,
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
        local ____t_18 = __t
        local ____t_result_17
        local ____t_16 = __t
        local ____temp_15 = not __t(enabled(nil))
        __O[2742] = ____temp_15
        if ____t_16(____temp_15) then
            ____t_result_17 = __O[2742]
        else
            ____t_result_17 = window.document.hidden
        end
        if ____t_18(____t_result_17) then
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
            local ____get_21 = __get
            local ____mod_20 = __mod
            local ____index_19 = index
            index = ____index_19 + 1
            local voice = ____get_21(
                voices,
                ____mod_20(
                    ____index_19,
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
            local ____t_result_24
            local ____t_23 = __t
            local ____TS__Number_result_22 = __TS__Number(options.volume)
            __O[2743] = ____TS__Number_result_22
            if ____t_23(____TS__Number_result_22) then
                ____t_result_24 = __O[2743]
            else
                ____t_result_24 = 0.72
            end
            local ____opt_27 = window.DarocaAudio
            if ____opt_27 ~= nil then
                ____opt_27 = ____opt_27.sfx
            end
            local ____opt_result_29
            if ____opt_27 ~= nil then
                ____opt_result_29 = ____opt_27(____opt_27)
            end
            local ____opt_result_29_30 = ____opt_result_29
            if ____opt_result_29_30 == nil then
                ____opt_result_29_30 = 1
            end
            audio.volume = math.max(
                0,
                math.min(1, ____t_result_24 * ____opt_result_29_30)
            )
            local ____t_result_33
            local ____t_32 = __t
            local ____TS__Number_result_31 = __TS__Number(options.pitch)
            __O[2744] = ____TS__Number_result_31
            if ____t_32(____TS__Number_result_31) then
                ____t_result_33 = __O[2744]
            else
                ____t_result_33 = 1
            end
            audio.playbackRate = math.max(
                0.8,
                math.min(1.3, ____t_result_33)
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
        local ____t_result_36
        local ____t_35 = __t
        local ____get_result_34 = __get(frequencies, name)
        __O[2745] = ____get_result_34
        if ____t_35(____get_result_34) then
            ____t_result_36 = __O[2745]
        else
            ____t_result_36 = frequencies.hit
        end
        local values = ____t_result_36
        do
            local function ____catch()
                return true, false
            end
            local ____try, ____hasReturned, ____returnValue = pcall(function()
                local at = context.currentTime
                local osc = context:createOscillator()
                local gain = context:createGain()
                osc.type = name == "combo" and "sawtooth" or "triangle"
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
                local ____self_46 = gain.gain
                local ____self_46_setValueAtTime_47 = ____self_46.setValueAtTime
                local ____opt_39 = window.DarocaAudio
                if ____opt_39 ~= nil then
                    ____opt_39 = ____opt_39.sfx
                end
                local ____opt_result_41
                if ____opt_39 ~= nil then
                    ____opt_result_41 = ____opt_39(____opt_39)
                end
                local ____opt_result_41_42 = ____opt_result_41
                if ____opt_result_41_42 == nil then
                    ____opt_result_41_42 = 1
                end
                local ____t_result_45
                local ____t_44 = __t
                local ____TS__Number_result_43 = __TS__Number(options.volume)
                __O[2746] = ____TS__Number_result_43
                if ____t_44(____TS__Number_result_43) then
                    ____t_result_45 = __O[2746]
                else
                    ____t_result_45 = 0.055
                end
                ____self_46_setValueAtTime_47(
                    ____self_46,
                    math.max(
                        0.001,
                        ____opt_result_41_42 * math.min(0.12, ____t_result_45)
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
            local ____sound_53 = sound
            local ____t_result_51
            local ____t_50 = __t
            local ____opt_48 = event.detail
            if ____opt_48 ~= nil then
                ____opt_48 = ____opt_48.name
            end
            __O[2747] = ____opt_48
            if ____t_50(____opt_48) then
                ____t_result_51 = __O[2747]
            else
                ____t_result_51 = "hit"
            end
            local ____t_result_52
            if __t(event.detail) then
                ____t_result_52 = event.detail
            else
                ____t_result_52 = {}
            end
            return ____sound_53(nil, ____t_result_51, ____t_result_52)
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
                local ____opt_result_58
                if context ~= nil then
                    ____opt_result_58 = context:resume()
                end
                if ____opt_result_58 ~= nil then
                    ____opt_result_58:catch(function()
                    end)
                end
            end
        end
    )
    local ____opt_59 = window.document:getElementById("soundBtn")
    if ____opt_59 ~= nil then
        ____opt_59:addEventListener(
            "click",
            function()
                if not __t(enabled(nil)) then
                    for ____, voice in __iterar((voices)) do
                        local ____opt_60 = voice.audio
                        if ____opt_60 ~= nil then
                            ____opt_60:pause()
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
