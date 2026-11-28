--!native
--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __ord, __arrL, __iterar, __t, __get, __call, __add, __re, __re_test, __re_exec = __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__call, __JSR.__add, __JSR.__re, __JSR.__re_test, __JSR.__re_exec
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Number = ____lualib.__TS__Number
local Set = ____lualib.Set
local __TS__New = ____lualib.__TS__New
local __TS__Iterator = ____lualib.__TS__Iterator
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    local KEY = "daroca-graphics-v1"
    local function read()
        do
            local function ____catch(e)
                return true, nil
            end
            local ____try, ____hasReturned, ____returnValue = pcall(function()
                return true, window.localStorage:getItem(KEY)
            end)
            if not ____try then
                ____hasReturned, ____returnValue = ____catch(____hasReturned)
            end
            if ____hasReturned then
                return ____returnValue
            end
        end
    end
    local function write(____, v)
        do
            pcall(function()
                window.localStorage:setItem(KEY, v)
            end)
        end
    end
    local OLD = __ord({lite = "low", full = "medium", shader = "high"}, "lite,full,shader")
    local LEVELS = __arrL({"low", "medium", "high"}, 3)
    local function webgl()
        do
            local function ____catch(e)
                return true, false
            end
            local ____try, ____hasReturned, ____returnValue = pcall(function()
                local c = window.document:createElement("canvas")
                return true, not not __t(c:getContext("webgl"))
            end)
            if not ____try then
                ____hasReturned, ____returnValue = ____catch(____hasReturned)
            end
            if ____hasReturned then
                return ____returnValue
            end
        end
    end
    local function detect(self)
        local ____t_result_0
        if __t(window.navigator.userAgent) then
            ____t_result_0 = window.navigator.userAgent
        else
            ____t_result_0 = ""
        end
        local ua = ____t_result_0
        local ____t_result_3
        local ____t_2 = __t
        local ____TS__Number_result_1 = __TS__Number(window.navigator.deviceMemory)
        __O[14] = ____TS__Number_result_1
        if ____t_2(____TS__Number_result_1) then
            ____t_result_3 = __O[14]
        else
            ____t_result_3 = 4
        end
        local mem = ____t_result_3
        local ____t_result_6
        local ____t_5 = __t
        local ____TS__Number_result_4 = __TS__Number(window.navigator.hardwareConcurrency)
        __O[15] = ____TS__Number_result_4
        if ____t_5(____TS__Number_result_4) then
            ____t_result_6 = __O[15]
        else
            ____t_result_6 = 4
        end
        local cores = ____t_result_6
        local tv = __re_test(
            __re("Android TV|GoogleTV|BRAVIA|AFT[A-Z]|SmartTV|SMART-TV|Tizen|WebOS|HbbTV|CrKey", "i"),
            ua
        )
        local ____t_result_9
        local ____t_8 = __t
        local ____re_test_result_7 = __re_test(
            __re("Android|iPhone|iPad|iPod|Mobile", "i"),
            ua
        )
        __O[16] = ____re_test_result_7
        if ____t_8(____re_test_result_7) then
            ____t_result_9 = __O[16]
        else
            ____t_result_9 = window.navigator.maxTouchPoints > 1 and math.min(window.screen.width, window.screen.height) < 820
        end
        local mobile = ____t_result_9
        if __t(tv) then
            return {kind = "tv", level = "medium"}
        end
        local ____t_result_12
        local ____t_11 = __t
        local ____re_test_result_10 = __re_test(
            __re("iPhone|iPad|iPod", "i"),
            ua
        )
        __O[17] = ____re_test_result_10
        if ____t_11(____re_test_result_10) then
            ____t_result_12 = __O[17]
        else
            ____t_result_12 = __re_test(
                __re("Macintosh", "i"),
                ua
            ) and window.navigator.maxTouchPoints > 1
        end
        local ios = ____t_result_12
        if __t(ios) then
            return {kind = "mobile", level = "medium"}
        end
        if __t(mobile) then
            return {
                kind = "mobile",
                level = __t(mem <= 3 or cores <= 4) and "low" or "medium"
            }
        end
        return {
            kind = "desktop",
            level = __t(webgl(nil)) and "high" or "medium"
        }
    end
    local device = detect(nil)
    local ____t_result_15
    local ____t_14 = __t
    local ____read_result_13 = read(nil)
    __O[18] = ____read_result_13
    if ____t_14(____read_result_13) then
        ____t_result_15 = __O[18]
    else
        ____t_result_15 = "auto"
    end
    local stored = ____t_result_15
    local mode = "auto"
    local autoLevel = device.level
    if __t(__get(OLD, stored)) then
        mode = __get(OLD, stored)
    elseif __t(__call(LEVELS, "includes", stored)) then
        mode = stored
    elseif __re_test(
        __re("^auto-(low|medium|high)$", ""),
        stored
    ) then
        autoLevel = __call(stored, "slice", 5)
    elseif stored == "auto-lite" then
        autoLevel = "low"
    end
    local listeners = __TS__New(Set)
    local function level()
        local ____temp_16
        if mode == "auto" then
            ____temp_16 = autoLevel
        else
            ____temp_16 = mode
        end
        local l = ____temp_16
        local ____t_24 = __t
        local ____temp_23 = l == "high"
        if ____temp_23 then
            local ____t_22 = __t
            local ____opt_19 = window.Shader
            if ____opt_19 ~= nil then
                ____opt_19 = ____opt_19.supported
            end
            local ____opt_result_21
            if ____opt_19 ~= nil then
                ____opt_result_21 = ____opt_19(____opt_19)
            end
            ____temp_23 = not ____t_22(____opt_result_21)
        end
        return ____t_24(____temp_23) and "medium" or l
    end
    local function isLite()
        return level(nil) == "low"
    end
    local function isShader()
        return level(nil) == "high"
    end
    local function apply(self)
        window.document.documentElement.dataset.graphics = __t(isShader(nil)) and "shader" or (__t(isLite(nil)) and "lite" or "full")
        window.document.documentElement.dataset.quality = level(nil)
        for ____, fn in __iterar((listeners)) do
            do
                pcall(function()
                    fn(
                        nil,
                        isLite(nil)
                    )
                end)
            end
        end
    end
    local function set(self, next)
        local ____t_result_27
        local ____t_26 = __t
        local ____get_result_25 = __get(OLD, next)
        __O[19] = ____get_result_25
        if ____t_26(____get_result_25) then
            ____t_result_27 = __O[19]
        else
            ____t_result_27 = next
        end
        next = ____t_result_27
        local autoDe = __re_exec(
            __re("^auto-(low|medium|high)$", ""),
            tostring(next)
        )
        local ____t_result_28
        if __t(__call(LEVELS, "includes", next)) then
            ____t_result_28 = next
        else
            ____t_result_28 = "auto"
        end
        mode = ____t_result_28
        if mode == "auto" then
            local ____t_result_29
            if __t(autoDe) then
                ____t_result_29 = __get(autoDe, 1)
            else
                ____t_result_29 = device.level
            end
            autoLevel = ____t_result_29
        end
        write(nil, mode == "auto" and "auto" or mode)
        apply(nil)
    end
    local NAMES = __ord({low = "BAIXA", medium = "MÉDIA", high = "ALTA"}, "low,medium,high")
    local function label(self)
        local ____temp_30
        if mode == "auto" then
            ____temp_30 = __add(
                __add(
                    "AUTO (",
                    __get(
                        NAMES,
                        level(nil)
                    )
                ),
                ")"
            )
        else
            ____temp_30 = __get(
                NAMES,
                level(nil)
            )
        end
        return ____temp_30
    end
    local function describe(self)
        local l = level(nil)
        local what = l == "high" and "Luz com relevo, brilho, raios de sol, névoa e reflexo na água." or (l == "medium" and "Cenários novos, hora do dia, clima e partículas." or "Sem efeitos, para aparelhos simples.")
        return __add(
            __add(mode == "auto" and "Escolhida pelo aparelho. " or "", what),
            " Toque para trocar."
        )
    end
    local function profile()
        return __get(
            {low = {particles = 0, weather = false}, medium = {particles = 0.6, weather = true}, high = {particles = 1, weather = true}},
            level(nil)
        )
    end
    local last = 0
    local slow = 0
    local samples = 0
    local sum = 0
    local function watch(self, now)
        local ____t_32 = __t
        local ____t_result_31
        if __t(last) then
            ____t_result_31 = not __t(window.document.hidden)
        else
            ____t_result_31 = last
        end
        if ____t_32(____t_result_31) then
            local dt = now - last
            if dt < 250 then
                sum = sum + dt
                samples = samples + 1
            end
            if samples >= 120 then
                local avg = sum / samples
                sum = 0
                samples = 0
                local ____temp_33
                if avg > 26 then
                    ____temp_33 = slow + 1
                else
                    ____temp_33 = math.max(0, slow - 1)
                end
                slow = ____temp_33
                local ____t_37 = __t
                local ____t_result_36
                local ____t_35 = __t
                local ____temp_34 = slow >= 3 and mode == "auto"
                __O[20] = ____temp_34
                if ____t_35(____temp_34) then
                    ____t_result_36 = autoLevel ~= "low"
                else
                    ____t_result_36 = __O[20]
                end
                if ____t_37(____t_result_36) then
                    autoLevel = autoLevel == "high" and "medium" or "low"
                    slow = 0
                    write(
                        nil,
                        __add("auto-", autoLevel)
                    )
                    apply(nil)
                    local toast = window.document:getElementById("toast")
                    if __t(toast) then
                        toast.textContent = __add(
                            __add(
                                "Qualidade ",
                                __get(NAMES, autoLevel)
                            ),
                            " ligada para o jogo rodar liso. Dá para trocar na pausa."
                        )
                        toast.hidden = false
                        __call(toast.classList, "add", "show")
                        window:setTimeout(
                            function()
                                toast.classList:remove("show")
                                toast.hidden = true
                            end,
                            4200
                        )
                    end
                end
            end
        end
        last = now
        window:requestAnimationFrame(watch)
    end
    window:requestAnimationFrame(watch)
    apply(nil)
    window:addEventListener("DOMContentLoaded", apply)
    window.Graphics = __ord(
        {
            isLite = isLite,
            isShader = isShader,
            set = set,
            label = label,
            describe = describe,
            level = level,
            profile = profile,
            device = function() return device.kind end,
            getMode = function() return mode end,
            toggle = function()
                local ____set_47 = set
                local ____temp_46
                if mode == "auto" then
                    ____temp_46 = "low"
                else
                    local ____temp_45
                    if mode == "low" then
                        ____temp_45 = "medium"
                    else
                        local ____temp_44
                        if mode == "medium" then
                            local ____t_43 = __t
                            local ____opt_40 = window.Shader
                            if ____opt_40 ~= nil then
                                ____opt_40 = ____opt_40.supported
                            end
                            local ____opt_result_42
                            if ____opt_40 ~= nil then
                                ____opt_result_42 = ____opt_40(____opt_40)
                            end
                            ____temp_44 = ____t_43(____opt_result_42) and "high" or "auto"
                        else
                            ____temp_44 = "auto"
                        end
                        ____temp_45 = ____temp_44
                    end
                    ____temp_46 = ____temp_45
                end
                return ____set_47(nil, ____temp_46)
            end,
            onChange = function(____, fn)
                __call(listeners, "add", fn)
                return function() return __call(listeners, "delete", fn) end
            end
        },
        "isLite,isShader,set,label,describe,level,profile,device,getMode,toggle,onChange"
    )
end)(nil)
return ____exports
