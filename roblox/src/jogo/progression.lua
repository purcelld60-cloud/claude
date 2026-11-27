--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __ge, __getq, __ord, __arrL, __iterar, __t, __get, __set, __inc, __arr, __call, __new = __JSR.__ge, __JSR.__getq, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__set, __JSR.__inc, __JSR.__arr, __JSR.__call, __JSR.__new
local __iter, __assign, __isArray = __JSR.__iter, __JSR.__assign, __JSR.__isArray
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Number = ____lualib.__TS__Number
local __TS__Iterator = ____lualib.__TS__Iterator
local Set = ____lualib.Set
local __TS__New = ____lualib.__TS__New
local __TS__Spread = ____lualib.__TS__Spread
local __TS__Promise = ____lualib.__TS__Promise
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    local keys = __arrL({"vigor", "forca", "gas", "agilidade"}, 4)
    local function defaults()
        return {
            level = 1,
            xp = 0,
            totalXP = 0,
            points = 0,
            stats = {vigor = 0, forca = 0, gas = 0, agilidade = 0},
            rewards = __arrL({}, 0)
        }
    end
    local state = defaults(nil)
    local function clamp(____, n, a, b)
        return math.max(
            a,
            math.min(b, n)
        )
    end
    local function dev()
        return not not __t(window.DAROCA_DEV)
    end
    local TETO = 40
    local TETO_DEV = 1000000000
    local function teto()
        return if __t(dev(nil)) then TETO_DEV else TETO
    end
    local function need(____, level)
        return if __ge(level, 50) then 0 else math.floor(60 + level * 35 + level ^ 1.5 * 12)
    end
    local function getState(self)
        return {
            level = state.level,
            xp = state.xp,
            totalXP = state.totalXP,
            points = if __t(dev(nil)) then 999 else state.points,
            infinito = dev(nil),
            teto = if __t(dev(nil)) then nil else TETO,
            nextXP = need(nil, state.level),
            stats = __assign({}, state.stats)
        }
    end
    local function emit(self, levelsGained, reason)
        if levelsGained == nil then
            levelsGained = 0
        end
        if reason == nil then
            reason = "update"
        end
        do
            pcall(function()
                window:dispatchEvent(__new(
                    "CustomEvent",
                    "progression-change",
                    {detail = __assign(
                        {},
                        getState(nil),
                        {
                            state = getState(nil),
                            levelsGained = levelsGained,
                            reason = reason
                        }
                    )}
                ))
            end)
        end
    end
    local function restore(self, data)
        state = defaults(nil)
        if __t(if __t(data) then type(data) == "table" else data) then
            local ____state_2 = state
            local ____t_1 = __t
            local ____TS__Number_result_0 = __TS__Number(data.level)
            __O[38] = ____TS__Number_result_0
            ____state_2.level = clamp(
                nil,
                math.floor(if ____t_1(____TS__Number_result_0) then __O[38] else 1),
                1,
                50
            )
            local ____state_5 = state
            local ____t_4 = __t
            local ____TS__Number_result_3 = __TS__Number(data.xp)
            __O[39] = ____TS__Number_result_3
            ____state_5.xp = clamp(
                nil,
                math.floor(if ____t_4(____TS__Number_result_3) then __O[39] else 0),
                0,
                100000
            )
            local ____state_8 = state
            local ____t_7 = __t
            local ____TS__Number_result_6 = __TS__Number(data.totalXP)
            __O[40] = ____TS__Number_result_6
            ____state_8.totalXP = clamp(
                nil,
                math.floor(if ____t_7(____TS__Number_result_6) then __O[40] else 0),
                0,
                10000000
            )
            local ____state_11 = state
            local ____t_10 = __t
            local ____TS__Number_result_9 = __TS__Number(data.points)
            __O[41] = ____TS__Number_result_9
            ____state_11.points = clamp(
                nil,
                math.floor(if ____t_10(____TS__Number_result_9) then __O[41] else 0),
                0,
                250
            )
            for ____, k in __iterar((keys)) do
                local ____set_15 = __set
                local ____state_stats_14 = state.stats
                local ____t_13 = __t
                local ____TS__Number_result_12 = __TS__Number(__getq(data.stats, k))
                __O[42] = ____TS__Number_result_12
                ____set_15(
                    ____state_stats_14,
                    k,
                    clamp(
                        nil,
                        math.floor(if ____t_13(____TS__Number_result_12) then __O[42] else 0),
                        0,
                        teto(nil)
                    )
                )
            end
            state.rewards = if __isArray(data.rewards) then __call(
                __arr(__TS__Spread(__iter(__TS__New(
                    Set,
                    __call(
                        data.rewards,
                        "filter",
                        function(____, x) return type(x) == "string" end
                    )
                )))),
                "slice",
                -2500
            ) else __arrL({}, 0)
            while __t(state.level < 50 and state.xp >= need(nil, state.level)) do
                state.xp = state.xp - need(nil, state.level)
                state.level = state.level + 1
                state.points = state.points + 2
            end
        end
        if state.level == 50 then
            state.xp = 0
        end
        local ____self_16 = __TS__Promise.resolve()
        ____self_16["then"](
            ____self_16,
            function() return emit(nil, 0, "restore") end
        )
        return getState(nil)
    end
    local function award(self, xp, sourceId)
        local ____t_18 = __t
        local ____TS__Number_result_17 = __TS__Number(xp)
        __O[43] = ____TS__Number_result_17
        local amount = clamp(
            nil,
            math.floor(if ____t_18(____TS__Number_result_17) then __O[43] else 0),
            0,
            10000
        )
        local ____t_21 = __t
        local ____t_20 = __t
        local ____temp_19 = not __t(amount)
        __O[44] = ____temp_19
        if ____t_21(if ____t_20(____temp_19) then __O[44] else if __t(sourceId) then __call(
            state.rewards,
            "includes",
            tostring(sourceId)
        ) else sourceId) then
            return __assign(
                {},
                getState(nil),
                {levelsGained = 0, awarded = 0}
            )
        end
        if __t(sourceId) then
            __call(
                state.rewards,
                "push",
                tostring(sourceId)
            )
        end
        state.rewards = __call(state.rewards, "slice", -2500)
        state.totalXP = state.totalXP + amount
        if state.level < 50 then
            state.xp = state.xp + amount
        end
        local gained = 0
        while __t(state.level < 50 and state.xp >= need(nil, state.level)) do
            state.xp = state.xp - need(nil, state.level)
            state.level = state.level + 1
            state.points = state.points + 2
            gained = gained + 1
        end
        if state.level == 50 then
            state.xp = 0
        end
        emit(nil, gained, "award")
        return __assign(
            {},
            getState(nil),
            {levelsGained = gained, awarded = amount}
        )
    end
    local function spend(self, stat, qtd)
        if qtd == nil then
            qtd = 1
        end
        if __t(not __t(__call(keys, "includes", stat)) or __ge(
            __get(state.stats, stat),
            teto(nil)
        )) then
            return false
        end
        if not __t(dev(nil)) then
            if state.points < 1 then
                return false
            end
            state.points = state.points - 1
            __inc(state.stats, stat, 1, true)
        else
            local ____set_27 = __set
            local ____state_stats_25 = state.stats
            local ____stat_26 = stat
            local ____get_result_24 = __get(state.stats, stat)
            local ____t_23 = __t
            local ____TS__Number_result_22 = __TS__Number(qtd)
            __O[45] = ____TS__Number_result_22
            ____set_27(
                ____state_stats_25,
                ____stat_26,
                math.min(
                    TETO_DEV,
                    ____get_result_24 + clamp(
                        nil,
                        math.floor(if ____t_23(____TS__Number_result_22) then __O[45] else 1),
                        1,
                        1000000
                    )
                )
            )
        end
        emit(nil, 0, "spend")
        return true
    end
    local function bonuses(self)
        local s = state.stats
        return {
            maxHP = 100 + s.vigor * 24,
            maxGas = 100 + s.gas * 20,
            damageMultiplier = 1 + s.forca * 0.11 + (state.level - 1) * 0.005,
            moveSpeed = 280 + s.agilidade * 8 + (state.level - 1),
            dashCooldown = math.max(0.48, 1.1 - s.agilidade * 0.055),
            projectileTier = if state.level >= 7 then 2 else if state.level >= 3 then 1 else 0,
            gasRegen = 16 + s.gas * 1.2,
            airGasRegen = 6 + s.gas * 0.35
        }
    end
    local function serialize(self)
        return __assign(
            {},
            getState(nil),
            {
                points = state.points,
                infinito = nil,
                teto = nil,
                stats = __assign({}, state.stats),
                rewards = __arr(__TS__Spread(__iter(state.rewards)))
            }
        )
    end
    window.Progression = __ord({
        restore = restore,
        getState = getState,
        award = award,
        spend = spend,
        bonuses = bonuses,
        serialize = serialize
    }, "restore,getState,award,spend,bonuses,serialize")
end)(nil)
return ____exports
