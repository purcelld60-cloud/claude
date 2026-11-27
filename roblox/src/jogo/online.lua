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
                local ____window_6 = window
                local ____ord_5 = __ord
                local ____port_4 = port
                local ____re_test_3 = __re_test
                local ____re_result_2 = __re("^[0-9.]{7,15}$", "")
                local ____t_1 = __t
                local ____call_result_0 = __call(q, "get", "tvip")
                __O[2] = ____call_result_0
                ____window_6.DAROCA_TV = ____ord_5({port = ____port_4, ip = if ____re_test_3(____re_result_2, if ____t_1(____call_result_0) then __O[2] else "") then __call(q, "get", "tvip") else ""}, "port,ip")
            end
        end)
    end
    local function norm(____, u)
        do
            local function ____catch(e)
                return true, ""
            end
            local ____try, ____hasReturned, ____returnValue = pcall(function()
                local x = __new(
                    "URL",
                    __call(
                        tostring(if __t(u) then u else ""),
                        "trim"
                    )
                )
                return true, if __re_test(
                    __re("^https?:$", ""),
                    x.protocol
                ) then x.origin else ""
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
            local ____t_8 = __t
            local ____temp_7 = window.localStorage:getItem(KEY)
            __O[3] = ____temp_7
            configured = if ____t_8(____temp_7) then __O[3] else ""
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
                ____hasReturned = true
                ____returnValue = if __t(j) then j.server == "daroca" else j
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
            local ____t_11 = __t
            local ____t_10 = __t
            local ____re_test_result_9 = __re_test(
                __re("^https?:$", ""),
                window.location.protocol
            )
            __O[4] = ____re_test_result_9
            if ____t_11(if ____t_10(____re_test_result_9) then __TS__Await(probe(nil, "")) else __O[4]) then
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
            base = if __t(configured) then configured else ""
            return ____awaiter_resolve(nil, base)
        end)
    end)(nil)
    local awake = false
    local function wake()
        return ready["then"](
            ready,
            function(____, b)
                local ____t_14 = __t
                local ____t_13 = __t
                local ____temp_12 = not __t(b)
                __O[5] = ____temp_12
                if ____t_14(if ____t_13(____temp_12) then __O[5] else awake) then
                    return
                end
                local ____self_15 = origFetch(
                    nil,
                    __add(b, "/api/health"),
                    {cache = "no-store", mode = "cors", credentials = "omit"}
                )
                ____self_15["then"](
                    ____self_15,
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
        local ____t_20 = __t
        local ____t_19 = __t
        local ____t_17 = __t
        local ____temp_16 = type(input) == "string"
        __O[6] = ____temp_16
        local ____temp_18 = if ____t_17(____temp_16) then __call(input, "startsWith", "/api/arena") else __O[6]
        __O[7] = ____temp_18
        if ____t_20(if ____t_19(____temp_18) then base else __O[7]) then
            input = __add(base, input)
            init = __assign({}, if __t(init) then init else {}, {mode = "cors", credentials = "omit"})
        end
        return origFetch(nil, input, init)
    end
    local function wsUrl(self)
        local ____t_23 = __t
        local ____t_22 = __t
        local ____temp_21 = base == ""
        __O[8] = ____temp_21
        local b = if ____t_23(if ____t_22(____temp_21) then sameOrigin else __O[8]) then window.location.origin else base
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
        base = if __t(sameOrigin) then "" else n
        return n
    end
    local function connect(self, opts)
        if opts == nil then
            opts = {}
        end
        local send, open, retry, kick, close, emit, ws, tok, closed, tries, pingT, ping, timer, pending, api
        function send(self, m)
            if __t(if __t(ws) then ws.readyState == 1 else ws) then
                ws:send(window.JSON:stringify(m))
                return true
            end
            local ____t_34 = __t
            local ____t_33 = __t
            local ____temp_32 = m.t ~= "input" and m.t ~= "state"
            __O[11] = ____temp_32
            if ____t_34(if ____t_33(____temp_32) then m.t ~= "ping" else __O[11]) then
                __call(pending, "push", m)
            end
            return false
        end
        function open(self)
            local url = if __t(opts.url) then opts.url else wsUrl(nil)
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
                ws:send(window.JSON:stringify({
                    t = "hello",
                    v = 1,
                    name = if __t(opts.name) then opts.name else "Jogador",
                    avatar = opts.avatar,
                    token = if __t(tok) then tok else nil
                }))
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
                    ping = math.floor(if ping == nil then window.performance:now() - m.c else ping * 0.7 + (window.performance:now() - m.c) * 0.3 + 0.5)
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
                    if __t(if __t(ws) then ws.readyState == 1 else ws) then
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
            local ____call_28 = __call
            local ____set_27 = __set
            local ____t_26 = t
            local ____t_25 = __t
            local ____get_result_24 = __get(handlers, t)
            __O[9] = ____get_result_24
            ____call_28(
                ____set_27(handlers, ____t_26, if ____t_25(____get_result_24) then __O[9] else __arrL({}, 0)),
                "push",
                fn
            )
            return api
        end
        emit = function(____, t, m)
            local ____call_31 = __call
            local ____t_30 = __t
            local ____get_result_29 = __get(handlers, t)
            __O[10] = ____get_result_29
            return ____call_31(
                if ____t_30(____get_result_29) then __O[10] else __arrL({}, 0),
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
            local ____t_43 = __t
            local ____t_42 = __t
            local ____t_40 = __t
            local ____temp_39 = not __t(join) or not __t(create)
            __O[12] = ____temp_39
            local ____temp_41 = if ____t_40(____temp_39) then __O[12] else not __t(codeIn)
            __O[13] = ____temp_41
            if ____t_43(if ____t_42(____temp_41) then __O[13] else window.document:getElementById("arenaQuick")) then
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
            hasServer = function() return not not __t(if __t(base) then base else sameOrigin) end
        },
        "ready,base,configured,sameOrigin,wsUrl,set,connect,hasServer"
    )
end)(nil)
return ____exports
