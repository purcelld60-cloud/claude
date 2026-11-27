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
        local ____t_10 = __t
        local ____t_9 = __t
        local ____t_7 = __t
        local ____t_5 = __t
        local ____t_3 = __t
        local ____temp_2 = lastAt ~= nil
        __O[1266] = ____temp_2
        local ____temp_4 = if ____t_3(____temp_2) then active else __O[1266]
        __O[1267] = ____temp_4
        local ____temp_6 = if ____t_5(____temp_4) then not __t(suspended) else __O[1267]
        __O[1268] = ____temp_6
        local ____temp_8 = if ____t_7(____temp_6) then run else __O[1268]
        __O[1269] = ____temp_8
        if ____t_10(if ____t_9(____temp_8) then not __t(run.finished) else __O[1269]) then
            local delta = math.max(0, now - lastAt)
            run.elapsedMs = run.elapsedMs + delta
            local ____set_15 = __set
            local ____run_modeTime_13 = run.modeTime
            local ____run_mode_14 = run.mode
            local ____t_12 = __t
            local ____get_result_11 = __get(run.modeTime, run.mode)
            __O[1270] = ____get_result_11
            ____set_15(____run_modeTime_13, ____run_mode_14, if ____t_12(____get_result_11) then __O[1270] else 0 + delta)
        end
        lastAt = now
        local ____t_19 = __t
        local ____t_17 = __t
        local ____temp_16 = not not __t(nextActive) and not __t(suspended)
        __O[1271] = ____temp_16
        local ____temp_18 = if ____t_17(____temp_16) then not not __t(run) else __O[1271]
        __O[1272] = ____temp_18
        active = if ____t_19(____temp_18) then not __t(run.finished) else __O[1272]
        if now - lastRender > 250 then
            lastRender = now
            render(nil)
        end
        return if __t(run) then run.elapsedMs else 0
    end
    function modeSummary(self)
        if not __t(run) then
            return {mode = "normal", modeLabel = "NORMAL", mixed = false}
        end
        local used = run.modesUsed
        local mode = if __t(__call(used, "includes", "easy")) then "easy" else if __t(__call(used, "includes", "normal")) then "normal" else "hard"
        return {
            mode = mode,
            modeLabel = if __gt(
                __len(used),
                1
            ) then __add(
                "MISTO · ",
                __call(
                    __call(used, "map", label),
                    "join",
                    " / "
                )
            ) else label(nil, mode),
            mixed = __gt(
                __len(used),
                1
            )
        }
    end
    function finish(self)
        local ____t_67 = __t
        local ____t_66 = __t
        local ____temp_65 = not __t(run)
        __O[1283] = ____temp_65
        if ____t_67(if ____t_66(____temp_65) then __O[1283] else suspended) then
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
        return if __t(run) then __assign(
            {},
            copy(nil, run),
            {
                suspended = suspended,
                active = if __t(active) then not __t(suspended) else active,
                categoryMode = summary.mode,
                modeLabel = summary.modeLabel,
                mixed = summary.mixed
            }
        ) else nil
    end
    function format(self, ms)
        local seconds = math.floor(math.max(
            0,
            finite(nil, ms)
        ) / 1000)
        local hours = math.floor(seconds / 3600)
        return __add(
            __add(
                __add(
                    if __t(hours) then __add(
                        __call(
                            tostring(hours),
                            "padStart",
                            2,
                            "0"
                        ),
                        ":"
                    ) else "",
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
        local ____t_74 = __t
        local ____t_72 = __t
        local ____temp_71 = window.document:querySelector("#pauseScreen .rp-body")
        __O[1284] = ____temp_71
        local ____temp_73 = if ____t_72(____temp_71) then __O[1284] else window.document:querySelector("#pauseScreen .ranch-pause-body")
        __O[1285] = ____temp_73
        local pause = if ____t_74(____temp_73) then __O[1285] else window.document:querySelector("#pauseScreen .game-modal")
        if __t(if __t(____end) then not __t(window.document:getElementById("campaignRunResult")) else ____end) then
            local card = window.document:createElement("section")
            card.id = "campaignRunResult"
            card.className = "campaign-run-result"
            card:setAttribute("aria-label", "Tempo e dificuldade da campanha")
            card.innerHTML = "<span>TEMPO DE CAMPANHA</span><strong></strong><b></b><small></small>"
            ____end:append(card)
        end
        if __t(if __t(pause) then not __t(window.document:getElementById("campaignRunPause")) else pause) then
            local card = window.document:createElement("div")
            card.id = "campaignRunPause"
            card.className = "campaign-run-pause"
            card.innerHTML = "<span>⏱ TEMPO ATIVO</span><b></b><small></small>"
            pause:append(card)
        end
        local ____opt_result_77
        if run ~= nil then
            ____opt_result_77 = run.result
        end
        local result = ____opt_result_77
        local card = window.document:getElementById("campaignRunResult")
        if __t(card) then
            card.hidden = not __t(result)
            if __t(result) then
                card.dataset.mode = result.mode
                card:querySelector("strong").textContent = format(nil, result.elapsedMs)
                card:querySelector("b").textContent = result.modeLabel
                card:querySelector("small").textContent = if __t(result.partial) then "SAVE ANTERIOR · TEMPO PARCIAL DESDE A ATUALIZAÇÃO" else if result.mode == "easy" then "PRÊMIO: CHUPETA · GUGU DADA" else "ATÉ A DERROTA DE NIKOLAS · PAUSAS DESCONTADAS"
            end
        end
        local timer = window.document:getElementById("campaignRunPause")
        if __t(timer) then
            local ____t_79 = __t
            local ____temp_78 = not __t(run)
            __O[1286] = ____temp_78
            timer.hidden = if ____t_79(____temp_78) then __O[1286] else suspended
            timer:querySelector("b").textContent = if __t(run) then format(nil, run.elapsedMs) else ""
            timer:querySelector("small").textContent = if __t(run) then __add(if __t(run.partial) then "Tempo parcial · save anterior" else if __t(run.finished) then "Campanha concluída" else modeSummary(nil).modeLabel, if __t(run.easyLocked) then " · Fácil travado neste save" else "") else ""
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
        local ____t_1 = __t
        local ____get_result_0 = __get({easy = "FÁCIL", normal = "NORMAL", hard = "DIFÍCIL"}, mode)
        __O[1265] = ____get_result_0
        return if ____t_1(____get_result_0) then __O[1265] else "NORMAL"
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
        return if __isFiniteN(__TS__Number(value)) then __TS__Number(value) else fallback
    end
    copy = function(____, value) return if __t(value) then window.JSON:parse(window.JSON:stringify(value)) else nil end
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
                local ____opt_22 = window.Difficulty
                if ____opt_22 ~= nil then
                    ____opt_22 = ____opt_22.setMode
                end
                if ____opt_22 ~= nil then
                    ____opt_22(____opt_22, mode)
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
        local ____t_27 = __t
        local ____opt_result_26
        if data ~= nil then
            ____opt_result_26 = data.mode
        end
        local mode = if ____t_27(valid(nil, ____opt_result_26)) then data.mode else if __t(valid(nil, options.mode)) then options.mode else "normal"
        local ____opt_result_30
        if data ~= nil then
            ____opt_result_30 = data.schema
        end
        if ____opt_result_30 == 1 then
            local used = if __isArray(data.modesUsed) then __arr(__TS__Spread(__iter(__TS__New(
                Set,
                __call(data.modesUsed, "filter", valid)
            )))) else __arrL({mode}, 1)
            local ____math_max_result_43 = math.max(
                0,
                finite(nil, data.elapsedMs)
            )
            local ____mode_44 = mode
            local ____t_32 = __t
            local ____temp_31 = not not __t(data.easyLocked) or mode == "easy"
            __O[1273] = ____temp_31
            local ____temp_45 = if ____t_32(____temp_31) then __O[1273] else __call(used, "includes", "easy")
            local ____temp_46 = if __t(__len(used)) then used else __arrL({mode}, 1)
            local ____call_result_47 = __call(
                __call(
                    __call(
                        if __isArray(data.history) then data.history else __arrL({}, 0),
                        "filter",
                        function(____, e)
                            local ____t_34 = __t
                            local ____temp_33 = if __t(e) then valid(nil, e.mode) else e
                            __O[1274] = ____temp_33
                            return if ____t_34(____temp_33) then __isFiniteN(e.atMs) else __O[1274]
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
            local ____opt_35 = data.modeTime
            if ____opt_35 ~= nil then
                ____opt_35 = ____opt_35.easy
            end
            local ____math_max_result_41 = math.max(
                0,
                finite(nil, ____opt_35)
            )
            local ____opt_37 = data.modeTime
            if ____opt_37 ~= nil then
                ____opt_37 = ____opt_37.normal
            end
            local ____math_max_result_42 = math.max(
                0,
                finite(nil, ____opt_37)
            )
            local ____opt_39 = data.modeTime
            if ____opt_39 ~= nil then
                ____opt_39 = ____opt_39.hard
            end
            run = {
                schema = 1,
                elapsedMs = ____math_max_result_43,
                mode = ____mode_44,
                easyLocked = ____temp_45,
                modesUsed = ____temp_46,
                history = ____call_result_47,
                modeTime = {
                    easy = ____math_max_result_41,
                    normal = ____math_max_result_42,
                    hard = math.max(
                        0,
                        finite(nil, ____opt_39)
                    )
                },
                partial = not not __t(data.partial),
                finished = not not __t(data.finished),
                initialChoicePending = not not __t(data.initialChoicePending),
                result = if __t(if __t(data.result) then type(data.result) == "table" else data.result) then copy(nil, data.result) else nil
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
        if __t(if __t(options.completed) then not __t(run.finished) else options.completed) then
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
        local ____t_49 = __t
        local ____valid_result_48 = valid(nil, next)
        __O[1279] = ____valid_result_48
        local ____t_57 = __t
        local ____t_55 = __t
        local ____t_53 = __t
        local ____t_51 = __t
        local ____temp_50 = not __t(run)
        __O[1275] = ____temp_50
        local ____temp_52 = if ____t_51(____temp_50) then __O[1275] else suspended
        __O[1276] = ____temp_52
        local ____temp_54 = if ____t_53(____temp_52) then __O[1276] else not __t(run.easyLocked)
        __O[1277] = ____temp_54
        local ____temp_56 = if ____t_55(____temp_54) then __O[1277] else next == "easy"
        __O[1278] = ____temp_56
        return if ____t_49(____valid_result_48) then if ____t_57(____temp_56) then __O[1278] else restoring else __O[1279]
    end
    local function changeMode(self, next)
        local ____t_64 = __t
        local ____t_63 = __t
        local ____t_61 = __t
        local ____t_59 = __t
        local ____temp_58 = if __t(restoring) then restoring else suspended
        __O[1280] = ____temp_58
        local ____temp_60 = if ____t_59(____temp_58) then __O[1280] else not __t(run)
        __O[1281] = ____temp_60
        local ____temp_62 = if ____t_61(____temp_60) then __O[1281] else not __t(valid(nil, next))
        __O[1282] = ____temp_62
        if ____t_64(if ____t_63(____temp_62) then __O[1282] else next == run.mode) then
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
        local ____opt_result_70
        if run ~= nil then
            ____opt_result_70 = run.result
        end
        return copy(nil, ____opt_result_70)
    end
    window:addEventListener(
        "difficulty-change",
        function(____, event)
            local ____changeMode_82 = changeMode
            local ____opt_80 = event.detail
            if ____opt_80 ~= nil then
                ____opt_80 = ____opt_80.mode
            end
            return ____changeMode_82(nil, ____opt_80)
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
                local ____t_86 = __t
                local ____opt_result_85
                if run ~= nil then
                    ____opt_result_85 = run.easyLocked
                end
                return not not ____t_86(____opt_result_85) and not __t(suspended)
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
