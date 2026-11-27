--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __t, __get, __call, __add, __re, __re_test, __re_replace = __JSR.__t, __JSR.__get, __JSR.__call, __JSR.__add, __JSR.__re, __JSR.__re_test, __JSR.__re_replace
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Number = ____lualib.__TS__Number
local ____exports = {}
local __O = {};
(function(self)
    local ____ = "use strict"
    local cur = if __t(window.DAROCA_APP_VERSION) then window.DAROCA_APP_VERSION else {}
    local LATER = "daroca-update-later"
    if __t(not __t(cur.updateUrl) or window.location.protocol == "file:") then
        return
    end
    local function store(self, get, k, v)
        do
            local function ____catch(e)
                return true, nil
            end
            local ____try, ____hasReturned, ____returnValue = pcall(function()
                return true, if __t(get) then window.localStorage:getItem(k) else window.localStorage:setItem(k, v)
            end)
            if not ____try then
                ____hasReturned, ____returnValue = ____catch(____hasReturned)
            end
            if ____hasReturned then
                return ____returnValue
            end
        end
    end
    local function esc(self, s)
        return __re_replace(
            tostring(s),
            __re("[&<>\"']", "g"),
            function(____, c) return __get({
                ["&"] = "&amp;",
                ["<"] = "&lt;",
                [">"] = "&gt;",
                ["\""] = "&quot;",
                ["'"] = "&#39;"
            }, c) end
        )
    end
    local function show(self, info)
        if __t(window.document:querySelector(".app-update-notice")) then
            return
        end
        local box = window.document:createElement("aside")
        box.className = "app-update-notice"
        box:setAttribute("role", "dialog")
        box:setAttribute("aria-label", "Nova versão")
        local url = if __t(type(info.url) == "string" and __re_test(
            __re("^(https:\\/\\/|\\/)", ""),
            info.url
        )) then info.url else ""
        local ____add_7 = __add
        local ____add_6 = __add
        local ____add_5 = __add
        local ____add_4 = __add
        local ____add_result_3 = __add(
            __add(
                __add(
                    __add(
                        __add("<span>ATUALIZAÇÃO DISPONÍVEL</span><button class=\"app-update-close\" type=\"button\" aria-label=\"Fechar\">×</button>", "<h2>Versão "),
                        esc(nil, if __t(info.versionName) then info.versionName else info.versionCode)
                    ),
                    "</h2>"
                ),
                if __t(info.notes) then __add(
                    __add(
                        "<p>",
                        esc(
                            nil,
                            __call(
                                tostring(info.notes),
                                "slice",
                                0,
                                400
                            )
                        )
                    ),
                    "</p>"
                ) else ""
            ),
            "<small>Você está na versão "
        )
        local ____esc_2 = esc
        local ____t_1 = __t
        local ____temp_0 = if __t(cur.versionName) then cur.versionName else cur.versionCode
        __O[3141] = ____temp_0
        box.innerHTML = ____add_7(
            ____add_6(
                ____add_5(
                    ____add_4(
                        ____add_result_3,
                        ____esc_2(nil, if ____t_1(____temp_0) then __O[3141] else "?")
                    ),
                    ". Seu progresso fica salvo.</small>"
                ),
                if __t(url) then "<button class=\"app-update-download\" type=\"button\">BAIXAR</button>" else "<button class=\"app-update-download\" type=\"button\">RECARREGAR</button>"
            ),
            "<button class=\"app-update-later\" type=\"button\">DEPOIS</button>"
        )
        local function close()
            return box:remove()
        end
        box:querySelector(".app-update-close").onclick = close
        box:querySelector(".app-update-later").onclick = function()
            store(
                nil,
                false,
                LATER,
                tostring(info.versionCode)
            )
            close(nil)
        end
        box:querySelector(".app-update-download").onclick = function()
            if __t(url) then
                window.location.href = url
            else
                window.location:reload()
            end
        end
        window.document.body:appendChild(box)
    end
    local function check(self)
        local ____self_14 = window:fetch(cur.updateUrl, {cache = "no-store"})
        local ____self_8 = ____self_14["then"](
            ____self_14,
            function(____, r)
                local ____t_13 = __t
                local ____re_test_12 = __re_test
                local ____re_result_11 = __re("json", "")
                local ____t_10 = __t
                local ____call_result_9 = __call(r.headers, "get", "content-type")
                __O[3142] = ____call_result_9
                return if ____t_13(if __t(r.ok) then ____re_test_12(____re_result_11, if ____t_10(____call_result_9) then __O[3142] else "") else r.ok) then r:json() else nil
            end
        )
        ____self_8["then"](
            ____self_8,
            function(____, info)
                if __t(not __t(info) or not (__TS__Number(info.versionCode) > __TS__Number(if __t(cur.versionCode) then cur.versionCode else 0))) then
                    return
                end
                if store(nil, true, LATER) == tostring(info.versionCode) then
                    return
                end
                show(nil, info)
            end
        ):catch(function()
        end)
    end
    if window.document.readyState == "complete" then
        window:setTimeout(check, 4000)
    else
        window:addEventListener(
            "load",
            function() return window:setTimeout(check, 4000) end
        )
    end
end)(nil)
return ____exports
