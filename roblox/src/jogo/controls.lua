--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __le, __isFiniteN, __isInteger, __getq, __callq, __ord, __arrL, __iterar, __t, __get, __set, __arr = __JSR.__le, __JSR.__isFiniteN, __JSR.__isInteger, __JSR.__getq, __JSR.__callq, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__set, __JSR.__arr
local __len, __call, __add, __new, __iter, __entries, __assign, __isArray, __hypot, __re, __re_test = __JSR.__len, __JSR.__call, __JSR.__add, __JSR.__new, __JSR.__iter, __JSR.__entries, __JSR.__assign, __JSR.__isArray, __JSR.__hypot, __JSR.__re, __JSR.__re_test
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Spread = ____lualib.__TS__Spread
local __TS__ObjectFromEntries = ____lualib.__TS__ObjectFromEntries
local Set = ____lualib.Set
local __TS__New = ____lualib.__TS__New
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__Number = ____lualib.__TS__Number
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    local STORAGE = "daroca-controls-v1"
    local schema = 1
    local definitions = __arrL(
        {
            __arrL(
                {
                    "left",
                    "Esquerda",
                    "Movimento",
                    __arrL({"KeyA", "ArrowLeft"}, 2)
                },
                4
            ),
            __arrL(
                {
                    "right",
                    "Direita",
                    "Movimento",
                    __arrL({"KeyD", "ArrowRight"}, 2)
                },
                4
            ),
            __arrL(
                {
                    "up",
                    "Subir / mirar para cima",
                    "Movimento",
                    __arrL({"KeyW", "ArrowUp"}, 2)
                },
                4
            ),
            __arrL(
                {
                    "down",
                    "Descer / mirar para baixo",
                    "Movimento",
                    __arrL({"KeyS", "ArrowDown"}, 2)
                },
                4
            ),
            __arrL(
                {
                    "jump",
                    "Pular / segurar para voar",
                    "Movimento",
                    __arrL({"Space"}, 1)
                },
                4
            ),
            __arrL(
                {
                    "paper",
                    "Papel / golpe físico",
                    "Combate",
                    __arrL({"KeyJ"}, 1)
                },
                4
            ),
            __arrL(
                {
                    "fart",
                    "Peido / ataque à distância",
                    "Combate",
                    __arrL({"KeyK"}, 1)
                },
                4
            ),
            __arrL(
                {
                    "dash",
                    "Dash",
                    "Combate",
                    __arrL({"KeyL", "ShiftLeft"}, 2)
                },
                4
            ),
            __arrL(
                {
                    "reeis",
                    "Reeis / combo da arena",
                    "Poderes",
                    __arrL({"KeyR"}, 1)
                },
                4
            ),
            __arrL(
                {
                    "vehicle",
                    "Carro a gás",
                    "Poderes",
                    __arrL({"KeyV"}, 1)
                },
                4
            ),
            __arrL(
                {
                    "bivolt",
                    "Bivolt",
                    "Poderes",
                    __arrL({"KeyB"}, 1)
                },
                4
            ),
            __arrL(
                {
                    "taunt",
                    "Provocar / emote",
                    "Combate",
                    __arrL({"KeyT"}, 1)
                },
                4
            ),
            __arrL(
                {
                    "poder1",
                    "Poder equipado 1 (Campanha 2)",
                    "Poderes",
                    __arrL({"KeyU"}, 1)
                },
                4
            ),
            __arrL(
                {
                    "poder2",
                    "Poder equipado 2 (Campanha 2)",
                    "Poderes",
                    __arrL({"KeyI"}, 1)
                },
                4
            ),
            __arrL(
                {
                    "interact",
                    "Conversar / interagir",
                    "Aventura",
                    __arrL({"KeyE", "Enter"}, 2)
                },
                4
            ),
            __arrL(
                {
                    "pause",
                    "Pausar / voltar",
                    "Aventura",
                    __arrL({"Escape"}, 1)
                },
                4
            )
        },
        16
    )
    local actions = __call(
        definitions,
        "map",
        function(____, ____bindingPattern0)
            local bindings
            local group
            local label
            local id
            id = ____bindingPattern0[1]
            label = ____bindingPattern0[2]
            group = ____bindingPattern0[3]
            bindings = ____bindingPattern0[4]
            return {
                id = id,
                label = label,
                group = group,
                defaultBindings = __arr(__TS__Spread(__iter(bindings)))
            }
        end
    )
    local function canonicalCode(____, code)
        local ____temp_1
        if code == "ShiftRight" then
            ____temp_1 = "ShiftLeft"
        else
            local ____t_result_0
            if __t(code) then
                ____t_result_0 = code
            else
                ____t_result_0 = ""
            end
            ____temp_1 = tostring(____t_result_0)
        end
        return ____temp_1
    end
    local function validCode(____, code)
        return __re_test(
            __re("^(Key[A-Z]|Digit[0-9]|Numpad[0-9]|Numpad(?:Add|Subtract|Multiply|Divide|Decimal|Enter)|Arrow(?:Left|Right|Up|Down)|Space|Enter|Escape|ShiftLeft|Backspace|Delete|Insert|Home|End|PageUp|PageDown|Minus|Equal|BracketLeft|BracketRight|Backslash|Semicolon|Quote|Backquote|Comma|Period|Slash|IntlBackslash|IntlRo|IntlYen)$", ""),
            code
        )
    end
    local function defaults()
        return {
            schema = schema,
            bindings = __TS__ObjectFromEntries(__call(
                definitions,
                "map",
                function(____, ____bindingPattern0)
                    local bindings
                    local id
                    id = ____bindingPattern0[1]
                    bindings = ____bindingPattern0[4]
                    return __arrL(
                        {
                            id,
                            __arr(__TS__Spread(__iter(bindings)))
                        },
                        2
                    )
                end
            )),
            sensitivity = 1,
            deadzone = 0.12
        }
    end
    local function clamp(____, n, min, max)
        return math.max(
            min,
            math.min(max, n)
        )
    end
    local function restore(self)
        local fallback = defaults(nil)
        do
            local ____try, ____hasReturned, ____returnValue = pcall(function()
                local saved = window.JSON:parse(window.localStorage:getItem(STORAGE))
                if __t(not __t(saved) or saved.schema ~= schema) then
                    return true, fallback
                end
                local used = __TS__New(
                    Set,
                    __arrL({"Escape"}, 1)
                )
                for ____, ____value in __iterar((actions)) do
                    local id = ____value.id
                    do
                        if id == "pause" then
                            continue
                        end
                        local ____isArray_result_2
                        if __isArray(__getq(saved.bindings, id)) then
                            ____isArray_result_2 = __get(saved.bindings, id)
                        else
                            ____isArray_result_2 = __get(fallback.bindings, id)
                        end
                        local candidates = ____isArray_result_2
                        local codes = __arrL({}, 0)
                        for ____, raw in __iterar((__call(candidates, "slice", 0, 2))) do
                            local code = canonicalCode(nil, raw)
                            local ____t_8 = __t
                            local ____t_result_7
                            local ____t_6 = __t
                            local ____t_result_5
                            local ____t_4 = __t
                            local ____validCode_result_3 = validCode(nil, code)
                            __O[1432] = ____validCode_result_3
                            if ____t_4(____validCode_result_3) then
                                ____t_result_5 = code ~= "Escape"
                            else
                                ____t_result_5 = __O[1432]
                            end
                            __O[1433] = ____t_result_5
                            if ____t_6(____t_result_5) then
                                ____t_result_7 = not __t(__call(used, "has", code))
                            else
                                ____t_result_7 = __O[1433]
                            end
                            if ____t_8(____t_result_7) then
                                __call(codes, "push", code)
                                __call(used, "add", code)
                            end
                        end
                        __set(fallback.bindings, id, codes)
                    end
                end
                local ____getq_11 = __getq
                local ____opt_9 = saved.bindings
                if ____opt_9 ~= nil then
                    ____opt_9 = ____opt_9.pause
                end
                local pauseExtra = canonicalCode(
                    nil,
                    ____getq_11(____opt_9, 1)
                )
                fallback.bindings.pause = __arrL({"Escape"}, 1)
                local ____t_15 = __t
                local ____t_result_14
                local ____t_13 = __t
                local ____validCode_result_12 = validCode(nil, pauseExtra)
                __O[1434] = ____validCode_result_12
                if ____t_13(____validCode_result_12) then
                    ____t_result_14 = not __t(__call(used, "has", pauseExtra))
                else
                    ____t_result_14 = __O[1434]
                end
                if ____t_15(____t_result_14) then
                    __call(fallback.bindings.pause, "push", pauseExtra)
                end
                if __t(__call(
                    actions,
                    "some",
                    function(____, ____bindingPattern0)
                        local id
                        id = ____bindingPattern0.id
                        return not __t(__len(__get(fallback.bindings, id)))
                    end
                )) then
                    return true, defaults(nil)
                end
                if __isFiniteN(__TS__Number(saved.sensitivity)) then
                    fallback.sensitivity = clamp(
                        nil,
                        __TS__Number(saved.sensitivity),
                        0.5,
                        2
                    )
                end
                if __isFiniteN(__TS__Number(saved.deadzone)) then
                    fallback.deadzone = clamp(
                        nil,
                        __TS__Number(saved.deadzone),
                        0,
                        0.4
                    )
                end
            end)
            if ____try and ____hasReturned then
                return ____returnValue
            end
        end
        return fallback
    end
    local state = restore(nil)
    local function getState()
        return {
            schema = schema,
            bindings = __TS__ObjectFromEntries(__call(
                __entries(state.bindings),
                "map",
                function(____, ____bindingPattern0)
                    local codes
                    local id
                    id = ____bindingPattern0[1]
                    codes = ____bindingPattern0[2]
                    return __arrL(
                        {
                            id,
                            __arr(__TS__Spread(__iter(codes)))
                        },
                        2
                    )
                end
            )),
            sensitivity = state.sensitivity,
            deadzone = state.deadzone
        }
    end
    local labels = __ord({
        Space = "Espaço",
        ArrowLeft = "←",
        ArrowRight = "→",
        ArrowUp = "↑",
        ArrowDown = "↓",
        Escape = "Esc",
        Enter = "Enter",
        ShiftLeft = "Shift",
        Backspace = "Apagar",
        Delete = "Del",
        Insert = "Insert",
        Home = "Home",
        End = "End",
        PageUp = "PgUp",
        PageDown = "PgDn",
        Minus = "−",
        Equal = "=",
        BracketLeft = "[",
        BracketRight = "]",
        Backslash = "\\",
        Semicolon = "Ç / ;",
        Quote = "'",
        Backquote = "`",
        Comma = ",",
        Period = ".",
        Slash = "/",
        IntlBackslash = "\\",
        IntlRo = "/",
        IntlYen = "¥",
        NumpadAdd = "Num +",
        NumpadSubtract = "Num −",
        NumpadMultiply = "Num ×",
        NumpadDivide = "Num ÷",
        NumpadDecimal = "Num .",
        NumpadEnter = "Num Enter"
    }, "Space,ArrowLeft,ArrowRight,ArrowUp,ArrowDown,Escape,Enter,ShiftLeft,Backspace,Delete,Insert,Home,End,PageUp,PageDown,Minus,Equal,BracketLeft,BracketRight,Backslash,Semicolon,Quote,Backquote,Comma,Period,Slash,IntlBackslash,IntlRo,IntlYen,NumpadAdd,NumpadSubtract,NumpadMultiply,NumpadDivide,NumpadDecimal,NumpadEnter")
    local function labelForCode(____, raw)
        local code = canonicalCode(nil, raw)
        local ____t_result_22
        local ____t_17 = __t
        local ____get_result_16 = __get(labels, code)
        __O[1435] = ____get_result_16
        if ____t_17(____get_result_16) then
            ____t_result_22 = __O[1435]
        else
            local ____re_test_result_21
            if __re_test(
                __re("^Key[A-Z]$", ""),
                code
            ) then
                ____re_test_result_21 = __call(code, "slice", 3)
            else
                local ____re_test_result_20
                if __re_test(
                    __re("^Digit[0-9]$", ""),
                    code
                ) then
                    ____re_test_result_20 = __call(code, "slice", 5)
                else
                    local ____re_test_result_19
                    if __re_test(
                        __re("^Numpad[0-9]$", ""),
                        code
                    ) then
                        ____re_test_result_19 = __add(
                            "Num ",
                            __call(code, "slice", 6)
                        )
                    else
                        local ____t_result_18
                        if __t(code) then
                            ____t_result_18 = code
                        else
                            ____t_result_18 = "Sem tecla"
                        end
                        ____re_test_result_19 = ____t_result_18
                    end
                    ____re_test_result_20 = ____re_test_result_19
                end
                ____re_test_result_21 = ____re_test_result_20
            end
            ____t_result_22 = ____re_test_result_21
        end
        return ____t_result_22
    end
    local function persist(self)
        local saved = true
        do
            local function ____catch()
                saved = false
            end
            local ____try = pcall(function()
                window.localStorage:setItem(
                    STORAGE,
                    window.JSON:stringify(state)
                )
            end)
            if not ____try then
                ____catch()
            end
        end
        window:dispatchEvent(__new(
            "CustomEvent",
            "controls-change",
            {detail = __assign(
                {},
                getState(nil),
                {saved = saved}
            )}
        ))
        return {
            ok = true,
            saved = saved,
            state = getState(nil)
        }
    end
    local function fail(____, message)
        return {ok = false, message = message}
    end
    local function setBinding(self, action, raw, slot, options)
        if slot == nil then
            slot = 0
        end
        if options == nil then
            options = {}
        end
        local ____t_28 = __t
        local ____t_result_27
        local ____t_26 = __t
        local ____t_result_25
        local ____t_24 = __t
        local ____temp_23 = not __t(__get(state.bindings, action)) or not __isInteger(slot)
        __O[1436] = ____temp_23
        if ____t_24(____temp_23) then
            ____t_result_25 = __O[1436]
        else
            ____t_result_25 = slot < 0
        end
        __O[1437] = ____t_result_25
        if ____t_26(____t_result_25) then
            ____t_result_27 = __O[1437]
        else
            ____t_result_27 = slot > 1
        end
        if ____t_28(____t_result_27) then
            return fail(nil, "Ação ou posição de tecla inválida.")
        end
        local code = canonicalCode(nil, raw)
        if not __t(validCode(nil, code)) then
            return fail(nil, "Escolha uma tecla de jogo. Tab, Ctrl, Alt, Windows e atalhos do navegador ficam livres.")
        end
        local ____t_35 = __t
        local ____t_result_34
        local ____t_30 = __t
        local ____temp_29 = code == "Escape" and action ~= "pause"
        __O[1439] = ____temp_29
        if ____t_30(____temp_29) then
            ____t_result_34 = __O[1439]
        else
            local ____t_result_33
            local ____t_32 = __t
            local ____temp_31 = action == "pause" and slot == 0
            __O[1438] = ____temp_31
            if ____t_32(____temp_31) then
                ____t_result_33 = code ~= "Escape"
            else
                ____t_result_33 = __O[1438]
            end
            ____t_result_34 = ____t_result_33
        end
        if ____t_35(____t_result_34) then
            return fail(nil, "Esc fica reservado para pausar e sair dos menus.")
        end
        if __get(
            __get(state.bindings, action),
            slot
        ) == code then
            return {
                ok = true,
                state = getState(nil),
                unchanged = true
            }
        end
        if __t(__call(
            __get(state.bindings, action),
            "some",
            function(____, key, index) return index ~= slot and key == code end
        )) then
            return fail(nil, "Esta ação já usa essa tecla. Escolha outra alternativa.")
        end
        local conflicts = __arrL({}, 0)
        for ____, item in __iterar((actions)) do
            if item.id ~= action then
                __call(
                    __get(state.bindings, item.id),
                    "forEach",
                    function(____, key, index)
                        if key == code then
                            __call(conflicts, "push", {action = item.id, slot = index, label = item.label})
                        end
                    end
                )
            end
        end
        local previous = __get(
            __get(state.bindings, action),
            slot
        )
        local ____t_39 = __t
        local ____t_result_38
        local ____t_37 = __t
        local ____t_result_36
        if __t(__len(conflicts)) then
            ____t_result_36 = not __t(options.replaceConflicts)
        else
            ____t_result_36 = __len(conflicts)
        end
        __O[1440] = ____t_result_36
        if ____t_37(____t_result_36) then
            ____t_result_38 = not __t(options.swapConflicts)
        else
            ____t_result_38 = __O[1440]
        end
        if ____t_39(____t_result_38) then
            return {ok = false, conflicts = conflicts, message = "Essa tecla já está em uso. Confirme a troca ou escolha outra."}
        end
        local ____t_41 = __t
        local ____t_result_40
        if __t(__len(conflicts)) then
            ____t_result_40 = options.swapConflicts
        else
            ____t_result_40 = __len(conflicts)
        end
        if ____t_41(____t_result_40) then
            if __t(__len(conflicts) ~= 1 or not __t(previous)) then
                return fail(nil, "Escolha uma tecla livre para adicionar uma alternativa.")
            end
            local conflict = __get(conflicts, 0)
            __set(
                __get(state.bindings, conflict.action),
                conflict.slot,
                previous
            )
        elseif __t(__len(conflicts)) then
            if __t(__call(
                conflicts,
                "some",
                function(____, ____bindingPattern0)
                    local other
                    other = ____bindingPattern0.action
                    return __le(
                        __len(__get(state.bindings, other)),
                        1
                    )
                end
            )) then
                return __assign(
                    {},
                    fail(nil, "Essa troca deixaria uma ação sem tecla. Use a troca de teclas para manter os dois comandos."),
                    {conflicts = conflicts}
                )
            end
            for ____, ____value in __iterar((conflicts)) do
                local other = ____value.action
                local index = ____value.slot
                __call(
                    __get(state.bindings, other),
                    "splice",
                    index,
                    1
                )
            end
        end
        __set(
            __get(state.bindings, action),
            slot,
            code
        )
        __set(
            state.bindings,
            action,
            __call(
                __get(state.bindings, action),
                "filter",
                window.Boolean
            )
        )
        return persist(nil)
    end
    local function clearBinding(self, action, slot)
        if slot == nil then
            slot = 0
        end
        local ____t_47 = __t
        local ____t_result_46
        local ____t_45 = __t
        local ____t_result_44
        local ____t_43 = __t
        local ____temp_42 = not __t(__get(state.bindings, action)) or not __isInteger(slot)
        __O[1441] = ____temp_42
        if ____t_43(____temp_42) then
            ____t_result_44 = __O[1441]
        else
            ____t_result_44 = slot < 0
        end
        __O[1442] = ____t_result_44
        if ____t_45(____t_result_44) then
            ____t_result_46 = __O[1442]
        else
            ____t_result_46 = slot > 1
        end
        if ____t_47(____t_result_46) then
            return fail(nil, "Ação ou posição de tecla inválida.")
        end
        if __t(action == "pause" and slot == 0) then
            return fail(nil, "Esc fica reservado para sair dos menus.")
        end
        if __le(
            __len(__get(state.bindings, action)),
            1
        ) then
            return fail(nil, "Mantenha pelo menos uma tecla para esta ação.")
        end
        __call(
            __get(state.bindings, action),
            "splice",
            slot,
            1
        )
        return persist(nil)
    end
    local function setNumber(self, key, value, min, max)
        local n = __TS__Number(value)
        if not __isFiniteN(n) then
            return fail(nil, "Use um valor numérico válido.")
        end
        __set(
            state,
            key,
            clamp(nil, n, min, max)
        )
        return persist(nil)
    end
    local function matches(____, action, code)
        return not not __t(__callq(
            __get(state.bindings, action),
            "includes",
            canonicalCode(nil, code)
        ))
    end
    local function pressed(self, action, keys)
        if keys == nil then
            keys = {}
        end
        return not not __t(__callq(
            __get(state.bindings, action),
            "some",
            function(____, code)
                local ____t_result_53
                local ____t_49 = __t
                local ____get_result_48 = __get(keys, code)
                __O[1444] = ____get_result_48
                if ____t_49(____get_result_48) then
                    ____t_result_53 = __O[1444]
                else
                    local ____t_result_52
                    local ____t_51 = __t
                    local ____temp_50 = code == "ShiftLeft"
                    __O[1443] = ____temp_50
                    if ____t_51(____temp_50) then
                        ____t_result_52 = keys.ShiftRight
                    else
                        ____t_result_52 = __O[1443]
                    end
                    ____t_result_53 = ____t_result_52
                end
                return ____t_result_53
            end
        ))
    end
    local function transformJoystick(self, x, y)
        local ____t_result_56
        local ____t_55 = __t
        local ____TS__Number_result_54 = __TS__Number(x)
        __O[1445] = ____TS__Number_result_54
        if ____t_55(____TS__Number_result_54) then
            ____t_result_56 = __O[1445]
        else
            ____t_result_56 = 0
        end
        x = clamp(nil, ____t_result_56, -1, 1)
        local ____t_result_59
        local ____t_58 = __t
        local ____TS__Number_result_57 = __TS__Number(y)
        __O[1446] = ____TS__Number_result_57
        if ____t_58(____TS__Number_result_57) then
            ____t_result_59 = __O[1446]
        else
            ____t_result_59 = 0
        end
        y = clamp(nil, ____t_result_59, -1, 1)
        local magnitude = __hypot(x, y)
        if magnitude <= state.deadzone then
            return {x = 0, y = 0}
        end
        local response = clamp(nil, (magnitude - state.deadzone) / (1 - state.deadzone), 0, 1) ^ (1 / state.sensitivity)
        return {x = x / magnitude * response, y = y / magnitude * response}
    end
    window.ControlSettings = __ord(
        {
            schema = schema,
            actions = actions,
            getState = getState,
            canonicalCode = canonicalCode,
            labelForCode = labelForCode,
            getLabel = function(____, action, slot)
                local ____temp_65
                if slot == nil then
                    local ____call_64 = __call
                    local ____call_63 = __call
                    local ____t_result_62
                    local ____t_61 = __t
                    local ____get_result_60 = __get(state.bindings, action)
                    __O[1447] = ____get_result_60
                    if ____t_61(____get_result_60) then
                        ____t_result_62 = __O[1447]
                    else
                        ____t_result_62 = __arrL({}, 0)
                    end
                    ____temp_65 = ____call_64(
                        ____call_63(____t_result_62, "map", labelForCode),
                        "join",
                        " / "
                    )
                else
                    ____temp_65 = labelForCode(
                        nil,
                        __getq(
                            __get(state.bindings, action),
                            slot
                        )
                    )
                end
                return ____temp_65
            end,
            matches = matches,
            pressed = pressed,
            getSensitivity = function() return state.sensitivity end,
            getActionsForCode = function(____, code) return __call(
                __call(
                    actions,
                    "filter",
                    function(____, ____bindingPattern0)
                        local id
                        id = ____bindingPattern0.id
                        return matches(nil, id, code)
                    end
                ),
                "map",
                function(____, ____bindingPattern0)
                    local id
                    id = ____bindingPattern0.id
                    return id
                end
            ) end,
            setBinding = setBinding,
            clearBinding = clearBinding,
            setSensitivity = function(____, value) return setNumber(
                nil,
                "sensitivity",
                value,
                0.5,
                2
            ) end,
            setDeadzone = function(____, value) return setNumber(
                nil,
                "deadzone",
                value,
                0,
                0.4
            ) end,
            transformJoystick = transformJoystick,
            reset = function()
                state = defaults(nil)
                return persist(nil)
            end
        },
        "schema,actions,getState,canonicalCode,labelForCode,getLabel,matches,pressed,getSensitivity,getActionsForCode,setBinding,clearBinding,setSensitivity,setDeadzone,transformJoystick,reset"
    )
end)(nil)
return ____exports
