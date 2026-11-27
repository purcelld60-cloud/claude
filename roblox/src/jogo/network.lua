--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __t, __len, __call, __add, __new, __assign, __re, __re_test = __JSR.__t, __JSR.__len, __JSR.__call, __JSR.__add, __JSR.__new, __JSR.__assign, __JSR.__re, __JSR.__re_test
local ____lualib = require(script.Parent.lualib_bundle)
local Map = ____lualib.Map
local __TS__New = ____lualib.__TS__New
local Error = ____lualib.Error
local RangeError = ____lualib.RangeError
local ReferenceError = ____lualib.ReferenceError
local SyntaxError = ____lualib.SyntaxError
local TypeError = ____lualib.TypeError
local URIError = ____lualib.URIError
local __TS__Promise = ____lualib.__TS__Promise
local __TS__Number = ____lualib.__TS__Number
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    local pending = __TS__New(Map)
    local serial = 0
    local function safePath(____, path)
        return __re_test(
            __re("^\\/api\\/arena\\/rooms(?:\\/[A-Z0-9]{6}(?:\\/(?:join|sync|leave|signal))?)?$", ""),
            path
        )
    end
    local function request(self, path, options)
        if options == nil then
            options = {}
        end
        if __t(not __t(safePath(nil, path)) or options.method ~= "POST") then
            return __TS__Promise.reject(__TS__New(Error, "Pedido de arena inválido."))
        end
        local body = if type(options.body) == "string" then options.body else window.JSON:stringify(if __t(options.body) then options.body else {})
        if __len(__new("TextEncoder"):encode(body)) > 65536 then
            return __TS__Promise.reject(__TS__New(Error, "Pedido de arena muito grande."))
        end
        local ____t_2 = __t
        local ____opt_0 = window.DaRocaArena
        if ____opt_0 ~= nil then
            ____opt_0 = ____opt_0.request
        end
        __O[2459] = ____opt_0
        local ____opt_5 = window.webkit
        if ____opt_5 ~= nil then
            ____opt_5 = ____opt_5.messageHandlers
        end
        local ____opt_result_7
        if ____opt_5 ~= nil then
            ____opt_result_7 = ____opt_5.arenaRequest
        end
        local native = if ____t_2(____opt_0) then __O[2459] else ____opt_result_7
        if not __t(native) then
            return window:fetch(
                path,
                __assign(
                    {},
                    options,
                    {
                        body = body,
                        credentials = "omit",
                        cache = "no-store",
                        headers = __assign({}, {["Content-Type"] = "application/json"}, options.headers)
                    }
                )
            )
        end
        return __TS__New(
            __TS__Promise,
            function(____, resolve, reject)
                local ____add_9 = __add
                local ____add_result_8 = __add(
                    __add(
                        "arena_",
                        __call(
                            window.Date:now(),
                            "toString",
                            36
                        )
                    ),
                    "_"
                )
                serial = serial + 1
                local id = ____add_9(____add_result_8, serial)
                local ____t_11 = __t
                local ____call_result_10 = __call(
                    __TS__New(window.Headers, if __t(options.headers) then options.headers else {}),
                    "get",
                    "Authorization"
                )
                __O[2460] = ____call_result_10
                local authorization = if ____t_11(____call_result_10) then __O[2460] else ""
                local timer = window:setTimeout(
                    function()
                        __call(pending, "delete", id)
                        reject(
                            nil,
                            __TS__New(Error, "A arena demorou para responder. Confira a internet.")
                        )
                    end,
                    18000
                )
                __call(pending, "set", id, {resolve = resolve, reject = reject, timer = timer})
                do
                    local function ____catch(____error)
                        window:clearTimeout(timer)
                        __call(pending, "delete", id)
                        reject(nil, ____error)
                    end
                    local ____try, ____hasReturned = pcall(function()
                        local ____t_14 = __t
                        local ____opt_12 = window.DaRocaArena
                        if ____opt_12 ~= nil then
                            ____opt_12 = ____opt_12.request
                        end
                        if ____t_14(____opt_12) then
                            window.DaRocaArena:request(
                                id,
                                path,
                                "POST",
                                body,
                                authorization
                            )
                        else
                            window.webkit.messageHandlers.arenaRequest:postMessage({
                                id = id,
                                path = path,
                                method = "POST",
                                body = body,
                                authorization = authorization
                            })
                        end
                    end)
                    if not ____try then
                        ____catch(____hasReturned)
                    end
                end
            end
        )
    end
    window:addEventListener(
        "daroca-arena-response",
        function(____, event)
            local detail = if __t(event.detail) then event.detail else {}
            local entry = __call(pending, "get", detail.id)
            if not __t(entry) then
                return
            end
            __call(pending, "delete", detail.id)
            window:clearTimeout(entry.timer)
            local ____entry_resolve_19 = entry.resolve
            local ____window_Response_18 = window.Response
            local ____temp_17 = if __t(detail.body) then detail.body else "{}"
            local ____t_16 = __t
            local ____TS__Number_result_15 = __TS__Number(detail.status)
            __O[2461] = ____TS__Number_result_15
            ____entry_resolve_19(
                entry,
                __TS__New(
                    ____window_Response_18,
                    ____temp_17,
                    {
                        status = math.max(
                            200,
                            math.min(599, if ____t_16(____TS__Number_result_15) then __O[2461] else 503)
                        ),
                        headers = {["Content-Type"] = "application/json"}
                    }
                )
            )
        end
    )
    window.DaRocaNetwork = {request = request}
end)(nil)
return ____exports
