--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __newExpr, __t, __len, __call, __add, __new, __assign, __re, __re_test = __JSR.__newExpr, __JSR.__t, __JSR.__len, __JSR.__call, __JSR.__add, __JSR.__new, __JSR.__assign, __JSR.__re, __JSR.__re_test
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
        local ____temp_3
        if type(options.body) == "string" then
            ____temp_3 = options.body
        else
            local ____self_1 = window.JSON
            local ____self_1_stringify_2 = ____self_1.stringify
            local ____t_result_0
            if __t(options.body) then
                ____t_result_0 = options.body
            else
                ____t_result_0 = {}
            end
            ____temp_3 = ____self_1_stringify_2(____self_1, ____t_result_0)
        end
        local body = ____temp_3
        if __len(__new("TextEncoder"):encode(body)) > 65536 then
            return __TS__Promise.reject(__TS__New(Error, "Pedido de arena muito grande."))
        end
        local ____t_result_12
        local ____t_6 = __t
        local ____opt_4 = window.DaRocaArena
        if ____opt_4 ~= nil then
            ____opt_4 = ____opt_4.request
        end
        __O[2509] = ____opt_4
        if ____t_6(____opt_4) then
            ____t_result_12 = __O[2509]
        else
            local ____opt_9 = window.webkit
            if ____opt_9 ~= nil then
                ____opt_9 = ____opt_9.messageHandlers
            end
            local ____opt_result_11
            if ____opt_9 ~= nil then
                ____opt_result_11 = ____opt_9.arenaRequest
            end
            ____t_result_12 = ____opt_result_11
        end
        local native = ____t_result_12
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
                local ____add_14 = __add
                local ____add_result_13 = __add(
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
                local id = ____add_14(____add_result_13, serial)
                local ____t_result_21
                local ____t_20 = __t
                local ____call_18 = __call
                local ____newExpr_17 = __newExpr
                local ____window_Headers_16 = window.Headers
                local ____t_result_15
                if __t(options.headers) then
                    ____t_result_15 = options.headers
                else
                    ____t_result_15 = {}
                end
                local ____call_18_result_19 = ____call_18(
                    ____newExpr_17(____window_Headers_16, ____t_result_15),
                    "get",
                    "Authorization"
                )
                __O[2510] = ____call_18_result_19
                if ____t_20(____call_18_result_19) then
                    ____t_result_21 = __O[2510]
                else
                    ____t_result_21 = ""
                end
                local authorization = ____t_result_21
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
                        local ____t_24 = __t
                        local ____opt_22 = window.DaRocaArena
                        if ____opt_22 ~= nil then
                            ____opt_22 = ____opt_22.request
                        end
                        if ____t_24(____opt_22) then
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
            local ____t_result_25
            if __t(event.detail) then
                ____t_result_25 = event.detail
            else
                ____t_result_25 = {}
            end
            local detail = ____t_result_25
            local entry = __call(pending, "get", detail.id)
            if not __t(entry) then
                return
            end
            __call(pending, "delete", detail.id)
            window:clearTimeout(entry.timer)
            local ____entry_resolve_32 = entry.resolve
            local ____newExpr_31 = __newExpr
            local ____window_Response_30 = window.Response
            local ____t_result_26
            if __t(detail.body) then
                ____t_result_26 = detail.body
            else
                ____t_result_26 = "{}"
            end
            local ____t_result_29
            local ____t_28 = __t
            local ____TS__Number_result_27 = __TS__Number(detail.status)
            __O[2511] = ____TS__Number_result_27
            if ____t_28(____TS__Number_result_27) then
                ____t_result_29 = __O[2511]
            else
                ____t_result_29 = 503
            end
            ____entry_resolve_32(
                entry,
                ____newExpr_31(
                    ____window_Response_30,
                    ____t_result_26,
                    {
                        status = math.max(
                            200,
                            math.min(599, ____t_result_29)
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
