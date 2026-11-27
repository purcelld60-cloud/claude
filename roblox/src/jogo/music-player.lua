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
            return if __t(v.volume) then v.volume else 0
        end
        local r = v.ramp
        local p = if __le(r["end"], r.start) then 1 else clamp(nil, (time - r.start) / (r["end"] - r.start), 0, 1)
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
        if __t(if __t(v.gain) then audioContext else v.gain) then
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
                    v.audio.volume = if duration > 0 then from else target
                end)
            end
        end
    end
    function makeVoices(self)
        if __t(__len(voices)) then
            return
        end
        local Context = if __t(window.AudioContext) then window.AudioContext else window.webkitAudioContext
        do
            local function ____catch()
                audioContext = nil
            end
            local ____try = pcall(function()
                if __t(if __t(Context) then not __t(window.nativeAndroid) else Context) then
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
                local ____opt_83 = audio.setAttribute
                if ____opt_83 ~= nil then
                    ____opt_83(audio, "playsinline", "")
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
                        local ____t_93 = __t
                        local ____t_92 = __t
                        local ____t_90 = __t
                        local ____t_88 = __t
                        local ____opt_result_87
                        if desired ~= nil then
                            ____opt_result_87 = desired.arenaShuffle
                        end
                        __O[2342] = ____opt_result_87
                        local ____temp_89 = if ____t_88(____opt_result_87) then arenaPlaylist.open else __O[2342]
                        __O[2343] = ____temp_89
                        local ____temp_91 = if ____t_90(____temp_89) then active == v.index else __O[2343]
                        __O[2344] = ____temp_91
                        if ____t_93(if ____t_92(____temp_91) then v.cueKey == desired.cueKey else __O[2344]) then
                            nextArenaTrack(nil)
                            lastAttempt = ""
                            syncSelection(nil, true)
                        else
                            local ____t_100 = __t
                            local ____t_99 = __t
                            local ____t_97 = __t
                            local ____t_95 = __t
                            local ____temp_94 = if __t(v.loop) then enabled else v.loop
                            __O[2345] = ____temp_94
                            local ____temp_96 = if ____t_95(____temp_94) then unlocked else __O[2345]
                            __O[2346] = ____temp_96
                            local ____temp_98 = if ____t_97(____temp_96) then not __t(suspended(nil)) else __O[2346]
                            __O[2347] = ____temp_98
                            if ____t_100(if ____t_99(____temp_98) then active == v.index else __O[2347]) then
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
                        if __t(if __t(v.id) then not __t(v.warming) else v.id) then
                            local ____add_105 = __add
                            local ____add_104 = __add
                            local ____t_103 = __t
                            local ____opt_101 = __call(
                                config.tracks,
                                "find",
                                function(____, t) return t.id == v.id end
                            )
                            if ____opt_101 ~= nil then
                                ____opt_101 = ____opt_101.title
                            end
                            __O[2348] = ____opt_101
                            lastError = ____add_105(
                                ____add_104("Não foi possível reproduzir “", if ____t_103(____opt_101) then __O[2348] else "esta trilha"),
                                "”."
                            )
                            if active == v.index then
                                active = -1
                            end
                            local ____t_112 = __t
                            local ____t_111 = __t
                            local ____t_109 = __t
                            local ____opt_result_108
                            if desired ~= nil then
                                ____opt_result_108 = desired.arenaShuffle
                            end
                            __O[2349] = ____opt_result_108
                            local ____temp_110 = if ____t_109(____opt_result_108) then arenaPlaylist.open else __O[2349]
                            __O[2350] = ____temp_110
                            if ____t_112(if ____t_111(____temp_110) then arenaPlaylist.currentId == v.id else __O[2350]) then
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
        local ____t_114 = __t
        local ____temp_113 = if __t(nativePaused) then nativePaused else gamePaused
        __O[2351] = ____temp_113
        return if ____t_114(____temp_113) then __O[2351] else not not __t(window.document.hidden)
    end
    function normalName(self, value)
        return __call(
            __re_replace(
                __call(
                    __re_replace(
                        __call(
                            tostring(if __t(value) then value else ""),
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
                        __O[2353] = __iter(__arrL(
                            {
                                __get(bag, j),
                                __get(bag, i)
                            },
                            2
                        ))
                        __set(
                            bag,
                            i,
                            __get(__O[2353], 0)
                        )
                    end
                    __set(
                        bag,
                        j,
                        __get(__O[2353], 1)
                    )
                end
                local ____ = __O[2353]
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
        if __t(if __t(arenaPlaylist.currentId) then not __t(__call(ids, "includes", arenaPlaylist.currentId)) else arenaPlaylist.currentId) then
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
        local previous = if __t(arenaPlaylist.currentId) then arenaPlaylist.currentId else arenaPlaylist.lastId
        if __t(__get(arenaPlaylist.bag, 0) == previous and __len(ids) > 1) then
            local alternative = __call(
                arenaPlaylist.bag,
                "findIndex",
                function(____, id) return id ~= previous end
            )
            if alternative >= 0 then
                do
                    do
                        __O[2354] = __iter(__arrL(
                            {
                                __get(arenaPlaylist.bag, alternative),
                                __get(arenaPlaylist.bag, 0)
                            },
                            2
                        ))
                        __set(
                            arenaPlaylist.bag,
                            0,
                            __get(__O[2354], 0)
                        )
                    end
                    __set(
                        arenaPlaylist.bag,
                        alternative,
                        __get(__O[2354], 1)
                    )
                end
                local ____ = __O[2354]
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
                local ____t_134 = __t
                local ____opt_131 = window.Arena
                if ____opt_131 ~= nil then
                    ____opt_131 = ____opt_131.getStatus
                end
                local ____opt_result_133
                if ____opt_131 ~= nil then
                    ____opt_result_133 = ____opt_131(____opt_131)
                end
                __O[2355] = ____opt_result_133
                return true, if ____t_134(____opt_result_133) then __O[2355] else nil
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
        local ____t_138 = __t
        local ____opt_result_137
        if arena ~= nil then
            ____opt_result_137 = arena.open
        end
        if not ____t_138(____opt_result_137) then
            arenaPlaylist.open = false
            arenaPlaylist.currentId = nil
            arenaPlaylist.matchId = nil
            return false
        end
        refreshArenaLibrary(nil)
        local ____t_141 = __t
        local ____t_140 = __t
        local ____temp_139 = type(arena.matchId) == "string"
        __O[2356] = ____temp_139
        local matchId = if ____t_141(if ____t_140(____temp_139) then arena.matchId else __O[2356]) then arena.matchId else nil
        if not __t(arenaPlaylist.open) then
            arenaPlaylist.open = true
            arenaPlaylist.session = arenaPlaylist.session + 1
            __call(arenaPlaylist.failed, "clear")
            arenaPlaylist.matchId = matchId
            nextArenaTrack(nil)
        elseif __t(if __t(matchId) then matchId ~= arenaPlaylist.matchId else matchId) then
            local rematch = arenaPlaylist.matchId ~= nil
            arenaPlaylist.matchId = matchId
            if __t(rematch) then
                nextArenaTrack(nil)
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
        local ____track_149 = track
        local ____temp_150 = if __t(isNative) then track.file else if __t(track.url) then track.url else track.file
        local ____temp_148 = config.masterVolume * track.volume
        local ____opt_144 = window.DarocaAudio
        if ____opt_144 ~= nil then
            ____opt_144 = ____opt_144.music
        end
        local ____opt_result_146
        if ____opt_144 ~= nil then
            ____opt_result_146 = ____opt_144(____opt_144)
        end
        local ____opt_result_146_147 = ____opt_result_146
        if ____opt_result_146_147 == nil then
            ____opt_result_146_147 = 1
        end
        return {
            track = ____track_149,
            key = ARENA_SHUFFLE,
            src = ____temp_150,
            loop = false,
            volume = clamp(nil, ____temp_148 * ____opt_result_146_147, 0, 1),
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
                    local ____t_156 = __t
                    local ____opt_153 = window.Game
                    if ____opt_153 ~= nil then
                        ____opt_153 = ____opt_153.getAudioState
                    end
                    local ____opt_result_155
                    if ____opt_153 ~= nil then
                        ____opt_result_155 = ____opt_153(____opt_153)
                    end
                    __O[2357] = ____opt_result_155
                    lastAudioState = if ____t_156(____opt_result_155) then __O[2357] else nil
                end)
            end
            return __arrL({override}, 1)
        end
        local party = nil
        local coop = nil
        local state = nil
        do
            pcall(function()
                local ____opt_159 = window.PartyGame
                if ____opt_159 ~= nil then
                    ____opt_159 = ____opt_159.getStatus
                end
                local ____opt_result_161
                if ____opt_159 ~= nil then
                    ____opt_result_161 = ____opt_159(____opt_159)
                end
                party = ____opt_result_161
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
                local ____opt_164 = window.WorldLife
                if ____opt_164 ~= nil then
                    ____opt_164 = ____opt_164.getStatus
                end
                local ____opt_result_166
                if ____opt_164 ~= nil then
                    ____opt_result_166 = ____opt_164(____opt_164)
                end
                local challenge = ____opt_result_166
                local ____t_171 = __t
                local ____t_170 = __t
                local ____opt_result_169
                if challenge ~= nil then
                    ____opt_result_169 = challenge.open
                end
                __O[2358] = ____opt_result_169
                if ____t_171(if ____t_170(____opt_result_169) then __call(
                    __arrL({"pump", "memory", "sort"}, 3),
                    "includes",
                    challenge.kind
                ) else __O[2358]) then
                    local ____opt_174 = window.Game
                    if ____opt_174 ~= nil then
                        ____opt_174 = ____opt_174.getAudioState
                    end
                    local ____opt_result_176
                    if ____opt_174 ~= nil then
                        ____opt_result_176 = ____opt_174(____opt_174)
                    end
                    local game = ____opt_result_176
                    lastAudioState = if __t(game) then game else nil
                    local ____arrL_185 = __arrL
                    local ____add_result_184 = __add("activities.", challenge.kind)
                    local ____add_183 = __add
                    local ____t_182 = __t
                    local ____get_180 = __get
                    local ____opt_result_179
                    if game ~= nil then
                        ____opt_result_179 = game.scene
                    end
                    local ____get_180_result_181 = ____get_180(SCENES, ____opt_result_179)
                    __O[2359] = ____get_180_result_181
                    return true, ____arrL_185(
                        {
                            ____add_result_184,
                            ____add_183("maps.", if ____t_182(____get_180_result_181) then __O[2359] else "roca"),
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
        local ____t_189 = __t
        local ____opt_result_188
        if party ~= nil then
            ____opt_result_188 = party.open
        end
        if ____t_189(____opt_result_188) then
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
                return __arrL({"party.results", if __t(party.game) then __add("party.", party.game) else "party.menu", "party.menu"}, 3)
            end
            return __arrL({if __t(party.game) then __add("party.", party.game) else "party.menu", "party.menu"}, 2)
        end
        do
            pcall(function()
                local ____opt_192 = window.CoopArena
                if ____opt_192 ~= nil then
                    ____opt_192 = ____opt_192.getStatus
                end
                local ____opt_result_194
                if ____opt_192 ~= nil then
                    ____opt_result_194 = ____opt_192(____opt_192)
                end
                coop = ____opt_result_194
            end)
        end
        local ____t_198 = __t
        local ____opt_result_197
        if coop ~= nil then
            ____opt_result_197 = coop.open
        end
        if ____t_198(____opt_result_197) then
            if not __t(coop.stage) then
                return __arrL({"coop.menu", "menu.title"}, 2)
            end
            if coop.stage == "victory" then
                return __arrL({"events.celebration", "coop.menu"}, 2)
            end
            if coop.stage == "defeat" then
                return __arrL({"events.defeat", "coop.menu"}, 2)
            end
            local ____arrL_202 = __arrL
            local ____t_201 = __t
            local ____opt_199 = coop.boss
            if ____opt_199 ~= nil then
                ____opt_199 = ____opt_199.type
            end
            return ____arrL_202({if ____t_201(____opt_199) then __add("coop.", coop.boss.type) else "coop.menu", "coop.menu"}, 2)
        end
        local ____t_208 = __t
        local ____opt_205 = window.Fliperama
        if ____opt_205 ~= nil then
            ____opt_205 = ____opt_205.isOpen
        end
        local ____opt_result_207
        if ____opt_205 ~= nil then
            ____opt_result_207 = ____opt_205(____opt_205)
        end
        if ____t_208(____opt_result_207) then
            local ____this_210
            ____this_210 = window.Fliperama
            local ____opt_209 = ____this_210.current
            if ____opt_209 ~= nil then
                ____opt_209 = ____opt_209(____this_210)
            end
            local g = ____opt_209
            local ____arr_212 = __arr
            local ____array_211 = __TS__SparseArrayNew(__TS__Spread(__iter(if __t(g) then __arrL(
                {__add("minigames.fliperama.", g)},
                1
            ) else __arrL({}, 0))))
            __TS__SparseArrayPush(____array_211, "minigames.fliperama", "activities.memory", "menu.title")
            return ____arr_212(__TS__SparseArraySpread(____array_211))
        end
        local ____t_218 = __t
        local ____opt_215 = window.Campanha2
        if ____opt_215 ~= nil then
            ____opt_215 = ____opt_215.aberto
        end
        local ____opt_result_217
        if ____opt_215 ~= nil then
            ____opt_result_217 = ____opt_215(____opt_215)
        end
        if ____t_218(____opt_result_217) then
            local id = window.Campanha2:estado().cutscene
            if __t(id) then
                local ____arr_227 = __arr
                local ____add_result_226 = __add("cutscenes.", id)
                local ____iter_225 = __iter
                local ____t_224 = __t
                local ____opt_221 = window.Roteiro
                if ____opt_221 ~= nil then
                    ____opt_221 = ____opt_221.musicFor
                end
                local ____opt_result_223
                if ____opt_221 ~= nil then
                    ____opt_result_223 = ____opt_221(____opt_221, id)
                end
                __O[2360] = ____opt_result_223
                return ____arr_227(
                    ____add_result_226,
                    __TS__Spread(____iter_225(if ____t_224(____opt_result_223) then __O[2360] else __arrL({}, 0)))
                )
            end
            local e2 = nil
            do
                pcall(function()
                    e2 = window.Campanha2:estado()
                end)
            end
            local ____t_231 = __t
            local ____opt_result_230
            if e2 ~= nil then
                ____opt_result_230 = e2.luta
            end
            if ____t_231(____opt_result_230) then
                return __arrL(
                    {
                        __add("c2.battles.", e2.luta),
                        "c2.battles"
                    },
                    2
                )
            end
            local ____t_235 = __t
            local ____opt_result_234
            if e2 ~= nil then
                ____opt_result_234 = e2.chave
            end
            return if ____t_235(____opt_result_234) then __arrL(
                {
                    __add("c2.maps.", e2.chave),
                    "c2.maps"
                },
                2
            ) else __arrL({"c2.maps"}, 1)
        end
        local ____t_241 = __t
        local ____opt_238 = window.CampanhaCutscenes
        if ____opt_238 ~= nil then
            ____opt_238 = ____opt_238.aberta
        end
        local ____opt_result_240
        if ____opt_238 ~= nil then
            ____opt_result_240 = ____opt_238(____opt_238)
        end
        if ____t_241(____opt_result_240) then
            return __arrL({}, 0)
        end
        do
            pcall(function()
                local ____opt_244 = window.Game
                if ____opt_244 ~= nil then
                    ____opt_244 = ____opt_244.getAudioState
                end
                local ____opt_result_246
                if ____opt_244 ~= nil then
                    ____opt_result_246 = ____opt_244(____opt_244)
                end
                state = ____opt_result_246
                lastAudioState = if __t(state) then state else nil
            end)
        end
        local ____t_250 = __t
        local ____opt_result_249
        if state ~= nil then
            ____opt_result_249 = state.chapterEnded
        end
        if ____t_250(____opt_result_249) then
            return __arrL({"events.chapter_end"}, 1)
        end
        local ____t_253 = __t
        local ____t_252 = __t
        local ____temp_251 = not __t(state) or not __t(state.started)
        __O[2361] = ____temp_251
        if ____t_253(if ____t_252(____temp_251) then __O[2361] else state.playing == false) then
            return if __t(config.bindings["menu.title"]) then __arrL({"menu.title"}, 1) else __arrL({"menu.title", "maps.roca"}, 2)
        end
        local ____add_256 = __add
        local ____t_255 = __t
        local ____get_result_254 = __get(
            SCENES,
            __TS__Number(state.scene)
        )
        __O[2362] = ____get_result_254
        local map = ____add_256("maps.", if ____t_255(____get_result_254) then __O[2362] else __get(SCENES, 0))
        if __t(state.cutscene) then
            local ____arr_265 = __arr
            local ____array_264 = __TS__SparseArrayNew(__add(
                "cutscenes.",
                tostring(state.cutscene)
            ))
            local ____iter_263 = __iter
            local ____t_262 = __t
            local ____opt_259 = window.Roteiro
            if ____opt_259 ~= nil then
                ____opt_259 = ____opt_259.musicFor
            end
            local ____opt_result_261
            if ____opt_259 ~= nil then
                ____opt_result_261 = ____opt_259(____opt_259, state.cutscene)
            end
            __O[2363] = ____opt_result_261
            __TS__SparseArrayPush(
                ____array_264,
                __TS__Spread(____iter_263(if ____t_262(____opt_result_261) then __O[2363] else __arrL({}, 0)))
            )
            __TS__SparseArrayPush(
                ____array_264,
                __add(
                    "events.",
                    tostring(state.cutscene)
                ),
                map
            )
            return ____arr_265(__TS__SparseArraySpread(____array_264))
        end
        if __t(state.paused) then
            return __arrL({"menu.pause", map}, 2)
        end
        if __t(state.defeated) then
            return __arrL({"events.defeat", map}, 2)
        end
        if __t(state.boss) then
            local ____arr_267 = __arr
            local ____array_266 = __TS__SparseArrayNew(__TS__Spread(__iter(if __t(__isInteger(state.bossPhase) and __gt(state.bossPhase, 0)) then __arrL(
                {__add(
                    __add(
                        __add("battles.", state.boss),
                        ".phase"
                    ),
                    state.bossPhase
                )},
                1
            ) else __arrL({}, 0))))
            __TS__SparseArrayPush(
                ____array_266,
                __add("battles.", state.boss),
                map
            )
            return ____arr_267(__TS__SparseArraySpread(____array_266))
        end
        if __t(if __t(state.reeis) then __call(
            __arrL({
                "running",
                "charging",
                "transforming",
                "arriving",
                "invoke"
            }, 5),
            "includes",
            state.reeis
        ) else state.reeis) then
            return __arrL({"events.reeis_transform", map}, 2)
        end
        if __t(state.training) then
            return __arrL({"activity.caleb", map}, 2)
        end
        if __t(state.activity) then
            local key = if __t(__call(
                __arrL({"football", "mota", "soccer"}, 3),
                "includes",
                state.activity
            )) then "mota" else if __t(__call(
                __arrL({"english", "quiz"}, 2),
                "includes",
                state.activity
            )) then "english" else state.activity
            return __arrL(
                {
                    __add("activity.", key),
                    map
                },
                2
            )
        end
        local room = if __t(state.room) then __add("rooms.", state.room) else nil
        if __t(state.dialogue) then
            local name = normalName(nil, state.dialogue)
            local character = __call(
                speakers,
                "find",
                function(____, ____bindingPattern0)
                    local alias
                    alias = ____bindingPattern0[1]
                    local ____t_271 = __t
                    local ____t_269 = __t
                    local ____temp_268 = name == alias
                    __O[2364] = ____temp_268
                    local ____temp_270 = if ____t_269(____temp_268) then __O[2364] else __call(
                        name,
                        "startsWith",
                        __add(alias, " ")
                    )
                    __O[2365] = ____temp_270
                    return if ____t_271(____temp_270) then __O[2365] else __call(
                        name,
                        "endsWith",
                        __add(" ", alias)
                    )
                end
            )
            if __t(character) then
                local ____arr_273 = __arr
                local ____array_272 = __TS__SparseArrayNew(
                    __add(
                        "characters.",
                        __get(character, 1)
                    ),
                    __TS__Spread(__iter(if __t(room) then __arrL({room}, 1) else __arrL({}, 0)))
                )
                __TS__SparseArrayPush(____array_272, map)
                return ____arr_273(__TS__SparseArraySpread(____array_272))
            end
        end
        local ____arr_275 = __arr
        local ____array_274 = __TS__SparseArrayNew(__TS__Spread(__iter(if __t(room) then __arrL({room}, 1) else __arrL({}, 0))))
        __TS__SparseArrayPush(____array_274, map)
        return ____arr_275(__TS__SparseArraySpread(____array_274))
    end
    function select(self)
        local list = candidates(nil)
        local ____t_280 = __t
        local ____get_result_279 = __get(list, 0)
        __O[2367] = ____get_result_279
        context = if ____t_280(____get_result_279) then __O[2367] else "menu.title"
        if context == ARENA_SHUFFLE then
            return selectArena(nil)
        end
        for ____, key in __iterar((list)) do
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
            local ____opt_result_283
            if lastAudioState ~= nil then
                ____opt_result_283 = lastAudioState.cutscene
            end
            local cutsceneKind = ____opt_result_283
            local ____t_285 = __t
            local ____temp_284 = key == __add("events.", cutsceneKind)
            __O[2368] = ____temp_284
            local legacyCue = if ____t_285(____temp_284) then binding.startSeconds ~= nil or binding.delaySeconds ~= nil else __O[2368]
            local ____t_288 = __t
            local ____t_287 = __t
            local ____temp_286 = key == __add("cutscenes.", cutsceneKind)
            __O[2369] = ____temp_286
            local cutscene = not not ____t_288(if __t(cutsceneKind) then if ____t_287(____temp_286) then __O[2369] else legacyCue else cutsceneKind) or not not __t(if __t(override) then __call(key, "startsWith", "cutscenes.") else override)
            local startSeconds = if __t(binding.startSeconds) then binding.startSeconds else 0
            local delaySeconds = if __t(cutscene) then if __t(binding.delaySeconds) then binding.delaySeconds else 0 else 0
            local ____opt_result_291
            if lastAudioState ~= nil then
                ____opt_result_291 = lastAudioState.cutsceneToken
            end
            local ____opt_result_291_292 = ____opt_result_291
            if ____opt_result_291_292 == nil then
                ____opt_result_291_292 = cutsceneKind
            end
            local token = if __t(cutscene) then if __t(override) then __add("override-", overrideSerial) else ____opt_result_291_292 else nil
            matchedContext = key
            local ____track_307 = track
            local ____key_308 = key
            local ____temp_309 = if __t(isNative) then track.file else if __t(track.url) then track.url else track.file
            local ____temp_310 = if binding.loop == nil then track.loop else binding.loop
            local ____temp_299 = config.masterVolume * track.volume * if binding.volume == nil then 1 else binding.volume
            local ____opt_295 = window.DarocaAudio
            if ____opt_295 ~= nil then
                ____opt_295 = ____opt_295.music
            end
            local ____opt_result_297
            if ____opt_295 ~= nil then
                ____opt_result_297 = ____opt_295(____opt_295)
            end
            local ____opt_result_297_298 = ____opt_result_297
            if ____opt_result_297_298 == nil then
                ____opt_result_297_298 = 1
            end
            local ____clamp_result_311 = clamp(nil, ____temp_299 * ____opt_result_297_298, 0, 1)
            local ____temp_312 = if binding.fadeMs == nil then track.fadeMs else binding.fadeMs
            local ____startSeconds_313 = startSeconds
            local ____delaySeconds_314 = delaySeconds
            local ____cutscene_315 = cutscene
            local ____token_316 = token
            local ____opt_result_302
            if lastAudioState ~= nil then
                ____opt_result_302 = lastAudioState.cutsceneElapsed
            end
            local ____temp_317 = if __t(cutscene) then math.max(
                0,
                number(nil, ____opt_result_302, 0)
            ) else 0
            local ____opt_result_305
            if lastAudioState ~= nil then
                ____opt_result_305 = lastAudioState.cutsceneIndex
            end
            local ____opt_result_305_306 = ____opt_result_305
            if ____opt_result_305_306 == nil then
                ____opt_result_305_306 = 0
            end
            return {
                track = ____track_307,
                key = ____key_308,
                src = ____temp_309,
                loop = ____temp_310,
                volume = ____clamp_result_311,
                fadeMs = ____temp_312,
                startSeconds = ____startSeconds_313,
                delaySeconds = ____delaySeconds_314,
                cutscene = ____cutscene_315,
                token = ____token_316,
                elapsed = ____temp_317,
                index = if __t(cutscene) then ____opt_result_305_306 else nil,
                cueKey = if __t(cutscene) then __add(
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
                ) else if __gt(startSeconds, 0) then __add(
                    __add(
                        __add("offset|", track.id),
                        "|"
                    ),
                    startSeconds
                ) else nil
            }
        end
        matchedContext = nil
        return nil
    end
    function timelineSelection(self, selection)
        local ____t_321 = __t
        local ____opt_result_320
        if selection ~= nil then
            ____opt_result_320 = selection.cutscene
        end
        if not ____t_321(____opt_result_320) then
            filmClock = nil
            return selection
        end
        local time = now(nil)
        local ____t_323 = __t
        local ____temp_322 = not __t(nativePaused) and not __t(window.document.hidden)
        __O[2370] = ____temp_322
        local ____t_327 = __t
        local ____opt_result_326
        if lastAudioState ~= nil then
            ____opt_result_326 = lastAudioState.paused
        end
        local running = if ____t_323(____temp_322) then not ____t_327(____opt_result_326) else __O[2370]
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
        local duration = if __t(__isFiniteN(audio.duration) and __gt(audio.duration, 0)) then audio.duration else selection.track.duration
        local start = if __gt(duration, 0) then math.min(
            selection.startSeconds,
            math.max(0, duration - 0.01)
        ) else selection.startSeconds
        local raw = start + if __t(selection.cutscene) then math.max(0, selection.elapsed - selection.delaySeconds) else 0
        if __t(__gt(duration, 0) and __ge(raw, duration)) then
            if __t(if __t(selection.loop) then duration - start > 0.01 else selection.loop) then
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
        if __t(if type(v.audio.readyState) == "number" then __ge(v.audio.readyState, 1) else __isFiniteN(v.audio.duration) and __gt(v.audio.duration, 0)) then
            return __TS__Promise.resolve(true)
        end
        local ____this_329
        ____this_329 = v
        local ____opt_328 = ____this_329.cancelMetadata
        if ____opt_328 ~= nil then
            ____opt_328(____this_329)
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
                    local ____this_331
                    ____this_331 = v.audio
                    local ____opt_330 = ____this_331.removeEventListener
                    if ____opt_330 ~= nil then
                        ____opt_330(____this_331, "loadedmetadata", loaded)
                    end
                    local ____this_333
                    ____this_333 = v.audio
                    local ____opt_332 = ____this_333.removeEventListener
                    if ____opt_332 ~= nil then
                        ____opt_332(____this_333, "error", failed)
                    end
                    if v.cancelMetadata == cancel then
                        v.cancelMetadata = nil
                    end
                    local ____resolve_340 = resolve
                    local ____t_339 = __t
                    local ____t_337 = __t
                    local ____t_335 = __t
                    local ____temp_334 = if __t(ok) then generation == requestGeneration else ok
                    __O[2371] = ____temp_334
                    local ____temp_336 = if ____t_335(____temp_334) then v.pending == generation else __O[2371]
                    __O[2372] = ____temp_336
                    local ____temp_338 = if ____t_337(____temp_336) then not __t(suspended(nil)) else __O[2372]
                    __O[2373] = ____temp_338
                    ____resolve_340(nil, if ____t_339(____temp_338) then enabled else __O[2373])
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
            local ____this_342
            ____this_342 = v
            local ____opt_341 = ____this_342.cancelMetadata
            if ____opt_341 ~= nil then
                ____opt_341(____this_342)
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
                local ____this_344
                ____this_344 = v.audio
                local ____opt_343 = ____this_344.load
                if ____opt_343 ~= nil then
                    ____opt_343(____this_344)
                end
            end
            v.loop = selection.loop
            v.startSeconds = selection.startSeconds
            v.audio.loop = if __t(selection.loop) then selection.startSeconds == 0 else selection.loop
            local ____t_350 = __t
            local ____t_348 = __t
            local ____t_346 = __t
            local ____temp_345 = not __t(same)
            __O[2374] = ____temp_345
            local ____temp_347 = if ____t_346(____temp_345) then __O[2374] else seek
            __O[2375] = ____temp_347
            local ____temp_349 = if ____t_348(____temp_347) then __O[2375] else v.cueKey ~= selection.cueKey
            __O[2376] = ____temp_349
            local needsSeek = if ____t_350(____temp_349) then __O[2376] else if __t(v.ended) then selection.loop else v.ended
            local ____t_355 = __t
            local ____t_354 = __t
            local ____t_352 = __t
            local ____temp_351 = if __t(selection.cutscene) then selection.cutscene else selection.arenaShuffle
            __O[2377] = ____temp_351
            local ____temp_353 = if ____t_352(____temp_351) then __O[2377] else __gt(selection.startSeconds, 0)
            __O[2378] = ____temp_353
            if ____t_355(if __t(needsSeek) then if ____t_354(____temp_353) then __O[2378] else __callq(v.cueKey, "startsWith", "offset|") else needsSeek) then
                if not __t(__TS__Await(waitMetadata(nil, v, generation))) then
                    local ____t_358 = __t
                    local ____t_357 = __t
                    local ____temp_356 = generation == requestGeneration and not __t(suspended(nil))
                    __O[2379] = ____temp_356
                    if ____t_358(if ____t_357(____temp_356) then enabled else __O[2379]) then
                        lastError = "Não foi possível carregar o trecho da música. Toque no som para tentar novamente."
                    end
                    return ____awaiter_resolve(nil, false)
                end
                local ____t_363 = __t
                local ____t_362 = __t
                local ____t_360 = __t
                local ____temp_359 = generation ~= requestGeneration or v.pending ~= generation
                __O[2380] = ____temp_359
                local ____temp_361 = if ____t_360(____temp_359) then __O[2380] else not __t(enabled)
                __O[2381] = ____temp_361
                if ____t_363(if ____t_362(____temp_361) then __O[2381] else suspended(nil)) then
                    return ____awaiter_resolve(nil, false)
                end
                selection = timelineSelection(nil, selection)
                local ____selection_startSeconds_366 = selection.startSeconds
                local ____t_365 = __t
                local ____temp_364 = if __t(v.audio.duration) then v.audio.duration else selection.track.duration
                __O[2382] = ____temp_364
                local target = if __t(if __t(v.ended) then selection.loop else v.ended) then {
                    seconds = math.min(
                        ____selection_startSeconds_366,
                        math.max(0, if ____t_365(____temp_364) then __O[2382] else math.huge - 0.01)
                    ),
                    ended = false
                } else targetPosition(nil, selection, v.audio)
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
            elseif __t(if __t(needsSeek) then not __t(same) else needsSeek) then
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
            v.cueKey = selection.cueKey
            v.cutsceneIndex = selection.index
            if __t(if __t(v.ended) then not __t(selection.loop) else v.ended) then
                return ____awaiter_resolve(nil, false)
            end
            local ____hasReturned, ____returnValue
            local ____try = __TS__AsyncAwaiter(function()
                if __t(if __t(audioContext) then audioContext.state ~= "running" else audioContext) then
                    __TS__Await(audioContext:resume())
                end
                local ____t_371 = __t
                local ____t_370 = __t
                local ____t_368 = __t
                local ____temp_367 = generation ~= requestGeneration or v.pending ~= generation
                __O[2383] = ____temp_367
                local ____temp_369 = if ____t_368(____temp_367) then __O[2383] else not __t(enabled)
                __O[2384] = ____temp_369
                if ____t_371(if ____t_370(____temp_369) then __O[2384] else suspended(nil)) then
                    ____hasReturned = true
                    ____returnValue = false
                    return
                end
                local p = v.audio:play()
                v.plays = v.plays + 1
                __TS__Await(__TS__Promise.resolve(p))
                local ____t_374 = __t
                local ____t_373 = __t
                local ____temp_372 = generation ~= requestGeneration or not __t(enabled)
                __O[2385] = ____temp_372
                if ____t_374(if ____t_373(____temp_372) then __O[2385] else suspended(nil)) then
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
                            local ____opt_result_377
                            if e ~= nil then
                                ____opt_result_377 = e.name
                            end
                            lastError = if ____opt_result_377 == "NotAllowedError" then "Toque novamente no botão de som para liberar a música." else __add(
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
            local ____opt_378 = v.cancelMetadata
            if ____opt_378 ~= nil then
                ____opt_378(v)
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
        local ____t_384 = __t
        local ____t_383 = __t
        local ____opt_result_382
        if lastAudioState ~= nil then
            ____opt_result_382 = lastAudioState.cutscene
        end
        __O[2386] = ____opt_result_382
        local nextPaused = not not ____t_384(if ____t_383(____opt_result_382) then lastAudioState.paused else __O[2386])
        if nextPaused ~= gamePaused then
            gamePaused = nextPaused
            if __t(gamePaused) then
                pauseForLifecycle(nil)
            else
                lastAttempt = ""
                do
                    pcall(function()
                        local ____opt_result_389
                        if audioContext ~= nil then
                            ____opt_result_389 = audioContext:resume()
                        end
                        if ____opt_result_389 ~= nil then
                            ____opt_result_389:catch(function()
                            end)
                        end
                    end)
                end
            end
        end
        local ____t_394 = __t
        local ____t_393 = __t
        local ____t_391 = __t
        local ____temp_390 = not __t(ready) or not __t(enabled)
        __O[2387] = ____temp_390
        local ____temp_392 = if ____t_391(____temp_390) then __O[2387] else not __t(unlocked)
        __O[2388] = ____temp_392
        if ____t_394(if ____t_393(____temp_392) then __O[2388] else suspended(nil)) then
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
        if __t(if __t(selection.cutscene) then __lt(selection.elapsed + 0.005, selection.delaySeconds) else selection.cutscene) then
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
        local ____t_396 = __t
        local ____temp_395 = selection.cueKey ~= nil and same.cueKey ~= selection.cueKey
        __O[2390] = ____temp_395
        local ____t_398 = __t
        local ____temp_397 = selection.cueKey == nil
        __O[2389] = ____temp_397
        local cueChanged = if __t(same) then if ____t_396(____temp_395) then __O[2390] else if ____t_398(____temp_397) then __callq(same.cueKey, "startsWith", "offset|") else __O[2389] else same
        local ____t_401 = __t
        local ____t_400 = __t
        local ____temp_399 = if __t(selection.cutscene) then not __t(same) or same.cueKey ~= selection.cueKey else selection.cutscene
        __O[2391] = ____temp_399
        if ____t_401(if ____t_400(____temp_399) then targetPosition(nil, selection, {duration = selection.track.duration}).ended else __O[2391]) then
            silenceSelection(
                nil,
                __add("end|", selection.cueKey),
                selection.fadeMs
            )
            return
        end
        local ____t_406 = __t
        local ____t_405 = __t
        local ____t_403 = __t
        local ____temp_402 = if __t(same) then active == same.index else same
        __O[2392] = ____temp_402
        local ____temp_404 = if ____t_403(____temp_402) then not __t(same.audio.paused) else __O[2392]
        __O[2393] = ____temp_404
        if ____t_406(if ____t_405(____temp_404) then not __t(cueChanged) else __O[2393]) then
            same.cueKey = selection.cueKey
            same.cutsceneIndex = selection.index
            same.loop = selection.loop
            same.startSeconds = selection.startSeconds
            same.audio.loop = if __t(selection.loop) then selection.startSeconds == 0 else selection.loop
            local ____opt_407 = same.ramp
            if ____opt_407 ~= nil then
                ____opt_407 = ____opt_407.to
            end
            local ____opt_407_409 = ____opt_407
            if ____opt_407_409 == nil then
                ____opt_407_409 = same.volume
            end
            local target = ____opt_407_409
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
        local ____t_418 = __t
        local ____t_417 = __t
        local ____t_415 = __t
        local ____t_413 = __t
        local ____opt_result_412
        if same ~= nil then
            ____opt_result_412 = same.ended
        end
        __O[2394] = ____opt_result_412
        local ____temp_414 = if ____t_413(____opt_result_412) then not __t(selection.loop) else __O[2394]
        __O[2395] = ____temp_414
        local ____temp_416 = if ____t_415(____temp_414) then same.cueKey == selection.cueKey else __O[2395]
        __O[2396] = ____temp_416
        if ____t_418(if ____t_417(____temp_416) then not __t(cueChanged) else __O[2396]) then
            lastAttempt = attempt
            return
        end
        lastAttempt = attempt
        requestGeneration = requestGeneration + 1
        local generation = requestGeneration
        local index = if __t(same) then same.index else if active == 0 then 1 else 0
        local v = __get(voices, index)
        local old = if active >= 0 then __get(voices, active) else nil
        if old ~= v then
            gain(nil, v, 0, 0)
        end
        v.pending = generation
        local ____self_419 = playVoice(
            nil,
            v,
            selection,
            generation,
            cueChanged
        )
        ____self_419["then"](
            ____self_419,
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
            local ____opt_436 = v.cancelMetadata
            if ____opt_436 ~= nil then
                ____opt_436(v)
            end
            gain(nil, v, 0, 0)
            v.audio:pause()
        end
        transition = false
        do
            pcall(function()
                local ____opt_result_442
                if audioContext ~= nil then
                    ____opt_result_442 = audioContext:suspend()
                end
                if ____opt_result_442 ~= nil then
                    ____opt_result_442:catch(function()
                    end)
                end
            end)
        end
    end
    function isPlaying(self)
        local ____t_458 = __t
        local ____t_456 = __t
        local ____t_454 = __t
        local ____temp_453 = if __t(enabled) then unlocked else enabled
        __O[2401] = ____temp_453
        local ____temp_455 = if ____t_454(____temp_453) then not __t(suspended(nil)) else __O[2401]
        __O[2402] = ____temp_455
        local ____temp_457 = if ____t_456(____temp_455) then not __t(audioContext) or audioContext.state == "running" else __O[2402]
        __O[2404] = ____temp_457
        return if ____t_458(____temp_457) then __call(
            voices,
            "some",
            function(____, v)
                local ____t_460 = __t
                local ____temp_459 = not __t(v.audio.paused) and not __t(v.audio.ended)
                __O[2403] = ____temp_459
                return if ____t_460(____temp_459) then __gt(
                    currentVolume(nil, v),
                    0.0001
                ) else __O[2403]
            end
        ) else __O[2404]
    end
    function getStatus(self)
        local ____ready_495 = ready
        local ____enabled_496 = enabled
        local ____unlocked_497 = unlocked
        local ____source_498 = source
        local ____config_revision_499 = config.revision
        local ____context_500 = context
        local ____matchedContext_501 = matchedContext
        local ____t_464 = __t
        local ____opt_result_463
        if desired ~= nil then
            ____opt_result_463 = desired.track.id
        end
        __O[2405] = ____opt_result_463
        local ____temp_502 = if ____t_464(____opt_result_463) then __O[2405] else nil
        local ____t_468 = __t
        local ____opt_result_467
        if desired ~= nil then
            ____opt_result_467 = desired.track.title
        end
        __O[2406] = ____opt_result_467
        local ____temp_503 = if ____t_468(____opt_result_467) then __O[2406] else nil
        local ____t_472 = __t
        local ____opt_result_471
        if desired ~= nil then
            ____opt_result_471 = desired.startSeconds
        end
        __O[2407] = ____opt_result_471
        local ____temp_504 = if ____t_472(____opt_result_471) then __O[2407] else 0
        local ____t_476 = __t
        local ____opt_result_475
        if desired ~= nil then
            ____opt_result_475 = desired.delaySeconds
        end
        __O[2408] = ____opt_result_475
        local ____temp_505 = if ____t_476(____opt_result_475) then __O[2408] else 0
        local ____opt_result_479
        if desired ~= nil then
            ____opt_result_479 = desired.token
        end
        local ____opt_result_479_480 = ____opt_result_479
        if ____opt_result_479_480 == nil then
            ____opt_result_479_480 = nil
        end
        local ____opt_result_483
        if desired ~= nil then
            ____opt_result_483 = desired.elapsed
        end
        local ____opt_result_483_484 = ____opt_result_483
        if ____opt_result_483_484 == nil then
            ____opt_result_483_484 = nil
        end
        local ____t_489 = __t
        local ____t_488 = __t
        local ____opt_result_487
        if desired ~= nil then
            ____opt_result_487 = desired.cutscene
        end
        __O[2409] = ____opt_result_487
        return {
            ready = ____ready_495,
            enabled = ____enabled_496,
            unlocked = ____unlocked_497,
            native = isNative,
            source = ____source_498,
            revision = ____config_revision_499,
            context = ____context_500,
            matchedContext = ____matchedContext_501,
            trackId = ____temp_502,
            title = ____temp_503,
            startSeconds = ____temp_504,
            delaySeconds = ____temp_505,
            cutsceneToken = ____opt_result_479_480,
            cutsceneElapsed = ____opt_result_483_484,
            waiting = not not ____t_489(if ____t_488(____opt_result_487) then __lt(desired.elapsed, desired.delaySeconds) else __O[2409]),
            playing = isPlaying(nil),
            transitioning = transition,
            error = if __t(lastError) then lastError else nil,
            configError = if __t(configError) then configError else nil,
            playlist = if __t(arenaPlaylist.open) then {
                mode = "shuffle",
                size = __len(config.tracks),
                currentTrackId = arenaPlaylist.currentId,
                remaining = __len(arenaPlaylist.bag),
                session = arenaPlaylist.session,
                matchId = arenaPlaylist.matchId
            } else nil,
            voices = __call(
                voices,
                "map",
                function(____, v)
                    local ____v_id_492 = v.id
                    local ____temp_493 = not __t(v.audio.paused) and not __t(v.audio.ended)
                    local ____TS__Number_result_494 = __TS__Number(__call(
                        currentVolume(nil, v),
                        "toFixed",
                        5
                    ))
                    local ____t_491 = __t
                    local ____TS__Number_result_490 = __TS__Number(v.audio.currentTime)
                    __O[2410] = ____TS__Number_result_490
                    return {
                        trackId = ____v_id_492,
                        playing = ____temp_493,
                        volume = ____TS__Number_result_494,
                        currentTime = if ____t_491(____TS__Number_result_490) then __O[2410] else 0,
                        duration = if __isFiniteN(v.audio.duration) then v.audio.duration else 0,
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
    local ____t_1 = __t
    local ____temp_0 = window.location.hostname == "127.0.0.1" and __call(launch, "get", "native") == "1"
    __O[2321] = ____temp_0
    local nativePC = if ____t_1(____temp_0) then __call(launch, "get", "pc") == "1" else __O[2321]
    local ____t_7 = __t
    local ____t_5 = __t
    local ____t_3 = __t
    local ____temp_2 = window.location.hostname == "appassets.androidplatform.net"
    __O[2322] = ____temp_2
    local ____temp_4 = if ____t_3(____temp_2) then __O[2322] else nativePC
    __O[2323] = ____temp_4
    local ____temp_6 = if ____t_5(____temp_4) then __O[2323] else window.location.protocol == "file:"
    __O[2324] = ____temp_6
    isNative = if ____t_7(____temp_6) then __O[2324] else window.location.protocol == "daroca:"
    local isWeb = __call(
        __arrL({"https:", "http:"}, 2),
        "includes",
        window.location.protocol
    )
    local ____Set_12 = Set
    local ____call_11 = __call
    local ____t_10 = __t
    local ____opt_8 = window.DAROCA_MUSIC_CONFIG
    if ____opt_8 ~= nil then
        ____opt_8 = ____opt_8.tracks
    end
    __O[2325] = ____opt_8
    local packagedIds = __TS__New(
        ____Set_12,
        ____call_11(
            if ____t_10(____opt_8) then __O[2325] else __arrL({}, 0),
            "map",
            function(____, t) return t.id end
        )
    )
    clamp = function(____, v, a, b) return math.max(
        a,
        math.min(b, v)
    ) end
    number = function(____, v, f) return if __isFiniteN(__TS__Number(v)) then __TS__Number(v) else f end
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
        local ____t_19 = __t
        local ____t_18 = __t
        local ____t_16 = __t
        local ____t_14 = __t
        local ____temp_13 = not __t(raw) or raw.schema ~= VERSION
        __O[2326] = ____temp_13
        local ____temp_15 = if ____t_14(____temp_13) then __O[2326] else not __isArray(raw.tracks)
        __O[2327] = ____temp_15
        local ____temp_17 = if ____t_16(____temp_15) then __O[2327] else not __t(raw.bindings)
        __O[2328] = ____temp_17
        if ____t_19(if ____t_18(____temp_17) then __O[2328] else type(raw.bindings) ~= "table") then
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
        c.categories = __call(
            __call(
                __call(
                    if __isArray(raw.categories) then raw.categories else __arrL({}, 0),
                    "filter",
                    function(____, x)
                        local ____t_21 = __t
                        local ____temp_20 = if __t(x) then type(x.id) == "string" else x
                        __O[2329] = ____temp_20
                        return if ____t_21(____temp_20) then type(x.name) == "string" else __O[2329]
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
            local ____t_26 = __t
            local ____t_25 = __t
            local ____t_23 = __t
            local ____temp_22 = not __t(t) or type(t.id) ~= "string"
            __O[2330] = ____temp_22
            local ____temp_24 = if ____t_23(____temp_22) then __O[2330] else not __re_test(
                __re("^[a-f0-9]{64}$", "i"),
                t.id
            )
            __O[2331] = ____temp_24
            if ____t_26(if ____t_25(____temp_24) then __O[2331] else __call(seen, "has", t.id)) then
                continue
            end
            local id = __call(t.id, "toLowerCase")
            local file = __add(
                __add("music/", id),
                ".mp3"
            )
            if __t(if __t(t.file) then t.file ~= file else t.file) then
                continue
            end
            __call(seen, "add", id)
            local ____call_40 = __call
            local ____c_tracks_39 = c.tracks
            local ____id_30 = id
            local ____call_result_31 = __call(
                tostring(if __t(t.title) then t.title else "Trilha"),
                "slice",
                0,
                140
            )
            local ____call_result_32 = __call(
                tostring(if __t(t.categoryId) then t.categoryId else "maps"),
                "slice",
                0,
                80
            )
            local ____file_33 = file
            local ____math_max_result_34 = math.max(
                0,
                number(nil, t.bytes, 0)
            )
            local ____math_max_result_35 = math.max(
                0,
                number(nil, t.duration, 0)
            )
            local ____clamp_result_36 = clamp(
                nil,
                number(nil, t.volume, 1),
                0,
                1
            )
            local ____temp_37 = t.loop ~= false
            local ____clamp_result_38 = clamp(
                nil,
                number(nil, t.fadeMs, c.defaultFadeMs),
                0,
                10000
            )
            local ____t_29 = __t
            local ____t_28 = __t
            local ____temp_27 = not __t(isNative) and not __t(__call(packagedIds, "has", id))
            __O[2332] = ____temp_27
            ____call_40(____c_tracks_39, "push", {
                id = ____id_30,
                title = ____call_result_31,
                categoryId = ____call_result_32,
                file = ____file_33,
                sha256 = id,
                bytes = ____math_max_result_34,
                duration = ____math_max_result_35,
                volume = ____clamp_result_36,
                loop = ____temp_37,
                fadeMs = ____clamp_result_38,
                url = if ____t_29(if ____t_28(____temp_27) then t.url == __add(
                    __add("/music/", id),
                    ".mp3"
                ) else __O[2332]) then t.url else nil
            })
        end
        for ____, ____value in __iterar((__entries(raw.bindings))) do
            local id = ____value[1]
            local b = ____value[2]
            local ____t_45 = __t
            local ____t_44 = __t
            local ____t_42 = __t
            local ____temp_41 = not __re_test(
                __re("^[a-zA-Z0-9_.-]{1,90}$", ""),
                id
            ) or not __t(b)
            __O[2333] = ____temp_41
            local ____temp_43 = if ____t_42(____temp_41) then __O[2333] else type(b) ~= "table"
            __O[2334] = ____temp_43
            if ____t_45(if ____t_44(____temp_43) then __O[2334] else not __t(__call(
                c.tracks,
                "some",
                function(____, t) return t.id == b.trackId end
            ))) then
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
        return c
    end
    local function mergeLocal(self, c, ____local)
        local ____t_48 = __t
        local ____t_47 = __t
        local ____temp_46 = not __t(____local) or not __t(c)
        __O[2335] = ____temp_46
        if ____t_48(if ____t_47(____temp_46) then __O[2335] else not __t(__len(____local.tracks)) and not __t(__len(__keys(____local.bindings)))) then
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
                local ____self_51 = window.JSON
                local ____self_51_parse_52 = ____self_51.parse
                local ____t_50 = __t
                local ____temp_49 = window.localStorage:getItem(CONFIG_CACHE)
                __O[2336] = ____temp_49
                local cached = ____self_51_parse_52(____self_51, if ____t_50(____temp_49) then __O[2336] else "null")
                return true, if __t(if __t(cached) then window.Date:now() - cached.at < DAY else cached) then normaliseConfig(nil, cached.config) else nil
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
            local controller = if type(window.AbortController) == "function" then __new("AbortController") else nil
            local timer = window:setTimeout(
                function()
                    local ____opt_result_55
                    if controller ~= nil then
                        ____opt_result_55 = controller:abort()
                    end
                    return ____opt_result_55
                end,
                6000
            )
            local ____hasReturned, ____returnValue
            local ____try = __TS__AsyncAwaiter(function()
                local ____window_60 = window
                local ____window_fetch_61 = window.fetch
                local ____url_59 = url
                local ____opt_result_58
                if controller ~= nil then
                    ____opt_result_58 = controller.signal
                end
                local r = __TS__Await(____window_fetch_61(____window_60, ____url_59, {cache = "no-store", credentials = "same-origin", signal = ____opt_result_58}))
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
                    local useCache = if __t(cached) then not __t(bundled) or cached.revision >= bundled.revision else cached
                    local base = if __t(useCache) then cached else bundled
                    local baseSource = if __t(useCache) then "cache" else "bundled"
                    local ____t_64 = __t
                    local ____t_63 = __t
                    local ____temp_62 = not __t(ready)
                    __O[2337] = ____temp_62
                    if ____t_64(if ____t_63(____temp_62) then base else __O[2337]) then
                        applyConfig(nil, base, baseSource)
                    end
                    local ____local = nil
                    local ____try = __TS__AsyncAwaiter(function()
                        local ____opt_67 = window.DarocaMusicas
                        if ____opt_67 ~= nil then
                            ____opt_67 = ____opt_67.load
                        end
                        local ____opt_result_69
                        if ____opt_67 ~= nil then
                            ____opt_result_69 = ____opt_67(____opt_67)
                        end
                        ____local = __TS__Await(____opt_result_69)
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
                    local ____t_77 = __t
                    local ____t_71 = __t
                    local ____temp_70 = if __t(base) then base else ____local
                    __O[2339] = ____temp_70
                    local ____temp_76 = not __t(ready)
                    if not ____temp_76 then
                        local ____t_75 = __t
                        local ____opt_result_74
                        if base ~= nil then
                            ____opt_result_74 = base.revision
                        end
                        __O[2338] = ____opt_result_74
                        ____temp_76 = if ____t_75(____opt_result_74) then __O[2338] else 0 >= config.revision
                    end
                    if ____t_77(if ____t_71(____temp_70) then ____temp_76 else __O[2339]) then
                        local merged = mergeLocal(nil, if __t(base) then base else empty(nil), ____local)
                        if merged ~= config then
                            applyConfig(nil, merged, baseSource)
                        end
                    end
                    local ____t_82 = __t
                    local ____t_81 = __t
                    local ____t_79 = __t
                    local ____temp_78 = not __t(isNative)
                    __O[2340] = ____temp_78
                    local ____temp_80 = if ____t_79(____temp_78) then isWeb else __O[2340]
                    __O[2341] = ____temp_80
                    if ____t_82(if ____t_81(____temp_80) then not __t(window.DAROCA_LAN) else __O[2341]) then
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
                local ____opt_result_117
                if audioContext ~= nil then
                    ____opt_result_117 = audioContext:resume()
                end
                local resume = ____opt_result_117
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
                        local ____self_123 = __TS__Promise.resolve(p)
                        ____self_123["then"](
                            ____self_123,
                            function()
                                local ____t_122 = __t
                                local ____t_121 = __t
                                local ____temp_120 = if __t(v.warming) then not __t(v.id) else v.warming
                                __O[2352] = ____temp_120
                                if ____t_122(if ____t_121(____temp_120) then generation == requestGeneration else __O[2352]) then
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
        local ____opt_result_126
        if audioContext ~= nil then
            ____opt_result_126 = audioContext.state
        end
        return __TS__Promise.resolve(____opt_result_126 == "running" or not __t(audioContext))
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
                local ____opt_127 = v.cancelMetadata
                if ____opt_127 ~= nil then
                    ____opt_127(v)
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
        local ____t_278 = __t
        local ____t_277 = __t
        local ____temp_276 = if __t(b) then b.enabled ~= false else b
        __O[2366] = ____temp_276
        return not not ____t_278(if ____t_277(____temp_276) then __call(
            config.tracks,
            "some",
            function(____, t) return t.id == b.trackId end
        ) else __O[2366])
    end
    local function control(self)
        local party = false
        do
            pcall(function()
                local ____t_425 = __t
                local ____opt_422 = window.PartyGame
                if ____opt_422 ~= nil then
                    ____opt_422 = ____opt_422.getStatus
                end
                local ____opt_result_424
                if ____opt_422 ~= nil then
                    ____opt_result_424 = ____opt_422(____opt_422).open
                end
                party = not not ____t_425(____opt_result_424)
            end)
        end
        local button = window.document:getElementById(if __t(party) then "partySoundBtn" else "soundBtn")
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
            if __t(if __t(v.ramp) then __ge(time, v.ramp["end"]) else v.ramp) then
                v.volume = v.ramp.to
                v.ramp = nil
                local ____t_430 = __t
                local ____t_429 = __t
                local ____t_427 = __t
                local ____temp_426 = v.volume == 0 and active ~= v.index
                __O[2397] = ____temp_426
                local ____temp_428 = if ____t_427(____temp_426) then not __t(v.pending) else __O[2397]
                __O[2398] = ____temp_428
                if ____t_430(if ____t_429(____temp_428) then not __t(v.audio.paused) else __O[2398]) then
                    v.audio:pause()
                end
            end
            if __t(v.ramp) then
                fading = true
            end
        end
        transition = fading
        local ____temp_435 = time - lastContextSync
        local ____t_434 = __t
        local ____opt_result_433
        if lastAudioState ~= nil then
            ____opt_result_433 = lastAudioState.cutscene
        end
        if ____temp_435 >= if ____t_434(____opt_result_433) then 40 else 150 then
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
        local ____t_447 = __t
        local ____t_446 = __t
        local ____t_444 = __t
        local ____suspended_result_443 = suspended(nil)
        __O[2399] = ____suspended_result_443
        local ____temp_445 = if ____t_444(____suspended_result_443) then __O[2399] else not __t(enabled)
        __O[2400] = ____temp_445
        if ____t_447(if ____t_446(____temp_445) then __O[2400] else not __t(unlocked)) then
            return
        end
        lastAttempt = ""
        do
            pcall(function()
                local ____opt_result_452
                if audioContext ~= nil then
                    ____opt_result_452 = audioContext:resume()
                end
                if ____opt_result_452 ~= nil then
                    ____opt_result_452["then"](
                        ____opt_result_452,
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
        local ____t_508 = __t
        local ____t_507 = __t
        local ____temp_506 = type(id) == "string"
        __O[2411] = ____temp_506
        override = if ____t_508(if ____t_507(____temp_506) then id else __O[2411]) then id else nil
        overrideSerial = overrideSerial + 1
        lastAttempt = ""
        syncSelection(nil, true)
        return getStatus(nil)
    end
    window.document:addEventListener(
        "click",
        function(____, event)
            local ____opt_511 = event.target
            local ____opt_509 = ____opt_511 and ____opt_511.closest
            if ____opt_509 ~= nil then
                ____opt_509 = ____opt_509(____opt_511, "#soundBtn,#partySoundBtn,#epilogueSoundBtn")
            end
            local button = ____opt_509
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
                        local ____opt_513 = e.data
                        if ____opt_513 ~= nil then
                            ____opt_513 = ____opt_513.type
                        end
                        if ____opt_513 == "config-updated" then
                            reload(nil)
                        end
                    end
                )
            end
        end)
    end
    local title = window.document:getElementById("startScreen")
    local sourceButton = window.document:getElementById("soundBtn")
    local ____t_519 = __t
    local ____t_518 = __t
    local ____t_516 = __t
    local ____temp_515 = if __t(title) then sourceButton else title
    __O[2412] = ____temp_515
    local ____temp_517 = if ____t_516(____temp_515) then type(title.append) == "function" else __O[2412]
    __O[2413] = ____temp_517
    if ____t_519(if ____t_518(____temp_517) then not __t(window.document:getElementById("menuMusicBtn")) else __O[2413]) then
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
            button:setAttribute("aria-label", if __t(on) then "Desativar músicas e efeitos" else "Ativar músicas e efeitos")
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
            local ____opt_522 = window.DarocaAudio
            if ____opt_522 ~= nil then
                ____opt_522 = ____opt_522.onChange
            end
            if ____opt_522 ~= nil then
                ____opt_522(
                    ____opt_522,
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
            hasSelection = function() return if __t(enabled) then not not __t(desired) else enabled end,
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
        local ____t_526 = __t
        local ____t_525 = __t
        local ____temp_524 = if __t(event.isTrusted) then enabled else event.isTrusted
        __O[2414] = ____temp_524
        if ____t_526(if ____t_525(____temp_524) then not __t(unlocked) or not __t(isPlaying(nil)) else __O[2414]) then
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
    local ____opt_529 = window.Game
    if ____opt_529 ~= nil then
        ____opt_529 = ____opt_529.setSoundEnabled
    end
    if ____opt_529 ~= nil then
        ____opt_529(____opt_529, enabled)
    end
    if __t(if __t(enabled) then isNative else enabled) then
        unlock(nil)
    end
end)(nil)
return ____exports
