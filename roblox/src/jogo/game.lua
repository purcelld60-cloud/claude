--!native
--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __newExpr, __lt, __le, __gt, __ge, __isFiniteV, __isFiniteN, __isInteger, __getq, __lenq, __callq, __mod = __JSR.__newExpr, __JSR.__lt, __JSR.__le, __JSR.__gt, __JSR.__ge, __JSR.__isFiniteV, __JSR.__isFiniteN, __JSR.__isInteger, __JSR.__getq, __JSR.__lenq, __JSR.__callq, __JSR.__mod
local __ord, __arrL, __iterar, __t, __get, __set, __inc, __arr, __len, __call, __add, __new = __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__set, __JSR.__inc, __JSR.__arr, __JSR.__len, __JSR.__call, __JSR.__add, __JSR.__new
local __iter, __keys, __entries, __assign, __isArray, __arrayFrom, __bor, __hypot, __re, __re_replace, __re_split = __JSR.__iter, __JSR.__keys, __JSR.__entries, __JSR.__assign, __JSR.__isArray, __JSR.__arrayFrom, __JSR.__bor, __JSR.__hypot, __JSR.__re, __JSR.__re_replace, __JSR.__re_split
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__Spread = ____lualib.__TS__Spread
local __TS__Number = ____lualib.__TS__Number
local __TS__MathSign = ____lualib.__TS__MathSign
local __TS__Delete = ____lualib.__TS__Delete
local __TS__SparseArrayNew = ____lualib.__TS__SparseArrayNew
local __TS__SparseArrayPush = ____lualib.__TS__SparseArrayPush
local __TS__SparseArraySpread = ____lualib.__TS__SparseArraySpread
local Set = ____lualib.Set
local __TS__New = ____lualib.__TS__New
local Map = ____lualib.Map
local WeakMap = ____lualib.WeakMap
local ____exports = {}
local __O = {};
(function()
    local __L1 = {}
    __L1.bivoltStatus = function(self)
        local ____t_result_6
        local ____t_5 = __t
        local ____opt_2 = window.BivoltSkill
        if ____opt_2 ~= nil then
            ____opt_2 = ____opt_2.getStatus
        end
        local ____opt_result_4
        if ____opt_2 ~= nil then
            ____opt_result_4 = ____opt_2(____opt_2, __L1.q)
        end
        __O[1615] = ____opt_result_4
        if ____t_5(____opt_result_4) then
            ____t_result_6 = __O[1615]
        else
            ____t_result_6 = {
                unlocked = false,
                charges = 0,
                remaining = 0,
                cooldown = 0,
                active = false,
                ready = false
            }
        end
        return ____t_result_6
    end
    __L1.createBivoltControl = function(self)
        local container = window.document:querySelector(".touch-extras")
        local ____t_12 = __t
        local ____t_result_11
        local ____t_10 = __t
        local ____t_result_9
        local ____t_8 = __t
        local ____temp_7 = not __t(container)
        __O[1616] = ____temp_7
        if ____t_8(____temp_7) then
            ____t_result_9 = __O[1616]
        else
            ____t_result_9 = __L1["$"](__L1, "bivoltBtn")
        end
        __O[1617] = ____t_result_9
        if ____t_10(____t_result_9) then
            ____t_result_11 = __O[1617]
        else
            ____t_result_11 = not __t(window.BivoltSkill)
        end
        if ____t_12(____t_result_11) then
            return
        end
        local button = window.document:createElement("button")
        button.id = "bivoltBtn"
        button.type = "button"
        button.className = "touch-btn bivolt-btn"
        button.dataset.action = "bivolt"
        button.innerHTML = __add(
            window.BivoltSkill:iconSVG(),
            "<small class=\"bivolt-label\">BIVOLT</small><span class=\"bivolt-count\">0</span><kbd>B</kbd>"
        )
        container:prepend(button)
    end
    __L1.updateBivoltUI = function(self)
        local state = __L1:bivoltStatus()
        local button = __L1["$"](__L1, "bivoltBtn")
        if __t(button) then
            button.hidden = not __t(__L1.started)
            for ____, name in __iterar((__arrL({"active", "cooling", "locked", "empty"}, 4))) do
                local ____self_16 = button.classList
                local ____self_16_toggle_17 = ____self_16.toggle
                local ____temp_15
                if name == "active" then
                    ____temp_15 = state.active
                else
                    local ____temp_14
                    if name == "cooling" then
                        ____temp_14 = __gt(state.cooldown, 0) and not __t(state.active)
                    else
                        local ____temp_13
                        if name == "locked" then
                            ____temp_13 = not __t(state.unlocked)
                        else
                            ____temp_13 = __le(state.charges, 0)
                        end
                        ____temp_14 = ____temp_13
                    end
                    ____temp_15 = ____temp_14
                end
                ____self_16_toggle_17(____self_16, name, ____temp_15)
            end
            local label = button:querySelector(".bivolt-label")
            local count = button:querySelector(".bivolt-count")
            if __t(label) then
                local ____t_result_19
                if __t(state.active) then
                    ____t_result_19 = __add(
                        __call(state.remaining, "toFixed", 1),
                        "s"
                    )
                else
                    local ____gt_result_18
                    if __gt(state.cooldown, 0) then
                        ____gt_result_18 = __add(
                            math.ceil(state.cooldown),
                            "s"
                        )
                    else
                        ____gt_result_18 = "BIVOLT"
                    end
                    ____t_result_19 = ____gt_result_18
                end
                label.textContent = ____t_result_19
            end
            if __t(count) then
                count.textContent = state.charges
            end
            local ____button_setAttribute_23 = button.setAttribute
            local ____t_result_22
            if __t(state.active) then
                ____t_result_22 = __add(
                    __add(
                        "Bivolt ativo por mais ",
                        __call(state.remaining, "toFixed", 1)
                    ),
                    " segundos"
                )
            else
                local ____temp_21
                if not __t(state.unlocked) then
                    ____temp_21 = "Bivolt: encontre as garotas na Casa de Rayssa"
                else
                    local ____gt_result_20
                    if __gt(state.cooldown, 0) then
                        ____gt_result_20 = __add(
                            __add(
                                "Bivolt recarregando por ",
                                math.ceil(state.cooldown)
                            ),
                            " segundos"
                        )
                    else
                        ____gt_result_20 = __add(
                            __add("Usar Bivolt por 10 segundos. ", state.charges),
                            " latas"
                        )
                    end
                    ____temp_21 = ____gt_result_20
                end
                ____t_result_22 = ____temp_21
            end
            ____button_setAttribute_23(button, "aria-label", ____t_result_22)
            local ____button_setAttribute_31 = button.setAttribute
            local ____t_result_30
            local ____t_29 = __t
            local ____t_result_28
            local ____t_27 = __t
            local ____t_result_26
            local ____t_25 = __t
            local ____temp_24 = not __t(state.ready)
            __O[1618] = ____temp_24
            if ____t_25(____temp_24) then
                ____t_result_26 = __O[1618]
            else
                ____t_result_26 = __L1.paused
            end
            __O[1619] = ____t_result_26
            if ____t_27(____t_result_26) then
                ____t_result_28 = __O[1619]
            else
                ____t_result_28 = not not __t(__L1.dialog)
            end
            __O[1620] = ____t_result_28
            if ____t_29(____t_result_28) then
                ____t_result_30 = __O[1620]
            else
                ____t_result_30 = not not __t(__L1.cutscene)
            end
            ____button_setAttribute_31(
                button,
                "aria-disabled",
                tostring(____t_result_30)
            )
            button.title = __t(state.active) and "Todos os atributos fortalecidos por 10 segundos" or (not __t(state.unlocked) and "Missão do Bivolt na Casa de Rayssa" or "B · energético: vida, gás, força e agilidade por 10 segundos")
        end
        local ____opt_32 = __L1["$"](__L1, "gameShell")
        if ____opt_32 ~= nil then
            ____opt_32.classList:toggle("is-bivolt", state.active)
        end
    end
    __L1.syncOllyanPlayer = function(self)
        if not __t(__L1.ollyanEncounter) then
            return
        end
        window.OllyanEncounter:setBonuses(
            __L1.ollyanEncounter,
            __L1:bonus()
        )
        window.OllyanEncounter:setPlayer(__L1.ollyanEncounter, {hp = __L1.player.hp, gas = __L1.player.gas})
    end
    __L1.activateBivolt = function(self)
        local ____t_56 = __t
        local ____t_result_55
        local ____t_53 = __t
        local ____t_result_52
        local ____t_51 = __t
        local ____t_result_50
        local ____t_49 = __t
        local ____t_result_48
        local ____t_47 = __t
        local ____t_result_46
        local ____t_43 = __t
        local ____t_result_42
        local ____t_41 = __t
        local ____t_result_40
        local ____t_39 = __t
        local ____t_result_38
        local ____t_37 = __t
        local ____t_result_36
        local ____t_35 = __t
        local ____temp_34 = not __t(__L1.started)
        __O[1621] = ____temp_34
        if ____t_35(____temp_34) then
            ____t_result_36 = __O[1621]
        else
            ____t_result_36 = __L1.paused
        end
        __O[1622] = ____t_result_36
        if ____t_37(____t_result_36) then
            ____t_result_38 = __O[1622]
        else
            ____t_result_38 = __L1.dialog
        end
        __O[1623] = ____t_result_38
        if ____t_39(____t_result_38) then
            ____t_result_40 = __O[1623]
        else
            ____t_result_40 = __L1.cutscene
        end
        __O[1624] = ____t_result_40
        if ____t_41(____t_result_40) then
            ____t_result_42 = __O[1624]
        else
            ____t_result_42 = __L1.routeTransition
        end
        __O[1625] = ____t_result_42
        if ____t_43(____t_result_42) then
            ____t_result_46 = __O[1625]
        else
            local ____opt_44 = __L1.training
            if ____opt_44 ~= nil then
                ____opt_44 = ____opt_44.active
            end
            ____t_result_46 = ____opt_44
        end
        __O[1626] = ____t_result_46
        if ____t_47(____t_result_46) then
            ____t_result_48 = __O[1626]
        else
            ____t_result_48 = __L1.activity
        end
        __O[1627] = ____t_result_48
        if ____t_49(____t_result_48) then
            ____t_result_50 = __O[1627]
        else
            ____t_result_50 = __L1.won
        end
        __O[1628] = ____t_result_50
        if ____t_51(____t_result_50) then
            ____t_result_52 = __O[1628]
        else
            ____t_result_52 = __L1.defeated
        end
        __O[1629] = ____t_result_52
        if ____t_53(____t_result_52) then
            ____t_result_55 = __O[1629]
        else
            local ____t_result_54
            if __t(__L1.ollyanEncounter) then
                ____t_result_54 = __L1.ollyanEncounter.stage ~= "fight"
            else
                ____t_result_54 = __L1.ollyanEncounter
            end
            ____t_result_55 = ____t_result_54
        end
        if ____t_56(____t_result_55) then
            return false
        end
        local before = __L1:bonus()
        local ____opt_59 = window.BivoltSkill
        if ____opt_59 ~= nil then
            ____opt_59 = ____opt_59.activate
        end
        local ____opt_result_61
        if ____opt_59 ~= nil then
            ____opt_result_61 = ____opt_59(____opt_59, __L1.q)
        end
        local result = ____opt_result_61
        local ____t_65 = __t
        local ____opt_result_64
        if result ~= nil then
            ____opt_result_64 = result.ok
        end
        if not ____t_65(____opt_result_64) then
            local ____L1_toast_71 = __L1.toast
            local ____t_result_70
            local ____t_69 = __t
            local ____opt_result_68
            if result ~= nil then
                ____opt_result_68 = result.message
            end
            __O[1630] = ____opt_result_68
            if ____t_69(____opt_result_68) then
                ____t_result_70 = __O[1630]
            else
                ____t_result_70 = "Converse com as garotas na Casa de Rayssa para encontrar o Bivolt."
            end
            ____L1_toast_71(__L1, ____t_result_70)
            return false
        end
        local after = __L1:bonus()
        __L1.player.hp = math.min(
            after.maxHP,
            __L1.player.hp + math.max(0, after.maxHP - before.maxHP)
        )
        __L1.player.gas = math.min(
            after.maxGas,
            __L1.player.gas + math.max(0, after.maxGas - before.maxGas)
        )
        __L1:syncOllyanPlayer()
        __L1:floating(__L1.player.x, __L1.player.y - 112, "BIVOLT! 10 SEGUNDOS!", "#ffe68f")
        __L1:fx(
            __L1.player.x,
            __L1.player.y - 40,
            "#f2d874",
            26,
            125
        )
        __L1:beep(770, 0.15, "triangle")
        local ____L1_toast_73 = __L1.toast
        local ____t_result_72
        if __t(result.message) then
            ____t_result_72 = result.message
        else
            ____t_result_72 = "BIVOLT! Todos os atributos fortalecidos por 10 segundos."
        end
        ____L1_toast_73(__L1, ____t_result_72)
        __L1:updateUI()
        __L1:save()
        return true
    end
    __L1.updateBivolt = function(self, dt)
        local ____opt_76 = window.BivoltSkill
        if ____opt_76 ~= nil then
            ____opt_76 = ____opt_76.update
        end
        local ____opt_result_78
        if ____opt_76 ~= nil then
            ____opt_result_78 = ____opt_76(____opt_76, dt)
        end
        local result = ____opt_result_78
        local ____t_82 = __t
        local ____opt_result_81
        if result ~= nil then
            ____opt_result_81 = result.expired
        end
        if ____t_82(____opt_result_81) then
            __L1.player.hp = math.min(
                __L1.player.hp,
                __L1:bonus().maxHP
            )
            __L1.player.gas = math.min(
                __L1.player.gas,
                __L1:bonus().maxGas
            )
            __L1:syncOllyanPlayer()
            __L1:updateUI()
        end
    end
    __L1.resetBivolt = function(self)
        local ____opt_85 = window.BivoltSkill
        if ____opt_85 ~= nil then
            ____opt_85 = ____opt_85.reset
        end
        if ____opt_85 ~= nil then
            ____opt_85(____opt_85)
        end
        if __t(__L1.player) then
            __L1.player.hp = math.min(
                __L1.player.hp,
                __L1:baseBonus().maxHP
            )
            __L1.player.gas = math.min(
                __L1.player.gas,
                __L1:baseBonus().maxGas
            )
        end
    end
    __L1.drawBivoltAura = function(self, c, x, y)
        if not __t(__L1:bivoltStatus().active) then
            return
        end
        c:save()
        c.globalAlpha = 0.35 + math.sin(__L1.time * 5) * 0.08
        c.strokeStyle = "#f5d775"
        c.lineWidth = 2
        c:beginPath()
        c:ellipse(
            x,
            y,
            35,
            43,
            math.sin(__L1.time) * 0.08,
            0,
            math.pi * 2
        )
        c:stroke()
        do
            local i = 0
            while i < 5 do
                local a = __L1.time * 1.8 + i * math.pi * 2 / 5
                c.fillStyle = __t(__mod(i, 2)) and "#cce8a4" or "#ffe6a0"
                c:fillRect(
                    x + math.cos(a) * 34 - 2,
                    y + math.sin(a) * 43 - 2,
                    4,
                    4
                )
                i = i + 1
            end
        end
        c:restore()
    end
    __L1.beginOllyanEncounter = function(self, force)
        if force == nil then
            force = false
        end
        local ____t_116 = __t
        local ____t_result_115
        local ____t_114 = __t
        local ____t_result_113
        local ____t_112 = __t
        local ____t_result_111
        local ____t_110 = __t
        local ____t_result_109
        local ____t_108 = __t
        local ____t_result_107
        local ____t_106 = __t
        local ____t_result_105
        local ____t_104 = __t
        local ____t_result_103
        local ____t_102 = __t
        local ____t_result_101
        local ____t_100 = __t
        local ____t_result_99
        local ____t_96 = __t
        local ____t_result_95
        local ____t_94 = __t
        local ____t_result_93
        local ____t_92 = __t
        local ____t_result_91
        local ____t_90 = __t
        local ____t_result_89
        local ____t_88 = __t
        local ____temp_87 = not __t(__L1.started)
        __O[1631] = ____temp_87
        if ____t_88(____temp_87) then
            ____t_result_89 = __O[1631]
        else
            ____t_result_89 = __L1.paused
        end
        __O[1632] = ____t_result_89
        if ____t_90(____t_result_89) then
            ____t_result_91 = __O[1632]
        else
            ____t_result_91 = __L1.dialog
        end
        __O[1633] = ____t_result_91
        if ____t_92(____t_result_91) then
            ____t_result_93 = __O[1633]
        else
            ____t_result_93 = __L1.cutscene
        end
        __O[1634] = ____t_result_93
        if ____t_94(____t_result_93) then
            ____t_result_95 = __O[1634]
        else
            ____t_result_95 = __L1.activity
        end
        __O[1635] = ____t_result_95
        if ____t_96(____t_result_95) then
            ____t_result_99 = __O[1635]
        else
            local ____opt_97 = __L1.training
            if ____opt_97 ~= nil then
                ____opt_97 = ____opt_97.active
            end
            ____t_result_99 = ____opt_97
        end
        __O[1636] = ____t_result_99
        if ____t_100(____t_result_99) then
            ____t_result_101 = __O[1636]
        else
            ____t_result_101 = __L1.arena
        end
        __O[1637] = ____t_result_101
        if ____t_102(____t_result_101) then
            ____t_result_103 = __O[1637]
        else
            ____t_result_103 = __L1.room
        end
        __O[1638] = ____t_result_103
        if ____t_104(____t_result_103) then
            ____t_result_105 = __O[1638]
        else
            ____t_result_105 = __L1.routeTransition
        end
        __O[1639] = ____t_result_105
        if ____t_106(____t_result_105) then
            ____t_result_107 = __O[1639]
        else
            ____t_result_107 = __L1.ollyanEncounter
        end
        __O[1640] = ____t_result_107
        if ____t_108(____t_result_107) then
            ____t_result_109 = __O[1640]
        else
            ____t_result_109 = __L1.defeated
        end
        __O[1641] = ____t_result_109
        if ____t_110(____t_result_109) then
            ____t_result_111 = __O[1641]
        else
            ____t_result_111 = __L1.won
        end
        __O[1642] = ____t_result_111
        if ____t_112(____t_result_111) then
            ____t_result_113 = __O[1642]
        else
            ____t_result_113 = __L1.scene ~= 11
        end
        __O[1643] = ____t_result_113
        if ____t_114(____t_result_113) then
            ____t_result_115 = __O[1643]
        else
            ____t_result_115 = __L1.q.ollyan
        end
        if ____t_116(____t_result_115) then
            return false
        end
        local ____t_result_123
        local ____t_122 = __t
        local ____opt_119 = window.BaileWorld
        if ____opt_119 ~= nil then
            ____opt_119 = ____opt_119.getNPC
        end
        local ____opt_result_121
        if ____opt_119 ~= nil then
            ____opt_result_121 = ____opt_119(____opt_119)
        end
        __O[1644] = ____opt_result_121
        if ____t_122(____opt_result_121) then
            ____t_result_123 = __O[1644]
        else
            ____t_result_123 = __L1.npcInfo.ollyan
        end
        local npc = ____t_result_123
        if __t(not __t(force) and math.abs(__L1.player.x - npc.x) > 190) then
            return false
        end
        if not __t(__L1.q.lucas) then
            __L1:toast("Conserte o carro a gás com Lucas antes de seguir Ollyan no céu.")
            return false
        end
        if not __t(window.OllyanEncounter) then
            return false
        end
        __L1:releaseInputs()
        __L1.shots = __arrL({}, 0)
        __L1.hazards = __arrL({}, 0)
        __L1.reeisPhase = "idle"
        __L1.reeisTimer = 0
        __L1.player.vx = 0
        __L1.player.vy = 0
        __L1.player.y = __L1.FLOOR
        __L1.player.ground = true
        __L1.lastSafeX = 2900
        __L1.q.ollyanTeto = true
        __L1.respawnCheckpoint = {scene = 11, x = 2900}
        __L1.vehicle = true
        local ____t_result_130
        local ____t_129 = __t
        local ____opt_126 = window.Difficulty
        if ____opt_126 ~= nil then
            ____opt_126 = ____opt_126.getMode
        end
        local ____opt_result_128
        if ____opt_126 ~= nil then
            ____opt_result_128 = ____opt_126(____opt_126)
        end
        __O[1645] = ____opt_result_128
        if ____t_129(____opt_result_128) then
            ____t_result_130 = __O[1645]
        else
            ____t_result_130 = "normal"
        end
        local mode = ____t_result_130
        local ____t_result_137
        local ____t_136 = __t
        local ____opt_133 = window.Difficulty
        if ____opt_133 ~= nil then
            ____opt_133 = ____opt_133.getSettings
        end
        local ____opt_result_135
        if ____opt_133 ~= nil then
            ____opt_result_135 = ____opt_133(____opt_133, mode)
        end
        __O[1646] = ____opt_result_135
        if ____t_136(____opt_result_135) then
            ____t_result_137 = __O[1646]
        else
            ____t_result_137 = {hp = 1, incomingDamage = 1, windup = 1, recovery = 1}
        end
        local settings = ____t_result_137
        __L1.ollyanEncounter = window.OllyanEncounter:create(__assign(
            {},
            __L1:bonus(),
            {
                hp = __L1.player.hp,
                gas = __L1.player.gas,
                trained = __L1.q.trained,
                difficultyMode = mode,
                bossHP = math.floor(2600 * settings.hp + 0.5),
                enemyDamageMultiplier = 1.5 * settings.incomingDamage,
                windupMultiplier = settings.windup,
                recoveryMultiplier = settings.recovery
            }
        ))
        __L1:updateUI()
        __L1:save()
        return true
    end
    __L1.finishOllyanEncounter = function(self, result)
        local encounter = __L1.ollyanEncounter
        if not __t(encounter) then
            return
        end
        local ____opt_140 = window.FxPixel
        if ____opt_140 ~= nil then
            ____opt_140 = ____opt_140.limpar
        end
        if ____opt_140 ~= nil then
            ____opt_140(____opt_140, "ollyan")
        end
        if __t(__L1.sandbox) then
            __L1:finishSandbox(result == "won" and "won" or (result == "defeated" and "defeated" or "retreat"))
            return
        end
        local status = window.OllyanEncounter:getStatus(encounter)
        __L1.player.hp = math.max(
            0,
            math.min(
                __L1:bonus().maxHP,
                status.playerHP
            )
        )
        __L1.player.gas = math.max(
            0,
            math.min(
                __L1:bonus().maxGas,
                status.gas
            )
        )
        __L1.ollyanEncounter = nil
        __L1:releaseInputs()
        __L1.vehicle = false
        __L1.shots = __arrL({}, 0)
        __L1.hazards = __arrL({}, 0)
        __L1.player.vx = 0
        __L1.player.vy = 0
        __L1.player.ground = true
        __L1.player.y = __L1.FLOOR
        __L1.player.x = result == "won" and 3500 or 2900
        __L1.lastSafeX = __L1.player.x
        __L1.camera = __L1:clamp(__L1.player.x - __L1.W * 0.36, 0, __L1.WORLD - __L1.W)
        __L1.ollyanRetryGrace = 3
        if result == "won" then
            local first = not __t(__L1.q.ollyan)
            __L1.q.ollyan = true
            if __t(first) then
                __L1:awardXP(700, "side-ollyan")
            end
            __L1:toast("Orelhas pousadas! Ollyan voltou ao baile. +700 XP pela vitória no céu.")
            __L1:save()
            __L1:updateUI()
        elseif result == "defeated" then
            __L1.respawnCheckpoint = {scene = 11, x = 2900}
            __L1:resetBivolt()
            __L1:defeat()
        else
            __L1:toast("Você voltou ao baile. O carro estacionou em segurança; Ollyan continua no desafio.")
            __L1:updateUI()
            __L1:save()
        end
    end
    __L1.consumeOllyanEvents = function(self)
        if not __t(__L1.ollyanEncounter) then
            return
        end
        for ____, event in __iterar((window.OllyanEncounter:drainEvents(__L1.ollyanEncounter))) do
            __L1:efeitoOllyan(event)
            if event.type == "hurt" then
                local ____L1_player_143 = __L1.player
                local ____event_hp_142 = event.hp
                if ____event_hp_142 == nil then
                    ____event_hp_142 = window.OllyanEncounter:getStatus(__L1.ollyanEncounter).playerHP
                end
                ____L1_player_143.hp = math.max(0, ____event_hp_142)
                __L1.hitFlash = 0.18
                __L1:beep(110, 0.1, "sawtooth")
            elseif event.type == "phase" then
                local ____L1_toast_147 = __L1.toast
                local ____add_146 = __add
                local ____add_result_145 = __add(
                    __add("Ollyan · fase ", event.phase),
                    "/3: "
                )
                local ____t_result_144
                if __t(event.name) then
                    ____t_result_144 = event.name
                else
                    ____t_result_144 = "o céu mudou de compasso"
                end
                ____L1_toast_147(
                    __L1,
                    ____add_146(____add_result_145, ____t_result_144)
                )
            else
                local ____t_151 = __t
                local ____t_result_150
                local ____t_149 = __t
                local ____temp_148 = event.type == "won" or event.type == "defeated"
                __O[1647] = ____temp_148
                if ____t_149(____temp_148) then
                    ____t_result_150 = __O[1647]
                else
                    ____t_result_150 = event.type == "retreat"
                end
                if ____t_151(____t_result_150) then
                    __L1:finishOllyanEncounter(event.type)
                    break
                end
            end
        end
    end
    __L1.efeitoOllyan = function(self, ev)
        local F = window.FxPixel
        local E = __L1.ollyanEncounter
        local ____t_159 = __t
        local ____t_result_158
        local ____t_157 = __t
        local ____t_155 = __t
        local ____opt_result_154
        if F ~= nil then
            ____opt_result_154 = F.tocar
        end
        local ____temp_156 = not ____t_155(____opt_result_154) or not __t(E)
        __O[1648] = ____temp_156
        if ____t_157(____temp_156) then
            ____t_result_158 = __O[1648]
        else
            ____t_result_158 = not __t(ev)
        end
        if ____t_159(____t_result_158) then
            return
        end
        local ____t_result_160
        if __t(E.boss) then
            ____t_result_160 = E.boss
        else
            ____t_result_160 = {}
        end
        local b = ____t_result_160
        local ____t_result_161
        if __t(E.player) then
            ____t_result_161 = E.player
        else
            ____t_result_161 = {}
        end
        local p = ____t_result_161
        local o = {dono = "ollyan", mundo = false}
        if ev.type == "phase" then
            F:tocar(
                "holy/sunburst",
                __assign({}, o, {x = b.x, y = b.y, palette = F.PAL.ouro, duracao = 1.2})
            )
            F:tocar(
                "explosions/firework-burst",
                __assign({}, o, {x = b.x, y = b.y + 40, atraso = 0.2})
            )
        elseif ev.type == "attack" then
            F:tocar(
                "spawn/poof",
                __assign(
                    {},
                    o,
                    {
                        x = b.x,
                        y = b.y + 20,
                        palette = __arrL({
                            "#3a4a6a",
                            "#6a7aa0",
                            "#a8b8d8",
                            "#dce6f6",
                            "#ffffff",
                            "#ffffff"
                        }, 6)
                    }
                )
            )
        elseif ev.type == "fart" then
            F:tocar(
                "spawn/poof",
                __assign({}, o, {x = p.x - 20, y = p.y + 10, palette = F.PAL.peido})
            )
        elseif ev.type == "dash" then
            F:tocar(
                "spawn/poof",
                __assign({}, o, {x = p.x - 24, y = p.y + 12, palette = F.PAL.poeira})
            )
        elseif ev.type == "defeated" then
            F:tocar(
                "explosions/firework-burst",
                __assign({}, o, {x = b.x, y = b.y, palette = F.PAL.ouro})
            )
            F:tocar(
                "explosions/firework-burst",
                __assign({}, o, {x = b.x - 120, y = b.y + 30, atraso = 0.35})
            )
            F:tocar(
                "explosions/firework-burst",
                __assign({}, o, {x = b.x + 120, y = b.y + 10, atraso = 0.7})
            )
            F:tocar(
                "holy/feather-burst",
                __assign({}, o, {x = b.x, y = b.y})
            )
        end
    end
    __L1.updateOllyan = function(self, dt)
        if not __t(__L1.ollyanEncounter) then
            return
        end
        local state = __L1.ollyanEncounter
        local ____L1_clamp_172 = __L1.clamp
        local ____L1_joystick_x_166 = __L1.joystick.x
        local ____t_165 = __t
        local ____t_result_164
        local ____t_163 = __t
        local ____temp_162 = __L1:keyHeld("right")
        __O[1649] = ____temp_162
        if ____t_163(____temp_162) then
            ____t_result_164 = __O[1649]
        else
            ____t_result_164 = __L1.touch.right
        end
        local ____temp_171 = ____L1_joystick_x_166 + (____t_165(____t_result_164) and 1 or 0)
        local ____t_170 = __t
        local ____t_result_169
        local ____t_168 = __t
        local ____temp_167 = __L1:keyHeld("left")
        __O[1650] = ____temp_167
        if ____t_168(____temp_167) then
            ____t_result_169 = __O[1650]
        else
            ____t_result_169 = __L1.touch.left
        end
        local ____L1_clamp_172_result_196 = ____L1_clamp_172(
            __L1,
            ____temp_171 - (____t_170(____t_result_169) and 1 or 0),
            -1,
            1
        )
        local ____L1_clamp_185 = __L1.clamp
        local ____L1_joystick_y_177 = __L1.joystick.y
        local ____t_176 = __t
        local ____t_result_175
        local ____t_174 = __t
        local ____temp_173 = __L1:keyHeld("down")
        __O[1651] = ____temp_173
        if ____t_174(____temp_173) then
            ____t_result_175 = __O[1651]
        else
            ____t_result_175 = __L1.touch.down
        end
        local ____temp_184 = ____L1_joystick_y_177 + (____t_176(____t_result_175) and 1 or 0)
        local ____t_183 = __t
        local ____t_result_182
        local ____t_181 = __t
        local ____t_result_180
        local ____t_179 = __t
        local ____temp_178 = __L1:keyHeld("up")
        __O[1652] = ____temp_178
        if ____t_179(____temp_178) then
            ____t_result_180 = __O[1652]
        else
            ____t_result_180 = __L1:keyHeld("jump")
        end
        __O[1653] = ____t_result_180
        if ____t_181(____t_result_180) then
            ____t_result_182 = __O[1653]
        else
            ____t_result_182 = __L1.touch.jump
        end
        local ____L1_clamp_185_result_197 = ____L1_clamp_185(
            __L1,
            ____temp_184 - (____t_183(____t_result_182) and 1 or 0),
            -1,
            1
        )
        local ____temp_198 = __L1:keyHeld("paper")
        local ____temp_199 = __L1:keyHeld("fart")
        local ____t_195 = __t
        local ____t_result_194
        local ____t_193 = __t
        local ____t_result_192
        local ____t_191 = __t
        local ____t_result_190
        local ____t_189 = __t
        local ____t_result_188
        local ____t_187 = __t
        local ____temp_186 = __L1:keyHeld("jump")
        __O[1654] = ____temp_186
        if ____t_187(____temp_186) then
            ____t_result_188 = __O[1654]
        else
            ____t_result_188 = __L1:keyHeld("up")
        end
        __O[1655] = ____t_result_188
        if ____t_189(____t_result_188) then
            ____t_result_190 = __O[1655]
        else
            ____t_result_190 = __L1.touch.jump
        end
        __O[1656] = ____t_result_190
        if ____t_191(____t_result_190) then
            ____t_result_192 = __O[1656]
        else
            ____t_result_192 = __L1.touch.up
        end
        __O[1657] = ____t_result_192
        if ____t_193(____t_result_192) then
            ____t_result_194 = __O[1657]
        else
            ____t_result_194 = __L1.joystick.y < -0.55
        end
        local input = {
            x = ____L1_clamp_172_result_196,
            y = ____L1_clamp_185_result_197,
            fire = ____temp_198,
            fart = ____temp_199,
            jump = not not ____t_195(____t_result_194)
        }
        window.OllyanEncounter:update(
            state,
            dt,
            input,
            __L1:bonus()
        )
        local status = window.OllyanEncounter:getStatus(state)
        __L1.player.hp = status.playerHP
        __L1.player.gas = status.gas
        __L1:consumeOllyanEvents()
        __L1.uiTimer = __L1.uiTimer + dt
        if __L1.uiTimer > 0.1 then
            __L1.uiTimer = 0
            __L1:updateUI()
        end
        __L1:updateEffects(dt)
    end
    __L1.retreatOllyan = function(self)
        local ____t_205 = __t
        local ____t_result_204
        local ____t_203 = __t
        local ____t_result_202
        local ____t_201 = __t
        local ____temp_200 = not __t(__L1.ollyanEncounter)
        __O[1658] = ____temp_200
        if ____t_201(____temp_200) then
            ____t_result_202 = __O[1658]
        else
            ____t_result_202 = __L1.paused
        end
        __O[1659] = ____t_result_202
        if ____t_203(____t_result_202) then
            ____t_result_204 = __O[1659]
        else
            ____t_result_204 = __L1.dialog
        end
        if ____t_205(____t_result_204) then
            return false
        end
        window.OllyanEncounter:cancel(__L1.ollyanEncounter)
        __L1:consumeOllyanEvents()
        return true
    end
    __L1.awardXP = function(self, xp, id)
        if __t(__L1.sandbox) then
            return __assign(
                {},
                __L1:levelState(),
                {awarded = 0, levelsGained = 0}
            )
        end
        local before = __L1:levelState().level
        local ____opt_208 = window.Progression
        if ____opt_208 ~= nil then
            ____opt_208 = ____opt_208.award
        end
        local ____opt_result_210
        if ____opt_208 ~= nil then
            ____opt_result_210 = ____opt_208(____opt_208, xp, id)
        end
        local r = ____opt_result_210
        local ____t_212 = __t
        local ____t_result_211
        if __t(r) then
            ____t_result_211 = __gt(
                __L1:levelState().level,
                before
            )
        else
            ____t_result_211 = r
        end
        if ____t_212(____t_result_211) then
            __L1.player.hp = __L1:bonus().maxHP
            __L1.player.gas = __L1:bonus().maxGas
            __L1:floating(
                __L1.player.x,
                __L1.player.y - 105,
                __add(
                    __add(
                        "NÍVEL ",
                        __L1:levelState().level
                    ),
                    "!"
                ),
                "#ffec91"
            )
            __L1:toast(__add(
                __add(
                    "Nível ",
                    __L1:levelState().level
                ),
                "! Abra ATRIBUTOS para distribuir seus pontos."
            ))
            __L1:beep(920, 0.22, "triangle")
        end
        return r
    end
    __L1.spendStat = function(self, stat, qtd)
        if qtd == nil then
            qtd = 1
        end
        if __t(__L1.sandbox) then
            __L1:toast("Distribua seus pontos na campanha antes da revanche.")
            return false
        end
        local ____t_218 = __t
        local ____opt_215 = window.Campanha2
        if ____opt_215 ~= nil then
            ____opt_215 = ____opt_215.aberto
        end
        local ____opt_result_217
        if ____opt_215 ~= nil then
            ____opt_result_217 = ____opt_215(____opt_215)
        end
        if ____t_218(____opt_result_217) then
            local ____t_result_225
            local ____t_224 = __t
            local ____opt_221 = window.Progression
            if ____opt_221 ~= nil then
                ____opt_221 = ____opt_221.spend
            end
            local ____opt_result_223
            if ____opt_221 ~= nil then
                ____opt_result_223 = ____opt_221(____opt_221, stat, qtd)
            end
            __O[1663] = ____opt_result_223
            if ____t_224(____opt_result_223) then
                ____t_result_225 = __O[1663]
            else
                ____t_result_225 = false
            end
            local ok = ____t_result_225
            if __t(ok) then
                window:dispatchEvent(__new("CustomEvent", "c2-atributo", {detail = {stat = stat}}))
            end
            return ok
        end
        local old = __L1:bonus()
        local ____t_result_232
        local ____t_231 = __t
        local ____opt_228 = window.Progression
        if ____opt_228 ~= nil then
            ____opt_228 = ____opt_228.spend
        end
        local ____opt_result_230
        if ____opt_228 ~= nil then
            ____opt_result_230 = ____opt_228(____opt_228, stat, qtd)
        end
        __O[1664] = ____opt_result_230
        if ____t_231(____opt_result_230) then
            ____t_result_232 = __O[1664]
        else
            ____t_result_232 = false
        end
        local ok = ____t_result_232
        if __t(ok) then
            local b = __L1:bonus()
            __L1.player.hp = math.min(
                b.maxHP,
                __L1.player.hp + math.max(0, b.maxHP - old.maxHP)
            )
            __L1.player.gas = math.min(
                b.maxGas,
                __L1.player.gas + math.max(0, b.maxGas - old.maxGas)
            )
            __L1:syncOllyanPlayer()
            __L1:updateUI()
            __L1:save()
        end
        return ok
    end
    __L1.closestNPC = function(self)
        local ____opt_233 = __L1.room
        if ____opt_233 ~= nil then
            ____opt_233 = ____opt_233.phase
        end
        if ____opt_233 == "inside" then
            local ____t_result_244
            if __t(math.abs(__L1.player.x - __L1.room.teacherX) < 105 and math.abs(__L1.player.y - __L1.FLOOR) < 100) then
                local ____arrL_243 = __arrL
                local ____L1_room_id_242 = __L1.room.id
                local ____t_result_241
                local ____t_240 = __t
                local ____opt_237 = window.FavelaCasas
                if ____opt_237 ~= nil then
                    ____opt_237 = ____opt_237.ehCasa
                end
                local ____opt_result_239
                if ____opt_237 ~= nil then
                    ____opt_result_239 = ____opt_237(____opt_237, __L1.room.id)
                end
                if ____t_240(____opt_result_239) then
                    ____t_result_241 = window.FavelaCasas:nomeNpc(__L1.room.id)
                else
                    ____t_result_241 = __L1.room.id == "almiro" and "Professor Almiro" or "Professor Miqueias"
                end
                ____t_result_244 = ____arrL_243({____L1_room_id_242, {name = ____t_result_241, scene = __L1.scene, x = __L1.room.teacherX}}, 2)
            else
                ____t_result_244 = nil
            end
            return ____t_result_244
        end
        return __get(
            __call(
                __call(
                    __entries(__L1.npcInfo),
                    "filter",
                    function(____, ____bindingPattern0)
                        local n
                        local id
                        id = ____bindingPattern0[1]
                        n = ____bindingPattern0[2]
                        local ____t_result_251
                        local ____t_250 = __t
                        local ____t_result_249
                        local ____t_248 = __t
                        local ____t_result_247
                        local ____t_246 = __t
                        local ____temp_245 = __L1:npcAvailable(id)
                        __O[1665] = ____temp_245
                        if ____t_246(____temp_245) then
                            ____t_result_247 = n.scene == __L1.scene
                        else
                            ____t_result_247 = __O[1665]
                        end
                        __O[1666] = ____t_result_247
                        if ____t_248(____t_result_247) then
                            ____t_result_249 = math.abs(__L1.player.x - n.x) < 105
                        else
                            ____t_result_249 = __O[1666]
                        end
                        __O[1667] = ____t_result_249
                        if ____t_250(____t_result_249) then
                            ____t_result_251 = math.abs(__L1.player.y - __L1.FLOOR) < 100
                        else
                            ____t_result_251 = __O[1667]
                        end
                        return ____t_result_251
                    end
                ),
                "sort",
                function(____, a, b) return math.abs(__get(a, 1).x - __L1.player.x) - math.abs(__get(b, 1).x - __L1.player.x) end
            ),
            0
        )
    end
    __L1.bossAccess = function(self, e)
        local tasks = {
            patioAccepted = "Vá ao Pátio da escola e converse com Aica ou Ravile, perto da entrada.",
            freddy = "Enfrente Freddy, o capanga mais forte, no caminho antes de Reeis.",
            mota = "Vença o futebol do Mota no Campo do Mota para aprender o dash.",
            almiro = "Entre na sala 01 do colégio e devolva os três cadernos ao professor Almiro.",
            miqueias = "Entre na sala 02 e complete o quiz de inglês do professor Miqueias.",
            reeis = "Vá à Favela do Reeis, vença o rei do morro e recrute sua ajuda.",
            marco = "Vença Marco no pátio do Colégio Adventista.",
            giant = "Vá ao Caderno do Caos e vença o monstro gigante.",
            menezes = "Vença Menezes no final do Colégio Adventista.",
            trained = "Termine o treino de reflexo com Caleb na academia."
        }
        local ____arrL_result_255 = __arrL({"almiro", "miqueias", "reeis"}, 3)
        local ____arrL_result_256 = __arrL({"almiro", "miqueias", "marco", "giant"}, 4)
        local ____arr_254 = __arr
        local ____iter_253 = __iter
        local ____t_result_252
        if __t(__L1.q.reeis) then
            ____t_result_252 = __arrL({}, 0)
        else
            ____t_result_252 = __arrL({"freddy"}, 1)
        end
        local requirements = {
            marco = ____arrL_result_255,
            menezes = ____arrL_result_256,
            reeisBoss = ____arr_254(
                "mota",
                "almiro",
                "miqueias",
                __TS__Spread(____iter_253(____t_result_252))
            ),
            freddy = __arrL({"mota", "almiro", "miqueias"}, 3),
            nicolas = __arrL({"mota"}, 1),
            dede = __arrL({"mota", "almiro", "miqueias"}, 3),
            arthur = __arrL({"patioAccepted"}, 1),
            giant = __arrL({"marco"}, 1),
            nikolas = __arrL({"giant", "menezes", "trained"}, 3)
        }
        local ____call_260 = __call
        local ____t_result_259
        local ____t_258 = __t
        local ____get_result_257 = __get(requirements, e.type)
        __O[1669] = ____get_result_257
        if ____t_258(____get_result_257) then
            ____t_result_259 = __O[1669]
        else
            ____t_result_259 = __arrL({}, 0)
        end
        local missing = ____call_260(
            ____t_result_259,
            "filter",
            function(____, flag) return not __t(__get(__L1.q, flag)) end
        )
        local ____opt_263 = window.Campaign
        if ____opt_263 ~= nil then
            ____opt_263 = ____opt_263.bossRequirement
        end
        local ____opt_result_265
        if ____opt_263 ~= nil then
            ____opt_result_265 = ____opt_263(____opt_263, e.type, __L1.q)
        end
        local campaign = ____opt_result_265
        local ____temp_269 = __len(missing) == 0
        if ____temp_269 then
            local ____opt_result_268
            if campaign ~= nil then
                ____opt_result_268 = campaign.ok
            end
            ____temp_269 = ____opt_result_268 ~= false
        end
        local ____missing_276 = missing
        local ____call_result_277 = __call(
            missing,
            "map",
            function(____, flag) return __get(tasks, flag) end
        )
        local ____t_result_275
        if __t(__len(missing)) then
            ____t_result_275 = __get(
                tasks,
                __get(missing, 0)
            )
        else
            local ____t_result_274
            local ____t_273 = __t
            local ____opt_result_272
            if campaign ~= nil then
                ____opt_result_272 = campaign.reason
            end
            __O[1670] = ____opt_result_272
            if ____t_273(____opt_result_272) then
                ____t_result_274 = __O[1670]
            else
                ____t_result_274 = ""
            end
            ____t_result_275 = ____t_result_274
        end
        return {ok = ____temp_269, missing = ____missing_276, lines = ____call_result_277, reason = ____t_result_275}
    end
    __L1.closestBoss = function(self)
        local ____t_result_284
        if __t(not __t(__L1.room) and not __t(__L1.arena)) then
            local ____t_result_283
            local ____t_282 = __t
            local ____get_result_281 = __get(
                __call(
                    __call(
                        __L1.enemies,
                        "filter",
                        function(____, e)
                            local ____t_result_280
                            local ____t_279 = __t
                            local ____temp_278 = __gt(e.hp, 0) and math.abs(e.x - __L1.player.x) <= 390
                            __O[1671] = ____temp_278
                            if ____t_279(____temp_278) then
                                ____t_result_280 = math.abs(e.y - __L1.player.y) < 180
                            else
                                ____t_result_280 = __O[1671]
                            end
                            return ____t_result_280
                        end
                    ),
                    "sort",
                    function(____, a, b) return math.abs(a.x - __L1.player.x) - math.abs(b.x - __L1.player.x) end
                ),
                0
            )
            __O[1672] = ____get_result_281
            if ____t_282(____get_result_281) then
                ____t_result_283 = __O[1672]
            else
                ____t_result_283 = nil
            end
            ____t_result_284 = ____t_result_283
        else
            ____t_result_284 = nil
        end
        return ____t_result_284
    end
    __L1.interactBoss = function(self, e)
        if __t(e.type == "igor" or e.type == "kaique") then
            return __L1:confrontMonitor(e, false)
        end
        local access = __L1:bossAccess(e)
        if __t(access.ok) then
            return __L1:engageBoss(e)
        end
        local lines = __arr(
            {
                name = __L1:nomeBoss(e.type),
                text = "Quer me desafiar? Primeiro termine sua preparação. Vou te mostrar exatamente o que falta."
            },
            __TS__Spread(__iter(__call(
                access.lines,
                "map",
                function(____, text) return {name = "Diário da aventura", text = text} end
            )))
        )
        if not __t(__len(access.lines)) then
            local ____call_286 = __call
            local ____t_result_285
            if __t(access.reason) then
                ____t_result_285 = access.reason
            else
                ____t_result_285 = "Conclua a missão que aparece no diário antes deste confronto."
            end
            ____call_286(lines, "push", {name = "Diário da aventura", text = ____t_result_285})
        end
        __call(lines, "push", {name = "Da Roça", text = "Agora entendi! Vou terminar essas missões e volto aqui para apertar E e começar a luta."})
        __L1:say(lines)
        return false
    end
    __L1.getDialogueAnchor = function(self)
        if not __t(__L1.dialog) then
            return nil
        end
        local line = __get(__L1.dialog.lines, __L1.dialog.index)
        if not __t(line) then
            return nil
        end
        local ____t_result_287
        if __t(line.name) then
            ____t_result_287 = line.name
        else
            ____t_result_287 = "Da Roça"
        end
        local speaker = ____t_result_287
        local norm = __call(
            __re_replace(
                __call(speaker, "normalize", "NFD"),
                __re("[\\u0300-\\u036f]", "g"),
                ""
            ),
            "toLowerCase"
        )
        local x = __L1.player.x
        local y = __L1.player.y - 62
        local ____type = "daroca"
        local ____t_297 = __t
        local ____t_result_296
        if __t(__L1.room) then
            local ____t_result_295
            local ____t_289 = __t
            local ____call_result_288 = __call(norm, "includes", __L1.room.id)
            __O[1673] = ____call_result_288
            if ____t_289(____call_result_288) then
                ____t_result_295 = __O[1673]
            else
                local ____opt_292 = window.FavelaCasas
                if ____opt_292 ~= nil then
                    ____opt_292 = ____opt_292.falante
                end
                local ____opt_result_294
                if ____opt_292 ~= nil then
                    ____opt_result_294 = ____opt_292(____opt_292, __L1.room.id, norm)
                end
                ____t_result_295 = ____opt_result_294
            end
            ____t_result_296 = ____t_result_295
        else
            ____t_result_296 = __L1.room
        end
        if ____t_297(____t_result_296) then
            x = __L1.room.teacherX
            y = __L1.FLOOR - 76
            local ____t_result_304
            local ____t_303 = __t
            local ____opt_300 = window.FavelaCasas
            if ____opt_300 ~= nil then
                ____opt_300 = ____opt_300.morador
            end
            local ____opt_result_302
            if ____opt_300 ~= nil then
                ____opt_result_302 = ____opt_300(____opt_300, __L1.room.id)
            end
            __O[1674] = ____opt_result_302
            if ____t_303(____opt_result_302) then
                ____t_result_304 = __O[1674]
            else
                ____t_result_304 = __L1.room.id
            end
            ____type = ____t_result_304
        elseif __t(not __t(__call(norm, "includes", "da roca")) and not __t(__call(norm, "includes", "diario"))) then
            local npc = __call(
                __entries(__L1.npcInfo),
                "find",
                function(____, ____bindingPattern0)
                    local n
                    local id
                    id = ____bindingPattern0[1]
                    n = ____bindingPattern0[2]
                    local ____t_result_310
                    local ____t_306 = __t
                    local ____temp_305 = n.scene == __L1.scene
                    __O[1676] = ____temp_305
                    if ____t_306(____temp_305) then
                        local ____t_result_309
                        local ____t_308 = __t
                        local ____call_result_307 = __call(norm, "includes", id)
                        __O[1675] = ____call_result_307
                        if ____t_308(____call_result_307) then
                            ____t_result_309 = __O[1675]
                        else
                            ____t_result_309 = __call(
                                norm,
                                "includes",
                                __call(
                                    __re_replace(
                                        __call(n.name, "normalize", "NFD"),
                                        __re("[\\u0300-\\u036f]", "g"),
                                        ""
                                    ),
                                    "toLowerCase"
                                )
                            )
                        end
                        ____t_result_310 = ____t_result_309
                    else
                        ____t_result_310 = __O[1676]
                    end
                    return ____t_result_310
                end
            )
            local enemy = __call(
                __L1.enemies,
                "find",
                function(____, e) return __call(norm, "includes", e.type == "reeisBoss" and "reeis" or (e.type == "giant" and "rabiscao" or e.type)) end
            )
            if __t(enemy) then
                x = enemy.x
                y = enemy.y - (enemy.type == "giant" and 190 or (enemy.type == "reeisBoss" and 115 or 76))
                ____type = enemy.type
            elseif __t(npc) then
                x = __get(npc, 1).x
                y = __L1.FLOOR - 76
                ____type = __get(npc, 0)
            end
        end
        return {
            x = __L1:clamp(
                x - (__t(__L1.room) and 0 or __L1.camera),
                35,
                __L1.W - 35
            ),
            y = __L1:clamp(y, 60, __L1.H - 60),
            speaker = speaker,
            type = ____type
        }
    end
    __L1.playerSpriteOptions = function(self, scale)
        if scale == nil then
            scale = 1
        end
        local attacking = __gt(__L1.player.attack, 0)
        local ____t_result_311
        if __t(attacking) then
            ____t_result_311 = 1 - __L1.player.attack / __L1.player.attackDuration
        else
            ____t_result_311 = 0
        end
        local progress = ____t_result_311
        local ____L1_player_facing_332 = __L1.player.facing
        local ____temp_312
        if math.abs(__L1.player.vx) > 8 then
            ____temp_312 = __L1.player.anim / 9
        else
            ____temp_312 = __L1.time
        end
        local ____temp_333 = __L1.hitFlash > 0
        local ____scale_334 = scale
        local ____temp_335 = not __t(__L1.vehicle) and math.abs(__L1.player.vx) > 8
        local ____math_abs_result_336 = math.abs(__L1.player.vx)
        local ____L1_player_ground_337 = __L1.player.ground
        local ____L1_player_vy_338 = __L1.player.vy
        local ____L1_player_attackType_339 = __L1.player.attackType
        local ____temp_340 = __t(__L1.q.miqueias) and "papaia" or (__L1.weapon == 2 and "case" or (__L1.weapon == 1 and "ruler" or "paper"))
        local ____t_result_313
        if __t(__L1.q.miqueias) then
            ____t_result_313 = __ge(
                __L1:bonus().projectileTier,
                2
            ) and "electric" or "fire"
        else
            ____t_result_313 = nil
        end
        local ____t_result_328
        if __t(__L1.vehicle) then
            ____t_result_328 = __L1.vehicle
        else
            local ____t_result_327
            local ____t_326 = __t
            local ____t_result_325
            local ____t_321 = __t
            local ____t_319 = __t
            local ____opt_316 = __L1.activeBoss
            if ____opt_316 ~= nil then
                ____opt_316 = ____opt_316.conquista
            end
            local ____opt_result_318
            if ____opt_316 ~= nil then
                ____opt_result_318 = ____opt_316.estrada
            end
            local ____temp_320 = not ____t_319(____opt_result_318) and not __t(__L1.player.ground)
            __O[1678] = ____temp_320
            if ____t_321(____temp_320) then
                local ____t_result_324
                local ____t_323 = __t
                local ____temp_322 = __L1:keyHeld("jump")
                __O[1677] = ____temp_322
                if ____t_323(____temp_322) then
                    ____t_result_324 = __O[1677]
                else
                    ____t_result_324 = __L1.touch.jump
                end
                ____t_result_325 = ____t_result_324
            else
                ____t_result_325 = __O[1678]
            end
            __O[1679] = ____t_result_325
            if ____t_326(____t_result_325) then
                ____t_result_327 = __gt(__L1.player.gas, 0)
            else
                ____t_result_327 = __O[1679]
            end
            ____t_result_328 = ____t_result_327
        end
        local ____t_result_331
        local ____t_330 = __t
        local ____t_result_329
        if __t(attacking) then
            ____t_result_329 = __L1.player.attackType == "paper"
        else
            ____t_result_329 = attacking
        end
        if ____t_330(____t_result_329) then
            ____t_result_331 = math.max(0, 1 - progress * 3)
        else
            ____t_result_331 = 0
        end
        return {
            facing = ____L1_player_facing_332,
            frame = ____temp_312,
            attack = attacking,
            hit = ____temp_333,
            scale = ____scale_334,
            moving = ____temp_335,
            speed = ____math_abs_result_336,
            grounded = ____L1_player_ground_337,
            vy = ____L1_player_vy_338,
            attackProgress = progress,
            attackType = ____L1_player_attackType_339,
            attackObject = ____temp_340,
            attackElement = ____t_result_313,
            flight = ____t_result_328,
            recoil = ____t_result_331,
            muscular = __L1.q.trained,
            dash = __L1.dashTimer > 0,
            land = __L1.player.landTimer / 0.15,
            landTimer = __L1.player.landTimer
        }
    end
    __L1.terrenoConquista = function(self, f)
        if f == nil then
            local ____opt_343 = __L1.activeBoss
            if ____opt_343 ~= nil then
                ____opt_343 = ____opt_343.conquista
            end
            f = ____opt_343
        end
        local ____opt_341 = window.ConquistaCombate
        if ____opt_341 ~= nil then
            ____opt_341 = ____opt_341:terreno(f)
        end
        return ____opt_341
    end
    __L1.scenePlatforms = function(self)
        local ____opt_345 = __L1.activeBoss
        if ____opt_345 ~= nil then
            ____opt_345 = ____opt_345.conquista
        end
        local f = ____opt_345
        local ____opt_result_349
        if f ~= nil then
            ____opt_result_349 = f.ceu
        end
        local ceu = ____opt_result_349
        local ____t_353 = __t
        local ____opt_result_352
        if f ~= nil then
            ____opt_result_352 = f.estrada
        end
        if ____t_353(____opt_result_352) then
            local w = window.PerseguicaoMoto.largura
            return __call(
                f.estrada.motos,
                "map",
                function(____, m) return __arrL({m.x - w / 2, m.y, w}, 3) end
            )
        end
        if __t(ceu) then
            return __call(
                __call(
                    ceu.ilhas,
                    "filter",
                    function(____, i) return i.estado ~= "ausente" end
                ),
                "map",
                function(____, i) return __arrL({i.x, i.y, i.w}, 3) end
            )
        end
        local ____t_result_380
        if __t(__L1.room) then
            ____t_result_380 = __arrL({}, 0)
        else
            local ____t_result_379
            if __t(__L1.arena) then
                local ____call_360 = __call
                local ____t_result_359
                local ____t_358 = __t
                local ____getq_356 = __getq
                local ____opt_354 = window.WorldData
                if ____opt_354 ~= nil then
                    ____opt_354 = ____opt_354.arenaPlatforms
                end
                local ____getq_356_result_357 = ____getq_356(____opt_354, __L1.arena.type)
                __O[1683] = ____getq_356_result_357
                if ____t_358(____getq_356_result_357) then
                    ____t_result_359 = __O[1683]
                else
                    ____t_result_359 = __arrL({}, 0)
                end
                ____t_result_379 = ____call_360(
                    ____t_result_359,
                    "map",
                    function(____, p) return __arrL(
                        {
                            __add(
                                __L1.arena.homeX,
                                __get(p, 0)
                            ),
                            __get(p, 1),
                            __get(p, 2)
                        },
                        3
                    ) end
                )
            else
                local ____call_378 = __call
                local ____t_result_370
                local ____t_369 = __t
                local ____t_result_368
                local ____t_362 = __t
                local ____get_result_361 = __get(__L1.platforms, __L1.scene)
                __O[1684] = ____get_result_361
                if ____t_362(____get_result_361) then
                    ____t_result_368 = __O[1684]
                else
                    local ____opt_365 = window.LugaresC1
                    if ____opt_365 ~= nil then
                        ____opt_365 = ____opt_365.plataformas
                    end
                    local ____opt_result_367
                    if ____opt_365 ~= nil then
                        ____opt_result_367 = ____opt_365(____opt_365, __L1.scene)
                    end
                    ____t_result_368 = ____opt_result_367
                end
                __O[1685] = ____t_result_368
                if ____t_369(____t_result_368) then
                    ____t_result_370 = __O[1685]
                else
                    ____t_result_370 = __arrL({}, 0)
                end
                local ____t_result_377
                local ____t_376 = __t
                local ____opt_373 = window.Interact
                if ____opt_373 ~= nil then
                    ____opt_373 = ____opt_373.platforms
                end
                local ____opt_result_375
                if ____opt_373 ~= nil then
                    ____opt_result_375 = ____opt_373(____opt_373, {scene = __L1.scene})
                end
                __O[1686] = ____opt_result_375
                if ____t_376(____opt_result_375) then
                    ____t_result_377 = __O[1686]
                else
                    ____t_result_377 = __arrL({}, 0)
                end
                ____t_result_379 = ____call_378(____t_result_370, "concat", ____t_result_377)
            end
            ____t_result_380 = ____t_result_379
        end
        return ____t_result_380
    end
    __L1.gapAt = function(self)
        return nil
    end
    __L1.heroFloor = function(self)
        local best = nil
        for ____, p in __iterar((__L1:scenePlatforms())) do
            local ____t_386 = __t
            local ____t_result_385
            local ____t_384 = __t
            local ____t_result_383
            local ____t_382 = __t
            local ____temp_381 = __ge(
                __L1.player.x,
                __get(p, 0) - 4
            ) and __le(
                __L1.player.x,
                __add(
                    __get(p, 0),
                    __get(p, 2)
                ) + 4
            )
            __O[1687] = ____temp_381
            if ____t_382(____temp_381) then
                ____t_result_383 = __ge(
                    __get(p, 1),
                    __L1.player.y - 2
                )
            else
                ____t_result_383 = __O[1687]
            end
            __O[1688] = ____t_result_383
            if ____t_384(____t_result_383) then
                ____t_result_385 = best == nil or __lt(
                    __get(p, 1),
                    best
                )
            else
                ____t_result_385 = __O[1688]
            end
            if ____t_386(____t_result_385) then
                best = __get(p, 1)
            end
        end
        local ____temp_387
        if best == nil then
            ____temp_387 = __L1.FLOOR
        else
            ____temp_387 = math.min(best, __L1.FLOOR)
        end
        return ____temp_387
    end
    __L1.resetWorldSize = function(self)
        __L1.WORLD = __L1:worldWidthFor(__L1.scene)
    end
    __L1.startCutscene = function(self, kind, done)
        local ____t_390 = __t
        local ____opt_388 = window.Cinematics
        if ____opt_388 ~= nil then
            ____opt_388 = ____opt_388.create
        end
        if not ____t_390(____opt_388) then
            if __t(done) then
                done(nil)
            end
            return false
        end
        local R = window.Roteiro
        local ____opt_result_395
        if R ~= nil then
            ____opt_result_395 = R.antes
        end
        local ____opt_result_396
        if ____opt_result_395 ~= nil then
            ____opt_result_396 = ____opt_result_395(R, kind, __L1.q)
        end
        local pre = ____opt_result_396
        local ____opt_result_401
        if R ~= nil then
            ____opt_result_401 = R.depois
        end
        local ____opt_result_402
        if ____opt_result_401 ~= nil then
            ____opt_result_402 = ____opt_result_401(R, kind, __L1.q)
        end
        local post = ____opt_result_402
        if __t(post) then
            local after = done
            done = function()
                R:visto(post, __L1.q)
                __L1:save()
                __L1:playCutscene(post, after)
            end
        end
        if __t(pre) then
            R:visto(pre, __L1.q)
            return __L1:playCutscene(
                pre,
                function() return __L1:playCutscene(kind, done) end
            )
        end
        return __L1:playCutscene(kind, done)
    end
    __L1.playCutscene = function(self, kind, done)
        local ____t_405 = __t
        local ____opt_403 = window.Cinematics
        if ____opt_403 ~= nil then
            ____opt_403 = ____opt_403.create
        end
        if not ____t_405(____opt_403) then
            if __t(done) then
                done(nil)
            end
            return false
        end
        local ____opt_408 = window.CampaignVfx
        if ____opt_408 ~= nil then
            ____opt_408 = ____opt_408.reset
        end
        if ____opt_408 ~= nil then
            ____opt_408(____opt_408)
        end
        __L1:releaseInputs()
        local ____self_418 = window.Cinematics
        local ____self_418_create_419 = ____self_418.create
        local ____kind_417 = kind
        local ____L1_q_trained_416 = __L1.q.trained
        local ____t_415 = __t
        local ____opt_412 = window.GameMusic
        if ____opt_412 ~= nil then
            ____opt_412 = ____opt_412.isCutsceneTimed
        end
        local ____opt_result_414
        if ____opt_412 ~= nil then
            ____opt_result_414 = ____opt_412(____opt_412, kind)
        end
        __L1.cutscene = ____self_418_create_419(
            ____self_418,
            ____kind_417,
            {
                trained = ____L1_q_trained_416,
                musicTimed = not not ____t_415(____opt_result_414)
            }
        )
        local ____L1_cutscene_423 = __L1.cutscene
        local ____L1_420, ____audioCutsceneSerial_421 = __L1, "audioCutsceneSerial"
        local ____L1_audioCutsceneSerial_422 = ____L1_420[____audioCutsceneSerial_421] + 1
        ____L1_420[____audioCutsceneSerial_421] = ____L1_audioCutsceneSerial_422
        ____L1_cutscene_423.audioToken = ____L1_audioCutsceneSerial_422
        __L1.cutscene.audioElapsed = 0
        local ____t_result_424
        if __t(done) then
            ____t_result_424 = done
        else
            ____t_result_424 = nil
        end
        __L1.cutsceneCallback = ____t_result_424
        __L1:show("dialogBox", false)
        __L1:updateUI()
        return true
    end
    __L1.finishCutscene = function(self)
        if not __t(__L1.cutscene) then
            return
        end
        local done = __L1.cutsceneCallback
        __L1.cutscene = nil
        __L1.cutsceneCallback = nil
        __L1:releaseInputs()
        __L1:updateUI()
        if __t(done) then
            done(nil)
        end
    end
    __L1.advanceCutscene = function(self)
        local ____t_426 = __t
        local ____t_result_425
        if __t(__L1.ollyanEncounter) then
            ____t_result_425 = not __t(__L1.paused)
        else
            ____t_result_425 = __L1.ollyanEncounter
        end
        if ____t_426(____t_result_425) then
            local ____t_result_433
            local ____t_432 = __t
            local ____opt_429 = window.OllyanEncounter
            if ____opt_429 ~= nil then
                ____opt_429 = ____opt_429.advance
            end
            local ____opt_result_431
            if ____opt_429 ~= nil then
                ____opt_result_431 = ____opt_429(____opt_429, __L1.ollyanEncounter)
            end
            __O[1689] = ____opt_result_431
            if ____t_432(____opt_result_431) then
                ____t_result_433 = __O[1689]
            else
                ____t_result_433 = false
            end
            local changed = ____t_result_433
            __L1:consumeOllyanEvents()
            __L1:updateUI()
            return changed
        end
        local ____t_437 = __t
        local ____t_result_436
        local ____t_435 = __t
        local ____temp_434 = not __t(__L1.cutscene)
        __O[1690] = ____temp_434
        if ____t_435(____temp_434) then
            ____t_result_436 = __O[1690]
        else
            ____t_result_436 = __L1.paused
        end
        if ____t_437(____t_result_436) then
            return false
        end
        window.Cinematics:advance(__L1.cutscene)
        if __t(__L1.cutscene.done) then
            __L1:finishCutscene()
        else
            __L1:epilogueCue(__L1.cutscene)
            __L1:updateUI()
        end
        return true
    end
    __L1.skipCutscene = function(self)
        local ____t_440 = __t
        local ____opt_438 = __L1.ollyanEncounter
        if ____opt_438 ~= nil then
            ____opt_438 = ____opt_438.stage
        end
        if ____t_440(____opt_438 == "intro" and not __t(__L1.paused)) then
            do
                local i = 0
                while true do
                    local ____t_444 = __t
                    local ____temp_443 = i < 3
                    if ____temp_443 then
                        local ____opt_441 = __L1.ollyanEncounter
                        if ____opt_441 ~= nil then
                            ____opt_441 = ____opt_441.stage
                        end
                        ____temp_443 = ____opt_441 == "intro"
                    end
                    if not ____t_444(____temp_443) then
                        break
                    end
                    window.OllyanEncounter:advance(__L1.ollyanEncounter)
                    i = i + 1
                end
            end
            __L1:releaseInputs()
            __L1:updateUI()
            return true
        end
        local ____t_448 = __t
        local ____t_result_447
        local ____t_446 = __t
        local ____temp_445 = not __t(__L1.cutscene)
        __O[1691] = ____temp_445
        if ____t_446(____temp_445) then
            ____t_result_447 = __O[1691]
        else
            ____t_result_447 = __L1.paused
        end
        if ____t_448(____t_result_447) then
            return false
        end
        __L1.cutscene.done = true
        __L1:finishCutscene()
        return true
    end
    __L1.replayIntro = function(self)
        local ____t_470 = __t
        local ____t_result_469
        local ____t_468 = __t
        local ____t_result_467
        local ____t_466 = __t
        local ____t_result_465
        local ____t_462 = __t
        local ____t_result_461
        local ____t_460 = __t
        local ____t_result_459
        local ____t_458 = __t
        local ____t_result_457
        local ____t_456 = __t
        local ____t_result_455
        local ____t_454 = __t
        local ____t_result_453
        local ____t_452 = __t
        local ____t_result_451
        local ____t_450 = __t
        local ____temp_449 = not __t(__L1.started)
        __O[1692] = ____temp_449
        if ____t_450(____temp_449) then
            ____t_result_451 = __O[1692]
        else
            ____t_result_451 = __L1.defeated
        end
        __O[1693] = ____t_result_451
        if ____t_452(____t_result_451) then
            ____t_result_453 = __O[1693]
        else
            ____t_result_453 = __L1.activeBoss
        end
        __O[1694] = ____t_result_453
        if ____t_454(____t_result_453) then
            ____t_result_455 = __O[1694]
        else
            ____t_result_455 = __L1.arena
        end
        __O[1695] = ____t_result_455
        if ____t_456(____t_result_455) then
            ____t_result_457 = __O[1695]
        else
            ____t_result_457 = __L1.room
        end
        __O[1696] = ____t_result_457
        if ____t_458(____t_result_457) then
            ____t_result_459 = __O[1696]
        else
            ____t_result_459 = __L1.routeTransition
        end
        __O[1697] = ____t_result_459
        if ____t_460(____t_result_459) then
            ____t_result_461 = __O[1697]
        else
            ____t_result_461 = __L1.dialog
        end
        __O[1698] = ____t_result_461
        if ____t_462(____t_result_461) then
            ____t_result_465 = __O[1698]
        else
            local ____opt_463 = __L1.training
            if ____opt_463 ~= nil then
                ____opt_463 = ____opt_463.active
            end
            ____t_result_465 = ____opt_463
        end
        __O[1699] = ____t_result_465
        if ____t_466(____t_result_465) then
            ____t_result_467 = __O[1699]
        else
            ____t_result_467 = __L1.cutscene
        end
        __O[1700] = ____t_result_467
        if ____t_468(____t_result_467) then
            ____t_result_469 = __O[1700]
        else
            ____t_result_469 = __L1.ollyanEncounter
        end
        if ____t_470(____t_result_469) then
            __L1:toast("Retome a exploração para rever a história.")
            return false
        end
        __L1:resume()
        __L1:show("victoryScreen", false)
        return __L1:startCutscene(
            "intro",
            function() return __L1:toast("História revista! Seu progresso continua igual.") end
        )
    end
    __L1.enterRoom = function(self, id)
        local ____t_488 = __t
        local ____t_result_487
        local ____t_486 = __t
        local ____t_result_485
        local ____t_484 = __t
        local ____t_result_483
        local ____t_482 = __t
        local ____t_result_481
        local ____t_480 = __t
        local ____t_result_479
        local ____t_478 = __t
        local ____t_result_477
        local ____t_476 = __t
        local ____t_result_475
        local ____t_474 = __t
        local ____t_result_473
        local ____t_472 = __t
        local ____temp_471 = not __t(__L1.started)
        __O[1701] = ____temp_471
        if ____t_472(____temp_471) then
            ____t_result_473 = __O[1701]
        else
            ____t_result_473 = __L1.paused
        end
        __O[1702] = ____t_result_473
        if ____t_474(____t_result_473) then
            ____t_result_475 = __O[1702]
        else
            ____t_result_475 = __L1.cutscene
        end
        __O[1703] = ____t_result_475
        if ____t_476(____t_result_475) then
            ____t_result_477 = __O[1703]
        else
            ____t_result_477 = __L1.room
        end
        __O[1704] = ____t_result_477
        if ____t_478(____t_result_477) then
            ____t_result_479 = __O[1704]
        else
            ____t_result_479 = __L1.arena
        end
        __O[1705] = ____t_result_479
        if ____t_480(____t_result_479) then
            ____t_result_481 = __O[1705]
        else
            ____t_result_481 = __L1.activeBoss
        end
        __O[1706] = ____t_result_481
        if ____t_482(____t_result_481) then
            ____t_result_483 = __O[1706]
        else
            ____t_result_483 = __L1.routeTransition
        end
        __O[1707] = ____t_result_483
        if ____t_484(____t_result_483) then
            ____t_result_485 = __O[1707]
        else
            ____t_result_485 = __L1.dialog
        end
        __O[1708] = ____t_result_485
        if ____t_486(____t_result_485) then
            ____t_result_487 = __O[1708]
        else
            ____t_result_487 = __L1.defeated
        end
        if ____t_488(____t_result_487) then
            return false
        end
        local ____call_493 = __call
        local ____t_result_492
        local ____t_491 = __t
        local ____opt_489 = window.WorldData
        if ____opt_489 ~= nil then
            ____opt_489 = ____opt_489.doors
        end
        __O[1709] = ____opt_489
        if ____t_491(____opt_489) then
            ____t_result_492 = __O[1709]
        else
            ____t_result_492 = __arrL({}, 0)
        end
        local door = ____call_493(
            ____t_result_492,
            "find",
            function(____, d) return d.id == id and d.scene == __L1.scene end
        )
        local ____t_497 = __t
        local ____t_result_496
        local ____t_495 = __t
        local ____temp_494 = not __t(door) or math.abs(__L1.player.x - door.x) > 110
        __O[1710] = ____temp_494
        if ____t_495(____temp_494) then
            ____t_result_496 = __O[1710]
        else
            ____t_result_496 = math.abs(__L1.player.y - __L1.FLOOR) > 50
        end
        if ____t_497(____t_result_496) then
            __L1:toast("Chegue à porta da sala e aperte E.")
            return false
        end
        if __t(__L1.vehicle) then
            __L1:toast("Estacione o carro com V antes de entrar na sala.")
            return false
        end
        __L1:releaseInputs()
        __L1.shots = __arrL({}, 0)
        __L1.hazards = __arrL({}, 0)
        local ____id_500 = id
        local ____L1_player_x_501 = __L1.player.x
        local ____L1_FLOOR_502 = __L1.FLOOR
        local ____L1_camera_503 = __L1.camera
        local ____t_result_498
        if __t(door.teacherX) then
            ____t_result_498 = door.teacherX
        else
            ____t_result_498 = 600
        end
        local ____t_result_499
        if __t(door.exitX) then
            ____t_result_499 = door.exitX
        else
            ____t_result_499 = 90
        end
        __L1.room = {
            id = ____id_500,
            phase = "entering",
            blend = 0,
            t = 0,
            returnX = ____L1_player_x_501,
            returnY = ____L1_FLOOR_502,
            exteriorCamera = ____L1_camera_503,
            teacherX = ____t_result_498,
            exitX = ____t_result_499
        }
        __L1:updateUI()
        __L1:beep(330, 0.12, "triangle")
        return true
    end
    __L1.exitRoom = function(self)
        local ____t_511 = __t
        local ____t_result_510
        local ____t_509 = __t
        local ____t_result_508
        local ____t_507 = __t
        local ____t_result_506
        local ____t_505 = __t
        local ____temp_504 = not __t(__L1.room) or __L1.room.phase ~= "inside"
        __O[1711] = ____temp_504
        if ____t_505(____temp_504) then
            ____t_result_506 = __O[1711]
        else
            ____t_result_506 = __L1.dialog
        end
        __O[1712] = ____t_result_506
        if ____t_507(____t_result_506) then
            ____t_result_508 = __O[1712]
        else
            ____t_result_508 = __L1.paused
        end
        __O[1713] = ____t_result_508
        if ____t_509(____t_result_508) then
            ____t_result_510 = __O[1713]
        else
            ____t_result_510 = __L1.cutscene
        end
        if ____t_511(____t_result_510) then
            return false
        end
        __L1:releaseInputs()
        __L1.room.phase = "exiting"
        __L1.room.t = 0
        __L1:updateUI()
        return true
    end
    __L1.updateRoomTransition = function(self, dt)
        __L1.room.t = __add(__L1.room.t, dt)
        local ____L1_room_513 = __L1.room
        local ____temp_512
        if __L1.room.phase == "entering" then
            ____temp_512 = __L1:clamp(__L1.room.t / 0.65, 0, 1)
        else
            ____temp_512 = 1 - __L1:clamp(__L1.room.t / 0.65, 0, 1)
        end
        ____L1_room_513.blend = ____temp_512
        if __ge(__L1.room.t, 0.65) then
            if __L1.room.phase == "entering" then
                __L1.room.phase = "inside"
                __L1.room.blend = 1
                __L1.player.x = 120
                __L1.player.y = __L1.FLOOR
                __L1.player.vy = 0
                __L1.player.ground = true
                __L1.WORLD = 960
                __L1.camera = 0
            else
                local x = __L1.room.returnX
                __L1.room = nil
                __L1:resetWorldSize()
                __L1.player.x = x
                __L1.player.y = __L1.FLOOR
                __L1.player.vy = 0
                __L1.player.ground = true
                __L1.camera = __L1:clamp(x - __L1.W * 0.36, 0, __L1.WORLD - __L1.W)
                __L1.lastSafeX = x
                __L1:releaseInputs()
            end
            __L1:updateUI()
        end
    end
    __L1.recoverFall = function(self)
        local ____isFiniteN_result_514
        if __isFiniteN(__L1.lastSafeX) then
            ____isFiniteN_result_514 = __L1.lastSafeX
        else
            ____isFiniteN_result_514 = 230
        end
        local safeX = ____isFiniteN_result_514
        __L1:releaseInputs()
        __L1.player.x = __L1:clamp(
            safeX,
            40,
            math.max(40, __L1.WORLD - 40)
        )
        __L1.player.y = __L1.FLOOR
        __L1.player.vx = 0
        __L1.player.vy = 0
        __L1.player.ground = true
        __L1.player.landTimer = 0.15
        local ____L1_player_518 = __L1.player
        local ____t_result_517
        local ____t_516 = __t
        local ____TS__Number_result_515 = __TS__Number(__L1.player.inv)
        __O[1714] = ____TS__Number_result_515
        if ____t_516(____TS__Number_result_515) then
            ____t_result_517 = __O[1714]
        else
            ____t_result_517 = 0
        end
        ____L1_player_518.inv = math.max(____t_result_517, 1)
        local ____t_result_520
        if __t(__L1.room) then
            ____t_result_520 = 0
        else
            local ____t_result_519
            if __t(__L1.arena) then
                ____t_result_519 = __L1.arena.homeX - __L1.W / 2
            else
                ____t_result_519 = __L1:clamp(__L1.player.x - __L1.W * 0.36, 0, __L1.WORLD - __L1.W)
            end
            ____t_result_520 = ____t_result_519
        end
        __L1.camera = ____t_result_520
        __L1.lastSafeX = __L1.player.x
        __L1:updateUI()
    end
    __L1.makeArena = function(self, e)
        local ____opt_523 = window.CampaignVfx
        if ____opt_523 ~= nil then
            ____opt_523 = ____opt_523.reset
        end
        if ____opt_523 ~= nil then
            ____opt_523(____opt_523)
        end
        local ____t_result_530
        local ____t_529 = __t
        local ____getq_527 = __getq
        local ____opt_525 = window.WorldData
        if ____opt_525 ~= nil then
            ____opt_525 = ____opt_525.arenaBounds
        end
        local ____getq_527_result_528 = ____getq_527(____opt_525, e.type)
        __O[1715] = ____getq_527_result_528
        if ____t_529(____getq_527_result_528) then
            ____t_result_530 = __O[1715]
        else
            ____t_result_530 = __arrL({-430, 430}, 2)
        end
        local bounds = ____t_result_530
        __L1.arena = {
            type = e.type,
            homeX = e.homeX,
            bounds = __arrL(
                {
                    __add(
                        e.homeX,
                        __get(bounds, 0)
                    ),
                    __add(
                        e.homeX,
                        __get(bounds, 1)
                    )
                },
                2
            ),
            phase = "entering",
            blend = 0,
            t = 0,
            exteriorCamera = __L1.camera,
            retreatHold = 0,
            returnX = math.max(180, e.homeX - 480),
            won = false
        }
        __L1.shots = __arrL({}, 0)
        __L1.hazards = __arrL({}, 0)
        __L1:releaseInputs()
        __L1.player.x = __L1:clamp(
            __L1.player.x,
            __get(__L1.arena.bounds, 0) + 35,
            __get(__L1.arena.bounds, 1) - 35
        )
        __L1.player.y = __L1.FLOOR
        __L1.player.vy = 0
        __L1.player.ground = true
        e.state = "idle"
        __L1:updateUI()
    end
    __L1.leaveArena = function(self, won)
        if won == nil then
            won = false
        end
        if not __t(__L1.arena) then
            return
        end
        __L1.minions = __call(
            __L1.minions,
            "filter",
            function(____, m) return not __t(m.summoned) end
        )
        __L1:releaseInputs()
        __L1.arena.phase = "exiting"
        __L1.arena.t = 0
        __L1.arena.won = won
        local ____L1_arena_532 = __L1.arena
        local ____t_result_531
        if __t(won) then
            ____t_result_531 = math.min(
                __L1.WORLD - 80,
                __L1.arena.homeX + (__t(__call(
                    __arrL({"freddy", "nicolas", "dede", "arthur"}, 4),
                    "includes",
                    __L1.arena.type
                )) and 90 or 460)
            )
        else
            ____t_result_531 = math.max(180, __L1.arena.homeX - 480)
        end
        ____L1_arena_532.returnX = ____t_result_531
        local ____t_534 = __t
        local ____t_result_533
        if __t(__L1.activeBoss) then
            ____t_result_533 = not __t(won)
        else
            ____t_result_533 = __L1.activeBoss
        end
        if ____t_534(____t_result_533) then
            __L1.activeBoss.hp = __L1.activeBoss.max
            __L1.activeBoss.x = __L1.activeBoss.homeX
            __L1:bossDefaults(__L1.activeBoss)
            __L1.marcoTrapTriggered = false
        end
        __L1.activeBoss = nil
        __L1.shots = __arrL({}, 0)
        __L1.hazards = __arrL({}, 0)
    end
    __L1.retreatBoss = function(self)
        local ____t_538 = __t
        local ____t_result_537
        if __t(__L1.sandbox) then
            local ____opt_535 = window.C2Luta
            if ____opt_535 ~= nil then
                ____opt_535 = ____opt_535.skin
            end
            ____t_result_537 = ____opt_535
        else
            ____t_result_537 = __L1.sandbox
        end
        if ____t_538(____t_result_537) then
            __L1:emitGameEvent("sandbox-change", {type = __L1.sandbox.type, result = "retreat"})
            return true
        end
        if __t(__L1.sandbox) then
            return __L1:exitSandbox()
        end
        local ____t_544 = __t
        local ____t_result_543
        local ____t_542 = __t
        local ____t_result_541
        local ____t_540 = __t
        local ____temp_539 = not __t(__L1.arena) or __L1.arena.phase ~= "active"
        __O[1716] = ____temp_539
        if ____t_540(____temp_539) then
            ____t_result_541 = __O[1716]
        else
            ____t_result_541 = __L1.dialog
        end
        __O[1717] = ____t_result_541
        if ____t_542(____t_result_541) then
            ____t_result_543 = __O[1717]
        else
            ____t_result_543 = __L1.paused
        end
        if ____t_544(____t_result_543) then
            return false
        end
        __L1:leaveArena(false)
        __L1:toast("Você recuou da arena. O chefe voltou à força total.")
        return true
    end
    __L1.updateArenaTransition = function(self, dt)
        __L1.arena.t = __add(__L1.arena.t, dt)
        local ____L1_arena_546 = __L1.arena
        local ____temp_545
        if __L1.arena.phase == "entering" then
            ____temp_545 = __L1:clamp(__L1.arena.t / 0.6, 0, 1)
        else
            ____temp_545 = 1 - __L1:clamp(__L1.arena.t / 0.6, 0, 1)
        end
        ____L1_arena_546.blend = ____temp_545
        __L1.camera = __L1.arena.exteriorCamera + (__L1.arena.homeX - __L1.W / 2 - __L1.arena.exteriorCamera) * __L1.arena.blend
        if __ge(__L1.arena.t, 0.6) then
            if __L1.arena.phase == "entering" then
                __L1.arena.phase = "active"
                __L1.arena.blend = 1
                __L1.camera = __L1.arena.homeX - __L1.W / 2
                if __t(__L1.activeBoss) then
                    local e = __L1.activeBoss
                    local key = e.type == "reeisBoss" and "boss_reeis" or __add("boss_", e.type)
                    if __t(e.type == "igor" or e.type == "kaique") then
                        e.state = "monitorTransform"
                        e.stateTimer = 1.25
                        e.monitorTransform = 0
                        __L1.player.inv = math.max(__L1.player.inv, 1.5)
                        __L1:floating(
                            e.x,
                            e.y - 150,
                            e.type == "igor" and "SEM LANCHE? BARRIGA GIGANTE!" or (__t(e.rage) and "NÃO PISA NO NOME DA IRACI!" or "ENTREGA ESSAS BOLINHAS!"),
                            "#ffd49c"
                        )
                        __L1.shake = 7
                        __L1:fx(
                            e.x,
                            e.y - 45,
                            __t(e.rage) and "#e66f73" or "#e8c386",
                            35,
                            130
                        )
                    elseif not __t(__call(__L1.seenBossIntros, "includes", e.type)) then
                        __call(__L1.seenBossIntros, "push", e.type)
                        __L1:startCutscene(
                            key,
                            function()
                                if __L1.activeBoss == e then
                                    __L1:beginBossWindup(e)
                                end
                                __L1:save()
                            end
                        )
                    else
                        __L1:beginBossWindup(e)
                    end
                end
            else
                local x = __L1.arena.returnX
                __L1.arena = nil
                __L1:resetWorldSize()
                __L1.player.x = x
                __L1.player.y = __L1.FLOOR
                __L1.player.vy = 0
                __L1.player.ground = true
                __L1.lastSafeX = x
                __L1.player.inv = math.max(__L1.player.inv, 1.2)
                __L1.camera = __L1:clamp(x - __L1.W * 0.36, 0, __L1.WORLD - __L1.W)
                __L1:releaseInputs()
            end
            __L1:updateUI()
        end
    end
    __L1.damageMinion = function(self, m, n, element)
        local ____t_548 = __t
        local ____t_result_547
        if __t(m.dead) then
            ____t_result_547 = m.dead
        else
            ____t_result_547 = __gt(m.hit, 0)
        end
        if ____t_548(____t_result_547) then
            return
        end
        m.hp = m.hp - n
        m.hit = 0.14
        local ____opt_551 = window.SceneLife
        if ____opt_551 ~= nil then
            ____opt_551 = ____opt_551.impact
        end
        if ____opt_551 ~= nil then
            ____opt_551(
                ____opt_551,
                m.x,
                m.y - 22,
                element == "electric" and "#a9e7f4" or (element == "fire" and "#f4ad60" or "#e9c27a"),
                n,
                __TS__Number(-__L1.player.facing)
            )
        end
        local ____opt_555 = window.CampaignVfx
        if ____opt_555 ~= nil then
            ____opt_555 = ____opt_555.emit
        end
        if ____opt_555 ~= nil then
            ____opt_555(____opt_555, "hit", {
                x = m.x,
                y = m.y - 22,
                dir = __L1.player.facing,
                element = element,
                damage = n,
                kind = m.type
            })
        end
        if element == "fire" then
            m.burn = 2.5
        end
        __L1:fx(
            m.x,
            m.y - 20,
            element == "electric" and "#a9e7f4" or (element == "fire" and "#f4ad60" or "#d2afd9"),
            7,
            75
        )
        __L1:floating(
            m.x,
            m.y - 55,
            __add(
                "−",
                math.floor(n + 0.5)
            )
        )
        if element == "electric" then
            local others = __call(
                __L1.minions,
                "filter",
                function(____, a)
                    local ____t_result_559
                    local ____t_558 = __t
                    local ____temp_557 = not __t(a.dead) and a ~= m
                    __O[1718] = ____temp_557
                    if ____t_558(____temp_557) then
                        ____t_result_559 = math.abs(a.x - m.x) < 150
                    else
                        ____t_result_559 = __O[1718]
                    end
                    return ____t_result_559
                end
            )
            for ____, a in __iterar((others)) do
                a.hp = a.hp - math.max(3, n * 0.35)
                local ____opt_562 = window.CampaignVfx
                if ____opt_562 ~= nil then
                    ____opt_562 = ____opt_562.emit
                end
                if ____opt_562 ~= nil then
                    ____opt_562(____opt_562, "hit", {
                        x = a.x,
                        y = a.y - 22,
                        dir = __L1.player.facing,
                        element = "electric",
                        damage = n * 0.35,
                        kind = a.type
                    })
                end
                __L1:fx(
                    a.x,
                    a.y - 20,
                    "#b9edf7",
                    6,
                    60
                )
                if __le(a.hp, 0) then
                    __L1:damageMinion(a, 1)
                end
            end
        end
        if __le(m.hp, 0) then
            m.hp = 0
            m.dead = true
            if not __t(m.summoned) then
                if not __t(__call(__L1.minionKills, "includes", m.id)) then
                    __call(__L1.minionKills, "push", m.id)
                end
                local ____L1_awardXP_566 = __L1.awardXP
                local ____m_xp_565 = m.xp
                if ____m_xp_565 == nil then
                    local ____t_result_564
                    if __t(m.tier) then
                        ____t_result_564 = m.tier
                    else
                        ____t_result_564 = 1
                    end
                    ____m_xp_565 = 25 + ____t_result_564 * 10
                end
                ____L1_awardXP_566(
                    __L1,
                    ____m_xp_565,
                    __add("minion-", m.id)
                )
                __L1.player.papers = math.min(30, __L1.player.papers + 4)
                __L1.player.gas = math.min(
                    __L1:bonus().maxGas,
                    __L1.player.gas + 8
                )
            end
            __L1:fx(
                m.x,
                m.y - 20,
                "#ecd2f0",
                15,
                120
            )
            __L1:save()
        end
        __L1:updateUI()
    end
    __L1.updateMinions = function(self, dt)
        for ____, m in __iterar((__L1.minions)) do
            do
                if __t(m.temporary) then
                    m.life = m.life - dt
                    if __le(m.life, 0) then
                        m.dead = true
                        continue
                    end
                end
                local ____t_569 = __t
                local ____t_result_568
                if __t(m.dead) then
                    ____t_result_568 = m.dead
                else
                    local ____t_result_567
                    if __t(__L1.arena) then
                        ____t_result_567 = not __t(m.summoned)
                    else
                        ____t_result_567 = __L1.arena
                    end
                    ____t_result_568 = ____t_result_567
                end
                if ____t_569(____t_result_568) then
                    continue
                end
                m.hit = math.max(0, m.hit - dt)
                if __gt(m.burn, 0) then
                    m.burn = m.burn - dt
                    local ____add_571 = __add
                    local ____t_result_570
                    if __t(m.burnTick) then
                        ____t_result_570 = m.burnTick
                    else
                        ____t_result_570 = 0
                    end
                    m.burnTick = ____add_571(____t_result_570, dt)
                    if __gt(m.burnTick, 0.6) then
                        m.burnTick = 0
                        __L1:damageMinion(m, 4)
                    end
                end
                local ____t_573 = __t
                local ____t_result_572
                if __t(m.dead) then
                    ____t_result_572 = m.dead
                else
                    ____t_result_572 = math.abs(m.x - __L1.player.x) > 650
                end
                if ____t_573(____t_result_572) then
                    continue
                end
                local ____m_tauntTimer_574 = m.tauntTimer
                if ____m_tauntTimer_574 == nil then
                    ____m_tauntTimer_574 = 1.2
                end
                m.tauntTimer = ____m_tauntTimer_574 - dt
                if __t(__le(m.tauntTimer, 0) and math.abs(m.x - __L1.player.x) < 410) then
                    local ____t_result_575
                    if __t(m.tier) then
                        ____t_result_575 = m.tier
                    else
                        ____t_result_575 = 1
                    end
                    m.tauntTimer = 5 + ____t_result_575 * 0.3
                    local ____L1_floating_579 = __L1.floating
                    local ____m_x_577 = m.x
                    local ____temp_578 = m.y - 65
                    local ____t_result_576
                    if __t(m.provocation) then
                        ____t_result_576 = m.provocation
                    else
                        ____t_result_576 = m.type == "rat" and "O REI DOS RATOS MANDOU!" or (m.design == "sixseven" and "SIX SEVEN!" or "DA ROÇA PEGOU AR!")
                    end
                    ____L1_floating_579(
                        __L1,
                        ____m_x_577,
                        ____temp_578,
                        ____t_result_576,
                        m.type == "thug" and "#edce9a" or "#e1b6ee"
                    )
                end
                m.t = m.t - dt
                local thug = m.type == "thug" or m.kind == "thug"
                if m.type == "rat" then
                    local ____t_result_582
                    local ____t_581 = __t
                    local ____TS__MathSign_result_580 = __TS__MathSign(__L1.player.x - m.x)
                    __O[1719] = ____TS__MathSign_result_580
                    if ____t_581(____TS__MathSign_result_580) then
                        ____t_result_582 = __O[1719]
                    else
                        ____t_result_582 = m.dir
                    end
                    m.dir = ____t_result_582
                    local ____t_result_586
                    local ____t_585 = __t
                    local ____opt_583 = __L1.arena
                    if ____opt_583 ~= nil then
                        ____opt_583 = ____opt_583.bounds
                    end
                    __O[1720] = ____opt_583
                    if ____t_585(____opt_583) then
                        ____t_result_586 = __O[1720]
                    else
                        ____t_result_586 = __arrL({25, __L1.WORLD - 25}, 2)
                    end
                    local bounds = ____t_result_586
                    local ____L1_clamp_590 = __L1.clamp
                    local ____m_x_589 = m.x
                    local ____m_dir_588 = m.dir
                    local ____t_result_587
                    if __t(m.speed) then
                        ____t_result_587 = m.speed
                    else
                        ____t_result_587 = 115
                    end
                    m.x = ____L1_clamp_590(
                        __L1,
                        ____m_x_589 + ____m_dir_588 * ____t_result_587 * dt,
                        __get(bounds, 0) + 20,
                        __get(bounds, 1) - 20
                    )
                    m.y = __L1.FLOOR
                else
                    local ____t_592 = __t
                    local ____t_result_591
                    if __t(thug) then
                        ____t_result_591 = thug
                    else
                        ____t_result_591 = m.kind == 2
                    end
                    if ____t_592(____t_result_591) then
                        local ____t_result_593
                        if __t(m.tier) then
                            ____t_result_593 = m.tier
                        else
                            ____t_result_593 = 1
                        end
                        local tier = ____t_result_593
                        if __lt(m.t, 0.4) then
                            m.charging = true
                        end
                        if __le(m.t, 0) then
                            m.charging = false
                            local ____t_result_594
                            if __t(thug) then
                                ____t_result_594 = math.max(1.25, 2.8 - tier * 0.3)
                            else
                                ____t_result_594 = 2.3
                            end
                            m.t = ____t_result_594
                            local a = math.atan(__L1.player.y - 30 - (m.y - 30), __L1.player.x - m.x)
                            local ____t_result_595
                            if __t(thug) then
                                ____t_result_595 = m.weapon == "scatter" and 3 or (m.weapon == "carbine" and 2 or 1)
                            else
                                ____t_result_595 = 1
                            end
                            local count = ____t_result_595
                            do
                                local i = 0
                                while i < count do
                                    local spread = (i - (count - 1) / 2) * 0.15
                                    local ____call_607 = __call
                                    local ____L1_shots_606 = __L1.shots
                                    local ____m_x_601 = m.x
                                    local ____temp_602 = m.y - 30
                                    local ____temp_597 = math.cos(a + spread) * (185 + tier * 16)
                                    local ____t_result_596
                                    if __t(m.projectileSpeed) then
                                        ____t_result_596 = m.projectileSpeed
                                    else
                                        ____t_result_596 = 1
                                    end
                                    local ____temp_603 = ____temp_597 * ____t_result_596
                                    local ____temp_599 = math.sin(a + spread) * (185 + tier * 16)
                                    local ____t_result_598
                                    if __t(m.projectileSpeed) then
                                        ____t_result_598 = m.projectileSpeed
                                    else
                                        ____t_result_598 = 1
                                    end
                                    local ____temp_604 = ____temp_599 * ____t_result_598
                                    local ____temp_605 = __t(thug) and "enemyBullet" or "doodle"
                                    local ____t_result_600
                                    if __t(m.damage) then
                                        ____t_result_600 = m.damage
                                    else
                                        ____t_result_600 = 8
                                    end
                                    ____call_607(____L1_shots_606, "push", {
                                        x = ____m_x_601,
                                        y = ____temp_602,
                                        vx = ____temp_603,
                                        vy = ____temp_604,
                                        life = 4,
                                        type = ____temp_605,
                                        owner = "enemy",
                                        damage = ____t_result_600,
                                        variant = 1
                                    })
                                    i = i + 1
                                end
                            end
                            __L1:beep(145, 0.035, "square", 0.008)
                        end
                    else
                        local ____m_610, ____x_611 = m, "x"
                        local ____m_dir_609 = m.dir
                        local ____t_result_608
                        if __t(m.speed) then
                            ____t_result_608 = m.speed
                        else
                            ____t_result_608 = m.kind == 1 and 75 or 58
                        end
                        ____m_610[____x_611] = ____m_610[____x_611] + ____m_dir_609 * ____t_result_608 * dt
                        if __gt(
                            math.abs(m.x - m.homeX),
                            m.range
                        ) then
                            m.dir = m.dir * -1
                        end
                        local ____t_615 = __t
                        local ____t_result_614
                        local ____t_613 = __t
                        local ____temp_612 = m.kind == 1 and __le(m.t, 0)
                        __O[1721] = ____temp_612
                        if ____t_613(____temp_612) then
                            ____t_result_614 = __ge(m.y, __L1.FLOOR)
                        else
                            ____t_result_614 = __O[1721]
                        end
                        if ____t_615(____t_result_614) then
                            m.vy = -240
                            m.t = 1.5
                        end
                        m.vy = m.vy + 760 * dt
                        m.y = math.min(__L1.FLOOR, m.y + m.vy * dt)
                        if m.y == __L1.FLOOR then
                            m.vy = 0
                        end
                    end
                end
                local ____t_617 = __t
                local ____t_result_616
                if __t(window.Golpes) then
                    ____t_result_616 = window.Golpes:cruza(
                        window.Golpes:capanga(m),
                        window.Golpes:heroi(__L1.player)
                    )
                else
                    ____t_result_616 = math.abs(m.x - __L1.player.x) < (m.type == "rat" and 24 or 30) and math.abs(m.y - __L1.player.y) < (m.type == "rat" and 42 or 52)
                end
                if ____t_617(____t_result_616) then
                    if __L1.dashTimer > 0 then
                        __L1:damageMinion(
                            m,
                            math.floor(30 * __L1:bonus().damageMultiplier + 0.5)
                        )
                    else
                        local ____L1_hurt_619 = __L1.hurt
                        local ____t_result_618
                        if __t(m.damage) then
                            ____t_result_618 = m.damage
                        else
                            ____t_result_618 = 8
                        end
                        ____L1_hurt_619(__L1, ____t_result_618, m.x)
                    end
                end
            end
        end
        __L1.minions = __call(
            __L1.minions,
            "filter",
            function(____, m)
                local ____t_result_622
                local ____t_621 = __t
                local ____temp_620 = not __t(m.temporary)
                __O[1722] = ____temp_620
                if ____t_621(____temp_620) then
                    ____t_result_622 = __O[1722]
                else
                    ____t_result_622 = not __t(m.dead) and __gt(m.life, 0)
                end
                return ____t_result_622
            end
        )
    end
    __L1.movePlayer = function(self, dt)
        if not __t(__call(
            __arrL({__L1.player.x, __L1.player.y, __L1.player.vx, __L1.player.vy}, 4),
            "every",
            __isFiniteV
        )) then
            __L1:recoverFall()
            return
        end
        local ____opt_623 = __L1.activeBoss
        if ____opt_623 ~= nil then
            ____opt_623 = ____opt_623.conquista
        end
        local duelo = ____opt_623
        local terreno = __L1:terrenoConquista(duelo)
        if __t(terreno) then
            terreno:avancar(duelo, dt, __L1.player)
        end
        local ____t_result_627
        local ____t_626 = __t
        local ____temp_625 = __L1:keyHeld("left")
        __O[1723] = ____temp_625
        if ____t_626(____temp_625) then
            ____t_result_627 = __O[1723]
        else
            ____t_result_627 = __L1.touch.left
        end
        local left = ____t_result_627
        local ____t_result_630
        local ____t_629 = __t
        local ____temp_628 = __L1:keyHeld("right")
        __O[1724] = ____temp_628
        if ____t_629(____temp_628) then
            ____t_result_630 = __O[1724]
        else
            ____t_result_630 = __L1.touch.right
        end
        local right = ____t_result_630
        local ____t_result_633
        local ____t_632 = __t
        local ____temp_631 = __L1:keyHeld("up")
        __O[1725] = ____temp_631
        if ____t_632(____temp_631) then
            ____t_result_633 = __O[1725]
        else
            ____t_result_633 = __L1.touch.up
        end
        local up = ____t_result_633
        local ____t_result_636
        local ____t_635 = __t
        local ____temp_634 = __L1:keyHeld("down")
        __O[1726] = ____temp_634
        if ____t_635(____temp_634) then
            ____t_result_636 = __O[1726]
        else
            ____t_result_636 = __L1.touch.down
        end
        local down = ____t_result_636
        local ____t_result_639
        local ____t_638 = __t
        local ____temp_637 = __L1:keyHeld("jump")
        __O[1727] = ____temp_637
        if ____t_638(____temp_637) then
            ____t_result_639 = __O[1727]
        else
            ____t_result_639 = __L1.touch.jump
        end
        local jump = ____t_result_639
        local ____t_result_646
        local ____t_645 = __t
        local ____opt_642 = window.ControlSettings
        if ____opt_642 ~= nil then
            ____opt_642 = ____opt_642.getSensitivity
        end
        local ____opt_result_644
        if ____opt_642 ~= nil then
            ____opt_result_644 = ____opt_642(____opt_642)
        end
        __O[1728] = ____opt_result_644
        if ____t_645(____opt_result_644) then
            ____t_result_646 = __O[1728]
        else
            ____t_result_646 = 1
        end
        local sensitivity = ____t_result_646
        local ____t_result_649
        local ____t_648 = __t
        local ____temp_647 = (__t(right) and 1 or 0) - (__t(left) and 1 or 0)
        __O[1729] = ____temp_647
        if ____t_648(____temp_647) then
            ____t_result_649 = __O[1729]
        else
            ____t_result_649 = __L1.joystick.x
        end
        local dir = ____t_result_649
        local targetVX = dir * (__t(__L1.vehicle) and 420 or __L1:bonus().moveSpeed)
        local ____t_result_650
        if __t(dir) then
            ____t_result_650 = __t(__L1.vehicle) and 1600 or (__t(__L1.player.ground) and 1800 or 1150)
        else
            ____t_result_650 = __t(__L1.player.ground) and 2200 or 950
        end
        local accel = ____t_result_650 * sensitivity
        if __L1.dashTimer > 0 then
            __L1.player.vx = __L1.dashDir * 600
            __call(__L1.afterimages, "push", {x = __L1.player.x, y = __L1.player.y, facing = __L1.player.facing, life = 0.2})
        else
            local ____L1_player_651, ____vx_652 = __L1.player, "vx"
            ____L1_player_651[____vx_652] = ____L1_player_651[____vx_652] + __L1:clamp(targetVX - __L1.player.vx, -accel * dt, accel * dt)
        end
        if math.abs(__L1.player.vx) < 0.1 then
            __L1.player.vx = 0
        end
        local ____t_654 = __t
        local ____t_result_653
        if __t(dir) then
            ____t_result_653 = __L1.dashTimer <= 0
        else
            ____t_result_653 = dir
        end
        if ____t_654(____t_result_653) then
            __L1.player.facing = __TS__MathSign(dir)
        end
        local ____L1_player_655, ____anim_656 = __L1.player, "anim"
        ____L1_player_655[____anim_656] = ____L1_player_655[____anim_656] + math.abs(__L1.player.vx) * dt / 18.3
        local ____t_658 = __t
        local ____t_result_657
        if __t(__L1.vehicle) then
            ____t_result_657 = __gt(__L1.player.gas, 0)
        else
            ____t_result_657 = __L1.vehicle
        end
        if ____t_658(____t_result_657) then
            local ____L1_player_664 = __L1.player
            local ____t_result_663
            local ____t_660 = __t
            local ____t_result_659
            if __t(jump) then
                ____t_result_659 = jump
            else
                ____t_result_659 = up
            end
            if ____t_660(____t_result_659) then
                ____t_result_663 = -190
            else
                local ____t_result_662
                if __t(down) then
                    ____t_result_662 = 180
                else
                    local ____t_result_661
                    if __t(__L1.joystick.y) then
                        ____t_result_661 = __L1.joystick.y * 190
                    else
                        ____t_result_661 = math.sin(__L1.time * 2) * 7
                    end
                    ____t_result_662 = ____t_result_661
                end
                ____t_result_663 = ____t_result_662
            end
            ____L1_player_664.vy = ____t_result_663
            local ____L1_player_671 = __L1.player
            local ____L1_player_gas_670 = __L1.player.gas
            local ____dt_669 = dt
            local ____t_668 = __t
            local ____t_result_667
            local ____t_666 = __t
            local ____t_result_665
            if __t(dir) then
                ____t_result_665 = dir
            else
                ____t_result_665 = jump
            end
            __O[1730] = ____t_result_665
            if ____t_666(____t_result_665) then
                ____t_result_667 = __O[1730]
            else
                ____t_result_667 = up
            end
            ____L1_player_671.gas = math.max(
                0,
                ____L1_player_gas_670 - ____dt_669 * (____t_668(____t_result_667) and 8 or 3)
            )
            if not __t(__L1.player.gas) then
                __L1.vehicle = false
                __L1:toast("Acabou o gás! Aguarde a recarga no chão.")
            end
            if math.random() < 0.4 then
                __L1:fx(
                    __L1.player.x - __L1.player.facing * 45,
                    __L1.player.y - 12,
                    "#c1db7b",
                    1,
                    25
                )
            end
        else
            local ____t_675 = __t
            local ____t_result_674
            local ____t_673 = __t
            local ____t_result_672
            if __t(jump) then
                ____t_result_672 = not __t(__L1.prevJump)
            else
                ____t_result_672 = jump
            end
            __O[1731] = ____t_result_672
            if ____t_673(____t_result_672) then
                ____t_result_674 = __L1.player.ground
            else
                ____t_result_674 = __O[1731]
            end
            if ____t_675(____t_result_674) then
                local ____L1_player_680 = __L1.player
                local ____t_679 = __t
                local ____opt_result_678
                if duelo ~= nil then
                    ____opt_result_678 = duelo.estrada
                end
                ____L1_player_680.vy = ____t_679(____opt_result_678) and -405 or -365
                __L1.player.ground = false
                __L1:beep(320, 0.06, "triangle")
            end
            local ____t_690 = __t
            local ____t_result_689
            local ____t_688 = __t
            local ____t_result_687
            local ____t_686 = __t
            local ____t_result_685
            if __t(jump) then
                local ____t_684 = __t
                local ____opt_result_683
                if duelo ~= nil then
                    ____opt_result_683 = duelo.estrada
                end
                ____t_result_685 = not ____t_684(____opt_result_683)
            else
                ____t_result_685 = jump
            end
            __O[1732] = ____t_result_685
            if ____t_686(____t_result_685) then
                ____t_result_687 = not __t(__L1.player.ground)
            else
                ____t_result_687 = __O[1732]
            end
            __O[1733] = ____t_result_687
            if ____t_688(____t_result_687) then
                ____t_result_689 = __gt(__L1.player.gas, 0)
            else
                ____t_result_689 = __O[1733]
            end
            if ____t_690(____t_result_689) then
                if __gt(__L1.player.vy, -235) then
                    __L1.player.vy = math.max(-235, __L1.player.vy - 1050 * dt)
                end
                __L1.player.gas = math.max(0, __L1.player.gas - 17 * dt)
                if math.random() < 0.35 then
                    __L1:fx(
                        __L1.player.x,
                        __L1.player.y + 3,
                        "#bed970",
                        1,
                        50
                    )
                end
            end
            local ____L1_player_691, ____vy_692 = __L1.player, "vy"
            ____L1_player_691[____vy_692] = ____L1_player_691[____vy_692] + 850 * dt
        end
        __L1.prevJump = not not __t(jump)
        local oldY = __L1.player.y
        local wasGrounded = __L1.player.ground
        local ____t_result_696
        local ____t_695 = __t
        local ____opt_693 = __L1.arena
        if ____opt_693 ~= nil then
            ____opt_693 = ____opt_693.bounds
        end
        __O[1734] = ____opt_693
        if ____t_695(____opt_693) then
            ____t_result_696 = __O[1734]
        else
            ____t_result_696 = __arrL({25, __L1.WORLD - 25}, 2)
        end
        local bounds = ____t_result_696
        __L1.player.x = __L1:clamp(
            __L1.player.x + __L1.player.vx * dt,
            __get(bounds, 0),
            __get(bounds, 1)
        )
        local ____L1_player_697, ____y_698 = __L1.player, "y"
        ____L1_player_697[____y_698] = ____L1_player_697[____y_698] + __L1.player.vy * dt
        __L1.player.ground = false
        if __t(terreno) then
            terreno:pousar(duelo, __L1.player, oldY, __L1.hurt)
        elseif __t(__ge(__L1.player.y, __L1.FLOOR) and not __t(__L1:gapAt(__L1.player.x))) then
            __L1.player.y = __L1.FLOOR
            __L1.player.vy = 0
            __L1.player.ground = true
        end
        if __lt(__L1.player.y, 95) then
            __L1.player.y = 95
            __L1.player.vy = math.max(0, __L1.player.vy)
        end
        local ____t_702 = __t
        local ____t_result_701
        local ____t_700 = __t
        local ____temp_699 = not __t(terreno) and not __t(__L1.vehicle)
        __O[1735] = ____temp_699
        if ____t_700(____temp_699) then
            ____t_result_701 = __ge(__L1.player.vy, 0)
        else
            ____t_result_701 = __O[1735]
        end
        if ____t_702(____t_result_701) then
            for ____, p in __iterar((__L1:scenePlatforms())) do
                local ____t_708 = __t
                local ____t_result_707
                local ____t_706 = __t
                local ____t_result_705
                local ____t_704 = __t
                local ____temp_703 = __gt(
                    __L1.player.x,
                    __get(p, 0) - 8
                ) and __lt(
                    __L1.player.x,
                    __add(
                        __get(p, 0),
                        __get(p, 2)
                    ) + 8
                )
                __O[1736] = ____temp_703
                if ____t_704(____temp_703) then
                    ____t_result_705 = __le(
                        oldY,
                        __get(p, 1) + 3
                    )
                else
                    ____t_result_705 = __O[1736]
                end
                __O[1737] = ____t_result_705
                if ____t_706(____t_result_705) then
                    ____t_result_707 = __ge(
                        __L1.player.y,
                        __get(p, 1)
                    )
                else
                    ____t_result_707 = __O[1737]
                end
                if ____t_708(____t_result_707) then
                    __L1.player.y = __get(p, 1)
                    __L1.player.vy = 0
                    __L1.player.ground = true
                    if __t(__get(p, 3)) then
                        __L1.player.x = __add(
                            __L1.player.x,
                            __get(p, 3)
                        )
                    end
                end
            end
        end
        local ____t_712 = __t
        local ____t_result_711
        local ____t_710 = __t
        local ____temp_709 = not __t(wasGrounded)
        __O[1738] = ____temp_709
        if ____t_710(____temp_709) then
            ____t_result_711 = __L1.player.ground
        else
            ____t_result_711 = __O[1738]
        end
        if ____t_712(____t_result_711) then
            __L1.player.landTimer = 0.15
        end
        if __t(not __t(__L1.vehicle) and not __t(jump)) then
            local ____L1_player_723 = __L1.player
            local ____table_maxGas_722 = __L1:bonus().maxGas
            local ____L1_player_gas_721 = __L1.player.gas
            local ____dt_720 = dt
            local ____t_result_719
            if __t(__L1.player.ground) then
                local ____t_result_715
                local ____t_714 = __t
                local ____table_gasRegen_713 = __L1:bonus().gasRegen
                __O[1739] = ____table_gasRegen_713
                if ____t_714(____table_gasRegen_713) then
                    ____t_result_715 = __O[1739]
                else
                    ____t_result_715 = 16
                end
                ____t_result_719 = ____t_result_715
            else
                local ____t_result_718
                local ____t_717 = __t
                local ____table_airGasRegen_716 = __L1:bonus().airGasRegen
                __O[1740] = ____table_airGasRegen_716
                if ____t_717(____table_airGasRegen_716) then
                    ____t_result_718 = __O[1740]
                else
                    ____t_result_718 = 6
                end
                ____t_result_719 = ____t_result_718
            end
            ____L1_player_723.gas = math.min(____table_maxGas_722, ____L1_player_gas_721 + ____dt_720 * ____t_result_719)
        end
        local ____t_731 = __t
        local ____t_result_730
        local ____t_729 = __t
        local ____t_result_728
        local ____t_727 = __t
        local ____t_result_726
        local ____t_725 = __t
        local ____temp_724 = not __t(__L1.room) and not __t(__L1.arena)
        __O[1741] = ____temp_724
        if ____t_725(____temp_724) then
            ____t_result_726 = __L1.player.ground
        else
            ____t_result_726 = __O[1741]
        end
        __O[1742] = ____t_result_726
        if ____t_727(____t_result_726) then
            ____t_result_728 = __L1.player.y == __L1.FLOOR
        else
            ____t_result_728 = __O[1742]
        end
        __O[1743] = ____t_result_728
        if ____t_729(____t_result_728) then
            ____t_result_730 = not __t(__L1:gapAt(__L1.player.x))
        else
            ____t_result_730 = __O[1743]
        end
        if ____t_731(____t_result_730) then
            __L1.lastSafeX = __L1.player.x
        end
        if __gt(__L1.player.y, __L1.H + 80) then
            __L1:recoverFall()
        end
        local ____t_result_734
        if __t(__L1.room) then
            ____t_result_734 = 0
        else
            local ____t_result_733
            if __t(terreno) then
                ____t_result_733 = (__add(duelo.l, duelo.r) - __L1.W) / 2
            else
                local ____t_result_732
                if __t(__L1.arena) then
                    ____t_result_732 = __L1.arena.homeX - __L1.W / 2
                else
                    ____t_result_732 = __L1:clamp(__L1.player.x - __L1.W * 0.36, 0, __L1.WORLD - __L1.W)
                end
                ____t_result_733 = ____t_result_732
            end
            ____t_result_734 = ____t_result_733
        end
        __L1.camera = ____t_result_734
        if __t(__L1.arena) then
            __L1.arena.retreatHold = 0
        end
    end
    __L1.basePlayer = function(self)
        return {
            x = 230,
            y = __L1.FLOOR,
            vx = 0,
            vy = 0,
            hp = __L1:bonus().maxHP,
            gas = __L1:bonus().maxGas,
            papers = 30,
            facing = 1,
            ground = true,
            inv = 0,
            attack = 0,
            attackType = "paper",
            attackDuration = 0.22,
            anim = 0,
            landTimer = 0
        }
    end
    __L1.safe = function(self, fn)
        do
            local function ____catch(e)
                return true, nil
            end
            local ____try, ____hasReturned, ____returnValue = pcall(function()
                return true, fn(nil)
            end)
            if not ____try then
                ____hasReturned, ____returnValue = ____catch(____hasReturned)
            end
            if ____hasReturned then
                return ____returnValue
            end
        end
    end
    __L1.setText = function(self, id, t)
        local e = __L1["$"](__L1, id)
        local ____t_736 = __t
        local ____t_result_735
        if __t(e) then
            ____t_result_735 = e.textContent ~= tostring(t)
        else
            ____t_result_735 = e
        end
        if ____t_736(____t_result_735) then
            e.textContent = t
        end
    end
    __L1.show = function(self, id, yes)
        local e = __L1["$"](__L1, id)
        if __t(e) then
            e.hidden = not __t(yes)
            e.style.display = __t(yes) and "" or "none"
        end
    end
    __L1.toast = function(self, t)
        __L1:setText("toast", t)
        local e = __L1["$"](__L1, "toast")
        if __t(e) then
            __call(e.classList, "add", "show")
            e.hidden = false
        end
        __L1.toastTimer = 4
    end
    __L1.beep = function(self, freq, dur, ____type, volume)
        if freq == nil then
            freq = 440
        end
        if dur == nil then
            dur = 0.09
        end
        if ____type == nil then
            ____type = "square"
        end
        if volume == nil then
            volume = 0.025
        end
        if not __t(__L1.sound) then
            return
        end
        local ____opt_739 = window.DarocaAudio
        if ____opt_739 ~= nil then
            ____opt_739 = ____opt_739.sfx
        end
        local ____opt_result_741
        if ____opt_739 ~= nil then
            ____opt_result_741 = ____opt_739(____opt_739)
        end
        local ____opt_result_741_742 = ____opt_result_741
        if ____opt_result_741_742 == nil then
            ____opt_result_741_742 = 1
        end
        volume = volume * ____opt_result_741_742
        if volume <= 0.0005 then
            return
        end
        __L1:safe(function()
            local ____t_result_745
            if __t(__L1.audioCtx) then
                ____t_result_745 = __L1.audioCtx
            else
                local ____newExpr_744 = __newExpr
                local ____t_result_743
                if __t(window.AudioContext) then
                    ____t_result_743 = window.AudioContext
                else
                    ____t_result_743 = window.webkitAudioContext
                end
                ____t_result_745 = ____newExpr_744(____t_result_743)
            end
            __L1.audioCtx = ____t_result_745
            __L1.audioCtx:resume()
            local o = __L1.audioCtx:createOscillator()
            local g = __L1.audioCtx:createGain()
            o.type = ____type
            o.frequency:setValueAtTime(freq, __L1.audioCtx.currentTime)
            o.frequency:exponentialRampToValueAtTime(
                math.max(35, freq * 0.5),
                __L1.audioCtx.currentTime + dur
            )
            g.gain:setValueAtTime(volume, __L1.audioCtx.currentTime)
            g.gain:exponentialRampToValueAtTime(0.001, __L1.audioCtx.currentTime + dur)
            o:connect(g)
            g:connect(__L1.audioCtx.destination)
            o:start()
            o:stop(__L1.audioCtx.currentTime + dur)
        end)
    end
    __L1.fx = function(self, x, y, color, count, power)
        if count == nil then
            count = 10
        end
        if power == nil then
            power = 90
        end
        local amount = math.min(
            12,
            math.max(
                0,
                math.floor(count * 0.5 + 0.5)
            ),
            math.max(
                0,
                96 - __len(__L1.particles)
            )
        )
        do
            local i = 0
            while i < amount do
                __call(
                    __L1.particles,
                    "push",
                    {
                        x = x,
                        y = y,
                        vx = __L1:rand(-power, power),
                        vy = __L1:rand(-power, power * 0.35),
                        life = __L1:rand(0.18, 0.48),
                        max = 0.48,
                        color = color,
                        size = __L1:rand(2, 4)
                    }
                )
                i = i + 1
            end
        end
    end
    __L1.floating = function(self, x, y, text, color)
        if color == nil then
            color = "#fff4d1"
        end
        __call(__L1.damageTexts, "push", {
            x = x,
            y = y,
            text = text,
            color = color,
            life = 1.2
        })
    end
    __L1.save = function(self)
        local ____t_749 = __t
        local ____t_result_748
        local ____t_747 = __t
        local ____temp_746 = not __t(__L1.started)
        __O[1744] = ____temp_746
        if ____t_747(____temp_746) then
            ____t_result_748 = __O[1744]
        else
            ____t_result_748 = __L1.sandbox
        end
        if ____t_749(____t_result_748) then
            return
        end
        __L1:safe(function()
            local ____self_774 = window.localStorage
            local ____self_774_setItem_775 = ____self_774.setItem
            local ____L1_SAVE_773 = __L1.SAVE
            local ____self_771 = window.JSON
            local ____self_771_stringify_772 = ____self_771.stringify
            local ____L1_q_761 = __L1.q
            local ____L1_scene_762 = __L1.scene
            local ____L1_player_hp_763 = __L1.player.hp
            local ____L1_player_papers_764 = __L1.player.papers
            local ____L1_items_765 = __L1.items
            local ____L1_collected_766 = __L1.collected
            local ____L1_weapon_767 = __L1.weapon
            local ____L1_minionKills_768 = __L1.minionKills
            local ____L1_seenBossIntros_769 = __L1.seenBossIntros
            local ____t_result_750
            if __t(not __t(__L1.room) and not __t(__L1.arena)) then
                ____t_result_750 = __L1.player.x
            else
                ____t_result_750 = __L1.lastSafeX
            end
            local ____temp_770 = {x = ____t_result_750, scene = __L1.scene}
            local ____opt_753 = window.Progression
            if ____opt_753 ~= nil then
                ____opt_753 = ____opt_753.serialize
            end
            local ____opt_result_755
            if ____opt_753 ~= nil then
                ____opt_result_755 = ____opt_753(____opt_753)
            end
            local ____opt_758 = window.CampaignRun
            if ____opt_758 ~= nil then
                ____opt_758 = ____opt_758.serialize
            end
            local ____opt_result_760
            if ____opt_758 ~= nil then
                ____opt_result_760 = ____opt_758(____opt_758)
            end
            return ____self_774_setItem_775(
                ____self_774,
                ____L1_SAVE_773,
                ____self_771_stringify_772(____self_771, {
                    q = ____L1_q_761,
                    scene = ____L1_scene_762,
                    hp = ____L1_player_hp_763,
                    papers = ____L1_player_papers_764,
                    items = ____L1_items_765,
                    collected = ____L1_collected_766,
                    weapon = ____L1_weapon_767,
                    minionKills = ____L1_minionKills_768,
                    seenBossIntros = ____L1_seenBossIntros_769,
                    position = ____temp_770,
                    progression = ____opt_result_755,
                    run = ____opt_result_760,
                    campaignVersion = 3.9,
                    version = 1
                })
            )
        end)
        __L1:updateContinue()
    end
    __L1.load = function(self)
        return __L1:safe(function()
            local a = window.JSON:parse(window.localStorage:getItem(__L1.SAVE))
            local ____t_result_780
            local ____t_779 = __t
            local ____t_result_778
            local ____t_777 = __t
            local ____t_result_776
            if __t(a) then
                ____t_result_776 = a.version == 1
            else
                ____t_result_776 = a
            end
            __O[1745] = ____t_result_776
            if ____t_777(____t_result_776) then
                ____t_result_778 = a.q
            else
                ____t_result_778 = __O[1745]
            end
            if ____t_779(____t_result_778) then
                ____t_result_780 = a
            else
                ____t_result_780 = nil
            end
            return ____t_result_780
        end)
    end
    __L1.getJaglionStatus = function(self)
        local ____t_result_781
        if __t(__L1.started) then
            ____t_result_781 = __L1.q
        else
            ____t_result_781 = __L1.menuLookQuest
        end
        local quest = ____t_result_781
        local ____t_785 = __t
        local ____opt_result_784
        if quest ~= nil then
            ____opt_result_784 = quest.amandaDating
        end
        if not ____t_785(____opt_result_784) then
            return "locked"
        end
        return __t(quest.jaglionClaimed) and "ready" or "reserved"
    end
    __L1.updateContinue = function(self)
        local b = __L1["$"](__L1, "continueBtn")
        if __t(b) then
            local yes = not not __t(__L1:load())
            b.hidden = not __t(yes)
            b.style.display = __t(yes) and "" or "none"
        end
    end
    __L1.mission = function(self)
        if __t(__L1.scene == 8 and __L1:getJaglionStatus() == "reserved") then
            return __arrL({"A entrega da Amanda", "O Jaglion está pronto. Fale com Davi na Bigodon e receba o traje para vestir no espelho."}, 2)
        end
        if __t(__L1.scene == 10 and not __t(__L1.q.bivoltUnlocked)) then
            local ____opt_788 = window.BivoltQuest
            if ____opt_788 ~= nil then
                ____opt_788 = ____opt_788.state
            end
            local ____opt_result_790
            if ____opt_788 ~= nil then
                ____opt_result_790 = ____opt_788(____opt_788, __L1.q)
            end
            local s = ____opt_result_790
            local ____arrL_799 = __arrL
            local ____t_result_798
            if __t(__L1.q.bivoltAccepted) then
                local ____t_result_797
                local ____t_796 = __t
                local ____lenq_794 = __lenq
                local ____opt_result_793
                if s ~= nil then
                    ____opt_result_793 = s.collected
                end
                local ____lenq_794_result_795 = ____lenq_794(____opt_result_793)
                __O[1746] = ____lenq_794_result_795
                if ____t_796(____lenq_794_result_795) then
                    ____t_result_797 = __O[1746]
                else
                    ____t_result_797 = 0
                end
                ____t_result_798 = tostring(____t_result_797) .. "/3 latas encontradas. Suba as prateleiras e a varanda; depois volte às garotas."
            else
                ____t_result_798 = "Converse com as garotas na Casa de Rayssa para descobrir um energético que fortalece todos os atributos por 10 segundos."
            end
            return ____arrL_799({"Bivolt · energia da resenha", ____t_result_798}, 2)
        end
        local ____opt_802 = window.MissaoFarda
        if ____opt_802 ~= nil then
            ____opt_802 = ____opt_802.objetivo
        end
        local ____opt_result_804
        if ____opt_802 ~= nil then
            ____opt_result_804 = ____opt_802(____opt_802, __L1.q, __L1.scene)
        end
        local fardaObj = ____opt_result_804
        if __t(fardaObj) then
            return fardaObj
        end
        local ____opt_807 = window.LugaresC1
        if ____opt_807 ~= nil then
            ____opt_807 = ____opt_807.objetivo
        end
        local ____opt_result_809
        if ____opt_807 ~= nil then
            ____opt_result_809 = ____opt_807(____opt_807, __L1.q, __L1.scene)
        end
        local lugarObj = ____opt_result_809
        if __t(lugarObj) then
            return lugarObj
        end
        if __t(__L1.scene == 11 and not __t(__L1.q.ollyan)) then
            return __arrL({"Orelhas ao vento", "Ollyan está no meio do baile. Use o carro a gás para persegui-lo numa luta aérea de três fases. Invista nos atributos antes de decolar."}, 2)
        end
        local ____t_812 = __t
        local ____opt_810 = window.Campaign
        if ____opt_810 ~= nil then
            ____opt_810 = ____opt_810.currentQuest
        end
        if ____t_812(____opt_810) then
            local result = window.Campaign:currentQuest(
                __L1.q,
                {
                    level = __L1:levelState().level,
                    carParts = __len(__L1.q.carParts),
                    notebooks = __len(__L1.q.notebooks),
                    activity = __L1.activity,
                    training = __L1.training
                }
            )
            if __isArray(result) then
                return result
            end
        end
        if not __t(__L1.q.carMissionAccepted) then
            return __arrL({"O carro do pai quebrou", "Fale com Lucas na roça. Ele sabe quais peças faltam para consertar o carro a gás."}, 2)
        end
        if not __t(__L1.q.lucas) then
            return __arrL(
                {
                    "Oficina no meio do parkour",
                    ("Encontre as 3 peças pelas plataformas da roça (" .. tostring(__len(__L1.q.carParts))) .. "/3) e volte ao Lucas."
                },
                2
            )
        end
        if not __t(__L1.q.mota) then
            return __arrL({"Futebol antes da aventura", "Entre no carro e vá ao Campo do Mota. Vença o minigame para aprender o dash!"}, 2)
        end
        if not __t(__L1.q.almiro) then
            local ____arrL_814 = __arrL
            local ____t_result_813
            if __t(__L1.q.almiroAccepted) then
                ____t_result_813 = ("Recupere os 3 cadernos no corredor (" .. tostring(__len(__L1.q.notebooks))) .. "/3) e entregue ao professor na sala 01."
            else
                ____t_result_813 = "Vá à escola e entre na sala do Almiro. Ele tem uma missão e ensina o combo de gás."
            end
            return ____arrL_814({"Os cadernos do Almiro", ____t_result_813}, 2)
        end
        if not __t(__L1.q.miqueias) then
            return __arrL({"ALLRIGHT, uma aula especial", "Na segunda sala, complete o quiz do Miqueias para liberar as papaias elementais."}, 2)
        end
        if not __t(__L1.q.reeis) then
            return __arrL({"O rei do morro", "Viaje à favela. Enfrente os capangas, vença Reeis no topo e peça sua ajuda pelo bolo."}, 2)
        end
        if not __t(__L1.q.marco) then
            return __arrL({"Rabiscos que pegam vida", "Volte à escola, atravesse os monstros de Marco e enfrente o desenhista. Cuidado com o piso SARUÊ!"}, 2)
        end
        if not __t(__L1.q.giant) then
            return __arrL({"O maior rabisco do caderno", "O caminho ao Caderno do Caos foi aberto. Vença o monstro gigante criado por Marco."}, 2)
        end
        if not __t(__L1.q.menezes) then
            return __arrL({"A última provocação da escola", "Retorne ao fim do colégio para enfrentar as paredes, ecos e ondas de Menezes."}, 2)
        end
        if not __t(__L1.q.trained) then
            return __arrL({"Treino de respeito", "Vá à academia e complete as 3 rodadas do Caleb. Seu shape e seus ataques vão mudar!"}, 2)
        end
        if not __t(__L1.q.nikolas) then
            return __arrL({"A amizade e o último pedaço", "Entre no carro para a quadra. Derrote Nikolas, o nariz de batata, e recupere o bolo."}, 2)
        end
        return __arrL({"O bolo voltou para a turma!", "Campanha concluída! Explore os 8 lugares, repita o futebol e continue evoluindo seus atributos."}, 2)
    end
    __L1.updateUI = function(self)
        __L1:updateBivoltUI()
        local hearts = __L1:clamp(
            math.ceil(__L1.player.hp / __L1:bonus().maxHP * 5),
            0,
            5
        )
        __L1:setText(
            "hpValue",
            __call(
                __add(
                    __call("♥ ", "repeat", hearts),
                    __call("♡ ", "repeat", 5 - hearts)
                ),
                "trim"
            )
        )
        local ____opt_815 = __L1["$"](__L1, "hpValue")
        if ____opt_815 ~= nil then
            ____opt_815:setAttribute(
                "aria-label",
                (("Vida: " .. tostring(math.ceil(__L1.player.hp))) .. " de ") .. tostring(__L1:bonus().maxHP)
            )
        end
        __L1:setText("paperValue", __L1.player.papers)
        local ____opt_819 = window.C2Luta
        if ____opt_819 ~= nil then
            ____opt_819 = ____opt_819.skin
        end
        local ____opt_result_821
        if ____opt_819 ~= nil then
            ____opt_result_821 = ____opt_819.lugar
        end
        local localC2 = ____opt_result_821
        local ____t_result_831
        local ____t_830 = __t
        local ____t_result_829
        local ____t_823 = __t
        local ____get_result_822 = __get(__L1.scenes, __L1.scene)
        __O[1747] = ____get_result_822
        if ____t_823(____get_result_822) then
            ____t_result_829 = __O[1747]
        else
            local ____opt_826 = window.LugaresC1
            if ____opt_826 ~= nil then
                ____opt_826 = ____opt_826.nome
            end
            local ____opt_result_828
            if ____opt_826 ~= nil then
                ____opt_result_828 = ____opt_826(____opt_826, __L1.scene)
            end
            ____t_result_829 = ____opt_result_828
        end
        __O[1748] = ____t_result_829
        if ____t_830(____t_result_829) then
            ____t_result_831 = __O[1748]
        else
            ____t_result_831 = ""
        end
        local nomeAqui = ____t_result_831
        local ____L1_setText_833 = __L1.setText
        local ____t_result_832
        if __t(localC2) then
            ____t_result_832 = localC2
        else
            ____t_result_832 = nomeAqui
        end
        ____L1_setText_833(__L1, "stageName", ____t_result_832)
        local ____L1_setText_843 = __L1.setText
        local ____t_result_842
        if __t(localC2) then
            ____t_result_842 = __add(
                "CONQUISTA / ",
                __call(localC2, "toUpperCase")
            )
        else
            local ____add_841 = __add
            local ____add_840 = __add
            local ____t_839 = __t
            local ____opt_836 = window.LugaresC1
            if ____opt_836 ~= nil then
                ____opt_836 = ____opt_836.tem
            end
            local ____opt_result_838
            if ____opt_836 ~= nil then
                ____opt_result_838 = ____opt_836(____opt_836, __L1.scene)
            end
            ____t_result_842 = ____add_841(
                ____add_840(
                    ____t_839(____opt_result_838) and "ITABUNA" or __call(
                        tostring(__L1.scene + 1),
                        "padStart",
                        2,
                        "0"
                    ),
                    " / "
                ),
                __call(nomeAqui, "toUpperCase")
            )
        end
        ____L1_setText_843(__L1, "sceneLabel", ____t_result_842)
        local gas = __L1["$"](__L1, "gasFill")
        if __t(gas) then
            gas.style.width = __add(
                __L1.player.gas / __L1:bonus().maxGas * 100,
                "%"
            )
        end
        local hp = __L1["$"](__L1, "hpFill")
        if __t(hp) then
            hp.style.width = __add(
                __L1:clamp(
                    __L1.player.hp / __L1:bonus().maxHP * 100,
                    0,
                    100
                ),
                "%"
            )
        end
        local ____t_result_846
        local ____t_845 = __t
        local ____L1__24_result_844 = __L1["$"](__L1, "gasPercent")
        __O[1749] = ____L1__24_result_844
        if ____t_845(____L1__24_result_844) then
            ____t_result_846 = __O[1749]
        else
            ____t_result_846 = __L1["$"](__L1, "gasValue")
        end
        local gf = ____t_result_846
        if __t(gf) then
            gf.textContent = __add(
                math.floor(__L1.player.gas / __L1:bonus().maxGas * 100),
                "%"
            )
        end
        local title, desc = table.unpack(
            __L1:mission(),
            1,
            2
        )
        __L1:setText("missionTitle", title)
        local ____L1_setText_853 = __L1.setText
        local ____add_852 = __add
        local ____desc_851 = desc
        local ____t_850 = __t
        local ____t_result_849
        local ____t_848 = __t
        local ____t_result_847
        if __t(__L1.q.kaua) then
            ____t_result_847 = __L1.weapon < 2
        else
            ____t_result_847 = __L1.q.kaua
        end
        __O[1750] = ____t_result_847
        if ____t_848(____t_result_847) then
            ____t_result_849 = __L1:materialCount() >= (__L1.weapon == 0 and 3 or 5)
        else
            ____t_result_849 = __O[1750]
        end
        ____L1_setText_853(
            __L1,
            "missionDesc",
            ____add_852(
                ____desc_851,
                ____t_850(____t_result_849) and " Kauã já pode fabricar sua próxima arma na roça!" or ""
            )
        )
        __L1:setText(
            "materialValue",
            __L1:materialCount()
        )
        __L1:setText(
            "weaponValue",
            __add("Nível ", __L1.weapon)
        )
        local ____opt_854 = __L1["$"](__L1, "weaponValue")
        if ____opt_854 ~= nil then
            ____opt_854:setAttribute(
                "title",
                __get(__L1.weaponNames, __L1.weapon)
            )
        end
        local ____L1_show_862 = __L1.show
        local ____t_result_861
        local ____t_860 = __t
        local ____t_858 = __t
        local ____opt_856 = __L1.training
        if ____opt_856 ~= nil then
            ____opt_856 = ____opt_856.active
        end
        local ____temp_859 = not not ____t_858(____opt_856) and not __t(__L1.paused)
        __O[1751] = ____temp_859
        if ____t_860(____temp_859) then
            ____t_result_861 = not __t(__L1.dialog)
        else
            ____t_result_861 = __O[1751]
        end
        ____L1_show_862(__L1, "trainingAction", ____t_result_861)
        local shell = __L1["$"](__L1, "gameShell")
        if __t(shell) then
            local ____self_866 = shell.classList
            local ____self_866_toggle_867 = ____self_866.toggle
            local ____t_865 = __t
            local ____opt_863 = __L1.training
            if ____opt_863 ~= nil then
                ____opt_863 = ____opt_863.active
            end
            ____self_866_toggle_867(
                ____self_866,
                "is-training",
                not not ____t_865(____opt_863) and not __t(__L1.activity)
            )
            shell.classList:toggle("is-paused", __L1.paused)
            shell.classList:toggle(
                "is-dialog",
                not not __t(__L1.dialog)
            )
        end
        __call(
            window.document:querySelectorAll("[data-action=\"taunt\"]"),
            "forEach",
            function(____, el)
                el.hidden = __L1.scene ~= 3
                el:setAttribute("aria-label", "Provocar Nikolas: nariz de batata")
                local ____this_869
                ____this_869 = el
                local ____opt_868 = ____this_869.querySelector
                if ____opt_868 ~= nil then
                    ____opt_868 = ____opt_868(____this_869, "small")
                end
                local label = ____opt_868
                if __t(label) then
                    label.textContent = "BATATA!"
                end
            end
        )
        local hitButton = __L1["$"](__L1, "trainingHitBtn")
        if __t(hitButton) then
            local ____hitButton_setAttribute_873 = hitButton.setAttribute
            local ____t_872 = __t
            local ____opt_870 = __L1.training
            if ____opt_870 ~= nil then
                ____opt_870 = ____opt_870.active
            end
            ____hitButton_setAttribute_873(
                hitButton,
                "aria-label",
                ____t_872(____opt_870) and "Acertar na faixa verde — E ou Espaço" or "Treino indisponível"
            )
        end
        __call(
            window.document:querySelectorAll("[data-scene]"),
            "forEach",
            function(____, el)
                local n = __TS__Number(el.dataset.scene)
                el.classList:toggle("active", n == __L1.scene)
                el.classList:toggle(
                    "locked",
                    not not __t(__L1:routeReason(n))
                )
                el:setAttribute("aria-current", n == __L1.scene and "location" or "false")
            end
        )
        __call(
            window.document:querySelectorAll("[data-action=\"reeis\"]"),
            "forEach",
            function(____, el)
                el.classList:toggle("unlocked", __L1.q.reeis)
                local ____el_876 = el
                local ____t_result_875
                if __t(__L1.q.reeis) then
                    local ____temp_874
                    if __L1.reeisCooldown > 0 then
                        ____temp_874 = ("Reeis recarregando: " .. tostring(math.ceil(__L1.reeisCooldown))) .. "s"
                    else
                        ____temp_874 = "Chamar Reeis (R)"
                    end
                    ____t_result_875 = ____temp_874
                else
                    ____t_result_875 = "Vença Reeis na favela para conquistar sua ajuda"
                end
                ____el_876.title = ____t_result_875
            end
        )
        local ____L1_setText_878 = __L1.setText
        local ____temp_877
        if __L1.dashCooldown > 0 then
            ____temp_877 = __add(
                __call(__L1.dashCooldown, "toFixed", 1),
                "s"
            )
        else
            ____temp_877 = "PRONTO"
        end
        ____L1_setText_878(__L1, "dashValue", ____temp_877)
        __call(
            window.document:querySelectorAll("[data-action=\"dash\"]"),
            "forEach",
            function(____, el)
                el.classList:toggle("cooldown", __L1.dashCooldown > 0)
                local ____el_884 = el
                local ____el_setAttribute_885 = el.setAttribute
                local ____t_result_883
                local ____t_882 = __t
                local ____t_result_881
                local ____t_880 = __t
                local ____temp_879 = __L1.dashCooldown > 0
                __O[1752] = ____temp_879
                if ____t_880(____temp_879) then
                    ____t_result_881 = __O[1752]
                else
                    ____t_result_881 = __L1.vehicle
                end
                __O[1753] = ____t_result_881
                if ____t_882(____t_result_881) then
                    ____t_result_883 = __O[1753]
                else
                    ____t_result_883 = not __t(__L1.q.mota) and not __t(__L1.q.trained)
                end
                ____el_setAttribute_885(
                    ____el_884,
                    "aria-disabled",
                    tostring(____t_result_883)
                )
            end
        )
        if __t(shell) then
            local ____self_888 = shell.classList
            local ____self_888_toggle_889 = ____self_888.toggle
            local ____opt_886 = __L1.cutscene
            if ____opt_886 ~= nil then
                ____opt_886 = ____opt_886.kind
            end
            ____self_888_toggle_889(____self_888, "is-epilogue", ____opt_886 == "jorge_epilogue")
            shell.classList:toggle("is-chapter-ended", __L1.chapterEnded)
            local ____self_893 = shell.classList
            local ____self_893_toggle_894 = ____self_893.toggle
            local ____temp_892 = not not __t(__L1.cutscene)
            if not ____temp_892 then
                local ____opt_890 = __L1.ollyanEncounter
                if ____opt_890 ~= nil then
                    ____opt_890 = ____opt_890.stage
                end
                ____temp_892 = ____opt_890 == "intro"
            end
            ____self_893_toggle_894(____self_893, "is-cutscene", ____temp_892)
            shell.classList:toggle(
                "is-ollyan-flight",
                not not __t(__L1.ollyanEncounter)
            )
            shell.classList:toggle(
                "is-room",
                not not __t(__L1.room)
            )
            shell.classList:toggle(
                "is-arena",
                not not __t(__L1.arena)
            )
        end
        __L1:show("chapterEndScreen", __L1.chapterEnded)
        local ____L1_show_900 = __L1.show
        local ____t_result_899
        local ____t_898 = __t
        local ____temp_897 = not not __t(__L1.cutscene)
        if not ____temp_897 then
            local ____opt_895 = __L1.ollyanEncounter
            if ____opt_895 ~= nil then
                ____opt_895 = ____opt_895.stage
            end
            ____temp_897 = ____opt_895 == "intro"
        end
        __O[1754] = ____temp_897
        if ____t_898(____temp_897) then
            ____t_result_899 = not __t(__L1.paused)
        else
            ____t_result_899 = __O[1754]
        end
        ____L1_show_900(__L1, "cinematicOverlay", ____t_result_899)
        local ____L1_show_904 = __L1.show
        local ____t_result_903
        local ____t_902 = __t
        local ____temp_901 = not not __t(__L1.room) and not __t(__L1.cutscene)
        __O[1755] = ____temp_901
        if ____t_902(____temp_901) then
            ____t_result_903 = not __t(__L1.activity)
        else
            ____t_result_903 = __O[1755]
        end
        ____L1_show_904(__L1, "roomOverlay", ____t_result_903)
        local ____L1_setText_913 = __L1.setText
        local ____t_result_912
        if __t(__L1.room) then
            local ____t_result_911
            local ____t_910 = __t
            local ____opt_907 = window.FavelaCasas
            if ____opt_907 ~= nil then
                ____opt_907 = ____opt_907.ehCasa
            end
            local ____opt_result_909
            if ____opt_907 ~= nil then
                ____opt_result_909 = ____opt_907(____opt_907, __L1.room.id)
            end
            if ____t_910(____opt_result_909) then
                ____t_result_911 = window.FavelaCasas:nome(__L1.room.id)
            else
                ____t_result_911 = __L1.room.id == "almiro" and "Sala do Professor Almiro" or "Sala do Professor Miqueias"
            end
            ____t_result_912 = ____t_result_911
        else
            ____t_result_912 = ""
        end
        ____L1_setText_913(__L1, "roomName", ____t_result_912)
        if __t(__L1.cutscene) then
            local beat = window.Cinematics:beat(__L1.cutscene)
            __L1:setText("cinematicTitle", beat.title)
            __L1:setText("cinematicName", beat.speaker)
            __L1:setText("cinematicText", beat.text)
            __L1:setText(
                "cinematicCounter",
                (tostring(beat.index + 1) .. " / ") .. tostring(beat.total)
            )
        end
        local exit = __L1["$"](__L1, "roomExitBtn")
        if __t(exit) then
            local ____opt_914 = __L1.room
            if ____opt_914 ~= nil then
                ____opt_914 = ____opt_914.phase
            end
            exit.disabled = ____opt_914 ~= "inside"
        end
        local ____opt_916 = __L1.activity
        if ____opt_916 ~= nil then
            ____opt_916 = ____opt_916.kind
        end
        local dinner = ____opt_916 == "dinner"
        local ____L1_show_923 = __L1.show
        local ____t_result_922
        local ____t_921 = __t
        local ____t_result_920
        local ____t_919 = __t
        local ____temp_918 = not not __t(__L1.activity) and not __t(__L1.paused)
        __O[1756] = ____temp_918
        if ____t_919(____temp_918) then
            ____t_result_920 = not __t(__L1.dialog)
        else
            ____t_result_920 = __O[1756]
        end
        __O[1757] = ____t_result_920
        if ____t_921(____t_result_920) then
            ____t_result_922 = not __t(__L1.cutscene)
        else
            ____t_result_922 = __O[1757]
        end
        ____L1_show_923(__L1, "activityOverlay", ____t_result_922)
        if shell ~= nil then
            shell.classList:toggle(
                "is-activity",
                not not __t(__L1.activity)
            )
        end
        if shell ~= nil then
            shell.classList:toggle("is-dinner", dinner)
        end
        local ____L1_show_929 = __L1.show
        local ____t_result_928
        if __t(dinner) then
            ____t_result_928 = __L1.activity.phase == "breath"
        else
            ____t_result_928 = dinner
        end
        ____L1_show_929(__L1, "dinnerBreath", ____t_result_928)
        __L1:show("dinnerSpeaker", dinner)
        if __t(__L1.activity) then
            local view = window.Activities:view(__L1.activity)
            if __t(dinner) then
                __L1:setText("dinnerSpeaker", view.speaker)
                __L1["$"](__L1, "activityOverlay").dataset.phase = __L1.activity.phase
            end
            __L1:setText("activityTitle", view.title)
            __L1:setText("activityText", view.text)
            local ____L1_setText_931 = __L1.setText
            local ____view_scoreLabel_930 = view.scoreLabel
            if ____view_scoreLabel_930 == nil then
                ____view_scoreLabel_930 = __L1.activity.score
            end
            ____L1_setText_931(__L1, "activityScore", ____view_scoreLabel_930)
            local ____L1_setText_933 = __L1.setText
            local ____t_result_932
            if __t(view.actionLabel) then
                ____t_result_932 = view.actionLabel
            else
                ____t_result_932 = "CHUTAR"
            end
            ____L1_setText_933(__L1, "activityMainBtn", ____t_result_932)
            __L1:setText(
                "activityExitBtn",
                __t(dinner) and "Voltar à praça" or "Sair do desafio"
            )
            __L1:show(
                "activityMainBtn",
                not __t(__lenq(view.choices))
            )
            local ____L1_show_941 = __L1.show
            local ____t_940 = __t
            local ____t_result_939
            local ____t_935 = __t
            local ____t_result_934
            if __t(dinner) then
                ____t_result_934 = __L1.activity.phase == "outcome"
            else
                ____t_result_934 = dinner
            end
            __O[1759] = ____t_result_934
            if ____t_935(____t_result_934) then
                local ____t_result_938
                local ____t_937 = __t
                local ____lt_result_936 = __lt(__L1.activity.score, 2)
                __O[1758] = ____lt_result_936
                if ____t_937(____lt_result_936) then
                    ____t_result_938 = __O[1758]
                else
                    ____t_result_938 = __L1.activity.options.dating
                end
                ____t_result_939 = ____t_result_938
            else
                ____t_result_939 = __O[1759]
            end
            ____L1_show_941(
                __L1,
                "activityExitBtn",
                not ____t_940(____t_result_939)
            )
            do
                local i = 0
                while i < 3 do
                    do
                        local button = __L1["$"](
                            __L1,
                            __add("activityChoice", i)
                        )
                        local choice = __getq(view.choices, i)
                        if not __t(button) then
                            do i = i + 1 continue end
                        end
                        button.hidden = not __t(choice)
                        if __t(choice) then
                            local ____L1_setText_944 = __L1.setText
                            local ____button_id_943 = button.id
                            local ____choice_label_942 = choice.label
                            if ____choice_label_942 == nil then
                                ____choice_label_942 = tostring(choice)
                            end
                            ____L1_setText_944(__L1, ____button_id_943, ____choice_label_942)
                            local ____button_dataset_946 = button.dataset
                            local ____choice_value_945 = choice.value
                            if ____choice_value_945 == nil then
                                ____choice_value_945 = i
                            end
                            ____button_dataset_946.value = tostring(____choice_value_945)
                        end
                    end
                    i = i + 1
                end
            end
        end
        local p = __L1["$"](__L1, "pauseBtn")
        if __t(p) then
            p:setAttribute(
                "aria-label",
                __t(__L1.paused) and "Continuar jogo" or "Pausar jogo"
            )
        end
        local nearby = __L1:closestBoss()
        __call(
            window.document:querySelectorAll("[data-action=\"interact\"]"),
            "forEach",
            function(____, el)
                local ____this_948
                ____this_948 = el
                local ____opt_947 = ____this_948.querySelector
                if ____opt_947 ~= nil then
                    ____opt_947 = ____opt_947(____this_948, "small")
                end
                local label = ____opt_947
                if __t(label) then
                    local ____t_result_953
                    if __t(__L1.ollyanEncounter) then
                        ____t_result_953 = __L1.ollyanEncounter.stage == "intro" and "AVANÇAR" or "RECUAR"
                    else
                        local ____t_result_952
                        local ____t_950 = __t
                        local ____t_result_949
                        if __t(__L1.arena) then
                            ____t_result_949 = __le(
                                __L1.player.x,
                                __get(__L1.arena.bounds, 0) + 78
                            )
                        else
                            ____t_result_949 = __L1.arena
                        end
                        if ____t_950(____t_result_949) then
                            ____t_result_952 = "RECUAR"
                        else
                            local ____t_result_951
                            if __t(nearby) then
                                ____t_result_951 = __t(__L1:bossAccess(nearby).ok) and "DESAFIAR" or "MISSÕES"
                            else
                                ____t_result_951 = "FALAR"
                            end
                            ____t_result_952 = ____t_result_951
                        end
                        ____t_result_953 = ____t_result_952
                    end
                    label.textContent = ____t_result_953
                end
            end
        )
    end
    __L1.populate = function(self)
        __L1:resetWorldSize()
        __L1.shots = __arrL({}, 0)
        __L1.particles = __arrL({}, 0)
        __L1.damageTexts = __arrL({}, 0)
        __L1.enemies = __arrL({}, 0)
        __L1.pickups = __arrL({}, 0)
        __L1.targets = __arrL({}, 0)
        __L1.hazards = __arrL({}, 0)
        __L1.activeBoss = nil
        __L1.minions = __arrL({}, 0)
        __L1.arena = nil
        __L1.marcoTrapTriggered = false
        do
            local i = 0
            while i < math.ceil(__L1.WORLD / 300) do
                __call(
                    __L1.pickups,
                    "push",
                    {
                        x = 620 + i * 280,
                        y = __L1.FLOOR - 24 - (__mod(i, 3) == 1 and 105 or 0),
                        type = __mod(i, 3) == 0 and "gas" or "paper",
                        taken = false,
                        t = i
                    }
                )
                i = i + 1
            end
        end
        local ____t_957 = __t
        local ____t_result_956
        local ____t_955 = __t
        local ____temp_954 = __L1.scene == 0 or __L1.scene == 1
        __O[1760] = ____temp_954
        if ____t_955(____temp_954) then
            ____t_result_956 = __O[1760]
        else
            ____t_result_956 = __L1.scene == 4
        end
        if ____t_957(____t_result_956) then
            local ____temp_959
            if __L1.scene == 0 then
                ____temp_959 = __arrL({
                    590,
                    645,
                    700,
                    850,
                    900,
                    950,
                    1080,
                    1135
                }, 8)
            else
                local ____temp_958
                if __L1.scene == 1 then
                    ____temp_958 = __arrL({
                        530,
                        590,
                        650,
                        710,
                        780,
                        1040,
                        1120,
                        1200,
                        1510,
                        1620
                    }, 10)
                else
                    ____temp_958 = __arrL({
                        580,
                        740,
                        980,
                        1450,
                        1830,
                        2460
                    }, 6)
                end
                ____temp_959 = ____temp_958
            end
            local places = ____temp_959
            __call(
                places,
                "forEach",
                function(____, x, i)
                    local id = (tostring(__L1.scene) .. "-material-") .. tostring(i)
                    __call(
                        __L1.pickups,
                        "push",
                        {
                            x = x,
                            y = __L1.FLOOR - 24,
                            type = __get(
                                __arrL({"pencil", "eraser", "clip"}, 3),
                                __mod(i, 3)
                            ),
                            id = id,
                            taken = __call(__L1.collected, "includes", id),
                            t = i
                        }
                    )
                end
            )
        end
        local specs = __arrL(
            {
                __arrL({"igor", 1, 1810, 850}, 4),
                __arrL({"kaique", 1, 3000, 1100}, 4),
                __arrL({"marco", 1, 3700, 1100}, 4),
                __arrL({"menezes", 1, 5200, 760}, 4),
                __arrL({"nikolas", 3, 4300, 1400}, 4),
                __arrL({"reeisBoss", 5, 6300, 850}, 4),
                __arrL({"giant", 6, 5500, 1200}, 4),
                __arrL({"freddy", 5, 5680, 520}, 4),
                __arrL({"nicolas", 4, 5350, 1050}, 4),
                __arrL({"dede", 5, 5000, 430}, 4),
                __arrL({"arthur", 9, 2850, 650}, 4)
            },
            11
        )
        for ____, ____value in __iterar((specs)) do
            local ____type = ____value[1]
            local where = ____value[2]
            local x = ____value[3]
            local hp = ____value[4]
            local flag = ____type == "reeisBoss" and "reeis" or ____type
            if __t(__L1.scene == where and not __t(__get(__L1.q, flag))) then
                local ____t_result_966
                local ____t_965 = __t
                local ____opt_962 = window.Difficulty
                if ____opt_962 ~= nil then
                    ____opt_962 = ____opt_962:boss(____type)
                end
                local ____opt_result_964
                if ____opt_962 ~= nil then
                    ____opt_result_964 = ____opt_962.hp
                end
                __O[1761] = ____opt_result_964
                if ____t_965(____opt_result_964) then
                    ____t_result_966 = __O[1761]
                else
                    ____t_result_966 = hp
                end
                local max = ____t_result_966
                __call(
                    __L1.enemies,
                    "push",
                    {
                        type = ____type,
                        x = __L1:bossHome(____type, x),
                        y = __L1.FLOOR,
                        hp = max,
                        max = max,
                        t = 1,
                        charge = 0,
                        hit = 0,
                        angry = 0,
                        rage = false,
                        drawCount = 0
                    }
                )
            end
        end
        local ____call_979 = __call
        local ____call_971 = __call
        local ____t_result_970
        local ____t_969 = __t
        local ____opt_967 = window.WorldData
        if ____opt_967 ~= nil then
            ____opt_967 = ____opt_967.minions
        end
        __O[1762] = ____opt_967
        if ____t_969(____opt_967) then
            ____t_result_970 = __O[1762]
        else
            ____t_result_970 = __arrL({}, 0)
        end
        __L1.minions = ____call_979(
            ____call_971(
                ____t_result_970,
                "filter",
                function(____, m) return m.scene == __L1.scene end
            ),
            "map",
            function(____, m)
                local ____assign_978 = __assign
                local ____temp_976 = {}
                local ____m_977 = m
                local ____m_x_973 = m.x
                local ____m_hp_974 = m.hp
                local ____call_result_975 = __call(__L1.minionKills, "includes", m.id)
                local ____t_result_972
                if __t(m.kind) then
                    ____t_result_972 = m.kind
                else
                    ____t_result_972 = 0
                end
                return ____assign_978(____temp_976, ____m_977, {
                    homeX = ____m_x_973,
                    max = ____m_hp_974,
                    dead = ____call_result_975,
                    hit = 0,
                    t = 0.8 + ____t_result_972 * 0.4,
                    vy = 0,
                    dir = 1
                })
            end
        )
        if __t(__L1.scene == 5 and not __t(__len(__L1.minions))) then
            do
                local i = 0
                while i < 20 do
                    local tier = 1 + math.floor(i / 5)
                    local id = __add("favela-thug-", i)
                    __call(
                        __L1.minions,
                        "push",
                        {
                            id = id,
                            scene = __L1.scene,
                            x = 900 + i * 245,
                            homeX = 900 + i * 245,
                            y = __L1.FLOOR,
                            kind = "thug",
                            tier = tier,
                            weapon = __get(
                                __arrL({"pistol", "shotgun", "rifle", "launcher"}, 4),
                                tier - 1
                            ),
                            hp = 35 + tier * 20,
                            max = 35 + tier * 20,
                            damage = 7 + tier * 3,
                            range = 75,
                            dead = __call(__L1.minionKills, "includes", id),
                            hit = 0,
                            t = 1 + __mod(i, 3) * 0.3,
                            vy = 0,
                            dir = 1
                        }
                    )
                    i = i + 1
                end
            end
        end
        local ____iter_984 = __iter
        local ____t_result_983
        local ____t_982 = __t
        local ____opt_980 = window.WorldData
        if ____opt_980 ~= nil then
            ____opt_980 = ____opt_980.collectibles
        end
        __O[1763] = ____opt_980
        if ____t_982(____opt_980) then
            ____t_result_983 = __O[1763]
        else
            ____t_result_983 = __arrL({}, 0)
        end
        for ____, p in __TS__Iterator(____iter_984(____t_result_983)) do
            if __t(p.scene == __L1.scene and not __t(__call(
                __arrL({"repair", "notebook"}, 2),
                "includes",
                p.type
            ))) then
                __call(
                    __L1.pickups,
                    "push",
                    __assign({}, p, {t = 0, taken = false})
                )
            end
        end
        local ____t_result_994
        local ____t_993 = __t
        local ____t_result_992
        local ____t_989 = __t
        local ____callq_987 = __callq
        local ____opt_985 = window.WorldData
        if ____opt_985 ~= nil then
            ____opt_985 = ____opt_985.questPickups
        end
        local ____callq_987_result_988 = ____callq_987(
            ____opt_985,
            "filter",
            function(____, p) return p.type == "carPart" end
        )
        __O[1764] = ____callq_987_result_988
        if ____t_989(____callq_987_result_988) then
            ____t_result_992 = __O[1764]
        else
            local ____opt_990 = window.WorldData
            if ____opt_990 ~= nil then
                ____opt_990 = ____opt_990.repairParts
            end
            ____t_result_992 = ____opt_990
        end
        __O[1765] = ____t_result_992
        if ____t_993(____t_result_992) then
            ____t_result_994 = __O[1765]
        else
            ____t_result_994 = __arrL({{id = "motor", scene = 0, x = 1300, y = 300}, {id = "ventoinha", scene = 0, x = 2500, y = 280}, {id = "cilindro", scene = 0, x = 4200, y = 285}}, 3)
        end
        local repair = ____t_result_994
        for ____, p in __iterar((repair)) do
            local ____p_scene_995 = p.scene
            if ____p_scene_995 == nil then
                ____p_scene_995 = 0
            end
            if ____p_scene_995 == __L1.scene then
                local ____call_1000 = __call
                local ____L1_pickups_999 = __L1.pickups
                local ____assign_998 = __assign
                local ____temp_997 = {}
                local ____t_result_996
                if __t(__L1.q.lucas) then
                    ____t_result_996 = __L1.q.lucas
                else
                    ____t_result_996 = __call(__L1.q.carParts, "includes", p.id)
                end
                ____call_1000(
                    ____L1_pickups_999,
                    "push",
                    ____assign_998(____temp_997, p, {type = "repair", t = 0, taken = ____t_result_996})
                )
            end
        end
        local ____t_result_1010
        local ____t_1009 = __t
        local ____t_result_1008
        local ____t_1005 = __t
        local ____callq_1003 = __callq
        local ____opt_1001 = window.WorldData
        if ____opt_1001 ~= nil then
            ____opt_1001 = ____opt_1001.questPickups
        end
        local ____callq_1003_result_1004 = ____callq_1003(
            ____opt_1001,
            "filter",
            function(____, p) return p.type == "notebook" end
        )
        __O[1766] = ____callq_1003_result_1004
        if ____t_1005(____callq_1003_result_1004) then
            ____t_result_1008 = __O[1766]
        else
            local ____opt_1006 = window.WorldData
            if ____opt_1006 ~= nil then
                ____opt_1006 = ____opt_1006.notebooks
            end
            ____t_result_1008 = ____opt_1006
        end
        __O[1767] = ____t_result_1008
        if ____t_1009(____t_result_1008) then
            ____t_result_1010 = __O[1767]
        else
            ____t_result_1010 = __arrL({{id = "caderno-1", scene = 1, x = 1600, y = 355}, {id = "caderno-2", scene = 1, x = 2100, y = 350}, {id = "caderno-3", scene = 1, x = 2900, y = 235}}, 3)
        end
        local books = ____t_result_1010
        for ____, p in __iterar((books)) do
            local ____p_scene_1011 = p.scene
            if ____p_scene_1011 == nil then
                ____p_scene_1011 = 1
            end
            if ____p_scene_1011 == __L1.scene then
                local ____call_1016 = __call
                local ____L1_pickups_1015 = __L1.pickups
                local ____assign_1014 = __assign
                local ____temp_1013 = {}
                local ____t_result_1012
                if __t(__L1.q.almiro) then
                    ____t_result_1012 = __L1.q.almiro
                else
                    ____t_result_1012 = __call(__L1.q.notebooks, "includes", p.id)
                end
                ____call_1016(
                    ____L1_pickups_1015,
                    "push",
                    ____assign_1014(____temp_1013, p, {type = "notebook", t = 1, taken = ____t_result_1012})
                )
            end
        end
        __call(__L1.enemies, "forEach", __L1.bossDefaults)
    end
    __L1.emitGameEvent = function(self, name, detail)
        __L1:safe(function() return window:dispatchEvent(__new("CustomEvent", name, {detail = detail})) end)
    end
    __L1.requestRoutePicker = function(self, reason)
        if reason == nil then
            reason = "car"
        end
        local ____t_1032 = __t
        local ____t_result_1031
        local ____t_1030 = __t
        local ____t_result_1029
        local ____t_1028 = __t
        local ____t_result_1027
        local ____t_1026 = __t
        local ____t_result_1025
        local ____t_1024 = __t
        local ____t_result_1023
        local ____t_1022 = __t
        local ____t_result_1021
        local ____t_1020 = __t
        local ____t_result_1019
        local ____t_1018 = __t
        local ____temp_1017 = not __t(__L1.vehicle)
        __O[1768] = ____temp_1017
        if ____t_1018(____temp_1017) then
            ____t_result_1019 = __O[1768]
        else
            ____t_result_1019 = __L1.activeBoss
        end
        __O[1769] = ____t_result_1019
        if ____t_1020(____t_result_1019) then
            ____t_result_1021 = __O[1769]
        else
            ____t_result_1021 = __L1.arena
        end
        __O[1770] = ____t_result_1021
        if ____t_1022(____t_result_1021) then
            ____t_result_1023 = __O[1770]
        else
            ____t_result_1023 = __L1.room
        end
        __O[1771] = ____t_result_1023
        if ____t_1024(____t_result_1023) then
            ____t_result_1025 = __O[1771]
        else
            ____t_result_1025 = __L1.cutscene
        end
        __O[1772] = ____t_result_1025
        if ____t_1026(____t_result_1025) then
            ____t_result_1027 = __O[1772]
        else
            ____t_result_1027 = __L1.routeTransition
        end
        __O[1773] = ____t_result_1027
        if ____t_1028(____t_result_1027) then
            ____t_result_1029 = __O[1773]
        else
            ____t_result_1029 = __L1.defeated
        end
        __O[1774] = ____t_result_1029
        if ____t_1030(____t_result_1029) then
            ____t_result_1031 = __O[1774]
        else
            ____t_result_1031 = __L1.ollyanEncounter
        end
        if ____t_1032(____t_result_1031) then
            return false
        end
        __L1:releaseInputs()
        __L1:emitGameEvent("car-route-request", {scene = __L1.scene, reason = reason})
        return true
    end
    __L1.travel = function(self, n)
        n = __TS__Number(n)
        local ____t_1043 = __t
        local ____t_result_1042
        local ____t_1034 = __t
        local ____temp_1033 = not __isInteger(n) or __lt(n, 0)
        __O[1775] = ____temp_1033
        if ____t_1034(____temp_1033) then
            ____t_result_1042 = __O[1775]
        else
            local ____ge_result_1041 = __ge(
                n,
                __len(__L1.scenes)
            )
            if ____ge_result_1041 then
                local ____t_1040 = __t
                local ____opt_1037 = window.LugaresC1
                if ____opt_1037 ~= nil then
                    ____opt_1037 = ____opt_1037.tem
                end
                local ____opt_result_1039
                if ____opt_1037 ~= nil then
                    ____opt_result_1039 = ____opt_1037(____opt_1037, n)
                end
                ____ge_result_1041 = not ____t_1040(____opt_result_1039)
            end
            ____t_result_1042 = ____ge_result_1041
        end
        if ____t_1043(____t_result_1042) then
            return false
        end
        __L1:releaseInputs()
        if not __t(__L1.started) then
            __L1:toast("Comece a aventura para explorar o mapa.")
            return false
        end
        local ____t_1061 = __t
        local ____t_result_1060
        local ____t_1059 = __t
        local ____t_result_1058
        local ____t_1057 = __t
        local ____t_result_1056
        local ____t_1055 = __t
        local ____t_result_1054
        local ____t_1053 = __t
        local ____t_result_1052
        local ____t_1051 = __t
        local ____t_result_1050
        local ____t_1049 = __t
        local ____t_result_1048
        local ____t_1047 = __t
        local ____t_result_1046
        local ____t_1045 = __t
        local ____t_result_1044
        if __t(__L1.paused) then
            ____t_result_1044 = __L1.paused
        else
            ____t_result_1044 = __L1.won
        end
        __O[1776] = ____t_result_1044
        if ____t_1045(____t_result_1044) then
            ____t_result_1046 = __O[1776]
        else
            ____t_result_1046 = __L1.chapterEnded
        end
        __O[1777] = ____t_result_1046
        if ____t_1047(____t_result_1046) then
            ____t_result_1048 = __O[1777]
        else
            ____t_result_1048 = __L1.defeated
        end
        __O[1778] = ____t_result_1048
        if ____t_1049(____t_result_1048) then
            ____t_result_1050 = __O[1778]
        else
            ____t_result_1050 = __L1.room
        end
        __O[1779] = ____t_result_1050
        if ____t_1051(____t_result_1050) then
            ____t_result_1052 = __O[1779]
        else
            ____t_result_1052 = __L1.arena
        end
        __O[1780] = ____t_result_1052
        if ____t_1053(____t_result_1052) then
            ____t_result_1054 = __O[1780]
        else
            ____t_result_1054 = __L1.cutscene
        end
        __O[1781] = ____t_result_1054
        if ____t_1055(____t_result_1054) then
            ____t_result_1056 = __O[1781]
        else
            ____t_result_1056 = __L1.activity
        end
        __O[1782] = ____t_result_1056
        if ____t_1057(____t_result_1056) then
            ____t_result_1058 = __O[1782]
        else
            ____t_result_1058 = __L1.routeTransition
        end
        __O[1783] = ____t_result_1058
        if ____t_1059(____t_result_1058) then
            ____t_result_1060 = __O[1783]
        else
            ____t_result_1060 = __L1.ollyanEncounter
        end
        if ____t_1061(____t_result_1060) then
            __L1:toast("Aguarde a chegada ou retome a aventura.")
            return false
        end
        if __t(__L1.activity) then
            __L1:toast("Termine o minigame ou use SAIR antes de viajar.")
            return false
        end
        local ____t_1064 = __t
        local ____opt_1062 = __L1.training
        if ____opt_1062 ~= nil then
            ____opt_1062 = ____opt_1062.active
        end
        if ____t_1064(____opt_1062) then
            __L1:toast("Termine o treino ou use SAIR DO TREINO antes de viajar.")
            return false
        end
        if __t(__L1.dialog) then
            __L1:toast("Termine a conversa antes de viajar.")
            return false
        end
        if __t(__L1.activeBoss) then
            __L1:toast("O chefe está na sua cola! Termine a luta ou recue antes de viajar.")
            return false
        end
        if not __t(__L1.q.lucas) then
            __L1:toast("Fale com Lucas para recuperar as chaves do carro a gás do seu pai.")
            return false
        end
        if not __t(__L1.vehicle) then
            __L1:toast("Entre no carro a gás com V para escolher uma rota.")
            return false
        end
        local blocked = __L1:routeReason(n)
        if __t(blocked) then
            __L1:toast(blocked)
            __L1:beep(120, 0.15)
            return false
        end
        if n == __L1.scene then
            __L1:toast("Você já está aqui. Dirija e explore à direita!")
            return false
        end
        if __t(window.ChegadaCarro) then
            __L1.shots = __arrL({}, 0)
            __L1.hazards = __arrL({}, 0)
            __L1.reeisPhase = "idle"
            __L1.reeisTimer = 0
            __L1:beep(160, 0.25, "sawtooth")
            local ____L1_scene_1069 = __L1.scene
            local ____n_1070 = n
            local ____t_result_1068
            local ____t_1067 = __t
            local ____opt_1065 = window.EstradaViagem
            if ____opt_1065 ~= nil then
                ____opt_1065 = ____opt_1065.duracao
            end
            __O[1784] = ____opt_1065
            if ____t_1067(____opt_1065) then
                ____t_result_1068 = __O[1784]
            else
                ____t_result_1068 = 0.01
            end
            __L1.routeTransition = {
                from = ____L1_scene_1069,
                to = ____n_1070,
                t = 0,
                duration = ____t_result_1068,
                estrada = true
            }
            return true
        end
        __L1.routeTransition = {from = __L1.scene, to = n, t = 0, duration = 1.2}
        __L1.shots = __arrL({}, 0)
        __L1.hazards = __arrL({}, 0)
        __L1.reeisPhase = "idle"
        __L1.reeisTimer = 0
        __L1:beep(160, 0.25, "sawtooth")
        return true
    end
    __L1.routeReason = function(self, n)
        local ____t_1073 = __t
        local ____opt_1071 = window.Campaign
        if ____opt_1071 ~= nil then
            ____opt_1071 = ____opt_1071.canTravel
        end
        if ____t_1073(____opt_1071) then
            local g = window.Campaign:canTravel(n, __L1.q)
            local ____t_1075 = __t
            local ____t_result_1074
            if __t(g) then
                ____t_result_1074 = g.ok == false
            else
                ____t_result_1074 = g
            end
            if ____t_1075(____t_result_1074) then
                return g.reason
            end
        end
        local ____t_1081 = __t
        local ____temp_1080 = n == 5
        if ____temp_1080 then
            local ____t_1079 = __t
            local ____t_result_1078
            local ____t_1077 = __t
            local ____t_result_1076
            if __t(__L1.q.mota) then
                ____t_result_1076 = __L1.q.almiro
            else
                ____t_result_1076 = __L1.q.mota
            end
            __O[1785] = ____t_result_1076
            if ____t_1077(____t_result_1076) then
                ____t_result_1078 = __L1.q.miqueias
            else
                ____t_result_1078 = __O[1785]
            end
            ____temp_1080 = not ____t_1079(____t_result_1078)
        end
        if ____t_1081(____temp_1080) then
            return "Complete o futebol do Mota e as missões dos dois professores antes de subir à favela."
        end
        if __t(n == 6 and not __t(__L1.q.marco)) then
            return "Vença Marco na escola para abrir o Caderno do Caos."
        end
        if __t(n == 2 and not __t(__L1.q.menezes)) then
            return "Vença Menezes no fim da escola antes do treino com Caleb."
        end
        local ____t_1087 = __t
        local ____temp_1086 = n == 3
        if ____temp_1086 then
            local ____t_1085 = __t
            local ____t_result_1084
            local ____t_1083 = __t
            local ____t_result_1082
            if __t(__L1.q.trained) then
                ____t_result_1082 = __L1.q.giant
            else
                ____t_result_1082 = __L1.q.trained
            end
            __O[1786] = ____t_result_1082
            if ____t_1083(____t_result_1082) then
                ____t_result_1084 = __L1.q.menezes
            else
                ____t_result_1084 = __O[1786]
            end
            ____temp_1086 = not ____t_1085(____t_result_1084)
        end
        if ____t_1087(____temp_1086) then
            return "Vença o gigante, Menezes e complete o treino do Caleb antes do final."
        end
        return ""
    end
    __L1.arrive = function(self, n)
        local ____opt_1090 = window.CampaignVfx
        if ____opt_1090 ~= nil then
            ____opt_1090 = ____opt_1090.reset
        end
        if ____opt_1090 ~= nil then
            ____opt_1090(____opt_1090)
        end
        __L1.room = nil
        __L1.arena = nil
        __L1.lastSafeX = 230
        __L1.scene = n
        __L1:resetWorldSize()
        __L1.player.x = 230
        __L1.player.y = __L1.FLOOR
        __L1.player.vx = 0
        __L1.player.vy = 0
        __L1.player.ground = true
        __L1.player.hp = math.min(
            __L1:bonus().maxHP,
            __L1.player.hp + 18
        )
        __L1.player.gas = __L1:bonus().maxGas
        __L1.vehicle = true
        __L1.camera = 0
        __L1.activeBoss = nil
        __L1.reeisTimer = 0
        __L1.reeisPhase = "idle"
        __L1.transition = 0.45
        __L1.routeEdgeCooldown = 2
        __L1:populate()
        __L1:updateUI()
        __L1:save()
        local ____L1_toast_1102 = __L1.toast
        local ____t_result_1101
        local ____t_1100 = __t
        local ____t_result_1099
        local ____t_1093 = __t
        local ____get_result_1092 = __get(__L1.scenes, n)
        __O[1787] = ____get_result_1092
        if ____t_1093(____get_result_1092) then
            ____t_result_1099 = __O[1787]
        else
            local ____opt_1096 = window.LugaresC1
            if ____opt_1096 ~= nil then
                ____opt_1096 = ____opt_1096.nome
            end
            local ____opt_result_1098
            if ____opt_1096 ~= nil then
                ____opt_result_1098 = ____opt_1096(____opt_1096, n)
            end
            ____t_result_1099 = ____opt_result_1098
        end
        __O[1788] = ____t_result_1099
        if ____t_1100(____t_result_1099) then
            ____t_result_1101 = __O[1788]
        else
            ____t_result_1101 = "Itabuna"
        end
        ____L1_toast_1102(
            __L1,
            ("Chegou: " .. tostring(____t_result_1101)) .. ". V estaciona o carro a gás. E conversa."
        )
        local ____opt_1105 = window.Roteiro
        if ____opt_1105 ~= nil then
            ____opt_1105 = ____opt_1105.chegada
        end
        local ____opt_result_1107
        if ____opt_1105 ~= nil then
            ____opt_result_1107 = ____opt_1105(____opt_1105, n, __L1.q)
        end
        local arrival = ____opt_result_1107
        local ____t_1109 = __t
        local ____t_result_1108
        if __t(arrival) then
            ____t_result_1108 = not __t(__L1.sandbox)
        else
            ____t_result_1108 = arrival
        end
        if ____t_1109(____t_result_1108) then
            window.Roteiro:visto(arrival, __L1.q)
            __L1:save()
            local function tocar()
                return __L1:playCutscene(arrival)
            end
            local ____t_1115 = __t
            local ____opt_1112 = window.ChegadaCarro
            if ____opt_1112 ~= nil then
                ____opt_1112 = ____opt_1112.ativa
            end
            local ____opt_result_1114
            if ____opt_1112 ~= nil then
                ____opt_result_1114 = ____opt_1112(____opt_1112)
            end
            if ____t_1115(____opt_result_1114) then
                window.ChegadaCarro:depois(tocar)
            else
                tocar(nil)
            end
        end
    end
    __L1.say = function(self, lines, done)
        local pages = __arrL({}, 0)
        for ____, raw in __iterar((lines)) do
            local ____temp_1116
            if type(raw) == "string" then
                ____temp_1116 = {name = "Da Roça", text = raw}
            else
                ____temp_1116 = raw
            end
            local line = ____temp_1116
            local ____re_split_1119 = __re_split
            local ____call_1118 = __call
            local ____t_result_1117
            if __t(line.text) then
                ____t_result_1117 = line.text
            else
                ____t_result_1117 = ""
            end
            local words = ____re_split_1119(
                ____call_1118(
                    tostring(____t_result_1117),
                    "trim"
                ),
                __re("\\s+", "")
            )
            local chunk = ""
            local chunks = __arrL({}, 0)
            for ____, word in __iterar((words)) do
                local ____t_1121 = __t
                local ____t_result_1120
                if __t(chunk) then
                    ____t_result_1120 = __len(chunk) + __len(word) + 1 > 108
                else
                    ____t_result_1120 = chunk
                end
                if ____t_1121(____t_result_1120) then
                    __call(chunks, "push", chunk)
                    chunk = word
                else
                    chunk = __add(
                        chunk,
                        __add(
                            __t(chunk) and " " or "",
                            word
                        )
                    )
                end
            end
            local ____t_1123 = __t
            local ____t_result_1122
            if __t(chunk) then
                ____t_result_1122 = chunk
            else
                ____t_result_1122 = not __t(__len(chunks))
            end
            if ____t_1123(____t_result_1122) then
                __call(chunks, "push", chunk)
            end
            __call(
                chunks,
                "forEach",
                function(____, text, i)
                    local page = __assign({}, line, {text = text})
                    if i ~= __len(chunks) - 1 then
                        __TS__Delete(page, "actionLabel")
                    end
                    __call(pages, "push", page)
                end
            )
        end
        if not __t(__len(pages)) then
            return false
        end
        __L1.dialog = {
            lines = pages,
            index = 0,
            completionRequired = not not __t(__L1.won)
        }
        local ____temp_1124
        if type(done) == "function" then
            ____temp_1124 = done
        else
            ____temp_1124 = nil
        end
        __L1.dialogCallback = ____temp_1124
        __L1:releaseInputs()
        __L1:show("dialogBox", true)
        __L1:show(
            "dialogControls",
            not __t(__L1.paused) and not __t(__L1.cutscene)
        )
        __L1:renderDialog()
        __L1:updateUI()
        return true
    end
    __L1.renderDialog = function(self)
        if not __t(__L1.dialog) then
            return
        end
        local line = __get(__L1.dialog.lines, __L1.dialog.index)
        __L1:setText("dialogName", line.name)
        __L1:setText("dialogText", line.text)
        local ____L1_setText_1126 = __L1.setText
        local ____t_result_1125
        if __t(line.actionLabel) then
            ____t_result_1125 = line.actionLabel
        else
            ____t_result_1125 = __L1.dialog.index == __len(__L1.dialog.lines) - 1 and "Concluir  ↵" or "Próximo  ↵"
        end
        ____L1_setText_1126(__L1, "dialogNext", ____t_result_1125)
        __L1:setText(
            "dialogClose",
            __t(__L1.dialog.completionRequired) and "Pular fala · Esc" or "Fechar · Esc"
        )
        __L1:emitGameEvent(
            "dialogue-update",
            __L1:getDialogueAnchor()
        )
    end
    __L1.closeDialogue = function(self, completed)
        if completed == nil then
            completed = false
        end
        if not __t(__L1.dialog) then
            return false
        end
        local ____t_result_1127
        if __t(completed) then
            ____t_result_1127 = completed
        else
            ____t_result_1127 = __L1.dialog.completionRequired
        end
        local finish = ____t_result_1127
        local ____t_result_1128
        if __t(finish) then
            ____t_result_1128 = __L1.dialogCallback
        else
            ____t_result_1128 = nil
        end
        local callback = ____t_result_1128
        __L1.dialog = nil
        __L1.dialogCallback = nil
        __L1.dialogueReopenUntil = window.performance:now() + 300
        __L1:releaseInputs()
        __L1:show("dialogBox", false)
        __L1:show("dialogControls", false)
        if __t(__L1.paused) then
            __L1.paused = false
            __L1:show("pauseScreen", false)
        end
        __L1:updateUI()
        __L1:safe(function() return __L1.canvas:focus({preventScroll = true}) end)
        __L1:emitGameEvent(
            "dialogue-closed",
            {
                completed = not not __t(finish),
                cancelled = not __t(finish)
            }
        )
        do
            local function ____catch(____error)
                print("Dialogue action failed:", ____error)
                __L1:toast("Conversa encerrada. Você pode falar com o personagem novamente.")
            end
            local ____try, ____hasReturned = pcall(function()
                if __t(callback) then
                    callback(nil)
                end
            end)
            local ____rethrow
            if not ____try then
                ____try, ____rethrow = pcall(function()
                    ____catch(____hasReturned)
                end)
            end
            do
                __L1:updateUI()
                __L1:save()
            end
            if not ____try then
                error(____rethrow, 0)
            end
        end
        return true
    end
    __L1.nextDialog = function(self)
        if not __t(__L1.dialog) then
            return false
        end
        if __t(__L1.paused) then
            __L1:resume()
            return true
        end
        __L1:beep(560, 0.035, "triangle", 0.012)
        local ____ge_1132 = __ge
        local ____L1_dialog_1129, ____index_1130 = __L1.dialog, "index"
        local ____L1_dialog_index_1131 = ____L1_dialog_1129[____index_1130] + 1
        ____L1_dialog_1129[____index_1130] = ____L1_dialog_index_1131
        if ____ge_1132(
            ____L1_dialog_index_1131,
            __len(__L1.dialog.lines)
        ) then
            return __L1:closeDialogue(true)
        end
        __L1:renderDialog()
        return true
    end
    __L1.getDialogueView = function(self)
        local ____temp_1134 = not not __t(__L1.dialog)
        local ____L1_paused_1135 = __L1.paused
        local ____t_result_1133
        if __t(__L1.cutscene) then
            ____t_result_1133 = __assign({}, __L1.cutscene)
        else
            ____t_result_1133 = nil
        end
        return {dialog = ____temp_1134, paused = ____L1_paused_1135, cutscene = ____t_result_1133}
    end
    __L1.visitTalk = function(self, id)
        local ____t_1139 = __t
        local ____t_result_1138
        local ____t_1137 = __t
        local ____temp_1136 = not __t(__L1.q.npcVisits) or type(__L1.q.npcVisits) ~= "table"
        __O[1789] = ____temp_1136
        if ____t_1137(____temp_1136) then
            ____t_result_1138 = __O[1789]
        else
            ____t_result_1138 = __isArray(__L1.q.npcVisits)
        end
        if ____t_1139(____t_result_1138) then
            __L1.q.npcVisits = {}
        end
        local ____t_result_1142
        local ____t_1141 = __t
        local ____TS__Number_result_1140 = __TS__Number(__get(__L1.q.npcVisits, id))
        __O[1790] = ____TS__Number_result_1140
        if ____t_1141(____TS__Number_result_1140) then
            ____t_result_1142 = __O[1790]
        else
            ____t_result_1142 = 0
        end
        local visit = math.max(
            0,
            math.floor(____t_result_1142)
        )
        __set(__L1.q.npcVisits, id, visit + 1)
        __L1:save()
        local ____opt_1145 = window.Resenha
        if ____opt_1145 ~= nil then
            ____opt_1145 = ____opt_1145.talk
        end
        local ____opt_result_1147
        if ____opt_1145 ~= nil then
            ____opt_result_1147 = ____opt_1145(____opt_1145, id, visit, __L1.q)
        end
        local lines = ____opt_result_1147
        local ____t_1151 = __t
        local ____t_result_1150
        local ____t_1149 = __t
        local ____isArray_result_1148 = __isArray(lines)
        __O[1791] = ____isArray_result_1148
        if ____t_1149(____isArray_result_1148) then
            ____t_result_1150 = __len(lines)
        else
            ____t_result_1150 = __O[1791]
        end
        if ____t_1151(____t_result_1150) then
            return lines
        end
        local ____t_result_1158
        local ____t_1157 = __t
        local ____getq_1155 = __getq
        local ____callq_1154 = __callq
        local ____opt_1152 = __get(__L1.npcInfo, id)
        if ____opt_1152 ~= nil then
            ____opt_1152 = ____opt_1152.name
        end
        local ____getq_1155_result_1156 = ____getq_1155(
            ____callq_1154(____opt_1152, "split", " ·"),
            0
        )
        __O[1792] = ____getq_1155_result_1156
        if ____t_1157(____getq_1155_result_1156) then
            ____t_result_1158 = __O[1792]
        else
            ____t_result_1158 = id
        end
        local name = ____t_result_1158
        local fallback = {
            aica = __arrL({"Aff veyr juro, Arthur é bestaiado. Puxar cabelo? Você se passou, menino!", "Aff veyr juro! Arthur, esse idiota confundiu recreio com salão. Se toca, menino!"}, 2),
            ravile = __arrL({"Aff veyr juro, Arthur se passou. Bestaiado! Da Roça, me ajuda com esse idiota.", "Aff veyr juro! Meu cabelo não é corda de pular, Arthur. Você se passou demais!"}, 2),
            eloisa = __arrL({"Aff veyr juro, chegou o menino da ventilação natural. Se toca, Da Roça!", "Aff veyr juro, esse chapéu tá entregando mais personagem que a sua entrada."}, 2),
            giselle = __arrL({"Aff veyr juro, menino! Guarda esse papel que a sala não é arena.", "Aff veyr juro, tu se passou. Aqui a fofoca tem trança e horário marcado."}, 2),
            rayssa = __arrL({"Aff veyr juro, entra. Só não usa o peido pra ligar meu ventilador.", "Aff veyr juro! O menino chegou em casa como se fosse personagem desbloqueável."}, 2),
            analaura = __arrL({"Aff veyr juro, eu ia ficar quieta, mas esse chapéu pediu opinião.", "Aff veyr juro! Se toca, menino. A sala é de visita, não de boss final."}, 2),
            allef = __arrL({"Da Roça chegou! Davi, recebe a entidade do chapéu antes que ela estacione no balcão.", "Esse chapéu tem horário na agenda ou veio só fiscalizar o degradê?"}, 2),
            dede = __arrL({"SEU GILÓ HOMI! Tu furou minha fumaça com papel de caderno!", "SEU GILÓ HOMI! Era neblina de respeito, não fumaça de churrasqueira."}, 2),
            freddy = __arrL({"OPEESTY DA ROÇA! Passou por mim e ainda quer tirar onda com o Reeis?", "OPEESTY DA ROÇA! Essa bolinha veio com peso de academia!"}, 2)
        }
        local ____t_result_1161
        local ____t_1160 = __t
        local ____get_result_1159 = __get(fallback, id)
        __O[1793] = ____get_result_1159
        if ____t_1160(____get_result_1159) then
            ____t_result_1161 = __O[1793]
        else
            ____t_result_1161 = __arrL({"A resenha muda, mas o bolo continua no assunto."}, 1)
        end
        local pool = ____t_result_1161
        return __arrL(
            {{
                name = name,
                text = __get(
                    pool,
                    __mod(
                        visit,
                        __len(pool)
                    )
                )
            }},
            1
        )
    end
    __L1.openSwiftGuide = function(self)
        local ____t_result_1168
        local ____t_1167 = __t
        local ____opt_1164 = window.SwiftGuide
        if ____opt_1164 ~= nil then
            ____opt_1164 = ____opt_1164.open
        end
        local ____opt_result_1166
        if ____opt_1164 ~= nil then
            ____opt_result_1166 = ____opt_1164(____opt_1164, {say = __L1.say, toast = __L1.toast})
        end
        __O[1794] = ____opt_result_1166
        if ____t_1167(____opt_result_1166) then
            ____t_result_1168 = __O[1794]
        else
            ____t_result_1168 = false
        end
        return ____t_result_1168
    end
    __L1.interact = function(self)
        if __t(__L1.dialog) then
            __L1:nextDialog()
            return
        end
        local ____t_1170 = __t
        local ____t_result_1169
        if __t(__L1.ollyanEncounter) then
            ____t_result_1169 = not __t(__L1.paused)
        else
            ____t_result_1169 = __L1.ollyanEncounter
        end
        if ____t_1170(____t_result_1169) then
            local ____t_1174 = __t
            local ____t_result_1173
            local ____t_1172 = __t
            local ____temp_1171 = __L1.ollyanEncounter.stage == "intro"
            __O[1795] = ____temp_1171
            if ____t_1172(____temp_1171) then
                ____t_result_1173 = __O[1795]
            else
                ____t_result_1173 = __call(
                    __arrL({"victory", "defeat"}, 2),
                    "includes",
                    __L1.ollyanEncounter.stage
                )
            end
            if ____t_1174(____t_result_1173) then
                __L1:advanceCutscene()
            else
                __L1:retreatOllyan()
            end
            return
        end
        local ____t_1188 = __t
        local ____t_result_1187
        local ____t_1186 = __t
        local ____t_result_1185
        local ____t_1184 = __t
        local ____t_result_1183
        local ____t_1182 = __t
        local ____t_result_1181
        local ____t_1180 = __t
        local ____t_result_1179
        local ____t_1178 = __t
        local ____t_result_1177
        local ____t_1176 = __t
        local ____temp_1175 = not __t(__L1.started)
        __O[1796] = ____temp_1175
        if ____t_1176(____temp_1175) then
            ____t_result_1177 = __O[1796]
        else
            ____t_result_1177 = __L1.paused
        end
        __O[1797] = ____t_result_1177
        if ____t_1178(____t_result_1177) then
            ____t_result_1179 = __O[1797]
        else
            ____t_result_1179 = __L1.chapterEnded
        end
        __O[1798] = ____t_result_1179
        if ____t_1180(____t_result_1179) then
            ____t_result_1181 = __O[1798]
        else
            ____t_result_1181 = __L1.defeated
        end
        __O[1799] = ____t_result_1181
        if ____t_1182(____t_result_1181) then
            ____t_result_1183 = __O[1799]
        else
            ____t_result_1183 = __L1.cutscene
        end
        __O[1800] = ____t_result_1183
        if ____t_1184(____t_result_1183) then
            ____t_result_1185 = __O[1800]
        else
            ____t_result_1185 = __L1.routeTransition
        end
        __O[1801] = ____t_result_1185
        if ____t_1186(____t_result_1185) then
            ____t_result_1187 = __O[1801]
        else
            ____t_result_1187 = window.performance:now() < __L1.dialogueReopenUntil
        end
        if ____t_1188(____t_result_1187) then
            return
        end
        if __t(__L1.won) then
            return
        end
        local ____t_1208 = __t
        local ____t_result_1207
        local ____t_1201 = __t
        local ____t_result_1200
        local ____t_1199 = __t
        local ____t_result_1198
        local ____t_1197 = __t
        local ____t_result_1196
        local ____t_1195 = __t
        local ____t_result_1194
        local ____t_1193 = __t
        local ____temp_1192 = not __t(__L1.activity)
        if ____temp_1192 then
            local ____t_1191 = __t
            local ____opt_1189 = __L1.training
            if ____opt_1189 ~= nil then
                ____opt_1189 = ____opt_1189.active
            end
            ____temp_1192 = not ____t_1191(____opt_1189)
        end
        __O[1802] = ____temp_1192
        if ____t_1193(____temp_1192) then
            ____t_result_1194 = not __t(__L1.arena)
        else
            ____t_result_1194 = __O[1802]
        end
        __O[1803] = ____t_result_1194
        if ____t_1195(____t_result_1194) then
            ____t_result_1196 = not __t(__L1.room)
        else
            ____t_result_1196 = __O[1803]
        end
        __O[1804] = ____t_result_1196
        if ____t_1197(____t_result_1196) then
            ____t_result_1198 = not __t(__L1.activeBoss)
        else
            ____t_result_1198 = __O[1804]
        end
        __O[1805] = ____t_result_1198
        if ____t_1199(____t_result_1198) then
            ____t_result_1200 = not __t(__L1.vehicle)
        else
            ____t_result_1200 = __O[1805]
        end
        __O[1806] = ____t_result_1200
        if ____t_1201(____t_result_1200) then
            local ____opt_1204 = window.Balanco
            if ____opt_1204 ~= nil then
                ____opt_1204 = ____opt_1204.near
            end
            local ____opt_result_1206
            if ____opt_1204 ~= nil then
                ____opt_result_1206 = ____opt_1204(____opt_1204, __L1.scene, __L1.player.x)
            end
            ____t_result_1207 = ____opt_result_1206
        else
            ____t_result_1207 = __O[1806]
        end
        if ____t_1208(____t_result_1207) then
            __L1:releaseInputs()
            window.Balanco:sit()
            return
        end
        local ____t_1228 = __t
        local ____t_result_1227
        local ____t_1221 = __t
        local ____t_result_1220
        local ____t_1219 = __t
        local ____t_result_1218
        local ____t_1217 = __t
        local ____t_result_1216
        local ____t_1215 = __t
        local ____t_result_1214
        local ____t_1213 = __t
        local ____temp_1212 = not __t(__L1.activity)
        if ____temp_1212 then
            local ____t_1211 = __t
            local ____opt_1209 = __L1.training
            if ____opt_1209 ~= nil then
                ____opt_1209 = ____opt_1209.active
            end
            ____temp_1212 = not ____t_1211(____opt_1209)
        end
        __O[1807] = ____temp_1212
        if ____t_1213(____temp_1212) then
            ____t_result_1214 = not __t(__L1.arena)
        else
            ____t_result_1214 = __O[1807]
        end
        __O[1808] = ____t_result_1214
        if ____t_1215(____t_result_1214) then
            ____t_result_1216 = not __t(__L1.room)
        else
            ____t_result_1216 = __O[1808]
        end
        __O[1809] = ____t_result_1216
        if ____t_1217(____t_result_1216) then
            ____t_result_1218 = not __t(__L1.activeBoss)
        else
            ____t_result_1218 = __O[1809]
        end
        __O[1810] = ____t_result_1218
        if ____t_1219(____t_result_1218) then
            ____t_result_1220 = not __t(__L1.vehicle)
        else
            ____t_result_1220 = __O[1810]
        end
        __O[1811] = ____t_result_1220
        if ____t_1221(____t_result_1220) then
            local ____opt_1224 = window.Fliperama
            if ____opt_1224 ~= nil then
                ____opt_1224 = ____opt_1224.near
            end
            local ____opt_result_1226
            if ____opt_1224 ~= nil then
                ____opt_result_1226 = ____opt_1224(____opt_1224, __L1.scene, __L1.player.x)
            end
            ____t_result_1227 = ____opt_result_1226
        else
            ____t_result_1227 = __O[1811]
        end
        if ____t_1228(____t_result_1227) then
            __L1:releaseInputs()
            window.Fliperama:open(nil, {from = "world"})
            return
        end
        if __t(__L1.activity) then
            __L1:submitActivity()
            return
        end
        local ____t_1231 = __t
        local ____opt_1229 = __L1.training
        if ____opt_1229 ~= nil then
            ____opt_1229 = ____opt_1229.active
        end
        if ____t_1231(____opt_1229) then
            __L1:submitTraining()
            return
        end
        local ____t_1234 = __t
        local ____opt_1232 = __L1.room
        if ____opt_1232 ~= nil then
            ____opt_1232 = ____opt_1232.phase
        end
        if ____t_1234(____opt_1232 == "inside" and math.abs(__L1.player.x - __L1.room.exitX) < 105) then
            __L1:exitRoom()
            return
        end
        local ____t_1237 = __t
        local ____opt_1235 = __L1.arena
        if ____opt_1235 ~= nil then
            ____opt_1235 = ____opt_1235.phase
        end
        if ____t_1237(____opt_1235 == "active" and __le(
            __L1.player.x,
            __get(__L1.arena.bounds, 0) + 78
        )) then
            __L1:retreatBoss()
            return
        end
        local pertinho = __L1:closestNPC()
        local ____t_result_1254
        local ____t_1253 = __t
        local ____t_result_1252
        if __t(pertinho) then
            local ____t_result_1251
            local ____t_1250 = __t
            local ____t_result_1249
            local ____t_1243 = __t
            local ____opt_1240 = window.MissaoFarda
            if ____opt_1240 ~= nil then
                ____opt_1240 = ____opt_1240.ehNpc
            end
            local ____opt_result_1242
            if ____opt_1240 ~= nil then
                ____opt_result_1242 = ____opt_1240(
                    ____opt_1240,
                    __get(pertinho, 0)
                )
            end
            __O[1812] = ____opt_result_1242
            if ____t_1243(____opt_result_1242) then
                ____t_result_1249 = __O[1812]
            else
                local ____opt_1246 = window.LugaresC1
                if ____opt_1246 ~= nil then
                    ____opt_1246 = ____opt_1246.ehNpc
                end
                local ____opt_result_1248
                if ____opt_1246 ~= nil then
                    ____opt_result_1248 = ____opt_1246(
                        ____opt_1246,
                        __get(pertinho, 0)
                    )
                end
                ____t_result_1249 = ____opt_result_1248
            end
            __O[1813] = ____t_result_1249
            if ____t_1250(____t_result_1249) then
                ____t_result_1251 = __O[1813]
            else
                ____t_result_1251 = __get(pertinho, 0) == "mc_batidao"
            end
            ____t_result_1252 = ____t_result_1251
        else
            ____t_result_1252 = pertinho
        end
        __O[1814] = ____t_result_1252
        if ____t_1253(____t_result_1252) then
            ____t_result_1254 = math.abs(__get(pertinho, 1).x - __L1.player.x) < 75
        else
            ____t_result_1254 = __O[1814]
        end
        local missao = ____t_result_1254
        local ____t_result_1255
        if __t(missao) then
            ____t_result_1255 = nil
        else
            ____t_result_1255 = __L1:closestBoss()
        end
        local boss = ____t_result_1255
        if __t(boss) then
            __L1:interactBoss(boss)
            return
        end
        local ____t_1259 = __t
        local ____t_result_1258
        local ____t_1257 = __t
        local ____temp_1256 = not __t(missao) and not __t(__L1.room)
        __O[1815] = ____temp_1256
        if ____t_1257(____temp_1256) then
            ____t_result_1258 = not __t(__L1.arena)
        else
            ____t_result_1258 = __O[1815]
        end
        if ____t_1259(____t_result_1258) then
            local ____get_1269 = __get
            local ____call_1268 = __call
            local ____call_1267 = __call
            local ____t_result_1263
            local ____t_1262 = __t
            local ____opt_1260 = window.WorldData
            if ____opt_1260 ~= nil then
                ____opt_1260 = ____opt_1260.doors
            end
            __O[1816] = ____opt_1260
            if ____t_1262(____opt_1260) then
                ____t_result_1263 = __O[1816]
            else
                ____t_result_1263 = __arrL({}, 0)
            end
            local door = ____get_1269(
                ____call_1268(
                    ____call_1267(
                        ____t_result_1263,
                        "filter",
                        function(____, d)
                            local ____t_result_1266
                            local ____t_1265 = __t
                            local ____temp_1264 = d.scene == __L1.scene and math.abs(__L1.player.x - d.x) < 105
                            __O[1817] = ____temp_1264
                            if ____t_1265(____temp_1264) then
                                ____t_result_1266 = math.abs(__L1.player.y - __L1.FLOOR) < 65
                            else
                                ____t_result_1266 = __O[1817]
                            end
                            return ____t_result_1266
                        end
                    ),
                    "sort",
                    function(____, a, b) return math.abs(a.x - __L1.player.x) - math.abs(b.x - __L1.player.x) end
                ),
                0
            )
            if __t(door) then
                __L1:enterRoom(door.id)
                return
            end
        end
        local ____t_1289 = __t
        local ____t_result_1288
        local ____t_1275 = __t
        local ____t_result_1274
        local ____t_1273 = __t
        local ____t_result_1272
        local ____t_1271 = __t
        local ____temp_1270 = not __t(missao) and not __t(__L1.room)
        __O[1818] = ____temp_1270
        if ____t_1271(____temp_1270) then
            ____t_result_1272 = not __t(__L1.arena)
        else
            ____t_result_1272 = __O[1818]
        end
        __O[1819] = ____t_result_1272
        if ____t_1273(____t_result_1272) then
            ____t_result_1274 = not __t(__L1.vehicle)
        else
            ____t_result_1274 = __O[1819]
        end
        __O[1821] = ____t_result_1274
        if ____t_1275(____t_result_1274) then
            local ____opt_1285 = window.WorldLife
            if ____opt_1285 ~= nil then
                ____opt_1285 = ____opt_1285.tryInteract
            end
            local ____opt_result_1287
            if ____opt_1285 ~= nil then
                ____opt_result_1287 = ____opt_1285(
                    ____opt_1285,
                    {scene = __L1.scene, player = __L1.player, q = __L1.q},
                    {
                        awardXP = __L1.awardXP,
                        save = __L1.save,
                        updateUI = __L1.updateUI,
                        toast = __L1.toast,
                        addItem = function(____, ____type, count)
                            if __t(__call(__L1.items, "hasOwnProperty", ____type)) then
                                local ____set_1283 = __set
                                local ____L1_items_1281 = __L1.items
                                local ____type_1282 = ____type
                                local ____get_result_1280 = __get(__L1.items, ____type)
                                local ____t_result_1279
                                local ____t_1278 = __t
                                local ____math_floor_result_1277 = math.floor(count)
                                __O[1820] = ____math_floor_result_1277
                                if ____t_1278(____math_floor_result_1277) then
                                    ____t_result_1279 = __O[1820]
                                else
                                    ____t_result_1279 = 0
                                end
                                ____set_1283(
                                    ____L1_items_1281,
                                    ____type_1282,
                                    math.min(
                                        999,
                                        ____get_result_1280 + math.max(0, ____t_result_1279)
                                    )
                                )
                            end
                        end
                    }
                )
            end
            ____t_result_1288 = ____opt_result_1287
        else
            ____t_result_1288 = __O[1821]
        end
        if ____t_1289(____t_result_1288) then
            return
        end
        local found = __L1:closestNPC()
        if not __t(found) then
            __L1:toast(__t(__L1.vehicle) and "Carro a gás ligado! Escolha uma rota ou dirija com o joystick." or "Chegue perto de alguém e aperte E. O diário mostra a próxima missão.")
            return
        end
        local id, n = table.unpack(found, 1, 2)
        if id == "amanda" then
            __L1:say(
                window.AmandaDinner:invitation(__L1.q),
                function()
                    if __t(__L1:startActivity("dinner")) then
                        __L1.q.amandaInvited = true
                        __L1:save()
                    end
                end
            )
            return
        end
        if id == "swift" then
            __L1:openSwiftGuide()
            return
        end
        if id == "ollyan" then
            if not __t(__L1.q.ollyan) then
                __L1:beginOllyanEncounter()
            else
                __L1:say(__arrL({{name = n.name, text = "Foi mal, véi… minhas orelhas perderam o compasso. Hoje eu vou de carona e de água."}, {name = "Da Roça", text = "Fechou. Da próxima vez deixa a pilotagem com o carro do meu pai."}}, 2))
            end
            return
        end
        if id == "almiro" then
            if not __t(__L1.q.almiroAccepted) then
                __L1:say(
                    __arrL({{name = n.name, text = "ahahaha da roça sacana é com cerveja! Mas antes da resenha: meus três cadernos sumiram no corredor."}, "Até professor tem quest agora?", {name = n.name, text = "Tem! Procura os cadernos azuis nas plataformas e me traz os três. Te ensino um combo de gás que nem o ventilador aguenta."}}, 3),
                    function()
                        __L1.q.almiroAccepted = true
                        __L1:toast("Missão: recolha 3 cadernos no corredor e volte à sala 01.")
                    end
                )
            elseif __t(not __t(__L1.q.almiro) and __len(__L1.q.notebooks) >= 3) then
                __L1:say(
                    __arrL({{name = n.name, text = "Aí sim! Três cadernos e nenhuma folha amassada... quase. Aprende: K, K, K no ritmo. O terceiro peido vira uma explosão!"}, "O senhor acabou de transformar feijão em disciplina escolar.", {name = n.name, text = "Combo liberado! Agora ajuda Miqueias na sala 02 antes de subir à favela."}}, 3),
                    function()
                        __L1.q.almiro = true
                        __L1:awardXP(240, "quest-almiro")
                        __L1:toast("Combo de gás desbloqueado: três toques em K no ritmo!")
                    end
                )
            else
                __L1:say(__arrL(
                    {{
                        name = n.name,
                        text = __t(__L1.q.almiro) and "Combo de gás: três toques separados, K → K → K. Não vale culpar a cadeira azul pelo barulho!" or ("Faltam " .. tostring(3 - __len(__L1.q.notebooks))) .. " cadernos! Estão nas plataformas do corredor. A careca está brilhando, mas não é radar."
                    }},
                    1
                ))
            end
            return
        end
        if id == "miqueias" then
            if __t(__L1.q.miqueias) then
                __L1:say(__arrL({{name = n.name, text = "ALLRIGHT! Your papaias is elemental now, beleza creuza! Level up and fire go brrr, é ou não é?"}}, 1))
            else
                __L1:say(
                    __arrL({{name = n.name, text = "ALLRIGHT! You is ready for the English challenge, é ou não é? Three correct and your paper get poderes!"}, "Três acertos e o papel vira arma elemental?", {name = n.name, text = "Yes, concorda ou sem corda! Choose the word, beleza creuza. Wrong answer no cancela sua matrícula!"}}, 3),
                    function() return __L1:startActivity("quiz") end
                )
            end
            return
        end
        if __t(id == "aica" or id == "ravile") then
            local lines = __L1:visitTalk(id)
            __L1:say(
                lines,
                function()
                    if not __t(__L1.q.arthur) then
                        __L1.q.patioAccepted = true
                        __L1:toast("Missão do pátio: Arthur está no fim do cenário. Aperte DESAFIAR para ajudar Ravile.")
                    end
                    __L1:save()
                    __L1:updateUI()
                end
            )
            return
        end
        if __t(__call(
            __arrL({"eloisa", "giselle", "rayssa", "analaura"}, 4),
            "includes",
            id
        )) then
            local first = not __t(__L1.q.rayssaVisit)
            local ____opt_1292 = window.BivoltQuest
            if ____opt_1292 ~= nil then
                ____opt_1292 = ____opt_1292.interact
            end
            local ____opt_result_1294
            if ____opt_1292 ~= nil then
                ____opt_result_1294 = ____opt_1292(____opt_1292, id, __L1.q, __L1.items)
            end
            local quest = ____opt_result_1294
            local ____L1_say_1317 = __L1.say
            local ____t_result_1299
            local ____t_1298 = __t
            local ____opt_result_1297
            if quest ~= nil then
                ____opt_result_1297 = quest.lines
            end
            __O[1822] = ____opt_result_1297
            if ____t_1298(____opt_result_1297) then
                ____t_result_1299 = __O[1822]
            else
                ____t_result_1299 = __L1:visitTalk(id)
            end
            ____L1_say_1317(
                __L1,
                ____t_result_1299,
                function()
                    local ____t_1301 = __t
                    local ____t_result_1300
                    if __t(first) then
                        ____t_result_1300 = not __t(__L1.q.rayssaVisit)
                    else
                        ____t_result_1300 = first
                    end
                    if ____t_1301(____t_result_1300) then
                        __L1.q.rayssaVisit = true
                        __L1:awardXP(90, "side-rayssa-visit")
                    end
                    local ____t_1305 = __t
                    local ____opt_result_1304
                    if quest ~= nil then
                        ____opt_result_1304 = quest.action
                    end
                    if ____t_1305(____opt_result_1304) then
                        local result = window.BivoltQuest:complete(__L1.q, quest.action, __L1.items)
                        local ____t_1309 = __t
                        local ____opt_result_1308
                        if result ~= nil then
                            ____opt_result_1308 = result.xp
                        end
                        if ____t_1309(____opt_result_1308) then
                            local ____L1_awardXP_1312 = __L1.awardXP
                            local ____result_xp_1311 = result.xp
                            local ____t_result_1310
                            if __t(result.source) then
                                ____t_result_1310 = result.source
                            else
                                ____t_result_1310 = "side-bivolt-unlock"
                            end
                            ____L1_awardXP_1312(__L1, ____result_xp_1311, ____t_result_1310)
                        end
                        local ____t_1316 = __t
                        local ____opt_result_1315
                        if result ~= nil then
                            ____opt_result_1315 = result.message
                        end
                        if ____t_1316(____opt_result_1315) then
                            __L1:toast(result.message)
                        end
                    end
                    __L1:save()
                    __L1:updateUI()
                end
            )
            return
        end
        if id == "allef" then
            __L1:say(__L1:visitTalk(id))
            return
        end
        local ____t_1323 = __t
        local ____opt_1320 = window.FavelaCasas
        if ____opt_1320 ~= nil then
            ____opt_1320 = ____opt_1320.ehCasa
        end
        local ____opt_result_1322
        if ____opt_1320 ~= nil then
            ____opt_result_1322 = ____opt_1320(____opt_1320, id)
        end
        if ____t_1323(____opt_result_1322) then
            window.FavelaCasas:falar(
                id,
                __L1.q,
                {
                    say = __L1.say,
                    save = function()
                        __L1:save()
                        __L1:updateUI()
                    end
                }
            )
            return
        end
        local ____t_1329 = __t
        local ____opt_1326 = window.LugaresC1
        if ____opt_1326 ~= nil then
            ____opt_1326 = ____opt_1326.ehNpc
        end
        local ____opt_result_1328
        if ____opt_1326 ~= nil then
            ____opt_result_1328 = ____opt_1326(____opt_1326, id)
        end
        if ____t_1329(____opt_result_1328) then
            window.LugaresC1:falar(
                id,
                __L1.q,
                {
                    say = __L1.say,
                    toast = __L1.toast,
                    save = function()
                        __L1:save()
                        __L1:updateUI()
                    end,
                    curar = function()
                        __L1.player.hp = __L1:bonus().maxHP
                        __L1.player.gas = __L1:bonus().maxGas
                        __L1:updateUI()
                    end,
                    xp = function(____, n2, src) return __L1:awardXP(n2, src) end,
                    materiais = function(____, k)
                        do
                            local i = 0
                            while __lt(i, k) do
                                local key = __get(
                                    __arrL({"pencil", "eraser", "clip"}, 3),
                                    __mod(i, 3)
                                )
                                local ____set_1334 = __set
                                local ____L1_items_1333 = __L1.items
                                local ____t_result_1332
                                local ____t_1331 = __t
                                local ____get_result_1330 = __get(__L1.items, key)
                                __O[1823] = ____get_result_1330
                                if ____t_1331(____get_result_1330) then
                                    ____t_result_1332 = __O[1823]
                                else
                                    ____t_result_1332 = 0
                                end
                                ____set_1334(
                                    ____L1_items_1333,
                                    key,
                                    math.min(999, ____t_result_1332 + 1)
                                )
                                i = i + 1
                            end
                        end
                    end
                }
            )
            return
        end
        if id == "mc_batidao" then
            local N = n.name
            local ja = not not __t(__L1.q.daJegue)
            if __t(ja) then
                __L1:say(__arrL({{name = N, text = "Olha ele aí, o DA JEGUE em pessoa! Veste a fantasia no espelho e manda o passinho, que o baile pede bis!"}}, 1))
                return
            end
            __L1:say(
                __arrL({{name = N, text = "Hoje é noite do CONCURSO DA FANTASIA! O prêmio é a fantasia mais lendária do galpão: o DA JEGUE, com orelhona, crina e rabo!"}, {name = N, text = "Pra levar, tem que dançar no ritmo do tamborzão. Aperta as setas quando elas chegarem na linha. Nota 70 ou mais e a fantasia é tua!"}, {name = "Da Roça", text = "Eu nasci dançando forró no terreiro. Tamborzão é só forró com grave!", actionLabel = "Entrar no concurso"}}, 3),
                function()
                    local ____t_1337 = __t
                    local ____opt_1335 = window.BaileConcurso
                    if ____opt_1335 ~= nil then
                        ____opt_1335 = ____opt_1335.abrir
                    end
                    if not ____t_1337(____opt_1335) then
                        return
                    end
                    __L1:releaseInputs()
                    window.BaileConcurso:abrir({onFim = function(____, ok, nota, desistiu)
                        __L1:releaseInputs()
                        local ____t_1339 = __t
                        local ____t_result_1338
                        if __t(ok) then
                            ____t_result_1338 = not __t(__L1.q.daJegue)
                        else
                            ____t_result_1338 = ok
                        end
                        if ____t_1339(____t_result_1338) then
                            __L1.q.daJegue = true
                            local ____opt_1342 = window.DarocaLook
                            if ____opt_1342 ~= nil then
                                ____opt_1342 = ____opt_1342.ganhar
                            end
                            if ____opt_1342 ~= nil then
                                ____opt_1342(____opt_1342, "dajegue")
                            end
                            __L1:awardXP(220, "side-dajegue")
                            __L1:toast(__add(
                                __add("DA JEGUE! Nota ", nota),
                                "%. A fantasia de burro está no espelho (INVENTÁRIO › ESPELHO)."
                            ))
                            __L1:fx(
                                __L1.player.x,
                                __L1.player.y - 60,
                                "#ff4fa8",
                                30,
                                150
                            )
                            __L1:save()
                            __L1:updateUI()
                        elseif not __t(desistiu) then
                            __L1:toast(__add(
                                __add("Nota ", nota),
                                "%. O MC Batidão disse que você quase levou. Fale com ele de novo!"
                            ))
                        end
                    end})
                end
            )
            return
        end
        local ____t_1349 = __t
        local ____opt_1346 = window.MissaoFarda
        if ____opt_1346 ~= nil then
            ____opt_1346 = ____opt_1346.ehNpc
        end
        local ____opt_result_1348
        if ____opt_1346 ~= nil then
            ____opt_result_1348 = ____opt_1346(____opt_1346, id)
        end
        if ____t_1349(____opt_result_1348) then
            window.MissaoFarda:falar(
                id,
                __L1.q,
                {
                    say = __L1.say,
                    toast = __L1.toast,
                    save = function()
                        __L1:save()
                        __L1:updateUI()
                    end,
                    xp = function(____, n2, src) return __L1:awardXP(n2, src) end
                }
            )
            return
        end
        if id == "arthur" then
            __L1:say(__arrL({{name = n.name, text = "Tá, eu pedi desculpa pelo cabelo. E minha orelha ainda está em modo alerta."}, {name = "Da Roça", text = "Boa. Da próxima vez chama pra conversar, sem puxar ninguém."}, {name = n.name, text = "Combinado! Posso pelo menos fazer uma pose dramática de reconciliação?"}}, 3))
            return
        end
        if id == "dede" then
            __L1:say(__L1:visitTalk(id))
            return
        end
        if id == "davi" then
            local first = not __t(__L1.q.bigodon)
            local gift = __L1:getJaglionStatus() == "reserved"
            local wardrobeLine = __t(gift) and "Amanda mandou recado! Vitor guardou o Jaglion pra você. Prova ele no espelho, rei da selva." or (__t(__L1.q.jaglionClaimed) and "Teu Jaglion tá no espelho junto dos chapéus. Hoje vai de juba ou de palha?" or "O Jaglion ali? A Amanda encomendou. Ela vive na entrada da Praça Camacan. Os outros visuais são da casa.")
            __L1:say(
                __arrL(
                    {
                        {
                            name = n.name,
                            text = __t(first) and "Chegou na Bigodon! Aqui o degradê é na régua e a resenha é sem limite. Senta aí, Da Roça!" or "Olha quem voltou! O único cliente que usa gás de fixador. Aqui a resenha recupera até a energia."
                        },
                        {name = "Da Roça", text = "Só alinha o chapéu. Se cortar meu cabelo, vou perder a aerodinâmica do peido."},
                        {name = n.name, text = "Relaxa! Meu corte é tão alinhado que até o carro do seu pai sai daqui fazendo curva certinha."},
                        {name = "Vitor · ajudante", text = "Davi, a tesoura! Você está penteando o vento de novo."},
                        {name = n.name, text = "É o acabamento premium, pô! Pronto: vida cheia, gás no tanque e autoestima na régua."},
                        {
                            name = n.name,
                            text = wardrobeLine,
                            actionLabel = __t(gift) and "Receber o Jaglion" or "Abrir o espelho"
                        }
                    },
                    6
                ),
                function()
                    if __t(gift) then
                        __L1.q.jaglionClaimed = true
                    end
                    __L1.q.bigodon = true
                    __L1.player.hp = __L1:bonus().maxHP
                    __L1.player.gas = __L1:bonus().maxGas
                    if __t(first) then
                        __L1:awardXP(120, "side-bigodon")
                    end
                    __L1:save()
                    __L1:updateUI()
                    __L1:toast(__t(gift) and "Jaglion recebido na Bigodon!" or "Resenha na Bigodon: vida e gás recuperados!")
                    local ____opt_1352 = window.DarocaLook
                    if ____opt_1352 ~= nil then
                        ____opt_1352 = ____opt_1352.open
                    end
                    if ____opt_1352 ~= nil then
                        ____opt_1352(
                            ____opt_1352,
                            {line = __t(gift) and "Davi: A juba é do Vitor, a ideia é da Amanda. O rugido é contigo!" or "Davi: Senta na cadeira e escolhe. Aqui o visual é por conta da casa!"}
                        )
                    end
                end
            )
            return
        end
        if id == "vitor" then
            local first = not __t(__L1.q.vitor)
            __L1:say(
                __arrL(
                    {
                        {
                            name = n.name,
                            text = __t(first) and "Eu sou Vitor, ajudante da Bigodon. Organizo as máquinas, os horários e as histórias do Davi." or "A máquina tá carregada e a agenda tá cheia. Só a resenha que não tem horário pra acabar."
                        },
                        {name = "Da Roça", text = "E qual é a história de hoje?"},
                        {name = n.name, text = "Nicolas tá na Praça Camacan dizendo que nasceu protagonista. A trilha sonora só toca na cabeça dele."},
                        {name = n.name, text = "E na favela tem Freddy, o mais forte do Reeis. Ele tira onda do chefe: “Ô REEEIS, tá se achando rei?”"},
                        {name = "Da Roça", text = "Um corte de cabelo e duas fofocas. Melhor parada do carro do meu pai!"}
                    },
                    5
                ),
                function()
                    __L1.q.vitor = true
                    if __t(first) then
                        __L1:awardXP(60, "side-vitor")
                    end
                    __L1:save()
                    __L1:toast("Dica do Vitor: Nicolas fica no fim da Praça Camacan; Freddy está antes de Reeis.")
                end
            )
            return
        end
        if id == "freddy" then
            local ____t_1356 = __t
            local ____opt_1354 = window.BaileConcurso
            if ____opt_1354 ~= nil then
                ____opt_1354 = ____opt_1354.abrir
            end
            if not ____t_1356(____opt_1354) then
                __L1:say(__L1:visitTalk(id))
                return
            end
            local N = n.name
            local ja = not not __t(__L1.q.rimaFreddy)
            __L1:say(
                __arrL(
                    {
                        {
                            name = N,
                            text = __t(ja) and "Tu me venceu no soco e na rima. Quer mais uma rodada pra galera ver?" or "Perdi no braço, mas no microfone ninguém me cala! Batalha de rima, chapéu. Aqui no morro."
                        },
                        {name = N, text = "Eu mando um verso, tu responde no compasso. A galera decide pela nota. Setinha na linha, rima na ponta da língua!"},
                        {name = "Da Roça", text = "Pode vir, Freddy. Rima de roça tem raiz!", actionLabel = "Batalha de rima"}
                    },
                    3
                ),
                function()
                    __L1:releaseInputs()
                    window.BaileConcurso:abrir({
                        config = {
                            titulo = "BATALHA DE RIMA",
                            rival = "freddy",
                            premio = nil,
                            premioLook = nil,
                            ganhou = "O MORRO TODO GRITOU: DA ROÇA!",
                            versos = __arrL(
                                {
                                    __arrL({"Lá do alto do morro eu mando a real,", "teu chapéu de palha não passa do quintal!"}, 2),
                                    __arrL({"Meu chapéu é de palha, mas a rima é de aço,", "eu planto no compasso e colho no espaço!"}, 2),
                                    __arrL({"Tu é da roça, eu sou do asfalto,", "no meu microfone o grave vem mais alto!"}, 2),
                                    __arrL({"No terreiro eu aprendi a ter paciência,", "teu grave é barulho, o meu tem ciência!"}, 2)
                                },
                                4
                            )
                        },
                        onFim = function(____, ok, nota, desistiu)
                            __L1:releaseInputs()
                            if __t(ok) then
                                local first = not __t(__L1.q.rimaFreddy)
                                __L1.q.rimaFreddy = true
                                if __t(first) then
                                    __L1:awardXP(200, "side-rima-freddy")
                                end
                                __L1:toast(__add(
                                    __add(
                                        __add("Batalha de rima vencida! Nota ", nota),
                                        "%. O Freddy pediu bis."
                                    ),
                                    __t(first) and " +200 XP" or ""
                                ))
                                __L1:save()
                                __L1:updateUI()
                            elseif not __t(desistiu) then
                                __L1:toast(__add(
                                    __add("Nota ", nota),
                                    "%. O Freddy levou essa. Fala com ele pra revanche!"
                                ))
                            end
                        end
                    })
                end
            )
            return
        end
        if id == "nicolas" then
            __L1:say(__arrL({{name = n.name, text = "Você viu minha aura suprema? Eu quase parti o céu. Só parei porque a praça tem horário de silêncio."}, {name = "Da Roça", text = "Nicolas, tu tava parado fazendo “vush, pá, bum” com a boca. O pombo foi o único que saiu voando."}, {name = n.name, text = "Foi uma batalha em outra dimensão! Você ainda não desbloqueou a câmera de protagonista."}, {name = "Da Roça", text = "Tá certo, guerreiro. Vou ali buscar meu bolo enquanto a sua dimensão esfria."}}, 4))
            return
        end
        if id == "mota" then
            __L1:say(
                __arrL(
                    {
                        {
                            name = n.name,
                            text = __t(__L1.q.mota) and "Bora repetir? O gol nunca fecha e treino dá XP. Mira, escolhe a força e chuta!" or "Sou Gabriel Mota, profissional da resenha e do futebol da escola. Faz 3 gols em 5 chutes pra aprender o dash!"
                        },
                        "Vale gol de peido?",
                        {name = n.name, text = "Hoje só vale bola! Aperta E ou CHUTAR pra travar a mira, de novo pra força. O goleiro se mexe: capricha!"}
                    },
                    3
                ),
                function() return __L1:startActivity("football") end
            )
            return
        end
        if id == "lucas" then
            if not __t(__L1.q.carMissionAccepted) then
                __L1:say(
                    __arrL({{name = n.name, text = "Nikolas levou o bolo... e o carro a gás do seu pai está quebrado! Preciso da ventoinha, do cano e da vela."}, "Roubaram o bolo e ainda caiu a manutenção no meu colo?", {name = n.name, text = "As três peças estão espalhadas nas plataformas da roça. Parkour primeiro, vingança depois. Traz tudo aqui que eu conserto!"}}, 3),
                    function()
                        __L1.q.carMissionAccepted = true
                        __L1:toast("Colete as 3 peças pelas plataformas da roça e volte ao Lucas.")
                    end
                )
            elseif __t(not __t(__L1.q.lucas) and __len(__L1.q.carParts) >= 3) then
                __L1:say(
                    __arrL({{name = n.name, text = "Ventoinha, cano e vela! Agora sim. *aperta um parafuso, assopra outro* O carro do seu pai voltou!"}, "Vruuum! É a mistura de oficina com feijão.", {name = n.name, text = "V entra no carro e abre as rotas. Conheça Mota no campo e os professores na escola antes de enfrentar os chefões!"}}, 3),
                    function()
                        __L1.q.lucas = true
                        __L1:awardXP(250, "quest-repair-car")
                        __L1:toast("Carro a gás consertado! V para entrar e escolher uma rota.")
                    end
                )
            else
                local ____L1_say_1360 = __L1.say
                local ____arrL_1359 = __arrL
                local ____n_name_1358 = n.name
                local ____t_result_1357
                if __t(__L1.q.lucas) then
                    ____t_result_1357 = __t(__L1.q.nikolas) and "O bolo voltou! A receita é chocolate e amizade. Sapo é só meu apelido!" or "O carro está pronto. Mota ensina o dash no campo; os professores têm missões na escola."
                else
                    ____t_result_1357 = ("Já achou " .. tostring(__len(__L1.q.carParts))) .. "/3 peças. Procura nas plataformas da roça, inclusive lá no fim!"
                end
                ____L1_say_1360(
                    __L1,
                    ____arrL_1359({{name = ____n_name_1358, text = ____t_result_1357}}, 1)
                )
            end
            return
        end
        if id == "kaua" then
            if not __t(__L1.q.kaua) then
                __L1:say(
                    __arrL(
                        {
                            {
                                name = n.name,
                                text = __add(__L1.kauaVoice, " Lápis, borracha e clipe viram armas! 3 materiais criam o Lançador de régua; mais 5 fazem o Canhão de estojo.")
                            },
                            "Oficina de armas ou papelaria?",
                            {name = n.name, text = "Os dois! Coleta os materiais brilhantes e volta aqui. As papaias ganham poderes na aula do Miqueias!"}
                        },
                        3
                    ),
                    function()
                        __L1.q.kaua = true
                        __L1:toast("Kauã: 3 materiais para arma1; outros5 para arma2.")
                    end
                )
            else
                __L1:craft()
            end
            return
        end
        if id == "reeis" then
            __L1:say(__arrL({{name = n.name, text = "Você ganhou meu respeito na favela! Agora é só chamar: OHHHH REEEEIS!"}, "O bolo tem reforço de peso agora!", {name = n.name, text = "Marco está no colégio. Cuidado com o piso SARUÊ: pisou, o desenhista fica vermelho de raiva."}}, 3))
            return
        end
        if id == "ravid" then
            __L1:say(__arrL({{name = "Ravid · olhando para a parede", text = "Se o quadro é verde água... será que a parede está com sede?"}, "Ravid, tem monstro desenhado andando no corredor!", {name = "Ravid", text = "Eu também desenhei um futuro brilhante... mas a parede ainda não respondeu."}, "Boa conversa com a parede aí."}, 4))
            return
        end
        if id == "caleb" then
            if not __t(__L1.q.menezes) then
                __L1:say(__arrL({{name = n.name, text = "Primeiro vence Menezes! Whey não resolve provocação física, mas uns reflexos ajudam."}}, 1))
                return
            end
            if not __t(__L1.q.trained) then
                __L1:say(
                    __arrL({{name = n.name, text = "Hoje tem leg day, bolo day e zero desculpa! Seu gás é monstro, mas esse braço ainda parece lápis HB."}, "Vai me fazer levantar o carro?", {name = n.name, text = "Só o marcador! Três rodadas, dois acertos no verde em cada. Depois disso teu shape assusta até o catarro do Nikolas!"}}, 3),
                    __L1.startTraining
                )
            else
                __L1:say(
                    __arrL({{name = n.name, text = "Olha o shape do supino de bolo! Quer repetir? Só não vai fazer flexão usando a barriga do Miqueias de apoio!"}, "Bora repetir o treino!", {name = n.name, text = "Verde, E e força! O treino não apaga seus músculos nem as rotas."}}, 3),
                    __L1.startTraining
                )
            end
        end
    end
    __L1.start = function(self, continuing)
        if continuing == nil then
            continuing = false
        end
        local ____opt_1363 = window.CampaignVfx
        if ____opt_1363 ~= nil then
            ____opt_1363 = ____opt_1363.reset
        end
        if ____opt_1363 ~= nil then
            ____opt_1363(____opt_1363)
        end
        if __t(__L1.sandbox) then
            __L1:exitSandbox()
        end
        __L1:resetBivolt()
        __L1.ollyanEncounter = nil
        __L1.ollyanRetryGrace = 0
        __L1.started = true
        __L1.playing = true
        __L1.paused = false
        __L1.won = false
        __L1.defeated = false
        __L1.chapterEnded = false
        __L1:show("chapterEndScreen", false)
        __L1.activeBoss = nil
        __L1.respawnCheckpoint = nil
        __L1.routeTransition = nil
        __L1.room = nil
        __L1.arena = nil
        __L1.cutscene = nil
        __L1.cutsceneCallback = nil
        __L1.lastSafeX = 230
        __L1.tauntCooldown = 0
        __L1.dashTimer = 0
        __L1.dashCooldown = 0
        __L1.reeisPhase = "idle"
        __L1:show("startScreen", false)
        __L1:show("pauseScreen", false)
        __L1:show("victoryScreen", false)
        __L1:show("defeatScreen", false)
        __L1:show("dialogBox", false)
        __L1.dialog = nil
        __L1.training = nil
        __L1.activity = nil
        __L1.activityCallback = nil
        __L1.comboStep = 0
        __L1.comboWindow = 0
        __L1:releaseInputs()
        local ____t_result_1365
        if __t(continuing) then
            ____t_result_1365 = __L1:load()
        else
            ____t_result_1365 = nil
        end
        local data = ____t_result_1365
        if __t(data) then
            local ____opt_1380 = window.CampaignRun
            if ____opt_1380 ~= nil then
                ____opt_1380 = ____opt_1380.restore
            end
            if ____opt_1380 ~= nil then
                local ____data_run_1378 = data.run
                local ____t_result_1373
                local ____t_1372 = __t
                local ____opt_1369 = window.Difficulty
                if ____opt_1369 ~= nil then
                    ____opt_1369 = ____opt_1369.getMode
                end
                local ____opt_result_1371
                if ____opt_1369 ~= nil then
                    ____opt_result_1371 = ____opt_1369(____opt_1369)
                end
                __O[1824] = ____opt_result_1371
                if ____t_1372(____opt_result_1371) then
                    ____t_result_1373 = __O[1824]
                else
                    ____t_result_1373 = "normal"
                end
                local ____temp_1377 = not __t(data.run)
                local ____t_1376 = __t
                local ____opt_1374 = data.q
                if ____opt_1374 ~= nil then
                    ____opt_1374 = ____opt_1374.nikolas
                end
                ____opt_1380(
                    ____opt_1380,
                    ____data_run_1378,
                    {
                        mode = ____t_result_1373,
                        legacy = ____temp_1377,
                        completed = not not ____t_1376(____opt_1374)
                    }
                )
            end
        else
            local ____opt_1384 = window.CampaignRun
            if ____opt_1384 ~= nil then
                ____opt_1384 = ____opt_1384.start
            end
            if ____opt_1384 ~= nil then
                ____opt_1384(____opt_1384)
            end
        end
        local ____t_result_1386
        if __t(data) then
            ____t_result_1386 = __assign(
                {},
                __L1:emptyQuest(),
                data.q
            )
        else
            ____t_result_1386 = __L1:emptyQuest()
        end
        __L1.q = ____t_result_1386
        local ____L1_q_1388 = __L1.q
        local ____isArray_result_1387
        if __isArray(__L1.q.carParts) then
            ____isArray_result_1387 = __L1.q.carParts
        else
            ____isArray_result_1387 = __arrL({}, 0)
        end
        ____L1_q_1388.carParts = ____isArray_result_1387
        local ____L1_q_1390 = __L1.q
        local ____isArray_result_1389
        if __isArray(__L1.q.notebooks) then
            ____isArray_result_1389 = __L1.q.notebooks
        else
            ____isArray_result_1389 = __arrL({}, 0)
        end
        ____L1_q_1390.notebooks = ____isArray_result_1389
        local ____L1_q_1392 = __L1.q
        local ____isArray_result_1391
        if __isArray(__L1.q.bivoltParts) then
            ____isArray_result_1391 = __L1.q.bivoltParts
        else
            ____isArray_result_1391 = __arrL({}, 0)
        end
        ____L1_q_1392.bivoltParts = ____isArray_result_1391
        local ____L1_q_1397 = __L1.q
        local ____L1_clamp_1396 = __L1.clamp
        local ____t_result_1395
        local ____t_1394 = __t
        local ____TS__Number_result_1393 = __TS__Number(__L1.q.bivoltCharges)
        __O[1825] = ____TS__Number_result_1393
        if ____t_1394(____TS__Number_result_1393) then
            ____t_result_1395 = __O[1825]
        else
            ____t_result_1395 = 0
        end
        ____L1_q_1397.bivoltCharges = ____L1_clamp_1396(
            __L1,
            math.floor(____t_result_1395),
            0,
            9
        )
        local ____L1_q_1403 = __L1.q
        local ____t_result_1402
        local ____t_1401 = __t
        local ____t_result_1400
        local ____t_1399 = __t
        local ____t_result_1398
        if __t(__L1.q.npcVisits) then
            ____t_result_1398 = type(__L1.q.npcVisits) == "table"
        else
            ____t_result_1398 = __L1.q.npcVisits
        end
        __O[1826] = ____t_result_1398
        if ____t_1399(____t_result_1398) then
            ____t_result_1400 = not __isArray(__L1.q.npcVisits)
        else
            ____t_result_1400 = __O[1826]
        end
        if ____t_1401(____t_result_1400) then
            ____t_result_1402 = __assign({}, __L1.q.npcVisits)
        else
            ____t_result_1402 = {}
        end
        ____L1_q_1403.npcVisits = ____t_result_1402
        for ____, id in __iterar((__keys(__L1.q.npcVisits))) do
            local count = __TS__Number(__get(__L1.q.npcVisits, id))
            local ____set_1406 = __set
            local ____L1_q_npcVisits_1405 = __L1.q.npcVisits
            local ____isFiniteN_result_1404
            if __isFiniteN(count) then
                ____isFiniteN_result_1404 = __L1:clamp(
                    math.floor(count),
                    0,
                    1000000
                )
            else
                ____isFiniteN_result_1404 = 0
            end
            ____set_1406(____L1_q_npcVisits_1405, id, ____isFiniteN_result_1404)
        end
        local ____opt_1412 = window.Progression
        if ____opt_1412 ~= nil then
            ____opt_1412 = ____opt_1412.restore
        end
        if ____opt_1412 ~= nil then
            local ____opt_result_1410
            if data ~= nil then
                ____opt_result_1410 = data.progression
            end
            ____opt_1412(____opt_1412, ____opt_result_1410)
        end
        local ____isArray_result_1418
        local ____isArray_1417 = __isArray
        local ____opt_result_1416
        if data ~= nil then
            ____opt_result_1416 = data.seenBossIntros
        end
        if ____isArray_1417(____opt_result_1416) then
            ____isArray_result_1418 = data.seenBossIntros
        else
            ____isArray_result_1418 = __arrL({}, 0)
        end
        __L1.seenBossIntros = ____isArray_result_1418
        __L1.items = {pencil = 0, eraser = 0, clip = 0}
        local ____t_1422 = __t
        local ____opt_result_1421
        if data ~= nil then
            ____opt_result_1421 = data.items
        end
        if ____t_1422(____opt_result_1421) then
            for ____, k in __iterar((__keys(__L1.items))) do
                local ____set_1428 = __set
                local ____L1_items_1427 = __L1.items
                local ____L1_clamp_1426 = __L1.clamp
                local ____t_result_1425
                local ____t_1424 = __t
                local ____TS__Number_result_1423 = __TS__Number(__get(data.items, k))
                __O[1827] = ____TS__Number_result_1423
                if ____t_1424(____TS__Number_result_1423) then
                    ____t_result_1425 = __O[1827]
                else
                    ____t_result_1425 = 0
                end
                ____set_1428(
                    ____L1_items_1427,
                    k,
                    ____L1_clamp_1426(
                        __L1,
                        math.floor(____t_result_1425),
                        0,
                        999
                    )
                )
            end
        end
        local ____isArray_result_1433
        local ____isArray_1432 = __isArray
        local ____opt_result_1431
        if data ~= nil then
            ____opt_result_1431 = data.collected
        end
        if ____isArray_1432(____opt_result_1431) then
            ____isArray_result_1433 = __call(
                data.collected,
                "filter",
                function(____, x) return type(x) == "string" end
            )
        else
            ____isArray_result_1433 = __arrL({}, 0)
        end
        __L1.collected = ____isArray_result_1433
        local ____isArray_result_1438
        local ____isArray_1437 = __isArray
        local ____opt_result_1436
        if data ~= nil then
            ____opt_result_1436 = data.minionKills
        end
        if ____isArray_1437(____opt_result_1436) then
            ____isArray_result_1438 = __call(
                data.minionKills,
                "filter",
                function(____, x) return type(x) == "string" end
            )
        else
            ____isArray_result_1438 = __arrL({}, 0)
        end
        __L1.minionKills = ____isArray_result_1438
        local ____L1_clamp_1445 = __L1.clamp
        local ____t_result_1444
        local ____t_1443 = __t
        local ____opt_result_1441
        if data ~= nil then
            ____opt_result_1441 = data.weapon
        end
        local ____TS__Number_result_1442 = __TS__Number(____opt_result_1441)
        __O[1828] = ____TS__Number_result_1442
        if ____t_1443(____TS__Number_result_1442) then
            ____t_result_1444 = __O[1828]
        else
            ____t_result_1444 = 0
        end
        __L1.weapon = ____L1_clamp_1445(
            __L1,
            math.floor(____t_result_1444),
            0,
            2
        )
        __L1.player = __L1:basePlayer()
        local ____t_result_1453
        if __t(data) then
            local ____t_result_1452
            local ____t_1451 = __t
            local ____opt_1448 = window.LugaresC1
            if ____opt_1448 ~= nil then
                ____opt_1448 = ____opt_1448.tem
            end
            local ____opt_result_1450
            if ____opt_1448 ~= nil then
                ____opt_result_1450 = ____opt_1448(
                    ____opt_1448,
                    __TS__Number(data.scene)
                )
            end
            if ____t_1451(____opt_result_1450) then
                ____t_result_1452 = __TS__Number(data.scene)
            else
                ____t_result_1452 = __L1:clamp(
                    data.scene,
                    0,
                    __len(__L1.scenes) - 1
                )
            end
            ____t_result_1453 = ____t_result_1452
        else
            ____t_result_1453 = 0
        end
        __L1.scene = ____t_result_1453
        if __t(__L1.scene == 3 and not __t(__L1.q.trained)) then
            __L1.scene = 2
        end
        local ____L1_player_1457 = __L1.player
        local ____t_result_1456
        if __t(data) then
            local ____table_maxHP_1455 = __L1:bonus().maxHP
            local ____t_result_1454
            if __t(data.hp) then
                ____t_result_1454 = data.hp
            else
                ____t_result_1454 = 100
            end
            ____t_result_1456 = math.min(
                ____table_maxHP_1455,
                math.max(55, ____t_result_1454)
            )
        else
            ____t_result_1456 = __L1:bonus().maxHP
        end
        ____L1_player_1457.hp = ____t_result_1456
        local ____L1_player_1460 = __L1.player
        local ____t_result_1459
        if __t(data) then
            local ____t_result_1458
            if __t(data.papers) then
                ____t_result_1458 = data.papers
            else
                ____t_result_1458 = 30
            end
            ____t_result_1459 = math.max(15, ____t_result_1458)
        else
            ____t_result_1459 = 30
        end
        ____L1_player_1460.papers = ____t_result_1459
        __L1.vehicle = false
        __L1.camera = 0
        __L1.reeisCooldown = 0
        __L1.reeisTimer = 0
        __L1.attackCooldown = 0
        __L1.fartCooldown = 0
        __L1.killCount = 0
        __L1:populate()
        local ____opt_result_1465
        if data ~= nil then
            ____opt_result_1465 = data.position
        end
        local ____opt_result_1466
        if ____opt_result_1465 ~= nil then
            ____opt_result_1466 = ____opt_result_1465.scene
        end
        if ____opt_result_1466 == __L1.scene then
            local savedX = __TS__Number(data.position.x)
            local ____L1_clamp_1468 = __L1.clamp
            local ____isFiniteN_result_1467
            if __isFiniteN(savedX) then
                ____isFiniteN_result_1467 = savedX
            else
                ____isFiniteN_result_1467 = 230
            end
            local px = ____L1_clamp_1468(__L1, ____isFiniteN_result_1467, 30, __L1.WORLD - 30)
            __L1.player.x = px
            __L1.player.y = __L1.FLOOR
            __L1.player.vy = 0
            __L1.lastSafeX = __L1.player.x
            __L1.camera = __L1:clamp(__L1.player.x - __L1.W * 0.36, 0, __L1.WORLD - __L1.W)
        end
        __L1:updateUI()
        __L1:save()
        __L1.canvas:focus()
        if not __t(continuing) then
            __L1:startCutscene(
                "intro",
                function()
                    __L1:toast("A aventura começou! Encontre Lucas à direita.")
                    __L1:openSwiftGuide()
                end
            )
        else
            local ____t_1470 = __t
            local ____t_result_1469
            if __t(__L1.q.nikolas) then
                ____t_result_1469 = not __t(__L1.q.celebrationSeen)
            else
                ____t_result_1469 = __L1.q.nikolas
            end
            if ____t_1470(____t_result_1469) then
                __L1:beginCelebration()
            else
                local ____t_1475 = __t
                local ____t_result_1474
                if __t(__L1.q.nikolas) then
                    local ____t_result_1473
                    local ____t_1472 = __t
                    local ____temp_1471 = not __t(__L1.q.jorgeSeen)
                    __O[1829] = ____temp_1471
                    if ____t_1472(____temp_1471) then
                        ____t_result_1473 = __O[1829]
                    else
                        ____t_result_1473 = __L1.q.jorgeStarted
                    end
                    ____t_result_1474 = ____t_result_1473
                else
                    ____t_result_1474 = __L1.q.nikolas
                end
                if ____t_1475(____t_result_1474) then
                    __L1:beginPostCelebration()
                else
                    __L1:toast("Aventura retomada! Seu objetivo está no painel.")
                end
            end
        end
    end
    __L1.returnToMenu = function(self)
        if __t(__L1.sandbox) then
            __L1:exitSandbox()
        end
        local ____opt_1478 = window.CampaignRun
        if ____opt_1478 ~= nil then
            ____opt_1478 = ____opt_1478.setActive
        end
        if ____opt_1478 ~= nil then
            ____opt_1478(____opt_1478, false)
        end
        if __t(__L1.started) then
            __L1:save()
        end
        __L1:resetBivolt()
        __L1.ollyanEncounter = nil
        __L1.ollyanRetryGrace = 0
        __L1:releaseInputs()
        if __t(__L1.activeBoss) then
            __L1.activeBoss.hp = __L1.activeBoss.max
            __L1.activeBoss.x = __L1.activeBoss.homeX
            __L1:bossDefaults(__L1.activeBoss)
        end
        if __t(__L1.started) then
            __L1.menuLookQuest = __L1.q
        end
        __L1.started = false
        __L1.playing = false
        __L1.paused = false
        __L1.won = false
        __L1.defeated = false
        __L1.chapterEnded = false
        __L1.vehicle = false
        __L1.dialog = nil
        __L1.dialogCallback = nil
        __L1.cutscene = nil
        __L1.cutsceneCallback = nil
        __L1.training = nil
        __L1.activity = nil
        __L1.activityCallback = nil
        __L1.room = nil
        __L1.arena = nil
        __L1.activeBoss = nil
        __L1.routeTransition = nil
        __L1.reeisPhase = "idle"
        __L1.reeisTimer = 0
        local ____opt_1482 = window.CampaignVfx
        if ____opt_1482 ~= nil then
            ____opt_1482 = ____opt_1482.reset
        end
        if ____opt_1482 ~= nil then
            ____opt_1482(____opt_1482)
        end
        __L1.shots = __arrL({}, 0)
        __L1.hazards = __arrL({}, 0)
        __L1.minions = __call(
            __L1.minions,
            "filter",
            function(____, m) return not __t(m.summoned) end
        )
        __L1.particles = __arrL({}, 0)
        __L1.damageTexts = __arrL({}, 0)
        __L1.afterimages = __arrL({}, 0)
        __L1:resetWorldSize()
        __L1.player.x = __L1:clamp(__L1.lastSafeX, 30, __L1.WORLD - 30)
        __L1.player.y = __L1.FLOOR
        __L1.player.vy = 0
        __L1.player.ground = true
        __L1.camera = __L1:clamp(__L1.player.x - __L1.W * 0.36, 0, __L1.WORLD - __L1.W)
        for ____, id in __iterar((__arrL({
            "chapterEndScreen",
            "pauseScreen",
            "victoryScreen",
            "defeatScreen",
            "dialogBox",
            "dialogControls",
            "cinematicOverlay",
            "roomOverlay",
            "activityOverlay",
            "trainingAction"
        }, 10))) do
            __L1:show(id, false)
        end
        __L1:show("startScreen", true)
        __L1:updateContinue()
        __L1:updateUI()
        __L1:emitGameEvent("game-menu")
        return true
    end
    __L1.pause = function(self)
        local ____opt_1486 = window.CampaignRun
        if ____opt_1486 ~= nil then
            ____opt_1486 = ____opt_1486.setActive
        end
        if ____opt_1486 ~= nil then
            ____opt_1486(____opt_1486, false)
        end
        __L1:releaseInputs()
        local ____t_1495 = __t
        local ____t_result_1494
        local ____t_1493 = __t
        local ____t_result_1492
        local ____t_1491 = __t
        local ____t_result_1490
        local ____t_1489 = __t
        local ____temp_1488 = not __t(__L1.started)
        __O[1830] = ____temp_1488
        if ____t_1489(____temp_1488) then
            ____t_result_1490 = __O[1830]
        else
            ____t_result_1490 = __L1.won
        end
        __O[1831] = ____t_result_1490
        if ____t_1491(____t_result_1490) then
            ____t_result_1492 = __O[1831]
        else
            ____t_result_1492 = __L1.defeated
        end
        __O[1832] = ____t_result_1492
        if ____t_1493(____t_result_1492) then
            ____t_result_1494 = __O[1832]
        else
            ____t_result_1494 = __L1.chapterEnded
        end
        if ____t_1495(____t_result_1494) then
            return
        end
        __L1.paused = true
        __L1:show("pauseScreen", true)
        __L1:updateUI()
        __L1:save()
    end
    __L1.resume = function(self)
        __L1:releaseInputs()
        local ____t_1498 = __t
        local ____opt_1496 = __L1.sandbox
        if ____opt_1496 ~= nil then
            ____opt_1496 = ____opt_1496.result
        end
        if ____t_1498(____opt_1496) then
            __L1:toast("Escolha TENTAR DE NOVO ou VOLTAR À CAMPANHA.")
            __L1:show("pauseScreen", true)
            return
        end
        if __t(__L1.chapterEnded) then
            return
        end
        __L1.paused = false
        __L1:show("pauseScreen", false)
        __L1.canvas:focus()
        __L1:updateUI()
    end
    __L1.reset = function(self)
        __L1:safe(function() return window.localStorage:removeItem(__L1.SAVE) end)
        __L1.q = __L1:emptyQuest()
        __L1:start(false)
    end
    __L1.action = function(self, a)
        local ____t_1505 = __t
        local ____t_result_1504
        if __t(__L1.inputCaptured) then
            ____t_result_1504 = __L1.inputCaptured
        else
            local ____opt_1501 = window.Arena
            if ____opt_1501 ~= nil then
                ____opt_1501 = ____opt_1501.isOpen
            end
            local ____opt_result_1503
            if ____opt_1501 ~= nil then
                ____opt_result_1503 = ____opt_1501(____opt_1501)
            end
            ____t_result_1504 = ____opt_result_1503
        end
        if ____t_1505(____t_result_1504) then
            return
        end
        local ____t_1513 = __t
        local ____t_result_1512
        local ____t_1511 = __t
        local ____t_result_1510
        local ____t_1507 = __t
        local ____temp_1506 = __L1.scene >= 12
        __O[1833] = ____temp_1506
        if ____t_1507(____temp_1506) then
            ____t_result_1510 = __O[1833]
        else
            local ____opt_1508 = window.C2Luta
            if ____opt_1508 ~= nil then
                ____opt_1508 = ____opt_1508.skin
            end
            ____t_result_1510 = ____opt_1508
        end
        __O[1834] = ____t_result_1510
        if ____t_1511(____t_result_1510) then
            ____t_result_1512 = window.CampanhaPoderes
        else
            ____t_result_1512 = __O[1834]
        end
        if ____t_1513(____t_result_1512) then
            if __t(__call(
                window.CampanhaPoderes:sairam(),
                "includes",
                a
            )) then
                return
            end
            if __t(a == "poder1" or a == "poder2") then
                local ____this_1515
                ____this_1515 = window.CampanhaPoderes
                local ____opt_1514 = ____this_1515.acionarNoJogo
                if ____opt_1514 ~= nil then
                    ____opt_1514(____this_1515, a == "poder1" and 0 or 1)
                end
                return
            end
        elseif __t(a == "poder1" or a == "poder2") then
            return
        end
        if a == "interact" then
            __L1:interact()
            return
        end
        local ____t_1531 = __t
        local ____t_result_1530
        local ____t_1529 = __t
        local ____t_result_1528
        local ____t_1527 = __t
        local ____t_result_1526
        local ____t_1525 = __t
        local ____t_result_1524
        local ____t_1523 = __t
        local ____t_result_1522
        local ____t_1521 = __t
        local ____t_result_1520
        local ____t_1519 = __t
        local ____t_result_1518
        local ____t_1517 = __t
        local ____temp_1516 = not __t(__L1.started)
        __O[1835] = ____temp_1516
        if ____t_1517(____temp_1516) then
            ____t_result_1518 = __O[1835]
        else
            ____t_result_1518 = __L1.paused
        end
        __O[1836] = ____t_result_1518
        if ____t_1519(____t_result_1518) then
            ____t_result_1520 = __O[1836]
        else
            ____t_result_1520 = __L1.dialog
        end
        __O[1837] = ____t_result_1520
        if ____t_1521(____t_result_1520) then
            ____t_result_1522 = __O[1837]
        else
            ____t_result_1522 = __L1.won
        end
        __O[1838] = ____t_result_1522
        if ____t_1523(____t_result_1522) then
            ____t_result_1524 = __O[1838]
        else
            ____t_result_1524 = __L1.defeated
        end
        __O[1839] = ____t_result_1524
        if ____t_1525(____t_result_1524) then
            ____t_result_1526 = __O[1839]
        else
            ____t_result_1526 = __L1.room
        end
        __O[1840] = ____t_result_1526
        if ____t_1527(____t_result_1526) then
            ____t_result_1528 = __O[1840]
        else
            ____t_result_1528 = __L1.cutscene
        end
        __O[1841] = ____t_result_1528
        if ____t_1529(____t_result_1528) then
            ____t_result_1530 = __O[1841]
        else
            ____t_result_1530 = __L1.routeTransition
        end
        if ____t_1531(____t_result_1530) then
            return
        end
        if a == "bivolt" then
            __L1:activateBivolt()
            return
        end
        if __t(__L1.ollyanEncounter) then
            if __t(__call(
                __arrL({"paper", "fart", "dash"}, 3),
                "includes",
                a
            )) then
                window.OllyanEncounter:attack(__L1.ollyanEncounter, a)
            elseif a == "vehicle" then
                __L1:toast("E ou FALAR faz o carro voltar ao baile.")
            end
            __L1:updateUI()
            return
        end
        if a == "activity" then
            __L1:submitActivity()
            return
        end
        if __t(__L1.activity) then
            return
        end
        if a == "train" then
            __L1:submitTraining()
            return
        end
        local ____t_1534 = __t
        local ____opt_1532 = __L1.training
        if ____opt_1532 ~= nil then
            ____opt_1532 = ____opt_1532.active
        end
        if ____t_1534(____opt_1532) then
            return
        end
        if a == "dash" then
            __L1:dash()
            return
        end
        if a == "taunt" then
            __L1:taunt()
            return
        end
        if a == "paper" then
            __L1:paperAttack()
        end
        if a == "fart" then
            __L1:fartAttack()
        end
        if a == "reeis" then
            __L1:summon()
        end
        if a == "vehicle" then
            __L1:toggleVehicle()
        end
    end
    __L1.craft = function(self)
        local ____t_1556 = __t
        local ____t_result_1555
        local ____t_1554 = __t
        local ____t_result_1553
        local ____t_1552 = __t
        local ____t_result_1551
        local ____t_1550 = __t
        local ____t_result_1549
        local ____t_1548 = __t
        local ____t_result_1547
        local ____t_1546 = __t
        local ____t_result_1545
        local ____t_1544 = __t
        local ____t_result_1543
        local ____t_1540 = __t
        local ____t_result_1539
        local ____t_1538 = __t
        local ____t_result_1537
        local ____t_1536 = __t
        local ____temp_1535 = not __t(__L1.started)
        __O[1842] = ____temp_1535
        if ____t_1536(____temp_1535) then
            ____t_result_1537 = __O[1842]
        else
            ____t_result_1537 = __L1.paused
        end
        __O[1843] = ____t_result_1537
        if ____t_1538(____t_result_1537) then
            ____t_result_1539 = __O[1843]
        else
            ____t_result_1539 = __L1.dialog
        end
        __O[1844] = ____t_result_1539
        if ____t_1540(____t_result_1539) then
            ____t_result_1543 = __O[1844]
        else
            local ____opt_1541 = __L1.training
            if ____opt_1541 ~= nil then
                ____opt_1541 = ____opt_1541.active
            end
            ____t_result_1543 = ____opt_1541
        end
        __O[1845] = ____t_result_1543
        if ____t_1544(____t_result_1543) then
            ____t_result_1545 = __O[1845]
        else
            ____t_result_1545 = __L1.activity
        end
        __O[1846] = ____t_result_1545
        if ____t_1546(____t_result_1545) then
            ____t_result_1547 = __O[1846]
        else
            ____t_result_1547 = __L1.won
        end
        __O[1847] = ____t_result_1547
        if ____t_1548(____t_result_1547) then
            ____t_result_1549 = __O[1847]
        else
            ____t_result_1549 = __L1.defeated
        end
        __O[1848] = ____t_result_1549
        if ____t_1550(____t_result_1549) then
            ____t_result_1551 = __O[1848]
        else
            ____t_result_1551 = __L1.room
        end
        __O[1849] = ____t_result_1551
        if ____t_1552(____t_result_1551) then
            ____t_result_1553 = __O[1849]
        else
            ____t_result_1553 = __L1.cutscene
        end
        __O[1850] = ____t_result_1553
        if ____t_1554(____t_result_1553) then
            ____t_result_1555 = __O[1850]
        else
            ____t_result_1555 = __L1.routeTransition
        end
        if ____t_1556(____t_result_1555) then
            return false
        end
        if __t(__L1.scene ~= 0 or math.abs(__L1.player.x - __L1.npcInfo.kaua.x) > 110) then
            __L1:toast("Procure Kauã na roça para fabricar uma arma com materiais escolares.")
            return false
        end
        if __L1.weapon >= 2 then
            __L1:say(__arrL(
                {{
                    name = "Kauã · inventor",
                    text = ((tostring(__L1.kauaVoice) .. " Seu Canhão de estojo já está no máximo! Você ainda tem ") .. tostring(__L1:materialCount())) .. " materiais. Use J para disparar três projéteis de fantasia de uma vez!"
                }},
                1
            ))
            return false
        end
        local cost = __L1.weapon == 0 and 3 or 5
        local next = __L1.weapon + 1
        if __L1:materialCount() < cost then
            __L1:say(__arrL(
                {
                    {
                        name = "Kauã · inventor",
                        text = ((((((((((((tostring(__L1.kauaVoice) .. " Você tem ") .. tostring(__L1:materialCount())) .. " materiais: ") .. tostring(__L1.items.pencil)) .. " lápis, ") .. tostring(__L1.items.eraser)) .. " borracha e ") .. tostring(__L1.items.clip)) .. " clipe. Preciso de ") .. tostring(cost)) .. " materiais, em qualquer combinação, para fabricar ") .. tostring(__get(__L1.weaponNames, next))) .. "."
                    },
                    {
                        name = "Kauã · inventor",
                        text = ("Faltam " .. tostring(cost - __L1:materialCount())) .. "! Pegue os materiais brilhantes pela roça e pela escola. Depois, volte e aperte E. Não precisa trocar seu papel nem seu gás!"
                    }
                },
                2
            ))
            return false
        end
        __L1:say(
            __arrL(
                {
                    {
                        name = "Kauã · inventor",
                        text = (((((((tostring(__L1.kauaVoice) .. " Inventário: ") .. tostring(__L1:materialCount())) .. " materiais. Vou trocar ") .. tostring(cost)) .. " por ") .. tostring(__get(__L1.weaponNames, next))) .. ". ") .. (next == 1 and "Suas bolinhas de papel ganham um lançamento bem mais forte!" or "Cada disparo lança três projéteis de fantasia!")
                    },
                    {
                        name = "Kauã · inventor",
                        text = ((("Aperte FABRICAR ou E para gastar " .. tostring(cost)) .. " materiais e equipar ") .. tostring(__get(__L1.weaponNames, next))) .. ".",
                        actionLabel = ("FABRICAR · " .. tostring(cost)) .. " MATERIAIS  ↵"
                    }
                },
                2
            ),
            function()
                local remaining = cost
                for ____, ____type in __iterar((__arrL({"pencil", "eraser", "clip"}, 3))) do
                    local use = math.min(
                        __get(__L1.items, ____type),
                        remaining
                    )
                    __set(
                        __L1.items,
                        ____type,
                        __get(__L1.items, ____type) - use
                    )
                    remaining = remaining - use
                end
                __L1.weapon = next
                __L1:fx(
                    __L1.player.x,
                    __L1.player.y - 40,
                    "#9fdac1",
                    35,
                    150
                )
                __L1:beep(840, 0.22, "triangle")
                __L1:toast(((tostring(__get(__L1.weaponNames, __L1.weapon)) .. " equipado! Aperte J. ") .. tostring(__L1:materialCount())) .. " materiais restantes.")
                __L1:updateUI()
                __L1:save()
            end
        )
        return true
    end
    __L1.taunt = function(self)
        local ____t_1578 = __t
        local ____t_result_1577
        local ____t_1576 = __t
        local ____t_result_1575
        local ____t_1574 = __t
        local ____t_result_1573
        local ____t_1572 = __t
        local ____t_result_1571
        local ____t_1570 = __t
        local ____t_result_1569
        local ____t_1568 = __t
        local ____t_result_1567
        local ____t_1566 = __t
        local ____t_result_1565
        local ____t_1562 = __t
        local ____t_result_1561
        local ____t_1560 = __t
        local ____t_result_1559
        local ____t_1558 = __t
        local ____temp_1557 = not __t(__L1.started)
        __O[1851] = ____temp_1557
        if ____t_1558(____temp_1557) then
            ____t_result_1559 = __O[1851]
        else
            ____t_result_1559 = __L1.paused
        end
        __O[1852] = ____t_result_1559
        if ____t_1560(____t_result_1559) then
            ____t_result_1561 = __O[1852]
        else
            ____t_result_1561 = __L1.dialog
        end
        __O[1853] = ____t_result_1561
        if ____t_1562(____t_result_1561) then
            ____t_result_1565 = __O[1853]
        else
            local ____opt_1563 = __L1.training
            if ____opt_1563 ~= nil then
                ____opt_1563 = ____opt_1563.active
            end
            ____t_result_1565 = ____opt_1563
        end
        __O[1854] = ____t_result_1565
        if ____t_1566(____t_result_1565) then
            ____t_result_1567 = __O[1854]
        else
            ____t_result_1567 = __L1.activity
        end
        __O[1855] = ____t_result_1567
        if ____t_1568(____t_result_1567) then
            ____t_result_1569 = __O[1855]
        else
            ____t_result_1569 = __L1.won
        end
        __O[1856] = ____t_result_1569
        if ____t_1570(____t_result_1569) then
            ____t_result_1571 = __O[1856]
        else
            ____t_result_1571 = __L1.defeated
        end
        __O[1857] = ____t_result_1571
        if ____t_1572(____t_result_1571) then
            ____t_result_1573 = __O[1857]
        else
            ____t_result_1573 = __L1.room
        end
        __O[1858] = ____t_result_1573
        if ____t_1574(____t_result_1573) then
            ____t_result_1575 = __O[1858]
        else
            ____t_result_1575 = __L1.cutscene
        end
        __O[1859] = ____t_result_1575
        if ____t_1576(____t_result_1575) then
            ____t_result_1577 = __O[1859]
        else
            ____t_result_1577 = __L1.routeTransition
        end
        if ____t_1578(____t_result_1577) then
            return false
        end
        if __L1.scene ~= 3 then
            __L1:toast("O SARUÊ agora é uma armadilha no chão. Não pise nela perto de Marco!")
            return false
        end
        local nik = __call(
            __L1.enemies,
            "find",
            function(____, e)
                local ____t_result_1581
                local ____t_1580 = __t
                local ____temp_1579 = e.type == "nikolas" and __gt(e.hp, 0)
                __O[1860] = ____temp_1579
                if ____t_1580(____temp_1579) then
                    ____t_result_1581 = math.abs(e.x - __L1.player.x) < 560
                else
                    ____t_result_1581 = __O[1860]
                end
                return ____t_result_1581
            end
        )
        if not __t(nik) then
            __L1:toast("Chegue perto de Nikolas para provocar o nariz de batata.")
            return false
        end
        if __L1.tauntCooldown > 0 then
            return false
        end
        __L1.tauntCooldown = 4
        __L1:floating(__L1.player.x, __L1.player.y - 115, "Ô NARIZ DE BATATA!", "#ffe3ad")
        __L1:floating(nik.x, nik.y - 135, "É AERODINÂMICO!", "#ecc39b")
        __L1:beep(210, 0.12, "triangle")
        return true
    end
    __L1.startActivity = function(self, kind)
        local ____t_1584 = __t
        local ____opt_1582 = window.Activities
        if ____opt_1582 ~= nil then
            ____opt_1582 = ____opt_1582.create
        end
        if not ____t_1584(____opt_1582) then
            __L1:toast("Minigame indisponível. Recarregue a atualização.")
            return false
        end
        if __t(kind == "football" and __L1.scene ~= 7) then
            return false
        end
        local ____t_1588 = __t
        local ____temp_1587 = kind == "quiz"
        if ____temp_1587 then
            local ____opt_1585 = __L1.room
            if ____opt_1585 ~= nil then
                ____opt_1585 = ____opt_1585.id
            end
            ____temp_1587 = ____opt_1585 ~= "miqueias"
        end
        if ____t_1588(____temp_1587) then
            return false
        end
        local ____t_1592 = __t
        local ____t_result_1591
        local ____t_1590 = __t
        local ____temp_1589 = kind == "dinner"
        __O[1861] = ____temp_1589
        if ____t_1590(____temp_1589) then
            ____t_result_1591 = __L1.scene ~= __L1.npcInfo.amanda.scene or __getq(
                __L1:closestNPC(),
                0
            ) ~= "amanda"
        else
            ____t_result_1591 = __O[1861]
        end
        if ____t_1592(____t_result_1591) then
            return false
        end
        __L1:releaseInputs()
        __L1.vehicle = false
        __L1.activity = window.Activities:create(
            kind,
            {
                level = __L1:levelState().level,
                trained = __L1.q.trained,
                dating = __L1.q.amandaDating
            }
        )
        __L1.activityCallback = kind
        __L1:updateUI()
        return true
    end
    __L1.submitActivity = function(self, value)
        local ____t_1600 = __t
        local ____t_result_1599
        local ____t_1598 = __t
        local ____t_result_1597
        local ____t_1596 = __t
        local ____t_result_1595
        local ____t_1594 = __t
        local ____temp_1593 = not __t(__L1.activity)
        __O[1862] = ____temp_1593
        if ____t_1594(____temp_1593) then
            ____t_result_1595 = __O[1862]
        else
            ____t_result_1595 = __L1.paused
        end
        __O[1863] = ____t_result_1595
        if ____t_1596(____t_result_1595) then
            ____t_result_1597 = __O[1863]
        else
            ____t_result_1597 = __L1.dialog
        end
        __O[1864] = ____t_result_1597
        if ____t_1598(____t_result_1597) then
            ____t_result_1599 = __O[1864]
        else
            ____t_result_1599 = __L1.cutscene
        end
        if ____t_1600(____t_result_1599) then
            return false
        end
        local result = window.Activities:submit(__L1.activity, value)
        local ____t_1603 = __t
        local ____opt_1601 = __L1.activity
        if ____opt_1601 ~= nil then
            ____opt_1601 = ____opt_1601.done
        end
        if ____t_1603(____opt_1601) then
            __L1:finishActivity()
        else
            __L1:updateUI()
        end
        return result
    end
    __L1.finishActivity = function(self)
        if not __t(__L1.activity) then
            return
        end
        local result = __L1.activity
        local kind = __L1.activityCallback
        __L1.activity = nil
        __L1.activityCallback = nil
        __L1:releaseInputs()
        if kind == "dinner" then
            local ____t_1605 = __t
            local ____t_result_1604
            if __t(result.success) then
                ____t_result_1604 = not __t(__L1.q.amandaDating)
            else
                ____t_result_1604 = result.success
            end
            if ____t_1605(____t_result_1604) then
                __L1.q.amandaDating = true
                __L1:awardXP(window.Campaign.rewards.amanda, "quest-amanda")
                __L1:save()
                __L1:say(__arrL({"Quero, uai! Agora eu tenho dois motivos pra dividir a sobremesa.", {name = "Amanda", text = "Um é sua namorada. O outro é o tamanho do seu olho, né?"}, {name = "Amanda", text = "Passa na Bigodon. O Davi guardou o Jaglion que eu e o Vitor desenhamos pra você."}}, 3))
            else
                __L1:toast(__t(__L1.q.amandaDating) and "De volta à praça com Amanda." or "O convite continua de pé. Fale com Amanda para tentar outra vez.")
            end
            __L1:updateUI()
            return
        end
        if __t(result.success) then
            if kind == "football" then
                local first = not __t(__L1.q.mota)
                __L1.q.mota = true
                __L1:awardXP(
                    __t(first) and 300 or 70,
                    __t(first) and "quest-mota" or nil
                )
                __L1:say(
                    __arrL(
                        {
                            {
                                name = "Mota",
                                text = __t(first) and "GOOOL! Três gols! Agora o dash é seu: L, Shift ou o botão » pra escapar dos golpes." or "Gol de quem treina! XP ganho. Pode repetir sempre que quiser evoluir."
                            },
                            "O bolo vai receber um passe de respeito!"
                        },
                        2
                    ),
                    function() return __L1:toast("Dash desbloqueado! Distribua seus pontos de nível nos atributos.") end
                )
            else
                __L1.q.miqueias = true
                __L1:awardXP(260, "quest-miqueias")
                __L1:say(
                    __arrL({{name = "Professor Miqueias", text = "ALLRIGHT! You win the English, beleza creuza! Your papaias got elemental powers, concorda ou sem corda?"}, "A aula melhorou até meu papel!", {name = "Professor Miqueias", text = "Level3 fire, level5 electric! Go level up and visit the favela, é ou não é?"}}, 3),
                    function() return __L1:toast("Papaias elementais liberadas! Evolua o nível para fortalecer os disparos.") end
                )
            end
        else
            __L1:toast(kind == "football" and "Quase! Converse com Mota para tentar os chutes de novo." or "Tente novamente com o professor.")
        end
        __L1:updateUI()
        __L1:save()
    end
    __L1.cancelActivity = function(self)
        if not __t(__L1.activity) then
            return false
        end
        local ____opt_1608 = window.Activities
        if ____opt_1608 ~= nil then
            ____opt_1608 = ____opt_1608.cancel
        end
        if ____opt_1608 ~= nil then
            ____opt_1608(____opt_1608, __L1.activity)
        end
        __L1.activity = nil
        __L1.activityCallback = nil
        __L1:releaseInputs()
        __L1:updateUI()
        __L1:toast("Minigame interrompido. Converse para tentar novamente.")
        return true
    end
    __L1.setTrainingZone = function(self)
        local widths = __arrL({0.3, 0.26, 0.22}, 3)
        local starts = __arrL({0.34, 0.49, 0.24}, 3)
        __L1.training.zoneStart = __get(starts, __L1.training.round - 1)
        __L1.training.zoneEnd = __L1.training.zoneStart + __get(widths, __L1.training.round - 1)
        __L1.training.speed = 0.64 + (__L1.training.round - 1) * 0.14
    end
    __L1.startTraining = function(self)
        if __L1.scene ~= 2 then
            return
        end
        __L1.q.training = true
        __L1.vehicle = false
        __L1:releaseInputs()
        __L1.player.vx = 0
        __L1.player.vy = 0
        __L1.player.y = __L1.FLOOR
        __L1.player.ground = true
        __L1.player.facing = 1
        __L1.training = {
            active = true,
            round = 1,
            hits = 0,
            totalHits = 0,
            score = 0,
            combo = 0,
            bestCombo = 0,
            misses = 0,
            marker = 0,
            direction = 1,
            cooldown = 0.35,
            zoneStart = 0.34,
            zoneEnd = 0.64,
            speed = 0.64,
            feedback = "ESPERE O MARCADOR ENTRAR NO VERDE",
            feedbackGood = true
        }
        __L1:setTrainingZone()
        __L1:updateUI()
        __L1:save()
        __L1:toast("Treino: E, Espaço ou ACERTAR no verde. Você pode errar e tentar de novo!")
    end
    __L1.cancelTraining = function(self)
        local ____t_1612 = __t
        local ____opt_1610 = __L1.training
        if ____opt_1610 ~= nil then
            ____opt_1610 = ____opt_1610.active
        end
        if not ____t_1612(____opt_1610) then
            return
        end
        __L1.training = nil
        __L1:releaseInputs()
        __L1:updateUI()
        __L1:save()
        __L1:toast("Treino interrompido. Fale com Caleb para tentar de novo.")
    end
    __L1.updateTraining = function(self, dt)
        __L1.training.cooldown = math.max(0, __L1.training.cooldown - dt)
        local ____L1_training_1613, ____marker_1614 = __L1.training, "marker"
        ____L1_training_1613[____marker_1614] = ____L1_training_1613[____marker_1614] + __L1.training.direction * __L1.training.speed * dt
        if __gt(__L1.training.marker, 1) then
            __L1.training.marker = 2 - __L1.training.marker
            __L1.training.direction = -1
        elseif __lt(__L1.training.marker, 0) then
            __L1.training.marker = __TS__Number(-__L1.training.marker)
            __L1.training.direction = 1
        end
    end
    __L1.submitTraining = function(self)
        local ____t_1625 = __t
        local ____t_result_1624
        local ____t_1623 = __t
        local ____t_result_1622
        local ____t_1621 = __t
        local ____t_result_1620
        local ____t_1619 = __t
        local ____t_1617 = __t
        local ____opt_1615 = __L1.training
        if ____opt_1615 ~= nil then
            ____opt_1615 = ____opt_1615.active
        end
        local ____temp_1618 = not ____t_1617(____opt_1615)
        __O[1865] = ____temp_1618
        if ____t_1619(____temp_1618) then
            ____t_result_1620 = __O[1865]
        else
            ____t_result_1620 = __L1.paused
        end
        __O[1866] = ____t_result_1620
        if ____t_1621(____t_result_1620) then
            ____t_result_1622 = __O[1866]
        else
            ____t_result_1622 = __L1.dialog
        end
        __O[1867] = ____t_result_1622
        if ____t_1623(____t_result_1622) then
            ____t_result_1624 = __O[1867]
        else
            ____t_result_1624 = __gt(__L1.training.cooldown, 0)
        end
        if ____t_1625(____t_result_1624) then
            return false
        end
        local t = __L1.training
        t.cooldown = 0.3
        if __t(__ge(t.marker, t.zoneStart) and __le(t.marker, t.zoneEnd)) then
            t.golpeEm = __L1.time
            t.hits = t.hits + 1
            t.totalHits = t.totalHits + 1
            t.combo = t.combo + 1
            t.bestCombo = math.max(t.bestCombo, t.combo)
            local center = __add(t.zoneStart, t.zoneEnd) / 2
            local perfect = math.abs(t.marker - center) < 0.045
            t.score = t.score + ((__t(perfect) and 150 or 100) + math.min(5, t.combo) * 20)
            t.feedback = __t(perfect) and "PERFEITO! REFLEXO DE CAMPEÃO!" or "BOA! MANDOU BEM!"
            t.feedbackGood = true
            __L1:beep(
                __t(perfect) and 930 or 720,
                0.12,
                "triangle"
            )
            __L1:fx(
                __L1.player.x,
                __L1.player.y - 50,
                "#c9e799",
                12,
                110
            )
            if __ge(t.hits, 2) then
                if __ge(t.round, 3) then
                    __L1:finishTraining()
                    return true
                end
                t.round = t.round + 1
                t.hits = 0
                t.cooldown = 0.65
                t.feedback = ("RODADA " .. tostring(t.round)) .. "! A FAIXA MUDOU DE LUGAR."
                __L1:setTrainingZone()
            end
        else
            t.misses = t.misses + 1
            t.combo = 0
            t.feedback = "QUASE! ESPERE O VERDE E TENTE DE NOVO."
            t.feedbackGood = false
            __L1:beep(170, 0.1, "triangle")
        end
        __L1:updateUI()
        return true
    end
    __L1.finishTraining = function(self)
        local score = __L1.training.score
        local combo = __L1.training.bestCombo
        __L1.training.active = false
        __L1.q.trained = true
        __L1:awardXP(380, "quest-caleb")
        __L1:emitGameEvent("player-trained")
        __L1.player.hp = __L1:bonus().maxHP
        __L1.player.gas = __L1:bonus().maxGas
        __L1.player.papers = 30
        __L1:releaseInputs()
        __L1:updateUI()
        __L1:save()
        __L1:say(
            __arrL(
                {
                    {
                        name = "Caleb",
                        text = ((("TREINO PAGO! " .. tostring(score)) .. " pontos, combo ") .. tostring(combo)) .. "! Esse braço saiu do tamanho de um lápis pra um bolo de três andares. Agora sim, shape de respeito!"
                    },
                    {name = "Da Roça", text = "Agora é papel mais forte, gás potente e reflexo afiado. Da academia direto pro bolo!"},
                    {name = "Caleb", text = "A quadra tá liberada! Entre no carro do seu pai com V e escolha a rota. Contra Nikolas: dash no aviso laranja, ataque quando ficar vulnerável. Se apertar, chama o Reeis — suplemento de amizade!"}
                },
                3
            ),
            function() return __L1:toast("Treino concluído! Seus ataques estão mais fortes. Vá à quadra.") end
        )
    end
    __L1.drawTrainingPixel = function(self)
        local t = __L1.training
        local PK = window.PixelKit
        local function P(____, x, y, w, h, c)
            __L1.ctx.fillStyle = c
            __L1.ctx:fillRect(
                math.floor(x + 0.5) * 2,
                math.floor(y + 0.5) * 2,
                math.floor(w + 0.5) * 2,
                math.floor(h + 0.5) * 2
            )
        end
        __L1.ctx.fillStyle = "#0a1612d0"
        __L1.ctx:fillRect(0, 0, __L1.W, __L1.H)
        PK:painel(
            __L1.ctx,
            70,
            52,
            820,
            380,
            {u = 2, fundo = "#16261f", borda = "#d7bf7e", rebite = "#a88a48"}
        )
        do
            local y = 34
            while y < 212 do
                do
                    local x = 38
                    while x < 442 do
                        P(
                            nil,
                            x + __mod(y / 6, 2) * 6,
                            y,
                            11,
                            1,
                            "rgba(0,0,0,.18)"
                        )
                        x = x + 12
                    end
                end
                y = y + 6
            end
        end
        PK:painel(
            __L1.ctx,
            300,
            64,
            360,
            36,
            {u = 2, fundo = "#2a1e12", borda = "#e8c24a", sombra = false}
        )
        PK:texto(
            __L1.ctx,
            "ACADEMIA DO CALEB",
            480,
            82,
            16,
            "#ffe9a8"
        )
        PK:contorno(
            __L1.ctx,
            "TREINO DE REFLEXO",
            480,
            128,
            24,
            "#fff0bd",
            "#1c1410"
        )
        local ____L1_time_1627 = __L1.time
        local ____t_result_1626
        if __t(t.golpeEm) then
            ____t_result_1626 = t.golpeEm
        else
            ____t_result_1626 = -9
        end
        local dt = ____L1_time_1627 - ____t_result_1626
        local bal = math.sin(dt * 9) * math.max(0, 1 - dt * 1.2) * 10
        local bx = 58 + math.floor(bal * 0.6 + 0.5)
        local by = 112
        do
            local k = 0
            while k < 6 do
                P(
                    nil,
                    58 + math.floor(bal * k / 12 + 0.5),
                    96 + k * 3,
                    2,
                    2,
                    __t(__mod(k, 2)) and "#9aa0a6" or "#6a7078"
                )
                k = k + 1
            end
        end
        P(
            nil,
            bx - 9,
            by,
            18,
            4,
            "#3a3a3a"
        )
        P(
            nil,
            bx - 10,
            by + 4,
            20,
            40,
            "#b8322a"
        )
        P(
            nil,
            bx - 10,
            by + 4,
            4,
            40,
            "#d8524a"
        )
        P(
            nil,
            bx + 6,
            by + 4,
            4,
            40,
            "#8a1e1a"
        )
        for ____, yy in __iterar((__arrL({by + 12, by + 34}, 2))) do
            P(
                nil,
                bx - 10,
                yy,
                20,
                2,
                "#3a3a3a"
            )
        end
        P(
            nil,
            bx - 8,
            by + 44,
            16,
            3,
            "#3a3a3a"
        )
        P(
            nil,
            bx - 3,
            by + 20,
            6,
            6,
            "#f2f2ee"
        )
        P(
            nil,
            bx - 2,
            by + 21,
            4,
            4,
            "#c43c3a"
        )
        if dt < 0.18 then
            do
                local k = 0
                while k < 6 do
                    local a = k / 6 * math.pi * 2
                    P(
                        nil,
                        bx + math.cos(a) * (14 + dt * 40),
                        by + 24 + math.sin(a) * (14 + dt * 40),
                        2,
                        2,
                        "#ffd24a"
                    )
                    k = k + 1
                end
            end
        end
        do
            local k = 0
            while k < 3 do
                local x = 404
                local y = 136 + k * 10
                P(
                    nil,
                    x,
                    y,
                    26,
                    2,
                    "#9aa0a6"
                )
                P(
                    nil,
                    x - 2,
                    y - 3,
                    5,
                    8,
                    "#2a2a2a"
                )
                P(
                    nil,
                    x + 23,
                    y - 3,
                    5,
                    8,
                    "#2a2a2a"
                )
                k = k + 1
            end
        end
        P(
            nil,
            400,
            164,
            36,
            3,
            "#5a3a22"
        )
        local placas = __arrL(
            {
                __arrL(
                    {
                        ("RODADA " .. tostring(t.round)) .. "/3",
                        "#e1d29d",
                        200
                    },
                    3
                ),
                __arrL(
                    {
                        "PONTOS " .. tostring(t.score),
                        "#d5e4ad",
                        480
                    },
                    3
                ),
                __arrL(
                    {
                        "COMBO x" .. tostring(t.combo),
                        "#d9b7df",
                        760
                    },
                    3
                )
            },
            3
        )
        for ____, ____value in __iterar((placas)) do
            local txt = ____value[1]
            local cor = ____value[2]
            local x = ____value[3]
            PK:painel(
                __L1.ctx,
                x - 104,
                152,
                208,
                34,
                {u = 2, fundo = "#0e1c16", borda = "#4a6a52", sombra = false}
            )
            PK:texto(
                __L1.ctx,
                txt,
                x,
                169,
                16,
                cor
            )
        end
        do
            local i = 0
            while i < 6 do
                local on = __lt(i, t.totalHits)
                P(
                    nil,
                    205 + i * 13,
                    99,
                    10,
                    4,
                    __t(on) and "#c9dd87" or "#2e4232"
                )
                if __t(on) then
                    P(
                        nil,
                        205 + i * 13,
                        99,
                        10,
                        1,
                        "#f2ffc8"
                    )
                end
                i = i + 1
            end
        end
        PK:barra(
            __L1.ctx,
            170,
            262,
            620,
            36,
            t.marker,
            {
                u = 2,
                gomos = 62,
                zona = __arrL({t.zoneStart, t.zoneEnd}, 2),
                zonaCor = "#8ad86a",
                vazio = "#7a3e38",
                borda = "#0a1410"
            }
        )
        local mx = math.floor((170 + t.marker * 620) / 2 + 0.5)
        P(
            nil,
            mx - 1,
            124,
            2,
            28,
            "#0a1410"
        )
        P(
            nil,
            mx - 6,
            118,
            12,
            8,
            "#c43c3a"
        )
        P(
            nil,
            mx - 6,
            118,
            12,
            2,
            "#e86a5a"
        )
        P(
            nil,
            mx - 7,
            120,
            2,
            5,
            "#a82a2a"
        )
        P(
            nil,
            mx - 4,
            126,
            8,
            3,
            "#f2f2ee"
        )
        P(
            nil,
            mx - 5,
            129,
            10,
            1,
            "#0a1410"
        )
        PK:texto(
            __L1.ctx,
            t.feedback,
            480,
            334,
            16,
            __t(t.feedbackGood) and "#d8ecae" or "#f0b6a0"
        )
        PK:texto(
            __L1.ctx,
            "E / ESPAÇO / ACERTAR: quando a luva estiver no verde",
            480,
            372,
            8,
            "#e4d7b2"
        )
        PK:texto(
            __L1.ctx,
            "2 acertos por rodada. Erros não apagam seus acertos.",
            480,
            396,
            8,
            "#9fb6a3"
        )
        return true
    end
    __L1.drawTraining = function(self)
        local ____t_1629 = __t
        local ____t_result_1628
        if __t(window.PixelKit) then
            ____t_result_1628 = __L1:drawTrainingPixel()
        else
            ____t_result_1628 = window.PixelKit
        end
        if ____t_1629(____t_result_1628) then
            return
        end
        local t = __L1.training
        __L1.ctx.fillStyle = "#132923c9"
        __L1.ctx:fillRect(0, 0, __L1.W, __L1.H)
        __L1.ctx.fillStyle = "#203b32"
        __L1.ctx:fillRect(85, 70, 790, 350)
        __L1.ctx.strokeStyle = "#d7bf7e"
        __L1.ctx.lineWidth = 3
        __L1.ctx:strokeRect(86.5, 71.5, 787, 347)
        __L1.ctx.fillStyle = "#314f3f"
        __L1.ctx:fillRect(102, 87, 756, 6)
        __L1:text(
            "ACADEMIA DO CALEB",
            480,
            117,
            13,
            "#dbcf9f"
        )
        __L1:text(
            "TREINO DE REFLEXO",
            480,
            154,
            30,
            "#fff0bd"
        )
        __L1:text(
            ("RODADA " .. tostring(t.round)) .. " / 3",
            235,
            199,
            17,
            "#e1d29d"
        )
        __L1:text(
            "PONTOS " .. tostring(t.score),
            480,
            199,
            17,
            "#d5e4ad"
        )
        __L1:text(
            "COMBO ×" .. tostring(t.combo),
            725,
            199,
            17,
            "#d9b7df"
        )
        do
            local i = 0
            while i < 6 do
                __L1.ctx.fillStyle = __lt(i, t.totalHits) and "#c9dd87" or "#526b50"
                __L1.ctx:fillRect(410 + i * 26, 225, 17, 8)
                i = i + 1
            end
        end
        local bx = 175
        local by = 267
        local bw = 610
        __L1.ctx.fillStyle = "#14291f"
        __L1.ctx:fillRect(bx - 4, by - 4, bw + 8, 43)
        __L1.ctx.fillStyle = "#9a5a52"
        __L1.ctx:fillRect(bx, by, bw, 35)
        __L1.ctx.fillStyle = "#b1d979"
        __L1.ctx:fillRect(bx + t.zoneStart * bw, by, (t.zoneEnd - t.zoneStart) * bw, 35)
        __L1.ctx.fillStyle = "#d8eea0"
        __L1.ctx:fillRect(bx + t.zoneStart * bw, by, (t.zoneEnd - t.zoneStart) * bw, 5)
        local mx = bx + t.marker * bw
        __L1.ctx.fillStyle = "#fff4d4"
        __L1.ctx:fillRect(mx - 4, by - 10, 8, 55)
        __L1.ctx.fillStyle = "#26372d"
        __L1.ctx:fillRect(mx - 1, by - 4, 2, 43)
        __L1:text(
            t.feedback,
            480,
            337,
            15,
            __t(t.feedbackGood) and "#d8ecae" or "#f0b6a0"
        )
        __L1:text(
            "E / ESPAÇO / ACERTAR — quando o marcador estiver no verde",
            480,
            371,
            13,
            "#e4d7b2"
        )
        __L1:text(
            "2 acertos por rodada. Erros não apagam seus acertos.",
            480,
            397,
            12,
            "#9fb6a3"
        )
    end
    __L1.paperAttack = function(self)
        if __L1.attackCooldown > 0 then
            return
        end
        if __le(__L1.player.papers, 0) then
            __L1:toast("O papel recarrega sozinho. Use o combo de gás enquanto espera!")
            return
        end
        __L1.attackCooldown = __L1.weapon == 2 and 0.31 or 0.23
        local ____L1_player_1630, ____papers_1631 = __L1.player, "papers"
        ____L1_player_1630[____papers_1631] = ____L1_player_1630[____papers_1631] - 1
        __L1.shake = math.max(__L1.shake, 1.2)
        __L1.player.attack = 0.24
        __L1.player.attackType = "paper"
        __L1.player.attackDuration = 0.24
        local ____t_result_1632
        if __t(__L1.q.miqueias) then
            ____t_result_1632 = math.max(
                1,
                __L1:bonus().projectileTier
            )
        else
            ____t_result_1632 = 0
        end
        local tier = ____t_result_1632
        local element = tier >= 2 and "electric" or (tier == 1 and "fire" or nil)
        local damage = math.floor(((__t(__L1.q.trained) and 28 or 18) + (__L1.weapon == 1 and 14 or (__L1.weapon == 2 and 22 or 0))) * __L1:bonus().damageMultiplier + 0.5)
        local ____t_result_1644
        local ____t_1638 = __t
        local ____opt_1635 = __L1.activeBoss
        if ____opt_1635 ~= nil then
            ____opt_1635 = ____opt_1635.conquista
        end
        local ____opt_result_1637
        if ____opt_1635 ~= nil then
            ____opt_result_1637 = ____opt_1635.estrada
        end
        if ____t_1638(____opt_result_1637) then
            ____t_result_1644 = window.PerseguicaoMoto:alvo(__L1.activeBoss.conquista, __L1.player, __L1.activeBoss)
        else
            local ____t_result_1643
            if __t(__L1.activeBoss) then
                ____t_result_1643 = __L1.activeBoss
            else
                local ____temp_1642
                if not __t(__L1.room) then
                    ____temp_1642 = __get(
                        __call(
                            __call(
                                __L1.minions,
                                "filter",
                                function(____, m)
                                    local ____t_result_1641
                                    local ____t_1640 = __t
                                    local ____temp_1639 = not __t(m.dead) and __TS__MathSign(m.x - __L1.player.x) == __L1.player.facing
                                    __O[1868] = ____temp_1639
                                    if ____t_1640(____temp_1639) then
                                        ____t_result_1641 = math.abs(m.x - __L1.player.x) < 650
                                    else
                                        ____t_result_1641 = __O[1868]
                                    end
                                    return ____t_result_1641
                                end
                            ),
                            "sort",
                            function(____, a, b) return math.abs(a.x - __L1.player.x) - math.abs(b.x - __L1.player.x) end
                        ),
                        0
                    )
                else
                    ____temp_1642 = nil
                end
                ____t_result_1643 = ____temp_1642
            end
            ____t_result_1644 = ____t_result_1643
        end
        local aimTarget = ____t_result_1644
        local ____t_result_1656
        local ____t_1646 = __t
        local ____t_result_1645
        if __t(aimTarget) then
            ____t_result_1645 = __TS__MathSign(aimTarget.x - __L1.player.x) == __L1.player.facing
        else
            ____t_result_1645 = aimTarget
        end
        if ____t_1646(____t_result_1645) then
            local ____L1_clamp_1655 = __L1.clamp
            local ____aimTarget_y_1654 = aimTarget.y
            local ____t_result_1653
            if __t(aimTarget.alto) then
                ____t_result_1653 = aimTarget.alto / 2
            else
                local ____temp_1652
                local ____opt_1647 = aimTarget.conquista
                if ____opt_1647 ~= nil then
                    ____opt_1647 = ____opt_1647.slug
                end
                if ____opt_1647 == "jorge" then
                    ____temp_1652 = window.JorgeDuelo:corpo(aimTarget.conquista).altura / 2
                else
                    local ____temp_1651
                    if aimTarget.type == "igor" then
                        ____temp_1651 = 45 * __L1:igorScale(aimTarget)
                    else
                        local ____temp_1650
                        if aimTarget.type == "giant" then
                            ____temp_1650 = 85
                        else
                            local ____t_result_1649
                            if __t(aimTarget.type == "nikolas" and __ge(aimTarget.phase, 2)) then
                                ____t_result_1649 = __L1:nikolasBounds(aimTarget).centerY
                            else
                                ____t_result_1649 = 30
                            end
                            ____temp_1650 = ____t_result_1649
                        end
                        ____temp_1651 = ____temp_1650
                    end
                    ____temp_1652 = ____temp_1651
                end
                ____t_result_1653 = ____temp_1652
            end
            ____t_result_1656 = ____L1_clamp_1655(
                __L1,
                math.atan(
                    ____aimTarget_y_1654 - ____t_result_1653 - (__L1.player.y - 32),
                    math.abs(aimTarget.x - __L1.player.x)
                ),
                -0.85,
                0.85
            )
        else
            ____t_result_1656 = 0
        end
        local aim = ____t_result_1656
        local ____iter_1658 = __iter
        local ____temp_1657
        if __L1.weapon == 2 then
            ____temp_1657 = __arrL({-0.11, 0, 0.11}, 3)
        else
            ____temp_1657 = __arrL({0}, 1)
        end
        for ____, spread in __TS__Iterator(____iter_1658(____temp_1657)) do
            __call(
                __L1.shots,
                "push",
                {
                    x = __L1.player.x + __L1.player.facing * 28,
                    y = __L1.player.y - 32,
                    vx = __L1.player.facing * math.cos(aim + spread) * (__t(__L1.weapon) and 680 or 600),
                    vy = math.sin(aim + spread) * (__t(__L1.weapon) and 680 or 600),
                    life = 1.5,
                    type = __t(element) and "papaia" or (__L1.weapon == 2 and "case" or (__L1.weapon == 1 and "ruler" or "paper")),
                    element = element,
                    owner = "player",
                    damage = damage
                }
            )
        end
        local ____opt_1661 = window.CampaignVfx
        if ____opt_1661 ~= nil then
            ____opt_1661 = ____opt_1661.emit
        end
        if ____opt_1661 ~= nil then
            ____opt_1661(____opt_1661, "cast", {x = __L1.player.x + __L1.player.facing * 26, y = __L1.player.y - 32, dir = __L1.player.facing, element = element})
        end
        __L1:fx(
            __L1.player.x + __L1.player.facing * 30,
            __L1.player.y - 32,
            element == "electric" and "#a7e6f1" or (__t(element) and "#f7b76c" or "#f8f3da"),
            4,
            35
        )
        __L1:beep(
            __t(element) and 570 or 760,
            0.045
        )
        __L1:updateUI()
    end
    __L1.fartAttack = function(self)
        if __L1.fartCooldown > 0 then
            return
        end
        local ____t_result_1663
        if __t(__L1.q.almiro) then
            ____t_result_1663 = __L1.comboWindow > 0
        else
            ____t_result_1663 = __L1.q.almiro
        end
        local chain = ____t_result_1663
        local ____t_result_1664
        if __t(chain) then
            ____t_result_1664 = math.min(3, __L1.comboStep + 1)
        else
            ____t_result_1664 = 1
        end
        __L1.comboStep = ____t_result_1664
        local cost = __L1.comboStep == 3 and 20 or (__L1.comboStep == 2 and 17 or 20)
        if __lt(__L1.player.gas, cost) then
            __L1:toast("Seu gás precisa recarregar. Espere no chão!")
            return
        end
        local ____L1_player_1665, ____gas_1666 = __L1.player, "gas"
        ____L1_player_1665[____gas_1666] = ____L1_player_1665[____gas_1666] - cost
        local ____t_result_1667
        if __t(__L1.q.almiro) then
            ____t_result_1667 = __L1.comboStep == 3 and 1.5 or 0.24
        else
            ____t_result_1667 = 0.9
        end
        __L1.fartCooldown = ____t_result_1667
        local ____t_1669 = __t
        local ____t_result_1668
        if __t(__L1.q.almiro) then
            ____t_result_1668 = __L1.comboStep < 3
        else
            ____t_result_1668 = __L1.q.almiro
        end
        __L1.comboWindow = ____t_1669(____t_result_1668) and 0.85 or 0
        __L1.player.attack = 0.36
        __L1.player.attackType = "fart"
        __L1.player.attackDuration = 0.36
        __L1.shake = __L1.comboStep == 3 and 9 or 4
        __L1:beep(80 - __L1.comboStep * 8, 0.2, "sawtooth", 0.045)
        local radius = __L1.comboStep == 3 and 165 or (__L1.comboStep == 2 and 130 or 100)
        local ____opt_1672 = window.Golpes
        if ____opt_1672 ~= nil then
            ____opt_1672 = ____opt_1672.areaGas
        end
        local ____opt_result_1674
        if ____opt_1672 ~= nil then
            ____opt_result_1674 = ____opt_1672(____opt_1672, __L1.player.x, __L1.player.y, radius)
        end
        local areaG = ____opt_result_1674
        local ____opt_1677 = window.Golpes
        if ____opt_1677 ~= nil then
            ____opt_1677 = ____opt_1677.gas
        end
        if ____opt_1677 ~= nil then
            ____opt_1677(
                ____opt_1677,
                __L1.player.x,
                __L1.player.y,
                radius,
                __L1.comboStep,
                __L1.player.facing
            )
        end
        local ____opt_1681 = window.CampaignVfx
        if ____opt_1681 ~= nil then
            ____opt_1681 = ____opt_1681.emit
        end
        if ____opt_1681 ~= nil then
            ____opt_1681(____opt_1681, "gas", {
                x = __L1.player.x + __L1.player.facing * 9,
                y = __L1.player.y - 23,
                dir = __L1.player.facing,
                stage = __L1.comboStep,
                radius = radius
            })
        end
        local ____opt_1685 = window.SceneLife
        if ____opt_1685 ~= nil then
            ____opt_1685 = ____opt_1685.gas
        end
        if ____opt_1685 ~= nil then
            ____opt_1685(
                ____opt_1685,
                __L1.player.x + __L1.player.facing * 9,
                __L1.player.y - 23,
                __L1.player.facing,
                __L1.comboStep
            )
        end
        local damage = math.floor((__t(__L1.q.trained) and 55 or 34) * (__L1.comboStep == 3 and 1.8 or (__L1.comboStep == 2 and 1.25 or 1)) * __L1:bonus().damageMultiplier + 0.5)
        if not __t(window.Golpes) then
            __L1:fx(
                __L1.player.x + __L1.player.facing * 38,
                __L1.player.y - 22,
                __L1.comboStep == 3 and "#e0ef82" or "#b9df55",
                __L1.comboStep == 3 and 52 or 25,
                radius * 0.75
            )
        end
        local ____t_1692 = __t
        local ____opt_1689 = __L1.activeBoss
        if ____opt_1689 ~= nil then
            ____opt_1689 = ____opt_1689.conquista
        end
        local ____opt_result_1691
        if ____opt_1689 ~= nil then
            ____opt_result_1691 = ____opt_1689.estrada
        end
        if ____t_1692(____opt_result_1691) then
            for ____, m in __iterar((__L1.activeBoss.conquista.estrada.motos)) do
                local r = m.rival
                local ____t_1696 = __t
                local ____t_result_1695
                local ____t_1694 = __t
                local ____temp_1693 = __gt(r.hp, 0) and math.abs(r.x - __L1.player.x) < radius
                __O[1869] = ____temp_1693
                if ____t_1694(____temp_1693) then
                    ____t_result_1695 = math.abs(r.y - __L1.player.y) < 90
                else
                    ____t_result_1695 = __O[1869]
                end
                if ____t_1696(____t_result_1695) then
                    r:onDano(damage)
                end
            end
        end
        for ____, e in __iterar((__L1.enemies)) do
            local ____t_1714 = __t
            local ____t_result_1713
            local ____t_1700 = __t
            local ____t_result_1699
            local ____t_1698 = __t
            local ____t_result_1697
            if __t(areaG) then
                ____t_result_1697 = not __t(e.conquista)
            else
                ____t_result_1697 = areaG
            end
            __O[1870] = ____t_result_1697
            if ____t_1698(____t_result_1697) then
                ____t_result_1699 = e.type ~= "igor"
            else
                ____t_result_1699 = __O[1870]
            end
            if ____t_1700(____t_result_1699) then
                ____t_result_1713 = window.Golpes:gasAcerta(
                    areaG,
                    window.Golpes:chefe(e)
                )
            else
                local ____temp_1712
                local ____opt_1701 = e.conquista
                if ____opt_1701 ~= nil then
                    ____opt_1701 = ____opt_1701.slug
                end
                if ____opt_1701 == "jorge" then
                    ____temp_1712 = window.JorgeDuelo:toca(
                        e.conquista,
                        __L1.player.x,
                        __L1.player.y - 25,
                        radius,
                        70
                    )
                else
                    local ____temp_1711
                    if e.type == "igor" then
                        ____temp_1711 = __L1:igorContains(
                            e,
                            __L1.player.x,
                            __L1.player.y - 25,
                            radius,
                            70
                        )
                    else
                        local ____t_result_1710
                        if __t(e.type == "nikolas" and __ge(e.phase, 2)) then
                            ____t_result_1710 = __L1:nikolasContains(
                                e,
                                __L1.player.x,
                                __L1.player.y - 25,
                                radius,
                                70
                            )
                        else
                            local ____t_result_1709
                            local ____t_1708 = __t
                            local ____t_result_1707
                            local ____t_1704 = __t
                            local ____temp_1703 = math.abs(e.x - __L1.player.x) < radius
                            __O[1871] = ____temp_1703
                            if ____t_1704(____temp_1703) then
                                ____t_result_1707 = __O[1871]
                            else
                                local ____opt_1705 = e.conquista
                                if ____opt_1705 ~= nil then
                                    ____opt_1705 = ____opt_1705.gemeoX
                                end
                                ____t_result_1707 = ____opt_1705 ~= nil and math.abs(e.conquista.gemeoX - __L1.player.x) < radius
                            end
                            __O[1872] = ____t_result_1707
                            if ____t_1708(____t_result_1707) then
                                ____t_result_1709 = math.abs(e.y - __L1.player.y) < 180
                            else
                                ____t_result_1709 = __O[1872]
                            end
                            ____t_result_1710 = ____t_result_1709
                        end
                        ____temp_1711 = ____t_result_1710
                    end
                    ____temp_1712 = ____temp_1711
                end
                ____t_result_1713 = ____temp_1712
            end
            if ____t_1714(____t_result_1713) then
                __L1:damageEnemy(e, damage)
            end
        end
        for ____, m in __iterar((__L1.minions)) do
            local ____t_1719 = __t
            local ____t_result_1718
            local ____t_1716 = __t
            local ____temp_1715 = not __t(m.dead)
            __O[1873] = ____temp_1715
            if ____t_1716(____temp_1715) then
                local ____t_result_1717
                if __t(areaG) then
                    ____t_result_1717 = window.Golpes:gasAcerta(
                        areaG,
                        window.Golpes:capanga(m)
                    )
                else
                    ____t_result_1717 = math.abs(m.x - __L1.player.x) < radius and math.abs(m.y - __L1.player.y) < 150
                end
                ____t_result_1718 = ____t_result_1717
            else
                ____t_result_1718 = __O[1873]
            end
            if ____t_1719(____t_result_1718) then
                __L1:damageMinion(m, damage)
            end
        end
        __L1.shots = __call(
            __L1.shots,
            "filter",
            function(____, a)
                local ____t_1731 = __t
                local ____t_result_1730
                local ____t_1721 = __t
                local ____temp_1720 = a.owner == "enemy"
                __O[1875] = ____temp_1720
                if ____t_1721(____temp_1720) then
                    local ____t_result_1729
                    if __t(areaG) then
                        local ____self_1727 = window.Golpes
                        local ____self_1727_gasPega_1728 = ____self_1727.gasPega
                        local ____a_x_1725 = a.x
                        local ____a_y_1726 = a.y
                        local ____t_result_1724
                        local ____t_1723 = __t
                        local ____table_r_1722 = window.Golpes:formaTiro(a).r
                        __O[1874] = ____table_r_1722
                        if ____t_1723(____table_r_1722) then
                            ____t_result_1724 = __O[1874]
                        else
                            ____t_result_1724 = 10
                        end
                        ____t_result_1729 = ____self_1727_gasPega_1728(
                            ____self_1727,
                            areaG,
                            ____a_x_1725,
                            ____a_y_1726,
                            ____t_result_1724
                        )
                    else
                        ____t_result_1729 = math.abs(a.x - __L1.player.x) < radius
                    end
                    ____t_result_1730 = ____t_result_1729
                else
                    ____t_result_1730 = __O[1875]
                end
                return not ____t_1731(____t_result_1730)
            end
        )
        __L1:floating(__L1.player.x, __L1.player.y - 85, __L1.comboStep == 3 and "COMBO 3! PEIDÃO SUPREMO!" or (__L1.comboStep == 2 and "COMBO 2! PÓÓÓF!" or "PÓÓÓF!"), "#d8f887")
        __L1:updateUI()
    end
    __L1.summon = function(self)
        if not __t(__L1.q.reeis) then
            __L1:toast("Vença Freddy e Reeis na favela para conquistar a ajuda do parceiro.")
            return
        end
        if __t(__L1.reeisCooldown > 0 or __L1.reeisPhase ~= "idle") then
            __L1:toast(("Reeis recupera o fôlego em " .. tostring(math.ceil(__L1.reeisCooldown))) .. "s.")
            return
        end
        __L1.reeisPhase = "running"
        __L1.reeisPhaseTimer = 0.9
        local ____gt_result_1732
        if __gt(__L1.player.facing, 0) then
            ____gt_result_1732 = __L1.camera - 110
        else
            ____gt_result_1732 = __L1.camera + __L1.W + 110
        end
        __L1.reeisX = ____gt_result_1732
        __L1.reeisY = __L1.FLOOR
        __L1.reeisFacing = __L1.player.facing
        __L1.reeisCooldown = 29
        __L1.reeisTimer = 0
        __L1.reeisFireTimer = 0
        __L1.player.inv = math.max(__L1.player.inv, 2.3)
        __L1:floating(__L1.player.x, __L1.player.y - 125, "OHHHH REEEEIS!", "#ffe1a0")
        __L1:toast("OHHHH REEEEIS! Lá vem o parceiro!")
        __L1:beep(130, 0.35, "sawtooth", 0.04)
    end
    __L1.updateReeis = function(self, dt)
        if __L1.reeisPhase == "idle" then
            return
        end
        local target = __L1.player.x - __L1.player.facing * 75
        __L1.reeisFacing = __L1.player.facing
        if __L1.reeisPhase == "running" then
            __L1.reeisX = __L1.reeisX + (target - __L1.reeisX) * math.min(1, dt * 6)
            __L1.reeisPhaseTimer = __L1.reeisPhaseTimer - dt
            if __L1.reeisPhaseTimer <= 0 then
                __L1.reeisPhase = "charging"
                __L1.reeisPhaseTimer = 0.9
                __L1.reeisX = target
                __L1.shake = 5
                __L1:beep(230, 0.2, "sawtooth")
            end
        elseif __L1.reeisPhase == "charging" then
            __L1.player.inv = math.max(__L1.player.inv, 0.2)
            __L1.reeisPhaseTimer = __L1.reeisPhaseTimer - dt
            __L1.reeisX = __L1.reeisX + (target - __L1.reeisX) * math.min(1, dt * 8)
            if math.random() < 0.7 then
                __L1:fx(
                    __L1.reeisX + __L1:rand(-30, 30),
                    __L1.reeisY - 45,
                    "#f4d474",
                    2,
                    45
                )
            end
            if __L1.reeisPhaseTimer <= 0 then
                __L1.reeisPhase = "burst"
                __L1.reeisPhaseTimer = 0.35
                local ____opt_1735 = window.CampaignVfx
                if ____opt_1735 ~= nil then
                    ____opt_1735 = ____opt_1735.emit
                end
                if ____opt_1735 ~= nil then
                    ____opt_1735(____opt_1735, "surge", {x = __L1.reeisX, y = __L1.reeisY - 24, dir = __L1.reeisFacing})
                end
                __L1.shake = 14
                __L1:fx(
                    __L1.reeisX,
                    __L1.reeisY - 48,
                    "#ffe09c",
                    60,
                    270
                )
                __L1:beep(90, 0.28, "sawtooth", 0.04)
            end
        elseif __L1.reeisPhase == "burst" then
            __L1.player.inv = math.max(__L1.player.inv, 0.15)
            __L1.reeisPhaseTimer = __L1.reeisPhaseTimer - dt
            if __L1.reeisPhaseTimer <= 0 then
                __L1.reeisPhase = "active"
                __L1.reeisTimer = 8
                __L1.reeisFireTimer = 0.1
            end
        elseif __L1.reeisPhase == "active" then
            __L1.reeisTimer = math.max(0, __L1.reeisTimer - dt)
            __L1.reeisX = __L1.reeisX + (target - __L1.reeisX) * math.min(1, dt * 9)
            __L1.reeisY = __L1.player.y
            __L1.reeisFireTimer = __L1.reeisFireTimer - dt
            if __L1.reeisFireTimer <= 0 then
                __L1.reeisFireTimer = 0.42
                local ____t_result_1740
                local ____t_1738 = __t
                local ____t_result_1737
                if __t(__L1.activeBoss) then
                    ____t_result_1737 = math.abs(__L1.activeBoss.x - __L1.player.x) < 740
                else
                    ____t_result_1737 = __L1.activeBoss
                end
                if ____t_1738(____t_result_1737) then
                    ____t_result_1740 = __L1.activeBoss
                else
                    local ____temp_1739
                    if not __t(__L1.arena) then
                        ____temp_1739 = __get(
                            __call(
                                __call(
                                    __L1.minions,
                                    "filter",
                                    function(____, m) return not __t(m.dead) and math.abs(m.x - __L1.player.x) < 700 end
                                ),
                                "sort",
                                function(____, a, b) return math.abs(a.x - __L1.player.x) - math.abs(b.x - __L1.player.x) end
                            ),
                            0
                        )
                    else
                        ____temp_1739 = nil
                    end
                    ____t_result_1740 = ____temp_1739
                end
                local nearest = ____t_result_1740
                if __t(nearest) then
                    local x = __L1.reeisX + __L1.reeisFacing * 42
                    local y = __L1.reeisY - 58
                    local ____nearest_y_1743 = nearest.y
                    local ____temp_1742
                    if nearest.type == "igor" then
                        ____temp_1742 = 45 * __L1:igorScale(nearest)
                    else
                        local ____t_result_1741
                        if __t(nearest.type == "nikolas" and __ge(nearest.phase, 2)) then
                            ____t_result_1741 = __L1:nikolasBounds(nearest).centerY
                        else
                            ____t_result_1741 = nearest.kind ~= nil and 22 or 32
                        end
                        ____temp_1742 = ____t_result_1741
                    end
                    local a = math.atan(____nearest_y_1743 - ____temp_1742 - y, nearest.x - x)
                    __call(
                        __L1.shots,
                        "push",
                        {
                            x = x,
                            y = y,
                            vx = math.cos(a) * 760,
                            vy = math.sin(a) * 760,
                            life = 1.1,
                            type = "reeis",
                            owner = "player",
                            damage = 14
                        }
                    )
                    __L1:beep(170, 0.035, "square", 0.012)
                end
            end
            if __L1.reeisTimer <= 0 then
                __L1.reeisPhase = "idle"
                __L1:fx(
                    __L1.reeisX,
                    __L1.reeisY - 40,
                    "#f5d58a",
                    12,
                    70
                )
                __L1:toast("Reeis voltou ao tamanho normal. O fôlego já está recarregando.")
            end
        end
    end
    __L1.dash = function(self)
        local ____t_1765 = __t
        local ____t_result_1764
        local ____t_1763 = __t
        local ____t_result_1762
        local ____t_1759 = __t
        local ____t_result_1758
        local ____t_1757 = __t
        local ____t_result_1756
        local ____t_1755 = __t
        local ____t_result_1754
        local ____t_1753 = __t
        local ____t_result_1752
        local ____t_1751 = __t
        local ____t_result_1750
        local ____t_1749 = __t
        local ____t_result_1748
        local ____t_1747 = __t
        local ____t_result_1746
        local ____t_1745 = __t
        local ____temp_1744 = not __t(__L1.started)
        __O[1876] = ____temp_1744
        if ____t_1745(____temp_1744) then
            ____t_result_1746 = __O[1876]
        else
            ____t_result_1746 = __L1.paused
        end
        __O[1877] = ____t_result_1746
        if ____t_1747(____t_result_1746) then
            ____t_result_1748 = __O[1877]
        else
            ____t_result_1748 = __L1.dialog
        end
        __O[1878] = ____t_result_1748
        if ____t_1749(____t_result_1748) then
            ____t_result_1750 = __O[1878]
        else
            ____t_result_1750 = __L1.won
        end
        __O[1879] = ____t_result_1750
        if ____t_1751(____t_result_1750) then
            ____t_result_1752 = __O[1879]
        else
            ____t_result_1752 = __L1.defeated
        end
        __O[1880] = ____t_result_1752
        if ____t_1753(____t_result_1752) then
            ____t_result_1754 = __O[1880]
        else
            ____t_result_1754 = __L1.room
        end
        __O[1881] = ____t_result_1754
        if ____t_1755(____t_result_1754) then
            ____t_result_1756 = __O[1881]
        else
            ____t_result_1756 = __L1.cutscene
        end
        __O[1882] = ____t_result_1756
        if ____t_1757(____t_result_1756) then
            ____t_result_1758 = __O[1882]
        else
            ____t_result_1758 = __L1.activity
        end
        __O[1883] = ____t_result_1758
        if ____t_1759(____t_result_1758) then
            ____t_result_1762 = __O[1883]
        else
            local ____opt_1760 = __L1.training
            if ____opt_1760 ~= nil then
                ____opt_1760 = ____opt_1760.active
            end
            ____t_result_1762 = ____opt_1760
        end
        __O[1884] = ____t_result_1762
        if ____t_1763(____t_result_1762) then
            ____t_result_1764 = __O[1884]
        else
            ____t_result_1764 = __L1.routeTransition
        end
        if ____t_1765(____t_result_1764) then
            return false
        end
        if __t(not __t(__L1.q.mota) and not __t(__L1.q.trained)) then
            __L1:toast("Vença o futebol do Mota para aprender o dash!")
            return false
        end
        if __t(__L1.vehicle) then
            __L1:toast("Estacione o carro com V para usar o dash.")
            return false
        end
        if __L1.dashCooldown > 0 then
            return false
        end
        local ____t_result_1778
        local ____t_1771 = __t
        local ____t_result_1770
        local ____t_1769 = __t
        local ____t_result_1768
        local ____t_1767 = __t
        local ____temp_1766 = __L1:keyHeld("left")
        __O[1885] = ____temp_1766
        if ____t_1767(____temp_1766) then
            ____t_result_1768 = __O[1885]
        else
            ____t_result_1768 = __L1.touch.left
        end
        __O[1886] = ____t_result_1768
        if ____t_1769(____t_result_1768) then
            ____t_result_1770 = __O[1886]
        else
            ____t_result_1770 = __L1.joystick.x < -0.15
        end
        if ____t_1771(____t_result_1770) then
            ____t_result_1778 = -1
        else
            local ____t_1777 = __t
            local ____t_result_1776
            local ____t_1775 = __t
            local ____t_result_1774
            local ____t_1773 = __t
            local ____temp_1772 = __L1:keyHeld("right")
            __O[1887] = ____temp_1772
            if ____t_1773(____temp_1772) then
                ____t_result_1774 = __O[1887]
            else
                ____t_result_1774 = __L1.touch.right
            end
            __O[1888] = ____t_result_1774
            if ____t_1775(____t_result_1774) then
                ____t_result_1776 = __O[1888]
            else
                ____t_result_1776 = __L1.joystick.x > 0.15
            end
            ____t_result_1778 = ____t_1777(____t_result_1776) and 1 or __L1.player.facing
        end
        __L1.dashDir = ____t_result_1778
        local ____opt_1781 = window.CampaignVfx
        if ____opt_1781 ~= nil then
            ____opt_1781 = ____opt_1781.emit
        end
        if ____opt_1781 ~= nil then
            ____opt_1781(____opt_1781, "dash", {x = __L1.player.x, y = __L1.player.y - 3, dir = __L1.dashDir})
        end
        __L1.dashTimer = 0.2
        __L1.dashCooldown = __L1:bonus().dashCooldown
        __L1.player.facing = __L1.dashDir
        __L1.player.vx = __L1.dashDir * 600
        __L1.player.inv = math.max(__L1.player.inv, 0.18)
        __L1:fx(
            __L1.player.x,
            __L1.player.y - 22,
            "#c0dfb8",
            18,
            130
        )
        __L1:beep(310, 0.08, "sawtooth")
        return true
    end
    __L1.setJoystick = function(self, x, y)
        local ____t_1813 = __t
        local ____t_result_1812
        local ____t_1811 = __t
        local ____t_result_1810
        local ____t_1807 = __t
        local ____t_result_1806
        local ____t_1804 = __t
        local ____t_result_1803
        local ____t_1801 = __t
        local ____t_result_1800
        local ____t_1799 = __t
        local ____t_result_1798
        local ____t_1797 = __t
        local ____t_result_1796
        local ____t_1795 = __t
        local ____t_result_1794
        local ____t_1793 = __t
        local ____t_result_1792
        local ____t_1791 = __t
        local ____t_result_1790
        local ____t_1789 = __t
        local ____t_result_1788
        if __t(__L1.inputCaptured) then
            ____t_result_1788 = __L1.inputCaptured
        else
            local ____opt_1785 = window.Arena
            if ____opt_1785 ~= nil then
                ____opt_1785 = ____opt_1785.isOpen
            end
            local ____opt_result_1787
            if ____opt_1785 ~= nil then
                ____opt_result_1787 = ____opt_1785(____opt_1785)
            end
            ____t_result_1788 = ____opt_result_1787
        end
        __O[1889] = ____t_result_1788
        if ____t_1789(____t_result_1788) then
            ____t_result_1790 = __O[1889]
        else
            ____t_result_1790 = not __t(__L1.started)
        end
        __O[1890] = ____t_result_1790
        if ____t_1791(____t_result_1790) then
            ____t_result_1792 = __O[1890]
        else
            ____t_result_1792 = __L1.paused
        end
        __O[1891] = ____t_result_1792
        if ____t_1793(____t_result_1792) then
            ____t_result_1794 = __O[1891]
        else
            ____t_result_1794 = __L1.dialog
        end
        __O[1892] = ____t_result_1794
        if ____t_1795(____t_result_1794) then
            ____t_result_1796 = __O[1892]
        else
            ____t_result_1796 = __L1.defeated
        end
        __O[1893] = ____t_result_1796
        if ____t_1797(____t_result_1796) then
            ____t_result_1798 = __O[1893]
        else
            ____t_result_1798 = __L1.cutscene
        end
        __O[1894] = ____t_result_1798
        if ____t_1799(____t_result_1798) then
            ____t_result_1800 = __O[1894]
        else
            ____t_result_1800 = __L1.activity
        end
        __O[1895] = ____t_result_1800
        if ____t_1801(____t_result_1800) then
            ____t_result_1803 = __O[1895]
        else
            local ____t_result_1802
            if __t(__L1.room) then
                ____t_result_1802 = __L1.room.phase ~= "inside"
            else
                ____t_result_1802 = __L1.room
            end
            ____t_result_1803 = ____t_result_1802
        end
        __O[1896] = ____t_result_1803
        if ____t_1804(____t_result_1803) then
            ____t_result_1806 = __O[1896]
        else
            local ____t_result_1805
            if __t(__L1.arena) then
                ____t_result_1805 = __L1.arena.phase ~= "active"
            else
                ____t_result_1805 = __L1.arena
            end
            ____t_result_1806 = ____t_result_1805
        end
        __O[1897] = ____t_result_1806
        if ____t_1807(____t_result_1806) then
            ____t_result_1810 = __O[1897]
        else
            local ____opt_1808 = __L1.training
            if ____opt_1808 ~= nil then
                ____opt_1808 = ____opt_1808.active
            end
            ____t_result_1810 = ____opt_1808
        end
        __O[1898] = ____t_result_1810
        if ____t_1811(____t_result_1810) then
            ____t_result_1812 = __O[1898]
        else
            ____t_result_1812 = __L1.routeTransition
        end
        if ____t_1813(____t_result_1812) then
            __L1.joystick = {x = 0, y = 0}
            return
        end
        local ____t_result_1826
        local ____t_1816 = __t
        local ____opt_1814 = window.ControlSettings
        if ____opt_1814 ~= nil then
            ____opt_1814 = ____opt_1814:transformJoystick(x, y)
        end
        __O[1901] = ____opt_1814
        if ____t_1816(____opt_1814) then
            ____t_result_1826 = __O[1901]
        else
            local ____L1_clamp_1820 = __L1.clamp
            local ____t_result_1819
            local ____t_1818 = __t
            local ____TS__Number_result_1817 = __TS__Number(x)
            __O[1899] = ____TS__Number_result_1817
            if ____t_1818(____TS__Number_result_1817) then
                ____t_result_1819 = __O[1899]
            else
                ____t_result_1819 = 0
            end
            local ____L1_clamp_1820_result_1825 = ____L1_clamp_1820(__L1, ____t_result_1819, -1, 1)
            local ____L1_clamp_1824 = __L1.clamp
            local ____t_result_1823
            local ____t_1822 = __t
            local ____TS__Number_result_1821 = __TS__Number(y)
            __O[1900] = ____TS__Number_result_1821
            if ____t_1822(____TS__Number_result_1821) then
                ____t_result_1823 = __O[1900]
            else
                ____t_result_1823 = 0
            end
            ____t_result_1826 = {
                x = ____L1_clamp_1820_result_1825,
                y = ____L1_clamp_1824(__L1, ____t_result_1823, -1, 1)
            }
        end
        __L1.joystick = ____t_result_1826
    end
    __L1.toggleVehicle = function(self)
        if __t(__L1.ollyanEncounter) then
            return false
        end
        local ____t_1835 = __t
        local ____t_result_1834
        local ____t_1828 = __t
        local ____temp_1827 = __L1.scene == 11 and not __t(__L1.vehicle)
        __O[1902] = ____temp_1827
        if ____t_1828(____temp_1827) then
            local ____gt_1833 = __gt
            local ____L1_player_x_1832 = __L1.player.x
            local ____opt_1829 = window.BaileGalpao
            if ____opt_1829 ~= nil then
                ____opt_1829 = ____opt_1829.PORTA
            end
            local ____opt_1829_1831 = ____opt_1829
            if ____opt_1829_1831 == nil then
                ____opt_1829_1831 = 760
            end
            ____t_result_1834 = ____gt_1833(____L1_player_x_1832, ____opt_1829_1831 - 70)
        else
            ____t_result_1834 = __O[1902]
        end
        if ____t_1835(____t_result_1834) then
            __L1:toast("Dentro do galpão não dá pra ligar o carro. Volte até a porta.")
            return
        end
        local ____t_1839 = __t
        local ____t_result_1838
        local ____t_1837 = __t
        local ____t_result_1836
        if __t(__L1.room) then
            ____t_result_1836 = __L1.room
        else
            ____t_result_1836 = __L1.cutscene
        end
        __O[1903] = ____t_result_1836
        if ____t_1837(____t_result_1836) then
            ____t_result_1838 = __O[1903]
        else
            ____t_result_1838 = __L1.arena
        end
        if ____t_1839(____t_result_1838) then
            __L1:toast("Saia da sala ou da arena para entrar no carro.")
            return
        end
        if not __t(__L1.q.lucas) then
            __L1:toast("Fale com Lucas para recuperar as chaves do carro a gás do seu pai.")
            return
        end
        if __t(__L1.activeBoss) then
            __L1:toast("O chefe não deixa você entrar no carro! Vença ou recue primeiro.")
            return
        end
        __L1.vehicle = not __t(__L1.vehicle)
        __L1:releaseInputs()
        __L1.player.vy = 0
        __L1:toast(__t(__L1.vehicle) and "Carro a gás do seu pai ligado! Escolha uma rota ou dirija com o joystick." or "Carro a gás estacionado.")
        __L1:beep(
            __t(__L1.vehicle) and 160 or 90,
            0.2,
            "sawtooth"
        )
        if __t(__L1.vehicle) then
            __L1:requestRoutePicker("entered-car")
        end
    end
    __L1.damageEnemy = function(self, e, n, element)
        local ____t_1860 = __t
        local ____t_result_1859
        local ____t_1857 = __t
        local ____t_result_1856
        local ____t_1855 = __t
        local ____t_result_1854
        local ____t_1853 = __t
        local ____t_result_1852
        local ____t_1851 = __t
        local ____t_result_1850
        local ____t_1849 = __t
        local ____t_result_1848
        local ____t_1847 = __t
        local ____t_result_1846
        local ____t_1845 = __t
        local ____t_result_1844
        local ____t_1841 = __t
        local ____temp_1840 = __le(e.hp, 0) or e.state == "underground"
        __O[1904] = ____temp_1840
        if ____t_1841(____temp_1840) then
            ____t_result_1844 = __O[1904]
        else
            local ____opt_1842 = e.conquista
            if ____opt_1842 ~= nil then
                ____opt_1842 = ____opt_1842.estado
            end
            ____t_result_1844 = ____opt_1842 == "phaseChange"
        end
        __O[1905] = ____t_result_1844
        if ____t_1845(____t_result_1844) then
            ____t_result_1846 = __O[1905]
        else
            ____t_result_1846 = __gt(e.damageLock, 0)
        end
        __O[1906] = ____t_result_1846
        if ____t_1847(____t_result_1846) then
            ____t_result_1848 = __O[1906]
        else
            ____t_result_1848 = __L1.dialog
        end
        __O[1907] = ____t_result_1848
        if ____t_1849(____t_result_1848) then
            ____t_result_1850 = __O[1907]
        else
            ____t_result_1850 = __L1.won
        end
        __O[1908] = ____t_result_1850
        if ____t_1851(____t_result_1850) then
            ____t_result_1852 = __O[1908]
        else
            ____t_result_1852 = __L1.defeated
        end
        __O[1909] = ____t_result_1852
        if ____t_1853(____t_result_1852) then
            ____t_result_1854 = __O[1909]
        else
            ____t_result_1854 = __L1.room
        end
        __O[1910] = ____t_result_1854
        if ____t_1855(____t_result_1854) then
            ____t_result_1856 = __O[1910]
        else
            ____t_result_1856 = __L1.cutscene
        end
        __O[1911] = ____t_result_1856
        if ____t_1857(____t_result_1856) then
            ____t_result_1859 = __O[1911]
        else
            local ____t_result_1858
            if __t(__L1.arena) then
                ____t_result_1858 = __L1.arena.phase ~= "active"
            else
                ____t_result_1858 = __L1.arena
            end
            ____t_result_1859 = ____t_result_1858
        end
        if ____t_1860(____t_result_1859) then
            return
        end
        if __t(not __t(__L1.activeBoss) and math.abs(__L1.player.x - e.x) > 390) then
            return
        end
        if __t(not __t(__L1.activeBoss) and not __t(__L1:engageBoss(e))) then
            return
        end
        if __L1.activeBoss ~= e then
            return
        end
        e.damageLock = 0.14
        local exposed = e.state == "recover"
        local ____n_1862 = n
        local ____t_result_1861
        if __t(exposed) then
            ____t_result_1861 = __t(e.type == "marco" and __gt(e.phase, 1)) and 0.9 or 1
        else
            ____t_result_1861 = __L1:bossProfile(e).armor
        end
        n = math.max(
            1,
            math.floor(____n_1862 * ____t_result_1861 + 0.5)
        )
        e.hp = e.hp - n
        local ____opt_1865 = window.SceneLife
        if ____opt_1865 ~= nil then
            ____opt_1865 = ____opt_1865.impact
        end
        if ____opt_1865 ~= nil then
            ____opt_1865(
                ____opt_1865,
                e.x - __L1.player.facing * 14,
                e.y - (e.type == "giant" and 80 or 40),
                element == "electric" and "#a9e7f4" or (element == "fire" and "#f4ad60" or "#ffd27a"),
                n,
                __TS__Number(-__L1.player.facing)
            )
        end
        __L1.shake = math.max(
            __L1.shake,
            math.min(4, 1 + n / 14)
        )
        __L1:epicFreeze(__ge(n, 18) and 0.085 or (__t(exposed) and 0.06 or 0.04))
        e.hit = 0.15
        local ____opt_1874 = window.CampaignVfx
        if ____opt_1874 ~= nil then
            ____opt_1874 = ____opt_1874.emit
        end
        if ____opt_1874 ~= nil then
            local ____e_x_1872 = e.x
            local ____e_y_1871 = e.y
            local ____temp_1870
            if e.type == "giant" then
                ____temp_1870 = 80
            else
                local ____temp_1869
                if e.type == "igor" then
                    ____temp_1869 = 45 * __L1:igorScale(e)
                else
                    local ____t_result_1868
                    if __t(e.type == "nikolas" and __ge(e.phase, 2)) then
                        ____t_result_1868 = __L1:nikolasBounds(e).centerY
                    else
                        ____t_result_1868 = 32
                    end
                    ____temp_1869 = ____t_result_1868
                end
                ____temp_1870 = ____temp_1869
            end
            ____opt_1874(____opt_1874, "hit", {
                x = ____e_x_1872,
                y = ____e_y_1871 - ____temp_1870,
                dir = __L1.player.facing,
                element = element,
                damage = n,
                kind = e.type
            })
        end
        if element == "fire" then
            e.burn = 3
        end
        if element == "electric" then
            local ____t_1877 = __t
            local ____t_result_1876
            if __t(exposed) then
                ____t_result_1876 = e.conquista
            else
                ____t_result_1876 = exposed
            end
            if ____t_1877(____t_result_1876) then
                local ____e_conquista_1878, ____dur_1879 = e.conquista, "dur"
                ____e_conquista_1878[____dur_1879] = ____e_conquista_1878[____dur_1879] + 0.08
            end
            e.stateTimer = e.stateTimer + (__t(exposed) and 0.08 or 0)
            __L1:fx(
                e.x,
                e.y - 55,
                "#a8e9ff",
                12,
                100
            )
        end
        __L1:fx(
            e.x,
            e.y - 32,
            e.type == "nikolas" and "#a6d05d" or "#e9ae68",
            8,
            90
        )
        __L1:floating(
            e.x,
            e.y - 85,
            __add("−", n)
        )
        __L1:beep(220, 0.06)
        local ____t_1886 = __t
        local ____t_result_1885
        local ____t_1881 = __t
        local ____temp_1880 = __le(e.hp, 0) and e.type ~= "giant"
        __O[1912] = ____temp_1880
        if ____t_1881(____temp_1880) then
            local ____lt_1884 = __lt
            local ____t_result_1882
            if __t(e.phase) then
                ____t_result_1882 = e.phase
            else
                ____t_result_1882 = 1
            end
            local ____t_result_1883
            if __t(e.phaseCount) then
                ____t_result_1883 = e.phaseCount
            else
                ____t_result_1883 = 3
            end
            ____t_result_1885 = ____lt_1884(____t_result_1882, ____t_result_1883)
        else
            ____t_result_1885 = __O[1912]
        end
        if ____t_1886(____t_result_1885) then
            e.hp = 0
            local ____L1_beginBossPhase_1889 = __L1.beginBossPhase
            local ____e_1888 = e
            local ____t_result_1887
            if __t(e.phase) then
                ____t_result_1887 = e.phase
            else
                ____t_result_1887 = 1
            end
            ____L1_beginBossPhase_1889(__L1, ____e_1888, ____t_result_1887 + 1)
            __L1:updateUI()
            return
        end
        local ____t_1893 = __t
        local ____t_result_1892
        local ____t_1891 = __t
        local ____le_result_1890 = __le(e.hp, 0)
        __O[1913] = ____le_result_1890
        if ____t_1891(____le_result_1890) then
            ____t_result_1892 = __L1.sandbox
        else
            ____t_result_1892 = __O[1913]
        end
        if ____t_1893(____t_result_1892) then
            e.hp = 0
            if __t(e.conquista) then
                e.conquista.objetos = __arrL({}, 0)
                e.conquista.marcas = __arrL({}, 0)
                e.conquista.estado = "fim"
                if e.conquista.slug == "jorge" then
                    __L1:epicPlate("JORGE CAIU…", "E AGORA, DA ROÇA?", "#e0c4fb", 0.85)
                end
            end
            __L1:finishSandbox("won")
            return
        end
        if __le(e.hp, 0) then
            e.hp = 0
            local ____opt_1896 = window.FxPixel
            if ____opt_1896 ~= nil then
                ____opt_1896 = ____opt_1896.derrota
            end
            if ____opt_1896 ~= nil then
                ____opt_1896(____opt_1896, e)
            end
            __L1.shake = 12
            __L1:epicFreeze(0.3)
            __L1.epic.flash = 0.75
            __L1.epic.flashColor = "#fff6d8"
            __L1:epicRing(e.x, e.y - 60, "#ffe08b", 1.6)
            __L1:epicRing(e.x, e.y - 60, "#ff9b6a", 1.1)
            local ____L1_epicPlate_1902 = __L1.epicPlate
            local ____call_1901 = __call
            local ____t_result_1900
            local ____t_1899 = __t
            local ____temp_1898 = __L1:nomeBoss(e.type)
            __O[1914] = ____temp_1898
            if ____t_1899(____temp_1898) then
                ____t_result_1900 = __O[1914]
            else
                ____t_result_1900 = ""
            end
            ____L1_epicPlate_1902(
                __L1,
                "DERROTADO!",
                ____call_1901(____t_result_1900, "toUpperCase"),
                "#ffd25a",
                2.2
            )
            __L1.killCount = __L1.killCount + 1
            local ____type = e.type
            __L1:leaveArena(true)
            __L1.activeBoss = nil
            __L1.hazards = __arrL({}, 0)
            __L1.shots = __call(
                __L1.shots,
                "filter",
                function(____, a) return a.owner ~= "enemy" end
            )
            __L1:awardXP(
                ____type == "nikolas" and 900 or (____type == "giant" and 750 or (____type == "nicolas" and 700 or (____type == "reeisBoss" and 600 or (____type == "menezes" and 650 or (____type == "freddy" and 400 or (____type == "dede" and 320 or (____type == "arthur" and 450 or (____type == "igor" and 360 or (____type == "kaique" and 420 or 480))))))))),
                __add("boss-", ____type)
            )
            if ____type == "arthur" then
                __L1.q.arthur = true
                __L1:startCutscene(
                    "arthur_revenge",
                    function()
                        __L1:toast("Paz no pátio! Ravile levantou e Arthur aprendeu a respeitar o cabelo dos outros.")
                        __L1:save()
                        __L1:updateUI()
                    end
                )
            elseif __t(____type == "igor" or ____type == "kaique") then
                __set(__L1.q, ____type, true)
                __set(
                    __L1.q,
                    __add(____type, "Sneak"),
                    true
                )
                local ____L1_say_1904 = __L1.say
                local ____temp_1903
                if ____type == "igor" then
                    ____temp_1903 = __arrL({{name = "Igor · monitor", text = "Oxe, véi... tu passou mesmo! Achou um pão de queijo, fortalece o pai aqui, viu?"}, {name = "Da Roça", text = "Tua barriga fez mais chamada que o professor, pô! Bora que meu bolo não se acha sozinho."}}, 2)
                else
                    ____temp_1903 = __arrL({{name = "Kaique · monitor", text = "Vai, se pique logo, véi! Hoje tu passou... mas se eu achar outra bolinha, já sabe, né?"}, {name = "Da Roça", text = "Qual foi, Kaique? Era só um trabalho de física voando, pô!"}}, 2)
                end
                ____L1_say_1904(__L1, ____temp_1903)
            elseif ____type == "dede" then
                __L1.q.dede = true
                __L1:startCutscene(
                    "dede_defeat",
                    function()
                        __L1:toast("A fumaça baixou! Dedé virou resenha; Freddy continua no fim do caminho.")
                        __L1:save()
                        __L1:updateUI()
                    end
                )
            elseif ____type == "nicolas" then
                __L1.q.nicolas = true
                __L1:startCutscene(
                    "nicolas_reveal",
                    function()
                        __L1:toast("A aura era imaginação! Nicolas voltou à Praça Camacan, pronto para mais uma resenha.")
                        __L1:save()
                        __L1:updateUI()
                    end
                )
            elseif ____type == "freddy" then
                __L1.q.freddy = true
                __L1:startCutscene(
                    "freddy_defeat",
                    function()
                        __L1:toast("Freddy liberou a passagem. Continue à direita para enfrentar Reeis!")
                        __L1:save()
                        __L1:updateUI()
                    end
                )
            elseif ____type == "marco" then
                __L1.q.marco = true
                local ____L1_items_1905, ____clip_1906 = __L1.items, "clip"
                ____L1_items_1905[____clip_1906] = ____L1_items_1905[____clip_1906] + 3
                __L1:toast("Marco derrotado! O portal para o Caderno do Caos foi aberto.")
            elseif ____type == "giant" then
                __L1.q.giant = true
                __L1:toast("O rabisco gigante caiu! Volte ao colégio para enfrentar Menezes.")
            elseif ____type == "reeisBoss" then
                __L1.q.reeis = true
                __L1:startCutscene(
                    "reeis_recruit",
                    function()
                        __L1.reeisCooldown = 0
                        __L1:toast("Reeis virou aliado! R chama a transformação dourada. Volte à escola para Marco.")
                        __L1:save()
                    end
                )
            elseif ____type == "menezes" then
                __L1.q.menezes = true
                __L1:say(
                    __arrL({{name = "Menezes · Rato", text = "Da Roça pegou a— opa! Nem minhas paredes de palavras seguraram você!"}, {name = "Da Roça", text = "Quem pegou ar agora foi seu quadro. Cadê o bolo?"}, {name = "Menezes · Rato", text = "Nikolas está na quadra... com o bolo e aquele nariz de batata. Treina com Caleb antes!"}}, 3),
                    function() return __L1:toast("Academia liberada! Próxima parada: treino do Caleb.") end
                )
            elseif ____type == "nikolas" then
                __L1:win()
            end
            __L1:save()
            __L1:updateUI()
        end
    end
    __L1.hurt = function(self, n, from)
        local ____t_1918 = __t
        local ____t_result_1917
        local ____t_1916 = __t
        local ____t_result_1915
        local ____t_1914 = __t
        local ____t_result_1913
        local ____t_1912 = __t
        local ____t_result_1911
        local ____t_1910 = __t
        local ____t_result_1909
        local ____t_1908 = __t
        local ____gt_result_1907 = __gt(__L1.player.inv, 0)
        __O[1915] = ____gt_result_1907
        if ____t_1908(____gt_result_1907) then
            ____t_result_1909 = __O[1915]
        else
            ____t_result_1909 = __L1.won
        end
        __O[1916] = ____t_result_1909
        if ____t_1910(____t_result_1909) then
            ____t_result_1911 = __O[1916]
        else
            ____t_result_1911 = __L1.defeated
        end
        __O[1917] = ____t_result_1911
        if ____t_1912(____t_result_1911) then
            ____t_result_1913 = __O[1917]
        else
            ____t_result_1913 = __L1.dialog
        end
        __O[1918] = ____t_result_1913
        if ____t_1914(____t_result_1913) then
            ____t_result_1915 = __O[1918]
        else
            ____t_result_1915 = __L1.paused
        end
        __O[1919] = ____t_result_1915
        if ____t_1916(____t_result_1915) then
            ____t_result_1917 = __O[1919]
        else
            ____t_result_1917 = __L1.routeTransition
        end
        if ____t_1918(____t_result_1917) then
            return
        end
        local ____t_1921 = __t
        local ____opt_1919 = window.C2Luta
        if ____opt_1919 ~= nil then
            ____opt_1919 = ____opt_1919.skin
        end
        if ____t_1921(____opt_1919) then
            local ____t_result_1922
            if __t(window.C2Luta.skin.dano) then
                ____t_result_1922 = window.C2Luta.skin.dano
            else
                ____t_result_1922 = 1
            end
            n = n * ____t_result_1922
        end
        local ____t_result_1932
        local ____t_1931 = __t
        local ____opt_1928 = window.Difficulty
        if ____opt_1928 ~= nil then
            ____opt_1928 = ____opt_1928.scaleIncomingDamage
        end
        local ____opt_result_1930
        if ____opt_1928 ~= nil then
            local ____n_1926 = n
            local ____opt_1924 = __L1.activeBoss
            if ____opt_1924 ~= nil then
                ____opt_1924 = ____opt_1924.difficultyMode
            end
            ____opt_result_1930 = ____opt_1928(____opt_1928, ____n_1926, ____opt_1924)
        end
        __O[1920] = ____opt_result_1930
        if ____t_1931(____opt_result_1930) then
            ____t_result_1932 = __O[1920]
        else
            ____t_result_1932 = n
        end
        n = ____t_result_1932
        __L1.player.hp = math.max(0, __L1.player.hp - n)
        local ____opt_1935 = window.CampaignVfx
        if ____opt_1935 ~= nil then
            ____opt_1935 = ____opt_1935.emit
        end
        if ____opt_1935 ~= nil then
            ____opt_1935(
                ____opt_1935,
                "enemyHit",
                {
                    x = __L1.player.x,
                    y = __L1.player.y - 30,
                    dir = __lt(__L1.player.x, from) and -1 or 1,
                    damage = n
                }
            )
        end
        __L1.player.inv = 0.65
        __L1.player.vy = -135
        __L1.player.x = __L1:clamp(
            __L1.player.x + (__lt(__L1.player.x, from) and -30 or 30),
            30,
            __L1.WORLD - 30
        )
        __L1.hitFlash = 0.18
        __L1.shake = 7
        __L1:fx(
            __L1.player.x,
            __L1.player.y - 25,
            "#e98866",
            12,
            100
        )
        __L1:beep(100, 0.12, "sawtooth")
        if __le(__L1.player.hp, 0) then
            __L1:defeat()
        end
        __L1:updateUI()
    end
    __L1.settleFinalWorld = function(self)
        __L1.activeBoss = nil
        __L1.arena = nil
        __L1.room = nil
        __L1.routeTransition = nil
        __L1.shots = __arrL({}, 0)
        __L1.hazards = __arrL({}, 0)
        __L1.minions = __call(
            __L1.minions,
            "filter",
            function(____, m) return not __t(m.summoned) end
        )
        __L1.reeisPhase = "idle"
        __L1.reeisTimer = 0
        __L1:releaseInputs()
        __L1:resetWorldSize()
        __L1.player.x = __L1:clamp(__L1.player.x, 30, __L1.WORLD - 30)
        __L1.player.y = __L1.FLOOR
        __L1.player.vx = 0
        __L1.player.vy = 0
        __L1.player.ground = true
        __L1.player.hp = __L1:bonus().maxHP
        __L1.player.gas = __L1:bonus().maxGas
        __L1.player.papers = 30
        __L1.lastSafeX = __L1.player.x
        __L1.camera = __L1:clamp(__L1.player.x - __L1.W * 0.36, 0, __L1.WORLD - __L1.W)
    end
    __L1.finishJorgeEpilogue = function(self)
        __L1.q.jorgeSeen = true
        __L1.q.jorgeStarted = false
        __L1.chapterEnded = true
        __L1.won = true
        __L1.playing = false
        __L1.paused = false
        __L1:settleFinalWorld()
        __L1:show("victoryScreen", false)
        __L1:show("pauseScreen", false)
        __L1:updateUI()
        __L1:save()
        __L1:emitGameEvent("chapter-ended", {chapter = 1, caller = "JORGE"})
    end
    __L1.beginJorgeEpilogue = function(self)
        __L1.q.jorgeStarted = true
        __L1.chapterEnded = false
        __L1.won = true
        __L1.playing = true
        __L1.paused = false
        __L1:settleFinalWorld()
        __L1:show("chapterEndScreen", false)
        __L1:show("pauseScreen", false)
        __L1:save()
        return __L1:startCutscene("jorge_epilogue", __L1.finishJorgeEpilogue)
    end
    __L1.continueExploring = function(self)
        if __t(not __t(__L1.started) or not __t(__L1.chapterEnded)) then
            return false
        end
        __L1.chapterEnded = false
        __L1.won = false
        __L1.playing = true
        __L1.paused = false
        __L1:settleFinalWorld()
        __L1:show("chapterEndScreen", false)
        __L1:updateUI()
        __L1:save()
        __L1.canvas:focus()
        return true
    end
    __L1.replayEpilogue = function(self)
        local ____t_1960 = __t
        local ____t_result_1959
        local ____t_1958 = __t
        local ____t_result_1957
        local ____t_1956 = __t
        local ____t_result_1955
        local ____t_1954 = __t
        local ____t_result_1953
        local ____t_1950 = __t
        local ____t_result_1949
        local ____t_1948 = __t
        local ____t_result_1947
        local ____t_1946 = __t
        local ____t_result_1945
        local ____t_1944 = __t
        local ____t_result_1943
        local ____t_1942 = __t
        local ____t_result_1941
        local ____t_1940 = __t
        local ____t_result_1939
        local ____t_1938 = __t
        local ____temp_1937 = not __t(__L1.started) or not __t(__L1.q.nikolas)
        __O[1921] = ____temp_1937
        if ____t_1938(____temp_1937) then
            ____t_result_1939 = __O[1921]
        else
            ____t_result_1939 = __L1.defeated
        end
        __O[1922] = ____t_result_1939
        if ____t_1940(____t_result_1939) then
            ____t_result_1941 = __O[1922]
        else
            ____t_result_1941 = __L1.activeBoss
        end
        __O[1923] = ____t_result_1941
        if ____t_1942(____t_result_1941) then
            ____t_result_1943 = __O[1923]
        else
            ____t_result_1943 = __L1.arena
        end
        __O[1924] = ____t_result_1943
        if ____t_1944(____t_result_1943) then
            ____t_result_1945 = __O[1924]
        else
            ____t_result_1945 = __L1.room
        end
        __O[1925] = ____t_result_1945
        if ____t_1946(____t_result_1945) then
            ____t_result_1947 = __O[1925]
        else
            ____t_result_1947 = __L1.routeTransition
        end
        __O[1926] = ____t_result_1947
        if ____t_1948(____t_result_1947) then
            ____t_result_1949 = __O[1926]
        else
            ____t_result_1949 = __L1.dialog
        end
        __O[1927] = ____t_result_1949
        if ____t_1950(____t_result_1949) then
            ____t_result_1953 = __O[1927]
        else
            local ____opt_1951 = __L1.training
            if ____opt_1951 ~= nil then
                ____opt_1951 = ____opt_1951.active
            end
            ____t_result_1953 = ____opt_1951
        end
        __O[1928] = ____t_result_1953
        if ____t_1954(____t_result_1953) then
            ____t_result_1955 = __O[1928]
        else
            ____t_result_1955 = __L1.activity
        end
        __O[1929] = ____t_result_1955
        if ____t_1956(____t_result_1955) then
            ____t_result_1957 = __O[1929]
        else
            ____t_result_1957 = __L1.cutscene
        end
        __O[1930] = ____t_result_1957
        if ____t_1958(____t_result_1957) then
            ____t_result_1959 = __O[1930]
        else
            ____t_result_1959 = __L1.ollyanEncounter
        end
        if ____t_1960(____t_result_1959) then
            return false
        end
        return __L1:beginJorgeEpilogue()
    end
    __L1.finishCelebration = function(self)
        __L1.q.acai = true
        __L1.q.celebrationSeen = true
        __L1:settleFinalWorld()
        __L1:show("victoryScreen", false)
        __L1:save()
        __L1:emitGameEvent("celebration-complete", {acai = true})
        __L1:beginPostCelebration()
    end
    __L1.beginPostCelebration = function(self)
        local ____t_1969 = __t
        local ____opt_1965 = window.CampaignRun
        if ____opt_1965 ~= nil then
            ____opt_1965 = ____opt_1965.getResult
        end
        local ____opt_result_1967
        if ____opt_1965 ~= nil then
            ____opt_result_1967 = ____opt_1965(____opt_1965)
        end
        local ____opt_result_1968
        if ____opt_result_1967 ~= nil then
            ____opt_result_1968 = ____opt_result_1967.mode
        end
        if ____t_1969(____opt_result_1968 == "easy" and not __t(__L1.q.easyEndingSeen)) then
            __L1.won = true
            __L1.playing = true
            __L1.paused = false
            return __L1:startCutscene(
                "easy_finish",
                function()
                    __L1.q.easyEndingSeen = true
                    __L1:save()
                    __L1:beginJorgeEpilogue()
                end
            )
        end
        return __L1:beginJorgeEpilogue()
    end
    __L1.beginCelebration = function(self)
        if not __t(__L1.q.acai) then
            __L1.q.acai = true
            __L1:awardXP(300, "reward-quarta-acai")
        end
        __L1.won = true
        __L1:save()
        return __L1:startCutscene("celebration", __L1.finishCelebration)
    end
    __L1.win = function(self)
        __L1.q.nikolas = true
        __L1.won = true
        __L1.vehicle = false
        local ____opt_1972 = window.CampaignRun
        if ____opt_1972 ~= nil then
            ____opt_1972 = ____opt_1972.finish
        end
        if ____opt_1972 ~= nil then
            ____opt_1972(____opt_1972)
        end
        __L1:save()
        __L1:say(
            __arrL({
                {name = "Nikolas Arroganti", text = "Meu catarro... minha força... e eu nem provei a cobertura!"},
                {name = "Nikolas Arroganti", text = "Anao da roça poudi pra que jogar a bola na mavie po seu arroganthi"},
                {name = "Da Roça", text = "O bolo é do Lucas e da turma. Aprende a pedir um pedaço, Nikolas!"},
                {name = "Reeis", text = "OHHHH REEEEIS! Missão cumprida, parceiro!"},
                {name = "Lucas · o Sapo", text = "Tem bolo pra todo mundo. Até pro Nikolas, se ele lavar as mãos primeiro."}
            }, 5),
            function() return __L1:startCutscene("outro", __L1.beginCelebration) end
        )
    end
    __L1.epicRing = function(self, x, y, color, size)
        if size == nil then
            size = 1
        end
        if __len(__L1.epic.rings) > 8 then
            __call(__L1.epic.rings, "shift")
        end
        __call(__L1.epic.rings, "push", {
            x = x,
            y = y,
            color = color,
            size = size,
            age = 0,
            life = 0.62 * size
        })
    end
    __L1.epicFreeze = function(self, seconds)
        if not __t(__L1.calmMotion) then
            __L1.hitStop = math.max(
                __L1.hitStop,
                math.min(0.35, seconds)
            )
        end
    end
    __L1.epicPlate = function(self, title, sub, color, life)
        if life == nil then
            life = 1.9
        end
        __L1.epic.plate = {
            title = title,
            sub = sub,
            color = color,
            age = 0,
            life = life
        }
    end
    __L1.updateEpic = function(self, dt)
        if __t(__L1.epic.intro) then
            __L1.epic.intro.age = __add(__L1.epic.intro.age, dt)
            if __t(not __t(__L1.epic.intro.slammed) and __ge(__L1.epic.intro.age, 0.36)) then
                __L1.epic.intro.slammed = true
                __L1.shake = math.max(
                    __L1.shake,
                    __t(__L1.calmMotion) and 2 or 7
                )
            end
            if __gt(__L1.epic.intro.age, 2.7) then
                __L1.epic.intro = nil
            end
        end
        for ____, r in __iterar((__L1.epic.rings)) do
            r.age = __add(r.age, dt)
        end
        __L1.epic.rings = __call(
            __L1.epic.rings,
            "filter",
            function(____, r) return __lt(r.age, r.life) end
        )
        if __t(__L1.epic.plate) then
            __L1.epic.plate.age = __add(__L1.epic.plate.age, dt)
            if __gt(__L1.epic.plate.age, __L1.epic.plate.life) then
                __L1.epic.plate = nil
            end
        end
        __L1.epic.flash = math.max(0, __L1.epic.flash - dt * 2.2)
    end
    __L1.drawEpicWorld = function(self)
        local b = __L1.activeBoss
        local ____t_1986 = __t
        local ____t_result_1985
        local ____t_1984 = __t
        local ____t_result_1983
        local ____t_1982 = __t
        local ____t_result_1981
        local ____t_1977 = __t
        local ____t_result_1976
        local ____t_1975 = __t
        local ____t_result_1974
        if __t(b) then
            ____t_result_1974 = not __t(b.conquista)
        else
            ____t_result_1974 = b
        end
        __O[1931] = ____t_result_1974
        if ____t_1975(____t_result_1974) then
            ____t_result_1976 = __gt(b.hp, 0)
        else
            ____t_result_1976 = __O[1931]
        end
        __O[1932] = ____t_result_1976
        if ____t_1977(____t_result_1976) then
            local ____ge_1980 = __ge
            local ____t_result_1978
            if __t(b.phase) then
                ____t_result_1978 = b.phase
            else
                ____t_result_1978 = 1
            end
            local ____t_result_1979
            if __t(b.phaseCount) then
                ____t_result_1979 = b.phaseCount
            else
                ____t_result_1979 = 1
            end
            ____t_result_1981 = ____ge_1980(____t_result_1978, ____t_result_1979)
        else
            ____t_result_1981 = __O[1932]
        end
        __O[1933] = ____t_result_1981
        if ____t_1982(____t_result_1981) then
            ____t_result_1983 = b.max
        else
            ____t_result_1983 = __O[1933]
        end
        __O[1934] = ____t_result_1983
        if ____t_1984(____t_result_1983) then
            ____t_result_1985 = b.hp / b.max < 0.35
        else
            ____t_result_1985 = __O[1934]
        end
        if ____t_1986(____t_result_1985) then
            local pulse = 0.5 + 0.5 * math.sin(__L1.time * 9)
            local h = b.type == "giant" and 190 or (__t(b.type == "nikolas" and __ge(b.phase, 4)) and 210 or 110)
            local g = __L1.ctx:createRadialGradient(
                b.x,
                b.y - h * 0.45,
                8,
                b.x,
                b.y - h * 0.45,
                h * 0.85
            )
            g:addColorStop(
                0,
                ("rgba(255,96,64," .. tostring(0.2 + 0.14 * pulse)) .. ")"
            )
            g:addColorStop(1, "rgba(255,60,40,0)")
            __L1.ctx:save()
            __L1.ctx.globalCompositeOperation = "lighter"
            __L1.ctx.fillStyle = g
            __L1.ctx:fillRect(b.x - h, b.y - h * 1.3, h * 2, h * 1.5)
            __L1.ctx.fillStyle = ("rgba(255,180,120," .. tostring(0.5 + 0.4 * pulse)) .. ")"
            do
                local i = 0
                while i < 5 do
                    local a = __L1.time * 2.2 + i * 1.26
                    local r = h * 0.42 + math.sin(__L1.time * 4 + i) * 6
                    __L1.ctx:fillRect(
                        math.floor(b.x + math.cos(a) * r * 0.7 + 0.5),
                        math.floor(b.y - h * 0.45 + math.sin(a) * r * 0.5 - __mod(__L1.time * 60 + i * 23, 40) + 0.5),
                        3,
                        3
                    )
                    i = i + 1
                end
            end
            __L1.ctx:restore()
        end
        for ____, r in __iterar((__L1.epic.rings)) do
            local k = r.age / r.life
            local ease = 1 - (1 - k) ^ 2.2
            __L1.ctx:save()
            __L1.ctx.globalAlpha = 1 - k * k
            do
                local i = 0
                while i < 24 do
                    local a = i / 24 * math.pi * 2 + __mod(i, 3) * 0.11
                    local sp = (140 + __mod(i * 37, 60)) * r.size
                    local d = ease * sp
                    local z = math.max(
                        2,
                        math.floor((__mod(i, 3) == 0 and 7 or 5) * (1 - k) * r.size + 0.5)
                    )
                    local px = math.floor(r.x + math.cos(a) * d + 0.5)
                    local py = math.floor(r.y + math.sin(a) * d * 0.75 + k * k * 40 + 0.5)
                    local ____L1_ctx_1988 = __L1.ctx
                    local ____t_result_1987
                    if __t(__mod(i, 2)) then
                        ____t_result_1987 = r.color
                    else
                        ____t_result_1987 = "#fff6d8"
                    end
                    ____L1_ctx_1988.fillStyle = ____t_result_1987
                    __L1.ctx:fillRect(
                        __bor(px - z / 2, 0),
                        __bor(py - z / 2, 0),
                        z,
                        z
                    )
                    __L1.ctx.globalAlpha = (1 - k) * 0.45
                    __L1.ctx:fillRect(
                        math.floor(r.x + math.cos(a) * d * 0.72 + 0.5) - 1,
                        math.floor(r.y + math.sin(a) * d * 0.54 + 0.5) - 1,
                        2,
                        2
                    )
                    __L1.ctx.globalAlpha = 1 - k * k
                    i = i + 1
                end
            end
            if k < 0.25 then
                local f = math.floor(18 * (1 - k / 0.25) * r.size + 0.5)
                __L1.ctx.fillStyle = "#fff6d8"
                __L1.ctx:fillRect(
                    r.x - f,
                    __bor(r.y - f / 3, 0),
                    f * 2,
                    __bor(f * 2 / 3, 0)
                )
                __L1.ctx:fillRect(
                    __bor(r.x - f / 3, 0),
                    r.y - f,
                    __bor(f * 2 / 3, 0),
                    f * 2
                )
            end
            __L1.ctx:restore()
        end
    end
    __L1.drawEpicScreen = function(self)
        local I = __L1.epic.intro
        if __t(I) then
            local a = I.age
            local inK = __L1:clamp(a / 0.32, 0, 1)
            local outK = __L1:clamp((a - 2.25) / 0.4, 0, 1)
            local bar = math.floor(__L1.H * 0.085 * (inK * (1 - outK)) + 0.5)
            if bar > 0 then
                __L1.ctx.fillStyle = "#0b1210"
                __L1.ctx:fillRect(0, 0, __L1.W, bar)
                __L1.ctx:fillRect(0, __L1.H - bar, __L1.W, bar)
            end
            if __t(__gt(a, 0.18) and outK < 1) then
                local slide = __L1:clamp((a - 0.18) / 0.2, 0, 1)
                local ease = 1 - (1 - slide) ^ 3
                local x = -420 + ease * (__L1.W / 2 + 420)
                local y = __L1.H * 0.27
                local w = math.min(
                    __L1.W - 40,
                    math.max(
                        320,
                        __len(I.name) * 14 + 80
                    )
                )
                __L1.ctx:save()
                __L1.ctx.globalAlpha = 1 - outK
                __L1.ctx:translate(
                    math.floor(x + 0.5),
                    math.floor(y + 0.5)
                )
                __L1.ctx.fillStyle = "#14211d"
                __L1.ctx:fillRect(-w / 2 - 6, -34, w + 12, 72)
                __L1.ctx.fillStyle = I.color
                __L1.ctx:fillRect(-w / 2, -28, w, 60)
                __L1.ctx.fillStyle = "#1c2e28"
                __L1.ctx:fillRect(-w / 2 + 5, -23, w - 10, 50)
                __L1.ctx.fillStyle = I.color
                do
                    local i = 0
                    while i < 6 do
                        __L1.ctx:fillRect(-w / 2 + 8 + i * 12, -31, 6, 3)
                        i = i + 1
                    end
                end
                __L1:text(
                    __add("CHEFE · NÍVEL ", I.level),
                    0,
                    -9,
                    12,
                    "#ffd98a"
                )
                __L1:text(
                    __call(I.name, "toUpperCase"),
                    0,
                    13,
                    math.max(
                        12,
                        math.min(
                            20,
                            math.floor((w - 30) / math.max(
                                8,
                                __len(I.name)
                            ) * 1.55)
                        )
                    ),
                    "#fff3d6"
                )
                if __t(__ge(a, 0.36) and __lt(a, 0.62)) then
                    __L1.ctx.globalAlpha = (0.62 - a) / 0.26 * 0.6
                    __L1.ctx.fillStyle = "#fff6d8"
                    __L1.ctx:fillRect(-w / 2, -28, w, 60)
                end
                __L1.ctx:restore()
            end
        end
        local P = __L1.epic.plate
        if __t(P) then
            local k = P.age / P.life
            local ____lt_result_1990
            if __lt(P.age, 0.18) then
                ____lt_result_1990 = 0.6 + P.age / 0.18 * 0.5
            else
                local ____lt_result_1989
                if __lt(P.age, 0.3) then
                    ____lt_result_1989 = 1.1 - (P.age - 0.18) / 0.12 * 0.1
                else
                    ____lt_result_1989 = 1
                end
                ____lt_result_1990 = ____lt_result_1989
            end
            local pop = ____lt_result_1990
            local ____temp_1991
            if k > 0.8 then
                ____temp_1991 = (1 - k) / 0.2
            else
                ____temp_1991 = 1
            end
            local alpha = ____temp_1991
            __L1.ctx:save()
            __L1.ctx.globalAlpha = __L1:clamp(alpha, 0, 1)
            __L1.ctx:translate(__L1.W / 2, __L1.H * 0.36)
            __L1.ctx:scale(pop, pop)
            __L1.ctx.font = "bold 34px monospace"
            __L1.ctx.textAlign = "center"
            __L1.ctx.textBaseline = "middle"
            __L1.ctx.lineWidth = 7
            __L1.ctx.lineJoin = "round"
            __L1.ctx.strokeStyle = "#14211d"
            __L1.ctx:strokeText(P.title, 0, 0)
            __L1.ctx.fillStyle = P.color
            __L1.ctx:fillText(P.title, 0, 0)
            if __t(P.sub) then
                __L1.ctx.font = "bold 14px monospace"
                __L1.ctx.lineWidth = 4
                __L1.ctx:strokeText(P.sub, 0, 30)
                __L1.ctx.fillStyle = "#fff3d6"
                __L1.ctx:fillText(P.sub, 0, 30)
            end
            __L1.ctx:restore()
        end
        if __L1.epic.flash > 0 then
            __L1.ctx:save()
            __L1.ctx.globalAlpha = math.min(0.55, __L1.epic.flash)
            __L1.ctx.fillStyle = __L1.epic.flashColor
            __L1.ctx:fillRect(0, 0, __L1.W, __L1.H)
            __L1.ctx:restore()
        end
    end
    __L1.drawPlank = function(self, p)
        local ____t_2000 = __t
        local ____t_result_1999
        local ____t_1993 = __t
        local ____temp_1992 = __L1.scene >= 12
        __O[1935] = ____temp_1992
        if ____t_1993(____temp_1992) then
            local ____opt_1996 = window.CampanhaCenarios
            if ____opt_1996 ~= nil then
                ____opt_1996 = ____opt_1996.plataforma
            end
            local ____opt_result_1998
            if ____opt_1996 ~= nil then
                ____opt_result_1998 = ____opt_1996(
                    ____opt_1996,
                    __L1.ctx,
                    __L1.scene,
                    p,
                    __L1.time
                )
            end
            ____t_result_1999 = ____opt_result_1998
        else
            ____t_result_1999 = __O[1935]
        end
        if ____t_2000(____t_result_1999) then
            return
        end
        local x = math.floor(__get(p, 0) + 0.5)
        local y = math.floor(__get(p, 1) + 0.5)
        local w = math.floor(__get(p, 2) + 0.5)
        local metal = __L1.scene == 2
        local ink = __L1.scene == 6
        local ____t_result_2003
        local ____t_2002 = __t
        local ____temp_2001 = __L1.scene == 0 or __L1.scene == 7
        __O[1936] = ____temp_2001
        if ____t_2002(____temp_2001) then
            ____t_result_2003 = __O[1936]
        else
            ____t_result_2003 = __L1.scene == 3
        end
        local grassy = ____t_result_2003
        local dark = __t(metal) and "#3e4a45" or (__t(ink) and "#3d2c52" or "#4f3624")
        local mid = __t(metal) and "#63736a" or (__t(ink) and "#7d6596" or "#8d6a45")
        local lit = __t(metal) and "#8fa096" or (__t(ink) and "#b59bd0" or "#b88d5c")
        __L1.ctx.fillStyle = "rgba(20,28,24,.22)"
        __L1.ctx:fillRect(x + 10, y + 15, w - 20, 6)
        for ____, sx in __iterar((__arrL({x + 14, x + w - 20}, 2))) do
            __L1.ctx.fillStyle = dark
            __L1.ctx:fillRect(sx, y + 12, 6, 10)
            __L1.ctx.fillStyle = mid
            __L1.ctx:fillRect(sx + 1, y + 12, 2, 9)
        end
        __L1.ctx.fillStyle = dark
        __L1.ctx:fillRect(x - 1, y, w + 2, 14)
        __L1.ctx.fillStyle = mid
        __L1.ctx:fillRect(x, y + 1, w, 11)
        do
            local xx = x
            while xx < x + w do
                __L1.ctx.fillStyle = dark
                __L1.ctx:fillRect(xx, y + 1, 1, 11)
                __L1.ctx.fillStyle = lit
                __L1.ctx:fillRect(
                    xx + 2,
                    y + 3,
                    math.min(10, x + w - xx - 3),
                    1
                )
                __L1.ctx.fillStyle = dark
                __L1.ctx:fillRect(xx + 5, y + 7, 2, 2)
                xx = xx + math.max(
                    18,
                    math.floor(w / math.max(
                        2,
                        math.floor(w / 34 + 0.5)
                    ) + 0.5)
                )
            end
        end
        __L1.ctx.fillStyle = lit
        __L1.ctx:fillRect(x, y + 1, w, 2)
        if __t(grassy) then
            __L1.ctx.fillStyle = "#4f8f3c"
            __L1.ctx:fillRect(x - 1, y - 1, w + 2, 3)
            __L1.ctx.fillStyle = "#8fc451"
            do
                local xx = x + 2
                while xx < x + w - 2 do
                    local h = 1 + __mod(xx * 7, 3)
                    local sw = math.floor(math.sin(__L1.time * 1.6 + xx * 0.05) + 0.5)
                    __L1.ctx:fillRect(xx + sw, y - 1 - h, 2, h)
                    xx = xx + 5
                end
            end
            __L1.ctx.fillStyle = "#3f7a34"
            do
                local xx = x + 6
                while xx < x + w - 6 do
                    __L1.ctx:fillRect(
                        xx,
                        y + 12,
                        2,
                        3 + __mod(xx * 13, 5)
                    )
                    xx = xx + 23
                end
            end
        else
            __L1.ctx.fillStyle = __t(metal) and "#b8c4bc" or "#d9c08f"
            __L1.ctx:fillRect(x, y, w, 1)
        end
    end
    __L1.hazPal = function(self, h)
        local ____t_result_2019
        if __t(h.catarro) then
            ____t_result_2019 = __L1.HAZ.slime
        else
            local ____t_result_2018
            if __t(h.brasa) then
                ____t_result_2018 = __L1.HAZ.brasa
            else
                local ____t_result_2017
                local ____t_2005 = __t
                local ____t_result_2004
                if __t(h.ink) then
                    ____t_result_2004 = h.ink
                else
                    ____t_result_2004 = h.type == "ink"
                end
                if ____t_2005(____t_result_2004) then
                    ____t_result_2017 = __L1.HAZ.ink
                else
                    local ____t_result_2016
                    local ____t_2009 = __t
                    local ____t_result_2008
                    local ____t_2007 = __t
                    local ____temp_2006 = h.type == "smoke"
                    __O[1937] = ____temp_2006
                    if ____t_2007(____temp_2006) then
                        ____t_result_2008 = __O[1937]
                    else
                        ____t_result_2008 = h.smoke
                    end
                    if ____t_2009(____t_result_2008) then
                        ____t_result_2016 = __L1.HAZ.smoke
                    else
                        local ____t_result_2015
                        local ____t_2013 = __t
                        local ____t_result_2012
                        local ____t_2011 = __t
                        local ____temp_2010 = h.type == "astral"
                        __O[1938] = ____temp_2010
                        if ____t_2011(____temp_2010) then
                            ____t_result_2012 = __O[1938]
                        else
                            ____t_result_2012 = h.astral
                        end
                        if ____t_2013(____t_result_2012) then
                            ____t_result_2015 = __L1.HAZ.astral
                        else
                            local ____temp_2014
                            if h.type == "slime" then
                                ____temp_2014 = __L1.HAZ.slime
                            else
                                ____temp_2014 = __L1.HAZ.pink
                            end
                            ____t_result_2015 = ____temp_2014
                        end
                        ____t_result_2016 = ____t_result_2015
                    end
                    ____t_result_2017 = ____t_result_2016
                end
                ____t_result_2018 = ____t_result_2017
            end
            ____t_result_2019 = ____t_result_2018
        end
        return ____t_result_2019
    end
    __L1.px = function(self, x, y, w, h, c)
        __L1.ctx.fillStyle = c
        __L1.ctx:fillRect(
            math.floor(x + 0.5),
            math.floor(y + 0.5),
            math.floor(w + 0.5),
            math.floor(h + 0.5)
        )
    end
    __L1.spike = function(self, x, base, h, pal, seed)
        local w = 6 + __mod(seed, 2) * 2
        do
            local yy = 0
            while __lt(yy, h) do
                local k = 1 - yy / h
                local ww = math.max(
                    2,
                    math.floor(w * k + 0.5)
                )
                local ____L1_px_2025 = __L1.px
                local ____temp_2023 = x - ww / 2
                local ____temp_2024 = base - yy - 4
                local ____temp_2022
                if yy < 4 then
                    ____temp_2022 = __get(pal, 0)
                else
                    local ____temp_2021
                    if k < 0.35 then
                        ____temp_2021 = __get(pal, 3)
                    else
                        local ____temp_2020
                        if k < 0.7 then
                            ____temp_2020 = __get(pal, 2)
                        else
                            ____temp_2020 = __get(pal, 1)
                        end
                        ____temp_2021 = ____temp_2020
                    end
                    ____temp_2022 = ____temp_2021
                end
                ____L1_px_2025(
                    __L1,
                    ____temp_2023,
                    ____temp_2024,
                    ww,
                    4,
                    ____temp_2022
                )
                yy = yy + 4
            end
        end
        __L1:px(
            x - 1,
            base - h - 2,
            2,
            2,
            __get(pal, 3)
        )
    end
    __L1.crack = function(self, x0, x1, pal, a)
        __L1.ctx:save()
        __L1.ctx.globalAlpha = a
        local y = __L1.FLOOR - 3
        do
            local x = x0
            while __lt(x, x1) do
                y = __L1.FLOOR - 3 + math.floor(math.sin(x * 0.37) * 1.4 + 0.5)
                __L1:px(
                    x,
                    y,
                    4,
                    2,
                    __get(pal, 2)
                )
                if __L1:hsh(x) > 0.8 then
                    __L1:px(
                        x + 1,
                        y - 2,
                        2,
                        2,
                        __get(pal, 3)
                    )
                end
                x = x + 4
            end
        end
        __L1.ctx:restore()
    end
    __L1.drawHazardPixel = function(self, h)
        local pal = __L1:hazPal(h)
        local t = __L1.time
        local ____t_2031 = __t
        local ____opt_2028 = window.Graphics
        if ____opt_2028 ~= nil then
            ____opt_2028 = ____opt_2028.isLite
        end
        local ____opt_result_2030
        if ____opt_2028 ~= nil then
            ____opt_result_2030 = ____opt_2028(____opt_2028)
        end
        local lite = not not ____t_2031(____opt_result_2030)
        local ____t_2041 = __t
        local ____opt_2038 = window.Golpes
        if ____opt_2038 ~= nil then
            ____opt_2038 = ____opt_2038.desenharPerigo
        end
        local ____opt_result_2040
        if ____opt_2038 ~= nil then
            local ____L1_ctx_2035 = __L1.ctx
            local ____h_2036 = h
            local ____opt_2033 = __L1.activeBoss
            if ____opt_2033 ~= nil then
                ____opt_2033 = ____opt_2033.type
            end
            ____opt_result_2040 = ____opt_2038(
                ____opt_2038,
                ____L1_ctx_2035,
                ____h_2036,
                t,
                lite,
                pal,
                ____opt_2033
            )
        end
        if ____t_2041(____opt_result_2040) then
            return
        end
        if __gt(h.delay, 0) then
            local blink = 0.45 + 0.35 * math.abs(math.sin(t * 14))
            if h.type == "ring" then
                __L1:crack(h.x - 46, h.x + 46, pal, blink)
            else
                __L1:crack(
                    h.x - h.r,
                    __add(h.x, h.r),
                    pal,
                    blink
                )
            end
            local span = h.type == "ring" and 46 or h.r
            __L1.ctx:save()
            do
                local i = 0
                while i < (__t(lite) and 4 or 10) do
                    local k = __mod(
                        t * 1.6 + __L1:hsh(i + h.x),
                        1
                    )
                    local ex = h.x + (__L1:hsh(i * 7 + h.x) - 0.5) * span * 2
                    __L1.ctx.globalAlpha = (1 - k) * blink
                    local ____L1_px_2046 = __L1.px
                    local ____temp_2043 = __L1.FLOOR - 6
                    local ____t_result_2042
                    if __t(h.height) then
                        ____t_result_2042 = math.min(160, h.height * 0.6)
                    else
                        ____t_result_2042 = 46
                    end
                    local ____temp_2045 = ____temp_2043 - k * ____t_result_2042
                    local ____t_result_2044
                    if __t(__mod(i, 2)) then
                        ____t_result_2044 = __get(pal, 2)
                    else
                        ____t_result_2044 = __get(pal, 3)
                    end
                    ____L1_px_2046(
                        __L1,
                        ex,
                        ____temp_2045,
                        3,
                        3,
                        ____t_result_2044
                    )
                    i = i + 1
                end
            end
            __L1.ctx:restore()
            if __t(h.height) then
                __L1.ctx:save()
                __L1.ctx.globalAlpha = 0.16 + 0.1 * math.sin(t * 20)
                do
                    local y = __L1.FLOOR - h.height
                    while y < __L1.FLOOR do
                        __L1:px(
                            h.x - h.r,
                            y,
                            h.r * 2,
                            2,
                            __get(pal, 2)
                        )
                        y = y + 8
                    end
                end
                __L1.ctx:restore()
            end
            if __t(h.cinza) then
                __L1.ctx:save()
                local n = __t(lite) and 8 or 18
                local dens = __L1:clamp(1.4 - h.delay, 0.35, 1)
                do
                    local i = 0
                    while i < n do
                        local k = __mod(
                            t * 0.8 + __L1:hsh(i * 5 + h.x),
                            1
                        )
                        local fx_ = h.x + (__L1:hsh(i * 3 + h.x) - 0.5) * h.r * 2 + math.sin(t * 3 + i) * 7
                        local fy = 30 + k * (__L1.FLOOR - 40)
                        __L1.ctx.globalAlpha = dens * (__t(__mod(i, 4)) and 0.75 or 1)
                        if __t(__mod(i, 4)) then
                            __L1:px(
                                fx_,
                                fy,
                                3,
                                2,
                                __t(__mod(i, 3)) and "#8a8680" or "#b8b4ac"
                            )
                        else
                            __L1:px(
                                fx_,
                                fy,
                                2,
                                2,
                                "#ff8a30"
                            )
                            __L1:px(
                                fx_,
                                fy - 1,
                                1,
                                1,
                                "#ffe08a"
                            )
                        end
                        i = i + 1
                    end
                end
                __L1.ctx:restore()
            end
            return
        end
        local ____t_result_2047
        if __t(h.life) then
            ____t_result_2047 = h.life
        else
            ____t_result_2047 = 0
        end
        local life = math.max(0, ____t_result_2047)
        local ____t_2055 = __t
        local ____t_result_2054
        local ____t_2051 = __t
        local ____t_result_2050
        local ____t_2049 = __t
        local ____temp_2048 = h.type == "ring"
        __O[1939] = ____temp_2048
        if ____t_2049(____temp_2048) then
            ____t_result_2050 = h.catarro
        else
            ____t_result_2050 = __O[1939]
        end
        __O[1940] = ____t_result_2050
        if ____t_2051(____t_result_2050) then
            local ____opt_2052 = window.NikolasFx
            if ____opt_2052 ~= nil then
                ____opt_2052 = ____opt_2052.onda
            end
            ____t_result_2054 = ____opt_2052
        else
            ____t_result_2054 = __O[1940]
        end
        if ____t_2055(____t_result_2054) then
            window.NikolasFx:onda(__L1.ctx, h, __L1.time, lite)
            return
        end
        if h.type == "ring" then
            for ____, dir in __iterar((__arrL({-1, 1}, 2))) do
                local cx = h.x + dir * h.r
                __L1.ctx:save()
                __L1.ctx.globalAlpha = 0.55
                do
                    local x = h.x
                    while true do
                        local ____t_2061 = __t
                        local ____temp_2060
                        if dir > 0 then
                            ____temp_2060 = __lt(x, cx - 8)
                        else
                            ____temp_2060 = __gt(x, cx + 8)
                        end
                        if not ____t_2061(____temp_2060) then
                            break
                        end
                        local fade = math.abs(x - h.x) / math.max(1, h.r)
                        __L1:px(
                            x,
                            __L1.FLOOR - 3,
                            6,
                            2,
                            __get(pal, 1)
                        )
                        if __L1:hsh(x) > 0.6 then
                            local ____L1_px_2059 = __L1.px
                            local ____temp_2057 = x + 2
                            local ____temp_2058 = __L1.FLOOR - 5 - __L1:hsh(x + 3) * 3
                            local ____temp_2056
                            if fade > 0.6 then
                                ____temp_2056 = __get(pal, 2)
                            else
                                ____temp_2056 = __get(pal, 0)
                            end
                            ____L1_px_2059(
                                __L1,
                                ____temp_2057,
                                ____temp_2058,
                                2,
                                2,
                                ____temp_2056
                            )
                        end
                        x = x + dir * 8
                    end
                end
                __L1.ctx:restore()
                if __t(h.smoke) then
                    do
                        local i = 0
                        while i < 6 do
                            local sx = cx - dir * i * 9
                            local z = math.max(6, 24 - i * 3) * (0.9 + 0.1 * math.sin(t * 20 + i))
                            local yy = __L1.FLOOR - z - __mod(i * 7, 5)
                            __L1.ctx:save()
                            __L1.ctx.globalAlpha = 0.88 - i * 0.11
                            __L1:px(
                                sx - z / 2,
                                yy,
                                z,
                                z,
                                __get(pal, 1)
                            )
                            __L1:px(
                                sx - z / 2 + 2,
                                yy + 2,
                                z - 5,
                                z - 5,
                                __get(pal, 2)
                            )
                            __L1:px(
                                sx - z / 2 + 3,
                                yy + 3,
                                z / 3,
                                z / 3,
                                __get(pal, 3)
                            )
                            __L1.ctx:restore()
                            i = i + 1
                        end
                    end
                else
                    do
                        local i = 0
                        while i < 5 do
                            local sx = cx - dir * i * 7
                            local hgt = math.max(
                                8,
                                (52 - i * 9) * (0.85 + 0.15 * math.sin(t * 30 + i))
                            )
                            __L1:spike(
                                sx,
                                __L1.FLOOR,
                                hgt,
                                pal,
                                i
                            )
                            i = i + 1
                        end
                    end
                end
                if not __t(lite) then
                    do
                        local i = 0
                        while i < 6 do
                            local k = __mod(t * 3 + i / 6, 1)
                            __L1.ctx:save()
                            __L1.ctx.globalAlpha = 1 - k
                            local ____L1_px_2064 = __L1.px
                            local ____array_2063 = __TS__SparseArrayNew(
                                cx + dir * (4 + k * 30) + (__L1:hsh(i) - 0.5) * 10,
                                __L1.FLOOR - 10 - k * 48 + k * k * 30,
                                __t(__mod(i, 2)) and 3 or 2,
                                __t(__mod(i, 2)) and 3 or 2
                            )
                            local ____t_result_2062
                            if __t(__mod(i, 3)) then
                                ____t_result_2062 = __get(pal, 2)
                            else
                                ____t_result_2062 = __get(pal, 3)
                            end
                            __TS__SparseArrayPush(____array_2063, ____t_result_2062)
                            ____L1_px_2064(
                                __L1,
                                __TS__SparseArraySpread(____array_2063)
                            )
                            __L1.ctx:restore()
                            i = i + 1
                        end
                    end
                end
            end
            return
        end
        if __t(h.brasa) then
            __L1.ctx:save()
            local n = math.max(
                4,
                math.floor(h.r / 5 + 0.5)
            )
            local fade = __L1:clamp(life * 2, 0, 1)
            do
                local i = 0
                while i < n do
                    local ex = h.x - h.r + 4 + i * (h.r * 2 - 8) / math.max(1, n - 1)
                    local f = math.sin(t * 22 + i * 2.3)
                    __L1.ctx.globalAlpha = fade
                    local ____L1_px_2068 = __L1.px
                    local ____temp_2066 = ex - 2
                    local ____temp_2067 = __L1.FLOOR - 5
                    local ____temp_2065
                    if f > 0.3 then
                        ____temp_2065 = __get(pal, 2)
                    else
                        ____temp_2065 = __get(pal, 1)
                    end
                    ____L1_px_2068(
                        __L1,
                        ____temp_2066,
                        ____temp_2067,
                        5,
                        3,
                        ____temp_2065
                    )
                    if f > 0.5 then
                        __L1:px(
                            ex - 1,
                            __L1.FLOOR - 6,
                            2,
                            1,
                            __get(pal, 3)
                        )
                    end
                    if __mod(i, 2) == 0 then
                        local fh = (6 + __L1:hsh(i + h.x) * 8) * (0.7 + 0.3 * math.sin(t * 28 + i))
                        __L1:px(
                            ex - 1,
                            __L1.FLOOR - 5 - fh,
                            3,
                            fh,
                            __get(pal, 2)
                        )
                        __L1:px(
                            ex,
                            __L1.FLOOR - 5 - fh,
                            1,
                            fh * 0.5,
                            __get(pal, 3)
                        )
                    end
                    i = i + 1
                end
            end
            __L1.ctx:restore()
        end
        if h.type == "smoke" then
            local ____t_result_2069
            if __t(h.brasa) then
                ____t_result_2069 = __L1.HAZ.smoke
            else
                ____t_result_2069 = pal
            end
            local sp = ____t_result_2069
            local m = __t(h.brasa) and 5 or 9
            __L1.ctx:save()
            do
                local i = 0
                while i < m do
                    local bx = h.x + (i - (m - 1) / 2) * h.r / 4.5
                    local rise = __mod(t * 20 + i * 13, 40)
                    local z = (__t(h.brasa) and 7 or 10) + __mod(i * 5, 3) * 4
                    __L1.ctx.globalAlpha = (0.55 * (1 - rise / 40) + 0.15) * (__t(h.brasa) and 0.7 or 1)
                    for ____, ____value in __iterar((__arrL(
                        {
                            __arrL(
                                {
                                    0,
                                    0,
                                    __get(sp, 1)
                                },
                                3
                            ),
                            __arrL(
                                {
                                    2,
                                    -2,
                                    __get(sp, 2)
                                },
                                3
                            ),
                            __arrL(
                                {
                                    4,
                                    -4,
                                    __get(sp, 3)
                                },
                                3
                            )
                        },
                        3
                    ))) do
                        local dx = ____value[1]
                        local dy = ____value[2]
                        local c = ____value[3]
                        __L1:px(
                            bx - z / 2 + dx,
                            __L1.FLOOR - 24 - rise - z + dy,
                            z - dx,
                            z - dx,
                            c
                        )
                    end
                    i = i + 1
                end
            end
            __L1.ctx:restore()
        end
        if __t(h.height) then
            local top = __L1.FLOOR - h.height
            local w = h.r * 2
            __L1.ctx:save()
            do
                local y = top
                while y < __L1.FLOOR do
                    local flick = math.floor(math.sin(t * 40 + y * 0.3) * 2 + 0.5)
                    __L1.ctx.globalAlpha = 0.55
                    __L1:px(
                        h.x - h.r + flick,
                        y,
                        w - flick * 2,
                        6,
                        __get(pal, 1)
                    )
                    __L1.ctx.globalAlpha = 0.85
                    __L1:px(
                        h.x - h.r * 0.45,
                        y,
                        h.r * 0.9,
                        6,
                        __get(pal, 2)
                    )
                    __L1:px(
                        h.x - h.r * 0.15,
                        y,
                        h.r * 0.3,
                        6,
                        __get(pal, 3)
                    )
                    y = y + 6
                end
            end
            __L1.ctx.globalAlpha = 0.9
            do
                local i = 0
                while i < (__t(lite) and 3 or 8) do
                    local k = __mod(t * 2.4 + i / 8, 1)
                    __L1:px(
                        h.x + (__L1:hsh(i + 3) - 0.5) * w,
                        __L1.FLOOR - k * h.height,
                        3,
                        6,
                        __get(pal, 3)
                    )
                    i = i + 1
                end
            end
            __L1.ctx:restore()
            __L1:crack(
                h.x - h.r - 10,
                __add(h.x, h.r) + 10,
                pal,
                0.8
            )
        elseif h.type ~= "smoke" then
            local n = math.max(
                3,
                math.floor(h.r * 2 / 12 + 0.5)
            )
            do
                local i = 0
                while i < n do
                    local sx = h.x - h.r + 6 + i * (h.r * 2 - 12) / math.max(1, n - 1)
                    local hgt = (18 + __L1:hsh(i + h.x) * 30) * (0.8 + 0.2 * math.sin(t * 26 + i))
                    __L1:spike(
                        sx,
                        __L1.FLOOR,
                        hgt,
                        pal,
                        i
                    )
                    i = i + 1
                end
            end
            __L1:crack(
                h.x - h.r,
                __add(h.x, h.r),
                pal,
                0.9
            )
        end
        if h.type == "astral" then
            __L1.ctx:save()
            do
                local y = 60
                while y < __L1.FLOOR do
                    local f = math.floor(math.sin(t * 50 + y) * 1.5 + 0.5)
                    __L1:px(
                        h.x - 8 + f,
                        y,
                        16 - f * 2,
                        6,
                        __get(pal, 2)
                    )
                    __L1:px(
                        h.x - 3,
                        y,
                        6,
                        6,
                        __get(pal, 3)
                    )
                    y = y + 6
                end
            end
            __L1.ctx:restore()
        end
    end
    __L1.drawPhaseFlames = function(self, e)
        local ____L1_clamp_2072 = __L1.clamp
        local ____e_stateTimer_2071 = e.stateTimer
        local ____t_result_2070
        if __t(e.phaseDuration) then
            ____t_result_2070 = e.phaseDuration
        else
            ____t_result_2070 = 1.05
        end
        local k = math.max(
            0,
            math.sin(____L1_clamp_2072(__L1, ____e_stateTimer_2071 / ____t_result_2070, 0, 1) * math.pi)
        )
        local ____temp_2074
        if e.type == "nikolas" then
            ____temp_2074 = __L1.HAZ.slime
        else
            local ____temp_2073
            if e.type == "menezes" then
                ____temp_2073 = __L1.HAZ.pink
            else
                ____temp_2073 = __L1.HAZ.ink
            end
            ____temp_2074 = ____temp_2073
        end
        local pal = ____temp_2074
        local spread = 60 + __L1:nikolasTransformProgress(e) * 80
        do
            local i = 0
            while i < 14 do
                local side = __t(__mod(i, 2)) and 1 or -1
                local off = (14 + math.floor(i / 2) * spread / 7) * side
                local hgt = (30 + __L1:hsh(i) * 60) * k * (0.8 + 0.2 * math.sin(__L1.time * 24 + i))
                __L1:spike(
                    e.x + off,
                    __L1.FLOOR,
                    hgt,
                    pal,
                    i
                )
                i = i + 1
            end
        end
        __L1.ctx:save()
        do
            local i = 0
            while i < 18 do
                local p = __mod(__L1.time * 1.4 + i / 18, 1)
                __L1.ctx.globalAlpha = k * (1 - p)
                local ____L1_px_2077 = __L1.px
                local ____array_2076 = __TS__SparseArrayNew(
                    e.x + (__L1:hsh(i + 9) - 0.5) * spread * 2.2,
                    __L1.FLOOR - 10 - p * 170,
                    __t(__mod(i, 3)) and 3 or 4,
                    __t(__mod(i, 3)) and 3 or 4
                )
                local ____t_result_2075
                if __t(__mod(i, 2)) then
                    ____t_result_2075 = __get(pal, 2)
                else
                    ____t_result_2075 = __get(pal, 3)
                end
                __TS__SparseArrayPush(____array_2076, ____t_result_2075)
                ____L1_px_2077(
                    __L1,
                    __TS__SparseArraySpread(____array_2076)
                )
                i = i + 1
            end
        end
        __L1.ctx:restore()
    end
    __L1.epilogueCue = function(self, film)
        local ____opt_result_2080
        if film ~= nil then
            ____opt_result_2080 = film.kind
        end
        if ____opt_result_2080 ~= "jorge_epilogue" then
            return
        end
        local ____opt_2085 = window.Cinematics
        if ____opt_2085 ~= nil then
            ____opt_2085 = ____opt_2085.beat
        end
        local ____opt_result_2087
        if ____opt_2085 ~= nil then
            ____opt_result_2087 = ____opt_2085(____opt_2085, film)
        end
        local ____opt_result_2088
        if ____opt_result_2087 ~= nil then
            ____opt_result_2088 = ____opt_result_2087.id
        end
        local shot = ____opt_result_2088
        if shot == "vibration" then
            __L1:beep(72, 0.24, "sawtooth", 0.025)
            __L1:beep(94, 0.15, "triangle", 0.014)
        elseif shot == "caller" then
            __L1:beep(660, 0.24, "sine", 0.018)
            __L1:beep(440, 0.34, "sine", 0.014)
        elseif shot == "recognition" then
            __L1:beep(48, 0.55, "sine", 0.025)
        elseif shot == "falling" then
            __L1:beep(110, 0.09, "triangle", 0.023)
        end
    end
    __L1.update = function(self, dt)
        __L1.time = __L1.time + dt
        __L1.transition = math.max(0, __L1.transition - dt)
        __L1.toastTimer = math.max(0, __L1.toastTimer - dt)
        if not __t(__L1.toastTimer) then
            local e = __L1["$"](__L1, "toast")
            if __t(e) then
                e.classList:remove("show")
                e.hidden = true
            end
        end
        local ____t_2096 = __t
        local ____t_result_2095
        local ____t_2094 = __t
        local ____t_result_2093
        local ____t_2092 = __t
        local ____t_result_2091
        local ____t_2090 = __t
        local ____temp_2089 = not __t(__L1.started)
        __O[1941] = ____temp_2089
        if ____t_2090(____temp_2089) then
            ____t_result_2091 = __O[1941]
        else
            ____t_result_2091 = __L1.paused
        end
        __O[1942] = ____t_result_2091
        if ____t_2092(____t_result_2091) then
            ____t_result_2093 = __O[1942]
        else
            ____t_result_2093 = __L1.dialog
        end
        __O[1943] = ____t_result_2093
        if ____t_2094(____t_result_2093) then
            ____t_result_2095 = __O[1943]
        else
            ____t_result_2095 = __L1.defeated
        end
        if ____t_2096(____t_result_2095) then
            __L1:updateEffects(dt)
            return
        end
        if __t(__L1.cutscene) then
            local film = __L1.cutscene
            local before = film.index
            local ____t_2099 = __t
            local ____opt_2097 = window.GameMusic
            if ____opt_2097 ~= nil then
                ____opt_2097 = ____opt_2097.isCutsceneTimed
            end
            if ____t_2099(____opt_2097) then
                film.options.musicTimed = window.GameMusic:isCutsceneTimed(film.kind)
            end
            local ____add_2101 = __add
            local ____t_result_2100
            if __t(film.audioElapsed) then
                ____t_result_2100 = film.audioElapsed
            else
                ____t_result_2100 = 0
            end
            film.audioElapsed = ____add_2101(____t_result_2100, dt)
            window.Cinematics:update(film, dt)
            if __t(film.done) then
                __L1:finishCutscene()
            elseif film.index ~= before then
                __L1:epilogueCue(film)
                __L1:updateUI()
            end
            return
        end
        if __t(__L1.won) then
            __L1:updateEffects(dt)
            return
        end
        local ____t_2103 = __t
        local ____t_result_2102
        if __t(__L1.room) then
            ____t_result_2102 = __L1.room.phase ~= "inside"
        else
            ____t_result_2102 = __L1.room
        end
        if ____t_2103(____t_result_2102) then
            __L1:updateRoomTransition(dt)
            __L1:updateEffects(dt)
            return
        end
        local ____t_2105 = __t
        local ____t_result_2104
        if __t(__L1.arena) then
            ____t_result_2104 = __L1.arena.phase ~= "active"
        else
            ____t_result_2104 = __L1.arena
        end
        if ____t_2105(____t_result_2104) then
            __L1:updateArenaTransition(dt)
            __L1:updateEffects(dt)
            return
        end
        local ____t_2108 = __t
        local ____opt_2106 = __L1.routeTransition
        if ____opt_2106 ~= nil then
            ____opt_2106 = ____opt_2106.chegada
        end
        if ____t_2108(____opt_2106) then
            local ____t_2114 = __t
            local ____opt_2111 = window.ChegadaCarro
            if ____opt_2111 ~= nil then
                ____opt_2111 = ____opt_2111.atualizar
            end
            local ____opt_result_2113
            if ____opt_2111 ~= nil then
                ____opt_result_2113 = ____opt_2111(____opt_2111, dt)
            end
            if not ____t_2114(____opt_result_2113) then
                __L1.routeTransition = nil
            end
            __L1:updateEffects(dt)
            return
        end
        if __t(__L1.routeTransition) then
            __L1.routeTransition.t = __add(__L1.routeTransition.t, dt)
            if __ge(__L1.routeTransition.t, __L1.routeTransition.duration) then
                local dest = __L1.routeTransition.to
                local de = __L1.routeTransition.from
                local ____t_2116 = __t
                local ____t_result_2115
                if __t(__L1.routeTransition.estrada) then
                    ____t_result_2115 = window.ChegadaCarro
                else
                    ____t_result_2115 = __L1.routeTransition.estrada
                end
                if ____t_2116(____t_result_2115) then
                    window.ChegadaCarro:iniciar(dest)
                    __L1.routeTransition = {
                        from = de,
                        to = dest,
                        t = 0,
                        duration = window.ChegadaCarro.duracao,
                        chegada = true
                    }
                    __L1:arrive(dest)
                else
                    __L1.routeTransition = nil
                    __L1:arrive(dest)
                end
            end
            __L1:updateEffects(dt)
            return
        end
        if __t(__L1.activity) then
            window.Activities:update(__L1.activity, dt)
            if __t(__L1.activity.kind == "dinner" and __L1.activity.phase == "breath") then
                __L1.dinnerMeter.style:setProperty(
                    "--marker",
                    __add(
                        __call(__L1.activity.marker * 100, "toFixed", 2),
                        "%"
                    )
                )
            end
            if __t(__L1.activity.done) then
                __L1:finishActivity()
            end
            __L1.uiTimer = __L1.uiTimer + dt
            if __L1.uiTimer > 0.1 then
                __L1.uiTimer = 0
                __L1:updateUI()
            end
            return
        end
        local ____t_2119 = __t
        local ____opt_2117 = __L1.training
        if ____opt_2117 ~= nil then
            ____opt_2117 = ____opt_2117.active
        end
        if ____t_2119(____opt_2117) then
            __L1:updateTraining(dt)
            __L1:updateEffects(dt)
            __L1.uiTimer = __L1.uiTimer + dt
            if __L1.uiTimer > 0.12 then
                __L1.uiTimer = 0
                __L1:updateUI()
            end
            return
        end
        if __t(not __t(__L1.ollyanEncounter) or __L1.ollyanEncounter.stage ~= "intro") then
            __L1:updateBivolt(dt)
        end
        if __t(__L1.ollyanEncounter) then
            __L1:updateOllyan(dt)
            return
        end
        __L1.ollyanRetryGrace = math.max(0, __L1.ollyanRetryGrace - dt)
        __L1.comboWindow = math.max(0, __L1.comboWindow - dt)
        if not __t(__L1.comboWindow) then
            __L1.comboStep = 0
        end
        __L1.bossHintCooldown = math.max(0, __L1.bossHintCooldown - dt)
        __L1.player.landTimer = math.max(0, __L1.player.landTimer - dt)
        __L1.tauntCooldown = math.max(0, __L1.tauntCooldown - dt)
        local wasDashing = __L1.dashTimer > 0
        __L1.dashTimer = math.max(0, __L1.dashTimer - dt)
        local ____t_2121 = __t
        local ____t_result_2120
        if __t(wasDashing) then
            ____t_result_2120 = __L1.dashTimer == 0
        else
            ____t_result_2120 = wasDashing
        end
        if ____t_2121(____t_result_2120) then
            __L1.player.vx = __L1:clamp(
                __L1.player.vx,
                __TS__Number(-__L1:bonus().moveSpeed),
                __L1:bonus().moveSpeed
            )
        end
        __L1.dashCooldown = math.max(0, __L1.dashCooldown - dt)
        __L1.routeEdgeCooldown = math.max(0, __L1.routeEdgeCooldown - dt)
        __L1.player.inv = math.max(0, __L1.player.inv - dt)
        __L1.player.attack = math.max(0, __L1.player.attack - dt)
        __L1.attackCooldown = math.max(0, __L1.attackCooldown - dt)
        __L1.fartCooldown = math.max(0, __L1.fartCooldown - dt)
        __L1.reeisCooldown = math.max(0, __L1.reeisCooldown - dt)
        __L1:movePlayer(dt)
        if not __t(__L1.room) then
            if __t(__L1:keyHeld("paper")) then
                __L1:paperAttack()
            end
            if __t(__L1:keyHeld("fart")) then
                __L1:fartAttack()
            end
        end
        if __t(__L1.room) then
            local ____t_result_2124
            local ____t_2123 = __t
            local ____getq_result_2122 = __getq(
                __L1:closestNPC(),
                0
            )
            __O[1944] = ____getq_result_2122
            if ____t_2123(____getq_result_2122) then
                ____t_result_2124 = __O[1944]
            else
                ____t_result_2124 = nil
            end
            __L1.nearNPC = ____t_result_2124
            __L1.uiTimer = __L1.uiTimer + dt
            if __L1.uiTimer > 0.12 then
                __L1.uiTimer = 0
                __L1:updateUI()
            end
            __L1:updateEffects(dt)
            return
        end
        __L1.ammoTimer = __L1.ammoTimer + dt
        if __L1.ammoTimer > 1.1 then
            __L1.ammoTimer = 0
            __L1.player.papers = math.min(30, __L1.player.papers + 1)
        end
        local ____t_2130 = __t
        local ____t_result_2129
        local ____t_2128 = __t
        local ____t_result_2127
        local ____t_2126 = __t
        local ____t_result_2125
        if __t(__L1.player.ground) then
            ____t_result_2125 = __lt(
                __L1.player.hp,
                __L1:bonus().maxHP
            )
        else
            ____t_result_2125 = __L1.player.ground
        end
        __O[1945] = ____t_result_2125
        if ____t_2126(____t_result_2125) then
            ____t_result_2127 = not __t(__L1.activeBoss)
        else
            ____t_result_2127 = __O[1945]
        end
        __O[1946] = ____t_result_2127
        if ____t_2128(____t_result_2127) then
            ____t_result_2129 = not __t(__L1.arena)
        else
            ____t_result_2129 = __O[1946]
        end
        if ____t_2130(____t_result_2129) then
            __L1.player.hp = math.min(
                __L1:bonus().maxHP,
                __L1.player.hp + dt * 2.5
            )
        end
        if not __t(__L1:terrenoConquista()) then
            __L1.camera = __L1:clamp(__L1.player.x - __L1.W * 0.36, 0, __L1.WORLD - __L1.W)
        end
        local ____t_result_2133
        local ____t_2132 = __t
        local ____getq_result_2131 = __getq(
            __L1:closestNPC(),
            0
        )
        __O[1947] = ____getq_result_2131
        if ____t_2132(____getq_result_2131) then
            ____t_result_2133 = __O[1947]
        else
            ____t_result_2133 = nil
        end
        __L1.nearNPC = ____t_result_2133
        for ____, p in __iterar((__L1.pickups)) do
            if __t(not __t(p.taken) and __hypot(__L1.player.x - p.x, __L1.player.y - 23 - p.y) < 40) then
                p.taken = true
                if p.type == "repair" then
                    if not __t(__call(__L1.q.carParts, "includes", p.id)) then
                        __call(__L1.q.carParts, "push", p.id)
                    end
                    __L1:floating(
                        p.x,
                        p.y - 25,
                        __add(
                            __add(
                                "PEÇA ",
                                __len(__L1.q.carParts)
                            ),
                            "/3"
                        ),
                        "#e7e7a8"
                    )
                    __L1:awardXP(
                        45,
                        __add("part-", p.id)
                    )
                    __L1:toast(__add(
                        __add(
                            "Peça do carro: ",
                            __len(__L1.q.carParts)
                        ),
                        "/3. Volte ao Lucas quando completar!"
                    ))
                    __L1:save()
                elseif p.type == "notebook" then
                    if not __t(__call(__L1.q.notebooks, "includes", p.id)) then
                        __call(__L1.q.notebooks, "push", p.id)
                    end
                    __L1:floating(
                        p.x,
                        p.y - 25,
                        __add(
                            __add(
                                "CADERNO ",
                                __len(__L1.q.notebooks)
                            ),
                            "/3"
                        ),
                        "#a6dfee"
                    )
                    __L1:awardXP(
                        30,
                        __add("notebook-", p.id)
                    )
                    __L1:save()
                elseif p.type == "gas" then
                    __L1.player.gas = math.min(
                        __L1:bonus().maxGas,
                        __L1.player.gas + 32
                    )
                    __L1:floating(p.x, p.y - 18, "+GÁS", "#c6ee85")
                elseif __t(__get(__L1.itemNames, p.type)) then
                    __inc(__L1.items, p.type, 1, true)
                    __call(__L1.collected, "push", p.id)
                    __L1:floating(
                        p.x,
                        p.y - 18,
                        __add(
                            "+1 ",
                            __call(
                                __get(__L1.itemNames, p.type),
                                "toUpperCase"
                            )
                        ),
                        "#b9ddf4"
                    )
                    __L1:save()
                else
                    __L1.player.papers = math.min(30, __L1.player.papers + 8)
                    __L1:floating(p.x, p.y - 18, "+8 PAPÉIS")
                end
                __L1:beep(720, 0.08, "triangle")
                __L1:fx(
                    p.x,
                    p.y,
                    "#f1d180",
                    8,
                    60
                )
            end
        end
        local ____opt_2136 = window.LugaresC1
        if ____opt_2136 ~= nil then
            ____opt_2136 = ____opt_2136.coletar
        end
        local ____opt_result_2138
        if ____opt_2136 ~= nil then
            ____opt_result_2138 = ____opt_2136(____opt_2136, __L1.q, __L1.player, __L1.scene)
        end
        local toolPick = ____opt_result_2138
        if __t(toolPick) then
            __L1:toast(toolPick.message)
            __L1:floating(
                __L1.player.x,
                __L1.player.y - 85,
                __add(
                    __add("FERRAMENTAS ", toolPick.count),
                    "/3"
                ),
                "#ffd27a"
            )
            __L1:beep(830, 0.08, "triangle")
            __L1:save()
            __L1:updateUI()
        end
        local ____opt_2141 = window.MissaoFarda
        if ____opt_2141 ~= nil then
            ____opt_2141 = ____opt_2141.coletar
        end
        local ____opt_result_2143
        if ____opt_2141 ~= nil then
            ____opt_result_2143 = ____opt_2141(____opt_2141, __L1.q, __L1.player, __L1.scene)
        end
        local fardaPick = ____opt_result_2143
        if __t(fardaPick) then
            __L1:toast(fardaPick.message)
            __L1:floating(
                __L1.player.x,
                __L1.player.y - 85,
                __add(
                    __add("FARDA ", fardaPick.count),
                    "/3"
                ),
                "#a8d4ff"
            )
            __L1:beep(830, 0.08, "triangle")
            __L1:save()
            __L1:updateUI()
        end
        local ____opt_2146 = window.BivoltQuest
        if ____opt_2146 ~= nil then
            ____opt_2146 = ____opt_2146.collect
        end
        local ____opt_result_2148
        if ____opt_2146 ~= nil then
            ____opt_result_2148 = ____opt_2146(____opt_2146, __L1.q, __L1.player, __L1.scene)
        end
        local bivoltPick = ____opt_result_2148
        local ____t_2152 = __t
        local ____opt_result_2151
        if bivoltPick ~= nil then
            ____opt_result_2151 = bivoltPick.collected
        end
        if ____t_2152(____opt_result_2151) then
            __L1:toast(bivoltPick.message)
            __L1:floating(
                __L1.player.x,
                __L1.player.y - 85,
                __add(
                    __add("BIVOLT ", bivoltPick.count),
                    "/3"
                ),
                "#f7d984"
            )
            __L1:beep(830, 0.08, "triangle")
            __L1:save()
            __L1:updateUI()
        end
        if __L1.scene == 11 then
            local ____opt_2157 = window.BaileGalpao
            if ____opt_2157 ~= nil then
                ____opt_2157 = ____opt_2157.sincronizar
            end
            if ____opt_2157 ~= nil then
                local ____t_2155 = __t
                local ____t_result_2154
                if __t(__L1.q.ollyan) then
                    ____t_result_2154 = __L1.q.ollyan
                else
                    ____t_result_2154 = __L1.q.ollyanTeto
                end
                ____opt_2157(
                    ____opt_2157,
                    {telhado = not not ____t_2155(____t_result_2154)}
                )
            end
            local ____opt_2159 = window.BaileGalpao
            if ____opt_2159 ~= nil then
                ____opt_2159 = ____opt_2159.PORTA
            end
            local ____opt_2159_2161 = ____opt_2159
            if ____opt_2159_2161 == nil then
                ____opt_2159_2161 = 760
            end
            local porta = ____opt_2159_2161 - 70
            local ____t_2165 = __t
            local ____t_result_2164
            local ____t_2163 = __t
            local ____t_result_2162
            if __t(__L1.vehicle) then
                ____t_result_2162 = not __t(__L1.ollyanEncounter)
            else
                ____t_result_2162 = __L1.vehicle
            end
            __O[1948] = ____t_result_2162
            if ____t_2163(____t_result_2162) then
                ____t_result_2164 = __gt(__L1.player.x, porta)
            else
                ____t_result_2164 = __O[1948]
            end
            if ____t_2165(____t_result_2164) then
                __L1.player.x = porta
                __L1.player.vx = 0
                __L1.vehicle = false
                __L1:toast("O carro a gás fica na porta do galpão. No baile, só a pé!")
            end
        end
        do
            local ____opt_2168 = window.LugaresC1
            if ____opt_2168 ~= nil then
                ____opt_2168 = ____opt_2168.porta
            end
            local ____opt_result_2170
            if ____opt_2168 ~= nil then
                ____opt_result_2170 = ____opt_2168(____opt_2168, __L1.scene)
            end
            local pl = ____opt_result_2170
            local ____t_2176 = __t
            local ____t_result_2175
            local ____t_2174 = __t
            local ____t_result_2173
            local ____t_2172 = __t
            local ____temp_2171 = pl ~= nil
            __O[1949] = ____temp_2171
            if ____t_2172(____temp_2171) then
                ____t_result_2173 = __L1.vehicle
            else
                ____t_result_2173 = __O[1949]
            end
            __O[1950] = ____t_result_2173
            if ____t_2174(____t_result_2173) then
                ____t_result_2175 = __gt(__L1.player.x, pl)
            else
                ____t_result_2175 = __O[1950]
            end
            if ____t_2176(____t_result_2175) then
                __L1.player.x = pl
                __L1.player.vx = 0
                __L1.vehicle = false
                __L1:toast("O carro fica na porta. Lá dentro, só a pé!")
            end
        end
        local ____t_2192 = __t
        local ____t_result_2191
        local ____t_2190 = __t
        local ____t_result_2189
        local ____t_2180 = __t
        local ____t_result_2179
        local ____t_2178 = __t
        local ____temp_2177 = __L1.scene == 11 and not __t(__L1.q.ollyan)
        __O[1951] = ____temp_2177
        if ____t_2178(____temp_2177) then
            ____t_result_2179 = __L1.ollyanRetryGrace <= 0
        else
            ____t_result_2179 = __O[1951]
        end
        __O[1953] = ____t_result_2179
        if ____t_2180(____t_result_2179) then
            local ____L1_player_x_2188 = __L1.player.x
            local ____t_result_2187
            local ____t_2186 = __t
            local ____opt_2183 = window.BaileWorld
            if ____opt_2183 ~= nil then
                ____opt_2183 = ____opt_2183.getNPC
            end
            local ____opt_result_2185
            if ____opt_2183 ~= nil then
                ____opt_result_2185 = ____opt_2183(____opt_2183).x
            end
            __O[1952] = ____opt_result_2185
            if ____t_2186(____opt_result_2185) then
                ____t_result_2187 = __O[1952]
            else
                ____t_result_2187 = 3260
            end
            ____t_result_2189 = math.abs(____L1_player_x_2188 - ____t_result_2187) < 145
        else
            ____t_result_2189 = __O[1953]
        end
        __O[1954] = ____t_result_2189
        if ____t_2190(____t_result_2189) then
            ____t_result_2191 = __L1.q.lucas
        else
            ____t_result_2191 = __O[1954]
        end
        if ____t_2192(____t_result_2191) then
            __L1:beginOllyanEncounter()
            return
        end
        __L1:updateMinions(dt)
        __L1:updateSarueTraps()
        __L1:updateEnemies(dt)
        __L1:updateShots(dt)
        __L1:updateHazards(dt)
        __L1:updateReeis(dt)
        __L1:updateEffects(dt)
        local ____t_2196 = __t
        local ____t_result_2195
        local ____t_2194 = __t
        local ____t_result_2193
        if __t(__L1.vehicle) then
            ____t_result_2193 = __L1.routeEdgeCooldown <= 0
        else
            ____t_result_2193 = __L1.vehicle
        end
        __O[1955] = ____t_result_2193
        if ____t_2194(____t_result_2193) then
            ____t_result_2195 = __lt(__L1.player.x, 38) or __gt(__L1.player.x, __L1.WORLD - 38)
        else
            ____t_result_2195 = __O[1955]
        end
        if ____t_2196(____t_result_2195) then
            __L1.routeEdgeCooldown = 2
            __L1:requestRoutePicker("world-edge")
        end
        __L1.saveTimer = __L1.saveTimer + dt
        if __L1.saveTimer > 8 then
            __L1.saveTimer = 0
            __L1:save()
        end
        __L1.uiTimer = __L1.uiTimer + dt
        if __L1.uiTimer > 0.12 then
            __L1.uiTimer = 0
            __L1:updateUI()
        end
    end
    __L1.updateSarueTraps = function(self)
        local ____t_2208 = __t
        local ____t_result_2207
        local ____t_2204 = __t
        local ____t_result_2203
        local ____t_2202 = __t
        local ____t_result_2201
        local ____t_2200 = __t
        local ____t_result_2199
        local ____t_2198 = __t
        local ____temp_2197 = __L1.scene ~= 1
        __O[1956] = ____temp_2197
        if ____t_2198(____temp_2197) then
            ____t_result_2199 = __O[1956]
        else
            ____t_result_2199 = __L1.marcoTrapTriggered
        end
        __O[1957] = ____t_result_2199
        if ____t_2200(____t_result_2199) then
            ____t_result_2201 = __O[1957]
        else
            ____t_result_2201 = not __t(__L1.activeBoss)
        end
        __O[1958] = ____t_result_2201
        if ____t_2202(____t_result_2201) then
            ____t_result_2203 = __O[1958]
        else
            ____t_result_2203 = __L1.activeBoss.type ~= "marco"
        end
        __O[1959] = ____t_result_2203
        if ____t_2204(____t_result_2203) then
            ____t_result_2207 = __O[1959]
        else
            local ____opt_2205 = __L1.arena
            if ____opt_2205 ~= nil then
                ____opt_2205 = ____opt_2205.phase
            end
            ____t_result_2207 = ____opt_2205 ~= "active"
        end
        if ____t_2208(____t_result_2207) then
            return
        end
        local ____t_result_2212
        local ____t_2211 = __t
        local ____opt_2209 = window.WorldData
        if ____opt_2209 ~= nil then
            ____opt_2209 = ____opt_2209.sarueTraps
        end
        __O[1960] = ____opt_2209
        if ____t_2211(____opt_2209) then
            ____t_result_2212 = __O[1960]
        else
            ____t_result_2212 = __arrL({{scene = 1, x = 3420, width = 70}}, 1)
        end
        local traps = ____t_result_2212
        local trap = __call(
            traps,
            "find",
            function(____, t)
                local ____t_result_2217
                local ____t_2216 = __t
                local ____temp_2215 = t.scene == __L1.scene
                if ____temp_2215 then
                    local ____math_abs_result_2214 = math.abs(__L1.player.x - t.x)
                    local ____t_result_2213
                    if __t(t.width) then
                        ____t_result_2213 = t.width
                    else
                        ____t_result_2213 = 70
                    end
                    ____temp_2215 = ____math_abs_result_2214 < ____t_result_2213 / 2
                end
                __O[1961] = ____temp_2215
                if ____t_2216(____temp_2215) then
                    ____t_result_2217 = __gt(__L1.player.y, __L1.FLOOR - 18)
                else
                    ____t_result_2217 = __O[1961]
                end
                return ____t_result_2217
            end
        )
        if not __t(trap) then
            return
        end
        __L1.marcoTrapTriggered = true
        local e = __L1.activeBoss
        e.rage = true
        e.angry = 99999
        e.hp = math.min(e.max, e.hp + 40)
        e.state = "idle"
        e.pattern = 0
        __L1:releaseInputs()
        __L1:fx(
            e.x,
            e.y - 40,
            "#ff4d5d",
            60,
            210
        )
        __L1.shake = 12
        __L1:startCutscene(
            "marco_rage",
            function()
                if __L1.activeBoss == e then
                    __L1:beginBossWindup(e)
                end
                __L1:toast("FÚRIA VERMELHA! Marco agora desenha brainrots e SIX SEVEN!")
            end
        )
    end
    __L1.isSchoolMonitor = function(self, e)
        return e.type == "igor" or e.type == "kaique"
    end
    __L1.igorScale = function(self, e)
        local ____t_2223 = __t
        local ____t_result_2222
        local ____t_2221 = __t
        local ____temp_2220 = e.type ~= "igor"
        if not ____temp_2220 then
            local ____opt_2218 = __L1.arena
            if ____opt_2218 ~= nil then
                ____opt_2218 = ____opt_2218.type
            end
            ____temp_2220 = ____opt_2218 ~= "igor"
        end
        __O[1962] = ____temp_2220
        if ____t_2221(____temp_2220) then
            ____t_result_2222 = __O[1962]
        else
            ____t_result_2222 = __L1.activeBoss ~= e and __L1.arena.phase ~= "exiting"
        end
        if ____t_2223(____t_result_2222) then
            return 1
        end
        local ____temp_2228
        if __L1.arena.phase == "entering" then
            ____temp_2228 = 0
        else
            local ____temp_2227
            if __L1.arena.phase == "exiting" then
                ____temp_2227 = __L1:clamp(__L1.arena.blend, 0, 1)
            else
                local ____temp_2226
                if e.state == "monitorTransform" then
                    local ____L1_clamp_2225 = __L1.clamp
                    local ____t_result_2224
                    if __t(e.monitorTransform) then
                        ____t_result_2224 = e.monitorTransform
                    else
                        ____t_result_2224 = 0
                    end
                    ____temp_2226 = ____L1_clamp_2225(__L1, ____t_result_2224, 0, 1)
                else
                    ____temp_2226 = 1
                end
                ____temp_2227 = ____temp_2226
            end
            ____temp_2228 = ____temp_2227
        end
        local p = ____temp_2228
        return 1 + 2 * p * p * (3 - 2 * p)
    end
    __L1.igorContains = function(self, e, x, y, padX, padY)
        if padX == nil then
            padX = 0
        end
        if padY == nil then
            padY = 0
        end
        local scale = __L1:igorScale(e)
        local rolling = e.state == "bellyRolling"
        local rx = (__t(rolling) and 36 or 33) * scale + padX
        local ry = (__t(rolling) and 36 or 45) * scale + padY
        local cy = e.y - (__t(rolling) and 36 or 45) * scale
        return ((x - e.x) / rx) ^ 2 + ((y - cy) / ry) ^ 2 < 1
    end
    __L1.nikolasBounds = function(self, e)
        local ____t_result_2238
        local ____t_2235 = __t
        local ____opt_2232 = window.Art
        if ____opt_2232 ~= nil then
            ____opt_2232 = ____opt_2232.nikolasBounds
        end
        local ____opt_result_2234
        if ____opt_2232 ~= nil then
            local ____t_result_2230
            if __t(e.phase) then
                ____t_result_2230 = e.phase
            else
                ____t_result_2230 = 1
            end
            ____opt_result_2234 = ____opt_2232(____opt_2232, ____t_result_2230)
        end
        __O[1963] = ____opt_result_2234
        if ____t_2235(____opt_result_2234) then
            ____t_result_2238 = __O[1963]
        else
            local ____temp_2237
            if e.phase == 4 then
                ____temp_2237 = {halfWidth = 185, height = 340, centerY = 170}
            else
                local ____ge_result_2236
                if __ge(e.phase, 2) then
                    ____ge_result_2236 = {halfWidth = 55, height = 140, centerY = 70}
                else
                    ____ge_result_2236 = {halfWidth = 35, height = 90, centerY = 30}
                end
                ____temp_2237 = ____ge_result_2236
            end
            ____t_result_2238 = ____temp_2237
        end
        return ____t_result_2238
    end
    __L1.nikolasContains = function(self, e, x, y, padX, padY)
        if padX == nil then
            padX = 0
        end
        if padY == nil then
            padY = 0
        end
        local b = __L1:nikolasBounds(e)
        local rx = b.halfWidth + padX
        local ry = b.height / 2 + padY
        return ((x - e.x) / rx) ^ 2 + ((y - (e.y - b.centerY)) / ry) ^ 2 < 1
    end
    __L1.nikolasTransformProgress = function(self, e)
        local ____temp_2242
        if e.state == "phaseChange" then
            local ____L1_clamp_2241 = __L1.clamp
            local ____e_stateTimer_2240 = e.stateTimer
            local ____t_result_2239
            if __t(e.phaseDuration) then
                ____t_result_2239 = e.phaseDuration
            else
                ____t_result_2239 = 1.05
            end
            ____temp_2242 = ____L1_clamp_2241(__L1, 1 - ____e_stateTimer_2240 / ____t_result_2239, 0, 1)
        else
            ____temp_2242 = 1
        end
        return ____temp_2242
    end
    __L1.bossCaptionY = function(self, e)
        local ____temp_2247 = e.type == "igor" and 145 or 83
        local ____e_y_2246 = e.y
        local ____temp_2245
        if e.type == "igor" then
            ____temp_2245 = 90 * __L1:igorScale(e) + 30
        else
            local ____temp_2244
            if e.type == "giant" then
                ____temp_2244 = 240
            else
                local ____t_result_2243
                if __t(e.type == "nikolas" and __ge(e.phase, 2)) then
                    ____t_result_2243 = __L1:nikolasBounds(e).height + 20
                else
                    ____t_result_2243 = 157
                end
                ____temp_2244 = ____t_result_2243
            end
            ____temp_2245 = ____temp_2244
        end
        return math.max(____temp_2247, ____e_y_2246 - ____temp_2245)
    end
    __L1.monitorSees = function(self, e)
        local distance = (__L1.player.x - e.x) * e.monitorDir
        local ____t_2251 = __t
        local ____t_result_2250
        local ____t_2249 = __t
        local ____temp_2248 = distance < -15 or distance > 300
        __O[1964] = ____temp_2248
        if ____t_2249(____temp_2248) then
            ____t_result_2250 = __O[1964]
        else
            ____t_result_2250 = __lt(__L1.player.y, __L1.FLOOR - 92)
        end
        if ____t_2251(____t_result_2250) then
            return false
        end
        local eye = __L1.FLOOR - (e.type == "igor" and 74 or 92)
        local head = __L1.player.y - 40
        local center = eye + (__L1.FLOOR - 40 - eye) * distance / 300
        if math.abs(head - center) > 18 + distance * 0.15 then
            return false
        end
        local a = math.min(e.x, __L1.player.x)
        local b = math.max(e.x, __L1.player.x)
        local ____t_2257 = __t
        local ____call_2256 = __call
        local ____t_result_2255
        local ____t_2254 = __t
        local ____opt_2252 = window.WorldData
        if ____opt_2252 ~= nil then
            ____opt_2252 = ____opt_2252.schoolCovers
        end
        __O[1965] = ____opt_2252
        if ____t_2254(____opt_2252) then
            ____t_result_2255 = __O[1965]
        else
            ____t_result_2255 = __arrL({}, 0)
        end
        return not ____t_2257(____call_2256(
            ____t_result_2255,
            "some",
            function(____, c) return __gt(c.x + c.width / 2, a) and c.x - c.width / 2 < b end
        ))
    end
    __L1.confrontMonitor = function(self, e, iraci)
        if iraci == nil then
            iraci = false
        end
        local ____t_2273 = __t
        local ____t_result_2272
        local ____t_2271 = __t
        local ____t_result_2270
        local ____t_2269 = __t
        local ____t_result_2268
        local ____t_2267 = __t
        local ____t_result_2266
        local ____t_2265 = __t
        local ____t_result_2264
        local ____t_2263 = __t
        local ____t_result_2262
        local ____t_2261 = __t
        local ____t_result_2260
        local ____t_2259 = __t
        local ____temp_2258 = not __t(e) or __le(e.hp, 0)
        __O[1966] = ____temp_2258
        if ____t_2259(____temp_2258) then
            ____t_result_2260 = __O[1966]
        else
            ____t_result_2260 = __L1.dialog
        end
        __O[1967] = ____t_result_2260
        if ____t_2261(____t_result_2260) then
            ____t_result_2262 = __O[1967]
        else
            ____t_result_2262 = __L1.activeBoss
        end
        __O[1968] = ____t_result_2262
        if ____t_2263(____t_result_2262) then
            ____t_result_2264 = __O[1968]
        else
            ____t_result_2264 = __L1.arena
        end
        __O[1969] = ____t_result_2264
        if ____t_2265(____t_result_2264) then
            ____t_result_2266 = __O[1969]
        else
            ____t_result_2266 = __L1.room
        end
        __O[1970] = ____t_result_2266
        if ____t_2267(____t_result_2266) then
            ____t_result_2268 = __O[1970]
        else
            ____t_result_2268 = __L1.cutscene
        end
        __O[1971] = ____t_result_2268
        if ____t_2269(____t_result_2268) then
            ____t_result_2270 = __O[1971]
        else
            ____t_result_2270 = __L1.paused
        end
        __O[1972] = ____t_result_2270
        if ____t_2271(____t_result_2270) then
            ____t_result_2272 = __O[1972]
        else
            ____t_result_2272 = __L1.defeated
        end
        if ____t_2273(____t_result_2272) then
            return false
        end
        if __t(iraci) then
            e.rage = true
            e.iraciTriggered = true
        end
        if not __t(__L1:engageBoss(e)) then
            return false
        end
        e.monitorSuspicion = 0
        local ____L1_say_2276 = __L1.say
        local ____temp_2275
        if e.type == "igor" then
            ____temp_2275 = __arrL({{name = "Igor · monitor", text = "Qual foi, Da Roça? Tem um lanche aí, véi? Um salgado, um pão... fortalece o monitor, pô!"}, {name = "Da Roça", text = "Tenho nada, pô! Nikolas levou meu bolo. Só sobrou a embalagem e o gás, tá ligado?"}, {name = "Igor · monitor", text = "Sem lanche?! Tá tirando com minha cara, é? Oxe! Então segura a barriga, meu parceiro!"}}, 3)
        else
            local ____t_result_2274
            if __t(iraci) then
                ____t_result_2274 = __arrL({{name = "Kaique · monitor", text = "IRACI?! Qual foi, véi?! Quem botou o nome de minha mãe nesse chão? Se passou, hein!"}, {name = "Da Roça", text = "Eu só pisei sem querer, pô! O chão é que tava de resenha com tu!"}, {name = "Kaique · monitor", text = "Ah, é? Agora tu vai ver a resenha! Bora, Da Roça, desvia disso aqui, quero ver!"}}, 3)
            else
                ____t_result_2274 = __arrL({{name = "Kaique · monitor", text = "Ô, Da Roça! Bora pra sala, véi! E deixa essas bolinhas aqui. Tu acha que eu não tô vendo, é?"}, {name = "Da Roça", text = "Calma, meu parceiro! Isso aqui é pesquisa de trajetória... na prática, tá ligado?"}, {name = "Kaique · monitor", text = "Pesquisa nada, véi! Tu tá é de resenha! Bora ver se tu é ligeiro mesmo. Na recarga tu vem, viu?"}}, 3)
            end
            ____temp_2275 = ____t_result_2274
        end
        ____L1_say_2276(__L1, ____temp_2275)
        return true
    end
    __L1.updateSchoolMonitors = function(self, dt)
        local ____t_2295 = __t
        local ____t_result_2294
        local ____t_2288 = __t
        local ____t_result_2287
        local ____t_2286 = __t
        local ____t_result_2285
        local ____t_2284 = __t
        local ____t_result_2283
        local ____t_2280 = __t
        local ____temp_2279 = __L1.scene == 1
        if ____temp_2279 then
            local ____opt_2277 = __L1.activeBoss
            if ____opt_2277 ~= nil then
                ____opt_2277 = ____opt_2277.type
            end
            ____temp_2279 = ____opt_2277 == "kaique"
        end
        __O[1973] = ____temp_2279
        if ____t_2280(____temp_2279) then
            local ____opt_2281 = __L1.arena
            if ____opt_2281 ~= nil then
                ____opt_2281 = ____opt_2281.phase
            end
            ____t_result_2283 = ____opt_2281 == "active"
        else
            ____t_result_2283 = __O[1973]
        end
        __O[1974] = ____t_result_2283
        if ____t_2284(____t_result_2283) then
            ____t_result_2285 = not __t(__L1.activeBoss.iraciTriggered)
        else
            ____t_result_2285 = __O[1974]
        end
        __O[1975] = ____t_result_2285
        if ____t_2286(____t_result_2285) then
            ____t_result_2287 = __gt(__L1.player.y, __L1.FLOOR - 18)
        else
            ____t_result_2287 = __O[1975]
        end
        __O[1977] = ____t_result_2287
        if ____t_2288(____t_result_2287) then
            local ____call_2293 = __call
            local ____t_result_2292
            local ____t_2291 = __t
            local ____opt_2289 = window.WorldData
            if ____opt_2289 ~= nil then
                ____opt_2289 = ____opt_2289.iraciTraps
            end
            __O[1976] = ____opt_2289
            if ____t_2291(____opt_2289) then
                ____t_result_2292 = __O[1976]
            else
                ____t_result_2292 = __arrL({}, 0)
            end
            ____t_result_2294 = ____call_2293(
                ____t_result_2292,
                "some",
                function(____, t) return math.abs(__L1.player.x - t.x) < t.width / 2 end
            )
        else
            ____t_result_2294 = __O[1977]
        end
        if ____t_2295(____t_result_2294) then
            local e = __L1.activeBoss
            e.iraciTriggered = true
            e.rage = true
            e.state = "monitorTransform"
            e.stateTimer = 1.25
            e.monitorTransform = 0
            __L1.shots = __call(
                __L1.shots,
                "filter",
                function(____, s) return s.owner ~= "enemy" end
            )
            __L1.hazards = __arrL({}, 0)
            __L1:releaseInputs()
            __L1.player.inv = math.max(__L1.player.inv, 1.6)
            __L1:floating(e.x, e.y - 155, "IRACI?! FISCALIZAÇÃO MÁXIMA!", "#ffb2ab")
            __L1:fx(
                e.x,
                e.y - 45,
                "#f3767d",
                36,
                160
            )
            __L1.shake = 8
        end
        local ____t_2313 = __t
        local ____t_result_2312
        local ____t_2311 = __t
        local ____t_result_2310
        local ____t_2309 = __t
        local ____t_result_2308
        local ____t_2307 = __t
        local ____t_result_2306
        local ____t_2305 = __t
        local ____t_result_2304
        local ____t_2303 = __t
        local ____t_result_2302
        local ____t_2301 = __t
        local ____t_result_2300
        local ____t_2299 = __t
        local ____t_result_2298
        local ____t_2297 = __t
        local ____temp_2296 = __L1.scene ~= 1
        __O[1978] = ____temp_2296
        if ____t_2297(____temp_2296) then
            ____t_result_2298 = __O[1978]
        else
            ____t_result_2298 = __L1.room
        end
        __O[1979] = ____t_result_2298
        if ____t_2299(____t_result_2298) then
            ____t_result_2300 = __O[1979]
        else
            ____t_result_2300 = __L1.arena
        end
        __O[1980] = ____t_result_2300
        if ____t_2301(____t_result_2300) then
            ____t_result_2302 = __O[1980]
        else
            ____t_result_2302 = __L1.activeBoss
        end
        __O[1981] = ____t_result_2302
        if ____t_2303(____t_result_2302) then
            ____t_result_2304 = __O[1981]
        else
            ____t_result_2304 = __L1.dialog
        end
        __O[1982] = ____t_result_2304
        if ____t_2305(____t_result_2304) then
            ____t_result_2306 = __O[1982]
        else
            ____t_result_2306 = __L1.cutscene
        end
        __O[1983] = ____t_result_2306
        if ____t_2307(____t_result_2306) then
            ____t_result_2308 = __O[1983]
        else
            ____t_result_2308 = __L1.vehicle
        end
        __O[1984] = ____t_result_2308
        if ____t_2309(____t_result_2308) then
            ____t_result_2310 = __O[1984]
        else
            ____t_result_2310 = __L1.paused
        end
        __O[1985] = ____t_result_2310
        if ____t_2311(____t_result_2310) then
            ____t_result_2312 = __O[1985]
        else
            ____t_result_2312 = __L1.defeated
        end
        if ____t_2313(____t_result_2312) then
            return
        end
        for ____, e in __iterar((__L1.enemies)) do
            do
                if __t(not __t(__L1:isSchoolMonitor(e)) or __le(e.hp, 0)) then
                    continue
                end
                e.monitorCooldown = math.max(0, e.monitorCooldown - dt)
                local ____add_2315 = __add
                local ____t_result_2314
                if __t(e.patrolTime) then
                    ____t_result_2314 = e.patrolTime
                else
                    ____t_result_2314 = 0
                end
                e.patrolTime = ____add_2315(____t_result_2314, dt)
                e.x = e.x + e.monitorDir * 33 * dt
                if __gt(e.x, e.homeX + 88) then
                    e.x = e.homeX + 88
                    e.monitorDir = -1
                elseif __lt(e.x, e.homeX - 88) then
                    e.x = e.homeX - 88
                    e.monitorDir = 1
                end
                local ____t_2319 = __t
                local ____t_result_2318
                local ____t_2317 = __t
                local ____temp_2316 = not __t(__get(
                    __L1.q,
                    __add(e.type, "Sneak")
                )) and not __t(__get(__L1.q, e.type))
                __O[1986] = ____temp_2316
                if ____t_2317(____temp_2316) then
                    ____t_result_2318 = __gt(__L1.player.x, e.homeX + 390)
                else
                    ____t_result_2318 = __O[1986]
                end
                if ____t_2319(____t_result_2318) then
                    __set(
                        __L1.q,
                        __add(e.type, "Sneak"),
                        true
                    )
                    __L1:awardXP(
                        120,
                        __add("school-stealth-", e.type)
                    )
                    __L1:toast(__add(
                        __add("Passou sem ser visto por ", e.type == "igor" and "Igor" or "Kaique"),
                        "! +120 XP de furtividade."
                    ))
                    __L1:save()
                end
                local ____t_result_2322
                local ____t_2321 = __t
                local ____le_result_2320 = __le(e.monitorCooldown, 0)
                __O[1987] = ____le_result_2320
                if ____t_2321(____le_result_2320) then
                    ____t_result_2322 = __L1:monitorSees(e)
                else
                    ____t_result_2322 = __O[1987]
                end
                local seen = ____t_result_2322
                local ____L1_clamp_2326 = __L1.clamp
                local ____add_2325 = __add
                local ____t_result_2323
                if __t(e.monitorSuspicion) then
                    ____t_result_2323 = e.monitorSuspicion
                else
                    ____t_result_2323 = 0
                end
                local ____t_result_2324
                if __t(seen) then
                    ____t_result_2324 = dt
                else
                    ____t_result_2324 = __TS__Number(-dt) * 2.4
                end
                e.monitorSuspicion = ____L1_clamp_2326(
                    __L1,
                    ____add_2325(____t_result_2323, ____t_result_2324),
                    0,
                    1.2
                )
                local ____t_2330 = __t
                local ____t_result_2329
                local ____t_2328 = __t
                local ____t_result_2327
                if __t(seen) then
                    ____t_result_2327 = __gt(e.monitorSuspicion, 0.25)
                else
                    ____t_result_2327 = seen
                end
                __O[1988] = ____t_result_2327
                if ____t_2328(____t_result_2327) then
                    ____t_result_2329 = not __t(e.monitorHint)
                else
                    ____t_result_2329 = __O[1988]
                end
                if ____t_2330(____t_result_2329) then
                    e.monitorHint = true
                    __L1:toast("O monitor está olhando! Saia do cone, suba nas passarelas ou se esconda atrás dos armários.")
                end
                if e.monitorSuspicion == 0 then
                    e.monitorHint = false
                end
                if __ge(e.monitorSuspicion, 1.2) then
                    __L1:confrontMonitor(e, false)
                    return
                end
            end
        end
        local kaique = __call(
            __L1.enemies,
            "find",
            function(____, e)
                local ____t_result_2333
                local ____t_2332 = __t
                local ____temp_2331 = e.type == "kaique" and __gt(e.hp, 0)
                __O[1989] = ____temp_2331
                if ____t_2332(____temp_2331) then
                    ____t_result_2333 = not __t(e.iraciTriggered)
                else
                    ____t_result_2333 = __O[1989]
                end
                return ____t_result_2333
            end
        )
        local ____t_2340 = __t
        local ____t_result_2339
        if __t(kaique) then
            local ____call_2338 = __call
            local ____t_result_2337
            local ____t_2336 = __t
            local ____opt_2334 = window.WorldData
            if ____opt_2334 ~= nil then
                ____opt_2334 = ____opt_2334.iraciTraps
            end
            __O[1990] = ____opt_2334
            if ____t_2336(____opt_2334) then
                ____t_result_2337 = __O[1990]
            else
                ____t_result_2337 = __arrL({}, 0)
            end
            ____t_result_2339 = ____call_2338(
                ____t_result_2337,
                "some",
                function(____, t) return math.abs(__L1.player.x - t.x) < t.width / 2 and __gt(__L1.player.y, __L1.FLOOR - 18) end
            )
        else
            ____t_result_2339 = kaique
        end
        if ____t_2340(____t_result_2339) then
            __L1:confrontMonitor(kaique, true)
        end
    end
    __L1.executeMonitorAttack = function(self, e)
        if e.type == "igor" then
            if e.kind == "bellyBounce" then
                e.state = "bellyAir"
                e.bellyDuration = 0.98
                e.stateTimer = e.bellyDuration
                e.bellyFrom = e.x
                e.bellyTo = __L1:clamp(
                    e.targetX,
                    __get(__L1.arena.bounds, 0) + 120,
                    __get(__L1.arena.bounds, 1) - 120
                )
                __L1:floating(
                    e.x,
                    __L1:bossCaptionY(e),
                    "BARRIGA NO AR!",
                    "#ffe1ac"
                )
                return
            end
            if e.kind == "bellyRoll" then
                e.state = "bellyRolling"
                e.stateTimer = 1.05
                local ____e_2344 = e
                local ____t_result_2343
                local ____t_2342 = __t
                local ____TS__MathSign_result_2341 = __TS__MathSign(e.targetX - e.x)
                __O[1991] = ____TS__MathSign_result_2341
                if ____t_2342(____TS__MathSign_result_2341) then
                    ____t_result_2343 = __O[1991]
                else
                    ____t_result_2343 = -1
                end
                ____e_2344.dashDir = ____t_result_2343
                e.rollAngle = 0
                return
            end
            do
                local i = 0
                while i < (e.phase == 3 and 2 or 1) do
                    __call(__L1.hazards, "push", {
                        x = e.x,
                        y = __L1.FLOOR - 5,
                        type = "ring",
                        r = 0,
                        delay = 0.6 + i * 0.8,
                        life = 3,
                        speed = 180 + e.phase * 15,
                        maxR = 820,
                        damage = 12,
                        triggered = false
                    })
                    i = i + 1
                end
            end
            e.state = "firing"
            e.stateTimer = 0.9
            return
        end
        if e.kind == "dash" then
            e.state = "dashing"
            e.stateTimer = 0.45
            local ____e_2348 = e
            local ____t_result_2347
            local ____t_2346 = __t
            local ____TS__MathSign_result_2345 = __TS__MathSign(e.targetX - e.x)
            __O[1992] = ____TS__MathSign_result_2345
            if ____t_2346(____TS__MathSign_result_2345) then
                ____t_result_2347 = __O[1992]
            else
                ____t_result_2347 = -1
            end
            ____e_2348.dashDir = ____t_result_2347
            return
        end
        if e.kind == "monitorReload" then
            e.state = "firing"
            e.stateTimer = 0.18
            __L1:floating(e.x, e.y - 130, "RECARREGANDO!", "#d8e9b0")
            return
        end
        local sweep = e.kind == "monitorSweep"
        local ____t_result_2349
        if __t(sweep) then
            ____t_result_2349 = 4 + e.phase
        else
            ____t_result_2349 = 5 + e.phase
        end
        local count = ____t_result_2349 + (__t(e.rage) and 2 or 0)
        local ____t_result_2352
        local ____t_2351 = __t
        local ____TS__MathSign_result_2350 = __TS__MathSign(e.targetX - e.x)
        __O[1993] = ____TS__MathSign_result_2350
        if ____t_2351(____TS__MathSign_result_2350) then
            ____t_result_2352 = __O[1993]
        else
            ____t_result_2352 = -1
        end
        local direction = ____t_result_2352
        local ____t_result_2353
        if __t(sweep) then
            ____t_result_2353 = direction > 0 and 0 or math.pi
        else
            ____t_result_2353 = math.atan(e.targetY - (e.y - 53), e.targetX - e.x)
        end
        local angle = ____t_result_2353
        do
            local i = 0
            while __lt(i, count) do
                local spread = __t(sweep) and 0 or __get(
                    __arrL({-0.1, 0.04, -0.04, 0.1}, 4),
                    __mod(i, 4)
                )
                local ____call_2357 = __call
                local ____L1_shots_2356 = __L1.shots
                local ____temp_2355 = e.x + direction * 35
                local ____t_result_2354
                if __t(sweep) then
                    ____t_result_2354 = __L1.FLOOR - 24
                else
                    ____t_result_2354 = e.y - 53
                end
                ____call_2357(
                    ____L1_shots_2356,
                    "push",
                    {
                        x = ____temp_2355,
                        y = ____t_result_2354,
                        vx = math.cos(angle + spread) * (__t(e.rage) and 295 or 250),
                        vy = math.sin(angle + spread) * (__t(e.rage) and 295 or 250),
                        delay = i * (__t(e.rage) and 0.105 or 0.14),
                        life = 4,
                        type = "enemyBullet",
                        owner = "enemy",
                        damage = __t(e.rage) and 13 or 10
                    }
                )
                i = i + 1
            end
        end
        e.state = "firing"
        e.stateTimer = 1.15 + (count - 5) * 0.14
        __L1:fx(
            e.x + direction * 35,
            e.y - 53,
            "#ffe4a4",
            12,
            100
        )
        __L1:beep(140, 0.12, "square", 0.018)
    end
    __L1.bossPhaseHP = function(self, e)
        local profile = __L1:bossProfile(e)
        local ____t_result_2364
        local ____t_2363 = __t
        local ____t_result_2362
        local ____t_2361 = __t
        local ____t_result_2360
        local ____t_2359 = __t
        local ____TS__Number_result_2358 = __TS__Number(e.baseMax)
        __O[1994] = ____TS__Number_result_2358
        if ____t_2359(____TS__Number_result_2358) then
            ____t_result_2360 = __O[1994]
        else
            ____t_result_2360 = __TS__Number(profile.hp)
        end
        __O[1995] = ____t_result_2360
        if ____t_2361(____t_result_2360) then
            ____t_result_2362 = __O[1995]
        else
            ____t_result_2362 = __TS__Number(e.max)
        end
        __O[1996] = ____t_result_2362
        if ____t_2363(____t_result_2362) then
            ____t_result_2364 = __O[1996]
        else
            ____t_result_2364 = 100
        end
        local base = ____t_result_2364
        local ____t_result_2367
        if __t(profile.phaseHP) then
            ____t_result_2367 = __arr(__TS__Spread(__iter(profile.phaseHP)))
        else
            local ____call_2366 = __call
            local ____temp_2365
            if e.type == "nikolas" then
                ____temp_2365 = __arrL({1, 1.2, 1.4, 1.65}, 4)
            else
                ____temp_2365 = __arrL({1, 1.25, 1.5}, 3)
            end
            ____t_result_2367 = ____call_2366(
                ____temp_2365,
                "map",
                function(____, value) return math.floor(base * value + 0.5) end
            )
        end
        return ____t_result_2367
    end
    __L1.beginBossPhase = function(self, e, phase)
        local ____t_result_2368
        if __t(e.phaseHP) then
            ____t_result_2368 = e.phaseHP
        else
            ____t_result_2368 = __L1:bossPhaseHP(e)
        end
        local bars = ____t_result_2368
        e.phaseHP = bars
        e.phaseCount = __len(bars)
        e.phase = __L1:clamp(
            phase,
            1,
            __len(bars)
        )
        local ____e_2370 = e
        local ____get_result_2369 = __get(bars, e.phase - 1)
        e.phaseMaxHp = ____get_result_2369
        ____e_2370.max = ____get_result_2369
        e.hp = e.max
        e.announcedPhase = e.phase
        e.pattern = 0
        e.state = "phaseChange"
        e.phaseDuration = e.type == "nikolas" and 3.6 or 1.05
        e.stateTimer = e.phaseDuration
        e.phaseTransitionTimer = e.phaseDuration
        e.damageLock = e.phaseDuration + 0.1
        e.charge = 0
        e.burn = 0
        e.burnTick = 0
        e.phaseStartY = e.y
        e.phaseStartX = e.x
        if __t(e.conquista) then
            local f = e.conquista
            e.phaseDuration = window.ConquistaCombate:trocar(f, e.phase, __L1.player)
            local ____e_2373 = e
            local ____e_2372 = e
            local ____e_phaseDuration_2371 = e.phaseDuration
            e.damageLock = ____e_phaseDuration_2371
            ____e_2372.phaseTransitionTimer = ____e_phaseDuration_2371
            ____e_2373.stateTimer = ____e_phaseDuration_2371
            __L1.shots = __call(
                __L1.shots,
                "filter",
                function(____, s) return s.owner ~= "enemy" end
            )
            __L1.hazards = __arrL({}, 0)
            __L1.minions = __call(
                __L1.minions,
                "filter",
                function(____, m) return not __t(m.summoned) end
            )
            __L1.player.inv = math.max(__L1.player.inv, e.phaseDuration)
            local cap = window.ConquistaCombate:capitulo(f)
            if not __t(cap) then
                __L1:epicPlate(
                    __add("FASE ", e.phase),
                    "VIDA RENOVADA",
                    __get(window.ConquistaCombate.chefes, f.slug).cor,
                    1
                )
            end
            local ____L1_beep_2375 = __L1.beep
            local ____t_result_2374
            if __t(cap) then
                ____t_result_2374 = 165 + e.phase * 38
            else
                ____t_result_2374 = 245
            end
            ____L1_beep_2375(
                __L1,
                ____t_result_2374,
                0.17,
                "triangle",
                0.023
            )
            return
        end
        if e.type == "nikolas" then
            e.form = __get(
                __arrL({"normal", "muscular", "flying", "giant"}, 4),
                e.phase - 1
            )
            e.kind = e.phase == 2 and "muscleClap" or (e.phase == 3 and "auraComets" or "giantPalm")
            e.targetX = __L1.player.x
            e.targetY = __L1.player.y - 30
        else
            e.y = __L1.FLOOR
            local kit = __get(__L1.bossPhaseSkills, e.type)
            local ____e_2379 = e
            local ____t_result_2378
            local ____t_2377 = __t
            local ____getq_result_2376 = __getq(kit, e.phase - 2)
            __O[1997] = ____getq_result_2376
            if ____t_2377(____getq_result_2376) then
                ____t_result_2378 = __O[1997]
            else
                ____t_result_2378 = "fan"
            end
            ____e_2379.kind = ____t_result_2378
        end
        __L1.shots = __call(
            __L1.shots,
            "filter",
            function(____, shot) return shot.owner ~= "enemy" end
        )
        __L1.hazards = __arrL({}, 0)
        __L1.minions = __call(
            __L1.minions,
            "filter",
            function(____, m) return not __t(m.summoned) end
        )
        __L1.player.inv = math.max(__L1.player.inv, e.phaseDuration)
        __L1.shake = math.max(__L1.shake, e.type == "nikolas" and 10 or 7)
        __L1:epicFreeze(0.16)
        __L1.epic.flash = 0.4
        __L1.epic.flashColor = e.type == "nikolas" and "#ffe18b" or "#f3d9ff"
        __L1:epicRing(e.x, e.y - 60, e.type == "nikolas" and "#ffe18b" or "#deb4f0", 1.3)
        __L1:fx(
            e.x,
            e.y - 60,
            e.type == "nikolas" and "#ffe18b" or (e.type == "menezes" and "#efbfd3" or "#deb4f0"),
            e.type == "nikolas" and 46 or 24,
            170
        )
        local ____L1_epicPlate_2384 = __L1.epicPlate
        local ____temp_2380
        if e.type == "nikolas" then
            ____temp_2380 = __get(
                __arrL({
                    "",
                    "NOVA FORMA!",
                    "SHAPE DO CALEB!",
                    "AURA ASCENDENTE!",
                    "TITÃ DO CATARRO!"
                }, 5),
                e.phase
            )
        else
            ____temp_2380 = __add("FASE ", e.phase)
        end
        local ____ge_2383 = __ge
        local ____e_phase_2382 = e.phase
        local ____t_result_2381
        if __t(e.phaseCount) then
            ____t_result_2381 = e.phaseCount
        else
            ____t_result_2381 = 3
        end
        ____L1_epicPlate_2384(
            __L1,
            ____temp_2380,
            ____ge_2383(____e_phase_2382, ____t_result_2381) and "ÚLTIMA FASE · VIDA RENOVADA" or "VIDA RENOVADA · O CHEFE FICOU MAIS FORTE",
            "#ffb36b",
            1.7
        )
        __L1:beep(
            __ge(e.phase, 3) and 190 or 290,
            0.24,
            "triangle",
            0.025
        )
    end
    __L1.phasePillar = function(self, e, x, ____type, delay, height, r, damage)
        if delay == nil then
            delay = 0.95
        end
        if height == nil then
            height = 310
        end
        if r == nil then
            r = 34
        end
        if damage == nil then
            damage = 15
        end
        __call(
            __L1.hazards,
            "push",
            {
                x = __L1:clamp(
                    x,
                    __get(__L1.arena.bounds, 0) + 45,
                    __get(__L1.arena.bounds, 1) - 45
                ),
                y = __L1.FLOOR - 6,
                type = ____type,
                r = r,
                delay = delay,
                life = 0.55,
                height = height,
                damage = damage,
                triggered = false
            }
        )
    end
    __L1.phaseReturnFan = function(self, e, ____type, count, speed, spread)
        if count == nil then
            count = 5
        end
        if speed == nil then
            speed = 180
        end
        if spread == nil then
            spread = 0.18
        end
        local start = __len(__L1.shots)
        __L1:bossFan(
            e,
            ____type,
            count,
            speed,
            spread
        )
        for ____, shot in __iterar((__call(__L1.shots, "slice", start))) do
            shot.returnAt = 2.8
            shot.life = 4.4
            shot.damage = ____type == "smoke" and 10 or 12
        end
    end
    __L1.executePhaseSkill = function(self, e)
        if __t(e.type == "giant" or not __t(__get(__L1.bossPhaseSkillNames, e.kind))) then
            return false
        end
        local ____t_result_2387
        local ____t_2386 = __t
        local ____TS__MathSign_result_2385 = __TS__MathSign(e.targetX - e.x)
        __O[1998] = ____TS__MathSign_result_2385
        if ____t_2386(____TS__MathSign_result_2385) then
            ____t_result_2387 = __O[1998]
        else
            ____t_result_2387 = -1
        end
        local direction = ____t_result_2387
        local ____t_result_2388
        if __t(e.phase) then
            ____t_result_2388 = e.phase
        else
            ____t_result_2388 = 1
        end
        local phase = ____t_result_2388
        if e.kind == "inkColumns" then
            do
                local i = -1
                while i <= 1 do
                    __L1:phasePillar(
                        e,
                        e.targetX + i * 145,
                        "ink",
                        0.95 + math.abs(i) * 0.17,
                        310,
                        32,
                        15
                    )
                    i = i + 1
                end
            end
        elseif e.kind == "inkCrossfire" then
            do
                local wave = 0
                while wave < 3 do
                    for ____, side in __iterar((__arrL({-1, 1}, 2))) do
                        local ____call_2391 = __call
                        local ____L1_shots_2390 = __L1.shots
                        local ____temp_2389
                        if side < 0 then
                            ____temp_2389 = __get(__L1.arena.bounds, 0) + 35
                        else
                            ____temp_2389 = __get(__L1.arena.bounds, 1) - 35
                        end
                        ____call_2391(
                            ____L1_shots_2390,
                            "push",
                            {
                                x = ____temp_2389,
                                y = __L1.FLOOR - (__t(__mod(wave, 2)) and 155 or 27),
                                vx = __TS__Number(-side) * 215,
                                vy = 0,
                                delay = wave * 0.6 + (side > 0 and 0.22 or 0),
                                life = 4,
                                type = "doodle",
                                owner = "enemy",
                                damage = 13,
                                variant = __mod(wave, 3)
                            }
                        )
                    end
                    wave = wave + 1
                end
            end
        elseif e.kind == "ratPincer" then
            local count = math.min(
                4,
                6 - __len(__call(
                    __L1.minions,
                    "filter",
                    function(____, m)
                        local ____t_result_2392
                        if __t(m.summoned) then
                            ____t_result_2392 = not __t(m.dead)
                        else
                            ____t_result_2392 = m.summoned
                        end
                        return ____t_result_2392
                    end
                ))
            )
            do
                local i = 0
                while i < count do
                    local side = __t(__mod(i, 2)) and 1 or -1
                    local ____temp_2393
                    if side < 0 then
                        ____temp_2393 = __get(__L1.arena.bounds, 0) + 45
                    else
                        ____temp_2393 = __get(__L1.arena.bounds, 1) - 45
                    end
                    local x = ____temp_2393
                    local hp = 34
                    __call(
                        __L1.minions,
                        "push",
                        {
                            id = __add(
                                __add(
                                    __add("menezes-pincer-", e.pattern),
                                    "-"
                                ),
                                i
                            ),
                            scene = __L1.scene,
                            x = x,
                            y = __L1.FLOOR,
                            homeX = x,
                            summoned = true,
                            temporary = true,
                            life = 7.5,
                            type = "rat",
                            design = "rat",
                            kind = 0,
                            hp = hp,
                            max = hp,
                            damage = 8,
                            speed = 145,
                            range = 460,
                            dir = -side,
                            vy = 0,
                            t = 1,
                            hit = 0,
                            dead = false,
                            xp = 0,
                            provocation = "CERCO POUDIAAAM!"
                        }
                    )
                    i = i + 1
                end
            end
            __L1:bossFan(
                e,
                "word",
                3,
                185,
                0.2
            )
        elseif e.kind == "sewerEruption" then
            do
                local i = -1
                while i <= 1 do
                    __L1:phasePillar(
                        e,
                        e.targetX + i * 150,
                        "word",
                        0.95 + (i + 1) * 0.19,
                        290,
                        34,
                        17
                    )
                    i = i + 1
                end
            end
        elseif e.kind == "slimeMortar" then
            local speed = __L1:bossProfile(e).projectileSpeed
            local flight = 1.2
            local gravity = 600
            do
                local i = -1
                while i <= 1 do
                    local target = __L1:clamp(
                        e.targetX + i * 110,
                        __get(__L1.arena.bounds, 0) + 45,
                        __get(__L1.arena.bounds, 1) - 45
                    )
                    __call(__L1.shots, "push", {
                        x = e.x,
                        y = e.y - 100,
                        vx = (target - e.x) / flight / speed,
                        vy = (100 - gravity * flight * flight / 2) / flight / speed,
                        gravity = gravity / speed,
                        delay = (i + 1) * 0.18,
                        life = 4,
                        type = "slime",
                        owner = "enemy",
                        damage = 15,
                        splash = true
                    })
                    i = i + 1
                end
            end
        elseif e.kind == "slimeNova" then
            do
                local i = 0
                while i < 12 do
                    local angle = i * math.pi / 6 + 0.12
                    __call(
                        __L1.shots,
                        "push",
                        {
                            x = e.x,
                            y = e.y - 72,
                            vx = math.cos(angle) * 205,
                            vy = math.sin(angle) * 205,
                            life = 3.3,
                            type = "slime",
                            owner = "enemy",
                            damage = 14,
                            delay = __mod(i, 2) * 0.24
                        }
                    )
                    i = i + 1
                end
            end
        elseif e.kind == "royalCrossfire" then
            local angle = math.atan(e.targetY - (e.y - 70), e.targetX - e.x)
            do
                local i = 0
                while i < 6 do
                    __call(
                        __L1.shots,
                        "push",
                        {
                            x = e.x + direction * 35,
                            y = e.y - (__t(__mod(i, 2)) and 100 or 35),
                            vx = math.cos(angle + (__t(__mod(i, 2)) and 0.12 or -0.12)) * 235,
                            vy = math.sin(angle + (__t(__mod(i, 2)) and 0.12 or -0.12)) * 235,
                            delay = i * 0.16,
                            life = 4,
                            type = "enemyBullet",
                            owner = "enemy",
                            damage = 13
                        }
                    )
                    i = i + 1
                end
            end
        elseif e.kind == "royalSeal" then
            for ____, offset in __iterar((__arrL({-170, 170}, 2))) do
                __L1:phasePillar(
                    e,
                    e.targetX + offset,
                    "word",
                    0.95,
                    180,
                    38,
                    14
                )
            end
            __call(__L1.hazards, "push", {
                x = e.x,
                y = __L1.FLOOR - 5,
                type = "ring",
                r = 0,
                delay = 0.65,
                life = 3,
                speed = 210,
                maxR = 850,
                damage = 14,
                triggered = false
            })
        elseif e.kind == "heavyUppercut" then
            __L1:phasePillar(
                e,
                e.targetX,
                "word",
                0.85,
                165,
                49,
                17
            )
        elseif e.kind == "doubleStomp" then
            do
                local i = 0
                while i < 2 do
                    __call(
                        __L1.hazards,
                        "push",
                        {
                            x = __L1:clamp(
                                e.x + (__t(i) and 140 or -140),
                                __get(__L1.arena.bounds, 0) + 50,
                                __get(__L1.arena.bounds, 1) - 50
                            ),
                            y = __L1.FLOOR - 5,
                            type = "ring",
                            r = 0,
                            delay = 0.65 + i * 0.75,
                            life = 3,
                            speed = 205,
                            maxR = 850,
                            damage = 15,
                            triggered = false
                        }
                    )
                    i = i + 1
                end
            end
        elseif e.kind == "smokeSpiral" then
            __L1:phaseReturnFan(
                e,
                "smoke",
                5,
                170,
                0.21
            )
        elseif e.kind == "smokePrison" then
            for ____, offset in __iterar((__arrL({-180, 0, 180}, 3))) do
                __L1:phasePillar(
                    e,
                    e.targetX + offset,
                    "smoke",
                    1.05 + math.abs(offset) / 1000,
                    260,
                    36,
                    12
                )
            end
        elseif e.kind == "astralOrbit" then
            __L1:phaseReturnFan(
                e,
                "astral",
                7,
                180,
                0.18
            )
        elseif e.kind == "heavenCross" then
            for ____, side in __iterar((__arrL({-1, 1}, 2))) do
                do
                    local i = 0
                    while i < 3 do
                        local ____temp_2394
                        if side < 0 then
                            ____temp_2394 = __get(__L1.arena.bounds, 0) + 40
                        else
                            ____temp_2394 = __get(__L1.arena.bounds, 1) - 40
                        end
                        local x = ____temp_2394
                        local y = 105 + i * 45
                        local angle = math.atan(e.targetY - y, e.targetX - x)
                        __call(
                            __L1.shots,
                            "push",
                            {
                                x = x,
                                y = y,
                                vx = math.cos(angle) * 225,
                                vy = math.sin(angle) * 225,
                                delay = i * 0.3,
                                life = 4,
                                type = "astral",
                                owner = "enemy",
                                damage = 14
                            }
                        )
                        i = i + 1
                    end
                end
            end
        elseif e.kind == "slapBoomerang" then
            __L1:phaseReturnFan(
                e,
                "confetti",
                5,
                185,
                0.17
            )
        elseif e.kind == "slapClap" then
            do
                local i = 0
                while i < 3 do
                    __call(__L1.hazards, "push", {
                        x = e.x,
                        y = __L1.FLOOR - 5,
                        type = "ring",
                        r = 0,
                        delay = 0.6 + i * 0.65,
                        life = 3,
                        speed = 190,
                        maxR = 850,
                        damage = 11,
                        triggered = false
                    })
                    i = i + 1
                end
            end
        elseif e.kind == "bellyQuake" then
            do
                local i = 0
                while i < 3 do
                    __call(__L1.hazards, "push", {
                        x = e.x,
                        y = __L1.FLOOR - 5,
                        type = "ring",
                        r = 0,
                        delay = 0.65 + i * 0.72,
                        life = 3,
                        speed = 175,
                        maxR = 850,
                        damage = 12,
                        triggered = false
                    })
                    i = i + 1
                end
            end
        elseif e.kind == "bellyShrapnel" then
            local start = __len(__L1.shots)
            local anchor = __assign({}, e, {y = e.y - 78, targetY = e.targetY})
            __L1:bossFan(
                anchor,
                "doodle",
                7,
                190,
                0.22
            )
            for ____, shot in __iterar((__call(__L1.shots, "slice", start))) do
                shot.damage = 12
                shot.life = 3.2
            end
        elseif e.kind == "monitorCrossfire" then
            do
                local i = 0
                while i < 6 do
                    __call(
                        __L1.shots,
                        "push",
                        {
                            x = e.x + direction * 35,
                            y = __L1.FLOOR - (__t(__mod(i, 2)) and 145 or 25),
                            vx = direction * 255,
                            vy = 0,
                            delay = i * 0.18,
                            life = 4,
                            type = "enemyBullet",
                            owner = "enemy",
                            damage = 10
                        }
                    )
                    i = i + 1
                end
            end
        elseif e.kind == "monitorGrid" then
            do
                local i = 0
                while i < 7 do
                    do
                        local y = __L1.FLOOR - 25 - i * 47
                        if i == 3 then
                            do i = i + 1 continue end
                        end
                        __call(
                            __L1.shots,
                            "push",
                            {
                                x = e.x + direction * 35,
                                y = y,
                                vx = direction * 230,
                                vy = 0,
                                delay = __mod(i, 2) * 0.45,
                                life = 4,
                                type = "enemyBullet",
                                owner = "enemy",
                                damage = 11
                            }
                        )
                    end
                    i = i + 1
                end
            end
        end
        e.state = "firing"
        e.stateTimer = __t(__call(
            __arrL({"bellyQuake", "slapClap"}, 2),
            "includes",
            e.kind
        )) and 1.65 or (e.kind == "doubleStomp" and 1.25 or 0.72)
        __L1:fx(
            e.x,
            e.y - 45,
            e.type == "nikolas" and "#d0e58c" or (e.type == "menezes" and "#efc0d2" or "#e4bfed"),
            18,
            120
        )
        __L1:beep(145, 0.12, "triangle", 0.018)
        return true
    end
    __L1.prepareNikolasGiantLane = function(self, e)
        local count = 5
        local width = (__get(__L1.arena.bounds, 1) - __get(__L1.arena.bounds, 0) - 100) / count
        e.slamLanes = __arrayFrom(
            {length = count},
            function(____, _, i) return __get(__L1.arena.bounds, 0) + 50 + width * (i + 0.5) end
        )
        e.safeLaneIndex = __call(
            __call(e.slamLanes, "slice", 0, 3),
            "reduce",
            function(____, best, x, i)
                local ____temp_2395
                if math.abs(x - e.targetX) < math.abs(__get(e.slamLanes, best) - e.targetX) then
                    ____temp_2395 = i
                else
                    ____temp_2395 = best
                end
                return ____temp_2395
            end,
            0
        )
        e.safeLaneX = __get(e.slamLanes, e.safeLaneIndex)
        e.safeLaneWidth = width * 0.65
        e.safeLaneTime = 3.25
    end
    __L1.executeNikolasFormAttack = function(self, e)
        local ____t_2399 = __t
        local ____t_result_2398
        local ____t_2397 = __t
        local ____temp_2396 = e.type ~= "nikolas" or __lt(e.phase, 2)
        __O[1999] = ____temp_2396
        if ____t_2397(____temp_2396) then
            ____t_result_2398 = __O[1999]
        else
            ____t_result_2398 = not __t(__get(__L1.nikolasPhaseWarnings, e.kind))
        end
        if ____t_2399(____t_result_2398) then
            return false
        end
        if e.kind == "goldenRush" then
            e.state = "dashing"
            e.stateTimer = 0.38
            local ____e_2403 = e
            local ____t_result_2402
            local ____t_2401 = __t
            local ____TS__MathSign_result_2400 = __TS__MathSign(e.targetX - e.x)
            __O[2000] = ____TS__MathSign_result_2400
            if ____t_2401(____TS__MathSign_result_2400) then
                ____t_result_2402 = __O[2000]
            else
                ____t_result_2402 = -1
            end
            ____e_2403.dashDir = ____t_result_2402
            __L1:fx(
                e.x,
                e.y - 65,
                "#ffe4a0",
                24,
                150
            )
            return true
        end
        if e.kind == "muscleClap" then
            do
                local i = 0
                while i < 2 do
                    __call(__L1.hazards, "push", {
                        x = e.x,
                        y = __L1.FLOOR - 5,
                        type = "ring",
                        catarro = true,
                        r = 0,
                        delay = 0.65 + i * 0.7,
                        life = 3,
                        speed = 200,
                        maxR = 850,
                        damage = 16,
                        triggered = false
                    })
                    i = i + 1
                end
            end
        elseif e.kind == "potatoUppercut" then
            __L1:phasePillar(
                e,
                e.targetX,
                "slime",
                0.9,
                175,
                52,
                18
            )
        elseif e.kind == "auraComets" then
            local first = __len(__L1.shots)
            __L1:bossFan(
                e,
                "slime",
                7,
                220,
                0.18
            )
            for ____, shot in __iterar((__call(__L1.shots, "slice", first))) do
                shot.gravity = 75
                shot.life = 3.5
            end
        elseif e.kind == "skySlimeLances" then
            do
                local i = -1
                while i <= 1 do
                    __L1:phasePillar(
                        e,
                        e.targetX + i * 155,
                        "slime",
                        1.05 + math.abs(i) * 0.16,
                        320,
                        32,
                        17
                    )
                    i = i + 1
                end
            end
        elseif e.kind == "auraSweep" then
            do
                local wave = 0
                while wave < 2 do
                    do
                        local i = 0
                        while i < 4 do
                            local direction = __lt(e.targetX, e.x) and -1 or 1
                            __call(__L1.shots, "push", {
                                x = e.x,
                                y = e.y - 55 - i * 16,
                                vx = direction * (160 + i * 17),
                                vy = 85 + i * 35,
                                delay = wave * 0.7,
                                life = 4,
                                type = "slime",
                                owner = "enemy",
                                damage = 14
                            })
                            i = i + 1
                        end
                    end
                    wave = wave + 1
                end
            end
        elseif e.kind == "giantPalm" then
            do
                local i = 0
                while i < 3 do
                    __L1:phasePillar(
                        e,
                        e.targetX + (i - 1) * 120,
                        "slime",
                        1.05 + i * 0.3,
                        130,
                        48,
                        19
                    )
                    i = i + 1
                end
            end
        elseif e.kind == "giantStomp" then
            do
                local i = 0
                while i < 3 do
                    __call(__L1.hazards, "push", {
                        x = e.x - 60 - i * 70,
                        y = __L1.FLOOR - 5,
                        type = "ring",
                        catarro = true,
                        r = 0,
                        delay = 0.8 + i * 0.7,
                        life = 3,
                        speed = 195,
                        maxR = 900,
                        damage = 18,
                        triggered = false
                    })
                    i = i + 1
                end
            end
        elseif e.kind == "giantSlam" then
            if not __t(e.slamLanes) then
                __L1:prepareNikolasGiantLane(e)
            end
            do
                local i = 0
                while __lt(
                    i,
                    __len(e.slamLanes)
                ) do
                    if i ~= e.safeLaneIndex then
                        __L1:phasePillar(
                            e,
                            __get(e.slamLanes, i),
                            "slime",
                            1.05,
                            340,
                            42,
                            20
                        )
                    end
                    i = i + 1
                end
            end
            e.safeLaneTime = 1.85
        elseif e.kind == "giantBreath" then
            do
                local i = 0
                while i < 7 do
                    __call(
                        __L1.shots,
                        "push",
                        {
                            x = e.x - 65,
                            y = 145 + __mod(i, 2) * 55,
                            vx = -(145 + i * 10),
                            vy = 70 + i * 12,
                            gravity = 75,
                            delay = i * 0.18,
                            life = 4,
                            type = "slime",
                            owner = "enemy",
                            damage = 15,
                            splash = true
                        }
                    )
                    i = i + 1
                end
            end
        end
        e.state = "firing"
        e.stateTimer = e.kind == "giantStomp" and 1.9 or (e.kind == "giantSlam" and 1.4 or 0.85)
        __L1:fx(
            e.x,
            e.y - (e.phase == 4 and 200 or 60),
            e.phase == 3 and "#cbb7ff" or "#ffe2a0",
            22,
            150
        )
        __L1:beep(e.phase == 4 and 75 or 125, 0.16, "sawtooth", 0.02)
        return true
    end
    __L1.bossDefaults = function(self, e)
        local ____assign_2406 = __assign
        local ____e_2405 = e
        local ____e_homeX_2404 = e.homeX
        if ____e_homeX_2404 == nil then
            ____e_homeX_2404 = e.x
        end
        ____assign_2406(____e_2405, {
            homeX = ____e_homeX_2404,
            state = "idle",
            stateTimer = 0,
            pattern = 0,
            phase = 1,
            announcedPhase = 1,
            damageLock = 0,
            rage = false,
            angry = 0,
            burn = 0,
            targetX = 0,
            targetY = __L1.FLOOR - 30,
            kind = "fan",
            dashDir = -1,
            tauntTimer = 2.5,
            emergeX = nil,
            diveFromX = nil,
            monitorSuspicion = 0,
            monitorDir = -1,
            monitorCooldown = 2,
            monitorHint = false,
            iraciTriggered = false,
            rollAngle = 0,
            phaseShield = 0,
            phaseTransitionTimer = 0,
            phaseDuration = 1.05,
            form = "normal",
            safeLaneTime = 0,
            slamLanes = nil,
            flightTime = 0
        })
        local ____t_2410 = __t
        local ____t_result_2409
        local ____t_2408 = __t
        local ____temp_2407 = e.type ~= "giant"
        __O[2001] = ____temp_2407
        if ____t_2408(____temp_2407) then
            ____t_result_2409 = __get(__L1.bossPhaseSkills, e.type)
        else
            ____t_result_2409 = __O[2001]
        end
        if ____t_2410(____t_result_2409) then
            e.phaseHP = __L1:bossPhaseHP(e)
            e.phaseCount = __len(e.phaseHP)
            e.baseMax = __get(e.phaseHP, 0)
            local ____e_2413 = e
            local ____e_2412 = e
            local ____e_baseMax_2411 = e.baseMax
            e.phaseMaxHp = ____e_baseMax_2411
            ____e_2412.max = ____e_baseMax_2411
            ____e_2413.hp = ____e_baseMax_2411
            e.y = __L1.FLOOR
        end
        return e
    end
    __L1.beginBossWindup = function(self, e)
        if __t(e.conquista) then
            window.ConquistaCombate:preparar(e.conquista, __L1.player)
            __L1:sincronizarConquista(e)
            return
        end
        if e.type == "giant" then
            e.phase = e.hp / e.max > 0.66 and 1 or (e.hp / e.max > 0.33 and 2 or 3)
        else
            local ____e_2417 = e
            local ____L1_clamp_2416 = __L1.clamp
            local ____t_result_2414
            if __t(e.phase) then
                ____t_result_2414 = e.phase
            else
                ____t_result_2414 = 1
            end
            local ____t_result_2415
            if __t(e.phaseCount) then
                ____t_result_2415 = e.phaseCount
            else
                ____t_result_2415 = 3
            end
            ____e_2417.phase = ____L1_clamp_2416(__L1, ____t_result_2414, 1, ____t_result_2415)
        end
        local ____temp_2437
        if e.type == "igor" then
            ____temp_2437 = __arrL({"bellyBounce", "bellyRoll", "bellyClap", "bellyBounce"}, 4)
        else
            local ____temp_2436
            if e.type == "kaique" then
                local ____t_result_2418
                if __t(e.rage) then
                    ____t_result_2418 = __arrL({"monitorBurst", "monitorSweep", "monitorBurst", "dash"}, 4)
                else
                    ____t_result_2418 = __arrL({"monitorBurst", "monitorSweep", "monitorReload", "dash"}, 4)
                end
                ____temp_2436 = ____t_result_2418
            else
                local ____temp_2435
                if e.type == "marco" then
                    local ____t_result_2420
                    if __t(e.rage) then
                        ____t_result_2420 = __arrL({
                            "brainrots",
                            "inkSlam",
                            "sketchLine",
                            "dash",
                            "sixseven",
                            "sketchSwarm",
                            "mines"
                        }, 7)
                    else
                        local ____temp_2419
                        if e.phase == 1 then
                            ____temp_2419 = __arrL({
                                "fan",
                                "inkSlam",
                                "sketchLine",
                                "sketchSwarm",
                                "mines"
                            }, 5)
                        else
                            ____temp_2419 = __arrL({
                                "sketchSwarm",
                                "fan",
                                "inkSlam",
                                "sketchLine",
                                "dash",
                                "mines"
                            }, 6)
                        end
                        ____t_result_2420 = ____temp_2419
                    end
                    ____temp_2435 = ____t_result_2420
                else
                    local ____temp_2434
                    if e.type == "menezes" then
                        local ____temp_2422
                        if e.phase == 1 then
                            ____temp_2422 = __arrL({"wordWalls", "sewerDive", "ratsArmy", "echo"}, 4)
                        else
                            local ____temp_2421
                            if e.phase == 2 then
                                ____temp_2421 = __arrL({
                                    "wordWalls",
                                    "sewerDive",
                                    "echo",
                                    "ratsArmy",
                                    "ring",
                                    "provokeZone",
                                    "dash"
                                }, 7)
                            else
                                ____temp_2421 = __arrL({
                                    "sewerDive",
                                    "echo",
                                    "ratsArmy",
                                    "wordWalls",
                                    "ring",
                                    "sewerDive",
                                    "provokeZone",
                                    "echo",
                                    "dash"
                                }, 9)
                            end
                            ____temp_2422 = ____temp_2421
                        end
                        ____temp_2434 = ____temp_2422
                    else
                        local ____temp_2433
                        if e.type == "dede" then
                            local ____temp_2424
                            if e.phase == 1 then
                                ____temp_2424 = __arrL({"smokeFan", "bitucas", "smokeVeil", "dash"}, 4)
                            else
                                local ____temp_2423
                                if e.phase == 2 then
                                    ____temp_2423 = __arrL({
                                        "bitucas",
                                        "tragada",
                                        "smokeFan",
                                        "cloudMines",
                                        "smokeVeil",
                                        "dash"
                                    }, 6)
                                else
                                    ____temp_2423 = __arrL({
                                        "tragada",
                                        "cinzas",
                                        "bitucas",
                                        "smokeVeil",
                                        "cloudMines",
                                        "dash"
                                    }, 6)
                                end
                                ____temp_2424 = ____temp_2423
                            end
                            ____temp_2433 = ____temp_2424
                        else
                            local ____temp_2432
                            if e.type == "arthur" then
                                ____temp_2432 = __arrL({"poseFan", "dash", "poseWave", "poseFan"}, 4)
                            else
                                local ____temp_2431
                                if e.type == "freddy" then
                                    ____temp_2431 = __arrL({"heavyFan", "dash", "stomp", "heavyFan"}, 4)
                                else
                                    local ____temp_2430
                                    if e.type == "nicolas" then
                                        local ____temp_2426
                                        if e.phase == 1 then
                                            ____temp_2426 = __arrL({"astralFan", "skyLances", "dash"}, 3)
                                        else
                                            local ____temp_2425
                                            if e.phase == 2 then
                                                ____temp_2425 = __arrL({"skyLances", "supremeRing", "astralFan", "dash"}, 4)
                                            else
                                                ____temp_2425 = __arrL({"supremeRing", "skyLances", "dash", "astralFan"}, 4)
                                            end
                                            ____temp_2426 = ____temp_2425
                                        end
                                        ____temp_2430 = ____temp_2426
                                    else
                                        local ____temp_2429
                                        if e.type == "reeisBoss" then
                                            ____temp_2429 = __arrL({"gangFan", "dash", "mines", "gangFan"}, 4)
                                        else
                                            local ____temp_2428
                                            if e.type == "giant" then
                                                ____temp_2428 = __arrL({"slam", "doodleRain", "summonInk", "dash"}, 4)
                                            else
                                                local ____t_result_2427
                                                if __t(e.type == "nikolas" and e.phase == 3) then
                                                    ____t_result_2427 = __arrL({
                                                        "slimeFan",
                                                        "slimeRain",
                                                        "dash",
                                                        "mines",
                                                        "slimeFan",
                                                        "dash"
                                                    }, 6)
                                                else
                                                    ____t_result_2427 = __arrL({"slimeFan", "dash", "slimeRain", "mines"}, 4)
                                                end
                                                ____temp_2428 = ____t_result_2427
                                            end
                                            ____temp_2429 = ____temp_2428
                                        end
                                        ____temp_2430 = ____temp_2429
                                    end
                                    ____temp_2431 = ____temp_2430
                                end
                                ____temp_2432 = ____temp_2431
                            end
                            ____temp_2433 = ____temp_2432
                        end
                        ____temp_2434 = ____temp_2433
                    end
                    ____temp_2435 = ____temp_2434
                end
                ____temp_2436 = ____temp_2435
            end
            ____temp_2437 = ____temp_2436
        end
        local kinds = ____temp_2437
        if __t(e.type == "nikolas" and __gt(e.phase, 1)) then
            local ____t_result_2440
            local ____t_2439 = __t
            local ____get_result_2438 = __get(__L1.nikolasPhasePatterns, e.phase)
            __O[2002] = ____get_result_2438
            if ____t_2439(____get_result_2438) then
                ____t_result_2440 = __O[2002]
            else
                ____t_result_2440 = __get(__L1.nikolasPhasePatterns, 4)
            end
            kinds = ____t_result_2440
        end
        local ____t_2444 = __t
        local ____t_result_2443
        local ____t_2442 = __t
        local ____temp_2441 = e.type ~= "giant" and e.type ~= "nikolas"
        __O[2003] = ____temp_2441
        if ____t_2442(____temp_2441) then
            ____t_result_2443 = __ge(e.phase, 2)
        else
            ____t_result_2443 = __O[2003]
        end
        if ____t_2444(____t_result_2443) then
            local kit = __get(__L1.bossPhaseSkills, e.type)
            if __t(kit) then
                local ____arr_2448 = __arr
                local ____iter_2446 = __iter
                local ____temp_2445
                if e.phase == 3 then
                    ____temp_2445 = __arrL(
                        {
                            __get(kit, 1),
                            __get(kit, 0)
                        },
                        2
                    )
                else
                    ____temp_2445 = __arrL(
                        {__get(kit, 0)},
                        1
                    )
                end
                local ____array_2447 = __TS__SparseArrayNew(__TS__Spread(____iter_2446(____temp_2445)))
                __TS__SparseArrayPush(
                    ____array_2447,
                    __TS__Spread(__iter(kinds))
                )
                kinds = ____arr_2448(__TS__SparseArraySpread(____array_2447))
            end
        end
        local ____e_2455 = e
        local ____get_2454 = __get
        local ____kinds_2453 = kinds
        local ____mod_2452 = __mod
        local ____e_2449, ____pattern_2450 = e, "pattern"
        local ____e_pattern_2451 = ____e_2449[____pattern_2450]
        ____e_2449[____pattern_2450] = ____e_pattern_2451 + 1
        ____e_2455.kind = ____get_2454(
            ____kinds_2453,
            ____mod_2452(
                ____e_pattern_2451,
                __len(kinds)
            )
        )
        e.wallGapY = __get(
            __arrL({__L1.FLOOR - 42, 300, e.phase == 3 and 195 or __L1.FLOOR - 42}, 3),
            __mod(e.pattern, 3)
        )
        e.targetX = __L1.player.x
        e.targetY = __L1.player.y - 30
        e.state = "windup"
        e.stateTimer = (__t(__call(
            __arrL({"nikolas", "giant", "nicolas"}, 3),
            "includes",
            e.type
        )) and 1.25 or 1.05) - (e.phase - 1) * 0.12 - (__t(e.rage) and 0.2 or 0)
        local profile = __L1:bossProfile(e)
        e.stateTimer = math.max(profile.minWindup, (e.stateTimer - (e.type == "marco" and 0.1 or 0)) * profile.windup)
        e.windupDuration = e.stateTimer
        if __t(e.type == "dede" and e.kind == "tragada") then
            local ____opt_2458 = e.fxTrago
            if ____opt_2458 ~= nil then
                ____opt_2458 = ____opt_2458.parar
            end
            if ____opt_2458 ~= nil then
                ____opt_2458(____opt_2458)
            end
            local ____e_2467 = e
            local ____t_result_2466
            local ____t_2465 = __t
            local ____opt_2462 = window.FxPixel
            if ____opt_2462 ~= nil then
                ____opt_2462 = ____opt_2462.tocar
            end
            local ____opt_result_2464
            if ____opt_2462 ~= nil then
                ____opt_result_2464 = ____opt_2462(
                    ____opt_2462,
                    "arcane/spell-charge",
                    {
                        x = e.x + __TS__MathSign(e.targetX - e.x) * 14,
                        y = e.y + 2,
                        palette = window.FxPixel.PAL.fumaca,
                        duracao = 1.5
                    }
                )
            end
            __O[2004] = ____opt_result_2464
            if ____t_2465(____opt_result_2464) then
                ____t_result_2466 = __O[2004]
            else
                ____t_result_2466 = nil
            end
            ____e_2467.fxTrago = ____t_result_2466
        end
        if __t(e.type == "nikolas" and e.kind == "giantSlam") then
            __L1:prepareNikolasGiantLane(e)
        end
        if e.kind == "sewerDive" then
            local candidates = __arrL(
                {
                    __get(__L1.arena.bounds, 0) + 90,
                    __get(__L1.arena.bounds, 1) - 90,
                    __L1.arena.homeX
                },
                3
            )
            local choices = __call(
                candidates,
                "filter",
                function(____, x) return math.abs(x - __L1.player.x) > 140 end
            )
            local ____e_2473 = e
            local ____get_2472 = __get
            local ____t_result_2468
            if __t(__len(choices)) then
                ____t_result_2468 = choices
            else
                ____t_result_2468 = candidates
            end
            local ____mod_2471 = __mod
            local ____e_pattern_2470 = e.pattern
            local ____t_result_2469
            if __t(__len(choices)) then
                ____t_result_2469 = __len(choices)
            else
                ____t_result_2469 = __len(candidates)
            end
            ____e_2473.emergeX = ____get_2472(
                ____t_result_2468,
                ____mod_2471(____e_pattern_2470, ____t_result_2469)
            )
            e.diveFromX = e.x
        end
        if __gt(e.phase, e.announcedPhase) then
            e.announcedPhase = e.phase
            __L1:floating(
                e.x,
                e.y - 160,
                __add(
                    __add("FASE ", e.phase),
                    "!"
                ),
                "#f5b8ae"
            )
            __L1.shake = 6
            local ____L1_toast_2475 = __L1.toast
            local ____temp_2474
            if e.type == "nicolas" then
                ____temp_2474 = __add(
                    __add("AURA SUPREMA · FASE ", e.phase),
                    "! Pule as ondas, saia dos raios e ataque nas pausas."
                )
            else
                ____temp_2474 = "O chefão acelerou! Observe o aviso laranja e ataque na recuperação."
            end
            ____L1_toast_2475(__L1, ____temp_2474)
        end
    end
    __L1.engageBoss = function(self, e)
        local ____t_2491 = __t
        local ____t_result_2490
        local ____t_2489 = __t
        local ____t_result_2488
        local ____t_2487 = __t
        local ____t_result_2486
        local ____t_2485 = __t
        local ____t_result_2484
        local ____t_2483 = __t
        local ____t_result_2482
        local ____t_2481 = __t
        local ____t_result_2480
        local ____t_2479 = __t
        local ____t_result_2478
        local ____t_2477 = __t
        local ____t_result_2476
        if __t(__L1.activeBoss) then
            ____t_result_2476 = __L1.activeBoss
        else
            ____t_result_2476 = __le(e.hp, 0)
        end
        __O[2005] = ____t_result_2476
        if ____t_2477(____t_result_2476) then
            ____t_result_2478 = __O[2005]
        else
            ____t_result_2478 = __L1.defeated
        end
        __O[2006] = ____t_result_2478
        if ____t_2479(____t_result_2478) then
            ____t_result_2480 = __O[2006]
        else
            ____t_result_2480 = __L1.won
        end
        __O[2007] = ____t_result_2480
        if ____t_2481(____t_result_2480) then
            ____t_result_2482 = __O[2007]
        else
            ____t_result_2482 = __L1.room
        end
        __O[2008] = ____t_result_2482
        if ____t_2483(____t_result_2482) then
            ____t_result_2484 = __O[2008]
        else
            ____t_result_2484 = __L1.cutscene
        end
        __O[2009] = ____t_result_2484
        if ____t_2485(____t_result_2484) then
            ____t_result_2486 = __O[2009]
        else
            ____t_result_2486 = __L1.activity
        end
        __O[2010] = ____t_result_2486
        if ____t_2487(____t_result_2486) then
            ____t_result_2488 = __O[2010]
        else
            ____t_result_2488 = __L1.dialog
        end
        __O[2011] = ____t_result_2488
        if ____t_2489(____t_result_2488) then
            ____t_result_2490 = __O[2011]
        else
            ____t_result_2490 = __L1.paused
        end
        if ____t_2491(____t_result_2490) then
            return false
        end
        local access = __L1:bossAccess(e)
        if not __t(access.ok) then
            if not __t(__L1.bossHintCooldown) then
                __L1:toast(access.reason)
                __L1.bossHintCooldown = 3
            end
            return false
        end
        local ____e_2499 = e
        local ____t_result_2498
        local ____t_2497 = __t
        local ____opt_2494 = window.Difficulty
        if ____opt_2494 ~= nil then
            ____opt_2494 = ____opt_2494.getMode
        end
        local ____opt_result_2496
        if ____opt_2494 ~= nil then
            ____opt_result_2496 = ____opt_2494(____opt_2494)
        end
        __O[2012] = ____opt_result_2496
        if ____t_2497(____opt_result_2496) then
            ____t_result_2498 = __O[2012]
        else
            ____t_result_2498 = "normal"
        end
        ____e_2499.difficultyMode = ____t_result_2498
        local ____e_2507 = e
        local ____t_result_2506
        local ____t_2505 = __t
        local ____opt_2502 = window.Difficulty
        if ____opt_2502 ~= nil then
            ____opt_2502 = ____opt_2502.boss
        end
        local ____opt_result_2504
        if ____opt_2502 ~= nil then
            ____opt_result_2504 = ____opt_2502(____opt_2502, e.type, e.difficultyMode)
        end
        __O[2013] = ____opt_result_2504
        if ____t_2505(____opt_result_2504) then
            ____t_result_2506 = __O[2013]
        else
            ____t_result_2506 = nil
        end
        ____e_2507.difficultyProfile = ____t_result_2506
        if __t(e.difficultyProfile) then
            local ____e_2510 = e
            local ____e_2509 = e
            local ____e_difficultyProfile_hp_2508 = e.difficultyProfile.hp
            e.baseMax = ____e_difficultyProfile_hp_2508
            ____e_2509.max = ____e_difficultyProfile_hp_2508
            ____e_2510.hp = ____e_difficultyProfile_hp_2508
            local ____e_2512 = e
            local ____t_result_2511
            if __t(e.difficultyProfile.phaseHP) then
                ____t_result_2511 = __arr(__TS__Spread(__iter(e.difficultyProfile.phaseHP)))
            else
                ____t_result_2511 = nil
            end
            ____e_2512.phaseHP = ____t_result_2511
            __L1:bossDefaults(e)
        end
        local ____opt_2513 = window.C2Luta
        if ____opt_2513 ~= nil then
            ____opt_2513 = ____opt_2513.skin
        end
        local c2 = ____opt_2513
        local ____t_2516 = __t
        local ____t_result_2515
        if __t(c2) then
            ____t_result_2515 = e.type == c2.kit
        else
            ____t_result_2515 = c2
        end
        if ____t_2516(____t_result_2515) then
            e.phaseHP = window.ConquistaCombate:barras(
                c2.tema,
                math.floor(e.hp * c2.vida + 0.5)
            )
            e.phaseCount = __len(e.phaseHP)
            local ____e_2520 = e
            local ____e_2519 = e
            local ____e_2518 = e
            local ____get_result_2517 = __get(e.phaseHP, 0)
            e.phaseMaxHp = ____get_result_2517
            ____e_2518.baseMax = ____get_result_2517
            ____e_2519.max = ____get_result_2517
            ____e_2520.hp = ____get_result_2517
        end
        __L1.activeBoss = e
        __L1.vehicle = false
        local ____L1_epic_2527 = __L1.epic
        local ____t_result_2523
        local ____t_2522 = __t
        local ____temp_2521 = __L1:nomeBoss(e.type)
        __O[2014] = ____temp_2521
        if ____t_2522(____temp_2521) then
            ____t_result_2523 = __O[2014]
        else
            ____t_result_2523 = "Chefe"
        end
        local ____t_result_2526
        local ____t_2525 = __t
        local ____table_level_2524 = __L1:bossProfile(e).level
        __O[2015] = ____table_level_2524
        if ____t_2525(____table_level_2524) then
            ____t_result_2526 = __O[2015]
        else
            ____t_result_2526 = 1
        end
        ____L1_epic_2527.intro = {
            age = 0,
            name = ____t_result_2523,
            level = ____t_result_2526,
            color = e.type == "nikolas" and "#a6d05d" or (e.type == "menezes" and "#efbfd3" or (e.type == "giant" and "#f0a35b" or "#e9b45c")),
            slammed = false
        }
        __L1:releaseInputs()
        __L1.player.inv = math.max(__L1.player.inv, 0.85)
        __L1.respawnCheckpoint = {
            scene = __L1.scene,
            x = math.max(180, e.homeX - 400),
            boss = e.type
        }
        __L1:makeArena(e)
        local ____t_2529 = __t
        local ____t_result_2528
        if __t(c2) then
            ____t_result_2528 = e.type == c2.kit
        else
            ____t_result_2528 = c2
        end
        if ____t_2529(____t_result_2528) then
            local ____e_2538 = e
            local ____self_2536 = window.ConquistaCombate
            local ____self_2536_criar_2537 = ____self_2536.criar
            local ____array_2535 = __TS__SparseArrayNew(
                c2.tema,
                e.x,
                __L1.FLOOR,
                __TS__Spread(__iter(__L1.arena.bounds))
            )
            local ____opt_2532 = window.Difficulty
            if ____opt_2532 ~= nil then
                ____opt_2532 = ____opt_2532.getSettings
            end
            local ____opt_result_2534
            if ____opt_2532 ~= nil then
                ____opt_result_2534 = ____opt_2532(____opt_2532, e.difficultyMode)
            end
            __TS__SparseArrayPush(
                ____array_2535,
                ____opt_result_2534,
                __L1:bossProfile(e).recovery
            )
            ____e_2538.conquista = ____self_2536_criar_2537(
                ____self_2536,
                __TS__SparseArraySpread(____array_2535)
            )
            __L1.epic.intro = nil
            return true
        end
        local ____L1_toast_2552 = __L1.toast
        local ____add_2551 = __add
        local ____add_2550 = __add
        local ____add_2549 = __add
        local ____t_result_2548
        local ____t_2547 = __t
        local ____opt_2543 = window.Difficulty
        if ____opt_2543 ~= nil then
            ____opt_2543 = ____opt_2543.getSettings
        end
        local ____opt_result_2545
        if ____opt_2543 ~= nil then
            ____opt_result_2545 = ____opt_2543(____opt_2543, e.difficultyMode)
        end
        local ____opt_result_2546
        if ____opt_result_2545 ~= nil then
            ____opt_result_2546 = ____opt_result_2545.label
        end
        __O[2016] = ____opt_result_2546
        if ____t_2547(____opt_result_2546) then
            ____t_result_2548 = __O[2016]
        else
            ____t_result_2548 = "NORMAL"
        end
        ____L1_toast_2552(
            __L1,
            ____add_2551(
                ____add_2550(
                    ____add_2549(____t_result_2548, " · Nv. "),
                    __L1:bossProfile(e).level
                ),
                " sugerido. Invista em ATRIBUTOS e ataque nas aberturas. E na saída: recuar."
            )
        )
        return true
    end
    __L1.bossFan = function(self, e, ____type, count, speed, spread)
        if spread == nil then
            spread = 0.16
        end
        local ____opt_2555 = window.CampaignVfx
        if ____opt_2555 ~= nil then
            ____opt_2555 = ____opt_2555.emit
        end
        if ____opt_2555 ~= nil then
            ____opt_2555(
                ____opt_2555,
                "cast",
                {
                    x = e.x + __TS__MathSign(e.targetX - e.x) * 26,
                    y = e.y - 42,
                    dir = __TS__MathSign(e.targetX - e.x),
                    kind = ____type
                }
            )
        end
        local a = math.atan(e.targetY - (e.y - 42), e.targetX - e.x)
        do
            local i = 0
            while __lt(i, count) do
                local angle = a + (i - (count - 1) / 2) * spread
                local ____call_2567 = __call
                local ____L1_shots_2566 = __L1.shots
                local ____temp_2561 = e.x + __TS__MathSign(e.targetX - e.x) * 30
                local ____temp_2562 = e.y - 42
                local ____temp_2563 = math.cos(angle) * speed
                local ____temp_2564 = math.sin(angle) * speed
                local ____type_2565 = ____type
                local ____temp_2560
                if ____type == "smoke" then
                    ____temp_2560 = 10
                else
                    local ____temp_2559
                    if ____type == "confetti" then
                        ____temp_2559 = 12
                    else
                        local ____temp_2558
                        if ____type == "word" then
                            ____temp_2558 = 12
                        else
                            local ____temp_2557
                            if ____type == "doodle" then
                                ____temp_2557 = __gt(e.angry, 0) and 18 or 13
                            else
                                ____temp_2557 = 16
                            end
                            ____temp_2558 = ____temp_2557
                        end
                        ____temp_2559 = ____temp_2558
                    end
                    ____temp_2560 = ____temp_2559
                end
                ____call_2567(
                    ____L1_shots_2566,
                    "push",
                    {
                        x = ____temp_2561,
                        y = ____temp_2562,
                        vx = ____temp_2563,
                        vy = ____temp_2564,
                        life = 5,
                        type = ____type_2565,
                        owner = "enemy",
                        damage = ____temp_2560,
                        text = __get(
                            __L1.phrases,
                            __mod(
                                i,
                                __len(__L1.phrases)
                            )
                        ),
                        variant = __mod(i, 3),
                        enraged = __gt(e.angry, 0)
                    }
                )
                i = i + 1
            end
        end
    end
    __L1.addHazard = function(self, x, ____type, delay, r)
        if delay == nil then
            delay = 0.75
        end
        if r == nil then
            r = 55
        end
        __call(
            __L1.hazards,
            "push",
            {
                x = __L1:clamp(x, 55, __L1.WORLD - 55),
                y = __L1.FLOOR - 6,
                r = r,
                delay = delay,
                life = 0.55,
                triggered = false,
                type = ____type,
                damage = ____type == "slime" and 19 or 16
            }
        )
    end
    __L1.executeBossAttack = function(self, e)
        e.visualAttackAt = __L1.time
        local firstShot = __len(__L1.shots)
        local firstHazard = __len(__L1.hazards)
        local firstMinion = __len(__L1.minions)
        local p = __L1:bossProfile(e)
        __L1:performBossAttack(e)
        for ____, s in __iterar((__call(__L1.shots, "slice", firstShot))) do
            if s.owner == "enemy" then
                s.vx = s.vx * p.projectileSpeed
                s.vy = s.vy * p.projectileSpeed
                if __t(s.gravity) then
                    s.gravity = s.gravity * p.projectileSpeed
                end
                s.damage = math.floor(s.damage * p.damage + 0.5)
                s.splashDamage = math.floor(19 * p.damage + 0.5)
            end
        end
        for ____, h in __iterar((__call(__L1.hazards, "slice", firstHazard))) do
            h.damage = math.floor(h.damage * p.damage + 0.5)
            if __t(h.speed) then
                h.speed = h.speed * p.projectileSpeed
            end
            h.delay = math.max(0.5, h.delay * 0.9)
        end
        for ____, m in __iterar((__call(__L1.minions, "slice", firstMinion))) do
            if __t(m.summoned) then
                local ____math_floor_result_2568 = math.floor(m.max * 1.15 + 0.5)
                m.max = ____math_floor_result_2568
                m.hp = ____math_floor_result_2568
                m.damage = math.floor(m.damage * 1.25 + 0.5)
                local ____t_result_2569
                if __t(m.speed) then
                    ____t_result_2569 = m.speed
                else
                    ____t_result_2569 = 75
                end
                m.speed = ____t_result_2569 * 1.2
                m.projectileSpeed = 1.2
            end
        end
        if e.state == "firing" then
            e.stateTimer = e.stateTimer * 0.85
        end
    end
    __L1.performBossAttack = function(self, e)
        e.charge = 0
        if __t(__L1:executeNikolasFormAttack(e)) then
            return
        end
        if __t(__L1:executePhaseSkill(e)) then
            return
        end
        if __t(e.type == "igor" or e.type == "kaique") then
            __L1:executeMonitorAttack(e)
            return
        end
        if __t(e.type == "dede" and e.kind ~= "dash") then
            __L1:executeDede(e)
            return
        end
        if __t(e.type == "arthur" and e.kind ~= "dash") then
            __L1:executeArthur(e)
            return
        end
        if __t(e.type == "nicolas" and e.kind ~= "dash") then
            __L1:executeNicolas(e)
            return
        end
        if __t(e.type == "freddy" and e.kind ~= "dash") then
            __L1:executeFreddy(e)
            return
        end
        if __t(e.type == "menezes" and e.kind ~= "dash") then
            __L1:executeMenezes(e)
            return
        end
        local ____t_2573 = __t
        local ____t_result_2572
        local ____t_2571 = __t
        local ____temp_2570 = e.type == "nikolas" and e.kind == "slimeFan"
        __O[2017] = ____temp_2570
        if ____t_2571(____temp_2570) then
            ____t_result_2572 = e.phase == 3
        else
            ____t_result_2572 = __O[2017]
        end
        if ____t_2573(____t_result_2572) then
            __L1:bossFan(
                e,
                "slime",
                5,
                258,
                0.17
            )
            local angle = math.atan(e.targetY - (e.y - 42), e.targetX - e.x)
            local ____t_result_2576
            local ____t_2575 = __t
            local ____TS__MathSign_result_2574 = __TS__MathSign(e.targetX - e.x)
            __O[2018] = ____TS__MathSign_result_2574
            if ____t_2575(____TS__MathSign_result_2574) then
                ____t_result_2576 = __O[2018]
            else
                ____t_result_2576 = -1
            end
            local direction = ____t_result_2576
            do
                local i = -2
                while i <= 2 do
                    __call(
                        __L1.shots,
                        "push",
                        {
                            x = e.x + direction * 30,
                            y = e.y - 42,
                            vx = math.cos(angle + i * 0.2) * 278,
                            vy = math.sin(angle + i * 0.2) * 278,
                            life = 5,
                            delay = 0.78,
                            type = "slime",
                            owner = "enemy",
                            damage = 14,
                            secondWave = true
                        }
                    )
                    i = i + 1
                end
            end
            e.state = "firing"
            e.stateTimer = 1.15
            __L1:floating(e.x, e.y - 165, "DUAS RAJADAS DE CATARRO!", "#d5e7a2")
            __L1:fx(
                e.x,
                e.y - 38,
                "#c3da73",
                18,
                115
            )
            __L1:beep(105, 0.16, "sawtooth", 0.018)
            return
        end
        if __t(__call(
            __arrL({"brainrots", "sixseven", "summonInk", "sketchSwarm"}, 4),
            "includes",
            e.kind
        )) then
            __L1:summonDoodles(e)
        elseif e.kind == "inkSlam" then
            __call(__L1.hazards, "push", {
                x = e.x,
                y = __L1.FLOOR - 5,
                type = "ring",
                ink = true,
                r = 0,
                delay = 0.75,
                life = 3,
                speed = 210 + e.phase * 12,
                maxR = 850,
                damage = 15,
                triggered = false
            })
            __L1:addHazard(e.targetX, "ink", 1, 55)
        elseif e.kind == "sketchLine" then
            local ____t_result_2579
            local ____t_2578 = __t
            local ____TS__MathSign_result_2577 = __TS__MathSign(e.targetX - e.x)
            __O[2019] = ____TS__MathSign_result_2577
            if ____t_2578(____TS__MathSign_result_2577) then
                ____t_result_2579 = __O[2019]
            else
                ____t_result_2579 = -1
            end
            local direction = ____t_result_2579
            __call(__L1.shots, "push", {
                x = e.x + direction * 25,
                y = __L1.FLOOR - 19,
                vx = direction * (250 + e.phase * 20),
                vy = 0,
                life = 3.2,
                type = "inkBlade",
                owner = "enemy",
                damage = 15
            })
            if e.phase == 3 then
                __call(
                    __L1.shots,
                    "push",
                    {
                        x = e.x - direction * 25,
                        y = __L1.FLOOR - 19,
                        vx = __TS__Number(-direction) * 260,
                        vy = 0,
                        life = 3.2,
                        type = "inkBlade",
                        owner = "enemy",
                        damage = 15,
                        delay = 0.4
                    }
                )
            end
        elseif e.kind == "slam" then
            do
                local i = -2
                while i <= 2 do
                    __L1:addHazard(
                        e.targetX + i * 95,
                        "ink",
                        0.75 + math.abs(i) * 0.1,
                        65
                    )
                    i = i + 1
                end
            end
            __call(__L1.hazards, "push", {
                x = e.x,
                y = __L1.FLOOR - 5,
                type = "ring",
                r = 0,
                delay = 0.7,
                life = 3,
                speed = 230,
                maxR = 900,
                damage = 20,
                triggered = false
            })
        elseif e.kind == "doodleRain" then
            do
                local i = 0
                while __lt(i, 6 + e.phase) do
                    __call(
                        __L1.shots,
                        "push",
                        {
                            x = __L1:clamp(
                                e.targetX + (i - (5 + e.phase) / 2) * 80,
                                __get(__L1.arena.bounds, 0) + 25,
                                __get(__L1.arena.bounds, 1) - 25
                            ),
                            y = 70 - __mod(i, 2) * 20,
                            vx = 0,
                            vy = 105,
                            gravity = 260,
                            life = 4,
                            type = "doodle",
                            owner = "enemy",
                            damage = 16,
                            variant = __mod(i, 3)
                        }
                    )
                    i = i + 1
                end
            end
        elseif e.kind == "gangFan" then
            __L1:bossFan(
                e,
                "enemyBullet",
                3 + e.phase * 2,
                220 + e.phase * 22,
                0.16
            )
        elseif e.kind == "dash" then
            e.state = "dashing"
            e.stateTimer = 0.5
            local ____e_2583 = e
            local ____t_result_2582
            local ____t_2581 = __t
            local ____TS__MathSign_result_2580 = __TS__MathSign(e.targetX - e.x)
            __O[2020] = ____TS__MathSign_result_2580
            if ____t_2581(____TS__MathSign_result_2580) then
                ____t_result_2582 = __O[2020]
            else
                ____t_result_2582 = -1
            end
            ____e_2583.dashDir = ____t_result_2582
            __L1:beep(100, 0.14, "sawtooth")
            return
        end
        if e.kind == "mines" then
            do
                local i = -1
                while i <= 1 do
                    __L1:addHazard(
                        e.targetX + i * (e.phase == 3 and 115 or 140),
                        e.type == "nikolas" and "slime" or (e.type == "marco" and "ink" or "word"),
                        0.7 + math.abs(i) * 0.12,
                        e.phase == 3 and 63 or 53
                    )
                    i = i + 1
                end
            end
        elseif e.kind == "slimeRain" then
            do
                local i = 0
                while __lt(i, 4 + e.phase) do
                    local x = e.targetX + (i - (3 + e.phase) / 2) * 92
                    __call(
                        __L1.shots,
                        "push",
                        {
                            x = __L1:clamp(x, 50, __L1.WORLD - 50),
                            y = 125 - __mod(i, 2) * 25,
                            vx = 0,
                            vy = 115,
                            gravity = 370,
                            life = 4,
                            type = "slime",
                            owner = "enemy",
                            damage = 16,
                            splash = true
                        }
                    )
                    i = i + 1
                end
            end
        elseif not __t(__call(
            __arrL({
                "brainrots",
                "sixseven",
                "summonInk",
                "sketchSwarm",
                "inkSlam",
                "sketchLine",
                "slam",
                "doodleRain",
                "gangFan"
            }, 9),
            "includes",
            e.kind
        )) then
            __L1:bossFan(
                e,
                e.kind == "fan" and "doodle" or (e.kind == "words" and "word" or "slime"),
                (e.phase == 1 and 3 or (e.phase == 2 and 5 or 7)) + (__t(e.type == "marco" and __gt(e.phase, 1)) and 2 or 0),
                (__gt(e.angry, 0) and 265 or 205) + e.phase * 26 + (e.type == "marco" and 15 or 0),
                e.type == "menezes" and 0.18 or 0.15
            )
        end
        e.state = "firing"
        e.stateTimer = 0.45
        __L1:fx(
            e.x,
            e.y - 38,
            e.type == "nikolas" and "#c3da73" or (e.type == "marco" and "#d1a6e8" or "#e2acba"),
            14,
            115
        )
        __L1:beep(120, 0.12, "sawtooth", 0.018)
    end
    __L1.sincronizarConquista = function(self, e)
        local f = e.conquista
        e.x = f.x
        e.y = f.y
        e.state = f.estado
        e.kind = f.golpe
        e.stateTimer = math.max(0, f.dur - f.tempo)
        e.windupDuration = f.dur
        local ____e_2585 = e
        local ____temp_2584
        if f.estado == "windup" then
            ____temp_2584 = 100 * __L1:clamp(f.tempo / f.dur, 0, 1)
        else
            ____temp_2584 = 0
        end
        ____e_2585.charge = ____temp_2584
    end
    __L1.atualizarConquista = function(self, e, dt)
        local f = e.conquista
        window.ConquistaCombate:atualizar(
            f,
            dt,
            __L1.player,
            function(____, d, x) return __L1:hurt(
                math.floor(d * __L1:bossProfile(e).damage + 0.5),
                x
            ) end,
            function()
                e.visualAttackAt = __L1.time
                window.C2Luta:som(f.slug, __L1.beep, f.fase)
            end
        )
        __L1:sincronizarConquista(e)
        local ____t_2593 = __t
        local ____t_result_2592
        local ____t_2589 = __t
        local ____t_result_2588
        local ____t_2587 = __t
        local ____temp_2586 = f.estado == "phaseChange"
        __O[2021] = ____temp_2586
        if ____t_2587(____temp_2586) then
            ____t_result_2588 = __O[2021]
        else
            ____t_result_2588 = __L1.defeated
        end
        __O[2022] = ____t_result_2588
        if ____t_2589(____t_result_2588) then
            ____t_result_2592 = __O[2022]
        else
            local ____opt_2590 = __L1.sandbox
            if ____opt_2590 ~= nil then
                ____opt_2590 = ____opt_2590.result
            end
            ____t_result_2592 = ____opt_2590
        end
        if ____t_2593(____t_result_2592) then
            return
        end
        local ____t_result_2594
        if __t(f.gemeoX ~= nil and math.abs(__L1.player.x - f.gemeoX) < math.abs(__L1.player.x - e.x)) then
            ____t_result_2594 = f.gemeoX
        else
            ____t_result_2594 = e.x
        end
        local corpo = ____t_result_2594
        local ____t_2596 = __t
        local ____temp_2595
        if f.slug == "jorge" then
            ____temp_2595 = window.JorgeDuelo:toca(
                f,
                __L1.player.x,
                __L1.player.y - 26,
                12,
                26
            )
        else
            ____temp_2595 = math.abs(__L1.player.y - e.y) < 62 and math.abs(__L1.player.x - corpo) < 34
        end
        if ____t_2596(____temp_2595) then
            __L1:hurt(
                math.floor(13 * __L1:bossProfile(e).damage + 0.5),
                corpo
            )
        end
    end
    __L1.updateEnemies = function(self, dt)
        for ____, e in __iterar((__L1.enemies)) do
            do
                if __le(e.hp, 0) then
                    continue
                end
                e.hit = math.max(0, e.hit - dt)
                e.damageLock = math.max(0, e.damageLock - dt)
                if __t(e.type == "marco" and not __t(e.rage)) then
                    e.angry = math.max(0, e.angry - dt)
                end
                if __gt(e.burn, 0) then
                    e.burn = e.burn - dt
                    local ____add_2598 = __add
                    local ____t_result_2597
                    if __t(e.burnTick) then
                        ____t_result_2597 = e.burnTick
                    else
                        ____t_result_2597 = 0
                    end
                    e.burnTick = ____add_2598(____t_result_2597, dt)
                    if __gt(e.burnTick, 0.6) then
                        e.burnTick = 0
                        __L1:damageEnemy(e, 5)
                    end
                end
            end
        end
        for ____, e in __iterar((__L1.enemies)) do
            local ____t_2604 = __t
            local ____t_result_2603
            local ____t_2602 = __t
            local ____t_result_2601
            local ____t_2600 = __t
            local ____temp_2599 = not __t(e.conquista) and __gt(e.hp, 0)
            __O[2023] = ____temp_2599
            if ____t_2600(____temp_2599) then
                ____t_result_2601 = e.type == "dede"
            else
                ____t_result_2601 = __O[2023]
            end
            __O[2024] = ____t_result_2601
            if ____t_2602(____t_result_2601) then
                ____t_result_2603 = math.abs(e.x - __L1.player.x) < 650
            else
                ____t_result_2603 = __O[2024]
            end
            if ____t_2604(____t_result_2603) then
                e.tauntTimer = e.tauntTimer - dt
                if __le(e.tauntTimer, 0) then
                    e.tauntTimer = 6
                    __L1:floating(e.x, e.y - 115, "SEU GILÓ HOMI!", "#e1eccd")
                end
            end
        end
        for ____, e in __iterar((__L1.enemies)) do
            local ____t_2610 = __t
            local ____t_result_2609
            local ____t_2608 = __t
            local ____t_result_2607
            local ____t_2606 = __t
            local ____temp_2605 = not __t(e.conquista) and __gt(e.hp, 0)
            __O[2025] = ____temp_2605
            if ____t_2606(____temp_2605) then
                ____t_result_2607 = e.type == "freddy"
            else
                ____t_result_2607 = __O[2025]
            end
            __O[2026] = ____t_result_2607
            if ____t_2608(____t_result_2607) then
                ____t_result_2609 = math.abs(e.x - __L1.player.x) < 650
            else
                ____t_result_2609 = __O[2026]
            end
            if ____t_2610(____t_result_2609) then
                e.tauntTimer = e.tauntTimer - dt
                if __le(e.tauntTimer, 0) then
                    e.tauntTimer = 6
                    __L1:floating(
                        e.x,
                        e.y - 125,
                        __t(__mod(e.pattern, 2)) and "OPEESTY DA ROÇA!" or "Ô REEEIS! Seu capanga tá trabalhando!",
                        "#efd19d"
                    )
                end
            end
        end
        __L1:updateSchoolMonitors(dt)
        local e = __L1.activeBoss
        local ____t_2615 = __t
        local ____t_result_2614
        local ____t_2612 = __t
        local ____temp_2611 = not __t(e) or __le(e.hp, 0)
        __O[2027] = ____temp_2611
        if ____t_2612(____temp_2611) then
            ____t_result_2614 = __O[2027]
        else
            local ____t_result_2613
            if __t(__L1.arena) then
                ____t_result_2613 = __L1.arena.phase ~= "active"
            else
                ____t_result_2613 = __L1.arena
            end
            ____t_result_2614 = ____t_result_2613
        end
        if ____t_2615(____t_result_2614) then
            return
        end
        if __t(e.conquista) then
            __L1:atualizarConquista(e, dt)
            return
        end
        e.stateTimer = e.stateTimer - dt
        if e.state == "windup" then
            e.charge = __L1:clamp(100 * (1 - e.stateTimer / e.windupDuration), 0, 100)
        end
        if __gt(e.safeLaneTime, 0) then
            e.safeLaneTime = math.max(0, e.safeLaneTime - dt)
        end
        local ____t_2619 = __t
        local ____t_result_2618
        local ____t_2617 = __t
        local ____temp_2616 = e.type == "nikolas" and e.phase == 3
        __O[2028] = ____temp_2616
        if ____t_2617(____temp_2616) then
            ____t_result_2618 = e.state ~= "phaseChange"
        else
            ____t_result_2618 = __O[2028]
        end
        if ____t_2619(____t_result_2618) then
            local ____add_2621 = __add
            local ____t_result_2620
            if __t(e.flightTime) then
                ____t_result_2620 = e.flightTime
            else
                ____t_result_2620 = 0
            end
            e.flightTime = ____add_2621(____t_result_2620, dt)
            e.y = __L1.FLOOR - 110 + math.sin(e.flightTime * 2) * 17
            e.x = __L1:clamp(
                e.homeX + math.sin(e.flightTime * 0.9) * 130,
                __get(__L1.arena.bounds, 0) + 85,
                __get(__L1.arena.bounds, 1) - 85
            )
        end
        if e.state == "phaseChange" then
            e.phaseTransitionTimer = math.max(0, e.stateTimer)
            if e.type == "nikolas" then
                local progress = __L1:nikolasTransformProgress(e)
                local ____temp_2626
                if e.phase == 3 then
                    ____temp_2626 = __L1.FLOOR - 110 * progress
                else
                    local ____temp_2625
                    if e.phase == 4 then
                        local ____t_result_2622
                        if __t(e.phaseStartY) then
                            ____t_result_2622 = e.phaseStartY
                        else
                            ____t_result_2622 = __L1.FLOOR
                        end
                        local ____L1_FLOOR_2624 = __L1.FLOOR
                        local ____t_result_2623
                        if __t(e.phaseStartY) then
                            ____t_result_2623 = e.phaseStartY
                        else
                            ____t_result_2623 = __L1.FLOOR
                        end
                        ____temp_2625 = ____t_result_2622 + (____L1_FLOOR_2624 - ____t_result_2623) * progress
                    else
                        ____temp_2625 = __L1.FLOOR
                    end
                    ____temp_2626 = ____temp_2625
                end
                e.y = ____temp_2626
                if e.phase == 4 then
                    local ____t_result_2627
                    if __t(e.phaseStartX) then
                        ____t_result_2627 = e.phaseStartX
                    else
                        ____t_result_2627 = e.homeX
                    end
                    local ____temp_2629 = __get(__L1.arena.bounds, 1) - 200
                    local ____t_result_2628
                    if __t(e.phaseStartX) then
                        ____t_result_2628 = e.phaseStartX
                    else
                        ____t_result_2628 = e.homeX
                    end
                    e.x = ____t_result_2627 + (____temp_2629 - ____t_result_2628) * progress
                end
                if math.random() < 0.65 then
                    __L1:fx(
                        __add(
                            e.x,
                            __L1:rand(-60, 60)
                        ),
                        e.y - 70,
                        e.phase == 3 and "#d3b2ff" or "#ffe4a0",
                        2,
                        95
                    )
                end
            end
            if __le(e.stateTimer, 0) then
                e.damageLock = 0
                if e.type == "nikolas" then
                    local ____temp_2630
                    if e.phase == 3 then
                        ____temp_2630 = __L1.FLOOR - 110
                    else
                        ____temp_2630 = __L1.FLOOR
                    end
                    e.y = ____temp_2630
                end
                __L1:beginBossWindup(e)
            end
            return
        end
        if e.state == "monitorTransform" then
            e.monitorTransform = __L1:clamp(1 - e.stateTimer / 1.25, 0, 1)
            if __le(e.stateTimer, 0) then
                __L1:beginBossWindup(e)
            end
        elseif e.state == "bellyAir" then
            local t = __L1:clamp(1 - e.stateTimer / e.bellyDuration, 0, 1)
            e.x = e.bellyFrom + (e.bellyTo - e.bellyFrom) * t
            e.y = __L1.FLOOR - math.sin(t * math.pi) * (30 + e.phase * 4)
            if __le(e.stateTimer, 0) then
                e.y = __L1.FLOOR
                e.state = "recover"
                e.stateTimer = __L1:bossRecovery(e)
                __call(
                    __L1.hazards,
                    "push",
                    {
                        x = e.x,
                        y = __L1.FLOOR - 5,
                        type = "ring",
                        r = 0,
                        delay = 0.45,
                        life = 3,
                        speed = (170 + e.phase * 15) * __L1:bossProfile(e).projectileSpeed,
                        maxR = 820,
                        damage = math.floor(12 * __L1:bossProfile(e).damage + 0.5),
                        triggered = false
                    }
                )
                __L1.shake = 8
                __L1:fx(
                    e.x,
                    __L1.FLOOR - 12,
                    "#e2bb83",
                    24,
                    150
                )
            end
        elseif e.state == "bellyRolling" then
            local ____t_result_2631
            if __t(e.rollAngle) then
                ____t_result_2631 = e.rollAngle
            else
                ____t_result_2631 = 0
            end
            e.rollAngle = ____t_result_2631 + dt * 9 * e.dashDir
            e.x = __L1:clamp(
                e.x + e.dashDir * 350 * __L1:bossProfile(e).dashSpeed * dt,
                __get(__L1.arena.bounds, 0) + 120,
                __get(__L1.arena.bounds, 1) - 120
            )
            if __le(e.stateTimer, 0) then
                e.state = "recover"
                e.stateTimer = __L1:bossRecovery(e)
                e.rollAngle = 0
            end
        elseif __t(e.state == "windup" and __le(e.stateTimer, 0)) then
            __L1:executeBossAttack(e)
        elseif __t(e.state == "underground" and __le(e.stateTimer, 0)) then
            e.x = __L1:clamp(
                e.emergeX,
                __get(__L1.arena.bounds, 0) + 60,
                __get(__L1.arena.bounds, 1) - 60
            )
            e.y = __L1.FLOOR
            e.state = "recover"
            e.stateTimer = __L1:bossRecovery(e)
            __L1:fx(
                e.x,
                __L1.FLOOR - 12,
                "#bfc69c",
                25,
                125
            )
            __L1:floating(e.x, e.y - 125, "SAIU DO ESGOTO!", "#dfe5b3")
        elseif __t(e.state == "concealed" and __le(e.stateTimer, 0)) then
            e.state = "recover"
            e.stateTimer = __L1:bossRecovery(e)
        elseif e.state == "dashing" then
            local ____L1_clamp_2644 = __L1.clamp
            local ____temp_2642 = e.x + e.dashDir * (e.type == "giant" and 450 or (e.type == "reeisBoss" and 690 or (e.type == "nicolas" and 710 or (e.type == "freddy" and 630 or (e.type == "nikolas" and 670 or 580))))) * __L1:bossProfile(e).dashSpeed * dt
            local ____temp_2636 = e.homeX - 390
            local ____getq_2634 = __getq
            local ____opt_2632 = __L1.arena
            if ____opt_2632 ~= nil then
                ____opt_2632 = ____opt_2632.bounds
            end
            local ____getq_2634_result_2635 = ____getq_2634(____opt_2632, 0)
            if ____getq_2634_result_2635 == nil then
                ____getq_2634_result_2635 = e.homeX - 430
            end
            local ____math_max_result_2643 = math.max(____temp_2636, ____getq_2634_result_2635 + 25)
            local ____temp_2641 = e.homeX + 390
            local ____getq_2639 = __getq
            local ____opt_2637 = __L1.arena
            if ____opt_2637 ~= nil then
                ____opt_2637 = ____opt_2637.bounds
            end
            local ____getq_2639_result_2640 = ____getq_2639(____opt_2637, 1)
            if ____getq_2639_result_2640 == nil then
                ____getq_2639_result_2640 = e.homeX + 430
            end
            e.x = ____L1_clamp_2644(
                __L1,
                ____temp_2642,
                ____math_max_result_2643,
                math.min(____temp_2641, ____getq_2639_result_2640 - 25)
            )
            if math.random() < 0.5 then
                __L1:fx(
                    e.x - e.dashDir * 20,
                    e.y - 12,
                    e.type == "nikolas" and "#b6cf75" or "#ceaddb",
                    1,
                    40
                )
            end
            if __le(e.stateTimer, 0) then
                e.state = "recover"
                e.stateTimer = __L1:bossRecovery(e)
            end
        elseif __t(e.state == "firing" and __le(e.stateTimer, 0)) then
            e.state = "recover"
            e.stateTimer = __L1:bossRecovery(e)
        elseif __t(e.state == "recover" and __le(e.stateTimer, 0)) then
            __L1:beginBossWindup(e)
        end
        local ____t_2651 = __t
        local ____t_result_2650
        local ____t_2646 = __t
        local ____temp_2645 = not __t(__call(
            __arrL({"underground", "monitorTransform", "phaseChange"}, 3),
            "includes",
            e.state
        ))
        __O[2029] = ____temp_2645
        if ____t_2646(____temp_2645) then
            local ____temp_2649
            if e.type == "igor" then
                ____temp_2649 = __L1:igorContains(
                    e,
                    __L1.player.x,
                    __L1.player.y - 27,
                    14,
                    23
                )
            else
                local ____t_result_2648
                if __t(window.Golpes) then
                    ____t_result_2648 = window.Golpes:cruza(
                        window.Golpes:chefe(e),
                        window.Golpes:heroi(__L1.player)
                    )
                else
                    local ____t_result_2647
                    if __t(e.type == "nikolas" and __ge(e.phase, 2)) then
                        ____t_result_2647 = __L1:nikolasContains(
                            e,
                            __L1.player.x,
                            __L1.player.y - 27,
                            14,
                            23
                        )
                    else
                        ____t_result_2647 = math.abs(e.x - __L1.player.x) < (e.type == "giant" and 95 or (__t(e.rage) and 60 or 43)) and math.abs(e.y - __L1.player.y) < (e.type == "giant" and 155 or 75)
                    end
                    ____t_result_2648 = ____t_result_2647
                end
                ____temp_2649 = ____t_result_2648
            end
            ____t_result_2650 = ____temp_2649
        else
            ____t_result_2650 = __O[2029]
        end
        if ____t_2651(____t_result_2650) then
            __L1:hurt(
                math.floor((__t(e.state == "dashing" or e.state == "bellyRolling") and 24 or (__t(e.type == "igor" and e.state == "bellyAir") and 20 or 13)) * __L1:bossProfile(e).damage + 0.5),
                e.x
            )
        end
    end
    __L1.summonDoodles = function(self, e)
        local roomLeft = 6 - __len(__call(
            __L1.minions,
            "filter",
            function(____, m)
                local ____t_result_2652
                if __t(m.summoned) then
                    ____t_result_2652 = not __t(m.dead)
                else
                    ____t_result_2652 = m.summoned
                end
                return ____t_result_2652
            end
        ))
        local ____t_result_2656
        local ____t_2655 = __t
        local ____opt_2653 = window.WorldData
        if ____opt_2653 ~= nil then
            ____opt_2653 = ____opt_2653.rageMinions
        end
        __O[2030] = ____opt_2653
        if ____t_2655(____opt_2653) then
            ____t_result_2656 = __O[2030]
        else
            ____t_result_2656 = __arrL({{design = "spindle"}, {design = "wobbler"}, {design = "pasta"}, {design = "brainrot"}}, 4)
        end
        local templates = ____t_result_2656
        do
            local i = 0
            while i < math.min(e.phase == 3 and 3 or 2, roomLeft) do
                local x = __L1:clamp(
                    e.x + (__t(__mod(i, 2)) and 170 or -170),
                    __get(__L1.arena.bounds, 0) + 45,
                    __get(__L1.arena.bounds, 1) - 45
                )
                local ____temp_2660
                if e.kind == "sixseven" then
                    ____temp_2660 = "sixseven"
                else
                    local ____t_result_2659
                    local ____t_2658 = __t
                    local ____get_result_design_2657 = __get(
                        templates,
                        __mod(
                            e.pattern + i,
                            __len(templates)
                        )
                    ).design
                    __O[2031] = ____get_result_design_2657
                    if ____t_2658(____get_result_design_2657) then
                        ____t_result_2659 = __O[2031]
                    else
                        ____t_result_2659 = "brainrot"
                    end
                    ____temp_2660 = ____t_result_2659
                end
                local design = ____temp_2660
                local hp = 40 + e.phase * 9
                __call(
                    __L1.minions,
                    "push",
                    {
                        id = __add(
                            __add(
                                __add(
                                    __add(e.type, "-summon-"),
                                    e.pattern
                                ),
                                "-"
                            ),
                            i
                        ),
                        scene = __L1.scene,
                        x = x,
                        y = __L1.FLOOR,
                        homeX = x,
                        summoned = true,
                        temporary = true,
                        life = 10,
                        kind = design == "sixseven" and 2 or 1,
                        type = "doodle",
                        design = design,
                        hp = hp,
                        max = hp,
                        damage = 9 + e.phase,
                        range = 100,
                        dir = __t(__mod(i, 2)) and 1 or -1,
                        vy = 0,
                        t = 1,
                        hit = 0,
                        dead = false,
                        xp = 0
                    }
                )
                i = i + 1
            end
        end
        __L1:floating(e.x, e.y - 160, e.kind == "sixseven" and "SIX SEVEN!" or "CADERNO, GANHA VIDA!", "#ffc4d6")
    end
    __L1.executeDede = function(self, e)
        local ____t_result_2663
        local ____t_2662 = __t
        local ____TS__MathSign_result_2661 = __TS__MathSign(e.targetX - e.x)
        __O[2032] = ____TS__MathSign_result_2661
        if ____t_2662(____TS__MathSign_result_2661) then
            ____t_result_2663 = __O[2032]
        else
            ____t_result_2663 = -1
        end
        local dir = ____t_result_2663
        local ____opt_2666 = e.fxTrago
        if ____opt_2666 ~= nil then
            ____opt_2666 = ____opt_2666.parar
        end
        if ____opt_2666 ~= nil then
            ____opt_2666(____opt_2666)
        end
        e.fxTrago = nil
        if e.kind == "smokeVeil" then
            e.state = "concealed"
            e.stateTimer = 1
            __L1:fx(
                e.x,
                e.y - 35,
                "#bec4c7",
                26,
                110
            )
            local ____opt_2670 = window.FxPixel
            if ____opt_2670 ~= nil then
                ____opt_2670 = ____opt_2670.tocar
            end
            if ____opt_2670 ~= nil then
                ____opt_2670(____opt_2670, "explosions/smoke-bomb", {
                    x = e.x,
                    y = __L1.FLOOR - 4,
                    palette = window.FxPixel.PAL.fumaca,
                    avancar = 0.9,
                    duracao = 1.7,
                    opcoes = {semLata = true}
                })
            end
            return
        end
        if e.kind == "bitucas" then
            local n = 3 + e.phase
            local ox = e.x + dir * 24
            local oy = e.y - 56
            do
                local i = 0
                while __lt(i, n) do
                    local land = __L1:clamp(
                        e.targetX + (i - (n - 1) / 2) * 72,
                        __get(__L1.arena.bounds, 0) + 40,
                        __get(__L1.arena.bounds, 1) - 40
                    )
                    local T = 0.72 + i * 0.07
                    local g = 620
                    __call(__L1.shots, "push", {
                        x = ox,
                        y = oy,
                        vx = (land - ox) / T,
                        vy = (__L1.FLOOR - 8 - oy) / T - g * T / 2,
                        gravity = g,
                        life = 3.2,
                        type = "bituca",
                        owner = "enemy",
                        damage = 8,
                        brasa = true,
                        spin = i * 1.7
                    })
                    i = i + 1
                end
            end
            e.state = "firing"
            e.stateTimer = 0.5
            __L1:fx(
                ox,
                oy,
                "#ffb070",
                8,
                70
            )
            __L1:beep(520, 0.05, "square", 0.012)
            return
        end
        if e.kind == "tragada" then
            do
                local i = 0
                while i < (e.phase == 3 and 2 or 1) do
                    __call(__L1.hazards, "push", {
                        x = e.x,
                        y = __L1.FLOOR - 5,
                        type = "ring",
                        smoke = true,
                        r = 0,
                        delay = 0.3 + i * 0.75,
                        life = 3,
                        speed = 205 + e.phase * 15,
                        maxR = 840,
                        damage = 13,
                        triggered = false
                    })
                    i = i + 1
                end
            end
            local ____opt_2674 = window.FxPixel
            if ____opt_2674 ~= nil then
                ____opt_2674 = ____opt_2674.tocar
            end
            if ____opt_2674 ~= nil then
                ____opt_2674(____opt_2674, "explosions/smoke-bomb", {
                    x = e.x + dir * 80,
                    y = e.y - 4,
                    palette = window.FxPixel.PAL.fumaca,
                    flip = dir < 0,
                    avancar = 0.9,
                    duracao = 1.9,
                    opcoes = {semLata = true}
                })
            end
            __L1:fx(
                e.x + dir * 20,
                e.y - 48,
                "#d4dcd6",
                30,
                170
            )
            __L1.shake = math.max(__L1.shake, 4)
            e.state = "firing"
            e.stateTimer = 0.7
            __L1:beep(80, 0.3, "sawtooth", 0.02)
            return
        end
        if e.kind == "cinzas" then
            do
                local i = -1
                while i <= 1 do
                    __call(
                        __L1.hazards,
                        "push",
                        {
                            x = __L1:clamp(
                                e.targetX + i * 125,
                                __get(__L1.arena.bounds, 0) + 40,
                                __get(__L1.arena.bounds, 1) - 40
                            ),
                            y = __L1.FLOOR - 8,
                            type = "smoke",
                            brasa = true,
                            cinza = true,
                            r = 42,
                            delay = 1.05 + math.abs(i) * 0.16,
                            life = 0.75,
                            damage = 12,
                            triggered = false
                        }
                    )
                    i = i + 1
                end
            end
            e.state = "firing"
            e.stateTimer = 0.45
            __L1:fx(
                e.x + dir * 26,
                e.y - 40,
                "#9a9690",
                10,
                60
            )
            __L1:beep(260, 0.06, "triangle", 0.012)
            return
        end
        if e.kind == "smokeFan" then
            __L1:bossFan(
                e,
                "smoke",
                3 + e.phase,
                175 + e.phase * 15,
                0.18
            )
        elseif e.kind == "cloudMines" then
            do
                local i = -1
                while i <= 1 do
                    __call(
                        __L1.hazards,
                        "push",
                        {
                            x = __L1:clamp(
                                e.targetX + i * 135,
                                __get(__L1.arena.bounds, 0) + 50,
                                __get(__L1.arena.bounds, 1) - 50
                            ),
                            y = __L1.FLOOR - 8,
                            type = "smoke",
                            r = 52,
                            delay = 1.05 + math.abs(i) * 0.1,
                            life = 0.85,
                            damage = 10,
                            triggered = false
                        }
                    )
                    i = i + 1
                end
            end
        end
        e.state = "firing"
        e.stateTimer = 0.4
        __L1:fx(
            e.x,
            e.y - 35,
            "#cbd4ce",
            12,
            95
        )
        __L1:beep(150, 0.1, "triangle", 0.015)
    end
    __L1.executeArthur = function(self, e)
        if e.kind == "poseFan" then
            __L1:bossFan(
                e,
                "confetti",
                3 + e.phase,
                190 + e.phase * 18,
                0.18
            )
        elseif e.kind == "poseWave" then
            __call(__L1.hazards, "push", {
                x = e.x,
                y = __L1.FLOOR - 5,
                type = "ring",
                r = 0,
                delay = 0.7,
                life = 3,
                speed = 215 + e.phase * 15,
                maxR = 850,
                damage = 13,
                triggered = false
            })
        end
        e.state = "firing"
        e.stateTimer = 0.45
        __L1:fx(
            e.x,
            e.y - 40,
            "#eab9df",
            18,
            105
        )
        __L1:beep(310, 0.1, "triangle", 0.018)
    end
    __L1.executeFreddy = function(self, e)
        if e.kind == "heavyFan" then
            __L1:bossFan(
                e,
                "enemyBullet",
                3 + e.phase,
                220 + e.phase * 18,
                0.15
            )
        elseif e.kind == "stomp" then
            __call(__L1.hazards, "push", {
                x = e.x,
                y = __L1.FLOOR - 5,
                type = "ring",
                r = 0,
                delay = 0.55,
                life = 3,
                speed = 220 + e.phase * 15,
                maxR = 850,
                damage = 16,
                triggered = false
            })
            __L1:floating(e.x, e.y - 128, "SEGURA ESSA, REEEIS!", "#efd19d")
        end
        e.state = "firing"
        e.stateTimer = 0.45
        __L1:fx(
            e.x,
            e.y - 35,
            "#e3b477",
            14,
            105
        )
        __L1:beep(115, 0.12, "square", 0.018)
    end
    __L1.executeNicolas = function(self, e)
        if e.kind == "astralFan" then
            __L1:bossFan(
                e,
                "astral",
                3 + e.phase * 2,
                190 + e.phase * 22,
                0.18
            )
        elseif e.kind == "skyLances" then
            do
                local i = -1
                while i <= 1 do
                    __call(
                        __L1.hazards,
                        "push",
                        {
                            x = __L1:clamp(
                                e.targetX + i * 125,
                                __get(__L1.arena.bounds, 0) + 35,
                                __get(__L1.arena.bounds, 1) - 35
                            ),
                            y = __L1.FLOOR - 6,
                            type = "astral",
                            r = 40,
                            delay = 0.95 + math.abs(i) * 0.15,
                            life = 0.5,
                            triggered = false,
                            damage = 18
                        }
                    )
                    i = i + 1
                end
            end
        elseif e.kind == "supremeRing" then
            __call(__L1.hazards, "push", {
                x = e.x,
                y = __L1.FLOOR - 5,
                type = "ring",
                astral = true,
                r = 0,
                delay = 0.65,
                life = 3,
                speed = 240 + e.phase * 18,
                maxR = 900,
                damage = 18,
                triggered = false
            })
            if e.phase == 3 then
                __call(__L1.hazards, "push", {
                    x = e.x,
                    y = __L1.FLOOR - 5,
                    type = "ring",
                    astral = true,
                    r = 0,
                    delay = 1.25,
                    life = 3,
                    speed = 240,
                    maxR = 900,
                    damage = 18,
                    triggered = false
                })
            end
        end
        e.state = "firing"
        e.stateTimer = 0.5
        __L1.shake = math.max(__L1.shake, 5)
        __L1:fx(
            e.x,
            e.y - 45,
            "#ffe28c",
            22,
            150
        )
        __L1:beep(210, 0.14, "triangle", 0.025)
    end
    __L1.executeMenezes = function(self, e)
        if e.kind == "sewerDive" then
            e.state = "underground"
            e.stateTimer = 1
            __L1:fx(
                e.x,
                __L1.FLOOR - 10,
                "#a7b68a",
                18,
                100
            )
            return
        end
        if e.kind == "ratsArmy" then
            local count = math.min(
                2 + e.phase,
                6 - __len(__call(
                    __L1.minions,
                    "filter",
                    function(____, m) return m.type == "rat" and not __t(m.dead) end
                ))
            )
            do
                local i = 0
                while i < count do
                    local x = __L1:clamp(
                        e.x + (__t(__mod(i, 2)) and 1 or -1) * (80 + math.floor(i / 2) * 45),
                        __get(__L1.arena.bounds, 0) + 35,
                        __get(__L1.arena.bounds, 1) - 35
                    )
                    local hp = 24 + e.phase * 6
                    __call(
                        __L1.minions,
                        "push",
                        {
                            id = __add(
                                __add(
                                    __add("menezes-rat-", e.pattern),
                                    "-"
                                ),
                                i
                            ),
                            scene = __L1.scene,
                            x = x,
                            y = __L1.FLOOR,
                            homeX = x,
                            summoned = true,
                            temporary = true,
                            life = 8,
                            type = "rat",
                            design = "rat",
                            kind = 0,
                            hp = hp,
                            max = hp,
                            damage = 6 + e.phase,
                            speed = 105 + e.phase * 12,
                            range = 340,
                            dir = __t(__mod(i, 2)) and 1 or -1,
                            vy = 0,
                            t = 1,
                            hit = 0,
                            dead = false,
                            xp = 0,
                            provocation = "REEIS POUDIAAAM!"
                        }
                    )
                    i = i + 1
                end
            end
            __L1:floating(e.x, e.y - 150, "EXÉRCITO DOS RATOS!", "#ddccaa")
        elseif e.kind == "wordWalls" then
            local ____t_result_2678
            local ____t_2677 = __t
            local ____TS__MathSign_result_2676 = __TS__MathSign(e.targetX - e.x)
            __O[2033] = ____TS__MathSign_result_2676
            if ____t_2677(____TS__MathSign_result_2676) then
                ____t_result_2678 = __O[2033]
            else
                ____t_result_2678 = -1
            end
            local direction = ____t_result_2678
            __call(__L1.shots, "push", {
                x = e.x + direction * 30,
                y = 200,
                vx = direction * (e.phase == 3 and 185 or 150),
                vy = 0,
                life = 6,
                type = "wordWall",
                owner = "enemy",
                damage = 17,
                gapY = e.wallGapY,
                gapHeight = 115
            })
        elseif e.kind == "ring" then
            __call(__L1.hazards, "push", {
                x = e.x,
                y = __L1.FLOOR - 5,
                type = "ring",
                r = 0,
                delay = 0.5,
                life = 3,
                speed = 230 + e.phase * 22,
                maxR = 860,
                damage = 17,
                triggered = false
            })
        elseif e.kind == "echo" then
            __L1:bossFan(
                e,
                "word",
                3,
                210,
                0.16
            )
            local a = math.atan(e.targetY - (e.y - 40), e.targetX - e.x)
            do
                local i = -1
                while i <= 1 do
                    __call(
                        __L1.shots,
                        "push",
                        {
                            x = e.x,
                            y = e.y - 40,
                            vx = math.cos(a + i * 0.12) * 245,
                            vy = math.sin(a + i * 0.12) * 245,
                            life = 5,
                            delay = 0.8,
                            type = "word",
                            echo = true,
                            owner = "enemy",
                            damage = 12,
                            text = __get(
                                __arrL({"PEGOU AR!", "ECO POUDIAAAM", "TEKETEKE"}, 3),
                                i + 1
                            )
                        }
                    )
                    i = i + 1
                end
            end
        elseif e.kind == "provokeZone" then
            local ____call_2694 = __call
            local ____L1_hazards_2693 = __L1.hazards
            local ____L1_clamp_2692 = __L1.clamp
            local ____e_targetX_2691 = e.targetX
            local ____t_result_2684
            local ____t_2683 = __t
            local ____getq_2681 = __getq
            local ____opt_2679 = __L1.arena
            if ____opt_2679 ~= nil then
                ____opt_2679 = ____opt_2679.bounds
            end
            local ____temp_2682 = ____getq_2681(____opt_2679, 0) + 100
            __O[2034] = ____temp_2682
            if ____t_2683(____temp_2682) then
                ____t_result_2684 = __O[2034]
            else
                ____t_result_2684 = 55
            end
            local ____t_result_2690
            local ____t_2689 = __t
            local ____getq_2687 = __getq
            local ____opt_2685 = __L1.arena
            if ____opt_2685 ~= nil then
                ____opt_2685 = ____opt_2685.bounds
            end
            local ____temp_2688 = ____getq_2687(____opt_2685, 1) - 100
            __O[2035] = ____temp_2688
            if ____t_2689(____temp_2688) then
                ____t_result_2690 = __O[2035]
            else
                ____t_result_2690 = __L1.WORLD - 55
            end
            ____call_2694(
                ____L1_hazards_2693,
                "push",
                {
                    x = ____L1_clamp_2692(__L1, ____e_targetX_2691, ____t_result_2684, ____t_result_2690),
                    y = __L1.FLOOR - 6,
                    r = 100,
                    delay = 1.1,
                    life = 2.1,
                    type = "provoke",
                    damage = 12,
                    triggered = false,
                    didLaunch = false
                }
            )
        end
        e.state = "firing"
        e.stateTimer = 0.45
        __L1:fx(
            e.x,
            e.y - 40,
            "#ecc2d5",
            14,
            115
        )
        __L1:beep(140, 0.13, "triangle")
    end
    __L1.updateHazards = function(self, dt)
        for ____, h in __iterar((__L1.hazards)) do
            do
                h.delay = h.delay - dt
                if __gt(h.delay, 0) then
                    continue
                end
                if not __t(h.triggered) then
                    h.triggered = true
                    if not __t(window.Golpes) then
                        local ____opt_2697 = window.FxPixel
                        if ____opt_2697 ~= nil then
                            ____opt_2697 = ____opt_2697.perigo
                        end
                        if ____opt_2697 ~= nil then
                            ____opt_2697(____opt_2697, h, __L1.activeBoss)
                        end
                        local ____L1_fx_2705 = __L1.fx
                        local ____h_x_2703 = h.x
                        local ____h_y_2704 = h.y
                        local ____t_2702 = __t
                        local ____t_result_2701
                        local ____t_2700 = __t
                        local ____temp_2699 = h.type == "astral"
                        __O[2036] = ____temp_2699
                        if ____t_2700(____temp_2699) then
                            ____t_result_2701 = __O[2036]
                        else
                            ____t_result_2701 = h.astral
                        end
                        ____L1_fx_2705(
                            __L1,
                            ____h_x_2703,
                            ____h_y_2704,
                            ____t_2702(____t_result_2701) and "#ffe39a" or (h.type == "slime" and "#bad677" or (h.type == "ink" and "#d2a7eb" or "#edb9cb")),
                            22,
                            135
                        )
                    end
                    __L1.shake = math.max(__L1.shake, 3)
                end
                h.life = h.life - dt
                if h.type == "ring" then
                    h.r = h.r + h.speed * dt
                    local ____t_2707 = __t
                    local ____t_result_2706
                    if __t(window.Golpes) then
                        ____t_result_2706 = window.Golpes:perigoAcerta(
                            h,
                            window.Golpes:heroi(__L1.player)
                        )
                    else
                        ____t_result_2706 = math.abs(math.abs(__L1.player.x - h.x) - h.r) < 27 and __gt(__L1.player.y, __L1.FLOOR - 57)
                    end
                    if ____t_2707(____t_result_2706) then
                        __L1:hurt(h.damage, h.x)
                    end
                    if __gt(h.r, h.maxR) then
                        h.life = 0
                    end
                else
                    local ____t_2716 = __t
                    local ____t_result_2715
                    if __t(window.Golpes) then
                        ____t_result_2715 = window.Golpes:perigoAcerta(
                            h,
                            window.Golpes:heroi(__L1.player)
                        )
                    else
                        local ____t_result_2714
                        local ____t_2709 = __t
                        local ____lt_result_2708 = __lt(
                            math.abs(__L1.player.x - h.x),
                            h.r
                        )
                        __O[2038] = ____lt_result_2708
                        if ____t_2709(____lt_result_2708) then
                            local ____t_result_2713
                            local ____t_2711 = __t
                            local ____temp_2710 = h.type == "astral"
                            __O[2037] = ____temp_2710
                            if ____t_2711(____temp_2710) then
                                ____t_result_2713 = __O[2037]
                            else
                                local ____t_result_2712
                                if __t(h.height) then
                                    ____t_result_2712 = __gt(__L1.player.y, __L1.FLOOR - h.height)
                                else
                                    ____t_result_2712 = __gt(__L1.player.y, __L1.FLOOR - 80)
                                end
                                ____t_result_2713 = ____t_result_2712
                            end
                            ____t_result_2714 = ____t_result_2713
                        else
                            ____t_result_2714 = __O[2038]
                        end
                        ____t_result_2715 = ____t_result_2714
                    end
                    if ____t_2716(____t_result_2715) then
                        local ____t_2720 = __t
                        local ____t_result_2719
                        local ____t_2718 = __t
                        local ____temp_2717 = h.type == "provoke" and not __t(h.didLaunch)
                        __O[2039] = ____temp_2717
                        if ____t_2718(____temp_2717) then
                            ____t_result_2719 = __le(__L1.player.inv, 0)
                        else
                            ____t_result_2719 = __O[2039]
                        end
                        if ____t_2720(____t_result_2719) then
                            __L1:hurt(h.damage, h.x)
                            __L1.player.vy = -250
                            __L1.player.ground = false
                            h.didLaunch = true
                            __L1:floating(__L1.player.x, __L1.player.y - 80, "PEGOU AR!", "#f4c6df")
                        else
                            __L1:hurt(h.damage, h.x)
                        end
                    end
                end
            end
        end
        __L1.hazards = __call(
            __L1.hazards,
            "filter",
            function(____, h) return __gt(h.delay, 0) or __gt(h.life, 0) end
        )
    end
    __L1.defeat = function(self)
        if __t(__L1.sandbox) then
            __L1:finishSandbox("defeated")
            return
        end
        __L1:resetBivolt()
        __L1.ollyanEncounter = nil
        __L1.defeated = true
        __L1.vehicle = false
        __L1.minions = __call(
            __L1.minions,
            "filter",
            function(____, m) return not __t(m.summoned) end
        )
        __L1:releaseInputs()
        __L1.reeisPhase = "idle"
        __L1.reeisTimer = 0
        __L1.shots = __arrL({}, 0)
        __L1.hazards = __arrL({}, 0)
        if __t(__L1.activeBoss) then
            __L1.activeBoss.hp = __L1.activeBoss.max
            __L1.activeBoss.x = __L1.activeBoss.homeX
            __L1:bossDefaults(__L1.activeBoss)
            __L1.marcoTrapTriggered = false
        end
        __L1.activeBoss = nil
        __L1.player.hp = 0
        __L1.player.y = __L1.FLOOR
        __L1:show("defeatScreen", true)
        __L1:save()
        __L1:updateUI()
        __L1:beep(70, 0.3, "sawtooth")
    end
    __L1.respawn = function(self)
        if not __t(__L1.defeated) then
            return false
        end
        local ____opt_2723 = window.CampaignVfx
        if ____opt_2723 ~= nil then
            ____opt_2723 = ____opt_2723.reset
        end
        if ____opt_2723 ~= nil then
            ____opt_2723(____opt_2723)
        end
        __L1:resetBivolt()
        __L1.ollyanEncounter = nil
        __L1.ollyanRetryGrace = 3
        __L1.marcoTrapTriggered = false
        __L1.defeated = false
        __L1.arena = nil
        __L1.room = nil
        __L1:resetWorldSize()
        __L1:show("defeatScreen", false)
        __L1:releaseInputs()
        __L1.player.hp = __L1:bonus().maxHP
        __L1.player.gas = __L1:bonus().maxGas
        __L1.player.papers = 30
        local ____L1_player_2728 = __L1.player
        local ____temp_2727
        local ____opt_2725 = __L1.respawnCheckpoint
        if ____opt_2725 ~= nil then
            ____opt_2725 = ____opt_2725.scene
        end
        if ____opt_2725 == __L1.scene then
            ____temp_2727 = __L1.respawnCheckpoint.x
        else
            ____temp_2727 = 230
        end
        ____L1_player_2728.x = ____temp_2727
        __L1.player.y = __L1.FLOOR
        __L1.player.vy = 0
        __L1.player.ground = true
        __L1.player.inv = 1
        __L1.camera = __L1:clamp(__L1.player.x - __L1.W * 0.36, 0, __L1.WORLD - __L1.W)
        for ____, e in __iterar((__L1.enemies)) do
            if __gt(e.hp, 0) then
                e.hp = e.max
                e.x = e.homeX
                __L1:bossDefaults(e)
            end
        end
        __L1:toast("Nova tentativa: observe o aviso, use dash e ataque na recuperação do chefe.")
        __L1:updateUI()
        __L1:save()
        return true
    end
    __L1.updateShots = function(self, dt)
        for ____, s in __iterar((__L1.shots)) do
            do
                if __gt(s.delay, 0) then
                    s.delay = s.delay - dt
                    continue
                end
                local ____t_2734 = __t
                local ____t_result_2733
                local ____t_2732 = __t
                local ____t_result_2731
                local ____t_2730 = __t
                local ____temp_2729 = s.owner == "enemy" and s.returnAt ~= nil
                __O[2040] = ____temp_2729
                if ____t_2730(____temp_2729) then
                    ____t_result_2731 = not __t(s.returned)
                else
                    ____t_result_2731 = __O[2040]
                end
                __O[2041] = ____t_result_2731
                if ____t_2732(____t_result_2731) then
                    ____t_result_2733 = __le(s.life, s.returnAt)
                else
                    ____t_result_2733 = __O[2041]
                end
                if ____t_2734(____t_result_2733) then
                    s.vx = __TS__Number(-s.vx)
                    s.vy = __TS__Number(-s.vy)
                    s.returned = true
                end
                s.x = s.x + s.vx * dt
                if __t(s.gravity) then
                    s.vy = s.vy + s.gravity * dt
                end
                s.y = s.y + s.vy * dt
                s.life = s.life - dt
                local ____t_2738 = __t
                local ____t_result_2737
                local ____t_2736 = __t
                local ____t_result_2735
                if __t(s.brasa) then
                    ____t_result_2735 = __gt(s.vy, 0)
                else
                    ____t_result_2735 = s.brasa
                end
                __O[2042] = ____t_result_2735
                if ____t_2736(____t_result_2735) then
                    ____t_result_2737 = __ge(s.y, __L1.FLOOR - 8)
                else
                    ____t_result_2737 = __O[2042]
                end
                if ____t_2738(____t_result_2737) then
                    __call(
                        __L1.hazards,
                        "push",
                        {
                            x = __L1:clamp(s.x, 40, __L1.WORLD - 40),
                            y = __L1.FLOOR - 6,
                            type = "smoke",
                            brasa = true,
                            r = 26,
                            delay = 0.05,
                            life = 1.25,
                            damage = math.max(
                                6,
                                math.floor(s.damage * 0.8 + 0.5)
                            ),
                            triggered = false
                        }
                    )
                    s.life = 0
                    continue
                end
                local ____t_2740 = __t
                local ____t_result_2739
                if __t(s.splash) then
                    ____t_result_2739 = __ge(s.y, __L1.FLOOR - 8)
                else
                    ____t_result_2739 = s.splash
                end
                if ____t_2740(____t_result_2739) then
                    __L1:addHazard(s.x, "slime", 0.55, 54)
                    if __t(s.splashDamage) then
                        __get(
                            __L1.hazards,
                            __len(__L1.hazards) - 1
                        ).damage = s.splashDamage
                    end
                    s.life = 0
                end
                if s.type == "wordWall" then
                    if __t(math.abs(s.x - __L1.player.x) < 35 and math.abs(__L1.player.y - 40 - s.gapY) > s.gapHeight / 2 - 14) then
                        __L1:hurt(s.damage, s.x)
                    end
                    continue
                end
                if s.owner == "player" then
                    local ____t_2748 = __t
                    local ____t_result_2747
                    local ____t_2746 = __t
                    local ____opt_2743 = __L1.activeBoss
                    if ____opt_2743 ~= nil then
                        ____opt_2743 = ____opt_2743.conquista
                    end
                    local ____opt_result_2745
                    if ____opt_2743 ~= nil then
                        ____opt_result_2745 = ____opt_2743.estrada
                    end
                    __O[2043] = ____opt_result_2745
                    if ____t_2746(____opt_result_2745) then
                        ____t_result_2747 = window.PerseguicaoMoto:acertar(__L1.activeBoss.conquista, s)
                    else
                        ____t_result_2747 = __O[2043]
                    end
                    if ____t_2748(____t_result_2747) then
                        s.life = 0
                        continue
                    end
                    for ____, e in __iterar((__L1.enemies)) do
                        local ____t_2767 = __t
                        local ____t_result_2766
                        local ____t_2750 = __t
                        local ____temp_2749 = __gt(e.hp, 0) and e.state ~= "underground"
                        __O[2046] = ____temp_2749
                        if ____t_2750(____temp_2749) then
                            local ____temp_2765
                            local ____opt_2751 = e.conquista
                            if ____opt_2751 ~= nil then
                                ____opt_2751 = ____opt_2751.slug
                            end
                            if ____opt_2751 == "jorge" then
                                ____temp_2765 = window.JorgeDuelo:toca(
                                    e.conquista,
                                    s.x,
                                    s.y,
                                    7,
                                    7
                                )
                            else
                                local ____temp_2764
                                if e.type == "igor" then
                                    ____temp_2764 = __L1:igorContains(
                                        e,
                                        s.x,
                                        s.y,
                                        7,
                                        7
                                    )
                                else
                                    local ____t_result_2763
                                    local ____t_2754 = __t
                                    local ____t_result_2753
                                    if __t(window.Golpes) then
                                        ____t_result_2753 = not __t(e.conquista)
                                    else
                                        ____t_result_2753 = window.Golpes
                                    end
                                    if ____t_2754(____t_result_2753) then
                                        ____t_result_2763 = window.Golpes:tiroAcerta(
                                            s,
                                            window.Golpes:chefe(e)
                                        )
                                    else
                                        local ____t_result_2762
                                        if __t(e.type == "nikolas" and __ge(e.phase, 2)) then
                                            ____t_result_2762 = __L1:nikolasContains(
                                                e,
                                                s.x,
                                                s.y,
                                                7,
                                                7
                                            )
                                        else
                                            local ____t_result_2761
                                            local ____t_2760 = __t
                                            local ____t_result_2759
                                            local ____t_2756 = __t
                                            local ____temp_2755 = math.abs(s.x - e.x) < (e.type == "giant" and 95 or (e.type == "reeisBoss" and 45 or 35))
                                            __O[2044] = ____temp_2755
                                            if ____t_2756(____temp_2755) then
                                                ____t_result_2759 = __O[2044]
                                            else
                                                local ____opt_2757 = e.conquista
                                                if ____opt_2757 ~= nil then
                                                    ____opt_2757 = ____opt_2757.gemeoX
                                                end
                                                ____t_result_2759 = ____opt_2757 ~= nil and math.abs(s.x - e.conquista.gemeoX) < 35
                                            end
                                            __O[2045] = ____t_result_2759
                                            if ____t_2760(____t_result_2759) then
                                                ____t_result_2761 = math.abs(s.y - (e.y - (e.type == "giant" and 80 or 30))) < (e.type == "giant" and 100 or 55)
                                            else
                                                ____t_result_2761 = __O[2045]
                                            end
                                            ____t_result_2762 = ____t_result_2761
                                        end
                                        ____t_result_2763 = ____t_result_2762
                                    end
                                    ____temp_2764 = ____t_result_2763
                                end
                                ____temp_2765 = ____temp_2764
                            end
                            ____t_result_2766 = ____temp_2765
                        else
                            ____t_result_2766 = __O[2046]
                        end
                        if ____t_2767(____t_result_2766) then
                            __L1:damageEnemy(e, s.damage, s.element)
                            s.life = 0
                            break
                        end
                    end
                    if __gt(s.life, 0) then
                        for ____, m in __iterar((__L1.minions)) do
                            local ____t_2772 = __t
                            local ____t_result_2771
                            local ____t_2769 = __t
                            local ____temp_2768 = not __t(m.dead)
                            __O[2047] = ____temp_2768
                            if ____t_2769(____temp_2768) then
                                local ____t_result_2770
                                if __t(window.Golpes) then
                                    ____t_result_2770 = window.Golpes:tiroAcerta(
                                        s,
                                        window.Golpes:capanga(m)
                                    )
                                else
                                    ____t_result_2770 = math.abs(s.x - m.x) < 28 and math.abs(s.y - (m.y - 22)) < 28
                                end
                                ____t_result_2771 = ____t_result_2770
                            else
                                ____t_result_2771 = __O[2047]
                            end
                            if ____t_2772(____t_result_2771) then
                                __L1:damageMinion(m, s.damage, s.element)
                                s.life = 0
                                break
                            end
                        end
                    end
                    if __gt(s.life, 0) then
                        for ____, d in __iterar((__L1.shots)) do
                            local ____t_2776 = __t
                            local ____t_result_2775
                            local ____t_2774 = __t
                            local ____temp_2773 = d.type == "doodle" and __gt(d.life, 0)
                            __O[2048] = ____temp_2773
                            if ____t_2774(____temp_2773) then
                                ____t_result_2775 = __hypot(s.x - d.x, s.y - d.y) < 27
                            else
                                ____t_result_2775 = __O[2048]
                            end
                            if ____t_2776(____t_result_2775) then
                                d.life = 0
                                s.life = 0
                                __L1:fx(
                                    d.x,
                                    d.y,
                                    "#dbc1ed",
                                    8,
                                    65
                                )
                                break
                            end
                        end
                    end
                else
                    local ____t_2778 = __t
                    local ____t_result_2777
                    if __t(window.Golpes) then
                        ____t_result_2777 = window.Golpes:tiroAcerta(
                            s,
                            window.Golpes:heroi(__L1.player)
                        )
                    else
                        ____t_result_2777 = math.abs(s.x - __L1.player.x) < (s.type == "word" and 55 or 22) and math.abs(s.y - (__L1.player.y - 28)) < 30
                    end
                    if ____t_2778(____t_result_2777) then
                        __L1:hurt(s.damage, s.x)
                        s.life = 0
                    end
                end
            end
        end
        __L1.shots = __call(
            __L1.shots,
            "filter",
            function(____, s)
                local ____t_result_2785
                local ____t_2784 = __t
                local ____t_result_2783
                local ____t_2782 = __t
                local ____t_result_2781
                local ____t_2780 = __t
                local ____temp_2779 = __gt(s.life, 0) and __gt(s.x, -100)
                __O[2049] = ____temp_2779
                if ____t_2780(____temp_2779) then
                    ____t_result_2781 = __lt(s.x, __L1.WORLD + 100)
                else
                    ____t_result_2781 = __O[2049]
                end
                __O[2050] = ____t_result_2781
                if ____t_2782(____t_result_2781) then
                    ____t_result_2783 = __lt(s.y, 520)
                else
                    ____t_result_2783 = __O[2050]
                end
                __O[2051] = ____t_result_2783
                if ____t_2784(____t_result_2783) then
                    ____t_result_2785 = __gt(s.y, 0)
                else
                    ____t_result_2785 = __O[2051]
                end
                return ____t_result_2785
            end
        )
    end
    __L1.updateEffects = function(self, dt)
        local ____opt_2788 = window.CampaignVfx
        if ____opt_2788 ~= nil then
            ____opt_2788 = ____opt_2788.update
        end
        if ____opt_2788 ~= nil then
            ____opt_2788(____opt_2788, dt)
        end
        local ____opt_2792 = window.Golpes
        if ____opt_2792 ~= nil then
            ____opt_2792 = ____opt_2792.atualizar
        end
        if ____opt_2792 ~= nil then
            ____opt_2792(____opt_2792, dt)
        end
        for ____, a in __iterar((__L1.afterimages)) do
            a.life = a.life - dt
        end
        __L1.afterimages = __call(
            __L1.afterimages,
            "filter",
            function(____, a) return __gt(a.life, 0) end
        )
        for ____, p in __iterar((__L1.particles)) do
            p.x = p.x + p.vx * dt
            p.y = p.y + p.vy * dt
            p.vy = p.vy + 180 * dt
            p.life = p.life - dt
        end
        __L1.particles = __call(
            __L1.particles,
            "filter",
            function(____, p) return __gt(p.life, 0) end
        )
        for ____, d in __iterar((__L1.damageTexts)) do
            d.y = d.y - dt * 30
            d.life = d.life - dt
        end
        __L1.damageTexts = __call(
            __L1.damageTexts,
            "filter",
            function(____, d) return __gt(d.life, 0) end
        )
        __L1.shake = math.max(0, __L1.shake - 28 * dt)
        __L1.hitFlash = math.max(0, __L1.hitFlash - dt)
    end
    __L1.text = function(self, t, x, y, size, color, align)
        if size == nil then
            size = 13
        end
        if color == nil then
            color = "#fff0d0"
        end
        if align == nil then
            align = "center"
        end
        __L1.ctx.font = ("bold " .. tostring(size)) .. "px monospace"
        __L1.ctx.textAlign = align
        __L1.ctx.textBaseline = "middle"
        __L1.ctx.fillStyle = "#172b26"
        __L1.ctx:fillText(t, x + 2, y + 2)
        __L1.ctx.fillStyle = color
        __L1.ctx:fillText(t, x, y)
    end
    __L1.pill = function(self, t, x, y, color)
        if color == nil then
            color = "#eed09a"
        end
        local width = __len(t) * 7.8 + 22
        __L1.ctx.fillStyle = "#1c342de8"
        __L1.ctx:fillRect(x - width / 2, y - 13, width, 26)
        __L1.ctx.strokeStyle = "#47604b"
        __L1.ctx:strokeRect(x - width / 2 + 0.5, y - 12.5, width - 1, 25)
        __L1:text(
            t,
            x,
            y,
            12,
            color
        )
    end
    __L1.sprite = function(self, ____type, x, y, opt)
        if opt == nil then
            opt = {}
        end
        local ____t_2799 = __t
        local ____t_result_2798
        local ____t_2795 = __t
        local ____temp_2794 = ____type == "swift"
        __O[2052] = ____temp_2794
        if ____t_2795(____temp_2794) then
            local ____opt_2796 = window.SwiftGuide
            if ____opt_2796 ~= nil then
                ____opt_2796 = ____opt_2796.draw
            end
            ____t_result_2798 = ____opt_2796
        else
            ____t_result_2798 = __O[2052]
        end
        if ____t_2799(____t_result_2798) then
            window.SwiftGuide:draw(__L1.ctx, x, y, opt)
            return
        end
        local ____t_2802 = __t
        local ____opt_2800 = window.Art
        if ____opt_2800 ~= nil then
            ____opt_2800 = ____opt_2800.drawCharacter
        end
        if ____t_2802(____opt_2800) then
            window.Art:drawCharacter(
                __L1.ctx,
                ____type,
                x,
                y,
                opt
            )
        else
            __L1.ctx.fillStyle = ____type == "daroca" and "#f0b45d" or "#b29d70"
            __L1.ctx:fillRect(x - 13, y - 39, 26, 39)
        end
    end
    __L1.drawSewerMarker = function(self, x, destination)
        __L1.ctx:save()
        __L1.ctx.fillStyle = __t(destination) and "#eee2a680" or "#172e29"
        __L1.ctx:beginPath()
        __L1.ctx:ellipse(
            x,
            __L1.FLOOR - 5,
            38,
            8,
            0,
            0,
            math.pi * 2
        )
        __call(__L1.ctx, "fill")
        __L1.ctx.strokeStyle = __t(destination) and "#f5c477" or "#70836b"
        __L1.ctx.lineWidth = 3
        __L1.ctx:stroke()
        do
            local i = -2
            while i <= 2 do
                __L1.ctx.fillStyle = __t(destination) and "#eec98c" or "#52665a"
                __L1.ctx:fillRect(x + i * 10 - 2, __L1.FLOOR - 10, 4, 10)
                i = i + 1
            end
        end
        __L1.ctx:restore()
        if __t(destination) then
            __L1:pill("VAI SAIR AQUI!", x, __L1.FLOOR - 40, "#ffe2a6")
        end
    end
    __L1.drawIraciTrap = function(self)
        local ____t_2809 = __t
        local ____t_result_2808
        local ____t_2806 = __t
        local ____t_result_2805
        local ____t_2804 = __t
        local ____temp_2803 = __L1.scene ~= 1
        __O[2053] = ____temp_2803
        if ____t_2804(____temp_2803) then
            ____t_result_2805 = __O[2053]
        else
            ____t_result_2805 = __L1.q.kaique
        end
        __O[2054] = ____t_result_2805
        if ____t_2806(____t_result_2805) then
            ____t_result_2808 = __O[2054]
        else
            local ____t_result_2807
            if __t(__L1.arena) then
                ____t_result_2807 = __L1.arena.type ~= "kaique"
            else
                ____t_result_2807 = __L1.arena
            end
            ____t_result_2808 = ____t_result_2807
        end
        if ____t_2809(____t_result_2808) then
            return
        end
        local ____iter_2819 = __iter
        local ____t_result_2818
        local ____t_2817 = __t
        local ____opt_2815 = window.WorldData
        if ____opt_2815 ~= nil then
            ____opt_2815 = ____opt_2815.iraciTraps
        end
        __O[2055] = ____opt_2815
        if ____t_2817(____opt_2815) then
            ____t_result_2818 = __O[2055]
        else
            ____t_result_2818 = __arrL({}, 0)
        end
        for ____, trap in __TS__Iterator(____iter_2819(____t_result_2818)) do
            __L1.ctx:save()
            local ____t_result_2814
            local ____t_2813 = __t
            local ____opt_2810 = __L1.activeBoss
            if ____opt_2810 ~= nil then
                ____opt_2810 = ____opt_2810.type
            end
            local ____temp_2812 = ____opt_2810 == "kaique"
            __O[2056] = ____temp_2812
            if ____t_2813(____temp_2812) then
                ____t_result_2814 = __L1.activeBoss.iraciTriggered
            else
                ____t_result_2814 = __O[2056]
            end
            local angry = ____t_result_2814
            __L1.ctx.fillStyle = __t(angry) and "#af5e62" or "#927596"
            __L1.ctx:fillRect(trap.x - trap.width / 2, __L1.FLOOR - 6, trap.width, 12)
            __L1.ctx.strokeStyle = "#f1cfac"
            __L1.ctx.lineWidth = 2
            __L1.ctx:strokeRect(trap.x - trap.width / 2 + 0.5, __L1.FLOOR - 6.5, trap.width - 1, 12)
            __L1.ctx.font = "bold 11px monospace"
            __L1.ctx.textAlign = "center"
            __L1.ctx.fillStyle = "#fff0cc"
            __L1.ctx:fillText("IRACI", trap.x, __L1.FLOOR + 4)
            __L1.ctx:restore()
        end
    end
    __L1.drawSchoolWatch = function(self)
        if __L1.scene ~= 1 then
            return
        end
        __L1:drawIraciTrap()
        for ____, e in __iterar((__L1.enemies)) do
            do
                if __t(not __t(__L1:isSchoolMonitor(e)) or __le(e.hp, 0)) then
                    continue
                end
                local ____t_result_2820
                if __t(e.monitorDir) then
                    ____t_result_2820 = e.monitorDir
                else
                    ____t_result_2820 = -1
                end
                local d = ____t_result_2820
                local reach = 300
                local ____iter_2825 = __iter
                local ____t_result_2824
                local ____t_2823 = __t
                local ____opt_2821 = window.WorldData
                if ____opt_2821 ~= nil then
                    ____opt_2821 = ____opt_2821.schoolCovers
                end
                __O[2057] = ____opt_2821
                if ____t_2823(____opt_2821) then
                    ____t_result_2824 = __O[2057]
                else
                    ____t_result_2824 = __arrL({}, 0)
                end
                for ____, cover in __TS__Iterator(____iter_2825(____t_result_2824)) do
                    local distance = (cover.x - e.x) * d - cover.width / 2
                    if __t(distance > 0 and distance < reach) then
                        reach = distance
                    end
                end
                local eye = __L1.FLOOR - (e.type == "igor" and 74 or 92)
                local center = eye + (__L1.FLOOR - 40 - eye) * reach / 300
                local half = 18 + reach * 0.15
                __L1.ctx:save()
                __L1.ctx.globalAlpha = __gt(e.monitorSuspicion, 0.6) and 0.25 or 0.13
                __L1.ctx.fillStyle = __gt(e.monitorSuspicion, 0.6) and "#eb977e" or "#e9d88e"
                __L1.ctx:beginPath()
                __L1.ctx:moveTo(e.x, eye - 18)
                __L1.ctx:lineTo(e.x + d * reach, center - half)
                __L1.ctx:lineTo(
                    e.x + d * reach,
                    math.min(__L1.FLOOR - 3, center + half)
                )
                __L1.ctx:lineTo(e.x, eye + 18)
                __L1.ctx:closePath()
                __call(__L1.ctx, "fill")
                __L1.ctx.strokeStyle = "#ffe6a7"
                __L1.ctx.lineWidth = 1
                __L1.ctx:stroke()
                __L1.ctx:restore()
                if __gt(e.monitorSuspicion, 0) then
                    __L1.ctx.fillStyle = "#304851"
                    __L1.ctx:fillRect(e.x - 35, __L1.FLOOR - 126, 70, 7)
                    __L1.ctx.fillStyle = __gt(e.monitorSuspicion, 0.7) and "#e39a80" or "#e4c77d"
                    __L1.ctx:fillRect(e.x - 34, __L1.FLOOR - 125, 68 * e.monitorSuspicion / 1.2, 5)
                    __L1:pill(
                        __gt(e.monitorSuspicion, 0.7) and "TE VI, DA ROÇA!" or "QUEM TÁ NO CORREDOR?",
                        e.x,
                        __L1.FLOOR - 147,
                        "#ffe0a4"
                    )
                end
            end
        end
    end
    __L1.drawSchoolCover = function(self)
        local ____t_2829 = __t
        local ____t_result_2828
        local ____t_2827 = __t
        local ____temp_2826 = __L1.scene ~= 1
        __O[2058] = ____temp_2826
        if ____t_2827(____temp_2826) then
            ____t_result_2828 = __O[2058]
        else
            ____t_result_2828 = __L1.arena
        end
        if ____t_2829(____t_result_2828) then
            return
        end
        local ____iter_2834 = __iter
        local ____t_result_2833
        local ____t_2832 = __t
        local ____opt_2830 = window.WorldData
        if ____opt_2830 ~= nil then
            ____opt_2830 = ____opt_2830.schoolCovers
        end
        __O[2059] = ____opt_2830
        if ____t_2832(____opt_2830) then
            ____t_result_2833 = __O[2059]
        else
            ____t_result_2833 = __arrL({}, 0)
        end
        for ____, cover in __TS__Iterator(____iter_2834(____t_result_2833)) do
            local hiding = math.abs(__L1.player.x - cover.x) < cover.width / 2 + 10 and __gt(__L1.player.y, __L1.FLOOR - 95)
            __L1.ctx:save()
            __L1.ctx.globalAlpha = __t(hiding) and 0.65 or 1
            __L1.ctx.fillStyle = "#294e70"
            __L1.ctx:fillRect(cover.x - cover.width / 2, __L1.FLOOR - 111, cover.width, 111)
            __L1.ctx.fillStyle = "#90b9be"
            __L1.ctx:fillRect(cover.x - cover.width / 2 + 3, __L1.FLOOR - 108, cover.width - 6, 105)
            do
                local i = 0
                while i < 2 do
                    local x = cover.x - cover.width / 2 + 5 + i * (cover.width - 10) / 2
                    __L1.ctx.fillStyle = "#51809a"
                    __L1.ctx:fillRect(x, __L1.FLOOR - 105, (cover.width - 14) / 2, 100)
                    __L1.ctx.fillStyle = "#d7dbc6"
                    __L1.ctx:fillRect(x + 5, __L1.FLOOR - 74, 7, 3)
                    __L1.ctx.fillStyle = "#264e69"
                    do
                        local j = 0
                        while j < 3 do
                            __L1.ctx:fillRect(x + 4, __L1.FLOOR - 96 + j * 5, 15, 2)
                            j = j + 1
                        end
                    end
                    i = i + 1
                end
            end
            __L1.ctx:restore()
            __L1:pill(
                __t(hiding) and "ESCONDIDO" or "ABRIGO",
                cover.x,
                __L1.FLOOR + 25,
                __t(hiding) and "#d4edaa" or "#c2d7d0"
            )
        end
    end
    __L1.drawBossTelegraphs = function(self)
        local ____t_2837 = __t
        local ____opt_2835 = __L1.activeBoss
        if ____opt_2835 ~= nil then
            ____opt_2835 = ____opt_2835.conquista
        end
        if ____t_2837(____opt_2835) then
            local f = __L1.activeBoss.conquista
            if f.estado == "windup" then
                local ____L1_pill_2842 = __L1.pill
                local ____array_2841 = __TS__SparseArrayNew(
                    window.ConquistaCombate:titulo(f),
                    __L1:clamp(f.x, __L1.camera + 110, __L1.camera + __L1.W - 110),
                    math.max(
                        88,
                        f.y - (__t(f.fase == 2 and f.slug == "jorge") and 150 or 111)
                    )
                )
                local ____t_result_2840
                local ____t_2839 = __t
                local ____getq_result_2838 = __getq(
                    window.ConquistaCombate:capitulo(f),
                    2
                )
                __O[2060] = ____getq_result_2838
                if ____t_2839(____getq_result_2838) then
                    ____t_result_2840 = __O[2060]
                else
                    ____t_result_2840 = __get(window.ConquistaCombate.chefes, f.slug).cor
                end
                __TS__SparseArrayPush(____array_2841, ____t_result_2840)
                ____L1_pill_2842(
                    __L1,
                    __TS__SparseArraySpread(____array_2841)
                )
            end
            if f.estado == "recover" then
                __L1:pill(
                    "ABERTURA!",
                    f.x,
                    math.max(88, f.y - 118),
                    "#cfefab"
                )
            end
            return
        end
        local ____opt_2843 = __L1.activeBoss
        if ____opt_2843 ~= nil then
            ____opt_2843 = ____opt_2843.type
        end
        if ____opt_2843 == "kaique" then
            __L1:drawIraciTrap()
        end
        for ____, h in __iterar((__L1.hazards)) do
            __L1:drawHazardPixel(h)
            if __gt(h.delay, 0) then
                __L1:pill("!", h.x, __L1.FLOOR - 34, "#ffe1a0")
            end
        end
        local e = __L1.activeBoss
        if not __t(e) then
            return
        end
        if e.state == "phaseChange" then
            __L1:drawPhaseFlames(e)
            local ____L1_pill_2852 = __L1.pill
            local ____add_2851 = __add
            local ____add_result_2850 = __add(
                __add("FASE ", e.phase),
                " · "
            )
            local ____t_result_2849
            local ____t_2848 = __t
            local ____t_result_2847
            local ____t_2846 = __t
            local ____get_result_2845 = __get(__L1.nikolasPhaseWarnings, e.kind)
            __O[2061] = ____get_result_2845
            if ____t_2846(____get_result_2845) then
                ____t_result_2847 = __O[2061]
            else
                ____t_result_2847 = __get(__L1.bossPhaseSkillNames, e.kind)
            end
            __O[2062] = ____t_result_2847
            if ____t_2848(____t_result_2847) then
                ____t_result_2849 = __O[2062]
            else
                ____t_result_2849 = "NOVA HABILIDADE"
            end
            ____L1_pill_2852(
                __L1,
                ____add_2851(____add_result_2850, ____t_result_2849),
                e.x,
                __L1:bossCaptionY(e),
                "#ffe4ad"
            )
            return
        end
        local ____t_2856 = __t
        local ____t_result_2855
        local ____t_2854 = __t
        local ____temp_2853 = e.kind == "sewerDive"
        __O[2063] = ____temp_2853
        if ____t_2854(____temp_2853) then
            ____t_result_2855 = e.state == "windup" or e.state == "underground"
        else
            ____t_result_2855 = __O[2063]
        end
        if ____t_2856(____t_result_2855) then
            __L1:drawSewerMarker(e.emergeX, true)
        end
        if e.state == "underground" then
            local ____L1_pill_2858 = __L1.pill
            local ____e_diveFromX_2857 = e.diveFromX
            if ____e_diveFromX_2857 == nil then
                ____e_diveFromX_2857 = e.x
            end
            ____L1_pill_2858(
                __L1,
                "NO ESGOTO · PREPARE O ATAQUE",
                ____e_diveFromX_2857,
                __L1.FLOOR - 95,
                "#dbe0aa"
            )
        end
        if e.state == "concealed" then
            __L1:pill("FUMAÇA! OBSERVE A SILHUETA", e.x, e.y - 125, "#e1e7df")
        end
        if e.state == "windup" then
            __L1.ctx:save()
            __L1.ctx.strokeStyle = "#f4b878"
            __L1.ctx.lineWidth = e.kind == "dash" and 6 or 2
            __L1.ctx.globalAlpha = 0.4 + math.sin(__L1.time * 19) * 0.2
            __L1.ctx:beginPath()
            if e.kind == "dash" then
                __L1.ctx:moveTo(e.x, __L1.FLOOR - 8)
                __L1.ctx:lineTo(
                    e.x + __TS__MathSign(e.targetX - e.x) * 330,
                    __L1.FLOOR - 8
                )
            else
                __L1.ctx:moveTo(e.x, e.y - 40)
                __L1.ctx:lineTo(e.targetX, e.targetY)
                __L1.ctx:moveTo(e.targetX - 28, e.targetY - 28)
                __L1.ctx:lineTo(e.targetX + 28, e.targetY + 28)
                __L1.ctx:moveTo(e.targetX + 28, e.targetY - 28)
                __L1.ctx:lineTo(e.targetX - 28, e.targetY + 28)
            end
            __L1.ctx:stroke()
            __L1.ctx:restore()
            local ____L1_pill_2891 = __L1.pill
            local ____t_result_2890
            local ____t_2862 = __t
            local ____t_result_2861
            local ____t_2860 = __t
            local ____get_result_2859 = __get(__L1.nikolasPhaseWarnings, e.kind)
            __O[2064] = ____get_result_2859
            if ____t_2860(____get_result_2859) then
                ____t_result_2861 = __O[2064]
            else
                ____t_result_2861 = __get(__L1.bossPhaseSkillNames, e.kind)
            end
            __O[2066] = ____t_result_2861
            if ____t_2862(____t_result_2861) then
                ____t_result_2890 = __O[2066]
            else
                local ____temp_2889
                if e.kind == "bellyBounce" then
                    ____temp_2889 = "BARRIGA NO AR! SAIA DA MARCA"
                else
                    local ____temp_2888
                    if e.kind == "bellyRoll" then
                        ____temp_2888 = "BARRIGA ROLANDO! USE AS PASSARELAS"
                    else
                        local ____temp_2887
                        if e.kind == "bellyClap" then
                            ____temp_2887 = "ONDA DA BARRIGA! PULE"
                        else
                            local ____temp_2886
                            if e.kind == "monitorBurst" then
                                ____temp_2886 = "RAJADA! ALVO TRAVADO"
                            else
                                local ____temp_2885
                                if e.kind == "monitorSweep" then
                                    ____temp_2885 = "TIROS RASANTES! PULE"
                                else
                                    local ____temp_2884
                                    if e.kind == "monitorReload" then
                                        ____temp_2884 = "RECARREGANDO! PREPARE O ATAQUE"
                                    else
                                        local ____temp_2883
                                        if e.kind == "sewerDive" then
                                            ____temp_2883 = "ESGOTO! OLHE A SAÍDA"
                                        else
                                            local ____temp_2882
                                            if e.kind == "ratsArmy" then
                                                ____temp_2882 = "EXÉRCITO DE RATOS!"
                                            else
                                                local ____temp_2881
                                                if e.kind == "cloudMines" then
                                                    ____temp_2881 = "FUMAÇA NO CHÃO! DESVIE"
                                                else
                                                    local ____temp_2880
                                                    if e.kind == "bitucas" then
                                                        ____temp_2880 = "BITUCAS ACESAS! SAIA DAS BRASAS"
                                                    else
                                                        local ____temp_2879
                                                        if e.kind == "tragada" then
                                                            ____temp_2879 = "TRAGADA FUNDA! PULE A BAFORADA"
                                                        else
                                                            local ____temp_2878
                                                            if e.kind == "cinzas" then
                                                                ____temp_2878 = "CHUVA DE CINZA! SAIA DAS MARCAS"
                                                            else
                                                                local ____temp_2877
                                                                if e.kind == "smokeVeil" then
                                                                    ____temp_2877 = "CORTINA DE FUMAÇA!"
                                                                else
                                                                    local ____t_result_2876
                                                                    if __t(e.kind == "sketchSwarm" or e.kind == "brainrots") then
                                                                        ____t_result_2876 = "DESENHOS GANHANDO VIDA!"
                                                                    else
                                                                        local ____temp_2875
                                                                        if e.kind == "sketchLine" then
                                                                            ____temp_2875 = "RISCO NO CHÃO! PULE!"
                                                                        else
                                                                            local ____temp_2874
                                                                            if e.kind == "inkSlam" then
                                                                                ____temp_2874 = "ONDA DE TINTA! PULE!"
                                                                            else
                                                                                local ____temp_2873
                                                                                if e.kind == "poseWave" then
                                                                                    ____temp_2873 = "ONDA DA POSE! PULE!"
                                                                                else
                                                                                    local ____temp_2872
                                                                                    if e.kind == "dash" then
                                                                                        ____temp_2872 = "INVESTIDA! USE DASH"
                                                                                    else
                                                                                        local ____temp_2871
                                                                                        if e.kind == "skyLances" then
                                                                                            ____temp_2871 = "RAIOS! SAIA DAS MARCAS"
                                                                                        else
                                                                                            local ____t_result_2870
                                                                                            if __t(e.kind == "supremeRing" or e.kind == "stomp") then
                                                                                                ____t_result_2870 = "ONDA NO CHÃO! PULE!"
                                                                                            else
                                                                                                local ____temp_2869
                                                                                                if e.kind == "astralFan" then
                                                                                                    ____temp_2869 = "ORBITAIS! DESVIE!"
                                                                                                else
                                                                                                    local ____temp_2868
                                                                                                    if e.kind == "mines" then
                                                                                                        ____temp_2868 = "SAIA DAS MARCAS!"
                                                                                                    else
                                                                                                        local ____temp_2867
                                                                                                        if e.kind == "slimeRain" then
                                                                                                            ____temp_2867 = "CHUVA DE CATARRO!"
                                                                                                        else
                                                                                                            local ____t_2866 = __t
                                                                                                            local ____t_result_2865
                                                                                                            local ____t_2864 = __t
                                                                                                            local ____temp_2863 = e.type == "nikolas" and e.kind == "slimeFan"
                                                                                                            __O[2065] = ____temp_2863
                                                                                                            if ____t_2864(____temp_2863) then
                                                                                                                ____t_result_2865 = e.phase == 3
                                                                                                            else
                                                                                                                ____t_result_2865 = __O[2065]
                                                                                                            end
                                                                                                            ____temp_2867 = ____t_2866(____t_result_2865) and "DUAS RAJADAS! DESVIE DUAS VEZES" or "ATAQUE CARREGANDO!"
                                                                                                        end
                                                                                                        ____temp_2868 = ____temp_2867
                                                                                                    end
                                                                                                    ____temp_2869 = ____temp_2868
                                                                                                end
                                                                                                ____t_result_2870 = ____temp_2869
                                                                                            end
                                                                                            ____temp_2871 = ____t_result_2870
                                                                                        end
                                                                                        ____temp_2872 = ____temp_2871
                                                                                    end
                                                                                    ____temp_2873 = ____temp_2872
                                                                                end
                                                                                ____temp_2874 = ____temp_2873
                                                                            end
                                                                            ____temp_2875 = ____temp_2874
                                                                        end
                                                                        ____t_result_2876 = ____temp_2875
                                                                    end
                                                                    ____temp_2877 = ____t_result_2876
                                                                end
                                                                ____temp_2878 = ____temp_2877
                                                            end
                                                            ____temp_2879 = ____temp_2878
                                                        end
                                                        ____temp_2880 = ____temp_2879
                                                    end
                                                    ____temp_2881 = ____temp_2880
                                                end
                                                ____temp_2882 = ____temp_2881
                                            end
                                            ____temp_2883 = ____temp_2882
                                        end
                                        ____temp_2884 = ____temp_2883
                                    end
                                    ____temp_2885 = ____temp_2884
                                end
                                ____temp_2886 = ____temp_2885
                            end
                            ____temp_2887 = ____temp_2886
                        end
                        ____temp_2888 = ____temp_2887
                    end
                    ____temp_2889 = ____temp_2888
                end
                ____t_result_2890 = ____temp_2889
            end
            ____L1_pill_2891(
                __L1,
                ____t_result_2890,
                e.x,
                __L1:bossCaptionY(e),
                "#ffd096"
            )
        end
        local ____t_2897 = __t
        local ____t_result_2896
        local ____t_2895 = __t
        local ____t_result_2894
        local ____t_2893 = __t
        local ____temp_2892 = e.type == "nikolas" and e.phase == 4
        __O[2067] = ____temp_2892
        if ____t_2893(____temp_2892) then
            ____t_result_2894 = __gt(e.safeLaneTime, 0)
        else
            ____t_result_2894 = __O[2067]
        end
        __O[2068] = ____t_result_2894
        if ____t_2895(____t_result_2894) then
            ____t_result_2896 = __isFiniteN(e.safeLaneX)
        else
            ____t_result_2896 = __O[2068]
        end
        if ____t_2897(____t_result_2896) then
            __L1.ctx:save()
            __L1.ctx.fillStyle = "#b9edbd24"
            __L1.ctx.strokeStyle = "#c8f3b3"
            __L1.ctx.lineWidth = 2
            __L1.ctx:fillRect(e.safeLaneX - e.safeLaneWidth / 2, 105, e.safeLaneWidth, __L1.FLOOR - 105)
            __L1.ctx:strokeRect(e.safeLaneX - e.safeLaneWidth / 2, 105, e.safeLaneWidth, __L1.FLOOR - 105)
            __L1.ctx:restore()
            __L1:pill("FAIXA SEGURA", e.safeLaneX, __L1.FLOOR - 44, "#d7f2b7")
        end
        if e.state == "monitorTransform" then
            __L1:pill(
                e.type == "igor" and "A BARRIGA ESTÁ CRESCENDO!" or (__t(e.rage) and "FÚRIA DE IRACI!" or "FISCALIZAÇÃO EM POSIÇÃO!"),
                e.x,
                __L1:bossCaptionY(e),
                __t(e.rage) and "#ffb7ae" or "#ffe1a0"
            )
        end
        if e.state == "bellyAir" then
            local ____L1_clamp_2900 = __L1.clamp
            local ____e_stateTimer_2899 = e.stateTimer
            local ____t_result_2898
            if __t(e.bellyDuration) then
                ____t_result_2898 = e.bellyDuration
            else
                ____t_result_2898 = 1
            end
            local k = ____L1_clamp_2900(__L1, 1 - ____e_stateTimer_2899 / ____t_result_2898, 0, 1)
            local w = math.floor(40 + k * 65 + 0.5)
            __L1.ctx:save()
            __L1.ctx.globalAlpha = 0.3 + 0.35 * k
            do
                local i = -w
                while i <= w do
                    local h = math.floor(math.sqrt(math.max(0, 1 - (i / w) ^ 2)) * (4 + k * 4) + 0.5)
                    __L1.ctx.fillStyle = math.abs(i) < w * 0.6 and "#2a1a10" or "#4a3020"
                    __L1.ctx:fillRect(
                        math.floor(e.bellyTo + i + 0.5),
                        __L1.FLOOR - 3 - h / 2,
                        4,
                        math.max(2, h)
                    )
                    i = i + 4
                end
            end
            __L1.ctx.globalAlpha = 0.55 + 0.45 * math.abs(math.sin(__L1.time * 12))
            __L1.ctx.fillStyle = "#ffd27a"
            for ____, d in __iterar((__arrL({-1, 1}, 2))) do
                local ax = e.bellyTo + d * (w + 10)
                __L1.ctx:fillRect(ax - 2, __L1.FLOOR - 14, 4, 8)
                __L1.ctx:fillRect(ax - (d > 0 and 6 or -2), __L1.FLOOR - 10, 4, 4)
            end
            __L1.ctx:restore()
        end
        if e.state == "recover" then
            __L1:pill(
                e.type == "kaique" and "RECARREGANDO! ATAQUE!" or "VULNERÁVEL! ATAQUE!",
                e.x,
                __L1:bossCaptionY(e),
                "#d3ed9e"
            )
        end
    end
    __L1.drawReeis = function(self)
        if __L1.reeisPhase == "idle" then
            return
        end
        local transformed = __L1.reeisPhase == "active" or __L1.reeisPhase == "burst"
        local ____L1_sprite_2913 = __L1.sprite
        local ____L1_reeisX_2911 = __L1.reeisX
        local ____L1_reeisY_2912 = __L1.reeisY
        local ____L1_reeisFacing_2905 = __L1.reeisFacing
        local ____L1_time_2906 = __L1.time
        local ____transformed_2907 = transformed
        local ____temp_2908 = __L1.reeisPhase ~= "running"
        local ____temp_2909 = __L1.reeisPhase == "charging"
        local ____t_result_2903
        local ____t_2902 = __t
        local ____temp_2901 = __L1.reeisPhase == "running"
        __O[2069] = ____temp_2901
        if ____t_2902(____temp_2901) then
            ____t_result_2903 = __O[2069]
        else
            ____t_result_2903 = __L1.reeisPhase == "active" and math.abs(__L1.player.vx) > 8
        end
        local ____temp_2910 = __L1.reeisPhase == "running" and 430 or math.abs(__L1.player.vx)
        local ____temp_2904
        if __L1.reeisPhase == "active" then
            ____temp_2904 = __L1.player.ground
        else
            ____temp_2904 = true
        end
        ____L1_sprite_2913(
            __L1,
            "reeis",
            ____L1_reeisX_2911,
            ____L1_reeisY_2912,
            {
                facing = ____L1_reeisFacing_2905,
                frame = ____L1_time_2906,
                transformed = ____transformed_2907,
                powered = transformed,
                aura = ____temp_2908,
                charging = ____temp_2909,
                moving = ____t_result_2903,
                speed = ____temp_2910,
                grounded = ____temp_2904,
                vy = __L1.player.vy,
                attack = __L1.reeisPhase == "active" and not not __t(__L1.activeBoss),
                attackType = "gun",
                attackProgress = __mod(__L1.time / 0.42, 1)
            }
        )
        if __L1.reeisPhase == "charging" then
            __L1:pill("O PODER DA RESENHA!", __L1.reeisX, __L1.reeisY - 120, "#ffe39a")
        end
        if __L1.reeisPhase == "burst" then
            __L1.ctx:save()
            __L1.ctx.strokeStyle = "#ffe2a0"
            __L1.ctx.lineWidth = 5
            __L1.ctx.globalAlpha = math.max(0, __L1.reeisPhaseTimer / 0.35)
            __L1.ctx:beginPath()
            __L1.ctx:arc(
                __L1.reeisX,
                __L1.reeisY - 45,
                (1 - __L1.reeisPhaseTimer / 0.35) * 230 + 35,
                0,
                math.pi * 2
            )
            __L1.ctx:stroke()
            __L1.ctx:restore()
        end
    end
    __L1.drawRouteTransition = function(self)
        local r = __L1.routeTransition
        if not __t(r) then
            return
        end
        local ____t_2915 = __t
        local ____t_result_2914
        if __t(r.estrada) then
            ____t_result_2914 = window.EstradaViagem
        else
            ____t_result_2914 = r.estrada
        end
        if ____t_2915(____t_result_2914) then
            window.EstradaViagem:desenhar(
                __L1.ctx,
                {
                    t = r.t,
                    dur = r.duration,
                    de = r.from,
                    para = r.to,
                    nomes = __L1.scenes,
                    time = __L1.time,
                    W = __L1.W,
                    H = __L1.H,
                    carro = function(____, c, x, y)
                        local ____t_2918 = __t
                        local ____opt_2916 = window.Art
                        if ____opt_2916 ~= nil then
                            ____opt_2916 = ____opt_2916.drawVehicle
                        end
                        if ____t_2918(____opt_2916) then
                            c:save()
                            c:translate(
                                math.floor(x + 0.5),
                                0
                            )
                            window.Art:drawVehicle(c, 0, y, __L1.time)
                            c:restore()
                        end
                        local ____t_2921 = __t
                        local ____opt_2919 = window.Art
                        if ____opt_2919 ~= nil then
                            ____opt_2919 = ____opt_2919.drawCharacter
                        end
                        if ____t_2921(____opt_2919) then
                            window.Art:drawCharacter(
                                c,
                                "daroca",
                                x + 4,
                                y - 22,
                                __assign(
                                    {},
                                    __L1:playerSpriteOptions(0.8),
                                    {facing = 1, moving = false, attack = false}
                                )
                            )
                        end
                    end
                }
            )
            return
        end
        __L1.ctx.fillStyle = "#203e37"
        __L1.ctx:fillRect(0, 0, __L1.W, __L1.H)
        local ____t_2924 = __t
        local ____opt_2922 = window.Art
        if ____opt_2922 ~= nil then
            ____opt_2922 = ____opt_2922.drawScene
        end
        if ____t_2924(____opt_2922) then
            window.Art:drawScene(
                __L1.ctx,
                0,
                __mod(r.t * 630, 1640),
                __L1.time
            )
        end
        __L1.ctx.fillStyle = "#18352bc4"
        __L1.ctx:fillRect(0, 0, __L1.W, __L1.H)
        __L1.ctx.fillStyle = "#55645d"
        __L1.ctx:fillRect(0, 350, __L1.W, 190)
        __L1.ctx.fillStyle = "#b5b194"
        __L1.ctx:fillRect(0, 348, __L1.W, 6)
        do
            local i = -1
            while i < 10 do
                local x = __mod(i * 160 - r.t * 800, 1700)
                __L1.ctx.fillStyle = "#d6d2ae"
                __L1.ctx:fillRect(x, 455, 90, 7)
                i = i + 1
            end
        end
        local ____t_2927 = __t
        local ____opt_2925 = window.Art
        if ____opt_2925 ~= nil then
            ____opt_2925 = ____opt_2925.drawVehicle
        end
        if ____t_2927(____opt_2925) then
            window.Art:drawVehicle(__L1.ctx, 480, 390, __L1.time)
        end
        __L1:sprite("daroca", 485, 366, {
            facing = 1,
            frame = __L1.time,
            scale = 0.8,
            muscular = __L1.q.trained,
            moving = false,
            grounded = false,
            flight = true
        })
        __L1:text(
            "NO CARRO A GÁS DO PAI",
            480,
            110,
            15,
            "#d3dfae"
        )
        local ____L1_text_2940 = __L1.text
        local ____add_2939 = __add
        local ____call_2938 = __call
        local ____t_result_2937
        local ____t_2936 = __t
        local ____t_result_2935
        local ____t_2929 = __t
        local ____get_result_2928 = __get(__L1.scenes, r.to)
        __O[2070] = ____get_result_2928
        if ____t_2929(____get_result_2928) then
            ____t_result_2935 = __O[2070]
        else
            local ____opt_2932 = window.LugaresC1
            if ____opt_2932 ~= nil then
                ____opt_2932 = ____opt_2932.nome
            end
            local ____opt_result_2934
            if ____opt_2932 ~= nil then
                ____opt_result_2934 = ____opt_2932(____opt_2932, r.to)
            end
            ____t_result_2935 = ____opt_result_2934
        end
        __O[2071] = ____t_result_2935
        if ____t_2936(____t_result_2935) then
            ____t_result_2937 = __O[2071]
        else
            ____t_result_2937 = ""
        end
        ____L1_text_2940(
            __L1,
            ____add_2939(
                "PRÓXIMA PARADA: ",
                ____call_2938(____t_result_2937, "toUpperCase")
            ),
            480,
            158,
            24,
            "#ffe2a7"
        )
        __L1:text(
            "Vruuum… o combustível é por nossa conta.",
            480,
            205,
            13,
            "#d8dfc3"
        )
        local progress = __L1:clamp(r.t / r.duration, 0, 1)
        __L1.ctx.fillStyle = "#283f35"
        __L1.ctx:fillRect(280, 260, 400, 8)
        __L1.ctx.fillStyle = "#efcb87"
        __L1.ctx:fillRect(280, 260, 400 * progress, 8)
    end
    __L1.drawRoomFrame = function(self)
        local r = __L1.room
        if r.phase ~= "inside" then
            local ____t_2943 = __t
            local ____opt_2941 = window.Art
            if ____opt_2941 ~= nil then
                ____opt_2941 = ____opt_2941.drawScene
            end
            if ____t_2943(____opt_2941) then
                window.Art:drawScene(__L1.ctx, __L1.scene, r.exteriorCamera, __L1.time)
            else
                __L1.ctx.fillStyle = "#7d9277"
                __L1.ctx:fillRect(0, 0, __L1.W, __L1.H)
            end
            __L1:sprite(
                "daroca",
                r.returnX - r.exteriorCamera,
                __L1.FLOOR,
                __assign(
                    {},
                    __L1:playerSpriteOptions(),
                    {moving = false}
                )
            )
        end
        __L1.ctx:save()
        __L1.ctx.globalAlpha = r.blend
        local ____t_2949 = __t
        local ____opt_2946 = window.FavelaCasas
        if ____opt_2946 ~= nil then
            ____opt_2946 = ____opt_2946.ehCasa
        end
        local ____opt_result_2948
        if ____opt_2946 ~= nil then
            ____opt_result_2948 = ____opt_2946(____opt_2946, r.id)
        end
        if ____t_2949(____opt_result_2948) then
            window.FavelaCasas:desenhar(__L1.ctx, r.id, __L1.time)
        else
            local ____t_2952 = __t
            local ____opt_2950 = window.Art
            if ____opt_2950 ~= nil then
                ____opt_2950 = ____opt_2950.drawClassroom
            end
            if ____t_2952(____opt_2950) then
                window.Art:drawClassroom(__L1.ctx, r.id, __L1.time)
            else
                __L1.ctx.fillStyle = "#d5c6a0"
                __L1.ctx:fillRect(0, 0, __L1.W, __L1.H)
                __L1.ctx.fillStyle = "#354f42"
                __L1.ctx:fillRect(0, __L1.FLOOR, __L1.W, __L1.H - __L1.FLOOR)
            end
        end
        local px = r.phase == "entering" and 120 or __L1.player.x
        local ____temp_2953
        if r.phase == "entering" then
            ____temp_2953 = __L1.FLOOR
        else
            ____temp_2953 = __L1.player.y
        end
        local py = ____temp_2953
        __L1:sprite(
            "daroca",
            px,
            py,
            __L1:playerSpriteOptions()
        )
        local ____opt_2956 = window.FavelaCasas
        if ____opt_2956 ~= nil then
            ____opt_2956 = ____opt_2956.ehCasa
        end
        local ____opt_result_2958
        if ____opt_2956 ~= nil then
            ____opt_result_2958 = ____opt_2956(____opt_2956, r.id)
        end
        local casa = ____opt_result_2958
        local ____L1_sprite_2960 = __L1.sprite
        local ____t_result_2959
        if __t(casa) then
            ____t_result_2959 = window.FavelaCasas:morador(r.id)
        else
            ____t_result_2959 = r.id
        end
        ____L1_sprite_2960(
            __L1,
            ____t_result_2959,
            r.teacherX,
            __L1.FLOOR,
            {
                facing = -1,
                frame = __L1.time,
                moving = false,
                grounded = true,
                talking = not not __t(__L1.dialog)
            }
        )
        local ____L1_pill_2962 = __L1.pill
        local ____t_result_2961
        if __t(casa) then
            ____t_result_2961 = __call(
                window.FavelaCasas:nomeNpc(r.id),
                "toUpperCase"
            )
        else
            ____t_result_2961 = r.id == "almiro" and "PROFESSOR ALMIRO" or "PROFESSOR MIQUEIAS"
        end
        ____L1_pill_2962(
            __L1,
            ____t_result_2961,
            r.teacherX,
            __L1.FLOOR - 105,
            "#f1dba5"
        )
        if __t(r.phase == "inside" and not __t(__L1.dialog)) then
            if __t(math.abs(__L1.player.x - r.teacherX) < 105 and math.abs(__L1.player.y - __L1.FLOOR) < 100) then
                __L1:pill("[E] conversar", r.teacherX, __L1.FLOOR - 140, "#d5e6a4")
            end
            if math.abs(__L1.player.x - r.exitX) < 105 then
                __L1:pill(
                    __t(casa) and "[E] sair da casa" or "[E] sair da sala",
                    r.exitX,
                    __L1.FLOOR - 110,
                    "#f0d298"
                )
            end
        end
        __L1.ctx:restore()
    end
    __L1.drawMinions = function(self)
        for ____, m in __iterar((__L1.minions)) do
            do
                local ____t_2965 = __t
                local ____t_result_2964
                if __t(m.dead) then
                    ____t_result_2964 = m.dead
                else
                    local ____t_result_2963
                    if __t(__L1.arena) then
                        ____t_result_2963 = not __t(m.summoned)
                    else
                        ____t_result_2963 = __L1.arena
                    end
                    ____t_result_2964 = ____t_result_2963
                end
                if ____t_2965(____t_result_2964) then
                    continue
                end
                local ____t_2971 = __t
                local ____t_result_2970
                local ____t_2967 = __t
                local ____temp_2966 = m.type == "rat"
                __O[2072] = ____temp_2966
                if ____t_2967(____temp_2966) then
                    local ____opt_2968 = window.Art
                    if ____opt_2968 ~= nil then
                        ____opt_2968 = ____opt_2968.drawRat
                    end
                    ____t_result_2970 = ____opt_2968
                else
                    ____t_result_2970 = __O[2072]
                end
                if ____t_2971(____t_result_2970) then
                    window.Art:drawRat(
                        __L1.ctx,
                        m.x,
                        m.y,
                        __L1.time,
                        {
                            facing = m.dir,
                            hit = __gt(m.hit, 0)
                        }
                    )
                else
                    local ____t_2977 = __t
                    local ____t_result_2976
                    local ____t_2973 = __t
                    local ____temp_2972 = m.type == "thug" or m.kind == "thug"
                    __O[2073] = ____temp_2972
                    if ____t_2973(____temp_2972) then
                        local ____opt_2974 = window.Art
                        if ____opt_2974 ~= nil then
                            ____opt_2974 = ____opt_2974.drawThug
                        end
                        ____t_result_2976 = ____opt_2974
                    else
                        ____t_result_2976 = __O[2073]
                    end
                    if ____t_2977(____t_result_2976) then
                        window.Art:drawThug(
                            __L1.ctx,
                            m.x,
                            m.y,
                            __L1.time,
                            {
                                facing = __lt(__L1.player.x, m.x) and -1 or 1,
                                tier = m.tier,
                                weapon = m.weapon,
                                hit = __gt(m.hit, 0),
                                moving = false,
                                attack = not not __t(m.charging)
                            }
                        )
                    else
                        local ____t_2980 = __t
                        local ____opt_2978 = window.Art
                        if ____opt_2978 ~= nil then
                            ____opt_2978 = ____opt_2978.drawMinion
                        end
                        if ____t_2980(____opt_2978) then
                            local ____self_2989 = window.Art
                            local ____self_2989_drawMinion_2990 = ____self_2989.drawMinion
                            local ____array_2988 = __TS__SparseArrayNew(
                                __L1.ctx,
                                m.x,
                                m.y,
                                m.kind,
                                __L1.time
                            )
                            local ____m_dir_2984 = m.dir
                            local ____gt_result_2985 = __gt(m.hit, 0)
                            local ____temp_2986 = m.kind ~= 2
                            local ____temp_2987 = math.abs(m.x - __L1.player.x) < 360
                            local ____t_result_2983
                            local ____t_2982 = __t
                            local ____t_result_2981
                            if __t(m.design) then
                                ____t_result_2981 = m.design
                            else
                                ____t_result_2981 = m.variant
                            end
                            __O[2074] = ____t_result_2981
                            if ____t_2982(____t_result_2981) then
                                ____t_result_2983 = __O[2074]
                            else
                                ____t_result_2983 = m.type
                            end
                            __TS__SparseArrayPush(____array_2988, {
                                facing = ____m_dir_2984,
                                hit = ____gt_result_2985,
                                moving = ____temp_2986,
                                angry = ____temp_2987,
                                type = ____t_result_2983
                            })
                            ____self_2989_drawMinion_2990(
                                ____self_2989,
                                __TS__SparseArraySpread(____array_2988)
                            )
                        else
                            local ____t_2993 = __t
                            local ____opt_2991 = window.Art
                            if ____opt_2991 ~= nil then
                                ____opt_2991 = ____opt_2991.drawDoodle
                            end
                            if ____t_2993(____opt_2991) then
                                window.Art:drawDoodle(
                                    __L1.ctx,
                                    m.x,
                                    m.y - 22,
                                    m.kind,
                                    __L1.time,
                                    false
                                )
                            else
                                __L1.ctx.fillStyle = __gt(m.hit, 0) and "#fff2d8" or "#a679ac"
                                __L1.ctx:fillRect(m.x - 18, m.y - 34, 36, 34)
                                __L1.ctx.fillStyle = "#fff3df"
                                __L1.ctx:fillRect(m.x - 11, m.y - 25, 7, 7)
                                __L1.ctx:fillRect(m.x + 4, m.y - 25, 7, 7)
                            end
                        end
                    end
                end
                __L1.ctx.fillStyle = "#2b3f33"
                __L1.ctx:fillRect(m.x - 20, m.y - 48, 40, 4)
                __L1.ctx.fillStyle = "#dab7dd"
                __L1.ctx:fillRect(m.x - 19, m.y - 47, 38 * m.hp / m.max, 2)
            end
        end
    end
    __L1.drawPickupsNow = function(self, ctx)
        for ____, p in __iterar((__L1.pickups)) do
            if not __t(p.taken) then
                local yy = p.y + math.sin(__L1.time * 3 + p.t) * 4
                ctx.fillStyle = "#172e2540"
                ctx:beginPath()
                ctx:ellipse(
                    p.x,
                    p.y + 22,
                    13,
                    4,
                    0,
                    0,
                    7
                )
                __call(ctx, "fill")
                if __t(p.type == "repair" or p.type == "notebook") then
                    ctx.fillStyle = p.type == "repair" and "#e9ca74" or "#6ca7c5"
                    ctx:fillRect(p.x - 11, yy - 14, 22, 26)
                    ctx.strokeStyle = "#f8f1b6"
                    ctx.lineWidth = 2
                    ctx:strokeRect(p.x - 12, yy - 15, 24, 28)
                    ctx.fillStyle = "#203c3d"
                    ctx:fillRect(p.x - 6, yy - 7, 12, 3)
                    ctx:fillRect(p.x - 6, yy, 8, 3)
                elseif __t(__get(__L1.itemNames, p.type)) then
                    local ____t_2996 = __t
                    local ____opt_2994 = window.Art
                    if ____opt_2994 ~= nil then
                        ____opt_2994 = ____opt_2994.drawMaterial
                    end
                    if ____t_2996(____opt_2994) then
                        window.Art:drawMaterial(ctx, p.x, yy, p.type)
                    else
                        ctx.fillStyle = p.type == "pencil" and "#edce6f" or (p.type == "eraser" and "#eb9eae" or "#b7d1dc")
                        ctx:fillRect(p.x - 7, yy - 10, p.type == "pencil" and 6 or 15, 20)
                        ctx.strokeStyle = "#f6eac2"
                        ctx:strokeRect(p.x - 10, yy - 13, 22, 26)
                    end
                elseif p.type == "gas" then
                    ctx.fillStyle = "#d5ed9a"
                    ctx:fillRect(p.x - 8, yy - 11, 16, 22)
                    ctx.fillStyle = "#4e775b"
                    ctx:fillRect(p.x - 4, yy - 15, 8, 5)
                    ctx.fillStyle = "#678a45"
                    ctx:fillRect(p.x - 3, yy - 6, 6, 11)
                else
                    ctx.fillStyle = "#fff1cc"
                    ctx:fillRect(p.x - 8, yy - 10, 17, 20)
                    ctx.fillStyle = "#c6bc9e"
                    ctx:fillRect(p.x - 4, yy - 5, 10, 2)
                    ctx:fillRect(p.x - 4, yy, 8, 2)
                end
            end
        end
    end
    __L1.fundoDaArena = function(self)
        local ____t_2999 = __t
        local ____opt_2997 = window.Art
        if ____opt_2997 ~= nil then
            ____opt_2997 = ____opt_2997.drawScene
        end
        if not ____t_2999(____opt_2997) then
            return false
        end
        local k = __add(
            __add(
                __add(
                    __add(
                        __add(
                            __add(__L1.scene, "|"),
                            math.floor(__L1.camera + 0.5)
                        ),
                        "|"
                    ),
                    __L1.W
                ),
                "x"
            ),
            __L1.H
        )
        if __t(not __t(__L1.arenaFundo) or __L1.arenaFundo.k ~= k) then
            local ____t_result_3003
            local ____t_3002 = __t
            local ____opt_3000 = __L1.arenaFundo
            if ____opt_3000 ~= nil then
                ____opt_3000 = ____opt_3000.cv
            end
            __O[2075] = ____opt_3000
            if ____t_3002(____opt_3000) then
                ____t_result_3003 = __O[2075]
            else
                ____t_result_3003 = window.document:createElement("canvas")
            end
            local cv = ____t_result_3003
            cv.width = __L1.W
            cv.height = __L1.H
            local g = cv:getContext("2d")
            g:clearRect(0, 0, __L1.W, __L1.H)
            window.Art:drawScene(g, __L1.scene, __L1.camera, __L1.time)
            __L1.arenaFundo = {k = k, cv = cv}
        end
        return __L1.ctx:copiarTela(__L1.arenaFundo.cv) ~= false
    end
    __L1.frenteCamadas = function(self)
        local Hc = window.HdMaps.camadas
        local amb = Hc:ambiente(__L1.scene)
        local ____t_result_3006
        local ____t_3005 = __t
        local ____temp_3004 = __lt(
            __get(amb, 0),
            0.97
        ) or __lt(
            __get(amb, 1),
            0.97
        )
        __O[2076] = ____temp_3004
        if ____t_3005(____temp_3004) then
            ____t_result_3006 = __O[2076]
        else
            ____t_result_3006 = __lt(
                __get(amb, 2),
                0.97
            )
        end
        local escuro = ____t_result_3006
        local ____t_result_3012
        local ____t_3011 = __t
        local ____getq_3009 = __getq
        local ____opt_3007 = window.WorldData
        if ____opt_3007 ~= nil then
            ____opt_3007 = ____opt_3007.gaps
        end
        local ____getq_3009_result_3010 = ____getq_3009(____opt_3007, __L1.scene)
        __O[2077] = ____getq_3009_result_3010
        if ____t_3011(____getq_3009_result_3010) then
            ____t_result_3012 = __O[2077]
        else
            ____t_result_3012 = __arrL({}, 0)
        end
        local gaps = ____t_result_3012
        local ponte = __call(
            gaps,
            "some",
            function(____, g) return __TS__Number(__get(g, 0)) + __TS__Number(__get(g, 1)) >= __L1.camera - 25 and __TS__Number(__get(g, 0)) <= __L1.camera + 985 end
        )
        Hc:texto(__L1.ctx, __L1.scene, __L1.camera)
        if not __t(ponte) then
            return
        end
        if not __t(escuro) then
            local ____opt_3015 = window.Art
            if ____opt_3015 ~= nil then
                ____opt_3015 = ____opt_3015.drawGroundBridges
            end
            if ____opt_3015 ~= nil then
                ____opt_3015(
                    ____opt_3015,
                    __L1.ctx,
                    __L1.scene,
                    __L1.camera,
                    __L1.time
                )
            end
            return
        end
        if not __t(__L1.pontesCv) then
            __L1.pontesCv = window.document:createElement("canvas")
            __L1.pontesCv.width = __L1.W
            __L1.pontesCv.height = 160
        end
        local g = __L1.pontesCv:getContext("2d")
        g:setTransform(
            1,
            0,
            0,
            1,
            0,
            0
        )
        g:clearRect(0, 0, __L1.W, 160)
        g:translate(0, -380)
        local ____opt_3019 = window.Art
        if ____opt_3019 ~= nil then
            ____opt_3019 = ____opt_3019.drawGroundBridges
        end
        if ____opt_3019 ~= nil then
            ____opt_3019(
                ____opt_3019,
                g,
                __L1.scene,
                __L1.camera,
                __L1.time
            )
        end
        g:setTransform(
            1,
            0,
            0,
            1,
            0,
            0
        )
        Hc:multiplicar(g, __L1.W, 160, amb)
        __L1.ctx:drawImage(__L1.pontesCv, 0, 380)
    end
    __L1.draw = function(self)
        local ____t_3024 = __t
        local ____t_result_3023
        local ____t_3022 = __t
        local ____temp_3021 = not __t(__L1.arena)
        __O[2078] = ____temp_3021
        if ____t_3022(____temp_3021) then
            ____t_result_3023 = __L1.arenaFundo
        else
            ____t_result_3023 = __O[2078]
        end
        if ____t_3024(____t_result_3023) then
            __L1.arenaFundo = nil
        end
        window.DAROCA_QUADRO_CAMADAS = -1
        window.DAROCA_QUADRO_CAMERA = __L1.camera
        window.DAROCA_QUADRO_TEMPO = __L1.time
        window.DAROCA_QUADRO_TREMOR_X = 0
        window.DAROCA_QUADRO_TREMOR_Y = 0
        __L1.ctx:save()
        __L1.ctx:clearRect(0, 0, __L1.W, __L1.H)
        if __t(__L1.ollyanEncounter) then
            window.OllyanEncounter:draw(__L1.ctx, __L1.ollyanEncounter, {hud = false})
            local ____opt_3027 = window.FxPixel
            if ____opt_3027 ~= nil then
                ____opt_3027 = ____opt_3027.desenhar
            end
            if ____opt_3027 ~= nil then
                ____opt_3027(____opt_3027, __L1.ctx, {
                    dono = "ollyan",
                    camada = "front",
                    mundo = false,
                    tempo = __L1.time,
                    atualizar = true
                })
            end
            if __L1.ollyanEncounter.stage == "fight" then
                __L1:drawBivoltAura(__L1.ctx, __L1.ollyanEncounter.player.x, __L1.ollyanEncounter.player.y)
                __L1:pill("[E] VOLTAR AO BAILE", __L1.W - 113, __L1.H - 25, "#ded6be")
            end
            __L1.ctx:restore()
            return
        end
        if __t(__L1.cutscene) then
            window.Cinematics:draw(__L1.ctx, __L1.cutscene)
            __L1.ctx:restore()
            return
        end
        if __t(__L1.activity) then
            window.Activities:draw(__L1.ctx, __L1.activity)
            __L1.ctx:restore()
            return
        end
        if __t(__L1.room) then
            __L1:drawRoomFrame()
            __L1.ctx:restore()
            return
        end
        if __L1.shake > 0 then
            local tx = math.floor(__L1:rand(
                __TS__Number(-__L1.shake),
                __L1.shake
            ) + 0.5)
            local ty = math.floor(__L1:rand(
                __TS__Number(-__L1.shake) * 0.4,
                __L1.shake * 0.4
            ) + 0.5)
            __L1.ctx:translate(tx, ty)
            window.DAROCA_QUADRO_TREMOR_X = tx
            window.DAROCA_QUADRO_TREMOR_Y = ty
        end
        local ____opt_3029 = __L1.activeBoss
        if ____opt_3029 ~= nil then
            ____opt_3029 = ____opt_3029.conquista
        end
        local duelo = ____opt_3029
        local percurso = __L1:terrenoConquista(duelo)
        local ____t_3035 = __t
        local ____t_result_3034
        local ____t_3032 = __t
        local ____temp_3031 = not __t(percurso)
        __O[2079] = ____temp_3031
        if ____t_3032(____temp_3031) then
            ____t_result_3034 = __O[2079]
        else
            local ____t_result_3033
            if __t(duelo.ceu) then
                ____t_result_3033 = __lt(duelo.ceu.tempo, 0.85)
            else
                ____t_result_3033 = duelo.ceu
            end
            ____t_result_3034 = ____t_result_3033
        end
        if ____t_3035(____t_result_3034) then
            local ____t_3042 = __t
            local ____t_result_3041
            local ____t_3038 = __t
            local ____opt_3036 = window.C2Luta
            if ____opt_3036 ~= nil then
                ____opt_3036 = ____opt_3036.skin
            end
            __O[2080] = ____opt_3036
            if ____t_3038(____opt_3036) then
                local ____this_3040
                ____this_3040 = window.C2Luta
                local ____opt_3039 = ____this_3040.desenharFundo
                if ____opt_3039 ~= nil then
                    ____opt_3039 = ____opt_3039(
                        ____this_3040,
                        __L1.ctx,
                        __L1.camera,
                        __L1.time,
                        __L1.arena
                    )
                end
                ____t_result_3041 = ____opt_3039
            else
                ____t_result_3041 = __O[2080]
            end
            if ____t_3042(____t_result_3041) then
            else
                local ____t_3048 = __t
                local ____t_result_3047
                local ____t_3046 = __t
                local ____t_result_3045
                local ____t_3044 = __t
                local ____t_result_3043
                if __t(__L1.arena) then
                    ____t_result_3043 = __ge(__L1.arena.blend, 1)
                else
                    ____t_result_3043 = __L1.arena
                end
                __O[2081] = ____t_result_3043
                if ____t_3044(____t_result_3043) then
                    ____t_result_3045 = __L1.ctx.copiarTela
                else
                    ____t_result_3045 = __O[2081]
                end
                __O[2082] = ____t_result_3045
                if ____t_3046(____t_result_3045) then
                    ____t_result_3047 = __L1:fundoDaArena()
                else
                    ____t_result_3047 = __O[2082]
                end
                if ____t_3048(____t_result_3047) then
                else
                    local ____t_3059 = __t
                    local ____t_result_3058
                    local ____t_3052 = __t
                    local ____t_result_3051
                    local ____t_3050 = __t
                    local ____temp_3049 = not __t(__L1.arena)
                    __O[2083] = ____temp_3049
                    if ____t_3050(____temp_3049) then
                        ____t_result_3051 = window.DAROCA_CAMADAS
                    else
                        ____t_result_3051 = __O[2083]
                    end
                    __O[2084] = ____t_result_3051
                    if ____t_3052(____t_result_3051) then
                        local ____opt_3055 = window.HdMaps
                        if ____opt_3055 ~= nil then
                            ____opt_3055 = ____opt_3055.camadas
                        end
                        local ____opt_result_3057
                        if ____opt_3055 ~= nil then
                            ____opt_result_3057 = ____opt_3055:pode(__L1.scene)
                        end
                        ____t_result_3058 = ____opt_result_3057
                    else
                        ____t_result_3058 = __O[2084]
                    end
                    if ____t_3059(____t_result_3058) then
                        window.DAROCA_QUADRO_CAMADAS = __L1.scene
                        __L1:frenteCamadas()
                    else
                        local ____t_3062 = __t
                        local ____opt_3060 = window.Art
                        if ____opt_3060 ~= nil then
                            ____opt_3060 = ____opt_3060.drawScene
                        end
                        if ____t_3062(____opt_3060) then
                            window.Art:drawScene(__L1.ctx, __L1.scene, __L1.camera, __L1.time)
                        else
                            __L1.ctx.fillStyle = "#819379"
                            __L1.ctx:fillRect(0, 0, __L1.W, __L1.H)
                            __L1.ctx.fillStyle = "#617448"
                            __L1.ctx:fillRect(0, __L1.FLOOR, __L1.W, __L1.H - __L1.FLOOR)
                        end
                    end
                end
            end
            if not __t(__L1.arena) then
                local ____opt_3065 = window.WorldLife
                if ____opt_3065 ~= nil then
                    ____opt_3065 = ____opt_3065.draw
                end
                if ____opt_3065 ~= nil then
                    ____opt_3065(
                        ____opt_3065,
                        __L1.ctx,
                        __L1.scene,
                        __L1.camera,
                        __L1.time,
                        __L1.q,
                        __L1.player
                    )
                end
            end
            local ____t_3070 = __t
            local ____t_result_3069
            if __t(__L1.arena) then
                local ____opt_3067 = window.C2Luta
                if ____opt_3067 ~= nil then
                    ____opt_3067 = ____opt_3067.skin
                end
                ____t_result_3069 = ____opt_3067
            else
                ____t_result_3069 = __L1.arena
            end
            if ____t_3070(____t_result_3069) then
                __L1.ctx:save()
                __L1.ctx.globalAlpha = __L1.arena.blend
                local ____opt_3073 = window.BossArena
                if ____opt_3073 ~= nil then
                    ____opt_3073 = ____opt_3073.palco
                end
                if ____opt_3073 ~= nil then
                    ____opt_3073(
                        ____opt_3073,
                        __L1.ctx,
                        window.C2Luta.skin.tema,
                        __L1.camera,
                        __L1.time,
                        __L1.arena.homeX
                    )
                end
                __L1.ctx:restore()
            else
                local ____t_3078 = __t
                local ____t_result_3077
                if __t(__L1.arena) then
                    local ____opt_3075 = window.Art
                    if ____opt_3075 ~= nil then
                        ____opt_3075 = ____opt_3075.drawArena
                    end
                    ____t_result_3077 = ____opt_3075
                else
                    ____t_result_3077 = __L1.arena
                end
                if ____t_3078(____t_result_3077) then
                    __L1.ctx:save()
                    __L1.ctx.globalAlpha = __L1.arena.blend
                    window.Art:drawArena(
                        __L1.ctx,
                        __L1.arena.type,
                        __L1.camera,
                        __L1.time,
                        __L1.arena.homeX
                    )
                    __L1.ctx:restore()
                end
            end
        end
        if __t(percurso) then
            percurso:fundo(__L1.ctx, duelo)
        end
        __L1.ctx:save()
        __L1.ctx:translate(
            -math.floor(__L1.camera + 0.5),
            0
        )
        local ____opt_3081 = window.CampaignVfx
        if ____opt_3081 ~= nil then
            ____opt_3081 = ____opt_3081.draw
        end
        if ____opt_3081 ~= nil then
            ____opt_3081(____opt_3081, __L1.ctx, __L1.time, "back")
        end
        local ____opt_3085 = window.Golpes
        if ____opt_3085 ~= nil then
            ____opt_3085 = ____opt_3085.desenharGas
        end
        if ____opt_3085 ~= nil then
            ____opt_3085(____opt_3085, __L1.ctx, __L1.time)
        end
        local ____opt_3089 = window.FxPixel
        if ____opt_3089 ~= nil then
            ____opt_3089 = ____opt_3089.desenhar
        end
        if ____opt_3089 ~= nil then
            ____opt_3089(____opt_3089, __L1.ctx, {dono = "luta", camada = "back", camera = __L1.camera, tempo = __L1.time})
        end
        local ____t_3093 = __t
        local ____opt_3091 = __L1.activeBoss
        if ____opt_3091 ~= nil then
            ____opt_3091 = ____opt_3091.conquista
        end
        if ____t_3093(____opt_3091) then
            window.ConquistaEfeitos:fundo(__L1.ctx, __L1.activeBoss.conquista)
        end
        if __t(percurso) then
            percurso:plataformas(__L1.ctx, duelo)
        else
            for ____, p in __iterar((__L1:scenePlatforms())) do
                do
                    if __t(__lt(
                        __add(
                            __get(p, 0),
                            __get(p, 2)
                        ),
                        __L1.camera - 60
                    ) or __gt(
                        __get(p, 0),
                        __L1.camera + __L1.W + 60
                    )) then
                        continue
                    end
                    local ____t_3099 = __t
                    local ____opt_3096 = window.Graphics
                    if ____opt_3096 ~= nil then
                        ____opt_3096 = ____opt_3096.isLite
                    end
                    local ____opt_result_3098
                    if ____opt_3096 ~= nil then
                        ____opt_result_3098 = ____opt_3096(____opt_3096)
                    end
                    if ____t_3099(____opt_result_3098) then
                        __L1.ctx.fillStyle = __L1.scene == 2 and "#63736a" or "#8d724f"
                        __L1.ctx:fillRect(
                            __get(p, 0),
                            __get(p, 1),
                            __get(p, 2),
                            12
                        )
                        __L1.ctx.fillStyle = __L1.scene == 0 and "#abc378" or "#c0ab7f"
                        __L1.ctx:fillRect(
                            __get(p, 0),
                            __get(p, 1),
                            __get(p, 2),
                            4
                        )
                        __L1.ctx.fillStyle = "#263c303d"
                        __L1.ctx:fillRect(
                            __get(p, 0) + 8,
                            __get(p, 1) + 12,
                            __get(p, 2) - 16,
                            4
                        )
                    else
                        local ____t_3110 = __t
                        local ____t_result_3109
                        local ____t_3105 = __t
                        local ____t_result_3104
                        local ____t_3101 = __t
                        local ____temp_3100 = __L1.scene == 11
                        __O[2085] = ____temp_3100
                        if ____t_3101(____temp_3100) then
                            local ____opt_3102 = window.BaileGalpao
                            if ____opt_3102 ~= nil then
                                ____opt_3102 = ____opt_3102.camarote
                            end
                            ____t_result_3104 = ____opt_3102
                        else
                            ____t_result_3104 = __O[2085]
                        end
                        __O[2086] = ____t_result_3104
                        if ____t_3105(____t_result_3104) then
                            local ____gt_3108 = __gt
                            local ____get_result_3107 = __get(p, 0)
                            local ____t_result_3106
                            if __t(window.BaileGalpao.PORTA) then
                                ____t_result_3106 = window.BaileGalpao.PORTA
                            else
                                ____t_result_3106 = 760
                            end
                            ____t_result_3109 = ____gt_3108(____get_result_3107, ____t_result_3106)
                        else
                            ____t_result_3109 = __O[2086]
                        end
                        if ____t_3110(____t_result_3109) then
                            window.BaileGalpao:camarote(__L1.ctx, p, __L1.time)
                        else
                            local ____t_3116 = __t
                            local ____opt_3113 = window.LugaresC1
                            if ____opt_3113 ~= nil then
                                ____opt_3113 = ____opt_3113.plataforma
                            end
                            local ____opt_result_3115
                            if ____opt_3113 ~= nil then
                                ____opt_result_3115 = ____opt_3113(
                                    ____opt_3113,
                                    __L1.ctx,
                                    p,
                                    __L1.scene,
                                    __L1.time
                                )
                            end
                            if ____t_3116(____opt_result_3115) then
                            else
                                __L1:drawPlank(p)
                            end
                        end
                    end
                end
            end
        end
        if not __t(percurso) then
            local ____opt_3128 = window.Interact
            if ____opt_3128 ~= nil then
                ____opt_3128 = ____opt_3128.drawBack
            end
            if ____opt_3128 ~= nil then
                local ____L1_ctx_3126 = __L1.ctx
                local ____L1_scene_3122 = __L1.scene
                local ____L1_camera_3123 = __L1.camera
                local ____L1_time_3124 = __L1.time
                local ____temp_3125 = not not __t(__L1.arena)
                local ____opt_3118 = __L1.arena
                if ____opt_3118 ~= nil then
                    ____opt_3118 = ____opt_3118.type
                end
                local ____opt_3120 = __L1.arena
                if ____opt_3120 ~= nil then
                    ____opt_3120 = ____opt_3120.homeX
                end
                ____opt_3128(
                    ____opt_3128,
                    ____L1_ctx_3126,
                    {
                        scene = ____L1_scene_3122,
                        camera = ____L1_camera_3123,
                        time = ____L1_time_3124,
                        arena = ____temp_3125,
                        arenaType = ____opt_3118,
                        homeX = ____opt_3120,
                        room = not not __t(__L1.room)
                    }
                )
            end
            local ____opt_3132 = window.Fliperama
            if ____opt_3132 ~= nil then
                ____opt_3132 = ____opt_3132.drawWorld
            end
            if ____opt_3132 ~= nil then
                ____opt_3132(
                    ____opt_3132,
                    __L1.ctx,
                    {
                        scene = __L1.scene,
                        camera = __L1.camera,
                        time = __L1.time,
                        arena = not not __t(__L1.arena),
                        room = not not __t(__L1.room)
                    }
                )
            end
            local ____opt_3136 = window.Trigal
            if ____opt_3136 ~= nil then
                ____opt_3136 = ____opt_3136.drawBack
            end
            if ____opt_3136 ~= nil then
                ____opt_3136(
                    ____opt_3136,
                    __L1.ctx,
                    {
                        scene = __L1.scene,
                        camera = __L1.camera,
                        time = __L1.time,
                        player = __L1.player,
                        arena = not not __t(__L1.arena),
                        room = not not __t(__L1.room)
                    }
                )
            end
            local ____opt_3140 = window.CampanhaPlantas
            if ____opt_3140 ~= nil then
                ____opt_3140 = ____opt_3140.drawBack
            end
            if ____opt_3140 ~= nil then
                ____opt_3140(
                    ____opt_3140,
                    __L1.ctx,
                    {
                        scene = __L1.scene,
                        camera = __L1.camera,
                        time = __L1.time,
                        player = __L1.player,
                        arena = not not __t(__L1.arena),
                        room = not not __t(__L1.room)
                    }
                )
            end
            if __L1.scene >= 12 then
                local ____opt_3144 = window.CampanhaCenarios
                if ____opt_3144 ~= nil then
                    ____opt_3144 = ____opt_3144.heroi
                end
                if ____opt_3144 ~= nil then
                    ____opt_3144(____opt_3144, __L1.player.x, __L1.player.y, __L1.player.vy)
                end
            end
        end
        if not __t(__L1.arena) then
            local ____opt_3148 = window.BivoltQuest
            if ____opt_3148 ~= nil then
                ____opt_3148 = ____opt_3148.draw
            end
            if ____opt_3148 ~= nil then
                ____opt_3148(
                    ____opt_3148,
                    __L1.ctx,
                    0,
                    __L1.time,
                    __L1.q,
                    __L1.scene
                )
            end
            local ____opt_3152 = window.MissaoFarda
            if ____opt_3152 ~= nil then
                ____opt_3152 = ____opt_3152.desenhar
            end
            if ____opt_3152 ~= nil then
                ____opt_3152(
                    ____opt_3152,
                    __L1.ctx,
                    __L1.time,
                    __L1.q,
                    __L1.scene
                )
            end
            local ____opt_3156 = window.LugaresC1
            if ____opt_3156 ~= nil then
                ____opt_3156 = ____opt_3156.desenhar
            end
            if ____opt_3156 ~= nil then
                ____opt_3156(
                    ____opt_3156,
                    __L1.ctx,
                    __L1.time,
                    __L1.q,
                    __L1.scene
                )
            end
            if __L1.scene == 1 then
                __L1:drawSchoolWatch()
            end
            local ____t_3163 = __t
            local ____opt_3160 = window.Graphics
            if ____opt_3160 ~= nil then
                ____opt_3160 = ____opt_3160.isShader
            end
            local ____opt_result_3162
            if ____opt_3160 ~= nil then
                ____opt_result_3162 = ____opt_3160(____opt_3160)
            end
            if ____t_3163(____opt_result_3162) then
                __L1.pickupsLater = true
            else
                __L1:drawPickupsNow(__L1.ctx)
            end
            for ____, ____value in __iterar((__entries(__L1.npcInfo))) do
                local id = ____value[1]
                local n = ____value[2]
                local ____t_3167 = __t
                local ____t_result_3166
                local ____t_3165 = __t
                local ____temp_3164 = n.scene == __L1.scene and math.abs(n.x - __L1.camera - __L1.W / 2) < __L1.W / 2 + 180
                __O[2087] = ____temp_3164
                if ____t_3165(____temp_3164) then
                    ____t_result_3166 = __L1:npcAvailable(id)
                else
                    ____t_result_3166 = __O[2087]
                end
                if ____t_3167(____t_result_3166) then
                    local ____L1_sprite_3181 = __L1.sprite
                    local ____array_3180 = __TS__SparseArrayNew(id, n.x, __L1.FLOOR)
                    local ____temp_3178 = id == "ravid" and 1 or -1
                    local ____L1_time_3179 = __L1.time
                    local ____t_result_3177
                    local ____t_3169 = __t
                    local ____temp_3168 = id == "ravid"
                    __O[2089] = ____temp_3168
                    if ____t_3169(____temp_3168) then
                        ____t_result_3177 = __O[2089]
                    else
                        local ____t_result_3176
                        local ____t_3171 = __t
                        local ____temp_3170 = not not __t(__L1.dialog)
                        __O[2088] = ____temp_3170
                        if ____t_3171(____temp_3170) then
                            local ____call_3175 = __call
                            local ____arrL_result_3174 = __arrL(
                                {
                                    n.name,
                                    __get(
                                        __call(n.name, "split", " ·"),
                                        0
                                    )
                                },
                                2
                            )
                            local ____opt_3172 = __get(__L1.dialog.lines, __L1.dialog.index)
                            if ____opt_3172 ~= nil then
                                ____opt_3172 = ____opt_3172.name
                            end
                            ____t_result_3176 = ____call_3175(____arrL_result_3174, "includes", ____opt_3172)
                        else
                            ____t_result_3176 = __O[2088]
                        end
                        ____t_result_3177 = ____t_result_3176
                    end
                    __TS__SparseArrayPush(
                        ____array_3180,
                        {
                            facing = ____temp_3178,
                            frame = ____L1_time_3179,
                            moving = false,
                            grounded = true,
                            talking = ____t_result_3177,
                            injured = id == "ravile" and not __t(__L1.q.arthur),
                            helping = id == "aica" and not __t(__L1.q.arthur),
                            expressive = id == "arthur",
                            smoking = id == "dede",
                            smoke = id == "dede"
                        }
                    )
                    ____L1_sprite_3181(
                        __L1,
                        __TS__SparseArraySpread(____array_3180)
                    )
                    if id == "swift" then
                        __L1:pill("Irmão de Clara", n.x, __L1.FLOOR - 112, __L1.nearNPC == id and "#ffe19b" or "#e0d7ba")
                        __L1:pill("Swift", n.x, __L1.FLOOR - 96, "#e0d7ba")
                    else
                        __L1:pill(n.name, n.x, __L1.FLOOR - 100, __L1.nearNPC == id and "#ffe19b" or "#e0d7ba")
                    end
                    local ____t_3187 = __t
                    local ____t_result_3186
                    local ____t_3185 = __t
                    local ____t_result_3184
                    local ____t_3183 = __t
                    local ____temp_3182 = __L1.nearNPC == id
                    __O[2090] = ____temp_3182
                    if ____t_3183(____temp_3182) then
                        ____t_result_3184 = __L1.started
                    else
                        ____t_result_3184 = __O[2090]
                    end
                    __O[2091] = ____t_result_3184
                    if ____t_3185(____t_result_3184) then
                        ____t_result_3186 = not __t(__L1.dialog)
                    else
                        ____t_result_3186 = __O[2091]
                    end
                    if ____t_3187(____t_result_3186) then
                        __L1:pill("[E] conversar", n.x, __L1.FLOOR - 134, "#b8e5a4")
                    end
                end
            end
            local ____t_3193 = __t
            local ____t_result_3192
            local ____t_3189 = __t
            local ____temp_3188 = __L1.scene == 0
            __O[2092] = ____temp_3188
            if ____t_3189(____temp_3188) then
                local ____opt_3190 = window.Art
                if ____opt_3190 ~= nil then
                    ____opt_3190 = ____opt_3190.drawVehicle
                end
                ____t_result_3192 = ____opt_3190
            else
                ____t_result_3192 = __O[2092]
            end
            if ____t_3193(____t_result_3192) then
                window.Art:drawVehicle(__L1.ctx, 1040, __L1.FLOOR - 5, __L1.time)
            end
            __L1:drawMinions()
            local ____opt_3196 = window.FavelaCasas
            if ____opt_3196 ~= nil then
                ____opt_3196 = ____opt_3196.portas
            end
            if ____opt_3196 ~= nil then
                ____opt_3196(____opt_3196, __L1.ctx, __L1.scene, __L1.time)
            end
            local ____iter_3206 = __iter
            local ____t_result_3205
            local ____t_3204 = __t
            local ____opt_3202 = window.WorldData
            if ____opt_3202 ~= nil then
                ____opt_3202 = ____opt_3202.doors
            end
            __O[2093] = ____opt_3202
            if ____t_3204(____opt_3202) then
                ____t_result_3205 = __O[2093]
            else
                ____t_result_3205 = __arrL({}, 0)
            end
            for ____, d in __TS__Iterator(____iter_3206(____t_result_3205)) do
                local ____t_3201 = __t
                local ____t_result_3200
                local ____t_3199 = __t
                local ____temp_3198 = d.scene == __L1.scene and math.abs(__L1.player.x - d.x) < 110
                __O[2094] = ____temp_3198
                if ____t_3199(____temp_3198) then
                    ____t_result_3200 = math.abs(__L1.player.y - __L1.FLOOR) < 80
                else
                    ____t_result_3200 = __O[2094]
                end
                if ____t_3201(____t_result_3200) then
                    __L1:pill(
                        __t(__L1.vehicle) and "[V] estacionar para entrar" or __add("[E] ", d.label),
                        d.x,
                        __L1.FLOOR - 125,
                        "#f3d89e"
                    )
                end
            end
        end
        local ____iter_3219 = __iter
        local ____t_result_3218
        local ____t_3217 = __t
        local ____opt_3215 = window.WorldData
        if ____opt_3215 ~= nil then
            ____opt_3215 = ____opt_3215.sarueTraps
        end
        __O[2095] = ____opt_3215
        if ____t_3217(____opt_3215) then
            ____t_result_3218 = __O[2095]
        else
            ____t_result_3218 = __arrL({}, 0)
        end
        for ____, trap in __TS__Iterator(____iter_3219(____t_result_3218)) do
            local ____t_3214 = __t
            local ____t_result_3213
            local ____t_3210 = __t
            local ____t_result_3209
            local ____t_3208 = __t
            local ____temp_3207 = trap.scene == __L1.scene
            __O[2096] = ____temp_3207
            if ____t_3208(____temp_3207) then
                ____t_result_3209 = not __t(__L1.arena) or __L1.arena.type == "marco"
            else
                ____t_result_3209 = __O[2096]
            end
            __O[2097] = ____t_result_3209
            if ____t_3210(____t_result_3209) then
                local ____opt_3211 = window.Art
                if ____opt_3211 ~= nil then
                    ____opt_3211 = ____opt_3211.drawSarueTrap
                end
                ____t_result_3213 = ____opt_3211
            else
                ____t_result_3213 = __O[2097]
            end
            if ____t_3214(____t_result_3213) then
                window.Art:drawSarueTrap(
                    __L1.ctx,
                    trap.x,
                    __L1.FLOOR,
                    __L1.time,
                    __L1.marcoTrapTriggered
                )
            end
        end
        for ____, e in __iterar((__L1.enemies)) do
            do
                local ____t_3224 = __t
                local ____t_result_3223
                local ____t_3221 = __t
                local ____le_result_3220 = __le(e.hp, 0)
                __O[2098] = ____le_result_3220
                if ____t_3221(____le_result_3220) then
                    ____t_result_3223 = __O[2098]
                else
                    local ____t_result_3222
                    if __t(__L1.arena) then
                        ____t_result_3222 = e.type ~= __L1.arena.type
                    else
                        ____t_result_3222 = __L1.arena
                    end
                    ____t_result_3223 = ____t_result_3222
                end
                if ____t_3224(____t_result_3223) then
                    continue
                end
                if e == __L1.activeBoss then
                    local ____opt_3227 = window.FxPixel
                    if ____opt_3227 ~= nil then
                        ____opt_3227 = ____opt_3227.chefe
                    end
                    if ____opt_3227 ~= nil then
                        ____opt_3227(____opt_3227, e)
                    end
                end
                if __t(e.conquista) then
                    local f = e.conquista
                    local ataca = f.estado == "firing"
                    local prepara = f.estado == "windup"
                    local ____L1_time_3232 = __L1.time
                    local ____temp_3233 = __lt(__L1.player.x, e.x) and -1 or 1
                    local ____gt_result_3234 = __gt(e.hit, 0)
                    local ____t_result_3229
                    if __t(ataca) then
                        ____t_result_3229 = ataca
                    else
                        ____t_result_3229 = prepara
                    end
                    local ____t_result_3231
                    if __t(prepara) then
                        ____t_result_3231 = 0.25 * __L1:clamp(f.tempo / f.dur, 0, 1)
                    else
                        local ____t_result_3230
                        if __t(ataca) then
                            ____t_result_3230 = 0.3 + 0.7 * __L1:clamp(f.tempo / f.dur, 0, 1)
                        else
                            ____t_result_3230 = 0
                        end
                        ____t_result_3231 = ____t_result_3230
                    end
                    local opt = {
                        frame = ____L1_time_3232,
                        grounded = true,
                        facing = ____temp_3233,
                        hit = ____gt_result_3234,
                        attack = ____t_result_3229,
                        attackProgress = ____t_result_3231,
                        moving = f.estado == "recover" and math.abs(f.destino - f.x) > 4
                    }
                    if __t(f.estrada) then
                        window.PerseguicaoMoto:personagem(__L1.ctx, f)
                    elseif f.slug == "jorge" then
                        window.JorgeDuelo:personagem(__L1.ctx, f, opt)
                    else
                        window.ConquistaEfeitos:personagem(
                            __L1.ctx,
                            f,
                            window.C2Luta.skin.tipo,
                            e.x,
                            e.y,
                            opt
                        )
                    end
                    if f.gemeoX ~= nil then
                        window.ConquistaEfeitos:personagem(
                            __L1.ctx,
                            f,
                            "c2_bryan",
                            f.gemeoX,
                            e.y,
                            __assign(
                                {},
                                opt,
                                {
                                    moving = false,
                                    facing = __lt(__L1.player.x, f.gemeoX) and -1 or 1
                                }
                            )
                        )
                    end
                    continue
                end
                if e.state == "underground" then
                    local ____L1_drawSewerMarker_3236 = __L1.drawSewerMarker
                    local ____e_diveFromX_3235 = e.diveFromX
                    if ____e_diveFromX_3235 == nil then
                        ____e_diveFromX_3235 = e.x
                    end
                    ____L1_drawSewerMarker_3236(__L1, ____e_diveFromX_3235, false)
                    continue
                end
                local fxOn = e == __L1.activeBoss
                if __t(fxOn) then
                    local ____opt_3239 = window.BossFx
                    if ____opt_3239 ~= nil then
                        ____opt_3239 = ____opt_3239.drawBack
                    end
                    if ____opt_3239 ~= nil then
                        ____opt_3239(____opt_3239, __L1.ctx, e, __L1.time)
                    end
                end
                if e.type == "nikolas" then
                    local ____opt_3243 = window.NikolasFx
                    if ____opt_3243 ~= nil then
                        ____opt_3243 = ____opt_3243.aura
                    end
                    if ____opt_3243 ~= nil then
                        ____opt_3243(
                            ____opt_3243,
                            __L1.ctx,
                            e,
                            __L1.time,
                            __lt(__L1.player.x, e.x) and -1 or 1
                        )
                    end
                end
                if e.type == "igor" then
                    e.igorScale = __L1:igorScale(e)
                end
                local ____t_result_3250
                if __t(fxOn) then
                    local ____opt_3247 = window.BossFx
                    if ____opt_3247 ~= nil then
                        ____opt_3247 = ____opt_3247.transform
                    end
                    local ____opt_result_3249
                    if ____opt_3247 ~= nil then
                        ____opt_result_3249 = ____opt_3247(____opt_3247, e, __L1.player)
                    end
                    ____t_result_3250 = ____opt_result_3249
                else
                    ____t_result_3250 = nil
                end
                local bt = ____t_result_3250
                if __t(bt) then
                    __L1.ctx:save()
                    __L1.ctx:translate(
                        __add(e.x, bt.dx),
                        e.y
                    )
                    if __t(bt.rot) then
                        __L1.ctx:translate(
                            0,
                            __TS__Number(-bt.py)
                        )
                        __L1.ctx:rotate(bt.rot)
                        __L1.ctx:translate(0, bt.py)
                    end
                    __L1.ctx:scale(bt.sx, bt.sy)
                    __L1.ctx:translate(
                        __TS__Number(-e.x),
                        __TS__Number(-e.y)
                    )
                end
                local ____L1_sprite_3340 = __L1.sprite
                local ____array_3339 = __TS__SparseArrayNew(e.type, e.x, e.y)
                local ____t_result_3255
                local ____t_3254 = __t
                local ____t_result_3253
                local ____t_3252 = __t
                local ____temp_3251 = __L1:isSchoolMonitor(e)
                __O[2099] = ____temp_3251
                if ____t_3252(____temp_3251) then
                    ____t_result_3253 = not __t(__L1.arena)
                else
                    ____t_result_3253 = __O[2099]
                end
                if ____t_3254(____t_result_3253) then
                    ____t_result_3255 = e.monitorDir
                else
                    ____t_result_3255 = __lt(__L1.player.x, e.x) and -1 or 1
                end
                local ____L1_time_3319 = __L1.time
                local ____temp_3257
                if e.type == "nikolas" then
                    local ____t_result_3256
                    if __t(e.phase) then
                        ____t_result_3256 = e.phase
                    else
                        ____t_result_3256 = 1
                    end
                    ____temp_3257 = ____t_result_3256
                else
                    ____temp_3257 = nil
                end
                local ____temp_3320 = e.type == "nikolas" and e.state == "phaseChange"
                local ____temp_3258
                if e.type == "nikolas" then
                    ____temp_3258 = __L1:nikolasTransformProgress(e)
                else
                    ____temp_3258 = 1
                end
                local ____e_state_3321 = e.state
                local ____e_kind_3322 = e.kind
                local ____e_targetX_3323 = e.targetX
                local ____gt_result_3324 = __gt(e.hit, 0)
                local ____temp_3325 = e.state == "windup" or e.state == "firing"
                local ____temp_3266
                if e.state == "windup" then
                    local ____L1_clamp_3261 = __L1.clamp
                    local ____e_stateTimer_3260 = e.stateTimer
                    local ____t_result_3259
                    if __t(e.windupDuration) then
                        ____t_result_3259 = e.windupDuration
                    else
                        ____t_result_3259 = 1
                    end
                    ____temp_3266 = 0.28 * ____L1_clamp_3261(__L1, 1 - ____e_stateTimer_3260 / ____t_result_3259, 0, 1)
                else
                    local ____temp_3265
                    if e.state == "firing" then
                        local ____L1_clamp_3264 = __L1.clamp
                        local ____L1_time_3263 = __L1.time
                        local ____e_visualAttackAt_3262 = e.visualAttackAt
                        if ____e_visualAttackAt_3262 == nil then
                            ____e_visualAttackAt_3262 = __L1.time
                        end
                        ____temp_3265 = 0.3 + 0.7 * ____L1_clamp_3264(__L1, (____L1_time_3263 - ____e_visualAttackAt_3262) / 0.45, 0, 1)
                    else
                        ____temp_3265 = 0
                    end
                    ____temp_3266 = ____temp_3265
                end
                local ____gt_result_3326 = __gt(e.angry, 0)
                local ____e_rage_3327 = e.rage
                local ____temp_3271
                if e.type == "igor" then
                    ____temp_3271 = __L1:igorScale(e)
                else
                    local ____t_3270 = __t
                    local ____t_result_3269
                    local ____t_3268 = __t
                    local ____temp_3267 = e.type == "marco"
                    __O[2100] = ____temp_3267
                    if ____t_3268(____temp_3267) then
                        ____t_result_3269 = e.rage
                    else
                        ____t_result_3269 = __O[2100]
                    end
                    ____temp_3271 = ____t_3270(____t_result_3269) and 1.4 or 1
                end
                local ____temp_3328 = not not __t(__L1.arena)
                local ____temp_3329 = e.state == "bellyRolling"
                local ____t_result_3272
                if __t(e.rollAngle) then
                    ____t_result_3272 = e.rollAngle
                else
                    ____t_result_3272 = 0
                end
                local ____t_result_3285
                local ____t_3276 = __t
                local ____t_result_3275
                local ____t_3274 = __t
                local ____temp_3273 = e.type == "igor"
                __O[2101] = ____temp_3273
                if ____t_3274(____temp_3273) then
                    ____t_result_3275 = fxOn
                else
                    ____t_result_3275 = __O[2101]
                end
                if ____t_3276(____t_result_3275) then
                    local ____opt_3281 = window.BossFx
                    if ____opt_3281 ~= nil then
                        ____opt_3281 = ____opt_3281.igorPose
                    end
                    local ____opt_result_3283
                    if ____opt_3281 ~= nil then
                        ____opt_result_3283 = ____opt_3281(____opt_3281, e)
                    end
                    local ____opt_result_3284
                    if ____opt_result_3283 ~= nil then
                        ____opt_result_3284 = ____opt_result_3283.pose
                    end
                    ____t_result_3285 = ____opt_result_3284
                else
                    ____t_result_3285 = nil
                end
                local ____t_result_3298
                local ____t_3289 = __t
                local ____t_result_3288
                local ____t_3287 = __t
                local ____temp_3286 = e.type == "igor"
                __O[2102] = ____temp_3286
                if ____t_3287(____temp_3286) then
                    ____t_result_3288 = fxOn
                else
                    ____t_result_3288 = __O[2102]
                end
                if ____t_3289(____t_result_3288) then
                    local ____opt_3294 = window.BossFx
                    if ____opt_3294 ~= nil then
                        ____opt_3294 = ____opt_3294.igorPose
                    end
                    local ____opt_result_3296
                    if ____opt_3294 ~= nil then
                        ____opt_result_3296 = ____opt_3294(____opt_3294, e)
                    end
                    local ____opt_result_3297
                    if ____opt_result_3296 ~= nil then
                        ____opt_result_3297 = ____opt_result_3296.k
                    end
                    ____t_result_3298 = ____opt_result_3297
                else
                    ____t_result_3298 = nil
                end
                local ____temp_3330 = e.state == "firing"
                local ____t_result_3304
                local ____t_3300 = __t
                local ____temp_3299 = e.state == "dashing"
                __O[2104] = ____temp_3299
                if ____t_3300(____temp_3299) then
                    ____t_result_3304 = __O[2104]
                else
                    local ____t_result_3303
                    local ____t_3302 = __t
                    local ____temp_3301 = __L1:isSchoolMonitor(e)
                    __O[2103] = ____temp_3301
                    if ____t_3302(____temp_3301) then
                        ____t_result_3303 = not __t(__L1.arena)
                    else
                        ____t_result_3303 = __O[2103]
                    end
                    ____t_result_3304 = ____t_result_3303
                end
                local ____temp_3331 = e.state == "dashing"
                local ____temp_3309
                if e.state == "dashing" then
                    ____temp_3309 = 600
                else
                    local ____t_3308 = __t
                    local ____t_result_3307
                    local ____t_3306 = __t
                    local ____temp_3305 = __L1:isSchoolMonitor(e)
                    __O[2105] = ____temp_3305
                    if ____t_3306(____temp_3305) then
                        ____t_result_3307 = not __t(__L1.arena)
                    else
                        ____t_result_3307 = __O[2105]
                    end
                    ____temp_3309 = ____t_3308(____t_result_3307) and 33 or 0
                end
                local ____ge_result_3332 = __ge(e.y, __L1.FLOOR)
                local ____temp_3333 = e.type == "arthur"
                local ____temp_3334 = e.type == "dede"
                local ____temp_3335 = e.type == "dede"
                local ____t_result_3312
                local ____t_3311 = __t
                local ____temp_3310 = e.type == "dede" and e.state == "windup"
                __O[2106] = ____temp_3310
                if ____t_3311(____temp_3310) then
                    ____t_result_3312 = e.kind == "tragada"
                else
                    ____t_result_3312 = __O[2106]
                end
                local ____temp_3336 = e.state == "concealed"
                local ____temp_3337 = e.type == "marco" and "doodle" or (e.type == "nikolas" and "slime" or (e.type == "freddy" and "punch" or (e.type == "nicolas" and "cast" or "word")))
                local ____temp_3315 = e.type == "nicolas"
                if ____temp_3315 then
                    local ____opt_3313 = __L1.arena
                    if ____opt_3313 ~= nil then
                        ____opt_3313 = ____opt_3313.type
                    end
                    ____temp_3315 = ____opt_3313 == "nicolas"
                end
                local ____temp_3338 = e.type == "nicolas" and e.state == "windup"
                local ____temp_3318 = e.type == "nicolas"
                if ____temp_3318 then
                    local ____opt_3316 = __L1.arena
                    if ____opt_3316 ~= nil then
                        ____opt_3316 = ____opt_3316.type
                    end
                    ____temp_3318 = ____opt_3316 == "nicolas"
                end
                __TS__SparseArrayPush(____array_3339, {
                    facing = ____t_result_3255,
                    frame = ____L1_time_3319,
                    bossPhase = ____temp_3257,
                    phaseChanging = ____temp_3320,
                    transformProgress = ____temp_3258,
                    phaseState = ____e_state_3321,
                    giantAttack = ____e_kind_3322,
                    attackTargetX = ____e_targetX_3323,
                    hit = ____gt_result_3324,
                    attack = ____temp_3325,
                    attackProgress = ____temp_3266,
                    angry = ____gt_result_3326,
                    rage = ____e_rage_3327,
                    scale = ____temp_3271,
                    monitorBattle = ____temp_3328,
                    bellyRolling = ____temp_3329,
                    rollAngle = ____t_result_3272,
                    igorPose = ____t_result_3285,
                    igorPoseK = ____t_result_3298,
                    firing = ____temp_3330,
                    moving = ____t_result_3304,
                    dash = ____temp_3331,
                    speed = ____temp_3309,
                    grounded = ____ge_result_3332,
                    expressive = ____temp_3333,
                    smoking = ____temp_3334,
                    smoke = ____temp_3335,
                    inhale = ____t_result_3312,
                    hiddenInSmoke = ____temp_3336,
                    attackType = ____temp_3337,
                    supreme = ____temp_3315,
                    charging = ____temp_3338,
                    powered = ____temp_3318,
                    noseRub = e.type == "nikolas"
                })
                ____L1_sprite_3340(
                    __L1,
                    __TS__SparseArraySpread(____array_3339)
                )
                if __t(bt) then
                    __L1.ctx:restore()
                end
                if __t(fxOn) then
                    local ____opt_3343 = window.BossFx
                    if ____opt_3343 ~= nil then
                        ____opt_3343 = ____opt_3343.drawFront
                    end
                    if ____opt_3343 ~= nil then
                        ____opt_3343(____opt_3343, __L1.ctx, e, __L1.time)
                    end
                end
                if e.type == "nikolas" then
                    local ____opt_3347 = window.NikolasFx
                    if ____opt_3347 ~= nil then
                        ____opt_3347 = ____opt_3347.frente
                    end
                    if ____opt_3347 ~= nil then
                        ____opt_3347(
                            ____opt_3347,
                            __L1.ctx,
                            e,
                            __L1.time,
                            __lt(__L1.player.x, e.x) and -1 or 1
                        )
                    end
                end
                local ____e_y_3355 = e.y
                local ____temp_3354
                if e.type == "giant" then
                    ____temp_3354 = 205
                else
                    local ____t_result_3353
                    local ____t_3352 = __t
                    local ____t_result_3351
                    local ____t_3350 = __t
                    local ____temp_3349 = e.type == "igor"
                    __O[2107] = ____temp_3349
                    if ____t_3350(____temp_3349) then
                        ____t_result_3351 = __L1.arena
                    else
                        ____t_result_3351 = __O[2107]
                    end
                    if ____t_3352(____t_result_3351) then
                        ____t_result_3353 = 90 * __L1:igorScale(e) + 28
                    else
                        ____t_result_3353 = e.type == "kaique" and 115 or (e.type == "reeisBoss" and 145 or (__t(e.rage) and 140 or 96))
                    end
                    ____temp_3354 = ____t_result_3353
                end
                local nameY = ____e_y_3355 - ____temp_3354
                local ____t_3365 = __t
                local ____t_3359 = __t
                local ____temp_3358 = e.type == "igor"
                if ____temp_3358 then
                    local ____opt_3356 = __L1.arena
                    if ____opt_3356 ~= nil then
                        ____opt_3356 = ____opt_3356.type
                    end
                    ____temp_3358 = ____opt_3356 == "igor"
                end
                local ____temp_3364 = not ____t_3359(____temp_3358)
                if ____temp_3364 then
                    local ____t_3363 = __t
                    local ____t_result_3362
                    local ____t_3361 = __t
                    local ____temp_3360 = e.type == "nikolas" and __ge(e.phase, 2)
                    __O[2108] = ____temp_3360
                    if ____t_3361(____temp_3360) then
                        ____t_result_3362 = __L1.arena
                    else
                        ____t_result_3362 = __O[2108]
                    end
                    ____temp_3364 = not ____t_3363(____t_result_3362)
                end
                if ____t_3365(____temp_3364) then
                    local ____L1_pill_3370 = __L1.pill
                    local ____call_3369 = __call
                    local ____t_result_3368
                    local ____t_3367 = __t
                    local ____temp_3366 = __L1:nomeBoss(e.type)
                    __O[2109] = ____temp_3366
                    if ____t_3367(____temp_3366) then
                        ____t_result_3368 = __O[2109]
                    else
                        ____t_result_3368 = e.type
                    end
                    ____L1_pill_3370(
                        __L1,
                        ____call_3369(____t_result_3368, "toUpperCase"),
                        e.x,
                        nameY,
                        e.type == "nicolas" and "#fff0aa" or (e.type == "nikolas" and "#f5b38c" or "#eacb98")
                    )
                    __L1.ctx.fillStyle = "#243b31"
                    __L1.ctx:fillRect(e.x - 47, nameY + 19, 94, 6)
                    __L1.ctx.fillStyle = "#d98c72"
                    __L1.ctx:fillRect(e.x - 46, nameY + 20, 92 * e.hp / e.max, 4)
                end
                if __t(e.type == "marco" and math.abs(e.x - __L1.player.x) < 520) then
                    __L1:pill(
                        __gt(e.angry, 0) and "FÚRIA VERMELHA!" or "CUIDADO COM O PISO SARUÊ",
                        e.x,
                        e.y - 126,
                        __gt(e.angry, 0) and "#f5abc2" or "#e1c6ec"
                    )
                end
                if __t(e.type == "nikolas" and e.phase == 1) then
                    __L1.ctx.fillStyle = "#253c31"
                    __L1.ctx:fillRect(e.x - 40, e.y - 65, 80, 6)
                    __L1.ctx.fillStyle = "#c7e285"
                    __L1.ctx:fillRect(e.x - 39, e.y - 64, 78 * e.charge / 100, 4)
                    if __gt(e.charge, 75) then
                        __L1:pill("CATARRO CARREGADO!", e.x, e.y - 126, "#d8f29d")
                    end
                end
            end
        end
        if not __t(__L1.arena) then
            __L1:drawSchoolCover()
        end
        if __t(__L1.arena) then
            __L1:drawMinions()
        end
        __L1:drawBossTelegraphs()
        __L1:drawReeis()
        local ____t_3385 = __t
        local ____t_result_3384
        local ____t_3378 = __t
        local ____t_result_3377
        local ____t_3376 = __t
        local ____t_result_3375
        local ____t_3374 = __t
        local ____t_result_3373
        local ____t_3372 = __t
        local ____temp_3371 = not __t(__L1.arena) and not __t(__L1.room)
        __O[2110] = ____temp_3371
        if ____t_3372(____temp_3371) then
            ____t_result_3373 = not __t(__L1.dialog)
        else
            ____t_result_3373 = __O[2110]
        end
        __O[2111] = ____t_result_3373
        if ____t_3374(____t_result_3373) then
            ____t_result_3375 = __L1.started
        else
            ____t_result_3375 = __O[2111]
        end
        __O[2112] = ____t_result_3375
        if ____t_3376(____t_result_3375) then
            ____t_result_3377 = not __t(__L1.vehicle)
        else
            ____t_result_3377 = __O[2112]
        end
        __O[2113] = ____t_result_3377
        if ____t_3378(____t_result_3377) then
            local ____opt_3381 = window.Fliperama
            if ____opt_3381 ~= nil then
                ____opt_3381 = ____opt_3381.near
            end
            local ____opt_result_3383
            if ____opt_3381 ~= nil then
                ____opt_result_3383 = ____opt_3381(____opt_3381, __L1.scene, __L1.player.x)
            end
            ____t_result_3384 = ____opt_result_3383
        else
            ____t_result_3384 = __O[2113]
        end
        if ____t_3385(____t_result_3384) then
            __L1:pill("[E] JOGAR FLIPERAMA", __L1.player.x, __L1.FLOOR - 140, "#ffd0f0")
        end
        local ____t_3408 = __t
        local ____t_result_3407
        local ____t_3401 = __t
        local ____t_result_3400
        local ____t_3393 = __t
        local ____t_result_3392
        local ____t_3391 = __t
        local ____t_result_3390
        local ____t_3389 = __t
        local ____t_result_3388
        local ____t_3387 = __t
        local ____temp_3386 = not __t(__L1.arena) and not __t(__L1.room)
        __O[2114] = ____temp_3386
        if ____t_3387(____temp_3386) then
            ____t_result_3388 = not __t(__L1.dialog)
        else
            ____t_result_3388 = __O[2114]
        end
        __O[2115] = ____t_result_3388
        if ____t_3389(____t_result_3388) then
            ____t_result_3390 = __L1.started
        else
            ____t_result_3390 = __O[2115]
        end
        __O[2116] = ____t_result_3390
        if ____t_3391(____t_result_3390) then
            ____t_result_3392 = not __t(__L1.vehicle)
        else
            ____t_result_3392 = __O[2116]
        end
        __O[2117] = ____t_result_3392
        if ____t_3393(____t_result_3392) then
            local ____t_3399 = __t
            local ____opt_3396 = window.Balanco
            if ____opt_3396 ~= nil then
                ____opt_3396 = ____opt_3396.active
            end
            local ____opt_result_3398
            if ____opt_3396 ~= nil then
                ____opt_result_3398 = ____opt_3396(____opt_3396)
            end
            ____t_result_3400 = not ____t_3399(____opt_result_3398)
        else
            ____t_result_3400 = __O[2117]
        end
        __O[2118] = ____t_result_3400
        if ____t_3401(____t_result_3400) then
            local ____opt_3404 = window.Balanco
            if ____opt_3404 ~= nil then
                ____opt_3404 = ____opt_3404.near
            end
            local ____opt_result_3406
            if ____opt_3404 ~= nil then
                ____opt_result_3406 = ____opt_3404(____opt_3404, __L1.scene, __L1.player.x)
            end
            ____t_result_3407 = ____opt_result_3406
        else
            ____t_result_3407 = __O[2118]
        end
        if ____t_3408(____t_result_3407) then
            __L1:pill("[E] SENTAR NO BALANÇO", __L1.player.x, __L1.FLOOR - 140, "#ffe2a8")
        end
        local ____t_3412 = __t
        local ____t_result_3411
        local ____t_3410 = __t
        local ____temp_3409 = not __t(__L1.arena) and not __t(__L1.dialog)
        __O[2119] = ____temp_3409
        if ____t_3410(____temp_3409) then
            ____t_result_3411 = __L1.started
        else
            ____t_result_3411 = __O[2119]
        end
        if ____t_3412(____t_result_3411) then
            local nearby = __L1:closestBoss()
            if __t(nearby) then
                local access = __L1:bossAccess(nearby)
                local ____L1_pill_3414 = __L1.pill
                local ____t_result_3413
                if __t(access.ok) then
                    ____t_result_3413 = __add(
                        "[E] DESAFIAR ",
                        __call(
                            __L1:nomeBoss(nearby.type),
                            "toUpperCase"
                        )
                    )
                else
                    ____t_result_3413 = "[E] VER MISSÕES PARA O CHEFE"
                end
                ____L1_pill_3414(
                    __L1,
                    ____t_result_3413,
                    nearby.x,
                    nearby.y - (nearby.type == "giant" and 242 or 172),
                    __t(access.ok) and "#daeda3" or "#f3d298"
                )
            end
        end
        local ____t_3420 = __t
        local ____t_result_3419
        local ____t_3418 = __t
        local ____opt_3415 = __L1.arena
        if ____opt_3415 ~= nil then
            ____opt_3415 = ____opt_3415.phase
        end
        local ____temp_3417 = ____opt_3415 == "active" and not __t(__L1.dialog)
        __O[2120] = ____temp_3417
        if ____t_3418(____temp_3417) then
            ____t_result_3419 = not __t(percurso) or __le(
                __L1.player.x,
                __get(__L1.arena.bounds, 0) + 78
            )
        else
            ____t_result_3419 = __O[2120]
        end
        if ____t_3420(____t_result_3419) then
            local ____L1_pill_3427 = __L1.pill
            local ____temp_3426 = __get(__L1.arena.bounds, 0) + 87
            local ____t_result_3425
            local ____t_3424 = __t
            local ____opt_result_3423
            if duelo ~= nil then
                ____opt_result_3423 = duelo.ceu
            end
            if ____t_3424(____opt_result_3423) then
                ____t_result_3425 = __get(duelo.ceu.ilhas, 0).y + 50
            else
                ____t_result_3425 = __L1.FLOOR - 65
            end
            ____L1_pill_3427(
                __L1,
                "[E] SAIR DA ARENA",
                ____temp_3426,
                ____t_result_3425,
                "#e4ce9b"
            )
        end
        local ____t_3429 = __t
        local ____t_result_3428
        if __t(__L1.started) then
            ____t_result_3428 = not __t(percurso)
        else
            ____t_result_3428 = __L1.started
        end
        if ____t_3429(____t_result_3428) then
            local ____opt_3432 = window.SceneLife
            if ____opt_3432 ~= nil then
                ____opt_3432 = ____opt_3432.drawBack
            end
            if ____opt_3432 ~= nil then
                ____opt_3432(
                    ____opt_3432,
                    __L1.ctx,
                    {
                        scene = __L1.scene,
                        player = __L1.player,
                        camera = __L1.camera,
                        time = __L1.time,
                        arena = not not __t(__L1.arena),
                        gapAt = __L1.gapAt
                    }
                )
            end
        end
        for ____, a in __iterar((__L1.afterimages)) do
            __L1.ctx:save()
            __L1.ctx.globalAlpha = a.life * 2
            __L1:sprite("daroca", a.x, a.y, {
                facing = a.facing,
                frame = __L1.time,
                dash = true,
                moving = true,
                muscular = __L1.q.trained,
                grounded = __L1.player.ground
            })
            __L1.ctx:restore()
        end
        if __t(__L1.started) then
            __L1:drawBivoltAura(__L1.ctx, __L1.player.x, __L1.player.y - 40)
        end
        local ____t_3435 = __t
        local ____t_result_3434
        if __t(__L1.started) then
            ____t_result_3434 = __le(__L1.player.inv, 0) or __mod(
                math.floor(__L1.time * 15),
                2
            ) == 0
        else
            ____t_result_3434 = __L1.started
        end
        if ____t_3435(____t_result_3434) then
            local function drawHero(____, c, ox, oy)
                local function paint(____, ____type, x, y, opt)
                    local ____t_3438 = __t
                    local ____opt_3436 = window.Art
                    if ____opt_3436 ~= nil then
                        ____opt_3436 = ____opt_3436.drawCharacter
                    end
                    if ____t_3438(____opt_3436) then
                        window.Art:drawCharacter(
                            c,
                            ____type,
                            x,
                            y,
                            opt
                        )
                    else
                        c.fillStyle = "#f0b45d"
                        c:fillRect(x - 13, y - 39, 26, 39)
                    end
                end
                local ____t_3442 = __t
                local ____t_result_3441
                if __t(__L1.vehicle) then
                    local ____opt_3439 = window.Art
                    if ____opt_3439 ~= nil then
                        ____opt_3439 = ____opt_3439.drawVehicle
                    end
                    ____t_result_3441 = ____opt_3439
                else
                    ____t_result_3441 = __L1.vehicle
                end
                if ____t_3442(____t_result_3441) then
                    local vf = __lt(__L1.player.facing, 0) and -1 or 1
                    c:save()
                    c:translate(
                        math.floor(ox + 0.5),
                        0
                    )
                    c:scale(vf, 1)
                    window.Art:drawVehicle(c, 0, oy, __L1.time)
                    c:restore()
                    paint(
                        nil,
                        "daroca",
                        ox + 4 * vf,
                        oy - 22,
                        __L1:playerSpriteOptions(0.8)
                    )
                else
                    local ____t_result_3449
                    local ____t_3448 = __t
                    local ____opt_3445 = window.SceneLife
                    if ____opt_3445 ~= nil then
                        ____opt_3445 = ____opt_3445.heroScale
                    end
                    local ____opt_result_3447
                    if ____opt_3445 ~= nil then
                        ____opt_result_3447 = ____opt_3445(____opt_3445, __L1.player, __L1.vehicle)
                    end
                    __O[2121] = ____opt_result_3447
                    if ____t_3448(____opt_result_3447) then
                        ____t_result_3449 = __O[2121]
                    else
                        ____t_result_3449 = {sx = 1, sy = 1}
                    end
                    local k = ____t_result_3449
                    c:save()
                    c:translate(
                        math.floor(ox + 0.5),
                        math.floor(oy + 0.5)
                    )
                    c:scale(k.sx, k.sy)
                    paint(
                        nil,
                        "daroca",
                        0,
                        0,
                        __L1:playerSpriteOptions()
                    )
                    c:restore()
                end
            end
            local ____t_3455 = __t
            local ____opt_3452 = window.Balanco
            if ____opt_3452 ~= nil then
                ____opt_3452 = ____opt_3452.active
            end
            local ____opt_result_3454
            if ____opt_3452 ~= nil then
                ____opt_result_3454 = ____opt_3452(____opt_3452)
            end
            if ____t_3455(____opt_result_3454) then
            else
                local ____t_3465 = __t
                local ____t_result_3464
                local ____t_3458 = __t
                local ____opt_3456 = __L1.routeTransition
                if ____opt_3456 ~= nil then
                    ____opt_3456 = ____opt_3456.chegada
                end
                __O[2122] = ____opt_3456
                if ____t_3458(____opt_3456) then
                    local ____opt_3461 = window.ChegadaCarro
                    if ____opt_3461 ~= nil then
                        ____opt_3461 = ____opt_3461.desenhar
                    end
                    local ____opt_result_3463
                    if ____opt_3461 ~= nil then
                        ____opt_result_3463 = ____opt_3461(
                            ____opt_3461,
                            __L1.ctx,
                            {
                                x = __L1.player.x,
                                y = __L1.player.y,
                                time = __L1.time,
                                pintar = function(____, c, x, y) return drawHero(nil, c, x, y) end
                            }
                        )
                    end
                    ____t_result_3464 = ____opt_result_3463
                else
                    ____t_result_3464 = __O[2122]
                end
                if ____t_3465(____t_result_3464) then
                else
                    local ____t_3473 = __t
                    local ____t_result_3472
                    if __t(percurso) then
                        ____t_result_3472 = percurso
                    else
                        local ____t_3471 = __t
                        local ____opt_3468 = window.HeroShadow
                        if ____opt_3468 ~= nil then
                            ____opt_3468 = ____opt_3468.draw
                        end
                        local ____opt_result_3470
                        if ____opt_3468 ~= nil then
                            ____opt_result_3470 = ____opt_3468(
                                ____opt_3468,
                                __L1.ctx,
                                {
                                    draw = drawHero,
                                    x = __L1.player.x,
                                    y = __L1.player.y,
                                    floor = __L1:heroFloor(),
                                    platforms = __L1:scenePlatforms(),
                                    scene = __L1.scene,
                                    time = __L1.time,
                                    room = not not __t(__L1.room),
                                    arena = not not __t(__L1.arena),
                                    vehicle = __L1.vehicle
                                }
                            )
                        end
                        ____t_result_3472 = not ____t_3471(____opt_result_3470)
                    end
                    if ____t_3473(____t_result_3472) then
                        drawHero(nil, __L1.ctx, __L1.player.x, __L1.player.y)
                    end
                end
            end
        end
        if not __t(percurso) then
            if __t(__L1.started) then
                local ____opt_3476 = window.SceneLife
                if ____opt_3476 ~= nil then
                    ____opt_3476 = ____opt_3476.drawFront
                end
                if ____opt_3476 ~= nil then
                    ____opt_3476(
                        ____opt_3476,
                        __L1.ctx,
                        {
                            scene = __L1.scene,
                            player = __L1.player,
                            camera = __L1.camera,
                            time = __L1.time,
                            arena = not not __t(__L1.arena),
                            gapAt = __L1.gapAt
                        }
                    )
                end
            end
            local ____opt_3489 = window.Interact
            if ____opt_3489 ~= nil then
                ____opt_3489 = ____opt_3489.drawFront
            end
            if ____opt_3489 ~= nil then
                local ____L1_ctx_3487 = __L1.ctx
                local ____L1_scene_3483 = __L1.scene
                local ____L1_camera_3484 = __L1.camera
                local ____L1_time_3485 = __L1.time
                local ____temp_3486 = not not __t(__L1.arena)
                local ____opt_3479 = __L1.arena
                if ____opt_3479 ~= nil then
                    ____opt_3479 = ____opt_3479.type
                end
                local ____opt_3481 = __L1.arena
                if ____opt_3481 ~= nil then
                    ____opt_3481 = ____opt_3481.homeX
                end
                ____opt_3489(
                    ____opt_3489,
                    ____L1_ctx_3487,
                    {
                        scene = ____L1_scene_3483,
                        camera = ____L1_camera_3484,
                        time = ____L1_time_3485,
                        arena = ____temp_3486,
                        arenaType = ____opt_3479,
                        homeX = ____opt_3481,
                        room = not not __t(__L1.room)
                    }
                )
            end
            local ____opt_3493 = window.Balanco
            if ____opt_3493 ~= nil then
                ____opt_3493 = ____opt_3493.draw
            end
            if ____opt_3493 ~= nil then
                ____opt_3493(
                    ____opt_3493,
                    __L1.ctx,
                    {
                        scene = __L1.scene,
                        camera = __L1.camera,
                        time = __L1.time,
                        arena = not not __t(__L1.arena),
                        room = not not __t(__L1.room)
                    }
                )
            end
            local ____opt_3497 = window.Trigal
            if ____opt_3497 ~= nil then
                ____opt_3497 = ____opt_3497.drawFront
            end
            if ____opt_3497 ~= nil then
                ____opt_3497(
                    ____opt_3497,
                    __L1.ctx,
                    {
                        scene = __L1.scene,
                        camera = __L1.camera,
                        time = __L1.time,
                        player = __L1.player,
                        arena = not not __t(__L1.arena),
                        room = not not __t(__L1.room)
                    }
                )
            end
            local ____opt_3501 = window.CampanhaPlantas
            if ____opt_3501 ~= nil then
                ____opt_3501 = ____opt_3501.drawFront
            end
            if ____opt_3501 ~= nil then
                ____opt_3501(
                    ____opt_3501,
                    __L1.ctx,
                    {
                        scene = __L1.scene,
                        camera = __L1.camera,
                        time = __L1.time,
                        player = __L1.player,
                        arena = not not __t(__L1.arena),
                        room = not not __t(__L1.room)
                    }
                )
            end
            local ____opt_3505 = window.CampanhaCamadas
            if ____opt_3505 ~= nil then
                ____opt_3505 = ____opt_3505.primeiroPlano
            end
            if ____opt_3505 ~= nil then
                ____opt_3505(
                    ____opt_3505,
                    __L1.ctx,
                    {
                        scene = __L1.scene,
                        camera = __L1.camera,
                        time = __L1.time,
                        player = __L1.player,
                        arena = not not __t(__L1.arena),
                        room = not not __t(__L1.room)
                    }
                )
            end
        end
        local ____t_3509 = __t
        local ____opt_3507 = __L1.activeBoss
        if ____opt_3507 ~= nil then
            ____opt_3507 = ____opt_3507.conquista
        end
        if ____t_3509(____opt_3507) then
            window.ConquistaEfeitos:desenhar(__L1.ctx, __L1.activeBoss.conquista)
        end
        local ____opt_3512 = window.BossFx
        if ____opt_3512 ~= nil then
            ____opt_3512 = ____opt_3512.drawShotTrails
        end
        if ____opt_3512 ~= nil then
            ____opt_3512(____opt_3512, __L1.ctx, __L1.shots)
        end
        for ____, s in __iterar((__L1.shots)) do
            do
                local ____t_3519 = __t
                local ____opt_3516 = window.CampaignVfx
                if ____opt_3516 ~= nil then
                    ____opt_3516 = ____opt_3516.drawProjectile
                end
                local ____opt_result_3518
                if ____opt_3516 ~= nil then
                    ____opt_result_3518 = ____opt_3516(____opt_3516, __L1.ctx, s, __L1.time)
                end
                if ____t_3519(____opt_result_3518) then
                    continue
                end
                if s.type == "inkBlade" then
                    __L1.ctx:save()
                    __L1.ctx:translate(s.x, s.y)
                    __L1.ctx:rotate(__L1.time * 9)
                    __L1.ctx.fillStyle = "#492e60"
                    do
                        local i = 0
                        while i < 4 do
                            __L1.ctx:rotate(math.pi / 2)
                            __L1.ctx:fillRect(-3, -23, 6, 46)
                            i = i + 1
                        end
                    end
                    __L1.ctx.fillStyle = "#d6a8ef"
                    __L1.ctx:fillRect(-9, -9, 18, 18)
                    __L1.ctx.fillStyle = "#f4dcff"
                    __L1.ctx:fillRect(-3, -3, 6, 6)
                    __L1.ctx:restore()
                elseif s.type == "smoke" then
                    __L1.ctx:save()
                    __L1.ctx.globalAlpha = 0.7
                    __L1.ctx.fillStyle = "#bdc9bd"
                    __L1.ctx:beginPath()
                    __L1.ctx:ellipse(
                        s.x,
                        s.y,
                        13,
                        10,
                        0,
                        0,
                        math.pi * 2
                    )
                    __call(__L1.ctx, "fill")
                    __L1.ctx.fillStyle = "#e9eee1"
                    __L1.ctx:fillRect(s.x - 6, s.y - 6, 7, 4)
                    __L1.ctx:restore()
                elseif s.type == "confetti" then
                    __L1.ctx:save()
                    __L1.ctx:translate(s.x, s.y)
                    __L1.ctx:rotate(__L1.time * 5)
                    __L1.ctx.fillStyle = "#e9b6dc"
                    __L1.ctx:fillRect(-7, -6, 14, 12)
                    __L1.ctx.fillStyle = "#fff0b8"
                    __L1.ctx:fillRect(-3, -3, 6, 6)
                    __L1.ctx:restore()
                elseif s.type == "astral" then
                    __L1.ctx:save()
                    __L1.ctx:translate(s.x, s.y)
                    __L1.ctx:rotate(__L1.time * 2)
                    __L1.ctx.fillStyle = "#83e8ef"
                    __L1.ctx:fillRect(-3, -14, 6, 28)
                    __L1.ctx:fillRect(-14, -3, 28, 6)
                    __L1.ctx.fillStyle = "#ffe49a"
                    __L1.ctx:fillRect(-7, -7, 14, 14)
                    __L1.ctx.fillStyle = "#fff9d5"
                    __L1.ctx:fillRect(-3, -3, 6, 6)
                    __L1.ctx:restore()
                elseif s.type == "papaia" then
                    __L1.ctx.fillStyle = s.element == "electric" and "#a3edf7" or "#f5a541"
                    __L1.ctx:beginPath()
                    __L1.ctx:ellipse(
                        s.x,
                        s.y,
                        10,
                        7,
                        __L1.time * 3,
                        0,
                        math.pi * 2
                    )
                    __call(__L1.ctx, "fill")
                    __L1.ctx.fillStyle = "#f7e58e"
                    __L1.ctx:fillRect(s.x - 3, s.y - 3, 4, 4)
                    __L1.ctx.strokeStyle = s.element == "electric" and "#e1ffff" or "#ffe1a6"
                    __L1.ctx.lineWidth = 2
                    __L1.ctx:beginPath()
                    __L1.ctx:moveTo(s.x - 15, s.y - 4)
                    __L1.ctx:lineTo(s.x - 23, s.y + 3)
                    __L1.ctx:lineTo(s.x - 18, s.y + 6)
                    __L1.ctx:stroke()
                elseif s.type == "enemyBullet" then
                    __L1.ctx.fillStyle = "#f6db88"
                    __L1.ctx:fillRect(s.x - 8, s.y - 3, 15, 6)
                    __L1.ctx.fillStyle = "#fff1c4"
                    __L1.ctx:fillRect(s.x - 5, s.y - 2, 7, 2)
                elseif s.type == "wordWall" then
                    __L1.ctx:save()
                    __L1.ctx.fillStyle = "#cf9db9"
                    do
                        local yy = 125
                        while yy < 440 do
                            do
                                if math.abs(yy - s.gapY) < s.gapHeight / 2 then
                                    do yy = yy + 26 continue end
                                end
                                __L1.ctx:fillRect(s.x - 25, yy - 10, 50, 22)
                                __L1:text(
                                    "POUDI",
                                    s.x,
                                    yy,
                                    10,
                                    "#43283e"
                                )
                            end
                            yy = yy + 26
                        end
                    end
                    __L1.ctx.strokeStyle = "#d1ec9a"
                    __L1.ctx.lineWidth = 3
                    __L1.ctx:strokeRect(s.x - 27, s.gapY - s.gapHeight / 2, 54, s.gapHeight)
                    __L1.ctx:restore()
                elseif s.type == "doodle" then
                    local ____t_3522 = __t
                    local ____opt_3520 = window.Art
                    if ____opt_3520 ~= nil then
                        ____opt_3520 = ____opt_3520.drawDoodle
                    end
                    if ____t_3522(____opt_3520) then
                        window.Art:drawDoodle(
                            __L1.ctx,
                            s.x,
                            s.y,
                            s.variant,
                            __L1.time,
                            s.enraged
                        )
                    else
                        __L1.ctx.strokeStyle = __t(s.enraged) and "#eb93ae" or "#d0a6e6"
                        __L1.ctx.lineWidth = 3
                        __L1.ctx:beginPath()
                        do
                            local i = 0
                            while i < 13 do
                                local a = i / 12 * math.pi * 2
                                local r = __t(__mod(i, 2)) and 12 or 21
                                local x = s.x + math.cos(a + __L1.time * 3) * r
                                local y = s.y + math.sin(a + __L1.time * 3) * r
                                local ____t_result_3523
                                if __t(i) then
                                    ____t_result_3523 = __L1.ctx:lineTo(x, y)
                                else
                                    ____t_result_3523 = __L1.ctx:moveTo(x, y)
                                end
                                i = i + 1
                            end
                        end
                        __L1.ctx:stroke()
                        __L1.ctx.fillStyle = "#f9e8df"
                        __L1.ctx:fillRect(s.x - 9, s.y - 4, 6, 6)
                        __L1.ctx:fillRect(s.x + 4, s.y - 4, 6, 6)
                        __L1.ctx.fillStyle = "#442b54"
                        __L1.ctx:fillRect(s.x - 7, s.y - 2, 3, 3)
                        __L1.ctx:fillRect(s.x + 5, s.y - 2, 3, 3)
                    end
                elseif s.type == "word" then
                    __L1.ctx:save()
                    if __gt(s.delay, 0) then
                        __L1.ctx.globalAlpha = 0.35
                    end
                    __L1.ctx.fillStyle = "#2c2b3ce8"
                    local width = __len(s.text) * 7 + 18
                    __L1.ctx:fillRect(s.x - width / 2, s.y - 13, width, 27)
                    __L1.ctx.fillStyle = "#cc94ad"
                    __L1.ctx:fillRect(s.x - width / 2, s.y + 12, width, 3)
                    __L1:text(
                        s.text,
                        s.x,
                        s.y,
                        12,
                        __t(s.echo) and "#bddeed" or "#f5c9de"
                    )
                    __L1.ctx:restore()
                else
                    local ____t_3532 = __t
                    local ____t_result_3531
                    local ____t_3525 = __t
                    local ____temp_3524 = s.type == "slime"
                    __O[2123] = ____temp_3524
                    if ____t_3525(____temp_3524) then
                        local ____opt_3528 = window.NikolasFx
                        if ____opt_3528 ~= nil then
                            ____opt_3528 = ____opt_3528.catarro
                        end
                        local ____opt_result_3530
                        if ____opt_3528 ~= nil then
                            ____opt_result_3530 = ____opt_3528(____opt_3528, __L1.ctx, s, __L1.time)
                        end
                        ____t_result_3531 = ____opt_result_3530
                    else
                        ____t_result_3531 = __O[2123]
                    end
                    if ____t_3532(____t_result_3531) then
                    elseif s.type == "slime" then
                        __L1.ctx.fillStyle = "#688a3a"
                        __L1.ctx:fillRect(s.x - 12, s.y - 8, 24, 16)
                        __L1.ctx.fillStyle = "#c6e37e"
                        __L1.ctx:fillRect(s.x - 9, s.y - 10, 15, 15)
                        __L1.ctx.fillStyle = "#e3f6a4"
                        __L1.ctx:fillRect(s.x - 6, s.y - 7, 5, 4)
                    else
                        __L1.ctx:save()
                        __L1.ctx:translate(s.x, s.y)
                        local ____self_3534 = __L1.ctx
                        local ____self_3534_rotate_3535 = ____self_3534.rotate
                        local ____temp_3533
                        if s.type == "paper" then
                            ____temp_3533 = __L1.time * 9
                        else
                            ____temp_3533 = 0
                        end
                        ____self_3534_rotate_3535(____self_3534, ____temp_3533)
                        __L1.ctx.fillStyle = s.type == "paper" and "#fff3d6" or (s.type == "ruler" and "#e0b061" or (s.type == "case" and "#9dd3c3" or "#ffe096"))
                        __L1.ctx:fillRect(-6, -5, s.type == "paper" and 12 or (s.type == "ruler" and 28 or 18), 10)
                        __L1.ctx.fillStyle = "#d5c9ad"
                        __L1.ctx:fillRect(-3, -3, 6, 2)
                        __L1.ctx:restore()
                    end
                end
            end
        end
        local ____opt_3538 = window.CampaignVfx
        if ____opt_3538 ~= nil then
            ____opt_3538 = ____opt_3538.draw
        end
        if ____opt_3538 ~= nil then
            ____opt_3538(____opt_3538, __L1.ctx, __L1.time, "front")
        end
        local ____opt_3542 = window.FxPixel
        if ____opt_3542 ~= nil then
            ____opt_3542 = ____opt_3542.desenhar
        end
        if ____opt_3542 ~= nil then
            ____opt_3542(____opt_3542, __L1.ctx, {dono = "luta", camada = "front", camera = __L1.camera, tempo = __L1.time})
        end
        for ____, p in __iterar((__L1.particles)) do
            __L1.ctx.globalAlpha = __L1:clamp(p.life * 2, 0, 1)
            __L1.ctx.fillStyle = p.color
            __L1.ctx:fillRect(
                math.floor(p.x + 0.5),
                math.floor(p.y + 0.5),
                p.size,
                p.size
            )
        end
        __L1.ctx.globalAlpha = 1
        local ____opt_3546 = window.Golpes
        if ____opt_3546 ~= nil then
            ____opt_3546 = ____opt_3546.desenharCaixas
        end
        if ____opt_3546 ~= nil then
            ____opt_3546(____opt_3546, __L1.ctx, {
                player = __L1.player,
                enemies = __L1.enemies,
                minions = __L1.minions,
                shots = __L1.shots,
                hazards = __L1.hazards
            })
        end
        local ____t_3554 = __t
        local ____t_result_3553
        local ____t_3552 = __t
        local ____t_result_3551
        if __t(__L1.arena) then
            local ____t_3550 = __t
            local ____opt_3548 = __L1.activeBoss
            if ____opt_3548 ~= nil then
                ____opt_3548 = ____opt_3548.conquista
            end
            ____t_result_3551 = not ____t_3550(____opt_3548)
        else
            ____t_result_3551 = __L1.arena
        end
        __O[2124] = ____t_result_3551
        if ____t_3552(____t_result_3551) then
            ____t_result_3553 = window.HdScene
        else
            ____t_result_3553 = __O[2124]
        end
        if ____t_3554(____t_result_3553) then
            __L1.ctx:save()
            __L1.ctx:translate(
                math.floor(__L1.camera + 0.5),
                0
            )
            window.HdScene:drawFront(
                __L1.ctx,
                __L1.arena.type,
                __L1.camera,
                __L1.time,
                __L1.arena.homeX,
                __L1.arena.blend
            )
            local ____opt_3557 = window.HdMaps
            if ____opt_3557 ~= nil then
                ____opt_3557 = ____opt_3557.arenaFront
            end
            if ____opt_3557 ~= nil then
                ____opt_3557(
                    ____opt_3557,
                    __L1.ctx,
                    __L1.arena.type,
                    __L1.camera,
                    __L1.time,
                    __L1.arena.homeX,
                    __L1.arena.blend
                )
            end
            __L1.ctx:restore()
        else
            local ____t_3566 = __t
            local ____t_result_3565
            local ____t_3564 = __t
            local ____t_result_3563
            local ____t_3562 = __t
            local ____t_result_3561
            local ____t_3560 = __t
            local ____temp_3559 = not __t(__L1.arena)
            __O[2125] = ____temp_3559
            if ____t_3560(____temp_3559) then
                ____t_result_3561 = __L1.started
            else
                ____t_result_3561 = __O[2125]
            end
            __O[2126] = ____t_result_3561
            if ____t_3562(____t_result_3561) then
                ____t_result_3563 = window.HdScene
            else
                ____t_result_3563 = __O[2126]
            end
            __O[2127] = ____t_result_3563
            if ____t_3564(____t_result_3563) then
                ____t_result_3565 = __call(
                    __arrL({
                        0,
                        1,
                        3,
                        4,
                        5,
                        7,
                        9
                    }, 7),
                    "includes",
                    __L1.scene
                )
            else
                ____t_result_3565 = __O[2127]
            end
            if ____t_3566(____t_result_3565) then
                __L1.ctx:save()
                __L1.ctx:translate(
                    math.floor(__L1.camera + 0.5),
                    0
                )
                window.HdScene:drawAmbient(
                    __L1.ctx,
                    __L1.time,
                    __L1.player.x - __L1.camera,
                    __L1.player.y,
                    __L1.scene
                )
                __L1.ctx:restore()
            end
        end
        local ____t_3572 = __t
        local ____t_result_3571
        local ____t_3570 = __t
        local ____t_result_3569
        local ____t_3568 = __t
        local ____temp_3567 = not __t(__L1.arena)
        __O[2128] = ____temp_3567
        if ____t_3568(____temp_3567) then
            ____t_result_3569 = __L1.started
        else
            ____t_result_3569 = __O[2128]
        end
        __O[2129] = ____t_result_3569
        if ____t_3570(____t_result_3569) then
            ____t_result_3571 = window.Weather
        else
            ____t_result_3571 = __O[2129]
        end
        if ____t_3572(____t_result_3571) then
            __L1.ctx:save()
            __L1.ctx:translate(
                math.floor(__L1.camera + 0.5),
                0
            )
            local ____self_3582 = window.Weather
            local ____self_3582_draw_3583 = ____self_3582.draw
            local ____L1_ctx_3581 = __L1.ctx
            local ____L1_scene_3578 = __L1.scene
            local ____L1_camera_3579 = __L1.camera
            local ____L1_time_3580 = __L1.time
            local ____t_result_3577
            local ____t_3576 = __t
            local ____t_result_3575
            local ____t_3574 = __t
            local ____temp_3573 = not __t(__L1.cutscene) and not __t(__L1.room)
            __O[2130] = ____temp_3573
            if ____t_3574(____temp_3573) then
                ____t_result_3575 = not __t(__L1.activity)
            else
                ____t_result_3575 = __O[2130]
            end
            __O[2131] = ____t_result_3575
            if ____t_3576(____t_result_3575) then
                ____t_result_3577 = not __t(__L1.ollyanEncounter)
            else
                ____t_result_3577 = __O[2131]
            end
            ____self_3582_draw_3583(____self_3582, ____L1_ctx_3581, {
                scene = ____L1_scene_3578,
                camera = ____L1_camera_3579,
                time = ____L1_time_3580,
                outdoor = ____t_result_3577,
                player = {
                    x = __L1.player.x,
                    y = __L1.player.y,
                    vx = __L1.player.vx,
                    vy = __L1.player.vy,
                    ground = __L1.player.ground
                }
            })
            __L1.ctx:restore()
        end
        local ____t_3593 = __t
        local ____t_result_3592
        local ____t_3589 = __t
        local ____t_result_3588
        local ____t_3587 = __t
        local ____t_result_3586
        local ____t_3585 = __t
        local ____temp_3584 = not __t(__L1.arena)
        __O[2132] = ____temp_3584
        if ____t_3585(____temp_3584) then
            ____t_result_3586 = __L1.started
        else
            ____t_result_3586 = __O[2132]
        end
        __O[2133] = ____t_result_3586
        if ____t_3587(____t_result_3586) then
            ____t_result_3588 = __L1.scene == 6
        else
            ____t_result_3588 = __O[2133]
        end
        __O[2134] = ____t_result_3588
        if ____t_3589(____t_result_3588) then
            local ____opt_3590 = window.HdMaps
            if ____opt_3590 ~= nil then
                ____opt_3590 = ____opt_3590.darkness
            end
            ____t_result_3592 = ____opt_3590
        else
            ____t_result_3592 = __O[2134]
        end
        if ____t_3593(____t_result_3592) then
            __L1.ctx:save()
            __L1.ctx:translate(
                math.floor(__L1.camera + 0.5),
                0
            )
            window.HdMaps:darkness(
                __L1.ctx,
                __L1.scene,
                __L1.camera,
                __L1.time,
                __L1.player.x - __L1.camera,
                __L1.player.y,
                __L1.player.facing
            )
            __L1.ctx:restore()
        end
        for ____, d in __iterar((__L1.damageTexts)) do
            __L1.ctx.globalAlpha = __L1:clamp(d.life * 2, 0, 1)
            __L1:text(
                d.text,
                d.x,
                d.y,
                17,
                d.color
            )
        end
        __L1.ctx.globalAlpha = 1
        local ____t_3599 = __t
        local ____t_result_3598
        local ____t_3595 = __t
        local ____t_result_3594
        if __t(__L1.q.nikolas) then
            ____t_result_3594 = __L1.scene == 3
        else
            ____t_result_3594 = __L1.q.nikolas
        end
        __O[2135] = ____t_result_3594
        if ____t_3595(____t_result_3594) then
            local ____opt_3596 = window.Art
            if ____opt_3596 ~= nil then
                ____opt_3596 = ____opt_3596.drawCake
            end
            ____t_result_3598 = ____opt_3596
        else
            ____t_result_3598 = __O[2135]
        end
        if ____t_3599(____t_result_3598) then
            window.Art:drawCake(__L1.ctx, 1970, __L1.FLOOR - 5)
        end
        __L1:drawEpicWorld()
        __L1.ctx:restore()
        if not __t(__L1.started) then
            __L1.ctx.fillStyle = "#192e301c"
            __L1.ctx:fillRect(0, 0, __L1.W, __L1.H)
            local ____t_3602 = __t
            local ____opt_3600 = window.Art
            if ____opt_3600 ~= nil then
                ____opt_3600 = ____opt_3600.drawVehicle
            end
            if ____t_3602(____opt_3600) then
                window.Art:drawVehicle(__L1.ctx, 760, __L1.FLOOR, __L1.time)
            end
            __L1:sprite("daroca", 760, __L1.FLOOR - 20, {facing = 1, frame = __L1.time, scale = 0.8})
        end
        local ____t_3621 = __t
        local ____t_result_3620
        local ____t_3619 = __t
        local ____t_result_3618
        local ____t_3614 = __t
        local ____t_result_3613
        local ____t_3612 = __t
        local ____t_result_3611
        local ____t_3610 = __t
        local ____t_result_3609
        local ____t_3608 = __t
        local ____t_result_3607
        local ____t_3606 = __t
        local ____t_result_3605
        local ____t_3604 = __t
        local ____t_result_3603
        if __t(__L1.started) then
            ____t_result_3603 = not __t(__L1.dialog)
        else
            ____t_result_3603 = __L1.started
        end
        __O[2136] = ____t_result_3603
        if ____t_3604(____t_result_3603) then
            ____t_result_3605 = not __t(__L1.paused)
        else
            ____t_result_3605 = __O[2136]
        end
        __O[2137] = ____t_result_3605
        if ____t_3606(____t_result_3605) then
            ____t_result_3607 = not __t(__L1.won)
        else
            ____t_result_3607 = __O[2137]
        end
        __O[2138] = ____t_result_3607
        if ____t_3608(____t_result_3607) then
            ____t_result_3609 = not __t(__L1.defeated)
        else
            ____t_result_3609 = __O[2138]
        end
        __O[2139] = ____t_result_3609
        if ____t_3610(____t_result_3609) then
            ____t_result_3611 = not __t(__L1.arena)
        else
            ____t_result_3611 = __O[2139]
        end
        __O[2140] = ____t_result_3611
        if ____t_3612(____t_result_3611) then
            ____t_result_3613 = not __t(__L1.routeTransition)
        else
            ____t_result_3613 = __O[2140]
        end
        __O[2141] = ____t_result_3613
        if ____t_3614(____t_result_3613) then
            local ____t_3617 = __t
            local ____opt_3615 = __L1.training
            if ____opt_3615 ~= nil then
                ____opt_3615 = ____opt_3615.active
            end
            ____t_result_3618 = not ____t_3617(____opt_3615)
        else
            ____t_result_3618 = __O[2141]
        end
        __O[2142] = ____t_result_3618
        if ____t_3619(____t_result_3618) then
            ____t_result_3620 = not __t(__L1.activity)
        else
            ____t_result_3620 = __O[2142]
        end
        if ____t_3621(____t_result_3620) then
            local needPart = __call(
                __L1.pickups,
                "find",
                function(____, p) return p.type == "repair" and not __t(p.taken) end
            )
            local needBook = __call(
                __L1.pickups,
                "find",
                function(____, p) return p.type == "notebook" and not __t(p.taken) end
            )
            local ____callq_3626 = __callq
            local ____opt_3624 = window.BivoltQuest
            if ____opt_3624 ~= nil then
                ____opt_3624 = ____opt_3624.parts
            end
            local ____opt_3622 = ____callq_3626(
                ____opt_3624,
                "find",
                function(____, p) return not __t(__call(__L1.q.bivoltParts, "includes", p.id)) end
            )
            if ____opt_3622 ~= nil then
                ____opt_3622 = ____opt_3622.x
            end
            local bivoltTarget = ____opt_3622
            local ____opt_3629 = window.MissaoFarda
            if ____opt_3629 ~= nil then
                ____opt_3629 = ____opt_3629.alvo
            end
            local ____opt_result_3631
            if ____opt_3629 ~= nil then
                ____opt_result_3631 = ____opt_3629(____opt_3629, __L1.q, __L1.scene)
            end
            local ____opt_result_3631_3637 = ____opt_result_3631
            if ____opt_result_3631_3637 == nil then
                local ____opt_3634 = window.LugaresC1
                if ____opt_3634 ~= nil then
                    ____opt_3634 = ____opt_3634.alvo
                end
                local ____opt_result_3636
                if ____opt_3634 ~= nil then
                    ____opt_result_3636 = ____opt_3634(____opt_3634, __L1.q, __L1.scene)
                end
                ____opt_result_3631_3637 = ____opt_result_3636
            end
            local fardaAlvo = ____opt_result_3631_3637
            local ____temp_3679
            if fardaAlvo ~= nil then
                ____temp_3679 = fardaAlvo
            else
                local ____t_result_3678
                if __t(__L1.scene == 11 and not __t(__L1.q.ollyan)) then
                    ____t_result_3678 = 3260
                else
                    local ____t_result_3677
                    if __t(__L1.scene == 10 and not __t(__L1.q.bivoltUnlocked)) then
                        local ____t_result_3639
                        if __t(__L1.q.bivoltAccepted) then
                            local ____bivoltTarget_3638 = bivoltTarget
                            if ____bivoltTarget_3638 == nil then
                                ____bivoltTarget_3638 = 1220
                            end
                            ____t_result_3639 = ____bivoltTarget_3638
                        else
                            ____t_result_3639 = 1220
                        end
                        ____t_result_3677 = ____t_result_3639
                    else
                        local ____t_result_3676
                        if __t(__L1.scene == 10 and not __t(__L1.q.rayssaVisit)) then
                            ____t_result_3676 = 450
                        else
                            local ____t_result_3675
                            if __t(__L1.scene == 0 and not __t(__L1.q.lucas)) then
                                local ____t_result_3645
                                local ____t_3641 = __t
                                local ____t_result_3640
                                if __t(__L1.q.carMissionAccepted) then
                                    ____t_result_3640 = __len(__L1.q.carParts) < 3
                                else
                                    ____t_result_3640 = __L1.q.carMissionAccepted
                                end
                                if ____t_3641(____t_result_3640) then
                                    local ____opt_result_3644
                                    if needPart ~= nil then
                                        ____opt_result_3644 = needPart.x
                                    end
                                    ____t_result_3645 = ____opt_result_3644
                                else
                                    ____t_result_3645 = 480
                                end
                                ____t_result_3675 = ____t_result_3645
                            else
                                local ____t_result_3674
                                if __t(__L1.scene == 7 and not __t(__L1.q.mota)) then
                                    ____t_result_3674 = 500
                                else
                                    local ____t_result_3673
                                    local ____t_3649 = __t
                                    local ____t_result_3648
                                    local ____t_3647 = __t
                                    local ____temp_3646 = __L1.scene == 8
                                    __O[2143] = ____temp_3646
                                    if ____t_3647(____temp_3646) then
                                        ____t_result_3648 = not __t(__L1.q.bigodon) or __L1:getJaglionStatus() == "reserved"
                                    else
                                        ____t_result_3648 = __O[2143]
                                    end
                                    if ____t_3649(____t_result_3648) then
                                        ____t_result_3673 = __L1.npcInfo.davi.x
                                    else
                                        local ____t_result_3672
                                        if __t(__L1.scene == 9 and not __t(__L1.q.arthur)) then
                                            local ____t_result_3650
                                            if __t(__L1.q.patioAccepted) then
                                                ____t_result_3650 = __L1:bossHome("arthur", 2850)
                                            else
                                                ____t_result_3650 = 500
                                            end
                                            ____t_result_3672 = ____t_result_3650
                                        else
                                            local ____t_result_3671
                                            if __t(__L1.scene == __L1.npcInfo.amanda.scene and not __t(__L1.q.amandaDating)) then
                                                ____t_result_3671 = __L1.npcInfo.amanda.x
                                            else
                                                local ____t_result_3670
                                                if __t(__L1.scene == 4 and not __t(__L1.q.nicolas)) then
                                                    ____t_result_3670 = __L1:bossHome("nicolas", 5350)
                                                else
                                                    local ____t_result_3669
                                                    if __t(__L1.scene == 1 and not __t(__L1.q.almiro)) then
                                                        local ____t_result_3656
                                                        local ____t_3652 = __t
                                                        local ____t_result_3651
                                                        if __t(__L1.q.almiroAccepted) then
                                                            ____t_result_3651 = __len(__L1.q.notebooks) < 3
                                                        else
                                                            ____t_result_3651 = __L1.q.almiroAccepted
                                                        end
                                                        if ____t_3652(____t_result_3651) then
                                                            local ____opt_result_3655
                                                            if needBook ~= nil then
                                                                ____opt_result_3655 = needBook.x
                                                            end
                                                            ____t_result_3656 = ____opt_result_3655
                                                        else
                                                            ____t_result_3656 = 1350
                                                        end
                                                        ____t_result_3669 = ____t_result_3656
                                                    else
                                                        local ____t_result_3668
                                                        if __t(__L1.scene == 1 and not __t(__L1.q.miqueias)) then
                                                            ____t_result_3668 = 2350
                                                        else
                                                            local ____t_result_3667
                                                            local ____t_3660 = __t
                                                            local ____t_result_3659
                                                            local ____t_3658 = __t
                                                            local ____temp_3657 = __L1.scene == 5 and not __t(__L1.q.freddy)
                                                            __O[2144] = ____temp_3657
                                                            if ____t_3658(____temp_3657) then
                                                                ____t_result_3659 = not __t(__L1.q.reeis)
                                                            else
                                                                ____t_result_3659 = __O[2144]
                                                            end
                                                            if ____t_3660(____t_result_3659) then
                                                                ____t_result_3667 = __L1:bossHome("freddy", 5680)
                                                            else
                                                                local ____t_result_3666
                                                                if __t(__L1.scene == 5 and not __t(__L1.q.reeis)) then
                                                                    ____t_result_3666 = __L1:bossHome("reeisBoss", 6400)
                                                                else
                                                                    local ____t_result_3665
                                                                    if __t(__L1.scene == 1 and not __t(__L1.q.marco)) then
                                                                        ____t_result_3665 = __L1:bossHome("marco", 3700)
                                                                    else
                                                                        local ____t_result_3664
                                                                        if __t(__L1.scene == 6 and not __t(__L1.q.giant)) then
                                                                            ____t_result_3664 = __L1:bossHome("giant", 5650)
                                                                        else
                                                                            local ____t_result_3663
                                                                            if __t(__L1.scene == 1 and not __t(__L1.q.menezes)) then
                                                                                ____t_result_3663 = __L1:bossHome("menezes", 5200)
                                                                            else
                                                                                local ____t_result_3662
                                                                                if __t(__L1.scene == 2 and not __t(__L1.q.trained)) then
                                                                                    ____t_result_3662 = 400
                                                                                else
                                                                                    local ____t_result_3661
                                                                                    if __t(__L1.scene == 3 and not __t(__L1.q.nikolas)) then
                                                                                        ____t_result_3661 = __L1:bossHome("nikolas", 4300)
                                                                                    else
                                                                                        ____t_result_3661 = nil
                                                                                    end
                                                                                    ____t_result_3662 = ____t_result_3661
                                                                                end
                                                                                ____t_result_3663 = ____t_result_3662
                                                                            end
                                                                            ____t_result_3664 = ____t_result_3663
                                                                        end
                                                                        ____t_result_3665 = ____t_result_3664
                                                                    end
                                                                    ____t_result_3666 = ____t_result_3665
                                                                end
                                                                ____t_result_3667 = ____t_result_3666
                                                            end
                                                            ____t_result_3668 = ____t_result_3667
                                                        end
                                                        ____t_result_3669 = ____t_result_3668
                                                    end
                                                    ____t_result_3670 = ____t_result_3669
                                                end
                                                ____t_result_3671 = ____t_result_3670
                                            end
                                            ____t_result_3672 = ____t_result_3671
                                        end
                                        ____t_result_3673 = ____t_result_3672
                                    end
                                    ____t_result_3674 = ____t_result_3673
                                end
                                ____t_result_3675 = ____t_result_3674
                            end
                            ____t_result_3676 = ____t_result_3675
                        end
                        ____t_result_3677 = ____t_result_3676
                    end
                    ____t_result_3678 = ____t_result_3677
                end
                ____temp_3679 = ____t_result_3678
            end
            local objective = ____temp_3679
            local ____t_3689 = __t
            local ____t_result_3688
            local ____t_3687 = __t
            local ____temp_3686 = objective ~= nil
            if ____temp_3686 then
                local ____t_3685 = __t
                local ____opt_3682 = window.Balanco
                if ____opt_3682 ~= nil then
                    ____opt_3682 = ____opt_3682.active
                end
                local ____opt_result_3684
                if ____opt_3682 ~= nil then
                    ____opt_result_3684 = ____opt_3682(____opt_3682)
                end
                ____temp_3686 = not ____t_3685(____opt_result_3684)
            end
            __O[2145] = ____temp_3686
            if ____t_3687(____temp_3686) then
                ____t_result_3688 = __lt(objective, __L1.camera + 45) or __gt(objective, __L1.camera + __L1.W - 45)
            else
                ____t_result_3688 = __O[2145]
            end
            if ____t_3689(____t_result_3688) then
                local right = __gt(objective, __L1.camera + __L1.W - 45)
                local ____L1_pill_3692 = __L1.pill
                local ____temp_3691 = __t(right) and "OBJETIVO →" or "← OBJETIVO"
                local ____t_result_3690
                if __t(right) then
                    ____t_result_3690 = __L1.W - 83
                else
                    ____t_result_3690 = 83
                end
                ____L1_pill_3692(
                    __L1,
                    ____temp_3691,
                    ____t_result_3690,
                    62,
                    "#ffe09b"
                )
            end
            if __t(__L1.vehicle) then
                __L1:pill("CARRO A GÁS", __L1.W / 2, 30, "#cfe5a7")
            end
            local ____t_3696 = __t
            local ____t_result_3695
            local ____t_3694 = __t
            local ____temp_3693 = __L1.reeisCooldown > 0
            __O[2146] = ____temp_3693
            if ____t_3694(____temp_3693) then
                ____t_result_3695 = __L1.q.reeis
            else
                ____t_result_3695 = __O[2146]
            end
            if ____t_3696(____t_result_3695) then
                __L1:pill(
                    __add(
                        __add(
                            "REEIS: ",
                            math.ceil(__L1.reeisCooldown)
                        ),
                        "s"
                    ),
                    __L1.W - 90,
                    __L1.H - 25,
                    "#f6cda0"
                )
            elseif __t(__L1.q.reeis) then
                __L1:pill("[R] REEIS PRONTO", __L1.W - 100, __L1.H - 25, "#d3e8a5")
            end
        end
        if __t(__L1.reeisPhase == "charging" or __L1.reeisPhase == "burst") then
            __L1.ctx:save()
            __L1.ctx.globalAlpha = __L1.reeisPhase == "burst" and 0.55 or 0.2
            __L1.ctx.strokeStyle = "#ffe7ab"
            __L1.ctx.lineWidth = 2
            do
                local i = 0
                while i < 16 do
                    local yy = 20 + i * 33 + math.sin(__L1.time * 15 + i) * 12
                    __L1.ctx:beginPath()
                    __L1.ctx:moveTo(
                        __t(__mod(i, 2)) and 0 or __L1.W,
                        yy
                    )
                    __L1.ctx:lineTo(
                        __t(__mod(i, 2)) and 180 or __L1.W - 180,
                        yy + math.sin(i) * 25
                    )
                    __L1.ctx:stroke()
                    i = i + 1
                end
            end
            __L1.ctx:restore()
        end
        local ____t_3699 = __t
        local ____opt_3697 = __L1.training
        if ____opt_3697 ~= nil then
            ____opt_3697 = ____opt_3697.active
        end
        if ____t_3699(____opt_3697) then
            __L1:drawTraining()
        end
        local ____t_3701 = __t
        local ____t_result_3700
        if __t(__L1.routeTransition) then
            ____t_result_3700 = not __t(__L1.routeTransition.chegada)
        else
            ____t_result_3700 = __L1.routeTransition
        end
        if ____t_3701(____t_result_3700) then
            __L1:drawRouteTransition()
        end
        if __L1.hitFlash > 0 then
            __L1.ctx.fillStyle = ("rgba(225,104,76," .. tostring(__L1.hitFlash * 0.8)) .. ")"
            __L1.ctx:fillRect(0, 0, __L1.W, __L1.H)
        end
        if __L1.transition > 0 then
            __L1.ctx.fillStyle = ("rgba(25,43,35," .. tostring(__L1.transition * 0.5)) .. ")"
            __L1.ctx:fillRect(0, 0, __L1.W, __L1.H)
        end
        __L1:drawEpicScreen()
        __L1.ctx:restore()
    end
    __L1.frame = function(self, now)
        local ____opt_3708 = window.CampanhaPoderes
        if ____opt_3708 ~= nil then
            ____opt_3708 = ____opt_3708.controles
        end
        if ____opt_3708 ~= nil then
            local ____temp_3706 = __L1.scene >= 12
            if not ____temp_3706 then
                local ____t_3705 = __t
                local ____opt_3703 = window.C2Luta
                if ____opt_3703 ~= nil then
                    ____opt_3703 = ____opt_3703.skin
                end
                ____temp_3706 = not not ____t_3705(____opt_3703)
            end
            ____opt_3708(____opt_3708, ____temp_3706)
        end
        local ____t_3722 = __t
        local ____t_result_3721
        local ____t_3715 = __t
        local ____opt_3712 = window.Fliperama
        if ____opt_3712 ~= nil then
            ____opt_3712 = ____opt_3712.isOpen
        end
        local ____opt_result_3714
        if ____opt_3712 ~= nil then
            ____opt_result_3714 = ____opt_3712(____opt_3712)
        end
        __O[2147] = ____opt_result_3714
        if ____t_3715(____opt_result_3714) then
            ____t_result_3721 = __O[2147]
        else
            local ____opt_3718 = window.Campanha2
            if ____opt_3718 ~= nil then
                ____opt_3718 = ____opt_3718.aberto
            end
            local ____opt_result_3720
            if ____opt_3718 ~= nil then
                ____opt_result_3720 = ____opt_3718(____opt_3718)
            end
            ____t_result_3721 = ____opt_result_3720
        end
        if ____t_3722(____t_result_3721) then
            __L1.last = now
            local ____opt_3725 = window.CampaignRun
            if ____opt_3725 ~= nil then
                ____opt_3725 = ____opt_3725.tick
            end
            if ____opt_3725 ~= nil then
                ____opt_3725(____opt_3725, now, false)
            end
            window:requestAnimationFrame(__L1.frame)
            return
        end
        local ____t_3732 = __t
        local ____t_result_3731
        local ____t_3730 = __t
        local ____t_result_3729
        local ____t_3728 = __t
        local ____t_result_3727
        if __t(window.DAROCA_ROBLOX) then
            ____t_result_3727 = not __t(__L1.started)
        else
            ____t_result_3727 = window.DAROCA_ROBLOX
        end
        __O[2148] = ____t_result_3727
        if ____t_3728(____t_result_3727) then
            ____t_result_3729 = __L1["$"](__L1, "startScreen")
        else
            ____t_result_3729 = __O[2148]
        end
        __O[2149] = ____t_result_3729
        if ____t_3730(____t_result_3729) then
            ____t_result_3731 = not __t(__L1["$"](__L1, "startScreen").hidden)
        else
            ____t_result_3731 = __O[2149]
        end
        if ____t_3732(____t_result_3731) then
            window.DAROCA_QUADRO_CAMADAS = -1
            __L1.last = now
            window:requestAnimationFrame(__L1.frame)
            return
        end
        local ____opt_3735 = window.WorldLife
        if ____opt_3735 ~= nil then
            ____opt_3735 = ____opt_3735.getStatus
        end
        local ____opt_result_3737
        if ____opt_3735 ~= nil then
            ____opt_result_3737 = ____opt_3735(____opt_3735)
        end
        local challenge = ____opt_result_3737
        local ____t_result_3764
        local ____t_3755 = __t
        local ____t_result_3754
        local ____t_3747 = __t
        local ____t_result_3746
        local ____t_3745 = __t
        local ____t_result_3744
        local ____t_3743 = __t
        local ____t_result_3742
        local ____t_3741 = __t
        local ____t_result_3740
        local ____t_3739 = __t
        local ____t_result_3738
        if __t(__L1.started) then
            ____t_result_3738 = not __t(__L1.sandbox)
        else
            ____t_result_3738 = __L1.started
        end
        __O[2150] = ____t_result_3738
        if ____t_3739(____t_result_3738) then
            ____t_result_3740 = not __t(__L1.won)
        else
            ____t_result_3740 = __O[2150]
        end
        __O[2151] = ____t_result_3740
        if ____t_3741(____t_result_3740) then
            ____t_result_3742 = not __t(__L1.chapterEnded)
        else
            ____t_result_3742 = __O[2151]
        end
        __O[2152] = ____t_result_3742
        if ____t_3743(____t_result_3742) then
            ____t_result_3744 = not __t(__L1.defeated)
        else
            ____t_result_3744 = __O[2152]
        end
        __O[2153] = ____t_result_3744
        if ____t_3745(____t_result_3744) then
            ____t_result_3746 = not __t(window.document.hidden)
        else
            ____t_result_3746 = __O[2153]
        end
        __O[2154] = ____t_result_3746
        if ____t_3747(____t_result_3746) then
            local ____t_3753 = __t
            local ____opt_3750 = window.Arena
            if ____opt_3750 ~= nil then
                ____opt_3750 = ____opt_3750.isOpen
            end
            local ____opt_result_3752
            if ____opt_3750 ~= nil then
                ____opt_result_3752 = ____opt_3750(____opt_3750)
            end
            ____t_result_3754 = not ____t_3753(____opt_result_3752)
        else
            ____t_result_3754 = __O[2154]
        end
        __O[2157] = ____t_result_3754
        if ____t_3755(____t_result_3754) then
            local ____t_result_3763
            local ____t_3757 = __t
            local ____temp_3756 = not __t(__L1.paused)
            __O[2156] = ____temp_3756
            if ____t_3757(____temp_3756) then
                ____t_result_3763 = __O[2156]
            else
                local ____t_result_3762
                local ____t_3761 = __t
                local ____opt_result_3760
                if challenge ~= nil then
                    ____opt_result_3760 = challenge.open
                end
                __O[2155] = ____opt_result_3760
                if ____t_3761(____opt_result_3760) then
                    ____t_result_3762 = challenge.stage == "live"
                else
                    ____t_result_3762 = __O[2155]
                end
                ____t_result_3763 = ____t_result_3762
            end
            ____t_result_3764 = ____t_result_3763
        else
            ____t_result_3764 = __O[2157]
        end
        local counting = ____t_result_3764
        local ____opt_3767 = window.CampaignRun
        if ____opt_3767 ~= nil then
            ____opt_3767 = ____opt_3767.tick
        end
        if ____opt_3767 ~= nil then
            ____opt_3767(____opt_3767, now, counting)
        end
        local ____t_3778 = __t
        local ____t_result_3777
        local ____t_3770 = __t
        local ____t_result_3769
        if __t(counting) then
            ____t_result_3769 = not __t(__L1.cutscene)
        else
            ____t_result_3769 = counting
        end
        __O[2158] = ____t_result_3769
        if ____t_3770(____t_result_3769) then
            local ____t_3776 = __t
            local ____opt_3773 = window.SwiftGuide
            if ____opt_3773 ~= nil then
                ____opt_3773 = ____opt_3773.isOpen
            end
            local ____opt_result_3775
            if ____opt_3773 ~= nil then
                ____opt_result_3775 = ____opt_3773(____opt_3773)
            end
            ____t_result_3777 = not ____t_3776(____opt_result_3775)
        else
            ____t_result_3777 = __O[2158]
        end
        if ____t_3778(____t_result_3777) then
            local ____opt_3781 = window.CampaignRun
            if ____opt_3781 ~= nil then
                ____opt_3781 = ____opt_3781.confirmInitialMode
            end
            if ____opt_3781 ~= nil then
                ____opt_3781(____opt_3781)
            end
        end
        local dt = math.min(0.035, (now - __L1.last) / 1000)
        __L1.last = now
        local ____t_3792 = __t
        local ____t_result_3791
        local ____t_3790 = __t
        local ____t_result_3789
        local ____t_3788 = __t
        local ____t_result_3787
        local ____t_3786 = __t
        local ____t_result_3785
        local ____t_3784 = __t
        local ____temp_3783 = __L1.hitStop > 0
        __O[2159] = ____temp_3783
        if ____t_3784(____temp_3783) then
            ____t_result_3785 = __L1.started
        else
            ____t_result_3785 = __O[2159]
        end
        __O[2160] = ____t_result_3785
        if ____t_3786(____t_result_3785) then
            ____t_result_3787 = not __t(__L1.cutscene)
        else
            ____t_result_3787 = __O[2160]
        end
        __O[2161] = ____t_result_3787
        if ____t_3788(____t_result_3787) then
            ____t_result_3789 = not __t(__L1.paused)
        else
            ____t_result_3789 = __O[2161]
        end
        __O[2162] = ____t_result_3789
        if ____t_3790(____t_result_3789) then
            ____t_result_3791 = not __t(__L1.dialog)
        else
            ____t_result_3791 = __O[2162]
        end
        if ____t_3792(____t_result_3791) then
            __L1.hitStop = math.max(0, __L1.hitStop - dt)
        else
            __L1.hitStop = 0
            __L1:update(dt)
            local ____t_3800 = __t
            local ____t_result_3799
            local ____t_3798 = __t
            local ____t_result_3797
            local ____t_3796 = __t
            local ____t_result_3795
            local ____t_3794 = __t
            local ____t_result_3793
            if __t(__L1.started) then
                ____t_result_3793 = not __t(__L1.cutscene)
            else
                ____t_result_3793 = __L1.started
            end
            __O[2163] = ____t_result_3793
            if ____t_3794(____t_result_3793) then
                ____t_result_3795 = not __t(__L1.room)
            else
                ____t_result_3795 = __O[2163]
            end
            __O[2164] = ____t_result_3795
            if ____t_3796(____t_result_3795) then
                ____t_result_3797 = not __t(__L1.activity)
            else
                ____t_result_3797 = __O[2164]
            end
            __O[2165] = ____t_result_3797
            if ____t_3798(____t_result_3797) then
                ____t_result_3799 = not __t(__L1.ollyanEncounter)
            else
                ____t_result_3799 = __O[2165]
            end
            if ____t_3800(____t_result_3799) then
                local ____opt_3803 = window.SceneLife
                if ____opt_3803 ~= nil then
                    ____opt_3803 = ____opt_3803.update
                end
                if ____opt_3803 ~= nil then
                    ____opt_3803(
                        ____opt_3803,
                        dt,
                        {
                            scene = __L1.scene,
                            player = __L1.player,
                            camera = __L1.camera,
                            time = __L1.time,
                            vehicle = __L1.vehicle,
                            arena = not not __t(__L1.arena),
                            dashing = __L1.dashTimer > 0
                        }
                    )
                end
            end
            local ____t_3814 = __t
            local ____t_result_3813
            local ____t_3812 = __t
            local ____t_result_3811
            local ____t_3810 = __t
            local ____t_result_3809
            local ____t_3808 = __t
            local ____t_result_3807
            local ____t_3806 = __t
            local ____t_result_3805
            if __t(__L1.started) then
                ____t_result_3805 = not __t(__L1.cutscene)
            else
                ____t_result_3805 = __L1.started
            end
            __O[2166] = ____t_result_3805
            if ____t_3806(____t_result_3805) then
                ____t_result_3807 = not __t(__L1.room)
            else
                ____t_result_3807 = __O[2166]
            end
            __O[2167] = ____t_result_3807
            if ____t_3808(____t_result_3807) then
                ____t_result_3809 = not __t(__L1.activity)
            else
                ____t_result_3809 = __O[2167]
            end
            __O[2168] = ____t_result_3809
            if ____t_3810(____t_result_3809) then
                ____t_result_3811 = not __t(__L1.ollyanEncounter)
            else
                ____t_result_3811 = __O[2168]
            end
            __O[2169] = ____t_result_3811
            if ____t_3812(____t_result_3811) then
                ____t_result_3813 = not __t(__L1.arena)
            else
                ____t_result_3813 = __O[2169]
            end
            if ____t_3814(____t_result_3813) then
                local ____opt_3817 = window.HdMaps
                if ____opt_3817 ~= nil then
                    ____opt_3817 = ____opt_3817.touch
                end
                if ____opt_3817 ~= nil then
                    ____opt_3817(
                        ____opt_3817,
                        __L1.scene,
                        __L1.player.x,
                        __L1.player.y,
                        __L1.player.vx,
                        __L1.player.vy
                    )
                end
            end
            if not __t(__L1:terrenoConquista()) then
                local ____opt_3830 = window.Interact
                if ____opt_3830 ~= nil then
                    ____opt_3830 = ____opt_3830.update
                end
                if ____opt_3830 ~= nil then
                    local ____L1_scene_3824 = __L1.scene
                    local ____L1_player_3825 = __L1.player
                    local ____L1_camera_3826 = __L1.camera
                    local ____L1_time_3827 = __L1.time
                    local ____temp_3828 = not not __t(__L1.arena)
                    local ____opt_3820 = __L1.arena
                    if ____opt_3820 ~= nil then
                        ____opt_3820 = ____opt_3820.type
                    end
                    local ____opt_3822 = __L1.arena
                    if ____opt_3822 ~= nil then
                        ____opt_3822 = ____opt_3822.homeX
                    end
                    ____opt_3830(
                        ____opt_3830,
                        dt,
                        {
                            scene = ____L1_scene_3824,
                            player = ____L1_player_3825,
                            camera = ____L1_camera_3826,
                            time = ____L1_time_3827,
                            arena = ____temp_3828,
                            arenaType = ____opt_3820,
                            homeX = ____opt_3822,
                            room = not not __t(__L1.room),
                            shots = __L1.shots,
                            enemies = __L1.enemies,
                            minions = __L1.minions,
                            dashing = __L1.dashTimer > 0
                        }
                    )
                end
            end
            local ____t_3833 = __t
            local ____t_result_3832
            if __t(__L1.activeBoss) then
                ____t_result_3832 = not __t(__L1.activeBoss.conquista)
            else
                ____t_result_3832 = __L1.activeBoss
            end
            if ____t_3833(____t_result_3832) then
                local ____opt_3836 = window.BossFx
                if ____opt_3836 ~= nil then
                    ____opt_3836 = ____opt_3836.update
                end
                if ____opt_3836 ~= nil then
                    ____opt_3836(____opt_3836, dt, {boss = __L1.activeBoss, player = __L1.player})
                end
            end
        end
        __L1:updateEpic(dt)
        __L1.pickupsLater = false
        __L1:draw()
        local ____t_result_3864
        local ____t_3843 = __t
        local ____opt_3840 = window.Graphics
        if ____opt_3840 ~= nil then
            ____opt_3840 = ____opt_3840.isShader
        end
        local ____opt_result_3842
        if ____opt_3840 ~= nil then
            ____opt_result_3842 = ____opt_3840(____opt_3840)
        end
        __O[2175] = ____opt_result_3842
        if ____t_3843(____opt_result_3842) then
            local ____opt_3861 = window.Shader
            if ____opt_3861 ~= nil then
                ____opt_3861 = ____opt_3861.apply
            end
            local ____opt_result_3863
            if ____opt_3861 ~= nil then
                local ____L1_ctx_canvas_3859 = __L1.ctx.canvas
                local ____L1_scene_3856 = __L1.scene
                local ____L1_camera_3857 = __L1.camera
                local ____L1_time_3858 = __L1.time
                local ____t_result_3855
                local ____t_3854 = __t
                local ____t_result_3853
                local ____t_3852 = __t
                local ____t_result_3851
                local ____t_3850 = __t
                local ____t_result_3849
                local ____t_3848 = __t
                local ____t_result_3847
                local ____t_3846 = __t
                local ____t_result_3845
                if __t(__L1.started) then
                    ____t_result_3845 = not __t(__L1.cutscene)
                else
                    ____t_result_3845 = __L1.started
                end
                __O[2170] = ____t_result_3845
                if ____t_3846(____t_result_3845) then
                    ____t_result_3847 = not __t(__L1.room)
                else
                    ____t_result_3847 = __O[2170]
                end
                __O[2171] = ____t_result_3847
                if ____t_3848(____t_result_3847) then
                    ____t_result_3849 = not __t(__L1.activity)
                else
                    ____t_result_3849 = __O[2171]
                end
                __O[2172] = ____t_result_3849
                if ____t_3850(____t_result_3849) then
                    ____t_result_3851 = not __t(__L1.ollyanEncounter)
                else
                    ____t_result_3851 = __O[2172]
                end
                __O[2173] = ____t_result_3851
                if ____t_3852(____t_result_3851) then
                    ____t_result_3853 = not __t(__L1.arena)
                else
                    ____t_result_3853 = __O[2173]
                end
                __O[2174] = ____t_result_3853
                if ____t_3854(____t_result_3853) then
                    ____t_result_3855 = __call(
                        __arrL({
                            0,
                            1,
                            3,
                            4,
                            5,
                            7,
                            9
                        }, 7),
                        "includes",
                        __L1.scene
                    )
                else
                    ____t_result_3855 = __O[2174]
                end
                ____opt_result_3863 = ____opt_3861(____opt_3861, ____L1_ctx_canvas_3859, {scene = ____L1_scene_3856, camera = ____L1_camera_3857, time = ____L1_time_3858, outdoor = ____t_result_3855})
            end
            ____t_result_3864 = ____opt_result_3863
        else
            ____t_result_3864 = __O[2175]
        end
        local shaded = ____t_result_3864
        local ____t_3868 = __t
        local ____t_result_3867
        if __t(__L1.pickupsLater) then
            local ____t_3866 = __t
            local ____t_result_3865
            if __t(__L1.routeTransition) then
                ____t_result_3865 = not __t(__L1.routeTransition.chegada)
            else
                ____t_result_3865 = __L1.routeTransition
            end
            ____t_result_3867 = not ____t_3866(____t_result_3865)
        else
            ____t_result_3867 = __L1.pickupsLater
        end
        if ____t_3868(____t_result_3867) then
            local ____t_result_3876
            local ____t_3875 = __t
            local ____t_result_3874
            if __t(shaded) then
                local ____opt_3871 = window.Shader
                if ____opt_3871 ~= nil then
                    ____opt_3871 = ____opt_3871.items
                end
                local ____opt_result_3873
                if ____opt_3871 ~= nil then
                    ____opt_result_3873 = ____opt_3871(____opt_3871)
                end
                ____t_result_3874 = ____opt_result_3873
            else
                ____t_result_3874 = shaded
            end
            __O[2176] = ____t_result_3874
            if ____t_3875(____t_result_3874) then
                ____t_result_3876 = __O[2176]
            else
                ____t_result_3876 = __L1.ctx
            end
            local g = ____t_result_3876
            g:save()
            g:setTransform(
                1,
                0,
                0,
                1,
                0,
                0
            )
            g.imageSmoothingEnabled = false
            g:translate(
                -math.floor(__L1.camera + 0.5),
                0
            )
            do
                local ____try, ____error = pcall(function()
                    __L1:drawPickupsNow(g)
                end)
                do
                    g:restore()
                end
                if not ____try then
                    error(____error, 0)
                end
            end
        end
        window:requestAnimationFrame(__L1.frame)
    end
    __L1.refreshTouchState = function(self)
        __L1.touch = {}
        for ____, p in __iterar((__call(__L1.activePointers, "values"))) do
            if __t(__call(__L1.heldActions, "has", p.action)) then
                __set(__L1.touch, p.action, true)
            end
        end
        __call(
            window.document:querySelectorAll("[data-action]"),
            "forEach",
            function(____, el) return el.classList:toggle(
                "pressed",
                __call(
                    __arr(__TS__Spread(__iter(__call(__L1.activePointers, "values")))),
                    "some",
                    function(____, p) return p.element == el end
                )
            ) end
        )
    end
    __L1.releasePointer = function(self, id)
        local p = __call(__L1.activePointers, "get", id)
        if not __t(p) then
            return
        end
        __call(__L1.activePointers, "delete", id)
        __L1:safe(function()
            local ____t_3879 = __t
            local ____this_3878
            ____this_3878 = p.element
            local ____opt_3877 = ____this_3878.hasPointerCapture
            if ____opt_3877 ~= nil then
                ____opt_3877 = ____opt_3877(____this_3878, id)
            end
            if ____t_3879(____opt_3877) then
                p.element:releasePointerCapture(id)
            end
        end)
        __L1:refreshTouchState()
    end
    __L1.releaseInputs = function(self)
        if __t(__L1.releasingInputs) then
            return
        end
        __L1.releasingInputs = true
        local captures = __arr(__TS__Spread(__iter(__call(__L1.activePointers, "entries"))))
        __call(__L1.activePointers, "clear")
        __L1.keys = {}
        __L1.touch = {}
        __L1.joystick = {x = 0, y = 0}
        __L1.prevJump = false
        if __t(__L1.player) then
            __L1.player.vx = 0
        end
        for ____, ____value in __iterar((captures)) do
            local id = ____value[1]
            local p = ____value[2]
            __L1:safe(function()
                local ____t_3882 = __t
                local ____this_3881
                ____this_3881 = p.element
                local ____opt_3880 = ____this_3881.hasPointerCapture
                if ____opt_3880 ~= nil then
                    ____opt_3880 = ____opt_3880(____this_3881, id)
                end
                if ____t_3882(____opt_3880) then
                    p.element:releasePointerCapture(id)
                end
            end)
        end
        __call(
            window.document:querySelectorAll("[data-action]"),
            "forEach",
            function(____, el) return el.classList:remove("pressed") end
        )
        __L1:emitGameEvent("game-input-reset")
        __L1.releasingInputs = false
    end
    __L1.reconcileTouches = function(self, e)
        if not __t(e.touches) then
            return
        end
        local remaining = __arrayFrom(e.touches)
        local records = __call(
            __arr(__TS__Spread(__iter(__call(__L1.activePointers, "entries")))),
            "filter",
            function(____, ____bindingPattern0)
                local p
                p = ____bindingPattern0[2]
                return p.pointerType == "touch"
            end
        )
        local matched = __TS__New(Set)
        for ____, t in __iterar((remaining)) do
            local best = nil
            local distance = math.huge
            for ____, ____value in __iterar((records)) do
                local id = ____value[1]
                local p = ____value[2]
                do
                    if __t(__call(matched, "has", id)) then
                        continue
                    end
                    local ____t_result_3887
                    local ____t_3884 = __t
                    local ____temp_3883 = t.target == p.element
                    __O[2207] = ____temp_3883
                    if ____t_3884(____temp_3883) then
                        ____t_result_3887 = __O[2207]
                    else
                        local ____this_3886
                        ____this_3886 = p.element
                        local ____opt_3885 = ____this_3886.contains
                        if ____opt_3885 ~= nil then
                            ____opt_3885 = ____opt_3885(____this_3886, t.target)
                        end
                        ____t_result_3887 = ____opt_3885
                    end
                    local sameTarget = ____t_result_3887
                    local ____hypot_3891 = __hypot
                    local ____t_clientX_3888 = t.clientX
                    if ____t_clientX_3888 == nil then
                        ____t_clientX_3888 = p.x
                    end
                    local ____temp_3890 = ____t_clientX_3888 - p.x
                    local ____t_clientY_3889 = t.clientY
                    if ____t_clientY_3889 == nil then
                        ____t_clientY_3889 = p.y
                    end
                    local dist = ____hypot_3891(____temp_3890, ____t_clientY_3889 - p.y)
                    local ____t_3895 = __t
                    local ____t_result_3894
                    local ____t_3893 = __t
                    local ____t_result_3892
                    if __t(sameTarget) then
                        ____t_result_3892 = sameTarget
                    else
                        ____t_result_3892 = not __t(t.target) and dist < 60
                    end
                    __O[2208] = ____t_result_3892
                    if ____t_3893(____t_result_3892) then
                        ____t_result_3894 = dist < distance
                    else
                        ____t_result_3894 = __O[2208]
                    end
                    if ____t_3895(____t_result_3894) then
                        best = id
                        distance = dist
                    end
                end
            end
            if best ~= nil then
                __call(matched, "add", best)
            end
        end
        for ____, ____value in __iterar((records)) do
            local id = ____value[1]
            if not __t(__call(matched, "has", id)) then
                __L1:releasePointer(id)
            end
        end
    end
    __L1.setSoundEnabled = function(self, value)
        __L1.sound = not not __t(value)
        local button = __L1["$"](__L1, "soundBtn")
        if __t(button) then
            button.classList:toggle("active", __L1.sound)
            button.classList:toggle(
                "muted",
                not __t(__L1.sound)
            )
            button:setAttribute(
                "aria-pressed",
                tostring(__L1.sound)
            )
            button.title = __t(__L1.sound) and "Desligar som" or "Ligar som"
            button.textContent = __t(__L1.sound) and "♫" or "♪"
        end
        __L1:setText(
            "soundState",
            __t(__L1.sound) and "Som ligado" or "Som desligado"
        )
    end
    __L1.getAudioState = function(self)
        local ____t_result_3901
        if __t(__L1.ollyanEncounter) then
            local ____opt_3898 = window.OllyanEncounter
            if ____opt_3898 ~= nil then
                ____opt_3898 = ____opt_3898.getAudioState
            end
            local ____opt_result_3900
            if ____opt_3898 ~= nil then
                ____opt_result_3900 = ____opt_3898(____opt_3898, __L1.ollyanEncounter)
            end
            ____t_result_3901 = ____opt_result_3900
        else
            ____t_result_3901 = nil
        end
        local flight = ____t_result_3901
        local ____L1_started_3999 = __L1.started
        local ____L1_playing_4000 = __L1.playing
        local ____L1_paused_4001 = __L1.paused
        local ____L1_scene_4002 = __L1.scene
        local ____t_result_3905
        local ____t_3904 = __t
        local ____opt_3902 = __L1.room
        if ____opt_3902 ~= nil then
            ____opt_3902 = ____opt_3902.id
        end
        __O[2230] = ____opt_3902
        if ____t_3904(____opt_3902) then
            ____t_result_3905 = __O[2230]
        else
            ____t_result_3905 = nil
        end
        local ____t_result_3914
        local ____t_3913 = __t
        local ____t_result_3912
        local ____t_3909 = __t
        local ____opt_result_3908
        if flight ~= nil then
            ____opt_result_3908 = flight.boss
        end
        __O[2231] = ____opt_result_3908
        if ____t_3909(____opt_result_3908) then
            ____t_result_3912 = __O[2231]
        else
            local ____opt_3910 = __L1.activeBoss
            if ____opt_3910 ~= nil then
                ____opt_3910 = ____opt_3910.type
            end
            ____t_result_3912 = ____opt_3910
        end
        __O[2232] = ____t_result_3912
        if ____t_3913(____t_result_3912) then
            ____t_result_3914 = __O[2232]
        else
            ____t_result_3914 = nil
        end
        local ____t_result_3919
        if __t(__L1.ollyanEncounter) then
            ____t_result_3919 = window.OllyanEncounter:getStatus(__L1.ollyanEncounter).phase
        else
            local ____t_result_3918
            local ____t_3917 = __t
            local ____opt_3915 = __L1.activeBoss
            if ____opt_3915 ~= nil then
                ____opt_3915 = ____opt_3915.phase
            end
            __O[2233] = ____opt_3915
            if ____t_3917(____opt_3915) then
                ____t_result_3918 = __O[2233]
            else
                ____t_result_3918 = nil
            end
            ____t_result_3919 = ____t_result_3918
        end
        local ____t_result_3928
        local ____t_3927 = __t
        local ____t_result_3926
        local ____t_3923 = __t
        local ____opt_result_3922
        if flight ~= nil then
            ____opt_result_3922 = flight.cutscene
        end
        __O[2234] = ____opt_result_3922
        if ____t_3923(____opt_result_3922) then
            ____t_result_3926 = __O[2234]
        else
            local ____opt_3924 = __L1.cutscene
            if ____opt_3924 ~= nil then
                ____opt_3924 = ____opt_3924.kind
            end
            ____t_result_3926 = ____opt_3924
        end
        __O[2235] = ____t_result_3926
        if ____t_3927(____t_result_3926) then
            ____t_result_3928 = __O[2235]
        else
            ____t_result_3928 = nil
        end
        local ____t_result_3937
        local ____t_3936 = __t
        local ____t_result_3935
        local ____t_3932 = __t
        local ____opt_result_3931
        if flight ~= nil then
            ____opt_result_3931 = flight.cutsceneToken
        end
        __O[2236] = ____opt_result_3931
        if ____t_3932(____opt_result_3931) then
            ____t_result_3935 = __O[2236]
        else
            local ____opt_3933 = __L1.cutscene
            if ____opt_3933 ~= nil then
                ____opt_3933 = ____opt_3933.audioToken
            end
            ____t_result_3935 = ____opt_3933
        end
        __O[2237] = ____t_result_3935
        if ____t_3936(____t_result_3935) then
            ____t_result_3937 = __O[2237]
        else
            ____t_result_3937 = nil
        end
        local ____t_result_3953
        local ____t_3941 = __t
        local ____opt_result_3940
        if flight ~= nil then
            ____opt_result_3940 = flight.cutscene
        end
        if ____t_3941(____opt_result_3940) then
            ____t_result_3953 = flight.cutsceneElapsed
        else
            local ____t_result_3952
            if __t(__L1.cutscene) then
                local ____t_result_3951
                local ____t_3950 = __t
                local ____opt_3944 = window.Cinematics
                if ____opt_3944 ~= nil then
                    ____opt_3944 = ____opt_3944.timelinePosition
                end
                local ____opt_result_3946
                if ____opt_3944 ~= nil then
                    ____opt_result_3946 = ____opt_3944(____opt_3944, __L1.cutscene)
                end
                local ____opt_result_3946_3947 = ____opt_result_3946
                if ____opt_result_3946_3947 == nil then
                    ____opt_result_3946_3947 = __L1.cutscene.elapsed
                end
                local ____opt_result_3946_3947_3948 = ____opt_result_3946_3947
                if ____opt_result_3946_3947_3948 == nil then
                    ____opt_result_3946_3947_3948 = __L1.cutscene.audioElapsed
                end
                local ____TS__Number_result_3949 = __TS__Number(____opt_result_3946_3947_3948)
                __O[2238] = ____TS__Number_result_3949
                if ____t_3950(____TS__Number_result_3949) then
                    ____t_result_3951 = __O[2238]
                else
                    ____t_result_3951 = 0
                end
                ____t_result_3952 = math.max(0, ____t_result_3951)
            else
                ____t_result_3952 = 0
            end
            ____t_result_3953 = ____t_result_3952
        end
        local ____t_result_3961
        local ____t_3957 = __t
        local ____opt_result_3956
        if flight ~= nil then
            ____opt_result_3956 = flight.cutscene
        end
        if ____t_3957(____opt_result_3956) then
            ____t_result_3961 = flight.cutsceneIndex
        else
            local ____opt_3958 = __L1.cutscene
            if ____opt_3958 ~= nil then
                ____opt_3958 = ____opt_3958.index
            end
            local ____opt_3958_3960 = ____opt_3958
            if ____opt_3958_3960 == nil then
                ____opt_3958_3960 = nil
            end
            ____t_result_3961 = ____opt_3958_3960
        end
        local ____t_3965 = __t
        local ____opt_result_3964
        if flight ~= nil then
            ____opt_result_3964 = flight.cutsceneTimed
        end
        local ____temp_3972 = not not ____t_3965(____opt_result_3964)
        if not ____temp_3972 then
            local ____t_3971 = __t
            local ____opt_3968 = __L1.cutscene
            if ____opt_3968 ~= nil then
                ____opt_3968 = ____opt_3968.options
            end
            local ____opt_result_3970
            if ____opt_3968 ~= nil then
                ____opt_result_3970 = ____opt_3968.musicTimed
            end
            ____temp_3972 = not not ____t_3971(____opt_result_3970)
        end
        local ____t_3975 = __t
        local ____opt_3973 = __L1.training
        if ____opt_3973 ~= nil then
            ____opt_3973 = ____opt_3973.active
        end
        local ____temp_4003 = not not ____t_3975(____opt_3973)
        local ____t_result_3981
        local ____t_3980 = __t
        local ____t_result_3979
        local ____t_3978 = __t
        local ____opt_3976 = __L1.activity
        if ____opt_3976 ~= nil then
            ____opt_3976 = ____opt_3976.kind
        end
        __O[2239] = ____opt_3976
        if ____t_3978(____opt_3976) then
            ____t_result_3979 = __O[2239]
        else
            ____t_result_3979 = __L1.activityCallback
        end
        __O[2240] = ____t_result_3979
        if ____t_3980(____t_result_3979) then
            ____t_result_3981 = __O[2240]
        else
            ____t_result_3981 = nil
        end
        local ____t_result_3995
        local ____t_3987 = __t
        local ____opt_3984 = window.SwiftGuide
        if ____opt_3984 ~= nil then
            ____opt_3984 = ____opt_3984.isOpen
        end
        local ____opt_result_3986
        if ____opt_3984 ~= nil then
            ____opt_result_3986 = ____opt_3984(____opt_3984)
        end
        if ____t_3987(____opt_result_3986) then
            ____t_result_3995 = "Irmão de Clara Swift"
        else
            local ____t_result_3994
            local ____t_3993 = __t
            local ____getq_3992 = __getq
            local ____opt_3990 = __L1.dialog
            if ____opt_3990 ~= nil then
                ____opt_3990 = ____opt_3990.lines
            end
            local ____opt_3988 = ____getq_3992(____opt_3990, __L1.dialog.index)
            if ____opt_3988 ~= nil then
                ____opt_3988 = ____opt_3988.name
            end
            __O[2241] = ____opt_3988
            if ____t_3993(____opt_3988) then
                ____t_result_3994 = __O[2241]
            else
                ____t_result_3994 = nil
            end
            ____t_result_3995 = ____t_result_3994
        end
        local ____L1_reeisPhase_4004 = __L1.reeisPhase
        local ____L1_sound_4005 = __L1.sound
        local ____t_result_3998
        if __t(__L1.defeated) then
            ____t_result_3998 = __L1.defeated
        else
            local ____opt_3996 = __L1.ollyanEncounter
            if ____opt_3996 ~= nil then
                ____opt_3996 = ____opt_3996.stage
            end
            ____t_result_3998 = ____opt_3996 == "defeat"
        end
        return {
            started = ____L1_started_3999,
            playing = ____L1_playing_4000,
            paused = ____L1_paused_4001,
            scene = ____L1_scene_4002,
            room = ____t_result_3905,
            boss = ____t_result_3914,
            bossPhase = ____t_result_3919,
            cutscene = ____t_result_3928,
            cutsceneToken = ____t_result_3937,
            cutsceneElapsed = ____t_result_3953,
            cutsceneIndex = ____t_result_3961,
            cutsceneTimed = ____temp_3972,
            training = ____temp_4003,
            activity = ____t_result_3981,
            dialogue = ____t_result_3995,
            reeis = ____L1_reeisPhase_4004,
            sound = ____L1_sound_4005,
            defeated = ____t_result_3998,
            chapterEnded = __L1.chapterEnded
        }
    end
    __L1.getBossStatus = function(self)
        if __t(__L1.ollyanEncounter) then
            local status = window.OllyanEncounter:getStatus(__L1.ollyanEncounter)
            local ____t_result_4021
            if __t(status.active) then
                local ____assign_4020 = __assign
                local ____temp_4019 = {}
                local ____t_result_4006
                if __t(status.phases) then
                    ____t_result_4006 = status.phases
                else
                    ____t_result_4006 = 3
                end
                local ____status_max_4017 = status.max
                local ____status_stage_4018 = status.stage
                local ____t_result_4016
                local ____t_4015 = __t
                local ____opt_4011 = window.Difficulty
                if ____opt_4011 ~= nil then
                    ____opt_4011 = ____opt_4011.getSettings
                end
                local ____opt_result_4013
                if ____opt_4011 ~= nil then
                    ____opt_result_4013 = ____opt_4011(____opt_4011, __L1.ollyanEncounter.options.difficultyMode)
                end
                local ____opt_result_4014
                if ____opt_result_4013 ~= nil then
                    ____opt_result_4014 = ____opt_result_4013.label
                end
                __O[2242] = ____opt_result_4014
                if ____t_4015(____opt_result_4014) then
                    ____t_result_4016 = __O[2242]
                else
                    ____t_result_4016 = "NORMAL"
                end
                ____t_result_4021 = ____assign_4020(____temp_4019, status, {
                    phaseCount = ____t_result_4006,
                    phaseBars = 3,
                    phaseMaxHp = ____status_max_4017,
                    state = ____status_stage_4018,
                    difficulty = ____t_result_4016
                })
            else
                ____t_result_4021 = nil
            end
            return ____t_result_4021
        end
        local e = __L1.activeBoss
        if __t(not __t(e) or __le(e.hp, 0)) then
            return nil
        end
        local ____t_result_4024
        local ____t_4023 = __t
        local ____temp_4022 = __L1:nomeBoss(e.type)
        __O[2243] = ____temp_4022
        if ____t_4023(____temp_4022) then
            ____t_result_4024 = __O[2243]
        else
            ____t_result_4024 = e.type
        end
        local ____t_result_4028
        local ____t_4027 = __t
        local ____opt_4025 = e.conquista
        if ____opt_4025 ~= nil then
            ____opt_4025 = ____opt_4025.slug
        end
        __O[2244] = ____opt_4025
        if ____t_4027(____opt_4025) then
            ____t_result_4028 = __O[2244]
        else
            ____t_result_4028 = e.type
        end
        local ____t_result_4029
        if __t(e.conquista) then
            ____t_result_4029 = __getq(
                window.ConquistaCombate:capitulo(e.conquista),
                0
            )
        else
            ____t_result_4029 = nil
        end
        local ____math_max_result_4055 = math.max(0, e.hp)
        local ____e_max_4056 = e.max
        local ____t_result_4030
        if __t(e.phase) then
            ____t_result_4030 = e.phase
        else
            ____t_result_4030 = 1
        end
        local ____temp_4032
        if e.type == "giant" then
            ____temp_4032 = 3
        else
            local ____t_result_4031
            if __t(e.phaseCount) then
                ____t_result_4031 = e.phaseCount
            else
                ____t_result_4031 = 3
            end
            ____temp_4032 = ____t_result_4031
        end
        local ____temp_4034
        if e.type == "giant" then
            ____temp_4034 = 1
        else
            local ____t_result_4033
            if __t(e.phaseCount) then
                ____t_result_4033 = e.phaseCount
            else
                ____t_result_4033 = 3
            end
            ____temp_4034 = ____t_result_4033
        end
        local ____e_max_4057 = e.max
        local ____temp_4036
        if e.type == "nikolas" then
            local ____t_result_4035
            if __t(e.form) then
                ____t_result_4035 = e.form
            else
                ____t_result_4035 = "normal"
            end
            ____temp_4036 = ____t_result_4035
        else
            ____temp_4036 = nil
        end
        local ____e_state_4058 = e.state
        local ____t_result_4037
        if __t(e.charge) then
            ____t_result_4037 = e.charge
        else
            ____t_result_4037 = 0
        end
        local ____t_result_4044
        local ____t_4043 = __t
        local ____opt_4040 = window.C2Luta
        if ____opt_4040 ~= nil then
            ____opt_4040 = ____opt_4040.skin
        end
        local ____opt_result_4042
        if ____opt_4040 ~= nil then
            ____opt_result_4042 = ____opt_4040.nivel
        end
        __O[2245] = ____opt_result_4042
        if ____t_4043(____opt_result_4042) then
            ____t_result_4044 = __O[2245]
        else
            ____t_result_4044 = __L1:bossProfile(e).level
        end
        local ____t_result_4054
        local ____t_4053 = __t
        local ____opt_4049 = window.Difficulty
        if ____opt_4049 ~= nil then
            ____opt_4049 = ____opt_4049.getSettings
        end
        local ____opt_result_4051
        if ____opt_4049 ~= nil then
            ____opt_result_4051 = ____opt_4049(____opt_4049, e.difficultyMode)
        end
        local ____opt_result_4052
        if ____opt_result_4051 ~= nil then
            ____opt_result_4052 = ____opt_result_4051.label
        end
        __O[2246] = ____opt_result_4052
        if ____t_4053(____opt_result_4052) then
            ____t_result_4054 = __O[2246]
        else
            ____t_result_4054 = "NORMAL"
        end
        return {
            name = ____t_result_4024,
            type = ____t_result_4028,
            phaseName = ____t_result_4029,
            hp = ____math_max_result_4055,
            max = ____e_max_4056,
            phase = ____t_result_4030,
            phaseCount = ____temp_4032,
            phaseBars = ____temp_4034,
            phaseMaxHp = ____e_max_4057,
            form = ____temp_4036,
            state = ____e_state_4058,
            charge = ____t_result_4037,
            recommendedLevel = ____t_result_4044,
            difficulty = ____t_result_4054
        }
    end
    __L1.sandboxUnlocked = function(self)
        local ____t_4067 = __t
        local ____t_result_4066
        local ____t_4065 = __t
        local ____t_result_4064
        if __t(__L1.q.jorgeSeen) then
            ____t_result_4064 = __L1.q.jorgeSeen
        else
            local ____opt_4061 = __L1:load()
            if ____opt_4061 ~= nil then
                ____opt_4061 = ____opt_4061.q
            end
            local ____opt_result_4063
            if ____opt_4061 ~= nil then
                ____opt_result_4063 = ____opt_4061.jorgeSeen
            end
            ____t_result_4064 = ____opt_result_4063
        end
        __O[2247] = ____t_result_4064
        if ____t_4065(____t_result_4064) then
            ____t_result_4066 = __O[2247]
        else
            ____t_result_4066 = __L1:safe(function() return window.localStorage:getItem("daroca-sandbox-v1") == "1" end)
        end
        return not not ____t_4067(____t_result_4066)
    end
    __L1.finishSandbox = function(self, result)
        if not __t(__L1.sandbox) then
            return
        end
        __L1:releaseInputs()
        __L1.sandbox.result = result
        __L1.shots = __arrL({}, 0)
        __L1.hazards = __arrL({}, 0)
        __L1.minions = __arrL({}, 0)
        __L1:resetBivolt()
        __L1.reeisPhase = "idle"
        __L1.reeisTimer = 0
        __L1.player.inv = 10
        __L1.paused = true
        __L1.defeated = false
        __L1:show("defeatScreen", false)
        local ____L1_show_4071 = __L1.show
        local ____t_4070 = __t
        local ____opt_4068 = window.C2Luta
        if ____opt_4068 ~= nil then
            ____opt_4068 = ____opt_4068.skin
        end
        ____L1_show_4071(
            __L1,
            "pauseScreen",
            not ____t_4070(____opt_4068)
        )
        __L1:updateUI()
        __L1:emitGameEvent("sandbox-change", {type = __L1.sandbox.type, result = result})
    end
    __L1.startSandboxBoss = function(self, ____type)
        if __t(not __t(__call(__L1.sandboxScenes, "hasOwnProperty", ____type)) or not __t(__L1:sandboxUnlocked())) then
            return false
        end
        local ____t_4094 = __t
        local ____t_result_4093
        local ____t_4073 = __t
        local ____temp_4072 = not __t(__L1.sandbox)
        __O[2256] = ____temp_4072
        if ____t_4073(____temp_4072) then
            local ____t_result_4092
            local ____t_4091 = __t
            local ____t_result_4090
            local ____t_4089 = __t
            local ____t_result_4088
            local ____t_4085 = __t
            local ____t_result_4084
            local ____t_4083 = __t
            local ____t_result_4082
            local ____t_4081 = __t
            local ____t_result_4080
            local ____t_4079 = __t
            local ____t_result_4078
            local ____t_4077 = __t
            local ____t_result_4076
            local ____t_4075 = __t
            local ____t_result_4074
            if __t(__L1.dialog) then
                ____t_result_4074 = __L1.dialog
            else
                ____t_result_4074 = __L1.cutscene
            end
            __O[2248] = ____t_result_4074
            if ____t_4075(____t_result_4074) then
                ____t_result_4076 = __O[2248]
            else
                ____t_result_4076 = __L1.activeBoss
            end
            __O[2249] = ____t_result_4076
            if ____t_4077(____t_result_4076) then
                ____t_result_4078 = __O[2249]
            else
                ____t_result_4078 = __L1.arena
            end
            __O[2250] = ____t_result_4078
            if ____t_4079(____t_result_4078) then
                ____t_result_4080 = __O[2250]
            else
                ____t_result_4080 = __L1.room
            end
            __O[2251] = ____t_result_4080
            if ____t_4081(____t_result_4080) then
                ____t_result_4082 = __O[2251]
            else
                ____t_result_4082 = __L1.routeTransition
            end
            __O[2252] = ____t_result_4082
            if ____t_4083(____t_result_4082) then
                ____t_result_4084 = __O[2252]
            else
                ____t_result_4084 = __L1.activity
            end
            __O[2253] = ____t_result_4084
            if ____t_4085(____t_result_4084) then
                ____t_result_4088 = __O[2253]
            else
                local ____opt_4086 = __L1.training
                if ____opt_4086 ~= nil then
                    ____opt_4086 = ____opt_4086.active
                end
                ____t_result_4088 = ____opt_4086
            end
            __O[2254] = ____t_result_4088
            if ____t_4089(____t_result_4088) then
                ____t_result_4090 = __O[2254]
            else
                ____t_result_4090 = __L1.ollyanEncounter
            end
            __O[2255] = ____t_result_4090
            if ____t_4091(____t_result_4090) then
                ____t_result_4092 = __O[2255]
            else
                ____t_result_4092 = __L1:bivoltStatus().active
            end
            ____t_result_4093 = ____t_result_4092
        else
            ____t_result_4093 = __O[2256]
        end
        if ____t_4094(____t_result_4093) then
            __L1:toast("Termine a cena, conversa ou confronto antes de abrir a revanche.")
            return false
        end
        if not __t(__L1.sandbox) then
            local ____opt_4097 = window.CampaignRun
            if ____opt_4097 ~= nil then
                ____opt_4097 = ____opt_4097.setSuspended
            end
            if ____opt_4097 ~= nil then
                ____opt_4097(____opt_4097, true)
            end
            local ____type_4135 = ____type
            local ____L1_copyState_4134 = __L1.copyState
            local ____t_result_4105
            local ____t_4104 = __t
            local ____opt_4101 = window.Difficulty
            if ____opt_4101 ~= nil then
                ____opt_4101 = ____opt_4101.getMode
            end
            local ____opt_result_4103
            if ____opt_4101 ~= nil then
                ____opt_result_4103 = ____opt_4101(____opt_4101)
            end
            __O[2257] = ____opt_result_4103
            if ____t_4104(____opt_result_4103) then
                ____t_result_4105 = __O[2257]
            else
                ____t_result_4105 = "normal"
            end
            local ____L1_started_4111 = __L1.started
            local ____L1_playing_4112 = __L1.playing
            local ____L1_paused_4113 = __L1.paused
            local ____L1_won_4114 = __L1.won
            local ____L1_defeated_4115 = __L1.defeated
            local ____L1_chapterEnded_4116 = __L1.chapterEnded
            local ____L1_scene_4117 = __L1.scene
            local ____L1_camera_4118 = __L1.camera
            local ____L1_player_4119 = __L1.player
            local ____L1_q_4120 = __L1.q
            local ____L1_items_4121 = __L1.items
            local ____L1_collected_4122 = __L1.collected
            local ____L1_weapon_4123 = __L1.weapon
            local ____L1_minionKills_4124 = __L1.minionKills
            local ____L1_seenBossIntros_4125 = __L1.seenBossIntros
            local ____L1_killCount_4126 = __L1.killCount
            local ____L1_lastSafeX_4127 = __L1.lastSafeX
            local ____L1_respawnCheckpoint_4128 = __L1.respawnCheckpoint
            local ____L1_vehicle_4129 = __L1.vehicle
            local ____L1_enemies_4130 = __L1.enemies
            local ____L1_minions_4131 = __L1.minions
            local ____L1_pickups_4132 = __L1.pickups
            local ____L1_targets_4133 = __L1.targets
            local ____opt_4108 = window.Progression
            if ____opt_4108 ~= nil then
                ____opt_4108 = ____opt_4108.serialize
            end
            local ____opt_result_4110
            if ____opt_4108 ~= nil then
                ____opt_result_4110 = ____opt_4108(____opt_4108)
            end
            __L1.sandbox = {
                type = ____type_4135,
                result = nil,
                snapshot = ____L1_copyState_4134(__L1, {
                    difficultyMode = ____t_result_4105,
                    started = ____L1_started_4111,
                    playing = ____L1_playing_4112,
                    paused = ____L1_paused_4113,
                    won = ____L1_won_4114,
                    defeated = ____L1_defeated_4115,
                    chapterEnded = ____L1_chapterEnded_4116,
                    scene = ____L1_scene_4117,
                    camera = ____L1_camera_4118,
                    player = ____L1_player_4119,
                    q = ____L1_q_4120,
                    items = ____L1_items_4121,
                    collected = ____L1_collected_4122,
                    weapon = ____L1_weapon_4123,
                    minionKills = ____L1_minionKills_4124,
                    seenBossIntros = ____L1_seenBossIntros_4125,
                    killCount = ____L1_killCount_4126,
                    lastSafeX = ____L1_lastSafeX_4127,
                    respawnCheckpoint = ____L1_respawnCheckpoint_4128,
                    vehicle = ____L1_vehicle_4129,
                    enemies = ____L1_enemies_4130,
                    minions = ____L1_minions_4131,
                    pickups = ____L1_pickups_4132,
                    targets = ____L1_targets_4133,
                    progression = ____opt_result_4110,
                    reeisCooldown = __L1.reeisCooldown,
                    dashCooldown = __L1.dashCooldown,
                    attackCooldown = __L1.attackCooldown,
                    fartCooldown = __L1.fartCooldown
                })
            }
        end
        local snapshot = __L1.sandbox.snapshot
        __L1.sandbox.type = ____type
        __L1.sandbox.result = nil
        local ____L1_sandbox_4143 = __L1.sandbox
        local ____t_result_4142
        local ____t_4141 = __t
        local ____opt_4138 = window.Difficulty
        if ____opt_4138 ~= nil then
            ____opt_4138 = ____opt_4138.getMode
        end
        local ____opt_result_4140
        if ____opt_4138 ~= nil then
            ____opt_result_4140 = ____opt_4138(____opt_4138)
        end
        __O[2258] = ____opt_result_4140
        if ____t_4141(____opt_result_4140) then
            ____t_result_4142 = __O[2258]
        else
            ____t_result_4142 = "normal"
        end
        ____L1_sandbox_4143.difficultyMode = ____t_result_4142
        local ____temp_4144
        if not __t(snapshot.started) then
            ____temp_4144 = __L1:load()
        else
            ____temp_4144 = nil
        end
        local saved = ____temp_4144
        local ____L1_copyState_4153 = __L1.copyState
        local ____assign_4152 = __assign
        local ____temp_4150 = {}
        local ____temp_4151 = __L1:emptyQuest()
        local ____t_result_4149
        local ____t_4148 = __t
        local ____opt_result_4147
        if saved ~= nil then
            ____opt_result_4147 = saved.q
        end
        __O[2259] = ____opt_result_4147
        if ____t_4148(____opt_result_4147) then
            ____t_result_4149 = __O[2259]
        else
            ____t_result_4149 = snapshot.q
        end
        __L1.q = ____L1_copyState_4153(
            __L1,
            ____assign_4152(____temp_4150, ____temp_4151, ____t_result_4149)
        )
        local ____opt_4161 = window.Progression
        if ____opt_4161 ~= nil then
            ____opt_4161 = ____opt_4161.restore
        end
        if ____opt_4161 ~= nil then
            local ____t_result_4159
            local ____t_4158 = __t
            local ____opt_result_4157
            if saved ~= nil then
                ____opt_result_4157 = saved.progression
            end
            __O[2260] = ____opt_result_4157
            if ____t_4158(____opt_result_4157) then
                ____t_result_4159 = __O[2260]
            else
                ____t_result_4159 = snapshot.progression
            end
            ____opt_4161(____opt_4161, ____t_result_4159)
        end
        local ____opt_result_4165
        if saved ~= nil then
            ____opt_result_4165 = saved.weapon
        end
        local ____opt_result_4165_4166 = ____opt_result_4165
        if ____opt_result_4165_4166 == nil then
            ____opt_result_4165_4166 = snapshot.weapon
        end
        __L1.weapon = ____opt_result_4165_4166
        local ____L1_copyState_4172 = __L1.copyState
        local ____t_result_4171
        local ____t_4170 = __t
        local ____opt_result_4169
        if saved ~= nil then
            ____opt_result_4169 = saved.items
        end
        __O[2261] = ____opt_result_4169
        if ____t_4170(____opt_result_4169) then
            ____t_result_4171 = __O[2261]
        else
            ____t_result_4171 = snapshot.items
        end
        __L1.items = ____L1_copyState_4172(__L1, ____t_result_4171)
        local ____L1_copyState_4178 = __L1.copyState
        local ____t_result_4177
        local ____t_4176 = __t
        local ____opt_result_4175
        if saved ~= nil then
            ____opt_result_4175 = saved.collected
        end
        __O[2262] = ____opt_result_4175
        if ____t_4176(____opt_result_4175) then
            ____t_result_4177 = __O[2262]
        else
            ____t_result_4177 = snapshot.collected
        end
        __L1.collected = ____L1_copyState_4178(__L1, ____t_result_4177)
        for ____, flag in __iterar((__arrL({
            "lucas",
            "mota",
            "almiro",
            "miqueias",
            "reeis",
            "marco",
            "giant",
            "menezes",
            "trained",
            "training",
            "freddy",
            "patioAccepted",
            "amandaDating"
        }, 13))) do
            __set(__L1.q, flag, true)
        end
        __set(__L1.q, ____type == "reeisBoss" and "reeis" or ____type, false)
        __L1.q.bivoltUnlocked = true
        __L1.q.bivoltCharges = 9
        __L1.started = true
        __L1.playing = true
        __L1.paused = false
        __L1.won = false
        __L1.defeated = false
        __L1.chapterEnded = false
        __L1.scene = __get(__L1.sandboxScenes, ____type)
        __L1.room = nil
        __L1.arena = nil
        __L1.activeBoss = nil
        __L1.cutscene = nil
        __L1.cutsceneCallback = nil
        __L1.dialog = nil
        __L1.dialogCallback = nil
        __L1.activity = nil
        __L1.training = nil
        __L1.ollyanEncounter = nil
        __L1.routeTransition = nil
        __L1:resetBivolt()
        __L1.vehicle = false
        __L1.reeisPhase = "idle"
        __L1.reeisTimer = 0
        __L1.reeisCooldown = 0
        __L1.dashTimer = 0
        __L1.dashCooldown = 0
        __L1.attackCooldown = 0
        __L1.fartCooldown = 0
        __L1.seenBossIntros = __arr(__TS__Spread(__iter(__keys(__L1.sandboxScenes))))
        __L1.player = __L1:basePlayer()
        __L1:populate()
        __L1.minions = __arrL({}, 0)
        __L1.pickups = __arrL({}, 0)
        __L1.targets = __arrL({}, 0)
        for ____, id in __iterar((__arrL({
            "startScreen",
            "pauseScreen",
            "chapterEndScreen",
            "victoryScreen",
            "defeatScreen",
            "dialogBox",
            "dialogControls",
            "cinematicOverlay",
            "activityOverlay",
            "trainingAction"
        }, 10))) do
            __L1:show(id, false)
        end
        if ____type == "ollyan" then
            __L1.player.x = 3260
            __L1.player.y = __L1.FLOOR
            __L1.camera = __L1:clamp(__L1.player.x - __L1.W * 0.36, 0, __L1.WORLD - __L1.W)
            __L1:beginOllyanEncounter(true)
        else
            local enemy = __call(
                __L1.enemies,
                "find",
                function(____, e) return e.type == ____type end
            )
            if not __t(enemy) then
                __L1:exitSandbox()
                return false
            end
            __L1.enemies = __arrL({enemy}, 1)
            __L1.player.x = enemy.x - 260
            __L1.player.y = __L1.FLOOR
            __L1.lastSafeX = __L1.player.x
            __L1.camera = __L1:clamp(__L1.player.x - __L1.W * 0.36, 0, __L1.WORLD - __L1.W)
            if not __t(__L1:engageBoss(enemy)) then
                __L1:exitSandbox()
                return false
            end
        end
        __L1:releaseInputs()
        __L1:updateUI()
        __L1.canvas:focus()
        __L1:emitGameEvent("sandbox-change", {type = ____type, difficultyMode = __L1.sandbox.difficultyMode})
        return true
    end
    __L1.retrySandboxBoss = function(self)
        local ____t_result_4179
        if __t(__L1.sandbox) then
            ____t_result_4179 = __L1:startSandboxBoss(__L1.sandbox.type)
        else
            ____t_result_4179 = false
        end
        return ____t_result_4179
    end
    __L1.exitSandbox = function(self)
        if not __t(__L1.sandbox) then
            return false
        end
        local prior = __L1.sandbox.snapshot
        __L1:releaseInputs()
        __L1.sandbox = nil
        __L1.ollyanEncounter = nil
        __L1.arena = nil
        __L1.activeBoss = nil
        __L1.room = nil
        __L1.dialog = nil
        __L1.dialogCallback = nil
        __L1.cutscene = nil
        __L1.cutsceneCallback = nil
        __L1.activity = nil
        __L1.training = nil
        __L1.routeTransition = nil
        __L1:resetBivolt()
        local ____opt_4182 = window.CampaignRun
        if ____opt_4182 ~= nil then
            ____opt_4182 = ____opt_4182.setSuspended
        end
        if ____opt_4182 ~= nil then
            ____opt_4182(____opt_4182, false)
        end
        local ____opt_4187 = window.Difficulty
        if ____opt_4187 ~= nil then
            ____opt_4187 = ____opt_4187.setMode
        end
        if ____opt_4187 ~= nil then
            local ____t_result_4185
            if __t(prior.difficultyMode) then
                ____t_result_4185 = prior.difficultyMode
            else
                ____t_result_4185 = "normal"
            end
            ____opt_4187(____opt_4187, ____t_result_4185)
        end
        __L1.started = prior.started
        __L1.playing = prior.playing
        __L1.paused = prior.paused
        __L1.won = prior.won
        __L1.defeated = prior.defeated
        __L1.chapterEnded = prior.chapterEnded
        __L1.scene = prior.scene
        __L1.camera = prior.camera
        __L1.player = prior.player
        __L1.q = prior.q
        __L1.items = prior.items
        __L1.collected = prior.collected
        __L1.weapon = prior.weapon
        __L1.minionKills = prior.minionKills
        __L1.seenBossIntros = prior.seenBossIntros
        __L1.killCount = prior.killCount
        __L1.lastSafeX = prior.lastSafeX
        __L1.respawnCheckpoint = prior.respawnCheckpoint
        __L1.vehicle = prior.vehicle
        __L1.enemies = prior.enemies
        __L1.minions = prior.minions
        __L1.pickups = prior.pickups
        __L1.targets = prior.targets
        __L1.reeisCooldown = prior.reeisCooldown
        __L1.dashCooldown = prior.dashCooldown
        __L1.attackCooldown = prior.attackCooldown
        __L1.fartCooldown = prior.fartCooldown
        local ____ = prior
        local ____opt_4191 = window.Progression
        if ____opt_4191 ~= nil then
            ____opt_4191 = ____opt_4191.restore
        end
        if ____opt_4191 ~= nil then
            ____opt_4191(____opt_4191, prior.progression)
        end
        __L1:resetWorldSize()
        __L1.shots = __arrL({}, 0)
        __L1.hazards = __arrL({}, 0)
        __L1.particles = __arrL({}, 0)
        __L1.damageTexts = __arrL({}, 0)
        __L1.afterimages = __arrL({}, 0)
        __L1.reeisPhase = "idle"
        __L1.reeisTimer = 0
        for ____, id in __iterar((__arrL({
            "victoryScreen",
            "defeatScreen",
            "dialogBox",
            "dialogControls",
            "cinematicOverlay",
            "activityOverlay",
            "trainingAction"
        }, 7))) do
            __L1:show(id, false)
        end
        __L1:show(
            "startScreen",
            not __t(__L1.started)
        )
        local ____L1_show_4196 = __L1.show
        local ____t_result_4195
        local ____t_4194 = __t
        local ____t_result_4193
        if __t(__L1.started) then
            ____t_result_4193 = __L1.paused
        else
            ____t_result_4193 = __L1.started
        end
        __O[2263] = ____t_result_4193
        if ____t_4194(____t_result_4193) then
            ____t_result_4195 = not __t(__L1.chapterEnded)
        else
            ____t_result_4195 = __O[2263]
        end
        ____L1_show_4196(__L1, "pauseScreen", ____t_result_4195)
        __L1:updateUI()
        __L1:updateContinue()
        __L1:emitGameEvent("sandbox-change", nil)
        local ____t_4200 = __t
        local ____t_result_4199
        local ____t_4198 = __t
        local ____t_result_4197
        if __t(__L1.started) then
            ____t_result_4197 = not __t(__L1.paused)
        else
            ____t_result_4197 = __L1.started
        end
        __O[2264] = ____t_result_4197
        if ____t_4198(____t_result_4197) then
            ____t_result_4199 = not __t(__L1.chapterEnded)
        else
            ____t_result_4199 = __O[2264]
        end
        if ____t_4200(____t_result_4199) then
            __L1.canvas:focus()
        end
        return true
    end
    local ____ = "use strict"
    __L1["$"] = function(____, id) return window.document:getElementById(id) end
    __L1.canvas = __L1["$"](__L1, "gameCanvas")
    if not __t(__L1.canvas) then
        return
    end
    __L1.ctx = __L1.canvas:getContext("2d", {alpha = false})
    __L1.canvas.width = 960
    __L1.canvas.height = 540
    __L1.ctx.imageSmoothingEnabled = false
    __L1.W = 960
    __L1.H = 540
    __L1.FLOOR = 440
    __L1.SAVE = "da-roca-adventure-v1"
    local ____opt_4203 = window.Golpes
    if ____opt_4203 ~= nil then
        ____opt_4203 = ____opt_4203.chao
    end
    if ____opt_4203 ~= nil then
        ____opt_4203(____opt_4203, __L1.FLOOR)
    end
    local ____t_result_4210
    local ____t_4209 = __t
    local ____getq_4207 = __getq
    local ____opt_4205 = window.WorldData
    if ____opt_4205 ~= nil then
        ____opt_4205 = ____opt_4205.widths
    end
    local ____TS__Number_result_4208 = __TS__Number(____getq_4207(____opt_4205, 0))
    __O[1610] = ____TS__Number_result_4208
    if ____t_4209(____TS__Number_result_4208) then
        ____t_result_4210 = __O[1610]
    else
        ____t_result_4210 = 2600
    end
    __L1.WORLD = ____t_result_4210
    local ____t_result_4214
    local ____t_4213 = __t
    local ____opt_4211 = window.Campaign
    if ____opt_4211 ~= nil then
        ____opt_4211 = ____opt_4211.sceneNames
    end
    __O[1611] = ____opt_4211
    if ____t_4213(____opt_4211) then
        ____t_result_4214 = __O[1611]
    else
        ____t_result_4214 = __arrL({
            "A roça",
            "Colégio Adventista",
            "Academia do Caleb",
            "A quadra",
            "Praça Camacan",
            "Favela do Reeis",
            "Caderno do Caos",
            "Campo do Mota",
            "Bigodon · barbearia",
            "Pátio da escola",
            "Casa de Rayssa",
            "Baile funk"
        }, 12)
    end
    __L1.scenes = ____t_result_4214
    __L1.phrases = __arrL({
        "da roça poudiaaam",
        "reeeis pouddiaaam",
        "da roça pegou ar",
        "teketeketeketeke",
        "ó pra Ravid falando sozinho"
    }, 5)
    local ____ord_4223 = __ord
    local ____assign_4222 = __assign
    local ____temp_4221 = {}
    local ____opt_4215 = window.LugaresC1
    if ____opt_4215 ~= nil then
        ____opt_4215 = ____opt_4215.npcs
    end
    local ____opt_4217 = window.MissaoFarda
    if ____opt_4217 ~= nil then
        ____opt_4217 = ____opt_4217.npcs
    end
    local ____opt_4219 = window.Campaign
    if ____opt_4219 ~= nil then
        ____opt_4219 = ____opt_4219.npcEntries
    end
    __L1.npcInfo = ____ord_4223(
        ____assign_4222(
            ____temp_4221,
            ____opt_4215,
            ____opt_4217,
            ____opt_4219,
            {
                swift = __ord({name = "Irmão de Clara Swift", scene = 0, x = 340}, "name,scene,x"),
                ollyan = __ord({name = "Ollyan · Orelhas ao Vento", scene = 11, x = 3260}, "name,scene,x"),
                mc_batidao = __ord({name = "MC Batidão · concurso de fantasia", scene = 11, x = 1960}, "name,scene,x"),
                lucas = __ord({name = "Lucas · o Sapo", scene = 0, x = 480}, "name,scene,x"),
                kaua = __ord({name = "Kauã · inventor", scene = 0, x = 760}, "name,scene,x"),
                reeis = __ord({name = "Gabriel Reeis", scene = 1, x = 390}, "name,scene,x"),
                ravid = __ord({name = "Ravid", scene = 1, x = 930}, "name,scene,x"),
                caleb = __ord({name = "Caleb", scene = 2, x = 400}, "name,scene,x"),
                mota = __ord({name = "Gabriel Mota", scene = 7, x = 500}, "name,scene,x"),
                davi = __ord({name = "Davi Costa · barbeiro", scene = 8, x = 520}, "name,scene,x"),
                vitor = __ord({name = "Vitor · ajudante", scene = 8, x = 850}, "name,scene,x"),
                freddy = __ord({name = "Freddy · resenha do morro", scene = 5, x = 5680}, "name,scene,x"),
                nicolas = __ord({name = "Nicolas Carvalho", scene = 4, x = 5350}, "name,scene,x"),
                dede = __ord({name = "Dedé · Fumacinha", scene = 5, x = 5000}, "name,scene,x"),
                aica = __ord({name = "Aica", scene = 9, x = 500}, "name,scene,x"),
                ravile = __ord({name = "Ravile", scene = 9, x = 670}, "name,scene,x"),
                arthur = __ord({name = "Arthur", scene = 9, x = 2850}, "name,scene,x"),
                allef = __ord({name = "Allef · recepção", scene = 8, x = 240}, "name,scene,x"),
                eloisa = __ord({name = "Eloisa", scene = 10, x = 450}, "name,scene,x"),
                giselle = __ord({name = "Giselle", scene = 10, x = 820}, "name,scene,x"),
                rayssa = __ord({name = "Rayssa", scene = 10, x = 1220}, "name,scene,x"),
                analaura = __ord({name = "Ana Laura", scene = 10, x = 1580}, "name,scene,x")
            }
        ),
        "swift,ollyan,mc_batidao,lucas,kaua,reeis,ravid,caleb,mota,davi,vitor,freddy,nicolas,dede,aica,ravile,arthur,allef,eloisa,giselle,rayssa,analaura"
    )
    local ____t_result_4227
    local ____t_4226 = __t
    local ____opt_4224 = window.WorldData
    if ____opt_4224 ~= nil then
        ____opt_4224 = ____opt_4224.platforms
    end
    __O[1612] = ____opt_4224
    if ____t_4226(____opt_4224) then
        ____t_result_4227 = __O[1612]
    else
        ____t_result_4227 = __arrL(
            {
                __arrL(
                    {
                        __arrL({790, 340, 160}, 3),
                        __arrL({1270, 290, 160}, 3),
                        __arrL({1840, 330, 170}, 3)
                    },
                    3
                ),
                __arrL(
                    {
                        __arrL({1080, 338, 150}, 3),
                        __arrL({1450, 285, 140}, 3),
                        __arrL({2100, 335, 140}, 3)
                    },
                    3
                ),
                __arrL(
                    {
                        __arrL({850, 350, 150}, 3),
                        __arrL({1340, 310, 140}, 3),
                        __arrL({1950, 350, 140}, 3)
                    },
                    3
                ),
                __arrL(
                    {
                        __arrL({680, 340, 150}, 3),
                        __arrL({1180, 290, 140}, 3),
                        __arrL({2100, 345, 150}, 3)
                    },
                    3
                )
            },
            4
        )
    end
    __L1.platforms = ____t_result_4227
    __L1.emptyQuest = function() return {
        carMissionAccepted = false,
        carParts = __arrL({}, 0),
        almiroAccepted = false,
        notebooks = __arrL({}, 0),
        lucas = false,
        kaua = false,
        mota = false,
        almiro = false,
        miqueias = false,
        reeis = false,
        marco = false,
        giant = false,
        menezes = false,
        training = false,
        trained = false,
        nikolas = false,
        freddy = false,
        nicolas = false,
        bigodon = false,
        vitor = false,
        amandaInvited = false,
        amandaDating = false,
        jaglionClaimed = false,
        dede = false,
        patioAccepted = false,
        arthur = false,
        acai = false,
        celebrationSeen = false,
        easyEndingSeen = false,
        jorgeSeen = false,
        jorgeStarted = false,
        rayssaVisit = false,
        ollyan = false,
        bivoltAccepted = false,
        bivoltParts = __arrL({}, 0),
        bivoltUnlocked = false,
        bivoltCharges = 0,
        igor = false,
        kaique = false,
        igorSneak = false,
        kaiqueSneak = false,
        npcVisits = {}
    } end
    __L1.q = __L1:emptyQuest()
    __L1.scene = 0
    __L1.camera = 0
    __L1.time = 0
    __L1.playing = false
    __L1.paused = false
    __L1.dialog = nil
    __L1.started = false
    __L1.won = false
    __L1.sound = false
    __L1.vehicle = false
    __L1.transition = 0
    __L1.particles = __arrL({}, 0)
    __L1.shots = __arrL({}, 0)
    __L1.enemies = __arrL({}, 0)
    __L1.pickups = __arrL({}, 0)
    __L1.targets = __arrL({}, 0)
    __L1.damageTexts = __arrL({}, 0)
    __L1.shake = 0
    __L1.hitFlash = 0
    __L1.hazards = __arrL({}, 0)
    __L1.afterimages = __arrL({}, 0)
    __L1.hitStop = 0
    __L1.epic = __ord(
        {
            intro = nil,
            rings = __arrL({}, 0),
            flash = 0,
            flashColor = "#fff6d8",
            plate = nil
        },
        "intro,rings,flash,flashColor,plate"
    )
    __L1.calmMotion = window:matchMedia("(prefers-reduced-motion: reduce)").matches
    __L1.joystick = __ord({x = 0, y = 0}, "x,y")
    __L1.dashTimer = 0
    __L1.dashCooldown = 0
    __L1.dashDir = 1
    __L1.activeBoss = nil
    __L1.defeated = false
    __L1.chapterEnded = false
    __L1.respawnCheckpoint = nil
    __L1.routeTransition = nil
    __L1.routeEdgeCooldown = 0
    __L1.releasingInputs = false
    __L1.reeisPhase = "idle"
    __L1.reeisPhaseTimer = 0
    __L1.reeisX = 0
    __L1.reeisY = __L1.FLOOR
    __L1.reeisFacing = 1
    __L1.reeisFireTimer = 0
    __L1.sandbox = nil
    __L1.audioCutsceneSerial = 0
    __L1.ollyanEncounter = nil
    __L1.ollyanRetryGrace = 0
    __L1.room = nil
    __L1.arena = nil
    __L1.cutscene = nil
    __L1.cutsceneCallback = nil
    __L1.minions = __arrL({}, 0)
    __L1.minionKills = __arrL({}, 0)
    __L1.lastSafeX = 230
    __L1.tauntCooldown = 0
    __L1.items = __ord({pencil = 0, eraser = 0, clip = 0}, "pencil,eraser,clip")
    __L1.collected = __arrL({}, 0)
    __L1.weapon = 0
    __L1.training = nil
    __L1.activity = nil
    __L1.activityCallback = nil
    __L1.seenBossIntros = __arrL({}, 0)
    __L1.comboStep = 0
    __L1.comboWindow = 0
    __L1.bossHintCooldown = 0
    __L1.marcoTrapTriggered = false
    __L1.baseBonus = function()
        local ____assign_4237 = __assign
        local ____temp_4235 = {}
        local ____temp_4236 = {
            maxHP = 100,
            maxGas = 100,
            damageMultiplier = 1,
            moveSpeed = 280,
            dashCooldown = 1.1,
            projectileTier = 0
        }
        local ____t_result_4234
        local ____t_4233 = __t
        local ____opt_4230 = window.Progression
        if ____opt_4230 ~= nil then
            ____opt_4230 = ____opt_4230.bonuses
        end
        local ____opt_result_4232
        if ____opt_4230 ~= nil then
            ____opt_result_4232 = ____opt_4230(____opt_4230)
        end
        __O[1613] = ____opt_result_4232
        if ____t_4233(____opt_result_4232) then
            ____t_result_4234 = __O[1613]
        else
            ____t_result_4234 = {}
        end
        return ____assign_4237(____temp_4235, ____temp_4236, ____t_result_4234)
    end
    __L1.bonus = function()
        local ____t_result_4244
        local ____t_4243 = __t
        local ____opt_4240 = window.BivoltSkill
        if ____opt_4240 ~= nil then
            ____opt_4240 = ____opt_4240.bonuses
        end
        local ____opt_result_4242
        if ____opt_4240 ~= nil then
            ____opt_result_4242 = ____opt_4240(
                ____opt_4240,
                __L1:baseBonus()
            )
        end
        __O[1614] = ____opt_result_4242
        if ____t_4243(____opt_result_4242) then
            ____t_result_4244 = __O[1614]
        else
            ____t_result_4244 = __L1:baseBonus()
        end
        return ____t_result_4244
    end
    __L1.bossProfile = function(____, e)
        local ____t_result_4249
        local ____t_4248 = __t
        local ____t_result_4247
        if __t(e.difficultyProfile) then
            ____t_result_4247 = e.difficultyProfile
        else
            local ____opt_4245 = window.Difficulty
            if ____opt_4245 ~= nil then
                ____opt_4245 = ____opt_4245:boss(e.type)
            end
            ____t_result_4247 = ____opt_4245
        end
        __O[1660] = ____t_result_4247
        if ____t_4248(____t_result_4247) then
            ____t_result_4249 = __O[1660]
        else
            ____t_result_4249 = {
                hp = e.max,
                level = 1,
                damage = 1,
                projectileSpeed = 1,
                dashSpeed = 1,
                windup = 1,
                minWindup = 0.62,
                recovery = __arrL({1.5, 1.42, 1.34}, 3),
                armor = 0.32
            }
        end
        return ____t_result_4249
    end
    __L1.bossRecovery = function(____, e)
        local ____get_4252 = __get
        local ____table_recovery_4251 = __L1:bossProfile(e).recovery
        local ____t_result_4250
        if __t(e.phase) then
            ____t_result_4250 = e.phase
        else
            ____t_result_4250 = 1
        end
        local ____get_4252_result_4257 = ____get_4252(
            ____table_recovery_4251,
            math.max(
                0,
                math.min(2, ____t_result_4250 - 1)
            )
        )
        local ____t_4256 = __t
        local ____t_result_4255
        local ____t_4254 = __t
        local ____temp_4253 = e.type == "kaique"
        __O[1661] = ____temp_4253
        if ____t_4254(____temp_4253) then
            ____t_result_4255 = e.rage
        else
            ____t_result_4255 = __O[1661]
        end
        return ____get_4252_result_4257 * (____t_4256(____t_result_4255) and 0.88 or 1)
    end
    __L1.levelState = function()
        local ____t_result_4264
        local ____t_4263 = __t
        local ____opt_4260 = window.Progression
        if ____opt_4260 ~= nil then
            ____opt_4260 = ____opt_4260.getState
        end
        local ____opt_result_4262
        if ____opt_4260 ~= nil then
            ____opt_result_4262 = ____opt_4260(____opt_4260)
        end
        __O[1662] = ____opt_result_4262
        if ____t_4263(____opt_result_4262) then
            ____t_result_4264 = __O[1662]
        else
            ____t_result_4264 = {
                level = 1,
                xp = 0,
                nextXP = 100,
                points = 0,
                stats = {vigor = 0, forca = 0, gas = 0, agilidade = 0}
            }
        end
        return ____t_result_4264
    end
    __L1.weaponNames = __arrL({"Bolinhas de papel", "Lançador de régua", "Canhão de estojo"}, 3)
    __L1.itemNames = __ord({pencil = "lápis", eraser = "borracha", clip = "clipe"}, "pencil,eraser,clip")
    __L1.kauaVoice = "ummhumhumm... rato poudii! Oprai da roça!"
    __L1.materialCount = function() return __L1.items.pencil + __L1.items.eraser + __L1.items.clip end
    __L1.last = window.performance:now()
    __L1.saveTimer = 0
    __L1.uiTimer = 0
    __L1.toastTimer = 0
    __L1.reeisTimer = 0
    __L1.reeisCooldown = 0
    __L1.attackCooldown = 0
    __L1.fartCooldown = 0
    __L1.ammoTimer = 0
    __L1.keys = {}
    __L1.touch = {}
    __L1.prevJump = false
    __L1.nearNPC = nil
    __L1.audioCtx = nil
    __L1.dialogCallback = nil
    __L1.killCount = 0
    __L1.defaultKeys = __ord(
        {
            left = __arrL({"KeyA", "ArrowLeft"}, 2),
            right = __arrL({"KeyD", "ArrowRight"}, 2),
            up = __arrL({"KeyW", "ArrowUp"}, 2),
            down = __arrL({"KeyS", "ArrowDown"}, 2),
            jump = __arrL({"Space"}, 1),
            paper = __arrL({"KeyJ"}, 1),
            fart = __arrL({"KeyK"}, 1),
            dash = __arrL({"KeyL", "ShiftLeft", "ShiftRight"}, 3),
            reeis = __arrL({"KeyR"}, 1),
            vehicle = __arrL({"KeyV"}, 1),
            bivolt = __arrL({"KeyB"}, 1),
            taunt = __arrL({"KeyT"}, 1),
            interact = __arrL({"KeyE", "Enter"}, 2),
            pause = __arrL({"Escape"}, 1)
        },
        "left,right,up,down,jump,paper,fart,dash,reeis,vehicle,bivolt,taunt,interact,pause"
    )
    __L1.inputCaptured = false
    __L1.keyHeld = function(____, action)
        local ____t_result_4265
        if __t(window.ControlSettings) then
            ____t_result_4265 = window.ControlSettings:pressed(action, __L1.keys)
        else
            ____t_result_4265 = not not __t(__callq(
                __get(__L1.defaultKeys, action),
                "some",
                function(____, code) return __get(__L1.keys, code) end
            ))
        end
        return ____t_result_4265
    end
    __L1.keyMatches = function(____, action, code)
        local ____t_result_4266
        if __t(window.ControlSettings) then
            ____t_result_4266 = window.ControlSettings:matches(action, code)
        else
            ____t_result_4266 = not not __t(__callq(
                __get(__L1.defaultKeys, action),
                "includes",
                code
            ))
        end
        return ____t_result_4266
    end
    __L1.rand = function(____, a, b) return a + math.random() * (b - a) end
    __L1.clamp = function(____, x, a, b) return math.max(
        a,
        math.min(b, x)
    ) end
    __L1.activePointers = __TS__New(Map)
    __L1.heldActions = __TS__New(
        Set,
        __arrL({
            "left",
            "right",
            "up",
            "down",
            "jump"
        }, 5)
    )
    __L1.pointerTimes = __TS__New(WeakMap)
    __L1.keyboardClicks = __TS__New(WeakMap)
    __L1.npcAvailable = function(____, id)
        local ____temp_4271
        if id == "reeis" then
            ____temp_4271 = __L1.q.reeis
        else
            local ____temp_4270
            if id == "freddy" then
                ____temp_4270 = __L1.q.freddy
            else
                local ____temp_4269
                if id == "nicolas" then
                    ____temp_4269 = __L1.q.nicolas
                else
                    local ____temp_4268
                    if id == "dede" then
                        ____temp_4268 = __L1.q.dede
                    else
                        local ____temp_4267
                        if id == "arthur" then
                            ____temp_4267 = __L1.q.arthur
                        else
                            ____temp_4267 = true
                        end
                        ____temp_4268 = ____temp_4267
                    end
                    ____temp_4269 = ____temp_4268
                end
                ____temp_4270 = ____temp_4269
            end
            ____temp_4271 = ____temp_4270
        end
        return ____temp_4271
    end
    __L1.bossNames = __ord({
        igor = "Igor · Fiscal do Lanche",
        kaique = "Kaique · Monitor do Corredor",
        marco = "Marco",
        menezes = "Menezes · Rato",
        nikolas = "Nikolas Arroganti",
        reeisBoss = "Reeis · Rei da Favela",
        giant = "Rabiscão · Monstro Gigante",
        freddy = "Freddy · Braço Forte do Reeis",
        nicolas = "Nicolas Carvalho · Aura Suprema",
        dede = "Dedé · Fumacinha",
        arthur = "Arthur · Duelo do pátio"
    }, "igor,kaique,marco,menezes,nikolas,reeisBoss,giant,freddy,nicolas,dede,arthur")
    __L1.nomeBoss = function(____, t)
        local ____t_result_4277
        local ____t_4276 = __t
        local ____t_result_4275
        local ____t_4274 = __t
        local ____opt_4272 = window.C2Luta
        if ____opt_4272 ~= nil then
            ____opt_4272 = ____opt_4272.skin
        end
        __O[1668] = ____opt_4272
        if ____t_4274(____opt_4272) then
            ____t_result_4275 = t == window.C2Luta.skin.kit
        else
            ____t_result_4275 = __O[1668]
        end
        if ____t_4276(____t_result_4275) then
            ____t_result_4277 = window.C2Luta.skin.nome
        else
            ____t_result_4277 = __get(__L1.bossNames, t)
        end
        return ____t_result_4277
    end
    __L1.worldWidthFor = function(____, n)
        local ____t_result_4290
        local ____t_4289 = __t
        local ____t_result_4288
        local ____t_4282 = __t
        local ____getq_4280 = __getq
        local ____opt_4278 = window.WorldData
        if ____opt_4278 ~= nil then
            ____opt_4278 = ____opt_4278.widths
        end
        local ____TS__Number_result_4281 = __TS__Number(____getq_4280(____opt_4278, n))
        __O[1680] = ____TS__Number_result_4281
        if ____t_4282(____TS__Number_result_4281) then
            ____t_result_4288 = __O[1680]
        else
            local ____opt_4285 = window.LugaresC1
            if ____opt_4285 ~= nil then
                ____opt_4285 = ____opt_4285.largura
            end
            local ____opt_result_4287
            if ____opt_4285 ~= nil then
                ____opt_result_4287 = ____opt_4285(____opt_4285, n)
            end
            ____t_result_4288 = ____opt_result_4287
        end
        __O[1681] = ____t_result_4288
        if ____t_4289(____t_result_4288) then
            ____t_result_4290 = __O[1681]
        else
            ____t_result_4290 = 2600
        end
        return ____t_result_4290
    end
    __L1.bossHome = function(____, ____type, fallback)
        local ____t_result_4298
        local ____t_4297 = __t
        local ____getq_4295 = __getq
        local ____opt_4293 = window.WorldData
        if ____opt_4293 ~= nil then
            ____opt_4293 = ____opt_4293.bosses
        end
        local ____opt_4291 = ____getq_4295(____opt_4293, ____type)
        if ____opt_4291 ~= nil then
            ____opt_4291 = ____opt_4291.x
        end
        local ____TS__Number_result_4296 = __TS__Number(____opt_4291)
        __O[1682] = ____TS__Number_result_4296
        if ____t_4297(____TS__Number_result_4296) then
            ____t_result_4298 = __O[1682]
        else
            ____t_result_4298 = fallback
        end
        return ____t_result_4298
    end
    __L1.player = __L1:basePlayer()
    local ____opt_4299 = __L1:load()
    if ____opt_4299 ~= nil then
        ____opt_4299 = ____opt_4299.q
    end
    __L1.menuLookQuest = ____opt_4299
    __L1.dialogueReopenUntil = 0
    __L1.dinnerMeter = __L1["$"](__L1, "dinnerBreath")
    __L1.dinnerMeter.style:setProperty(
        "--band-start",
        __add(window.AmandaDinner.band.start * 100, "%")
    )
    __L1.dinnerMeter.style:setProperty(
        "--band-end",
        __add(window.AmandaDinner.band["end"] * 100, "%")
    )
    __L1.HAZ = __ord(
        {
            pink = __arrL({"#7a2c4c", "#d4558a", "#f5a3c4", "#fff0f5"}, 4),
            slime = __arrL({"#3f5a1e", "#86b23a", "#c8e276", "#f6ffd0"}, 4),
            ink = __arrL({"#3a2054", "#7d4fb0", "#c79ae5", "#f6e8ff"}, 4),
            astral = __arrL({"#6a5a1c", "#e0b83c", "#ffe39a", "#fffbe6"}, 4),
            smoke = __arrL({"#4c5650", "#8d9a91", "#c7d2c9", "#f2f5ef"}, 4),
            brasa = __arrL({"#3a1608", "#a8401a", "#ff8a30", "#ffe08a"}, 4)
        },
        "pink,slime,ink,astral,smoke,brasa"
    )
    __L1.hsh = function(____, n)
        local x = math.sin(n * 12.9898 + 78.233) * 43758.5453
        return x - math.floor(x)
    end
    __L1.bossPhaseSkills = __ord(
        {
            marco = __arrL({"inkColumns", "inkCrossfire"}, 2),
            menezes = __arrL({"ratPincer", "sewerEruption"}, 2),
            nikolas = __arrL({"slimeMortar", "slimeNova"}, 2),
            reeisBoss = __arrL({"royalCrossfire", "royalSeal"}, 2),
            freddy = __arrL({"heavyUppercut", "doubleStomp"}, 2),
            dede = __arrL({"smokeSpiral", "smokePrison"}, 2),
            nicolas = __arrL({"astralOrbit", "heavenCross"}, 2),
            arthur = __arrL({"slapBoomerang", "slapClap"}, 2),
            igor = __arrL({"bellyQuake", "bellyShrapnel"}, 2),
            kaique = __arrL({"monitorCrossfire", "monitorGrid"}, 2)
        },
        "marco,menezes,nikolas,reeisBoss,freddy,dede,nicolas,arthur,igor,kaique"
    )
    __L1.bossPhaseSkillNames = __ord({
        inkColumns = "PILARES DE TINTA! SAIA DAS MARCAS",
        inkCrossfire = "RABISCO CRUZADO! OBSERVE OS DOIS LADOS",
        ratPincer = "CERCO DOS RATOS! LIMPE UM LADO",
        sewerEruption = "ESGOTO EXPLODINDO! SAIA DAS TAMPAS",
        slimeMortar = "CATARRO DE MORTEIRO! SAIA DO ALVO",
        slimeNova = "SUPERNOVA DE CATARRO! ABRA DISTÂNCIA",
        royalCrossfire = "RAJADA REAL! DESVIE EM ZIGUEZAGUE",
        royalSeal = "SELO DO REI! PULE E SAIA DAS MARCAS",
        heavyUppercut = "GANCHO DO FREDDY! SAIA DO ALVO",
        doubleStomp = "DOIS PISÕES! PULE DUAS VEZES",
        smokeSpiral = "FUMAÇA VOLTANDO! GUARDE O DASH",
        smokePrison = "PRISÃO DE FUMAÇA! BUSQUE O VÃO",
        astralOrbit = "ÓRBITAS VOLTANDO! OBSERVE A TRAJETÓRIA",
        heavenCross = "CRUZ CELESTIAL! SAIA DAS DIAGONAIS",
        slapBoomerang = "TAPA DE IDA E VOLTA! DESVIE DUAS VEZES",
        slapClap = "PALMAS NO CHÃO! SALTE O COMPASSO",
        bellyQuake = "TRÊS ONDAS DE BARRIGA! PULE NO RITMO",
        bellyShrapnel = "BARRIGA SUPREMA! DESVIE DO LEQUE",
        monitorCrossfire = "RAJADA EM DUAS ALTURAS! OLHE A MIRA",
        monitorGrid = "GRADE DA FISCALIZAÇÃO! USE O VÃO"
    }, "inkColumns,inkCrossfire,ratPincer,sewerEruption,slimeMortar,slimeNova,royalCrossfire,royalSeal,heavyUppercut,doubleStomp,smokeSpiral,smokePrison,astralOrbit,heavenCross,slapBoomerang,slapClap,bellyQuake,bellyShrapnel,monitorCrossfire,monitorGrid")
    __L1.nikolasPhasePatterns = {
        ["2"] = __arrL({
            "muscleClap",
            "slimeMortar",
            "goldenRush",
            "slimeFan",
            "potatoUppercut"
        }, 5),
        ["3"] = __arrL({
            "auraComets",
            "skySlimeLances",
            "slimeNova",
            "auraSweep",
            "dash"
        }, 5),
        ["4"] = __arrL({
            "giantPalm",
            "giantStomp",
            "giantSlam",
            "giantBreath",
            "giantPalm"
        }, 5)
    }
    __L1.nikolasPhaseWarnings = __ord({
        muscleClap = "PALMAS DO SHAPE! PULE AS ONDAS",
        goldenRush = "INVESTIDA DOURADA! USE O DASH",
        potatoUppercut = "GANCHO DE BATATA! SAIA DA MARCA",
        auraComets = "COMETAS DE CATARRO! MUDE DE ROTA",
        skySlimeLances = "AURA DO CÉU! SAIA DAS COLUNAS",
        auraSweep = "RAJADA AÉREA! OBSERVE AS DIAGONAIS",
        giantPalm = "MÃO GIGANTE! SAIA DO ALVO",
        giantStomp = "PASSOS DO TITÃ! PULE NO RITMO",
        giantSlam = "ESMAGAMENTO! ENTRE NA FAIXA VERDE",
        giantBreath = "SOPRO GIGANTE! DESVIE DAS GOTAS"
    }, "muscleClap,goldenRush,potatoUppercut,auraComets,skySlimeLances,auraSweep,giantPalm,giantStomp,giantSlam,giantBreath")
    __L1.pickupsLater = false
    __L1.arenaFundo = nil
    __L1.pontesCv = nil
    __L1:createBivoltControl()
    __L1.editableTarget = function(____, target)
        local ____t_4312 = __t
        local ____t_result_4311
        local ____t_4304 = __t
        local ____opt_result_4303
        if target ~= nil then
            ____opt_result_4303 = target.isContentEditable
        end
        __O[2177] = ____opt_result_4303
        if ____t_4304(____opt_result_4303) then
            ____t_result_4311 = __O[2177]
        else
            local ____opt_result_4309
            if target ~= nil then
                ____opt_result_4309 = target.closest
            end
            local ____opt_result_4310
            if ____opt_result_4309 ~= nil then
                ____opt_result_4310 = ____opt_result_4309(target, "input,textarea,select,[contenteditable=\"\"],[contenteditable=\"true\"],[role=\"textbox\"]")
            end
            ____t_result_4311 = ____opt_result_4310
        end
        return not not ____t_4312(____t_result_4311)
    end
    __L1.visibleKeyboardButton = function(____, target)
        local ____opt_result_4317
        if target ~= nil then
            ____opt_result_4317 = target.closest
        end
        local ____opt_result_4318
        if ____opt_result_4317 ~= nil then
            ____opt_result_4318 = ____opt_result_4317(target, "button,a")
        end
        local button = ____opt_result_4318
        local ____t_result_4325
        local ____t_4324 = __t
        local ____t_result_4323
        local ____t_4322 = __t
        local ____t_result_4321
        local ____t_4320 = __t
        local ____t_result_4319
        if __t(button) then
            ____t_result_4319 = not __t(button:closest("[hidden],[inert]"))
        else
            ____t_result_4319 = button
        end
        __O[2178] = ____t_result_4319
        if ____t_4320(____t_result_4319) then
            ____t_result_4321 = __len(button:getClientRects())
        else
            ____t_result_4321 = __O[2178]
        end
        __O[2179] = ____t_result_4321
        if ____t_4322(____t_result_4321) then
            ____t_result_4323 = window:getComputedStyle(button).visibility ~= "hidden"
        else
            ____t_result_4323 = __O[2179]
        end
        if ____t_4324(____t_result_4323) then
            ____t_result_4325 = button
        else
            ____t_result_4325 = nil
        end
        return ____t_result_4325
    end
    window:addEventListener(
        "keydown",
        function(____, e)
            local ____t_4340 = __t
            local ____t_result_4339
            local ____t_4338 = __t
            local ____t_result_4337
            local ____t_4334 = __t
            local ____t_result_4333
            local ____t_4327 = __t
            local ____t_result_4326
            if __t(e.defaultPrevented) then
                ____t_result_4326 = e.defaultPrevented
            else
                ____t_result_4326 = __L1.inputCaptured
            end
            __O[2180] = ____t_result_4326
            if ____t_4327(____t_result_4326) then
                ____t_result_4333 = __O[2180]
            else
                local ____opt_4330 = window.Arena
                if ____opt_4330 ~= nil then
                    ____opt_4330 = ____opt_4330.isOpen
                end
                local ____opt_result_4332
                if ____opt_4330 ~= nil then
                    ____opt_result_4332 = ____opt_4330(____opt_4330)
                end
                ____t_result_4333 = ____opt_result_4332
            end
            __O[2181] = ____t_result_4333
            if ____t_4334(____t_result_4333) then
                ____t_result_4337 = __O[2181]
            else
                local ____this_4336
                ____this_4336 = window.document
                local ____opt_4335 = ____this_4336.querySelector
                ____t_result_4337 = ____opt_4335 and ____opt_4335(____this_4336, "dialog[open]")
            end
            __O[2182] = ____t_result_4337
            if ____t_4338(____t_result_4337) then
                ____t_result_4339 = __O[2182]
            else
                ____t_result_4339 = __L1:editableTarget(e.target)
            end
            if ____t_4340(____t_result_4339) then
                return
            end
            local ____t_4344 = __t
            local ____t_result_4343
            local ____t_4342 = __t
            local ____t_result_4341
            if __t(e.ctrlKey) then
                ____t_result_4341 = e.ctrlKey
            else
                ____t_result_4341 = e.metaKey
            end
            __O[2183] = ____t_result_4341
            if ____t_4342(____t_result_4341) then
                ____t_result_4343 = __O[2183]
            else
                ____t_result_4343 = e.altKey
            end
            if ____t_4344(____t_result_4343) then
                __L1.keys = {}
                return
            end
            local code = e.code
            local ____t_result_4351
            local ____t_4350 = __t
            local ____t_result_4349
            local ____t_4348 = __t
            local ____t_result_4347
            local ____t_4346 = __t
            local ____temp_4345 = __L1:keyMatches("interact", code)
            __O[2184] = ____temp_4345
            if ____t_4346(____temp_4345) then
                ____t_result_4347 = __O[2184]
            else
                ____t_result_4347 = __L1:keyMatches("jump", code)
            end
            __O[2185] = ____t_result_4347
            if ____t_4348(____t_result_4347) then
                ____t_result_4349 = __O[2185]
            else
                ____t_result_4349 = code == "Space"
            end
            __O[2186] = ____t_result_4349
            if ____t_4350(____t_result_4349) then
                ____t_result_4351 = __O[2186]
            else
                ____t_result_4351 = code == "Enter"
            end
            local confirm = ____t_result_4351
            local ____t_result_4354
            local ____t_4353 = __t
            local ____temp_4352 = code == "Escape"
            __O[2187] = ____temp_4352
            if ____t_4353(____temp_4352) then
                ____t_result_4354 = __O[2187]
            else
                ____t_result_4354 = __L1:keyMatches("pause", code)
            end
            local pauseKey = ____t_result_4354
            local ____t_4357 = __t
            local ____t_result_4356
            if __t(__L1.dialog) then
                local ____t_result_4355
                if __t(confirm) then
                    ____t_result_4355 = confirm
                else
                    ____t_result_4355 = pauseKey
                end
                ____t_result_4356 = ____t_result_4355
            else
                ____t_result_4356 = __L1.dialog
            end
            if ____t_4357(____t_result_4356) then
                e:preventDefault()
                if not __t(e["repeat"]) then
                    local ____t_4363 = __t
                    local ____t_result_4362
                    if __t(pauseKey) then
                        ____t_result_4362 = pauseKey
                    else
                        local ____opt_4360 = e.target
                        local ____opt_4358 = ____opt_4360 and ____opt_4360.closest
                        if ____opt_4358 ~= nil then
                            ____opt_4358 = ____opt_4358(____opt_4360, "#dialogClose")
                        end
                        ____t_result_4362 = ____opt_4358
                    end
                    if ____t_4363(____t_result_4362) then
                        __L1:closeDialogue(false)
                    else
                        __L1:nextDialog()
                    end
                end
                return
            end
            local ____t_4371 = __t
            local ____t_result_4370
            local ____t_4369 = __t
            local ____t_result_4368
            local ____t_4367 = __t
            local ____t_result_4366
            if __t(__L1.cutscene) then
                ____t_result_4366 = __L1.cutscene
            else
                local ____opt_4364 = __L1.ollyanEncounter
                if ____opt_4364 ~= nil then
                    ____opt_4364 = ____opt_4364.stage
                end
                ____t_result_4366 = ____opt_4364 == "intro"
            end
            __O[2188] = ____t_result_4366
            if ____t_4367(____t_result_4366) then
                ____t_result_4368 = not __t(__L1.paused)
            else
                ____t_result_4368 = __O[2188]
            end
            __O[2189] = ____t_result_4368
            if ____t_4369(____t_result_4368) then
                ____t_result_4370 = confirm
            else
                ____t_result_4370 = __O[2189]
            end
            if ____t_4371(____t_result_4370) then
                e:preventDefault()
                if not __t(e["repeat"]) then
                    __L1:advanceCutscene()
                end
                return
            end
            local ____t_4379 = __t
            local ____t_result_4378
            local ____t_4377 = __t
            local ____t_result_4376
            local ____t_4375 = __t
            local ____t_result_4374
            local ____t_4373 = __t
            local ____t_result_4372
            if __t(pauseKey) then
                ____t_result_4372 = __L1.started
            else
                ____t_result_4372 = pauseKey
            end
            __O[2190] = ____t_result_4372
            if ____t_4373(____t_result_4372) then
                ____t_result_4374 = not __t(__L1.won)
            else
                ____t_result_4374 = __O[2190]
            end
            __O[2191] = ____t_result_4374
            if ____t_4375(____t_result_4374) then
                ____t_result_4376 = not __t(__L1.defeated)
            else
                ____t_result_4376 = __O[2191]
            end
            __O[2192] = ____t_result_4376
            if ____t_4377(____t_result_4376) then
                ____t_result_4378 = not __t(__L1.chapterEnded)
            else
                ____t_result_4378 = __O[2192]
            end
            if ____t_4379(____t_result_4378) then
                e:preventDefault()
                if not __t(e["repeat"]) then
                    if __t(__L1.paused) then
                        __L1:resume()
                    else
                        __L1:pause()
                    end
                end
                return
            end
            local ____t_4389 = __t
            local ____t_result_4388
            local ____t_4387 = __t
            local ____t_result_4386
            local ____t_4385 = __t
            local ____t_result_4384
            local ____t_4383 = __t
            local ____t_result_4382
            local ____t_4381 = __t
            local ____temp_4380 = not __t(__L1.started)
            __O[2193] = ____temp_4380
            if ____t_4381(____temp_4380) then
                ____t_result_4382 = __O[2193]
            else
                ____t_result_4382 = __L1.paused
            end
            __O[2194] = ____t_result_4382
            if ____t_4383(____t_result_4382) then
                ____t_result_4384 = __O[2194]
            else
                ____t_result_4384 = __L1.won
            end
            __O[2195] = ____t_result_4384
            if ____t_4385(____t_result_4384) then
                ____t_result_4386 = __O[2195]
            else
                ____t_result_4386 = __L1.defeated
            end
            __O[2196] = ____t_result_4386
            if ____t_4387(____t_result_4386) then
                ____t_result_4388 = __O[2196]
            else
                ____t_result_4388 = __L1.chapterEnded
            end
            if ____t_4389(____t_result_4388) then
                local button = __L1:visibleKeyboardButton(e.target)
                local ____t_4391 = __t
                local ____t_result_4390
                if __t(button) then
                    ____t_result_4390 = __call(
                        __arrL({"Enter", "Space"}, 2),
                        "includes",
                        code
                    )
                else
                    ____t_result_4390 = button
                end
                if ____t_4391(____t_result_4390) then
                    __call(
                        __L1.keyboardClicks,
                        "set",
                        button,
                        window.performance:now()
                    )
                end
                return
            end
            local ____t_4397 = __t
            local ____t_result_4396
            local ____t_4395 = __t
            local ____opt_4392 = __L1.activity
            if ____opt_4392 ~= nil then
                ____opt_4392 = ____opt_4392.kind
            end
            local ____temp_4394 = ____opt_4392 == "dinner" and __L1.activity.phase == "choice"
            __O[2197] = ____temp_4394
            if ____t_4395(____temp_4394) then
                ____t_result_4396 = __call(
                    __arrL({"Digit1", "Digit2", "Numpad1", "Numpad2"}, 4),
                    "includes",
                    code
                )
            else
                ____t_result_4396 = __O[2197]
            end
            if ____t_4397(____t_result_4396) then
                e:preventDefault()
                if not __t(e["repeat"]) then
                    __L1:submitActivity(__TS__Number(__call(code, "slice", -1)) - 1)
                end
                return
            end
            local ____t_4399 = __t
            local ____t_result_4398
            if __t(__L1.activity) then
                ____t_result_4398 = confirm
            else
                ____t_result_4398 = __L1.activity
            end
            if ____t_4399(____t_result_4398) then
                local ____t_4405 = __t
                local ____t_result_4404
                local ____t_4403 = __t
                local ____t_result_4402
                local ____t_4401 = __t
                local ____temp_4400 = __L1.activity.kind == "quiz" or __L1.activity.kind == "dinner"
                __O[2198] = ____temp_4400
                if ____t_4401(____temp_4400) then
                    ____t_result_4402 = __L1:visibleKeyboardButton(e.target)
                else
                    ____t_result_4402 = __O[2198]
                end
                __O[2199] = ____t_result_4402
                if ____t_4403(____t_result_4402) then
                    ____t_result_4404 = __call(
                        __arrL({"Enter", "Space"}, 2),
                        "includes",
                        code
                    )
                else
                    ____t_result_4404 = __O[2199]
                end
                if ____t_4405(____t_result_4404) then
                    __call(
                        __L1.keyboardClicks,
                        "set",
                        e.target:closest("button,a"),
                        window.performance:now()
                    )
                    return
                end
                e:preventDefault()
                if not __t(e["repeat"]) then
                    __L1:submitActivity()
                end
                return
            end
            local ____t_4410 = __t
            local ____t_result_4409
            local ____t_4408 = __t
            local ____opt_4406 = __L1.training
            if ____opt_4406 ~= nil then
                ____opt_4406 = ____opt_4406.active
            end
            __O[2200] = ____opt_4406
            if ____t_4408(____opt_4406) then
                ____t_result_4409 = confirm
            else
                ____t_result_4409 = __O[2200]
            end
            if ____t_4410(____t_result_4409) then
                e:preventDefault()
                if not __t(e["repeat"]) then
                    __L1:submitTraining()
                end
                return
            end
            local ____t_4424 = __t
            local ____t_result_4423
            local ____t_4421 = __t
            local ____t_result_4420
            local ____t_4418 = __t
            local ____t_result_4417
            local ____t_4416 = __t
            local ____t_result_4415
            local ____t_4414 = __t
            local ____t_result_4413
            if __t(__L1.activity) then
                ____t_result_4413 = __L1.activity
            else
                local ____opt_4411 = __L1.training
                if ____opt_4411 ~= nil then
                    ____opt_4411 = ____opt_4411.active
                end
                ____t_result_4413 = ____opt_4411
            end
            __O[2201] = ____t_result_4413
            if ____t_4414(____t_result_4413) then
                ____t_result_4415 = __O[2201]
            else
                ____t_result_4415 = __L1.cutscene
            end
            __O[2202] = ____t_result_4415
            if ____t_4416(____t_result_4415) then
                ____t_result_4417 = __O[2202]
            else
                ____t_result_4417 = __L1.routeTransition
            end
            __O[2203] = ____t_result_4417
            if ____t_4418(____t_result_4417) then
                ____t_result_4420 = __O[2203]
            else
                local ____t_result_4419
                if __t(__L1.room) then
                    ____t_result_4419 = __L1.room.phase ~= "inside"
                else
                    ____t_result_4419 = __L1.room
                end
                ____t_result_4420 = ____t_result_4419
            end
            __O[2204] = ____t_result_4420
            if ____t_4421(____t_result_4420) then
                ____t_result_4423 = __O[2204]
            else
                local ____t_result_4422
                if __t(__L1.arena) then
                    ____t_result_4422 = __L1.arena.phase ~= "active"
                else
                    ____t_result_4422 = __L1.arena
                end
                ____t_result_4423 = ____t_result_4422
            end
            if ____t_4424(____t_result_4423) then
                return
            end
            local ____t_4428 = __t
            local ____t_result_4427
            local ____t_4426 = __t
            local ____temp_4425 = code == "Enter"
            __O[2205] = ____temp_4425
            if ____t_4426(____temp_4425) then
                ____t_result_4427 = __L1:keyMatches("interact", code)
            else
                ____t_result_4427 = __O[2205]
            end
            if ____t_4428(____t_result_4427) then
                local button = __L1:visibleKeyboardButton(e.target)
                if __t(button) then
                    __call(
                        __L1.keyboardClicks,
                        "set",
                        button,
                        window.performance:now()
                    )
                    return
                end
            end
            local ____t_result_4432
            local ____t_4431 = __t
            local ____opt_4429 = window.ControlSettings
            if ____opt_4429 ~= nil then
                ____opt_4429 = ____opt_4429:getActionsForCode(code)
            end
            __O[2206] = ____opt_4429
            if ____t_4431(____opt_4429) then
                ____t_result_4432 = __O[2206]
            else
                ____t_result_4432 = __call(
                    __keys(__L1.defaultKeys),
                    "filter",
                    function(____, a) return __L1:keyMatches(a, code) end
                )
            end
            local mapped = ____t_result_4432
            if not __t(__len(mapped)) then
                return
            end
            e:preventDefault()
            local held = not not __t(__get(__L1.keys, code))
            local ____t_4434 = __t
            local ____t_result_4433
            if __t(e["repeat"]) then
                ____t_result_4433 = not __t(held)
            else
                ____t_result_4433 = e["repeat"]
            end
            if ____t_4434(____t_result_4433) then
                return
            end
            __set(__L1.keys, code, true)
            if __t(not __t(e["repeat"]) and not __t(held)) then
                for ____, a in __iterar((mapped)) do
                    if __t(not __t(__call(__L1.heldActions, "has", a)) and a ~= "pause") then
                        __L1:action(a)
                    end
                end
            end
        end
    )
    window:addEventListener(
        "keyup",
        function(____, e)
            __set(__L1.keys, e.code, false)
        end
    )
    window:addEventListener("controls-change", __L1.releaseInputs)
    window:addEventListener(
        "controls-capture",
        function(____, e)
            local ____t_4437 = __t
            local ____opt_4435 = e.detail
            if ____opt_4435 ~= nil then
                ____opt_4435 = ____opt_4435.active
            end
            __L1.inputCaptured = not not ____t_4437(____opt_4435)
            __L1:releaseInputs()
        end
    )
    window.document:addEventListener(
        "focusin",
        function(____, e)
            local ____t_4445 = __t
            local ____t_result_4444
            local ____t_4439 = __t
            local ____temp_4438 = __L1:editableTarget(e.target)
            __O[2209] = ____temp_4438
            if ____t_4439(____temp_4438) then
                ____t_result_4444 = __O[2209]
            else
                local ____opt_4442 = e.target
                local ____opt_4440 = ____opt_4442 and ____opt_4442.closest
                if ____opt_4440 ~= nil then
                    ____opt_4440 = ____opt_4440(____opt_4442, "dialog[open]")
                end
                ____t_result_4444 = ____opt_4440
            end
            if ____t_4445(____t_result_4444) then
                __L1:releaseInputs()
            end
        end
    )
    window:addEventListener(
        "blur",
        function()
            __L1:releaseInputs()
            local ____t_4449 = __t
            local ____t_result_4448
            local ____t_4447 = __t
            local ____t_result_4446
            if __t(__L1.started) then
                ____t_result_4446 = not __t(__L1.dialog)
            else
                ____t_result_4446 = __L1.started
            end
            __O[2210] = ____t_result_4446
            if ____t_4447(____t_result_4446) then
                ____t_result_4448 = not __t(__L1.won)
            else
                ____t_result_4448 = __O[2210]
            end
            if ____t_4449(____t_result_4448) then
                __L1:pause()
            end
        end
    )
    window:addEventListener("pagehide", __L1.releaseInputs)
    window:addEventListener("orientationchange", __L1.releaseInputs)
    local ____this_4457
    ____this_4457 = window.document
    local ____opt_4450 = ____this_4457.addEventListener
    if ____opt_4450 ~= nil then
        ____opt_4450(
            ____this_4457,
            "visibilitychange",
            function()
                __L1:releaseInputs()
                local ____t_4456 = __t
                local ____t_result_4455
                local ____t_4454 = __t
                local ____t_result_4453
                local ____t_4452 = __t
                local ____t_result_4451
                if __t(window.document.hidden) then
                    ____t_result_4451 = __L1.started
                else
                    ____t_result_4451 = window.document.hidden
                end
                __O[2211] = ____t_result_4451
                if ____t_4452(____t_result_4451) then
                    ____t_result_4453 = not __t(__L1.won)
                else
                    ____t_result_4453 = __O[2211]
                end
                __O[2212] = ____t_result_4453
                if ____t_4454(____t_result_4453) then
                    ____t_result_4455 = not __t(__L1.dialog)
                else
                    ____t_result_4455 = __O[2212]
                end
                if ____t_4456(____t_result_4455) then
                    __L1:pause()
                end
            end
        )
    end
    local ____this_4459
    ____this_4459 = window.document
    local ____opt_4458 = ____this_4459.addEventListener
    if ____opt_4458 ~= nil then
        ____opt_4458(____this_4459, "fullscreenchange", __L1.releaseInputs)
    end
    for ____, target in __iterar((__arrL({window.document, window}, 2))) do
        for ____, eventName in __iterar((__arrL({"pointerup", "pointercancel", "lostpointercapture"}, 3))) do
            local ____opt_4460 = target.addEventListener
            if ____opt_4460 ~= nil then
                ____opt_4460(
                    target,
                    eventName,
                    function(____, e) return __L1:releasePointer(e.pointerId) end,
                    true
                )
            end
        end
        local ____opt_4462 = target.addEventListener
        if ____opt_4462 ~= nil then
            ____opt_4462(
                target,
                "pointermove",
                function(____, e)
                    local p = __call(__L1.activePointers, "get", e.pointerId)
                    if __t(p) then
                        local ____e_clientX_4463 = e.clientX
                        if ____e_clientX_4463 == nil then
                            ____e_clientX_4463 = p.x
                        end
                        p.x = ____e_clientX_4463
                        local ____e_clientY_4464 = e.clientY
                        if ____e_clientY_4464 == nil then
                            ____e_clientY_4464 = p.y
                        end
                        p.y = ____e_clientY_4464
                    end
                end,
                true
            )
        end
        local ____opt_4466 = target.addEventListener
        if ____opt_4466 ~= nil then
            ____opt_4466(
                target,
                "touchend",
                __L1.reconcileTouches,
                __ord({capture = true, passive = true}, "capture,passive")
            )
        end
        local ____opt_4468 = target.addEventListener
        if ____opt_4468 ~= nil then
            ____opt_4468(
                target,
                "touchcancel",
                __L1.reconcileTouches,
                __ord({capture = true, passive = true}, "capture,passive")
            )
        end
    end
    __call(
        window.document:querySelectorAll("[data-action]"),
        "forEach",
        function(____, el)
            local a = el.dataset.action
            el:addEventListener(
                "pointerdown",
                function(____, e)
                    local ____t_4473 = __t
                    local ____t_result_4472
                    local ____t_4471 = __t
                    local ____temp_4470 = e.pointerType == "mouse" and e.button ~= 0
                    __O[2213] = ____temp_4470
                    if ____t_4471(____temp_4470) then
                        ____t_result_4472 = __O[2213]
                    else
                        ____t_result_4472 = __call(__L1.activePointers, "has", e.pointerId)
                    end
                    if ____t_4473(____t_result_4472) then
                        return
                    end
                    e:preventDefault()
                    local ____t_4510 = __t
                    local ____t_result_4509
                    local ____t_4480 = __t
                    local ____t_result_4479
                    if __t(__L1.inputCaptured) then
                        ____t_result_4479 = __L1.inputCaptured
                    else
                        local ____opt_4476 = window.Arena
                        if ____opt_4476 ~= nil then
                            ____opt_4476 = ____opt_4476.isOpen
                        end
                        local ____opt_result_4478
                        if ____opt_4476 ~= nil then
                            ____opt_result_4478 = ____opt_4476(____opt_4476)
                        end
                        ____t_result_4479 = ____opt_result_4478
                    end
                    __O[2225] = ____t_result_4479
                    if ____t_4480(____t_result_4479) then
                        ____t_result_4509 = __O[2225]
                    else
                        local ____t_result_4508
                        local ____t_4482 = __t
                        local ____call_result_4481 = __call(__L1.heldActions, "has", a)
                        __O[2224] = ____call_result_4481
                        if ____t_4482(____call_result_4481) then
                            local ____t_result_4507
                            local ____t_4504 = __t
                            local ____t_result_4503
                            local ____t_4502 = __t
                            local ____t_result_4501
                            local ____t_4500 = __t
                            local ____t_result_4499
                            local ____t_4497 = __t
                            local ____t_result_4496
                            local ____t_4494 = __t
                            local ____t_result_4493
                            local ____t_4492 = __t
                            local ____t_result_4491
                            local ____t_4490 = __t
                            local ____t_result_4489
                            local ____t_4488 = __t
                            local ____t_result_4487
                            local ____t_4486 = __t
                            local ____t_result_4485
                            local ____t_4484 = __t
                            local ____temp_4483 = not __t(__L1.started)
                            __O[2214] = ____temp_4483
                            if ____t_4484(____temp_4483) then
                                ____t_result_4485 = __O[2214]
                            else
                                ____t_result_4485 = __L1.paused
                            end
                            __O[2215] = ____t_result_4485
                            if ____t_4486(____t_result_4485) then
                                ____t_result_4487 = __O[2215]
                            else
                                ____t_result_4487 = __L1.dialog
                            end
                            __O[2216] = ____t_result_4487
                            if ____t_4488(____t_result_4487) then
                                ____t_result_4489 = __O[2216]
                            else
                                ____t_result_4489 = __L1.won
                            end
                            __O[2217] = ____t_result_4489
                            if ____t_4490(____t_result_4489) then
                                ____t_result_4491 = __O[2217]
                            else
                                ____t_result_4491 = __L1.defeated
                            end
                            __O[2218] = ____t_result_4491
                            if ____t_4492(____t_result_4491) then
                                ____t_result_4493 = __O[2218]
                            else
                                ____t_result_4493 = __L1.cutscene
                            end
                            __O[2219] = ____t_result_4493
                            if ____t_4494(____t_result_4493) then
                                ____t_result_4496 = __O[2219]
                            else
                                local ____t_result_4495
                                if __t(__L1.room) then
                                    ____t_result_4495 = __L1.room.phase ~= "inside"
                                else
                                    ____t_result_4495 = __L1.room
                                end
                                ____t_result_4496 = ____t_result_4495
                            end
                            __O[2220] = ____t_result_4496
                            if ____t_4497(____t_result_4496) then
                                ____t_result_4499 = __O[2220]
                            else
                                local ____t_result_4498
                                if __t(__L1.arena) then
                                    ____t_result_4498 = __L1.arena.phase ~= "active"
                                else
                                    ____t_result_4498 = __L1.arena
                                end
                                ____t_result_4499 = ____t_result_4498
                            end
                            __O[2221] = ____t_result_4499
                            if ____t_4500(____t_result_4499) then
                                ____t_result_4501 = __O[2221]
                            else
                                ____t_result_4501 = __L1.routeTransition
                            end
                            __O[2222] = ____t_result_4501
                            if ____t_4502(____t_result_4501) then
                                ____t_result_4503 = __O[2222]
                            else
                                ____t_result_4503 = __L1.activity
                            end
                            __O[2223] = ____t_result_4503
                            if ____t_4504(____t_result_4503) then
                                ____t_result_4507 = __O[2223]
                            else
                                local ____opt_4505 = __L1.training
                                if ____opt_4505 ~= nil then
                                    ____opt_4505 = ____opt_4505.active
                                end
                                ____t_result_4507 = ____opt_4505
                            end
                            ____t_result_4508 = ____t_result_4507
                        else
                            ____t_result_4508 = __O[2224]
                        end
                        ____t_result_4509 = ____t_result_4508
                    end
                    if ____t_4510(____t_result_4509) then
                        return
                    end
                    __call(
                        __L1.pointerTimes,
                        "set",
                        el,
                        window.performance:now()
                    )
                    local ____call_4517 = __call
                    local ____L1_activePointers_4515 = __L1.activePointers
                    local ____e_pointerId_4516 = e.pointerId
                    local ____el_4514 = el
                    local ____t_result_4511
                    if __t(e.pointerType) then
                        ____t_result_4511 = e.pointerType
                    else
                        ____t_result_4511 = "touch"
                    end
                    local ____e_clientX_4512 = e.clientX
                    if ____e_clientX_4512 == nil then
                        ____e_clientX_4512 = 0
                    end
                    local ____e_clientY_4513 = e.clientY
                    if ____e_clientY_4513 == nil then
                        ____e_clientY_4513 = 0
                    end
                    ____call_4517(____L1_activePointers_4515, "set", ____e_pointerId_4516, {
                        action = a,
                        element = ____el_4514,
                        pointerType = ____t_result_4511,
                        x = ____e_clientX_4512,
                        y = ____e_clientY_4513
                    })
                    __L1:safe(function() return el:setPointerCapture(e.pointerId) end)
                    __L1:refreshTouchState()
                    if not __t(__call(__L1.heldActions, "has", a)) then
                        __L1:action(a)
                    end
                end
            )
            for ____, eventName in __iterar((__arrL({"pointerup", "pointercancel", "lostpointercapture"}, 3))) do
                el:addEventListener(
                    eventName,
                    function(____, e) return __L1:releasePointer(e.pointerId) end
                )
            end
            el:addEventListener(
                "click",
                function(____, e)
                    local ____t_4527 = __t
                    local ____t_result_4526
                    local ____t_4525 = __t
                    local ____t_result_4524
                    local ____t_4521 = __t
                    local ____t_result_4520
                    local ____t_4519 = __t
                    local ____temp_4518 = e.detail ~= 0
                    __O[2226] = ____temp_4518
                    if ____t_4519(____temp_4518) then
                        ____t_result_4520 = __O[2226]
                    else
                        ____t_result_4520 = __call(__L1.heldActions, "has", a)
                    end
                    __O[2227] = ____t_result_4520
                    if ____t_4521(____t_result_4520) then
                        ____t_result_4524 = __O[2227]
                    else
                        local ____opt_4522 = e.sourceCapabilities
                        if ____opt_4522 ~= nil then
                            ____opt_4522 = ____opt_4522.firesTouchEvents
                        end
                        ____t_result_4524 = ____opt_4522
                    end
                    __O[2228] = ____t_result_4524
                    if ____t_4525(____t_result_4524) then
                        ____t_result_4526 = __O[2228]
                    else
                        ____t_result_4526 = e.pointerType == "touch"
                    end
                    if ____t_4527(____t_result_4526) then
                        return
                    end
                    local pointerAt = __call(__L1.pointerTimes, "get", el)
                    local keyboardAt = __call(__L1.keyboardClicks, "get", el)
                    local ____t_4531 = __t
                    local ____t_result_4530
                    local ____t_4529 = __t
                    local ____temp_4528 = pointerAt ~= nil and window.performance:now() - pointerAt < 750
                    __O[2229] = ____temp_4528
                    if ____t_4529(____temp_4528) then
                        ____t_result_4530 = not __t(keyboardAt ~= nil and __ge(keyboardAt, pointerAt))
                    else
                        ____t_result_4530 = __O[2229]
                    end
                    if ____t_4531(____t_result_4530) then
                        return
                    end
                    __L1:action(a)
                end
            )
        end
    )
    __call(
        window.document:querySelectorAll("[data-scene]"),
        "forEach",
        function(____, el) return el:addEventListener(
            "click",
            function() return __L1:travel(__TS__Number(el.dataset.scene)) end
        ) end
    )
    local ____opt_4532 = __L1["$"](__L1, "startBtn")
    if ____opt_4532 ~= nil then
        ____opt_4532:addEventListener(
            "click",
            function() return __L1:start(false) end
        )
    end
    local ____opt_4534 = __L1["$"](__L1, "continueBtn")
    if ____opt_4534 ~= nil then
        ____opt_4534:addEventListener(
            "click",
            function() return __L1:start(true) end
        )
    end
    local ____opt_4536 = __L1["$"](__L1, "pauseBtn")
    if ____opt_4536 ~= nil then
        ____opt_4536:addEventListener(
            "click",
            function()
                local ____t_result_4537
                if __t(__L1.paused) then
                    ____t_result_4537 = __L1:resume()
                else
                    ____t_result_4537 = __L1:pause()
                end
                return ____t_result_4537
            end
        )
    end
    local ____opt_4539 = __L1["$"](__L1, "resumeBtn")
    if ____opt_4539 ~= nil then
        ____opt_4539:addEventListener("click", __L1.resume)
    end
    local ____opt_4541 = __L1["$"](__L1, "restartBtn")
    if ____opt_4541 ~= nil then
        ____opt_4541:addEventListener("click", __L1.reset)
    end
    local ____opt_4543 = __L1["$"](__L1, "soundBtn")
    if ____opt_4543 ~= nil then
        ____opt_4543:addEventListener(
            "click",
            function()
                __L1:setSoundEnabled(not __t(__L1.sound))
                __L1:beep(660, 0.1, "triangle")
            end
        )
    end
    do
        local i = 0
        while i < 3 do
            local ____opt_4545 = __L1["$"](
                __L1,
                __add("activityChoice", i)
            )
            if ____opt_4545 ~= nil then
                ____opt_4545:addEventListener(
                    "click",
                    function()
                        local ____L1_submitActivity_4549 = __L1.submitActivity
                        local ____opt_4546 = __L1["$"](
                            __L1,
                            __add("activityChoice", i)
                        )
                        if ____opt_4546 ~= nil then
                            ____opt_4546 = ____opt_4546.dataset.value
                        end
                        local ____opt_4546_4548 = ____opt_4546
                        if ____opt_4546_4548 == nil then
                            ____opt_4546_4548 = i
                        end
                        return ____L1_submitActivity_4549(
                            __L1,
                            __TS__Number(____opt_4546_4548)
                        )
                    end
                )
            end
            i = i + 1
        end
    end
    local ____opt_4551 = __L1["$"](__L1, "activityExitBtn")
    if ____opt_4551 ~= nil then
        ____opt_4551:addEventListener("click", __L1.cancelActivity)
    end
    local ____opt_4553 = __L1["$"](__L1, "cutsceneNextBtn")
    if ____opt_4553 ~= nil then
        ____opt_4553:addEventListener("click", __L1.advanceCutscene)
    end
    local ____opt_4555 = __L1["$"](__L1, "cutsceneSkipBtn")
    if ____opt_4555 ~= nil then
        ____opt_4555:addEventListener("click", __L1.skipCutscene)
    end
    local ____opt_4557 = __L1["$"](__L1, "replayIntroBtn")
    if ____opt_4557 ~= nil then
        ____opt_4557:addEventListener("click", __L1.replayIntro)
    end
    local ____opt_4559 = __L1["$"](__L1, "roomExitBtn")
    if ____opt_4559 ~= nil then
        ____opt_4559:addEventListener("click", __L1.exitRoom)
    end
    local ____opt_4561 = __L1["$"](__L1, "trainingExitBtn")
    if ____opt_4561 ~= nil then
        ____opt_4561:addEventListener("click", __L1.cancelTraining)
    end
    local ____opt_4563 = __L1["$"](__L1, "respawnBtn")
    if ____opt_4563 ~= nil then
        ____opt_4563:addEventListener("click", __L1.respawn)
    end
    __L1.sandboxScenes = __ord({
        igor = 1,
        kaique = 1,
        arthur = 9,
        dede = 5,
        freddy = 5,
        reeisBoss = 5,
        marco = 1,
        giant = 6,
        nicolas = 4,
        menezes = 1,
        ollyan = 11,
        nikolas = 3
    }, "igor,kaique,arthur,dede,freddy,reeisBoss,marco,giant,nicolas,menezes,ollyan,nikolas")
    __L1.copyState = function(____, value) return window.JSON:parse(window.JSON:stringify(value)) end
    window.Game = __ord(
        {
            soundOn = function() return __L1.sound end,
            setSoundEnabled = __L1.setSoundEnabled,
            getJaglionStatus = __L1.getJaglionStatus,
            openSwiftGuide = __L1.openSwiftGuide,
            startSandboxBoss = __L1.startSandboxBoss,
            retrySandboxBoss = __L1.retrySandboxBoss,
            exitSandbox = __L1.exitSandbox,
            activateBivolt = __L1.activateBivolt,
            beginOllyanEncounter = __L1.beginOllyanEncounter,
            retreatOllyan = __L1.retreatOllyan,
            advanceDialogue = __L1.nextDialog,
            closeDialogue = __L1.closeDialogue,
            getDialogueView = __L1.getDialogueView,
            getAudioState = __L1.getAudioState,
            getBossStatus = __L1.getBossStatus,
            continueExploring = __L1.continueExploring,
            replayEpilogue = __L1.replayEpilogue,
            returnToMenu = __L1.returnToMenu,
            getViewTarget = function()
                local ____opt_4567 = __L1.ollyanEncounter
                if ____opt_4567 ~= nil then
                    ____opt_4567 = ____opt_4567.player
                end
                local ____opt_result_4569
                if ____opt_4567 ~= nil then
                    ____opt_result_4569 = ____opt_4567.y
                end
                local ____opt_result_4569_4570 = ____opt_result_4569
                if ____opt_result_4569_4570 == nil then
                    ____opt_result_4569_4570 = __L1.player.y
                end
                local ____t_result_4571
                if __t(__L1.vehicle) then
                    ____t_result_4571 = __L1.vehicle
                else
                    ____t_result_4571 = not not __t(__L1.ollyanEncounter)
                end
                return {y = ____opt_result_4569_4570, vehicle = ____t_result_4571}
            end,
            getDialogueAnchor = __L1.getDialogueAnchor,
            submitActivity = __L1.submitActivity,
            cancelActivity = __L1.cancelActivity,
            spendStat = __L1.spendStat,
            routeReason = __L1.routeReason,
            advanceCutscene = __L1.advanceCutscene,
            skipCutscene = __L1.skipCutscene,
            replayIntro = __L1.replayIntro,
            enterRoom = __L1.enterRoom,
            exitRoom = __L1.exitRoom,
            retreatBoss = __L1.retreatBoss,
            setJoystick = __L1.setJoystick,
            dash = __L1.dash,
            respawn = __L1.respawn,
            releaseInputs = __L1.releaseInputs,
            start = __L1.start,
            travel = __L1.travel,
            pause = __L1.pause,
            resume = __L1.resume,
            reset = __L1.reset,
            submitTraining = __L1.submitTraining,
            cancelTraining = __L1.cancelTraining,
            taunt = __L1.taunt,
            craft = __L1.craft,
            getState = function()
                local ____t_result_4578
                local ____t_4577 = __t
                local ____opt_4574 = window.CampaignRun
                if ____opt_4574 ~= nil then
                    ____opt_4574 = ____opt_4574.getState
                end
                local ____opt_result_4576
                if ____opt_4574 ~= nil then
                    ____opt_result_4576 = ____opt_4574(____opt_4574)
                end
                __O[2265] = ____opt_result_4576
                if ____t_4577(____opt_result_4576) then
                    ____t_result_4578 = __O[2265]
                else
                    ____t_result_4578 = nil
                end
                local ____t_result_4579
                if __t(__L1.sandbox) then
                    ____t_result_4579 = {type = __L1.sandbox.type, result = __L1.sandbox.result, difficultyMode = __L1.sandbox.difficultyMode}
                else
                    ____t_result_4579 = nil
                end
                local ____assign_result_4593 = __assign(
                    {},
                    __L1:bivoltStatus()
                )
                local ____t_result_4580
                if __t(__L1.ollyanEncounter) then
                    ____t_result_4580 = __assign(
                        {},
                        window.OllyanEncounter:getStatus(__L1.ollyanEncounter),
                        {player = __assign({}, __L1.ollyanEncounter.player)}
                    )
                else
                    ____t_result_4580 = nil
                end
                local ____L1_started_4594 = __L1.started
                local ____L1_playing_4595 = __L1.playing
                local ____L1_paused_4596 = __L1.paused
                local ____L1_won_4597 = __L1.won
                local ____L1_chapterEnded_4598 = __L1.chapterEnded
                local ____L1_scene_4599 = __L1.scene
                local ____L1_camera_4600 = __L1.camera
                local ____t_result_4581
                if __t(__L1:closestBoss()) then
                    ____t_result_4581 = __assign(
                        {},
                        {
                            type = __L1:closestBoss().type,
                            name = __L1:nomeBoss(__L1:closestBoss().type)
                        },
                        __L1:bossAccess(__L1:closestBoss())
                    )
                else
                    ____t_result_4581 = nil
                end
                local ____assign_result_4601 = __assign({}, __L1.q)
                local ____assign_result_4602 = __assign({}, __L1.player)
                local ____call_result_4603 = __call(
                    __L1.enemies,
                    "map",
                    function(____, e) return __assign({}, e) end
                )
                local ____call_result_4604 = __call(
                    __L1.targets,
                    "map",
                    function(____, t) return __assign({}, t) end
                )
                local ____t_result_4582
                if __t(__L1.dialog) then
                    ____t_result_4582 = __assign({}, __L1.dialog)
                else
                    ____t_result_4582 = nil
                end
                local ____assign_result_4605 = __assign({}, __L1.items)
                local ____temp_4606 = __L1:materialCount()
                local ____arr_result_4607 = __arr(__TS__Spread(__iter(__L1.collected)))
                local ____L1_weapon_4608 = __L1.weapon
                local ____get_result_4609 = __get(__L1.weaponNames, __L1.weapon)
                local ____temp_4610 = __L1:levelState()
                local ____L1_comboStep_4611 = __L1.comboStep
                local ____arr_result_4612 = __arr(__TS__Spread(__iter(__L1.seenBossIntros)))
                local ____t_result_4583
                if __t(__L1.activity) then
                    ____t_result_4583 = __assign({}, __L1.activity)
                else
                    ____t_result_4583 = nil
                end
                local ____t_result_4584
                if __t(__L1.training) then
                    ____t_result_4584 = __assign({}, __L1.training)
                else
                    ____t_result_4584 = nil
                end
                local ____call_result_4613 = __call(
                    __L1.shots,
                    "map",
                    function(____, s) return __assign({}, s) end
                )
                local ____L1_vehicle_4614 = __L1.vehicle
                local ____L1_reeisTimer_4615 = __L1.reeisTimer
                local ____L1_reeisCooldown_4616 = __L1.reeisCooldown
                local ____L1_reeisPhase_4617 = __L1.reeisPhase
                local ____L1_reeisX_4618 = __L1.reeisX
                local ____L1_reeisPhaseTimer_4619 = __L1.reeisPhaseTimer
                local ____assign_result_4620 = __assign({}, __L1.joystick)
                local ____L1_dashTimer_4621 = __L1.dashTimer
                local ____L1_dashCooldown_4622 = __L1.dashCooldown
                local ____t_result_4588
                local ____t_4587 = __t
                local ____opt_4585 = __L1.activeBoss
                if ____opt_4585 ~= nil then
                    ____opt_4585 = ____opt_4585.type
                end
                __O[2266] = ____opt_4585
                if ____t_4587(____opt_4585) then
                    ____t_result_4588 = __O[2266]
                else
                    ____t_result_4588 = nil
                end
                local ____L1_defeated_4623 = __L1.defeated
                local ____t_result_4589
                if __t(__L1.routeTransition) then
                    ____t_result_4589 = __assign({}, __L1.routeTransition)
                else
                    ____t_result_4589 = nil
                end
                local ____call_result_4624 = __call(
                    __L1.hazards,
                    "map",
                    function(____, h) return __assign({}, h) end
                )
                local ____L1_WORLD_4625 = __L1.WORLD
                local ____t_result_4590
                if __t(__L1.room) then
                    ____t_result_4590 = __assign({}, __L1.room)
                else
                    ____t_result_4590 = nil
                end
                local ____t_result_4591
                if __t(__L1.arena) then
                    ____t_result_4591 = __assign({}, __L1.arena)
                else
                    ____t_result_4591 = nil
                end
                local ____t_result_4592
                if __t(__L1.cutscene) then
                    ____t_result_4592 = __assign({}, __L1.cutscene)
                else
                    ____t_result_4592 = nil
                end
                return {
                    run = ____t_result_4578,
                    sandbox = ____t_result_4579,
                    bivolt = ____assign_result_4593,
                    ollyan = ____t_result_4580,
                    started = ____L1_started_4594,
                    playing = ____L1_playing_4595,
                    paused = ____L1_paused_4596,
                    won = ____L1_won_4597,
                    chapterEnded = ____L1_chapterEnded_4598,
                    scene = ____L1_scene_4599,
                    camera = ____L1_camera_4600,
                    nearBoss = ____t_result_4581,
                    q = ____assign_result_4601,
                    player = ____assign_result_4602,
                    enemies = ____call_result_4603,
                    targets = ____call_result_4604,
                    dialog = ____t_result_4582,
                    items = ____assign_result_4605,
                    materialCount = ____temp_4606,
                    collected = ____arr_result_4607,
                    weapon = ____L1_weapon_4608,
                    weaponName = ____get_result_4609,
                    progression = ____temp_4610,
                    comboStep = ____L1_comboStep_4611,
                    seenBossIntros = ____arr_result_4612,
                    activity = ____t_result_4583,
                    training = ____t_result_4584,
                    shots = ____call_result_4613,
                    vehicle = ____L1_vehicle_4614,
                    reeisTimer = ____L1_reeisTimer_4615,
                    reeisCooldown = ____L1_reeisCooldown_4616,
                    reeisPhase = ____L1_reeisPhase_4617,
                    reeisX = ____L1_reeisX_4618,
                    reeisPhaseTimer = ____L1_reeisPhaseTimer_4619,
                    joystick = ____assign_result_4620,
                    dashTimer = ____L1_dashTimer_4621,
                    dashCooldown = ____L1_dashCooldown_4622,
                    activeBoss = ____t_result_4588,
                    defeated = ____L1_defeated_4623,
                    routeTransition = ____t_result_4589,
                    hazards = ____call_result_4624,
                    worldWidth = ____L1_WORLD_4625,
                    room = ____t_result_4590,
                    arena = ____t_result_4591,
                    cutscene = ____t_result_4592,
                    minions = __call(
                        __L1.minions,
                        "map",
                        function(____, m) return __assign({}, m) end
                    ),
                    minionKills = __arr(__TS__Spread(__iter(__L1.minionKills))),
                    touchActions = __call(
                        __keys(__L1.touch),
                        "filter",
                        function(____, a) return __get(__L1.touch, a) end
                    ),
                    activePointers = __call(
                        __arr(__TS__Spread(__iter(__L1.activePointers))),
                        "map",
                        function(____, ____bindingPattern0)
                            local p
                            local pointerId
                            pointerId = ____bindingPattern0[1]
                            p = ____bindingPattern0[2]
                            return {pointerId = pointerId, action = p.action, pointerType = p.pointerType}
                        end
                    )
                }
            end
        },
        "soundOn,setSoundEnabled,getJaglionStatus,openSwiftGuide,startSandboxBoss,retrySandboxBoss,exitSandbox,activateBivolt,beginOllyanEncounter,retreatOllyan,advanceDialogue,closeDialogue,getDialogueView,getAudioState,getBossStatus,continueExploring,replayEpilogue,returnToMenu,getViewTarget,getDialogueAnchor,submitActivity,cancelActivity,spendStat,routeReason,advanceCutscene,skipCutscene,replayIntro,enterRoom,exitRoom,retreatBoss,setJoystick,dash,respawn,releaseInputs,start,travel,pause,resume,reset,submitTraining,cancelTraining,taunt,craft,getState"
    )
    window:addEventListener(
        "campaign-run-change",
        function(____, event)
            local ____t_4633 = __t
            local ____t_result_4632
            local ____t_4631 = __t
            local ____t_result_4630
            local ____t_4629 = __t
            local ____opt_4626 = event.detail
            if ____opt_4626 ~= nil then
                ____opt_4626 = ____opt_4626.reason
            end
            local ____temp_4628 = ____opt_4626 == "difficulty"
            __O[2267] = ____temp_4628
            if ____t_4629(____temp_4628) then
                ____t_result_4630 = __L1.started
            else
                ____t_result_4630 = __O[2267]
            end
            __O[2268] = ____t_result_4630
            if ____t_4631(____t_result_4630) then
                ____t_result_4632 = not __t(__L1.sandbox)
            else
                ____t_result_4632 = __O[2268]
            end
            if ____t_4633(____t_result_4632) then
                __L1:save()
                __L1:updateUI()
            end
        end
    )
    window:addEventListener(
        "progression-change",
        function()
            if __t(not __t(__L1.started) or not __t(__L1.player)) then
                return
            end
            __L1.player.hp = math.min(
                __L1.player.hp,
                __L1:bonus().maxHP
            )
            __L1.player.gas = math.min(
                __L1.player.gas,
                __L1:bonus().maxGas
            )
            __L1:updateUI()
            __L1:save()
        end
    )
    __L1:show("chapterEndScreen", false)
    __L1:show("pauseScreen", false)
    __L1:show("dialogBox", false)
    __L1:show("victoryScreen", false)
    __L1:show("defeatScreen", false)
    __L1:show("cinematicOverlay", false)
    __L1:show("roomOverlay", false)
    __L1:updateContinue()
    __L1:populate()
    __L1:updateUI()
    window:requestAnimationFrame(__L1.frame)
end)(nil)
return ____exports
