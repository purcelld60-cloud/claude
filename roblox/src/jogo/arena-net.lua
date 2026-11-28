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
        local ____t_result_4
        local ____t_3 = __t
        local ____t_result_2
        local ____t_1 = __t
        local ____isSafeInteger_result_0 = __isSafeInteger(n)
        __O[2748] = ____isSafeInteger_result_0
        if ____t_1(____isSafeInteger_result_0) then
            ____t_result_2 = __ge(n, 0)
        else
            ____t_result_2 = __O[2748]
        end
        __O[2749] = ____t_result_2
        if ____t_3(____t_result_2) then
            ____t_result_4 = __le(n, 2147483647)
        else
            ____t_result_4 = __O[2749]
        end
        return ____t_result_4
    end
    local function nonce()
        local ____t_result_11
        local ____t_10 = __t
        local ____opt_7 = window.crypto
        local ____opt_5 = ____opt_7 and ____opt_7.randomUUID
        local ____temp_9 = ____opt_5 and ____opt_5(____opt_7)
        __O[2750] = ____temp_9
        if ____t_10(____temp_9) then
            ____t_result_11 = __O[2750]
        else
            ____t_result_11 = __add(
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
        return ____t_result_11
    end
    local function validInput(self, value)
        local ____t_17 = __t
        local ____t_result_16
        local ____t_15 = __t
        local ____t_result_14
        local ____t_13 = __t
        local ____temp_12 = not __t(value) or type(value) ~= "table"
        __O[2751] = ____temp_12
        if ____t_13(____temp_12) then
            ____t_result_14 = __O[2751]
        else
            ____t_result_14 = __isArray(value)
        end
        __O[2752] = ____t_result_14
        if ____t_15(____t_result_14) then
            ____t_result_16 = __O[2752]
        else
            ____t_result_16 = not __t(seq(nil, value.seq))
        end
        if ____t_17(____t_result_16) then
            return false
        end
        for ____, ____value in __iterar((__entries(value))) do
            local key = ____value[1]
            local item = ____value[2]
            if __t(key == "x" or key == "y") then
                local ____t_21 = __t
                local ____t_result_20
                local ____t_19 = __t
                local ____temp_18 = type(item) ~= "number" or not __isFiniteN(item)
                __O[2753] = ____temp_18
                if ____t_19(____temp_18) then
                    ____t_result_20 = __O[2753]
                else
                    ____t_result_20 = math.abs(item) > 1
                end
                if ____t_21(____t_result_20) then
                    return false
                end
            elseif key == "response" then
                local ____t_27 = __t
                local ____t_result_26
                local ____t_25 = __t
                local ____t_result_24
                local ____t_23 = __t
                local ____temp_22 = type(item) ~= "number" or not __isFiniteN(item)
                __O[2754] = ____temp_22
                if ____t_23(____temp_22) then
                    ____t_result_24 = __O[2754]
                else
                    ____t_result_24 = item < 0.5
                end
                __O[2755] = ____t_result_24
                if ____t_25(____t_result_24) then
                    ____t_result_26 = __O[2755]
                else
                    ____t_result_26 = item > 2
                end
                if ____t_27(____t_result_26) then
                    return false
                end
            elseif key == "jump" then
                if type(item) ~= "boolean" then
                    return false
                end
            elseif key == "aim" then
                local ____t_31 = __t
                local ____t_result_30
                local ____t_29 = __t
                local ____temp_28 = not __isInteger(item) or __lt(item, 0)
                __O[2756] = ____temp_28
                if ____t_29(____temp_28) then
                    ____t_result_30 = __O[2756]
                else
                    ____t_result_30 = __gt(item, 4)
                end
                if ____t_31(____t_result_30) then
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
                function(____, p)
                    local ____p_id_53 = p.id
                    local ____connected_result_54 = connected(nil, p)
                    local ____t_result_50
                    if __t(p.pc.connectionState) then
                        ____t_result_50 = p.pc.connectionState
                    else
                        ____t_result_50 = "new"
                    end
                    local ____temp_55 = __t(connected(nil, p)) and "open" or p.stage
                    local ____isFiniteN_result_51
                    if __isFiniteN(p.ping) then
                        ____isFiniteN_result_51 = math.floor(p.ping + 0.5)
                    else
                        ____isFiniteN_result_51 = nil
                    end
                    local ____t_result_52
                    if __t(p.connectedAt) then
                        ____t_result_52 = p.connectedAt
                    else
                        ____t_result_52 = window.performance:now()
                    end
                    return {
                        id = ____p_id_53,
                        open = ____connected_result_54,
                        connection = ____t_result_50,
                        stage = ____temp_55,
                        pingMs = ____isFiniteN_result_51,
                        negotiationMs = math.floor(____t_result_52 - p.createdAt + 0.5)
                    }
                end
            )
            local count = __len(__call(
                list,
                "filter",
                function(____, p) return p.open end
            ))
            local ____t_result_56
            if __t(isHost) then
                ____t_result_56 = math.max(0, roster.size - 1)
            else
                ____t_result_56 = __t(__call(roster, "has", hostId)) and 1 or 0
            end
            local total = ____t_result_56
            local pings = __call(
                __call(
                    list,
                    "filter",
                    function(____, p)
                        local ____t_result_57
                        if __t(p.open) then
                            ____t_result_57 = p.pingMs ~= nil
                        else
                            ____t_result_57 = p.open
                        end
                        return ____t_result_57
                    end
                ),
                "map",
                function(____, p) return p.pingMs end
            )
            local ____total_59 = total
            local ____temp_60 = count > 0 and "realtime" or "relay"
            local ____t_result_58
            if __t(__len(pings)) then
                ____t_result_58 = math.max(__TS__Spread(__iter(pings)))
            else
                ____t_result_58 = nil
            end
            return {
                supported = enabled,
                connected = count,
                directPeers = count,
                total = ____total_59,
                status = ____temp_60,
                pingMs = ____t_result_58,
                handshakeRequests = metrics.signals,
                iceBatches = metrics.batches,
                signalingPolls = metrics.polls,
                pendingSignals = __len(queue) + (__t(sending) and 1 or 0),
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
                local ____temp_64
                local ____opt_result_63
                if response ~= nil then
                    ____opt_result_63 = response.json
                end
                if type(____opt_result_63) == "function" then
                    ____temp_64 = __TS__Await(response:json())
                else
                    ____temp_64 = response
                end
                local data = ____temp_64
                local ____t_78 = __t
                local ____t_result_77
                local ____t_73 = __t
                local ____opt_result_67
                if response ~= nil then
                    ____opt_result_67 = response.ok
                end
                local ____temp_72 = ____opt_result_67 == false
                if not ____temp_72 then
                    local ____ge_71 = __ge
                    local ____opt_result_70
                    if response ~= nil then
                        ____opt_result_70 = response.status
                    end
                    ____temp_72 = ____ge_71(____opt_result_70, 400)
                end
                __O[2761] = ____temp_72
                if ____t_73(____temp_72) then
                    ____t_result_77 = __O[2761]
                else
                    local ____opt_result_76
                    if data ~= nil then
                        ____opt_result_76 = data.error
                    end
                    ____t_result_77 = ____opt_result_76
                end
                if ____t_78(____t_result_77) then
                    local ____Error_83 = Error
                    local ____temp_82
                    local ____opt_result_81
                    if data ~= nil then
                        ____opt_result_81 = data.error
                    end
                    if type(____opt_result_81) == "string" then
                        ____temp_82 = data.error
                    else
                        ____temp_82 = "Conexão direta indisponível."
                    end
                    local ____error = __TS__New(____Error_83, ____temp_82)
                    local ____opt_result_86
                    if response ~= nil then
                        ____opt_result_86 = response.status
                    end
                    ____error.status = ____opt_result_86
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
                local ____call_89 = __call
                local ____queue_88 = queue
                local ____temp_87
                if at < 0 then
                    ____temp_87 = __len(queue)
                else
                    ____temp_87 = at
                end
                ____call_89(
                    ____queue_88,
                    "splice",
                    ____temp_87,
                    0,
                    item
                )
            else
                __call(queue, "push", item)
            end
        end
        function enqueue(self, to, kind, data)
            local ____t_91 = __t
            local ____t_result_90
            if __t(closed) then
                ____t_result_90 = closed
            else
                ____t_result_90 = __len(queue) >= 80
            end
            if ____t_91(____t_result_90) then
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
                local ____t_93 = __t
                local ____t_result_92
                if __t(sending) then
                    ____t_result_92 = sending
                else
                    ____t_result_92 = closed
                end
                if ____t_93(____t_result_92) then
                    return ____awaiter_resolve(nil)
                end
                sending = true
                local ____try = __TS__AsyncAwaiter(function()
                    while true do
                        local ____t_102 = __t
                        local ____t_result_101
                        if __t(__len(queue)) then
                            ____t_result_101 = not __t(closed)
                        else
                            ____t_result_101 = __len(queue)
                        end
                        if not ____t_102(____t_result_101) then
                            break
                        end
                        do
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
                                        local ____t_100 = __t
                                        local ____t_result_99
                                        local ____t_95 = __t
                                        local ____call_result_94 = __call(
                                            __arrL({401, 403, 404, 410}, 4),
                                            "includes",
                                            ____error.status
                                        )
                                        __O[2762] = ____call_result_94
                                        if ____t_95(____call_result_94) then
                                            ____t_result_99 = __O[2762]
                                        else
                                            local ____item_96, ____attempts_97 = item, "attempts"
                                            local ____item_attempts_98 = ____item_96[____attempts_97] + 1
                                            ____item_96[____attempts_97] = ____item_attempts_98
                                            ____t_result_99 = ____item_attempts_98 >= 3
                                        end
                                        if ____t_100(____t_result_99) then
                                            status(nil)
                                            ____hasContinued = true
                                            return
                                        end
                                        __TS__Await(__TS__New(
                                            __TS__Promise,
                                            function(____, resolve) return window:setTimeout(resolve, ____error.status == 429 and 1100 or 400 * item.attempts) end
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
                        local ____temp_105 = q.to ~= id
                        if not ____temp_105 then
                            local ____opt_103 = q.data
                            if ____opt_103 ~= nil then
                                ____opt_103 = ____opt_103.session
                            end
                            ____temp_105 = ____opt_103 ~= peer.session
                        end
                        return ____temp_105
                    end
                )
                do
                    pcall(function()
                        local ____opt_106 = peer.channel
                        if ____opt_106 ~= nil then
                            ____opt_106:close()
                        end
                        peer.pc:close()
                    end)
                end
            end
            if __t(again) then
                local ____t_result_110
                local ____t_109 = __t
                local ____call_result_108 = __call(retry, "get", id)
                __O[2763] = ____call_result_108
                if ____t_109(____call_result_108) then
                    ____t_result_110 = __O[2763]
                else
                    ____t_result_110 = {tries = 0}
                end
                local old = ____t_result_110
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
            local ____t_114 = __t
            local ____t_result_113
            local ____t_112 = __t
            local ____t_result_111
            if __t(closed) then
                ____t_result_111 = closed
            else
                ____t_result_111 = __call(peers, "get", peer.id) ~= peer
            end
            __O[2764] = ____t_result_111
            if ____t_112(____t_result_111) then
                ____t_result_113 = __O[2764]
            else
                ____t_result_113 = not __t(peer.descriptionQueued)
            end
            if ____t_114(____t_result_113) then
                return
            end
            while __t(__len(peer.outgoingIce)) do
                local candidates = __arrL({}, 0)
                while true do
                    local ____t_123 = __t
                    local ____t_result_122
                    if __t(__len(peer.outgoingIce)) then
                        ____t_result_122 = __len(candidates) < 16
                    else
                        ____t_result_122 = __len(peer.outgoingIce)
                    end
                    if not ____t_123(____t_result_122) then
                        break
                    end
                    local value = __get(peer.outgoingIce, 0)
                    local ____t_121 = __t
                    local ____t_result_120
                    if __t(__len(candidates)) then
                        local ____len_119 = __len
                        local ____self_117 = window.JSON
                        local ____self_117_stringify_118 = ____self_117.stringify
                        local ____arr_116 = __arr
                        local ____array_115 = __TS__SparseArrayNew(__TS__Spread(__iter(candidates)))
                        __TS__SparseArrayPush(____array_115, value)
                        ____t_result_120 = ____len_119(____self_117_stringify_118(
                            ____self_117,
                            ____arr_116(__TS__SparseArraySpread(____array_115))
                        )) > 22000
                    else
                        ____t_result_120 = __len(candidates)
                    end
                    if ____t_121(____t_result_120) then
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
            local ____t_125 = __t
            local ____t_result_124
            if __t(closed) then
                ____t_result_124 = closed
            else
                ____t_result_124 = __call(peers, "get", peer.id) ~= peer
            end
            if ____t_125(____t_result_124) then
                return
            end
            if __t(connected(nil, peer)) then
                local ____peer_126, ____pingSeq_127 = peer, "pingSeq"
                local ____peer_pingSeq_128 = ____peer_126[____pingSeq_127] + 1
                ____peer_126[____pingSeq_127] = ____peer_pingSeq_128
                local n = ____peer_pingSeq_128
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
                local ____t_136 = __t
                local ____t_result_135
                local ____t_134 = __t
                local ____t_result_133
                local ____t_132 = __t
                local ____t_result_131
                local ____t_130 = __t
                local ____t_result_129
                if __t(closed) then
                    ____t_result_129 = closed
                else
                    ____t_result_129 = __call(peers, "get", peer.id) ~= peer
                end
                __O[2765] = ____t_result_129
                if ____t_130(____t_result_129) then
                    ____t_result_131 = __O[2765]
                else
                    ____t_result_131 = not __t(__call(roster, "has", peer.id))
                end
                __O[2766] = ____t_result_131
                if ____t_132(____t_result_131) then
                    ____t_result_133 = __O[2766]
                else
                    ____t_result_133 = type(event.data) ~= "string"
                end
                __O[2767] = ____t_result_133
                if ____t_134(____t_result_133) then
                    ____t_result_135 = __O[2767]
                else
                    ____t_result_135 = __gt(
                        __len(event.data),
                        32768
                    )
                end
                if ____t_136(____t_result_135) then
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
                local ____opt_result_139
                if packet ~= nil then
                    ____opt_result_139 = packet.v
                end
                if ____opt_result_139 ~= 1 then
                    return
                end
                local ____t_145 = __t
                local ____t_result_144
                local ____t_143 = __t
                local ____t_result_142
                local ____t_141 = __t
                local ____temp_140 = packet.kind == "ping"
                __O[2768] = ____temp_140
                if ____t_141(____temp_140) then
                    ____t_result_142 = seq(nil, packet.n)
                else
                    ____t_result_142 = __O[2768]
                end
                __O[2769] = ____t_result_142
                if ____t_143(____t_result_142) then
                    ____t_result_144 = __isFiniteN(packet.t)
                else
                    ____t_result_144 = __O[2769]
                end
                if ____t_145(____t_result_144) then
                    do
                        pcall(function()
                            channel:send(window.JSON:stringify({v = 1, kind = "pong", n = packet.n, t = packet.t}))
                        end)
                    end
                    return
                end
                if packet.kind == "pong" then
                    local sent = peer.pendingPing
                    local ____t_149 = __t
                    local ____t_result_148
                    local ____t_147 = __t
                    local ____t_result_146
                    if __t(sent) then
                        ____t_result_146 = packet.n == sent.n
                    else
                        ____t_result_146 = sent
                    end
                    __O[2770] = ____t_result_146
                    if ____t_147(____t_result_146) then
                        ____t_result_148 = packet.t == sent.t
                    else
                        ____t_result_148 = __O[2770]
                    end
                    if ____t_149(____t_result_148) then
                        local elapsed = window.performance:now() - sent.t
                        if __t(elapsed >= 0 and elapsed < 10000) then
                            local ____peer_151 = peer
                            local ____isFiniteN_result_150
                            if __isFiniteN(peer.ping) then
                                ____isFiniteN_result_150 = peer.ping * 0.7 + elapsed * 0.3
                            else
                                ____isFiniteN_result_150 = elapsed
                            end
                            ____peer_151.ping = ____isFiniteN_result_150
                            peer.pendingPing = nil
                            status(nil)
                        end
                    end
                    return
                end
                if __t(not __t(packet.value) or type(packet.value) ~= "table") then
                    return
                end
                local ____t_157 = __t
                local ____t_result_156
                local ____t_155 = __t
                local ____t_result_154
                local ____t_153 = __t
                local ____t_result_152
                if __t(isHost) then
                    ____t_result_152 = packet.kind == "input"
                else
                    ____t_result_152 = isHost
                end
                __O[2771] = ____t_result_152
                if ____t_153(____t_result_152) then
                    ____t_result_154 = validInput(nil, packet.value)
                else
                    ____t_result_154 = __O[2771]
                end
                __O[2772] = ____t_result_154
                if ____t_155(____t_result_154) then
                    ____t_result_156 = __gt(packet.value.seq, peer.inputSeq)
                else
                    ____t_result_156 = __O[2772]
                end
                if ____t_157(____t_result_156) then
                    peer.inputSeq = packet.value.seq
                    safeCall(nil, "onInput", peer.id, packet.value)
                else
                    local ____t_165 = __t
                    local ____t_result_164
                    local ____t_163 = __t
                    local ____t_result_162
                    local ____t_161 = __t
                    local ____t_result_160
                    local ____t_159 = __t
                    local ____temp_158 = not __t(isHost) and peer.id == hostId
                    __O[2773] = ____temp_158
                    if ____t_159(____temp_158) then
                        ____t_result_160 = packet.kind == "state"
                    else
                        ____t_result_160 = __O[2773]
                    end
                    __O[2774] = ____t_result_160
                    if ____t_161(____t_result_160) then
                        ____t_result_162 = seq(nil, packet.value.seq)
                    else
                        ____t_result_162 = __O[2774]
                    end
                    __O[2775] = ____t_result_162
                    if ____t_163(____t_result_162) then
                        ____t_result_164 = __gt(packet.value.seq, peer.stateSeq)
                    else
                        ____t_result_164 = __O[2775]
                    end
                    if ____t_165(____t_result_164) then
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
                stage = __t(isHost) and "creating-offer" or "answering",
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
                local ____t_169 = __t
                local ____t_result_168
                local ____t_167 = __t
                local ____t_result_166
                if __t(closed) then
                    ____t_result_166 = closed
                else
                    ____t_result_166 = __call(peers, "get", id) ~= peer
                end
                __O[2776] = ____t_result_166
                if ____t_167(____t_result_166) then
                    ____t_result_168 = __O[2776]
                else
                    ____t_result_168 = peer.candidateKeys.size >= 48
                end
                if ____t_169(____t_result_168) then
                    return
                end
                local ____temp_170
                if type(event.candidate.toJSON) == "function" then
                    ____temp_170 = event.candidate:toJSON()
                else
                    ____temp_170 = event.candidate
                end
                local value = ____temp_170
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
                local ____call_175 = __call
                local ____peer_outgoingIce_174 = peer.outgoingIce
                local ____value_candidate_173 = value.candidate
                local ____value_sdpMid_171 = value.sdpMid
                if ____value_sdpMid_171 == nil then
                    ____value_sdpMid_171 = nil
                end
                local ____value_sdpMLineIndex_172 = value.sdpMLineIndex
                if ____value_sdpMLineIndex_172 == nil then
                    ____value_sdpMLineIndex_172 = nil
                end
                ____call_175(____peer_outgoingIce_174, "push", {candidate = ____value_candidate_173, sdpMid = ____value_sdpMid_171, sdpMLineIndex = ____value_sdpMLineIndex_172})
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
                local ____t_177 = __t
                local ____t_result_176
                if __t(closed) then
                    ____t_result_176 = closed
                else
                    ____t_result_176 = __call(peers, "get", id) ~= peer
                end
                if ____t_177(____t_result_176) then
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
                local ____t_181 = __t
                local ____t_result_180
                local ____t_179 = __t
                local ____t_result_178
                if __t(closed) then
                    ____t_result_178 = closed
                else
                    ____t_result_178 = __call(peers, "has", id)
                end
                __O[2777] = ____t_result_178
                if ____t_179(____t_result_178) then
                    ____t_result_180 = __O[2777]
                else
                    ____t_result_180 = not __t(__call(roster, "has", id))
                end
                if ____t_181(____t_result_180) then
                    return ____awaiter_resolve(nil)
                end
                local ____t_result_184
                local ____t_183 = __t
                local ____call_result_182 = __call(retry, "get", id)
                __O[2778] = ____call_result_182
                if ____t_183(____call_result_182) then
                    ____t_result_184 = __O[2778]
                else
                    ____t_result_184 = {tries = 0, nextAt = 0}
                end
                local history = ____t_result_184
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
                            local ____t_186 = __t
                            local ____t_result_185
                            if __t(peer) then
                                ____t_result_185 = __call(peers, "get", id) == peer
                            else
                                ____t_result_185 = peer
                            end
                            if ____t_186(____t_result_185) then
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
                local ____arr_192 = __arr
                local ____iter_190 = __iter
                local ____t_result_189
                local ____t_188 = __t
                local ____call_result_187 = __call(pendingIce, "get", key)
                __O[2779] = ____call_result_187
                if ____t_188(____call_result_187) then
                    ____t_result_189 = __O[2779]
                else
                    ____t_result_189 = __arrL({}, 0)
                end
                local ____array_191 = __TS__SparseArrayNew(__TS__Spread(____iter_190(____t_result_189)))
                __TS__SparseArrayPush(
                    ____array_191,
                    __TS__Spread(__iter(peer.ice))
                )
                local candidates = ____arr_192(__TS__SparseArraySpread(____array_191))
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
                local ____t_205 = __t
                local ____t_result_204
                local ____t_203 = __t
                local ____t_result_202
                local ____t_201 = __t
                local ____t_result_200
                local ____t_199 = __t
                local ____t_result_198
                local ____t_197 = __t
                local ____t_result_196
                if __t(closed) then
                    ____t_result_196 = closed
                else
                    local ____opt_result_195
                    if item ~= nil then
                        ____opt_result_195 = item.to
                    end
                    ____t_result_196 = ____opt_result_195 ~= myId
                end
                __O[2780] = ____t_result_196
                if ____t_197(____t_result_196) then
                    ____t_result_198 = __O[2780]
                else
                    ____t_result_198 = not __t(__call(roster, "has", item.from))
                end
                __O[2781] = ____t_result_198
                if ____t_199(____t_result_198) then
                    ____t_result_200 = __O[2781]
                else
                    ____t_result_200 = item.from == myId
                end
                __O[2782] = ____t_result_200
                if ____t_201(____t_result_200) then
                    ____t_result_202 = __O[2782]
                else
                    ____t_result_202 = not __t(item.data)
                end
                __O[2783] = ____t_result_202
                if ____t_203(____t_result_202) then
                    ____t_result_204 = __O[2783]
                else
                    ____t_result_204 = type(item.data.session) ~= "string"
                end
                if ____t_205(____t_result_204) then
                    return ____awaiter_resolve(nil)
                end
                local ____t_209 = __t
                local ____t_result_208
                local ____t_207 = __t
                local ____t_result_206
                if __t(isHost) then
                    ____t_result_206 = item.from == hostId
                else
                    ____t_result_206 = isHost
                end
                __O[2784] = ____t_result_206
                if ____t_207(____t_result_206) then
                    ____t_result_208 = __O[2784]
                else
                    ____t_result_208 = not __t(isHost) and item.from ~= hostId
                end
                if ____t_209(____t_result_208) then
                    return ____awaiter_resolve(nil)
                end
                local data = item.data
                local peer = __call(peers, "get", item.from)
                if item.kind == "offer" then
                    if __t(isHost) then
                        return ____awaiter_resolve(nil)
                    end
                    local ____t_216 = __t
                    local ____t_result_215
                    local ____t_214 = __t
                    local ____opt_result_212
                    if peer ~= nil then
                        ____opt_result_212 = peer.session
                    end
                    local ____temp_213 = ____opt_result_212 == data.session
                    __O[2785] = ____temp_213
                    if ____t_214(____temp_213) then
                        ____t_result_215 = peer.pc.remoteDescription
                    else
                        ____t_result_215 = __O[2785]
                    end
                    if ____t_216(____t_result_215) then
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
                        local ____t_218 = __t
                        local ____t_result_217
                        if __t(closed) then
                            ____t_result_217 = closed
                        else
                            ____t_result_217 = __call(peers, "get", item.from) ~= peer
                        end
                        if ____t_218(____t_result_217) then
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
                    local ____t_224 = __t
                    local ____t_result_223
                    local ____t_222 = __t
                    local ____t_result_221
                    local ____t_220 = __t
                    local ____temp_219 = not __t(isHost) or not __t(peer)
                    __O[2786] = ____temp_219
                    if ____t_220(____temp_219) then
                        ____t_result_221 = __O[2786]
                    else
                        ____t_result_221 = peer.session ~= data.session
                    end
                    __O[2787] = ____t_result_221
                    if ____t_222(____t_result_221) then
                        ____t_result_223 = __O[2787]
                    else
                        ____t_result_223 = peer.pc.remoteDescription
                    end
                    if ____t_224(____t_result_223) then
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
                    local ____temp_225
                    if item.kind == "ice-batch" then
                        ____temp_225 = data.candidates
                    else
                        ____temp_225 = __arrL({data}, 1)
                    end
                    local candidates = ____temp_225
                    if __t(not __isArray(candidates) or __len(candidates) > 16) then
                        return ____awaiter_resolve(nil)
                    end
                    for ____, c in __iterar((candidates)) do
                        do
                            local ____t_229 = __t
                            local ____t_result_228
                            local ____t_227 = __t
                            local ____temp_226 = not __t(c) or type(c.candidate) ~= "string"
                            __O[2788] = ____temp_226
                            if ____t_227(____temp_226) then
                                ____t_result_228 = __O[2788]
                            else
                                ____t_result_228 = __gt(
                                    __len(c.candidate),
                                    2048
                                )
                            end
                            if ____t_229(____t_result_228) then
                                continue
                            end
                            local ____c_candidate_232 = c.candidate
                            local ____c_sdpMid_230 = c.sdpMid
                            if ____c_sdpMid_230 == nil then
                                ____c_sdpMid_230 = nil
                            end
                            local ____c_sdpMLineIndex_231 = c.sdpMLineIndex
                            if ____c_sdpMLineIndex_231 == nil then
                                ____c_sdpMLineIndex_231 = nil
                            end
                            local candidate = {candidate = ____c_candidate_232, sdpMid = ____c_sdpMid_230, sdpMLineIndex = ____c_sdpMLineIndex_231}
                            local ____t_234 = __t
                            local ____t_result_233
                            if __t(peer) then
                                ____t_result_233 = peer.session == data.session
                            else
                                ____t_result_233 = peer
                            end
                            if ____t_234(____t_result_233) then
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
                                local ____t_result_237
                                local ____t_236 = __t
                                local ____call_result_235 = __call(pendingIce, "get", key)
                                __O[2789] = ____call_result_235
                                if ____t_236(____call_result_235) then
                                    ____t_result_237 = __O[2789]
                                else
                                    ____t_result_237 = __arrL({}, 0)
                                end
                                local list = ____t_result_237
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
                end
            end)
        end
        function schedulePoll(self, delay)
            window:clearTimeout(pollTimer)
            local ____t_239 = __t
            local ____t_result_238
            if __t(closed) then
                ____t_result_238 = closed
            else
                ____t_result_238 = not __t(enabled)
            end
            if ____t_239(____t_result_238) then
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
                local ____t_243 = __t
                local ____t_result_242
                local ____t_241 = __t
                local ____t_result_240
                if __t(closed) then
                    ____t_result_240 = closed
                else
                    ____t_result_240 = not __t(enabled)
                end
                __O[2790] = ____t_result_240
                if ____t_241(____t_result_240) then
                    ____t_result_242 = __O[2790]
                else
                    ____t_result_242 = polling
                end
                if ____t_243(____t_result_242) then
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
                    local ____iter_245 = __iter
                    local ____t_result_244
                    if __t(data.signals) then
                        ____t_result_244 = data.signals
                    else
                        ____t_result_244 = __arrL({}, 0)
                    end
                    for ____, item in __TS__Iterator(____iter_245(____t_result_244)) do
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
                    local ____t_249 = __t
                    local ____t_result_248
                    local ____t_247 = __t
                    local ____isSafeInteger_result_246 = __isSafeInteger(data.cursor)
                    __O[2791] = ____isSafeInteger_result_246
                    if ____t_247(____isSafeInteger_result_246) then
                        ____t_result_248 = __ge(data.cursor, cursor)
                    else
                        ____t_result_248 = __O[2791]
                    end
                    if ____t_249(____t_result_248) then
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
                                local ____t_result_252
                                local ____t_251 = __t
                                local ____temp_250 = value.total == 0 or value.connected == value.total
                                __O[2792] = ____temp_250
                                if ____t_251(____temp_250) then
                                    ____t_result_252 = __O[2792]
                                else
                                    ____t_result_252 = window.performance:now() - lastNegotiationAt > 25000
                                end
                                local idle = ____t_result_252
                                schedulePoll(
                                    nil,
                                    __t(pollSoon) and 0 or math.max(
                                        0,
                                        (__t(idle) and 3000 or 250) - (window.performance:now() - started)
                                    )
                                )
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
            local ____t_254 = __t
            local ____t_result_253
            if __t(closed) then
                ____t_result_253 = closed
            else
                ____t_result_253 = not __t(enabled)
            end
            if ____t_254(____t_result_253) then
                return
            end
            for ____, ____value in __iterar((peers)) do
                local id = ____value[1]
                local peer = ____value[2]
                local ____t_258 = __t
                local ____t_result_257
                local ____t_256 = __t
                local ____temp_255 = not __t(__call(roster, "has", id))
                __O[2793] = ____temp_255
                if ____t_256(____temp_255) then
                    ____t_result_257 = __O[2793]
                else
                    ____t_result_257 = not __t(isHost) and id ~= hostId
                end
                if ____t_258(____t_result_257) then
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
        local ____t_result_32
        if __t(options.code) then
            ____t_result_32 = options.code
        else
            ____t_result_32 = options.roomCode
        end
        local code = ____t_result_32
        myId = options.playerId
        isHost = not not __t(options.isHost)
        local ____t_result_33
        if __t(isHost) then
            ____t_result_33 = myId
        else
            ____t_result_33 = options.hostPlayerId
        end
        hostId = ____t_result_33
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
        local ____t_result_45
        local ____t_44 = __t
        local ____t_result_43
        local ____t_42 = __t
        local ____t_result_41
        local ____t_40 = __t
        local ____t_result_39
        local ____t_35 = __t
        local ____supported_result_34 = supported(nil)
        __O[2757] = ____supported_result_34
        if ____t_35(____supported_result_34) then
            local ____re_test_38 = __re_test
            local ____re_result_37 = __re("^[A-Z0-9]{6}$", "")
            local ____t_result_36
            if __t(code) then
                ____t_result_36 = code
            else
                ____t_result_36 = ""
            end
            ____t_result_39 = ____re_test_38(____re_result_37, ____t_result_36)
        else
            ____t_result_39 = __O[2757]
        end
        __O[2758] = ____t_result_39
        if ____t_40(____t_result_39) then
            ____t_result_41 = type(myId) == "string"
        else
            ____t_result_41 = __O[2758]
        end
        __O[2759] = ____t_result_41
        if ____t_42(____t_result_41) then
            ____t_result_43 = type(hostId) == "string"
        else
            ____t_result_43 = __O[2759]
        end
        __O[2760] = ____t_result_43
        if ____t_44(____t_result_43) then
            ____t_result_45 = type(options.request) == "function"
        else
            ____t_result_45 = __O[2760]
        end
        enabled = ____t_result_45
        endpoint = __add(
            __add("/api/arena/rooms/", code),
            "/signal"
        )
        safeCall = function(____, name, ...)
            local args = {...}
            do
                pcall(function()
                    local ____opt_46 = __get(options, name)
                    if ____opt_46 ~= nil then
                        ____opt_46(
                            nil,
                            __TS__Spread(__iter(args))
                        )
                    end
                end)
            end
        end
        connected = function(____, peer)
            local ____opt_48 = peer.channel
            if ____opt_48 ~= nil then
                ____opt_48 = ____opt_48.readyState
            end
            return ____opt_48 == "open" and not __t(__call(
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
            local ____Set_266 = Set
            local ____call_265 = __call
            local ____call_264 = __call
            local ____isArray_result_259
            if __isArray(players) then
                ____isArray_result_259 = players
            else
                ____isArray_result_259 = __arrL({}, 0)
            end
            roster = __TS__New(
                ____Set_266,
                ____call_265(
                    ____call_264(
                        ____isArray_result_259,
                        "map",
                        function(____, p)
                            local ____temp_263
                            if type(p) == "string" then
                                ____temp_263 = p
                            else
                                local ____opt_result_262
                                if p ~= nil then
                                    ____opt_result_262 = p.id
                                end
                                ____temp_263 = ____opt_result_262
                            end
                            return ____temp_263
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
            local ____t_274 = __t
            local ____t_result_273
            local ____t_272 = __t
            local ____t_result_271
            local ____t_270 = __t
            local ____t_result_269
            local ____t_268 = __t
            local ____t_result_267
            if __t(closed) then
                ____t_result_267 = closed
            else
                ____t_result_267 = not __t(enabled)
            end
            __O[2794] = ____t_result_267
            if ____t_268(____t_result_267) then
                ____t_result_269 = __O[2794]
            else
                ____t_result_269 = not __t(value)
            end
            __O[2795] = ____t_result_269
            if ____t_270(____t_result_269) then
                ____t_result_271 = __O[2795]
            else
                ____t_result_271 = not __t(seq(nil, value.seq))
            end
            __O[2796] = ____t_result_271
            if ____t_272(____t_result_271) then
                ____t_result_273 = __O[2796]
            else
                ____t_result_273 = kind == "input" and not __t(validInput(nil, value))
            end
            if ____t_274(____t_result_273) then
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
                local ____t_278 = __t
                local ____t_result_277
                local ____t_276 = __t
                local ____connected_result_275 = connected(nil, peer)
                __O[2797] = ____connected_result_275
                if ____t_276(____connected_result_275) then
                    ____t_result_277 = __lt(peer.channel.bufferedAmount, 65536)
                else
                    ____t_result_277 = __O[2797]
                end
                if ____t_278(____t_result_277) then
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
            local ____updateRoster_280 = updateRoster
            local ____t_result_279
            if __t(options.players) then
                ____t_result_279 = options.players
            else
                ____t_result_279 = __arrL({}, 0)
            end
            ____updateRoster_280(nil, ____t_result_279)
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
