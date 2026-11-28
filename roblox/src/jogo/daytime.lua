--!native
--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __le, __gt, __mod, __ord, __arrL, __t, __get, __len, __call = __JSR.__lt, __JSR.__le, __JSR.__gt, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__t, __JSR.__get, __JSR.__len, __JSR.__call
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__ParseInt = ____lualib.__TS__ParseInt
local __TS__Number = ____lualib.__TS__Number
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    if __t(window.DayTime) then
        return
    end
    local KEY = "daroca-daytime-v1"
    local DAY_SECONDS = 360
    local START_HOUR = 15.5
    local MODES = __arrL(
        {
            __ord({id = "auto", label = "AUTOMÁTICA", text = "O dia passa sozinho: tarde, pôr do sol, noite e manhã."}, "id,label,text"),
            __ord({id = "manha", label = "MANHÃ", hour = 8.2, text = "Luz clara e fria entrando pelas janelas."}, "id,label,hour,text"),
            __ord({id = "tarde", label = "TARDE", hour = 13.5, text = "Sol alto e cores vivas."}, "id,label,hour,text"),
            __ord({id = "por", label = "PÔR DO SOL", hour = 17.7, text = "Luz dourada e sombras compridas."}, "id,label,hour,text"),
            __ord({id = "noite", label = "NOITE", hour = 22, text = "Lua, estrelas e lâmpadas acesas."}, "id,label,hour,text")
        },
        5
    )
    local KEYS = __arrL(
        {
            __arrL({
                0,
                "#0b1030",
                "#1c2a55",
                "#7d8ccc",
                "#8fa8ff",
                1
            }, 6),
            __arrL({
                4.8,
                "#141a44",
                "#30386e",
                "#7f8cc8",
                "#8fa8ff",
                1
            }, 6),
            __arrL({
                6.2,
                "#4a5aa0",
                "#f0a078",
                "#dcbcb0",
                "#ffb07a",
                0.45
            }, 6),
            __arrL({
                8,
                "#5aa0e0",
                "#c8e4f0",
                "#fff4e6",
                "#fff1c8",
                0
            }, 6),
            __arrL({
                12,
                "#3f8fe0",
                "#bfe2f5",
                "#ffffff",
                "#fff8dc",
                0
            }, 6),
            __arrL({
                16,
                "#4a90d8",
                "#f2dcae",
                "#fff0d8",
                "#ffe2a0",
                0
            }, 6),
            __arrL({
                17.8,
                "#5a5aa8",
                "#ff9a5a",
                "#ffc89a",
                "#ff9a4a",
                0.3
            }, 6),
            __arrL({
                19,
                "#2a2a68",
                "#a0507a",
                "#a890c0",
                "#c88ab0",
                0.85
            }, 6),
            __arrL({
                20.5,
                "#0d1236",
                "#22305e",
                "#7d8ccc",
                "#8fa8ff",
                1
            }, 6),
            __arrL({
                24,
                "#0b1030",
                "#1c2a55",
                "#7d8ccc",
                "#8fa8ff",
                1
            }, 6)
        },
        10
    )
    local function rgb(____, hex)
        return __arrL(
            {
                __TS__ParseInt(
                    __call(hex, "slice", 1, 3),
                    16
                ) / 255,
                __TS__ParseInt(
                    __call(hex, "slice", 3, 5),
                    16
                ) / 255,
                __TS__ParseInt(
                    __call(hex, "slice", 5, 7),
                    16
                ) / 255
            },
            3
        )
    end
    local TABLE = __call(
        KEYS,
        "map",
        function(____, k) return {
            h = __get(k, 0),
            top = rgb(
                nil,
                __get(k, 1)
            ),
            bot = rgb(
                nil,
                __get(k, 2)
            ),
            amb = rgb(
                nil,
                __get(k, 3)
            ),
            sun = rgb(
                nil,
                __get(k, 4)
            ),
            night = __get(k, 5)
        } end
    )
    local function mix(____, a, b, k)
        return __arrL(
            {
                __get(a, 0) + (__get(b, 0) - __get(a, 0)) * k,
                __get(a, 1) + (__get(b, 1) - __get(a, 1)) * k,
                __get(a, 2) + (__get(b, 2) - __get(a, 2)) * k
            },
            3
        )
    end
    local mode = "auto"
    local forced = nil
    do
        pcall(function()
            local saved = window.localStorage:getItem(KEY)
            if __t(__call(
                MODES,
                "some",
                function(____, m) return m.id == saved end
            )) then
                mode = saved
            end
        end)
    end
    local listeners = __arrL({}, 0)
    local function current()
        local ____t_result_2
        local ____t_1 = __t
        local ____call_result_0 = __call(
            MODES,
            "find",
            function(____, m) return m.id == mode end
        )
        __O[46] = ____call_result_0
        if ____t_1(____call_result_0) then
            ____t_result_2 = __O[46]
        else
            ____t_result_2 = __get(MODES, 0)
        end
        return ____t_result_2
    end
    local function hour(self)
        if forced ~= nil then
            return forced
        end
        local m = current(nil)
        if m.hour ~= nil then
            return m.hour
        end
        return __mod(
            START_HOUR + window.performance:now() / 1000 / DAY_SECONDS * 24,
            24
        )
    end
    local function state(self)
        local h = hour(nil)
        local i = 0
        while __t(i < __len(TABLE) - 2 and __le(
            __get(TABLE, i + 1).h,
            h
        )) do
            i = i + 1
        end
        local a = __get(TABLE, i)
        local b = __get(TABLE, i + 1)
        local k = math.max(
            0,
            math.min(1, (h - a.h) / (b.h - a.h))
        )
        local ____t_result_3
        if __t(__gt(h, 5.8) and __lt(h, 18.7)) then
            ____t_result_3 = (h - 5.8) / 12.9
        else
            ____t_result_3 = nil
        end
        local sunT = ____t_result_3
        local ____lt_result_4
        if __lt(h, 12) then
            ____lt_result_4 = h + 24
        else
            ____lt_result_4 = h
        end
        local mh = ____lt_result_4
        local ____t_result_5
        if __t(__gt(mh, 18.8) and __lt(mh, 29.6)) then
            ____t_result_5 = (mh - 18.8) / 10.8
        else
            ____t_result_5 = nil
        end
        local moonT = ____t_result_5
        return {
            h = h,
            top = mix(nil, a.top, b.top, k),
            bot = mix(nil, a.bot, b.bot, k),
            amb = mix(nil, a.amb, b.amb, k),
            sun = mix(nil, a.sun, b.sun, k),
            night = a.night + (b.night - a.night) * k,
            sunT = sunT,
            moonT = moonT
        }
    end
    local function next(self)
        local i = __call(
            MODES,
            "findIndex",
            function(____, m) return m.id == mode end
        )
        mode = __get(
            MODES,
            __mod(
                i + 1,
                __len(MODES)
            )
        ).id
        do
            pcall(function()
                window.localStorage:setItem(KEY, mode)
            end)
        end
        __call(
            listeners,
            "forEach",
            function(____, fn)
                do
                    pcall(function()
                        fn(nil, mode)
                    end)
                end
            end
        )
        return mode
    end
    window.DayTime = __ord(
        {
            hour = hour,
            state = state,
            next = next,
            mode = function() return mode end,
            label = function() return current(nil).label end,
            describe = function() return current(nil).text end,
            onChange = function(____, fn)
                if type(fn) == "function" then
                    __call(listeners, "push", fn)
                end
            end,
            force = function(____, h)
                local ____t_result_6
                if __t(h == nil or h == nil) then
                    ____t_result_6 = nil
                else
                    ____t_result_6 = __mod(
                        __mod(
                            __TS__Number(h),
                            24
                        ) + 24,
                        24
                    )
                end
                forced = ____t_result_6
            end
        },
        "hour,state,next,mode,label,describe,onChange,force"
    )
end)(nil)
return ____exports
