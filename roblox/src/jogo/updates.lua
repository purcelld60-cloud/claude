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
    local ____t_result_0
    if __t(window.DAROCA_APP_VERSION) then
        ____t_result_0 = window.DAROCA_APP_VERSION
    else
        ____t_result_0 = {}
    end
    local cur = ____t_result_0
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
                local ____t_result_1
                if __t(get) then
                    ____t_result_1 = window.localStorage:getItem(k)
                else
                    ____t_result_1 = window.localStorage:setItem(k, v)
                end
                return true, ____t_result_1
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
        local ____t_result_2
        if __t(type(info.url) == "string" and __re_test(
            __re("^(https:\\/\\/|\\/)", ""),
            info.url
        )) then
            ____t_result_2 = info.url
        else
            ____t_result_2 = ""
        end
        local url = ____t_result_2
        local ____add_20 = __add
        local ____add_19 = __add
        local ____add_18 = __add
        local ____add_17 = __add
        local ____add_11 = __add
        local ____add_10 = __add
        local ____add_7 = __add
        local ____add_6 = __add
        local ____add_result_5 = __add("<span>ATUALIZAÇÃO DISPONÍVEL</span><button class=\"app-update-close\" type=\"button\" aria-label=\"Fechar\">×</button>", "<h2>Versão ")
        local ____esc_4 = esc
        local ____t_result_3
        if __t(info.versionName) then
            ____t_result_3 = info.versionName
        else
            ____t_result_3 = info.versionCode
        end
        local ____add_7_result_9 = ____add_7(
            ____add_6(
                ____add_result_5,
                ____esc_4(nil, ____t_result_3)
            ),
            "</h2>"
        )
        local ____t_result_8
        if __t(info.notes) then
            ____t_result_8 = __add(
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
            )
        else
            ____t_result_8 = ""
        end
        local ____add_11_result_16 = ____add_11(
            ____add_10(____add_7_result_9, ____t_result_8),
            "<small>Você está na versão "
        )
        local ____esc_15 = esc
        local ____t_result_14
        local ____t_13 = __t
        local ____t_result_12
        if __t(cur.versionName) then
            ____t_result_12 = cur.versionName
        else
            ____t_result_12 = cur.versionCode
        end
        __O[3187] = ____t_result_12
        if ____t_13(____t_result_12) then
            ____t_result_14 = __O[3187]
        else
            ____t_result_14 = "?"
        end
        box.innerHTML = ____add_20(
            ____add_19(
                ____add_18(
                    ____add_17(
                        ____add_11_result_16,
                        ____esc_15(nil, ____t_result_14)
                    ),
                    ". Seu progresso fica salvo.</small>"
                ),
                __t(url) and "<button class=\"app-update-download\" type=\"button\">BAIXAR</button>" or "<button class=\"app-update-download\" type=\"button\">RECARREGAR</button>"
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
        local ____self_34 = window:fetch(cur.updateUrl, {cache = "no-store"})
        local ____self_25 = ____self_34["then"](
            ____self_34,
            function(____, r)
                local ____t_result_33
                local ____t_32 = __t
                local ____t_result_31
                if __t(r.ok) then
                    local ____re_test_30 = __re_test
                    local ____re_result_29 = __re("json", "")
                    local ____t_result_28
                    local ____t_27 = __t
                    local ____call_result_26 = __call(r.headers, "get", "content-type")
                    __O[3188] = ____call_result_26
                    if ____t_27(____call_result_26) then
                        ____t_result_28 = __O[3188]
                    else
                        ____t_result_28 = ""
                    end
                    ____t_result_31 = ____re_test_30(____re_result_29, ____t_result_28)
                else
                    ____t_result_31 = r.ok
                end
                if ____t_32(____t_result_31) then
                    ____t_result_33 = r:json()
                else
                    ____t_result_33 = nil
                end
                return ____t_result_33
            end
        )
        ____self_25["then"](
            ____self_25,
            function(____, info)
                local ____t_24 = __t
                local ____temp_23 = not __t(info)
                if not ____temp_23 then
                    local ____TS__Number_result_22 = __TS__Number(info.versionCode)
                    local ____t_result_21
                    if __t(cur.versionCode) then
                        ____t_result_21 = cur.versionCode
                    else
                        ____t_result_21 = 0
                    end
                    ____temp_23 = not (____TS__Number_result_22 > __TS__Number(____t_result_21))
                end
                if ____t_24(____temp_23) then
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
