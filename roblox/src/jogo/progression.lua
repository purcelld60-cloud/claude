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
        return __t(dev(nil)) and TETO_DEV or TETO
    end
    local function need(____, level)
        return __ge(level, 50) and 0 or math.floor(60 + level * 35 + level ^ 1.5 * 12)
    end
    local function getState(self)
        local ____state_level_1 = state.level
        local ____state_xp_2 = state.xp
        local ____state_totalXP_3 = state.totalXP
        local ____temp_4 = __t(dev(nil)) and 999 or state.points
        local ____dev_result_5 = dev(nil)
        local ____t_result_0
        if __t(dev(nil)) then
            ____t_result_0 = nil
        else
            ____t_result_0 = TETO
        end
        return {
            level = ____state_level_1,
            xp = ____state_xp_2,
            totalXP = ____state_totalXP_3,
            points = ____temp_4,
            infinito = ____dev_result_5,
            teto = ____t_result_0,
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
        local ____t_7 = __t
        local ____t_result_6
        if __t(data) then
            ____t_result_6 = type(data) == "table"
        else
            ____t_result_6 = data
        end
        if ____t_7(____t_result_6) then
            local ____state_11 = state
            local ____t_result_10
            local ____t_9 = __t
            local ____TS__Number_result_8 = __TS__Number(data.level)
            __O[38] = ____TS__Number_result_8
            if ____t_9(____TS__Number_result_8) then
                ____t_result_10 = __O[38]
            else
                ____t_result_10 = 1
            end
            ____state_11.level = clamp(
                nil,
                math.floor(____t_result_10),
                1,
                50
            )
            local ____state_15 = state
            local ____t_result_14
            local ____t_13 = __t
            local ____TS__Number_result_12 = __TS__Number(data.xp)
            __O[39] = ____TS__Number_result_12
            if ____t_13(____TS__Number_result_12) then
                ____t_result_14 = __O[39]
            else
                ____t_result_14 = 0
            end
            ____state_15.xp = clamp(
                nil,
                math.floor(____t_result_14),
                0,
                100000
            )
            local ____state_19 = state
            local ____t_result_18
            local ____t_17 = __t
            local ____TS__Number_result_16 = __TS__Number(data.totalXP)
            __O[40] = ____TS__Number_result_16
            if ____t_17(____TS__Number_result_16) then
                ____t_result_18 = __O[40]
            else
                ____t_result_18 = 0
            end
            ____state_19.totalXP = clamp(
                nil,
                math.floor(____t_result_18),
                0,
                10000000
            )
            local ____state_23 = state
            local ____t_result_22
            local ____t_21 = __t
            local ____TS__Number_result_20 = __TS__Number(data.points)
            __O[41] = ____TS__Number_result_20
            if ____t_21(____TS__Number_result_20) then
                ____t_result_22 = __O[41]
            else
                ____t_result_22 = 0
            end
            ____state_23.points = clamp(
                nil,
                math.floor(____t_result_22),
                0,
                250
            )
            for ____, k in __iterar((keys)) do
                local ____set_28 = __set
                local ____state_stats_27 = state.stats
                local ____t_result_26
                local ____t_25 = __t
                local ____TS__Number_result_24 = __TS__Number(__getq(data.stats, k))
                __O[42] = ____TS__Number_result_24
                if ____t_25(____TS__Number_result_24) then
                    ____t_result_26 = __O[42]
                else
                    ____t_result_26 = 0
                end
                ____set_28(
                    ____state_stats_27,
                    k,
                    clamp(
                        nil,
                        math.floor(____t_result_26),
                        0,
                        teto(nil)
                    )
                )
            end
            local ____state_30 = state
            local ____isArray_result_29
            if __isArray(data.rewards) then
                ____isArray_result_29 = __call(
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
                )
            else
                ____isArray_result_29 = __arrL({}, 0)
            end
            ____state_30.rewards = ____isArray_result_29
            while __t(state.level < 50 and state.xp >= need(nil, state.level)) do
                state.xp = state.xp - need(nil, state.level)
                state.level = state.level + 1
                state.points = state.points + 2
            end
        end
        if state.level == 50 then
            state.xp = 0
        end
        local ____self_31 = __TS__Promise.resolve()
        ____self_31["then"](
            ____self_31,
            function() return emit(nil, 0, "restore") end
        )
        return getState(nil)
    end
    local function award(self, xp, sourceId)
        local ____t_result_34
        local ____t_33 = __t
        local ____TS__Number_result_32 = __TS__Number(xp)
        __O[43] = ____TS__Number_result_32
        if ____t_33(____TS__Number_result_32) then
            ____t_result_34 = __O[43]
        else
            ____t_result_34 = 0
        end
        local amount = clamp(
            nil,
            math.floor(____t_result_34),
            0,
            10000
        )
        local ____t_39 = __t
        local ____t_result_38
        local ____t_36 = __t
        local ____temp_35 = not __t(amount)
        __O[44] = ____temp_35
        if ____t_36(____temp_35) then
            ____t_result_38 = __O[44]
        else
            local ____t_result_37
            if __t(sourceId) then
                ____t_result_37 = __call(
                    state.rewards,
                    "includes",
                    tostring(sourceId)
                )
            else
                ____t_result_37 = sourceId
            end
            ____t_result_38 = ____t_result_37
        end
        if ____t_39(____t_result_38) then
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
            local ____set_46 = __set
            local ____state_stats_44 = state.stats
            local ____stat_45 = stat
            local ____get_result_43 = __get(state.stats, stat)
            local ____t_result_42
            local ____t_41 = __t
            local ____TS__Number_result_40 = __TS__Number(qtd)
            __O[45] = ____TS__Number_result_40
            if ____t_41(____TS__Number_result_40) then
                ____t_result_42 = __O[45]
            else
                ____t_result_42 = 1
            end
            ____set_46(
                ____state_stats_44,
                ____stat_45,
                math.min(
                    TETO_DEV,
                    ____get_result_43 + clamp(
                        nil,
                        math.floor(____t_result_42),
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
            projectileTier = state.level >= 7 and 2 or (state.level >= 3 and 1 or 0),
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
