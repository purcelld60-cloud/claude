--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __gt, __isFiniteN, __mod, __ord, __arrL, __t, __get, __set, __arr, __len, __call, __add = __JSR.__gt, __JSR.__isFiniteN, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__t, __JSR.__get, __JSR.__set, __JSR.__arr, __JSR.__len, __JSR.__call, __JSR.__add
local __new, __iter, __assign, __isArray = __JSR.__new, __JSR.__iter, __JSR.__assign, __JSR.__isArray
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Number = ____lualib.__TS__Number
local Set = ____lualib.Set
local __TS__New = ____lualib.__TS__New
local __TS__Spread = ____lualib.__TS__Spread
local ____exports = {}
local __O = {};
(function()
    local tick, modeSummary, finish, getState, format, render, label, run, suspended, lastAt, active, lastRender, stamp, finite, copy, emit
    function tick(self, now, nextActive)
        if now == nil then
            now = stamp(nil)
        end
        if nextActive == nil then
            nextActive = active
        end
        now = finite(
            nil,
            now,
            stamp(nil)
        )
        local ____t_14 = __t
        local ____t_result_13
        local ____t_12 = __t
        local ____t_result_11
        local ____t_10 = __t
        local ____t_result_9
        local ____t_8 = __t
        local ____t_result_7
        local ____t_6 = __t
        local ____temp_5 = lastAt ~= nil
        __O[1282] = ____temp_5
        if ____t_6(____temp_5) then
            ____t_result_7 = active
        else
            ____t_result_7 = __O[1282]
        end
        __O[1283] = ____t_result_7
        if ____t_8(____t_result_7) then
            ____t_result_9 = not __t(suspended)
        else
            ____t_result_9 = __O[1283]
        end
        __O[1284] = ____t_result_9
        if ____t_10(____t_result_9) then
            ____t_result_11 = run
        else
            ____t_result_11 = __O[1284]
        end
        __O[1285] = ____t_result_11
        if ____t_12(____t_result_11) then
            ____t_result_13 = not __t(run.finished)
        else
            ____t_result_13 = __O[1285]
        end
        if ____t_14(____t_result_13) then
            local delta = math.max(0, now - lastAt)
            run.elapsedMs = run.elapsedMs + delta
            local ____set_20 = __set
            local ____run_modeTime_18 = run.modeTime
            local ____run_mode_19 = run.mode
            local ____t_result_17
            local ____t_16 = __t
            local ____get_result_15 = __get(run.modeTime, run.mode)
            __O[1286] = ____get_result_15
            if ____t_16(____get_result_15) then
                ____t_result_17 = __O[1286]
            else
                ____t_result_17 = 0
            end
            ____set_20(____run_modeTime_18, ____run_mode_19, ____t_result_17 + delta)
        end
        lastAt = now
        local ____t_result_25
        local ____t_24 = __t
        local ____t_result_23
        local ____t_22 = __t
        local ____temp_21 = not not __t(nextActive) and not __t(suspended)
        __O[1287] = ____temp_21
        if ____t_22(____temp_21) then
            ____t_result_23 = not not __t(run)
        else
            ____t_result_23 = __O[1287]
        end
        __O[1288] = ____t_result_23
        if ____t_24(____t_result_23) then
            ____t_result_25 = not __t(run.finished)
        else
            ____t_result_25 = __O[1288]
        end
        active = ____t_result_25
        if now - lastRender > 250 then
            lastRender = now
            render(nil)
        end
        local ____t_result_26
        if __t(run) then
            ____t_result_26 = run.elapsedMs
        else
            ____t_result_26 = 0
        end
        return ____t_result_26
    end
    function modeSummary(self)
        if not __t(run) then
            return {mode = "normal", modeLabel = "NORMAL", mixed = false}
        end
        local used = run.modesUsed
        local mode = __t(__call(used, "includes", "easy")) and "easy" or (__t(__call(used, "includes", "normal")) and "normal" or "hard")
        local ____mode_93 = mode
        local ____gt_result_92
        if __gt(
            __len(used),
            1
        ) then
            ____gt_result_92 = __add(
                "MISTO · ",
                __call(
                    __call(used, "map", label),
                    "join",
                    " / "
                )
            )
        else
            ____gt_result_92 = label(nil, mode)
        end
        return {
            mode = ____mode_93,
            modeLabel = ____gt_result_92,
            mixed = __gt(
                __len(used),
                1
            )
        }
    end
    function finish(self)
        local ____t_97 = __t
        local ____t_result_96
        local ____t_95 = __t
        local ____temp_94 = not __t(run)
        __O[1299] = ____temp_94
        if ____t_95(____temp_94) then
            ____t_result_96 = __O[1299]
        else
            ____t_result_96 = suspended
        end
        if ____t_97(____t_result_96) then
            return nil
        end
        if __t(run.finished) then
            return copy(nil, run.result)
        end
        tick(
            nil,
            stamp(nil),
            false
        )
        run.initialChoicePending = false
        run.finished = true
        run.result = __assign(
            {},
            {
                schema = 1,
                elapsedMs = math.floor(run.elapsedMs + 0.5)
            },
            modeSummary(nil),
            {
                partial = run.partial,
                modesUsed = __arr(__TS__Spread(__iter(run.modesUsed))),
                modeTime = __assign({}, run.modeTime)
            }
        )
        emit(nil, "finish")
        render(nil)
        return copy(nil, run.result)
    end
    function getState(self)
        local summary = modeSummary(nil)
        local ____t_result_103
        if __t(run) then
            local ____assign_102 = __assign
            local ____temp_100 = {}
            local ____copy_result_101 = copy(nil, run)
            local ____suspended_99 = suspended
            local ____t_result_98
            if __t(active) then
                ____t_result_98 = not __t(suspended)
            else
                ____t_result_98 = active
            end
            ____t_result_103 = ____assign_102(____temp_100, ____copy_result_101, {
                suspended = ____suspended_99,
                active = ____t_result_98,
                categoryMode = summary.mode,
                modeLabel = summary.modeLabel,
                mixed = summary.mixed
            })
        else
            ____t_result_103 = nil
        end
        return ____t_result_103
    end
    function format(self, ms)
        local seconds = math.floor(math.max(
            0,
            finite(nil, ms)
        ) / 1000)
        local hours = math.floor(seconds / 3600)
        local ____add_110 = __add
        local ____add_109 = __add
        local ____add_108 = __add
        local ____t_result_107
        if __t(hours) then
            ____t_result_107 = __add(
                __call(
                    tostring(hours),
                    "padStart",
                    2,
                    "0"
                ),
                ":"
            )
        else
            ____t_result_107 = ""
        end
        return ____add_110(
            ____add_109(
                ____add_108(
                    ____t_result_107,
                    __call(
                        tostring(__mod(
                            math.floor(seconds / 60),
                            60
                        )),
                        "padStart",
                        2,
                        "0"
                    )
                ),
                ":"
            ),
            __call(
                tostring(__mod(seconds, 60)),
                "padStart",
                2,
                "0"
            )
        )
    end
    function render(self)
        if type(window.document) == "nil" then
            return
        end
        local ____end = window.document:getElementById("chapterEndScreen")
        local ____t_result_115
        local ____t_114 = __t
        local ____t_result_113
        local ____t_112 = __t
        local ____temp_111 = window.document:querySelector("#pauseScreen .rp-body")
        __O[1300] = ____temp_111
        if ____t_112(____temp_111) then
            ____t_result_113 = __O[1300]
        else
            ____t_result_113 = window.document:querySelector("#pauseScreen .ranch-pause-body")
        end
        __O[1301] = ____t_result_113
        if ____t_114(____t_result_113) then
            ____t_result_115 = __O[1301]
        else
            ____t_result_115 = window.document:querySelector("#pauseScreen .game-modal")
        end
        local pause = ____t_result_115
        local ____t_117 = __t
        local ____t_result_116
        if __t(____end) then
            ____t_result_116 = not __t(window.document:getElementById("campaignRunResult"))
        else
            ____t_result_116 = ____end
        end
        if ____t_117(____t_result_116) then
            local card = window.document:createElement("section")
            card.id = "campaignRunResult"
            card.className = "campaign-run-result"
            card:setAttribute("aria-label", "Tempo e dificuldade da campanha")
            card.innerHTML = "<span>TEMPO DE CAMPANHA</span><strong></strong><b></b><small></small>"
            ____end:append(card)
        end
        local ____t_119 = __t
        local ____t_result_118
        if __t(pause) then
            ____t_result_118 = not __t(window.document:getElementById("campaignRunPause"))
        else
            ____t_result_118 = pause
        end
        if ____t_119(____t_result_118) then
            local card = window.document:createElement("div")
            card.id = "campaignRunPause"
            card.className = "campaign-run-pause"
            card.innerHTML = "<span>⏱ TEMPO ATIVO</span><b></b><small></small>"
            pause:append(card)
        end
        local ____opt_result_122
        if run ~= nil then
            ____opt_result_122 = run.result
        end
        local result = ____opt_result_122
        local card = window.document:getElementById("campaignRunResult")
        if __t(card) then
            card.hidden = not __t(result)
            if __t(result) then
                card.dataset.mode = result.mode
                card:querySelector("strong").textContent = format(nil, result.elapsedMs)
                card:querySelector("b").textContent = result.modeLabel
                card:querySelector("small").textContent = __t(result.partial) and "SAVE ANTERIOR · TEMPO PARCIAL DESDE A ATUALIZAÇÃO" or (result.mode == "easy" and "PRÊMIO: CHUPETA · GUGU DADA" or "ATÉ A DERROTA DE NIKOLAS · PAUSAS DESCONTADAS")
            end
        end
        local timer = window.document:getElementById("campaignRunPause")
        if __t(timer) then
            local ____t_result_125
            local ____t_124 = __t
            local ____temp_123 = not __t(run)
            __O[1302] = ____temp_123
            if ____t_124(____temp_123) then
                ____t_result_125 = __O[1302]
            else
                ____t_result_125 = suspended
            end
            timer.hidden = ____t_result_125
            local ____temp_127 = timer:querySelector("b")
            local ____t_result_126
            if __t(run) then
                ____t_result_126 = format(nil, run.elapsedMs)
            else
                ____t_result_126 = ""
            end
            ____temp_127.textContent = ____t_result_126
            local ____temp_129 = timer:querySelector("small")
            local ____t_result_128
            if __t(run) then
                ____t_result_128 = __add(
                    __t(run.partial) and "Tempo parcial · save anterior" or (__t(run.finished) and "Campanha concluída" or modeSummary(nil).modeLabel),
                    __t(run.easyLocked) and " · Fácil travado neste save" or ""
                )
            else
                ____t_result_128 = ""
            end
            ____temp_129.textContent = ____t_result_128
        end
    end
    local ____ = "use strict"
    local function valid(____, mode)
        return __call(
            __arrL({"easy", "normal", "hard"}, 3),
            "includes",
            mode
        )
    end
    label = function(____, mode)
        local ____t_result_2
        local ____t_1 = __t
        local ____get_result_0 = __get({easy = "FÁCIL", normal = "NORMAL", hard = "DIFÍCIL"}, mode)
        __O[1281] = ____get_result_0
        if ____t_1(____get_result_0) then
            ____t_result_2 = __O[1281]
        else
            ____t_result_2 = "NORMAL"
        end
        return ____t_result_2
    end
    run = nil
    suspended = false
    lastAt = nil
    active = false
    lastRender = 0
    local restoring = false
    stamp = function() return window.performance:now() end
    finite = function(____, value, fallback)
        if fallback == nil then
            fallback = 0
        end
        local ____isFiniteN_result_3
        if __isFiniteN(__TS__Number(value)) then
            ____isFiniteN_result_3 = __TS__Number(value)
        else
            ____isFiniteN_result_3 = fallback
        end
        return ____isFiniteN_result_3
    end
    copy = function(____, value)
        local ____t_result_4
        if __t(value) then
            ____t_result_4 = window.JSON:parse(window.JSON:stringify(value))
        else
            ____t_result_4 = nil
        end
        return ____t_result_4
    end
    emit = function(____, reason)
        do
            pcall(function()
                window:dispatchEvent(__new(
                    "CustomEvent",
                    "campaign-run-change",
                    {detail = {
                        reason = reason,
                        state = getState(nil)
                    }}
                ))
            end)
        end
    end
    local function assignMode(self, mode)
        restoring = true
        do
            local ____try, ____error = pcall(function()
                local ____opt_29 = window.Difficulty
                if ____opt_29 ~= nil then
                    ____opt_29 = ____opt_29.setMode
                end
                if ____opt_29 ~= nil then
                    ____opt_29(____opt_29, mode)
                end
            end)
            do
                restoring = false
            end
            if not ____try then
                error(____error, 0)
            end
        end
    end
    local function begin(self, data, options)
        if options == nil then
            options = {}
        end
        suspended = false
        active = false
        lastAt = stamp(nil)
        local ____t_result_36
        local ____t_34 = __t
        local ____opt_result_33
        if data ~= nil then
            ____opt_result_33 = data.mode
        end
        if ____t_34(valid(nil, ____opt_result_33)) then
            ____t_result_36 = data.mode
        else
            local ____t_result_35
            if __t(valid(nil, options.mode)) then
                ____t_result_35 = options.mode
            else
                ____t_result_35 = "normal"
            end
            ____t_result_36 = ____t_result_35
        end
        local mode = ____t_result_36
        local ____opt_result_39
        if data ~= nil then
            ____opt_result_39 = data.schema
        end
        if ____opt_result_39 == 1 then
            local ____isArray_result_40
            if __isArray(data.modesUsed) then
                ____isArray_result_40 = __arr(__TS__Spread(__iter(__TS__New(
                    Set,
                    __call(data.modesUsed, "filter", valid)
                ))))
            else
                ____isArray_result_40 = __arrL({mode}, 1)
            end
            local used = ____isArray_result_40
            local ____math_max_result_63 = math.max(
                0,
                finite(nil, data.elapsedMs)
            )
            local ____mode_64 = mode
            local ____t_result_43
            local ____t_42 = __t
            local ____temp_41 = not not __t(data.easyLocked) or mode == "easy"
            __O[1289] = ____temp_41
            if ____t_42(____temp_41) then
                ____t_result_43 = __O[1289]
            else
                ____t_result_43 = __call(used, "includes", "easy")
            end
            local ____t_result_44
            if __t(__len(used)) then
                ____t_result_44 = used
            else
                ____t_result_44 = __arrL({mode}, 1)
            end
            local ____call_51 = __call
            local ____call_50 = __call
            local ____call_49 = __call
            local ____isArray_result_45
            if __isArray(data.history) then
                ____isArray_result_45 = data.history
            else
                ____isArray_result_45 = __arrL({}, 0)
            end
            local ____call_51_result_65 = ____call_51(
                ____call_50(
                    ____call_49(
                        ____isArray_result_45,
                        "filter",
                        function(____, e)
                            local ____t_result_48
                            local ____t_47 = __t
                            local ____t_result_46
                            if __t(e) then
                                ____t_result_46 = valid(nil, e.mode)
                            else
                                ____t_result_46 = e
                            end
                            __O[1290] = ____t_result_46
                            if ____t_47(____t_result_46) then
                                ____t_result_48 = __isFiniteN(e.atMs)
                            else
                                ____t_result_48 = __O[1290]
                            end
                            return ____t_result_48
                        end
                    ),
                    "slice",
                    -40
                ),
                "map",
                function(____, e) return {
                    mode = e.mode,
                    atMs = math.max(0, e.atMs)
                } end
            )
            local ____opt_52 = data.modeTime
            if ____opt_52 ~= nil then
                ____opt_52 = ____opt_52.easy
            end
            local ____math_max_result_58 = math.max(
                0,
                finite(nil, ____opt_52)
            )
            local ____opt_54 = data.modeTime
            if ____opt_54 ~= nil then
                ____opt_54 = ____opt_54.normal
            end
            local ____math_max_result_59 = math.max(
                0,
                finite(nil, ____opt_54)
            )
            local ____opt_56 = data.modeTime
            if ____opt_56 ~= nil then
                ____opt_56 = ____opt_56.hard
            end
            local ____temp_66 = {
                easy = ____math_max_result_58,
                normal = ____math_max_result_59,
                hard = math.max(
                    0,
                    finite(nil, ____opt_56)
                )
            }
            local ____temp_67 = not not __t(data.partial)
            local ____temp_68 = not not __t(data.finished)
            local ____temp_69 = not not __t(data.initialChoicePending)
            local ____t_result_62
            local ____t_61 = __t
            local ____t_result_60
            if __t(data.result) then
                ____t_result_60 = type(data.result) == "table"
            else
                ____t_result_60 = data.result
            end
            if ____t_61(____t_result_60) then
                ____t_result_62 = copy(nil, data.result)
            else
                ____t_result_62 = nil
            end
            run = {
                schema = 1,
                elapsedMs = ____math_max_result_63,
                mode = ____mode_64,
                easyLocked = ____t_result_43,
                modesUsed = ____t_result_44,
                history = ____call_51_result_65,
                modeTime = ____temp_66,
                partial = ____temp_67,
                finished = ____temp_68,
                initialChoicePending = ____temp_69,
                result = ____t_result_62
            }
            if __t(run.easyLocked) then
                run.mode = "easy"
            end
            if not __t(__len(run.history)) then
                run.history = __arrL({{mode = run.mode, atMs = 0}}, 1)
            end
        else
            run = {
                schema = 1,
                elapsedMs = 0,
                mode = mode,
                easyLocked = mode == "easy",
                modesUsed = __arrL({mode}, 1),
                history = __arrL({{mode = mode, atMs = 0}}, 1),
                modeTime = {easy = 0, normal = 0, hard = 0},
                partial = not not __t(options.legacy),
                finished = false,
                initialChoicePending = not not __t(options.initialChoicePending),
                result = nil
            }
        end
        assignMode(nil, run.mode)
        local ____t_71 = __t
        local ____t_result_70
        if __t(options.completed) then
            ____t_result_70 = not __t(run.finished)
        else
            ____t_result_70 = options.completed
        end
        if ____t_71(____t_result_70) then
            finish(nil)
        end
        render(nil)
        return getState(nil)
    end
    local function start(self)
        return begin(nil, nil, {mode = "normal", initialChoicePending = true})
    end
    local function restore(self, data, options)
        if options == nil then
            options = {}
        end
        return begin(
            nil,
            data,
            __assign({}, options, {initialChoicePending = false})
        )
    end
    local function confirmInitialMode(self)
        if __t(run) then
            run.initialChoicePending = false
        end
    end
    local function canSetMode(self, next)
        local ____t_result_83
        local ____t_73 = __t
        local ____valid_result_72 = valid(nil, next)
        __O[1295] = ____valid_result_72
        if ____t_73(____valid_result_72) then
            local ____t_result_82
            local ____t_81 = __t
            local ____t_result_80
            local ____t_79 = __t
            local ____t_result_78
            local ____t_77 = __t
            local ____t_result_76
            local ____t_75 = __t
            local ____temp_74 = not __t(run)
            __O[1291] = ____temp_74
            if ____t_75(____temp_74) then
                ____t_result_76 = __O[1291]
            else
                ____t_result_76 = suspended
            end
            __O[1292] = ____t_result_76
            if ____t_77(____t_result_76) then
                ____t_result_78 = __O[1292]
            else
                ____t_result_78 = not __t(run.easyLocked)
            end
            __O[1293] = ____t_result_78
            if ____t_79(____t_result_78) then
                ____t_result_80 = __O[1293]
            else
                ____t_result_80 = next == "easy"
            end
            __O[1294] = ____t_result_80
            if ____t_81(____t_result_80) then
                ____t_result_82 = __O[1294]
            else
                ____t_result_82 = restoring
            end
            ____t_result_83 = ____t_result_82
        else
            ____t_result_83 = __O[1295]
        end
        return ____t_result_83
    end
    local function changeMode(self, next)
        local ____t_91 = __t
        local ____t_result_90
        local ____t_89 = __t
        local ____t_result_88
        local ____t_87 = __t
        local ____t_result_86
        local ____t_85 = __t
        local ____t_result_84
        if __t(restoring) then
            ____t_result_84 = restoring
        else
            ____t_result_84 = suspended
        end
        __O[1296] = ____t_result_84
        if ____t_85(____t_result_84) then
            ____t_result_86 = __O[1296]
        else
            ____t_result_86 = not __t(run)
        end
        __O[1297] = ____t_result_86
        if ____t_87(____t_result_86) then
            ____t_result_88 = __O[1297]
        else
            ____t_result_88 = not __t(valid(nil, next))
        end
        __O[1298] = ____t_result_88
        if ____t_89(____t_result_88) then
            ____t_result_90 = __O[1298]
        else
            ____t_result_90 = next == run.mode
        end
        if ____t_91(____t_result_90) then
            return
        end
        tick(
            nil,
            stamp(nil),
            active
        )
        local previous = run.mode
        run.mode = next
        if next == "easy" then
            run.easyLocked = true
        end
        if not __t(run.finished) then
            if __t(run.initialChoicePending) then
                run.modesUsed = __arrL({next}, 1)
                run.history = __arrL({{mode = next, atMs = 0}}, 1)
                run.modeTime = {easy = 0, normal = 0, hard = 0}
                __set(run.modeTime, next, run.elapsedMs)
            else
                if not __t(__call(run.modesUsed, "includes", next)) then
                    __call(run.modesUsed, "push", next)
                end
                __call(run.history, "push", {mode = next, atMs = run.elapsedMs})
                run.history = __call(run.history, "slice", -40)
            end
        end
        emit(nil, "difficulty")
        render(nil)
        return previous
    end
    local function setSuspended(self, value)
        tick(
            nil,
            stamp(nil),
            false
        )
        suspended = not not __t(value)
        active = false
        lastAt = stamp(nil)
        render(nil)
    end
    local function serialize(self)
        if not __t(run) then
            return nil
        end
        tick(
            nil,
            stamp(nil),
            active
        )
        return copy(nil, run)
    end
    local function getResult(self)
        local ____opt_result_106
        if run ~= nil then
            ____opt_result_106 = run.result
        end
        return copy(nil, ____opt_result_106)
    end
    window:addEventListener(
        "difficulty-change",
        function(____, event)
            local ____changeMode_132 = changeMode
            local ____opt_130 = event.detail
            if ____opt_130 ~= nil then
                ____opt_130 = ____opt_130.mode
            end
            return ____changeMode_132(nil, ____opt_130)
        end
    )
    window:addEventListener("chapter-ended", render)
    if type(window.document) ~= "nil" then
        window.document:addEventListener(
            "visibilitychange",
            function() return tick(
                nil,
                stamp(nil),
                false
            ) end
        )
    end
    window.CampaignRun = __ord(
        {
            start = start,
            restore = restore,
            tick = tick,
            setActive = function(____, value) return tick(
                nil,
                stamp(nil),
                value
            ) end,
            setSuspended = setSuspended,
            confirmInitialMode = confirmInitialMode,
            canSetMode = canSetMode,
            isEasyLocked = function()
                local ____t_136 = __t
                local ____opt_result_135
                if run ~= nil then
                    ____opt_result_135 = run.easyLocked
                end
                return not not ____t_136(____opt_result_135) and not __t(suspended)
            end,
            serialize = serialize,
            getState = getState,
            getResult = getResult,
            finish = finish,
            format = format,
            render = render
        },
        "start,restore,tick,setActive,setSuspended,confirmInitialMode,canSetMode,isEasyLocked,serialize,getState,getResult,finish,format,render"
    )
end)(nil)
return ____exports
