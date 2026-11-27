--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __ord, __arrL, __iterar, __t, __get, __call, __add, __re, __re_test = __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__call, __JSR.__add, __JSR.__re, __JSR.__re_test
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
        local ua = if __t(window.navigator.userAgent) then window.navigator.userAgent else ""
        local ____t_1 = __t
        local ____TS__Number_result_0 = __TS__Number(window.navigator.deviceMemory)
        __O[14] = ____TS__Number_result_0
        local mem = if ____t_1(____TS__Number_result_0) then __O[14] else 4
        local ____t_3 = __t
        local ____TS__Number_result_2 = __TS__Number(window.navigator.hardwareConcurrency)
        __O[15] = ____TS__Number_result_2
        local cores = if ____t_3(____TS__Number_result_2) then __O[15] else 4
        local tv = __re_test(
            __re("Android TV|GoogleTV|BRAVIA|AFT[A-Z]|SmartTV|SMART-TV|Tizen|WebOS|HbbTV|CrKey", "i"),
            ua
        )
        local ____t_5 = __t
        local ____re_test_result_4 = __re_test(
            __re("Android|iPhone|iPad|iPod|Mobile", "i"),
            ua
        )
        __O[16] = ____re_test_result_4
        local mobile = if ____t_5(____re_test_result_4) then __O[16] else window.navigator.maxTouchPoints > 1 and math.min(window.screen.width, window.screen.height) < 820
        if __t(tv) then
            return {kind = "tv", level = "medium"}
        end
        local ____t_7 = __t
        local ____re_test_result_6 = __re_test(
            __re("iPhone|iPad|iPod", "i"),
            ua
        )
        __O[17] = ____re_test_result_6
        local ios = if ____t_7(____re_test_result_6) then __O[17] else __re_test(
            __re("Macintosh", "i"),
            ua
        ) and window.navigator.maxTouchPoints > 1
        if __t(ios) then
            return {kind = "mobile", level = "medium"}
        end
        if __t(mobile) then
            return {kind = "mobile", level = if __t(mem <= 3 or cores <= 4) then "low" else "medium"}
        end
        return {kind = "desktop", level = if __t(webgl(nil)) then "high" else "medium"}
    end
    local device = detect(nil)
    local ____t_9 = __t
    local ____read_result_8 = read(nil)
    __O[18] = ____read_result_8
    local stored = if ____t_9(____read_result_8) then __O[18] else "auto"
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
        local l = if mode == "auto" then autoLevel else mode
        local ____t_17 = __t
        local ____temp_16 = l == "high"
        if ____temp_16 then
            local ____t_15 = __t
            local ____opt_12 = window.Shader
            if ____opt_12 ~= nil then
                ____opt_12 = ____opt_12.supported
            end
            local ____opt_result_14
            if ____opt_12 ~= nil then
                ____opt_result_14 = ____opt_12(____opt_12)
            end
            ____temp_16 = not ____t_15(____opt_result_14)
        end
        return if ____t_17(____temp_16) then "medium" else l
    end
    local function isLite()
        return level(nil) == "low"
    end
    local function isShader()
        return level(nil) == "high"
    end
    local function apply(self)
        window.document.documentElement.dataset.graphics = if __t(isShader(nil)) then "shader" else if __t(isLite(nil)) then "lite" else "full"
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
        local ____t_19 = __t
        local ____get_result_18 = __get(OLD, next)
        __O[19] = ____get_result_18
        next = if ____t_19(____get_result_18) then __O[19] else next
        mode = if __t(__call(LEVELS, "includes", next)) then next else "auto"
        if mode == "auto" then
            autoLevel = device.level
        end
        write(nil, if mode == "auto" then "auto" else mode)
        apply(nil)
    end
    local NAMES = __ord({low = "BAIXA", medium = "MÉDIA", high = "ALTA"}, "low,medium,high")
    local function label(self)
        return if mode == "auto" then __add(
            __add(
                "AUTO (",
                __get(
                    NAMES,
                    level(nil)
                )
            ),
            ")"
        ) else __get(
            NAMES,
            level(nil)
        )
    end
    local function describe(self)
        local l = level(nil)
        local what = if l == "high" then "Luz com relevo, brilho, raios de sol, névoa e reflexo na água." else if l == "medium" then "Cenários novos, hora do dia, clima e partículas." else "Sem efeitos, para aparelhos simples."
        return __add(
            __add(if mode == "auto" then "Escolhida pelo aparelho. " else "", what),
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
        if __t(if __t(last) then not __t(window.document.hidden) else last) then
            local dt = now - last
            if dt < 250 then
                sum = sum + dt
                samples = samples + 1
            end
            if samples >= 120 then
                local avg = sum / samples
                sum = 0
                samples = 0
                slow = if avg > 26 then slow + 1 else math.max(0, slow - 1)
                local ____t_22 = __t
                local ____t_21 = __t
                local ____temp_20 = slow >= 3 and mode == "auto"
                __O[20] = ____temp_20
                if ____t_22(if ____t_21(____temp_20) then autoLevel ~= "low" else __O[20]) then
                    autoLevel = if autoLevel == "high" then "medium" else "low"
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
                local ____set_29 = set
                local ____t_28 = __t
                local ____opt_25 = window.Shader
                if ____opt_25 ~= nil then
                    ____opt_25 = ____opt_25.supported
                end
                local ____opt_result_27
                if ____opt_25 ~= nil then
                    ____opt_result_27 = ____opt_25(____opt_25)
                end
                return ____set_29(nil, if mode == "auto" then "low" else if mode == "low" then "medium" else if mode == "medium" then if ____t_28(____opt_result_27) then "high" else "auto" else "auto")
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
