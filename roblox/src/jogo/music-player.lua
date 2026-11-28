--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __newExpr, __lt, __le, __gt, __ge, __objCreate, __isFiniteN, __isInteger, __callq, __mod, __ord, __arrL = __JSR.__newExpr, __JSR.__lt, __JSR.__le, __JSR.__gt, __JSR.__ge, __JSR.__objCreate, __JSR.__isFiniteN, __JSR.__isInteger, __JSR.__callq, __JSR.__mod, __JSR.__ord, __JSR.__arrL
local __iterar, __t, __get, __set, __arr, __len, __call, __add, __new, __iter, __keys, __entries = __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__set, __JSR.__arr, __JSR.__len, __JSR.__call, __JSR.__add, __JSR.__new, __JSR.__iter, __JSR.__keys, __JSR.__entries
local __assign, __isArray, __re, __re_test, __re_replace = __JSR.__assign, __JSR.__isArray, __JSR.__re, __JSR.__re_test, __JSR.__re_replace
local ____lualib = require(script.Parent.lualib_bundle)
local Set = ____lualib.Set
local __TS__New = ____lualib.__TS__New
local __TS__Number = ____lualib.__TS__Number
local Error = ____lualib.Error
local RangeError = ____lualib.RangeError
local ReferenceError = ____lualib.ReferenceError
local SyntaxError = ____lualib.SyntaxError
local TypeError = ____lualib.TypeError
local URIError = ____lualib.URIError
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__AsyncAwaiter = ____lualib.__TS__AsyncAwaiter
local __TS__Await = ____lualib.__TS__Await
local __TS__Promise = ____lualib.__TS__Promise
local __TS__Spread = ____lualib.__TS__Spread
local __TS__SparseArrayNew = ____lualib.__TS__SparseArrayNew
local __TS__SparseArrayPush = ____lualib.__TS__SparseArrayPush
local __TS__SparseArraySpread = ____lualib.__TS__SparseArraySpread
local ____exports = {}
local __O = {};
(function()
    local currentVolume, gain, makeVoices, suspended, normalName, shuffled, refreshArenaLibrary, nextArenaTrack, arenaStatus, updateArenaPlaylist, selectArena, candidates, select, timelineSelection, targetPosition, waitMetadata, playVoice, silenceSelection, syncSelection, pauseForLifecycle, isPlaying, getStatus, SCENES, isNative, clamp, number, now, config, source, ready, enabled, unlocked, audioContext, voices, active, requestGeneration, context, matchedContext, override, desired, lastAttempt, lastError, configError, nativePaused, transition, lastAudioState, gamePaused, overrideSerial, filmClock, ARENA_SHUFFLE, arenaPlaylist, speakers
    function currentVolume(self, v, time)
        if time == nil then
            time = now(nil)
        end
        if not __t(v.ramp) then
            local ____t_result_117
            if __t(v.volume) then
                ____t_result_117 = v.volume
            else
                ____t_result_117 = 0
            end
            return ____t_result_117
        end
        local r = v.ramp
        local p = __le(r["end"], r.start) and 1 or clamp(nil, (time - r.start) / (r["end"] - r.start), 0, 1)
        return r.from + (r.to - r.from) * p
    end
    function gain(self, v, value, duration)
        if duration == nil then
            duration = 0
        end
        local time = now(nil)
        local from = currentVolume(nil, v, time)
        local target = clamp(nil, value, 0, 1)
        v.volume = from
        v.ramp = {from = from, to = target, start = time, ["end"] = time + duration}
        local ____t_119 = __t
        local ____t_result_118
        if __t(v.gain) then
            ____t_result_118 = audioContext
        else
            ____t_result_118 = v.gain
        end
        if ____t_119(____t_result_118) then
            do
                pcall(function()
                    local t = audioContext.currentTime
                    v.gain.gain:cancelScheduledValues(t)
                    v.gain.gain:setValueAtTime(from, t)
                    if duration > 0 then
                        v.gain.gain:linearRampToValueAtTime(target, t + duration / 1000)
                    else
                        v.gain.gain:setValueAtTime(target, t)
                    end
                end)
            end
        else
            do
                pcall(function()
                    local ____v_audio_121 = v.audio
                    local ____temp_120
                    if duration > 0 then
                        ____temp_120 = from
                    else
                        ____temp_120 = target
                    end
                    ____v_audio_121.volume = ____temp_120
                end)
            end
        end
    end
    function makeVoices(self)
        if __t(__len(voices)) then
            return
        end
        local ____t_result_122
        if __t(window.AudioContext) then
            ____t_result_122 = window.AudioContext
        else
            ____t_result_122 = window.webkitAudioContext
        end
        local Context = ____t_result_122
        do
            local function ____catch()
                audioContext = nil
            end
            local ____try = pcall(function()
                local ____t_124 = __t
                local ____t_result_123
                if __t(Context) then
                    ____t_result_123 = not __t(window.nativeAndroid)
                else
                    ____t_result_123 = Context
                end
                if ____t_124(____t_result_123) then
                    audioContext = __newExpr(Context)
                end
            end)
            if not ____try then
                ____catch()
            end
        end
        do
            local index = 0
            while index < 2 do
                local audio = __new("Audio")
                audio.preload = "auto"
                local ____opt_125 = audio.setAttribute
                if ____opt_125 ~= nil then
                    ____opt_125(audio, "playsinline", "")
                end
                audio.playsInline = true
                audio.loop = false
                audio.volume = 1
                local v = {
                    audio = audio,
                    index = index,
                    gain = nil,
                    volume = 0,
                    ramp = nil,
                    id = nil,
                    src = nil,
                    loop = false,
                    loads = 0,
                    plays = 0,
                    seeks = 0,
                    ended = false,
                    warming = false,
                    pending = 0,
                    cueKey = nil,
                    startSeconds = 0,
                    cutsceneIndex = nil,
                    cancelMetadata = nil
                }
                do
                    local function ____catch()
                        v.gain = nil
                    end
                    local ____try = pcall(function()
                        if __t(audioContext) then
                            local media = audioContext:createMediaElementSource(audio)
                            local node = audioContext:createGain()
                            node.gain.value = 0
                            media:connect(node)
                            node:connect(audioContext.destination)
                            v.gain = node
                        end
                    end)
                    if not ____try then
                        ____catch()
                    end
                end
                if not __t(v.gain) then
                    audio.volume = 0
                end
                audio:addEventListener(
                    "ended",
                    function()
                        v.ended = true
                        local ____t_136 = __t
                        local ____t_result_135
                        local ____t_134 = __t
                        local ____t_result_133
                        local ____t_132 = __t
                        local ____t_result_131
                        local ____t_130 = __t
                        local ____opt_result_129
                        if desired ~= nil then
                            ____opt_result_129 = desired.arenaShuffle
                        end
                        __O[2387] = ____opt_result_129
                        if ____t_130(____opt_result_129) then
                            ____t_result_131 = arenaPlaylist.open
                        else
                            ____t_result_131 = __O[2387]
                        end
                        __O[2388] = ____t_result_131
                        if ____t_132(____t_result_131) then
                            ____t_result_133 = active == v.index
                        else
                            ____t_result_133 = __O[2388]
                        end
                        __O[2389] = ____t_result_133
                        if ____t_134(____t_result_133) then
                            ____t_result_135 = v.cueKey == desired.cueKey
                        else
                            ____t_result_135 = __O[2389]
                        end
                        if ____t_136(____t_result_135) then
                            nextArenaTrack(nil)
                            lastAttempt = ""
                            syncSelection(nil, true)
                        else
                            local ____t_144 = __t
                            local ____t_result_143
                            local ____t_142 = __t
                            local ____t_result_141
                            local ____t_140 = __t
                            local ____t_result_139
                            local ____t_138 = __t
                            local ____t_result_137
                            if __t(v.loop) then
                                ____t_result_137 = enabled
                            else
                                ____t_result_137 = v.loop
                            end
                            __O[2390] = ____t_result_137
                            if ____t_138(____t_result_137) then
                                ____t_result_139 = unlocked
                            else
                                ____t_result_139 = __O[2390]
                            end
                            __O[2391] = ____t_result_139
                            if ____t_140(____t_result_139) then
                                ____t_result_141 = not __t(suspended(nil))
                            else
                                ____t_result_141 = __O[2391]
                            end
                            __O[2392] = ____t_result_141
                            if ____t_142(____t_result_141) then
                                ____t_result_143 = active == v.index
                            else
                                ____t_result_143 = __O[2392]
                            end
                            if ____t_144(____t_result_143) then
                                lastAttempt = ""
                                syncSelection(nil, true)
                            end
                        end
                    end
                )
                audio:addEventListener(
                    "playing",
                    function()
                        v.ended = false
                    end
                )
                audio:addEventListener(
                    "error",
                    function()
                        local ____t_146 = __t
                        local ____t_result_145
                        if __t(v.id) then
                            ____t_result_145 = not __t(v.warming)
                        else
                            ____t_result_145 = v.id
                        end
                        if ____t_146(____t_result_145) then
                            local ____add_152 = __add
                            local ____add_151 = __add
                            local ____t_result_150
                            local ____t_149 = __t
                            local ____opt_147 = __call(
                                config.tracks,
                                "find",
                                function(____, t) return t.id == v.id end
                            )
                            if ____opt_147 ~= nil then
                                ____opt_147 = ____opt_147.title
                            end
                            __O[2393] = ____opt_147
                            if ____t_149(____opt_147) then
                                ____t_result_150 = __O[2393]
                            else
                                ____t_result_150 = "esta trilha"
                            end
                            lastError = ____add_152(
                                ____add_151("Não foi possível reproduzir “", ____t_result_150),
                                "”."
                            )
                            if active == v.index then
                                active = -1
                            end
                            local ____t_160 = __t
                            local ____t_result_159
                            local ____t_158 = __t
                            local ____t_result_157
                            local ____t_156 = __t
                            local ____opt_result_155
                            if desired ~= nil then
                                ____opt_result_155 = desired.arenaShuffle
                            end
                            __O[2394] = ____opt_result_155
                            if ____t_156(____opt_result_155) then
                                ____t_result_157 = arenaPlaylist.open
                            else
                                ____t_result_157 = __O[2394]
                            end
                            __O[2395] = ____t_result_157
                            if ____t_158(____t_result_157) then
                                ____t_result_159 = arenaPlaylist.currentId == v.id
                            else
                                ____t_result_159 = __O[2395]
                            end
                            if ____t_160(____t_result_159) then
                                __call(arenaPlaylist.failed, "add", v.id)
                                nextArenaTrack(nil)
                                lastAttempt = ""
                                syncSelection(nil, true)
                            end
                        end
                    end
                )
                __call(voices, "push", v)
                index = index + 1
            end
        end
    end
    function suspended(self)
        local ____t_result_163
        local ____t_162 = __t
        local ____t_result_161
        if __t(nativePaused) then
            ____t_result_161 = nativePaused
        else
            ____t_result_161 = gamePaused
        end
        __O[2396] = ____t_result_161
        if ____t_162(____t_result_161) then
            ____t_result_163 = __O[2396]
        else
            ____t_result_163 = not not __t(window.document.hidden)
        end
        return ____t_result_163
    end
    function normalName(self, value)
        local ____call_184 = __call
        local ____re_replace_183 = __re_replace
        local ____call_182 = __call
        local ____re_replace_181 = __re_replace
        local ____call_180 = __call
        local ____t_result_179
        if __t(value) then
            ____t_result_179 = value
        else
            ____t_result_179 = ""
        end
        return ____call_184(
            ____re_replace_183(
                ____call_182(
                    ____re_replace_181(
                        ____call_180(
                            tostring(____t_result_179),
                            "normalize",
                            "NFD"
                        ),
                        __re("[\\u0300-\\u036f]", "g"),
                        ""
                    ),
                    "toLowerCase"
                ),
                __re("[^a-z0-9]+", "g"),
                " "
            ),
            "trim"
        )
    end
    function shuffled(self, ids)
        local bag = __arr(__TS__Spread(__iter(ids)))
        do
            local i = __len(bag) - 1
            while i > 0 do
                local j = math.floor(math.random() * (i + 1))
                do
                    do
                        __O[2398] = __iter(__arrL(
                            {
                                __get(bag, j),
                                __get(bag, i)
                            },
                            2
                        ))
                        __set(
                            bag,
                            i,
                            __get(__O[2398], 0)
                        )
                    end
                    __set(
                        bag,
                        j,
                        __get(__O[2398], 1)
                    )
                end
                local ____ = __O[2398]
                i = i - 1
            end
        end
        return bag
    end
    function refreshArenaLibrary(self)
        local ids = __call(
            config.tracks,
            "map",
            function(____, track) return track.id end
        )
        local signature = __call(
            __call(
                __arr(__TS__Spread(__iter(ids))),
                "sort"
            ),
            "join",
            "|"
        )
        if signature == arenaPlaylist.library then
            return
        end
        arenaPlaylist.library = signature
        for ____, id in __iterar((arenaPlaylist.failed)) do
            if not __t(__call(ids, "includes", id)) then
                __call(arenaPlaylist.failed, "delete", id)
            end
        end
        local ____t_186 = __t
        local ____t_result_185
        if __t(arenaPlaylist.currentId) then
            ____t_result_185 = not __t(__call(ids, "includes", arenaPlaylist.currentId))
        else
            ____t_result_185 = arenaPlaylist.currentId
        end
        if ____t_186(____t_result_185) then
            arenaPlaylist.currentId = nil
        end
        arenaPlaylist.bag = shuffled(
            nil,
            __call(
                ids,
                "filter",
                function(____, id) return id ~= arenaPlaylist.currentId and not __t(__call(arenaPlaylist.failed, "has", id)) end
            )
        )
    end
    function nextArenaTrack(self)
        refreshArenaLibrary(nil)
        local ids = __call(
            __call(
                config.tracks,
                "map",
                function(____, track) return track.id end
            ),
            "filter",
            function(____, id) return not __t(__call(arenaPlaylist.failed, "has", id)) end
        )
        arenaPlaylist.bag = __call(
            arenaPlaylist.bag,
            "filter",
            function(____, id) return __call(ids, "includes", id) end
        )
        if not __t(__len(ids)) then
            arenaPlaylist.currentId = nil
            return nil
        end
        if not __t(__len(arenaPlaylist.bag)) then
            arenaPlaylist.bag = shuffled(nil, ids)
        end
        local ____t_result_187
        if __t(arenaPlaylist.currentId) then
            ____t_result_187 = arenaPlaylist.currentId
        else
            ____t_result_187 = arenaPlaylist.lastId
        end
        local previous = ____t_result_187
        if __t(__get(arenaPlaylist.bag, 0) == previous and __len(ids) > 1) then
            local alternative = __call(
                arenaPlaylist.bag,
                "findIndex",
                function(____, id) return id ~= previous end
            )
            if alternative >= 0 then
                do
                    do
                        __O[2399] = __iter(__arrL(
                            {
                                __get(arenaPlaylist.bag, alternative),
                                __get(arenaPlaylist.bag, 0)
                            },
                            2
                        ))
                        __set(
                            arenaPlaylist.bag,
                            0,
                            __get(__O[2399], 0)
                        )
                    end
                    __set(
                        arenaPlaylist.bag,
                        alternative,
                        __get(__O[2399], 1)
                    )
                end
                local ____ = __O[2399]
            else
                arenaPlaylist.bag = __arrL({}, 0)
                return nextArenaTrack(nil)
            end
        end
        arenaPlaylist.currentId = __call(arenaPlaylist.bag, "shift")
        arenaPlaylist.lastId = arenaPlaylist.currentId
        arenaPlaylist.serial = arenaPlaylist.serial + 1
        return arenaPlaylist.currentId
    end
    function arenaStatus(self)
        do
            local function ____catch()
                return true, nil
            end
            local ____try, ____hasReturned, ____returnValue = pcall(function()
                local ____t_result_194
                local ____t_193 = __t
                local ____opt_190 = window.Arena
                if ____opt_190 ~= nil then
                    ____opt_190 = ____opt_190.getStatus
                end
                local ____opt_result_192
                if ____opt_190 ~= nil then
                    ____opt_result_192 = ____opt_190(____opt_190)
                end
                __O[2400] = ____opt_result_192
                if ____t_193(____opt_result_192) then
                    ____t_result_194 = __O[2400]
                else
                    ____t_result_194 = nil
                end
                return true, ____t_result_194
            end)
            if not ____try then
                ____hasReturned, ____returnValue = ____catch()
            end
            if ____hasReturned then
                return ____returnValue
            end
        end
    end
    function updateArenaPlaylist(self, arena)
        local ____t_198 = __t
        local ____opt_result_197
        if arena ~= nil then
            ____opt_result_197 = arena.open
        end
        if not ____t_198(____opt_result_197) then
            arenaPlaylist.open = false
            arenaPlaylist.currentId = nil
            arenaPlaylist.matchId = nil
            return false
        end
        refreshArenaLibrary(nil)
        local ____t_result_203
        local ____t_202 = __t
        local ____t_result_201
        local ____t_200 = __t
        local ____temp_199 = type(arena.matchId) == "string"
        __O[2401] = ____temp_199
        if ____t_200(____temp_199) then
            ____t_result_201 = arena.matchId
        else
            ____t_result_201 = __O[2401]
        end
        if ____t_202(____t_result_201) then
            ____t_result_203 = arena.matchId
        else
            ____t_result_203 = nil
        end
        local matchId = ____t_result_203
        if not __t(arenaPlaylist.open) then
            arenaPlaylist.open = true
            arenaPlaylist.session = arenaPlaylist.session + 1
            __call(arenaPlaylist.failed, "clear")
            arenaPlaylist.matchId = matchId
            nextArenaTrack(nil)
        else
            local ____t_205 = __t
            local ____t_result_204
            if __t(matchId) then
                ____t_result_204 = matchId ~= arenaPlaylist.matchId
            else
                ____t_result_204 = matchId
            end
            if ____t_205(____t_result_204) then
                local rematch = arenaPlaylist.matchId ~= nil
                arenaPlaylist.matchId = matchId
                if __t(rematch) then
                    nextArenaTrack(nil)
                end
            end
        end
        if not __t(arenaPlaylist.currentId) then
            nextArenaTrack(nil)
        end
        return true
    end
    function selectArena(self)
        local track = __call(
            config.tracks,
            "find",
            function(____, t) return t.id == arenaPlaylist.currentId end
        )
        if not __t(track) then
            matchedContext = nil
            return nil
        end
        matchedContext = ARENA_SHUFFLE
        local ____track_215 = track
        local ____t_result_207
        if __t(isNative) then
            ____t_result_207 = track.file
        else
            local ____t_result_206
            if __t(track.url) then
                ____t_result_206 = track.url
            else
                ____t_result_206 = track.file
            end
            ____t_result_207 = ____t_result_206
        end
        local ____temp_214 = config.masterVolume * track.volume
        local ____opt_210 = window.DarocaAudio
        if ____opt_210 ~= nil then
            ____opt_210 = ____opt_210.music
        end
        local ____opt_result_212
        if ____opt_210 ~= nil then
            ____opt_result_212 = ____opt_210(____opt_210)
        end
        local ____opt_result_212_213 = ____opt_result_212
        if ____opt_result_212_213 == nil then
            ____opt_result_212_213 = 1
        end
        return {
            track = ____track_215,
            key = ARENA_SHUFFLE,
            src = ____t_result_207,
            loop = false,
            volume = clamp(nil, ____temp_214 * ____opt_result_212_213, 0, 1),
            fadeMs = track.fadeMs,
            startSeconds = 0,
            delaySeconds = 0,
            cutscene = false,
            token = nil,
            elapsed = 0,
            index = nil,
            arenaShuffle = true,
            cueKey = __add(
                __add(
                    __add(
                        __add(
                            __add("arena|", arenaPlaylist.session),
                            "|"
                        ),
                        arenaPlaylist.serial
                    ),
                    "|"
                ),
                track.id
            )
        }
    end
    function candidates(self)
        lastAudioState = nil
        if __t(override) then
            do
                pcall(function()
                    local ____t_result_222
                    local ____t_221 = __t
                    local ____opt_218 = window.Game
                    if ____opt_218 ~= nil then
                        ____opt_218 = ____opt_218.getAudioState
                    end
                    local ____opt_result_220
                    if ____opt_218 ~= nil then
                        ____opt_result_220 = ____opt_218(____opt_218)
                    end
                    __O[2402] = ____opt_result_220
                    if ____t_221(____opt_result_220) then
                        ____t_result_222 = __O[2402]
                    else
                        ____t_result_222 = nil
                    end
                    lastAudioState = ____t_result_222
                end)
            end
            return __arrL({override}, 1)
        end
        local party = nil
        local coop = nil
        local state = nil
        do
            pcall(function()
                local ____opt_225 = window.PartyGame
                if ____opt_225 ~= nil then
                    ____opt_225 = ____opt_225.getStatus
                end
                local ____opt_result_227
                if ____opt_225 ~= nil then
                    ____opt_result_227 = ____opt_225(____opt_225)
                end
                party = ____opt_result_227
            end)
        end
        if __t(updateArenaPlaylist(
            nil,
            arenaStatus(nil)
        )) then
            return __arrL({ARENA_SHUFFLE}, 1)
        end
        do
            local ____try, ____hasReturned, ____returnValue = pcall(function()
                local ____opt_230 = window.WorldLife
                if ____opt_230 ~= nil then
                    ____opt_230 = ____opt_230.getStatus
                end
                local ____opt_result_232
                if ____opt_230 ~= nil then
                    ____opt_result_232 = ____opt_230(____opt_230)
                end
                local challenge = ____opt_result_232
                local ____t_238 = __t
                local ____t_result_237
                local ____t_236 = __t
                local ____opt_result_235
                if challenge ~= nil then
                    ____opt_result_235 = challenge.open
                end
                __O[2403] = ____opt_result_235
                if ____t_236(____opt_result_235) then
                    ____t_result_237 = __call(
                        __arrL({"pump", "memory", "sort"}, 3),
                        "includes",
                        challenge.kind
                    )
                else
                    ____t_result_237 = __O[2403]
                end
                if ____t_238(____t_result_237) then
                    local ____opt_241 = window.Game
                    if ____opt_241 ~= nil then
                        ____opt_241 = ____opt_241.getAudioState
                    end
                    local ____opt_result_243
                    if ____opt_241 ~= nil then
                        ____opt_result_243 = ____opt_241(____opt_241)
                    end
                    local game = ____opt_result_243
                    local ____t_result_244
                    if __t(game) then
                        ____t_result_244 = game
                    else
                        ____t_result_244 = nil
                    end
                    lastAudioState = ____t_result_244
                    local ____arrL_254 = __arrL
                    local ____add_result_253 = __add("activities.", challenge.kind)
                    local ____add_252 = __add
                    local ____t_result_251
                    local ____t_250 = __t
                    local ____get_248 = __get
                    local ____opt_result_247
                    if game ~= nil then
                        ____opt_result_247 = game.scene
                    end
                    local ____get_248_result_249 = ____get_248(SCENES, ____opt_result_247)
                    __O[2404] = ____get_248_result_249
                    if ____t_250(____get_248_result_249) then
                        ____t_result_251 = __O[2404]
                    else
                        ____t_result_251 = "roca"
                    end
                    return true, ____arrL_254(
                        {
                            ____add_result_253,
                            ____add_252("maps.", ____t_result_251),
                            "menu.title"
                        },
                        3
                    )
                end
            end)
            if ____try and ____hasReturned then
                return ____returnValue
            end
        end
        local ____t_258 = __t
        local ____opt_result_257
        if party ~= nil then
            ____opt_result_257 = party.open
        end
        if ____t_258(____opt_result_257) then
            if party.view ~= "live" then
                return __arrL({"party.menu", "menu.title"}, 2)
            end
            if party.phase == "board" then
                return __arrL({"party.board", "party.menu"}, 2)
            end
            if party.phase == "ceremony" then
                return __arrL({"party.ceremony", "party.menu"}, 2)
            end
            if party.phase == "results" then
                local ____arrL_260 = __arrL
                local ____t_result_259
                if __t(party.game) then
                    ____t_result_259 = __add("party.", party.game)
                else
                    ____t_result_259 = "party.menu"
                end
                return ____arrL_260({"party.results", ____t_result_259, "party.menu"}, 3)
            end
            local ____arrL_262 = __arrL
            local ____t_result_261
            if __t(party.game) then
                ____t_result_261 = __add("party.", party.game)
            else
                ____t_result_261 = "party.menu"
            end
            return ____arrL_262({____t_result_261, "party.menu"}, 2)
        end
        do
            pcall(function()
                local ____opt_265 = window.CoopArena
                if ____opt_265 ~= nil then
                    ____opt_265 = ____opt_265.getStatus
                end
                local ____opt_result_267
                if ____opt_265 ~= nil then
                    ____opt_result_267 = ____opt_265(____opt_265)
                end
                coop = ____opt_result_267
            end)
        end
        local ____t_271 = __t
        local ____opt_result_270
        if coop ~= nil then
            ____opt_result_270 = coop.open
        end
        if ____t_271(____opt_result_270) then
            if not __t(coop.stage) then
                return __arrL({"coop.menu", "menu.title"}, 2)
            end
            if coop.stage == "victory" then
                return __arrL({"events.celebration", "coop.menu"}, 2)
            end
            if coop.stage == "defeat" then
                return __arrL({"events.defeat", "coop.menu"}, 2)
            end
            local ____arrL_276 = __arrL
            local ____t_result_275
            local ____t_274 = __t
            local ____opt_272 = coop.boss
            if ____opt_272 ~= nil then
                ____opt_272 = ____opt_272.type
            end
            if ____t_274(____opt_272) then
                ____t_result_275 = __add("coop.", coop.boss.type)
            else
                ____t_result_275 = "coop.menu"
            end
            return ____arrL_276({____t_result_275, "coop.menu"}, 2)
        end
        local ____t_282 = __t
        local ____opt_279 = window.Fliperama
        if ____opt_279 ~= nil then
            ____opt_279 = ____opt_279.isOpen
        end
        local ____opt_result_281
        if ____opt_279 ~= nil then
            ____opt_result_281 = ____opt_279(____opt_279)
        end
        if ____t_282(____opt_result_281) then
            local ____this_284
            ____this_284 = window.Fliperama
            local ____opt_283 = ____this_284.current
            if ____opt_283 ~= nil then
                ____opt_283 = ____opt_283(____this_284)
            end
            local g = ____opt_283
            local ____arr_288 = __arr
            local ____iter_286 = __iter
            local ____t_result_285
            if __t(g) then
                ____t_result_285 = __arrL(
                    {__add("minigames.fliperama.", g)},
                    1
                )
            else
                ____t_result_285 = __arrL({}, 0)
            end
            local ____array_287 = __TS__SparseArrayNew(__TS__Spread(____iter_286(____t_result_285)))
            __TS__SparseArrayPush(____array_287, "minigames.fliperama", "activities.memory", "menu.title")
            return ____arr_288(__TS__SparseArraySpread(____array_287))
        end
        local ____t_294 = __t
        local ____opt_291 = window.Campanha2
        if ____opt_291 ~= nil then
            ____opt_291 = ____opt_291.aberto
        end
        local ____opt_result_293
        if ____opt_291 ~= nil then
            ____opt_result_293 = ____opt_291(____opt_291)
        end
        if ____t_294(____opt_result_293) then
            local id = window.Campanha2:estado().cutscene
            if __t(id) then
                local ____arr_304 = __arr
                local ____add_result_303 = __add("cutscenes.", id)
                local ____iter_302 = __iter
                local ____t_result_301
                local ____t_300 = __t
                local ____opt_297 = window.Roteiro
                if ____opt_297 ~= nil then
                    ____opt_297 = ____opt_297.musicFor
                end
                local ____opt_result_299
                if ____opt_297 ~= nil then
                    ____opt_result_299 = ____opt_297(____opt_297, id)
                end
                __O[2405] = ____opt_result_299
                if ____t_300(____opt_result_299) then
                    ____t_result_301 = __O[2405]
                else
                    ____t_result_301 = __arrL({}, 0)
                end
                return ____arr_304(
                    ____add_result_303,
                    __TS__Spread(____iter_302(____t_result_301))
                )
            end
            local e2 = nil
            do
                pcall(function()
                    e2 = window.Campanha2:estado()
                end)
            end
            local ____t_308 = __t
            local ____opt_result_307
            if e2 ~= nil then
                ____opt_result_307 = e2.luta
            end
            if ____t_308(____opt_result_307) then
                return __arrL(
                    {
                        __add("c2.battles.", e2.luta),
                        "c2.battles"
                    },
                    2
                )
            end
            local ____t_result_313
            local ____t_312 = __t
            local ____opt_result_311
            if e2 ~= nil then
                ____opt_result_311 = e2.chave
            end
            if ____t_312(____opt_result_311) then
                ____t_result_313 = __arrL(
                    {
                        __add("c2.maps.", e2.chave),
                        "c2.maps"
                    },
                    2
                )
            else
                ____t_result_313 = __arrL({"c2.maps"}, 1)
            end
            return ____t_result_313
        end
        local ____t_319 = __t
        local ____opt_316 = window.CampanhaCutscenes
        if ____opt_316 ~= nil then
            ____opt_316 = ____opt_316.aberta
        end
        local ____opt_result_318
        if ____opt_316 ~= nil then
            ____opt_result_318 = ____opt_316(____opt_316)
        end
        if ____t_319(____opt_result_318) then
            return __arrL({}, 0)
        end
        do
            pcall(function()
                local ____opt_322 = window.Game
                if ____opt_322 ~= nil then
                    ____opt_322 = ____opt_322.getAudioState
                end
                local ____opt_result_324
                if ____opt_322 ~= nil then
                    ____opt_result_324 = ____opt_322(____opt_322)
                end
                state = ____opt_result_324
                local ____t_result_325
                if __t(state) then
                    ____t_result_325 = state
                else
                    ____t_result_325 = nil
                end
                lastAudioState = ____t_result_325
            end)
        end
        local ____t_329 = __t
        local ____opt_result_328
        if state ~= nil then
            ____opt_result_328 = state.chapterEnded
        end
        if ____t_329(____opt_result_328) then
            return __arrL({"events.chapter_end"}, 1)
        end
        local ____t_333 = __t
        local ____t_result_332
        local ____t_331 = __t
        local ____temp_330 = not __t(state) or not __t(state.started)
        __O[2406] = ____temp_330
        if ____t_331(____temp_330) then
            ____t_result_332 = __O[2406]
        else
            ____t_result_332 = state.playing == false
        end
        if ____t_333(____t_result_332) then
            local ____t_result_334
            if __t(config.bindings["menu.title"]) then
                ____t_result_334 = __arrL({"menu.title"}, 1)
            else
                ____t_result_334 = __arrL({"menu.title", "maps.roca"}, 2)
            end
            return ____t_result_334
        end
        local ____add_338 = __add
        local ____t_result_337
        local ____t_336 = __t
        local ____get_result_335 = __get(
            SCENES,
            __TS__Number(state.scene)
        )
        __O[2407] = ____get_result_335
        if ____t_336(____get_result_335) then
            ____t_result_337 = __O[2407]
        else
            ____t_result_337 = __get(SCENES, 0)
        end
        local map = ____add_338("maps.", ____t_result_337)
        if __t(state.cutscene) then
            local ____arr_348 = __arr
            local ____array_347 = __TS__SparseArrayNew(__add(
                "cutscenes.",
                tostring(state.cutscene)
            ))
            local ____iter_346 = __iter
            local ____t_result_345
            local ____t_344 = __t
            local ____opt_341 = window.Roteiro
            if ____opt_341 ~= nil then
                ____opt_341 = ____opt_341.musicFor
            end
            local ____opt_result_343
            if ____opt_341 ~= nil then
                ____opt_result_343 = ____opt_341(____opt_341, state.cutscene)
            end
            __O[2408] = ____opt_result_343
            if ____t_344(____opt_result_343) then
                ____t_result_345 = __O[2408]
            else
                ____t_result_345 = __arrL({}, 0)
            end
            __TS__SparseArrayPush(
                ____array_347,
                __TS__Spread(____iter_346(____t_result_345))
            )
            __TS__SparseArrayPush(
                ____array_347,
                __add(
                    "events.",
                    tostring(state.cutscene)
                ),
                map
            )
            return ____arr_348(__TS__SparseArraySpread(____array_347))
        end
        if __t(state.paused) then
            return __arrL({"menu.pause", map}, 2)
        end
        if __t(state.defeated) then
            return __arrL({"events.defeat", map}, 2)
        end
        if __t(state.boss) then
            local ____arr_352 = __arr
            local ____iter_350 = __iter
            local ____t_result_349
            if __t(__isInteger(state.bossPhase) and __gt(state.bossPhase, 0)) then
                ____t_result_349 = __arrL(
                    {__add(
                        __add(
                            __add("battles.", state.boss),
                            ".phase"
                        ),
                        state.bossPhase
                    )},
                    1
                )
            else
                ____t_result_349 = __arrL({}, 0)
            end
            local ____array_351 = __TS__SparseArrayNew(__TS__Spread(____iter_350(____t_result_349)))
            __TS__SparseArrayPush(
                ____array_351,
                __add("battles.", state.boss),
                map
            )
            return ____arr_352(__TS__SparseArraySpread(____array_351))
        end
        local ____t_354 = __t
        local ____t_result_353
        if __t(state.reeis) then
            ____t_result_353 = __call(
                __arrL({
                    "running",
                    "charging",
                    "transforming",
                    "arriving",
                    "invoke"
                }, 5),
                "includes",
                state.reeis
            )
        else
            ____t_result_353 = state.reeis
        end
        if ____t_354(____t_result_353) then
            return __arrL({"events.reeis_transform", map}, 2)
        end
        if __t(state.training) then
            return __arrL({"activity.caleb", map}, 2)
        end
        if __t(state.activity) then
            local key = __t(__call(
                __arrL({"football", "mota", "soccer"}, 3),
                "includes",
                state.activity
            )) and "mota" or (__t(__call(
                __arrL({"english", "quiz"}, 2),
                "includes",
                state.activity
            )) and "english" or state.activity)
            return __arrL(
                {
                    __add("activity.", key),
                    map
                },
                2
            )
        end
        local ____t_result_355
        if __t(state.room) then
            ____t_result_355 = __add("rooms.", state.room)
        else
            ____t_result_355 = nil
        end
        local room = ____t_result_355
        if __t(state.dialogue) then
            local name = normalName(nil, state.dialogue)
            local character = __call(
                speakers,
                "find",
                function(____, ____bindingPattern0)
                    local alias
                    alias = ____bindingPattern0[1]
                    local ____t_result_360
                    local ____t_359 = __t
                    local ____t_result_358
                    local ____t_357 = __t
                    local ____temp_356 = name == alias
                    __O[2409] = ____temp_356
                    if ____t_357(____temp_356) then
                        ____t_result_358 = __O[2409]
                    else
                        ____t_result_358 = __call(
                            name,
                            "startsWith",
                            __add(alias, " ")
                        )
                    end
                    __O[2410] = ____t_result_358
                    if ____t_359(____t_result_358) then
                        ____t_result_360 = __O[2410]
                    else
                        ____t_result_360 = __call(
                            name,
                            "endsWith",
                            __add(" ", alias)
                        )
                    end
                    return ____t_result_360
                end
            )
            if __t(character) then
                local ____arr_364 = __arr
                local ____array_363 = __TS__SparseArrayNew(__add(
                    "characters.",
                    __get(character, 1)
                ))
                local ____iter_362 = __iter
                local ____t_result_361
                if __t(room) then
                    ____t_result_361 = __arrL({room}, 1)
                else
                    ____t_result_361 = __arrL({}, 0)
                end
                __TS__SparseArrayPush(
                    ____array_363,
                    __TS__Spread(____iter_362(____t_result_361))
                )
                __TS__SparseArrayPush(____array_363, map)
                return ____arr_364(__TS__SparseArraySpread(____array_363))
            end
        end
        local ____arr_368 = __arr
        local ____iter_366 = __iter
        local ____t_result_365
        if __t(room) then
            ____t_result_365 = __arrL({room}, 1)
        else
            ____t_result_365 = __arrL({}, 0)
        end
        local ____array_367 = __TS__SparseArrayNew(__TS__Spread(____iter_366(____t_result_365)))
        __TS__SparseArrayPush(____array_367, map)
        return ____arr_368(__TS__SparseArraySpread(____array_367))
    end
    function select(self)
        local list = candidates(nil)
        local ____t_result_375
        local ____t_374 = __t
        local ____get_result_373 = __get(list, 0)
        __O[2412] = ____get_result_373
        if ____t_374(____get_result_373) then
            ____t_result_375 = __O[2412]
        else
            ____t_result_375 = "menu.title"
        end
        context = ____t_result_375
        if context == ARENA_SHUFFLE then
            return selectArena(nil)
        end
        for ____, key in __iterar((list)) do
            do
                local binding = __get(config.bindings, key)
                if __t(not __t(binding) or binding.enabled == false) then
                    continue
                end
                local track = __call(
                    config.tracks,
                    "find",
                    function(____, t) return t.id == binding.trackId end
                )
                if not __t(track) then
                    continue
                end
                local ____opt_result_378
                if lastAudioState ~= nil then
                    ____opt_result_378 = lastAudioState.cutscene
                end
                local cutsceneKind = ____opt_result_378
                local ____t_result_381
                local ____t_380 = __t
                local ____temp_379 = key == __add("events.", cutsceneKind)
                __O[2413] = ____temp_379
                if ____t_380(____temp_379) then
                    ____t_result_381 = binding.startSeconds ~= nil or binding.delaySeconds ~= nil
                else
                    ____t_result_381 = __O[2413]
                end
                local legacyCue = ____t_result_381
                local ____t_386 = __t
                local ____t_result_385
                if __t(cutsceneKind) then
                    local ____t_result_384
                    local ____t_383 = __t
                    local ____temp_382 = key == __add("cutscenes.", cutsceneKind)
                    __O[2414] = ____temp_382
                    if ____t_383(____temp_382) then
                        ____t_result_384 = __O[2414]
                    else
                        ____t_result_384 = legacyCue
                    end
                    ____t_result_385 = ____t_result_384
                else
                    ____t_result_385 = cutsceneKind
                end
                local ____temp_389 = not not ____t_386(____t_result_385)
                if not ____temp_389 then
                    local ____t_388 = __t
                    local ____t_result_387
                    if __t(override) then
                        ____t_result_387 = __call(key, "startsWith", "cutscenes.")
                    else
                        ____t_result_387 = override
                    end
                    ____temp_389 = not not ____t_388(____t_result_387)
                end
                local cutscene = ____temp_389
                local ____t_result_390
                if __t(binding.startSeconds) then
                    ____t_result_390 = binding.startSeconds
                else
                    ____t_result_390 = 0
                end
                local startSeconds = ____t_result_390
                local ____t_result_392
                if __t(cutscene) then
                    local ____t_result_391
                    if __t(binding.delaySeconds) then
                        ____t_result_391 = binding.delaySeconds
                    else
                        ____t_result_391 = 0
                    end
                    ____t_result_392 = ____t_result_391
                else
                    ____t_result_392 = 0
                end
                local delaySeconds = ____t_result_392
                local ____t_result_398
                if __t(cutscene) then
                    local ____t_result_397
                    if __t(override) then
                        ____t_result_397 = __add("override-", overrideSerial)
                    else
                        local ____opt_result_395
                        if lastAudioState ~= nil then
                            ____opt_result_395 = lastAudioState.cutsceneToken
                        end
                        local ____opt_result_395_396 = ____opt_result_395
                        if ____opt_result_395_396 == nil then
                            ____opt_result_395_396 = cutsceneKind
                        end
                        ____t_result_397 = ____opt_result_395_396
                    end
                    ____t_result_398 = ____t_result_397
                else
                    ____t_result_398 = nil
                end
                local token = ____t_result_398
                matchedContext = key
                local ____track_421 = track
                local ____key_422 = key
                local ____t_result_400
                if __t(isNative) then
                    ____t_result_400 = track.file
                else
                    local ____t_result_399
                    if __t(track.url) then
                        ____t_result_399 = track.url
                    else
                        ____t_result_399 = track.file
                    end
                    ____t_result_400 = ____t_result_399
                end
                local ____temp_401
                if binding.loop == nil then
                    ____temp_401 = track.loop
                else
                    ____temp_401 = binding.loop
                end
                local ____temp_408 = config.masterVolume * track.volume * (binding.volume == nil and 1 or binding.volume)
                local ____opt_404 = window.DarocaAudio
                if ____opt_404 ~= nil then
                    ____opt_404 = ____opt_404.music
                end
                local ____opt_result_406
                if ____opt_404 ~= nil then
                    ____opt_result_406 = ____opt_404(____opt_404)
                end
                local ____opt_result_406_407 = ____opt_result_406
                if ____opt_result_406_407 == nil then
                    ____opt_result_406_407 = 1
                end
                local ____clamp_result_423 = clamp(nil, ____temp_408 * ____opt_result_406_407, 0, 1)
                local ____temp_409
                if binding.fadeMs == nil then
                    ____temp_409 = track.fadeMs
                else
                    ____temp_409 = binding.fadeMs
                end
                local ____startSeconds_424 = startSeconds
                local ____delaySeconds_425 = delaySeconds
                local ____cutscene_426 = cutscene
                local ____token_427 = token
                local ____t_result_413
                if __t(cutscene) then
                    local ____opt_result_412
                    if lastAudioState ~= nil then
                        ____opt_result_412 = lastAudioState.cutsceneElapsed
                    end
                    ____t_result_413 = math.max(
                        0,
                        number(nil, ____opt_result_412, 0)
                    )
                else
                    ____t_result_413 = 0
                end
                local ____t_result_418
                if __t(cutscene) then
                    local ____opt_result_416
                    if lastAudioState ~= nil then
                        ____opt_result_416 = lastAudioState.cutsceneIndex
                    end
                    local ____opt_result_416_417 = ____opt_result_416
                    if ____opt_result_416_417 == nil then
                        ____opt_result_416_417 = 0
                    end
                    ____t_result_418 = ____opt_result_416_417
                else
                    ____t_result_418 = nil
                end
                local ____t_result_420
                if __t(cutscene) then
                    ____t_result_420 = __add(
                        __add(
                            __add(
                                __add(
                                    __add(
                                        __add(
                                            __add("film|", token),
                                            "|"
                                        ),
                                        key
                                    ),
                                    "|"
                                ),
                                startSeconds
                            ),
                            "|"
                        ),
                        delaySeconds
                    )
                else
                    local ____gt_result_419
                    if __gt(startSeconds, 0) then
                        ____gt_result_419 = __add(
                            __add(
                                __add("offset|", track.id),
                                "|"
                            ),
                            startSeconds
                        )
                    else
                        ____gt_result_419 = nil
                    end
                    ____t_result_420 = ____gt_result_419
                end
                return {
                    track = ____track_421,
                    key = ____key_422,
                    src = ____t_result_400,
                    loop = ____temp_401,
                    volume = ____clamp_result_423,
                    fadeMs = ____temp_409,
                    startSeconds = ____startSeconds_424,
                    delaySeconds = ____delaySeconds_425,
                    cutscene = ____cutscene_426,
                    token = ____token_427,
                    elapsed = ____t_result_413,
                    index = ____t_result_418,
                    cueKey = ____t_result_420
                }
            end
        end
        matchedContext = nil
        return nil
    end
    function timelineSelection(self, selection)
        local ____t_431 = __t
        local ____opt_result_430
        if selection ~= nil then
            ____opt_result_430 = selection.cutscene
        end
        if not ____t_431(____opt_result_430) then
            filmClock = nil
            return selection
        end
        local time = now(nil)
        local ____t_result_438
        local ____t_433 = __t
        local ____temp_432 = not __t(nativePaused) and not __t(window.document.hidden)
        __O[2415] = ____temp_432
        if ____t_433(____temp_432) then
            local ____t_437 = __t
            local ____opt_result_436
            if lastAudioState ~= nil then
                ____opt_result_436 = lastAudioState.paused
            end
            ____t_result_438 = not ____t_437(____opt_result_436)
        else
            ____t_result_438 = __O[2415]
        end
        local running = ____t_result_438
        if __t(not __t(filmClock) or filmClock.key ~= selection.cueKey) then
            filmClock = {key = selection.cueKey, elapsed = selection.elapsed, lastAt = time, running = running}
        else
            if __t(filmClock.running) then
                filmClock.elapsed = filmClock.elapsed + math.max(0, time - filmClock.lastAt) / 1000
            end
            filmClock.lastAt = time
            filmClock.running = running
        end
        return __assign({}, selection, {elapsed = filmClock.elapsed})
    end
    function targetPosition(self, selection, audio)
        local ____t_result_439
        if __t(__isFiniteN(audio.duration) and __gt(audio.duration, 0)) then
            ____t_result_439 = audio.duration
        else
            ____t_result_439 = selection.track.duration
        end
        local duration = ____t_result_439
        local ____gt_result_440
        if __gt(duration, 0) then
            ____gt_result_440 = math.min(
                selection.startSeconds,
                math.max(0, duration - 0.01)
            )
        else
            ____gt_result_440 = selection.startSeconds
        end
        local start = ____gt_result_440
        local ____t_result_441
        if __t(selection.cutscene) then
            ____t_result_441 = math.max(0, selection.elapsed - selection.delaySeconds)
        else
            ____t_result_441 = 0
        end
        local raw = start + ____t_result_441
        if __t(__gt(duration, 0) and __ge(raw, duration)) then
            local ____t_443 = __t
            local ____t_result_442
            if __t(selection.loop) then
                ____t_result_442 = duration - start > 0.01
            else
                ____t_result_442 = selection.loop
            end
            if ____t_443(____t_result_442) then
                return {
                    seconds = start + __mod(raw - start, duration - start),
                    ended = false
                }
            end
            return {seconds = duration, ended = true}
        end
        return {seconds = raw, ended = false}
    end
    function waitMetadata(self, v, generation)
        local ____t_445 = __t
        local ____temp_444
        if type(v.audio.readyState) == "number" then
            ____temp_444 = __ge(v.audio.readyState, 1)
        else
            ____temp_444 = __isFiniteN(v.audio.duration) and __gt(v.audio.duration, 0)
        end
        if ____t_445(____temp_444) then
            return __TS__Promise.resolve(true)
        end
        local ____this_447
        ____this_447 = v
        local ____opt_446 = ____this_447.cancelMetadata
        if ____opt_446 ~= nil then
            ____opt_446(____this_447)
        end
        return __TS__New(
            __TS__Promise,
            function(____, resolve)
                local loaded, failed, cancel
                local timer
                local done = false
                local function finish(____, ok)
                    if __t(done) then
                        return
                    end
                    done = true
                    window:clearTimeout(timer)
                    local ____this_449
                    ____this_449 = v.audio
                    local ____opt_448 = ____this_449.removeEventListener
                    if ____opt_448 ~= nil then
                        ____opt_448(____this_449, "loadedmetadata", loaded)
                    end
                    local ____this_451
                    ____this_451 = v.audio
                    local ____opt_450 = ____this_451.removeEventListener
                    if ____opt_450 ~= nil then
                        ____opt_450(____this_451, "error", failed)
                    end
                    if v.cancelMetadata == cancel then
                        v.cancelMetadata = nil
                    end
                    local ____resolve_459 = resolve
                    local ____t_result_458
                    local ____t_457 = __t
                    local ____t_result_456
                    local ____t_455 = __t
                    local ____t_result_454
                    local ____t_453 = __t
                    local ____t_result_452
                    if __t(ok) then
                        ____t_result_452 = generation == requestGeneration
                    else
                        ____t_result_452 = ok
                    end
                    __O[2416] = ____t_result_452
                    if ____t_453(____t_result_452) then
                        ____t_result_454 = v.pending == generation
                    else
                        ____t_result_454 = __O[2416]
                    end
                    __O[2417] = ____t_result_454
                    if ____t_455(____t_result_454) then
                        ____t_result_456 = not __t(suspended(nil))
                    else
                        ____t_result_456 = __O[2417]
                    end
                    __O[2418] = ____t_result_456
                    if ____t_457(____t_result_456) then
                        ____t_result_458 = enabled
                    else
                        ____t_result_458 = __O[2418]
                    end
                    ____resolve_459(nil, ____t_result_458)
                end
                loaded = function() return finish(nil, true) end
                failed = function() return finish(nil, false) end
                cancel = function() return finish(nil, false) end
                v.cancelMetadata = cancel
                v.audio:addEventListener("loadedmetadata", loaded)
                v.audio:addEventListener("error", failed)
                timer = window:setTimeout(failed, 8000)
            end
        )
    end
    function playVoice(self, v, selection, generation, seek)
        if seek == nil then
            seek = false
        end
        return __TS__AsyncAwaiter(function(____awaiter_resolve)
            local same = v.id == selection.track.id and v.src == selection.src
            local ____this_461
            ____this_461 = v
            local ____opt_460 = ____this_461.cancelMetadata
            if ____opt_460 ~= nil then
                ____opt_460(____this_461)
            end
            if not __t(same) then
                v.audio:pause()
                gain(nil, v, 0, 0)
                v.id = selection.track.id
                v.src = selection.src
                v.ended = false
                v.warming = false
                v.cueKey = nil
                v.audio.src = selection.src
                v.loads = v.loads + 1
                local ____this_463
                ____this_463 = v.audio
                local ____opt_462 = ____this_463.load
                if ____opt_462 ~= nil then
                    ____opt_462(____this_463)
                end
            end
            v.loop = selection.loop
            v.startSeconds = selection.startSeconds
            local ____v_audio_465 = v.audio
            local ____t_result_464
            if __t(selection.loop) then
                ____t_result_464 = selection.startSeconds == 0
            else
                ____t_result_464 = selection.loop
            end
            ____v_audio_465.loop = ____t_result_464
            local ____t_result_473
            local ____t_471 = __t
            local ____t_result_470
            local ____t_469 = __t
            local ____t_result_468
            local ____t_467 = __t
            local ____temp_466 = not __t(same)
            __O[2419] = ____temp_466
            if ____t_467(____temp_466) then
                ____t_result_468 = __O[2419]
            else
                ____t_result_468 = seek
            end
            __O[2420] = ____t_result_468
            if ____t_469(____t_result_468) then
                ____t_result_470 = __O[2420]
            else
                ____t_result_470 = v.cueKey ~= selection.cueKey
            end
            __O[2421] = ____t_result_470
            if ____t_471(____t_result_470) then
                ____t_result_473 = __O[2421]
            else
                local ____t_result_472
                if __t(v.ended) then
                    ____t_result_472 = selection.loop
                else
                    ____t_result_472 = v.ended
                end
                ____t_result_473 = ____t_result_472
            end
            local needsSeek = ____t_result_473
            local ____t_480 = __t
            local ____t_result_479
            if __t(needsSeek) then
                local ____t_result_478
                local ____t_477 = __t
                local ____t_result_476
                local ____t_475 = __t
                local ____t_result_474
                if __t(selection.cutscene) then
                    ____t_result_474 = selection.cutscene
                else
                    ____t_result_474 = selection.arenaShuffle
                end
                __O[2422] = ____t_result_474
                if ____t_475(____t_result_474) then
                    ____t_result_476 = __O[2422]
                else
                    ____t_result_476 = __gt(selection.startSeconds, 0)
                end
                __O[2423] = ____t_result_476
                if ____t_477(____t_result_476) then
                    ____t_result_478 = __O[2423]
                else
                    ____t_result_478 = __callq(v.cueKey, "startsWith", "offset|")
                end
                ____t_result_479 = ____t_result_478
            else
                ____t_result_479 = needsSeek
            end
            if ____t_480(____t_result_479) then
                if not __t(__TS__Await(waitMetadata(nil, v, generation))) then
                    local ____t_484 = __t
                    local ____t_result_483
                    local ____t_482 = __t
                    local ____temp_481 = generation == requestGeneration and not __t(suspended(nil))
                    __O[2424] = ____temp_481
                    if ____t_482(____temp_481) then
                        ____t_result_483 = enabled
                    else
                        ____t_result_483 = __O[2424]
                    end
                    if ____t_484(____t_result_483) then
                        lastError = "Não foi possível carregar o trecho da música. Toque no som para tentar novamente."
                    end
                    return ____awaiter_resolve(nil, false)
                end
                local ____t_490 = __t
                local ____t_result_489
                local ____t_488 = __t
                local ____t_result_487
                local ____t_486 = __t
                local ____temp_485 = generation ~= requestGeneration or v.pending ~= generation
                __O[2425] = ____temp_485
                if ____t_486(____temp_485) then
                    ____t_result_487 = __O[2425]
                else
                    ____t_result_487 = not __t(enabled)
                end
                __O[2426] = ____t_result_487
                if ____t_488(____t_result_487) then
                    ____t_result_489 = __O[2426]
                else
                    ____t_result_489 = suspended(nil)
                end
                if ____t_490(____t_result_489) then
                    return ____awaiter_resolve(nil, false)
                end
                selection = timelineSelection(nil, selection)
                local ____t_result_497
                local ____t_492 = __t
                local ____t_result_491
                if __t(v.ended) then
                    ____t_result_491 = selection.loop
                else
                    ____t_result_491 = v.ended
                end
                if ____t_492(____t_result_491) then
                    local ____selection_startSeconds_496 = selection.startSeconds
                    local ____t_result_495
                    local ____t_494 = __t
                    local ____t_result_493
                    if __t(v.audio.duration) then
                        ____t_result_493 = v.audio.duration
                    else
                        ____t_result_493 = selection.track.duration
                    end
                    __O[2427] = ____t_result_493
                    if ____t_494(____t_result_493) then
                        ____t_result_495 = __O[2427]
                    else
                        ____t_result_495 = math.huge
                    end
                    ____t_result_497 = {
                        seconds = math.min(
                            ____selection_startSeconds_496,
                            math.max(0, ____t_result_495 - 0.01)
                        ),
                        ended = false
                    }
                else
                    ____t_result_497 = targetPosition(nil, selection, v.audio)
                end
                local target = ____t_result_497
                if __t(target.ended) then
                    v.ended = true
                    v.cueKey = selection.cueKey
                    v.cutsceneIndex = selection.index
                    gain(nil, v, 0, 0)
                    v.audio:pause()
                    return ____awaiter_resolve(nil, false)
                end
                local ____hasReturned, ____returnValue
                local ____try = __TS__AsyncAwaiter(function()
                    v.audio.currentTime = target.seconds
                    v.seeks = v.seeks + 1
                    v.ended = false
                end)
                ____try = ____try.catch(
                    ____try,
                    function(____)
                        return __TS__AsyncAwaiter(function()
                            lastError = "Não foi possível posicionar o trecho da música."
                            ____hasReturned = true
                            ____returnValue = false
                            return
                        end)
                    end
                )
                __TS__Await(____try)
                if ____hasReturned then
                    return ____awaiter_resolve(nil, ____returnValue)
                end
            else
                local ____t_499 = __t
                local ____t_result_498
                if __t(needsSeek) then
                    ____t_result_498 = not __t(same)
                else
                    ____t_result_498 = needsSeek
                end
                if ____t_499(____t_result_498) then
                    local ____try = __TS__AsyncAwaiter(function()
                        v.audio.currentTime = 0
                    end)
                    ____try = ____try.catch(
                        ____try,
                        function(____)
                            return __TS__AsyncAwaiter(function()
                            end)
                        end
                    )
                    __TS__Await(____try)
                end
            end
            v.cueKey = selection.cueKey
            v.cutsceneIndex = selection.index
            local ____t_501 = __t
            local ____t_result_500
            if __t(v.ended) then
                ____t_result_500 = not __t(selection.loop)
            else
                ____t_result_500 = v.ended
            end
            if ____t_501(____t_result_500) then
                return ____awaiter_resolve(nil, false)
            end
            local ____hasReturned, ____returnValue
            local ____try = __TS__AsyncAwaiter(function()
                local ____t_503 = __t
                local ____t_result_502
                if __t(audioContext) then
                    ____t_result_502 = audioContext.state ~= "running"
                else
                    ____t_result_502 = audioContext
                end
                if ____t_503(____t_result_502) then
                    __TS__Await(audioContext:resume())
                end
                local ____t_509 = __t
                local ____t_result_508
                local ____t_507 = __t
                local ____t_result_506
                local ____t_505 = __t
                local ____temp_504 = generation ~= requestGeneration or v.pending ~= generation
                __O[2428] = ____temp_504
                if ____t_505(____temp_504) then
                    ____t_result_506 = __O[2428]
                else
                    ____t_result_506 = not __t(enabled)
                end
                __O[2429] = ____t_result_506
                if ____t_507(____t_result_506) then
                    ____t_result_508 = __O[2429]
                else
                    ____t_result_508 = suspended(nil)
                end
                if ____t_509(____t_result_508) then
                    ____hasReturned = true
                    ____returnValue = false
                    return
                end
                local p = v.audio:play()
                v.plays = v.plays + 1
                __TS__Await(__TS__Promise.resolve(p))
                local ____t_513 = __t
                local ____t_result_512
                local ____t_511 = __t
                local ____temp_510 = generation ~= requestGeneration or not __t(enabled)
                __O[2430] = ____temp_510
                if ____t_511(____temp_510) then
                    ____t_result_512 = __O[2430]
                else
                    ____t_result_512 = suspended(nil)
                end
                if ____t_513(____t_result_512) then
                    if __t(active ~= v.index and v.pending == generation) then
                        gain(nil, v, 0, 0)
                        v.audio:pause()
                    end
                    ____hasReturned = true
                    ____returnValue = false
                    return
                end
                ____hasReturned = true
                ____returnValue = true
                return
            end)
            ____try = ____try.catch(
                ____try,
                function(____, e)
                    return __TS__AsyncAwaiter(function()
                        if generation == requestGeneration then
                            local ____opt_result_516
                            if e ~= nil then
                                ____opt_result_516 = e.name
                            end
                            lastError = ____opt_result_516 == "NotAllowedError" and "Toque novamente no botão de som para liberar a música." or __add(
                                __add("Não foi possível iniciar “", selection.track.title),
                                "”."
                            )
                        end
                        ____hasReturned = true
                        ____returnValue = false
                        return
                    end)
                end
            )
            __TS__Await(____try)
            if ____hasReturned then
                return ____awaiter_resolve(nil, ____returnValue)
            end
        end)
    end
    function silenceSelection(self, key, fade)
        if lastAttempt == key then
            return
        end
        lastAttempt = key
        requestGeneration = requestGeneration + 1
        active = -1
        for ____, v in __iterar((voices)) do
            local ____opt_517 = v.cancelMetadata
            if ____opt_517 ~= nil then
                ____opt_517(v)
            end
            if not __t(v.audio.paused) then
                gain(nil, v, 0, fade)
                if __le(fade, 0) then
                    v.audio:pause()
                end
            end
        end
        transition = __call(
            voices,
            "some",
            function(____, v) return not __t(v.audio.paused) end
        )
    end
    function syncSelection(self, force)
        if force == nil then
            force = false
        end
        local selection = timelineSelection(
            nil,
            select(nil)
        )
        desired = selection
        local ____t_524 = __t
        local ____t_result_523
        local ____t_522 = __t
        local ____opt_result_521
        if lastAudioState ~= nil then
            ____opt_result_521 = lastAudioState.cutscene
        end
        __O[2431] = ____opt_result_521
        if ____t_522(____opt_result_521) then
            ____t_result_523 = lastAudioState.paused
        else
            ____t_result_523 = __O[2431]
        end
        local nextPaused = not not ____t_524(____t_result_523)
        if nextPaused ~= gamePaused then
            gamePaused = nextPaused
            if __t(gamePaused) then
                pauseForLifecycle(nil)
            else
                lastAttempt = ""
                do
                    pcall(function()
                        local ____opt_result_529
                        if audioContext ~= nil then
                            ____opt_result_529 = audioContext:resume()
                        end
                        if ____opt_result_529 ~= nil then
                            ____opt_result_529:catch(function()
                            end)
                        end
                    end)
                end
            end
        end
        local ____t_535 = __t
        local ____t_result_534
        local ____t_533 = __t
        local ____t_result_532
        local ____t_531 = __t
        local ____temp_530 = not __t(ready) or not __t(enabled)
        __O[2432] = ____temp_530
        if ____t_531(____temp_530) then
            ____t_result_532 = __O[2432]
        else
            ____t_result_532 = not __t(unlocked)
        end
        __O[2433] = ____t_result_532
        if ____t_533(____t_result_532) then
            ____t_result_534 = __O[2433]
        else
            ____t_result_534 = suspended(nil)
        end
        if ____t_535(____t_result_534) then
            return
        end
        makeVoices(nil)
        if not __t(selection) then
            silenceSelection(
                nil,
                __add(
                    __add(
                        __add("none|", context),
                        "|"
                    ),
                    config.revision
                ),
                config.defaultFadeMs
            )
            return
        end
        local ____t_537 = __t
        local ____t_result_536
        if __t(selection.cutscene) then
            ____t_result_536 = __lt(selection.elapsed + 0.005, selection.delaySeconds)
        else
            ____t_result_536 = selection.cutscene
        end
        if ____t_537(____t_result_536) then
            silenceSelection(
                nil,
                __add(
                    __add(
                        __add("wait|", selection.cueKey),
                        "|"
                    ),
                    config.revision
                ),
                selection.fadeMs
            )
            return
        end
        local same = __call(
            voices,
            "find",
            function(____, v) return v.id == selection.track.id and v.src == selection.src end
        )
        local ____t_result_544
        if __t(same) then
            local ____t_result_543
            local ____t_539 = __t
            local ____temp_538 = selection.cueKey ~= nil and same.cueKey ~= selection.cueKey
            __O[2435] = ____temp_538
            if ____t_539(____temp_538) then
                ____t_result_543 = __O[2435]
            else
                local ____t_result_542
                local ____t_541 = __t
                local ____temp_540 = selection.cueKey == nil
                __O[2434] = ____temp_540
                if ____t_541(____temp_540) then
                    ____t_result_542 = __callq(same.cueKey, "startsWith", "offset|")
                else
                    ____t_result_542 = __O[2434]
                end
                ____t_result_543 = ____t_result_542
            end
            ____t_result_544 = ____t_result_543
        else
            ____t_result_544 = same
        end
        local cueChanged = ____t_result_544
        local ____t_548 = __t
        local ____t_result_547
        local ____t_546 = __t
        local ____t_result_545
        if __t(selection.cutscene) then
            ____t_result_545 = not __t(same) or same.cueKey ~= selection.cueKey
        else
            ____t_result_545 = selection.cutscene
        end
        __O[2436] = ____t_result_545
        if ____t_546(____t_result_545) then
            ____t_result_547 = targetPosition(nil, selection, {duration = selection.track.duration}).ended
        else
            ____t_result_547 = __O[2436]
        end
        if ____t_548(____t_result_547) then
            silenceSelection(
                nil,
                __add("end|", selection.cueKey),
                selection.fadeMs
            )
            return
        end
        local ____t_554 = __t
        local ____t_result_553
        local ____t_552 = __t
        local ____t_result_551
        local ____t_550 = __t
        local ____t_result_549
        if __t(same) then
            ____t_result_549 = active == same.index
        else
            ____t_result_549 = same
        end
        __O[2437] = ____t_result_549
        if ____t_550(____t_result_549) then
            ____t_result_551 = not __t(same.audio.paused)
        else
            ____t_result_551 = __O[2437]
        end
        __O[2438] = ____t_result_551
        if ____t_552(____t_result_551) then
            ____t_result_553 = not __t(cueChanged)
        else
            ____t_result_553 = __O[2438]
        end
        if ____t_554(____t_result_553) then
            same.cueKey = selection.cueKey
            same.cutsceneIndex = selection.index
            same.loop = selection.loop
            same.startSeconds = selection.startSeconds
            local ____same_audio_556 = same.audio
            local ____t_result_555
            if __t(selection.loop) then
                ____t_result_555 = selection.startSeconds == 0
            else
                ____t_result_555 = selection.loop
            end
            ____same_audio_556.loop = ____t_result_555
            local ____opt_557 = same.ramp
            if ____opt_557 ~= nil then
                ____opt_557 = ____opt_557.to
            end
            local ____opt_557_559 = ____opt_557
            if ____opt_557_559 == nil then
                ____opt_557_559 = same.volume
            end
            local target = ____opt_557_559
            if math.abs(target - selection.volume) > 0.0001 then
                gain(
                    nil,
                    same,
                    selection.volume,
                    math.min(300, selection.fadeMs)
                )
            end
            return
        end
        local attempt = __add(
            __add(
                __add(
                    __add(
                        __add(
                            __add(
                                __add(
                                    __add(
                                        __add(
                                            __add(selection.track.id, "|"),
                                            selection.src
                                        ),
                                        "|"
                                    ),
                                    selection.loop
                                ),
                                "|"
                            ),
                            selection.key
                        ),
                        "|"
                    ),
                    selection.cueKey
                ),
                "|"
            ),
            config.revision
        )
        if __t(not __t(force) and lastAttempt == attempt) then
            return
        end
        local ____t_569 = __t
        local ____t_result_568
        local ____t_567 = __t
        local ____t_result_566
        local ____t_565 = __t
        local ____t_result_564
        local ____t_563 = __t
        local ____opt_result_562
        if same ~= nil then
            ____opt_result_562 = same.ended
        end
        __O[2439] = ____opt_result_562
        if ____t_563(____opt_result_562) then
            ____t_result_564 = not __t(selection.loop)
        else
            ____t_result_564 = __O[2439]
        end
        __O[2440] = ____t_result_564
        if ____t_565(____t_result_564) then
            ____t_result_566 = same.cueKey == selection.cueKey
        else
            ____t_result_566 = __O[2440]
        end
        __O[2441] = ____t_result_566
        if ____t_567(____t_result_566) then
            ____t_result_568 = not __t(cueChanged)
        else
            ____t_result_568 = __O[2441]
        end
        if ____t_569(____t_result_568) then
            lastAttempt = attempt
            return
        end
        lastAttempt = attempt
        requestGeneration = requestGeneration + 1
        local generation = requestGeneration
        local ____t_result_570
        if __t(same) then
            ____t_result_570 = same.index
        else
            ____t_result_570 = active == 0 and 1 or 0
        end
        local index = ____t_result_570
        local v = __get(voices, index)
        local ____temp_571
        if active >= 0 then
            ____temp_571 = __get(voices, active)
        else
            ____temp_571 = nil
        end
        local old = ____temp_571
        if old ~= v then
            gain(nil, v, 0, 0)
        end
        v.pending = generation
        local ____self_572 = playVoice(
            nil,
            v,
            selection,
            generation,
            cueChanged
        )
        ____self_572["then"](
            ____self_572,
            function(____, ok)
                if __t(not __t(ok) or generation ~= requestGeneration) then
                    return
                end
                active = index
                lastError = ""
                gain(nil, v, selection.volume, selection.fadeMs)
                for ____, other in __iterar((voices)) do
                    if __t(other ~= v and not __t(other.audio.paused)) then
                        gain(nil, other, 0, selection.fadeMs)
                    end
                end
                transition = __gt(selection.fadeMs, 0)
            end
        ):finally(function()
            if v.pending == generation then
                v.pending = 0
            end
        end)
    end
    function pauseForLifecycle(self)
        if __t(filmClock) then
            if __t(filmClock.running) then
                filmClock.elapsed = filmClock.elapsed + math.max(
                    0,
                    now(nil) - filmClock.lastAt
                ) / 1000
            end
            filmClock.lastAt = now(nil)
            filmClock.running = false
        end
        requestGeneration = requestGeneration + 1
        lastAttempt = ""
        for ____, v in __iterar((voices)) do
            local ____opt_592 = v.cancelMetadata
            if ____opt_592 ~= nil then
                ____opt_592(v)
            end
            gain(nil, v, 0, 0)
            v.audio:pause()
        end
        transition = false
        do
            pcall(function()
                local ____opt_result_598
                if audioContext ~= nil then
                    ____opt_result_598 = audioContext:suspend()
                end
                if ____opt_result_598 ~= nil then
                    ____opt_result_598:catch(function()
                    end)
                end
            end)
        end
    end
    function isPlaying(self)
        local ____t_result_619
        local ____t_615 = __t
        local ____t_result_614
        local ____t_613 = __t
        local ____t_result_612
        local ____t_611 = __t
        local ____t_result_610
        if __t(enabled) then
            ____t_result_610 = unlocked
        else
            ____t_result_610 = enabled
        end
        __O[2446] = ____t_result_610
        if ____t_611(____t_result_610) then
            ____t_result_612 = not __t(suspended(nil))
        else
            ____t_result_612 = __O[2446]
        end
        __O[2447] = ____t_result_612
        if ____t_613(____t_result_612) then
            ____t_result_614 = not __t(audioContext) or audioContext.state == "running"
        else
            ____t_result_614 = __O[2447]
        end
        __O[2449] = ____t_result_614
        if ____t_615(____t_result_614) then
            ____t_result_619 = __call(
                voices,
                "some",
                function(____, v)
                    local ____t_result_618
                    local ____t_617 = __t
                    local ____temp_616 = not __t(v.audio.paused) and not __t(v.audio.ended)
                    __O[2448] = ____temp_616
                    if ____t_617(____temp_616) then
                        ____t_result_618 = __gt(
                            currentVolume(nil, v),
                            0.0001
                        )
                    else
                        ____t_result_618 = __O[2448]
                    end
                    return ____t_result_618
                end
            )
        else
            ____t_result_619 = __O[2449]
        end
        return ____t_result_619
    end
    function getStatus(self)
        local ____ready_664 = ready
        local ____enabled_665 = enabled
        local ____unlocked_666 = unlocked
        local ____source_667 = source
        local ____config_revision_668 = config.revision
        local ____context_669 = context
        local ____matchedContext_670 = matchedContext
        local ____t_result_624
        local ____t_623 = __t
        local ____opt_result_622
        if desired ~= nil then
            ____opt_result_622 = desired.track.id
        end
        __O[2450] = ____opt_result_622
        if ____t_623(____opt_result_622) then
            ____t_result_624 = __O[2450]
        else
            ____t_result_624 = nil
        end
        local ____t_result_629
        local ____t_628 = __t
        local ____opt_result_627
        if desired ~= nil then
            ____opt_result_627 = desired.track.title
        end
        __O[2451] = ____opt_result_627
        if ____t_628(____opt_result_627) then
            ____t_result_629 = __O[2451]
        else
            ____t_result_629 = nil
        end
        local ____t_result_634
        local ____t_633 = __t
        local ____opt_result_632
        if desired ~= nil then
            ____opt_result_632 = desired.startSeconds
        end
        __O[2452] = ____opt_result_632
        if ____t_633(____opt_result_632) then
            ____t_result_634 = __O[2452]
        else
            ____t_result_634 = 0
        end
        local ____t_result_639
        local ____t_638 = __t
        local ____opt_result_637
        if desired ~= nil then
            ____opt_result_637 = desired.delaySeconds
        end
        __O[2453] = ____opt_result_637
        if ____t_638(____opt_result_637) then
            ____t_result_639 = __O[2453]
        else
            ____t_result_639 = 0
        end
        local ____opt_result_642
        if desired ~= nil then
            ____opt_result_642 = desired.token
        end
        local ____opt_result_642_643 = ____opt_result_642
        if ____opt_result_642_643 == nil then
            ____opt_result_642_643 = nil
        end
        local ____opt_result_646
        if desired ~= nil then
            ____opt_result_646 = desired.elapsed
        end
        local ____opt_result_646_647 = ____opt_result_646
        if ____opt_result_646_647 == nil then
            ____opt_result_646_647 = nil
        end
        local ____t_653 = __t
        local ____t_result_652
        local ____t_651 = __t
        local ____opt_result_650
        if desired ~= nil then
            ____opt_result_650 = desired.cutscene
        end
        __O[2454] = ____opt_result_650
        if ____t_651(____opt_result_650) then
            ____t_result_652 = __lt(desired.elapsed, desired.delaySeconds)
        else
            ____t_result_652 = __O[2454]
        end
        local ____temp_671 = not not ____t_653(____t_result_652)
        local ____isPlaying_result_672 = isPlaying(nil)
        local ____transition_673 = transition
        local ____t_result_654
        if __t(lastError) then
            ____t_result_654 = lastError
        else
            ____t_result_654 = nil
        end
        local ____t_result_655
        if __t(configError) then
            ____t_result_655 = configError
        else
            ____t_result_655 = nil
        end
        local ____t_result_656
        if __t(arenaPlaylist.open) then
            ____t_result_656 = {
                mode = "shuffle",
                size = __len(config.tracks),
                currentTrackId = arenaPlaylist.currentId,
                remaining = __len(arenaPlaylist.bag),
                session = arenaPlaylist.session,
                matchId = arenaPlaylist.matchId
            }
        else
            ____t_result_656 = nil
        end
        return {
            ready = ____ready_664,
            enabled = ____enabled_665,
            unlocked = ____unlocked_666,
            native = isNative,
            source = ____source_667,
            revision = ____config_revision_668,
            context = ____context_669,
            matchedContext = ____matchedContext_670,
            trackId = ____t_result_624,
            title = ____t_result_629,
            startSeconds = ____t_result_634,
            delaySeconds = ____t_result_639,
            cutsceneToken = ____opt_result_642_643,
            cutsceneElapsed = ____opt_result_646_647,
            waiting = ____temp_671,
            playing = ____isPlaying_result_672,
            transitioning = ____transition_673,
            error = ____t_result_654,
            configError = ____t_result_655,
            playlist = ____t_result_656,
            voices = __call(
                voices,
                "map",
                function(____, v)
                    local ____v_id_661 = v.id
                    local ____temp_662 = not __t(v.audio.paused) and not __t(v.audio.ended)
                    local ____TS__Number_result_663 = __TS__Number(__call(
                        currentVolume(nil, v),
                        "toFixed",
                        5
                    ))
                    local ____t_result_659
                    local ____t_658 = __t
                    local ____TS__Number_result_657 = __TS__Number(v.audio.currentTime)
                    __O[2455] = ____TS__Number_result_657
                    if ____t_658(____TS__Number_result_657) then
                        ____t_result_659 = __O[2455]
                    else
                        ____t_result_659 = 0
                    end
                    local ____isFiniteN_result_660
                    if __isFiniteN(v.audio.duration) then
                        ____isFiniteN_result_660 = v.audio.duration
                    else
                        ____isFiniteN_result_660 = 0
                    end
                    return {
                        trackId = ____v_id_661,
                        playing = ____temp_662,
                        volume = ____TS__Number_result_663,
                        currentTime = ____t_result_659,
                        duration = ____isFiniteN_result_660,
                        loop = v.loop,
                        loads = v.loads,
                        plays = v.plays,
                        seeks = v.seeks,
                        cueKey = v.cueKey
                    }
                end
            )
        }
    end
    local ____ = "use strict"
    local VERSION = 1
    local CONFIG_CACHE = "daroca-music-config-cache-v1"
    local PREF = "daroca-music-enabled"
    local DAY = 86400000
    SCENES = __arrL({
        "roca",
        "escola",
        "academia",
        "quadra",
        "camacan",
        "favela",
        "caderno",
        "campo",
        "bigodon",
        "patio",
        "rayssa",
        "baile"
    }, 12)
    local SILENCE = "data:audio/wav;base64,UklGRigAAABXQVZFZm10IBAAAAABAAEAQB8AAEAfAAABAAgAZGF0YQQAAACAgICA"
    local launch = __new("URLSearchParams", window.location.search)
    local ____t_result_2
    local ____t_1 = __t
    local ____temp_0 = window.location.hostname == "127.0.0.1" and __call(launch, "get", "native") == "1"
    __O[2366] = ____temp_0
    if ____t_1(____temp_0) then
        ____t_result_2 = __call(launch, "get", "pc") == "1"
    else
        ____t_result_2 = __O[2366]
    end
    local nativePC = ____t_result_2
    local ____t_result_9
    local ____t_8 = __t
    local ____t_result_7
    local ____t_6 = __t
    local ____t_result_5
    local ____t_4 = __t
    local ____temp_3 = window.location.hostname == "appassets.androidplatform.net"
    __O[2367] = ____temp_3
    if ____t_4(____temp_3) then
        ____t_result_5 = __O[2367]
    else
        ____t_result_5 = nativePC
    end
    __O[2368] = ____t_result_5
    if ____t_6(____t_result_5) then
        ____t_result_7 = __O[2368]
    else
        ____t_result_7 = window.location.protocol == "file:"
    end
    __O[2369] = ____t_result_7
    if ____t_8(____t_result_7) then
        ____t_result_9 = __O[2369]
    else
        ____t_result_9 = window.location.protocol == "daroca:"
    end
    isNative = ____t_result_9
    local isWeb = __call(
        __arrL({"https:", "http:"}, 2),
        "includes",
        window.location.protocol
    )
    local ____Set_15 = Set
    local ____call_14 = __call
    local ____t_result_13
    local ____t_12 = __t
    local ____opt_10 = window.DAROCA_MUSIC_CONFIG
    if ____opt_10 ~= nil then
        ____opt_10 = ____opt_10.tracks
    end
    __O[2370] = ____opt_10
    if ____t_12(____opt_10) then
        ____t_result_13 = __O[2370]
    else
        ____t_result_13 = __arrL({}, 0)
    end
    local packagedIds = __TS__New(
        ____Set_15,
        ____call_14(
            ____t_result_13,
            "map",
            function(____, t) return t.id end
        )
    )
    clamp = function(____, v, a, b) return math.max(
        a,
        math.min(b, v)
    ) end
    number = function(____, v, f)
        local ____isFiniteN_result_16
        if __isFiniteN(__TS__Number(v)) then
            ____isFiniteN_result_16 = __TS__Number(v)
        else
            ____isFiniteN_result_16 = f
        end
        return ____isFiniteN_result_16
    end
    now = function() return window.performance:now() end
    local function empty()
        return {
            schema = 1,
            revision = 0,
            masterVolume = 0.7,
            defaultFadeMs = 1200,
            categories = __arrL({}, 0),
            tracks = __arrL({}, 0),
            bindings = __objCreate(nil)
        }
    end
    config = empty(nil)
    source = "bundled"
    ready = false
    enabled = false
    unlocked = false
    audioContext = nil
    voices = __arrL({}, 0)
    active = -1
    requestGeneration = 0
    local loadGeneration = 0
    local loading = nil
    context = "menu.title"
    matchedContext = nil
    override = nil
    desired = nil
    lastAttempt = ""
    lastError = ""
    configError = ""
    local lastRemoteAt = 0
    local lastControl = ""
    local lastPressed = nil
    nativePaused = false
    transition = false
    local lastFocusReload = 0
    local lastContextSync = -math.huge
    lastAudioState = nil
    gamePaused = false
    overrideSerial = 0
    filmClock = nil
    ARENA_SHUFFLE = "arena.shuffle"
    arenaPlaylist = __ord(
        {
            open = false,
            session = 0,
            matchId = nil,
            currentId = nil,
            lastId = nil,
            bag = __arrL({}, 0),
            library = "",
            serial = 0,
            failed = __TS__New(Set)
        },
        "open,session,matchId,currentId,lastId,bag,library,serial,failed"
    )
    do
        local function ____catch()
            enabled = true
        end
        local ____try = pcall(function()
            enabled = window.localStorage:getItem(PREF) ~= "false"
        end)
        if not ____try then
            ____catch()
        end
    end
    local function normaliseConfig(self, raw)
        local ____t_24 = __t
        local ____t_result_23
        local ____t_22 = __t
        local ____t_result_21
        local ____t_20 = __t
        local ____t_result_19
        local ____t_18 = __t
        local ____temp_17 = not __t(raw) or raw.schema ~= VERSION
        __O[2371] = ____temp_17
        if ____t_18(____temp_17) then
            ____t_result_19 = __O[2371]
        else
            ____t_result_19 = not __isArray(raw.tracks)
        end
        __O[2372] = ____t_result_19
        if ____t_20(____t_result_19) then
            ____t_result_21 = __O[2372]
        else
            ____t_result_21 = not __t(raw.bindings)
        end
        __O[2373] = ____t_result_21
        if ____t_22(____t_result_21) then
            ____t_result_23 = __O[2373]
        else
            ____t_result_23 = type(raw.bindings) ~= "table"
        end
        if ____t_24(____t_result_23) then
            error(
                Error(nil, "Configuração de trilhas inválida."),
                0
            )
        end
        local c = empty(nil)
        c.revision = math.max(
            0,
            math.floor(number(nil, raw.revision, 0))
        )
        c.masterVolume = clamp(
            nil,
            number(nil, raw.masterVolume, 0.7),
            0,
            1
        )
        c.defaultFadeMs = clamp(
            nil,
            number(nil, raw.defaultFadeMs, 1200),
            0,
            10000
        )
        local ____call_31 = __call
        local ____call_30 = __call
        local ____call_29 = __call
        local ____isArray_result_25
        if __isArray(raw.categories) then
            ____isArray_result_25 = raw.categories
        else
            ____isArray_result_25 = __arrL({}, 0)
        end
        c.categories = ____call_31(
            ____call_30(
                ____call_29(
                    ____isArray_result_25,
                    "filter",
                    function(____, x)
                        local ____t_result_28
                        local ____t_27 = __t
                        local ____t_result_26
                        if __t(x) then
                            ____t_result_26 = type(x.id) == "string"
                        else
                            ____t_result_26 = x
                        end
                        __O[2374] = ____t_result_26
                        if ____t_27(____t_result_26) then
                            ____t_result_28 = type(x.name) == "string"
                        else
                            ____t_result_28 = __O[2374]
                        end
                        return ____t_result_28
                    end
                ),
                "slice",
                0,
                100
            ),
            "map",
            function(____, x) return {
                id = __call(x.id, "slice", 0, 80),
                name = __call(x.name, "slice", 0, 100)
            } end
        )
        local seen = __TS__New(Set)
        for ____, t in __iterar((__call(raw.tracks, "slice", 0, 200))) do
            do
                local ____t_37 = __t
                local ____t_result_36
                local ____t_35 = __t
                local ____t_result_34
                local ____t_33 = __t
                local ____temp_32 = not __t(t) or type(t.id) ~= "string"
                __O[2375] = ____temp_32
                if ____t_33(____temp_32) then
                    ____t_result_34 = __O[2375]
                else
                    ____t_result_34 = not __re_test(
                        __re("^[a-f0-9]{64}$", "i"),
                        t.id
                    )
                end
                __O[2376] = ____t_result_34
                if ____t_35(____t_result_34) then
                    ____t_result_36 = __O[2376]
                else
                    ____t_result_36 = __call(seen, "has", t.id)
                end
                if ____t_37(____t_result_36) then
                    continue
                end
                local id = __call(t.id, "toLowerCase")
                local file = __add(
                    __add("music/", id),
                    ".mp3"
                )
                local ____t_39 = __t
                local ____t_result_38
                if __t(t.file) then
                    ____t_result_38 = t.file ~= file
                else
                    ____t_result_38 = t.file
                end
                if ____t_39(____t_result_38) then
                    continue
                end
                __call(seen, "add", id)
                local ____call_59 = __call
                local ____c_tracks_58 = c.tracks
                local ____id_49 = id
                local ____call_41 = __call
                local ____t_result_40
                if __t(t.title) then
                    ____t_result_40 = t.title
                else
                    ____t_result_40 = "Trilha"
                end
                local ____call_41_result_50 = ____call_41(
                    tostring(____t_result_40),
                    "slice",
                    0,
                    140
                )
                local ____call_43 = __call
                local ____t_result_42
                if __t(t.categoryId) then
                    ____t_result_42 = t.categoryId
                else
                    ____t_result_42 = "maps"
                end
                local ____call_43_result_51 = ____call_43(
                    tostring(____t_result_42),
                    "slice",
                    0,
                    80
                )
                local ____file_52 = file
                local ____math_max_result_53 = math.max(
                    0,
                    number(nil, t.bytes, 0)
                )
                local ____math_max_result_54 = math.max(
                    0,
                    number(nil, t.duration, 0)
                )
                local ____clamp_result_55 = clamp(
                    nil,
                    number(nil, t.volume, 1),
                    0,
                    1
                )
                local ____temp_56 = t.loop ~= false
                local ____clamp_result_57 = clamp(
                    nil,
                    number(nil, t.fadeMs, c.defaultFadeMs),
                    0,
                    10000
                )
                local ____t_result_48
                local ____t_47 = __t
                local ____t_result_46
                local ____t_45 = __t
                local ____temp_44 = not __t(isNative) and not __t(__call(packagedIds, "has", id))
                __O[2377] = ____temp_44
                if ____t_45(____temp_44) then
                    ____t_result_46 = t.url == __add(
                        __add("/music/", id),
                        ".mp3"
                    )
                else
                    ____t_result_46 = __O[2377]
                end
                if ____t_47(____t_result_46) then
                    ____t_result_48 = t.url
                else
                    ____t_result_48 = nil
                end
                ____call_59(____c_tracks_58, "push", {
                    id = ____id_49,
                    title = ____call_41_result_50,
                    categoryId = ____call_43_result_51,
                    file = ____file_52,
                    sha256 = id,
                    bytes = ____math_max_result_53,
                    duration = ____math_max_result_54,
                    volume = ____clamp_result_55,
                    loop = ____temp_56,
                    fadeMs = ____clamp_result_57,
                    url = ____t_result_48
                })
            end
        end
        for ____, ____value in __iterar((__entries(raw.bindings))) do
            local id = ____value[1]
            local b = ____value[2]
            do
                local ____t_65 = __t
                local ____t_result_64
                local ____t_63 = __t
                local ____t_result_62
                local ____t_61 = __t
                local ____temp_60 = not __re_test(
                    __re("^[a-zA-Z0-9_.-]{1,90}$", ""),
                    id
                ) or not __t(b)
                __O[2378] = ____temp_60
                if ____t_61(____temp_60) then
                    ____t_result_62 = __O[2378]
                else
                    ____t_result_62 = type(b) ~= "table"
                end
                __O[2379] = ____t_result_62
                if ____t_63(____t_result_62) then
                    ____t_result_64 = __O[2379]
                else
                    ____t_result_64 = not __t(__call(
                        c.tracks,
                        "some",
                        function(____, t) return t.id == b.trackId end
                    ))
                end
                if ____t_65(____t_result_64) then
                    continue
                end
                __set(c.bindings, id, {trackId = b.trackId, enabled = b.enabled ~= false})
                if b.volume ~= nil then
                    __get(c.bindings, id).volume = clamp(
                        nil,
                        number(nil, b.volume, 1),
                        0,
                        1
                    )
                end
                if b.loop ~= nil then
                    __get(c.bindings, id).loop = b.loop ~= false
                end
                if b.fadeMs ~= nil then
                    __get(c.bindings, id).fadeMs = clamp(
                        nil,
                        number(nil, b.fadeMs, c.defaultFadeMs),
                        0,
                        10000
                    )
                end
                if b.startSeconds ~= nil then
                    __get(c.bindings, id).startSeconds = clamp(
                        nil,
                        math.floor(number(nil, b.startSeconds, 0) * 100 + 0.5) / 100,
                        0,
                        86400
                    )
                end
                if b.delaySeconds ~= nil then
                    __get(c.bindings, id).delaySeconds = clamp(
                        nil,
                        math.floor(number(nil, b.delaySeconds, 0) * 100 + 0.5) / 100,
                        0,
                        3600
                    )
                end
            end
        end
        return c
    end
    local function mergeLocal(self, c, ____local)
        local ____t_69 = __t
        local ____t_result_68
        local ____t_67 = __t
        local ____temp_66 = not __t(____local) or not __t(c)
        __O[2380] = ____temp_66
        if ____t_67(____temp_66) then
            ____t_result_68 = __O[2380]
        else
            ____t_result_68 = not __t(__len(____local.tracks)) and not __t(__len(__keys(____local.bindings)))
        end
        if ____t_69(____t_result_68) then
            return c
        end
        local out = __assign(
            {},
            c,
            {
                tracks = __call(
                    c.tracks,
                    "concat",
                    __call(
                        ____local.tracks,
                        "filter",
                        function(____, t) return not __t(__call(
                            c.tracks,
                            "some",
                            function(____, x) return x.id == t.id end
                        )) end
                    )
                ),
                bindings = __assign(
                    __objCreate(nil),
                    c.bindings,
                    ____local.bindings
                )
            }
        )
        return out
    end
    local function readCache(self)
        if __t(isNative) then
            return nil
        end
        do
            local function ____catch()
                return true, nil
            end
            local ____try, ____hasReturned, ____returnValue = pcall(function()
                local ____self_73 = window.JSON
                local ____self_73_parse_74 = ____self_73.parse
                local ____t_result_72
                local ____t_71 = __t
                local ____temp_70 = window.localStorage:getItem(CONFIG_CACHE)
                __O[2381] = ____temp_70
                if ____t_71(____temp_70) then
                    ____t_result_72 = __O[2381]
                else
                    ____t_result_72 = "null"
                end
                local cached = ____self_73_parse_74(____self_73, ____t_result_72)
                local ____t_result_77
                local ____t_76 = __t
                local ____t_result_75
                if __t(cached) then
                    ____t_result_75 = window.Date:now() - cached.at < DAY
                else
                    ____t_result_75 = cached
                end
                if ____t_76(____t_result_75) then
                    ____t_result_77 = normaliseConfig(nil, cached.config)
                else
                    ____t_result_77 = nil
                end
                return true, ____t_result_77
            end)
            if not ____try then
                ____hasReturned, ____returnValue = ____catch()
            end
            if ____hasReturned then
                return ____returnValue
            end
        end
    end
    local function saveCache(self, c)
        do
            pcall(function()
                window.localStorage:setItem(
                    CONFIG_CACHE,
                    window.JSON:stringify({
                        at = window.Date:now(),
                        config = c
                    })
                )
            end)
        end
    end
    local function fetchConfig(self, url)
        return __TS__AsyncAwaiter(function(____awaiter_resolve)
            local ____temp_78
            if type(window.AbortController) == "function" then
                ____temp_78 = __new("AbortController")
            else
                ____temp_78 = nil
            end
            local controller = ____temp_78
            local timer = window:setTimeout(
                function()
                    local ____opt_result_81
                    if controller ~= nil then
                        ____opt_result_81 = controller:abort()
                    end
                    return ____opt_result_81
                end,
                6000
            )
            local ____hasReturned, ____returnValue
            local ____try = __TS__AsyncAwaiter(function()
                local ____window_86 = window
                local ____window_fetch_87 = window.fetch
                local ____url_85 = url
                local ____opt_result_84
                if controller ~= nil then
                    ____opt_result_84 = controller.signal
                end
                local r = __TS__Await(____window_fetch_87(____window_86, ____url_85, {cache = "no-store", credentials = "same-origin", signal = ____opt_result_84}))
                if not __t(r.ok) then
                    error(
                        Error(
                            nil,
                            __add("HTTP ", r.status)
                        ),
                        0
                    )
                end
                ____hasReturned = true
                ____returnValue = normaliseConfig(
                    nil,
                    __TS__Await(r:json())
                )
                return
            end)
            ____try = ____try.finally(
                ____try,
                function()
                    return __TS__AsyncAwaiter(function()
                        window:clearTimeout(timer)
                    end)
                end
            )
            __TS__Await(____try)
            if ____hasReturned then
                return ____awaiter_resolve(nil, ____returnValue)
            end
        end)
    end
    local function applyConfig(self, c, nextSource)
        config = c
        source = nextSource
        ready = true
        configError = ""
        lastAttempt = ""
        __call(arenaPlaylist.failed, "clear")
        refreshArenaLibrary(nil)
        syncSelection(nil)
        do
            pcall(function()
                window:dispatchEvent(__new(
                    "CustomEvent",
                    "music-config-ready",
                    {detail = {
                        revision = c.revision,
                        source = nextSource,
                        tracks = __len(c.tracks)
                    }}
                ))
            end)
        end
    end
    local function reload(self)
        return __TS__AsyncAwaiter(function(____awaiter_resolve)
            if __t(loading) then
                return ____awaiter_resolve(nil, loading)
            end
            loadGeneration = loadGeneration + 1
            local generation = loadGeneration
            loading = (function()
                return __TS__AsyncAwaiter(function(____awaiter_resolve)
                    local bundled = nil
                    local ____try = __TS__AsyncAwaiter(function()
                        if __t(window.DAROCA_MUSIC_CONFIG) then
                            bundled = normaliseConfig(nil, window.DAROCA_MUSIC_CONFIG)
                        else
                            bundled = __TS__Await(fetchConfig(nil, "music/config.json"))
                        end
                    end)
                    ____try = ____try.catch(
                        ____try,
                        function(____, e)
                            return __TS__AsyncAwaiter(function()
                                configError = "Não foi possível ler a configuração incluída no jogo."
                            end)
                        end
                    )
                    __TS__Await(____try)
                    local cached = readCache(nil)
                    local ____t_result_88
                    if __t(cached) then
                        ____t_result_88 = not __t(bundled) or cached.revision >= bundled.revision
                    else
                        ____t_result_88 = cached
                    end
                    local useCache = ____t_result_88
                    local ____t_result_89
                    if __t(useCache) then
                        ____t_result_89 = cached
                    else
                        ____t_result_89 = bundled
                    end
                    local base = ____t_result_89
                    local baseSource = __t(useCache) and "cache" or "bundled"
                    local ____t_93 = __t
                    local ____t_result_92
                    local ____t_91 = __t
                    local ____temp_90 = not __t(ready)
                    __O[2382] = ____temp_90
                    if ____t_91(____temp_90) then
                        ____t_result_92 = base
                    else
                        ____t_result_92 = __O[2382]
                    end
                    if ____t_93(____t_result_92) then
                        applyConfig(nil, base, baseSource)
                    end
                    local ____local = nil
                    local ____try = __TS__AsyncAwaiter(function()
                        local ____opt_96 = window.DarocaMusicas
                        if ____opt_96 ~= nil then
                            ____opt_96 = ____opt_96.load
                        end
                        local ____opt_result_98
                        if ____opt_96 ~= nil then
                            ____opt_result_98 = ____opt_96(____opt_96)
                        end
                        ____local = __TS__Await(____opt_result_98)
                    end)
                    ____try = ____try.catch(
                        ____try,
                        function(____)
                            return __TS__AsyncAwaiter(function()
                            end)
                        end
                    )
                    __TS__Await(____try)
                    if generation ~= loadGeneration then
                        return ____awaiter_resolve(
                            nil,
                            getStatus(nil)
                        )
                    end
                    local ____t_108 = __t
                    local ____t_result_107
                    local ____t_100 = __t
                    local ____t_result_99
                    if __t(base) then
                        ____t_result_99 = base
                    else
                        ____t_result_99 = ____local
                    end
                    __O[2384] = ____t_result_99
                    if ____t_100(____t_result_99) then
                        local ____temp_106 = not __t(ready)
                        if not ____temp_106 then
                            local ____t_result_105
                            local ____t_104 = __t
                            local ____opt_result_103
                            if base ~= nil then
                                ____opt_result_103 = base.revision
                            end
                            __O[2383] = ____opt_result_103
                            if ____t_104(____opt_result_103) then
                                ____t_result_105 = __O[2383]
                            else
                                ____t_result_105 = 0
                            end
                            ____temp_106 = ____t_result_105 >= config.revision
                        end
                        ____t_result_107 = ____temp_106
                    else
                        ____t_result_107 = __O[2384]
                    end
                    if ____t_108(____t_result_107) then
                        local ____mergeLocal_110 = mergeLocal
                        local ____t_result_109
                        if __t(base) then
                            ____t_result_109 = base
                        else
                            ____t_result_109 = empty(nil)
                        end
                        local merged = ____mergeLocal_110(nil, ____t_result_109, ____local)
                        if merged ~= config then
                            applyConfig(nil, merged, baseSource)
                        end
                    end
                    local ____t_116 = __t
                    local ____t_result_115
                    local ____t_114 = __t
                    local ____t_result_113
                    local ____t_112 = __t
                    local ____temp_111 = not __t(isNative)
                    __O[2385] = ____temp_111
                    if ____t_112(____temp_111) then
                        ____t_result_113 = isWeb
                    else
                        ____t_result_113 = __O[2385]
                    end
                    __O[2386] = ____t_result_113
                    if ____t_114(____t_result_113) then
                        ____t_result_115 = not __t(window.DAROCA_LAN)
                    else
                        ____t_result_115 = __O[2386]
                    end
                    if ____t_116(____t_result_115) then
                        local ____try = __TS__AsyncAwaiter(function()
                            local remote = __TS__Await(fetchConfig(nil, "/api/music/config"))
                            if __t(generation == loadGeneration and remote.revision >= config.revision) then
                                lastRemoteAt = window.Date:now()
                                applyConfig(
                                    nil,
                                    mergeLocal(nil, remote, ____local),
                                    "remote"
                                )
                                saveCache(nil, remote)
                            end
                        end)
                        ____try = ____try.catch(
                            ____try,
                            function(____, e)
                                return __TS__AsyncAwaiter(function()
                                    if not __t(ready) then
                                        ready = true
                                        source = "bundled"
                                    end
                                    configError = "A configuração online não respondeu; usando as trilhas disponíveis neste aparelho."
                                end)
                            end
                        )
                        __TS__Await(____try)
                    elseif not __t(ready) then
                        ready = true
                    end
                    return ____awaiter_resolve(
                        nil,
                        getStatus(nil)
                    )
                end)
            end)(nil):finally(function()
                loading = nil
            end)
            return ____awaiter_resolve(nil, loading)
        end)
    end
    local function unlock(self)
        makeVoices(nil)
        unlocked = true
        lastAttempt = ""
        do
            pcall(function()
                local ____opt_result_166
                if audioContext ~= nil then
                    ____opt_result_166 = audioContext:resume()
                end
                local resume = ____opt_result_166
                if resume ~= nil then
                    resume:catch(function()
                        lastError = "Toque no botão de som para liberar o áudio."
                    end)
                end
            end)
        end
        for ____, v in __iterar((voices)) do
            if __t(not __t(v.src) and not __t(v.warming)) then
                v.warming = true
                local generation = requestGeneration
                do
                    local function ____catch()
                        v.warming = false
                    end
                    local ____try = pcall(function()
                        v.audio.src = SILENCE
                        v.audio.loop = false
                        local p = v.audio:play()
                        local ____self_173 = __TS__Promise.resolve(p)
                        ____self_173["then"](
                            ____self_173,
                            function()
                                local ____t_172 = __t
                                local ____t_result_171
                                local ____t_170 = __t
                                local ____t_result_169
                                if __t(v.warming) then
                                    ____t_result_169 = not __t(v.id)
                                else
                                    ____t_result_169 = v.warming
                                end
                                __O[2397] = ____t_result_169
                                if ____t_170(____t_result_169) then
                                    ____t_result_171 = generation == requestGeneration
                                else
                                    ____t_result_171 = __O[2397]
                                end
                                if ____t_172(____t_result_171) then
                                    v.audio:pause()
                                end
                            end
                        ):catch(function()
                        end):finally(function()
                            v.warming = false
                        end)
                    end)
                    if not ____try then
                        ____catch()
                    end
                end
            end
        end
        syncSelection(nil, true)
        local ____opt_result_176
        if audioContext ~= nil then
            ____opt_result_176 = audioContext.state
        end
        return __TS__Promise.resolve(____opt_result_176 == "running" or not __t(audioContext))
    end
    local function setEnabled(self, value, persist)
        if persist == nil then
            persist = true
        end
        enabled = not not __t(value)
        if __t(persist) then
            do
                pcall(function()
                    window.localStorage:setItem(
                        PREF,
                        tostring(enabled)
                    )
                end)
            end
        end
        if not __t(enabled) then
            requestGeneration = requestGeneration + 1
            lastAttempt = ""
            for ____, v in __iterar((voices)) do
                local ____opt_177 = v.cancelMetadata
                if ____opt_177 ~= nil then
                    ____opt_177(v)
                end
                gain(nil, v, 0, 0)
                v.audio:pause()
            end
            transition = false
        else
            lastAttempt = ""
            if __t(unlocked) then
                syncSelection(nil, true)
            end
        end
        return enabled
    end
    speakers = __arrL(
        {
            __arrL({"amanda", "amanda"}, 2),
            __arrL({"irmao de clara swift", "swift"}, 2),
            __arrL({"igor", "igor"}, 2),
            __arrL({"kaique", "kaique"}, 2),
            __arrL({"ana laura", "analaura"}, 2),
            __arrL({"nicolas carvalho", "nicolas"}, 2),
            __arrL({"nicolas", "nicolas"}, 2),
            __arrL({"nikolas", "nikolas"}, 2),
            __arrL({"da roca", "daroca"}, 2),
            __arrL({"gabriel mota", "mota"}, 2),
            __arrL({"gabriel reis", "reeis"}, 2),
            __arrL({"reeis", "reeis"}, 2),
            __arrL({"reis", "reeis"}, 2),
            __arrL({"menezes", "menezes"}, 2),
            __arrL({"lucas", "lucas"}, 2),
            __arrL({"caleb", "caleb"}, 2),
            __arrL({"kaua", "kaua"}, 2),
            __arrL({"marco", "marco"}, 2),
            __arrL({"ravid", "ravid"}, 2),
            __arrL({"mota", "mota"}, 2),
            __arrL({"colosso", "giant"}, 2),
            __arrL({"almiro", "almiro"}, 2),
            __arrL({"miqueias", "miqueias"}, 2),
            __arrL({"davi", "davi"}, 2),
            __arrL({"vitor", "vitor"}, 2),
            __arrL({"freddy", "freddy"}, 2),
            __arrL({"dede", "dede"}, 2),
            __arrL({"aica", "aica"}, 2),
            __arrL({"ravile", "ravile"}, 2),
            __arrL({"arthur", "arthur"}, 2),
            __arrL({"allef", "allef"}, 2),
            __arrL({"eloisa", "eloisa"}, 2),
            __arrL({"giselle", "giselle"}, 2),
            __arrL({"rayssa", "rayssa"}, 2)
        },
        34
    )
    local function isCutsceneTimed(self, kind)
        local b = __get(
            config.bindings,
            __add("cutscenes.", kind)
        )
        local ____t_372 = __t
        local ____t_result_371
        local ____t_370 = __t
        local ____t_result_369
        if __t(b) then
            ____t_result_369 = b.enabled ~= false
        else
            ____t_result_369 = b
        end
        __O[2411] = ____t_result_369
        if ____t_370(____t_result_369) then
            ____t_result_371 = __call(
                config.tracks,
                "some",
                function(____, t) return t.id == b.trackId end
            )
        else
            ____t_result_371 = __O[2411]
        end
        return not not ____t_372(____t_result_371)
    end
    local function control(self)
        local party = false
        do
            pcall(function()
                local ____t_578 = __t
                local ____opt_575 = window.PartyGame
                if ____opt_575 ~= nil then
                    ____opt_575 = ____opt_575.getStatus
                end
                local ____opt_result_577
                if ____opt_575 ~= nil then
                    ____opt_result_577 = ____opt_575(____opt_575).open
                end
                party = not not ____t_578(____opt_result_577)
            end)
        end
        local button = window.document:getElementById(__t(party) and "partySoundBtn" or "soundBtn")
        if not __t(button) then
            return
        end
        local pressed = button:getAttribute("aria-pressed") == "true"
        local key = button.id
        if __t(lastControl ~= key or lastPressed ~= pressed) then
            local first = not __t(lastControl)
            lastControl = key
            lastPressed = pressed
            if __t(not __t(first) or not __t(enabled)) then
                setEnabled(nil, pressed, false)
            end
        end
    end
    local function tick(self)
        local time = now(nil)
        local fading = false
        for ____, v in __iterar((voices)) do
            local level = currentVolume(nil, v, time)
            if not __t(v.gain) then
                do
                    pcall(function()
                        v.audio.volume = clamp(nil, level, 0, 1)
                    end)
                end
            end
            local ____t_580 = __t
            local ____t_result_579
            if __t(v.ramp) then
                ____t_result_579 = __ge(time, v.ramp["end"])
            else
                ____t_result_579 = v.ramp
            end
            if ____t_580(____t_result_579) then
                v.volume = v.ramp.to
                v.ramp = nil
                local ____t_586 = __t
                local ____t_result_585
                local ____t_584 = __t
                local ____t_result_583
                local ____t_582 = __t
                local ____temp_581 = v.volume == 0 and active ~= v.index
                __O[2442] = ____temp_581
                if ____t_582(____temp_581) then
                    ____t_result_583 = not __t(v.pending)
                else
                    ____t_result_583 = __O[2442]
                end
                __O[2443] = ____t_result_583
                if ____t_584(____t_result_583) then
                    ____t_result_585 = not __t(v.audio.paused)
                else
                    ____t_result_585 = __O[2443]
                end
                if ____t_586(____t_result_585) then
                    v.audio:pause()
                end
            end
            if __t(v.ramp) then
                fading = true
            end
        end
        transition = fading
        local ____temp_591 = time - lastContextSync
        local ____t_590 = __t
        local ____opt_result_589
        if lastAudioState ~= nil then
            ____opt_result_589 = lastAudioState.cutscene
        end
        if ____temp_591 >= (____t_590(____opt_result_589) and 40 or 150) then
            lastContextSync = time
            control(nil)
            syncSelection(nil)
        end
    end
    local function resumeForLifecycle(self)
        if __t(filmClock) then
            filmClock.lastAt = now(nil)
            filmClock.running = not __t(suspended(nil))
        end
        local ____t_604 = __t
        local ____t_result_603
        local ____t_602 = __t
        local ____t_result_601
        local ____t_600 = __t
        local ____suspended_result_599 = suspended(nil)
        __O[2444] = ____suspended_result_599
        if ____t_600(____suspended_result_599) then
            ____t_result_601 = __O[2444]
        else
            ____t_result_601 = not __t(enabled)
        end
        __O[2445] = ____t_result_601
        if ____t_602(____t_result_601) then
            ____t_result_603 = __O[2445]
        else
            ____t_result_603 = not __t(unlocked)
        end
        if ____t_604(____t_result_603) then
            return
        end
        lastAttempt = ""
        do
            pcall(function()
                local ____opt_result_609
                if audioContext ~= nil then
                    ____opt_result_609 = audioContext:resume()
                end
                if ____opt_result_609 ~= nil then
                    ____opt_result_609["then"](
                        ____opt_result_609,
                        function() return syncSelection(nil, true) end
                    ):catch(function()
                        lastError = "Toque no botão de som para retomar a música."
                    end)
                end
                if not __t(audioContext) then
                    syncSelection(nil, true)
                end
            end)
        end
    end
    local function setContext(self, id)
        local ____t_result_678
        local ____t_677 = __t
        local ____t_result_676
        local ____t_675 = __t
        local ____temp_674 = type(id) == "string"
        __O[2456] = ____temp_674
        if ____t_675(____temp_674) then
            ____t_result_676 = id
        else
            ____t_result_676 = __O[2456]
        end
        if ____t_677(____t_result_676) then
            ____t_result_678 = id
        else
            ____t_result_678 = nil
        end
        override = ____t_result_678
        overrideSerial = overrideSerial + 1
        lastAttempt = ""
        syncSelection(nil, true)
        return getStatus(nil)
    end
    window.document:addEventListener(
        "click",
        function(____, event)
            local ____opt_681 = event.target
            local ____opt_679 = ____opt_681 and ____opt_681.closest
            if ____opt_679 ~= nil then
                ____opt_679 = ____opt_679(____opt_681, "#soundBtn,#partySoundBtn,#epilogueSoundBtn")
            end
            local button = ____opt_679
            if not __t(button) then
                return
            end
            local pressed = button:getAttribute("aria-pressed") == "true"
            setEnabled(
                nil,
                not __t(pressed)
            )
            if not __t(pressed) then
                unlock(nil)
            end
        end,
        true
    )
    window.document:addEventListener(
        "visibilitychange",
        function()
            if __t(window.document.hidden) then
                pauseForLifecycle(nil)
            else
                resumeForLifecycle(nil)
                if window.Date:now() - lastFocusReload > 10000 then
                    lastFocusReload = window.Date:now()
                    reload(nil)
                end
            end
        end
    )
    window:addEventListener(
        "daroca-native-pause",
        function()
            nativePaused = true
            pauseForLifecycle(nil)
        end
    )
    window:addEventListener(
        "daroca-native-resume",
        function()
            nativePaused = false
            resumeForLifecycle(nil)
        end
    )
    window:addEventListener(
        "online",
        function()
            lastAttempt = ""
            reload(nil)
        end
    )
    window:addEventListener(
        "music-config-changed",
        function() return reload(nil) end
    )
    window:addEventListener(
        "storage",
        function(____, e)
            if e.key == "daroca-music-revision" then
                reload(nil)
            end
        end
    )
    do
        pcall(function()
            if type(window.BroadcastChannel) == "function" then
                local channel = __new("BroadcastChannel", "daroca-music")
                channel:addEventListener(
                    "message",
                    function(____, e)
                        local ____opt_683 = e.data
                        if ____opt_683 ~= nil then
                            ____opt_683 = ____opt_683.type
                        end
                        if ____opt_683 == "config-updated" then
                            reload(nil)
                        end
                    end
                )
            end
        end)
    end
    local title = window.document:getElementById("startScreen")
    local sourceButton = window.document:getElementById("soundBtn")
    local ____t_690 = __t
    local ____t_result_689
    local ____t_688 = __t
    local ____t_result_687
    local ____t_686 = __t
    local ____t_result_685
    if __t(title) then
        ____t_result_685 = sourceButton
    else
        ____t_result_685 = title
    end
    __O[2457] = ____t_result_685
    if ____t_686(____t_result_685) then
        ____t_result_687 = type(title.append) == "function"
    else
        ____t_result_687 = __O[2457]
    end
    __O[2458] = ____t_result_687
    if ____t_688(____t_result_687) then
        ____t_result_689 = not __t(window.document:getElementById("menuMusicBtn"))
    else
        ____t_result_689 = __O[2458]
    end
    if ____t_690(____t_result_689) then
        local button = window.document:createElement("button")
        button.id = "menuMusicBtn"
        button.type = "button"
        button.className = "menu-music-control"
        button.innerHTML = "<svg viewBox=\"0 0 24 24\" aria-hidden=\"true\"><path d=\"M9 18V5l11-2v13M9 9l11-2\"/><circle cx=\"6\" cy=\"18\" r=\"3\"/><circle cx=\"17\" cy=\"16\" r=\"3\"/></svg><small>SOM</small>"
        local function reflect()
            local on = sourceButton:getAttribute("aria-pressed") == "true"
            button:setAttribute(
                "aria-pressed",
                tostring(on)
            )
            button:setAttribute(
                "aria-label",
                __t(on) and "Desativar músicas e efeitos" or "Ativar músicas e efeitos"
            )
        end
        button:addEventListener(
            "click",
            function() return sourceButton:click() end
        )
        title:append(button)
        if type(window.MutationObserver) == "function" then
            __new("MutationObserver", reflect):observe(
                sourceButton,
                __ord(
                    {
                        attributes = true,
                        attributeFilter = __arrL({"aria-pressed"}, 1)
                    },
                    "attributes,attributeFilter"
                )
            )
        end
        reflect(nil)
    end
    do
        pcall(function()
            local ____opt_693 = window.DarocaAudio
            if ____opt_693 ~= nil then
                ____opt_693 = ____opt_693.onChange
            end
            if ____opt_693 ~= nil then
                ____opt_693(
                    ____opt_693,
                    function()
                        lastAttempt = ""
                        syncSelection(nil, true)
                    end
                )
            end
        end)
    end
    window.GameMusic = __ord(
        {
            hasSelection = function()
                local ____t_result_695
                if __t(enabled) then
                    ____t_result_695 = not not __t(desired)
                else
                    ____t_result_695 = enabled
                end
                return ____t_result_695
            end,
            version = "3.7.0",
            isCutsceneTimed = isCutsceneTimed,
            unlock = unlock,
            setEnabled = setEnabled,
            isPlaying = isPlaying,
            getStatus = getStatus,
            reload = reload,
            setContext = setContext
        },
        "hasSelection,version,isCutsceneTimed,unlock,setEnabled,isPlaying,getStatus,reload,setContext"
    )
    local function firstGesture(____, event)
        local ____t_699 = __t
        local ____t_result_698
        local ____t_697 = __t
        local ____t_result_696
        if __t(event.isTrusted) then
            ____t_result_696 = enabled
        else
            ____t_result_696 = event.isTrusted
        end
        __O[2459] = ____t_result_696
        if ____t_697(____t_result_696) then
            ____t_result_698 = not __t(unlocked) or not __t(isPlaying(nil))
        else
            ____t_result_698 = __O[2459]
        end
        if ____t_699(____t_result_698) then
            unlock(nil)
        end
    end
    window.document:addEventListener(
        "pointerdown",
        firstGesture,
        __ord({capture = true, passive = true}, "capture,passive")
    )
    window.document:addEventListener("keydown", firstGesture, {capture = true})
    window:setInterval(tick, 50)
    reload(nil)
    local ____opt_702 = window.Game
    if ____opt_702 ~= nil then
        ____opt_702 = ____opt_702.setSoundEnabled
    end
    if ____opt_702 ~= nil then
        ____opt_702(____opt_702, enabled)
    end
    local ____t_705 = __t
    local ____t_result_704
    if __t(enabled) then
        ____t_result_704 = isNative
    else
        ____t_result_704 = enabled
    end
    if ____t_705(____t_result_704) then
        unlock(nil)
    end
end)(nil)
return ____exports
