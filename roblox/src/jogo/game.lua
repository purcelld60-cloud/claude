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
        local ____t_5 = __t
        local ____opt_2 = window.BivoltSkill
        if ____opt_2 ~= nil then
            ____opt_2 = ____opt_2.getStatus
        end
        local ____opt_result_4
        if ____opt_2 ~= nil then
            ____opt_result_4 = ____opt_2(____opt_2, __L1.q)
        end
        __O[1597] = ____opt_result_4
        return if ____t_5(____opt_result_4) then __O[1597] else {
            unlocked = false,
            charges = 0,
            remaining = 0,
            cooldown = 0,
            active = false,
            ready = false
        }
    end
    __L1.createBivoltControl = function(self)
        local container = window.document:querySelector(".touch-extras")
        local ____t_10 = __t
        local ____t_9 = __t
        local ____t_7 = __t
        local ____temp_6 = not __t(container)
        __O[1598] = ____temp_6
        local ____temp_8 = if ____t_7(____temp_6) then __O[1598] else __L1["$"](__L1, "bivoltBtn")
        __O[1599] = ____temp_8
        if ____t_10(if ____t_9(____temp_8) then __O[1599] else not __t(window.BivoltSkill)) then
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
                button.classList:toggle(name, if name == "active" then state.active else if name == "cooling" then __gt(state.cooldown, 0) and not __t(state.active) else if name == "locked" then not __t(state.unlocked) else __le(state.charges, 0))
            end
            local label = button:querySelector(".bivolt-label")
            local count = button:querySelector(".bivolt-count")
            if __t(label) then
                label.textContent = if __t(state.active) then __add(
                    __call(state.remaining, "toFixed", 1),
                    "s"
                ) else if __gt(state.cooldown, 0) then __add(
                    math.ceil(state.cooldown),
                    "s"
                ) else "BIVOLT"
            end
            if __t(count) then
                count.textContent = state.charges
            end
            button:setAttribute("aria-label", if __t(state.active) then __add(
                __add(
                    "Bivolt ativo por mais ",
                    __call(state.remaining, "toFixed", 1)
                ),
                " segundos"
            ) else if not __t(state.unlocked) then "Bivolt: encontre as garotas na Casa de Rayssa" else if __gt(state.cooldown, 0) then __add(
                __add(
                    "Bivolt recarregando por ",
                    math.ceil(state.cooldown)
                ),
                " segundos"
            ) else __add(
                __add("Usar Bivolt por 10 segundos. ", state.charges),
                " latas"
            ))
            local ____button_setAttribute_17 = button.setAttribute
            local ____t_16 = __t
            local ____t_14 = __t
            local ____t_12 = __t
            local ____temp_11 = not __t(state.ready)
            __O[1600] = ____temp_11
            local ____temp_13 = if ____t_12(____temp_11) then __O[1600] else __L1.paused
            __O[1601] = ____temp_13
            local ____temp_15 = if ____t_14(____temp_13) then __O[1601] else not not __t(__L1.dialog)
            __O[1602] = ____temp_15
            ____button_setAttribute_17(
                button,
                "aria-disabled",
                tostring(if ____t_16(____temp_15) then __O[1602] else not not __t(__L1.cutscene))
            )
            button.title = if __t(state.active) then "Todos os atributos fortalecidos por 10 segundos" else if not __t(state.unlocked) then "Missão do Bivolt na Casa de Rayssa" else "B · energético: vida, gás, força e agilidade por 10 segundos"
        end
        local ____opt_18 = __L1["$"](__L1, "gameShell")
        if ____opt_18 ~= nil then
            ____opt_18.classList:toggle("is-bivolt", state.active)
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
        local ____t_40 = __t
        local ____t_39 = __t
        local ____t_37 = __t
        local ____t_35 = __t
        local ____t_33 = __t
        local ____t_29 = __t
        local ____t_27 = __t
        local ____t_25 = __t
        local ____t_23 = __t
        local ____t_21 = __t
        local ____temp_20 = not __t(__L1.started)
        __O[1603] = ____temp_20
        local ____temp_22 = if ____t_21(____temp_20) then __O[1603] else __L1.paused
        __O[1604] = ____temp_22
        local ____temp_24 = if ____t_23(____temp_22) then __O[1604] else __L1.dialog
        __O[1605] = ____temp_24
        local ____temp_26 = if ____t_25(____temp_24) then __O[1605] else __L1.cutscene
        __O[1606] = ____temp_26
        local ____temp_28 = if ____t_27(____temp_26) then __O[1606] else __L1.routeTransition
        __O[1607] = ____temp_28
        local ____opt_30 = __L1.training
        if ____opt_30 ~= nil then
            ____opt_30 = ____opt_30.active
        end
        local ____temp_32 = if ____t_29(____temp_28) then __O[1607] else ____opt_30
        __O[1608] = ____temp_32
        local ____temp_34 = if ____t_33(____temp_32) then __O[1608] else __L1.activity
        __O[1609] = ____temp_34
        local ____temp_36 = if ____t_35(____temp_34) then __O[1609] else __L1.won
        __O[1610] = ____temp_36
        local ____temp_38 = if ____t_37(____temp_36) then __O[1610] else __L1.defeated
        __O[1611] = ____temp_38
        if ____t_40(if ____t_39(____temp_38) then __O[1611] else if __t(__L1.ollyanEncounter) then __L1.ollyanEncounter.stage ~= "fight" else __L1.ollyanEncounter) then
            return false
        end
        local before = __L1:bonus()
        local ____opt_43 = window.BivoltSkill
        if ____opt_43 ~= nil then
            ____opt_43 = ____opt_43.activate
        end
        local ____opt_result_45
        if ____opt_43 ~= nil then
            ____opt_result_45 = ____opt_43(____opt_43, __L1.q)
        end
        local result = ____opt_result_45
        local ____t_49 = __t
        local ____opt_result_48
        if result ~= nil then
            ____opt_result_48 = result.ok
        end
        if not ____t_49(____opt_result_48) then
            local ____L1_toast_54 = __L1.toast
            local ____t_53 = __t
            local ____opt_result_52
            if result ~= nil then
                ____opt_result_52 = result.message
            end
            __O[1612] = ____opt_result_52
            ____L1_toast_54(__L1, if ____t_53(____opt_result_52) then __O[1612] else "Converse com as garotas na Casa de Rayssa para encontrar o Bivolt.")
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
        __L1:toast(if __t(result.message) then result.message else "BIVOLT! Todos os atributos fortalecidos por 10 segundos.")
        __L1:updateUI()
        __L1:save()
        return true
    end
    __L1.updateBivolt = function(self, dt)
        local ____opt_57 = window.BivoltSkill
        if ____opt_57 ~= nil then
            ____opt_57 = ____opt_57.update
        end
        local ____opt_result_59
        if ____opt_57 ~= nil then
            ____opt_result_59 = ____opt_57(____opt_57, dt)
        end
        local result = ____opt_result_59
        local ____t_63 = __t
        local ____opt_result_62
        if result ~= nil then
            ____opt_result_62 = result.expired
        end
        if ____t_63(____opt_result_62) then
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
        local ____opt_66 = window.BivoltSkill
        if ____opt_66 ~= nil then
            ____opt_66 = ____opt_66.reset
        end
        if ____opt_66 ~= nil then
            ____opt_66(____opt_66)
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
                c.fillStyle = if __t(__mod(i, 2)) then "#cce8a4" else "#ffe6a0"
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
        local ____t_96 = __t
        local ____t_95 = __t
        local ____t_93 = __t
        local ____t_91 = __t
        local ____t_89 = __t
        local ____t_87 = __t
        local ____t_85 = __t
        local ____t_83 = __t
        local ____t_81 = __t
        local ____t_77 = __t
        local ____t_75 = __t
        local ____t_73 = __t
        local ____t_71 = __t
        local ____t_69 = __t
        local ____temp_68 = not __t(__L1.started)
        __O[1613] = ____temp_68
        local ____temp_70 = if ____t_69(____temp_68) then __O[1613] else __L1.paused
        __O[1614] = ____temp_70
        local ____temp_72 = if ____t_71(____temp_70) then __O[1614] else __L1.dialog
        __O[1615] = ____temp_72
        local ____temp_74 = if ____t_73(____temp_72) then __O[1615] else __L1.cutscene
        __O[1616] = ____temp_74
        local ____temp_76 = if ____t_75(____temp_74) then __O[1616] else __L1.activity
        __O[1617] = ____temp_76
        local ____opt_78 = __L1.training
        if ____opt_78 ~= nil then
            ____opt_78 = ____opt_78.active
        end
        local ____temp_80 = if ____t_77(____temp_76) then __O[1617] else ____opt_78
        __O[1618] = ____temp_80
        local ____temp_82 = if ____t_81(____temp_80) then __O[1618] else __L1.arena
        __O[1619] = ____temp_82
        local ____temp_84 = if ____t_83(____temp_82) then __O[1619] else __L1.room
        __O[1620] = ____temp_84
        local ____temp_86 = if ____t_85(____temp_84) then __O[1620] else __L1.routeTransition
        __O[1621] = ____temp_86
        local ____temp_88 = if ____t_87(____temp_86) then __O[1621] else __L1.ollyanEncounter
        __O[1622] = ____temp_88
        local ____temp_90 = if ____t_89(____temp_88) then __O[1622] else __L1.defeated
        __O[1623] = ____temp_90
        local ____temp_92 = if ____t_91(____temp_90) then __O[1623] else __L1.won
        __O[1624] = ____temp_92
        local ____temp_94 = if ____t_93(____temp_92) then __O[1624] else __L1.scene ~= 11
        __O[1625] = ____temp_94
        if ____t_96(if ____t_95(____temp_94) then __O[1625] else __L1.q.ollyan) then
            return false
        end
        local ____t_102 = __t
        local ____opt_99 = window.BaileWorld
        if ____opt_99 ~= nil then
            ____opt_99 = ____opt_99.getNPC
        end
        local ____opt_result_101
        if ____opt_99 ~= nil then
            ____opt_result_101 = ____opt_99(____opt_99)
        end
        __O[1626] = ____opt_result_101
        local npc = if ____t_102(____opt_result_101) then __O[1626] else __L1.npcInfo.ollyan
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
        local ____t_108 = __t
        local ____opt_105 = window.Difficulty
        if ____opt_105 ~= nil then
            ____opt_105 = ____opt_105.getMode
        end
        local ____opt_result_107
        if ____opt_105 ~= nil then
            ____opt_result_107 = ____opt_105(____opt_105)
        end
        __O[1627] = ____opt_result_107
        local mode = if ____t_108(____opt_result_107) then __O[1627] else "normal"
        local ____t_114 = __t
        local ____opt_111 = window.Difficulty
        if ____opt_111 ~= nil then
            ____opt_111 = ____opt_111.getSettings
        end
        local ____opt_result_113
        if ____opt_111 ~= nil then
            ____opt_result_113 = ____opt_111(____opt_111, mode)
        end
        __O[1628] = ____opt_result_113
        local settings = if ____t_114(____opt_result_113) then __O[1628] else {hp = 1, incomingDamage = 1, windup = 1, recovery = 1}
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
        local ____opt_117 = window.FxPixel
        if ____opt_117 ~= nil then
            ____opt_117 = ____opt_117.limpar
        end
        if ____opt_117 ~= nil then
            ____opt_117(____opt_117, "ollyan")
        end
        if __t(__L1.sandbox) then
            __L1:finishSandbox(if result == "won" then "won" else if result == "defeated" then "defeated" else "retreat")
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
        __L1.player.x = if result == "won" then 3500 else 2900
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
                local ____L1_player_120 = __L1.player
                local ____event_hp_119 = event.hp
                if ____event_hp_119 == nil then
                    ____event_hp_119 = window.OllyanEncounter:getStatus(__L1.ollyanEncounter).playerHP
                end
                ____L1_player_120.hp = math.max(0, ____event_hp_119)
                __L1.hitFlash = 0.18
                __L1:beep(110, 0.1, "sawtooth")
            elseif event.type == "phase" then
                __L1:toast(__add(
                    __add(
                        __add("Ollyan · fase ", event.phase),
                        "/3: "
                    ),
                    if __t(event.name) then event.name else "o céu mudou de compasso"
                ))
            else
                local ____t_123 = __t
                local ____t_122 = __t
                local ____temp_121 = event.type == "won" or event.type == "defeated"
                __O[1629] = ____temp_121
                if ____t_123(if ____t_122(____temp_121) then __O[1629] else event.type == "retreat") then
                    __L1:finishOllyanEncounter(event.type)
                    break
                end
            end
        end
    end
    __L1.efeitoOllyan = function(self, ev)
        local F = window.FxPixel
        local E = __L1.ollyanEncounter
        local ____t_130 = __t
        local ____t_129 = __t
        local ____t_127 = __t
        local ____opt_result_126
        if F ~= nil then
            ____opt_result_126 = F.tocar
        end
        local ____temp_128 = not ____t_127(____opt_result_126) or not __t(E)
        __O[1630] = ____temp_128
        if ____t_130(if ____t_129(____temp_128) then __O[1630] else not __t(ev)) then
            return
        end
        local b = if __t(E.boss) then E.boss else {}
        local p = if __t(E.player) then E.player else {}
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
        local ____L1_clamp_139 = __L1.clamp
        local ____L1_joystick_x_134 = __L1.joystick.x
        local ____t_133 = __t
        local ____t_132 = __t
        local ____temp_131 = __L1:keyHeld("right")
        __O[1631] = ____temp_131
        local ____temp_138 = ____L1_joystick_x_134 + if ____t_133(if ____t_132(____temp_131) then __O[1631] else __L1.touch.right) then 1 else 0
        local ____t_137 = __t
        local ____t_136 = __t
        local ____temp_135 = __L1:keyHeld("left")
        __O[1632] = ____temp_135
        local ____L1_clamp_139_result_160 = ____L1_clamp_139(__L1, ____temp_138 - if ____t_137(if ____t_136(____temp_135) then __O[1632] else __L1.touch.left) then 1 else 0, -1, 1)
        local ____L1_clamp_150 = __L1.clamp
        local ____L1_joystick_y_143 = __L1.joystick.y
        local ____t_142 = __t
        local ____t_141 = __t
        local ____temp_140 = __L1:keyHeld("down")
        __O[1633] = ____temp_140
        local ____temp_149 = ____L1_joystick_y_143 + if ____t_142(if ____t_141(____temp_140) then __O[1633] else __L1.touch.down) then 1 else 0
        local ____t_148 = __t
        local ____t_147 = __t
        local ____t_145 = __t
        local ____temp_144 = __L1:keyHeld("up")
        __O[1634] = ____temp_144
        local ____temp_146 = if ____t_145(____temp_144) then __O[1634] else __L1:keyHeld("jump")
        __O[1635] = ____temp_146
        local ____L1_clamp_150_result_161 = ____L1_clamp_150(__L1, ____temp_149 - if ____t_148(if ____t_147(____temp_146) then __O[1635] else __L1.touch.jump) then 1 else 0, -1, 1)
        local ____temp_162 = __L1:keyHeld("paper")
        local ____temp_163 = __L1:keyHeld("fart")
        local ____t_159 = __t
        local ____t_158 = __t
        local ____t_156 = __t
        local ____t_154 = __t
        local ____t_152 = __t
        local ____temp_151 = __L1:keyHeld("jump")
        __O[1636] = ____temp_151
        local ____temp_153 = if ____t_152(____temp_151) then __O[1636] else __L1:keyHeld("up")
        __O[1637] = ____temp_153
        local ____temp_155 = if ____t_154(____temp_153) then __O[1637] else __L1.touch.jump
        __O[1638] = ____temp_155
        local ____temp_157 = if ____t_156(____temp_155) then __O[1638] else __L1.touch.up
        __O[1639] = ____temp_157
        local input = {
            x = ____L1_clamp_139_result_160,
            y = ____L1_clamp_150_result_161,
            fire = ____temp_162,
            fart = ____temp_163,
            jump = not not ____t_159(if ____t_158(____temp_157) then __O[1639] else __L1.joystick.y < -0.55)
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
        local ____t_168 = __t
        local ____t_167 = __t
        local ____t_165 = __t
        local ____temp_164 = not __t(__L1.ollyanEncounter)
        __O[1640] = ____temp_164
        local ____temp_166 = if ____t_165(____temp_164) then __O[1640] else __L1.paused
        __O[1641] = ____temp_166
        if ____t_168(if ____t_167(____temp_166) then __O[1641] else __L1.dialog) then
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
        local ____opt_171 = window.Progression
        if ____opt_171 ~= nil then
            ____opt_171 = ____opt_171.award
        end
        local ____opt_result_173
        if ____opt_171 ~= nil then
            ____opt_result_173 = ____opt_171(____opt_171, xp, id)
        end
        local r = ____opt_result_173
        if __t(if __t(r) then __gt(
            __L1:levelState().level,
            before
        ) else r) then
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
        local ____t_179 = __t
        local ____opt_176 = window.Campanha2
        if ____opt_176 ~= nil then
            ____opt_176 = ____opt_176.aberto
        end
        local ____opt_result_178
        if ____opt_176 ~= nil then
            ____opt_result_178 = ____opt_176(____opt_176)
        end
        if ____t_179(____opt_result_178) then
            local ____t_185 = __t
            local ____opt_182 = window.Progression
            if ____opt_182 ~= nil then
                ____opt_182 = ____opt_182.spend
            end
            local ____opt_result_184
            if ____opt_182 ~= nil then
                ____opt_result_184 = ____opt_182(____opt_182, stat, qtd)
            end
            __O[1645] = ____opt_result_184
            local ok = if ____t_185(____opt_result_184) then __O[1645] else false
            if __t(ok) then
                window:dispatchEvent(__new("CustomEvent", "c2-atributo", {detail = {stat = stat}}))
            end
            return ok
        end
        local old = __L1:bonus()
        local ____t_191 = __t
        local ____opt_188 = window.Progression
        if ____opt_188 ~= nil then
            ____opt_188 = ____opt_188.spend
        end
        local ____opt_result_190
        if ____opt_188 ~= nil then
            ____opt_result_190 = ____opt_188(____opt_188, stat, qtd)
        end
        __O[1646] = ____opt_result_190
        local ok = if ____t_191(____opt_result_190) then __O[1646] else false
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
        local ____opt_192 = __L1.room
        if ____opt_192 ~= nil then
            ____opt_192 = ____opt_192.phase
        end
        if ____opt_192 == "inside" then
            local ____arrL_201 = __arrL
            local ____L1_room_id_200 = __L1.room.id
            local ____t_199 = __t
            local ____opt_196 = window.FavelaCasas
            if ____opt_196 ~= nil then
                ____opt_196 = ____opt_196.ehCasa
            end
            local ____opt_result_198
            if ____opt_196 ~= nil then
                ____opt_result_198 = ____opt_196(____opt_196, __L1.room.id)
            end
            return if __t(math.abs(__L1.player.x - __L1.room.teacherX) < 105 and math.abs(__L1.player.y - __L1.FLOOR) < 100) then ____arrL_201({____L1_room_id_200, {name = if ____t_199(____opt_result_198) then window.FavelaCasas:nomeNpc(__L1.room.id) else if __L1.room.id == "almiro" then "Professor Almiro" else "Professor Miqueias", scene = __L1.scene, x = __L1.room.teacherX}}, 2) else nil
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
                        local ____t_207 = __t
                        local ____t_205 = __t
                        local ____t_203 = __t
                        local ____temp_202 = __L1:npcAvailable(id)
                        __O[1647] = ____temp_202
                        local ____temp_204 = if ____t_203(____temp_202) then n.scene == __L1.scene else __O[1647]
                        __O[1648] = ____temp_204
                        local ____temp_206 = if ____t_205(____temp_204) then math.abs(__L1.player.x - n.x) < 105 else __O[1648]
                        __O[1649] = ____temp_206
                        return if ____t_207(____temp_206) then math.abs(__L1.player.y - __L1.FLOOR) < 100 else __O[1649]
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
        local requirements = {
            marco = __arrL({"almiro", "miqueias", "reeis"}, 3),
            menezes = __arrL({"almiro", "miqueias", "marco", "giant"}, 4),
            reeisBoss = __arr(
                "mota",
                "almiro",
                "miqueias",
                __TS__Spread(__iter(if __t(__L1.q.reeis) then __arrL({}, 0) else __arrL({"freddy"}, 1)))
            ),
            freddy = __arrL({"mota", "almiro", "miqueias"}, 3),
            nicolas = __arrL({"mota"}, 1),
            dede = __arrL({"mota", "almiro", "miqueias"}, 3),
            arthur = __arrL({"patioAccepted"}, 1),
            giant = __arrL({"marco"}, 1),
            nikolas = __arrL({"giant", "menezes", "trained"}, 3)
        }
        local ____call_210 = __call
        local ____t_209 = __t
        local ____get_result_208 = __get(requirements, e.type)
        __O[1651] = ____get_result_208
        local missing = ____call_210(
            if ____t_209(____get_result_208) then __O[1651] else __arrL({}, 0),
            "filter",
            function(____, flag) return not __t(__get(__L1.q, flag)) end
        )
        local ____opt_213 = window.Campaign
        if ____opt_213 ~= nil then
            ____opt_213 = ____opt_213.bossRequirement
        end
        local ____opt_result_215
        if ____opt_213 ~= nil then
            ____opt_result_215 = ____opt_213(____opt_213, e.type, __L1.q)
        end
        local campaign = ____opt_result_215
        local ____temp_219 = __len(missing) == 0
        if ____temp_219 then
            local ____opt_result_218
            if campaign ~= nil then
                ____opt_result_218 = campaign.ok
            end
            ____temp_219 = ____opt_result_218 ~= false
        end
        local ____missing_224 = missing
        local ____call_result_225 = __call(
            missing,
            "map",
            function(____, flag) return __get(tasks, flag) end
        )
        local ____t_223 = __t
        local ____opt_result_222
        if campaign ~= nil then
            ____opt_result_222 = campaign.reason
        end
        __O[1652] = ____opt_result_222
        return {ok = ____temp_219, missing = ____missing_224, lines = ____call_result_225, reason = if __t(__len(missing)) then __get(
            tasks,
            __get(missing, 0)
        ) else if ____t_223(____opt_result_222) then __O[1652] else ""}
    end
    __L1.closestBoss = function(self)
        local ____t_229 = __t
        local ____get_result_228 = __get(
            __call(
                __call(
                    __L1.enemies,
                    "filter",
                    function(____, e)
                        local ____t_227 = __t
                        local ____temp_226 = __gt(e.hp, 0) and math.abs(e.x - __L1.player.x) <= 390
                        __O[1653] = ____temp_226
                        return if ____t_227(____temp_226) then math.abs(e.y - __L1.player.y) < 180 else __O[1653]
                    end
                ),
                "sort",
                function(____, a, b) return math.abs(a.x - __L1.player.x) - math.abs(b.x - __L1.player.x) end
            ),
            0
        )
        __O[1654] = ____get_result_228
        return if __t(not __t(__L1.room) and not __t(__L1.arena)) then if ____t_229(____get_result_228) then __O[1654] else nil else nil
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
            __call(lines, "push", {name = "Diário da aventura", text = if __t(access.reason) then access.reason else "Conclua a missão que aparece no diário antes deste confronto."})
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
        local speaker = if __t(line.name) then line.name else "Da Roça"
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
        local ____t_237 = __t
        local ____t_231 = __t
        local ____call_result_230 = __call(norm, "includes", __L1.room.id)
        __O[1655] = ____call_result_230
        local ____opt_234 = window.FavelaCasas
        if ____opt_234 ~= nil then
            ____opt_234 = ____opt_234.falante
        end
        local ____opt_result_236
        if ____opt_234 ~= nil then
            ____opt_result_236 = ____opt_234(____opt_234, __L1.room.id, norm)
        end
        if ____t_237(if __t(__L1.room) then if ____t_231(____call_result_230) then __O[1655] else ____opt_result_236 else __L1.room) then
            x = __L1.room.teacherX
            y = __L1.FLOOR - 76
            local ____t_243 = __t
            local ____opt_240 = window.FavelaCasas
            if ____opt_240 ~= nil then
                ____opt_240 = ____opt_240.morador
            end
            local ____opt_result_242
            if ____opt_240 ~= nil then
                ____opt_result_242 = ____opt_240(____opt_240, __L1.room.id)
            end
            __O[1656] = ____opt_result_242
            ____type = if ____t_243(____opt_result_242) then __O[1656] else __L1.room.id
        elseif __t(not __t(__call(norm, "includes", "da roca")) and not __t(__call(norm, "includes", "diario"))) then
            local npc = __call(
                __entries(__L1.npcInfo),
                "find",
                function(____, ____bindingPattern0)
                    local n
                    local id
                    id = ____bindingPattern0[1]
                    n = ____bindingPattern0[2]
                    local ____t_245 = __t
                    local ____temp_244 = n.scene == __L1.scene
                    __O[1658] = ____temp_244
                    local ____t_247 = __t
                    local ____call_result_246 = __call(norm, "includes", id)
                    __O[1657] = ____call_result_246
                    return if ____t_245(____temp_244) then if ____t_247(____call_result_246) then __O[1657] else __call(
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
                    ) else __O[1658]
                end
            )
            local enemy = __call(
                __L1.enemies,
                "find",
                function(____, e) return __call(norm, "includes", if e.type == "reeisBoss" then "reeis" else if e.type == "giant" then "rabiscao" else e.type) end
            )
            if __t(enemy) then
                x = enemy.x
                y = enemy.y - if enemy.type == "giant" then 190 else if enemy.type == "reeisBoss" then 115 else 76
                ____type = enemy.type
            elseif __t(npc) then
                x = __get(npc, 1).x
                y = __L1.FLOOR - 76
                ____type = __get(npc, 0)
            end
        end
        return {
            x = __L1:clamp(x - if __t(__L1.room) then 0 else __L1.camera, 35, __L1.W - 35),
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
        local progress = if __t(attacking) then 1 - __L1.player.attack / __L1.player.attackDuration else 0
        local ____L1_player_facing_260 = __L1.player.facing
        local ____temp_261 = if math.abs(__L1.player.vx) > 8 then __L1.player.anim / 9 else __L1.time
        local ____temp_262 = __L1.hitFlash > 0
        local ____scale_263 = scale
        local ____temp_264 = not __t(__L1.vehicle) and math.abs(__L1.player.vx) > 8
        local ____math_abs_result_265 = math.abs(__L1.player.vx)
        local ____L1_player_ground_266 = __L1.player.ground
        local ____L1_player_vy_267 = __L1.player.vy
        local ____L1_player_attackType_268 = __L1.player.attackType
        local ____temp_269 = if __t(__L1.q.miqueias) then "papaia" else if __L1.weapon == 2 then "case" else if __L1.weapon == 1 then "ruler" else "paper"
        local ____temp_270 = if __t(__L1.q.miqueias) then if __ge(
            __L1:bonus().projectileTier,
            2
        ) then "electric" else "fire" else nil
        local ____t_259 = __t
        local ____t_255 = __t
        local ____t_253 = __t
        local ____opt_250 = __L1.activeBoss
        if ____opt_250 ~= nil then
            ____opt_250 = ____opt_250.conquista
        end
        local ____opt_result_252
        if ____opt_250 ~= nil then
            ____opt_result_252 = ____opt_250.estrada
        end
        local ____temp_254 = not ____t_253(____opt_result_252) and not __t(__L1.player.ground)
        __O[1660] = ____temp_254
        local ____t_257 = __t
        local ____temp_256 = __L1:keyHeld("jump")
        __O[1659] = ____temp_256
        local ____temp_258 = if ____t_255(____temp_254) then if ____t_257(____temp_256) then __O[1659] else __L1.touch.jump else __O[1660]
        __O[1661] = ____temp_258
        return {
            facing = ____L1_player_facing_260,
            frame = ____temp_261,
            attack = attacking,
            hit = ____temp_262,
            scale = ____scale_263,
            moving = ____temp_264,
            speed = ____math_abs_result_265,
            grounded = ____L1_player_ground_266,
            vy = ____L1_player_vy_267,
            attackProgress = progress,
            attackType = ____L1_player_attackType_268,
            attackObject = ____temp_269,
            attackElement = ____temp_270,
            flight = if __t(__L1.vehicle) then __L1.vehicle else if ____t_259(____temp_258) then __gt(__L1.player.gas, 0) else __O[1661],
            recoil = if __t(if __t(attacking) then __L1.player.attackType == "paper" else attacking) then math.max(0, 1 - progress * 3) else 0,
            muscular = __L1.q.trained,
            dash = __L1.dashTimer > 0,
            land = __L1.player.landTimer / 0.15,
            landTimer = __L1.player.landTimer
        }
    end
    __L1.terrenoConquista = function(self, f)
        if f == nil then
            local ____opt_273 = __L1.activeBoss
            if ____opt_273 ~= nil then
                ____opt_273 = ____opt_273.conquista
            end
            f = ____opt_273
        end
        local ____opt_271 = window.ConquistaCombate
        if ____opt_271 ~= nil then
            ____opt_271 = ____opt_271:terreno(f)
        end
        return ____opt_271
    end
    __L1.scenePlatforms = function(self)
        local ____opt_275 = __L1.activeBoss
        if ____opt_275 ~= nil then
            ____opt_275 = ____opt_275.conquista
        end
        local f = ____opt_275
        local ____opt_result_279
        if f ~= nil then
            ____opt_result_279 = f.ceu
        end
        local ceu = ____opt_result_279
        local ____t_283 = __t
        local ____opt_result_282
        if f ~= nil then
            ____opt_result_282 = f.estrada
        end
        if ____t_283(____opt_result_282) then
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
        local ____call_289 = __call
        local ____t_288 = __t
        local ____getq_286 = __getq
        local ____opt_284 = window.WorldData
        if ____opt_284 ~= nil then
            ____opt_284 = ____opt_284.arenaPlatforms
        end
        local ____getq_286_result_287 = ____getq_286(____opt_284, __L1.arena.type)
        __O[1665] = ____getq_286_result_287
        local ____call_306 = __call
        local ____t_298 = __t
        local ____t_291 = __t
        local ____get_result_290 = __get(__L1.platforms, __L1.scene)
        __O[1666] = ____get_result_290
        local ____opt_294 = window.LugaresC1
        if ____opt_294 ~= nil then
            ____opt_294 = ____opt_294.plataformas
        end
        local ____opt_result_296
        if ____opt_294 ~= nil then
            ____opt_result_296 = ____opt_294(____opt_294, __L1.scene)
        end
        local ____temp_297 = if ____t_291(____get_result_290) then __O[1666] else ____opt_result_296
        __O[1667] = ____temp_297
        local ____temp_305 = if ____t_298(____temp_297) then __O[1667] else __arrL({}, 0)
        local ____t_304 = __t
        local ____opt_301 = window.Interact
        if ____opt_301 ~= nil then
            ____opt_301 = ____opt_301.platforms
        end
        local ____opt_result_303
        if ____opt_301 ~= nil then
            ____opt_result_303 = ____opt_301(____opt_301, {scene = __L1.scene})
        end
        __O[1668] = ____opt_result_303
        return if __t(__L1.room) then __arrL({}, 0) else if __t(__L1.arena) then ____call_289(
            if ____t_288(____getq_286_result_287) then __O[1665] else __arrL({}, 0),
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
        ) else ____call_306(____temp_305, "concat", if ____t_304(____opt_result_303) then __O[1668] else __arrL({}, 0))
    end
    __L1.gapAt = function(self)
        return nil
    end
    __L1.heroFloor = function(self)
        local best = nil
        for ____, p in __iterar((__L1:scenePlatforms())) do
            local ____t_311 = __t
            local ____t_310 = __t
            local ____t_308 = __t
            local ____temp_307 = __ge(
                __L1.player.x,
                __get(p, 0) - 4
            ) and __le(
                __L1.player.x,
                __add(
                    __get(p, 0),
                    __get(p, 2)
                ) + 4
            )
            __O[1669] = ____temp_307
            local ____temp_309 = if ____t_308(____temp_307) then __ge(
                __get(p, 1),
                __L1.player.y - 2
            ) else __O[1669]
            __O[1670] = ____temp_309
            if ____t_311(if ____t_310(____temp_309) then best == nil or __lt(
                __get(p, 1),
                best
            ) else __O[1670]) then
                best = __get(p, 1)
            end
        end
        return if best == nil then __L1.FLOOR else math.min(best, __L1.FLOOR)
    end
    __L1.resetWorldSize = function(self)
        __L1.WORLD = __L1:worldWidthFor(__L1.scene)
    end
    __L1.startCutscene = function(self, kind, done)
        local ____t_314 = __t
        local ____opt_312 = window.Cinematics
        if ____opt_312 ~= nil then
            ____opt_312 = ____opt_312.create
        end
        if not ____t_314(____opt_312) then
            if __t(done) then
                done(nil)
            end
            return false
        end
        local R = window.Roteiro
        local ____opt_result_319
        if R ~= nil then
            ____opt_result_319 = R.antes
        end
        local ____opt_result_320
        if ____opt_result_319 ~= nil then
            ____opt_result_320 = ____opt_result_319(R, kind, __L1.q)
        end
        local pre = ____opt_result_320
        local ____opt_result_325
        if R ~= nil then
            ____opt_result_325 = R.depois
        end
        local ____opt_result_326
        if ____opt_result_325 ~= nil then
            ____opt_result_326 = ____opt_result_325(R, kind, __L1.q)
        end
        local post = ____opt_result_326
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
        local ____t_329 = __t
        local ____opt_327 = window.Cinematics
        if ____opt_327 ~= nil then
            ____opt_327 = ____opt_327.create
        end
        if not ____t_329(____opt_327) then
            if __t(done) then
                done(nil)
            end
            return false
        end
        local ____opt_332 = window.CampaignVfx
        if ____opt_332 ~= nil then
            ____opt_332 = ____opt_332.reset
        end
        if ____opt_332 ~= nil then
            ____opt_332(____opt_332)
        end
        __L1:releaseInputs()
        local ____self_342 = window.Cinematics
        local ____self_342_create_343 = ____self_342.create
        local ____kind_341 = kind
        local ____L1_q_trained_340 = __L1.q.trained
        local ____t_339 = __t
        local ____opt_336 = window.GameMusic
        if ____opt_336 ~= nil then
            ____opt_336 = ____opt_336.isCutsceneTimed
        end
        local ____opt_result_338
        if ____opt_336 ~= nil then
            ____opt_result_338 = ____opt_336(____opt_336, kind)
        end
        __L1.cutscene = ____self_342_create_343(
            ____self_342,
            ____kind_341,
            {
                trained = ____L1_q_trained_340,
                musicTimed = not not ____t_339(____opt_result_338)
            }
        )
        local ____L1_cutscene_347 = __L1.cutscene
        local ____L1_344, ____audioCutsceneSerial_345 = __L1, "audioCutsceneSerial"
        local ____L1_audioCutsceneSerial_346 = ____L1_344[____audioCutsceneSerial_345] + 1
        ____L1_344[____audioCutsceneSerial_345] = ____L1_audioCutsceneSerial_346
        ____L1_cutscene_347.audioToken = ____L1_audioCutsceneSerial_346
        __L1.cutscene.audioElapsed = 0
        __L1.cutsceneCallback = if __t(done) then done else nil
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
        if __t(if __t(__L1.ollyanEncounter) then not __t(__L1.paused) else __L1.ollyanEncounter) then
            local ____t_353 = __t
            local ____opt_350 = window.OllyanEncounter
            if ____opt_350 ~= nil then
                ____opt_350 = ____opt_350.advance
            end
            local ____opt_result_352
            if ____opt_350 ~= nil then
                ____opt_result_352 = ____opt_350(____opt_350, __L1.ollyanEncounter)
            end
            __O[1671] = ____opt_result_352
            local changed = if ____t_353(____opt_result_352) then __O[1671] else false
            __L1:consumeOllyanEvents()
            __L1:updateUI()
            return changed
        end
        local ____t_356 = __t
        local ____t_355 = __t
        local ____temp_354 = not __t(__L1.cutscene)
        __O[1672] = ____temp_354
        if ____t_356(if ____t_355(____temp_354) then __O[1672] else __L1.paused) then
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
        local ____t_359 = __t
        local ____opt_357 = __L1.ollyanEncounter
        if ____opt_357 ~= nil then
            ____opt_357 = ____opt_357.stage
        end
        if ____t_359(____opt_357 == "intro" and not __t(__L1.paused)) then
            do
                local i = 0
                while true do
                    local ____t_363 = __t
                    local ____temp_362 = i < 3
                    if ____temp_362 then
                        local ____opt_360 = __L1.ollyanEncounter
                        if ____opt_360 ~= nil then
                            ____opt_360 = ____opt_360.stage
                        end
                        ____temp_362 = ____opt_360 == "intro"
                    end
                    if not ____t_363(____temp_362) then
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
        local ____t_366 = __t
        local ____t_365 = __t
        local ____temp_364 = not __t(__L1.cutscene)
        __O[1673] = ____temp_364
        if ____t_366(if ____t_365(____temp_364) then __O[1673] else __L1.paused) then
            return false
        end
        __L1.cutscene.done = true
        __L1:finishCutscene()
        return true
    end
    __L1.replayIntro = function(self)
        local ____t_387 = __t
        local ____t_386 = __t
        local ____t_384 = __t
        local ____t_380 = __t
        local ____t_378 = __t
        local ____t_376 = __t
        local ____t_374 = __t
        local ____t_372 = __t
        local ____t_370 = __t
        local ____t_368 = __t
        local ____temp_367 = not __t(__L1.started)
        __O[1674] = ____temp_367
        local ____temp_369 = if ____t_368(____temp_367) then __O[1674] else __L1.defeated
        __O[1675] = ____temp_369
        local ____temp_371 = if ____t_370(____temp_369) then __O[1675] else __L1.activeBoss
        __O[1676] = ____temp_371
        local ____temp_373 = if ____t_372(____temp_371) then __O[1676] else __L1.arena
        __O[1677] = ____temp_373
        local ____temp_375 = if ____t_374(____temp_373) then __O[1677] else __L1.room
        __O[1678] = ____temp_375
        local ____temp_377 = if ____t_376(____temp_375) then __O[1678] else __L1.routeTransition
        __O[1679] = ____temp_377
        local ____temp_379 = if ____t_378(____temp_377) then __O[1679] else __L1.dialog
        __O[1680] = ____temp_379
        local ____opt_381 = __L1.training
        if ____opt_381 ~= nil then
            ____opt_381 = ____opt_381.active
        end
        local ____temp_383 = if ____t_380(____temp_379) then __O[1680] else ____opt_381
        __O[1681] = ____temp_383
        local ____temp_385 = if ____t_384(____temp_383) then __O[1681] else __L1.cutscene
        __O[1682] = ____temp_385
        if ____t_387(if ____t_386(____temp_385) then __O[1682] else __L1.ollyanEncounter) then
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
        local ____t_404 = __t
        local ____t_403 = __t
        local ____t_401 = __t
        local ____t_399 = __t
        local ____t_397 = __t
        local ____t_395 = __t
        local ____t_393 = __t
        local ____t_391 = __t
        local ____t_389 = __t
        local ____temp_388 = not __t(__L1.started)
        __O[1683] = ____temp_388
        local ____temp_390 = if ____t_389(____temp_388) then __O[1683] else __L1.paused
        __O[1684] = ____temp_390
        local ____temp_392 = if ____t_391(____temp_390) then __O[1684] else __L1.cutscene
        __O[1685] = ____temp_392
        local ____temp_394 = if ____t_393(____temp_392) then __O[1685] else __L1.room
        __O[1686] = ____temp_394
        local ____temp_396 = if ____t_395(____temp_394) then __O[1686] else __L1.arena
        __O[1687] = ____temp_396
        local ____temp_398 = if ____t_397(____temp_396) then __O[1687] else __L1.activeBoss
        __O[1688] = ____temp_398
        local ____temp_400 = if ____t_399(____temp_398) then __O[1688] else __L1.routeTransition
        __O[1689] = ____temp_400
        local ____temp_402 = if ____t_401(____temp_400) then __O[1689] else __L1.dialog
        __O[1690] = ____temp_402
        if ____t_404(if ____t_403(____temp_402) then __O[1690] else __L1.defeated) then
            return false
        end
        local ____call_408 = __call
        local ____t_407 = __t
        local ____opt_405 = window.WorldData
        if ____opt_405 ~= nil then
            ____opt_405 = ____opt_405.doors
        end
        __O[1691] = ____opt_405
        local door = ____call_408(
            if ____t_407(____opt_405) then __O[1691] else __arrL({}, 0),
            "find",
            function(____, d) return d.id == id and d.scene == __L1.scene end
        )
        local ____t_411 = __t
        local ____t_410 = __t
        local ____temp_409 = not __t(door) or math.abs(__L1.player.x - door.x) > 110
        __O[1692] = ____temp_409
        if ____t_411(if ____t_410(____temp_409) then __O[1692] else math.abs(__L1.player.y - __L1.FLOOR) > 50) then
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
        __L1.room = {
            id = id,
            phase = "entering",
            blend = 0,
            t = 0,
            returnX = __L1.player.x,
            returnY = __L1.FLOOR,
            exteriorCamera = __L1.camera,
            teacherX = if __t(door.teacherX) then door.teacherX else 600,
            exitX = if __t(door.exitX) then door.exitX else 90
        }
        __L1:updateUI()
        __L1:beep(330, 0.12, "triangle")
        return true
    end
    __L1.exitRoom = function(self)
        local ____t_418 = __t
        local ____t_417 = __t
        local ____t_415 = __t
        local ____t_413 = __t
        local ____temp_412 = not __t(__L1.room) or __L1.room.phase ~= "inside"
        __O[1693] = ____temp_412
        local ____temp_414 = if ____t_413(____temp_412) then __O[1693] else __L1.dialog
        __O[1694] = ____temp_414
        local ____temp_416 = if ____t_415(____temp_414) then __O[1694] else __L1.paused
        __O[1695] = ____temp_416
        if ____t_418(if ____t_417(____temp_416) then __O[1695] else __L1.cutscene) then
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
        __L1.room.blend = if __L1.room.phase == "entering" then __L1:clamp(__L1.room.t / 0.65, 0, 1) else 1 - __L1:clamp(__L1.room.t / 0.65, 0, 1)
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
        local safeX = if __isFiniteN(__L1.lastSafeX) then __L1.lastSafeX else 230
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
        local ____L1_player_421 = __L1.player
        local ____t_420 = __t
        local ____TS__Number_result_419 = __TS__Number(__L1.player.inv)
        __O[1696] = ____TS__Number_result_419
        ____L1_player_421.inv = math.max(if ____t_420(____TS__Number_result_419) then __O[1696] else 0, 1)
        __L1.camera = if __t(__L1.room) then 0 else if __t(__L1.arena) then __L1.arena.homeX - __L1.W / 2 else __L1:clamp(__L1.player.x - __L1.W * 0.36, 0, __L1.WORLD - __L1.W)
        __L1.lastSafeX = __L1.player.x
        __L1:updateUI()
    end
    __L1.makeArena = function(self, e)
        local ____opt_424 = window.CampaignVfx
        if ____opt_424 ~= nil then
            ____opt_424 = ____opt_424.reset
        end
        if ____opt_424 ~= nil then
            ____opt_424(____opt_424)
        end
        local ____t_430 = __t
        local ____getq_428 = __getq
        local ____opt_426 = window.WorldData
        if ____opt_426 ~= nil then
            ____opt_426 = ____opt_426.arenaBounds
        end
        local ____getq_428_result_429 = ____getq_428(____opt_426, e.type)
        __O[1697] = ____getq_428_result_429
        local bounds = if ____t_430(____getq_428_result_429) then __O[1697] else __arrL({-430, 430}, 2)
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
        __L1.arena.returnX = if __t(won) then math.min(__L1.WORLD - 80, __L1.arena.homeX + if __t(__call(
            __arrL({"freddy", "nicolas", "dede", "arthur"}, 4),
            "includes",
            __L1.arena.type
        )) then 90 else 460) else math.max(180, __L1.arena.homeX - 480)
        if __t(if __t(__L1.activeBoss) then not __t(won) else __L1.activeBoss) then
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
        local ____t_433 = __t
        local ____opt_431 = window.C2Luta
        if ____opt_431 ~= nil then
            ____opt_431 = ____opt_431.skin
        end
        if ____t_433(if __t(__L1.sandbox) then ____opt_431 else __L1.sandbox) then
            __L1:emitGameEvent("sandbox-change", {type = __L1.sandbox.type, result = "retreat"})
            return true
        end
        if __t(__L1.sandbox) then
            return __L1:exitSandbox()
        end
        local ____t_438 = __t
        local ____t_437 = __t
        local ____t_435 = __t
        local ____temp_434 = not __t(__L1.arena) or __L1.arena.phase ~= "active"
        __O[1698] = ____temp_434
        local ____temp_436 = if ____t_435(____temp_434) then __O[1698] else __L1.dialog
        __O[1699] = ____temp_436
        if ____t_438(if ____t_437(____temp_436) then __O[1699] else __L1.paused) then
            return false
        end
        __L1:leaveArena(false)
        __L1:toast("Você recuou da arena. O chefe voltou à força total.")
        return true
    end
    __L1.updateArenaTransition = function(self, dt)
        __L1.arena.t = __add(__L1.arena.t, dt)
        __L1.arena.blend = if __L1.arena.phase == "entering" then __L1:clamp(__L1.arena.t / 0.6, 0, 1) else 1 - __L1:clamp(__L1.arena.t / 0.6, 0, 1)
        __L1.camera = __L1.arena.exteriorCamera + (__L1.arena.homeX - __L1.W / 2 - __L1.arena.exteriorCamera) * __L1.arena.blend
        if __ge(__L1.arena.t, 0.6) then
            if __L1.arena.phase == "entering" then
                __L1.arena.phase = "active"
                __L1.arena.blend = 1
                __L1.camera = __L1.arena.homeX - __L1.W / 2
                if __t(__L1.activeBoss) then
                    local e = __L1.activeBoss
                    local key = if e.type == "reeisBoss" then "boss_reeis" else __add("boss_", e.type)
                    if __t(e.type == "igor" or e.type == "kaique") then
                        e.state = "monitorTransform"
                        e.stateTimer = 1.25
                        e.monitorTransform = 0
                        __L1.player.inv = math.max(__L1.player.inv, 1.5)
                        __L1:floating(e.x, e.y - 150, if e.type == "igor" then "SEM LANCHE? BARRIGA GIGANTE!" else if __t(e.rage) then "NÃO PISA NO NOME DA IRACI!" else "ENTREGA ESSAS BOLINHAS!", "#ffd49c")
                        __L1.shake = 7
                        __L1:fx(
                            e.x,
                            e.y - 45,
                            if __t(e.rage) then "#e66f73" else "#e8c386",
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
        if __t(if __t(m.dead) then m.dead else __gt(m.hit, 0)) then
            return
        end
        m.hp = m.hp - n
        m.hit = 0.14
        local ____opt_441 = window.SceneLife
        if ____opt_441 ~= nil then
            ____opt_441 = ____opt_441.impact
        end
        if ____opt_441 ~= nil then
            ____opt_441(
                ____opt_441,
                m.x,
                m.y - 22,
                if element == "electric" then "#a9e7f4" else if element == "fire" then "#f4ad60" else "#e9c27a",
                n,
                __TS__Number(-__L1.player.facing)
            )
        end
        local ____opt_445 = window.CampaignVfx
        if ____opt_445 ~= nil then
            ____opt_445 = ____opt_445.emit
        end
        if ____opt_445 ~= nil then
            ____opt_445(____opt_445, "hit", {
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
            if element == "electric" then "#a9e7f4" else if element == "fire" then "#f4ad60" else "#d2afd9",
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
                    local ____t_448 = __t
                    local ____temp_447 = not __t(a.dead) and a ~= m
                    __O[1700] = ____temp_447
                    return if ____t_448(____temp_447) then math.abs(a.x - m.x) < 150 else __O[1700]
                end
            )
            for ____, a in __iterar((others)) do
                a.hp = a.hp - math.max(3, n * 0.35)
                local ____opt_451 = window.CampaignVfx
                if ____opt_451 ~= nil then
                    ____opt_451 = ____opt_451.emit
                end
                if ____opt_451 ~= nil then
                    ____opt_451(____opt_451, "hit", {
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
                local ____L1_awardXP_454 = __L1.awardXP
                local ____m_xp_453 = m.xp
                if ____m_xp_453 == nil then
                    ____m_xp_453 = 25 + if __t(m.tier) then m.tier else 1 * 10
                end
                ____L1_awardXP_454(
                    __L1,
                    ____m_xp_453,
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
            if __t(m.temporary) then
                m.life = m.life - dt
                if __le(m.life, 0) then
                    m.dead = true
                    continue
                end
            end
            if __t(if __t(m.dead) then m.dead else if __t(__L1.arena) then not __t(m.summoned) else __L1.arena) then
                continue
            end
            m.hit = math.max(0, m.hit - dt)
            if __gt(m.burn, 0) then
                m.burn = m.burn - dt
                m.burnTick = __add(if __t(m.burnTick) then m.burnTick else 0, dt)
                if __gt(m.burnTick, 0.6) then
                    m.burnTick = 0
                    __L1:damageMinion(m, 4)
                end
            end
            if __t(if __t(m.dead) then m.dead else math.abs(m.x - __L1.player.x) > 650) then
                continue
            end
            local ____m_tauntTimer_455 = m.tauntTimer
            if ____m_tauntTimer_455 == nil then
                ____m_tauntTimer_455 = 1.2
            end
            m.tauntTimer = ____m_tauntTimer_455 - dt
            if __t(__le(m.tauntTimer, 0) and math.abs(m.x - __L1.player.x) < 410) then
                m.tauntTimer = 5 + if __t(m.tier) then m.tier else 1 * 0.3
                __L1:floating(m.x, m.y - 65, if __t(m.provocation) then m.provocation else if m.type == "rat" then "O REI DOS RATOS MANDOU!" else if m.design == "sixseven" then "SIX SEVEN!" else "DA ROÇA PEGOU AR!", if m.type == "thug" then "#edce9a" else "#e1b6ee")
            end
            m.t = m.t - dt
            local thug = m.type == "thug" or m.kind == "thug"
            if m.type == "rat" then
                local ____t_457 = __t
                local ____TS__MathSign_result_456 = __TS__MathSign(__L1.player.x - m.x)
                __O[1701] = ____TS__MathSign_result_456
                m.dir = if ____t_457(____TS__MathSign_result_456) then __O[1701] else m.dir
                local ____t_460 = __t
                local ____opt_458 = __L1.arena
                if ____opt_458 ~= nil then
                    ____opt_458 = ____opt_458.bounds
                end
                __O[1702] = ____opt_458
                local bounds = if ____t_460(____opt_458) then __O[1702] else __arrL({25, __L1.WORLD - 25}, 2)
                m.x = __L1:clamp(
                    m.x + m.dir * if __t(m.speed) then m.speed else 115 * dt,
                    __get(bounds, 0) + 20,
                    __get(bounds, 1) - 20
                )
                m.y = __L1.FLOOR
            elseif __t(if __t(thug) then thug else m.kind == 2) then
                local tier = if __t(m.tier) then m.tier else 1
                if __lt(m.t, 0.4) then
                    m.charging = true
                end
                if __le(m.t, 0) then
                    m.charging = false
                    m.t = if __t(thug) then math.max(1.25, 2.8 - tier * 0.3) else 2.3
                    local a = math.atan2(__L1.player.y - 30 - (m.y - 30), __L1.player.x - m.x)
                    local count = if __t(thug) then if m.weapon == "scatter" then 3 else if m.weapon == "carbine" then 2 else 1 else 1
                    do
                        local i = 0
                        while i < count do
                            local spread = (i - (count - 1) / 2) * 0.15
                            __call(
                                __L1.shots,
                                "push",
                                {
                                    x = m.x,
                                    y = m.y - 30,
                                    vx = math.cos(a + spread) * (185 + tier * 16) * if __t(m.projectileSpeed) then m.projectileSpeed else 1,
                                    vy = math.sin(a + spread) * (185 + tier * 16) * if __t(m.projectileSpeed) then m.projectileSpeed else 1,
                                    life = 4,
                                    type = if __t(thug) then "enemyBullet" else "doodle",
                                    owner = "enemy",
                                    damage = if __t(m.damage) then m.damage else 8,
                                    variant = 1
                                }
                            )
                            i = i + 1
                        end
                    end
                    __L1:beep(145, 0.035, "square", 0.008)
                end
            else
                m.x = m.x + m.dir * if __t(m.speed) then m.speed else if m.kind == 1 then 75 else 58 * dt
                if __gt(
                    math.abs(m.x - m.homeX),
                    m.range
                ) then
                    m.dir = m.dir * -1
                end
                local ____t_463 = __t
                local ____t_462 = __t
                local ____temp_461 = m.kind == 1 and __le(m.t, 0)
                __O[1703] = ____temp_461
                if ____t_463(if ____t_462(____temp_461) then __ge(m.y, __L1.FLOOR) else __O[1703]) then
                    m.vy = -240
                    m.t = 1.5
                end
                m.vy = m.vy + 760 * dt
                m.y = math.min(__L1.FLOOR, m.y + m.vy * dt)
                if m.y == __L1.FLOOR then
                    m.vy = 0
                end
            end
            if __t(if __t(window.Golpes) then window.Golpes:cruza(
                window.Golpes:capanga(m),
                window.Golpes:heroi(__L1.player)
            ) else math.abs(m.x - __L1.player.x) < if m.type == "rat" then 24 else 30 and math.abs(m.y - __L1.player.y) < if m.type == "rat" then 42 else 52) then
                if __L1.dashTimer > 0 then
                    __L1:damageMinion(
                        m,
                        math.floor(30 * __L1:bonus().damageMultiplier + 0.5)
                    )
                else
                    __L1:hurt(if __t(m.damage) then m.damage else 8, m.x)
                end
            end
        end
        __L1.minions = __call(
            __L1.minions,
            "filter",
            function(____, m)
                local ____t_465 = __t
                local ____temp_464 = not __t(m.temporary)
                __O[1704] = ____temp_464
                return if ____t_465(____temp_464) then __O[1704] else not __t(m.dead) and __gt(m.life, 0)
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
        local ____opt_466 = __L1.activeBoss
        if ____opt_466 ~= nil then
            ____opt_466 = ____opt_466.conquista
        end
        local duelo = ____opt_466
        local terreno = __L1:terrenoConquista(duelo)
        if __t(terreno) then
            terreno:avancar(duelo, dt, __L1.player)
        end
        local ____t_469 = __t
        local ____temp_468 = __L1:keyHeld("left")
        __O[1705] = ____temp_468
        local left = if ____t_469(____temp_468) then __O[1705] else __L1.touch.left
        local ____t_471 = __t
        local ____temp_470 = __L1:keyHeld("right")
        __O[1706] = ____temp_470
        local right = if ____t_471(____temp_470) then __O[1706] else __L1.touch.right
        local ____t_473 = __t
        local ____temp_472 = __L1:keyHeld("up")
        __O[1707] = ____temp_472
        local up = if ____t_473(____temp_472) then __O[1707] else __L1.touch.up
        local ____t_475 = __t
        local ____temp_474 = __L1:keyHeld("down")
        __O[1708] = ____temp_474
        local down = if ____t_475(____temp_474) then __O[1708] else __L1.touch.down
        local ____t_477 = __t
        local ____temp_476 = __L1:keyHeld("jump")
        __O[1709] = ____temp_476
        local jump = if ____t_477(____temp_476) then __O[1709] else __L1.touch.jump
        local ____t_483 = __t
        local ____opt_480 = window.ControlSettings
        if ____opt_480 ~= nil then
            ____opt_480 = ____opt_480.getSensitivity
        end
        local ____opt_result_482
        if ____opt_480 ~= nil then
            ____opt_result_482 = ____opt_480(____opt_480)
        end
        __O[1710] = ____opt_result_482
        local sensitivity = if ____t_483(____opt_result_482) then __O[1710] else 1
        local ____t_485 = __t
        local ____temp_484 = if __t(right) then 1 else 0 - if __t(left) then 1 else 0
        __O[1711] = ____temp_484
        local dir = if ____t_485(____temp_484) then __O[1711] else __L1.joystick.x
        local targetVX = dir * if __t(__L1.vehicle) then 420 else __L1:bonus().moveSpeed
        local accel = if __t(dir) then if __t(__L1.vehicle) then 1600 else if __t(__L1.player.ground) then 1800 else 1150 else if __t(__L1.player.ground) then 2200 else 950 * sensitivity
        if __L1.dashTimer > 0 then
            __L1.player.vx = __L1.dashDir * 600
            __call(__L1.afterimages, "push", {x = __L1.player.x, y = __L1.player.y, facing = __L1.player.facing, life = 0.2})
        else
            local ____L1_player_486, ____vx_487 = __L1.player, "vx"
            ____L1_player_486[____vx_487] = ____L1_player_486[____vx_487] + __L1:clamp(targetVX - __L1.player.vx, -accel * dt, accel * dt)
        end
        if math.abs(__L1.player.vx) < 0.1 then
            __L1.player.vx = 0
        end
        if __t(if __t(dir) then __L1.dashTimer <= 0 else dir) then
            __L1.player.facing = __TS__MathSign(dir)
        end
        local ____L1_player_488, ____anim_489 = __L1.player, "anim"
        ____L1_player_488[____anim_489] = ____L1_player_488[____anim_489] + math.abs(__L1.player.vx) * dt / 18.3
        if __t(if __t(__L1.vehicle) then __gt(__L1.player.gas, 0) else __L1.vehicle) then
            __L1.player.vy = if __t(if __t(jump) then jump else up) then -190 else if __t(down) then 180 else if __t(__L1.joystick.y) then __L1.joystick.y * 190 else math.sin(__L1.time * 2) * 7
            local ____L1_player_495 = __L1.player
            local ____L1_player_gas_494 = __L1.player.gas
            local ____dt_493 = dt
            local ____t_492 = __t
            local ____t_491 = __t
            local ____temp_490 = if __t(dir) then dir else jump
            __O[1712] = ____temp_490
            ____L1_player_495.gas = math.max(0, ____L1_player_gas_494 - ____dt_493 * if ____t_492(if ____t_491(____temp_490) then __O[1712] else up) then 8 else 3)
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
            local ____t_498 = __t
            local ____t_497 = __t
            local ____temp_496 = if __t(jump) then not __t(__L1.prevJump) else jump
            __O[1713] = ____temp_496
            if ____t_498(if ____t_497(____temp_496) then __L1.player.ground else __O[1713]) then
                local ____L1_player_503 = __L1.player
                local ____t_502 = __t
                local ____opt_result_501
                if duelo ~= nil then
                    ____opt_result_501 = duelo.estrada
                end
                ____L1_player_503.vy = if ____t_502(____opt_result_501) then -405 else -365
                __L1.player.ground = false
                __L1:beep(320, 0.06, "triangle")
            end
            local ____t_512 = __t
            local ____t_511 = __t
            local ____t_509 = __t
            local ____t_507 = __t
            local ____opt_result_506
            if duelo ~= nil then
                ____opt_result_506 = duelo.estrada
            end
            local ____temp_508 = if __t(jump) then not ____t_507(____opt_result_506) else jump
            __O[1714] = ____temp_508
            local ____temp_510 = if ____t_509(____temp_508) then not __t(__L1.player.ground) else __O[1714]
            __O[1715] = ____temp_510
            if ____t_512(if ____t_511(____temp_510) then __gt(__L1.player.gas, 0) else __O[1715]) then
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
            local ____L1_player_513, ____vy_514 = __L1.player, "vy"
            ____L1_player_513[____vy_514] = ____L1_player_513[____vy_514] + 850 * dt
        end
        __L1.prevJump = not not __t(jump)
        local oldY = __L1.player.y
        local wasGrounded = __L1.player.ground
        local ____t_517 = __t
        local ____opt_515 = __L1.arena
        if ____opt_515 ~= nil then
            ____opt_515 = ____opt_515.bounds
        end
        __O[1716] = ____opt_515
        local bounds = if ____t_517(____opt_515) then __O[1716] else __arrL({25, __L1.WORLD - 25}, 2)
        __L1.player.x = __L1:clamp(
            __L1.player.x + __L1.player.vx * dt,
            __get(bounds, 0),
            __get(bounds, 1)
        )
        local ____L1_player_518, ____y_519 = __L1.player, "y"
        ____L1_player_518[____y_519] = ____L1_player_518[____y_519] + __L1.player.vy * dt
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
        local ____t_522 = __t
        local ____t_521 = __t
        local ____temp_520 = not __t(terreno) and not __t(__L1.vehicle)
        __O[1717] = ____temp_520
        if ____t_522(if ____t_521(____temp_520) then __ge(__L1.player.vy, 0) else __O[1717]) then
            for ____, p in __iterar((__L1:scenePlatforms())) do
                local ____t_527 = __t
                local ____t_526 = __t
                local ____t_524 = __t
                local ____temp_523 = __gt(
                    __L1.player.x,
                    __get(p, 0) - 8
                ) and __lt(
                    __L1.player.x,
                    __add(
                        __get(p, 0),
                        __get(p, 2)
                    ) + 8
                )
                __O[1718] = ____temp_523
                local ____temp_525 = if ____t_524(____temp_523) then __le(
                    oldY,
                    __get(p, 1) + 3
                ) else __O[1718]
                __O[1719] = ____temp_525
                if ____t_527(if ____t_526(____temp_525) then __ge(
                    __L1.player.y,
                    __get(p, 1)
                ) else __O[1719]) then
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
        local ____t_530 = __t
        local ____t_529 = __t
        local ____temp_528 = not __t(wasGrounded)
        __O[1720] = ____temp_528
        if ____t_530(if ____t_529(____temp_528) then __L1.player.ground else __O[1720]) then
            __L1.player.landTimer = 0.15
        end
        if __t(not __t(__L1.vehicle) and not __t(jump)) then
            local ____L1_player_538 = __L1.player
            local ____table_maxGas_537 = __L1:bonus().maxGas
            local ____L1_player_gas_536 = __L1.player.gas
            local ____dt_535 = dt
            local ____t_532 = __t
            local ____table_gasRegen_531 = __L1:bonus().gasRegen
            __O[1721] = ____table_gasRegen_531
            local ____t_534 = __t
            local ____table_airGasRegen_533 = __L1:bonus().airGasRegen
            __O[1722] = ____table_airGasRegen_533
            ____L1_player_538.gas = math.min(____table_maxGas_537, ____L1_player_gas_536 + ____dt_535 * if __t(__L1.player.ground) then if ____t_532(____table_gasRegen_531) then __O[1721] else 16 else if ____t_534(____table_airGasRegen_533) then __O[1722] else 6)
        end
        local ____t_545 = __t
        local ____t_544 = __t
        local ____t_542 = __t
        local ____t_540 = __t
        local ____temp_539 = not __t(__L1.room) and not __t(__L1.arena)
        __O[1723] = ____temp_539
        local ____temp_541 = if ____t_540(____temp_539) then __L1.player.ground else __O[1723]
        __O[1724] = ____temp_541
        local ____temp_543 = if ____t_542(____temp_541) then __L1.player.y == __L1.FLOOR else __O[1724]
        __O[1725] = ____temp_543
        if ____t_545(if ____t_544(____temp_543) then not __t(__L1:gapAt(__L1.player.x)) else __O[1725]) then
            __L1.lastSafeX = __L1.player.x
        end
        if __gt(__L1.player.y, __L1.H + 80) then
            __L1:recoverFall()
        end
        __L1.camera = if __t(__L1.room) then 0 else if __t(terreno) then (__add(duelo.l, duelo.r) - __L1.W) / 2 else if __t(__L1.arena) then __L1.arena.homeX - __L1.W / 2 else __L1:clamp(__L1.player.x - __L1.W * 0.36, 0, __L1.WORLD - __L1.W)
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
        if __t(if __t(e) then e.textContent ~= tostring(t) else e) then
            e.textContent = t
        end
    end
    __L1.show = function(self, id, yes)
        local e = __L1["$"](__L1, id)
        if __t(e) then
            e.hidden = not __t(yes)
            e.style.display = if __t(yes) then "" else "none"
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
        local ____opt_548 = window.DarocaAudio
        if ____opt_548 ~= nil then
            ____opt_548 = ____opt_548.sfx
        end
        local ____opt_result_550
        if ____opt_548 ~= nil then
            ____opt_result_550 = ____opt_548(____opt_548)
        end
        local ____opt_result_550_551 = ____opt_result_550
        if ____opt_result_550_551 == nil then
            ____opt_result_550_551 = 1
        end
        volume = volume * ____opt_result_550_551
        if volume <= 0.0005 then
            return
        end
        __L1:safe(function()
            __L1.audioCtx = if __t(__L1.audioCtx) then __L1.audioCtx else __newExpr(if __t(window.AudioContext) then window.AudioContext else window.webkitAudioContext)
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
        local ____t_554 = __t
        local ____t_553 = __t
        local ____temp_552 = not __t(__L1.started)
        __O[1726] = ____temp_552
        if ____t_554(if ____t_553(____temp_552) then __O[1726] else __L1.sandbox) then
            return
        end
        __L1:safe(function()
            local ____self_578 = window.localStorage
            local ____self_578_setItem_579 = ____self_578.setItem
            local ____L1_SAVE_577 = __L1.SAVE
            local ____self_575 = window.JSON
            local ____self_575_stringify_576 = ____self_575.stringify
            local ____L1_q_565 = __L1.q
            local ____L1_scene_566 = __L1.scene
            local ____L1_player_hp_567 = __L1.player.hp
            local ____L1_player_papers_568 = __L1.player.papers
            local ____L1_items_569 = __L1.items
            local ____L1_collected_570 = __L1.collected
            local ____L1_weapon_571 = __L1.weapon
            local ____L1_minionKills_572 = __L1.minionKills
            local ____L1_seenBossIntros_573 = __L1.seenBossIntros
            local ____temp_574 = {x = if __t(not __t(__L1.room) and not __t(__L1.arena)) then __L1.player.x else __L1.lastSafeX, scene = __L1.scene}
            local ____opt_557 = window.Progression
            if ____opt_557 ~= nil then
                ____opt_557 = ____opt_557.serialize
            end
            local ____opt_result_559
            if ____opt_557 ~= nil then
                ____opt_result_559 = ____opt_557(____opt_557)
            end
            local ____opt_562 = window.CampaignRun
            if ____opt_562 ~= nil then
                ____opt_562 = ____opt_562.serialize
            end
            local ____opt_result_564
            if ____opt_562 ~= nil then
                ____opt_result_564 = ____opt_562(____opt_562)
            end
            return ____self_578_setItem_579(
                ____self_578,
                ____L1_SAVE_577,
                ____self_575_stringify_576(____self_575, {
                    q = ____L1_q_565,
                    scene = ____L1_scene_566,
                    hp = ____L1_player_hp_567,
                    papers = ____L1_player_papers_568,
                    items = ____L1_items_569,
                    collected = ____L1_collected_570,
                    weapon = ____L1_weapon_571,
                    minionKills = ____L1_minionKills_572,
                    seenBossIntros = ____L1_seenBossIntros_573,
                    position = ____temp_574,
                    progression = ____opt_result_559,
                    run = ____opt_result_564,
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
            local ____t_582 = __t
            local ____t_581 = __t
            local ____temp_580 = if __t(a) then a.version == 1 else a
            __O[1727] = ____temp_580
            return if ____t_582(if ____t_581(____temp_580) then a.q else __O[1727]) then a else nil
        end)
    end
    __L1.getJaglionStatus = function(self)
        local quest = if __t(__L1.started) then __L1.q else __L1.menuLookQuest
        local ____t_586 = __t
        local ____opt_result_585
        if quest ~= nil then
            ____opt_result_585 = quest.amandaDating
        end
        if not ____t_586(____opt_result_585) then
            return "locked"
        end
        return if __t(quest.jaglionClaimed) then "ready" else "reserved"
    end
    __L1.updateContinue = function(self)
        local b = __L1["$"](__L1, "continueBtn")
        if __t(b) then
            local yes = not not __t(__L1:load())
            b.hidden = not __t(yes)
            b.style.display = if __t(yes) then "" else "none"
        end
    end
    __L1.mission = function(self)
        if __t(__L1.scene == 8 and __L1:getJaglionStatus() == "reserved") then
            return __arrL({"A entrega da Amanda", "O Jaglion está pronto. Fale com Davi na Bigodon e receba o traje para vestir no espelho."}, 2)
        end
        if __t(__L1.scene == 10 and not __t(__L1.q.bivoltUnlocked)) then
            local ____opt_589 = window.BivoltQuest
            if ____opt_589 ~= nil then
                ____opt_589 = ____opt_589.state
            end
            local ____opt_result_591
            if ____opt_589 ~= nil then
                ____opt_result_591 = ____opt_589(____opt_589, __L1.q)
            end
            local s = ____opt_result_591
            local ____arrL_598 = __arrL
            local ____t_597 = __t
            local ____lenq_595 = __lenq
            local ____opt_result_594
            if s ~= nil then
                ____opt_result_594 = s.collected
            end
            local ____lenq_595_result_596 = ____lenq_595(____opt_result_594)
            __O[1728] = ____lenq_595_result_596
            return ____arrL_598({"Bivolt · energia da resenha", if __t(__L1.q.bivoltAccepted) then tostring(if ____t_597(____lenq_595_result_596) then __O[1728] else 0) .. "/3 latas encontradas. Suba as prateleiras e a varanda; depois volte às garotas." else "Converse com as garotas na Casa de Rayssa para descobrir um energético que fortalece todos os atributos por 10 segundos."}, 2)
        end
        local ____opt_601 = window.MissaoFarda
        if ____opt_601 ~= nil then
            ____opt_601 = ____opt_601.objetivo
        end
        local ____opt_result_603
        if ____opt_601 ~= nil then
            ____opt_result_603 = ____opt_601(____opt_601, __L1.q, __L1.scene)
        end
        local fardaObj = ____opt_result_603
        if __t(fardaObj) then
            return fardaObj
        end
        local ____opt_606 = window.LugaresC1
        if ____opt_606 ~= nil then
            ____opt_606 = ____opt_606.objetivo
        end
        local ____opt_result_608
        if ____opt_606 ~= nil then
            ____opt_result_608 = ____opt_606(____opt_606, __L1.q, __L1.scene)
        end
        local lugarObj = ____opt_result_608
        if __t(lugarObj) then
            return lugarObj
        end
        if __t(__L1.scene == 11 and not __t(__L1.q.ollyan)) then
            return __arrL({"Orelhas ao vento", "Ollyan está no meio do baile. Use o carro a gás para persegui-lo numa luta aérea de três fases. Invista nos atributos antes de decolar."}, 2)
        end
        local ____t_611 = __t
        local ____opt_609 = window.Campaign
        if ____opt_609 ~= nil then
            ____opt_609 = ____opt_609.currentQuest
        end
        if ____t_611(____opt_609) then
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
            return __arrL({"Os cadernos do Almiro", if __t(__L1.q.almiroAccepted) then ("Recupere os 3 cadernos no corredor (" .. tostring(__len(__L1.q.notebooks))) .. "/3) e entregue ao professor na sala 01." else "Vá à escola e entre na sala do Almiro. Ele tem uma missão e ensina o combo de gás."}, 2)
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
        local ____opt_612 = __L1["$"](__L1, "hpValue")
        if ____opt_612 ~= nil then
            ____opt_612:setAttribute(
                "aria-label",
                (("Vida: " .. tostring(math.ceil(__L1.player.hp))) .. " de ") .. tostring(__L1:bonus().maxHP)
            )
        end
        __L1:setText("paperValue", __L1.player.papers)
        local ____opt_616 = window.C2Luta
        if ____opt_616 ~= nil then
            ____opt_616 = ____opt_616.skin
        end
        local ____opt_result_618
        if ____opt_616 ~= nil then
            ____opt_result_618 = ____opt_616.lugar
        end
        local localC2 = ____opt_result_618
        local ____t_627 = __t
        local ____t_620 = __t
        local ____get_result_619 = __get(__L1.scenes, __L1.scene)
        __O[1729] = ____get_result_619
        local ____opt_623 = window.LugaresC1
        if ____opt_623 ~= nil then
            ____opt_623 = ____opt_623.nome
        end
        local ____opt_result_625
        if ____opt_623 ~= nil then
            ____opt_result_625 = ____opt_623(____opt_623, __L1.scene)
        end
        local ____temp_626 = if ____t_620(____get_result_619) then __O[1729] else ____opt_result_625
        __O[1730] = ____temp_626
        local nomeAqui = if ____t_627(____temp_626) then __O[1730] else ""
        __L1:setText("stageName", if __t(localC2) then localC2 else nomeAqui)
        local ____L1_setText_636 = __L1.setText
        local ____add_635 = __add
        local ____add_634 = __add
        local ____t_633 = __t
        local ____opt_630 = window.LugaresC1
        if ____opt_630 ~= nil then
            ____opt_630 = ____opt_630.tem
        end
        local ____opt_result_632
        if ____opt_630 ~= nil then
            ____opt_result_632 = ____opt_630(____opt_630, __L1.scene)
        end
        ____L1_setText_636(__L1, "sceneLabel", if __t(localC2) then __add(
            "CONQUISTA / ",
            __call(localC2, "toUpperCase")
        ) else ____add_635(
            ____add_634(if ____t_633(____opt_result_632) then "ITABUNA" else __call(
                tostring(__L1.scene + 1),
                "padStart",
                2,
                "0"
            ), " / "),
            __call(nomeAqui, "toUpperCase")
        ))
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
        local ____t_638 = __t
        local ____L1__24_result_637 = __L1["$"](__L1, "gasPercent")
        __O[1731] = ____L1__24_result_637
        local gf = if ____t_638(____L1__24_result_637) then __O[1731] else __L1["$"](__L1, "gasValue")
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
        local ____L1_setText_644 = __L1.setText
        local ____add_643 = __add
        local ____desc_642 = desc
        local ____t_641 = __t
        local ____t_640 = __t
        local ____temp_639 = if __t(__L1.q.kaua) then __L1.weapon < 2 else __L1.q.kaua
        __O[1732] = ____temp_639
        ____L1_setText_644(
            __L1,
            "missionDesc",
            ____add_643(____desc_642, if ____t_641(if ____t_640(____temp_639) then __L1:materialCount() >= if __L1.weapon == 0 then 3 else 5 else __O[1732]) then " Kauã já pode fabricar sua próxima arma na roça!" else "")
        )
        __L1:setText(
            "materialValue",
            __L1:materialCount()
        )
        __L1:setText(
            "weaponValue",
            __add("Nível ", __L1.weapon)
        )
        local ____opt_645 = __L1["$"](__L1, "weaponValue")
        if ____opt_645 ~= nil then
            ____opt_645:setAttribute(
                "title",
                __get(__L1.weaponNames, __L1.weapon)
            )
        end
        local ____L1_show_652 = __L1.show
        local ____t_651 = __t
        local ____t_649 = __t
        local ____opt_647 = __L1.training
        if ____opt_647 ~= nil then
            ____opt_647 = ____opt_647.active
        end
        local ____temp_650 = not not ____t_649(____opt_647) and not __t(__L1.paused)
        __O[1733] = ____temp_650
        ____L1_show_652(__L1, "trainingAction", if ____t_651(____temp_650) then not __t(__L1.dialog) else __O[1733])
        local shell = __L1["$"](__L1, "gameShell")
        if __t(shell) then
            local ____self_656 = shell.classList
            local ____self_656_toggle_657 = ____self_656.toggle
            local ____t_655 = __t
            local ____opt_653 = __L1.training
            if ____opt_653 ~= nil then
                ____opt_653 = ____opt_653.active
            end
            ____self_656_toggle_657(
                ____self_656,
                "is-training",
                not not ____t_655(____opt_653) and not __t(__L1.activity)
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
                local ____this_659
                ____this_659 = el
                local ____opt_658 = ____this_659.querySelector
                if ____opt_658 ~= nil then
                    ____opt_658 = ____opt_658(____this_659, "small")
                end
                local label = ____opt_658
                if __t(label) then
                    label.textContent = "BATATA!"
                end
            end
        )
        local hitButton = __L1["$"](__L1, "trainingHitBtn")
        if __t(hitButton) then
            local ____hitButton_setAttribute_663 = hitButton.setAttribute
            local ____t_662 = __t
            local ____opt_660 = __L1.training
            if ____opt_660 ~= nil then
                ____opt_660 = ____opt_660.active
            end
            ____hitButton_setAttribute_663(hitButton, "aria-label", if ____t_662(____opt_660) then "Acertar na faixa verde — E ou Espaço" else "Treino indisponível")
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
                el:setAttribute("aria-current", if n == __L1.scene then "location" else "false")
            end
        )
        __call(
            window.document:querySelectorAll("[data-action=\"reeis\"]"),
            "forEach",
            function(____, el)
                el.classList:toggle("unlocked", __L1.q.reeis)
                el.title = if __t(__L1.q.reeis) then if __L1.reeisCooldown > 0 then ("Reeis recarregando: " .. tostring(math.ceil(__L1.reeisCooldown))) .. "s" else "Chamar Reeis (R)" else "Vença Reeis na favela para conquistar sua ajuda"
            end
        )
        __L1:setText("dashValue", if __L1.dashCooldown > 0 then __add(
            __call(__L1.dashCooldown, "toFixed", 1),
            "s"
        ) else "PRONTO")
        __call(
            window.document:querySelectorAll("[data-action=\"dash\"]"),
            "forEach",
            function(____, el)
                el.classList:toggle("cooldown", __L1.dashCooldown > 0)
                local ____el_668 = el
                local ____el_setAttribute_669 = el.setAttribute
                local ____t_667 = __t
                local ____t_665 = __t
                local ____temp_664 = __L1.dashCooldown > 0
                __O[1734] = ____temp_664
                local ____temp_666 = if ____t_665(____temp_664) then __O[1734] else __L1.vehicle
                __O[1735] = ____temp_666
                ____el_setAttribute_669(
                    ____el_668,
                    "aria-disabled",
                    tostring(if ____t_667(____temp_666) then __O[1735] else not __t(__L1.q.mota) and not __t(__L1.q.trained))
                )
            end
        )
        if __t(shell) then
            local ____self_672 = shell.classList
            local ____self_672_toggle_673 = ____self_672.toggle
            local ____opt_670 = __L1.cutscene
            if ____opt_670 ~= nil then
                ____opt_670 = ____opt_670.kind
            end
            ____self_672_toggle_673(____self_672, "is-epilogue", ____opt_670 == "jorge_epilogue")
            shell.classList:toggle("is-chapter-ended", __L1.chapterEnded)
            local ____self_677 = shell.classList
            local ____self_677_toggle_678 = ____self_677.toggle
            local ____temp_676 = not not __t(__L1.cutscene)
            if not ____temp_676 then
                local ____opt_674 = __L1.ollyanEncounter
                if ____opt_674 ~= nil then
                    ____opt_674 = ____opt_674.stage
                end
                ____temp_676 = ____opt_674 == "intro"
            end
            ____self_677_toggle_678(____self_677, "is-cutscene", ____temp_676)
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
        local ____L1_show_683 = __L1.show
        local ____t_682 = __t
        local ____temp_681 = not not __t(__L1.cutscene)
        if not ____temp_681 then
            local ____opt_679 = __L1.ollyanEncounter
            if ____opt_679 ~= nil then
                ____opt_679 = ____opt_679.stage
            end
            ____temp_681 = ____opt_679 == "intro"
        end
        __O[1736] = ____temp_681
        ____L1_show_683(__L1, "cinematicOverlay", if ____t_682(____temp_681) then not __t(__L1.paused) else __O[1736])
        local ____L1_show_686 = __L1.show
        local ____t_685 = __t
        local ____temp_684 = not not __t(__L1.room) and not __t(__L1.cutscene)
        __O[1737] = ____temp_684
        ____L1_show_686(__L1, "roomOverlay", if ____t_685(____temp_684) then not __t(__L1.activity) else __O[1737])
        local ____L1_setText_693 = __L1.setText
        local ____t_692 = __t
        local ____opt_689 = window.FavelaCasas
        if ____opt_689 ~= nil then
            ____opt_689 = ____opt_689.ehCasa
        end
        local ____opt_result_691
        if ____opt_689 ~= nil then
            ____opt_result_691 = ____opt_689(____opt_689, __L1.room.id)
        end
        ____L1_setText_693(__L1, "roomName", if __t(__L1.room) then if ____t_692(____opt_result_691) then window.FavelaCasas:nome(__L1.room.id) else if __L1.room.id == "almiro" then "Sala do Professor Almiro" else "Sala do Professor Miqueias" else "")
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
            local ____opt_694 = __L1.room
            if ____opt_694 ~= nil then
                ____opt_694 = ____opt_694.phase
            end
            exit.disabled = ____opt_694 ~= "inside"
        end
        local ____opt_696 = __L1.activity
        if ____opt_696 ~= nil then
            ____opt_696 = ____opt_696.kind
        end
        local dinner = ____opt_696 == "dinner"
        local ____L1_show_702 = __L1.show
        local ____t_701 = __t
        local ____t_699 = __t
        local ____temp_698 = not not __t(__L1.activity) and not __t(__L1.paused)
        __O[1738] = ____temp_698
        local ____temp_700 = if ____t_699(____temp_698) then not __t(__L1.dialog) else __O[1738]
        __O[1739] = ____temp_700
        ____L1_show_702(__L1, "activityOverlay", if ____t_701(____temp_700) then not __t(__L1.cutscene) else __O[1739])
        if shell ~= nil then
            shell.classList:toggle(
                "is-activity",
                not not __t(__L1.activity)
            )
        end
        if shell ~= nil then
            shell.classList:toggle("is-dinner", dinner)
        end
        __L1:show("dinnerBreath", if __t(dinner) then __L1.activity.phase == "breath" else dinner)
        __L1:show("dinnerSpeaker", dinner)
        if __t(__L1.activity) then
            local view = window.Activities:view(__L1.activity)
            if __t(dinner) then
                __L1:setText("dinnerSpeaker", view.speaker)
                __L1["$"](__L1, "activityOverlay").dataset.phase = __L1.activity.phase
            end
            __L1:setText("activityTitle", view.title)
            __L1:setText("activityText", view.text)
            local ____L1_setText_708 = __L1.setText
            local ____view_scoreLabel_707 = view.scoreLabel
            if ____view_scoreLabel_707 == nil then
                ____view_scoreLabel_707 = __L1.activity.score
            end
            ____L1_setText_708(__L1, "activityScore", ____view_scoreLabel_707)
            __L1:setText("activityMainBtn", if __t(view.actionLabel) then view.actionLabel else "CHUTAR")
            __L1:setText("activityExitBtn", if __t(dinner) then "Voltar à praça" else "Sair do desafio")
            __L1:show(
                "activityMainBtn",
                not __t(__lenq(view.choices))
            )
            local ____L1_show_714 = __L1.show
            local ____t_713 = __t
            local ____t_710 = __t
            local ____temp_709 = if __t(dinner) then __L1.activity.phase == "outcome" else dinner
            __O[1741] = ____temp_709
            local ____t_712 = __t
            local ____lt_result_711 = __lt(__L1.activity.score, 2)
            __O[1740] = ____lt_result_711
            ____L1_show_714(
                __L1,
                "activityExitBtn",
                not ____t_713(if ____t_710(____temp_709) then if ____t_712(____lt_result_711) then __O[1740] else __L1.activity.options.dating else __O[1741])
            )
            do
                local i = 0
                while i < 3 do
                    local button = __L1["$"](
                        __L1,
                        __add("activityChoice", i)
                    )
                    local choice = __getq(view.choices, i)
                    if not __t(button) then
                        continue
                    end
                    button.hidden = not __t(choice)
                    if __t(choice) then
                        local ____L1_setText_717 = __L1.setText
                        local ____button_id_716 = button.id
                        local ____choice_label_715 = choice.label
                        if ____choice_label_715 == nil then
                            ____choice_label_715 = tostring(choice)
                        end
                        ____L1_setText_717(__L1, ____button_id_716, ____choice_label_715)
                        local ____button_dataset_719 = button.dataset
                        local ____choice_value_718 = choice.value
                        if ____choice_value_718 == nil then
                            ____choice_value_718 = i
                        end
                        ____button_dataset_719.value = tostring(____choice_value_718)
                    end
                    i = i + 1
                end
            end
        end
        local p = __L1["$"](__L1, "pauseBtn")
        if __t(p) then
            p:setAttribute("aria-label", if __t(__L1.paused) then "Continuar jogo" else "Pausar jogo")
        end
        local nearby = __L1:closestBoss()
        __call(
            window.document:querySelectorAll("[data-action=\"interact\"]"),
            "forEach",
            function(____, el)
                local ____this_721
                ____this_721 = el
                local ____opt_720 = ____this_721.querySelector
                if ____opt_720 ~= nil then
                    ____opt_720 = ____opt_720(____this_721, "small")
                end
                local label = ____opt_720
                if __t(label) then
                    label.textContent = if __t(__L1.ollyanEncounter) then if __L1.ollyanEncounter.stage == "intro" then "AVANÇAR" else "RECUAR" else if __t(if __t(__L1.arena) then __le(
                        __L1.player.x,
                        __get(__L1.arena.bounds, 0) + 78
                    ) else __L1.arena) then "RECUAR" else if __t(nearby) then if __t(__L1:bossAccess(nearby).ok) then "DESAFIAR" else "MISSÕES" else "FALAR"
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
                __call(__L1.pickups, "push", {
                    x = 620 + i * 280,
                    y = __L1.FLOOR - 24 - if __mod(i, 3) == 1 then 105 else 0,
                    type = if __mod(i, 3) == 0 then "gas" else "paper",
                    taken = false,
                    t = i
                })
                i = i + 1
            end
        end
        local ____t_724 = __t
        local ____t_723 = __t
        local ____temp_722 = __L1.scene == 0 or __L1.scene == 1
        __O[1742] = ____temp_722
        if ____t_724(if ____t_723(____temp_722) then __O[1742] else __L1.scene == 4) then
            local places = if __L1.scene == 0 then __arrL({
                590,
                645,
                700,
                850,
                900,
                950,
                1080,
                1135
            }, 8) else if __L1.scene == 1 then __arrL({
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
            }, 10) else __arrL({
                580,
                740,
                980,
                1450,
                1830,
                2460
            }, 6)
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
            local flag = if ____type == "reeisBoss" then "reeis" else ____type
            if __t(__L1.scene == where and not __t(__get(__L1.q, flag))) then
                local ____t_730 = __t
                local ____opt_727 = window.Difficulty
                if ____opt_727 ~= nil then
                    ____opt_727 = ____opt_727:boss(____type)
                end
                local ____opt_result_729
                if ____opt_727 ~= nil then
                    ____opt_result_729 = ____opt_727.hp
                end
                __O[1743] = ____opt_result_729
                local max = if ____t_730(____opt_result_729) then __O[1743] else hp
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
        local ____call_735 = __call
        local ____call_734 = __call
        local ____t_733 = __t
        local ____opt_731 = window.WorldData
        if ____opt_731 ~= nil then
            ____opt_731 = ____opt_731.minions
        end
        __O[1744] = ____opt_731
        __L1.minions = ____call_735(
            ____call_734(
                if ____t_733(____opt_731) then __O[1744] else __arrL({}, 0),
                "filter",
                function(____, m) return m.scene == __L1.scene end
            ),
            "map",
            function(____, m) return __assign(
                {},
                m,
                {
                    homeX = m.x,
                    max = m.hp,
                    dead = __call(__L1.minionKills, "includes", m.id),
                    hit = 0,
                    t = 0.8 + if __t(m.kind) then m.kind else 0 * 0.4,
                    vy = 0,
                    dir = 1
                }
            ) end
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
        local ____iter_739 = __iter
        local ____t_738 = __t
        local ____opt_736 = window.WorldData
        if ____opt_736 ~= nil then
            ____opt_736 = ____opt_736.collectibles
        end
        __O[1745] = ____opt_736
        for ____, p in __TS__Iterator(____iter_739(if ____t_738(____opt_736) then __O[1745] else __arrL({}, 0))) do
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
        local ____t_748 = __t
        local ____t_744 = __t
        local ____callq_742 = __callq
        local ____opt_740 = window.WorldData
        if ____opt_740 ~= nil then
            ____opt_740 = ____opt_740.questPickups
        end
        local ____callq_742_result_743 = ____callq_742(
            ____opt_740,
            "filter",
            function(____, p) return p.type == "carPart" end
        )
        __O[1746] = ____callq_742_result_743
        local ____opt_745 = window.WorldData
        if ____opt_745 ~= nil then
            ____opt_745 = ____opt_745.repairParts
        end
        local ____temp_747 = if ____t_744(____callq_742_result_743) then __O[1746] else ____opt_745
        __O[1747] = ____temp_747
        local repair = if ____t_748(____temp_747) then __O[1747] else __arrL({{id = "motor", scene = 0, x = 1300, y = 300}, {id = "ventoinha", scene = 0, x = 2500, y = 280}, {id = "cilindro", scene = 0, x = 4200, y = 285}}, 3)
        for ____, p in __iterar((repair)) do
            local ____p_scene_749 = p.scene
            if ____p_scene_749 == nil then
                ____p_scene_749 = 0
            end
            if ____p_scene_749 == __L1.scene then
                __call(
                    __L1.pickups,
                    "push",
                    __assign({}, p, {type = "repair", t = 0, taken = if __t(__L1.q.lucas) then __L1.q.lucas else __call(__L1.q.carParts, "includes", p.id)})
                )
            end
        end
        local ____t_758 = __t
        local ____t_754 = __t
        local ____callq_752 = __callq
        local ____opt_750 = window.WorldData
        if ____opt_750 ~= nil then
            ____opt_750 = ____opt_750.questPickups
        end
        local ____callq_752_result_753 = ____callq_752(
            ____opt_750,
            "filter",
            function(____, p) return p.type == "notebook" end
        )
        __O[1748] = ____callq_752_result_753
        local ____opt_755 = window.WorldData
        if ____opt_755 ~= nil then
            ____opt_755 = ____opt_755.notebooks
        end
        local ____temp_757 = if ____t_754(____callq_752_result_753) then __O[1748] else ____opt_755
        __O[1749] = ____temp_757
        local books = if ____t_758(____temp_757) then __O[1749] else __arrL({{id = "caderno-1", scene = 1, x = 1600, y = 355}, {id = "caderno-2", scene = 1, x = 2100, y = 350}, {id = "caderno-3", scene = 1, x = 2900, y = 235}}, 3)
        for ____, p in __iterar((books)) do
            local ____p_scene_759 = p.scene
            if ____p_scene_759 == nil then
                ____p_scene_759 = 1
            end
            if ____p_scene_759 == __L1.scene then
                __call(
                    __L1.pickups,
                    "push",
                    __assign({}, p, {type = "notebook", t = 1, taken = if __t(__L1.q.almiro) then __L1.q.almiro else __call(__L1.q.notebooks, "includes", p.id)})
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
        local ____t_774 = __t
        local ____t_773 = __t
        local ____t_771 = __t
        local ____t_769 = __t
        local ____t_767 = __t
        local ____t_765 = __t
        local ____t_763 = __t
        local ____t_761 = __t
        local ____temp_760 = not __t(__L1.vehicle)
        __O[1750] = ____temp_760
        local ____temp_762 = if ____t_761(____temp_760) then __O[1750] else __L1.activeBoss
        __O[1751] = ____temp_762
        local ____temp_764 = if ____t_763(____temp_762) then __O[1751] else __L1.arena
        __O[1752] = ____temp_764
        local ____temp_766 = if ____t_765(____temp_764) then __O[1752] else __L1.room
        __O[1753] = ____temp_766
        local ____temp_768 = if ____t_767(____temp_766) then __O[1753] else __L1.cutscene
        __O[1754] = ____temp_768
        local ____temp_770 = if ____t_769(____temp_768) then __O[1754] else __L1.routeTransition
        __O[1755] = ____temp_770
        local ____temp_772 = if ____t_771(____temp_770) then __O[1755] else __L1.defeated
        __O[1756] = ____temp_772
        if ____t_774(if ____t_773(____temp_772) then __O[1756] else __L1.ollyanEncounter) then
            return false
        end
        __L1:releaseInputs()
        __L1:emitGameEvent("car-route-request", {scene = __L1.scene, reason = reason})
        return true
    end
    __L1.travel = function(self, n)
        n = __TS__Number(n)
        local ____t_784 = __t
        local ____t_776 = __t
        local ____temp_775 = not __isInteger(n) or __lt(n, 0)
        __O[1757] = ____temp_775
        local ____ge_result_783 = __ge(
            n,
            __len(__L1.scenes)
        )
        if ____ge_result_783 then
            local ____t_782 = __t
            local ____opt_779 = window.LugaresC1
            if ____opt_779 ~= nil then
                ____opt_779 = ____opt_779.tem
            end
            local ____opt_result_781
            if ____opt_779 ~= nil then
                ____opt_result_781 = ____opt_779(____opt_779, n)
            end
            ____ge_result_783 = not ____t_782(____opt_result_781)
        end
        if ____t_784(if ____t_776(____temp_775) then __O[1757] else ____ge_result_783) then
            return false
        end
        __L1:releaseInputs()
        if not __t(__L1.started) then
            __L1:toast("Comece a aventura para explorar o mapa.")
            return false
        end
        local ____t_801 = __t
        local ____t_800 = __t
        local ____t_798 = __t
        local ____t_796 = __t
        local ____t_794 = __t
        local ____t_792 = __t
        local ____t_790 = __t
        local ____t_788 = __t
        local ____t_786 = __t
        local ____temp_785 = if __t(__L1.paused) then __L1.paused else __L1.won
        __O[1758] = ____temp_785
        local ____temp_787 = if ____t_786(____temp_785) then __O[1758] else __L1.chapterEnded
        __O[1759] = ____temp_787
        local ____temp_789 = if ____t_788(____temp_787) then __O[1759] else __L1.defeated
        __O[1760] = ____temp_789
        local ____temp_791 = if ____t_790(____temp_789) then __O[1760] else __L1.room
        __O[1761] = ____temp_791
        local ____temp_793 = if ____t_792(____temp_791) then __O[1761] else __L1.arena
        __O[1762] = ____temp_793
        local ____temp_795 = if ____t_794(____temp_793) then __O[1762] else __L1.cutscene
        __O[1763] = ____temp_795
        local ____temp_797 = if ____t_796(____temp_795) then __O[1763] else __L1.activity
        __O[1764] = ____temp_797
        local ____temp_799 = if ____t_798(____temp_797) then __O[1764] else __L1.routeTransition
        __O[1765] = ____temp_799
        if ____t_801(if ____t_800(____temp_799) then __O[1765] else __L1.ollyanEncounter) then
            __L1:toast("Aguarde a chegada ou retome a aventura.")
            return false
        end
        if __t(__L1.activity) then
            __L1:toast("Termine o minigame ou use SAIR antes de viajar.")
            return false
        end
        local ____t_804 = __t
        local ____opt_802 = __L1.training
        if ____opt_802 ~= nil then
            ____opt_802 = ____opt_802.active
        end
        if ____t_804(____opt_802) then
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
            local ____L1_scene_808 = __L1.scene
            local ____n_809 = n
            local ____t_807 = __t
            local ____opt_805 = window.EstradaViagem
            if ____opt_805 ~= nil then
                ____opt_805 = ____opt_805.duracao
            end
            __O[1766] = ____opt_805
            __L1.routeTransition = {
                from = ____L1_scene_808,
                to = ____n_809,
                t = 0,
                duration = if ____t_807(____opt_805) then __O[1766] else 0.01,
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
        local ____t_812 = __t
        local ____opt_810 = window.Campaign
        if ____opt_810 ~= nil then
            ____opt_810 = ____opt_810.canTravel
        end
        if ____t_812(____opt_810) then
            local g = window.Campaign:canTravel(n, __L1.q)
            if __t(if __t(g) then g.ok == false else g) then
                return g.reason
            end
        end
        local ____t_817 = __t
        local ____temp_816 = n == 5
        if ____temp_816 then
            local ____t_815 = __t
            local ____t_814 = __t
            local ____temp_813 = if __t(__L1.q.mota) then __L1.q.almiro else __L1.q.mota
            __O[1767] = ____temp_813
            ____temp_816 = not ____t_815(if ____t_814(____temp_813) then __L1.q.miqueias else __O[1767])
        end
        if ____t_817(____temp_816) then
            return "Complete o futebol do Mota e as missões dos dois professores antes de subir à favela."
        end
        if __t(n == 6 and not __t(__L1.q.marco)) then
            return "Vença Marco na escola para abrir o Caderno do Caos."
        end
        if __t(n == 2 and not __t(__L1.q.menezes)) then
            return "Vença Menezes no fim da escola antes do treino com Caleb."
        end
        local ____t_822 = __t
        local ____temp_821 = n == 3
        if ____temp_821 then
            local ____t_820 = __t
            local ____t_819 = __t
            local ____temp_818 = if __t(__L1.q.trained) then __L1.q.giant else __L1.q.trained
            __O[1768] = ____temp_818
            ____temp_821 = not ____t_820(if ____t_819(____temp_818) then __L1.q.menezes else __O[1768])
        end
        if ____t_822(____temp_821) then
            return "Vença o gigante, Menezes e complete o treino do Caleb antes do final."
        end
        return ""
    end
    __L1.arrive = function(self, n)
        local ____opt_825 = window.CampaignVfx
        if ____opt_825 ~= nil then
            ____opt_825 = ____opt_825.reset
        end
        if ____opt_825 ~= nil then
            ____opt_825(____opt_825)
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
        local ____L1_toast_836 = __L1.toast
        local ____t_835 = __t
        local ____t_828 = __t
        local ____get_result_827 = __get(__L1.scenes, n)
        __O[1769] = ____get_result_827
        local ____opt_831 = window.LugaresC1
        if ____opt_831 ~= nil then
            ____opt_831 = ____opt_831.nome
        end
        local ____opt_result_833
        if ____opt_831 ~= nil then
            ____opt_result_833 = ____opt_831(____opt_831, n)
        end
        local ____temp_834 = if ____t_828(____get_result_827) then __O[1769] else ____opt_result_833
        __O[1770] = ____temp_834
        ____L1_toast_836(
            __L1,
            ("Chegou: " .. tostring(if ____t_835(____temp_834) then __O[1770] else "Itabuna")) .. ". V estaciona o carro a gás. E conversa."
        )
        local ____opt_839 = window.Roteiro
        if ____opt_839 ~= nil then
            ____opt_839 = ____opt_839.chegada
        end
        local ____opt_result_841
        if ____opt_839 ~= nil then
            ____opt_result_841 = ____opt_839(____opt_839, n, __L1.q)
        end
        local arrival = ____opt_result_841
        if __t(if __t(arrival) then not __t(__L1.sandbox) else arrival) then
            window.Roteiro:visto(arrival, __L1.q)
            __L1:save()
            local function tocar()
                return __L1:playCutscene(arrival)
            end
            local ____t_847 = __t
            local ____opt_844 = window.ChegadaCarro
            if ____opt_844 ~= nil then
                ____opt_844 = ____opt_844.ativa
            end
            local ____opt_result_846
            if ____opt_844 ~= nil then
                ____opt_result_846 = ____opt_844(____opt_844)
            end
            if ____t_847(____opt_result_846) then
                window.ChegadaCarro:depois(tocar)
            else
                tocar(nil)
            end
        end
    end
    __L1.say = function(self, lines, done)
        local pages = __arrL({}, 0)
        for ____, raw in __iterar((lines)) do
            local line = if type(raw) == "string" then {name = "Da Roça", text = raw} else raw
            local words = __re_split(
                __call(
                    tostring(if __t(line.text) then line.text else ""),
                    "trim"
                ),
                __re("\\s+", "")
            )
            local chunk = ""
            local chunks = __arrL({}, 0)
            for ____, word in __iterar((words)) do
                if __t(if __t(chunk) then __len(chunk) + __len(word) + 1 > 108 else chunk) then
                    __call(chunks, "push", chunk)
                    chunk = word
                else
                    chunk = __add(
                        chunk,
                        __add(if __t(chunk) then " " else "", word)
                    )
                end
            end
            if __t(if __t(chunk) then chunk else not __t(__len(chunks))) then
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
        __L1.dialogCallback = if type(done) == "function" then done else nil
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
        __L1:setText("dialogNext", if __t(line.actionLabel) then line.actionLabel else if __L1.dialog.index == __len(__L1.dialog.lines) - 1 then "Concluir  ↵" else "Próximo  ↵")
        __L1:setText("dialogClose", if __t(__L1.dialog.completionRequired) then "Pular fala · Esc" else "Fechar · Esc")
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
        local finish = if __t(completed) then completed else __L1.dialog.completionRequired
        local callback = if __t(finish) then __L1.dialogCallback else nil
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
        local ____ge_851 = __ge
        local ____L1_dialog_848, ____index_849 = __L1.dialog, "index"
        local ____L1_dialog_index_850 = ____L1_dialog_848[____index_849] + 1
        ____L1_dialog_848[____index_849] = ____L1_dialog_index_850
        if ____ge_851(
            ____L1_dialog_index_850,
            __len(__L1.dialog.lines)
        ) then
            return __L1:closeDialogue(true)
        end
        __L1:renderDialog()
        return true
    end
    __L1.getDialogueView = function(self)
        return {
            dialog = not not __t(__L1.dialog),
            paused = __L1.paused,
            cutscene = if __t(__L1.cutscene) then __assign({}, __L1.cutscene) else nil
        }
    end
    __L1.visitTalk = function(self, id)
        local ____t_854 = __t
        local ____t_853 = __t
        local ____temp_852 = not __t(__L1.q.npcVisits) or type(__L1.q.npcVisits) ~= "table"
        __O[1771] = ____temp_852
        if ____t_854(if ____t_853(____temp_852) then __O[1771] else __isArray(__L1.q.npcVisits)) then
            __L1.q.npcVisits = {}
        end
        local ____t_856 = __t
        local ____TS__Number_result_855 = __TS__Number(__get(__L1.q.npcVisits, id))
        __O[1772] = ____TS__Number_result_855
        local visit = math.max(
            0,
            math.floor(if ____t_856(____TS__Number_result_855) then __O[1772] else 0)
        )
        __set(__L1.q.npcVisits, id, visit + 1)
        __L1:save()
        local ____opt_859 = window.Resenha
        if ____opt_859 ~= nil then
            ____opt_859 = ____opt_859.talk
        end
        local ____opt_result_861
        if ____opt_859 ~= nil then
            ____opt_result_861 = ____opt_859(____opt_859, id, visit, __L1.q)
        end
        local lines = ____opt_result_861
        local ____t_864 = __t
        local ____t_863 = __t
        local ____isArray_result_862 = __isArray(lines)
        __O[1773] = ____isArray_result_862
        if ____t_864(if ____t_863(____isArray_result_862) then __len(lines) else __O[1773]) then
            return lines
        end
        local ____t_870 = __t
        local ____getq_868 = __getq
        local ____callq_867 = __callq
        local ____opt_865 = __get(__L1.npcInfo, id)
        if ____opt_865 ~= nil then
            ____opt_865 = ____opt_865.name
        end
        local ____getq_868_result_869 = ____getq_868(
            ____callq_867(____opt_865, "split", " ·"),
            0
        )
        __O[1774] = ____getq_868_result_869
        local name = if ____t_870(____getq_868_result_869) then __O[1774] else id
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
        local ____t_872 = __t
        local ____get_result_871 = __get(fallback, id)
        __O[1775] = ____get_result_871
        local pool = if ____t_872(____get_result_871) then __O[1775] else __arrL({"A resenha muda, mas o bolo continua no assunto."}, 1)
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
        local ____t_878 = __t
        local ____opt_875 = window.SwiftGuide
        if ____opt_875 ~= nil then
            ____opt_875 = ____opt_875.open
        end
        local ____opt_result_877
        if ____opt_875 ~= nil then
            ____opt_result_877 = ____opt_875(____opt_875, {say = __L1.say, toast = __L1.toast})
        end
        __O[1776] = ____opt_result_877
        return if ____t_878(____opt_result_877) then __O[1776] else false
    end
    __L1.interact = function(self)
        if __t(__L1.dialog) then
            __L1:nextDialog()
            return
        end
        if __t(if __t(__L1.ollyanEncounter) then not __t(__L1.paused) else __L1.ollyanEncounter) then
            local ____t_881 = __t
            local ____t_880 = __t
            local ____temp_879 = __L1.ollyanEncounter.stage == "intro"
            __O[1777] = ____temp_879
            if ____t_881(if ____t_880(____temp_879) then __O[1777] else __call(
                __arrL({"victory", "defeat"}, 2),
                "includes",
                __L1.ollyanEncounter.stage
            )) then
                __L1:advanceCutscene()
            else
                __L1:retreatOllyan()
            end
            return
        end
        local ____t_894 = __t
        local ____t_893 = __t
        local ____t_891 = __t
        local ____t_889 = __t
        local ____t_887 = __t
        local ____t_885 = __t
        local ____t_883 = __t
        local ____temp_882 = not __t(__L1.started)
        __O[1778] = ____temp_882
        local ____temp_884 = if ____t_883(____temp_882) then __O[1778] else __L1.paused
        __O[1779] = ____temp_884
        local ____temp_886 = if ____t_885(____temp_884) then __O[1779] else __L1.chapterEnded
        __O[1780] = ____temp_886
        local ____temp_888 = if ____t_887(____temp_886) then __O[1780] else __L1.defeated
        __O[1781] = ____temp_888
        local ____temp_890 = if ____t_889(____temp_888) then __O[1781] else __L1.cutscene
        __O[1782] = ____temp_890
        local ____temp_892 = if ____t_891(____temp_890) then __O[1782] else __L1.routeTransition
        __O[1783] = ____temp_892
        if ____t_894(if ____t_893(____temp_892) then __O[1783] else window.performance:now() < __L1.dialogueReopenUntil) then
            return
        end
        if __t(__L1.won) then
            return
        end
        local ____t_913 = __t
        local ____t_907 = __t
        local ____t_905 = __t
        local ____t_903 = __t
        local ____t_901 = __t
        local ____t_899 = __t
        local ____temp_898 = not __t(__L1.activity)
        if ____temp_898 then
            local ____t_897 = __t
            local ____opt_895 = __L1.training
            if ____opt_895 ~= nil then
                ____opt_895 = ____opt_895.active
            end
            ____temp_898 = not ____t_897(____opt_895)
        end
        __O[1784] = ____temp_898
        local ____temp_900 = if ____t_899(____temp_898) then not __t(__L1.arena) else __O[1784]
        __O[1785] = ____temp_900
        local ____temp_902 = if ____t_901(____temp_900) then not __t(__L1.room) else __O[1785]
        __O[1786] = ____temp_902
        local ____temp_904 = if ____t_903(____temp_902) then not __t(__L1.activeBoss) else __O[1786]
        __O[1787] = ____temp_904
        local ____temp_906 = if ____t_905(____temp_904) then not __t(__L1.vehicle) else __O[1787]
        __O[1788] = ____temp_906
        local ____opt_910 = window.Balanco
        if ____opt_910 ~= nil then
            ____opt_910 = ____opt_910.near
        end
        local ____opt_result_912
        if ____opt_910 ~= nil then
            ____opt_result_912 = ____opt_910(____opt_910, __L1.scene, __L1.player.x)
        end
        if ____t_913(if ____t_907(____temp_906) then ____opt_result_912 else __O[1788]) then
            __L1:releaseInputs()
            window.Balanco:sit()
            return
        end
        local ____t_932 = __t
        local ____t_926 = __t
        local ____t_924 = __t
        local ____t_922 = __t
        local ____t_920 = __t
        local ____t_918 = __t
        local ____temp_917 = not __t(__L1.activity)
        if ____temp_917 then
            local ____t_916 = __t
            local ____opt_914 = __L1.training
            if ____opt_914 ~= nil then
                ____opt_914 = ____opt_914.active
            end
            ____temp_917 = not ____t_916(____opt_914)
        end
        __O[1789] = ____temp_917
        local ____temp_919 = if ____t_918(____temp_917) then not __t(__L1.arena) else __O[1789]
        __O[1790] = ____temp_919
        local ____temp_921 = if ____t_920(____temp_919) then not __t(__L1.room) else __O[1790]
        __O[1791] = ____temp_921
        local ____temp_923 = if ____t_922(____temp_921) then not __t(__L1.activeBoss) else __O[1791]
        __O[1792] = ____temp_923
        local ____temp_925 = if ____t_924(____temp_923) then not __t(__L1.vehicle) else __O[1792]
        __O[1793] = ____temp_925
        local ____opt_929 = window.Fliperama
        if ____opt_929 ~= nil then
            ____opt_929 = ____opt_929.near
        end
        local ____opt_result_931
        if ____opt_929 ~= nil then
            ____opt_result_931 = ____opt_929(____opt_929, __L1.scene, __L1.player.x)
        end
        if ____t_932(if ____t_926(____temp_925) then ____opt_result_931 else __O[1793]) then
            __L1:releaseInputs()
            window.Fliperama:open(nil, {from = "world"})
            return
        end
        if __t(__L1.activity) then
            __L1:submitActivity()
            return
        end
        local ____t_935 = __t
        local ____opt_933 = __L1.training
        if ____opt_933 ~= nil then
            ____opt_933 = ____opt_933.active
        end
        if ____t_935(____opt_933) then
            __L1:submitTraining()
            return
        end
        local ____t_938 = __t
        local ____opt_936 = __L1.room
        if ____opt_936 ~= nil then
            ____opt_936 = ____opt_936.phase
        end
        if ____t_938(____opt_936 == "inside" and math.abs(__L1.player.x - __L1.room.exitX) < 105) then
            __L1:exitRoom()
            return
        end
        local ____t_941 = __t
        local ____opt_939 = __L1.arena
        if ____opt_939 ~= nil then
            ____opt_939 = ____opt_939.phase
        end
        if ____t_941(____opt_939 == "active" and __le(
            __L1.player.x,
            __get(__L1.arena.bounds, 0) + 78
        )) then
            __L1:retreatBoss()
            return
        end
        local pertinho = __L1:closestNPC()
        local ____t_956 = __t
        local ____t_954 = __t
        local ____t_947 = __t
        local ____opt_944 = window.MissaoFarda
        if ____opt_944 ~= nil then
            ____opt_944 = ____opt_944.ehNpc
        end
        local ____opt_result_946
        if ____opt_944 ~= nil then
            ____opt_result_946 = ____opt_944(
                ____opt_944,
                __get(pertinho, 0)
            )
        end
        __O[1794] = ____opt_result_946
        local ____opt_950 = window.LugaresC1
        if ____opt_950 ~= nil then
            ____opt_950 = ____opt_950.ehNpc
        end
        local ____opt_result_952
        if ____opt_950 ~= nil then
            ____opt_result_952 = ____opt_950(
                ____opt_950,
                __get(pertinho, 0)
            )
        end
        local ____temp_953 = if ____t_947(____opt_result_946) then __O[1794] else ____opt_result_952
        __O[1795] = ____temp_953
        local ____temp_955 = if __t(pertinho) then if ____t_954(____temp_953) then __O[1795] else __get(pertinho, 0) == "mc_batidao" else pertinho
        __O[1796] = ____temp_955
        local missao = if ____t_956(____temp_955) then math.abs(__get(pertinho, 1).x - __L1.player.x) < 75 else __O[1796]
        local boss = if __t(missao) then nil else __L1:closestBoss()
        if __t(boss) then
            __L1:interactBoss(boss)
            return
        end
        local ____t_959 = __t
        local ____t_958 = __t
        local ____temp_957 = not __t(missao) and not __t(__L1.room)
        __O[1797] = ____temp_957
        if ____t_959(if ____t_958(____temp_957) then not __t(__L1.arena) else __O[1797]) then
            local ____get_967 = __get
            local ____call_966 = __call
            local ____call_965 = __call
            local ____t_962 = __t
            local ____opt_960 = window.WorldData
            if ____opt_960 ~= nil then
                ____opt_960 = ____opt_960.doors
            end
            __O[1798] = ____opt_960
            local door = ____get_967(
                ____call_966(
                    ____call_965(
                        if ____t_962(____opt_960) then __O[1798] else __arrL({}, 0),
                        "filter",
                        function(____, d)
                            local ____t_964 = __t
                            local ____temp_963 = d.scene == __L1.scene and math.abs(__L1.player.x - d.x) < 105
                            __O[1799] = ____temp_963
                            return if ____t_964(____temp_963) then math.abs(__L1.player.y - __L1.FLOOR) < 65 else __O[1799]
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
        local ____t_985 = __t
        local ____t_973 = __t
        local ____t_971 = __t
        local ____t_969 = __t
        local ____temp_968 = not __t(missao) and not __t(__L1.room)
        __O[1800] = ____temp_968
        local ____temp_970 = if ____t_969(____temp_968) then not __t(__L1.arena) else __O[1800]
        __O[1801] = ____temp_970
        local ____temp_972 = if ____t_971(____temp_970) then not __t(__L1.vehicle) else __O[1801]
        __O[1803] = ____temp_972
        local ____opt_982 = window.WorldLife
        if ____opt_982 ~= nil then
            ____opt_982 = ____opt_982.tryInteract
        end
        local ____opt_result_984
        if ____opt_982 ~= nil then
            ____opt_result_984 = ____opt_982(
                ____opt_982,
                {scene = __L1.scene, player = __L1.player, q = __L1.q},
                {
                    awardXP = __L1.awardXP,
                    save = __L1.save,
                    updateUI = __L1.updateUI,
                    toast = __L1.toast,
                    addItem = function(____, ____type, count)
                        if __t(__call(__L1.items, "hasOwnProperty", ____type)) then
                            local ____set_980 = __set
                            local ____L1_items_978 = __L1.items
                            local ____type_979 = ____type
                            local ____get_result_977 = __get(__L1.items, ____type)
                            local ____t_976 = __t
                            local ____math_floor_result_975 = math.floor(count)
                            __O[1802] = ____math_floor_result_975
                            ____set_980(
                                ____L1_items_978,
                                ____type_979,
                                math.min(
                                    999,
                                    ____get_result_977 + math.max(0, if ____t_976(____math_floor_result_975) then __O[1802] else 0)
                                )
                            )
                        end
                    end
                }
            )
        end
        if ____t_985(if ____t_973(____temp_972) then ____opt_result_984 else __O[1803]) then
            return
        end
        local found = __L1:closestNPC()
        if not __t(found) then
            __L1:toast(if __t(__L1.vehicle) then "Carro a gás ligado! Escolha uma rota ou dirija com o joystick." else "Chegue perto de alguém e aperte E. O diário mostra a próxima missão.")
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
                __L1:say(__arrL({{name = n.name, text = if __t(__L1.q.almiro) then "Combo de gás: três toques separados, K → K → K. Não vale culpar a cadeira azul pelo barulho!" else ("Faltam " .. tostring(3 - __len(__L1.q.notebooks))) .. " cadernos! Estão nas plataformas do corredor. A careca está brilhando, mas não é radar."}}, 1))
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
            local ____opt_988 = window.BivoltQuest
            if ____opt_988 ~= nil then
                ____opt_988 = ____opt_988.interact
            end
            local ____opt_result_990
            if ____opt_988 ~= nil then
                ____opt_result_990 = ____opt_988(____opt_988, id, __L1.q, __L1.items)
            end
            local quest = ____opt_result_990
            local ____L1_say_1007 = __L1.say
            local ____t_994 = __t
            local ____opt_result_993
            if quest ~= nil then
                ____opt_result_993 = quest.lines
            end
            __O[1804] = ____opt_result_993
            ____L1_say_1007(
                __L1,
                if ____t_994(____opt_result_993) then __O[1804] else __L1:visitTalk(id),
                function()
                    if __t(if __t(first) then not __t(__L1.q.rayssaVisit) else first) then
                        __L1.q.rayssaVisit = true
                        __L1:awardXP(90, "side-rayssa-visit")
                    end
                    local ____t_998 = __t
                    local ____opt_result_997
                    if quest ~= nil then
                        ____opt_result_997 = quest.action
                    end
                    if ____t_998(____opt_result_997) then
                        local result = window.BivoltQuest:complete(__L1.q, quest.action, __L1.items)
                        local ____t_1002 = __t
                        local ____opt_result_1001
                        if result ~= nil then
                            ____opt_result_1001 = result.xp
                        end
                        if ____t_1002(____opt_result_1001) then
                            __L1:awardXP(result.xp, if __t(result.source) then result.source else "side-bivolt-unlock")
                        end
                        local ____t_1006 = __t
                        local ____opt_result_1005
                        if result ~= nil then
                            ____opt_result_1005 = result.message
                        end
                        if ____t_1006(____opt_result_1005) then
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
        local ____t_1013 = __t
        local ____opt_1010 = window.FavelaCasas
        if ____opt_1010 ~= nil then
            ____opt_1010 = ____opt_1010.ehCasa
        end
        local ____opt_result_1012
        if ____opt_1010 ~= nil then
            ____opt_result_1012 = ____opt_1010(____opt_1010, id)
        end
        if ____t_1013(____opt_result_1012) then
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
        local ____t_1019 = __t
        local ____opt_1016 = window.LugaresC1
        if ____opt_1016 ~= nil then
            ____opt_1016 = ____opt_1016.ehNpc
        end
        local ____opt_result_1018
        if ____opt_1016 ~= nil then
            ____opt_result_1018 = ____opt_1016(____opt_1016, id)
        end
        if ____t_1019(____opt_result_1018) then
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
                                local ____set_1023 = __set
                                local ____L1_items_1022 = __L1.items
                                local ____t_1021 = __t
                                local ____get_result_1020 = __get(__L1.items, key)
                                __O[1805] = ____get_result_1020
                                ____set_1023(
                                    ____L1_items_1022,
                                    key,
                                    math.min(999, if ____t_1021(____get_result_1020) then __O[1805] else 0 + 1)
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
                    local ____t_1026 = __t
                    local ____opt_1024 = window.BaileConcurso
                    if ____opt_1024 ~= nil then
                        ____opt_1024 = ____opt_1024.abrir
                    end
                    if not ____t_1026(____opt_1024) then
                        return
                    end
                    __L1:releaseInputs()
                    window.BaileConcurso:abrir({onFim = function(____, ok, nota, desistiu)
                        __L1:releaseInputs()
                        if __t(if __t(ok) then not __t(__L1.q.daJegue) else ok) then
                            __L1.q.daJegue = true
                            local ____opt_1029 = window.DarocaLook
                            if ____opt_1029 ~= nil then
                                ____opt_1029 = ____opt_1029.ganhar
                            end
                            if ____opt_1029 ~= nil then
                                ____opt_1029(____opt_1029, "dajegue")
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
        local ____t_1036 = __t
        local ____opt_1033 = window.MissaoFarda
        if ____opt_1033 ~= nil then
            ____opt_1033 = ____opt_1033.ehNpc
        end
        local ____opt_result_1035
        if ____opt_1033 ~= nil then
            ____opt_result_1035 = ____opt_1033(____opt_1033, id)
        end
        if ____t_1036(____opt_result_1035) then
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
            local wardrobeLine = if __t(gift) then "Amanda mandou recado! Vitor guardou o Jaglion pra você. Prova ele no espelho, rei da selva." else if __t(__L1.q.jaglionClaimed) then "Teu Jaglion tá no espelho junto dos chapéus. Hoje vai de juba ou de palha?" else "O Jaglion ali? A Amanda encomendou. Ela vive na entrada da Praça Camacan. Os outros visuais são da casa."
            __L1:say(
                __arrL({
                    {name = n.name, text = if __t(first) then "Chegou na Bigodon! Aqui o degradê é na régua e a resenha é sem limite. Senta aí, Da Roça!" else "Olha quem voltou! O único cliente que usa gás de fixador. Aqui a resenha recupera até a energia."},
                    {name = "Da Roça", text = "Só alinha o chapéu. Se cortar meu cabelo, vou perder a aerodinâmica do peido."},
                    {name = n.name, text = "Relaxa! Meu corte é tão alinhado que até o carro do seu pai sai daqui fazendo curva certinha."},
                    {name = "Vitor · ajudante", text = "Davi, a tesoura! Você está penteando o vento de novo."},
                    {name = n.name, text = "É o acabamento premium, pô! Pronto: vida cheia, gás no tanque e autoestima na régua."},
                    {name = n.name, text = wardrobeLine, actionLabel = if __t(gift) then "Receber o Jaglion" else "Abrir o espelho"}
                }, 6),
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
                    __L1:toast(if __t(gift) then "Jaglion recebido na Bigodon!" else "Resenha na Bigodon: vida e gás recuperados!")
                    local ____opt_1039 = window.DarocaLook
                    if ____opt_1039 ~= nil then
                        ____opt_1039 = ____opt_1039.open
                    end
                    if ____opt_1039 ~= nil then
                        ____opt_1039(____opt_1039, {line = if __t(gift) then "Davi: A juba é do Vitor, a ideia é da Amanda. O rugido é contigo!" else "Davi: Senta na cadeira e escolhe. Aqui o visual é por conta da casa!"})
                    end
                end
            )
            return
        end
        if id == "vitor" then
            local first = not __t(__L1.q.vitor)
            __L1:say(
                __arrL({
                    {name = n.name, text = if __t(first) then "Eu sou Vitor, ajudante da Bigodon. Organizo as máquinas, os horários e as histórias do Davi." else "A máquina tá carregada e a agenda tá cheia. Só a resenha que não tem horário pra acabar."},
                    {name = "Da Roça", text = "E qual é a história de hoje?"},
                    {name = n.name, text = "Nicolas tá na Praça Camacan dizendo que nasceu protagonista. A trilha sonora só toca na cabeça dele."},
                    {name = n.name, text = "E na favela tem Freddy, o mais forte do Reeis. Ele tira onda do chefe: “Ô REEEIS, tá se achando rei?”"},
                    {name = "Da Roça", text = "Um corte de cabelo e duas fofocas. Melhor parada do carro do meu pai!"}
                }, 5),
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
            local ____t_1043 = __t
            local ____opt_1041 = window.BaileConcurso
            if ____opt_1041 ~= nil then
                ____opt_1041 = ____opt_1041.abrir
            end
            if not ____t_1043(____opt_1041) then
                __L1:say(__L1:visitTalk(id))
                return
            end
            local N = n.name
            local ja = not not __t(__L1.q.rimaFreddy)
            __L1:say(
                __arrL({{name = N, text = if __t(ja) then "Tu me venceu no soco e na rima. Quer mais uma rodada pra galera ver?" else "Perdi no braço, mas no microfone ninguém me cala! Batalha de rima, chapéu. Aqui no morro."}, {name = N, text = "Eu mando um verso, tu responde no compasso. A galera decide pela nota. Setinha na linha, rima na ponta da língua!"}, {name = "Da Roça", text = "Pode vir, Freddy. Rima de roça tem raiz!", actionLabel = "Batalha de rima"}}, 3),
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
                                    if __t(first) then " +200 XP" else ""
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
                __arrL({{name = n.name, text = if __t(__L1.q.mota) then "Bora repetir? O gol nunca fecha e treino dá XP. Mira, escolhe a força e chuta!" else "Sou Gabriel Mota, profissional da resenha e do futebol da escola. Faz 3 gols em 5 chutes pra aprender o dash!"}, "Vale gol de peido?", {name = n.name, text = "Hoje só vale bola! Aperta E ou CHUTAR pra travar a mira, de novo pra força. O goleiro se mexe: capricha!"}}, 3),
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
                __L1:say(__arrL({{name = n.name, text = if __t(__L1.q.lucas) then if __t(__L1.q.nikolas) then "O bolo voltou! A receita é chocolate e amizade. Sapo é só meu apelido!" else "O carro está pronto. Mota ensina o dash no campo; os professores têm missões na escola." else ("Já achou " .. tostring(__len(__L1.q.carParts))) .. "/3 peças. Procura nas plataformas da roça, inclusive lá no fim!"}}, 1))
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
        local ____opt_1046 = window.CampaignVfx
        if ____opt_1046 ~= nil then
            ____opt_1046 = ____opt_1046.reset
        end
        if ____opt_1046 ~= nil then
            ____opt_1046(____opt_1046)
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
        local data = if __t(continuing) then __L1:load() else nil
        if __t(data) then
            local ____opt_1062 = window.CampaignRun
            if ____opt_1062 ~= nil then
                ____opt_1062 = ____opt_1062.restore
            end
            if ____opt_1062 ~= nil then
                local ____data_run_1060 = data.run
                local ____t_1054 = __t
                local ____opt_1051 = window.Difficulty
                if ____opt_1051 ~= nil then
                    ____opt_1051 = ____opt_1051.getMode
                end
                local ____opt_result_1053
                if ____opt_1051 ~= nil then
                    ____opt_result_1053 = ____opt_1051(____opt_1051)
                end
                __O[1806] = ____opt_result_1053
                local ____temp_1058 = if ____t_1054(____opt_result_1053) then __O[1806] else "normal"
                local ____temp_1059 = not __t(data.run)
                local ____t_1057 = __t
                local ____opt_1055 = data.q
                if ____opt_1055 ~= nil then
                    ____opt_1055 = ____opt_1055.nikolas
                end
                ____opt_1062(
                    ____opt_1062,
                    ____data_run_1060,
                    {
                        mode = ____temp_1058,
                        legacy = ____temp_1059,
                        completed = not not ____t_1057(____opt_1055)
                    }
                )
            end
        else
            local ____opt_1066 = window.CampaignRun
            if ____opt_1066 ~= nil then
                ____opt_1066 = ____opt_1066.start
            end
            if ____opt_1066 ~= nil then
                ____opt_1066(____opt_1066)
            end
        end
        __L1.q = if __t(data) then __assign(
            {},
            __L1:emptyQuest(),
            data.q
        ) else __L1:emptyQuest()
        __L1.q.carParts = if __isArray(__L1.q.carParts) then __L1.q.carParts else __arrL({}, 0)
        __L1.q.notebooks = if __isArray(__L1.q.notebooks) then __L1.q.notebooks else __arrL({}, 0)
        __L1.q.bivoltParts = if __isArray(__L1.q.bivoltParts) then __L1.q.bivoltParts else __arrL({}, 0)
        local ____L1_q_1071 = __L1.q
        local ____L1_clamp_1070 = __L1.clamp
        local ____t_1069 = __t
        local ____TS__Number_result_1068 = __TS__Number(__L1.q.bivoltCharges)
        __O[1807] = ____TS__Number_result_1068
        ____L1_q_1071.bivoltCharges = ____L1_clamp_1070(
            __L1,
            math.floor(if ____t_1069(____TS__Number_result_1068) then __O[1807] else 0),
            0,
            9
        )
        local ____L1_q_1075 = __L1.q
        local ____t_1074 = __t
        local ____t_1073 = __t
        local ____temp_1072 = if __t(__L1.q.npcVisits) then type(__L1.q.npcVisits) == "table" else __L1.q.npcVisits
        __O[1808] = ____temp_1072
        ____L1_q_1075.npcVisits = if ____t_1074(if ____t_1073(____temp_1072) then not __isArray(__L1.q.npcVisits) else __O[1808]) then __assign({}, __L1.q.npcVisits) else {}
        for ____, id in __iterar((__keys(__L1.q.npcVisits))) do
            local count = __TS__Number(__get(__L1.q.npcVisits, id))
            __set(__L1.q.npcVisits, id, if __isFiniteN(count) then __L1:clamp(
                math.floor(count),
                0,
                1000000
            ) else 0)
        end
        local ____opt_1081 = window.Progression
        if ____opt_1081 ~= nil then
            ____opt_1081 = ____opt_1081.restore
        end
        if ____opt_1081 ~= nil then
            local ____opt_result_1079
            if data ~= nil then
                ____opt_result_1079 = data.progression
            end
            ____opt_1081(____opt_1081, ____opt_result_1079)
        end
        local ____isArray_1086 = __isArray
        local ____opt_result_1085
        if data ~= nil then
            ____opt_result_1085 = data.seenBossIntros
        end
        __L1.seenBossIntros = if ____isArray_1086(____opt_result_1085) then data.seenBossIntros else __arrL({}, 0)
        __L1.items = {pencil = 0, eraser = 0, clip = 0}
        local ____t_1090 = __t
        local ____opt_result_1089
        if data ~= nil then
            ____opt_result_1089 = data.items
        end
        if ____t_1090(____opt_result_1089) then
            for ____, k in __iterar((__keys(__L1.items))) do
                local ____set_1095 = __set
                local ____L1_items_1094 = __L1.items
                local ____L1_clamp_1093 = __L1.clamp
                local ____t_1092 = __t
                local ____TS__Number_result_1091 = __TS__Number(__get(data.items, k))
                __O[1809] = ____TS__Number_result_1091
                ____set_1095(
                    ____L1_items_1094,
                    k,
                    ____L1_clamp_1093(
                        __L1,
                        math.floor(if ____t_1092(____TS__Number_result_1091) then __O[1809] else 0),
                        0,
                        999
                    )
                )
            end
        end
        local ____isArray_1099 = __isArray
        local ____opt_result_1098
        if data ~= nil then
            ____opt_result_1098 = data.collected
        end
        __L1.collected = if ____isArray_1099(____opt_result_1098) then __call(
            data.collected,
            "filter",
            function(____, x) return type(x) == "string" end
        ) else __arrL({}, 0)
        local ____isArray_1103 = __isArray
        local ____opt_result_1102
        if data ~= nil then
            ____opt_result_1102 = data.minionKills
        end
        __L1.minionKills = if ____isArray_1103(____opt_result_1102) then __call(
            data.minionKills,
            "filter",
            function(____, x) return type(x) == "string" end
        ) else __arrL({}, 0)
        local ____L1_clamp_1109 = __L1.clamp
        local ____t_1108 = __t
        local ____opt_result_1106
        if data ~= nil then
            ____opt_result_1106 = data.weapon
        end
        local ____TS__Number_result_1107 = __TS__Number(____opt_result_1106)
        __O[1810] = ____TS__Number_result_1107
        __L1.weapon = ____L1_clamp_1109(
            __L1,
            math.floor(if ____t_1108(____TS__Number_result_1107) then __O[1810] else 0),
            0,
            2
        )
        __L1.player = __L1:basePlayer()
        local ____t_1115 = __t
        local ____opt_1112 = window.LugaresC1
        if ____opt_1112 ~= nil then
            ____opt_1112 = ____opt_1112.tem
        end
        local ____opt_result_1114
        if ____opt_1112 ~= nil then
            ____opt_result_1114 = ____opt_1112(
                ____opt_1112,
                __TS__Number(data.scene)
            )
        end
        __L1.scene = if __t(data) then if ____t_1115(____opt_result_1114) then __TS__Number(data.scene) else __L1:clamp(
            data.scene,
            0,
            __len(__L1.scenes) - 1
        ) else 0
        if __t(__L1.scene == 3 and not __t(__L1.q.trained)) then
            __L1.scene = 2
        end
        __L1.player.hp = if __t(data) then math.min(
            __L1:bonus().maxHP,
            math.max(55, if __t(data.hp) then data.hp else 100)
        ) else __L1:bonus().maxHP
        __L1.player.papers = if __t(data) then math.max(15, if __t(data.papers) then data.papers else 30) else 30
        __L1.vehicle = false
        __L1.camera = 0
        __L1.reeisCooldown = 0
        __L1.reeisTimer = 0
        __L1.attackCooldown = 0
        __L1.fartCooldown = 0
        __L1.killCount = 0
        __L1:populate()
        local ____opt_result_1120
        if data ~= nil then
            ____opt_result_1120 = data.position
        end
        local ____opt_result_1121
        if ____opt_result_1120 ~= nil then
            ____opt_result_1121 = ____opt_result_1120.scene
        end
        if ____opt_result_1121 == __L1.scene then
            local savedX = __TS__Number(data.position.x)
            local px = __L1:clamp(if __isFiniteN(savedX) then savedX else 230, 30, __L1.WORLD - 30)
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
        elseif __t(if __t(__L1.q.nikolas) then not __t(__L1.q.celebrationSeen) else __L1.q.nikolas) then
            __L1:beginCelebration()
        else
            local ____t_1124 = __t
            local ____t_1123 = __t
            local ____temp_1122 = not __t(__L1.q.jorgeSeen)
            __O[1811] = ____temp_1122
            if ____t_1124(if __t(__L1.q.nikolas) then if ____t_1123(____temp_1122) then __O[1811] else __L1.q.jorgeStarted else __L1.q.nikolas) then
                __L1:beginPostCelebration()
            else
                __L1:toast("Aventura retomada! Seu objetivo está no painel.")
            end
        end
    end
    __L1.returnToMenu = function(self)
        if __t(__L1.sandbox) then
            __L1:exitSandbox()
        end
        local ____opt_1127 = window.CampaignRun
        if ____opt_1127 ~= nil then
            ____opt_1127 = ____opt_1127.setActive
        end
        if ____opt_1127 ~= nil then
            ____opt_1127(____opt_1127, false)
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
        local ____opt_1131 = window.CampaignVfx
        if ____opt_1131 ~= nil then
            ____opt_1131 = ____opt_1131.reset
        end
        if ____opt_1131 ~= nil then
            ____opt_1131(____opt_1131)
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
        local ____opt_1135 = window.CampaignRun
        if ____opt_1135 ~= nil then
            ____opt_1135 = ____opt_1135.setActive
        end
        if ____opt_1135 ~= nil then
            ____opt_1135(____opt_1135, false)
        end
        __L1:releaseInputs()
        local ____t_1143 = __t
        local ____t_1142 = __t
        local ____t_1140 = __t
        local ____t_1138 = __t
        local ____temp_1137 = not __t(__L1.started)
        __O[1812] = ____temp_1137
        local ____temp_1139 = if ____t_1138(____temp_1137) then __O[1812] else __L1.won
        __O[1813] = ____temp_1139
        local ____temp_1141 = if ____t_1140(____temp_1139) then __O[1813] else __L1.defeated
        __O[1814] = ____temp_1141
        if ____t_1143(if ____t_1142(____temp_1141) then __O[1814] else __L1.chapterEnded) then
            return
        end
        __L1.paused = true
        __L1:show("pauseScreen", true)
        __L1:updateUI()
        __L1:save()
    end
    __L1.resume = function(self)
        __L1:releaseInputs()
        local ____t_1146 = __t
        local ____opt_1144 = __L1.sandbox
        if ____opt_1144 ~= nil then
            ____opt_1144 = ____opt_1144.result
        end
        if ____t_1146(____opt_1144) then
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
        local ____t_1152 = __t
        local ____opt_1149 = window.Arena
        if ____opt_1149 ~= nil then
            ____opt_1149 = ____opt_1149.isOpen
        end
        local ____opt_result_1151
        if ____opt_1149 ~= nil then
            ____opt_result_1151 = ____opt_1149(____opt_1149)
        end
        if ____t_1152(if __t(__L1.inputCaptured) then __L1.inputCaptured else ____opt_result_1151) then
            return
        end
        local ____t_1159 = __t
        local ____t_1158 = __t
        local ____t_1154 = __t
        local ____temp_1153 = __L1.scene >= 12
        __O[1815] = ____temp_1153
        local ____opt_1155 = window.C2Luta
        if ____opt_1155 ~= nil then
            ____opt_1155 = ____opt_1155.skin
        end
        local ____temp_1157 = if ____t_1154(____temp_1153) then __O[1815] else ____opt_1155
        __O[1816] = ____temp_1157
        if ____t_1159(if ____t_1158(____temp_1157) then window.CampanhaPoderes else __O[1816]) then
            if __t(__call(
                window.CampanhaPoderes:sairam(),
                "includes",
                a
            )) then
                return
            end
            if __t(a == "poder1" or a == "poder2") then
                local ____this_1161
                ____this_1161 = window.CampanhaPoderes
                local ____opt_1160 = ____this_1161.acionarNoJogo
                if ____opt_1160 ~= nil then
                    ____opt_1160(____this_1161, if a == "poder1" then 0 else 1)
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
        local ____t_1176 = __t
        local ____t_1175 = __t
        local ____t_1173 = __t
        local ____t_1171 = __t
        local ____t_1169 = __t
        local ____t_1167 = __t
        local ____t_1165 = __t
        local ____t_1163 = __t
        local ____temp_1162 = not __t(__L1.started)
        __O[1817] = ____temp_1162
        local ____temp_1164 = if ____t_1163(____temp_1162) then __O[1817] else __L1.paused
        __O[1818] = ____temp_1164
        local ____temp_1166 = if ____t_1165(____temp_1164) then __O[1818] else __L1.dialog
        __O[1819] = ____temp_1166
        local ____temp_1168 = if ____t_1167(____temp_1166) then __O[1819] else __L1.won
        __O[1820] = ____temp_1168
        local ____temp_1170 = if ____t_1169(____temp_1168) then __O[1820] else __L1.defeated
        __O[1821] = ____temp_1170
        local ____temp_1172 = if ____t_1171(____temp_1170) then __O[1821] else __L1.room
        __O[1822] = ____temp_1172
        local ____temp_1174 = if ____t_1173(____temp_1172) then __O[1822] else __L1.cutscene
        __O[1823] = ____temp_1174
        if ____t_1176(if ____t_1175(____temp_1174) then __O[1823] else __L1.routeTransition) then
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
        local ____t_1179 = __t
        local ____opt_1177 = __L1.training
        if ____opt_1177 ~= nil then
            ____opt_1177 = ____opt_1177.active
        end
        if ____t_1179(____opt_1177) then
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
        local ____t_1200 = __t
        local ____t_1199 = __t
        local ____t_1197 = __t
        local ____t_1195 = __t
        local ____t_1193 = __t
        local ____t_1191 = __t
        local ____t_1189 = __t
        local ____t_1185 = __t
        local ____t_1183 = __t
        local ____t_1181 = __t
        local ____temp_1180 = not __t(__L1.started)
        __O[1824] = ____temp_1180
        local ____temp_1182 = if ____t_1181(____temp_1180) then __O[1824] else __L1.paused
        __O[1825] = ____temp_1182
        local ____temp_1184 = if ____t_1183(____temp_1182) then __O[1825] else __L1.dialog
        __O[1826] = ____temp_1184
        local ____opt_1186 = __L1.training
        if ____opt_1186 ~= nil then
            ____opt_1186 = ____opt_1186.active
        end
        local ____temp_1188 = if ____t_1185(____temp_1184) then __O[1826] else ____opt_1186
        __O[1827] = ____temp_1188
        local ____temp_1190 = if ____t_1189(____temp_1188) then __O[1827] else __L1.activity
        __O[1828] = ____temp_1190
        local ____temp_1192 = if ____t_1191(____temp_1190) then __O[1828] else __L1.won
        __O[1829] = ____temp_1192
        local ____temp_1194 = if ____t_1193(____temp_1192) then __O[1829] else __L1.defeated
        __O[1830] = ____temp_1194
        local ____temp_1196 = if ____t_1195(____temp_1194) then __O[1830] else __L1.room
        __O[1831] = ____temp_1196
        local ____temp_1198 = if ____t_1197(____temp_1196) then __O[1831] else __L1.cutscene
        __O[1832] = ____temp_1198
        if ____t_1200(if ____t_1199(____temp_1198) then __O[1832] else __L1.routeTransition) then
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
        local cost = if __L1.weapon == 0 then 3 else 5
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
                        text = (((((((tostring(__L1.kauaVoice) .. " Inventário: ") .. tostring(__L1:materialCount())) .. " materiais. Vou trocar ") .. tostring(cost)) .. " por ") .. tostring(__get(__L1.weaponNames, next))) .. ". ") .. if next == 1 then "Suas bolinhas de papel ganham um lançamento bem mais forte!" else "Cada disparo lança três projéteis de fantasia!"
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
        local ____t_1221 = __t
        local ____t_1220 = __t
        local ____t_1218 = __t
        local ____t_1216 = __t
        local ____t_1214 = __t
        local ____t_1212 = __t
        local ____t_1210 = __t
        local ____t_1206 = __t
        local ____t_1204 = __t
        local ____t_1202 = __t
        local ____temp_1201 = not __t(__L1.started)
        __O[1833] = ____temp_1201
        local ____temp_1203 = if ____t_1202(____temp_1201) then __O[1833] else __L1.paused
        __O[1834] = ____temp_1203
        local ____temp_1205 = if ____t_1204(____temp_1203) then __O[1834] else __L1.dialog
        __O[1835] = ____temp_1205
        local ____opt_1207 = __L1.training
        if ____opt_1207 ~= nil then
            ____opt_1207 = ____opt_1207.active
        end
        local ____temp_1209 = if ____t_1206(____temp_1205) then __O[1835] else ____opt_1207
        __O[1836] = ____temp_1209
        local ____temp_1211 = if ____t_1210(____temp_1209) then __O[1836] else __L1.activity
        __O[1837] = ____temp_1211
        local ____temp_1213 = if ____t_1212(____temp_1211) then __O[1837] else __L1.won
        __O[1838] = ____temp_1213
        local ____temp_1215 = if ____t_1214(____temp_1213) then __O[1838] else __L1.defeated
        __O[1839] = ____temp_1215
        local ____temp_1217 = if ____t_1216(____temp_1215) then __O[1839] else __L1.room
        __O[1840] = ____temp_1217
        local ____temp_1219 = if ____t_1218(____temp_1217) then __O[1840] else __L1.cutscene
        __O[1841] = ____temp_1219
        if ____t_1221(if ____t_1220(____temp_1219) then __O[1841] else __L1.routeTransition) then
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
                local ____t_1223 = __t
                local ____temp_1222 = e.type == "nikolas" and __gt(e.hp, 0)
                __O[1842] = ____temp_1222
                return if ____t_1223(____temp_1222) then math.abs(e.x - __L1.player.x) < 560 else __O[1842]
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
        local ____t_1226 = __t
        local ____opt_1224 = window.Activities
        if ____opt_1224 ~= nil then
            ____opt_1224 = ____opt_1224.create
        end
        if not ____t_1226(____opt_1224) then
            __L1:toast("Minigame indisponível. Recarregue a atualização.")
            return false
        end
        if __t(kind == "football" and __L1.scene ~= 7) then
            return false
        end
        local ____t_1230 = __t
        local ____temp_1229 = kind == "quiz"
        if ____temp_1229 then
            local ____opt_1227 = __L1.room
            if ____opt_1227 ~= nil then
                ____opt_1227 = ____opt_1227.id
            end
            ____temp_1229 = ____opt_1227 ~= "miqueias"
        end
        if ____t_1230(____temp_1229) then
            return false
        end
        local ____t_1233 = __t
        local ____t_1232 = __t
        local ____temp_1231 = kind == "dinner"
        __O[1843] = ____temp_1231
        if ____t_1233(if ____t_1232(____temp_1231) then __L1.scene ~= __L1.npcInfo.amanda.scene or __getq(
            __L1:closestNPC(),
            0
        ) ~= "amanda" else __O[1843]) then
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
        local ____t_1240 = __t
        local ____t_1239 = __t
        local ____t_1237 = __t
        local ____t_1235 = __t
        local ____temp_1234 = not __t(__L1.activity)
        __O[1844] = ____temp_1234
        local ____temp_1236 = if ____t_1235(____temp_1234) then __O[1844] else __L1.paused
        __O[1845] = ____temp_1236
        local ____temp_1238 = if ____t_1237(____temp_1236) then __O[1845] else __L1.dialog
        __O[1846] = ____temp_1238
        if ____t_1240(if ____t_1239(____temp_1238) then __O[1846] else __L1.cutscene) then
            return false
        end
        local result = window.Activities:submit(__L1.activity, value)
        local ____t_1243 = __t
        local ____opt_1241 = __L1.activity
        if ____opt_1241 ~= nil then
            ____opt_1241 = ____opt_1241.done
        end
        if ____t_1243(____opt_1241) then
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
            if __t(if __t(result.success) then not __t(__L1.q.amandaDating) else result.success) then
                __L1.q.amandaDating = true
                __L1:awardXP(window.Campaign.rewards.amanda, "quest-amanda")
                __L1:save()
                __L1:say(__arrL({"Quero, uai! Agora eu tenho dois motivos pra dividir a sobremesa.", {name = "Amanda", text = "Um é sua namorada. O outro é o tamanho do seu olho, né?"}, {name = "Amanda", text = "Passa na Bigodon. O Davi guardou o Jaglion que eu e o Vitor desenhamos pra você."}}, 3))
            else
                __L1:toast(if __t(__L1.q.amandaDating) then "De volta à praça com Amanda." else "O convite continua de pé. Fale com Amanda para tentar outra vez.")
            end
            __L1:updateUI()
            return
        end
        if __t(result.success) then
            if kind == "football" then
                local first = not __t(__L1.q.mota)
                __L1.q.mota = true
                __L1:awardXP(if __t(first) then 300 else 70, if __t(first) then "quest-mota" else nil)
                __L1:say(
                    __arrL({{name = "Mota", text = if __t(first) then "GOOOL! Três gols! Agora o dash é seu: L, Shift ou o botão » pra escapar dos golpes." else "Gol de quem treina! XP ganho. Pode repetir sempre que quiser evoluir."}, "O bolo vai receber um passe de respeito!"}, 2),
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
            __L1:toast(if kind == "football" then "Quase! Converse com Mota para tentar os chutes de novo." else "Tente novamente com o professor.")
        end
        __L1:updateUI()
        __L1:save()
    end
    __L1.cancelActivity = function(self)
        if not __t(__L1.activity) then
            return false
        end
        local ____opt_1246 = window.Activities
        if ____opt_1246 ~= nil then
            ____opt_1246 = ____opt_1246.cancel
        end
        if ____opt_1246 ~= nil then
            ____opt_1246(____opt_1246, __L1.activity)
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
        local ____t_1250 = __t
        local ____opt_1248 = __L1.training
        if ____opt_1248 ~= nil then
            ____opt_1248 = ____opt_1248.active
        end
        if not ____t_1250(____opt_1248) then
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
        local ____L1_training_1251, ____marker_1252 = __L1.training, "marker"
        ____L1_training_1251[____marker_1252] = ____L1_training_1251[____marker_1252] + __L1.training.direction * __L1.training.speed * dt
        if __gt(__L1.training.marker, 1) then
            __L1.training.marker = 2 - __L1.training.marker
            __L1.training.direction = -1
        elseif __lt(__L1.training.marker, 0) then
            __L1.training.marker = __TS__Number(-__L1.training.marker)
            __L1.training.direction = 1
        end
    end
    __L1.submitTraining = function(self)
        local ____t_1262 = __t
        local ____t_1261 = __t
        local ____t_1259 = __t
        local ____t_1257 = __t
        local ____t_1255 = __t
        local ____opt_1253 = __L1.training
        if ____opt_1253 ~= nil then
            ____opt_1253 = ____opt_1253.active
        end
        local ____temp_1256 = not ____t_1255(____opt_1253)
        __O[1847] = ____temp_1256
        local ____temp_1258 = if ____t_1257(____temp_1256) then __O[1847] else __L1.paused
        __O[1848] = ____temp_1258
        local ____temp_1260 = if ____t_1259(____temp_1258) then __O[1848] else __L1.dialog
        __O[1849] = ____temp_1260
        if ____t_1262(if ____t_1261(____temp_1260) then __O[1849] else __gt(__L1.training.cooldown, 0)) then
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
            t.score = t.score + (if __t(perfect) then 150 else 100 + math.min(5, t.combo) * 20)
            t.feedback = if __t(perfect) then "PERFEITO! REFLEXO DE CAMPEÃO!" else "BOA! MANDOU BEM!"
            t.feedbackGood = true
            __L1:beep(if __t(perfect) then 930 else 720, 0.12, "triangle")
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
        local dt = __L1.time - if __t(t.golpeEm) then t.golpeEm else -9
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
                    if __t(__mod(k, 2)) then "#9aa0a6" else "#6a7078"
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
                    if __t(on) then "#c9dd87" else "#2e4232"
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
            if __t(t.feedbackGood) then "#d8ecae" else "#f0b6a0"
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
        if __t(if __t(window.PixelKit) then __L1:drawTrainingPixel() else window.PixelKit) then
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
                __L1.ctx.fillStyle = if __lt(i, t.totalHits) then "#c9dd87" else "#526b50"
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
            if __t(t.feedbackGood) then "#d8ecae" else "#f0b6a0"
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
        __L1.attackCooldown = if __L1.weapon == 2 then 0.31 else 0.23
        local ____L1_player_1263, ____papers_1264 = __L1.player, "papers"
        ____L1_player_1263[____papers_1264] = ____L1_player_1263[____papers_1264] - 1
        __L1.shake = math.max(__L1.shake, 1.2)
        __L1.player.attack = 0.24
        __L1.player.attackType = "paper"
        __L1.player.attackDuration = 0.24
        local tier = if __t(__L1.q.miqueias) then math.max(
            1,
            __L1:bonus().projectileTier
        ) else 0
        local element = if tier >= 2 then "electric" else if tier == 1 then "fire" else nil
        local damage = math.floor((if __t(__L1.q.trained) then 28 else 18 + if __L1.weapon == 1 then 14 else if __L1.weapon == 2 then 22 else 0) * __L1:bonus().damageMultiplier + 0.5)
        local ____t_1270 = __t
        local ____opt_1267 = __L1.activeBoss
        if ____opt_1267 ~= nil then
            ____opt_1267 = ____opt_1267.conquista
        end
        local ____opt_result_1269
        if ____opt_1267 ~= nil then
            ____opt_result_1269 = ____opt_1267.estrada
        end
        local aimTarget = if ____t_1270(____opt_result_1269) then window.PerseguicaoMoto:alvo(__L1.activeBoss.conquista, __L1.player, __L1.activeBoss) else if __t(__L1.activeBoss) then __L1.activeBoss else if not __t(__L1.room) then __get(
            __call(
                __call(
                    __L1.minions,
                    "filter",
                    function(____, m)
                        local ____t_1272 = __t
                        local ____temp_1271 = not __t(m.dead) and __TS__MathSign(m.x - __L1.player.x) == __L1.player.facing
                        __O[1850] = ____temp_1271
                        return if ____t_1272(____temp_1271) then math.abs(m.x - __L1.player.x) < 650 else __O[1850]
                    end
                ),
                "sort",
                function(____, a, b) return math.abs(a.x - __L1.player.x) - math.abs(b.x - __L1.player.x) end
            ),
            0
        ) else nil
        local ____L1_clamp_1276 = __L1.clamp
        local ____aimTarget_y_1275 = aimTarget.y
        local ____opt_1273 = aimTarget.conquista
        if ____opt_1273 ~= nil then
            ____opt_1273 = ____opt_1273.slug
        end
        local aim = if __t(if __t(aimTarget) then __TS__MathSign(aimTarget.x - __L1.player.x) == __L1.player.facing else aimTarget) then ____L1_clamp_1276(
            __L1,
            math.atan2(
                ____aimTarget_y_1275 - if __t(aimTarget.alto) then aimTarget.alto / 2 else if ____opt_1273 == "jorge" then window.JorgeDuelo:corpo(aimTarget.conquista).altura / 2 else if aimTarget.type == "igor" then 45 * __L1:igorScale(aimTarget) else if aimTarget.type == "giant" then 85 else if __t(aimTarget.type == "nikolas" and __ge(aimTarget.phase, 2)) then __L1:nikolasBounds(aimTarget).centerY else 30 - (__L1.player.y - 32),
                math.abs(aimTarget.x - __L1.player.x)
            ),
            -0.85,
            0.85
        ) else 0
        for ____, spread in __iterar((if __L1.weapon == 2 then __arrL({-0.11, 0, 0.11}, 3) else __arrL({0}, 1))) do
            __call(
                __L1.shots,
                "push",
                {
                    x = __L1.player.x + __L1.player.facing * 28,
                    y = __L1.player.y - 32,
                    vx = __L1.player.facing * math.cos(aim + spread) * if __t(__L1.weapon) then 680 else 600,
                    vy = math.sin(aim + spread) * if __t(__L1.weapon) then 680 else 600,
                    life = 1.5,
                    type = if __t(element) then "papaia" else if __L1.weapon == 2 then "case" else if __L1.weapon == 1 then "ruler" else "paper",
                    element = element,
                    owner = "player",
                    damage = damage
                }
            )
        end
        local ____opt_1279 = window.CampaignVfx
        if ____opt_1279 ~= nil then
            ____opt_1279 = ____opt_1279.emit
        end
        if ____opt_1279 ~= nil then
            ____opt_1279(____opt_1279, "cast", {x = __L1.player.x + __L1.player.facing * 26, y = __L1.player.y - 32, dir = __L1.player.facing, element = element})
        end
        __L1:fx(
            __L1.player.x + __L1.player.facing * 30,
            __L1.player.y - 32,
            if element == "electric" then "#a7e6f1" else if __t(element) then "#f7b76c" else "#f8f3da",
            4,
            35
        )
        __L1:beep(if __t(element) then 570 else 760, 0.045)
        __L1:updateUI()
    end
    __L1.fartAttack = function(self)
        if __L1.fartCooldown > 0 then
            return
        end
        local chain = if __t(__L1.q.almiro) then __L1.comboWindow > 0 else __L1.q.almiro
        __L1.comboStep = if __t(chain) then math.min(3, __L1.comboStep + 1) else 1
        local cost = if __L1.comboStep == 3 then 20 else if __L1.comboStep == 2 then 17 else 20
        if __lt(__L1.player.gas, cost) then
            __L1:toast("Seu gás precisa recarregar. Espere no chão!")
            return
        end
        local ____L1_player_1281, ____gas_1282 = __L1.player, "gas"
        ____L1_player_1281[____gas_1282] = ____L1_player_1281[____gas_1282] - cost
        __L1.fartCooldown = if __t(__L1.q.almiro) then if __L1.comboStep == 3 then 1.5 else 0.24 else 0.9
        __L1.comboWindow = if __t(if __t(__L1.q.almiro) then __L1.comboStep < 3 else __L1.q.almiro) then 0.85 else 0
        __L1.player.attack = 0.36
        __L1.player.attackType = "fart"
        __L1.player.attackDuration = 0.36
        __L1.shake = if __L1.comboStep == 3 then 9 else 4
        __L1:beep(80 - __L1.comboStep * 8, 0.2, "sawtooth", 0.045)
        local radius = if __L1.comboStep == 3 then 165 else if __L1.comboStep == 2 then 130 else 100
        local ____opt_1285 = window.Golpes
        if ____opt_1285 ~= nil then
            ____opt_1285 = ____opt_1285.areaGas
        end
        local ____opt_result_1287
        if ____opt_1285 ~= nil then
            ____opt_result_1287 = ____opt_1285(____opt_1285, __L1.player.x, __L1.player.y, radius)
        end
        local areaG = ____opt_result_1287
        local ____opt_1290 = window.Golpes
        if ____opt_1290 ~= nil then
            ____opt_1290 = ____opt_1290.gas
        end
        if ____opt_1290 ~= nil then
            ____opt_1290(
                ____opt_1290,
                __L1.player.x,
                __L1.player.y,
                radius,
                __L1.comboStep,
                __L1.player.facing
            )
        end
        local ____opt_1294 = window.CampaignVfx
        if ____opt_1294 ~= nil then
            ____opt_1294 = ____opt_1294.emit
        end
        if ____opt_1294 ~= nil then
            ____opt_1294(____opt_1294, "gas", {
                x = __L1.player.x + __L1.player.facing * 9,
                y = __L1.player.y - 23,
                dir = __L1.player.facing,
                stage = __L1.comboStep,
                radius = radius
            })
        end
        local ____opt_1298 = window.SceneLife
        if ____opt_1298 ~= nil then
            ____opt_1298 = ____opt_1298.gas
        end
        if ____opt_1298 ~= nil then
            ____opt_1298(
                ____opt_1298,
                __L1.player.x + __L1.player.facing * 9,
                __L1.player.y - 23,
                __L1.player.facing,
                __L1.comboStep
            )
        end
        local damage = math.floor(if __t(__L1.q.trained) then 55 else 34 * if __L1.comboStep == 3 then 1.8 else if __L1.comboStep == 2 then 1.25 else 1 * __L1:bonus().damageMultiplier + 0.5)
        if not __t(window.Golpes) then
            __L1:fx(
                __L1.player.x + __L1.player.facing * 38,
                __L1.player.y - 22,
                if __L1.comboStep == 3 then "#e0ef82" else "#b9df55",
                if __L1.comboStep == 3 then 52 else 25,
                radius * 0.75
            )
        end
        local ____t_1305 = __t
        local ____opt_1302 = __L1.activeBoss
        if ____opt_1302 ~= nil then
            ____opt_1302 = ____opt_1302.conquista
        end
        local ____opt_result_1304
        if ____opt_1302 ~= nil then
            ____opt_result_1304 = ____opt_1302.estrada
        end
        if ____t_1305(____opt_result_1304) then
            for ____, m in __iterar((__L1.activeBoss.conquista.estrada.motos)) do
                local r = m.rival
                local ____t_1308 = __t
                local ____t_1307 = __t
                local ____temp_1306 = __gt(r.hp, 0) and math.abs(r.x - __L1.player.x) < radius
                __O[1851] = ____temp_1306
                if ____t_1308(if ____t_1307(____temp_1306) then math.abs(r.y - __L1.player.y) < 90 else __O[1851]) then
                    r:onDano(damage)
                end
            end
        end
        for ____, e in __iterar((__L1.enemies)) do
            local ____t_1320 = __t
            local ____t_1311 = __t
            local ____t_1310 = __t
            local ____temp_1309 = if __t(areaG) then not __t(e.conquista) else areaG
            __O[1852] = ____temp_1309
            local ____opt_1312 = e.conquista
            if ____opt_1312 ~= nil then
                ____opt_1312 = ____opt_1312.slug
            end
            local ____t_1319 = __t
            local ____t_1315 = __t
            local ____temp_1314 = math.abs(e.x - __L1.player.x) < radius
            __O[1853] = ____temp_1314
            local ____opt_1316 = e.conquista
            if ____opt_1316 ~= nil then
                ____opt_1316 = ____opt_1316.gemeoX
            end
            local ____temp_1318 = if ____t_1315(____temp_1314) then __O[1853] else ____opt_1316 ~= nil and math.abs(e.conquista.gemeoX - __L1.player.x) < radius
            __O[1854] = ____temp_1318
            if ____t_1320(if ____t_1311(if ____t_1310(____temp_1309) then e.type ~= "igor" else __O[1852]) then window.Golpes:gasAcerta(
                areaG,
                window.Golpes:chefe(e)
            ) else if ____opt_1312 == "jorge" then window.JorgeDuelo:toca(
                e.conquista,
                __L1.player.x,
                __L1.player.y - 25,
                radius,
                70
            ) else if e.type == "igor" then __L1:igorContains(
                e,
                __L1.player.x,
                __L1.player.y - 25,
                radius,
                70
            ) else if __t(e.type == "nikolas" and __ge(e.phase, 2)) then __L1:nikolasContains(
                e,
                __L1.player.x,
                __L1.player.y - 25,
                radius,
                70
            ) else if ____t_1319(____temp_1318) then math.abs(e.y - __L1.player.y) < 180 else __O[1854]) then
                __L1:damageEnemy(e, damage)
            end
        end
        for ____, m in __iterar((__L1.minions)) do
            local ____t_1323 = __t
            local ____t_1322 = __t
            local ____temp_1321 = not __t(m.dead)
            __O[1855] = ____temp_1321
            if ____t_1323(if ____t_1322(____temp_1321) then if __t(areaG) then window.Golpes:gasAcerta(
                areaG,
                window.Golpes:capanga(m)
            ) else math.abs(m.x - __L1.player.x) < radius and math.abs(m.y - __L1.player.y) < 150 else __O[1855]) then
                __L1:damageMinion(m, damage)
            end
        end
        __L1.shots = __call(
            __L1.shots,
            "filter",
            function(____, a)
                local ____t_1332 = __t
                local ____t_1325 = __t
                local ____temp_1324 = a.owner == "enemy"
                __O[1857] = ____temp_1324
                local ____self_1330 = window.Golpes
                local ____self_1330_gasPega_1331 = ____self_1330.gasPega
                local ____a_x_1328 = a.x
                local ____a_y_1329 = a.y
                local ____t_1327 = __t
                local ____table_r_1326 = window.Golpes:formaTiro(a).r
                __O[1856] = ____table_r_1326
                return not ____t_1332(if ____t_1325(____temp_1324) then if __t(areaG) then ____self_1330_gasPega_1331(
                    ____self_1330,
                    areaG,
                    ____a_x_1328,
                    ____a_y_1329,
                    if ____t_1327(____table_r_1326) then __O[1856] else 10
                ) else math.abs(a.x - __L1.player.x) < radius else __O[1857])
            end
        )
        __L1:floating(__L1.player.x, __L1.player.y - 85, if __L1.comboStep == 3 then "COMBO 3! PEIDÃO SUPREMO!" else if __L1.comboStep == 2 then "COMBO 2! PÓÓÓF!" else "PÓÓÓF!", "#d8f887")
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
        __L1.reeisX = if __gt(__L1.player.facing, 0) then __L1.camera - 110 else __L1.camera + __L1.W + 110
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
                local ____opt_1335 = window.CampaignVfx
                if ____opt_1335 ~= nil then
                    ____opt_1335 = ____opt_1335.emit
                end
                if ____opt_1335 ~= nil then
                    ____opt_1335(____opt_1335, "surge", {x = __L1.reeisX, y = __L1.reeisY - 24, dir = __L1.reeisFacing})
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
                local nearest = if __t(if __t(__L1.activeBoss) then math.abs(__L1.activeBoss.x - __L1.player.x) < 740 else __L1.activeBoss) then __L1.activeBoss else if not __t(__L1.arena) then __get(
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
                ) else nil
                if __t(nearest) then
                    local x = __L1.reeisX + __L1.reeisFacing * 42
                    local y = __L1.reeisY - 58
                    local a = math.atan2(nearest.y - if nearest.type == "igor" then 45 * __L1:igorScale(nearest) else if __t(nearest.type == "nikolas" and __ge(nearest.phase, 2)) then __L1:nikolasBounds(nearest).centerY else if nearest.kind ~= nil then 22 else 32 - y, nearest.x - x)
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
        local ____t_1357 = __t
        local ____t_1356 = __t
        local ____t_1352 = __t
        local ____t_1350 = __t
        local ____t_1348 = __t
        local ____t_1346 = __t
        local ____t_1344 = __t
        local ____t_1342 = __t
        local ____t_1340 = __t
        local ____t_1338 = __t
        local ____temp_1337 = not __t(__L1.started)
        __O[1858] = ____temp_1337
        local ____temp_1339 = if ____t_1338(____temp_1337) then __O[1858] else __L1.paused
        __O[1859] = ____temp_1339
        local ____temp_1341 = if ____t_1340(____temp_1339) then __O[1859] else __L1.dialog
        __O[1860] = ____temp_1341
        local ____temp_1343 = if ____t_1342(____temp_1341) then __O[1860] else __L1.won
        __O[1861] = ____temp_1343
        local ____temp_1345 = if ____t_1344(____temp_1343) then __O[1861] else __L1.defeated
        __O[1862] = ____temp_1345
        local ____temp_1347 = if ____t_1346(____temp_1345) then __O[1862] else __L1.room
        __O[1863] = ____temp_1347
        local ____temp_1349 = if ____t_1348(____temp_1347) then __O[1863] else __L1.cutscene
        __O[1864] = ____temp_1349
        local ____temp_1351 = if ____t_1350(____temp_1349) then __O[1864] else __L1.activity
        __O[1865] = ____temp_1351
        local ____opt_1353 = __L1.training
        if ____opt_1353 ~= nil then
            ____opt_1353 = ____opt_1353.active
        end
        local ____temp_1355 = if ____t_1352(____temp_1351) then __O[1865] else ____opt_1353
        __O[1866] = ____temp_1355
        if ____t_1357(if ____t_1356(____temp_1355) then __O[1866] else __L1.routeTransition) then
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
        local ____t_1362 = __t
        local ____t_1361 = __t
        local ____t_1359 = __t
        local ____temp_1358 = __L1:keyHeld("left")
        __O[1867] = ____temp_1358
        local ____temp_1360 = if ____t_1359(____temp_1358) then __O[1867] else __L1.touch.left
        __O[1868] = ____temp_1360
        local ____t_1367 = __t
        local ____t_1366 = __t
        local ____t_1364 = __t
        local ____temp_1363 = __L1:keyHeld("right")
        __O[1869] = ____temp_1363
        local ____temp_1365 = if ____t_1364(____temp_1363) then __O[1869] else __L1.touch.right
        __O[1870] = ____temp_1365
        __L1.dashDir = if ____t_1362(if ____t_1361(____temp_1360) then __O[1868] else __L1.joystick.x < -0.15) then -1 else if ____t_1367(if ____t_1366(____temp_1365) then __O[1870] else __L1.joystick.x > 0.15) then 1 else __L1.player.facing
        local ____opt_1370 = window.CampaignVfx
        if ____opt_1370 ~= nil then
            ____opt_1370 = ____opt_1370.emit
        end
        if ____opt_1370 ~= nil then
            ____opt_1370(____opt_1370, "dash", {x = __L1.player.x, y = __L1.player.y - 3, dir = __L1.dashDir})
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
        local ____t_1399 = __t
        local ____t_1398 = __t
        local ____t_1394 = __t
        local ____t_1392 = __t
        local ____t_1390 = __t
        local ____t_1388 = __t
        local ____t_1386 = __t
        local ____t_1384 = __t
        local ____t_1382 = __t
        local ____t_1380 = __t
        local ____t_1378 = __t
        local ____opt_1374 = window.Arena
        if ____opt_1374 ~= nil then
            ____opt_1374 = ____opt_1374.isOpen
        end
        local ____opt_result_1376
        if ____opt_1374 ~= nil then
            ____opt_result_1376 = ____opt_1374(____opt_1374)
        end
        local ____temp_1377 = if __t(__L1.inputCaptured) then __L1.inputCaptured else ____opt_result_1376
        __O[1871] = ____temp_1377
        local ____temp_1379 = if ____t_1378(____temp_1377) then __O[1871] else not __t(__L1.started)
        __O[1872] = ____temp_1379
        local ____temp_1381 = if ____t_1380(____temp_1379) then __O[1872] else __L1.paused
        __O[1873] = ____temp_1381
        local ____temp_1383 = if ____t_1382(____temp_1381) then __O[1873] else __L1.dialog
        __O[1874] = ____temp_1383
        local ____temp_1385 = if ____t_1384(____temp_1383) then __O[1874] else __L1.defeated
        __O[1875] = ____temp_1385
        local ____temp_1387 = if ____t_1386(____temp_1385) then __O[1875] else __L1.cutscene
        __O[1876] = ____temp_1387
        local ____temp_1389 = if ____t_1388(____temp_1387) then __O[1876] else __L1.activity
        __O[1877] = ____temp_1389
        local ____temp_1391 = if ____t_1390(____temp_1389) then __O[1877] else if __t(__L1.room) then __L1.room.phase ~= "inside" else __L1.room
        __O[1878] = ____temp_1391
        local ____temp_1393 = if ____t_1392(____temp_1391) then __O[1878] else if __t(__L1.arena) then __L1.arena.phase ~= "active" else __L1.arena
        __O[1879] = ____temp_1393
        local ____opt_1395 = __L1.training
        if ____opt_1395 ~= nil then
            ____opt_1395 = ____opt_1395.active
        end
        local ____temp_1397 = if ____t_1394(____temp_1393) then __O[1879] else ____opt_1395
        __O[1880] = ____temp_1397
        if ____t_1399(if ____t_1398(____temp_1397) then __O[1880] else __L1.routeTransition) then
            __L1.joystick = {x = 0, y = 0}
            return
        end
        local ____t_1402 = __t
        local ____opt_1400 = window.ControlSettings
        if ____opt_1400 ~= nil then
            ____opt_1400 = ____opt_1400:transformJoystick(x, y)
        end
        __O[1883] = ____opt_1400
        local ____L1_clamp_1405 = __L1.clamp
        local ____t_1404 = __t
        local ____TS__Number_result_1403 = __TS__Number(x)
        __O[1881] = ____TS__Number_result_1403
        local ____L1_clamp_1405_result_1409 = ____L1_clamp_1405(__L1, if ____t_1404(____TS__Number_result_1403) then __O[1881] else 0, -1, 1)
        local ____L1_clamp_1408 = __L1.clamp
        local ____t_1407 = __t
        local ____TS__Number_result_1406 = __TS__Number(y)
        __O[1882] = ____TS__Number_result_1406
        __L1.joystick = if ____t_1402(____opt_1400) then __O[1883] else {
            x = ____L1_clamp_1405_result_1409,
            y = ____L1_clamp_1408(__L1, if ____t_1407(____TS__Number_result_1406) then __O[1882] else 0, -1, 1)
        }
    end
    __L1.toggleVehicle = function(self)
        if __t(__L1.ollyanEncounter) then
            return false
        end
        local ____t_1417 = __t
        local ____t_1411 = __t
        local ____temp_1410 = __L1.scene == 11 and not __t(__L1.vehicle)
        __O[1884] = ____temp_1410
        local ____gt_1416 = __gt
        local ____L1_player_x_1415 = __L1.player.x
        local ____opt_1412 = window.BaileGalpao
        if ____opt_1412 ~= nil then
            ____opt_1412 = ____opt_1412.PORTA
        end
        local ____opt_1412_1414 = ____opt_1412
        if ____opt_1412_1414 == nil then
            ____opt_1412_1414 = 760
        end
        if ____t_1417(if ____t_1411(____temp_1410) then ____gt_1416(____L1_player_x_1415, ____opt_1412_1414 - 70) else __O[1884]) then
            __L1:toast("Dentro do galpão não dá pra ligar o carro. Volte até a porta.")
            return
        end
        local ____t_1420 = __t
        local ____t_1419 = __t
        local ____temp_1418 = if __t(__L1.room) then __L1.room else __L1.cutscene
        __O[1885] = ____temp_1418
        if ____t_1420(if ____t_1419(____temp_1418) then __O[1885] else __L1.arena) then
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
        __L1:toast(if __t(__L1.vehicle) then "Carro a gás do seu pai ligado! Escolha uma rota ou dirija com o joystick." else "Carro a gás estacionado.")
        __L1:beep(if __t(__L1.vehicle) then 160 else 90, 0.2, "sawtooth")
        if __t(__L1.vehicle) then
            __L1:requestRoutePicker("entered-car")
        end
    end
    __L1.damageEnemy = function(self, e, n, element)
        local ____t_1439 = __t
        local ____t_1438 = __t
        local ____t_1436 = __t
        local ____t_1434 = __t
        local ____t_1432 = __t
        local ____t_1430 = __t
        local ____t_1428 = __t
        local ____t_1426 = __t
        local ____t_1422 = __t
        local ____temp_1421 = __le(e.hp, 0) or e.state == "underground"
        __O[1886] = ____temp_1421
        local ____opt_1423 = e.conquista
        if ____opt_1423 ~= nil then
            ____opt_1423 = ____opt_1423.estado
        end
        local ____temp_1425 = if ____t_1422(____temp_1421) then __O[1886] else ____opt_1423 == "phaseChange"
        __O[1887] = ____temp_1425
        local ____temp_1427 = if ____t_1426(____temp_1425) then __O[1887] else __gt(e.damageLock, 0)
        __O[1888] = ____temp_1427
        local ____temp_1429 = if ____t_1428(____temp_1427) then __O[1888] else __L1.dialog
        __O[1889] = ____temp_1429
        local ____temp_1431 = if ____t_1430(____temp_1429) then __O[1889] else __L1.won
        __O[1890] = ____temp_1431
        local ____temp_1433 = if ____t_1432(____temp_1431) then __O[1890] else __L1.defeated
        __O[1891] = ____temp_1433
        local ____temp_1435 = if ____t_1434(____temp_1433) then __O[1891] else __L1.room
        __O[1892] = ____temp_1435
        local ____temp_1437 = if ____t_1436(____temp_1435) then __O[1892] else __L1.cutscene
        __O[1893] = ____temp_1437
        if ____t_1439(if ____t_1438(____temp_1437) then __O[1893] else if __t(__L1.arena) then __L1.arena.phase ~= "active" else __L1.arena) then
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
        n = math.max(
            1,
            math.floor(n * if __t(exposed) then if __t(e.type == "marco" and __gt(e.phase, 1)) then 0.9 else 1 else __L1:bossProfile(e).armor + 0.5)
        )
        e.hp = e.hp - n
        local ____opt_1442 = window.SceneLife
        if ____opt_1442 ~= nil then
            ____opt_1442 = ____opt_1442.impact
        end
        if ____opt_1442 ~= nil then
            ____opt_1442(
                ____opt_1442,
                e.x - __L1.player.facing * 14,
                e.y - if e.type == "giant" then 80 else 40,
                if element == "electric" then "#a9e7f4" else if element == "fire" then "#f4ad60" else "#ffd27a",
                n,
                __TS__Number(-__L1.player.facing)
            )
        end
        __L1.shake = math.max(
            __L1.shake,
            math.min(4, 1 + n / 14)
        )
        __L1:epicFreeze(if __ge(n, 18) then 0.085 else if __t(exposed) then 0.06 else 0.04)
        e.hit = 0.15
        local ____opt_1446 = window.CampaignVfx
        if ____opt_1446 ~= nil then
            ____opt_1446 = ____opt_1446.emit
        end
        if ____opt_1446 ~= nil then
            ____opt_1446(____opt_1446, "hit", {
                x = e.x,
                y = e.y - if e.type == "giant" then 80 else if e.type == "igor" then 45 * __L1:igorScale(e) else if __t(e.type == "nikolas" and __ge(e.phase, 2)) then __L1:nikolasBounds(e).centerY else 32,
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
            if __t(if __t(exposed) then e.conquista else exposed) then
                local ____e_conquista_1448, ____dur_1449 = e.conquista, "dur"
                ____e_conquista_1448[____dur_1449] = ____e_conquista_1448[____dur_1449] + 0.08
            end
            e.stateTimer = e.stateTimer + if __t(exposed) then 0.08 else 0
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
            if e.type == "nikolas" then "#a6d05d" else "#e9ae68",
            8,
            90
        )
        __L1:floating(
            e.x,
            e.y - 85,
            __add("−", n)
        )
        __L1:beep(220, 0.06)
        local ____t_1452 = __t
        local ____t_1451 = __t
        local ____temp_1450 = __le(e.hp, 0) and e.type ~= "giant"
        __O[1894] = ____temp_1450
        if ____t_1452(if ____t_1451(____temp_1450) then __lt(if __t(e.phase) then e.phase else 1, if __t(e.phaseCount) then e.phaseCount else 3) else __O[1894]) then
            e.hp = 0
            __L1:beginBossPhase(e, if __t(e.phase) then e.phase else 1 + 1)
            __L1:updateUI()
            return
        end
        local ____t_1455 = __t
        local ____t_1454 = __t
        local ____le_result_1453 = __le(e.hp, 0)
        __O[1895] = ____le_result_1453
        if ____t_1455(if ____t_1454(____le_result_1453) then __L1.sandbox else __O[1895]) then
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
            local ____opt_1458 = window.FxPixel
            if ____opt_1458 ~= nil then
                ____opt_1458 = ____opt_1458.derrota
            end
            if ____opt_1458 ~= nil then
                ____opt_1458(____opt_1458, e)
            end
            __L1.shake = 12
            __L1:epicFreeze(0.3)
            __L1.epic.flash = 0.75
            __L1.epic.flashColor = "#fff6d8"
            __L1:epicRing(e.x, e.y - 60, "#ffe08b", 1.6)
            __L1:epicRing(e.x, e.y - 60, "#ff9b6a", 1.1)
            local ____L1_epicPlate_1463 = __L1.epicPlate
            local ____call_1462 = __call
            local ____t_1461 = __t
            local ____temp_1460 = __L1:nomeBoss(e.type)
            __O[1896] = ____temp_1460
            ____L1_epicPlate_1463(
                __L1,
                "DERROTADO!",
                ____call_1462(if ____t_1461(____temp_1460) then __O[1896] else "", "toUpperCase"),
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
                if ____type == "nikolas" then 900 else if ____type == "giant" then 750 else if ____type == "nicolas" then 700 else if ____type == "reeisBoss" then 600 else if ____type == "menezes" then 650 else if ____type == "freddy" then 400 else if ____type == "dede" then 320 else if ____type == "arthur" then 450 else if ____type == "igor" then 360 else if ____type == "kaique" then 420 else 480,
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
                __L1:say(if ____type == "igor" then __arrL({{name = "Igor · monitor", text = "Oxe, véi... tu passou mesmo! Achou um pão de queijo, fortalece o pai aqui, viu?"}, {name = "Da Roça", text = "Tua barriga fez mais chamada que o professor, pô! Bora que meu bolo não se acha sozinho."}}, 2) else __arrL({{name = "Kaique · monitor", text = "Vai, se pique logo, véi! Hoje tu passou... mas se eu achar outra bolinha, já sabe, né?"}, {name = "Da Roça", text = "Qual foi, Kaique? Era só um trabalho de física voando, pô!"}}, 2))
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
                local ____L1_items_1464, ____clip_1465 = __L1.items, "clip"
                ____L1_items_1464[____clip_1465] = ____L1_items_1464[____clip_1465] + 3
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
        local ____t_1476 = __t
        local ____t_1475 = __t
        local ____t_1473 = __t
        local ____t_1471 = __t
        local ____t_1469 = __t
        local ____t_1467 = __t
        local ____gt_result_1466 = __gt(__L1.player.inv, 0)
        __O[1897] = ____gt_result_1466
        local ____temp_1468 = if ____t_1467(____gt_result_1466) then __O[1897] else __L1.won
        __O[1898] = ____temp_1468
        local ____temp_1470 = if ____t_1469(____temp_1468) then __O[1898] else __L1.defeated
        __O[1899] = ____temp_1470
        local ____temp_1472 = if ____t_1471(____temp_1470) then __O[1899] else __L1.dialog
        __O[1900] = ____temp_1472
        local ____temp_1474 = if ____t_1473(____temp_1472) then __O[1900] else __L1.paused
        __O[1901] = ____temp_1474
        if ____t_1476(if ____t_1475(____temp_1474) then __O[1901] else __L1.routeTransition) then
            return
        end
        local ____t_1479 = __t
        local ____opt_1477 = window.C2Luta
        if ____opt_1477 ~= nil then
            ____opt_1477 = ____opt_1477.skin
        end
        if ____t_1479(____opt_1477) then
            n = n * if __t(window.C2Luta.skin.dano) then window.C2Luta.skin.dano else 1
        end
        local ____t_1488 = __t
        local ____opt_1485 = window.Difficulty
        if ____opt_1485 ~= nil then
            ____opt_1485 = ____opt_1485.scaleIncomingDamage
        end
        local ____opt_result_1487
        if ____opt_1485 ~= nil then
            local ____n_1483 = n
            local ____opt_1481 = __L1.activeBoss
            if ____opt_1481 ~= nil then
                ____opt_1481 = ____opt_1481.difficultyMode
            end
            ____opt_result_1487 = ____opt_1485(____opt_1485, ____n_1483, ____opt_1481)
        end
        __O[1902] = ____opt_result_1487
        n = if ____t_1488(____opt_result_1487) then __O[1902] else n
        __L1.player.hp = math.max(0, __L1.player.hp - n)
        local ____opt_1491 = window.CampaignVfx
        if ____opt_1491 ~= nil then
            ____opt_1491 = ____opt_1491.emit
        end
        if ____opt_1491 ~= nil then
            ____opt_1491(____opt_1491, "enemyHit", {x = __L1.player.x, y = __L1.player.y - 30, dir = if __lt(__L1.player.x, from) then -1 else 1, damage = n})
        end
        __L1.player.inv = 0.65
        __L1.player.vy = -135
        __L1.player.x = __L1:clamp(__L1.player.x + if __lt(__L1.player.x, from) then -30 else 30, 30, __L1.WORLD - 30)
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
        local ____t_1515 = __t
        local ____t_1514 = __t
        local ____t_1512 = __t
        local ____t_1510 = __t
        local ____t_1506 = __t
        local ____t_1504 = __t
        local ____t_1502 = __t
        local ____t_1500 = __t
        local ____t_1498 = __t
        local ____t_1496 = __t
        local ____t_1494 = __t
        local ____temp_1493 = not __t(__L1.started) or not __t(__L1.q.nikolas)
        __O[1903] = ____temp_1493
        local ____temp_1495 = if ____t_1494(____temp_1493) then __O[1903] else __L1.defeated
        __O[1904] = ____temp_1495
        local ____temp_1497 = if ____t_1496(____temp_1495) then __O[1904] else __L1.activeBoss
        __O[1905] = ____temp_1497
        local ____temp_1499 = if ____t_1498(____temp_1497) then __O[1905] else __L1.arena
        __O[1906] = ____temp_1499
        local ____temp_1501 = if ____t_1500(____temp_1499) then __O[1906] else __L1.room
        __O[1907] = ____temp_1501
        local ____temp_1503 = if ____t_1502(____temp_1501) then __O[1907] else __L1.routeTransition
        __O[1908] = ____temp_1503
        local ____temp_1505 = if ____t_1504(____temp_1503) then __O[1908] else __L1.dialog
        __O[1909] = ____temp_1505
        local ____opt_1507 = __L1.training
        if ____opt_1507 ~= nil then
            ____opt_1507 = ____opt_1507.active
        end
        local ____temp_1509 = if ____t_1506(____temp_1505) then __O[1909] else ____opt_1507
        __O[1910] = ____temp_1509
        local ____temp_1511 = if ____t_1510(____temp_1509) then __O[1910] else __L1.activity
        __O[1911] = ____temp_1511
        local ____temp_1513 = if ____t_1512(____temp_1511) then __O[1911] else __L1.cutscene
        __O[1912] = ____temp_1513
        if ____t_1515(if ____t_1514(____temp_1513) then __O[1912] else __L1.ollyanEncounter) then
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
        local ____t_1524 = __t
        local ____opt_1520 = window.CampaignRun
        if ____opt_1520 ~= nil then
            ____opt_1520 = ____opt_1520.getResult
        end
        local ____opt_result_1522
        if ____opt_1520 ~= nil then
            ____opt_result_1522 = ____opt_1520(____opt_1520)
        end
        local ____opt_result_1523
        if ____opt_result_1522 ~= nil then
            ____opt_result_1523 = ____opt_result_1522.mode
        end
        if ____t_1524(____opt_result_1523 == "easy" and not __t(__L1.q.easyEndingSeen)) then
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
        local ____opt_1527 = window.CampaignRun
        if ____opt_1527 ~= nil then
            ____opt_1527 = ____opt_1527.finish
        end
        if ____opt_1527 ~= nil then
            ____opt_1527(____opt_1527)
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
                __L1.shake = math.max(__L1.shake, if __t(__L1.calmMotion) then 2 else 7)
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
        local ____t_1537 = __t
        local ____t_1536 = __t
        local ____t_1534 = __t
        local ____t_1532 = __t
        local ____t_1530 = __t
        local ____temp_1529 = if __t(b) then not __t(b.conquista) else b
        __O[1913] = ____temp_1529
        local ____temp_1531 = if ____t_1530(____temp_1529) then __gt(b.hp, 0) else __O[1913]
        __O[1914] = ____temp_1531
        local ____temp_1533 = if ____t_1532(____temp_1531) then __ge(if __t(b.phase) then b.phase else 1, if __t(b.phaseCount) then b.phaseCount else 1) else __O[1914]
        __O[1915] = ____temp_1533
        local ____temp_1535 = if ____t_1534(____temp_1533) then b.max else __O[1915]
        __O[1916] = ____temp_1535
        if ____t_1537(if ____t_1536(____temp_1535) then b.hp / b.max < 0.35 else __O[1916]) then
            local pulse = 0.5 + 0.5 * math.sin(__L1.time * 9)
            local h = if b.type == "giant" then 190 else if __t(b.type == "nikolas" and __ge(b.phase, 4)) then 210 else 110
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
                        math.floor(if __mod(i, 3) == 0 then 7 else 5 * (1 - k) * r.size + 0.5)
                    )
                    local px = math.floor(r.x + math.cos(a) * d + 0.5)
                    local py = math.floor(r.y + math.sin(a) * d * 0.75 + k * k * 40 + 0.5)
                    __L1.ctx.fillStyle = if __t(__mod(i, 2)) then r.color else "#fff6d8"
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
            local pop = if __lt(P.age, 0.18) then 0.6 + P.age / 0.18 * 0.5 else if __lt(P.age, 0.3) then 1.1 - (P.age - 0.18) / 0.12 * 0.1 else 1
            local alpha = if k > 0.8 then (1 - k) / 0.2 else 1
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
        local ____t_1545 = __t
        local ____t_1539 = __t
        local ____temp_1538 = __L1.scene >= 12
        __O[1917] = ____temp_1538
        local ____opt_1542 = window.CampanhaCenarios
        if ____opt_1542 ~= nil then
            ____opt_1542 = ____opt_1542.plataforma
        end
        local ____opt_result_1544
        if ____opt_1542 ~= nil then
            ____opt_result_1544 = ____opt_1542(
                ____opt_1542,
                __L1.ctx,
                __L1.scene,
                p,
                __L1.time
            )
        end
        if ____t_1545(if ____t_1539(____temp_1538) then ____opt_result_1544 else __O[1917]) then
            return
        end
        local x = math.floor(__get(p, 0) + 0.5)
        local y = math.floor(__get(p, 1) + 0.5)
        local w = math.floor(__get(p, 2) + 0.5)
        local metal = __L1.scene == 2
        local ink = __L1.scene == 6
        local ____t_1547 = __t
        local ____temp_1546 = __L1.scene == 0 or __L1.scene == 7
        __O[1918] = ____temp_1546
        local grassy = if ____t_1547(____temp_1546) then __O[1918] else __L1.scene == 3
        local dark = if __t(metal) then "#3e4a45" else if __t(ink) then "#3d2c52" else "#4f3624"
        local mid = if __t(metal) then "#63736a" else if __t(ink) then "#7d6596" else "#8d6a45"
        local lit = if __t(metal) then "#8fa096" else if __t(ink) then "#b59bd0" else "#b88d5c"
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
            __L1.ctx.fillStyle = if __t(metal) then "#b8c4bc" else "#d9c08f"
            __L1.ctx:fillRect(x, y, w, 1)
        end
    end
    __L1.hazPal = function(self, h)
        local ____t_1550 = __t
        local ____t_1549 = __t
        local ____temp_1548 = h.type == "smoke"
        __O[1919] = ____temp_1548
        local ____t_1553 = __t
        local ____t_1552 = __t
        local ____temp_1551 = h.type == "astral"
        __O[1920] = ____temp_1551
        return if __t(h.catarro) then __L1.HAZ.slime else if __t(h.brasa) then __L1.HAZ.brasa else if __t(if __t(h.ink) then h.ink else h.type == "ink") then __L1.HAZ.ink else if ____t_1550(if ____t_1549(____temp_1548) then __O[1919] else h.smoke) then __L1.HAZ.smoke else if ____t_1553(if ____t_1552(____temp_1551) then __O[1920] else h.astral) then __L1.HAZ.astral else if h.type == "slime" then __L1.HAZ.slime else __L1.HAZ.pink
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
                __L1:px(
                    x - ww / 2,
                    base - yy - 4,
                    ww,
                    4,
                    if yy < 4 then __get(pal, 0) else if k < 0.35 then __get(pal, 3) else if k < 0.7 then __get(pal, 2) else __get(pal, 1)
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
        local ____t_1559 = __t
        local ____opt_1556 = window.Graphics
        if ____opt_1556 ~= nil then
            ____opt_1556 = ____opt_1556.isLite
        end
        local ____opt_result_1558
        if ____opt_1556 ~= nil then
            ____opt_result_1558 = ____opt_1556(____opt_1556)
        end
        local lite = not not ____t_1559(____opt_result_1558)
        local ____t_1569 = __t
        local ____opt_1566 = window.Golpes
        if ____opt_1566 ~= nil then
            ____opt_1566 = ____opt_1566.desenharPerigo
        end
        local ____opt_result_1568
        if ____opt_1566 ~= nil then
            local ____L1_ctx_1563 = __L1.ctx
            local ____h_1564 = h
            local ____opt_1561 = __L1.activeBoss
            if ____opt_1561 ~= nil then
                ____opt_1561 = ____opt_1561.type
            end
            ____opt_result_1568 = ____opt_1566(
                ____opt_1566,
                ____L1_ctx_1563,
                ____h_1564,
                t,
                lite,
                pal,
                ____opt_1561
            )
        end
        if ____t_1569(____opt_result_1568) then
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
            local span = if h.type == "ring" then 46 else h.r
            __L1.ctx:save()
            do
                local i = 0
                while i < if __t(lite) then 4 else 10 do
                    local k = __mod(
                        t * 1.6 + __L1:hsh(i + h.x),
                        1
                    )
                    local ex = h.x + (__L1:hsh(i * 7 + h.x) - 0.5) * span * 2
                    __L1.ctx.globalAlpha = (1 - k) * blink
                    __L1:px(
                        ex,
                        __L1.FLOOR - 6 - k * if __t(h.height) then math.min(160, h.height * 0.6) else 46,
                        3,
                        3,
                        if __t(__mod(i, 2)) then __get(pal, 2) else __get(pal, 3)
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
                local n = if __t(lite) then 8 else 18
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
                        __L1.ctx.globalAlpha = dens * if __t(__mod(i, 4)) then 0.75 else 1
                        if __t(__mod(i, 4)) then
                            __L1:px(
                                fx_,
                                fy,
                                3,
                                2,
                                if __t(__mod(i, 3)) then "#8a8680" else "#b8b4ac"
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
        local life = math.max(0, if __t(h.life) then h.life else 0)
        local ____t_1576 = __t
        local ____t_1573 = __t
        local ____t_1571 = __t
        local ____temp_1570 = h.type == "ring"
        __O[1921] = ____temp_1570
        local ____temp_1572 = if ____t_1571(____temp_1570) then h.catarro else __O[1921]
        __O[1922] = ____temp_1572
        local ____opt_1574 = window.NikolasFx
        if ____opt_1574 ~= nil then
            ____opt_1574 = ____opt_1574.onda
        end
        if ____t_1576(if ____t_1573(____temp_1572) then ____opt_1574 else __O[1922]) then
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
                    while __t(if dir > 0 then __lt(x, cx - 8) else __gt(x, cx + 8)) do
                        local fade = math.abs(x - h.x) / math.max(1, h.r)
                        __L1:px(
                            x,
                            __L1.FLOOR - 3,
                            6,
                            2,
                            __get(pal, 1)
                        )
                        if __L1:hsh(x) > 0.6 then
                            __L1:px(
                                x + 2,
                                __L1.FLOOR - 5 - __L1:hsh(x + 3) * 3,
                                2,
                                2,
                                if fade > 0.6 then __get(pal, 2) else __get(pal, 0)
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
                            __L1:px(
                                cx + dir * (4 + k * 30) + (__L1:hsh(i) - 0.5) * 10,
                                __L1.FLOOR - 10 - k * 48 + k * k * 30,
                                if __t(__mod(i, 2)) then 3 else 2,
                                if __t(__mod(i, 2)) then 3 else 2,
                                if __t(__mod(i, 3)) then __get(pal, 2) else __get(pal, 3)
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
                    __L1:px(
                        ex - 2,
                        __L1.FLOOR - 5,
                        5,
                        3,
                        if f > 0.3 then __get(pal, 2) else __get(pal, 1)
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
            local sp = if __t(h.brasa) then __L1.HAZ.smoke else pal
            local m = if __t(h.brasa) then 5 else 9
            __L1.ctx:save()
            do
                local i = 0
                while i < m do
                    local bx = h.x + (i - (m - 1) / 2) * h.r / 4.5
                    local rise = __mod(t * 20 + i * 13, 40)
                    local z = if __t(h.brasa) then 7 else 10 + __mod(i * 5, 3) * 4
                    __L1.ctx.globalAlpha = (0.55 * (1 - rise / 40) + 0.15) * if __t(h.brasa) then 0.7 else 1
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
                while i < if __t(lite) then 3 else 8 do
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
        local k = math.max(
            0,
            math.sin(__L1:clamp(e.stateTimer / if __t(e.phaseDuration) then e.phaseDuration else 1.05, 0, 1) * math.pi)
        )
        local pal = if e.type == "nikolas" then __L1.HAZ.slime else if e.type == "menezes" then __L1.HAZ.pink else __L1.HAZ.ink
        local spread = 60 + __L1:nikolasTransformProgress(e) * 80
        do
            local i = 0
            while i < 14 do
                local side = if __t(__mod(i, 2)) then 1 else -1
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
                __L1:px(
                    e.x + (__L1:hsh(i + 9) - 0.5) * spread * 2.2,
                    __L1.FLOOR - 10 - p * 170,
                    if __t(__mod(i, 3)) then 3 else 4,
                    if __t(__mod(i, 3)) then 3 else 4,
                    if __t(__mod(i, 2)) then __get(pal, 2) else __get(pal, 3)
                )
                i = i + 1
            end
        end
        __L1.ctx:restore()
    end
    __L1.epilogueCue = function(self, film)
        local ____opt_result_1579
        if film ~= nil then
            ____opt_result_1579 = film.kind
        end
        if ____opt_result_1579 ~= "jorge_epilogue" then
            return
        end
        local ____opt_1584 = window.Cinematics
        if ____opt_1584 ~= nil then
            ____opt_1584 = ____opt_1584.beat
        end
        local ____opt_result_1586
        if ____opt_1584 ~= nil then
            ____opt_result_1586 = ____opt_1584(____opt_1584, film)
        end
        local ____opt_result_1587
        if ____opt_result_1586 ~= nil then
            ____opt_result_1587 = ____opt_result_1586.id
        end
        local shot = ____opt_result_1587
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
        local ____t_1594 = __t
        local ____t_1593 = __t
        local ____t_1591 = __t
        local ____t_1589 = __t
        local ____temp_1588 = not __t(__L1.started)
        __O[1923] = ____temp_1588
        local ____temp_1590 = if ____t_1589(____temp_1588) then __O[1923] else __L1.paused
        __O[1924] = ____temp_1590
        local ____temp_1592 = if ____t_1591(____temp_1590) then __O[1924] else __L1.dialog
        __O[1925] = ____temp_1592
        if ____t_1594(if ____t_1593(____temp_1592) then __O[1925] else __L1.defeated) then
            __L1:updateEffects(dt)
            return
        end
        if __t(__L1.cutscene) then
            local film = __L1.cutscene
            local before = film.index
            local ____t_1597 = __t
            local ____opt_1595 = window.GameMusic
            if ____opt_1595 ~= nil then
                ____opt_1595 = ____opt_1595.isCutsceneTimed
            end
            if ____t_1597(____opt_1595) then
                film.options.musicTimed = window.GameMusic:isCutsceneTimed(film.kind)
            end
            film.audioElapsed = __add(if __t(film.audioElapsed) then film.audioElapsed else 0, dt)
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
        if __t(if __t(__L1.room) then __L1.room.phase ~= "inside" else __L1.room) then
            __L1:updateRoomTransition(dt)
            __L1:updateEffects(dt)
            return
        end
        if __t(if __t(__L1.arena) then __L1.arena.phase ~= "active" else __L1.arena) then
            __L1:updateArenaTransition(dt)
            __L1:updateEffects(dt)
            return
        end
        local ____t_1600 = __t
        local ____opt_1598 = __L1.routeTransition
        if ____opt_1598 ~= nil then
            ____opt_1598 = ____opt_1598.chegada
        end
        if ____t_1600(____opt_1598) then
            local ____t_1606 = __t
            local ____opt_1603 = window.ChegadaCarro
            if ____opt_1603 ~= nil then
                ____opt_1603 = ____opt_1603.atualizar
            end
            local ____opt_result_1605
            if ____opt_1603 ~= nil then
                ____opt_result_1605 = ____opt_1603(____opt_1603, dt)
            end
            if not ____t_1606(____opt_result_1605) then
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
                if __t(if __t(__L1.routeTransition.estrada) then window.ChegadaCarro else __L1.routeTransition.estrada) then
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
        local ____t_1609 = __t
        local ____opt_1607 = __L1.training
        if ____opt_1607 ~= nil then
            ____opt_1607 = ____opt_1607.active
        end
        if ____t_1609(____opt_1607) then
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
        if __t(if __t(wasDashing) then __L1.dashTimer == 0 else wasDashing) then
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
            local ____t_1611 = __t
            local ____getq_result_1610 = __getq(
                __L1:closestNPC(),
                0
            )
            __O[1926] = ____getq_result_1610
            __L1.nearNPC = if ____t_1611(____getq_result_1610) then __O[1926] else nil
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
        local ____t_1616 = __t
        local ____t_1615 = __t
        local ____t_1613 = __t
        local ____temp_1612 = if __t(__L1.player.ground) then __lt(
            __L1.player.hp,
            __L1:bonus().maxHP
        ) else __L1.player.ground
        __O[1927] = ____temp_1612
        local ____temp_1614 = if ____t_1613(____temp_1612) then not __t(__L1.activeBoss) else __O[1927]
        __O[1928] = ____temp_1614
        if ____t_1616(if ____t_1615(____temp_1614) then not __t(__L1.arena) else __O[1928]) then
            __L1.player.hp = math.min(
                __L1:bonus().maxHP,
                __L1.player.hp + dt * 2.5
            )
        end
        if not __t(__L1:terrenoConquista()) then
            __L1.camera = __L1:clamp(__L1.player.x - __L1.W * 0.36, 0, __L1.WORLD - __L1.W)
        end
        local ____t_1618 = __t
        local ____getq_result_1617 = __getq(
            __L1:closestNPC(),
            0
        )
        __O[1929] = ____getq_result_1617
        __L1.nearNPC = if ____t_1618(____getq_result_1617) then __O[1929] else nil
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
        local ____opt_1621 = window.LugaresC1
        if ____opt_1621 ~= nil then
            ____opt_1621 = ____opt_1621.coletar
        end
        local ____opt_result_1623
        if ____opt_1621 ~= nil then
            ____opt_result_1623 = ____opt_1621(____opt_1621, __L1.q, __L1.player, __L1.scene)
        end
        local toolPick = ____opt_result_1623
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
        local ____opt_1626 = window.MissaoFarda
        if ____opt_1626 ~= nil then
            ____opt_1626 = ____opt_1626.coletar
        end
        local ____opt_result_1628
        if ____opt_1626 ~= nil then
            ____opt_result_1628 = ____opt_1626(____opt_1626, __L1.q, __L1.player, __L1.scene)
        end
        local fardaPick = ____opt_result_1628
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
        local ____opt_1631 = window.BivoltQuest
        if ____opt_1631 ~= nil then
            ____opt_1631 = ____opt_1631.collect
        end
        local ____opt_result_1633
        if ____opt_1631 ~= nil then
            ____opt_result_1633 = ____opt_1631(____opt_1631, __L1.q, __L1.player, __L1.scene)
        end
        local bivoltPick = ____opt_result_1633
        local ____t_1637 = __t
        local ____opt_result_1636
        if bivoltPick ~= nil then
            ____opt_result_1636 = bivoltPick.collected
        end
        if ____t_1637(____opt_result_1636) then
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
            local ____opt_1640 = window.BaileGalpao
            if ____opt_1640 ~= nil then
                ____opt_1640 = ____opt_1640.sincronizar
            end
            if ____opt_1640 ~= nil then
                ____opt_1640(
                    ____opt_1640,
                    {telhado = not not __t(if __t(__L1.q.ollyan) then __L1.q.ollyan else __L1.q.ollyanTeto)}
                )
            end
            local ____opt_1642 = window.BaileGalpao
            if ____opt_1642 ~= nil then
                ____opt_1642 = ____opt_1642.PORTA
            end
            local ____opt_1642_1644 = ____opt_1642
            if ____opt_1642_1644 == nil then
                ____opt_1642_1644 = 760
            end
            local porta = ____opt_1642_1644 - 70
            local ____t_1647 = __t
            local ____t_1646 = __t
            local ____temp_1645 = if __t(__L1.vehicle) then not __t(__L1.ollyanEncounter) else __L1.vehicle
            __O[1930] = ____temp_1645
            if ____t_1647(if ____t_1646(____temp_1645) then __gt(__L1.player.x, porta) else __O[1930]) then
                __L1.player.x = porta
                __L1.player.vx = 0
                __L1.vehicle = false
                __L1:toast("O carro a gás fica na porta do galpão. No baile, só a pé!")
            end
        end
        do
            local ____opt_1650 = window.LugaresC1
            if ____opt_1650 ~= nil then
                ____opt_1650 = ____opt_1650.porta
            end
            local ____opt_result_1652
            if ____opt_1650 ~= nil then
                ____opt_result_1652 = ____opt_1650(____opt_1650, __L1.scene)
            end
            local pl = ____opt_result_1652
            local ____t_1657 = __t
            local ____t_1656 = __t
            local ____t_1654 = __t
            local ____temp_1653 = pl ~= nil
            __O[1931] = ____temp_1653
            local ____temp_1655 = if ____t_1654(____temp_1653) then __L1.vehicle else __O[1931]
            __O[1932] = ____temp_1655
            if ____t_1657(if ____t_1656(____temp_1655) then __gt(__L1.player.x, pl) else __O[1932]) then
                __L1.player.x = pl
                __L1.player.vx = 0
                __L1.vehicle = false
                __L1:toast("O carro fica na porta. Lá dentro, só a pé!")
            end
        end
        local ____t_1671 = __t
        local ____t_1670 = __t
        local ____t_1661 = __t
        local ____t_1659 = __t
        local ____temp_1658 = __L1.scene == 11 and not __t(__L1.q.ollyan)
        __O[1933] = ____temp_1658
        local ____temp_1660 = if ____t_1659(____temp_1658) then __L1.ollyanRetryGrace <= 0 else __O[1933]
        __O[1935] = ____temp_1660
        local ____L1_player_x_1668 = __L1.player.x
        local ____t_1667 = __t
        local ____opt_1664 = window.BaileWorld
        if ____opt_1664 ~= nil then
            ____opt_1664 = ____opt_1664.getNPC
        end
        local ____opt_result_1666
        if ____opt_1664 ~= nil then
            ____opt_result_1666 = ____opt_1664(____opt_1664).x
        end
        __O[1934] = ____opt_result_1666
        local ____temp_1669 = if ____t_1661(____temp_1660) then math.abs(____L1_player_x_1668 - if ____t_1667(____opt_result_1666) then __O[1934] else 3260) < 145 else __O[1935]
        __O[1936] = ____temp_1669
        if ____t_1671(if ____t_1670(____temp_1669) then __L1.q.lucas else __O[1936]) then
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
        local ____t_1674 = __t
        local ____t_1673 = __t
        local ____temp_1672 = if __t(__L1.vehicle) then __L1.routeEdgeCooldown <= 0 else __L1.vehicle
        __O[1937] = ____temp_1672
        if ____t_1674(if ____t_1673(____temp_1672) then __lt(__L1.player.x, 38) or __gt(__L1.player.x, __L1.WORLD - 38) else __O[1937]) then
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
        local ____t_1685 = __t
        local ____t_1682 = __t
        local ____t_1680 = __t
        local ____t_1678 = __t
        local ____t_1676 = __t
        local ____temp_1675 = __L1.scene ~= 1
        __O[1938] = ____temp_1675
        local ____temp_1677 = if ____t_1676(____temp_1675) then __O[1938] else __L1.marcoTrapTriggered
        __O[1939] = ____temp_1677
        local ____temp_1679 = if ____t_1678(____temp_1677) then __O[1939] else not __t(__L1.activeBoss)
        __O[1940] = ____temp_1679
        local ____temp_1681 = if ____t_1680(____temp_1679) then __O[1940] else __L1.activeBoss.type ~= "marco"
        __O[1941] = ____temp_1681
        local ____opt_1683 = __L1.arena
        if ____opt_1683 ~= nil then
            ____opt_1683 = ____opt_1683.phase
        end
        if ____t_1685(if ____t_1682(____temp_1681) then __O[1941] else ____opt_1683 ~= "active") then
            return
        end
        local ____t_1688 = __t
        local ____opt_1686 = window.WorldData
        if ____opt_1686 ~= nil then
            ____opt_1686 = ____opt_1686.sarueTraps
        end
        __O[1942] = ____opt_1686
        local traps = if ____t_1688(____opt_1686) then __O[1942] else __arrL({{scene = 1, x = 3420, width = 70}}, 1)
        local trap = __call(
            traps,
            "find",
            function(____, t)
                local ____t_1690 = __t
                local ____temp_1689 = t.scene == __L1.scene and math.abs(__L1.player.x - t.x) < if __t(t.width) then t.width else 70 / 2
                __O[1943] = ____temp_1689
                return if ____t_1690(____temp_1689) then __gt(__L1.player.y, __L1.FLOOR - 18) else __O[1943]
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
        local ____t_1695 = __t
        local ____t_1694 = __t
        local ____temp_1693 = e.type ~= "igor"
        if not ____temp_1693 then
            local ____opt_1691 = __L1.arena
            if ____opt_1691 ~= nil then
                ____opt_1691 = ____opt_1691.type
            end
            ____temp_1693 = ____opt_1691 ~= "igor"
        end
        __O[1944] = ____temp_1693
        if ____t_1695(if ____t_1694(____temp_1693) then __O[1944] else __L1.activeBoss ~= e and __L1.arena.phase ~= "exiting") then
            return 1
        end
        local p = if __L1.arena.phase == "entering" then 0 else if __L1.arena.phase == "exiting" then __L1:clamp(__L1.arena.blend, 0, 1) else if e.state == "monitorTransform" then __L1:clamp(if __t(e.monitorTransform) then e.monitorTransform else 0, 0, 1) else 1
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
        local rx = if __t(rolling) then 36 else 33 * scale + padX
        local ry = if __t(rolling) then 36 else 45 * scale + padY
        local cy = e.y - if __t(rolling) then 36 else 45 * scale
        return ((x - e.x) / rx) ^ 2 + ((y - cy) / ry) ^ 2 < 1
    end
    __L1.nikolasBounds = function(self, e)
        local ____t_1701 = __t
        local ____opt_1698 = window.Art
        if ____opt_1698 ~= nil then
            ____opt_1698 = ____opt_1698.nikolasBounds
        end
        local ____opt_result_1700
        if ____opt_1698 ~= nil then
            ____opt_result_1700 = ____opt_1698(____opt_1698, if __t(e.phase) then e.phase else 1)
        end
        __O[1945] = ____opt_result_1700
        return if ____t_1701(____opt_result_1700) then __O[1945] else if e.phase == 4 then {halfWidth = 185, height = 340, centerY = 170} else if __ge(e.phase, 2) then {halfWidth = 55, height = 140, centerY = 70} else {halfWidth = 35, height = 90, centerY = 30}
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
        return if e.state == "phaseChange" then __L1:clamp(1 - e.stateTimer / if __t(e.phaseDuration) then e.phaseDuration else 1.05, 0, 1) else 1
    end
    __L1.bossCaptionY = function(self, e)
        return math.max(if e.type == "igor" then 145 else 83, e.y - if e.type == "igor" then 90 * __L1:igorScale(e) + 30 else if e.type == "giant" then 240 else if __t(e.type == "nikolas" and __ge(e.phase, 2)) then __L1:nikolasBounds(e).height + 20 else 157)
    end
    __L1.monitorSees = function(self, e)
        local distance = (__L1.player.x - e.x) * e.monitorDir
        local ____t_1704 = __t
        local ____t_1703 = __t
        local ____temp_1702 = distance < -15 or distance > 300
        __O[1946] = ____temp_1702
        if ____t_1704(if ____t_1703(____temp_1702) then __O[1946] else __lt(__L1.player.y, __L1.FLOOR - 92)) then
            return false
        end
        local eye = __L1.FLOOR - if e.type == "igor" then 74 else 92
        local head = __L1.player.y - 40
        local center = eye + (__L1.FLOOR - 40 - eye) * distance / 300
        if math.abs(head - center) > 18 + distance * 0.15 then
            return false
        end
        local a = math.min(e.x, __L1.player.x)
        local b = math.max(e.x, __L1.player.x)
        local ____t_1709 = __t
        local ____call_1708 = __call
        local ____t_1707 = __t
        local ____opt_1705 = window.WorldData
        if ____opt_1705 ~= nil then
            ____opt_1705 = ____opt_1705.schoolCovers
        end
        __O[1947] = ____opt_1705
        return not ____t_1709(____call_1708(
            if ____t_1707(____opt_1705) then __O[1947] else __arrL({}, 0),
            "some",
            function(____, c) return __gt(c.x + c.width / 2, a) and c.x - c.width / 2 < b end
        ))
    end
    __L1.confrontMonitor = function(self, e, iraci)
        if iraci == nil then
            iraci = false
        end
        local ____t_1724 = __t
        local ____t_1723 = __t
        local ____t_1721 = __t
        local ____t_1719 = __t
        local ____t_1717 = __t
        local ____t_1715 = __t
        local ____t_1713 = __t
        local ____t_1711 = __t
        local ____temp_1710 = not __t(e) or __le(e.hp, 0)
        __O[1948] = ____temp_1710
        local ____temp_1712 = if ____t_1711(____temp_1710) then __O[1948] else __L1.dialog
        __O[1949] = ____temp_1712
        local ____temp_1714 = if ____t_1713(____temp_1712) then __O[1949] else __L1.activeBoss
        __O[1950] = ____temp_1714
        local ____temp_1716 = if ____t_1715(____temp_1714) then __O[1950] else __L1.arena
        __O[1951] = ____temp_1716
        local ____temp_1718 = if ____t_1717(____temp_1716) then __O[1951] else __L1.room
        __O[1952] = ____temp_1718
        local ____temp_1720 = if ____t_1719(____temp_1718) then __O[1952] else __L1.cutscene
        __O[1953] = ____temp_1720
        local ____temp_1722 = if ____t_1721(____temp_1720) then __O[1953] else __L1.paused
        __O[1954] = ____temp_1722
        if ____t_1724(if ____t_1723(____temp_1722) then __O[1954] else __L1.defeated) then
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
        __L1:say(if e.type == "igor" then __arrL({{name = "Igor · monitor", text = "Qual foi, Da Roça? Tem um lanche aí, véi? Um salgado, um pão... fortalece o monitor, pô!"}, {name = "Da Roça", text = "Tenho nada, pô! Nikolas levou meu bolo. Só sobrou a embalagem e o gás, tá ligado?"}, {name = "Igor · monitor", text = "Sem lanche?! Tá tirando com minha cara, é? Oxe! Então segura a barriga, meu parceiro!"}}, 3) else if __t(iraci) then __arrL({{name = "Kaique · monitor", text = "IRACI?! Qual foi, véi?! Quem botou o nome de minha mãe nesse chão? Se passou, hein!"}, {name = "Da Roça", text = "Eu só pisei sem querer, pô! O chão é que tava de resenha com tu!"}, {name = "Kaique · monitor", text = "Ah, é? Agora tu vai ver a resenha! Bora, Da Roça, desvia disso aqui, quero ver!"}}, 3) else __arrL({{name = "Kaique · monitor", text = "Ô, Da Roça! Bora pra sala, véi! E deixa essas bolinhas aqui. Tu acha que eu não tô vendo, é?"}, {name = "Da Roça", text = "Calma, meu parceiro! Isso aqui é pesquisa de trajetória... na prática, tá ligado?"}, {name = "Kaique · monitor", text = "Pesquisa nada, véi! Tu tá é de resenha! Bora ver se tu é ligeiro mesmo. Na recarga tu vem, viu?"}}, 3))
        return true
    end
    __L1.updateSchoolMonitors = function(self, dt)
        local ____t_1741 = __t
        local ____t_1736 = __t
        local ____t_1734 = __t
        local ____t_1732 = __t
        local ____t_1728 = __t
        local ____temp_1727 = __L1.scene == 1
        if ____temp_1727 then
            local ____opt_1725 = __L1.activeBoss
            if ____opt_1725 ~= nil then
                ____opt_1725 = ____opt_1725.type
            end
            ____temp_1727 = ____opt_1725 == "kaique"
        end
        __O[1955] = ____temp_1727
        local ____opt_1729 = __L1.arena
        if ____opt_1729 ~= nil then
            ____opt_1729 = ____opt_1729.phase
        end
        local ____temp_1731 = if ____t_1728(____temp_1727) then ____opt_1729 == "active" else __O[1955]
        __O[1956] = ____temp_1731
        local ____temp_1733 = if ____t_1732(____temp_1731) then not __t(__L1.activeBoss.iraciTriggered) else __O[1956]
        __O[1957] = ____temp_1733
        local ____temp_1735 = if ____t_1734(____temp_1733) then __gt(__L1.player.y, __L1.FLOOR - 18) else __O[1957]
        __O[1959] = ____temp_1735
        local ____call_1740 = __call
        local ____t_1739 = __t
        local ____opt_1737 = window.WorldData
        if ____opt_1737 ~= nil then
            ____opt_1737 = ____opt_1737.iraciTraps
        end
        __O[1958] = ____opt_1737
        if ____t_1741(if ____t_1736(____temp_1735) then ____call_1740(
            if ____t_1739(____opt_1737) then __O[1958] else __arrL({}, 0),
            "some",
            function(____, t) return math.abs(__L1.player.x - t.x) < t.width / 2 end
        ) else __O[1959]) then
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
        local ____t_1758 = __t
        local ____t_1757 = __t
        local ____t_1755 = __t
        local ____t_1753 = __t
        local ____t_1751 = __t
        local ____t_1749 = __t
        local ____t_1747 = __t
        local ____t_1745 = __t
        local ____t_1743 = __t
        local ____temp_1742 = __L1.scene ~= 1
        __O[1960] = ____temp_1742
        local ____temp_1744 = if ____t_1743(____temp_1742) then __O[1960] else __L1.room
        __O[1961] = ____temp_1744
        local ____temp_1746 = if ____t_1745(____temp_1744) then __O[1961] else __L1.arena
        __O[1962] = ____temp_1746
        local ____temp_1748 = if ____t_1747(____temp_1746) then __O[1962] else __L1.activeBoss
        __O[1963] = ____temp_1748
        local ____temp_1750 = if ____t_1749(____temp_1748) then __O[1963] else __L1.dialog
        __O[1964] = ____temp_1750
        local ____temp_1752 = if ____t_1751(____temp_1750) then __O[1964] else __L1.cutscene
        __O[1965] = ____temp_1752
        local ____temp_1754 = if ____t_1753(____temp_1752) then __O[1965] else __L1.vehicle
        __O[1966] = ____temp_1754
        local ____temp_1756 = if ____t_1755(____temp_1754) then __O[1966] else __L1.paused
        __O[1967] = ____temp_1756
        if ____t_1758(if ____t_1757(____temp_1756) then __O[1967] else __L1.defeated) then
            return
        end
        for ____, e in __iterar((__L1.enemies)) do
            if __t(not __t(__L1:isSchoolMonitor(e)) or __le(e.hp, 0)) then
                continue
            end
            e.monitorCooldown = math.max(0, e.monitorCooldown - dt)
            e.patrolTime = __add(if __t(e.patrolTime) then e.patrolTime else 0, dt)
            e.x = e.x + e.monitorDir * 33 * dt
            if __gt(e.x, e.homeX + 88) then
                e.x = e.homeX + 88
                e.monitorDir = -1
            elseif __lt(e.x, e.homeX - 88) then
                e.x = e.homeX - 88
                e.monitorDir = 1
            end
            local ____t_1761 = __t
            local ____t_1760 = __t
            local ____temp_1759 = not __t(__get(
                __L1.q,
                __add(e.type, "Sneak")
            )) and not __t(__get(__L1.q, e.type))
            __O[1968] = ____temp_1759
            if ____t_1761(if ____t_1760(____temp_1759) then __gt(__L1.player.x, e.homeX + 390) else __O[1968]) then
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
                    __add("Passou sem ser visto por ", if e.type == "igor" then "Igor" else "Kaique"),
                    "! +120 XP de furtividade."
                ))
                __L1:save()
            end
            local ____t_1763 = __t
            local ____le_result_1762 = __le(e.monitorCooldown, 0)
            __O[1969] = ____le_result_1762
            local seen = if ____t_1763(____le_result_1762) then __L1:monitorSees(e) else __O[1969]
            e.monitorSuspicion = __L1:clamp(
                __add(if __t(e.monitorSuspicion) then e.monitorSuspicion else 0, if __t(seen) then dt else __TS__Number(-dt) * 2.4),
                0,
                1.2
            )
            local ____t_1766 = __t
            local ____t_1765 = __t
            local ____temp_1764 = if __t(seen) then __gt(e.monitorSuspicion, 0.25) else seen
            __O[1970] = ____temp_1764
            if ____t_1766(if ____t_1765(____temp_1764) then not __t(e.monitorHint) else __O[1970]) then
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
        local kaique = __call(
            __L1.enemies,
            "find",
            function(____, e)
                local ____t_1768 = __t
                local ____temp_1767 = e.type == "kaique" and __gt(e.hp, 0)
                __O[1971] = ____temp_1767
                return if ____t_1768(____temp_1767) then not __t(e.iraciTriggered) else __O[1971]
            end
        )
        local ____t_1773 = __t
        local ____call_1772 = __call
        local ____t_1771 = __t
        local ____opt_1769 = window.WorldData
        if ____opt_1769 ~= nil then
            ____opt_1769 = ____opt_1769.iraciTraps
        end
        __O[1972] = ____opt_1769
        if ____t_1773(if __t(kaique) then ____call_1772(
            if ____t_1771(____opt_1769) then __O[1972] else __arrL({}, 0),
            "some",
            function(____, t) return math.abs(__L1.player.x - t.x) < t.width / 2 and __gt(__L1.player.y, __L1.FLOOR - 18) end
        ) else kaique) then
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
                local ____e_1776 = e
                local ____t_1775 = __t
                local ____TS__MathSign_result_1774 = __TS__MathSign(e.targetX - e.x)
                __O[1973] = ____TS__MathSign_result_1774
                ____e_1776.dashDir = if ____t_1775(____TS__MathSign_result_1774) then __O[1973] else -1
                e.rollAngle = 0
                return
            end
            do
                local i = 0
                while i < if e.phase == 3 then 2 else 1 do
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
            local ____e_1779 = e
            local ____t_1778 = __t
            local ____TS__MathSign_result_1777 = __TS__MathSign(e.targetX - e.x)
            __O[1974] = ____TS__MathSign_result_1777
            ____e_1779.dashDir = if ____t_1778(____TS__MathSign_result_1777) then __O[1974] else -1
            return
        end
        if e.kind == "monitorReload" then
            e.state = "firing"
            e.stateTimer = 0.18
            __L1:floating(e.x, e.y - 130, "RECARREGANDO!", "#d8e9b0")
            return
        end
        local sweep = e.kind == "monitorSweep"
        local count = if __t(sweep) then 4 + e.phase else 5 + e.phase + if __t(e.rage) then 2 else 0
        local ____t_1781 = __t
        local ____TS__MathSign_result_1780 = __TS__MathSign(e.targetX - e.x)
        __O[1975] = ____TS__MathSign_result_1780
        local direction = if ____t_1781(____TS__MathSign_result_1780) then __O[1975] else -1
        local angle = if __t(sweep) then if direction > 0 then 0 else math.pi else math.atan2(e.targetY - (e.y - 53), e.targetX - e.x)
        do
            local i = 0
            while __lt(i, count) do
                local spread = if __t(sweep) then 0 else __get(
                    __arrL({-0.1, 0.04, -0.04, 0.1}, 4),
                    __mod(i, 4)
                )
                __call(
                    __L1.shots,
                    "push",
                    {
                        x = e.x + direction * 35,
                        y = if __t(sweep) then __L1.FLOOR - 24 else e.y - 53,
                        vx = math.cos(angle + spread) * if __t(e.rage) then 295 else 250,
                        vy = math.sin(angle + spread) * if __t(e.rage) then 295 else 250,
                        delay = i * if __t(e.rage) then 0.105 else 0.14,
                        life = 4,
                        type = "enemyBullet",
                        owner = "enemy",
                        damage = if __t(e.rage) then 13 else 10
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
        local ____t_1787 = __t
        local ____t_1785 = __t
        local ____t_1783 = __t
        local ____TS__Number_result_1782 = __TS__Number(e.baseMax)
        __O[1976] = ____TS__Number_result_1782
        local ____temp_1784 = if ____t_1783(____TS__Number_result_1782) then __O[1976] else __TS__Number(profile.hp)
        __O[1977] = ____temp_1784
        local ____temp_1786 = if ____t_1785(____temp_1784) then __O[1977] else __TS__Number(e.max)
        __O[1978] = ____temp_1786
        local base = if ____t_1787(____temp_1786) then __O[1978] else 100
        return if __t(profile.phaseHP) then __arr(__TS__Spread(__iter(profile.phaseHP))) else __call(
            if e.type == "nikolas" then __arrL({1, 1.2, 1.4, 1.65}, 4) else __arrL({1, 1.25, 1.5}, 3),
            "map",
            function(____, value) return math.floor(base * value + 0.5) end
        )
    end
    __L1.beginBossPhase = function(self, e, phase)
        local bars = if __t(e.phaseHP) then e.phaseHP else __L1:bossPhaseHP(e)
        e.phaseHP = bars
        e.phaseCount = __len(bars)
        e.phase = __L1:clamp(
            phase,
            1,
            __len(bars)
        )
        local ____e_1789 = e
        local ____get_result_1788 = __get(bars, e.phase - 1)
        e.phaseMaxHp = ____get_result_1788
        ____e_1789.max = ____get_result_1788
        e.hp = e.max
        e.announcedPhase = e.phase
        e.pattern = 0
        e.state = "phaseChange"
        e.phaseDuration = if e.type == "nikolas" then 3.6 else 1.05
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
            local ____e_1792 = e
            local ____e_1791 = e
            local ____e_phaseDuration_1790 = e.phaseDuration
            e.damageLock = ____e_phaseDuration_1790
            ____e_1791.phaseTransitionTimer = ____e_phaseDuration_1790
            ____e_1792.stateTimer = ____e_phaseDuration_1790
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
            __L1:beep(if __t(cap) then 165 + e.phase * 38 else 245, 0.17, "triangle", 0.023)
            return
        end
        if e.type == "nikolas" then
            e.form = __get(
                __arrL({"normal", "muscular", "flying", "giant"}, 4),
                e.phase - 1
            )
            e.kind = if e.phase == 2 then "muscleClap" else if e.phase == 3 then "auraComets" else "giantPalm"
            e.targetX = __L1.player.x
            e.targetY = __L1.player.y - 30
        else
            e.y = __L1.FLOOR
            local kit = __get(__L1.bossPhaseSkills, e.type)
            local ____e_1795 = e
            local ____t_1794 = __t
            local ____getq_result_1793 = __getq(kit, e.phase - 2)
            __O[1979] = ____getq_result_1793
            ____e_1795.kind = if ____t_1794(____getq_result_1793) then __O[1979] else "fan"
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
        __L1.shake = math.max(__L1.shake, if e.type == "nikolas" then 10 else 7)
        __L1:epicFreeze(0.16)
        __L1.epic.flash = 0.4
        __L1.epic.flashColor = if e.type == "nikolas" then "#ffe18b" else "#f3d9ff"
        __L1:epicRing(e.x, e.y - 60, if e.type == "nikolas" then "#ffe18b" else "#deb4f0", 1.3)
        __L1:fx(
            e.x,
            e.y - 60,
            if e.type == "nikolas" then "#ffe18b" else if e.type == "menezes" then "#efbfd3" else "#deb4f0",
            if e.type == "nikolas" then 46 else 24,
            170
        )
        __L1:epicPlate(if e.type == "nikolas" then __get(
            __arrL({
                "",
                "NOVA FORMA!",
                "SHAPE DO CALEB!",
                "AURA ASCENDENTE!",
                "TITÃ DO CATARRO!"
            }, 5),
            e.phase
        ) else __add("FASE ", e.phase), if __ge(e.phase, if __t(e.phaseCount) then e.phaseCount else 3) then "ÚLTIMA FASE · VIDA RENOVADA" else "VIDA RENOVADA · O CHEFE FICOU MAIS FORTE", "#ffb36b", 1.7)
        __L1:beep(if __ge(e.phase, 3) then 190 else 290, 0.24, "triangle", 0.025)
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
            shot.damage = if ____type == "smoke" then 10 else 12
        end
    end
    __L1.executePhaseSkill = function(self, e)
        if __t(e.type == "giant" or not __t(__get(__L1.bossPhaseSkillNames, e.kind))) then
            return false
        end
        local ____t_1797 = __t
        local ____TS__MathSign_result_1796 = __TS__MathSign(e.targetX - e.x)
        __O[1980] = ____TS__MathSign_result_1796
        local direction = if ____t_1797(____TS__MathSign_result_1796) then __O[1980] else -1
        local phase = if __t(e.phase) then e.phase else 1
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
                        __call(
                            __L1.shots,
                            "push",
                            {
                                x = if side < 0 then __get(__L1.arena.bounds, 0) + 35 else __get(__L1.arena.bounds, 1) - 35,
                                y = __L1.FLOOR - if __t(__mod(wave, 2)) then 155 else 27,
                                vx = __TS__Number(-side) * 215,
                                vy = 0,
                                delay = wave * 0.6 + if side > 0 then 0.22 else 0,
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
                    function(____, m) return if __t(m.summoned) then not __t(m.dead) else m.summoned end
                ))
            )
            do
                local i = 0
                while i < count do
                    local side = if __t(__mod(i, 2)) then 1 else -1
                    local x = if side < 0 then __get(__L1.arena.bounds, 0) + 45 else __get(__L1.arena.bounds, 1) - 45
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
            local angle = math.atan2(e.targetY - (e.y - 70), e.targetX - e.x)
            do
                local i = 0
                while i < 6 do
                    __call(
                        __L1.shots,
                        "push",
                        {
                            x = e.x + direction * 35,
                            y = e.y - if __t(__mod(i, 2)) then 100 else 35,
                            vx = math.cos(angle + if __t(__mod(i, 2)) then 0.12 else -0.12) * 235,
                            vy = math.sin(angle + if __t(__mod(i, 2)) then 0.12 else -0.12) * 235,
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
                                e.x + if __t(i) then 140 else -140,
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
                        local x = if side < 0 then __get(__L1.arena.bounds, 0) + 40 else __get(__L1.arena.bounds, 1) - 40
                        local y = 105 + i * 45
                        local angle = math.atan2(e.targetY - y, e.targetX - x)
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
                    __call(__L1.shots, "push", {
                        x = e.x + direction * 35,
                        y = __L1.FLOOR - if __t(__mod(i, 2)) then 145 else 25,
                        vx = direction * 255,
                        vy = 0,
                        delay = i * 0.18,
                        life = 4,
                        type = "enemyBullet",
                        owner = "enemy",
                        damage = 10
                    })
                    i = i + 1
                end
            end
        elseif e.kind == "monitorGrid" then
            do
                local i = 0
                while i < 7 do
                    local y = __L1.FLOOR - 25 - i * 47
                    if i == 3 then
                        continue
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
                    i = i + 1
                end
            end
        end
        e.state = "firing"
        e.stateTimer = if __t(__call(
            __arrL({"bellyQuake", "slapClap"}, 2),
            "includes",
            e.kind
        )) then 1.65 else if e.kind == "doubleStomp" then 1.25 else 0.72
        __L1:fx(
            e.x,
            e.y - 45,
            if e.type == "nikolas" then "#d0e58c" else if e.type == "menezes" then "#efc0d2" else "#e4bfed",
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
            function(____, best, x, i) return if math.abs(x - e.targetX) < math.abs(__get(e.slamLanes, best) - e.targetX) then i else best end,
            0
        )
        e.safeLaneX = __get(e.slamLanes, e.safeLaneIndex)
        e.safeLaneWidth = width * 0.65
        e.safeLaneTime = 3.25
    end
    __L1.executeNikolasFormAttack = function(self, e)
        local ____t_1800 = __t
        local ____t_1799 = __t
        local ____temp_1798 = e.type ~= "nikolas" or __lt(e.phase, 2)
        __O[1981] = ____temp_1798
        if ____t_1800(if ____t_1799(____temp_1798) then __O[1981] else not __t(__get(__L1.nikolasPhaseWarnings, e.kind))) then
            return false
        end
        if e.kind == "goldenRush" then
            e.state = "dashing"
            e.stateTimer = 0.38
            local ____e_1803 = e
            local ____t_1802 = __t
            local ____TS__MathSign_result_1801 = __TS__MathSign(e.targetX - e.x)
            __O[1982] = ____TS__MathSign_result_1801
            ____e_1803.dashDir = if ____t_1802(____TS__MathSign_result_1801) then __O[1982] else -1
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
                            local direction = if __lt(e.targetX, e.x) then -1 else 1
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
        e.stateTimer = if e.kind == "giantStomp" then 1.9 else if e.kind == "giantSlam" then 1.4 else 0.85
        __L1:fx(
            e.x,
            e.y - if e.phase == 4 then 200 else 60,
            if e.phase == 3 then "#cbb7ff" else "#ffe2a0",
            22,
            150
        )
        __L1:beep(if e.phase == 4 then 75 else 125, 0.16, "sawtooth", 0.02)
        return true
    end
    __L1.bossDefaults = function(self, e)
        local ____assign_1806 = __assign
        local ____e_1805 = e
        local ____e_homeX_1804 = e.homeX
        if ____e_homeX_1804 == nil then
            ____e_homeX_1804 = e.x
        end
        ____assign_1806(____e_1805, {
            homeX = ____e_homeX_1804,
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
        local ____t_1809 = __t
        local ____t_1808 = __t
        local ____temp_1807 = e.type ~= "giant"
        __O[1983] = ____temp_1807
        if ____t_1809(if ____t_1808(____temp_1807) then __get(__L1.bossPhaseSkills, e.type) else __O[1983]) then
            e.phaseHP = __L1:bossPhaseHP(e)
            e.phaseCount = __len(e.phaseHP)
            e.baseMax = __get(e.phaseHP, 0)
            local ____e_1812 = e
            local ____e_1811 = e
            local ____e_baseMax_1810 = e.baseMax
            e.phaseMaxHp = ____e_baseMax_1810
            ____e_1811.max = ____e_baseMax_1810
            ____e_1812.hp = ____e_baseMax_1810
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
            e.phase = if e.hp / e.max > 0.66 then 1 else if e.hp / e.max > 0.33 then 2 else 3
        else
            e.phase = __L1:clamp(if __t(e.phase) then e.phase else 1, 1, if __t(e.phaseCount) then e.phaseCount else 3)
        end
        local kinds = if e.type == "igor" then __arrL({"bellyBounce", "bellyRoll", "bellyClap", "bellyBounce"}, 4) else if e.type == "kaique" then if __t(e.rage) then __arrL({"monitorBurst", "monitorSweep", "monitorBurst", "dash"}, 4) else __arrL({"monitorBurst", "monitorSweep", "monitorReload", "dash"}, 4) else if e.type == "marco" then if __t(e.rage) then __arrL({
            "brainrots",
            "inkSlam",
            "sketchLine",
            "dash",
            "sixseven",
            "sketchSwarm",
            "mines"
        }, 7) else if e.phase == 1 then __arrL({
            "fan",
            "inkSlam",
            "sketchLine",
            "sketchSwarm",
            "mines"
        }, 5) else __arrL({
            "sketchSwarm",
            "fan",
            "inkSlam",
            "sketchLine",
            "dash",
            "mines"
        }, 6) else if e.type == "menezes" then if e.phase == 1 then __arrL({"wordWalls", "sewerDive", "ratsArmy", "echo"}, 4) else if e.phase == 2 then __arrL({
            "wordWalls",
            "sewerDive",
            "echo",
            "ratsArmy",
            "ring",
            "provokeZone",
            "dash"
        }, 7) else __arrL({
            "sewerDive",
            "echo",
            "ratsArmy",
            "wordWalls",
            "ring",
            "sewerDive",
            "provokeZone",
            "echo",
            "dash"
        }, 9) else if e.type == "dede" then if e.phase == 1 then __arrL({"smokeFan", "bitucas", "smokeVeil", "dash"}, 4) else if e.phase == 2 then __arrL({
            "bitucas",
            "tragada",
            "smokeFan",
            "cloudMines",
            "smokeVeil",
            "dash"
        }, 6) else __arrL({
            "tragada",
            "cinzas",
            "bitucas",
            "smokeVeil",
            "cloudMines",
            "dash"
        }, 6) else if e.type == "arthur" then __arrL({"poseFan", "dash", "poseWave", "poseFan"}, 4) else if e.type == "freddy" then __arrL({"heavyFan", "dash", "stomp", "heavyFan"}, 4) else if e.type == "nicolas" then if e.phase == 1 then __arrL({"astralFan", "skyLances", "dash"}, 3) else if e.phase == 2 then __arrL({"skyLances", "supremeRing", "astralFan", "dash"}, 4) else __arrL({"supremeRing", "skyLances", "dash", "astralFan"}, 4) else if e.type == "reeisBoss" then __arrL({"gangFan", "dash", "mines", "gangFan"}, 4) else if e.type == "giant" then __arrL({"slam", "doodleRain", "summonInk", "dash"}, 4) else if __t(e.type == "nikolas" and e.phase == 3) then __arrL({
            "slimeFan",
            "slimeRain",
            "dash",
            "mines",
            "slimeFan",
            "dash"
        }, 6) else __arrL({"slimeFan", "dash", "slimeRain", "mines"}, 4)
        if __t(e.type == "nikolas" and __gt(e.phase, 1)) then
            local ____t_1814 = __t
            local ____get_result_1813 = __get(__L1.nikolasPhasePatterns, e.phase)
            __O[1984] = ____get_result_1813
            kinds = if ____t_1814(____get_result_1813) then __O[1984] else __get(__L1.nikolasPhasePatterns, 4)
        end
        local ____t_1817 = __t
        local ____t_1816 = __t
        local ____temp_1815 = e.type ~= "giant" and e.type ~= "nikolas"
        __O[1985] = ____temp_1815
        if ____t_1817(if ____t_1816(____temp_1815) then __ge(e.phase, 2) else __O[1985]) then
            local kit = __get(__L1.bossPhaseSkills, e.type)
            if __t(kit) then
                local ____arr_1819 = __arr
                local ____array_1818 = __TS__SparseArrayNew(__TS__Spread(__iter(if e.phase == 3 then __arrL(
                    {
                        __get(kit, 1),
                        __get(kit, 0)
                    },
                    2
                ) else __arrL(
                    {__get(kit, 0)},
                    1
                ))))
                __TS__SparseArrayPush(
                    ____array_1818,
                    __TS__Spread(__iter(kinds))
                )
                kinds = ____arr_1819(__TS__SparseArraySpread(____array_1818))
            end
        end
        local ____e_1826 = e
        local ____get_1825 = __get
        local ____kinds_1824 = kinds
        local ____mod_1823 = __mod
        local ____e_1820, ____pattern_1821 = e, "pattern"
        local ____e_pattern_1822 = ____e_1820[____pattern_1821]
        ____e_1820[____pattern_1821] = ____e_pattern_1822 + 1
        ____e_1826.kind = ____get_1825(
            ____kinds_1824,
            ____mod_1823(
                ____e_pattern_1822,
                __len(kinds)
            )
        )
        e.wallGapY = __get(
            __arrL({__L1.FLOOR - 42, 300, if e.phase == 3 then 195 else __L1.FLOOR - 42}, 3),
            __mod(e.pattern, 3)
        )
        e.targetX = __L1.player.x
        e.targetY = __L1.player.y - 30
        e.state = "windup"
        e.stateTimer = if __t(__call(
            __arrL({"nikolas", "giant", "nicolas"}, 3),
            "includes",
            e.type
        )) then 1.25 else 1.05 - (e.phase - 1) * 0.12 - if __t(e.rage) then 0.2 else 0
        local profile = __L1:bossProfile(e)
        e.stateTimer = math.max(profile.minWindup, (e.stateTimer - if e.type == "marco" then 0.1 else 0) * profile.windup)
        e.windupDuration = e.stateTimer
        if __t(e.type == "dede" and e.kind == "tragada") then
            local ____opt_1829 = e.fxTrago
            if ____opt_1829 ~= nil then
                ____opt_1829 = ____opt_1829.parar
            end
            if ____opt_1829 ~= nil then
                ____opt_1829(____opt_1829)
            end
            local ____e_1837 = e
            local ____t_1836 = __t
            local ____opt_1833 = window.FxPixel
            if ____opt_1833 ~= nil then
                ____opt_1833 = ____opt_1833.tocar
            end
            local ____opt_result_1835
            if ____opt_1833 ~= nil then
                ____opt_result_1835 = ____opt_1833(
                    ____opt_1833,
                    "arcane/spell-charge",
                    {
                        x = e.x + __TS__MathSign(e.targetX - e.x) * 14,
                        y = e.y + 2,
                        palette = window.FxPixel.PAL.fumaca,
                        duracao = 1.5
                    }
                )
            end
            __O[1986] = ____opt_result_1835
            ____e_1837.fxTrago = if ____t_1836(____opt_result_1835) then __O[1986] else nil
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
            e.emergeX = __get(
                if __t(__len(choices)) then choices else candidates,
                __mod(e.pattern, if __t(__len(choices)) then __len(choices) else __len(candidates))
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
            __L1:toast(if e.type == "nicolas" then __add(
                __add("AURA SUPREMA · FASE ", e.phase),
                "! Pule as ondas, saia dos raios e ataque nas pausas."
            ) else "O chefão acelerou! Observe o aviso laranja e ataque na recuperação.")
        end
    end
    __L1.engageBoss = function(self, e)
        local ____t_1852 = __t
        local ____t_1851 = __t
        local ____t_1849 = __t
        local ____t_1847 = __t
        local ____t_1845 = __t
        local ____t_1843 = __t
        local ____t_1841 = __t
        local ____t_1839 = __t
        local ____temp_1838 = if __t(__L1.activeBoss) then __L1.activeBoss else __le(e.hp, 0)
        __O[1987] = ____temp_1838
        local ____temp_1840 = if ____t_1839(____temp_1838) then __O[1987] else __L1.defeated
        __O[1988] = ____temp_1840
        local ____temp_1842 = if ____t_1841(____temp_1840) then __O[1988] else __L1.won
        __O[1989] = ____temp_1842
        local ____temp_1844 = if ____t_1843(____temp_1842) then __O[1989] else __L1.room
        __O[1990] = ____temp_1844
        local ____temp_1846 = if ____t_1845(____temp_1844) then __O[1990] else __L1.cutscene
        __O[1991] = ____temp_1846
        local ____temp_1848 = if ____t_1847(____temp_1846) then __O[1991] else __L1.activity
        __O[1992] = ____temp_1848
        local ____temp_1850 = if ____t_1849(____temp_1848) then __O[1992] else __L1.dialog
        __O[1993] = ____temp_1850
        if ____t_1852(if ____t_1851(____temp_1850) then __O[1993] else __L1.paused) then
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
        local ____e_1859 = e
        local ____t_1858 = __t
        local ____opt_1855 = window.Difficulty
        if ____opt_1855 ~= nil then
            ____opt_1855 = ____opt_1855.getMode
        end
        local ____opt_result_1857
        if ____opt_1855 ~= nil then
            ____opt_result_1857 = ____opt_1855(____opt_1855)
        end
        __O[1994] = ____opt_result_1857
        ____e_1859.difficultyMode = if ____t_1858(____opt_result_1857) then __O[1994] else "normal"
        local ____e_1866 = e
        local ____t_1865 = __t
        local ____opt_1862 = window.Difficulty
        if ____opt_1862 ~= nil then
            ____opt_1862 = ____opt_1862.boss
        end
        local ____opt_result_1864
        if ____opt_1862 ~= nil then
            ____opt_result_1864 = ____opt_1862(____opt_1862, e.type, e.difficultyMode)
        end
        __O[1995] = ____opt_result_1864
        ____e_1866.difficultyProfile = if ____t_1865(____opt_result_1864) then __O[1995] else nil
        if __t(e.difficultyProfile) then
            local ____e_1869 = e
            local ____e_1868 = e
            local ____e_difficultyProfile_hp_1867 = e.difficultyProfile.hp
            e.baseMax = ____e_difficultyProfile_hp_1867
            ____e_1868.max = ____e_difficultyProfile_hp_1867
            ____e_1869.hp = ____e_difficultyProfile_hp_1867
            e.phaseHP = if __t(e.difficultyProfile.phaseHP) then __arr(__TS__Spread(__iter(e.difficultyProfile.phaseHP))) else nil
            __L1:bossDefaults(e)
        end
        local ____opt_1870 = window.C2Luta
        if ____opt_1870 ~= nil then
            ____opt_1870 = ____opt_1870.skin
        end
        local c2 = ____opt_1870
        if __t(if __t(c2) then e.type == c2.kit else c2) then
            e.phaseHP = window.ConquistaCombate:barras(
                c2.tema,
                math.floor(e.hp * c2.vida + 0.5)
            )
            e.phaseCount = __len(e.phaseHP)
            local ____e_1875 = e
            local ____e_1874 = e
            local ____e_1873 = e
            local ____get_result_1872 = __get(e.phaseHP, 0)
            e.phaseMaxHp = ____get_result_1872
            ____e_1873.baseMax = ____get_result_1872
            ____e_1874.max = ____get_result_1872
            ____e_1875.hp = ____get_result_1872
        end
        __L1.activeBoss = e
        __L1.vehicle = false
        local ____L1_epic_1881 = __L1.epic
        local ____t_1877 = __t
        local ____temp_1876 = __L1:nomeBoss(e.type)
        __O[1996] = ____temp_1876
        local ____temp_1880 = if ____t_1877(____temp_1876) then __O[1996] else "Chefe"
        local ____t_1879 = __t
        local ____table_level_1878 = __L1:bossProfile(e).level
        __O[1997] = ____table_level_1878
        ____L1_epic_1881.intro = {
            age = 0,
            name = ____temp_1880,
            level = if ____t_1879(____table_level_1878) then __O[1997] else 1,
            color = if e.type == "nikolas" then "#a6d05d" else if e.type == "menezes" then "#efbfd3" else if e.type == "giant" then "#f0a35b" else "#e9b45c",
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
        if __t(if __t(c2) then e.type == c2.kit else c2) then
            local ____e_1890 = e
            local ____self_1888 = window.ConquistaCombate
            local ____self_1888_criar_1889 = ____self_1888.criar
            local ____array_1887 = __TS__SparseArrayNew(
                c2.tema,
                e.x,
                __L1.FLOOR,
                __TS__Spread(__iter(__L1.arena.bounds))
            )
            local ____opt_1884 = window.Difficulty
            if ____opt_1884 ~= nil then
                ____opt_1884 = ____opt_1884.getSettings
            end
            local ____opt_result_1886
            if ____opt_1884 ~= nil then
                ____opt_result_1886 = ____opt_1884(____opt_1884, e.difficultyMode)
            end
            __TS__SparseArrayPush(
                ____array_1887,
                ____opt_result_1886,
                __L1:bossProfile(e).recovery
            )
            ____e_1890.conquista = ____self_1888_criar_1889(
                ____self_1888,
                __TS__SparseArraySpread(____array_1887)
            )
            __L1.epic.intro = nil
            return true
        end
        local ____L1_toast_1903 = __L1.toast
        local ____add_1902 = __add
        local ____add_1901 = __add
        local ____add_1900 = __add
        local ____t_1899 = __t
        local ____opt_1895 = window.Difficulty
        if ____opt_1895 ~= nil then
            ____opt_1895 = ____opt_1895.getSettings
        end
        local ____opt_result_1897
        if ____opt_1895 ~= nil then
            ____opt_result_1897 = ____opt_1895(____opt_1895, e.difficultyMode)
        end
        local ____opt_result_1898
        if ____opt_result_1897 ~= nil then
            ____opt_result_1898 = ____opt_result_1897.label
        end
        __O[1998] = ____opt_result_1898
        ____L1_toast_1903(
            __L1,
            ____add_1902(
                ____add_1901(
                    ____add_1900(if ____t_1899(____opt_result_1898) then __O[1998] else "NORMAL", " · Nv. "),
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
        local ____opt_1906 = window.CampaignVfx
        if ____opt_1906 ~= nil then
            ____opt_1906 = ____opt_1906.emit
        end
        if ____opt_1906 ~= nil then
            ____opt_1906(
                ____opt_1906,
                "cast",
                {
                    x = e.x + __TS__MathSign(e.targetX - e.x) * 26,
                    y = e.y - 42,
                    dir = __TS__MathSign(e.targetX - e.x),
                    kind = ____type
                }
            )
        end
        local a = math.atan2(e.targetY - (e.y - 42), e.targetX - e.x)
        do
            local i = 0
            while __lt(i, count) do
                local angle = a + (i - (count - 1) / 2) * spread
                __call(
                    __L1.shots,
                    "push",
                    {
                        x = e.x + __TS__MathSign(e.targetX - e.x) * 30,
                        y = e.y - 42,
                        vx = math.cos(angle) * speed,
                        vy = math.sin(angle) * speed,
                        life = 5,
                        type = ____type,
                        owner = "enemy",
                        damage = if ____type == "smoke" then 10 else if ____type == "confetti" then 12 else if ____type == "word" then 12 else if ____type == "doodle" then if __gt(e.angry, 0) then 18 else 13 else 16,
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
                damage = if ____type == "slime" then 19 else 16
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
                local ____math_floor_result_1908 = math.floor(m.max * 1.15 + 0.5)
                m.max = ____math_floor_result_1908
                m.hp = ____math_floor_result_1908
                m.damage = math.floor(m.damage * 1.25 + 0.5)
                m.speed = if __t(m.speed) then m.speed else 75 * 1.2
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
        local ____t_1911 = __t
        local ____t_1910 = __t
        local ____temp_1909 = e.type == "nikolas" and e.kind == "slimeFan"
        __O[1999] = ____temp_1909
        if ____t_1911(if ____t_1910(____temp_1909) then e.phase == 3 else __O[1999]) then
            __L1:bossFan(
                e,
                "slime",
                5,
                258,
                0.17
            )
            local angle = math.atan2(e.targetY - (e.y - 42), e.targetX - e.x)
            local ____t_1913 = __t
            local ____TS__MathSign_result_1912 = __TS__MathSign(e.targetX - e.x)
            __O[2000] = ____TS__MathSign_result_1912
            local direction = if ____t_1913(____TS__MathSign_result_1912) then __O[2000] else -1
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
            local ____t_1915 = __t
            local ____TS__MathSign_result_1914 = __TS__MathSign(e.targetX - e.x)
            __O[2001] = ____TS__MathSign_result_1914
            local direction = if ____t_1915(____TS__MathSign_result_1914) then __O[2001] else -1
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
            local ____e_1918 = e
            local ____t_1917 = __t
            local ____TS__MathSign_result_1916 = __TS__MathSign(e.targetX - e.x)
            __O[2002] = ____TS__MathSign_result_1916
            ____e_1918.dashDir = if ____t_1917(____TS__MathSign_result_1916) then __O[2002] else -1
            __L1:beep(100, 0.14, "sawtooth")
            return
        end
        if e.kind == "mines" then
            do
                local i = -1
                while i <= 1 do
                    __L1:addHazard(
                        e.targetX + i * if e.phase == 3 then 115 else 140,
                        if e.type == "nikolas" then "slime" else if e.type == "marco" then "ink" else "word",
                        0.7 + math.abs(i) * 0.12,
                        if e.phase == 3 then 63 else 53
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
                if e.kind == "fan" then "doodle" else if e.kind == "words" then "word" else "slime",
                if e.phase == 1 then 3 else if e.phase == 2 then 5 else 7 + if __t(e.type == "marco" and __gt(e.phase, 1)) then 2 else 0,
                if __gt(e.angry, 0) then 265 else 205 + e.phase * 26 + if e.type == "marco" then 15 else 0,
                if e.type == "menezes" then 0.18 else 0.15
            )
        end
        e.state = "firing"
        e.stateTimer = 0.45
        __L1:fx(
            e.x,
            e.y - 38,
            if e.type == "nikolas" then "#c3da73" else if e.type == "marco" then "#d1a6e8" else "#e2acba",
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
        e.charge = if f.estado == "windup" then 100 * __L1:clamp(f.tempo / f.dur, 0, 1) else 0
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
        local ____t_1925 = __t
        local ____t_1922 = __t
        local ____t_1920 = __t
        local ____temp_1919 = f.estado == "phaseChange"
        __O[2003] = ____temp_1919
        local ____temp_1921 = if ____t_1920(____temp_1919) then __O[2003] else __L1.defeated
        __O[2004] = ____temp_1921
        local ____opt_1923 = __L1.sandbox
        if ____opt_1923 ~= nil then
            ____opt_1923 = ____opt_1923.result
        end
        if ____t_1925(if ____t_1922(____temp_1921) then __O[2004] else ____opt_1923) then
            return
        end
        local corpo = if __t(f.gemeoX ~= nil and math.abs(__L1.player.x - f.gemeoX) < math.abs(__L1.player.x - e.x)) then f.gemeoX else e.x
        if __t(if f.slug == "jorge" then window.JorgeDuelo:toca(
            f,
            __L1.player.x,
            __L1.player.y - 26,
            12,
            26
        ) else math.abs(__L1.player.y - e.y) < 62 and math.abs(__L1.player.x - corpo) < 34) then
            __L1:hurt(
                math.floor(13 * __L1:bossProfile(e).damage + 0.5),
                corpo
            )
        end
    end
    __L1.updateEnemies = function(self, dt)
        for ____, e in __iterar((__L1.enemies)) do
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
                e.burnTick = __add(if __t(e.burnTick) then e.burnTick else 0, dt)
                if __gt(e.burnTick, 0.6) then
                    e.burnTick = 0
                    __L1:damageEnemy(e, 5)
                end
            end
        end
        for ____, e in __iterar((__L1.enemies)) do
            local ____t_1930 = __t
            local ____t_1929 = __t
            local ____t_1927 = __t
            local ____temp_1926 = not __t(e.conquista) and __gt(e.hp, 0)
            __O[2005] = ____temp_1926
            local ____temp_1928 = if ____t_1927(____temp_1926) then e.type == "dede" else __O[2005]
            __O[2006] = ____temp_1928
            if ____t_1930(if ____t_1929(____temp_1928) then math.abs(e.x - __L1.player.x) < 650 else __O[2006]) then
                e.tauntTimer = e.tauntTimer - dt
                if __le(e.tauntTimer, 0) then
                    e.tauntTimer = 6
                    __L1:floating(e.x, e.y - 115, "SEU GILÓ HOMI!", "#e1eccd")
                end
            end
        end
        for ____, e in __iterar((__L1.enemies)) do
            local ____t_1935 = __t
            local ____t_1934 = __t
            local ____t_1932 = __t
            local ____temp_1931 = not __t(e.conquista) and __gt(e.hp, 0)
            __O[2007] = ____temp_1931
            local ____temp_1933 = if ____t_1932(____temp_1931) then e.type == "freddy" else __O[2007]
            __O[2008] = ____temp_1933
            if ____t_1935(if ____t_1934(____temp_1933) then math.abs(e.x - __L1.player.x) < 650 else __O[2008]) then
                e.tauntTimer = e.tauntTimer - dt
                if __le(e.tauntTimer, 0) then
                    e.tauntTimer = 6
                    __L1:floating(e.x, e.y - 125, if __t(__mod(e.pattern, 2)) then "OPEESTY DA ROÇA!" else "Ô REEEIS! Seu capanga tá trabalhando!", "#efd19d")
                end
            end
        end
        __L1:updateSchoolMonitors(dt)
        local e = __L1.activeBoss
        local ____t_1938 = __t
        local ____t_1937 = __t
        local ____temp_1936 = not __t(e) or __le(e.hp, 0)
        __O[2009] = ____temp_1936
        if ____t_1938(if ____t_1937(____temp_1936) then __O[2009] else if __t(__L1.arena) then __L1.arena.phase ~= "active" else __L1.arena) then
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
        local ____t_1941 = __t
        local ____t_1940 = __t
        local ____temp_1939 = e.type == "nikolas" and e.phase == 3
        __O[2010] = ____temp_1939
        if ____t_1941(if ____t_1940(____temp_1939) then e.state ~= "phaseChange" else __O[2010]) then
            e.flightTime = __add(if __t(e.flightTime) then e.flightTime else 0, dt)
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
                e.y = if e.phase == 3 then __L1.FLOOR - 110 * progress else if e.phase == 4 then if __t(e.phaseStartY) then e.phaseStartY else __L1.FLOOR + (__L1.FLOOR - if __t(e.phaseStartY) then e.phaseStartY else __L1.FLOOR) * progress else __L1.FLOOR
                if e.phase == 4 then
                    e.x = if __t(e.phaseStartX) then e.phaseStartX else e.homeX + (__get(__L1.arena.bounds, 1) - 200 - if __t(e.phaseStartX) then e.phaseStartX else e.homeX) * progress
                end
                if math.random() < 0.65 then
                    __L1:fx(
                        __add(
                            e.x,
                            __L1:rand(-60, 60)
                        ),
                        e.y - 70,
                        if e.phase == 3 then "#d3b2ff" else "#ffe4a0",
                        2,
                        95
                    )
                end
            end
            if __le(e.stateTimer, 0) then
                e.damageLock = 0
                if e.type == "nikolas" then
                    e.y = if e.phase == 3 then __L1.FLOOR - 110 else __L1.FLOOR
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
            e.rollAngle = if __t(e.rollAngle) then e.rollAngle else 0 + dt * 9 * e.dashDir
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
            local ____L1_clamp_1954 = __L1.clamp
            local ____temp_1952 = e.x + e.dashDir * if e.type == "giant" then 450 else if e.type == "reeisBoss" then 690 else if e.type == "nicolas" then 710 else if e.type == "freddy" then 630 else if e.type == "nikolas" then 670 else 580 * __L1:bossProfile(e).dashSpeed * dt
            local ____temp_1946 = e.homeX - 390
            local ____getq_1944 = __getq
            local ____opt_1942 = __L1.arena
            if ____opt_1942 ~= nil then
                ____opt_1942 = ____opt_1942.bounds
            end
            local ____getq_1944_result_1945 = ____getq_1944(____opt_1942, 0)
            if ____getq_1944_result_1945 == nil then
                ____getq_1944_result_1945 = e.homeX - 430
            end
            local ____math_max_result_1953 = math.max(____temp_1946, ____getq_1944_result_1945 + 25)
            local ____temp_1951 = e.homeX + 390
            local ____getq_1949 = __getq
            local ____opt_1947 = __L1.arena
            if ____opt_1947 ~= nil then
                ____opt_1947 = ____opt_1947.bounds
            end
            local ____getq_1949_result_1950 = ____getq_1949(____opt_1947, 1)
            if ____getq_1949_result_1950 == nil then
                ____getq_1949_result_1950 = e.homeX + 430
            end
            e.x = ____L1_clamp_1954(
                __L1,
                ____temp_1952,
                ____math_max_result_1953,
                math.min(____temp_1951, ____getq_1949_result_1950 - 25)
            )
            if math.random() < 0.5 then
                __L1:fx(
                    e.x - e.dashDir * 20,
                    e.y - 12,
                    if e.type == "nikolas" then "#b6cf75" else "#ceaddb",
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
        local ____t_1957 = __t
        local ____t_1956 = __t
        local ____temp_1955 = not __t(__call(
            __arrL({"underground", "monitorTransform", "phaseChange"}, 3),
            "includes",
            e.state
        ))
        __O[2011] = ____temp_1955
        if ____t_1957(if ____t_1956(____temp_1955) then if e.type == "igor" then __L1:igorContains(
            e,
            __L1.player.x,
            __L1.player.y - 27,
            14,
            23
        ) else if __t(window.Golpes) then window.Golpes:cruza(
            window.Golpes:chefe(e),
            window.Golpes:heroi(__L1.player)
        ) else if __t(e.type == "nikolas" and __ge(e.phase, 2)) then __L1:nikolasContains(
            e,
            __L1.player.x,
            __L1.player.y - 27,
            14,
            23
        ) else math.abs(e.x - __L1.player.x) < if e.type == "giant" then 95 else if __t(e.rage) then 60 else 43 and math.abs(e.y - __L1.player.y) < if e.type == "giant" then 155 else 75 else __O[2011]) then
            __L1:hurt(
                math.floor(if __t(e.state == "dashing" or e.state == "bellyRolling") then 24 else if __t(e.type == "igor" and e.state == "bellyAir") then 20 else 13 * __L1:bossProfile(e).damage + 0.5),
                e.x
            )
        end
    end
    __L1.summonDoodles = function(self, e)
        local roomLeft = 6 - __len(__call(
            __L1.minions,
            "filter",
            function(____, m) return if __t(m.summoned) then not __t(m.dead) else m.summoned end
        ))
        local ____t_1960 = __t
        local ____opt_1958 = window.WorldData
        if ____opt_1958 ~= nil then
            ____opt_1958 = ____opt_1958.rageMinions
        end
        __O[2012] = ____opt_1958
        local templates = if ____t_1960(____opt_1958) then __O[2012] else __arrL({{design = "spindle"}, {design = "wobbler"}, {design = "pasta"}, {design = "brainrot"}}, 4)
        do
            local i = 0
            while i < math.min(if e.phase == 3 then 3 else 2, roomLeft) do
                local x = __L1:clamp(
                    e.x + if __t(__mod(i, 2)) then 170 else -170,
                    __get(__L1.arena.bounds, 0) + 45,
                    __get(__L1.arena.bounds, 1) - 45
                )
                local ____t_1962 = __t
                local ____get_result_design_1961 = __get(
                    templates,
                    __mod(
                        e.pattern + i,
                        __len(templates)
                    )
                ).design
                __O[2013] = ____get_result_design_1961
                local design = if e.kind == "sixseven" then "sixseven" else if ____t_1962(____get_result_design_1961) then __O[2013] else "brainrot"
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
                        kind = if design == "sixseven" then 2 else 1,
                        type = "doodle",
                        design = design,
                        hp = hp,
                        max = hp,
                        damage = 9 + e.phase,
                        range = 100,
                        dir = if __t(__mod(i, 2)) then 1 else -1,
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
        __L1:floating(e.x, e.y - 160, if e.kind == "sixseven" then "SIX SEVEN!" else "CADERNO, GANHA VIDA!", "#ffc4d6")
    end
    __L1.executeDede = function(self, e)
        local ____t_1964 = __t
        local ____TS__MathSign_result_1963 = __TS__MathSign(e.targetX - e.x)
        __O[2014] = ____TS__MathSign_result_1963
        local dir = if ____t_1964(____TS__MathSign_result_1963) then __O[2014] else -1
        local ____opt_1967 = e.fxTrago
        if ____opt_1967 ~= nil then
            ____opt_1967 = ____opt_1967.parar
        end
        if ____opt_1967 ~= nil then
            ____opt_1967(____opt_1967)
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
            local ____opt_1971 = window.FxPixel
            if ____opt_1971 ~= nil then
                ____opt_1971 = ____opt_1971.tocar
            end
            if ____opt_1971 ~= nil then
                ____opt_1971(____opt_1971, "explosions/smoke-bomb", {
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
                while i < if e.phase == 3 then 2 else 1 do
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
            local ____opt_1975 = window.FxPixel
            if ____opt_1975 ~= nil then
                ____opt_1975 = ____opt_1975.tocar
            end
            if ____opt_1975 ~= nil then
                ____opt_1975(____opt_1975, "explosions/smoke-bomb", {
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
                        e.x + if __t(__mod(i, 2)) then 1 else -1 * (80 + math.floor(i / 2) * 45),
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
                            dir = if __t(__mod(i, 2)) then 1 else -1,
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
            local ____t_1978 = __t
            local ____TS__MathSign_result_1977 = __TS__MathSign(e.targetX - e.x)
            __O[2015] = ____TS__MathSign_result_1977
            local direction = if ____t_1978(____TS__MathSign_result_1977) then __O[2015] else -1
            __call(__L1.shots, "push", {
                x = e.x + direction * 30,
                y = 200,
                vx = direction * if e.phase == 3 then 185 else 150,
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
            local a = math.atan2(e.targetY - (e.y - 40), e.targetX - e.x)
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
            local ____call_1993 = __call
            local ____L1_hazards_1992 = __L1.hazards
            local ____L1_clamp_1991 = __L1.clamp
            local ____e_targetX_1989 = e.targetX
            local ____t_1983 = __t
            local ____getq_1981 = __getq
            local ____opt_1979 = __L1.arena
            if ____opt_1979 ~= nil then
                ____opt_1979 = ____opt_1979.bounds
            end
            local ____temp_1982 = ____getq_1981(____opt_1979, 0) + 100
            __O[2016] = ____temp_1982
            local ____temp_1990 = if ____t_1983(____temp_1982) then __O[2016] else 55
            local ____t_1988 = __t
            local ____getq_1986 = __getq
            local ____opt_1984 = __L1.arena
            if ____opt_1984 ~= nil then
                ____opt_1984 = ____opt_1984.bounds
            end
            local ____temp_1987 = ____getq_1986(____opt_1984, 1) - 100
            __O[2017] = ____temp_1987
            ____call_1993(
                ____L1_hazards_1992,
                "push",
                {
                    x = ____L1_clamp_1991(__L1, ____e_targetX_1989, ____temp_1990, if ____t_1988(____temp_1987) then __O[2017] else __L1.WORLD - 55),
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
            h.delay = h.delay - dt
            if __gt(h.delay, 0) then
                continue
            end
            if not __t(h.triggered) then
                h.triggered = true
                if not __t(window.Golpes) then
                    local ____opt_1996 = window.FxPixel
                    if ____opt_1996 ~= nil then
                        ____opt_1996 = ____opt_1996.perigo
                    end
                    if ____opt_1996 ~= nil then
                        ____opt_1996(____opt_1996, h, __L1.activeBoss)
                    end
                    local ____L1_fx_2003 = __L1.fx
                    local ____h_x_2001 = h.x
                    local ____h_y_2002 = h.y
                    local ____t_2000 = __t
                    local ____t_1999 = __t
                    local ____temp_1998 = h.type == "astral"
                    __O[2018] = ____temp_1998
                    ____L1_fx_2003(
                        __L1,
                        ____h_x_2001,
                        ____h_y_2002,
                        if ____t_2000(if ____t_1999(____temp_1998) then __O[2018] else h.astral) then "#ffe39a" else if h.type == "slime" then "#bad677" else if h.type == "ink" then "#d2a7eb" else "#edb9cb",
                        22,
                        135
                    )
                end
                __L1.shake = math.max(__L1.shake, 3)
            end
            h.life = h.life - dt
            if h.type == "ring" then
                h.r = h.r + h.speed * dt
                if __t(if __t(window.Golpes) then window.Golpes:perigoAcerta(
                    h,
                    window.Golpes:heroi(__L1.player)
                ) else math.abs(math.abs(__L1.player.x - h.x) - h.r) < 27 and __gt(__L1.player.y, __L1.FLOOR - 57)) then
                    __L1:hurt(h.damage, h.x)
                end
                if __gt(h.r, h.maxR) then
                    h.life = 0
                end
            else
                local ____t_2008 = __t
                local ____t_2005 = __t
                local ____lt_result_2004 = __lt(
                    math.abs(__L1.player.x - h.x),
                    h.r
                )
                __O[2020] = ____lt_result_2004
                local ____t_2007 = __t
                local ____temp_2006 = h.type == "astral"
                __O[2019] = ____temp_2006
                if ____t_2008(if __t(window.Golpes) then window.Golpes:perigoAcerta(
                    h,
                    window.Golpes:heroi(__L1.player)
                ) else if ____t_2005(____lt_result_2004) then if ____t_2007(____temp_2006) then __O[2019] else if __t(h.height) then __gt(__L1.player.y, __L1.FLOOR - h.height) else __gt(__L1.player.y, __L1.FLOOR - 80) else __O[2020]) then
                    local ____t_2011 = __t
                    local ____t_2010 = __t
                    local ____temp_2009 = h.type == "provoke" and not __t(h.didLaunch)
                    __O[2021] = ____temp_2009
                    if ____t_2011(if ____t_2010(____temp_2009) then __le(__L1.player.inv, 0) else __O[2021]) then
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
        local ____opt_2014 = window.CampaignVfx
        if ____opt_2014 ~= nil then
            ____opt_2014 = ____opt_2014.reset
        end
        if ____opt_2014 ~= nil then
            ____opt_2014(____opt_2014)
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
        local ____L1_player_2018 = __L1.player
        local ____opt_2016 = __L1.respawnCheckpoint
        if ____opt_2016 ~= nil then
            ____opt_2016 = ____opt_2016.scene
        end
        ____L1_player_2018.x = if ____opt_2016 == __L1.scene then __L1.respawnCheckpoint.x else 230
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
            if __gt(s.delay, 0) then
                s.delay = s.delay - dt
                continue
            end
            local ____t_2023 = __t
            local ____t_2022 = __t
            local ____t_2020 = __t
            local ____temp_2019 = s.owner == "enemy" and s.returnAt ~= nil
            __O[2022] = ____temp_2019
            local ____temp_2021 = if ____t_2020(____temp_2019) then not __t(s.returned) else __O[2022]
            __O[2023] = ____temp_2021
            if ____t_2023(if ____t_2022(____temp_2021) then __le(s.life, s.returnAt) else __O[2023]) then
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
            local ____t_2026 = __t
            local ____t_2025 = __t
            local ____temp_2024 = if __t(s.brasa) then __gt(s.vy, 0) else s.brasa
            __O[2024] = ____temp_2024
            if ____t_2026(if ____t_2025(____temp_2024) then __ge(s.y, __L1.FLOOR - 8) else __O[2024]) then
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
            if __t(if __t(s.splash) then __ge(s.y, __L1.FLOOR - 8) else s.splash) then
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
                local ____t_2033 = __t
                local ____t_2032 = __t
                local ____opt_2029 = __L1.activeBoss
                if ____opt_2029 ~= nil then
                    ____opt_2029 = ____opt_2029.conquista
                end
                local ____opt_result_2031
                if ____opt_2029 ~= nil then
                    ____opt_result_2031 = ____opt_2029.estrada
                end
                __O[2025] = ____opt_result_2031
                if ____t_2033(if ____t_2032(____opt_result_2031) then window.PerseguicaoMoto:acertar(__L1.activeBoss.conquista, s) else __O[2025]) then
                    s.life = 0
                    continue
                end
                for ____, e in __iterar((__L1.enemies)) do
                    local ____t_2044 = __t
                    local ____t_2035 = __t
                    local ____temp_2034 = __gt(e.hp, 0) and e.state ~= "underground"
                    __O[2028] = ____temp_2034
                    local ____opt_2036 = e.conquista
                    if ____opt_2036 ~= nil then
                        ____opt_2036 = ____opt_2036.slug
                    end
                    local ____t_2043 = __t
                    local ____t_2039 = __t
                    local ____temp_2038 = math.abs(s.x - e.x) < if e.type == "giant" then 95 else if e.type == "reeisBoss" then 45 else 35
                    __O[2026] = ____temp_2038
                    local ____opt_2040 = e.conquista
                    if ____opt_2040 ~= nil then
                        ____opt_2040 = ____opt_2040.gemeoX
                    end
                    local ____temp_2042 = if ____t_2039(____temp_2038) then __O[2026] else ____opt_2040 ~= nil and math.abs(s.x - e.conquista.gemeoX) < 35
                    __O[2027] = ____temp_2042
                    if ____t_2044(if ____t_2035(____temp_2034) then if ____opt_2036 == "jorge" then window.JorgeDuelo:toca(
                        e.conquista,
                        s.x,
                        s.y,
                        7,
                        7
                    ) else if e.type == "igor" then __L1:igorContains(
                        e,
                        s.x,
                        s.y,
                        7,
                        7
                    ) else if __t(if __t(window.Golpes) then not __t(e.conquista) else window.Golpes) then window.Golpes:tiroAcerta(
                        s,
                        window.Golpes:chefe(e)
                    ) else if __t(e.type == "nikolas" and __ge(e.phase, 2)) then __L1:nikolasContains(
                        e,
                        s.x,
                        s.y,
                        7,
                        7
                    ) else if ____t_2043(____temp_2042) then math.abs(s.y - (e.y - if e.type == "giant" then 80 else 30)) < if e.type == "giant" then 100 else 55 else __O[2027] else __O[2028]) then
                        __L1:damageEnemy(e, s.damage, s.element)
                        s.life = 0
                        break
                    end
                end
                if __gt(s.life, 0) then
                    for ____, m in __iterar((__L1.minions)) do
                        local ____t_2047 = __t
                        local ____t_2046 = __t
                        local ____temp_2045 = not __t(m.dead)
                        __O[2029] = ____temp_2045
                        if ____t_2047(if ____t_2046(____temp_2045) then if __t(window.Golpes) then window.Golpes:tiroAcerta(
                            s,
                            window.Golpes:capanga(m)
                        ) else math.abs(s.x - m.x) < 28 and math.abs(s.y - (m.y - 22)) < 28 else __O[2029]) then
                            __L1:damageMinion(m, s.damage, s.element)
                            s.life = 0
                            break
                        end
                    end
                end
                if __gt(s.life, 0) then
                    for ____, d in __iterar((__L1.shots)) do
                        local ____t_2050 = __t
                        local ____t_2049 = __t
                        local ____temp_2048 = d.type == "doodle" and __gt(d.life, 0)
                        __O[2030] = ____temp_2048
                        if ____t_2050(if ____t_2049(____temp_2048) then __hypot(s.x - d.x, s.y - d.y) < 27 else __O[2030]) then
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
            elseif __t(if __t(window.Golpes) then window.Golpes:tiroAcerta(
                s,
                window.Golpes:heroi(__L1.player)
            ) else math.abs(s.x - __L1.player.x) < if s.type == "word" then 55 else 22 and math.abs(s.y - (__L1.player.y - 28)) < 30) then
                __L1:hurt(s.damage, s.x)
                s.life = 0
            end
        end
        __L1.shots = __call(
            __L1.shots,
            "filter",
            function(____, s)
                local ____t_2056 = __t
                local ____t_2054 = __t
                local ____t_2052 = __t
                local ____temp_2051 = __gt(s.life, 0) and __gt(s.x, -100)
                __O[2031] = ____temp_2051
                local ____temp_2053 = if ____t_2052(____temp_2051) then __lt(s.x, __L1.WORLD + 100) else __O[2031]
                __O[2032] = ____temp_2053
                local ____temp_2055 = if ____t_2054(____temp_2053) then __lt(s.y, 520) else __O[2032]
                __O[2033] = ____temp_2055
                return if ____t_2056(____temp_2055) then __gt(s.y, 0) else __O[2033]
            end
        )
    end
    __L1.updateEffects = function(self, dt)
        local ____opt_2059 = window.CampaignVfx
        if ____opt_2059 ~= nil then
            ____opt_2059 = ____opt_2059.update
        end
        if ____opt_2059 ~= nil then
            ____opt_2059(____opt_2059, dt)
        end
        local ____opt_2063 = window.Golpes
        if ____opt_2063 ~= nil then
            ____opt_2063 = ____opt_2063.atualizar
        end
        if ____opt_2063 ~= nil then
            ____opt_2063(____opt_2063, dt)
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
        local ____t_2069 = __t
        local ____t_2066 = __t
        local ____temp_2065 = ____type == "swift"
        __O[2034] = ____temp_2065
        local ____opt_2067 = window.SwiftGuide
        if ____opt_2067 ~= nil then
            ____opt_2067 = ____opt_2067.draw
        end
        if ____t_2069(if ____t_2066(____temp_2065) then ____opt_2067 else __O[2034]) then
            window.SwiftGuide:draw(__L1.ctx, x, y, opt)
            return
        end
        local ____t_2072 = __t
        local ____opt_2070 = window.Art
        if ____opt_2070 ~= nil then
            ____opt_2070 = ____opt_2070.drawCharacter
        end
        if ____t_2072(____opt_2070) then
            window.Art:drawCharacter(
                __L1.ctx,
                ____type,
                x,
                y,
                opt
            )
        else
            __L1.ctx.fillStyle = if ____type == "daroca" then "#f0b45d" else "#b29d70"
            __L1.ctx:fillRect(x - 13, y - 39, 26, 39)
        end
    end
    __L1.drawSewerMarker = function(self, x, destination)
        __L1.ctx:save()
        __L1.ctx.fillStyle = if __t(destination) then "#eee2a680" else "#172e29"
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
        __L1.ctx.strokeStyle = if __t(destination) then "#f5c477" else "#70836b"
        __L1.ctx.lineWidth = 3
        __L1.ctx:stroke()
        do
            local i = -2
            while i <= 2 do
                __L1.ctx.fillStyle = if __t(destination) then "#eec98c" else "#52665a"
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
        local ____t_2077 = __t
        local ____t_2076 = __t
        local ____t_2074 = __t
        local ____temp_2073 = __L1.scene ~= 1
        __O[2035] = ____temp_2073
        local ____temp_2075 = if ____t_2074(____temp_2073) then __O[2035] else __L1.q.kaique
        __O[2036] = ____temp_2075
        if ____t_2077(if ____t_2076(____temp_2075) then __O[2036] else if __t(__L1.arena) then __L1.arena.type ~= "kaique" else __L1.arena) then
            return
        end
        local ____iter_2085 = __iter
        local ____t_2084 = __t
        local ____opt_2082 = window.WorldData
        if ____opt_2082 ~= nil then
            ____opt_2082 = ____opt_2082.iraciTraps
        end
        __O[2037] = ____opt_2082
        for ____, trap in __TS__Iterator(____iter_2085(if ____t_2084(____opt_2082) then __O[2037] else __arrL({}, 0))) do
            __L1.ctx:save()
            local ____t_2081 = __t
            local ____opt_2078 = __L1.activeBoss
            if ____opt_2078 ~= nil then
                ____opt_2078 = ____opt_2078.type
            end
            local ____temp_2080 = ____opt_2078 == "kaique"
            __O[2038] = ____temp_2080
            local angry = if ____t_2081(____temp_2080) then __L1.activeBoss.iraciTriggered else __O[2038]
            __L1.ctx.fillStyle = if __t(angry) then "#af5e62" else "#927596"
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
            if __t(not __t(__L1:isSchoolMonitor(e)) or __le(e.hp, 0)) then
                continue
            end
            local d = if __t(e.monitorDir) then e.monitorDir else -1
            local reach = 300
            local ____iter_2089 = __iter
            local ____t_2088 = __t
            local ____opt_2086 = window.WorldData
            if ____opt_2086 ~= nil then
                ____opt_2086 = ____opt_2086.schoolCovers
            end
            __O[2039] = ____opt_2086
            for ____, cover in __TS__Iterator(____iter_2089(if ____t_2088(____opt_2086) then __O[2039] else __arrL({}, 0))) do
                local distance = (cover.x - e.x) * d - cover.width / 2
                if __t(distance > 0 and distance < reach) then
                    reach = distance
                end
            end
            local eye = __L1.FLOOR - if e.type == "igor" then 74 else 92
            local center = eye + (__L1.FLOOR - 40 - eye) * reach / 300
            local half = 18 + reach * 0.15
            __L1.ctx:save()
            __L1.ctx.globalAlpha = if __gt(e.monitorSuspicion, 0.6) then 0.25 else 0.13
            __L1.ctx.fillStyle = if __gt(e.monitorSuspicion, 0.6) then "#eb977e" else "#e9d88e"
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
                __L1.ctx.fillStyle = if __gt(e.monitorSuspicion, 0.7) then "#e39a80" else "#e4c77d"
                __L1.ctx:fillRect(e.x - 34, __L1.FLOOR - 125, 68 * e.monitorSuspicion / 1.2, 5)
                __L1:pill(if __gt(e.monitorSuspicion, 0.7) then "TE VI, DA ROÇA!" else "QUEM TÁ NO CORREDOR?", e.x, __L1.FLOOR - 147, "#ffe0a4")
            end
        end
    end
    __L1.drawSchoolCover = function(self)
        local ____t_2092 = __t
        local ____t_2091 = __t
        local ____temp_2090 = __L1.scene ~= 1
        __O[2040] = ____temp_2090
        if ____t_2092(if ____t_2091(____temp_2090) then __O[2040] else __L1.arena) then
            return
        end
        local ____iter_2096 = __iter
        local ____t_2095 = __t
        local ____opt_2093 = window.WorldData
        if ____opt_2093 ~= nil then
            ____opt_2093 = ____opt_2093.schoolCovers
        end
        __O[2041] = ____opt_2093
        for ____, cover in __TS__Iterator(____iter_2096(if ____t_2095(____opt_2093) then __O[2041] else __arrL({}, 0))) do
            local hiding = math.abs(__L1.player.x - cover.x) < cover.width / 2 + 10 and __gt(__L1.player.y, __L1.FLOOR - 95)
            __L1.ctx:save()
            __L1.ctx.globalAlpha = if __t(hiding) then 0.65 else 1
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
            __L1:pill(if __t(hiding) then "ESCONDIDO" else "ABRIGO", cover.x, __L1.FLOOR + 25, if __t(hiding) then "#d4edaa" else "#c2d7d0")
        end
    end
    __L1.drawBossTelegraphs = function(self)
        local ____t_2099 = __t
        local ____opt_2097 = __L1.activeBoss
        if ____opt_2097 ~= nil then
            ____opt_2097 = ____opt_2097.conquista
        end
        if ____t_2099(____opt_2097) then
            local f = __L1.activeBoss.conquista
            if f.estado == "windup" then
                local ____L1_pill_2103 = __L1.pill
                local ____array_2102 = __TS__SparseArrayNew(
                    window.ConquistaCombate:titulo(f),
                    __L1:clamp(f.x, __L1.camera + 110, __L1.camera + __L1.W - 110),
                    math.max(88, f.y - if __t(f.fase == 2 and f.slug == "jorge") then 150 else 111)
                )
                local ____t_2101 = __t
                local ____getq_result_2100 = __getq(
                    window.ConquistaCombate:capitulo(f),
                    2
                )
                __O[2042] = ____getq_result_2100
                __TS__SparseArrayPush(____array_2102, if ____t_2101(____getq_result_2100) then __O[2042] else __get(window.ConquistaCombate.chefes, f.slug).cor)
                ____L1_pill_2103(
                    __L1,
                    __TS__SparseArraySpread(____array_2102)
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
        local ____opt_2104 = __L1.activeBoss
        if ____opt_2104 ~= nil then
            ____opt_2104 = ____opt_2104.type
        end
        if ____opt_2104 == "kaique" then
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
            local ____L1_pill_2112 = __L1.pill
            local ____add_2111 = __add
            local ____add_result_2110 = __add(
                __add("FASE ", e.phase),
                " · "
            )
            local ____t_2109 = __t
            local ____t_2107 = __t
            local ____get_result_2106 = __get(__L1.nikolasPhaseWarnings, e.kind)
            __O[2043] = ____get_result_2106
            local ____temp_2108 = if ____t_2107(____get_result_2106) then __O[2043] else __get(__L1.bossPhaseSkillNames, e.kind)
            __O[2044] = ____temp_2108
            ____L1_pill_2112(
                __L1,
                ____add_2111(____add_result_2110, if ____t_2109(____temp_2108) then __O[2044] else "NOVA HABILIDADE"),
                e.x,
                __L1:bossCaptionY(e),
                "#ffe4ad"
            )
            return
        end
        local ____t_2115 = __t
        local ____t_2114 = __t
        local ____temp_2113 = e.kind == "sewerDive"
        __O[2045] = ____temp_2113
        if ____t_2115(if ____t_2114(____temp_2113) then e.state == "windup" or e.state == "underground" else __O[2045]) then
            __L1:drawSewerMarker(e.emergeX, true)
        end
        if e.state == "underground" then
            local ____L1_pill_2117 = __L1.pill
            local ____e_diveFromX_2116 = e.diveFromX
            if ____e_diveFromX_2116 == nil then
                ____e_diveFromX_2116 = e.x
            end
            ____L1_pill_2117(
                __L1,
                "NO ESGOTO · PREPARE O ATAQUE",
                ____e_diveFromX_2116,
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
            __L1.ctx.lineWidth = if e.kind == "dash" then 6 else 2
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
            local ____L1_pill_2125 = __L1.pill
            local ____t_2121 = __t
            local ____t_2119 = __t
            local ____get_result_2118 = __get(__L1.nikolasPhaseWarnings, e.kind)
            __O[2046] = ____get_result_2118
            local ____temp_2120 = if ____t_2119(____get_result_2118) then __O[2046] else __get(__L1.bossPhaseSkillNames, e.kind)
            __O[2048] = ____temp_2120
            local ____t_2124 = __t
            local ____t_2123 = __t
            local ____temp_2122 = e.type == "nikolas" and e.kind == "slimeFan"
            __O[2047] = ____temp_2122
            ____L1_pill_2125(
                __L1,
                if ____t_2121(____temp_2120) then __O[2048] else if e.kind == "bellyBounce" then "BARRIGA NO AR! SAIA DA MARCA" else if e.kind == "bellyRoll" then "BARRIGA ROLANDO! USE AS PASSARELAS" else if e.kind == "bellyClap" then "ONDA DA BARRIGA! PULE" else if e.kind == "monitorBurst" then "RAJADA! ALVO TRAVADO" else if e.kind == "monitorSweep" then "TIROS RASANTES! PULE" else if e.kind == "monitorReload" then "RECARREGANDO! PREPARE O ATAQUE" else if e.kind == "sewerDive" then "ESGOTO! OLHE A SAÍDA" else if e.kind == "ratsArmy" then "EXÉRCITO DE RATOS!" else if e.kind == "cloudMines" then "FUMAÇA NO CHÃO! DESVIE" else if e.kind == "bitucas" then "BITUCAS ACESAS! SAIA DAS BRASAS" else if e.kind == "tragada" then "TRAGADA FUNDA! PULE A BAFORADA" else if e.kind == "cinzas" then "CHUVA DE CINZA! SAIA DAS MARCAS" else if e.kind == "smokeVeil" then "CORTINA DE FUMAÇA!" else if __t(e.kind == "sketchSwarm" or e.kind == "brainrots") then "DESENHOS GANHANDO VIDA!" else if e.kind == "sketchLine" then "RISCO NO CHÃO! PULE!" else if e.kind == "inkSlam" then "ONDA DE TINTA! PULE!" else if e.kind == "poseWave" then "ONDA DA POSE! PULE!" else if e.kind == "dash" then "INVESTIDA! USE DASH" else if e.kind == "skyLances" then "RAIOS! SAIA DAS MARCAS" else if __t(e.kind == "supremeRing" or e.kind == "stomp") then "ONDA NO CHÃO! PULE!" else if e.kind == "astralFan" then "ORBITAIS! DESVIE!" else if e.kind == "mines" then "SAIA DAS MARCAS!" else if e.kind == "slimeRain" then "CHUVA DE CATARRO!" else if ____t_2124(if ____t_2123(____temp_2122) then e.phase == 3 else __O[2047]) then "DUAS RAJADAS! DESVIE DUAS VEZES" else "ATAQUE CARREGANDO!",
                e.x,
                __L1:bossCaptionY(e),
                "#ffd096"
            )
        end
        local ____t_2130 = __t
        local ____t_2129 = __t
        local ____t_2127 = __t
        local ____temp_2126 = e.type == "nikolas" and e.phase == 4
        __O[2049] = ____temp_2126
        local ____temp_2128 = if ____t_2127(____temp_2126) then __gt(e.safeLaneTime, 0) else __O[2049]
        __O[2050] = ____temp_2128
        if ____t_2130(if ____t_2129(____temp_2128) then __isFiniteN(e.safeLaneX) else __O[2050]) then
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
                if e.type == "igor" then "A BARRIGA ESTÁ CRESCENDO!" else if __t(e.rage) then "FÚRIA DE IRACI!" else "FISCALIZAÇÃO EM POSIÇÃO!",
                e.x,
                __L1:bossCaptionY(e),
                if __t(e.rage) then "#ffb7ae" else "#ffe1a0"
            )
        end
        if e.state == "bellyAir" then
            local k = __L1:clamp(1 - e.stateTimer / if __t(e.bellyDuration) then e.bellyDuration else 1, 0, 1)
            local w = math.floor(40 + k * 65 + 0.5)
            __L1.ctx:save()
            __L1.ctx.globalAlpha = 0.3 + 0.35 * k
            do
                local i = -w
                while i <= w do
                    local h = math.floor(math.sqrt(math.max(0, 1 - (i / w) ^ 2)) * (4 + k * 4) + 0.5)
                    __L1.ctx.fillStyle = if math.abs(i) < w * 0.6 then "#2a1a10" else "#4a3020"
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
                __L1.ctx:fillRect(ax - if d > 0 then 6 else -2, __L1.FLOOR - 10, 4, 4)
            end
            __L1.ctx:restore()
        end
        if e.state == "recover" then
            __L1:pill(
                if e.type == "kaique" then "RECARREGANDO! ATAQUE!" else "VULNERÁVEL! ATAQUE!",
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
        local ____L1_sprite_2140 = __L1.sprite
        local ____L1_reeisX_2138 = __L1.reeisX
        local ____L1_reeisY_2139 = __L1.reeisY
        local ____L1_reeisFacing_2133 = __L1.reeisFacing
        local ____L1_time_2134 = __L1.time
        local ____transformed_2135 = transformed
        local ____temp_2136 = __L1.reeisPhase ~= "running"
        local ____temp_2137 = __L1.reeisPhase == "charging"
        local ____t_2132 = __t
        local ____temp_2131 = __L1.reeisPhase == "running"
        __O[2051] = ____temp_2131
        ____L1_sprite_2140(
            __L1,
            "reeis",
            ____L1_reeisX_2138,
            ____L1_reeisY_2139,
            {
                facing = ____L1_reeisFacing_2133,
                frame = ____L1_time_2134,
                transformed = ____transformed_2135,
                powered = transformed,
                aura = ____temp_2136,
                charging = ____temp_2137,
                moving = if ____t_2132(____temp_2131) then __O[2051] else __L1.reeisPhase == "active" and math.abs(__L1.player.vx) > 8,
                speed = if __L1.reeisPhase == "running" then 430 else math.abs(__L1.player.vx),
                grounded = if __L1.reeisPhase == "active" then __L1.player.ground else true,
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
        if __t(if __t(r.estrada) then window.EstradaViagem else r.estrada) then
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
                        local ____t_2143 = __t
                        local ____opt_2141 = window.Art
                        if ____opt_2141 ~= nil then
                            ____opt_2141 = ____opt_2141.drawVehicle
                        end
                        if ____t_2143(____opt_2141) then
                            c:save()
                            c:translate(
                                math.floor(x + 0.5),
                                0
                            )
                            window.Art:drawVehicle(c, 0, y, __L1.time)
                            c:restore()
                        end
                        local ____t_2146 = __t
                        local ____opt_2144 = window.Art
                        if ____opt_2144 ~= nil then
                            ____opt_2144 = ____opt_2144.drawCharacter
                        end
                        if ____t_2146(____opt_2144) then
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
        local ____t_2149 = __t
        local ____opt_2147 = window.Art
        if ____opt_2147 ~= nil then
            ____opt_2147 = ____opt_2147.drawScene
        end
        if ____t_2149(____opt_2147) then
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
        local ____t_2152 = __t
        local ____opt_2150 = window.Art
        if ____opt_2150 ~= nil then
            ____opt_2150 = ____opt_2150.drawVehicle
        end
        if ____t_2152(____opt_2150) then
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
        local ____L1_text_2164 = __L1.text
        local ____add_2163 = __add
        local ____call_2162 = __call
        local ____t_2161 = __t
        local ____t_2154 = __t
        local ____get_result_2153 = __get(__L1.scenes, r.to)
        __O[2052] = ____get_result_2153
        local ____opt_2157 = window.LugaresC1
        if ____opt_2157 ~= nil then
            ____opt_2157 = ____opt_2157.nome
        end
        local ____opt_result_2159
        if ____opt_2157 ~= nil then
            ____opt_result_2159 = ____opt_2157(____opt_2157, r.to)
        end
        local ____temp_2160 = if ____t_2154(____get_result_2153) then __O[2052] else ____opt_result_2159
        __O[2053] = ____temp_2160
        ____L1_text_2164(
            __L1,
            ____add_2163(
                "PRÓXIMA PARADA: ",
                ____call_2162(if ____t_2161(____temp_2160) then __O[2053] else "", "toUpperCase")
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
            local ____t_2167 = __t
            local ____opt_2165 = window.Art
            if ____opt_2165 ~= nil then
                ____opt_2165 = ____opt_2165.drawScene
            end
            if ____t_2167(____opt_2165) then
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
        local ____t_2173 = __t
        local ____opt_2170 = window.FavelaCasas
        if ____opt_2170 ~= nil then
            ____opt_2170 = ____opt_2170.ehCasa
        end
        local ____opt_result_2172
        if ____opt_2170 ~= nil then
            ____opt_result_2172 = ____opt_2170(____opt_2170, r.id)
        end
        if ____t_2173(____opt_result_2172) then
            window.FavelaCasas:desenhar(__L1.ctx, r.id, __L1.time)
        else
            local ____t_2176 = __t
            local ____opt_2174 = window.Art
            if ____opt_2174 ~= nil then
                ____opt_2174 = ____opt_2174.drawClassroom
            end
            if ____t_2176(____opt_2174) then
                window.Art:drawClassroom(__L1.ctx, r.id, __L1.time)
            else
                __L1.ctx.fillStyle = "#d5c6a0"
                __L1.ctx:fillRect(0, 0, __L1.W, __L1.H)
                __L1.ctx.fillStyle = "#354f42"
                __L1.ctx:fillRect(0, __L1.FLOOR, __L1.W, __L1.H - __L1.FLOOR)
            end
        end
        local px = if r.phase == "entering" then 120 else __L1.player.x
        local py = if r.phase == "entering" then __L1.FLOOR else __L1.player.y
        __L1:sprite(
            "daroca",
            px,
            py,
            __L1:playerSpriteOptions()
        )
        local ____opt_2179 = window.FavelaCasas
        if ____opt_2179 ~= nil then
            ____opt_2179 = ____opt_2179.ehCasa
        end
        local ____opt_result_2181
        if ____opt_2179 ~= nil then
            ____opt_result_2181 = ____opt_2179(____opt_2179, r.id)
        end
        local casa = ____opt_result_2181
        __L1:sprite(
            if __t(casa) then window.FavelaCasas:morador(r.id) else r.id,
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
        __L1:pill(if __t(casa) then __call(
            window.FavelaCasas:nomeNpc(r.id),
            "toUpperCase"
        ) else if r.id == "almiro" then "PROFESSOR ALMIRO" else "PROFESSOR MIQUEIAS", r.teacherX, __L1.FLOOR - 105, "#f1dba5")
        if __t(r.phase == "inside" and not __t(__L1.dialog)) then
            if __t(math.abs(__L1.player.x - r.teacherX) < 105 and math.abs(__L1.player.y - __L1.FLOOR) < 100) then
                __L1:pill("[E] conversar", r.teacherX, __L1.FLOOR - 140, "#d5e6a4")
            end
            if math.abs(__L1.player.x - r.exitX) < 105 then
                __L1:pill(if __t(casa) then "[E] sair da casa" else "[E] sair da sala", r.exitX, __L1.FLOOR - 110, "#f0d298")
            end
        end
        __L1.ctx:restore()
    end
    __L1.drawMinions = function(self)
        for ____, m in __iterar((__L1.minions)) do
            if __t(if __t(m.dead) then m.dead else if __t(__L1.arena) then not __t(m.summoned) else __L1.arena) then
                continue
            end
            local ____t_2186 = __t
            local ____t_2183 = __t
            local ____temp_2182 = m.type == "rat"
            __O[2054] = ____temp_2182
            local ____opt_2184 = window.Art
            if ____opt_2184 ~= nil then
                ____opt_2184 = ____opt_2184.drawRat
            end
            if ____t_2186(if ____t_2183(____temp_2182) then ____opt_2184 else __O[2054]) then
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
                local ____t_2191 = __t
                local ____t_2188 = __t
                local ____temp_2187 = m.type == "thug" or m.kind == "thug"
                __O[2055] = ____temp_2187
                local ____opt_2189 = window.Art
                if ____opt_2189 ~= nil then
                    ____opt_2189 = ____opt_2189.drawThug
                end
                if ____t_2191(if ____t_2188(____temp_2187) then ____opt_2189 else __O[2055]) then
                    window.Art:drawThug(
                        __L1.ctx,
                        m.x,
                        m.y,
                        __L1.time,
                        {
                            facing = if __lt(__L1.player.x, m.x) then -1 else 1,
                            tier = m.tier,
                            weapon = m.weapon,
                            hit = __gt(m.hit, 0),
                            moving = false,
                            attack = not not __t(m.charging)
                        }
                    )
                else
                    local ____t_2194 = __t
                    local ____opt_2192 = window.Art
                    if ____opt_2192 ~= nil then
                        ____opt_2192 = ____opt_2192.drawMinion
                    end
                    if ____t_2194(____opt_2192) then
                        local ____self_2202 = window.Art
                        local ____self_2202_drawMinion_2203 = ____self_2202.drawMinion
                        local ____array_2201 = __TS__SparseArrayNew(
                            __L1.ctx,
                            m.x,
                            m.y,
                            m.kind,
                            __L1.time
                        )
                        local ____m_dir_2197 = m.dir
                        local ____gt_result_2198 = __gt(m.hit, 0)
                        local ____temp_2199 = m.kind ~= 2
                        local ____temp_2200 = math.abs(m.x - __L1.player.x) < 360
                        local ____t_2196 = __t
                        local ____temp_2195 = if __t(m.design) then m.design else m.variant
                        __O[2056] = ____temp_2195
                        __TS__SparseArrayPush(____array_2201, {
                            facing = ____m_dir_2197,
                            hit = ____gt_result_2198,
                            moving = ____temp_2199,
                            angry = ____temp_2200,
                            type = if ____t_2196(____temp_2195) then __O[2056] else m.type
                        })
                        ____self_2202_drawMinion_2203(
                            ____self_2202,
                            __TS__SparseArraySpread(____array_2201)
                        )
                    else
                        local ____t_2206 = __t
                        local ____opt_2204 = window.Art
                        if ____opt_2204 ~= nil then
                            ____opt_2204 = ____opt_2204.drawDoodle
                        end
                        if ____t_2206(____opt_2204) then
                            window.Art:drawDoodle(
                                __L1.ctx,
                                m.x,
                                m.y - 22,
                                m.kind,
                                __L1.time,
                                false
                            )
                        else
                            __L1.ctx.fillStyle = if __gt(m.hit, 0) then "#fff2d8" else "#a679ac"
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
                    ctx.fillStyle = if p.type == "repair" then "#e9ca74" else "#6ca7c5"
                    ctx:fillRect(p.x - 11, yy - 14, 22, 26)
                    ctx.strokeStyle = "#f8f1b6"
                    ctx.lineWidth = 2
                    ctx:strokeRect(p.x - 12, yy - 15, 24, 28)
                    ctx.fillStyle = "#203c3d"
                    ctx:fillRect(p.x - 6, yy - 7, 12, 3)
                    ctx:fillRect(p.x - 6, yy, 8, 3)
                elseif __t(__get(__L1.itemNames, p.type)) then
                    local ____t_2209 = __t
                    local ____opt_2207 = window.Art
                    if ____opt_2207 ~= nil then
                        ____opt_2207 = ____opt_2207.drawMaterial
                    end
                    if ____t_2209(____opt_2207) then
                        window.Art:drawMaterial(ctx, p.x, yy, p.type)
                    else
                        ctx.fillStyle = if p.type == "pencil" then "#edce6f" else if p.type == "eraser" then "#eb9eae" else "#b7d1dc"
                        ctx:fillRect(p.x - 7, yy - 10, if p.type == "pencil" then 6 else 15, 20)
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
    __L1.draw = function(self)
        __L1.ctx:save()
        __L1.ctx:clearRect(0, 0, __L1.W, __L1.H)
        if __t(__L1.ollyanEncounter) then
            window.OllyanEncounter:draw(__L1.ctx, __L1.ollyanEncounter, {hud = false})
            local ____opt_2212 = window.FxPixel
            if ____opt_2212 ~= nil then
                ____opt_2212 = ____opt_2212.desenhar
            end
            if ____opt_2212 ~= nil then
                ____opt_2212(____opt_2212, __L1.ctx, {
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
            __L1.ctx:translate(
                math.floor(__L1:rand(
                    __TS__Number(-__L1.shake),
                    __L1.shake
                ) + 0.5),
                math.floor(__L1:rand(
                    __TS__Number(-__L1.shake) * 0.4,
                    __L1.shake * 0.4
                ) + 0.5)
            )
        end
        local ____opt_2214 = __L1.activeBoss
        if ____opt_2214 ~= nil then
            ____opt_2214 = ____opt_2214.conquista
        end
        local duelo = ____opt_2214
        local percurso = __L1:terrenoConquista(duelo)
        local ____t_2218 = __t
        local ____t_2217 = __t
        local ____temp_2216 = not __t(percurso)
        __O[2057] = ____temp_2216
        if ____t_2218(if ____t_2217(____temp_2216) then __O[2057] else if __t(duelo.ceu) then __lt(duelo.ceu.tempo, 0.85) else duelo.ceu) then
            local ____t_2224 = __t
            local ____t_2221 = __t
            local ____opt_2219 = window.C2Luta
            if ____opt_2219 ~= nil then
                ____opt_2219 = ____opt_2219.skin
            end
            __O[2058] = ____opt_2219
            local ____this_2223
            ____this_2223 = window.C2Luta
            local ____opt_2222 = ____this_2223.desenharFundo
            if ____opt_2222 ~= nil then
                ____opt_2222 = ____opt_2222(
                    ____this_2223,
                    __L1.ctx,
                    __L1.camera,
                    __L1.time,
                    __L1.arena
                )
            end
            if ____t_2224(if ____t_2221(____opt_2219) then ____opt_2222 else __O[2058]) then
            else
                local ____t_2227 = __t
                local ____opt_2225 = window.Art
                if ____opt_2225 ~= nil then
                    ____opt_2225 = ____opt_2225.drawScene
                end
                if ____t_2227(____opt_2225) then
                    window.Art:drawScene(__L1.ctx, __L1.scene, __L1.camera, __L1.time)
                else
                    __L1.ctx.fillStyle = "#819379"
                    __L1.ctx:fillRect(0, 0, __L1.W, __L1.H)
                    __L1.ctx.fillStyle = "#617448"
                    __L1.ctx:fillRect(0, __L1.FLOOR, __L1.W, __L1.H - __L1.FLOOR)
                end
            end
            if not __t(__L1.arena) then
                local ____opt_2230 = window.WorldLife
                if ____opt_2230 ~= nil then
                    ____opt_2230 = ____opt_2230.draw
                end
                if ____opt_2230 ~= nil then
                    ____opt_2230(
                        ____opt_2230,
                        __L1.ctx,
                        __L1.scene,
                        __L1.camera,
                        __L1.time,
                        __L1.q,
                        __L1.player
                    )
                end
            end
            local ____t_2234 = __t
            local ____opt_2232 = window.C2Luta
            if ____opt_2232 ~= nil then
                ____opt_2232 = ____opt_2232.skin
            end
            if ____t_2234(if __t(__L1.arena) then ____opt_2232 else __L1.arena) then
                __L1.ctx:save()
                __L1.ctx.globalAlpha = __L1.arena.blend
                local ____opt_2237 = window.BossArena
                if ____opt_2237 ~= nil then
                    ____opt_2237 = ____opt_2237.palco
                end
                if ____opt_2237 ~= nil then
                    ____opt_2237(
                        ____opt_2237,
                        __L1.ctx,
                        window.C2Luta.skin.tema,
                        __L1.camera,
                        __L1.time,
                        __L1.arena.homeX
                    )
                end
                __L1.ctx:restore()
            else
                local ____t_2241 = __t
                local ____opt_2239 = window.Art
                if ____opt_2239 ~= nil then
                    ____opt_2239 = ____opt_2239.drawArena
                end
                if ____t_2241(if __t(__L1.arena) then ____opt_2239 else __L1.arena) then
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
        local ____opt_2244 = window.CampaignVfx
        if ____opt_2244 ~= nil then
            ____opt_2244 = ____opt_2244.draw
        end
        if ____opt_2244 ~= nil then
            ____opt_2244(____opt_2244, __L1.ctx, __L1.time, "back")
        end
        local ____opt_2248 = window.Golpes
        if ____opt_2248 ~= nil then
            ____opt_2248 = ____opt_2248.desenharGas
        end
        if ____opt_2248 ~= nil then
            ____opt_2248(____opt_2248, __L1.ctx, __L1.time)
        end
        local ____opt_2252 = window.FxPixel
        if ____opt_2252 ~= nil then
            ____opt_2252 = ____opt_2252.desenhar
        end
        if ____opt_2252 ~= nil then
            ____opt_2252(____opt_2252, __L1.ctx, {dono = "luta", camada = "back", camera = __L1.camera, tempo = __L1.time})
        end
        local ____t_2256 = __t
        local ____opt_2254 = __L1.activeBoss
        if ____opt_2254 ~= nil then
            ____opt_2254 = ____opt_2254.conquista
        end
        if ____t_2256(____opt_2254) then
            window.ConquistaEfeitos:fundo(__L1.ctx, __L1.activeBoss.conquista)
        end
        if __t(percurso) then
            percurso:plataformas(__L1.ctx, duelo)
        else
            for ____, p in __iterar((__L1:scenePlatforms())) do
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
                local ____t_2262 = __t
                local ____opt_2259 = window.Graphics
                if ____opt_2259 ~= nil then
                    ____opt_2259 = ____opt_2259.isLite
                end
                local ____opt_result_2261
                if ____opt_2259 ~= nil then
                    ____opt_result_2261 = ____opt_2259(____opt_2259)
                end
                if ____t_2262(____opt_result_2261) then
                    __L1.ctx.fillStyle = if __L1.scene == 2 then "#63736a" else "#8d724f"
                    __L1.ctx:fillRect(
                        __get(p, 0),
                        __get(p, 1),
                        __get(p, 2),
                        12
                    )
                    __L1.ctx.fillStyle = if __L1.scene == 0 then "#abc378" else "#c0ab7f"
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
                    local ____t_2269 = __t
                    local ____t_2268 = __t
                    local ____t_2264 = __t
                    local ____temp_2263 = __L1.scene == 11
                    __O[2059] = ____temp_2263
                    local ____opt_2265 = window.BaileGalpao
                    if ____opt_2265 ~= nil then
                        ____opt_2265 = ____opt_2265.camarote
                    end
                    local ____temp_2267 = if ____t_2264(____temp_2263) then ____opt_2265 else __O[2059]
                    __O[2060] = ____temp_2267
                    if ____t_2269(if ____t_2268(____temp_2267) then __gt(
                        __get(p, 0),
                        if __t(window.BaileGalpao.PORTA) then window.BaileGalpao.PORTA else 760
                    ) else __O[2060]) then
                        window.BaileGalpao:camarote(__L1.ctx, p, __L1.time)
                    else
                        local ____t_2275 = __t
                        local ____opt_2272 = window.LugaresC1
                        if ____opt_2272 ~= nil then
                            ____opt_2272 = ____opt_2272.plataforma
                        end
                        local ____opt_result_2274
                        if ____opt_2272 ~= nil then
                            ____opt_result_2274 = ____opt_2272(
                                ____opt_2272,
                                __L1.ctx,
                                p,
                                __L1.scene,
                                __L1.time
                            )
                        end
                        if ____t_2275(____opt_result_2274) then
                        else
                            __L1:drawPlank(p)
                        end
                    end
                end
            end
        end
        if not __t(percurso) then
            local ____opt_2287 = window.Interact
            if ____opt_2287 ~= nil then
                ____opt_2287 = ____opt_2287.drawBack
            end
            if ____opt_2287 ~= nil then
                local ____L1_ctx_2285 = __L1.ctx
                local ____L1_scene_2281 = __L1.scene
                local ____L1_camera_2282 = __L1.camera
                local ____L1_time_2283 = __L1.time
                local ____temp_2284 = not not __t(__L1.arena)
                local ____opt_2277 = __L1.arena
                if ____opt_2277 ~= nil then
                    ____opt_2277 = ____opt_2277.type
                end
                local ____opt_2279 = __L1.arena
                if ____opt_2279 ~= nil then
                    ____opt_2279 = ____opt_2279.homeX
                end
                ____opt_2287(
                    ____opt_2287,
                    ____L1_ctx_2285,
                    {
                        scene = ____L1_scene_2281,
                        camera = ____L1_camera_2282,
                        time = ____L1_time_2283,
                        arena = ____temp_2284,
                        arenaType = ____opt_2277,
                        homeX = ____opt_2279,
                        room = not not __t(__L1.room)
                    }
                )
            end
            local ____opt_2291 = window.Fliperama
            if ____opt_2291 ~= nil then
                ____opt_2291 = ____opt_2291.drawWorld
            end
            if ____opt_2291 ~= nil then
                ____opt_2291(
                    ____opt_2291,
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
            local ____opt_2295 = window.Trigal
            if ____opt_2295 ~= nil then
                ____opt_2295 = ____opt_2295.drawBack
            end
            if ____opt_2295 ~= nil then
                ____opt_2295(
                    ____opt_2295,
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
            local ____opt_2299 = window.CampanhaPlantas
            if ____opt_2299 ~= nil then
                ____opt_2299 = ____opt_2299.drawBack
            end
            if ____opt_2299 ~= nil then
                ____opt_2299(
                    ____opt_2299,
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
                local ____opt_2303 = window.CampanhaCenarios
                if ____opt_2303 ~= nil then
                    ____opt_2303 = ____opt_2303.heroi
                end
                if ____opt_2303 ~= nil then
                    ____opt_2303(____opt_2303, __L1.player.x, __L1.player.y, __L1.player.vy)
                end
            end
        end
        if not __t(__L1.arena) then
            local ____opt_2307 = window.BivoltQuest
            if ____opt_2307 ~= nil then
                ____opt_2307 = ____opt_2307.draw
            end
            if ____opt_2307 ~= nil then
                ____opt_2307(
                    ____opt_2307,
                    __L1.ctx,
                    0,
                    __L1.time,
                    __L1.q,
                    __L1.scene
                )
            end
            local ____opt_2311 = window.MissaoFarda
            if ____opt_2311 ~= nil then
                ____opt_2311 = ____opt_2311.desenhar
            end
            if ____opt_2311 ~= nil then
                ____opt_2311(
                    ____opt_2311,
                    __L1.ctx,
                    __L1.time,
                    __L1.q,
                    __L1.scene
                )
            end
            local ____opt_2315 = window.LugaresC1
            if ____opt_2315 ~= nil then
                ____opt_2315 = ____opt_2315.desenhar
            end
            if ____opt_2315 ~= nil then
                ____opt_2315(
                    ____opt_2315,
                    __L1.ctx,
                    __L1.time,
                    __L1.q,
                    __L1.scene
                )
            end
            if __L1.scene == 1 then
                __L1:drawSchoolWatch()
            end
            local ____t_2322 = __t
            local ____opt_2319 = window.Graphics
            if ____opt_2319 ~= nil then
                ____opt_2319 = ____opt_2319.isShader
            end
            local ____opt_result_2321
            if ____opt_2319 ~= nil then
                ____opt_result_2321 = ____opt_2319(____opt_2319)
            end
            if ____t_2322(____opt_result_2321) then
                __L1.pickupsLater = true
            else
                __L1:drawPickupsNow(__L1.ctx)
            end
            for ____, ____value in __iterar((__entries(__L1.npcInfo))) do
                local id = ____value[1]
                local n = ____value[2]
                local ____t_2325 = __t
                local ____t_2324 = __t
                local ____temp_2323 = n.scene == __L1.scene and math.abs(n.x - __L1.camera - __L1.W / 2) < __L1.W / 2 + 180
                __O[2061] = ____temp_2323
                if ____t_2325(if ____t_2324(____temp_2323) then __L1:npcAvailable(id) else __O[2061]) then
                    local ____L1_sprite_2337 = __L1.sprite
                    local ____array_2336 = __TS__SparseArrayNew(id, n.x, __L1.FLOOR)
                    local ____temp_2334 = if id == "ravid" then 1 else -1
                    local ____L1_time_2335 = __L1.time
                    local ____t_2327 = __t
                    local ____temp_2326 = id == "ravid"
                    __O[2063] = ____temp_2326
                    local ____t_2329 = __t
                    local ____temp_2328 = not not __t(__L1.dialog)
                    __O[2062] = ____temp_2328
                    local ____call_2333 = __call
                    local ____arrL_result_2332 = __arrL(
                        {
                            n.name,
                            __get(
                                __call(n.name, "split", " ·"),
                                0
                            )
                        },
                        2
                    )
                    local ____opt_2330 = __get(__L1.dialog.lines, __L1.dialog.index)
                    if ____opt_2330 ~= nil then
                        ____opt_2330 = ____opt_2330.name
                    end
                    __TS__SparseArrayPush(
                        ____array_2336,
                        {
                            facing = ____temp_2334,
                            frame = ____L1_time_2335,
                            moving = false,
                            grounded = true,
                            talking = if ____t_2327(____temp_2326) then __O[2063] else if ____t_2329(____temp_2328) then ____call_2333(____arrL_result_2332, "includes", ____opt_2330) else __O[2062],
                            injured = id == "ravile" and not __t(__L1.q.arthur),
                            helping = id == "aica" and not __t(__L1.q.arthur),
                            expressive = id == "arthur",
                            smoking = id == "dede",
                            smoke = id == "dede"
                        }
                    )
                    ____L1_sprite_2337(
                        __L1,
                        __TS__SparseArraySpread(____array_2336)
                    )
                    if id == "swift" then
                        __L1:pill("Irmão de Clara", n.x, __L1.FLOOR - 112, if __L1.nearNPC == id then "#ffe19b" else "#e0d7ba")
                        __L1:pill("Swift", n.x, __L1.FLOOR - 96, "#e0d7ba")
                    else
                        __L1:pill(n.name, n.x, __L1.FLOOR - 100, if __L1.nearNPC == id then "#ffe19b" else "#e0d7ba")
                    end
                    local ____t_2342 = __t
                    local ____t_2341 = __t
                    local ____t_2339 = __t
                    local ____temp_2338 = __L1.nearNPC == id
                    __O[2064] = ____temp_2338
                    local ____temp_2340 = if ____t_2339(____temp_2338) then __L1.started else __O[2064]
                    __O[2065] = ____temp_2340
                    if ____t_2342(if ____t_2341(____temp_2340) then not __t(__L1.dialog) else __O[2065]) then
                        __L1:pill("[E] conversar", n.x, __L1.FLOOR - 134, "#b8e5a4")
                    end
                end
            end
            local ____t_2347 = __t
            local ____t_2344 = __t
            local ____temp_2343 = __L1.scene == 0
            __O[2066] = ____temp_2343
            local ____opt_2345 = window.Art
            if ____opt_2345 ~= nil then
                ____opt_2345 = ____opt_2345.drawVehicle
            end
            if ____t_2347(if ____t_2344(____temp_2343) then ____opt_2345 else __O[2066]) then
                window.Art:drawVehicle(__L1.ctx, 1040, __L1.FLOOR - 5, __L1.time)
            end
            __L1:drawMinions()
            local ____opt_2350 = window.FavelaCasas
            if ____opt_2350 ~= nil then
                ____opt_2350 = ____opt_2350.portas
            end
            if ____opt_2350 ~= nil then
                ____opt_2350(____opt_2350, __L1.ctx, __L1.scene, __L1.time)
            end
            local ____iter_2358 = __iter
            local ____t_2357 = __t
            local ____opt_2355 = window.WorldData
            if ____opt_2355 ~= nil then
                ____opt_2355 = ____opt_2355.doors
            end
            __O[2067] = ____opt_2355
            for ____, d in __TS__Iterator(____iter_2358(if ____t_2357(____opt_2355) then __O[2067] else __arrL({}, 0))) do
                local ____t_2354 = __t
                local ____t_2353 = __t
                local ____temp_2352 = d.scene == __L1.scene and math.abs(__L1.player.x - d.x) < 110
                __O[2068] = ____temp_2352
                if ____t_2354(if ____t_2353(____temp_2352) then math.abs(__L1.player.y - __L1.FLOOR) < 80 else __O[2068]) then
                    __L1:pill(if __t(__L1.vehicle) then "[V] estacionar para entrar" else __add("[E] ", d.label), d.x, __L1.FLOOR - 125, "#f3d89e")
                end
            end
        end
        local ____iter_2369 = __iter
        local ____t_2368 = __t
        local ____opt_2366 = window.WorldData
        if ____opt_2366 ~= nil then
            ____opt_2366 = ____opt_2366.sarueTraps
        end
        __O[2069] = ____opt_2366
        for ____, trap in __TS__Iterator(____iter_2369(if ____t_2368(____opt_2366) then __O[2069] else __arrL({}, 0))) do
            local ____t_2365 = __t
            local ____t_2362 = __t
            local ____t_2360 = __t
            local ____temp_2359 = trap.scene == __L1.scene
            __O[2070] = ____temp_2359
            local ____temp_2361 = if ____t_2360(____temp_2359) then not __t(__L1.arena) or __L1.arena.type == "marco" else __O[2070]
            __O[2071] = ____temp_2361
            local ____opt_2363 = window.Art
            if ____opt_2363 ~= nil then
                ____opt_2363 = ____opt_2363.drawSarueTrap
            end
            if ____t_2365(if ____t_2362(____temp_2361) then ____opt_2363 else __O[2071]) then
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
            local ____t_2372 = __t
            local ____t_2371 = __t
            local ____le_result_2370 = __le(e.hp, 0)
            __O[2072] = ____le_result_2370
            if ____t_2372(if ____t_2371(____le_result_2370) then __O[2072] else if __t(__L1.arena) then e.type ~= __L1.arena.type else __L1.arena) then
                continue
            end
            if e == __L1.activeBoss then
                local ____opt_2375 = window.FxPixel
                if ____opt_2375 ~= nil then
                    ____opt_2375 = ____opt_2375.chefe
                end
                if ____opt_2375 ~= nil then
                    ____opt_2375(____opt_2375, e)
                end
            end
            if __t(e.conquista) then
                local f = e.conquista
                local ataca = f.estado == "firing"
                local prepara = f.estado == "windup"
                local opt = {
                    frame = __L1.time,
                    grounded = true,
                    facing = if __lt(__L1.player.x, e.x) then -1 else 1,
                    hit = __gt(e.hit, 0),
                    attack = if __t(ataca) then ataca else prepara,
                    attackProgress = if __t(prepara) then 0.25 * __L1:clamp(f.tempo / f.dur, 0, 1) else if __t(ataca) then 0.3 + 0.7 * __L1:clamp(f.tempo / f.dur, 0, 1) else 0,
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
                        __assign({}, opt, {moving = false, facing = if __lt(__L1.player.x, f.gemeoX) then -1 else 1})
                    )
                end
                continue
            end
            if e.state == "underground" then
                local ____L1_drawSewerMarker_2378 = __L1.drawSewerMarker
                local ____e_diveFromX_2377 = e.diveFromX
                if ____e_diveFromX_2377 == nil then
                    ____e_diveFromX_2377 = e.x
                end
                ____L1_drawSewerMarker_2378(__L1, ____e_diveFromX_2377, false)
                continue
            end
            local fxOn = e == __L1.activeBoss
            if __t(fxOn) then
                local ____opt_2381 = window.BossFx
                if ____opt_2381 ~= nil then
                    ____opt_2381 = ____opt_2381.drawBack
                end
                if ____opt_2381 ~= nil then
                    ____opt_2381(____opt_2381, __L1.ctx, e, __L1.time)
                end
            end
            if e.type == "nikolas" then
                local ____opt_2385 = window.NikolasFx
                if ____opt_2385 ~= nil then
                    ____opt_2385 = ____opt_2385.aura
                end
                if ____opt_2385 ~= nil then
                    ____opt_2385(
                        ____opt_2385,
                        __L1.ctx,
                        e,
                        __L1.time,
                        if __lt(__L1.player.x, e.x) then -1 else 1
                    )
                end
            end
            if e.type == "igor" then
                e.igorScale = __L1:igorScale(e)
            end
            local ____opt_2389 = window.BossFx
            if ____opt_2389 ~= nil then
                ____opt_2389 = ____opt_2389.transform
            end
            local ____opt_result_2391
            if ____opt_2389 ~= nil then
                ____opt_result_2391 = ____opt_2389(____opt_2389, e, __L1.player)
            end
            local bt = if __t(fxOn) then ____opt_result_2391 else nil
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
            local ____L1_sprite_2470 = __L1.sprite
            local ____array_2469 = __TS__SparseArrayNew(e.type, e.x, e.y)
            local ____t_2394 = __t
            local ____t_2393 = __t
            local ____temp_2392 = __L1:isSchoolMonitor(e)
            __O[2073] = ____temp_2392
            local ____temp_2438 = if ____t_2394(if ____t_2393(____temp_2392) then not __t(__L1.arena) else __O[2073]) then e.monitorDir else if __lt(__L1.player.x, e.x) then -1 else 1
            local ____L1_time_2439 = __L1.time
            local ____temp_2440 = if e.type == "nikolas" then if __t(e.phase) then e.phase else 1 else nil
            local ____temp_2441 = e.type == "nikolas" and e.state == "phaseChange"
            local ____temp_2442 = if e.type == "nikolas" then __L1:nikolasTransformProgress(e) else 1
            local ____e_state_2443 = e.state
            local ____e_kind_2444 = e.kind
            local ____e_targetX_2445 = e.targetX
            local ____gt_result_2446 = __gt(e.hit, 0)
            local ____temp_2447 = e.state == "windup" or e.state == "firing"
            local ____L1_clamp_2397 = __L1.clamp
            local ____L1_time_2396 = __L1.time
            local ____e_visualAttackAt_2395 = e.visualAttackAt
            if ____e_visualAttackAt_2395 == nil then
                ____e_visualAttackAt_2395 = __L1.time
            end
            local ____temp_2448 = if e.state == "windup" then 0.28 * __L1:clamp(1 - e.stateTimer / if __t(e.windupDuration) then e.windupDuration else 1, 0, 1) else if e.state == "firing" then 0.3 + 0.7 * ____L1_clamp_2397(__L1, (____L1_time_2396 - ____e_visualAttackAt_2395) / 0.45, 0, 1) else 0
            local ____gt_result_2449 = __gt(e.angry, 0)
            local ____e_rage_2450 = e.rage
            local ____t_2400 = __t
            local ____t_2399 = __t
            local ____temp_2398 = e.type == "marco"
            __O[2074] = ____temp_2398
            local ____temp_2451 = if e.type == "igor" then __L1:igorScale(e) else if ____t_2400(if ____t_2399(____temp_2398) then e.rage else __O[2074]) then 1.4 else 1
            local ____temp_2452 = not not __t(__L1.arena)
            local ____temp_2453 = e.state == "bellyRolling"
            local ____temp_2454 = if __t(e.rollAngle) then e.rollAngle else 0
            local ____t_2403 = __t
            local ____t_2402 = __t
            local ____temp_2401 = e.type == "igor"
            __O[2075] = ____temp_2401
            local ____opt_2408 = window.BossFx
            if ____opt_2408 ~= nil then
                ____opt_2408 = ____opt_2408.igorPose
            end
            local ____opt_result_2410
            if ____opt_2408 ~= nil then
                ____opt_result_2410 = ____opt_2408(____opt_2408, e)
            end
            local ____opt_result_2411
            if ____opt_result_2410 ~= nil then
                ____opt_result_2411 = ____opt_result_2410.pose
            end
            local ____temp_2455 = if ____t_2403(if ____t_2402(____temp_2401) then fxOn else __O[2075]) then ____opt_result_2411 else nil
            local ____t_2414 = __t
            local ____t_2413 = __t
            local ____temp_2412 = e.type == "igor"
            __O[2076] = ____temp_2412
            local ____opt_2419 = window.BossFx
            if ____opt_2419 ~= nil then
                ____opt_2419 = ____opt_2419.igorPose
            end
            local ____opt_result_2421
            if ____opt_2419 ~= nil then
                ____opt_result_2421 = ____opt_2419(____opt_2419, e)
            end
            local ____opt_result_2422
            if ____opt_result_2421 ~= nil then
                ____opt_result_2422 = ____opt_result_2421.k
            end
            local ____temp_2456 = if ____t_2414(if ____t_2413(____temp_2412) then fxOn else __O[2076]) then ____opt_result_2422 else nil
            local ____temp_2457 = e.state == "firing"
            local ____t_2424 = __t
            local ____temp_2423 = e.state == "dashing"
            __O[2078] = ____temp_2423
            local ____t_2426 = __t
            local ____temp_2425 = __L1:isSchoolMonitor(e)
            __O[2077] = ____temp_2425
            local ____temp_2458 = if ____t_2424(____temp_2423) then __O[2078] else if ____t_2426(____temp_2425) then not __t(__L1.arena) else __O[2077]
            local ____temp_2459 = e.state == "dashing"
            local ____t_2429 = __t
            local ____t_2428 = __t
            local ____temp_2427 = __L1:isSchoolMonitor(e)
            __O[2079] = ____temp_2427
            local ____temp_2460 = if e.state == "dashing" then 600 else if ____t_2429(if ____t_2428(____temp_2427) then not __t(__L1.arena) else __O[2079]) then 33 else 0
            local ____ge_result_2461 = __ge(e.y, __L1.FLOOR)
            local ____temp_2462 = e.type == "arthur"
            local ____temp_2463 = e.type == "dede"
            local ____temp_2464 = e.type == "dede"
            local ____t_2431 = __t
            local ____temp_2430 = e.type == "dede" and e.state == "windup"
            __O[2080] = ____temp_2430
            local ____temp_2465 = if ____t_2431(____temp_2430) then e.kind == "tragada" else __O[2080]
            local ____temp_2466 = e.state == "concealed"
            local ____temp_2467 = if e.type == "marco" then "doodle" else if e.type == "nikolas" then "slime" else if e.type == "freddy" then "punch" else if e.type == "nicolas" then "cast" else "word"
            local ____temp_2434 = e.type == "nicolas"
            if ____temp_2434 then
                local ____opt_2432 = __L1.arena
                if ____opt_2432 ~= nil then
                    ____opt_2432 = ____opt_2432.type
                end
                ____temp_2434 = ____opt_2432 == "nicolas"
            end
            local ____temp_2468 = e.type == "nicolas" and e.state == "windup"
            local ____temp_2437 = e.type == "nicolas"
            if ____temp_2437 then
                local ____opt_2435 = __L1.arena
                if ____opt_2435 ~= nil then
                    ____opt_2435 = ____opt_2435.type
                end
                ____temp_2437 = ____opt_2435 == "nicolas"
            end
            __TS__SparseArrayPush(____array_2469, {
                facing = ____temp_2438,
                frame = ____L1_time_2439,
                bossPhase = ____temp_2440,
                phaseChanging = ____temp_2441,
                transformProgress = ____temp_2442,
                phaseState = ____e_state_2443,
                giantAttack = ____e_kind_2444,
                attackTargetX = ____e_targetX_2445,
                hit = ____gt_result_2446,
                attack = ____temp_2447,
                attackProgress = ____temp_2448,
                angry = ____gt_result_2449,
                rage = ____e_rage_2450,
                scale = ____temp_2451,
                monitorBattle = ____temp_2452,
                bellyRolling = ____temp_2453,
                rollAngle = ____temp_2454,
                igorPose = ____temp_2455,
                igorPoseK = ____temp_2456,
                firing = ____temp_2457,
                moving = ____temp_2458,
                dash = ____temp_2459,
                speed = ____temp_2460,
                grounded = ____ge_result_2461,
                expressive = ____temp_2462,
                smoking = ____temp_2463,
                smoke = ____temp_2464,
                inhale = ____temp_2465,
                hiddenInSmoke = ____temp_2466,
                attackType = ____temp_2467,
                supreme = ____temp_2434,
                charging = ____temp_2468,
                powered = ____temp_2437,
                noseRub = e.type == "nikolas"
            })
            ____L1_sprite_2470(
                __L1,
                __TS__SparseArraySpread(____array_2469)
            )
            if __t(bt) then
                __L1.ctx:restore()
            end
            if __t(fxOn) then
                local ____opt_2473 = window.BossFx
                if ____opt_2473 ~= nil then
                    ____opt_2473 = ____opt_2473.drawFront
                end
                if ____opt_2473 ~= nil then
                    ____opt_2473(____opt_2473, __L1.ctx, e, __L1.time)
                end
            end
            if e.type == "nikolas" then
                local ____opt_2477 = window.NikolasFx
                if ____opt_2477 ~= nil then
                    ____opt_2477 = ____opt_2477.frente
                end
                if ____opt_2477 ~= nil then
                    ____opt_2477(
                        ____opt_2477,
                        __L1.ctx,
                        e,
                        __L1.time,
                        if __lt(__L1.player.x, e.x) then -1 else 1
                    )
                end
            end
            local ____e_y_2482 = e.y
            local ____t_2481 = __t
            local ____t_2480 = __t
            local ____temp_2479 = e.type == "igor"
            __O[2081] = ____temp_2479
            local nameY = ____e_y_2482 - if e.type == "giant" then 205 else if ____t_2481(if ____t_2480(____temp_2479) then __L1.arena else __O[2081]) then 90 * __L1:igorScale(e) + 28 else if e.type == "kaique" then 115 else if e.type == "reeisBoss" then 145 else if __t(e.rage) then 140 else 96
            local ____t_2491 = __t
            local ____t_2486 = __t
            local ____temp_2485 = e.type == "igor"
            if ____temp_2485 then
                local ____opt_2483 = __L1.arena
                if ____opt_2483 ~= nil then
                    ____opt_2483 = ____opt_2483.type
                end
                ____temp_2485 = ____opt_2483 == "igor"
            end
            local ____temp_2490 = not ____t_2486(____temp_2485)
            if ____temp_2490 then
                local ____t_2489 = __t
                local ____t_2488 = __t
                local ____temp_2487 = e.type == "nikolas" and __ge(e.phase, 2)
                __O[2082] = ____temp_2487
                ____temp_2490 = not ____t_2489(if ____t_2488(____temp_2487) then __L1.arena else __O[2082])
            end
            if ____t_2491(____temp_2490) then
                local ____L1_pill_2495 = __L1.pill
                local ____call_2494 = __call
                local ____t_2493 = __t
                local ____temp_2492 = __L1:nomeBoss(e.type)
                __O[2083] = ____temp_2492
                ____L1_pill_2495(
                    __L1,
                    ____call_2494(if ____t_2493(____temp_2492) then __O[2083] else e.type, "toUpperCase"),
                    e.x,
                    nameY,
                    if e.type == "nicolas" then "#fff0aa" else if e.type == "nikolas" then "#f5b38c" else "#eacb98"
                )
                __L1.ctx.fillStyle = "#243b31"
                __L1.ctx:fillRect(e.x - 47, nameY + 19, 94, 6)
                __L1.ctx.fillStyle = "#d98c72"
                __L1.ctx:fillRect(e.x - 46, nameY + 20, 92 * e.hp / e.max, 4)
            end
            if __t(e.type == "marco" and math.abs(e.x - __L1.player.x) < 520) then
                __L1:pill(if __gt(e.angry, 0) then "FÚRIA VERMELHA!" else "CUIDADO COM O PISO SARUÊ", e.x, e.y - 126, if __gt(e.angry, 0) then "#f5abc2" else "#e1c6ec")
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
        if not __t(__L1.arena) then
            __L1:drawSchoolCover()
        end
        if __t(__L1.arena) then
            __L1:drawMinions()
        end
        __L1:drawBossTelegraphs()
        __L1:drawReeis()
        local ____t_2509 = __t
        local ____t_2503 = __t
        local ____t_2501 = __t
        local ____t_2499 = __t
        local ____t_2497 = __t
        local ____temp_2496 = not __t(__L1.arena) and not __t(__L1.room)
        __O[2084] = ____temp_2496
        local ____temp_2498 = if ____t_2497(____temp_2496) then not __t(__L1.dialog) else __O[2084]
        __O[2085] = ____temp_2498
        local ____temp_2500 = if ____t_2499(____temp_2498) then __L1.started else __O[2085]
        __O[2086] = ____temp_2500
        local ____temp_2502 = if ____t_2501(____temp_2500) then not __t(__L1.vehicle) else __O[2086]
        __O[2087] = ____temp_2502
        local ____opt_2506 = window.Fliperama
        if ____opt_2506 ~= nil then
            ____opt_2506 = ____opt_2506.near
        end
        local ____opt_result_2508
        if ____opt_2506 ~= nil then
            ____opt_result_2508 = ____opt_2506(____opt_2506, __L1.scene, __L1.player.x)
        end
        if ____t_2509(if ____t_2503(____temp_2502) then ____opt_result_2508 else __O[2087]) then
            __L1:pill("[E] JOGAR FLIPERAMA", __L1.player.x, __L1.FLOOR - 140, "#ffd0f0")
        end
        local ____t_2531 = __t
        local ____t_2525 = __t
        local ____t_2517 = __t
        local ____t_2515 = __t
        local ____t_2513 = __t
        local ____t_2511 = __t
        local ____temp_2510 = not __t(__L1.arena) and not __t(__L1.room)
        __O[2088] = ____temp_2510
        local ____temp_2512 = if ____t_2511(____temp_2510) then not __t(__L1.dialog) else __O[2088]
        __O[2089] = ____temp_2512
        local ____temp_2514 = if ____t_2513(____temp_2512) then __L1.started else __O[2089]
        __O[2090] = ____temp_2514
        local ____temp_2516 = if ____t_2515(____temp_2514) then not __t(__L1.vehicle) else __O[2090]
        __O[2091] = ____temp_2516
        local ____t_2523 = __t
        local ____opt_2520 = window.Balanco
        if ____opt_2520 ~= nil then
            ____opt_2520 = ____opt_2520.active
        end
        local ____opt_result_2522
        if ____opt_2520 ~= nil then
            ____opt_result_2522 = ____opt_2520(____opt_2520)
        end
        local ____temp_2524 = if ____t_2517(____temp_2516) then not ____t_2523(____opt_result_2522) else __O[2091]
        __O[2092] = ____temp_2524
        local ____opt_2528 = window.Balanco
        if ____opt_2528 ~= nil then
            ____opt_2528 = ____opt_2528.near
        end
        local ____opt_result_2530
        if ____opt_2528 ~= nil then
            ____opt_result_2530 = ____opt_2528(____opt_2528, __L1.scene, __L1.player.x)
        end
        if ____t_2531(if ____t_2525(____temp_2524) then ____opt_result_2530 else __O[2092]) then
            __L1:pill("[E] SENTAR NO BALANÇO", __L1.player.x, __L1.FLOOR - 140, "#ffe2a8")
        end
        local ____t_2534 = __t
        local ____t_2533 = __t
        local ____temp_2532 = not __t(__L1.arena) and not __t(__L1.dialog)
        __O[2093] = ____temp_2532
        if ____t_2534(if ____t_2533(____temp_2532) then __L1.started else __O[2093]) then
            local nearby = __L1:closestBoss()
            if __t(nearby) then
                local access = __L1:bossAccess(nearby)
                __L1:pill(if __t(access.ok) then __add(
                    "[E] DESAFIAR ",
                    __call(
                        __L1:nomeBoss(nearby.type),
                        "toUpperCase"
                    )
                ) else "[E] VER MISSÕES PARA O CHEFE", nearby.x, nearby.y - if nearby.type == "giant" then 242 else 172, if __t(access.ok) then "#daeda3" else "#f3d298")
            end
        end
        local ____t_2539 = __t
        local ____t_2538 = __t
        local ____opt_2535 = __L1.arena
        if ____opt_2535 ~= nil then
            ____opt_2535 = ____opt_2535.phase
        end
        local ____temp_2537 = ____opt_2535 == "active" and not __t(__L1.dialog)
        __O[2094] = ____temp_2537
        if ____t_2539(if ____t_2538(____temp_2537) then not __t(percurso) or __le(
            __L1.player.x,
            __get(__L1.arena.bounds, 0) + 78
        ) else __O[2094]) then
            local ____L1_pill_2545 = __L1.pill
            local ____temp_2544 = __get(__L1.arena.bounds, 0) + 87
            local ____t_2543 = __t
            local ____opt_result_2542
            if duelo ~= nil then
                ____opt_result_2542 = duelo.ceu
            end
            ____L1_pill_2545(
                __L1,
                "[E] SAIR DA ARENA",
                ____temp_2544,
                if ____t_2543(____opt_result_2542) then __get(duelo.ceu.ilhas, 0).y + 50 else __L1.FLOOR - 65,
                "#e4ce9b"
            )
        end
        if __t(if __t(__L1.started) then not __t(percurso) else __L1.started) then
            local ____opt_2548 = window.SceneLife
            if ____opt_2548 ~= nil then
                ____opt_2548 = ____opt_2548.drawBack
            end
            if ____opt_2548 ~= nil then
                ____opt_2548(
                    ____opt_2548,
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
        if __t(if __t(__L1.started) then __le(__L1.player.inv, 0) or __mod(
            math.floor(__L1.time * 15),
            2
        ) == 0 else __L1.started) then
            local function drawHero(____, c, ox, oy)
                local function paint(____, ____type, x, y, opt)
                    local ____t_2552 = __t
                    local ____opt_2550 = window.Art
                    if ____opt_2550 ~= nil then
                        ____opt_2550 = ____opt_2550.drawCharacter
                    end
                    if ____t_2552(____opt_2550) then
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
                local ____t_2555 = __t
                local ____opt_2553 = window.Art
                if ____opt_2553 ~= nil then
                    ____opt_2553 = ____opt_2553.drawVehicle
                end
                if ____t_2555(if __t(__L1.vehicle) then ____opt_2553 else __L1.vehicle) then
                    local vf = if __lt(__L1.player.facing, 0) then -1 else 1
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
                    local ____t_2561 = __t
                    local ____opt_2558 = window.SceneLife
                    if ____opt_2558 ~= nil then
                        ____opt_2558 = ____opt_2558.heroScale
                    end
                    local ____opt_result_2560
                    if ____opt_2558 ~= nil then
                        ____opt_result_2560 = ____opt_2558(____opt_2558, __L1.player, __L1.vehicle)
                    end
                    __O[2095] = ____opt_result_2560
                    local k = if ____t_2561(____opt_result_2560) then __O[2095] else {sx = 1, sy = 1}
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
            local ____t_2567 = __t
            local ____opt_2564 = window.Balanco
            if ____opt_2564 ~= nil then
                ____opt_2564 = ____opt_2564.active
            end
            local ____opt_result_2566
            if ____opt_2564 ~= nil then
                ____opt_result_2566 = ____opt_2564(____opt_2564)
            end
            if ____t_2567(____opt_result_2566) then
            else
                local ____t_2576 = __t
                local ____t_2570 = __t
                local ____opt_2568 = __L1.routeTransition
                if ____opt_2568 ~= nil then
                    ____opt_2568 = ____opt_2568.chegada
                end
                __O[2096] = ____opt_2568
                local ____opt_2573 = window.ChegadaCarro
                if ____opt_2573 ~= nil then
                    ____opt_2573 = ____opt_2573.desenhar
                end
                local ____opt_result_2575
                if ____opt_2573 ~= nil then
                    ____opt_result_2575 = ____opt_2573(
                        ____opt_2573,
                        __L1.ctx,
                        {
                            x = __L1.player.x,
                            y = __L1.player.y,
                            time = __L1.time,
                            pintar = function(____, c, x, y) return drawHero(nil, c, x, y) end
                        }
                    )
                end
                if ____t_2576(if ____t_2570(____opt_2568) then ____opt_result_2575 else __O[2096]) then
                else
                    local ____t_2583 = __t
                    local ____t_2582 = __t
                    local ____opt_2579 = window.HeroShadow
                    if ____opt_2579 ~= nil then
                        ____opt_2579 = ____opt_2579.draw
                    end
                    local ____opt_result_2581
                    if ____opt_2579 ~= nil then
                        ____opt_result_2581 = ____opt_2579(
                            ____opt_2579,
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
                    if ____t_2583(if __t(percurso) then percurso else not ____t_2582(____opt_result_2581)) then
                        drawHero(nil, __L1.ctx, __L1.player.x, __L1.player.y)
                    end
                end
            end
        end
        if not __t(percurso) then
            if __t(__L1.started) then
                local ____opt_2586 = window.SceneLife
                if ____opt_2586 ~= nil then
                    ____opt_2586 = ____opt_2586.drawFront
                end
                if ____opt_2586 ~= nil then
                    ____opt_2586(
                        ____opt_2586,
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
            local ____opt_2599 = window.Interact
            if ____opt_2599 ~= nil then
                ____opt_2599 = ____opt_2599.drawFront
            end
            if ____opt_2599 ~= nil then
                local ____L1_ctx_2597 = __L1.ctx
                local ____L1_scene_2593 = __L1.scene
                local ____L1_camera_2594 = __L1.camera
                local ____L1_time_2595 = __L1.time
                local ____temp_2596 = not not __t(__L1.arena)
                local ____opt_2589 = __L1.arena
                if ____opt_2589 ~= nil then
                    ____opt_2589 = ____opt_2589.type
                end
                local ____opt_2591 = __L1.arena
                if ____opt_2591 ~= nil then
                    ____opt_2591 = ____opt_2591.homeX
                end
                ____opt_2599(
                    ____opt_2599,
                    ____L1_ctx_2597,
                    {
                        scene = ____L1_scene_2593,
                        camera = ____L1_camera_2594,
                        time = ____L1_time_2595,
                        arena = ____temp_2596,
                        arenaType = ____opt_2589,
                        homeX = ____opt_2591,
                        room = not not __t(__L1.room)
                    }
                )
            end
            local ____opt_2603 = window.Balanco
            if ____opt_2603 ~= nil then
                ____opt_2603 = ____opt_2603.draw
            end
            if ____opt_2603 ~= nil then
                ____opt_2603(
                    ____opt_2603,
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
            local ____opt_2607 = window.Trigal
            if ____opt_2607 ~= nil then
                ____opt_2607 = ____opt_2607.drawFront
            end
            if ____opt_2607 ~= nil then
                ____opt_2607(
                    ____opt_2607,
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
            local ____opt_2611 = window.CampanhaPlantas
            if ____opt_2611 ~= nil then
                ____opt_2611 = ____opt_2611.drawFront
            end
            if ____opt_2611 ~= nil then
                ____opt_2611(
                    ____opt_2611,
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
            local ____opt_2615 = window.CampanhaCamadas
            if ____opt_2615 ~= nil then
                ____opt_2615 = ____opt_2615.primeiroPlano
            end
            if ____opt_2615 ~= nil then
                ____opt_2615(
                    ____opt_2615,
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
        local ____t_2619 = __t
        local ____opt_2617 = __L1.activeBoss
        if ____opt_2617 ~= nil then
            ____opt_2617 = ____opt_2617.conquista
        end
        if ____t_2619(____opt_2617) then
            window.ConquistaEfeitos:desenhar(__L1.ctx, __L1.activeBoss.conquista)
        end
        local ____opt_2622 = window.BossFx
        if ____opt_2622 ~= nil then
            ____opt_2622 = ____opt_2622.drawShotTrails
        end
        if ____opt_2622 ~= nil then
            ____opt_2622(____opt_2622, __L1.ctx, __L1.shots)
        end
        for ____, s in __iterar((__L1.shots)) do
            local ____t_2629 = __t
            local ____opt_2626 = window.CampaignVfx
            if ____opt_2626 ~= nil then
                ____opt_2626 = ____opt_2626.drawProjectile
            end
            local ____opt_result_2628
            if ____opt_2626 ~= nil then
                ____opt_result_2628 = ____opt_2626(____opt_2626, __L1.ctx, s, __L1.time)
            end
            if ____t_2629(____opt_result_2628) then
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
                __L1.ctx.fillStyle = if s.element == "electric" then "#a3edf7" else "#f5a541"
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
                __L1.ctx.strokeStyle = if s.element == "electric" then "#e1ffff" else "#ffe1a6"
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
                        if math.abs(yy - s.gapY) < s.gapHeight / 2 then
                            continue
                        end
                        __L1.ctx:fillRect(s.x - 25, yy - 10, 50, 22)
                        __L1:text(
                            "POUDI",
                            s.x,
                            yy,
                            10,
                            "#43283e"
                        )
                        yy = yy + 26
                    end
                end
                __L1.ctx.strokeStyle = "#d1ec9a"
                __L1.ctx.lineWidth = 3
                __L1.ctx:strokeRect(s.x - 27, s.gapY - s.gapHeight / 2, 54, s.gapHeight)
                __L1.ctx:restore()
            elseif s.type == "doodle" then
                local ____t_2632 = __t
                local ____opt_2630 = window.Art
                if ____opt_2630 ~= nil then
                    ____opt_2630 = ____opt_2630.drawDoodle
                end
                if ____t_2632(____opt_2630) then
                    window.Art:drawDoodle(
                        __L1.ctx,
                        s.x,
                        s.y,
                        s.variant,
                        __L1.time,
                        s.enraged
                    )
                else
                    __L1.ctx.strokeStyle = if __t(s.enraged) then "#eb93ae" else "#d0a6e6"
                    __L1.ctx.lineWidth = 3
                    __L1.ctx:beginPath()
                    do
                        local i = 0
                        while i < 13 do
                            local a = i / 12 * math.pi * 2
                            local r = if __t(__mod(i, 2)) then 12 else 21
                            local x = s.x + math.cos(a + __L1.time * 3) * r
                            local y = s.y + math.sin(a + __L1.time * 3) * r
                            local ____ = if __t(i) then __L1.ctx:lineTo(x, y) else __L1.ctx:moveTo(x, y)
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
                    if __t(s.echo) then "#bddeed" else "#f5c9de"
                )
                __L1.ctx:restore()
            else
                local ____t_2640 = __t
                local ____t_2634 = __t
                local ____temp_2633 = s.type == "slime"
                __O[2097] = ____temp_2633
                local ____opt_2637 = window.NikolasFx
                if ____opt_2637 ~= nil then
                    ____opt_2637 = ____opt_2637.catarro
                end
                local ____opt_result_2639
                if ____opt_2637 ~= nil then
                    ____opt_result_2639 = ____opt_2637(____opt_2637, __L1.ctx, s, __L1.time)
                end
                if ____t_2640(if ____t_2634(____temp_2633) then ____opt_result_2639 else __O[2097]) then
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
                    __L1.ctx:rotate(if s.type == "paper" then __L1.time * 9 else 0)
                    __L1.ctx.fillStyle = if s.type == "paper" then "#fff3d6" else if s.type == "ruler" then "#e0b061" else if s.type == "case" then "#9dd3c3" else "#ffe096"
                    __L1.ctx:fillRect(-6, -5, if s.type == "paper" then 12 else if s.type == "ruler" then 28 else 18, 10)
                    __L1.ctx.fillStyle = "#d5c9ad"
                    __L1.ctx:fillRect(-3, -3, 6, 2)
                    __L1.ctx:restore()
                end
            end
        end
        local ____opt_2643 = window.CampaignVfx
        if ____opt_2643 ~= nil then
            ____opt_2643 = ____opt_2643.draw
        end
        if ____opt_2643 ~= nil then
            ____opt_2643(____opt_2643, __L1.ctx, __L1.time, "front")
        end
        local ____opt_2647 = window.FxPixel
        if ____opt_2647 ~= nil then
            ____opt_2647 = ____opt_2647.desenhar
        end
        if ____opt_2647 ~= nil then
            ____opt_2647(____opt_2647, __L1.ctx, {dono = "luta", camada = "front", camera = __L1.camera, tempo = __L1.time})
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
        local ____opt_2651 = window.Golpes
        if ____opt_2651 ~= nil then
            ____opt_2651 = ____opt_2651.desenharCaixas
        end
        if ____opt_2651 ~= nil then
            ____opt_2651(____opt_2651, __L1.ctx, {
                player = __L1.player,
                enemies = __L1.enemies,
                minions = __L1.minions,
                shots = __L1.shots,
                hazards = __L1.hazards
            })
        end
        local ____t_2658 = __t
        local ____t_2657 = __t
        local ____t_2655 = __t
        local ____opt_2653 = __L1.activeBoss
        if ____opt_2653 ~= nil then
            ____opt_2653 = ____opt_2653.conquista
        end
        local ____temp_2656 = if __t(__L1.arena) then not ____t_2655(____opt_2653) else __L1.arena
        __O[2098] = ____temp_2656
        if ____t_2658(if ____t_2657(____temp_2656) then window.HdScene else __O[2098]) then
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
            local ____opt_2661 = window.HdMaps
            if ____opt_2661 ~= nil then
                ____opt_2661 = ____opt_2661.arenaFront
            end
            if ____opt_2661 ~= nil then
                ____opt_2661(
                    ____opt_2661,
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
            local ____t_2669 = __t
            local ____t_2668 = __t
            local ____t_2666 = __t
            local ____t_2664 = __t
            local ____temp_2663 = not __t(__L1.arena)
            __O[2099] = ____temp_2663
            local ____temp_2665 = if ____t_2664(____temp_2663) then __L1.started else __O[2099]
            __O[2100] = ____temp_2665
            local ____temp_2667 = if ____t_2666(____temp_2665) then window.HdScene else __O[2100]
            __O[2101] = ____temp_2667
            if ____t_2669(if ____t_2668(____temp_2667) then __call(
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
            ) else __O[2101]) then
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
        local ____t_2674 = __t
        local ____t_2673 = __t
        local ____t_2671 = __t
        local ____temp_2670 = not __t(__L1.arena)
        __O[2102] = ____temp_2670
        local ____temp_2672 = if ____t_2671(____temp_2670) then __L1.started else __O[2102]
        __O[2103] = ____temp_2672
        if ____t_2674(if ____t_2673(____temp_2672) then window.Weather else __O[2103]) then
            __L1.ctx:save()
            __L1.ctx:translate(
                math.floor(__L1.camera + 0.5),
                0
            )
            local ____self_2683 = window.Weather
            local ____self_2683_draw_2684 = ____self_2683.draw
            local ____L1_ctx_2682 = __L1.ctx
            local ____L1_scene_2679 = __L1.scene
            local ____L1_camera_2680 = __L1.camera
            local ____L1_time_2681 = __L1.time
            local ____t_2678 = __t
            local ____t_2676 = __t
            local ____temp_2675 = not __t(__L1.cutscene) and not __t(__L1.room)
            __O[2104] = ____temp_2675
            local ____temp_2677 = if ____t_2676(____temp_2675) then not __t(__L1.activity) else __O[2104]
            __O[2105] = ____temp_2677
            ____self_2683_draw_2684(____self_2683, ____L1_ctx_2682, {
                scene = ____L1_scene_2679,
                camera = ____L1_camera_2680,
                time = ____L1_time_2681,
                outdoor = if ____t_2678(____temp_2677) then not __t(__L1.ollyanEncounter) else __O[2105],
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
        local ____t_2693 = __t
        local ____t_2690 = __t
        local ____t_2688 = __t
        local ____t_2686 = __t
        local ____temp_2685 = not __t(__L1.arena)
        __O[2106] = ____temp_2685
        local ____temp_2687 = if ____t_2686(____temp_2685) then __L1.started else __O[2106]
        __O[2107] = ____temp_2687
        local ____temp_2689 = if ____t_2688(____temp_2687) then __L1.scene == 6 else __O[2107]
        __O[2108] = ____temp_2689
        local ____opt_2691 = window.HdMaps
        if ____opt_2691 ~= nil then
            ____opt_2691 = ____opt_2691.darkness
        end
        if ____t_2693(if ____t_2690(____temp_2689) then ____opt_2691 else __O[2108]) then
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
        local ____t_2698 = __t
        local ____t_2695 = __t
        local ____temp_2694 = if __t(__L1.q.nikolas) then __L1.scene == 3 else __L1.q.nikolas
        __O[2109] = ____temp_2694
        local ____opt_2696 = window.Art
        if ____opt_2696 ~= nil then
            ____opt_2696 = ____opt_2696.drawCake
        end
        if ____t_2698(if ____t_2695(____temp_2694) then ____opt_2696 else __O[2109]) then
            window.Art:drawCake(__L1.ctx, 1970, __L1.FLOOR - 5)
        end
        __L1:drawEpicWorld()
        __L1.ctx:restore()
        if not __t(__L1.started) then
            __L1.ctx.fillStyle = "#192e301c"
            __L1.ctx:fillRect(0, 0, __L1.W, __L1.H)
            local ____t_2701 = __t
            local ____opt_2699 = window.Art
            if ____opt_2699 ~= nil then
                ____opt_2699 = ____opt_2699.drawVehicle
            end
            if ____t_2701(____opt_2699) then
                window.Art:drawVehicle(__L1.ctx, 760, __L1.FLOOR, __L1.time)
            end
            __L1:sprite("daroca", 760, __L1.FLOOR - 20, {facing = 1, frame = __L1.time, scale = 0.8})
        end
        local ____t_2719 = __t
        local ____t_2718 = __t
        local ____t_2713 = __t
        local ____t_2711 = __t
        local ____t_2709 = __t
        local ____t_2707 = __t
        local ____t_2705 = __t
        local ____t_2703 = __t
        local ____temp_2702 = if __t(__L1.started) then not __t(__L1.dialog) else __L1.started
        __O[2110] = ____temp_2702
        local ____temp_2704 = if ____t_2703(____temp_2702) then not __t(__L1.paused) else __O[2110]
        __O[2111] = ____temp_2704
        local ____temp_2706 = if ____t_2705(____temp_2704) then not __t(__L1.won) else __O[2111]
        __O[2112] = ____temp_2706
        local ____temp_2708 = if ____t_2707(____temp_2706) then not __t(__L1.defeated) else __O[2112]
        __O[2113] = ____temp_2708
        local ____temp_2710 = if ____t_2709(____temp_2708) then not __t(__L1.arena) else __O[2113]
        __O[2114] = ____temp_2710
        local ____temp_2712 = if ____t_2711(____temp_2710) then not __t(__L1.routeTransition) else __O[2114]
        __O[2115] = ____temp_2712
        local ____t_2716 = __t
        local ____opt_2714 = __L1.training
        if ____opt_2714 ~= nil then
            ____opt_2714 = ____opt_2714.active
        end
        local ____temp_2717 = if ____t_2713(____temp_2712) then not ____t_2716(____opt_2714) else __O[2115]
        __O[2116] = ____temp_2717
        if ____t_2719(if ____t_2718(____temp_2717) then not __t(__L1.activity) else __O[2116]) then
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
            local ____callq_2724 = __callq
            local ____opt_2722 = window.BivoltQuest
            if ____opt_2722 ~= nil then
                ____opt_2722 = ____opt_2722.parts
            end
            local ____opt_2720 = ____callq_2724(
                ____opt_2722,
                "find",
                function(____, p) return not __t(__call(__L1.q.bivoltParts, "includes", p.id)) end
            )
            if ____opt_2720 ~= nil then
                ____opt_2720 = ____opt_2720.x
            end
            local bivoltTarget = ____opt_2720
            local ____opt_2727 = window.MissaoFarda
            if ____opt_2727 ~= nil then
                ____opt_2727 = ____opt_2727.alvo
            end
            local ____opt_result_2729
            if ____opt_2727 ~= nil then
                ____opt_result_2729 = ____opt_2727(____opt_2727, __L1.q, __L1.scene)
            end
            local ____opt_result_2729_2735 = ____opt_result_2729
            if ____opt_result_2729_2735 == nil then
                local ____opt_2732 = window.LugaresC1
                if ____opt_2732 ~= nil then
                    ____opt_2732 = ____opt_2732.alvo
                end
                local ____opt_result_2734
                if ____opt_2732 ~= nil then
                    ____opt_result_2734 = ____opt_2732(____opt_2732, __L1.q, __L1.scene)
                end
                ____opt_result_2729_2735 = ____opt_result_2734
            end
            local fardaAlvo = ____opt_result_2729_2735
            local ____bivoltTarget_2736 = bivoltTarget
            if ____bivoltTarget_2736 == nil then
                ____bivoltTarget_2736 = 1220
            end
            local ____opt_result_2739
            if needPart ~= nil then
                ____opt_result_2739 = needPart.x
            end
            local ____t_2742 = __t
            local ____t_2741 = __t
            local ____temp_2740 = __L1.scene == 8
            __O[2117] = ____temp_2740
            local ____opt_result_2745
            if needBook ~= nil then
                ____opt_result_2745 = needBook.x
            end
            local ____t_2748 = __t
            local ____t_2747 = __t
            local ____temp_2746 = __L1.scene == 5 and not __t(__L1.q.freddy)
            __O[2118] = ____temp_2746
            local objective = if fardaAlvo ~= nil then fardaAlvo else if __t(__L1.scene == 11 and not __t(__L1.q.ollyan)) then 3260 else if __t(__L1.scene == 10 and not __t(__L1.q.bivoltUnlocked)) then if __t(__L1.q.bivoltAccepted) then ____bivoltTarget_2736 else 1220 else if __t(__L1.scene == 10 and not __t(__L1.q.rayssaVisit)) then 450 else if __t(__L1.scene == 0 and not __t(__L1.q.lucas)) then if __t(if __t(__L1.q.carMissionAccepted) then __len(__L1.q.carParts) < 3 else __L1.q.carMissionAccepted) then ____opt_result_2739 else 480 else if __t(__L1.scene == 7 and not __t(__L1.q.mota)) then 500 else if ____t_2742(if ____t_2741(____temp_2740) then not __t(__L1.q.bigodon) or __L1:getJaglionStatus() == "reserved" else __O[2117]) then __L1.npcInfo.davi.x else if __t(__L1.scene == 9 and not __t(__L1.q.arthur)) then if __t(__L1.q.patioAccepted) then __L1:bossHome("arthur", 2850) else 500 else if __t(__L1.scene == __L1.npcInfo.amanda.scene and not __t(__L1.q.amandaDating)) then __L1.npcInfo.amanda.x else if __t(__L1.scene == 4 and not __t(__L1.q.nicolas)) then __L1:bossHome("nicolas", 5350) else if __t(__L1.scene == 1 and not __t(__L1.q.almiro)) then if __t(if __t(__L1.q.almiroAccepted) then __len(__L1.q.notebooks) < 3 else __L1.q.almiroAccepted) then ____opt_result_2745 else 1350 else if __t(__L1.scene == 1 and not __t(__L1.q.miqueias)) then 2350 else if ____t_2748(if ____t_2747(____temp_2746) then not __t(__L1.q.reeis) else __O[2118]) then __L1:bossHome("freddy", 5680) else if __t(__L1.scene == 5 and not __t(__L1.q.reeis)) then __L1:bossHome("reeisBoss", 6400) else if __t(__L1.scene == 1 and not __t(__L1.q.marco)) then __L1:bossHome("marco", 3700) else if __t(__L1.scene == 6 and not __t(__L1.q.giant)) then __L1:bossHome("giant", 5650) else if __t(__L1.scene == 1 and not __t(__L1.q.menezes)) then __L1:bossHome("menezes", 5200) else if __t(__L1.scene == 2 and not __t(__L1.q.trained)) then 400 else if __t(__L1.scene == 3 and not __t(__L1.q.nikolas)) then __L1:bossHome("nikolas", 4300) else nil
            local ____t_2757 = __t
            local ____t_2756 = __t
            local ____temp_2755 = objective ~= nil
            if ____temp_2755 then
                local ____t_2754 = __t
                local ____opt_2751 = window.Balanco
                if ____opt_2751 ~= nil then
                    ____opt_2751 = ____opt_2751.active
                end
                local ____opt_result_2753
                if ____opt_2751 ~= nil then
                    ____opt_result_2753 = ____opt_2751(____opt_2751)
                end
                ____temp_2755 = not ____t_2754(____opt_result_2753)
            end
            __O[2119] = ____temp_2755
            if ____t_2757(if ____t_2756(____temp_2755) then __lt(objective, __L1.camera + 45) or __gt(objective, __L1.camera + __L1.W - 45) else __O[2119]) then
                local right = __gt(objective, __L1.camera + __L1.W - 45)
                __L1:pill(if __t(right) then "OBJETIVO →" else "← OBJETIVO", if __t(right) then __L1.W - 83 else 83, 62, "#ffe09b")
            end
            if __t(__L1.vehicle) then
                __L1:pill("CARRO A GÁS", __L1.W / 2, 30, "#cfe5a7")
            end
            local ____t_2760 = __t
            local ____t_2759 = __t
            local ____temp_2758 = __L1.reeisCooldown > 0
            __O[2120] = ____temp_2758
            if ____t_2760(if ____t_2759(____temp_2758) then __L1.q.reeis else __O[2120]) then
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
            __L1.ctx.globalAlpha = if __L1.reeisPhase == "burst" then 0.55 else 0.2
            __L1.ctx.strokeStyle = "#ffe7ab"
            __L1.ctx.lineWidth = 2
            do
                local i = 0
                while i < 16 do
                    local yy = 20 + i * 33 + math.sin(__L1.time * 15 + i) * 12
                    __L1.ctx:beginPath()
                    __L1.ctx:moveTo(if __t(__mod(i, 2)) then 0 else __L1.W, yy)
                    __L1.ctx:lineTo(
                        if __t(__mod(i, 2)) then 180 else __L1.W - 180,
                        yy + math.sin(i) * 25
                    )
                    __L1.ctx:stroke()
                    i = i + 1
                end
            end
            __L1.ctx:restore()
        end
        local ____t_2763 = __t
        local ____opt_2761 = __L1.training
        if ____opt_2761 ~= nil then
            ____opt_2761 = ____opt_2761.active
        end
        if ____t_2763(____opt_2761) then
            __L1:drawTraining()
        end
        if __t(if __t(__L1.routeTransition) then not __t(__L1.routeTransition.chegada) else __L1.routeTransition) then
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
        local ____opt_2770 = window.CampanhaPoderes
        if ____opt_2770 ~= nil then
            ____opt_2770 = ____opt_2770.controles
        end
        if ____opt_2770 ~= nil then
            local ____temp_2768 = __L1.scene >= 12
            if not ____temp_2768 then
                local ____t_2767 = __t
                local ____opt_2765 = window.C2Luta
                if ____opt_2765 ~= nil then
                    ____opt_2765 = ____opt_2765.skin
                end
                ____temp_2768 = not not ____t_2767(____opt_2765)
            end
            ____opt_2770(____opt_2770, ____temp_2768)
        end
        local ____t_2783 = __t
        local ____t_2777 = __t
        local ____opt_2774 = window.Fliperama
        if ____opt_2774 ~= nil then
            ____opt_2774 = ____opt_2774.isOpen
        end
        local ____opt_result_2776
        if ____opt_2774 ~= nil then
            ____opt_result_2776 = ____opt_2774(____opt_2774)
        end
        __O[2121] = ____opt_result_2776
        local ____opt_2780 = window.Campanha2
        if ____opt_2780 ~= nil then
            ____opt_2780 = ____opt_2780.aberto
        end
        local ____opt_result_2782
        if ____opt_2780 ~= nil then
            ____opt_result_2782 = ____opt_2780(____opt_2780)
        end
        if ____t_2783(if ____t_2777(____opt_result_2776) then __O[2121] else ____opt_result_2782) then
            __L1.last = now
            local ____opt_2786 = window.CampaignRun
            if ____opt_2786 ~= nil then
                ____opt_2786 = ____opt_2786.tick
            end
            if ____opt_2786 ~= nil then
                ____opt_2786(____opt_2786, now, false)
            end
            window:requestAnimationFrame(__L1.frame)
            return
        end
        local ____opt_2790 = window.WorldLife
        if ____opt_2790 ~= nil then
            ____opt_2790 = ____opt_2790.getStatus
        end
        local ____opt_result_2792
        if ____opt_2790 ~= nil then
            ____opt_result_2792 = ____opt_2790(____opt_2790)
        end
        local challenge = ____opt_result_2792
        local ____t_2810 = __t
        local ____t_2802 = __t
        local ____t_2800 = __t
        local ____t_2798 = __t
        local ____t_2796 = __t
        local ____t_2794 = __t
        local ____temp_2793 = if __t(__L1.started) then not __t(__L1.sandbox) else __L1.started
        __O[2122] = ____temp_2793
        local ____temp_2795 = if ____t_2794(____temp_2793) then not __t(__L1.won) else __O[2122]
        __O[2123] = ____temp_2795
        local ____temp_2797 = if ____t_2796(____temp_2795) then not __t(__L1.chapterEnded) else __O[2123]
        __O[2124] = ____temp_2797
        local ____temp_2799 = if ____t_2798(____temp_2797) then not __t(__L1.defeated) else __O[2124]
        __O[2125] = ____temp_2799
        local ____temp_2801 = if ____t_2800(____temp_2799) then not __t(window.document.hidden) else __O[2125]
        __O[2126] = ____temp_2801
        local ____t_2808 = __t
        local ____opt_2805 = window.Arena
        if ____opt_2805 ~= nil then
            ____opt_2805 = ____opt_2805.isOpen
        end
        local ____opt_result_2807
        if ____opt_2805 ~= nil then
            ____opt_result_2807 = ____opt_2805(____opt_2805)
        end
        local ____temp_2809 = if ____t_2802(____temp_2801) then not ____t_2808(____opt_result_2807) else __O[2126]
        __O[2129] = ____temp_2809
        local ____t_2812 = __t
        local ____temp_2811 = not __t(__L1.paused)
        __O[2128] = ____temp_2811
        local ____t_2816 = __t
        local ____opt_result_2815
        if challenge ~= nil then
            ____opt_result_2815 = challenge.open
        end
        __O[2127] = ____opt_result_2815
        local counting = if ____t_2810(____temp_2809) then if ____t_2812(____temp_2811) then __O[2128] else if ____t_2816(____opt_result_2815) then challenge.stage == "live" else __O[2127] else __O[2129]
        local ____opt_2819 = window.CampaignRun
        if ____opt_2819 ~= nil then
            ____opt_2819 = ____opt_2819.tick
        end
        if ____opt_2819 ~= nil then
            ____opt_2819(____opt_2819, now, counting)
        end
        local ____t_2829 = __t
        local ____t_2822 = __t
        local ____temp_2821 = if __t(counting) then not __t(__L1.cutscene) else counting
        __O[2130] = ____temp_2821
        local ____t_2828 = __t
        local ____opt_2825 = window.SwiftGuide
        if ____opt_2825 ~= nil then
            ____opt_2825 = ____opt_2825.isOpen
        end
        local ____opt_result_2827
        if ____opt_2825 ~= nil then
            ____opt_result_2827 = ____opt_2825(____opt_2825)
        end
        if ____t_2829(if ____t_2822(____temp_2821) then not ____t_2828(____opt_result_2827) else __O[2130]) then
            local ____opt_2832 = window.CampaignRun
            if ____opt_2832 ~= nil then
                ____opt_2832 = ____opt_2832.confirmInitialMode
            end
            if ____opt_2832 ~= nil then
                ____opt_2832(____opt_2832)
            end
        end
        local dt = math.min(0.035, (now - __L1.last) / 1000)
        __L1.last = now
        local ____t_2842 = __t
        local ____t_2841 = __t
        local ____t_2839 = __t
        local ____t_2837 = __t
        local ____t_2835 = __t
        local ____temp_2834 = __L1.hitStop > 0
        __O[2131] = ____temp_2834
        local ____temp_2836 = if ____t_2835(____temp_2834) then __L1.started else __O[2131]
        __O[2132] = ____temp_2836
        local ____temp_2838 = if ____t_2837(____temp_2836) then not __t(__L1.cutscene) else __O[2132]
        __O[2133] = ____temp_2838
        local ____temp_2840 = if ____t_2839(____temp_2838) then not __t(__L1.paused) else __O[2133]
        __O[2134] = ____temp_2840
        if ____t_2842(if ____t_2841(____temp_2840) then not __t(__L1.dialog) else __O[2134]) then
            __L1.hitStop = math.max(0, __L1.hitStop - dt)
        else
            __L1.hitStop = 0
            __L1:update(dt)
            local ____t_2849 = __t
            local ____t_2848 = __t
            local ____t_2846 = __t
            local ____t_2844 = __t
            local ____temp_2843 = if __t(__L1.started) then not __t(__L1.cutscene) else __L1.started
            __O[2135] = ____temp_2843
            local ____temp_2845 = if ____t_2844(____temp_2843) then not __t(__L1.room) else __O[2135]
            __O[2136] = ____temp_2845
            local ____temp_2847 = if ____t_2846(____temp_2845) then not __t(__L1.activity) else __O[2136]
            __O[2137] = ____temp_2847
            if ____t_2849(if ____t_2848(____temp_2847) then not __t(__L1.ollyanEncounter) else __O[2137]) then
                local ____opt_2852 = window.SceneLife
                if ____opt_2852 ~= nil then
                    ____opt_2852 = ____opt_2852.update
                end
                if ____opt_2852 ~= nil then
                    ____opt_2852(
                        ____opt_2852,
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
            local ____t_2862 = __t
            local ____t_2861 = __t
            local ____t_2859 = __t
            local ____t_2857 = __t
            local ____t_2855 = __t
            local ____temp_2854 = if __t(__L1.started) then not __t(__L1.cutscene) else __L1.started
            __O[2138] = ____temp_2854
            local ____temp_2856 = if ____t_2855(____temp_2854) then not __t(__L1.room) else __O[2138]
            __O[2139] = ____temp_2856
            local ____temp_2858 = if ____t_2857(____temp_2856) then not __t(__L1.activity) else __O[2139]
            __O[2140] = ____temp_2858
            local ____temp_2860 = if ____t_2859(____temp_2858) then not __t(__L1.ollyanEncounter) else __O[2140]
            __O[2141] = ____temp_2860
            if ____t_2862(if ____t_2861(____temp_2860) then not __t(__L1.arena) else __O[2141]) then
                local ____opt_2865 = window.HdMaps
                if ____opt_2865 ~= nil then
                    ____opt_2865 = ____opt_2865.touch
                end
                if ____opt_2865 ~= nil then
                    ____opt_2865(
                        ____opt_2865,
                        __L1.scene,
                        __L1.player.x,
                        __L1.player.y,
                        __L1.player.vx,
                        __L1.player.vy
                    )
                end
            end
            if not __t(__L1:terrenoConquista()) then
                local ____opt_2878 = window.Interact
                if ____opt_2878 ~= nil then
                    ____opt_2878 = ____opt_2878.update
                end
                if ____opt_2878 ~= nil then
                    local ____L1_scene_2872 = __L1.scene
                    local ____L1_player_2873 = __L1.player
                    local ____L1_camera_2874 = __L1.camera
                    local ____L1_time_2875 = __L1.time
                    local ____temp_2876 = not not __t(__L1.arena)
                    local ____opt_2868 = __L1.arena
                    if ____opt_2868 ~= nil then
                        ____opt_2868 = ____opt_2868.type
                    end
                    local ____opt_2870 = __L1.arena
                    if ____opt_2870 ~= nil then
                        ____opt_2870 = ____opt_2870.homeX
                    end
                    ____opt_2878(
                        ____opt_2878,
                        dt,
                        {
                            scene = ____L1_scene_2872,
                            player = ____L1_player_2873,
                            camera = ____L1_camera_2874,
                            time = ____L1_time_2875,
                            arena = ____temp_2876,
                            arenaType = ____opt_2868,
                            homeX = ____opt_2870,
                            room = not not __t(__L1.room),
                            shots = __L1.shots,
                            enemies = __L1.enemies,
                            minions = __L1.minions,
                            dashing = __L1.dashTimer > 0
                        }
                    )
                end
            end
            if __t(if __t(__L1.activeBoss) then not __t(__L1.activeBoss.conquista) else __L1.activeBoss) then
                local ____opt_2882 = window.BossFx
                if ____opt_2882 ~= nil then
                    ____opt_2882 = ____opt_2882.update
                end
                if ____opt_2882 ~= nil then
                    ____opt_2882(____opt_2882, dt, {boss = __L1.activeBoss, player = __L1.player})
                end
            end
        end
        __L1:updateEpic(dt)
        __L1.pickupsLater = false
        __L1:draw()
        local ____t_2889 = __t
        local ____opt_2886 = window.Graphics
        if ____opt_2886 ~= nil then
            ____opt_2886 = ____opt_2886.isShader
        end
        local ____opt_result_2888
        if ____opt_2886 ~= nil then
            ____opt_result_2888 = ____opt_2886(____opt_2886)
        end
        __O[2147] = ____opt_result_2888
        local ____opt_2906 = window.Shader
        if ____opt_2906 ~= nil then
            ____opt_2906 = ____opt_2906.apply
        end
        local ____opt_result_2908
        if ____opt_2906 ~= nil then
            local ____L1_ctx_canvas_2904 = __L1.ctx.canvas
            local ____L1_scene_2901 = __L1.scene
            local ____L1_camera_2902 = __L1.camera
            local ____L1_time_2903 = __L1.time
            local ____t_2900 = __t
            local ____t_2898 = __t
            local ____t_2896 = __t
            local ____t_2894 = __t
            local ____t_2892 = __t
            local ____temp_2891 = if __t(__L1.started) then not __t(__L1.cutscene) else __L1.started
            __O[2142] = ____temp_2891
            local ____temp_2893 = if ____t_2892(____temp_2891) then not __t(__L1.room) else __O[2142]
            __O[2143] = ____temp_2893
            local ____temp_2895 = if ____t_2894(____temp_2893) then not __t(__L1.activity) else __O[2143]
            __O[2144] = ____temp_2895
            local ____temp_2897 = if ____t_2896(____temp_2895) then not __t(__L1.ollyanEncounter) else __O[2144]
            __O[2145] = ____temp_2897
            local ____temp_2899 = if ____t_2898(____temp_2897) then not __t(__L1.arena) else __O[2145]
            __O[2146] = ____temp_2899
            ____opt_result_2908 = ____opt_2906(____opt_2906, ____L1_ctx_canvas_2904, {scene = ____L1_scene_2901, camera = ____L1_camera_2902, time = ____L1_time_2903, outdoor = if ____t_2900(____temp_2899) then __call(
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
            ) else __O[2146]})
        end
        local shaded = if ____t_2889(____opt_result_2888) then ____opt_result_2908 else __O[2147]
        if __t(if __t(__L1.pickupsLater) then not __t(if __t(__L1.routeTransition) then not __t(__L1.routeTransition.chegada) else __L1.routeTransition) else __L1.pickupsLater) then
            local ____t_2915 = __t
            local ____opt_2911 = window.Shader
            if ____opt_2911 ~= nil then
                ____opt_2911 = ____opt_2911.items
            end
            local ____opt_result_2913
            if ____opt_2911 ~= nil then
                ____opt_result_2913 = ____opt_2911(____opt_2911)
            end
            local ____temp_2914 = if __t(shaded) then ____opt_result_2913 else shaded
            __O[2148] = ____temp_2914
            local g = if ____t_2915(____temp_2914) then __O[2148] else __L1.ctx
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
            local ____t_2918 = __t
            local ____this_2917
            ____this_2917 = p.element
            local ____opt_2916 = ____this_2917.hasPointerCapture
            if ____opt_2916 ~= nil then
                ____opt_2916 = ____opt_2916(____this_2917, id)
            end
            if ____t_2918(____opt_2916) then
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
                local ____t_2921 = __t
                local ____this_2920
                ____this_2920 = p.element
                local ____opt_2919 = ____this_2920.hasPointerCapture
                if ____opt_2919 ~= nil then
                    ____opt_2919 = ____opt_2919(____this_2920, id)
                end
                if ____t_2921(____opt_2919) then
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
                if __t(__call(matched, "has", id)) then
                    continue
                end
                local ____t_2923 = __t
                local ____temp_2922 = t.target == p.element
                __O[2179] = ____temp_2922
                local ____this_2925
                ____this_2925 = p.element
                local ____opt_2924 = ____this_2925.contains
                if ____opt_2924 ~= nil then
                    ____opt_2924 = ____opt_2924(____this_2925, t.target)
                end
                local sameTarget = if ____t_2923(____temp_2922) then __O[2179] else ____opt_2924
                local ____hypot_2929 = __hypot
                local ____t_clientX_2926 = t.clientX
                if ____t_clientX_2926 == nil then
                    ____t_clientX_2926 = p.x
                end
                local ____temp_2928 = ____t_clientX_2926 - p.x
                local ____t_clientY_2927 = t.clientY
                if ____t_clientY_2927 == nil then
                    ____t_clientY_2927 = p.y
                end
                local dist = ____hypot_2929(____temp_2928, ____t_clientY_2927 - p.y)
                local ____t_2932 = __t
                local ____t_2931 = __t
                local ____temp_2930 = if __t(sameTarget) then sameTarget else not __t(t.target) and dist < 60
                __O[2180] = ____temp_2930
                if ____t_2932(if ____t_2931(____temp_2930) then dist < distance else __O[2180]) then
                    best = id
                    distance = dist
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
            button.title = if __t(__L1.sound) then "Desligar som" else "Ligar som"
            button.textContent = if __t(__L1.sound) then "♫" else "♪"
        end
        __L1:setText("soundState", if __t(__L1.sound) then "Som ligado" else "Som desligado")
    end
    __L1.getAudioState = function(self)
        local ____opt_2935 = window.OllyanEncounter
        if ____opt_2935 ~= nil then
            ____opt_2935 = ____opt_2935.getAudioState
        end
        local ____opt_result_2937
        if ____opt_2935 ~= nil then
            ____opt_result_2937 = ____opt_2935(____opt_2935, __L1.ollyanEncounter)
        end
        local flight = if __t(__L1.ollyanEncounter) then ____opt_result_2937 else nil
        local ____L1_started_3021 = __L1.started
        local ____L1_playing_3022 = __L1.playing
        local ____L1_paused_3023 = __L1.paused
        local ____L1_scene_3024 = __L1.scene
        local ____t_2940 = __t
        local ____opt_2938 = __L1.room
        if ____opt_2938 ~= nil then
            ____opt_2938 = ____opt_2938.id
        end
        __O[2202] = ____opt_2938
        local ____temp_3025 = if ____t_2940(____opt_2938) then __O[2202] else nil
        local ____t_2948 = __t
        local ____t_2944 = __t
        local ____opt_result_2943
        if flight ~= nil then
            ____opt_result_2943 = flight.boss
        end
        __O[2203] = ____opt_result_2943
        local ____opt_2945 = __L1.activeBoss
        if ____opt_2945 ~= nil then
            ____opt_2945 = ____opt_2945.type
        end
        local ____temp_2947 = if ____t_2944(____opt_result_2943) then __O[2203] else ____opt_2945
        __O[2204] = ____temp_2947
        local ____temp_3026 = if ____t_2948(____temp_2947) then __O[2204] else nil
        local ____t_2951 = __t
        local ____opt_2949 = __L1.activeBoss
        if ____opt_2949 ~= nil then
            ____opt_2949 = ____opt_2949.phase
        end
        __O[2205] = ____opt_2949
        local ____temp_3027 = if __t(__L1.ollyanEncounter) then window.OllyanEncounter:getStatus(__L1.ollyanEncounter).phase else if ____t_2951(____opt_2949) then __O[2205] else nil
        local ____t_2959 = __t
        local ____t_2955 = __t
        local ____opt_result_2954
        if flight ~= nil then
            ____opt_result_2954 = flight.cutscene
        end
        __O[2206] = ____opt_result_2954
        local ____opt_2956 = __L1.cutscene
        if ____opt_2956 ~= nil then
            ____opt_2956 = ____opt_2956.kind
        end
        local ____temp_2958 = if ____t_2955(____opt_result_2954) then __O[2206] else ____opt_2956
        __O[2207] = ____temp_2958
        local ____temp_3028 = if ____t_2959(____temp_2958) then __O[2207] else nil
        local ____t_2967 = __t
        local ____t_2963 = __t
        local ____opt_result_2962
        if flight ~= nil then
            ____opt_result_2962 = flight.cutsceneToken
        end
        __O[2208] = ____opt_result_2962
        local ____opt_2964 = __L1.cutscene
        if ____opt_2964 ~= nil then
            ____opt_2964 = ____opt_2964.audioToken
        end
        local ____temp_2966 = if ____t_2963(____opt_result_2962) then __O[2208] else ____opt_2964
        __O[2209] = ____temp_2966
        local ____temp_3029 = if ____t_2967(____temp_2966) then __O[2209] else nil
        local ____t_2971 = __t
        local ____opt_result_2970
        if flight ~= nil then
            ____opt_result_2970 = flight.cutscene
        end
        local ____t_2980 = __t
        local ____opt_2974 = window.Cinematics
        if ____opt_2974 ~= nil then
            ____opt_2974 = ____opt_2974.timelinePosition
        end
        local ____opt_result_2976
        if ____opt_2974 ~= nil then
            ____opt_result_2976 = ____opt_2974(____opt_2974, __L1.cutscene)
        end
        local ____opt_result_2976_2977 = ____opt_result_2976
        if ____opt_result_2976_2977 == nil then
            ____opt_result_2976_2977 = __L1.cutscene.elapsed
        end
        local ____opt_result_2976_2977_2978 = ____opt_result_2976_2977
        if ____opt_result_2976_2977_2978 == nil then
            ____opt_result_2976_2977_2978 = __L1.cutscene.audioElapsed
        end
        local ____TS__Number_result_2979 = __TS__Number(____opt_result_2976_2977_2978)
        __O[2210] = ____TS__Number_result_2979
        local ____temp_3030 = if ____t_2971(____opt_result_2970) then flight.cutsceneElapsed else if __t(__L1.cutscene) then math.max(0, if ____t_2980(____TS__Number_result_2979) then __O[2210] else 0) else 0
        local ____t_2984 = __t
        local ____opt_result_2983
        if flight ~= nil then
            ____opt_result_2983 = flight.cutscene
        end
        local ____opt_2985 = __L1.cutscene
        if ____opt_2985 ~= nil then
            ____opt_2985 = ____opt_2985.index
        end
        local ____opt_2985_2987 = ____opt_2985
        if ____opt_2985_2987 == nil then
            ____opt_2985_2987 = nil
        end
        local ____temp_3031 = if ____t_2984(____opt_result_2983) then flight.cutsceneIndex else ____opt_2985_2987
        local ____t_2991 = __t
        local ____opt_result_2990
        if flight ~= nil then
            ____opt_result_2990 = flight.cutsceneTimed
        end
        local ____temp_2998 = not not ____t_2991(____opt_result_2990)
        if not ____temp_2998 then
            local ____t_2997 = __t
            local ____opt_2994 = __L1.cutscene
            if ____opt_2994 ~= nil then
                ____opt_2994 = ____opt_2994.options
            end
            local ____opt_result_2996
            if ____opt_2994 ~= nil then
                ____opt_result_2996 = ____opt_2994.musicTimed
            end
            ____temp_2998 = not not ____t_2997(____opt_result_2996)
        end
        local ____t_3001 = __t
        local ____opt_2999 = __L1.training
        if ____opt_2999 ~= nil then
            ____opt_2999 = ____opt_2999.active
        end
        local ____temp_3032 = not not ____t_3001(____opt_2999)
        local ____t_3006 = __t
        local ____t_3004 = __t
        local ____opt_3002 = __L1.activity
        if ____opt_3002 ~= nil then
            ____opt_3002 = ____opt_3002.kind
        end
        __O[2211] = ____opt_3002
        local ____temp_3005 = if ____t_3004(____opt_3002) then __O[2211] else __L1.activityCallback
        __O[2212] = ____temp_3005
        local ____temp_3033 = if ____t_3006(____temp_3005) then __O[2212] else nil
        local ____t_3012 = __t
        local ____opt_3009 = window.SwiftGuide
        if ____opt_3009 ~= nil then
            ____opt_3009 = ____opt_3009.isOpen
        end
        local ____opt_result_3011
        if ____opt_3009 ~= nil then
            ____opt_result_3011 = ____opt_3009(____opt_3009)
        end
        local ____t_3018 = __t
        local ____getq_3017 = __getq
        local ____opt_3015 = __L1.dialog
        if ____opt_3015 ~= nil then
            ____opt_3015 = ____opt_3015.lines
        end
        local ____opt_3013 = ____getq_3017(____opt_3015, __L1.dialog.index)
        if ____opt_3013 ~= nil then
            ____opt_3013 = ____opt_3013.name
        end
        __O[2213] = ____opt_3013
        local ____temp_3034 = if ____t_3012(____opt_result_3011) then "Irmão de Clara Swift" else if ____t_3018(____opt_3013) then __O[2213] else nil
        local ____L1_reeisPhase_3035 = __L1.reeisPhase
        local ____L1_sound_3036 = __L1.sound
        local ____opt_3019 = __L1.ollyanEncounter
        if ____opt_3019 ~= nil then
            ____opt_3019 = ____opt_3019.stage
        end
        return {
            started = ____L1_started_3021,
            playing = ____L1_playing_3022,
            paused = ____L1_paused_3023,
            scene = ____L1_scene_3024,
            room = ____temp_3025,
            boss = ____temp_3026,
            bossPhase = ____temp_3027,
            cutscene = ____temp_3028,
            cutsceneToken = ____temp_3029,
            cutsceneElapsed = ____temp_3030,
            cutsceneIndex = ____temp_3031,
            cutsceneTimed = ____temp_2998,
            training = ____temp_3032,
            activity = ____temp_3033,
            dialogue = ____temp_3034,
            reeis = ____L1_reeisPhase_3035,
            sound = ____L1_sound_3036,
            defeated = if __t(__L1.defeated) then __L1.defeated else ____opt_3019 == "defeat",
            chapterEnded = __L1.chapterEnded
        }
    end
    __L1.getBossStatus = function(self)
        if __t(__L1.ollyanEncounter) then
            local status = window.OllyanEncounter:getStatus(__L1.ollyanEncounter)
            local ____assign_3050 = __assign
            local ____temp_3049 = {}
            local ____temp_3046 = if __t(status.phases) then status.phases else 3
            local ____status_max_3047 = status.max
            local ____status_stage_3048 = status.stage
            local ____t_3045 = __t
            local ____opt_3041 = window.Difficulty
            if ____opt_3041 ~= nil then
                ____opt_3041 = ____opt_3041.getSettings
            end
            local ____opt_result_3043
            if ____opt_3041 ~= nil then
                ____opt_result_3043 = ____opt_3041(____opt_3041, __L1.ollyanEncounter.options.difficultyMode)
            end
            local ____opt_result_3044
            if ____opt_result_3043 ~= nil then
                ____opt_result_3044 = ____opt_result_3043.label
            end
            __O[2214] = ____opt_result_3044
            return if __t(status.active) then ____assign_3050(____temp_3049, status, {
                phaseCount = ____temp_3046,
                phaseBars = 3,
                phaseMaxHp = ____status_max_3047,
                state = ____status_stage_3048,
                difficulty = if ____t_3045(____opt_result_3044) then __O[2214] else "NORMAL"
            }) else nil
        end
        local e = __L1.activeBoss
        if __t(not __t(e) or __le(e.hp, 0)) then
            return nil
        end
        local ____t_3052 = __t
        local ____temp_3051 = __L1:nomeBoss(e.type)
        __O[2215] = ____temp_3051
        local ____temp_3071 = if ____t_3052(____temp_3051) then __O[2215] else e.type
        local ____t_3055 = __t
        local ____opt_3053 = e.conquista
        if ____opt_3053 ~= nil then
            ____opt_3053 = ____opt_3053.slug
        end
        __O[2216] = ____opt_3053
        local ____temp_3072 = if ____t_3055(____opt_3053) then __O[2216] else e.type
        local ____temp_3073 = if __t(e.conquista) then __getq(
            window.ConquistaCombate:capitulo(e.conquista),
            0
        ) else nil
        local ____math_max_result_3074 = math.max(0, e.hp)
        local ____e_max_3075 = e.max
        local ____temp_3076 = if __t(e.phase) then e.phase else 1
        local ____temp_3077 = if e.type == "giant" then 3 else if __t(e.phaseCount) then e.phaseCount else 3
        local ____temp_3078 = if e.type == "giant" then 1 else if __t(e.phaseCount) then e.phaseCount else 3
        local ____e_max_3079 = e.max
        local ____temp_3080 = if e.type == "nikolas" then if __t(e.form) then e.form else "normal" else nil
        local ____e_state_3081 = e.state
        local ____temp_3082 = if __t(e.charge) then e.charge else 0
        local ____t_3061 = __t
        local ____opt_3058 = window.C2Luta
        if ____opt_3058 ~= nil then
            ____opt_3058 = ____opt_3058.skin
        end
        local ____opt_result_3060
        if ____opt_3058 ~= nil then
            ____opt_result_3060 = ____opt_3058.nivel
        end
        __O[2217] = ____opt_result_3060
        local ____temp_3083 = if ____t_3061(____opt_result_3060) then __O[2217] else __L1:bossProfile(e).level
        local ____t_3070 = __t
        local ____opt_3066 = window.Difficulty
        if ____opt_3066 ~= nil then
            ____opt_3066 = ____opt_3066.getSettings
        end
        local ____opt_result_3068
        if ____opt_3066 ~= nil then
            ____opt_result_3068 = ____opt_3066(____opt_3066, e.difficultyMode)
        end
        local ____opt_result_3069
        if ____opt_result_3068 ~= nil then
            ____opt_result_3069 = ____opt_result_3068.label
        end
        __O[2218] = ____opt_result_3069
        return {
            name = ____temp_3071,
            type = ____temp_3072,
            phaseName = ____temp_3073,
            hp = ____math_max_result_3074,
            max = ____e_max_3075,
            phase = ____temp_3076,
            phaseCount = ____temp_3077,
            phaseBars = ____temp_3078,
            phaseMaxHp = ____e_max_3079,
            form = ____temp_3080,
            state = ____e_state_3081,
            charge = ____temp_3082,
            recommendedLevel = ____temp_3083,
            difficulty = if ____t_3070(____opt_result_3069) then __O[2218] else "NORMAL"
        }
    end
    __L1.sandboxUnlocked = function(self)
        local ____t_3091 = __t
        local ____t_3090 = __t
        local ____opt_3086 = __L1:load()
        if ____opt_3086 ~= nil then
            ____opt_3086 = ____opt_3086.q
        end
        local ____opt_result_3088
        if ____opt_3086 ~= nil then
            ____opt_result_3088 = ____opt_3086.jorgeSeen
        end
        local ____temp_3089 = if __t(__L1.q.jorgeSeen) then __L1.q.jorgeSeen else ____opt_result_3088
        __O[2219] = ____temp_3089
        return not not ____t_3091(if ____t_3090(____temp_3089) then __O[2219] else __L1:safe(function() return window.localStorage:getItem("daroca-sandbox-v1") == "1" end))
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
        local ____L1_show_3095 = __L1.show
        local ____t_3094 = __t
        local ____opt_3092 = window.C2Luta
        if ____opt_3092 ~= nil then
            ____opt_3092 = ____opt_3092.skin
        end
        ____L1_show_3095(
            __L1,
            "pauseScreen",
            not ____t_3094(____opt_3092)
        )
        __L1:updateUI()
        __L1:emitGameEvent("sandbox-change", {type = __L1.sandbox.type, result = result})
    end
    __L1.startSandboxBoss = function(self, ____type)
        if __t(not __t(__call(__L1.sandboxScenes, "hasOwnProperty", ____type)) or not __t(__L1:sandboxUnlocked())) then
            return false
        end
        local ____t_3116 = __t
        local ____t_3097 = __t
        local ____temp_3096 = not __t(__L1.sandbox)
        __O[2228] = ____temp_3096
        local ____t_3115 = __t
        local ____t_3113 = __t
        local ____t_3109 = __t
        local ____t_3107 = __t
        local ____t_3105 = __t
        local ____t_3103 = __t
        local ____t_3101 = __t
        local ____t_3099 = __t
        local ____temp_3098 = if __t(__L1.dialog) then __L1.dialog else __L1.cutscene
        __O[2220] = ____temp_3098
        local ____temp_3100 = if ____t_3099(____temp_3098) then __O[2220] else __L1.activeBoss
        __O[2221] = ____temp_3100
        local ____temp_3102 = if ____t_3101(____temp_3100) then __O[2221] else __L1.arena
        __O[2222] = ____temp_3102
        local ____temp_3104 = if ____t_3103(____temp_3102) then __O[2222] else __L1.room
        __O[2223] = ____temp_3104
        local ____temp_3106 = if ____t_3105(____temp_3104) then __O[2223] else __L1.routeTransition
        __O[2224] = ____temp_3106
        local ____temp_3108 = if ____t_3107(____temp_3106) then __O[2224] else __L1.activity
        __O[2225] = ____temp_3108
        local ____opt_3110 = __L1.training
        if ____opt_3110 ~= nil then
            ____opt_3110 = ____opt_3110.active
        end
        local ____temp_3112 = if ____t_3109(____temp_3108) then __O[2225] else ____opt_3110
        __O[2226] = ____temp_3112
        local ____temp_3114 = if ____t_3113(____temp_3112) then __O[2226] else __L1.ollyanEncounter
        __O[2227] = ____temp_3114
        if ____t_3116(if ____t_3097(____temp_3096) then if ____t_3115(____temp_3114) then __O[2227] else __L1:bivoltStatus().active else __O[2228]) then
            __L1:toast("Termine a cena, conversa ou confronto antes de abrir a revanche.")
            return false
        end
        if not __t(__L1.sandbox) then
            local ____opt_3119 = window.CampaignRun
            if ____opt_3119 ~= nil then
                ____opt_3119 = ____opt_3119.setSuspended
            end
            if ____opt_3119 ~= nil then
                ____opt_3119(____opt_3119, true)
            end
            local ____type_3157 = ____type
            local ____L1_copyState_3156 = __L1.copyState
            local ____t_3126 = __t
            local ____opt_3123 = window.Difficulty
            if ____opt_3123 ~= nil then
                ____opt_3123 = ____opt_3123.getMode
            end
            local ____opt_result_3125
            if ____opt_3123 ~= nil then
                ____opt_result_3125 = ____opt_3123(____opt_3123)
            end
            __O[2229] = ____opt_result_3125
            local ____temp_3132 = if ____t_3126(____opt_result_3125) then __O[2229] else "normal"
            local ____L1_started_3133 = __L1.started
            local ____L1_playing_3134 = __L1.playing
            local ____L1_paused_3135 = __L1.paused
            local ____L1_won_3136 = __L1.won
            local ____L1_defeated_3137 = __L1.defeated
            local ____L1_chapterEnded_3138 = __L1.chapterEnded
            local ____L1_scene_3139 = __L1.scene
            local ____L1_camera_3140 = __L1.camera
            local ____L1_player_3141 = __L1.player
            local ____L1_q_3142 = __L1.q
            local ____L1_items_3143 = __L1.items
            local ____L1_collected_3144 = __L1.collected
            local ____L1_weapon_3145 = __L1.weapon
            local ____L1_minionKills_3146 = __L1.minionKills
            local ____L1_seenBossIntros_3147 = __L1.seenBossIntros
            local ____L1_killCount_3148 = __L1.killCount
            local ____L1_lastSafeX_3149 = __L1.lastSafeX
            local ____L1_respawnCheckpoint_3150 = __L1.respawnCheckpoint
            local ____L1_vehicle_3151 = __L1.vehicle
            local ____L1_enemies_3152 = __L1.enemies
            local ____L1_minions_3153 = __L1.minions
            local ____L1_pickups_3154 = __L1.pickups
            local ____L1_targets_3155 = __L1.targets
            local ____opt_3129 = window.Progression
            if ____opt_3129 ~= nil then
                ____opt_3129 = ____opt_3129.serialize
            end
            local ____opt_result_3131
            if ____opt_3129 ~= nil then
                ____opt_result_3131 = ____opt_3129(____opt_3129)
            end
            __L1.sandbox = {
                type = ____type_3157,
                result = nil,
                snapshot = ____L1_copyState_3156(__L1, {
                    difficultyMode = ____temp_3132,
                    started = ____L1_started_3133,
                    playing = ____L1_playing_3134,
                    paused = ____L1_paused_3135,
                    won = ____L1_won_3136,
                    defeated = ____L1_defeated_3137,
                    chapterEnded = ____L1_chapterEnded_3138,
                    scene = ____L1_scene_3139,
                    camera = ____L1_camera_3140,
                    player = ____L1_player_3141,
                    q = ____L1_q_3142,
                    items = ____L1_items_3143,
                    collected = ____L1_collected_3144,
                    weapon = ____L1_weapon_3145,
                    minionKills = ____L1_minionKills_3146,
                    seenBossIntros = ____L1_seenBossIntros_3147,
                    killCount = ____L1_killCount_3148,
                    lastSafeX = ____L1_lastSafeX_3149,
                    respawnCheckpoint = ____L1_respawnCheckpoint_3150,
                    vehicle = ____L1_vehicle_3151,
                    enemies = ____L1_enemies_3152,
                    minions = ____L1_minions_3153,
                    pickups = ____L1_pickups_3154,
                    targets = ____L1_targets_3155,
                    progression = ____opt_result_3131,
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
        local ____L1_sandbox_3164 = __L1.sandbox
        local ____t_3163 = __t
        local ____opt_3160 = window.Difficulty
        if ____opt_3160 ~= nil then
            ____opt_3160 = ____opt_3160.getMode
        end
        local ____opt_result_3162
        if ____opt_3160 ~= nil then
            ____opt_result_3162 = ____opt_3160(____opt_3160)
        end
        __O[2230] = ____opt_result_3162
        ____L1_sandbox_3164.difficultyMode = if ____t_3163(____opt_result_3162) then __O[2230] else "normal"
        local saved = if not __t(snapshot.started) then __L1:load() else nil
        local ____L1_copyState_3172 = __L1.copyState
        local ____assign_3171 = __assign
        local ____temp_3169 = {}
        local ____temp_3170 = __L1:emptyQuest()
        local ____t_3168 = __t
        local ____opt_result_3167
        if saved ~= nil then
            ____opt_result_3167 = saved.q
        end
        __O[2231] = ____opt_result_3167
        __L1.q = ____L1_copyState_3172(
            __L1,
            ____assign_3171(____temp_3169, ____temp_3170, if ____t_3168(____opt_result_3167) then __O[2231] else snapshot.q)
        )
        local ____opt_3179 = window.Progression
        if ____opt_3179 ~= nil then
            ____opt_3179 = ____opt_3179.restore
        end
        if ____opt_3179 ~= nil then
            local ____t_3177 = __t
            local ____opt_result_3176
            if saved ~= nil then
                ____opt_result_3176 = saved.progression
            end
            __O[2232] = ____opt_result_3176
            ____opt_3179(____opt_3179, if ____t_3177(____opt_result_3176) then __O[2232] else snapshot.progression)
        end
        local ____opt_result_3183
        if saved ~= nil then
            ____opt_result_3183 = saved.weapon
        end
        local ____opt_result_3183_3184 = ____opt_result_3183
        if ____opt_result_3183_3184 == nil then
            ____opt_result_3183_3184 = snapshot.weapon
        end
        __L1.weapon = ____opt_result_3183_3184
        local ____L1_copyState_3189 = __L1.copyState
        local ____t_3188 = __t
        local ____opt_result_3187
        if saved ~= nil then
            ____opt_result_3187 = saved.items
        end
        __O[2233] = ____opt_result_3187
        __L1.items = ____L1_copyState_3189(__L1, if ____t_3188(____opt_result_3187) then __O[2233] else snapshot.items)
        local ____L1_copyState_3194 = __L1.copyState
        local ____t_3193 = __t
        local ____opt_result_3192
        if saved ~= nil then
            ____opt_result_3192 = saved.collected
        end
        __O[2234] = ____opt_result_3192
        __L1.collected = ____L1_copyState_3194(__L1, if ____t_3193(____opt_result_3192) then __O[2234] else snapshot.collected)
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
        __set(__L1.q, if ____type == "reeisBoss" then "reeis" else ____type, false)
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
        return if __t(__L1.sandbox) then __L1:startSandboxBoss(__L1.sandbox.type) else false
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
        local ____opt_3197 = window.CampaignRun
        if ____opt_3197 ~= nil then
            ____opt_3197 = ____opt_3197.setSuspended
        end
        if ____opt_3197 ~= nil then
            ____opt_3197(____opt_3197, false)
        end
        local ____opt_3201 = window.Difficulty
        if ____opt_3201 ~= nil then
            ____opt_3201 = ____opt_3201.setMode
        end
        if ____opt_3201 ~= nil then
            ____opt_3201(____opt_3201, if __t(prior.difficultyMode) then prior.difficultyMode else "normal")
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
        local ____opt_3205 = window.Progression
        if ____opt_3205 ~= nil then
            ____opt_3205 = ____opt_3205.restore
        end
        if ____opt_3205 ~= nil then
            ____opt_3205(____opt_3205, prior.progression)
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
        local ____L1_show_3209 = __L1.show
        local ____t_3208 = __t
        local ____temp_3207 = if __t(__L1.started) then __L1.paused else __L1.started
        __O[2235] = ____temp_3207
        ____L1_show_3209(__L1, "pauseScreen", if ____t_3208(____temp_3207) then not __t(__L1.chapterEnded) else __O[2235])
        __L1:updateUI()
        __L1:updateContinue()
        __L1:emitGameEvent("sandbox-change", nil)
        local ____t_3212 = __t
        local ____t_3211 = __t
        local ____temp_3210 = if __t(__L1.started) then not __t(__L1.paused) else __L1.started
        __O[2236] = ____temp_3210
        if ____t_3212(if ____t_3211(____temp_3210) then not __t(__L1.chapterEnded) else __O[2236]) then
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
    local ____opt_3215 = window.Golpes
    if ____opt_3215 ~= nil then
        ____opt_3215 = ____opt_3215.chao
    end
    if ____opt_3215 ~= nil then
        ____opt_3215(____opt_3215, __L1.FLOOR)
    end
    local ____t_3221 = __t
    local ____getq_3219 = __getq
    local ____opt_3217 = window.WorldData
    if ____opt_3217 ~= nil then
        ____opt_3217 = ____opt_3217.widths
    end
    local ____TS__Number_result_3220 = __TS__Number(____getq_3219(____opt_3217, 0))
    __O[1592] = ____TS__Number_result_3220
    __L1.WORLD = if ____t_3221(____TS__Number_result_3220) then __O[1592] else 2600
    local ____t_3224 = __t
    local ____opt_3222 = window.Campaign
    if ____opt_3222 ~= nil then
        ____opt_3222 = ____opt_3222.sceneNames
    end
    __O[1593] = ____opt_3222
    __L1.scenes = if ____t_3224(____opt_3222) then __O[1593] else __arrL({
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
    __L1.phrases = __arrL({
        "da roça poudiaaam",
        "reeeis pouddiaaam",
        "da roça pegou ar",
        "teketeketeketeke",
        "ó pra Ravid falando sozinho"
    }, 5)
    local ____ord_3233 = __ord
    local ____assign_3232 = __assign
    local ____temp_3231 = {}
    local ____opt_3225 = window.LugaresC1
    if ____opt_3225 ~= nil then
        ____opt_3225 = ____opt_3225.npcs
    end
    local ____opt_3227 = window.MissaoFarda
    if ____opt_3227 ~= nil then
        ____opt_3227 = ____opt_3227.npcs
    end
    local ____opt_3229 = window.Campaign
    if ____opt_3229 ~= nil then
        ____opt_3229 = ____opt_3229.npcEntries
    end
    __L1.npcInfo = ____ord_3233(
        ____assign_3232(
            ____temp_3231,
            ____opt_3225,
            ____opt_3227,
            ____opt_3229,
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
    local ____t_3236 = __t
    local ____opt_3234 = window.WorldData
    if ____opt_3234 ~= nil then
        ____opt_3234 = ____opt_3234.platforms
    end
    __O[1594] = ____opt_3234
    __L1.platforms = if ____t_3236(____opt_3234) then __O[1594] else __arrL(
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
        local ____assign_3245 = __assign
        local ____temp_3243 = {}
        local ____temp_3244 = {
            maxHP = 100,
            maxGas = 100,
            damageMultiplier = 1,
            moveSpeed = 280,
            dashCooldown = 1.1,
            projectileTier = 0
        }
        local ____t_3242 = __t
        local ____opt_3239 = window.Progression
        if ____opt_3239 ~= nil then
            ____opt_3239 = ____opt_3239.bonuses
        end
        local ____opt_result_3241
        if ____opt_3239 ~= nil then
            ____opt_result_3241 = ____opt_3239(____opt_3239)
        end
        __O[1595] = ____opt_result_3241
        return ____assign_3245(____temp_3243, ____temp_3244, if ____t_3242(____opt_result_3241) then __O[1595] else {})
    end
    __L1.bonus = function()
        local ____t_3251 = __t
        local ____opt_3248 = window.BivoltSkill
        if ____opt_3248 ~= nil then
            ____opt_3248 = ____opt_3248.bonuses
        end
        local ____opt_result_3250
        if ____opt_3248 ~= nil then
            ____opt_result_3250 = ____opt_3248(
                ____opt_3248,
                __L1:baseBonus()
            )
        end
        __O[1596] = ____opt_result_3250
        return if ____t_3251(____opt_result_3250) then __O[1596] else __L1:baseBonus()
    end
    __L1.bossProfile = function(____, e)
        local ____t_3255 = __t
        local ____opt_3252 = window.Difficulty
        if ____opt_3252 ~= nil then
            ____opt_3252 = ____opt_3252:boss(e.type)
        end
        local ____temp_3254 = if __t(e.difficultyProfile) then e.difficultyProfile else ____opt_3252
        __O[1642] = ____temp_3254
        return if ____t_3255(____temp_3254) then __O[1642] else {
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
    __L1.bossRecovery = function(____, e)
        local ____get_result_3259 = __get(
            __L1:bossProfile(e).recovery,
            math.max(
                0,
                math.min(2, if __t(e.phase) then e.phase else 1 - 1)
            )
        )
        local ____t_3258 = __t
        local ____t_3257 = __t
        local ____temp_3256 = e.type == "kaique"
        __O[1643] = ____temp_3256
        return ____get_result_3259 * if ____t_3258(if ____t_3257(____temp_3256) then e.rage else __O[1643]) then 0.88 else 1
    end
    __L1.levelState = function()
        local ____t_3265 = __t
        local ____opt_3262 = window.Progression
        if ____opt_3262 ~= nil then
            ____opt_3262 = ____opt_3262.getState
        end
        local ____opt_result_3264
        if ____opt_3262 ~= nil then
            ____opt_result_3264 = ____opt_3262(____opt_3262)
        end
        __O[1644] = ____opt_result_3264
        return if ____t_3265(____opt_result_3264) then __O[1644] else {
            level = 1,
            xp = 0,
            nextXP = 100,
            points = 0,
            stats = {vigor = 0, forca = 0, gas = 0, agilidade = 0}
        }
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
    __L1.keyHeld = function(____, action) return if __t(window.ControlSettings) then window.ControlSettings:pressed(action, __L1.keys) else not not __t(__callq(
        __get(__L1.defaultKeys, action),
        "some",
        function(____, code) return __get(__L1.keys, code) end
    )) end
    __L1.keyMatches = function(____, action, code) return if __t(window.ControlSettings) then window.ControlSettings:matches(action, code) else not not __t(__callq(
        __get(__L1.defaultKeys, action),
        "includes",
        code
    )) end
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
    __L1.npcAvailable = function(____, id) return if id == "reeis" then __L1.q.reeis else if id == "freddy" then __L1.q.freddy else if id == "nicolas" then __L1.q.nicolas else if id == "dede" then __L1.q.dede else if id == "arthur" then __L1.q.arthur else true end
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
        local ____t_3269 = __t
        local ____t_3268 = __t
        local ____opt_3266 = window.C2Luta
        if ____opt_3266 ~= nil then
            ____opt_3266 = ____opt_3266.skin
        end
        __O[1650] = ____opt_3266
        return if ____t_3269(if ____t_3268(____opt_3266) then t == window.C2Luta.skin.kit else __O[1650]) then window.C2Luta.skin.nome else __get(__L1.bossNames, t)
    end
    __L1.worldWidthFor = function(____, n)
        local ____t_3281 = __t
        local ____t_3274 = __t
        local ____getq_3272 = __getq
        local ____opt_3270 = window.WorldData
        if ____opt_3270 ~= nil then
            ____opt_3270 = ____opt_3270.widths
        end
        local ____TS__Number_result_3273 = __TS__Number(____getq_3272(____opt_3270, n))
        __O[1662] = ____TS__Number_result_3273
        local ____opt_3277 = window.LugaresC1
        if ____opt_3277 ~= nil then
            ____opt_3277 = ____opt_3277.largura
        end
        local ____opt_result_3279
        if ____opt_3277 ~= nil then
            ____opt_result_3279 = ____opt_3277(____opt_3277, n)
        end
        local ____temp_3280 = if ____t_3274(____TS__Number_result_3273) then __O[1662] else ____opt_result_3279
        __O[1663] = ____temp_3280
        return if ____t_3281(____temp_3280) then __O[1663] else 2600
    end
    __L1.bossHome = function(____, ____type, fallback)
        local ____t_3288 = __t
        local ____getq_3286 = __getq
        local ____opt_3284 = window.WorldData
        if ____opt_3284 ~= nil then
            ____opt_3284 = ____opt_3284.bosses
        end
        local ____opt_3282 = ____getq_3286(____opt_3284, ____type)
        if ____opt_3282 ~= nil then
            ____opt_3282 = ____opt_3282.x
        end
        local ____TS__Number_result_3287 = __TS__Number(____opt_3282)
        __O[1664] = ____TS__Number_result_3287
        return if ____t_3288(____TS__Number_result_3287) then __O[1664] else fallback
    end
    __L1.player = __L1:basePlayer()
    local ____opt_3289 = __L1:load()
    if ____opt_3289 ~= nil then
        ____opt_3289 = ____opt_3289.q
    end
    __L1.menuLookQuest = ____opt_3289
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
    __L1:createBivoltControl()
    __L1.editableTarget = function(____, target)
        local ____t_3301 = __t
        local ____t_3294 = __t
        local ____opt_result_3293
        if target ~= nil then
            ____opt_result_3293 = target.isContentEditable
        end
        __O[2149] = ____opt_result_3293
        local ____opt_result_3299
        if target ~= nil then
            ____opt_result_3299 = target.closest
        end
        local ____opt_result_3300
        if ____opt_result_3299 ~= nil then
            ____opt_result_3300 = ____opt_result_3299(target, "input,textarea,select,[contenteditable=\"\"],[contenteditable=\"true\"],[role=\"textbox\"]")
        end
        return not not ____t_3301(if ____t_3294(____opt_result_3293) then __O[2149] else ____opt_result_3300)
    end
    __L1.visibleKeyboardButton = function(____, target)
        local ____opt_result_3306
        if target ~= nil then
            ____opt_result_3306 = target.closest
        end
        local ____opt_result_3307
        if ____opt_result_3306 ~= nil then
            ____opt_result_3307 = ____opt_result_3306(target, "button,a")
        end
        local button = ____opt_result_3307
        local ____t_3312 = __t
        local ____t_3311 = __t
        local ____t_3309 = __t
        local ____temp_3308 = if __t(button) then not __t(button:closest("[hidden],[inert]")) else button
        __O[2150] = ____temp_3308
        local ____temp_3310 = if ____t_3309(____temp_3308) then __len(button:getClientRects()) else __O[2150]
        __O[2151] = ____temp_3310
        return if ____t_3312(if ____t_3311(____temp_3310) then window:getComputedStyle(button).visibility ~= "hidden" else __O[2151]) then button else nil
    end
    window:addEventListener(
        "keydown",
        function(____, e)
            local ____t_3326 = __t
            local ____t_3325 = __t
            local ____t_3321 = __t
            local ____t_3314 = __t
            local ____temp_3313 = if __t(e.defaultPrevented) then e.defaultPrevented else __L1.inputCaptured
            __O[2152] = ____temp_3313
            local ____opt_3317 = window.Arena
            if ____opt_3317 ~= nil then
                ____opt_3317 = ____opt_3317.isOpen
            end
            local ____opt_result_3319
            if ____opt_3317 ~= nil then
                ____opt_result_3319 = ____opt_3317(____opt_3317)
            end
            local ____temp_3320 = if ____t_3314(____temp_3313) then __O[2152] else ____opt_result_3319
            __O[2153] = ____temp_3320
            local ____this_3323
            ____this_3323 = window.document
            local ____opt_3322 = ____this_3323.querySelector
            local ____temp_3324 = if ____t_3321(____temp_3320) then __O[2153] else ____opt_3322 and ____opt_3322(____this_3323, "dialog[open]")
            __O[2154] = ____temp_3324
            if ____t_3326(if ____t_3325(____temp_3324) then __O[2154] else __L1:editableTarget(e.target)) then
                return
            end
            local ____t_3329 = __t
            local ____t_3328 = __t
            local ____temp_3327 = if __t(e.ctrlKey) then e.ctrlKey else e.metaKey
            __O[2155] = ____temp_3327
            if ____t_3329(if ____t_3328(____temp_3327) then __O[2155] else e.altKey) then
                __L1.keys = {}
                return
            end
            local code = e.code
            local ____t_3335 = __t
            local ____t_3333 = __t
            local ____t_3331 = __t
            local ____temp_3330 = __L1:keyMatches("interact", code)
            __O[2156] = ____temp_3330
            local ____temp_3332 = if ____t_3331(____temp_3330) then __O[2156] else __L1:keyMatches("jump", code)
            __O[2157] = ____temp_3332
            local ____temp_3334 = if ____t_3333(____temp_3332) then __O[2157] else code == "Space"
            __O[2158] = ____temp_3334
            local confirm = if ____t_3335(____temp_3334) then __O[2158] else code == "Enter"
            local ____t_3337 = __t
            local ____temp_3336 = code == "Escape"
            __O[2159] = ____temp_3336
            local pauseKey = if ____t_3337(____temp_3336) then __O[2159] else __L1:keyMatches("pause", code)
            if __t(if __t(__L1.dialog) then if __t(confirm) then confirm else pauseKey else __L1.dialog) then
                e:preventDefault()
                if not __t(e["repeat"]) then
                    local ____t_3342 = __t
                    local ____opt_3340 = e.target
                    local ____opt_3338 = ____opt_3340 and ____opt_3340.closest
                    if ____opt_3338 ~= nil then
                        ____opt_3338 = ____opt_3338(____opt_3340, "#dialogClose")
                    end
                    if ____t_3342(if __t(pauseKey) then pauseKey else ____opt_3338) then
                        __L1:closeDialogue(false)
                    else
                        __L1:nextDialog()
                    end
                end
                return
            end
            local ____t_3349 = __t
            local ____t_3348 = __t
            local ____t_3346 = __t
            local ____opt_3343 = __L1.ollyanEncounter
            if ____opt_3343 ~= nil then
                ____opt_3343 = ____opt_3343.stage
            end
            local ____temp_3345 = if __t(__L1.cutscene) then __L1.cutscene else ____opt_3343 == "intro"
            __O[2160] = ____temp_3345
            local ____temp_3347 = if ____t_3346(____temp_3345) then not __t(__L1.paused) else __O[2160]
            __O[2161] = ____temp_3347
            if ____t_3349(if ____t_3348(____temp_3347) then confirm else __O[2161]) then
                e:preventDefault()
                if not __t(e["repeat"]) then
                    __L1:advanceCutscene()
                end
                return
            end
            local ____t_3356 = __t
            local ____t_3355 = __t
            local ____t_3353 = __t
            local ____t_3351 = __t
            local ____temp_3350 = if __t(pauseKey) then __L1.started else pauseKey
            __O[2162] = ____temp_3350
            local ____temp_3352 = if ____t_3351(____temp_3350) then not __t(__L1.won) else __O[2162]
            __O[2163] = ____temp_3352
            local ____temp_3354 = if ____t_3353(____temp_3352) then not __t(__L1.defeated) else __O[2163]
            __O[2164] = ____temp_3354
            if ____t_3356(if ____t_3355(____temp_3354) then not __t(__L1.chapterEnded) else __O[2164]) then
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
            local ____t_3365 = __t
            local ____t_3364 = __t
            local ____t_3362 = __t
            local ____t_3360 = __t
            local ____t_3358 = __t
            local ____temp_3357 = not __t(__L1.started)
            __O[2165] = ____temp_3357
            local ____temp_3359 = if ____t_3358(____temp_3357) then __O[2165] else __L1.paused
            __O[2166] = ____temp_3359
            local ____temp_3361 = if ____t_3360(____temp_3359) then __O[2166] else __L1.won
            __O[2167] = ____temp_3361
            local ____temp_3363 = if ____t_3362(____temp_3361) then __O[2167] else __L1.defeated
            __O[2168] = ____temp_3363
            if ____t_3365(if ____t_3364(____temp_3363) then __O[2168] else __L1.chapterEnded) then
                local button = __L1:visibleKeyboardButton(e.target)
                if __t(if __t(button) then __call(
                    __arrL({"Enter", "Space"}, 2),
                    "includes",
                    code
                ) else button) then
                    __call(
                        __L1.keyboardClicks,
                        "set",
                        button,
                        window.performance:now()
                    )
                end
                return
            end
            local ____t_3370 = __t
            local ____t_3369 = __t
            local ____opt_3366 = __L1.activity
            if ____opt_3366 ~= nil then
                ____opt_3366 = ____opt_3366.kind
            end
            local ____temp_3368 = ____opt_3366 == "dinner" and __L1.activity.phase == "choice"
            __O[2169] = ____temp_3368
            if ____t_3370(if ____t_3369(____temp_3368) then __call(
                __arrL({"Digit1", "Digit2", "Numpad1", "Numpad2"}, 4),
                "includes",
                code
            ) else __O[2169]) then
                e:preventDefault()
                if not __t(e["repeat"]) then
                    __L1:submitActivity(__TS__Number(__call(code, "slice", -1)) - 1)
                end
                return
            end
            if __t(if __t(__L1.activity) then confirm else __L1.activity) then
                local ____t_3375 = __t
                local ____t_3374 = __t
                local ____t_3372 = __t
                local ____temp_3371 = __L1.activity.kind == "quiz" or __L1.activity.kind == "dinner"
                __O[2170] = ____temp_3371
                local ____temp_3373 = if ____t_3372(____temp_3371) then __L1:visibleKeyboardButton(e.target) else __O[2170]
                __O[2171] = ____temp_3373
                if ____t_3375(if ____t_3374(____temp_3373) then __call(
                    __arrL({"Enter", "Space"}, 2),
                    "includes",
                    code
                ) else __O[2171]) then
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
            local ____t_3379 = __t
            local ____t_3378 = __t
            local ____opt_3376 = __L1.training
            if ____opt_3376 ~= nil then
                ____opt_3376 = ____opt_3376.active
            end
            __O[2172] = ____opt_3376
            if ____t_3379(if ____t_3378(____opt_3376) then confirm else __O[2172]) then
                e:preventDefault()
                if not __t(e["repeat"]) then
                    __L1:submitTraining()
                end
                return
            end
            local ____t_3390 = __t
            local ____t_3389 = __t
            local ____t_3387 = __t
            local ____t_3385 = __t
            local ____t_3383 = __t
            local ____opt_3380 = __L1.training
            if ____opt_3380 ~= nil then
                ____opt_3380 = ____opt_3380.active
            end
            local ____temp_3382 = if __t(__L1.activity) then __L1.activity else ____opt_3380
            __O[2173] = ____temp_3382
            local ____temp_3384 = if ____t_3383(____temp_3382) then __O[2173] else __L1.cutscene
            __O[2174] = ____temp_3384
            local ____temp_3386 = if ____t_3385(____temp_3384) then __O[2174] else __L1.routeTransition
            __O[2175] = ____temp_3386
            local ____temp_3388 = if ____t_3387(____temp_3386) then __O[2175] else if __t(__L1.room) then __L1.room.phase ~= "inside" else __L1.room
            __O[2176] = ____temp_3388
            if ____t_3390(if ____t_3389(____temp_3388) then __O[2176] else if __t(__L1.arena) then __L1.arena.phase ~= "active" else __L1.arena) then
                return
            end
            local ____t_3393 = __t
            local ____t_3392 = __t
            local ____temp_3391 = code == "Enter"
            __O[2177] = ____temp_3391
            if ____t_3393(if ____t_3392(____temp_3391) then __L1:keyMatches("interact", code) else __O[2177]) then
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
            local ____t_3396 = __t
            local ____opt_3394 = window.ControlSettings
            if ____opt_3394 ~= nil then
                ____opt_3394 = ____opt_3394:getActionsForCode(code)
            end
            __O[2178] = ____opt_3394
            local mapped = if ____t_3396(____opt_3394) then __O[2178] else __call(
                __keys(__L1.defaultKeys),
                "filter",
                function(____, a) return __L1:keyMatches(a, code) end
            )
            if not __t(__len(mapped)) then
                return
            end
            e:preventDefault()
            local held = not not __t(__get(__L1.keys, code))
            if __t(if __t(e["repeat"]) then not __t(held) else e["repeat"]) then
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
            local ____t_3399 = __t
            local ____opt_3397 = e.detail
            if ____opt_3397 ~= nil then
                ____opt_3397 = ____opt_3397.active
            end
            __L1.inputCaptured = not not ____t_3399(____opt_3397)
            __L1:releaseInputs()
        end
    )
    window.document:addEventListener(
        "focusin",
        function(____, e)
            local ____t_3406 = __t
            local ____t_3401 = __t
            local ____temp_3400 = __L1:editableTarget(e.target)
            __O[2181] = ____temp_3400
            local ____opt_3404 = e.target
            local ____opt_3402 = ____opt_3404 and ____opt_3404.closest
            if ____opt_3402 ~= nil then
                ____opt_3402 = ____opt_3402(____opt_3404, "dialog[open]")
            end
            if ____t_3406(if ____t_3401(____temp_3400) then __O[2181] else ____opt_3402) then
                __L1:releaseInputs()
            end
        end
    )
    window:addEventListener(
        "blur",
        function()
            __L1:releaseInputs()
            local ____t_3409 = __t
            local ____t_3408 = __t
            local ____temp_3407 = if __t(__L1.started) then not __t(__L1.dialog) else __L1.started
            __O[2182] = ____temp_3407
            if ____t_3409(if ____t_3408(____temp_3407) then not __t(__L1.won) else __O[2182]) then
                __L1:pause()
            end
        end
    )
    window:addEventListener("pagehide", __L1.releaseInputs)
    window:addEventListener("orientationchange", __L1.releaseInputs)
    local ____this_3416
    ____this_3416 = window.document
    local ____opt_3410 = ____this_3416.addEventListener
    if ____opt_3410 ~= nil then
        ____opt_3410(
            ____this_3416,
            "visibilitychange",
            function()
                __L1:releaseInputs()
                local ____t_3415 = __t
                local ____t_3414 = __t
                local ____t_3412 = __t
                local ____temp_3411 = if __t(window.document.hidden) then __L1.started else window.document.hidden
                __O[2183] = ____temp_3411
                local ____temp_3413 = if ____t_3412(____temp_3411) then not __t(__L1.won) else __O[2183]
                __O[2184] = ____temp_3413
                if ____t_3415(if ____t_3414(____temp_3413) then not __t(__L1.dialog) else __O[2184]) then
                    __L1:pause()
                end
            end
        )
    end
    local ____this_3418
    ____this_3418 = window.document
    local ____opt_3417 = ____this_3418.addEventListener
    if ____opt_3417 ~= nil then
        ____opt_3417(____this_3418, "fullscreenchange", __L1.releaseInputs)
    end
    for ____, target in __iterar((__arrL({window.document, window}, 2))) do
        for ____, eventName in __iterar((__arrL({"pointerup", "pointercancel", "lostpointercapture"}, 3))) do
            local ____opt_3419 = target.addEventListener
            if ____opt_3419 ~= nil then
                ____opt_3419(
                    target,
                    eventName,
                    function(____, e) return __L1:releasePointer(e.pointerId) end,
                    true
                )
            end
        end
        local ____opt_3421 = target.addEventListener
        if ____opt_3421 ~= nil then
            ____opt_3421(
                target,
                "pointermove",
                function(____, e)
                    local p = __call(__L1.activePointers, "get", e.pointerId)
                    if __t(p) then
                        local ____e_clientX_3422 = e.clientX
                        if ____e_clientX_3422 == nil then
                            ____e_clientX_3422 = p.x
                        end
                        p.x = ____e_clientX_3422
                        local ____e_clientY_3423 = e.clientY
                        if ____e_clientY_3423 == nil then
                            ____e_clientY_3423 = p.y
                        end
                        p.y = ____e_clientY_3423
                    end
                end,
                true
            )
        end
        local ____opt_3425 = target.addEventListener
        if ____opt_3425 ~= nil then
            ____opt_3425(
                target,
                "touchend",
                __L1.reconcileTouches,
                __ord({capture = true, passive = true}, "capture,passive")
            )
        end
        local ____opt_3427 = target.addEventListener
        if ____opt_3427 ~= nil then
            ____opt_3427(
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
                    local ____t_3431 = __t
                    local ____t_3430 = __t
                    local ____temp_3429 = e.pointerType == "mouse" and e.button ~= 0
                    __O[2185] = ____temp_3429
                    if ____t_3431(if ____t_3430(____temp_3429) then __O[2185] else __call(__L1.activePointers, "has", e.pointerId)) then
                        return
                    end
                    e:preventDefault()
                    local ____t_3463 = __t
                    local ____t_3438 = __t
                    local ____opt_3434 = window.Arena
                    if ____opt_3434 ~= nil then
                        ____opt_3434 = ____opt_3434.isOpen
                    end
                    local ____opt_result_3436
                    if ____opt_3434 ~= nil then
                        ____opt_result_3436 = ____opt_3434(____opt_3434)
                    end
                    local ____temp_3437 = if __t(__L1.inputCaptured) then __L1.inputCaptured else ____opt_result_3436
                    __O[2197] = ____temp_3437
                    local ____t_3440 = __t
                    local ____call_result_3439 = __call(__L1.heldActions, "has", a)
                    __O[2196] = ____call_result_3439
                    local ____t_3460 = __t
                    local ____t_3458 = __t
                    local ____t_3456 = __t
                    local ____t_3454 = __t
                    local ____t_3452 = __t
                    local ____t_3450 = __t
                    local ____t_3448 = __t
                    local ____t_3446 = __t
                    local ____t_3444 = __t
                    local ____t_3442 = __t
                    local ____temp_3441 = not __t(__L1.started)
                    __O[2186] = ____temp_3441
                    local ____temp_3443 = if ____t_3442(____temp_3441) then __O[2186] else __L1.paused
                    __O[2187] = ____temp_3443
                    local ____temp_3445 = if ____t_3444(____temp_3443) then __O[2187] else __L1.dialog
                    __O[2188] = ____temp_3445
                    local ____temp_3447 = if ____t_3446(____temp_3445) then __O[2188] else __L1.won
                    __O[2189] = ____temp_3447
                    local ____temp_3449 = if ____t_3448(____temp_3447) then __O[2189] else __L1.defeated
                    __O[2190] = ____temp_3449
                    local ____temp_3451 = if ____t_3450(____temp_3449) then __O[2190] else __L1.cutscene
                    __O[2191] = ____temp_3451
                    local ____temp_3453 = if ____t_3452(____temp_3451) then __O[2191] else if __t(__L1.room) then __L1.room.phase ~= "inside" else __L1.room
                    __O[2192] = ____temp_3453
                    local ____temp_3455 = if ____t_3454(____temp_3453) then __O[2192] else if __t(__L1.arena) then __L1.arena.phase ~= "active" else __L1.arena
                    __O[2193] = ____temp_3455
                    local ____temp_3457 = if ____t_3456(____temp_3455) then __O[2193] else __L1.routeTransition
                    __O[2194] = ____temp_3457
                    local ____temp_3459 = if ____t_3458(____temp_3457) then __O[2194] else __L1.activity
                    __O[2195] = ____temp_3459
                    local ____opt_3461 = __L1.training
                    if ____opt_3461 ~= nil then
                        ____opt_3461 = ____opt_3461.active
                    end
                    if ____t_3463(if ____t_3438(____temp_3437) then __O[2197] else if ____t_3440(____call_result_3439) then if ____t_3460(____temp_3459) then __O[2195] else ____opt_3461 else __O[2196]) then
                        return
                    end
                    __call(
                        __L1.pointerTimes,
                        "set",
                        el,
                        window.performance:now()
                    )
                    local ____call_3470 = __call
                    local ____L1_activePointers_3468 = __L1.activePointers
                    local ____e_pointerId_3469 = e.pointerId
                    local ____el_3466 = el
                    local ____temp_3467 = if __t(e.pointerType) then e.pointerType else "touch"
                    local ____e_clientX_3464 = e.clientX
                    if ____e_clientX_3464 == nil then
                        ____e_clientX_3464 = 0
                    end
                    local ____e_clientY_3465 = e.clientY
                    if ____e_clientY_3465 == nil then
                        ____e_clientY_3465 = 0
                    end
                    ____call_3470(____L1_activePointers_3468, "set", ____e_pointerId_3469, {
                        action = a,
                        element = ____el_3466,
                        pointerType = ____temp_3467,
                        x = ____e_clientX_3464,
                        y = ____e_clientY_3465
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
                    local ____t_3479 = __t
                    local ____t_3478 = __t
                    local ____t_3474 = __t
                    local ____t_3472 = __t
                    local ____temp_3471 = e.detail ~= 0
                    __O[2198] = ____temp_3471
                    local ____temp_3473 = if ____t_3472(____temp_3471) then __O[2198] else __call(__L1.heldActions, "has", a)
                    __O[2199] = ____temp_3473
                    local ____opt_3475 = e.sourceCapabilities
                    if ____opt_3475 ~= nil then
                        ____opt_3475 = ____opt_3475.firesTouchEvents
                    end
                    local ____temp_3477 = if ____t_3474(____temp_3473) then __O[2199] else ____opt_3475
                    __O[2200] = ____temp_3477
                    if ____t_3479(if ____t_3478(____temp_3477) then __O[2200] else e.pointerType == "touch") then
                        return
                    end
                    local pointerAt = __call(__L1.pointerTimes, "get", el)
                    local keyboardAt = __call(__L1.keyboardClicks, "get", el)
                    local ____t_3482 = __t
                    local ____t_3481 = __t
                    local ____temp_3480 = pointerAt ~= nil and window.performance:now() - pointerAt < 750
                    __O[2201] = ____temp_3480
                    if ____t_3482(if ____t_3481(____temp_3480) then not __t(keyboardAt ~= nil and __ge(keyboardAt, pointerAt)) else __O[2201]) then
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
    local ____opt_3483 = __L1["$"](__L1, "startBtn")
    if ____opt_3483 ~= nil then
        ____opt_3483:addEventListener(
            "click",
            function() return __L1:start(false) end
        )
    end
    local ____opt_3485 = __L1["$"](__L1, "continueBtn")
    if ____opt_3485 ~= nil then
        ____opt_3485:addEventListener(
            "click",
            function() return __L1:start(true) end
        )
    end
    local ____opt_3487 = __L1["$"](__L1, "pauseBtn")
    if ____opt_3487 ~= nil then
        ____opt_3487:addEventListener(
            "click",
            function() return if __t(__L1.paused) then __L1:resume() else __L1:pause() end
        )
    end
    local ____opt_3489 = __L1["$"](__L1, "resumeBtn")
    if ____opt_3489 ~= nil then
        ____opt_3489:addEventListener("click", __L1.resume)
    end
    local ____opt_3491 = __L1["$"](__L1, "restartBtn")
    if ____opt_3491 ~= nil then
        ____opt_3491:addEventListener("click", __L1.reset)
    end
    local ____opt_3493 = __L1["$"](__L1, "soundBtn")
    if ____opt_3493 ~= nil then
        ____opt_3493:addEventListener(
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
            local ____opt_3495 = __L1["$"](
                __L1,
                __add("activityChoice", i)
            )
            if ____opt_3495 ~= nil then
                ____opt_3495:addEventListener(
                    "click",
                    function()
                        local ____L1_submitActivity_3499 = __L1.submitActivity
                        local ____opt_3496 = __L1["$"](
                            __L1,
                            __add("activityChoice", i)
                        )
                        if ____opt_3496 ~= nil then
                            ____opt_3496 = ____opt_3496.dataset.value
                        end
                        local ____opt_3496_3498 = ____opt_3496
                        if ____opt_3496_3498 == nil then
                            ____opt_3496_3498 = i
                        end
                        return ____L1_submitActivity_3499(
                            __L1,
                            __TS__Number(____opt_3496_3498)
                        )
                    end
                )
            end
            i = i + 1
        end
    end
    local ____opt_3501 = __L1["$"](__L1, "activityExitBtn")
    if ____opt_3501 ~= nil then
        ____opt_3501:addEventListener("click", __L1.cancelActivity)
    end
    local ____opt_3503 = __L1["$"](__L1, "cutsceneNextBtn")
    if ____opt_3503 ~= nil then
        ____opt_3503:addEventListener("click", __L1.advanceCutscene)
    end
    local ____opt_3505 = __L1["$"](__L1, "cutsceneSkipBtn")
    if ____opt_3505 ~= nil then
        ____opt_3505:addEventListener("click", __L1.skipCutscene)
    end
    local ____opt_3507 = __L1["$"](__L1, "replayIntroBtn")
    if ____opt_3507 ~= nil then
        ____opt_3507:addEventListener("click", __L1.replayIntro)
    end
    local ____opt_3509 = __L1["$"](__L1, "roomExitBtn")
    if ____opt_3509 ~= nil then
        ____opt_3509:addEventListener("click", __L1.exitRoom)
    end
    local ____opt_3511 = __L1["$"](__L1, "trainingExitBtn")
    if ____opt_3511 ~= nil then
        ____opt_3511:addEventListener("click", __L1.cancelTraining)
    end
    local ____opt_3513 = __L1["$"](__L1, "respawnBtn")
    if ____opt_3513 ~= nil then
        ____opt_3513:addEventListener("click", __L1.respawn)
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
                local ____opt_3517 = __L1.ollyanEncounter
                if ____opt_3517 ~= nil then
                    ____opt_3517 = ____opt_3517.player
                end
                local ____opt_result_3519
                if ____opt_3517 ~= nil then
                    ____opt_result_3519 = ____opt_3517.y
                end
                local ____opt_result_3519_3520 = ____opt_result_3519
                if ____opt_result_3519_3520 == nil then
                    ____opt_result_3519_3520 = __L1.player.y
                end
                return {y = ____opt_result_3519_3520, vehicle = if __t(__L1.vehicle) then __L1.vehicle else not not __t(__L1.ollyanEncounter)}
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
                local ____t_3526 = __t
                local ____opt_3523 = window.CampaignRun
                if ____opt_3523 ~= nil then
                    ____opt_3523 = ____opt_3523.getState
                end
                local ____opt_result_3525
                if ____opt_3523 ~= nil then
                    ____opt_result_3525 = ____opt_3523(____opt_3523)
                end
                __O[2237] = ____opt_result_3525
                local ____temp_3530 = if ____t_3526(____opt_result_3525) then __O[2237] else nil
                local ____temp_3531 = if __t(__L1.sandbox) then {type = __L1.sandbox.type, result = __L1.sandbox.result, difficultyMode = __L1.sandbox.difficultyMode} else nil
                local ____assign_result_3532 = __assign(
                    {},
                    __L1:bivoltStatus()
                )
                local ____temp_3533 = if __t(__L1.ollyanEncounter) then __assign(
                    {},
                    window.OllyanEncounter:getStatus(__L1.ollyanEncounter),
                    {player = __assign({}, __L1.ollyanEncounter.player)}
                ) else nil
                local ____L1_started_3534 = __L1.started
                local ____L1_playing_3535 = __L1.playing
                local ____L1_paused_3536 = __L1.paused
                local ____L1_won_3537 = __L1.won
                local ____L1_chapterEnded_3538 = __L1.chapterEnded
                local ____L1_scene_3539 = __L1.scene
                local ____L1_camera_3540 = __L1.camera
                local ____temp_3541 = if __t(__L1:closestBoss()) then __assign(
                    {},
                    {
                        type = __L1:closestBoss().type,
                        name = __L1:nomeBoss(__L1:closestBoss().type)
                    },
                    __L1:bossAccess(__L1:closestBoss())
                ) else nil
                local ____assign_result_3542 = __assign({}, __L1.q)
                local ____assign_result_3543 = __assign({}, __L1.player)
                local ____call_result_3544 = __call(
                    __L1.enemies,
                    "map",
                    function(____, e) return __assign({}, e) end
                )
                local ____call_result_3545 = __call(
                    __L1.targets,
                    "map",
                    function(____, t) return __assign({}, t) end
                )
                local ____temp_3546 = if __t(__L1.dialog) then __assign({}, __L1.dialog) else nil
                local ____assign_result_3547 = __assign({}, __L1.items)
                local ____temp_3548 = __L1:materialCount()
                local ____arr_result_3549 = __arr(__TS__Spread(__iter(__L1.collected)))
                local ____L1_weapon_3550 = __L1.weapon
                local ____get_result_3551 = __get(__L1.weaponNames, __L1.weapon)
                local ____temp_3552 = __L1:levelState()
                local ____L1_comboStep_3553 = __L1.comboStep
                local ____arr_result_3554 = __arr(__TS__Spread(__iter(__L1.seenBossIntros)))
                local ____temp_3555 = if __t(__L1.activity) then __assign({}, __L1.activity) else nil
                local ____temp_3556 = if __t(__L1.training) then __assign({}, __L1.training) else nil
                local ____call_result_3557 = __call(
                    __L1.shots,
                    "map",
                    function(____, s) return __assign({}, s) end
                )
                local ____L1_vehicle_3558 = __L1.vehicle
                local ____L1_reeisTimer_3559 = __L1.reeisTimer
                local ____L1_reeisCooldown_3560 = __L1.reeisCooldown
                local ____L1_reeisPhase_3561 = __L1.reeisPhase
                local ____L1_reeisX_3562 = __L1.reeisX
                local ____L1_reeisPhaseTimer_3563 = __L1.reeisPhaseTimer
                local ____assign_result_3564 = __assign({}, __L1.joystick)
                local ____L1_dashTimer_3565 = __L1.dashTimer
                local ____L1_dashCooldown_3566 = __L1.dashCooldown
                local ____t_3529 = __t
                local ____opt_3527 = __L1.activeBoss
                if ____opt_3527 ~= nil then
                    ____opt_3527 = ____opt_3527.type
                end
                __O[2238] = ____opt_3527
                return {
                    run = ____temp_3530,
                    sandbox = ____temp_3531,
                    bivolt = ____assign_result_3532,
                    ollyan = ____temp_3533,
                    started = ____L1_started_3534,
                    playing = ____L1_playing_3535,
                    paused = ____L1_paused_3536,
                    won = ____L1_won_3537,
                    chapterEnded = ____L1_chapterEnded_3538,
                    scene = ____L1_scene_3539,
                    camera = ____L1_camera_3540,
                    nearBoss = ____temp_3541,
                    q = ____assign_result_3542,
                    player = ____assign_result_3543,
                    enemies = ____call_result_3544,
                    targets = ____call_result_3545,
                    dialog = ____temp_3546,
                    items = ____assign_result_3547,
                    materialCount = ____temp_3548,
                    collected = ____arr_result_3549,
                    weapon = ____L1_weapon_3550,
                    weaponName = ____get_result_3551,
                    progression = ____temp_3552,
                    comboStep = ____L1_comboStep_3553,
                    seenBossIntros = ____arr_result_3554,
                    activity = ____temp_3555,
                    training = ____temp_3556,
                    shots = ____call_result_3557,
                    vehicle = ____L1_vehicle_3558,
                    reeisTimer = ____L1_reeisTimer_3559,
                    reeisCooldown = ____L1_reeisCooldown_3560,
                    reeisPhase = ____L1_reeisPhase_3561,
                    reeisX = ____L1_reeisX_3562,
                    reeisPhaseTimer = ____L1_reeisPhaseTimer_3563,
                    joystick = ____assign_result_3564,
                    dashTimer = ____L1_dashTimer_3565,
                    dashCooldown = ____L1_dashCooldown_3566,
                    activeBoss = if ____t_3529(____opt_3527) then __O[2238] else nil,
                    defeated = __L1.defeated,
                    routeTransition = if __t(__L1.routeTransition) then __assign({}, __L1.routeTransition) else nil,
                    hazards = __call(
                        __L1.hazards,
                        "map",
                        function(____, h) return __assign({}, h) end
                    ),
                    worldWidth = __L1.WORLD,
                    room = if __t(__L1.room) then __assign({}, __L1.room) else nil,
                    arena = if __t(__L1.arena) then __assign({}, __L1.arena) else nil,
                    cutscene = if __t(__L1.cutscene) then __assign({}, __L1.cutscene) else nil,
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
            local ____t_3573 = __t
            local ____t_3572 = __t
            local ____t_3570 = __t
            local ____opt_3567 = event.detail
            if ____opt_3567 ~= nil then
                ____opt_3567 = ____opt_3567.reason
            end
            local ____temp_3569 = ____opt_3567 == "difficulty"
            __O[2239] = ____temp_3569
            local ____temp_3571 = if ____t_3570(____temp_3569) then __L1.started else __O[2239]
            __O[2240] = ____temp_3571
            if ____t_3573(if ____t_3572(____temp_3571) then not __t(__L1.sandbox) else __O[2240]) then
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
