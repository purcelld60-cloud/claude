--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __fbind, __ord, __arrL, __t, __get, __set, __call, __add, __new, __assign, __getters, __re = __JSR.__fbind, __JSR.__ord, __JSR.__arrL, __JSR.__t, __JSR.__get, __JSR.__set, __JSR.__call, __JSR.__add, __JSR.__new, __JSR.__assign, __JSR.__getters, __JSR.__re
local __re_test, __re_replace = __JSR.__re_test, __JSR.__re_replace
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Number = ____lualib.__TS__Number
local Error = ____lualib.Error
local RangeError = ____lualib.RangeError
local ReferenceError = ____lualib.ReferenceError
local SyntaxError = ____lualib.SyntaxError
local TypeError = ____lualib.TypeError
local URIError = ____lualib.URIError
local __TS__New = ____lualib.__TS__New
local __TS__Promise = ____lualib.__TS__Promise
local __TS__PromiseRace = ____lualib.__TS__PromiseRace
local __TS__AsyncAwaiter = ____lualib.__TS__AsyncAwaiter
local __TS__Await = ____lualib.__TS__Await
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    if __t(window.DarocaOnline) then
        return
    end
    local KEY = "daroca-servidor"
    do
        pcall(function()
            local q = __new("URLSearchParams", window.location.search)
            local port = __TS__Number(__call(q, "get", "tvport"))
            if __t(port > 0 and port < 65536) then
                local ____window_8 = window
                local ____ord_7 = __ord
                local ____port_6 = port
                local ____re_test_result_5
                local ____re_test_4 = __re_test
                local ____re_result_3 = __re("^[0-9.]{7,15}$", "")
                local ____t_result_2
                local ____t_1 = __t
                local ____call_result_0 = __call(q, "get", "tvip")
                __O[2] = ____call_result_0
                if ____t_1(____call_result_0) then
                    ____t_result_2 = __O[2]
                else
                    ____t_result_2 = ""
                end
                if ____re_test_4(____re_result_3, ____t_result_2) then
                    ____re_test_result_5 = __call(q, "get", "tvip")
                else
                    ____re_test_result_5 = ""
                end
                ____window_8.DAROCA_TV = ____ord_7({port = ____port_6, ip = ____re_test_result_5}, "port,ip")
            end
        end)
    end
    local function norm(____, u)
        do
            local function ____catch(e)
                return true, ""
            end
            local ____try, ____hasReturned, ____returnValue = pcall(function()
                local ____new_11 = __new
                local ____call_10 = __call
                local ____t_result_9
                if __t(u) then
                    ____t_result_9 = u
                else
                    ____t_result_9 = ""
                end
                local x = ____new_11(
                    "URL",
                    ____call_10(
                        tostring(____t_result_9),
                        "trim"
                    )
                )
                local ____re_test_result_12
                if __re_test(
                    __re("^https?:$", ""),
                    x.protocol
                ) then
                    ____re_test_result_12 = x.origin
                else
                    ____re_test_result_12 = ""
                end
                return true, ____re_test_result_12
            end)
            if not ____try then
                ____hasReturned, ____returnValue = ____catch(____hasReturned)
            end
            if ____hasReturned then
                return ____returnValue
            end
        end
    end
    local base = nil
    local configured = ""
    local sameOrigin = false
    do
        pcall(function()
            local q = __call(
                __new("URLSearchParams", window.location.search),
                "get",
                "servidor"
            )
            if q ~= nil then
                local n = norm(nil, q)
                if __t(n) then
                    window.localStorage:setItem(KEY, n)
                else
                    window.localStorage:removeItem(KEY)
                end
            end
            local ____t_result_15
            local ____t_14 = __t
            local ____temp_13 = window.localStorage:getItem(KEY)
            __O[3] = ____temp_13
            if ____t_14(____temp_13) then
                ____t_result_15 = __O[3]
            else
                ____t_result_15 = ""
            end
            configured = ____t_result_15
        end)
    end
    local function withTimeout(____, p, ms)
        return __TS__PromiseRace(__arrL(
            {
                p,
                __TS__New(
                    __TS__Promise,
                    function(____, _, r) return window:setTimeout(
                        function() return r(
                            nil,
                            __TS__New(Error, "tempo")
                        ) end,
                        ms
                    ) end
                )
            },
            2
        ))
    end
    local origFetch = __fbind(window.fetch, window)
    local function probe(self, origin)
        return __TS__AsyncAwaiter(function(____awaiter_resolve)
            local ____hasReturned, ____returnValue
            local ____try = __TS__AsyncAwaiter(function()
                local r = __TS__Await(withTimeout(
                    nil,
                    origFetch(
                        nil,
                        __add(origin, "/api/health"),
                        {cache = "no-store"}
                    ),
                    2500
                ))
                if not __t(r.ok) then
                    ____hasReturned = true
                    ____returnValue = false
                    return
                end
                local j = __TS__Await(r:json())
                local ____t_result_16
                if __t(j) then
                    ____t_result_16 = j.server == "daroca"
                else
                    ____t_result_16 = j
                end
                ____hasReturned = true
                ____returnValue = ____t_result_16
                return
            end)
            ____try = ____try.catch(
                ____try,
                function(____, e)
                    return __TS__AsyncAwaiter(function()
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
    local ready = (function()
        return __TS__AsyncAwaiter(function(____awaiter_resolve)
            local ____t_20 = __t
            local ____t_result_19
            local ____t_18 = __t
            local ____re_test_result_17 = __re_test(
                __re("^https?:$", ""),
                window.location.protocol
            )
            __O[4] = ____re_test_result_17
            if ____t_18(____re_test_result_17) then
                ____t_result_19 = __TS__Await(probe(nil, ""))
            else
                ____t_result_19 = __O[4]
            end
            if ____t_20(____t_result_19) then
                sameOrigin = true
                base = ""
                return ____awaiter_resolve(nil, base)
            end
            if not __t(configured) then
                local ____try = __TS__AsyncAwaiter(function()
                    local r = __TS__Await(withTimeout(
                        nil,
                        origFetch(nil, "servidor.json", {cache = "no-cache"}),
                        2500
                    ))
                    if __t(r.ok) then
                        configured = norm(
                            nil,
                            __TS__Await(r:json()).url
                        )
                    end
                end)
                ____try = ____try.catch(
                    ____try,
                    function(____, e)
                        return __TS__AsyncAwaiter(function()
                        end)
                    end
                )
                __TS__Await(____try)
            end
            local ____t_result_21
            if __t(configured) then
                ____t_result_21 = configured
            else
                ____t_result_21 = ""
            end
            base = ____t_result_21
            return ____awaiter_resolve(nil, base)
        end)
    end)(nil)
    local awake = false
    local function wake()
        return ready["then"](
            ready,
            function(____, b)
                local ____t_25 = __t
                local ____t_result_24
                local ____t_23 = __t
                local ____temp_22 = not __t(b)
                __O[5] = ____temp_22
                if ____t_23(____temp_22) then
                    ____t_result_24 = __O[5]
                else
                    ____t_result_24 = awake
                end
                if ____t_25(____t_result_24) then
                    return
                end
                local ____self_26 = origFetch(
                    nil,
                    __add(b, "/api/health"),
                    {cache = "no-store", mode = "cors", credentials = "omit"}
                )
                ____self_26["then"](
                    ____self_26,
                    function(____, r)
                        awake = r.ok
                    end
                ):catch(function()
                end)
            end
        )
    end
    wake(nil)
    window:setInterval(
        function()
            awake = false
            if not __t(window.document.hidden) then
                wake(nil)
            end
        end,
        10 * 60 * 1000
    )
    window.fetch = function(self, input, init)
        local ____t_32 = __t
        local ____t_result_31
        local ____t_30 = __t
        local ____t_result_29
        local ____t_28 = __t
        local ____temp_27 = type(input) == "string"
        __O[6] = ____temp_27
        if ____t_28(____temp_27) then
            ____t_result_29 = __call(input, "startsWith", "/api/arena")
        else
            ____t_result_29 = __O[6]
        end
        __O[7] = ____t_result_29
        if ____t_30(____t_result_29) then
            ____t_result_31 = base
        else
            ____t_result_31 = __O[7]
        end
        if ____t_32(____t_result_31) then
            input = __add(base, input)
            local ____assign_35 = __assign
            local ____temp_34 = {}
            local ____t_result_33
            if __t(init) then
                ____t_result_33 = init
            else
                ____t_result_33 = {}
            end
            init = ____assign_35(____temp_34, ____t_result_33, {mode = "cors", credentials = "omit"})
        end
        return origFetch(nil, input, init)
    end
    local function wsUrl(self)
        local ____t_result_40
        local ____t_39 = __t
        local ____t_result_38
        local ____t_37 = __t
        local ____temp_36 = base == ""
        __O[8] = ____temp_36
        if ____t_37(____temp_36) then
            ____t_result_38 = sameOrigin
        else
            ____t_result_38 = __O[8]
        end
        if ____t_39(____t_result_38) then
            ____t_result_40 = window.location.origin
        else
            ____t_result_40 = base
        end
        local b = ____t_result_40
        if not __t(b) then
            return ""
        end
        return __add(
            __re_replace(
                b,
                __re("^http", ""),
                "ws"
            ),
            "/ws"
        )
    end
    local function set(self, url)
        local n = norm(nil, url)
        do
            pcall(function()
                if __t(n) then
                    window.localStorage:setItem(KEY, n)
                else
                    window.localStorage:removeItem(KEY)
                end
            end)
        end
        configured = n
        base = __t(sameOrigin) and "" or n
        return n
    end
    local function connect(self, opts)
        if opts == nil then
            opts = {}
        end
        local send, open, retry, kick, close, emit, ws, tok, closed, tries, pingT, ping, timer, pending, api
        function send(self, m)
            local ____t_52 = __t
            local ____t_result_51
            if __t(ws) then
                ____t_result_51 = ws.readyState == 1
            else
                ____t_result_51 = ws
            end
            if ____t_52(____t_result_51) then
                ws:send(window.JSON:stringify(m))
                return true
            end
            local ____t_56 = __t
            local ____t_result_55
            local ____t_54 = __t
            local ____temp_53 = m.t ~= "input" and m.t ~= "state"
            __O[11] = ____temp_53
            if ____t_54(____temp_53) then
                ____t_result_55 = m.t ~= "ping"
            else
                ____t_result_55 = __O[11]
            end
            if ____t_56(____t_result_55) then
                __call(pending, "push", m)
            end
            return false
        end
        function open(self)
            local ____t_result_57
            if __t(opts.url) then
                ____t_result_57 = opts.url
            else
                ____t_result_57 = wsUrl(nil)
            end
            local url = ____t_result_57
            if not __t(url) then
                emit(nil, "error", {m = "Nenhum servidor online configurado. Veja como em docs/SERVIDOR-ONLINE.md.", fatal = true})
                return
            end
            do
                local function ____catch(e)
                    return true, retry(nil)
                end
                local ____try, ____hasReturned, ____returnValue = pcall(function()
                    ws = __new("WebSocket", url)
                end)
                if not ____try then
                    ____hasReturned, ____returnValue = ____catch(____hasReturned)
                end
                if ____hasReturned then
                    return ____returnValue
                end
            end
            ws.onopen = function()
                tries = 0
                local ____ws_63 = ws
                local ____ws_send_64 = ws.send
                local ____self_61 = window.JSON
                local ____self_61_stringify_62 = ____self_61.stringify
                local ____t_result_58
                if __t(opts.name) then
                    ____t_result_58 = opts.name
                else
                    ____t_result_58 = "Jogador"
                end
                local ____opts_avatar_60 = opts.avatar
                local ____t_result_59
                if __t(tok) then
                    ____t_result_59 = tok
                else
                    ____t_result_59 = nil
                end
                ____ws_send_64(
                    ____ws_63,
                    ____self_61_stringify_62(____self_61, {
                        t = "hello",
                        v = 1,
                        name = ____t_result_58,
                        avatar = ____opts_avatar_60,
                        token = ____t_result_59
                    })
                )
                emit(nil, "status", {online = true})
                window:clearInterval(pingT)
                pingT = window:setInterval(
                    function() return send(
                        nil,
                        {
                            t = "ping",
                            c = window.performance:now()
                        }
                    ) end,
                    2000
                )
            end
            ws.onmessage = function(____, ev)
                local m
                do
                    local function ____catch(e)
                        return true
                    end
                    local ____try, ____hasReturned, ____returnValue = pcall(function()
                        m = window.JSON:parse(ev.data)
                    end)
                    if not ____try then
                        ____hasReturned, ____returnValue = ____catch(____hasReturned)
                    end
                    if ____hasReturned then
                        return ____returnValue
                    end
                end
                if m.t == "welcome" then
                    tok = m.token
                    api.id = m.id
                    local q = pending
                    pending = __arrL({}, 0)
                    __call(q, "forEach", send)
                end
                if m.t == "pong" then
                    local ____temp_65
                    if ping == nil then
                        ____temp_65 = window.performance:now() - m.c
                    else
                        ____temp_65 = ping * 0.7 + (window.performance:now() - m.c) * 0.3
                    end
                    ping = math.floor(____temp_65 + 0.5)
                end
                emit(nil, m.t, m)
            end
            ws.onclose = function()
                window:clearInterval(pingT)
                emit(nil, "status", {online = false})
                if not __t(closed) then
                    retry(nil)
                end
            end
            ws.onerror = function()
            end
        end
        function retry(self)
            if __t(closed) then
                return
            end
            tries = tries + 1
            if tries > 24 then
                emit(nil, "error", {m = "Não deu para falar com o servidor. Confira a internet.", fatal = true})
                return
            end
            window:clearTimeout(timer)
            timer = window:setTimeout(
                open,
                math.min(
                    8000,
                    400 * 2 ^ math.min(tries, 5)
                )
            )
        end
        function kick(self)
            do
                pcall(function()
                    if ws ~= nil then
                        ws:close()
                    end
                end)
            end
        end
        function close(self)
            closed = true
            window:clearTimeout(timer)
            window:clearInterval(pingT)
            do
                pcall(function()
                    local ____t_69 = __t
                    local ____t_result_68
                    if __t(ws) then
                        ____t_result_68 = ws.readyState == 1
                    else
                        ____t_result_68 = ws
                    end
                    if ____t_69(____t_result_68) then
                        ws:send(window.JSON:stringify({t = "leave"}))
                    end
                    if ws ~= nil then
                        ws:close()
                    end
                end)
            end
        end
        local handlers = {}
        local function on(____, t, fn)
            local ____call_46 = __call
            local ____set_45 = __set
            local ____t_44 = t
            local ____t_result_43
            local ____t_42 = __t
            local ____get_result_41 = __get(handlers, t)
            __O[9] = ____get_result_41
            if ____t_42(____get_result_41) then
                ____t_result_43 = __O[9]
            else
                ____t_result_43 = __arrL({}, 0)
            end
            ____call_46(
                ____set_45(handlers, ____t_44, ____t_result_43),
                "push",
                fn
            )
            return api
        end
        emit = function(____, t, m)
            local ____call_50 = __call
            local ____t_result_49
            local ____t_48 = __t
            local ____get_result_47 = __get(handlers, t)
            __O[10] = ____get_result_47
            if ____t_48(____get_result_47) then
                ____t_result_49 = __O[10]
            else
                ____t_result_49 = __arrL({}, 0)
            end
            return ____call_50(
                ____t_result_49,
                "forEach",
                function(____, fn)
                    do
                        local function ____catch(e)
                            print(e)
                        end
                        local ____try, ____hasReturned = pcall(function()
                            fn(nil, m)
                        end)
                        if not ____try then
                            ____catch(____hasReturned)
                        end
                    end
                end
            )
        end
        ws = nil
        tok = nil
        closed = false
        tries = 0
        pingT = 0
        ping = nil
        timer = 0
        pending = __arrL({}, 0)
        api = __getters(
            {
                on = on,
                send = send,
                close = close,
                kick = kick,
                id = nil
            },
            {
                ping = function()
                    return ping
                end,
                online = function()
                    return not not __t(ws) and ws.readyState == 1
                end
            }
        )
        ready["then"](ready, open)
        return api
    end
    window:setInterval(
        function()
            local join = window.document:getElementById("arenaJoin")
            local create = window.document:getElementById("arenaCreate")
            local codeIn = window.document:getElementById("arenaCode")
            local ____t_77 = __t
            local ____t_result_76
            local ____t_75 = __t
            local ____t_result_74
            local ____t_73 = __t
            local ____temp_72 = not __t(join) or not __t(create)
            __O[12] = ____temp_72
            if ____t_73(____temp_72) then
                ____t_result_74 = __O[12]
            else
                ____t_result_74 = not __t(codeIn)
            end
            __O[13] = ____t_result_74
            if ____t_75(____t_result_74) then
                ____t_result_76 = __O[13]
            else
                ____t_result_76 = window.document:getElementById("arenaQuick")
            end
            if ____t_77(____t_result_76) then
                return
            end
            local b = window.document:createElement("button")
            b.type = "button"
            b.id = "arenaQuick"
            b.className = join.className
            b.textContent = "SALA RÁPIDA"
            b:addEventListener(
                "click",
                function()
                    return __TS__AsyncAwaiter(function(____awaiter_resolve)
                        b.disabled = true
                        local ____try = __TS__AsyncAwaiter(function()
                            __TS__Await(ready)
                            local r = __TS__Await(window:fetch(
                                "/api/arena/rooms/quick",
                                {
                                    method = "POST",
                                    headers = {["Content-Type"] = "application/json"},
                                    body = window.JSON:stringify({find = true, mode = "arena", protocol = 3})
                                }
                            ))
                            local j = __TS__Await(r:json())
                            if __t(j.code) then
                                codeIn.value = j.code
                                codeIn:dispatchEvent(__new("Event", "input", {bubbles = true}))
                                join:click()
                            else
                                create:click()
                            end
                        end)
                        ____try = ____try.catch(
                            ____try,
                            function(____, e)
                                return __TS__AsyncAwaiter(function()
                                    create:click()
                                end)
                            end
                        )
                        __TS__Await(____try)
                        b.disabled = false
                    end)
                end
            )
            join:after(b)
        end,
        1000
    )
    window.DarocaOnline = __ord(
        {
            ready = ready,
            base = function() return base end,
            configured = function() return configured end,
            sameOrigin = function() return sameOrigin end,
            wsUrl = wsUrl,
            set = set,
            connect = connect,
            hasServer = function()
                local ____t_79 = __t
                local ____t_result_78
                if __t(base) then
                    ____t_result_78 = base
                else
                    ____t_result_78 = sameOrigin
                end
                return not not ____t_79(____t_result_78)
            end
        },
        "ready,base,configured,sameOrigin,wsUrl,set,connect,hasServer"
    )
end)(nil)
return ____exports
