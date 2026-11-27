--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __newExpr, __lt, __le, __gt, __ge, __isSafeInteger, __isFiniteN, __isInteger, __ord, __arrL, __iterar, __t = __JSR.__newExpr, __JSR.__lt, __JSR.__le, __JSR.__gt, __JSR.__ge, __JSR.__isSafeInteger, __JSR.__isFiniteN, __JSR.__isInteger, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t
local __get, __arr, __len, __call, __add, __iter, __entries, __isArray, __re, __re_test = __JSR.__get, __JSR.__arr, __JSR.__len, __JSR.__call, __JSR.__add, __JSR.__iter, __JSR.__entries, __JSR.__isArray, __JSR.__re, __JSR.__re_test
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Iterator = ____lualib.__TS__Iterator
local Map = ____lualib.Map
local __TS__New = ____lualib.__TS__New
local Set = ____lualib.Set
local __TS__Spread = ____lualib.__TS__Spread
local __TS__AsyncAwaiter = ____lualib.__TS__AsyncAwaiter
local __TS__Await = ____lualib.__TS__Await
local Error = ____lualib.Error
local RangeError = ____lualib.RangeError
local ReferenceError = ____lualib.ReferenceError
local SyntaxError = ____lualib.SyntaxError
local TypeError = ____lualib.TypeError
local URIError = ____lualib.URIError
local __TS__Promise = ____lualib.__TS__Promise
local __TS__SparseArrayNew = ____lualib.__TS__SparseArrayNew
local __TS__SparseArrayPush = ____lualib.__TS__SparseArrayPush
local __TS__SparseArraySpread = ____lualib.__TS__SparseArraySpread
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    local function supported()
        return type(window.RTCPeerConnection) == "function"
    end
    local function seq(____, n)
        local ____t_3 = __t
        local ____t_1 = __t
        local ____isSafeInteger_result_0 = __isSafeInteger(n)
        __O[2729] = ____isSafeInteger_result_0
        local ____temp_2 = if ____t_1(____isSafeInteger_result_0) then __ge(n, 0) else __O[2729]
        __O[2730] = ____temp_2
        return if ____t_3(____temp_2) then __le(n, 2147483647) else __O[2730]
    end
    local function nonce()
        local ____t_9 = __t
        local ____opt_6 = window.crypto
        local ____opt_4 = ____opt_6 and ____opt_6.randomUUID
        local ____temp_8 = ____opt_4 and ____opt_4(____opt_6)
        __O[2731] = ____temp_8
        return if ____t_9(____temp_8) then __O[2731] else __add(
            __add(
                __add(
                    "rtc_",
                    __call(
                        window.Date:now(),
                        "toString",
                        36
                    )
                ),
                "_"
            ),
            __call(
                __call(
                    math.random(),
                    "toString",
                    36
                ),
                "slice",
                2
            )
        )
    end
    local function validInput(self, value)
        local ____t_14 = __t
        local ____t_13 = __t
        local ____t_11 = __t
        local ____temp_10 = not __t(value) or type(value) ~= "table"
        __O[2732] = ____temp_10
        local ____temp_12 = if ____t_11(____temp_10) then __O[2732] else __isArray(value)
        __O[2733] = ____temp_12
        if ____t_14(if ____t_13(____temp_12) then __O[2733] else not __t(seq(nil, value.seq))) then
            return false
        end
        for ____, ____value in __iterar((__entries(value))) do
            local key = ____value[1]
            local item = ____value[2]
            if __t(key == "x" or key == "y") then
                local ____t_17 = __t
                local ____t_16 = __t
                local ____temp_15 = type(item) ~= "number" or not __isFiniteN(item)
                __O[2734] = ____temp_15
                if ____t_17(if ____t_16(____temp_15) then __O[2734] else math.abs(item) > 1) then
                    return false
                end
            elseif key == "response" then
                local ____t_22 = __t
                local ____t_21 = __t
                local ____t_19 = __t
                local ____temp_18 = type(item) ~= "number" or not __isFiniteN(item)
                __O[2735] = ____temp_18
                local ____temp_20 = if ____t_19(____temp_18) then __O[2735] else item < 0.5
                __O[2736] = ____temp_20
                if ____t_22(if ____t_21(____temp_20) then __O[2736] else item > 2) then
                    return false
                end
            elseif key == "jump" then
                if type(item) ~= "boolean" then
                    return false
                end
            elseif key == "aim" then
                local ____t_25 = __t
                local ____t_24 = __t
                local ____temp_23 = not __isInteger(item) or __lt(item, 0)
                __O[2737] = ____temp_23
                if ____t_25(if ____t_24(____temp_23) then __O[2737] else __gt(item, 4)) then
                    return false
                end
            elseif __t(not __t(__call(
                __arrL({
                    "seq",
                    "jumpPress",
                    "attack",
                    "special",
                    "ultimate",
                    "dash",
                    "emote"
                }, 7),
                "includes",
                key
            )) or not __t(seq(nil, item))) then
                return false
            end
        end
        return true
    end
    local function create(self, options)
        if options == nil then
            options = {}
        end
        local getStatus, status, api, insert, enqueue, drain, remove, flushLocalIce, ping, bindChannel, makePeer, offer, flushRemoteIce, accept, schedulePoll, poll, reconcile, close, myId, isHost, hostId, peers, retry, pendingIce, metrics, roster, closed, cursor, pollTimer, polling, pollSoon, sending, lastNegotiationAt, statusKey, queue, enabled, endpoint, safeCall, connected
        function getStatus(self)
            local list = __call(
                __arr(__TS__Spread(__iter(__call(peers, "values")))),
                "map",
                function(____, p) return {
                    id = p.id,
                    open = connected(nil, p),
                    connection = if __t(p.pc.connectionState) then p.pc.connectionState else "new",
                    stage = if __t(connected(nil, p)) then "open" else p.stage,
                    pingMs = if __isFiniteN(p.ping) then math.floor(p.ping + 0.5) else nil,
                    negotiationMs = math.floor(if __t(p.connectedAt) then p.connectedAt else window.performance:now() - p.createdAt + 0.5)
                } end
            )
            local count = __len(__call(
                list,
                "filter",
                function(____, p) return p.open end
            ))
            local total = if __t(isHost) then math.max(0, roster.size - 1) else if __t(__call(roster, "has", hostId)) then 1 else 0
            local pings = __call(
                __call(
                    list,
                    "filter",
                    function(____, p) return if __t(p.open) then p.pingMs ~= nil else p.open end
                ),
                "map",
                function(____, p) return p.pingMs end
            )
            return {
                supported = enabled,
                connected = count,
                directPeers = count,
                total = total,
                status = if count > 0 then "realtime" else "relay",
                pingMs = if __t(__len(pings)) then math.max(__TS__Spread(__iter(pings))) else nil,
                handshakeRequests = metrics.signals,
                iceBatches = metrics.batches,
                signalingPolls = metrics.polls,
                pendingSignals = __len(queue) + if __t(sending) then 1 else 0,
                peers = list
            }
        end
        function status(self)
            local value = getStatus(nil)
            local key = window.JSON:stringify(value)
            if key ~= statusKey then
                statusKey = key
                safeCall(nil, "onStatus", value)
            end
        end
        function api(self, body)
            return __TS__AsyncAwaiter(function(____awaiter_resolve)
                local response = __TS__Await(options:request(endpoint, {body = body}))
                local ____opt_result_40
                if response ~= nil then
                    ____opt_result_40 = response.json
                end
                local data = if type(____opt_result_40) == "function" then __TS__Await(response:json()) else response
                local ____t_53 = __t
                local ____t_49 = __t
                local ____opt_result_43
                if response ~= nil then
                    ____opt_result_43 = response.ok
                end
                local ____temp_48 = ____opt_result_43 == false
                if not ____temp_48 then
                    local ____ge_47 = __ge
                    local ____opt_result_46
                    if response ~= nil then
                        ____opt_result_46 = response.status
                    end
                    ____temp_48 = ____ge_47(____opt_result_46, 400)
                end
                __O[2742] = ____temp_48
                local ____opt_result_52
                if data ~= nil then
                    ____opt_result_52 = data.error
                end
                if ____t_53(if ____t_49(____temp_48) then __O[2742] else ____opt_result_52) then
                    local ____Error_57 = Error
                    local ____opt_result_56
                    if data ~= nil then
                        ____opt_result_56 = data.error
                    end
                    local ____error = __TS__New(____Error_57, if type(____opt_result_56) == "string" then data.error else "Conexão direta indisponível.")
                    local ____opt_result_60
                    if response ~= nil then
                        ____opt_result_60 = response.status
                    end
                    ____error.status = ____opt_result_60
                    error(____error, 0)
                end
                return ____awaiter_resolve(nil, data)
            end)
        end
        function insert(self, item)
            if __t(item.kind == "offer" or item.kind == "answer") then
                local at = __call(
                    queue,
                    "findIndex",
                    function(____, q) return q.kind ~= "offer" and q.kind ~= "answer" end
                )
                __call(
                    queue,
                    "splice",
                    if at < 0 then __len(queue) else at,
                    0,
                    item
                )
            else
                __call(queue, "push", item)
            end
        end
        function enqueue(self, to, kind, data)
            if __t(if __t(closed) then closed else __len(queue) >= 80) then
                return
            end
            insert(
                nil,
                {
                    op = "send",
                    to = to,
                    kind = kind,
                    data = data,
                    nonce = nonce(nil),
                    attempts = 0
                }
            )
            drain(nil)
        end
        function drain(self)
            return __TS__AsyncAwaiter(function(____awaiter_resolve)
                if __t(if __t(sending) then sending else closed) then
                    return ____awaiter_resolve(nil)
                end
                sending = true
                local ____try = __TS__AsyncAwaiter(function()
                    while __t(if __t(__len(queue)) then not __t(closed) else __len(queue)) do
                        local item = __call(queue, "shift")
                        local ____hasContinued
                        local ____try = __TS__AsyncAwaiter(function()
                            metrics.signals = metrics.signals + 1
                            if item.kind == "ice-batch" then
                                metrics.batches = metrics.batches + 1
                            elseif __t(item.kind == "offer" or item.kind == "answer") then
                                metrics.descriptions = metrics.descriptions + 1
                            end
                            __TS__Await(api(nil, item))
                        end)
                        ____try = ____try.catch(
                            ____try,
                            function(____, ____error)
                                return __TS__AsyncAwaiter(function()
                                    local ____t_66 = __t
                                    local ____t_62 = __t
                                    local ____call_result_61 = __call(
                                        __arrL({401, 403, 404, 410}, 4),
                                        "includes",
                                        ____error.status
                                    )
                                    __O[2743] = ____call_result_61
                                    local ____item_63, ____attempts_64 = item, "attempts"
                                    local ____item_attempts_65 = ____item_63[____attempts_64] + 1
                                    ____item_63[____attempts_64] = ____item_attempts_65
                                    if ____t_66(if ____t_62(____call_result_61) then __O[2743] else ____item_attempts_65 >= 3) then
                                        status(nil)
                                        ____hasContinued = true
                                        return
                                    end
                                    __TS__Await(__TS__New(
                                        __TS__Promise,
                                        function(____, resolve) return window:setTimeout(resolve, if ____error.status == 429 then 1100 else 400 * item.attempts) end
                                    ))
                                    if not __t(closed) then
                                        insert(nil, item)
                                    end
                                end)
                            end
                        )
                        __TS__Await(____try)
                        if ____hasContinued then
                            continue
                        end
                    end
                end)
                ____try = ____try.finally(
                    ____try,
                    function()
                        return __TS__AsyncAwaiter(function()
                            sending = false
                            status(nil)
                        end)
                    end
                )
                __TS__Await(____try)
            end)
        end
        function remove(self, id, again)
            if again == nil then
                again = false
            end
            local peer = __call(peers, "get", id)
            if __t(peer) then
                __call(peers, "delete", id)
                __call(
                    pendingIce,
                    "delete",
                    __add(
                        __add(id, "|"),
                        peer.session
                    )
                )
                window:clearTimeout(peer.iceTimer)
                window:clearTimeout(peer.pingTimer)
                queue = __call(
                    queue,
                    "filter",
                    function(____, q)
                        local ____temp_69 = q.to ~= id
                        if not ____temp_69 then
                            local ____opt_67 = q.data
                            if ____opt_67 ~= nil then
                                ____opt_67 = ____opt_67.session
                            end
                            ____temp_69 = ____opt_67 ~= peer.session
                        end
                        return ____temp_69
                    end
                )
                do
                    pcall(function()
                        local ____opt_70 = peer.channel
                        if ____opt_70 ~= nil then
                            ____opt_70:close()
                        end
                        peer.pc:close()
                    end)
                end
            end
            if __t(again) then
                local ____t_73 = __t
                local ____call_result_72 = __call(retry, "get", id)
                __O[2744] = ____call_result_72
                local old = if ____t_73(____call_result_72) then __O[2744] else {tries = 0}
                __call(
                    retry,
                    "set",
                    id,
                    {
                        tries = old.tries,
                        nextAt = window.performance:now() + math.min(
                            15000,
                            2500 * math.max(1, old.tries)
                        )
                    }
                )
            end
            status(nil)
        end
        function flushLocalIce(self, peer)
            window:clearTimeout(peer.iceTimer)
            peer.iceTimer = 0
            local ____t_76 = __t
            local ____t_75 = __t
            local ____temp_74 = if __t(closed) then closed else __call(peers, "get", peer.id) ~= peer
            __O[2745] = ____temp_74
            if ____t_76(if ____t_75(____temp_74) then __O[2745] else not __t(peer.descriptionQueued)) then
                return
            end
            while __t(__len(peer.outgoingIce)) do
                local candidates = __arrL({}, 0)
                while __t(if __t(__len(peer.outgoingIce)) then __len(candidates) < 16 else __len(peer.outgoingIce)) do
                    local value = __get(peer.outgoingIce, 0)
                    local ____t_82 = __t
                    local ____len_81 = __len
                    local ____self_79 = window.JSON
                    local ____self_79_stringify_80 = ____self_79.stringify
                    local ____arr_78 = __arr
                    local ____array_77 = __TS__SparseArrayNew(__TS__Spread(__iter(candidates)))
                    __TS__SparseArrayPush(____array_77, value)
                    if ____t_82(if __t(__len(candidates)) then ____len_81(____self_79_stringify_80(
                        ____self_79,
                        ____arr_78(__TS__SparseArraySpread(____array_77))
                    )) > 22000 else __len(candidates)) then
                        break
                    end
                    __call(
                        candidates,
                        "push",
                        __call(peer.outgoingIce, "shift")
                    )
                end
                enqueue(nil, peer.id, "ice-batch", {session = peer.session, candidates = candidates})
            end
        end
        function ping(self, peer)
            window:clearTimeout(peer.pingTimer)
            if __t(if __t(closed) then closed else __call(peers, "get", peer.id) ~= peer) then
                return
            end
            if __t(connected(nil, peer)) then
                local ____peer_83, ____pingSeq_84 = peer, "pingSeq"
                local ____peer_pingSeq_85 = ____peer_83[____pingSeq_84] + 1
                ____peer_83[____pingSeq_84] = ____peer_pingSeq_85
                local n = ____peer_pingSeq_85
                local t = window.performance:now()
                peer.pendingPing = {n = n, t = t}
                do
                    pcall(function()
                        peer.channel:send(window.JSON:stringify({v = 1, kind = "ping", n = n, t = t}))
                    end)
                end
            end
            peer.pingTimer = window:setTimeout(
                function() return ping(nil, peer) end,
                3000
            )
        end
        function bindChannel(self, peer, channel)
            if channel.label ~= "roca-arena-v1" then
                channel:close()
                return
            end
            peer.channel = channel
            channel.onopen = function()
                if __t(closed) then
                    return
                end
                peer.connectedAt = window.performance:now()
                ping(nil, peer)
                status(nil)
            end
            channel.onclose = function() return status(nil) end
            channel.onerror = function() return status(nil) end
            channel.onmessage = function(____, event)
                local ____t_92 = __t
                local ____t_91 = __t
                local ____t_89 = __t
                local ____t_87 = __t
                local ____temp_86 = if __t(closed) then closed else __call(peers, "get", peer.id) ~= peer
                __O[2746] = ____temp_86
                local ____temp_88 = if ____t_87(____temp_86) then __O[2746] else not __t(__call(roster, "has", peer.id))
                __O[2747] = ____temp_88
                local ____temp_90 = if ____t_89(____temp_88) then __O[2747] else type(event.data) ~= "string"
                __O[2748] = ____temp_90
                if ____t_92(if ____t_91(____temp_90) then __O[2748] else __gt(
                    __len(event.data),
                    32768
                )) then
                    return
                end
                local packet
                do
                    local function ____catch()
                        return true
                    end
                    local ____try, ____hasReturned, ____returnValue = pcall(function()
                        packet = window.JSON:parse(event.data)
                    end)
                    if not ____try then
                        ____hasReturned, ____returnValue = ____catch()
                    end
                    if ____hasReturned then
                        return ____returnValue
                    end
                end
                local ____opt_result_95
                if packet ~= nil then
                    ____opt_result_95 = packet.v
                end
                if ____opt_result_95 ~= 1 then
                    return
                end
                local ____t_100 = __t
                local ____t_99 = __t
                local ____t_97 = __t
                local ____temp_96 = packet.kind == "ping"
                __O[2749] = ____temp_96
                local ____temp_98 = if ____t_97(____temp_96) then seq(nil, packet.n) else __O[2749]
                __O[2750] = ____temp_98
                if ____t_100(if ____t_99(____temp_98) then __isFiniteN(packet.t) else __O[2750]) then
                    do
                        pcall(function()
                            channel:send(window.JSON:stringify({v = 1, kind = "pong", n = packet.n, t = packet.t}))
                        end)
                    end
                    return
                end
                if packet.kind == "pong" then
                    local sent = peer.pendingPing
                    local ____t_103 = __t
                    local ____t_102 = __t
                    local ____temp_101 = if __t(sent) then packet.n == sent.n else sent
                    __O[2751] = ____temp_101
                    if ____t_103(if ____t_102(____temp_101) then packet.t == sent.t else __O[2751]) then
                        local elapsed = window.performance:now() - sent.t
                        if __t(elapsed >= 0 and elapsed < 10000) then
                            peer.ping = if __isFiniteN(peer.ping) then peer.ping * 0.7 + elapsed * 0.3 else elapsed
                            peer.pendingPing = nil
                            status(nil)
                        end
                    end
                    return
                end
                if __t(not __t(packet.value) or type(packet.value) ~= "table") then
                    return
                end
                local ____t_108 = __t
                local ____t_107 = __t
                local ____t_105 = __t
                local ____temp_104 = if __t(isHost) then packet.kind == "input" else isHost
                __O[2752] = ____temp_104
                local ____temp_106 = if ____t_105(____temp_104) then validInput(nil, packet.value) else __O[2752]
                __O[2753] = ____temp_106
                if ____t_108(if ____t_107(____temp_106) then __gt(packet.value.seq, peer.inputSeq) else __O[2753]) then
                    peer.inputSeq = packet.value.seq
                    safeCall(nil, "onInput", peer.id, packet.value)
                else
                    local ____t_115 = __t
                    local ____t_114 = __t
                    local ____t_112 = __t
                    local ____t_110 = __t
                    local ____temp_109 = not __t(isHost) and peer.id == hostId
                    __O[2754] = ____temp_109
                    local ____temp_111 = if ____t_110(____temp_109) then packet.kind == "state" else __O[2754]
                    __O[2755] = ____temp_111
                    local ____temp_113 = if ____t_112(____temp_111) then seq(nil, packet.value.seq) else __O[2755]
                    __O[2756] = ____temp_113
                    if ____t_115(if ____t_114(____temp_113) then __gt(packet.value.seq, peer.stateSeq) else __O[2756]) then
                        peer.stateSeq = packet.value.seq
                        safeCall(nil, "onState", packet.value)
                    end
                end
            end
        end
        function makePeer(self, id, session)
            lastNegotiationAt = window.performance:now()
            local pc = __newExpr(
                window.RTCPeerConnection,
                {
                    iceServers = __arrL({{urls = "stun:stun.cloudflare.com:3478"}, {urls = "stun:stun.l.google.com:19302"}}, 2),
                    iceCandidatePoolSize = 0
                }
            )
            local peer = {
                id = id,
                pc = pc,
                session = session,
                stage = if __t(isHost) then "creating-offer" else "answering",
                descriptionQueued = false,
                channel = nil,
                inputSeq = -1,
                stateSeq = -1,
                ice = __arrL({}, 0),
                outgoingIce = __arrL({}, 0),
                candidateKeys = __TS__New(Set),
                iceTimer = 0,
                pingTimer = 0,
                pingSeq = 0,
                pendingPing = nil,
                ping = nil,
                createdAt = window.performance:now(),
                connectedAt = nil
            }
            __call(peers, "set", id, peer)
            pc.onicecandidate = function(____, event)
                if not __t(event.candidate) then
                    flushLocalIce(nil, peer)
                    return
                end
                local ____t_118 = __t
                local ____t_117 = __t
                local ____temp_116 = if __t(closed) then closed else __call(peers, "get", id) ~= peer
                __O[2757] = ____temp_116
                if ____t_118(if ____t_117(____temp_116) then __O[2757] else peer.candidateKeys.size >= 48) then
                    return
                end
                local value = if type(event.candidate.toJSON) == "function" then event.candidate:toJSON() else event.candidate
                local key = __add(
                    __add(
                        __add(
                            __add(value.candidate, "|"),
                            value.sdpMid
                        ),
                        "|"
                    ),
                    value.sdpMLineIndex
                )
                if __t(__call(peer.candidateKeys, "has", key)) then
                    return
                end
                __call(peer.candidateKeys, "add", key)
                local ____call_123 = __call
                local ____peer_outgoingIce_122 = peer.outgoingIce
                local ____value_candidate_121 = value.candidate
                local ____value_sdpMid_119 = value.sdpMid
                if ____value_sdpMid_119 == nil then
                    ____value_sdpMid_119 = nil
                end
                local ____value_sdpMLineIndex_120 = value.sdpMLineIndex
                if ____value_sdpMLineIndex_120 == nil then
                    ____value_sdpMLineIndex_120 = nil
                end
                ____call_123(____peer_outgoingIce_122, "push", {candidate = ____value_candidate_121, sdpMid = ____value_sdpMid_119, sdpMLineIndex = ____value_sdpMLineIndex_120})
                if __len(peer.outgoingIce) >= 16 then
                    flushLocalIce(nil, peer)
                elseif not __t(peer.iceTimer) then
                    peer.iceTimer = window:setTimeout(
                        function() return flushLocalIce(nil, peer) end,
                        120
                    )
                end
            end
            pc.onicegatheringstatechange = function()
                if pc.iceGatheringState == "complete" then
                    flushLocalIce(nil, peer)
                end
            end
            pc.onconnectionstatechange = function()
                if __t(if __t(closed) then closed else __call(peers, "get", id) ~= peer) then
                    return
                end
                if __t(pc.connectionState == "failed" or pc.connectionState == "closed") then
                    remove(nil, id, isHost)
                else
                    status(nil)
                end
            end
            if __t(isHost) then
                bindChannel(
                    nil,
                    peer,
                    pc:createDataChannel("roca-arena-v1", {ordered = false, maxRetransmits = 0})
                )
            else
                pc.ondatachannel = function(____, event) return bindChannel(nil, peer, event.channel) end
            end
            status(nil)
            return peer
        end
        function offer(self, id)
            return __TS__AsyncAwaiter(function(____awaiter_resolve)
                local ____t_126 = __t
                local ____t_125 = __t
                local ____temp_124 = if __t(closed) then closed else __call(peers, "has", id)
                __O[2758] = ____temp_124
                if ____t_126(if ____t_125(____temp_124) then __O[2758] else not __t(__call(roster, "has", id))) then
                    return ____awaiter_resolve(nil)
                end
                local ____t_128 = __t
                local ____call_result_127 = __call(retry, "get", id)
                __O[2759] = ____call_result_127
                local history = if ____t_128(____call_result_127) then __O[2759] else {tries = 0, nextAt = 0}
                if __t(__ge(history.tries, 4) or __gt(
                    history.nextAt,
                    window.performance:now()
                )) then
                    return ____awaiter_resolve(nil)
                end
                __call(
                    retry,
                    "set",
                    id,
                    {
                        tries = history.tries + 1,
                        nextAt = window.performance:now() + 3000
                    }
                )
                local peer
                local ____try = __TS__AsyncAwaiter(function()
                    peer = makePeer(
                        nil,
                        id,
                        nonce(nil)
                    )
                    local description = __TS__Await(peer.pc:createOffer())
                    __TS__Await(peer.pc:setLocalDescription(description))
                    if __t(not __t(closed) and __call(peers, "get", id) == peer) then
                        peer.descriptionQueued = true
                        peer.stage = "awaiting-answer"
                        enqueue(nil, id, "offer", {type = "offer", sdp = peer.pc.localDescription.sdp, session = peer.session})
                        flushLocalIce(nil, peer)
                    end
                end)
                ____try = ____try.catch(
                    ____try,
                    function(____)
                        return __TS__AsyncAwaiter(function()
                            if __t(if __t(peer) then __call(peers, "get", id) == peer else peer) then
                                remove(nil, id, true)
                            end
                        end)
                    end
                )
                __TS__Await(____try)
            end)
        end
        function flushRemoteIce(self, peer)
            return __TS__AsyncAwaiter(function(____awaiter_resolve)
                local key = __add(
                    __add(peer.id, "|"),
                    peer.session
                )
                local ____arr_133 = __arr
                local ____iter_131 = __iter
                local ____t_130 = __t
                local ____call_result_129 = __call(pendingIce, "get", key)
                __O[2760] = ____call_result_129
                local ____array_132 = __TS__SparseArrayNew(__TS__Spread(____iter_131(if ____t_130(____call_result_129) then __O[2760] else __arrL({}, 0))))
                __TS__SparseArrayPush(
                    ____array_132,
                    __TS__Spread(__iter(peer.ice))
                )
                local candidates = ____arr_133(__TS__SparseArraySpread(____array_132))
                __call(pendingIce, "delete", key)
                peer.ice = __arrL({}, 0)
                for ____, value in __iterar((candidates)) do
                    local ____try = __TS__AsyncAwaiter(function()
                        __TS__Await(peer.pc:addIceCandidate(value))
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
            end)
        end
        function accept(self, item)
            return __TS__AsyncAwaiter(function(____awaiter_resolve)
                local ____t_145 = __t
                local ____t_144 = __t
                local ____t_142 = __t
                local ____t_140 = __t
                local ____t_138 = __t
                local ____opt_result_136
                if item ~= nil then
                    ____opt_result_136 = item.to
                end
                local ____temp_137 = if __t(closed) then closed else ____opt_result_136 ~= myId
                __O[2761] = ____temp_137
                local ____temp_139 = if ____t_138(____temp_137) then __O[2761] else not __t(__call(roster, "has", item.from))
                __O[2762] = ____temp_139
                local ____temp_141 = if ____t_140(____temp_139) then __O[2762] else item.from == myId
                __O[2763] = ____temp_141
                local ____temp_143 = if ____t_142(____temp_141) then __O[2763] else not __t(item.data)
                __O[2764] = ____temp_143
                if ____t_145(if ____t_144(____temp_143) then __O[2764] else type(item.data.session) ~= "string") then
                    return ____awaiter_resolve(nil)
                end
                local ____t_148 = __t
                local ____t_147 = __t
                local ____temp_146 = if __t(isHost) then item.from == hostId else isHost
                __O[2765] = ____temp_146
                if ____t_148(if ____t_147(____temp_146) then __O[2765] else not __t(isHost) and item.from ~= hostId) then
                    return ____awaiter_resolve(nil)
                end
                local data = item.data
                local peer = __call(peers, "get", item.from)
                if item.kind == "offer" then
                    if __t(isHost) then
                        return ____awaiter_resolve(nil)
                    end
                    local ____t_154 = __t
                    local ____t_153 = __t
                    local ____opt_result_151
                    if peer ~= nil then
                        ____opt_result_151 = peer.session
                    end
                    local ____temp_152 = ____opt_result_151 == data.session
                    __O[2766] = ____temp_152
                    if ____t_154(if ____t_153(____temp_152) then peer.pc.remoteDescription else __O[2766]) then
                        return ____awaiter_resolve(nil)
                    end
                    if __t(peer) then
                        remove(nil, item.from)
                    end
                    local ____hasReturned, ____returnValue
                    local ____try = __TS__AsyncAwaiter(function()
                        peer = makePeer(nil, item.from, data.session)
                        __TS__Await(peer.pc:setRemoteDescription({type = "offer", sdp = data.sdp}))
                        __TS__Await(flushRemoteIce(nil, peer))
                        local answer = __TS__Await(peer.pc:createAnswer())
                        __TS__Await(peer.pc:setLocalDescription(answer))
                        if __t(if __t(closed) then closed else __call(peers, "get", item.from) ~= peer) then
                            ____hasReturned = true
                            return
                        end
                        peer.descriptionQueued = true
                        peer.stage = "connecting"
                        enqueue(nil, item.from, "answer", {type = "answer", sdp = peer.pc.localDescription.sdp, session = peer.session})
                        flushLocalIce(nil, peer)
                    end)
                    ____try = ____try.catch(
                        ____try,
                        function(____)
                            return __TS__AsyncAwaiter(function()
                                if __t(peer) then
                                    remove(nil, item.from)
                                end
                            end)
                        end
                    )
                    __TS__Await(____try)
                    if ____hasReturned then
                        return ____awaiter_resolve(nil, ____returnValue)
                    end
                    return ____awaiter_resolve(nil)
                end
                if item.kind == "answer" then
                    local ____t_159 = __t
                    local ____t_158 = __t
                    local ____t_156 = __t
                    local ____temp_155 = not __t(isHost) or not __t(peer)
                    __O[2767] = ____temp_155
                    local ____temp_157 = if ____t_156(____temp_155) then __O[2767] else peer.session ~= data.session
                    __O[2768] = ____temp_157
                    if ____t_159(if ____t_158(____temp_157) then __O[2768] else peer.pc.remoteDescription) then
                        return ____awaiter_resolve(nil)
                    end
                    local ____try = __TS__AsyncAwaiter(function()
                        __TS__Await(peer.pc:setRemoteDescription({type = "answer", sdp = data.sdp}))
                        peer.stage = "connecting"
                        __TS__Await(flushRemoteIce(nil, peer))
                    end)
                    ____try = ____try.catch(
                        ____try,
                        function(____)
                            return __TS__AsyncAwaiter(function()
                                remove(nil, item.from, true)
                            end)
                        end
                    )
                    __TS__Await(____try)
                    return ____awaiter_resolve(nil)
                end
                if __t(item.kind == "ice" or item.kind == "ice-batch") then
                    local candidates = if item.kind == "ice-batch" then data.candidates else __arrL({data}, 1)
                    if __t(not __isArray(candidates) or __len(candidates) > 16) then
                        return ____awaiter_resolve(nil)
                    end
                    for ____, c in __iterar((candidates)) do
                        local ____t_162 = __t
                        local ____t_161 = __t
                        local ____temp_160 = not __t(c) or type(c.candidate) ~= "string"
                        __O[2769] = ____temp_160
                        if ____t_162(if ____t_161(____temp_160) then __O[2769] else __gt(
                            __len(c.candidate),
                            2048
                        )) then
                            continue
                        end
                        local ____c_candidate_165 = c.candidate
                        local ____c_sdpMid_163 = c.sdpMid
                        if ____c_sdpMid_163 == nil then
                            ____c_sdpMid_163 = nil
                        end
                        local ____c_sdpMLineIndex_164 = c.sdpMLineIndex
                        if ____c_sdpMLineIndex_164 == nil then
                            ____c_sdpMLineIndex_164 = nil
                        end
                        local candidate = {candidate = ____c_candidate_165, sdpMid = ____c_sdpMid_163, sdpMLineIndex = ____c_sdpMLineIndex_164}
                        if __t(if __t(peer) then peer.session == data.session else peer) then
                            if __t(peer.pc.remoteDescription) then
                                local ____try = __TS__AsyncAwaiter(function()
                                    __TS__Await(peer.pc:addIceCandidate(candidate))
                                end)
                                ____try = ____try.catch(
                                    ____try,
                                    function(____)
                                        return __TS__AsyncAwaiter(function()
                                        end)
                                    end
                                )
                                __TS__Await(____try)
                            elseif __lt(
                                __len(peer.ice),
                                48
                            ) then
                                __call(peer.ice, "push", candidate)
                            end
                        else
                            if __t(isHost) then
                                continue
                            end
                            local key = __add(
                                __add(item.from, "|"),
                                data.session
                            )
                            if __t(pendingIce.size >= 12 and not __t(__call(pendingIce, "has", key))) then
                                continue
                            end
                            local ____t_167 = __t
                            local ____call_result_166 = __call(pendingIce, "get", key)
                            __O[2770] = ____call_result_166
                            local list = if ____t_167(____call_result_166) then __O[2770] else __arrL({}, 0)
                            if __lt(
                                __len(list),
                                48
                            ) then
                                __call(list, "push", candidate)
                                __call(pendingIce, "set", key, list)
                            end
                        end
                    end
                end
            end)
        end
        function schedulePoll(self, delay)
            window:clearTimeout(pollTimer)
            if __t(if __t(closed) then closed else not __t(enabled)) then
                return
            end
            if __t(polling) then
                pollSoon = true
                return
            end
            pollTimer = window:setTimeout(
                poll,
                math.max(0, delay)
            )
        end
        function poll(self)
            return __TS__AsyncAwaiter(function(____awaiter_resolve)
                local ____t_170 = __t
                local ____t_169 = __t
                local ____temp_168 = if __t(closed) then closed else not __t(enabled)
                __O[2771] = ____temp_168
                if ____t_170(if ____t_169(____temp_168) then __O[2771] else polling) then
                    return ____awaiter_resolve(nil)
                end
                polling = true
                pollSoon = false
                local started = window.performance:now()
                metrics.polls = metrics.polls + 1
                local ____hasReturned, ____returnValue
                local ____try = __TS__AsyncAwaiter(function()
                    local data = __TS__Await(api(nil, {op = "poll", after = cursor}))
                    if __t(closed) then
                        ____hasReturned = true
                        return
                    end
                    for ____, item in __iterar((if __t(data.signals) then data.signals else __arrL({}, 0))) do
                        local ____try = __TS__AsyncAwaiter(function()
                            __TS__Await(accept(nil, item))
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
                    local ____t_173 = __t
                    local ____t_172 = __t
                    local ____isSafeInteger_result_171 = __isSafeInteger(data.cursor)
                    __O[2772] = ____isSafeInteger_result_171
                    if ____t_173(if ____t_172(____isSafeInteger_result_171) then __ge(data.cursor, cursor) else __O[2772]) then
                        cursor = data.cursor
                    end
                end)
                ____try = ____try.catch(
                    ____try,
                    function(____, ____error)
                        return __TS__AsyncAwaiter(function()
                            if __t(__call(
                                __arrL({401, 403, 404, 410}, 4),
                                "includes",
                                ____error.status
                            )) then
                                close(nil)
                                ____hasReturned = true
                                return
                            end
                            status(nil)
                        end)
                    end
                )
                ____try = ____try.finally(
                    ____try,
                    function()
                        return __TS__AsyncAwaiter(function()
                            polling = false
                            if not __t(closed) then
                                reconcile(nil)
                                local value = getStatus(nil)
                                local ____t_175 = __t
                                local ____temp_174 = value.total == 0 or value.connected == value.total
                                __O[2773] = ____temp_174
                                local idle = if ____t_175(____temp_174) then __O[2773] else window.performance:now() - lastNegotiationAt > 25000
                                schedulePoll(nil, if __t(pollSoon) then 0 else math.max(
                                    0,
                                    if __t(idle) then 3000 else 250 - (window.performance:now() - started)
                                ))
                            end
                        end)
                    end
                )
                __TS__Await(____try)
                if ____hasReturned then
                    return ____awaiter_resolve(nil, ____returnValue)
                end
            end)
        end
        function reconcile(self)
            if __t(if __t(closed) then closed else not __t(enabled)) then
                return
            end
            for ____, ____value in __iterar((peers)) do
                local id = ____value[1]
                local peer = ____value[2]
                local ____t_178 = __t
                local ____t_177 = __t
                local ____temp_176 = not __t(__call(roster, "has", id))
                __O[2774] = ____temp_176
                if ____t_178(if ____t_177(____temp_176) then __O[2774] else not __t(isHost) and id ~= hostId) then
                    remove(nil, id)
                elseif __t(not __t(connected(nil, peer)) and window.performance:now() - peer.createdAt > 25000) then
                    remove(nil, id, isHost)
                end
            end
            if __t(isHost) then
                for ____, id in __iterar((roster)) do
                    if __t(id ~= myId and not __t(__call(peers, "has", id))) then
                        offer(nil, id)
                    end
                end
            end
            status(nil)
        end
        function close(self)
            if __t(closed) then
                return
            end
            closed = true
            window:clearTimeout(pollTimer)
            queue = __arrL({}, 0)
            for ____, id in __iterar((__arr(__TS__Spread(__iter(__call(peers, "keys")))))) do
                remove(nil, id)
            end
            __call(pendingIce, "clear")
            status(nil)
        end
        local code = if __t(options.code) then options.code else options.roomCode
        myId = options.playerId
        isHost = not not __t(options.isHost)
        hostId = if __t(isHost) then myId else options.hostPlayerId
        peers = __TS__New(Map)
        retry = __TS__New(Map)
        pendingIce = __TS__New(Map)
        metrics = {signals = 0, batches = 0, polls = 0, descriptions = 0}
        roster = __TS__New(Set)
        closed = false
        cursor = 0
        pollTimer = 0
        polling = false
        pollSoon = false
        sending = false
        local lastInputAt = 0
        local lastStateAt = 0
        lastNegotiationAt = window.performance:now()
        statusKey = ""
        queue = __arrL({}, 0)
        local ____t_33 = __t
        local ____t_31 = __t
        local ____t_29 = __t
        local ____t_27 = __t
        local ____supported_result_26 = supported(nil)
        __O[2738] = ____supported_result_26
        local ____temp_28 = if ____t_27(____supported_result_26) then __re_test(
            __re("^[A-Z0-9]{6}$", ""),
            if __t(code) then code else ""
        ) else __O[2738]
        __O[2739] = ____temp_28
        local ____temp_30 = if ____t_29(____temp_28) then type(myId) == "string" else __O[2739]
        __O[2740] = ____temp_30
        local ____temp_32 = if ____t_31(____temp_30) then type(hostId) == "string" else __O[2740]
        __O[2741] = ____temp_32
        enabled = if ____t_33(____temp_32) then type(options.request) == "function" else __O[2741]
        endpoint = __add(
            __add("/api/arena/rooms/", code),
            "/signal"
        )
        safeCall = function(____, name, ...)
            local args = {...}
            do
                pcall(function()
                    local ____opt_34 = __get(options, name)
                    if ____opt_34 ~= nil then
                        ____opt_34(
                            nil,
                            __TS__Spread(__iter(args))
                        )
                    end
                end)
            end
        end
        connected = function(____, peer)
            local ____opt_36 = peer.channel
            if ____opt_36 ~= nil then
                ____opt_36 = ____opt_36.readyState
            end
            return ____opt_36 == "open" and not __t(__call(
                __arrL({"failed", "closed", "disconnected"}, 3),
                "includes",
                peer.pc.connectionState
            ))
        end
        local function updateRoster(self, players)
            local previous = __call(
                __call(
                    __arr(__TS__Spread(__iter(roster))),
                    "sort"
                ),
                "join",
                "|"
            )
            roster = __TS__New(
                Set,
                __call(
                    __call(
                        if __isArray(players) then players else __arrL({}, 0),
                        "map",
                        function(____, p)
                            local ____opt_result_181
                            if p ~= nil then
                                ____opt_result_181 = p.id
                            end
                            return if type(p) == "string" then p else ____opt_result_181
                        end
                    ),
                    "filter",
                    function(____, id) return type(id) == "string" end
                )
            )
            __call(roster, "add", myId)
            local changed = __call(
                __call(
                    __arr(__TS__Spread(__iter(roster))),
                    "sort"
                ),
                "join",
                "|"
            ) ~= previous
            if __t(changed) then
                lastNegotiationAt = window.performance:now()
            end
            for ____, key in __iterar((__call(pendingIce, "keys"))) do
                if not __t(__call(
                    roster,
                    "has",
                    __get(
                        __call(key, "split", "|"),
                        0
                    )
                )) then
                    __call(pendingIce, "delete", key)
                end
            end
            for ____, id in __iterar((__call(retry, "keys"))) do
                if not __t(__call(roster, "has", id)) then
                    __call(retry, "delete", id)
                end
            end
            reconcile(nil)
            if __t(changed) then
                schedulePoll(nil, 0)
            end
        end
        local function transmit(self, kind, value)
            local ____t_188 = __t
            local ____t_187 = __t
            local ____t_185 = __t
            local ____t_183 = __t
            local ____temp_182 = if __t(closed) then closed else not __t(enabled)
            __O[2775] = ____temp_182
            local ____temp_184 = if ____t_183(____temp_182) then __O[2775] else not __t(value)
            __O[2776] = ____temp_184
            local ____temp_186 = if ____t_185(____temp_184) then __O[2776] else not __t(seq(nil, value.seq))
            __O[2777] = ____temp_186
            if ____t_188(if ____t_187(____temp_186) then __O[2777] else kind == "input" and not __t(validInput(nil, value))) then
                return false
            end
            local data
            do
                local function ____catch()
                    return true, false
                end
                local ____try, ____hasReturned, ____returnValue = pcall(function()
                    data = window.JSON:stringify({v = 1, kind = kind, value = value})
                end)
                if not ____try then
                    ____hasReturned, ____returnValue = ____catch()
                end
                if ____hasReturned then
                    return ____returnValue
                end
            end
            if __len(data) > 32768 then
                return false
            end
            local sent = false
            for ____, peer in __iterar((__call(peers, "values"))) do
                local ____t_191 = __t
                local ____t_190 = __t
                local ____connected_result_189 = connected(nil, peer)
                __O[2778] = ____connected_result_189
                if ____t_191(if ____t_190(____connected_result_189) then __lt(peer.channel.bufferedAmount, 65536) else __O[2778]) then
                    do
                        pcall(function()
                            peer.channel:send(data)
                            sent = true
                        end)
                    end
                end
            end
            return sent
        end
        local function sendInput(self, value)
            if __t(isHost) then
                return false
            end
            local now = window.performance:now()
            if now - lastInputAt < 1000 / 30 then
                return false
            end
            lastInputAt = now
            return transmit(nil, "input", value)
        end
        local function sendState(self, value)
            if not __t(isHost) then
                return false
            end
            local now = window.performance:now()
            if now - lastStateAt < 1000 / 30 then
                return false
            end
            lastStateAt = now
            return transmit(nil, "state", value)
        end
        if __t(enabled) then
            updateRoster(nil, if __t(options.players) then options.players else __arrL({}, 0))
            schedulePoll(nil, 0)
        else
            status(nil)
        end
        return {
            updateRoster = updateRoster,
            sendInput = sendInput,
            sendState = sendState,
            close = close,
            getStatus = getStatus
        }
    end
    window.ArenaNet = __ord({create = create, supported = supported}, "create,supported")
end)(nil)
return ____exports
