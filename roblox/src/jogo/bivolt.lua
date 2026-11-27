--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __isFiniteN, __getq, __ord, __arrL, __iterar, __t, __get, __set, __arr, __len, __call, __add = __JSR.__isFiniteN, __JSR.__getq, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__set, __JSR.__arr, __JSR.__len, __JSR.__call, __JSR.__add
local __iter, __keys, __assign, __isArray = __JSR.__iter, __JSR.__keys, __JSR.__assign, __JSR.__isArray
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Number = ____lualib.__TS__Number
local Set = ____lualib.Set
local __TS__New = ____lualib.__TS__New
local WeakSet = ____lualib.WeakSet
local __TS__Spread = ____lualib.__TS__Spread
local __TS__Iterator = ____lualib.__TS__Iterator
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    local SCENE = 10
    local DURATION = 10
    local COOLDOWN = 30
    local MAX_CHARGES = 9
    local girls = __ord({eloisa = "Eloisa", giselle = "Giselle", rayssa = "Rayssa", analaura = "Ana Laura"}, "eloisa,giselle,rayssa,analaura")
    local parts = __arrL(
        {
            __ord({
                id = "bivolt-dourada",
                x = 1990,
                y = 350,
                label = "Lata dourada · prateleira baixa",
                color = "#efca67"
            }, "id,x,y,label,color"),
            __ord({
                id = "bivolt-azul",
                x = 2180,
                y = 294,
                label = "Lata azul · prateleira de cima",
                color = "#70c9dd"
            }, "id,x,y,label,color"),
            __ord({
                id = "bivolt-violeta",
                x = 2930,
                y = 294,
                label = "Lata violeta · varanda",
                color = "#bc8ce1"
            }, "id,x,y,label,color")
        },
        3
    )
    local function clamp(____, n, a, b)
        return math.max(
            a,
            math.min(b, n)
        )
    end
    local function count(____, value)
        return if __isFiniteN(__TS__Number(value)) then clamp(
            nil,
            math.floor(__TS__Number(value)),
            0,
            999
        ) else 0
    end
    local function charges(____, q)
        local ____opt_result_2
        if q ~= nil then
            ____opt_result_2 = q.bivoltCharges
        end
        return clamp(
            nil,
            count(nil, ____opt_result_2),
            0,
            MAX_CHARGES
        )
    end
    local function found(____, q)
        local ____Set_8 = Set
        local ____call_7 = __call
        local ____isArray_6 = __isArray
        local ____opt_result_5
        if q ~= nil then
            ____opt_result_5 = q.bivoltParts
        end
        return __TS__New(
            ____Set_8,
            ____call_7(
                if ____isArray_6(____opt_result_5) then q.bivoltParts else __arrL({}, 0),
                "filter",
                function(____, id) return __call(
                    parts,
                    "some",
                    function(____, p) return p.id == id end
                ) end
            )
        )
    end
    local function materials(____, bag)
        return __call(
            __arrL({"pencil", "eraser", "clip"}, 3),
            "reduce",
            function(____, sum, key) return sum + count(
                nil,
                __getq(bag, key)
            ) end,
            0
        )
    end
    local issued = __TS__New(WeakSet)
    local completed = __TS__New(WeakSet)
    local sequence = 0
    local remaining = 0
    local cooldown = 0
    local function action(____, ____type)
        local ____type_9 = ____type
        sequence = sequence + 1
        local value = {type = ____type_9, id = sequence}
        __call(issued, "add", value)
        return value
    end
    local function line(____, name, text)
        return {name = name, text = text}
    end
    local function state(self, q)
        local collected = __arr(__TS__Spread(__iter(found(nil, q))))
        local ____t_13 = __t
        local ____opt_result_12
        if q ~= nil then
            ____opt_result_12 = q.bivoltAccepted
        end
        local ____temp_18 = not not ____t_13(____opt_result_12)
        local ____t_17 = __t
        local ____opt_result_16
        if q ~= nil then
            ____opt_result_16 = q.bivoltUnlocked
        end
        return {
            accepted = ____temp_18,
            unlocked = not not ____t_17(____opt_result_16),
            charges = charges(nil, q),
            collected = collected,
            needed = math.max(
                0,
                __len(parts) - __len(collected)
            ),
            maxCharges = MAX_CHARGES
        }
    end
    local function interact(self, npcId, q, bag)
        local name = __get(girls, npcId)
        local ____t_21 = __t
        local ____t_20 = __t
        local ____temp_19 = not __t(name) or not __t(q)
        __O[1287] = ____temp_19
        if ____t_21(if ____t_20(____temp_19) then __O[1287] else type(q) ~= "table") then
            return nil
        end
        local s = state(nil, q)
        local opening = __get({eloisa = "Aff veyr juro, Da Roça! Você sobe essas prateleiras ou só sobe a pressão de Nikolas?", giselle = "Aff veyr juro! O menino entrou aqui com o gás acabando e a pose carregada.", rayssa = "Aff veyr juro, menino, se toca! Pra buscar esse bolo vai precisar de uma energia extra.", analaura = "Aff veyr juro! Esse chapéu tá no modo economia de bateria, é?"}, npcId)
        if __t(not __t(s.accepted) and not __t(s.unlocked)) then
            return {
                lines = __arrL(
                    {
                        line(nil, name, opening),
                        line(nil, name, "Espalhamos três latas seladas de Bivolt nas prateleiras e na varanda. Pega as três e traz aqui. Tem parkour, mas não tem como culpar a cadeira!"),
                        line(nil, "Da Roça", "Três latas e uma missão? Vou buscar no gás. O energético pode ficar por conta de vocês."),
                        line(nil, name, "Aff veyr juro, combinado! Lata dourada embaixo, azul lá em cima e violeta na varanda. Depois volta pra conversar.")
                    },
                    4
                ),
                action = action(nil, "accept")
            }
        end
        if __t(if __t(s.accepted) then not __t(s.unlocked) else s.accepted) then
            if s.needed == 0 then
                return {
                    lines = __arrL(
                        {
                            line(nil, name, "Aff veyr juro! As três latas chegaram inteiras. Até que esse parkour de chapéu presta!"),
                            line(nil, name, "Toma três cargas de BIVOLT. Cada lata sobe vida máxima, gás, força e agilidade por DEZ segundos. Depois volta tudo ao normal, sem gastar seus pontos."),
                            line(nil, "Da Roça", "Dez segundos no modo tomada dupla? Nikolas vai conhecer a conta de luz da roça."),
                            line(nil, name, "Aff veyr juro, bestaiado! Usa B ou o botão da latinha. Não dá pra emendar: espera a recarga. Quando acabar, eu troco três materiais escolares por outra lata.")
                        },
                        4
                    ),
                    action = action(nil, "unlock")
                }
            end
            return {
                lines = __arrL(
                    {
                        line(nil, name, opening),
                        line(
                            nil,
                            name,
                            ((("Ainda " .. tostring(if s.needed == 1 then "falta uma lata" else __add(
                                __add("faltam ", s.needed),
                                " latas"
                            ))) .. "! Você já pegou ") .. tostring(__len(s.collected))) .. "/3. Confere a prateleira baixa, a de cima e a varanda. Aff veyr juro, não me volta só com o lacre!"
                        )
                    },
                    2
                ),
                action = nil
            }
        end
        if npcId ~= "rayssa" then
            return nil
        end
        if s.charges >= MAX_CHARGES then
            return {
                lines = __arrL(
                    {line(nil, name, "Aff veyr juro! Nove latas já é um estoque, menino. Usa uma antes de pedir mais. Teu bolso não é a geladeira da festa.")},
                    1
                ),
                action = nil
            }
        end
        if materials(nil, bag) >= 3 then
            return {
                lines = __arrL(
                    {
                        line(
                            nil,
                            name,
                            ((("Aff veyr juro! Você tem " .. tostring(s.charges)) .. " ") .. if s.charges == 1 then "lata" else "latas") .. ". Troco três materiais escolares por UMA carga nova. Lápis, borracha ou clipe: a resenha aceita os três."
                        ),
                        line(nil, "Da Roça", "Fechado. Meu estojo virou patrocinador do Bivolt!"),
                        line(nil, name, "Aff veyr juro, patrocinador de papel, né? Uma lata por troca. E continua gastando seus pontos de nível, porque energético não faz milagre.")
                    },
                    3
                ),
                action = action(nil, "refill")
            }
        end
        return {
            lines = __arrL(
                {line(
                    nil,
                    name,
                    ((("Aff veyr juro! Você tá com " .. tostring(s.charges)) .. " ") .. if s.charges == 1 then "carga" else "cargas") .. " de Bivolt. Traz três materiais escolares pra eu te dar mais uma. Por enquanto, dez segundos de boost e trinta entre uma lata e outra!"
                )},
                1
            ),
            action = nil
        }
    end
    local function complete(self, q, plan, bag)
        local ____t_30 = __t
        local ____t_29 = __t
        local ____t_27 = __t
        local ____t_25 = __t
        local ____t_23 = __t
        local ____temp_22 = not __t(q) or type(q) ~= "table"
        __O[1288] = ____temp_22
        local ____temp_24 = if ____t_23(____temp_22) then __O[1288] else not __t(plan)
        __O[1289] = ____temp_24
        local ____temp_26 = if ____t_25(____temp_24) then __O[1289] else type(plan) ~= "table"
        __O[1290] = ____temp_26
        local ____temp_28 = if ____t_27(____temp_26) then __O[1290] else not __t(__call(issued, "has", plan))
        __O[1291] = ____temp_28
        if ____t_30(if ____t_29(____temp_28) then __O[1291] else __call(completed, "has", plan)) then
            return {ok = false, changed = false, message = "Essa conversa não tem uma entrega pendente."}
        end
        __call(completed, "add", plan)
        local s = state(nil, q)
        if plan.type == "accept" then
            if __t(if __t(s.accepted) then s.accepted else s.unlocked) then
                return {ok = false, changed = false, message = "A missão do Bivolt já foi aceita."}
            end
            q.bivoltAccepted = true
            q.bivoltParts = __arrL({}, 0)
            return {ok = true, changed = true, accepted = true, message = "Missão Bivolt: encontre as três latas na Casa de Rayssa e volte às garotas."}
        end
        if plan.type == "unlock" then
            local ____t_35 = __t
            local ____t_34 = __t
            local ____t_32 = __t
            local ____temp_31 = not __t(s.accepted)
            __O[1292] = ____temp_31
            local ____temp_33 = if ____t_32(____temp_31) then __O[1292] else s.unlocked
            __O[1293] = ____temp_33
            if ____t_35(if ____t_34(____temp_33) then __O[1293] else s.needed ~= 0) then
                return {ok = false, changed = false, message = "Recolha as três latas antes de receber o Bivolt."}
            end
            q.bivoltUnlocked = true
            q.bivoltCharges = 3
            return {
                ok = true,
                changed = true,
                unlocked = true,
                xp = 240,
                source = "side-bivolt-unlock",
                message = "BIVOLT DESBLOQUEADO! 3 cargas · todos os atributos por 10 segundos · B ou latinha."
            }
        end
        if plan.type == "refill" then
            local ____t_40 = __t
            local ____t_39 = __t
            local ____t_37 = __t
            local ____temp_36 = not __t(s.unlocked) or s.charges >= MAX_CHARGES
            __O[1294] = ____temp_36
            local ____temp_38 = if ____t_37(____temp_36) then __O[1294] else not __t(bag)
            __O[1295] = ____temp_38
            if ____t_40(if ____t_39(____temp_38) then __O[1295] else materials(nil, bag) < 3) then
                return {ok = false, changed = false, message = "Separe três materiais escolares e um espaço para a lata."}
            end
            local needed = 3
            local consumed = {pencil = 0, eraser = 0, clip = 0}
            for ____, key in __iterar((__keys(consumed))) do
                local available = count(
                    nil,
                    __get(bag, key)
                )
                local use = math.min(needed, available)
                __set(consumed, key, use)
                needed = needed - use
            end
            if __t(needed) then
                return {ok = false, changed = false, message = "Os materiais da troca não estão mais no estojo."}
            end
            for ____, key in __iterar((__keys(consumed))) do
                __set(
                    bag,
                    key,
                    count(
                        nil,
                        __get(bag, key)
                    ) - __get(consumed, key)
                )
            end
            q.bivoltCharges = s.charges + 1
            return {
                ok = true,
                changed = true,
                refilled = true,
                consumed = consumed,
                message = "Rayssa trocou 3 materiais por 1 carga de Bivolt. Aff veyr juro!"
            }
        end
        return {ok = false, changed = false, message = "Entrega de Bivolt desconhecida."}
    end
    local function collect(self, q, player, scene)
        local ____t_53 = __t
        local ____t_52 = __t
        local ____t_50 = __t
        local ____t_48 = __t
        local ____t_46 = __t
        local ____temp_45 = __TS__Number(scene) ~= SCENE
        if not ____temp_45 then
            local ____t_44 = __t
            local ____opt_result_43
            if q ~= nil then
                ____opt_result_43 = q.bivoltAccepted
            end
            ____temp_45 = not ____t_44(____opt_result_43)
        end
        __O[1296] = ____temp_45
        local ____temp_47 = if ____t_46(____temp_45) then __O[1296] else q.bivoltUnlocked
        __O[1297] = ____temp_47
        local ____temp_49 = if ____t_48(____temp_47) then __O[1297] else not __t(player)
        __O[1298] = ____temp_49
        local ____temp_51 = if ____t_50(____temp_49) then __O[1298] else not __isFiniteN(player.x)
        __O[1299] = ____temp_51
        if ____t_53(if ____t_52(____temp_51) then __O[1299] else not __isFiniteN(player.y)) then
            return nil
        end
        local collected = found(nil, q)
        local part = __call(
            parts,
            "find",
            function(____, p)
                local ____t_55 = __t
                local ____temp_54 = not __t(__call(collected, "has", p.id)) and math.abs(player.x - p.x) <= 29
                __O[1300] = ____temp_54
                return if ____t_55(____temp_54) then math.abs(player.y - 30 - p.y) <= 35 else __O[1300]
            end
        )
        if not __t(part) then
            return nil
        end
        __call(collected, "add", part.id)
        q.bivoltParts = __arr(__TS__Spread(__iter(collected)))
        return {
            collected = true,
            id = part.id,
            count = collected.size,
            total = __len(parts),
            message = if collected.size == __len(parts) then "Bivolt 3/3! Volte às garotas para receber suas três cargas." else ((("Bivolt " .. tostring(collected.size)) .. "/3 · ") .. tostring(part.label)) .. "."
        }
    end
    local function can(self, c, x, y, t, color, small)
        if small == nil then
            small = false
        end
        local u = if __t(small) then 0.72 else 1
        c:save()
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + math.sin(t * 3 + x) * 2 + 0.5)
        )
        c:scale(u, u)
        c.fillStyle = "#172d35"
        c:fillRect(-9, -16, 18, 29)
        c.fillStyle = "#a9bbbc"
        c:fillRect(-6, -18, 12, 3)
        c:fillRect(-7, 12, 14, 3)
        c.fillStyle = "#586a71"
        c:fillRect(-2, -17, 5, 2)
        c.fillStyle = color
        c:fillRect(-6, -13, 12, 25)
        c.fillStyle = "#fbefc3"
        c:fillRect(-5, -10, 10, 5)
        c.fillStyle = "#61324b"
        c:beginPath()
        c:moveTo(2, -5)
        c:lineTo(-4, 3)
        c:lineTo(0, 3)
        c:lineTo(-2, 10)
        c:lineTo(5, 0)
        c:lineTo(1, 0)
        c:closePath()
        __call(c, "fill")
        c.fillStyle = "#ffffff80"
        c:fillRect(-5, -12, 2, 22)
        c:restore()
    end
    local function draw(self, c, camera, t, q, scene)
        local ____t_64 = __t
        local ____t_63 = __t
        local ____t_57 = __t
        local ____temp_56 = not __t(c) or __TS__Number(scene) ~= SCENE
        __O[1301] = ____temp_56
        local ____t_61 = __t
        local ____opt_result_60
        if q ~= nil then
            ____opt_result_60 = q.bivoltAccepted
        end
        local ____temp_62 = if ____t_57(____temp_56) then __O[1301] else not ____t_61(____opt_result_60)
        __O[1302] = ____temp_62
        if ____t_64(if ____t_63(____temp_62) then __O[1302] else q.bivoltUnlocked) then
            return
        end
        local collected = found(nil, q)
        c:save()
        local ____c_67 = c
        local ____c_translate_68 = c.translate
        local ____t_66 = __t
        local ____TS__Number_result_65 = __TS__Number(camera)
        __O[1303] = ____TS__Number_result_65
        ____c_translate_68(
            ____c_67,
            __TS__Number(-if ____t_66(____TS__Number_result_65) then __O[1303] else 0),
            0
        )
        for ____, p in __iterar((parts)) do
            if __t(__call(collected, "has", p.id)) then
                continue
            end
            local pulse = 0.5 + 0.5 * math.sin(t * 3 + p.x)
            c.globalAlpha = 0.13 + pulse * 0.1
            c.fillStyle = p.color
            c:beginPath()
            c:arc(
                p.x,
                p.y,
                24 + pulse * 4,
                0,
                math.pi * 2
            )
            __call(c, "fill")
            c.globalAlpha = 1
            can(
                nil,
                c,
                p.x,
                p.y,
                t,
                p.color
            )
            c.fillStyle = "#efe3aa"
            c.font = "bold 9px monospace"
            c.textAlign = "center"
            c:fillText("BIVOLT", p.x, p.y - 24)
        end
        c:restore()
    end
    local function activate(self, q)
        local s = state(nil, q)
        if not __t(s.unlocked) then
            return {ok = false, message = "Faça a missão das garotas na Casa de Rayssa para liberar o Bivolt."}
        end
        if remaining > 0 then
            return {ok = false, message = "O Bivolt já está ativo!"}
        end
        if cooldown > 0 then
            return {
                ok = false,
                message = ("Aguarde " .. tostring(math.ceil(cooldown))) .. "s para abrir outra lata."
            }
        end
        if s.charges < 1 then
            return {ok = false, message = "Sem Bivolt. Rayssa troca 3 materiais escolares por uma carga."}
        end
        q.bivoltCharges = s.charges - 1
        remaining = DURATION
        cooldown = COOLDOWN
        return {
            ok = true,
            active = true,
            duration = DURATION,
            cooldown = COOLDOWN,
            charges = q.bivoltCharges,
            message = "BIVOLT! Vida, força, gás e agilidade aumentados por 10 segundos!"
        }
    end
    local function update(self, dt)
        local delta = if __isFiniteN(dt) then math.max(0, dt) else 0
        local was = remaining > 0
        remaining = math.max(0, remaining - delta)
        cooldown = math.max(0, cooldown - delta)
        if remaining < 1e-8 then
            remaining = 0
        end
        if cooldown < 1e-8 then
            cooldown = 0
        end
        return {active = remaining > 0, expired = if __t(was) then remaining == 0 else was, remaining = remaining, cooldown = cooldown}
    end
    local function reset(self)
        remaining = 0
        cooldown = 0
    end
    local function bonuses(self, base)
        if base == nil then
            base = {}
        end
        local value = __assign({}, base)
        if remaining <= 0 then
            return value
        end
        local function numeric(____, key, fallback)
            return if __isFiniteN(__TS__Number(__get(base, key))) then __TS__Number(__get(base, key)) else fallback
        end
        return __assign(
            {},
            value,
            {
                maxHP = math.floor(numeric(nil, "maxHP", 100) * 1.35 + 0.5),
                maxGas = math.floor(numeric(nil, "maxGas", 100) * 1.35 + 0.5),
                damageMultiplier = numeric(nil, "damageMultiplier", 1) * 1.35,
                moveSpeed = numeric(nil, "moveSpeed", 280) * 1.22,
                dashCooldown = math.max(
                    0.24,
                    numeric(nil, "dashCooldown", 1.1) * 0.7
                ),
                gasRegen = numeric(nil, "gasRegen", 16) * 1.35,
                airGasRegen = numeric(nil, "airGasRegen", 6) * 1.35,
                bivoltActive = true
            }
        )
    end
    local function getStatus(self, q)
        local s = state(nil, q)
        local active = remaining > 0
        local ____assign_77 = __assign
        local ____temp_76 = {}
        local ____active_73 = active
        local ____remaining_74 = remaining
        local ____cooldown_75 = cooldown
        local ____t_72 = __t
        local ____t_70 = __t
        local ____temp_69 = if __t(s.unlocked) then s.charges > 0 else s.unlocked
        __O[1304] = ____temp_69
        local ____temp_71 = if ____t_70(____temp_69) then not __t(active) else __O[1304]
        __O[1305] = ____temp_71
        return ____assign_77(____temp_76, s, {
            active = ____active_73,
            remaining = ____remaining_74,
            cooldown = ____cooldown_75,
            duration = DURATION,
            cooldownDuration = COOLDOWN,
            ready = if ____t_72(____temp_71) then cooldown == 0 else __O[1305],
            remainingRatio = remaining / DURATION,
            cooldownRatio = cooldown / COOLDOWN,
            label = if __t(active) then ("BIVOLT " .. tostring(__call(remaining, "toFixed", 1))) .. "s" else if cooldown > 0 then ("BIVOLT " .. tostring(math.ceil(cooldown))) .. "s" else "BIVOLT ×" .. tostring(s.charges)
        })
    end
    local function iconSVG()
        return "<svg viewBox=\"0 0 32 36\" aria-hidden=\"true\"><path d=\"M10 4h12l2 4v23H8V8Z\" fill=\"currentColor\"/><path d=\"M11 3h10M11 33h10M11 10h10\" fill=\"none\" stroke=\"#273e36\" stroke-width=\"2\"/><path d=\"m18 12-7 9h5l-2 9 9-13h-6Z\" fill=\"#263c35\"/></svg>"
    end
    window.BivoltQuest = __ord({
        scene = SCENE,
        parts = parts,
        state = state,
        interact = interact,
        complete = complete,
        collect = collect,
        draw = draw
    }, "scene,parts,state,interact,complete,collect,draw")
    window.BivoltSkill = __ord({
        activate = activate,
        update = update,
        bonuses = bonuses,
        reset = reset,
        getStatus = getStatus,
        iconSVG = iconSVG,
        duration = DURATION,
        cooldownDuration = COOLDOWN
    }, "activate,update,bonuses,reset,getStatus,iconSVG,duration,cooldownDuration")
end)(nil)
return ____exports
