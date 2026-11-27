--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __isFiniteN, __ord, __arrL, __iterar, __t, __get, __set, __call, __new, __entries, __assign, __getters = __JSR.__isFiniteN, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__set, __JSR.__call, __JSR.__new, __JSR.__entries, __JSR.__assign, __JSR.__getters
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__Number = ____lualib.__TS__Number
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    local profiles = __ord(
        {
            igor = __ord(
                {
                    hp = 850,
                    level = 5,
                    damage = 1.35,
                    projectileSpeed = 1.15,
                    dashSpeed = 1.08,
                    windup = 1,
                    minWindup = 0.78,
                    recovery = __arrL({1.3, 1.18, 1.08}, 3),
                    armor = 0.28
                },
                "hp,level,damage,projectileSpeed,dashSpeed,windup,minWindup,recovery,armor"
            ),
            kaique = __ord(
                {
                    hp = 1100,
                    level = 6,
                    damage = 1.45,
                    projectileSpeed = 1.25,
                    dashSpeed = 1.12,
                    windup = 0.95,
                    minWindup = 0.74,
                    recovery = __arrL({1.32, 1.18, 1.08}, 3),
                    armor = 0.26
                },
                "hp,level,damage,projectileSpeed,dashSpeed,windup,minWindup,recovery,armor"
            ),
            arthur = __ord(
                {
                    hp = 950,
                    level = 5,
                    damage = 1.5,
                    projectileSpeed = 1.28,
                    dashSpeed = 1.12,
                    windup = 0.86,
                    minWindup = 0.7,
                    recovery = __arrL({1.02, 0.9, 0.84}, 3),
                    armor = 0.24
                },
                "hp,level,damage,projectileSpeed,dashSpeed,windup,minWindup,recovery,armor"
            ),
            dede = __ord(
                {
                    hp = 700,
                    level = 6,
                    damage = 1.55,
                    projectileSpeed = 1.33,
                    dashSpeed = 1.16,
                    windup = 0.84,
                    minWindup = 0.65,
                    recovery = __arrL({1, 0.9, 0.8}, 3),
                    armor = 0.23
                },
                "hp,level,damage,projectileSpeed,dashSpeed,windup,minWindup,recovery,armor"
            ),
            freddy = __ord(
                {
                    hp = 900,
                    level = 6,
                    damage = 1.65,
                    projectileSpeed = 1.35,
                    dashSpeed = 1.18,
                    windup = 0.81,
                    minWindup = 0.62,
                    recovery = __arrL({0.98, 0.86, 0.78}, 3),
                    armor = 0.22
                },
                "hp,level,damage,projectileSpeed,dashSpeed,windup,minWindup,recovery,armor"
            ),
            reeisBoss = __ord(
                {
                    hp = 1450,
                    level = 7,
                    damage = 1.7,
                    projectileSpeed = 1.36,
                    dashSpeed = 1.18,
                    windup = 0.8,
                    minWindup = 0.6,
                    recovery = __arrL({1, 0.88, 0.8}, 3),
                    armor = 0.22
                },
                "hp,level,damage,projectileSpeed,dashSpeed,windup,minWindup,recovery,armor"
            ),
            marco = __ord(
                {
                    hp = 2050,
                    level = 8,
                    damage = 1.85,
                    projectileSpeed = 1.46,
                    dashSpeed = 1.3,
                    windup = 0.76,
                    minWindup = 0.62,
                    recovery = __arrL({0.86, 0.72, 0.62}, 3),
                    armor = 0.2
                },
                "hp,level,damage,projectileSpeed,dashSpeed,windup,minWindup,recovery,armor"
            ),
            giant = __ord(
                {
                    hp = 2200,
                    level = 9,
                    damage = 1.8,
                    projectileSpeed = 1.3,
                    dashSpeed = 1.2,
                    windup = 0.8,
                    minWindup = 0.66,
                    recovery = __arrL({1.08, 0.96, 0.88}, 3),
                    armor = 0.21
                },
                "hp,level,damage,projectileSpeed,dashSpeed,windup,minWindup,recovery,armor"
            ),
            menezes = __ord(
                {
                    hp = 2350,
                    level = 12,
                    damage = 2.12,
                    projectileSpeed = 1.62,
                    dashSpeed = 1.39,
                    windup = 0.7,
                    minWindup = 0.6,
                    recovery = __arrL({0.8, 0.68, 0.58}, 3),
                    armor = 0.2
                },
                "hp,level,damage,projectileSpeed,dashSpeed,windup,minWindup,recovery,armor"
            ),
            nicolas = __ord(
                {
                    hp = 2000,
                    level = 9,
                    damage = 1.8,
                    projectileSpeed = 1.38,
                    dashSpeed = 1.18,
                    windup = 0.8,
                    minWindup = 0.62,
                    recovery = __arrL({1, 0.88, 0.8}, 3),
                    armor = 0.2
                },
                "hp,level,damage,projectileSpeed,dashSpeed,windup,minWindup,recovery,armor"
            ),
            nikolas = __ord(
                {
                    hp = 4100,
                    level = 13,
                    damage = 2.35,
                    projectileSpeed = 1.67,
                    dashSpeed = 1.42,
                    windup = 0.71,
                    minWindup = 0.62,
                    recovery = __arrL({0.84, 0.7, 0.6}, 3),
                    armor = 0.18
                },
                "hp,level,damage,projectileSpeed,dashSpeed,windup,minWindup,recovery,armor"
            )
        },
        "igor,kaique,arthur,dede,freddy,reeisBoss,marco,giant,menezes,nicolas,nikolas"
    )
    for ____, ____value in __iterar((__entries(profiles))) do
        local ____type = ____value[1]
        local p = ____value[2]
        if ____type ~= "giant" then
            p.phaseHP = __call(
                if ____type == "nikolas" then __arrL({1, 1.2, 1.4, 1.65}, 4) else __arrL({1, 1.25, 1.5}, 3),
                "map",
                function(____, multiplier) return math.floor(p.hp * multiplier + 0.5) end
            )
        end
        local ____ = p.recovery
        local ____ = p
    end
    local ____ = profiles
    local STORAGE_KEY = "daroca-difficulty-v1"
    local modes = __ord(
        {
            easy = __ord({
                id = "easy",
                label = "FÁCIL",
                hp = 0.68,
                windup = 1.22,
                recovery = 1.4,
                incomingDamage = 1,
                description = "Chefes com 32% menos vida e mais tempo para reagir e contra-atacar."
            }, "id,label,hp,windup,recovery,incomingDamage,description"),
            normal = __ord({
                id = "normal",
                label = "NORMAL",
                hp = 1,
                windup = 1,
                recovery = 1,
                incomingDamage = 1,
                description = "O desafio original da campanha, com seus padrões e atributos atuais."
            }, "id,label,hp,windup,recovery,incomingDamage,description"),
            hard = __ord({
                id = "hard",
                label = "DIFÍCIL",
                hp = 1,
                windup = 0.82,
                recovery = 0.72,
                incomingDamage = 2,
                description = "Chefes recuperam mais rápido, avisam por menos tempo e seus golpes tiram o dobro da sua vida."
            }, "id,label,hp,windup,recovery,incomingDamage,description")
        },
        "easy,normal,hard"
    )
    local mode = "normal"
    do
        pcall(function()
            local saved = window.localStorage:getItem(STORAGE_KEY)
            if __t(__call(modes, "hasOwnProperty", saved)) then
                mode = saved
            end
        end)
    end
    local scaled = {}
    for ____, ____value in __iterar((__entries(modes))) do
        local id = ____value[1]
        local settings = ____value[2]
        __set(scaled, id, {})
        for ____, ____value in __iterar((__entries(profiles))) do
            local ____type = ____value[1]
            local profile = ____value[2]
            __set(
                __get(scaled, id),
                ____type,
                if id == "normal" then profile else __ord(
                    __assign(
                        {},
                        profile,
                        {hp = math.floor(profile.hp * settings.hp + 0.5)},
                        if __t(profile.phaseHP) then {phaseHP = __call(
                            profile.phaseHP,
                            "map",
                            function(____, hp) return math.floor(hp * settings.hp + 0.5) end
                        )} else {},
                        {
                            windup = profile.windup * settings.windup,
                            minWindup = profile.minWindup * settings.windup,
                            recovery = __call(
                                profile.recovery,
                                "map",
                                function(____, seconds) return seconds * settings.recovery end
                            )
                        }
                    ),
                    "hp,windup,minWindup,recovery"
                )
            )
        end
        __get(scaled, id)
    end
    local ____ = scaled
    local function getMode(self)
        return mode
    end
    local function getSettings(self, selected)
        if selected == nil then
            selected = mode
        end
        local ____t_1 = __t
        local ____get_result_0 = __get(modes, selected)
        __O[1262] = ____get_result_0
        return if ____t_1(____get_result_0) then __O[1262] else modes.normal
    end
    local function setMode(self, next)
        local ____t_8 = __t
        local ____temp_7 = not __t(__call(modes, "hasOwnProperty", next))
        if not ____temp_7 then
            local ____opt_4 = window.CampaignRun
            if ____opt_4 ~= nil then
                ____opt_4 = ____opt_4.canSetMode
            end
            local ____opt_result_6
            if ____opt_4 ~= nil then
                ____opt_result_6 = ____opt_4(____opt_4, next)
            end
            ____temp_7 = ____opt_result_6 == false
        end
        if ____t_8(____temp_7) then
            return false
        end
        if next == mode then
            return true
        end
        local previous = mode
        mode = next
        do
            pcall(function()
                window.localStorage:setItem(STORAGE_KEY, mode)
            end)
        end
        do
            pcall(function()
                window:dispatchEvent(__new(
                    "CustomEvent",
                    "difficulty-change",
                    {detail = {
                        mode = mode,
                        previous = previous,
                        settings = getSettings(nil)
                    }}
                ))
            end)
        end
        return true
    end
    local function boss(self, ____type, selected)
        if selected == nil then
            selected = mode
        end
        local ____t_13 = __t
        local ____get_11 = __get
        local ____t_10 = __t
        local ____get_result_9 = __get(scaled, selected)
        __O[1263] = ____get_result_9
        local ____get_11_result_12 = ____get_11(if ____t_10(____get_result_9) then __O[1263] else scaled.normal, ____type)
        __O[1264] = ____get_11_result_12
        return if ____t_13(____get_11_result_12) then __O[1264] else nil
    end
    local function scaleIncomingDamage(self, damage, selected)
        if selected == nil then
            selected = mode
        end
        local value = __TS__Number(damage)
        return if __isFiniteN(value) then math.max(0, value) * getSettings(nil, selected).incomingDamage else 0
    end
    window.Difficulty = __ord(
        __getters(
            {
                version = "3.9.0",
                getMode = getMode,
                getSettings = getSettings,
                setMode = setMode,
                isLocked = function()
                    local ____t_19 = __t
                    local ____opt_16 = window.CampaignRun
                    if ____opt_16 ~= nil then
                        ____opt_16 = ____opt_16.isEasyLocked
                    end
                    local ____opt_result_18
                    if ____opt_16 ~= nil then
                        ____opt_result_18 = ____opt_16(____opt_16)
                    end
                    return not not ____t_19(____opt_result_18)
                end,
                scaleIncomingDamage = scaleIncomingDamage,
                boss = boss,
                modes = modes,
                profiles = profiles
            },
            {
                id = function()
                    return mode
                end,
                label = function()
                    return getSettings(nil).label
                end
            }
        ),
        "id,label,version,getMode,getSettings,setMode,isLocked,scaleIncomingDamage,boss,modes,profiles"
    )
end)(nil)
return ____exports
