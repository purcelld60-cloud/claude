--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __le, __ge, __isFiniteN, __callq, __ord, __arrL, __iterar, __t, __get, __set, __arr, __len = __JSR.__le, __JSR.__ge, __JSR.__isFiniteN, __JSR.__callq, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__set, __JSR.__arr, __JSR.__len
local __call, __add, __iter, __keys, __assign = __JSR.__call, __JSR.__add, __JSR.__iter, __JSR.__keys, __JSR.__assign
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__Number = ____lualib.__TS__Number
local __TS__Spread = ____lualib.__TS__Spread
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    local function clamp(____, v, a, b)
        return math.max(
            a,
            math.min(b, v)
        )
    end
    local profile = __ord(
        {
            daroca = __ord(
                {
                    physical = __arrL({10, 0.35, 72, "elbow"}, 4),
                    ranged = __arrL({
                        11,
                        0.7,
                        "paper",
                        490,
                        "straight"
                    }, 5),
                    combo = "gascombo"
                },
                "physical,ranged,combo"
            ),
            reeis = __ord(
                {
                    physical = __arrL({11, 0.39, 70, "gunbutt"}, 4),
                    ranged = __arrL({
                        11,
                        0.72,
                        "bullet",
                        610,
                        "straight"
                    }, 5),
                    combo = "army"
                },
                "physical,ranged,combo"
            ),
            nikolas = __ord(
                {
                    physical = __arrL({11, 0.39, 70, "nosepunch"}, 4),
                    ranged = __arrL({
                        9,
                        0.68,
                        "goo",
                        390,
                        "arc"
                    }, 5),
                    combo = "muscle"
                },
                "physical,ranged,combo"
            ),
            marco = __ord(
                {
                    physical = __arrL({10, 0.35, 73, "ruler"}, 4),
                    ranged = __arrL({
                        11,
                        0.73,
                        "brainrot",
                        355,
                        "arc"
                    }, 5),
                    combo = "sketch"
                },
                "physical,ranged,combo"
            ),
            menezes = __ord(
                {
                    physical = __arrL({9, 0.315, 64, "claw"}, 4),
                    ranged = __arrL({
                        11,
                        0.74,
                        "words",
                        420,
                        "straight"
                    }, 5),
                    combo = "sewer"
                },
                "physical,ranged,combo"
            ),
            ollyan = __ord(
                {
                    physical = __arrL({10, 0.35, 73, "ear"}, 4),
                    ranged = __arrL({
                        10,
                        0.66,
                        "wind",
                        550,
                        "straight"
                    }, 5),
                    combo = "earspin"
                },
                "physical,ranged,combo"
            ),
            igor = __ord(
                {
                    physical = __arrL({12, 0.42, 68, "punch"}, 4),
                    ranged = __arrL({
                        12,
                        0.8,
                        "bellywave",
                        355,
                        "wave"
                    }, 5),
                    combo = "bellybounce"
                },
                "physical,ranged,combo"
            ),
            kaique = __ord(
                {
                    physical = __arrL({11, 0.39, 70, "stock"}, 4),
                    ranged = __arrL({
                        11,
                        0.72,
                        "bullet",
                        610,
                        "straight"
                    }, 5),
                    combo = "inspection"
                },
                "physical,ranged,combo"
            ),
            freddy = __ord(
                {
                    physical = __arrL({10, 0.35, 72, "capoeira"}, 4),
                    ranged = __arrL({
                        11,
                        0.73,
                        "stone",
                        470,
                        "arc"
                    }, 5),
                    combo = "freddyspin"
                },
                "physical,ranged,combo"
            ),
            dede = __ord(
                {
                    physical = __arrL({10, 0.35, 70, "smokepalm"}, 4),
                    ranged = __arrL({
                        9,
                        0.68,
                        "smoke",
                        375,
                        "straight"
                    }, 5),
                    combo = "smokelift"
                },
                "physical,ranged,combo"
            ),
            arthur = __ord(
                {
                    physical = __arrL({10, 0.35, 72, "slap"}, 4),
                    ranged = __arrL({
                        11,
                        0.73,
                        "palm",
                        450,
                        "straight"
                    }, 5),
                    combo = "slapcombo"
                },
                "physical,ranged,combo"
            ),
            nicolas = __ord(
                {
                    physical = __arrL({10, 0.35, 72, "divinepunch"}, 4),
                    ranged = __arrL({
                        11,
                        0.72,
                        "light",
                        505,
                        "straight"
                    }, 5),
                    combo = "divine"
                },
                "physical,ranged,combo"
            ),
            giant = __ord(
                {
                    physical = __arrL({12, 0.42, 68, "stonefist"}, 4),
                    ranged = __arrL({
                        12,
                        0.8,
                        "six",
                        370,
                        "arc"
                    }, 5),
                    combo = "sixtyseven"
                },
                "physical,ranged,combo"
            ),
            caleb = __ord(
                {
                    physical = __arrL({11, 0.39, 71, "dumbbell"}, 4),
                    ranged = __arrL({
                        12,
                        0.8,
                        "weight",
                        430,
                        "arc"
                    }, 5),
                    combo = "stomp"
                },
                "physical,ranged,combo"
            ),
            lucas = __ord(
                {
                    physical = __arrL({9, 0.32, 61, "lowblow"}, 4),
                    ranged = __arrL({
                        8,
                        0.56,
                        "tongue",
                        520,
                        "tether"
                    }, 5),
                    combo = "frogcombo"
                },
                "physical,ranged,combo"
            ),
            kaua = __ord(
                {
                    physical = __arrL({10, 0.35, 73, "rulertool"}, 4),
                    ranged = __arrL({
                        11,
                        0.72,
                        "pen",
                        520,
                        "straight"
                    }, 5),
                    combo = "schoolarsenal"
                },
                "physical,ranged,combo"
            ),
            mota = __ord(
                {
                    physical = __arrL({10, 0.35, 71, "footballkick"}, 4),
                    ranged = __arrL({
                        11,
                        0.76,
                        "ball",
                        465,
                        "return"
                    }, 5),
                    combo = "juggle"
                },
                "physical,ranged,combo"
            ),
            ravid = __ord(
                {
                    physical = __arrL({10, 0.35, 72, "point"}, 4),
                    ranged = __arrL({
                        11,
                        0.74,
                        "monologue",
                        405,
                        "straight"
                    }, 5),
                    combo = "wallrant"
                },
                "physical,ranged,combo"
            ),
            almiro = __ord(
                {
                    physical = __arrL({10, 0.35, 72, "teacherpalm"}, 4),
                    ranged = __arrL({
                        11,
                        0.72,
                        "chalk",
                        510,
                        "straight"
                    }, 5),
                    combo = "baldflash"
                },
                "physical,ranged,combo"
            ),
            miqueias = __ord(
                {
                    physical = __arrL({10, 0.35, 73, "teacheruler"}, 4),
                    ranged = __arrL({
                        11,
                        0.74,
                        "english",
                        420,
                        "straight"
                    }, 5),
                    combo = "englishcombo"
                },
                "physical,ranged,combo"
            ),
            davi = __ord(
                {
                    physical = __arrL({10, 0.35, 72, "clipper"}, 4),
                    ranged = __arrL({
                        10,
                        0.69,
                        "comb",
                        475,
                        "return"
                    }, 5),
                    combo = "barberchair"
                },
                "physical,ranged,combo"
            ),
            vitor = __ord(
                {
                    physical = __arrL({9, 0.32, 75, "towel"}, 4),
                    ranged = __arrL({
                        10,
                        0.69,
                        "brush",
                        475,
                        "return"
                    }, 5),
                    combo = "towelspin"
                },
                "physical,ranged,combo"
            ),
            allef = __ord(
                {
                    physical = __arrL({11, 0.39, 70, "receiptslap"}, 4),
                    ranged = __arrL({
                        11,
                        0.74,
                        "ticket",
                        435,
                        "straight"
                    }, 5),
                    combo = "queue"
                },
                "physical,ranged,combo"
            ),
            aica = __ord(
                {
                    physical = __arrL({10, 0.35, 72, "heelkick"}, 4),
                    ranged = __arrL({
                        10,
                        0.7,
                        "heel",
                        475,
                        "return"
                    }, 5),
                    combo = "girlknee"
                },
                "physical,ranged,combo"
            ),
            ravile = __ord(
                {
                    physical = __arrL({10, 0.35, 72, "roundkick"}, 4),
                    ranged = __arrL({
                        10,
                        0.7,
                        "heel",
                        475,
                        "return"
                    }, 5),
                    combo = "girlknee"
                },
                "physical,ranged,combo"
            ),
            eloisa = __ord(
                {
                    physical = __arrL({10, 0.35, 72, "highkick"}, 4),
                    ranged = __arrL({
                        10,
                        0.7,
                        "heel",
                        475,
                        "return"
                    }, 5),
                    combo = "girlknee"
                },
                "physical,ranged,combo"
            ),
            giselle = __ord(
                {
                    physical = __arrL({10, 0.35, 72, "spinkick"}, 4),
                    ranged = __arrL({
                        10,
                        0.7,
                        "heel",
                        475,
                        "return"
                    }, 5),
                    combo = "girlknee"
                },
                "physical,ranged,combo"
            ),
            rayssa = __ord(
                {
                    physical = __arrL({10, 0.35, 72, "sidekick"}, 4),
                    ranged = __arrL({
                        10,
                        0.7,
                        "heel",
                        475,
                        "return"
                    }, 5),
                    combo = "girlknee"
                },
                "physical,ranged,combo"
            ),
            analaura = __ord(
                {
                    physical = __arrL({10, 0.35, 72, "backkick"}, 4),
                    ranged = __arrL({
                        10,
                        0.7,
                        "heel",
                        475,
                        "return"
                    }, 5),
                    combo = "girlknee"
                },
                "physical,ranged,combo"
            )
        },
        "daroca,reeis,nikolas,marco,menezes,ollyan,igor,kaique,freddy,dede,arthur,nicolas,giant,caleb,lucas,kaua,mota,ravid,almiro,miqueias,davi,vitor,allef,aica,ravile,eloisa,giselle,rayssa,analaura"
    )
    local directions = __arrL({"neutral", "side", "up", "down"}, 4)
    local directionAngle = __ord({neutral = -0.12, side = -0.12, up = -math.pi / 2, down = math.pi / 2}, "neutral,side,up,down")
    local dirNames = __ord({neutral = "", side = " · lateral", up = " · alto", down = " · baixo"}, "neutral,side,up,down")
    local function identity(self, id)
        local ____t_1 = __t
        local ____callq_result_0 = __callq(window.ArenaRoster, "get", id)
        __O[2490] = ____callq_result_0
        return if ____t_1(____callq_result_0) then __O[2490] else {
            id = "daroca",
            physical = "Cotovelada do chapéu",
            ranged = "Papel propulsor",
            combo = "Trinca do feijão",
            color = "#e8a35d",
            quote = "Bora pra resenha!"
        }
    end
    local function base(self, id, kind, direction)
        local k = identity(nil, id)
        id = if __t(__call(profile, "hasOwnProperty", id)) then id else "daroca"
        direction = if __t(__call(directions, "includes", direction)) then direction else "neutral"
        return {
            id = __add(
                __add(
                    __add(
                        __add(id, "."),
                        kind
                    ),
                    "."
                ),
                direction
            ),
            name = __add(
                if kind == "physical" then k.physical else if kind == "ranged" then k.ranged else k.combo,
                __get(dirNames, direction)
            ),
            character = id,
            kind = kind,
            direction = direction,
            damage = 0,
            knockback = 220,
            angle = __get(directionAngle, direction),
            reach = 72,
            radius = 23,
            windup = 0.085,
            duration = 0.13,
            recovery = 0.18,
            cooldown = 0.35,
            color = k.color,
            shape = "punch",
            effects = __arrL({}, 0),
            text = "",
            sound = ""
        }
    end
    local function physical(self, id, dir, options)
        local ____t_3 = __t
        local ____get_result_2 = __get(profile, id)
        __O[2491] = ____get_result_2
        local def = if ____t_3(____get_result_2) then __O[2491] else profile.daroca
        local p = def.physical
        local d = base(nil, id, "physical", dir)
        d.damage = __get(p, 0)
        d.cooldown = __get(p, 1)
        d.reach = __get(p, 2)
        d.shape = __get(p, 3)
        d.knockback = 210 + (__get(p, 0) - 9) * 18
        d.windup = if __ge(
            __get(p, 0),
            12
        ) then 0.12 else if __get(p, 0) == 11 then 0.1 else 0.075
        d.recovery = d.cooldown - d.windup - d.duration
        d.effects = __arrL({d.shape}, 1)
        if dir == "side" then
            d.reach = d.reach + 7
            d.windup = d.windup + 0.025
            d.recovery = math.max(0.07, d.recovery - 0.025)
            d.knockback = d.knockback + 18
        end
        if dir == "up" then
            d.reach = d.reach - 5
            d.radius = 26
            d.knockback = d.knockback + 12
            d.shape = __add(
                __get(p, 3),
                "-upper"
            )
        end
        if dir == "down" then
            d.reach = d.reach - 2
            d.radius = 26
            d.shape = __add(
                __get(p, 3),
                "-low"
            )
        end
        if id == "menezes" then
            d.effects = __arrL({"claws", if dir == "up" then "scratch-up" else "scratch"}, 2)
            d.radius = 21
        end
        if id == "lucas" then
            d.angle = if dir == "up" then -1.4 else if dir == "down" then 1.15 else -0.06
            d.radius = 20
            d.effects = __arrL({"lowblow", "frog-star"}, 2)
        end
        if id == "mota" then
            d.effects = __arrL({"football-touch"}, 1)
            d.self = {vx = if dir == "side" then 56 else 0}
        end
        if __t(__call(
            __arrL({
                "aica",
                "ravile",
                "eloisa",
                "giselle",
                "rayssa",
                "analaura"
            }, 6),
            "includes",
            id
        )) then
            d.effects = __arrL({"heel-slash", "deboche"}, 2)
            d.sound = "heel"
        end
        if __t(id == "caleb" and dir == "down") then
            d.name = "Pisada do leg day"
            d.shape = "stomp"
            d.damage = 8
            d.reach = 62
            d.knockback = 235
            d.cooldown = 0.5
            d.windup = 0.14
            d.duration = 0.16
            d.recovery = 0.2
            d.projectile = {
                type = "shockwave",
                motion = "wave",
                speed = 370,
                damage = 6,
                life = 1.15,
                radius = 14,
                count = 1,
                spread = 0
            }
            d.effects = __arrL({"ground-crack", "weight"}, 2)
        end
        if __t(id == "ollyan" and dir == "up") then
            d.effects = __arrL({"ear-fan", "wind"}, 2)
        end
        if __t(id == "igor" and dir == "down") then
            d.shape = "belly-stomp"
            d.effects = __arrL({"belly-ring"}, 1)
        end
        if id == "arthur" then
            d.sound = "slap"
        end
        return d
    end
    local function ranged(self, id, dir, options)
        local ____t_5 = __t
        local ____get_result_4 = __get(profile, id)
        __O[2492] = ____get_result_4
        local def = if ____t_5(____get_result_4) then __O[2492] else profile.daroca
        local p = def.ranged
        local d = base(nil, id, "ranged", dir)
        d.damage = __get(p, 0)
        d.cooldown = __get(p, 1)
        d.reach = 0
        d.radius = 10
        d.windup = 0.13
        d.duration = 0.16
        d.recovery = math.max(0.15, d.cooldown - 0.29)
        d.knockback = 185
        d.shape = __get(p, 2)
        d.angle = if dir == "up" then -1.28 else if dir == "down" then 1.16 else 0
        d.projectile = {
            type = __get(p, 2),
            motion = __get(p, 4),
            speed = __get(p, 3),
            gravity = if __get(p, 4) == "arc" then 250 else 0,
            life = if __get(p, 4) == "tether" then 0.5 else 1.5,
            count = 1,
            spread = 0,
            radius = d.radius,
            damage = d.damage,
            boomerang = __get(p, 4) == "return",
            maxHits = 1
        }
        local ____t_8 = __t
        local ____t_7 = __t
        local ____temp_6 = __get(p, 4) == "arc" and dir ~= "up"
        __O[2493] = ____temp_6
        if ____t_8(if ____t_7(____temp_6) then dir ~= "down" else __O[2493]) then
            d.angle = -0.22
        end
        if __get(p, 4) == "return" then
            d.boomerang = true
            d.projectile.returnAfter = 0.48
            d.projectile.life = 2
            d.effects = __arrL({"return-trail"}, 1)
        end
        if id == "lucas" then
            local ____d_projectile_9 = d.projectile
            d.slow = 1.35
            ____d_projectile_9.slow = 1.35
            local ____d_projectile_10 = d.projectile
            d.slowFactor = 0.7
            ____d_projectile_10.slowFactor = 0.7
            d.projectile.life = 0.5
            d.projectile.radius = 11
            d.effects = __arrL({"tongue-tether"}, 1)
            d.knockback = 135
        end
        if id == "nikolas" then
            local ____d_projectile_11 = d.projectile
            d.slow = 0.85
            ____d_projectile_11.slow = 0.85
            local ____d_projectile_12 = d.projectile
            d.slowFactor = 0.78
            ____d_projectile_12.slowFactor = 0.78
            d.projectile.gravity = 200
            d.effects = __arrL({"nose-charge", "slime"}, 2)
        end
        if id == "dede" then
            local ____d_projectile_13 = d.projectile
            d.slow = 0.9
            ____d_projectile_13.slow = 0.9
            local ____d_projectile_14 = d.projectile
            d.slowFactor = 0.76
            ____d_projectile_14.slowFactor = 0.76
            d.effects = __arrL({"smoke-ring"}, 1)
            d.projectile.radius = 13
        end
        if id == "marco" then
            d.projectile.gravity = 110
            d.projectile.life = 1.7
            d.effects = __arrL({"draw-spawn", "brainrot"}, 2)
            d.projectile.variant = __get(
                __arrL({"ink", "spindle", "pasta", "brainrot"}, 4),
                __call(directions, "indexOf", dir)
            )
        end
        if id == "mota" then
            local ____d_projectile_15 = d.projectile
            d.returnGain = 8
            ____d_projectile_15.returnGain = 8
            d.projectile.returnAfter = if dir == "up" then 0.62 else 0.48
            d.projectile.gravity = if dir == "up" then 380 else if dir == "down" then 340 else 175
            d.angle = if dir == "up" then -1.1 else if dir == "down" then 1.16 else if dir == "side" then -0.08 else -0.32
            d.effects = __arrL({"football-launch", "aura-catch"}, 2)
        end
        if id == "igor" then
            d.projectile.radius = 17
            d.projectile.life = 1.65
            d.effects = __arrL({"belly-wave"}, 1)
            d.knockback = 205
        end
        if id == "caleb" then
            d.projectile.radius = 12
            d.projectile.gravity = 320
            d.angle = if dir == "up" then -1.22 else if dir == "down" then 1.18 else -0.28
            d.effects = __arrL({"weight-spin"}, 1)
            d.knockback = 210
        end
        if __t(id == "reeis" or id == "kaique") then
            d.effects = __arrL({"muzzle", "short-burst"}, 2)
            d.projectile.visualCount = 3
            d.projectile.radius = 7
            d.sound = "shot"
        end
        if id == "ravid" then
            d.text = "Ó PRA RAVID FALANDO SOZINHO"
            d.projectile.text = if dir == "up" then "MAS VEJA BEM" else if dir == "down" then "EU DISSE" else "FALANDO SOZINHO"
            d.projectile.radius = 12
        end
        if id == "menezes" then
            d.text = "DA ROÇA PEGOU AR"
            d.projectile.text = __get(
                __arrL({"POUDIAAAM", "TEKETEKE", "PEGOU AR", "RATO POUDI"}, 4),
                __call(directions, "indexOf", dir)
            )
            d.projectile.radius = 12
        end
        if id == "miqueias" then
            d.text = "ALLRIGHT!"
            d.projectile.text = __get(
                __arrL({"ALLRIGHT!", "É OU NÃO É", "BELEZA CREUZA", "YOU IS ERRADO"}, 4),
                __call(directions, "indexOf", dir)
            )
            d.projectile.radius = 12
        end
        if id == "allef" then
            d.projectile.text = __add(
                "SENHA ",
                __call(directions, "indexOf", dir) + 1
            )
            d.effects = __arrL({"queue-ticket"}, 1)
        end
        if __t(__call(
            __arrL({
                "aica",
                "ravile",
                "eloisa",
                "giselle",
                "rayssa",
                "analaura"
            }, 6),
            "includes",
            id
        )) then
            d.effects = __arrL({"heel-spin", "deboche"}, 2)
            d.projectile.radius = 11
            d.projectile.gravity = if dir == "up" then 110 else 0
            d.projectile.variant = id
        end
        return d
    end
    local function hit(____, delay, damage, knockback, angle, shape, extra)
        if extra == nil then
            extra = {}
        end
        return __assign({}, {
            delay = delay,
            damage = damage,
            knockback = knockback,
            angle = angle,
            dx = 54,
            dy = -35,
            radius = 35,
            shape = shape
        }, extra)
    end
    local function combo(self, id, dir, options)
        local ____t_17 = __t
        local ____get_result_16 = __get(profile, id)
        __O[2494] = ____get_result_16
        local def = if ____t_17(____get_result_16) then __O[2494] else profile.daroca
        local d = base(nil, id, "combo", dir)
        d.damage = 32
        d.knockback = 745
        d.reach = 91
        d.radius = 31
        d.windup = 0.12
        d.duration = 0.96
        d.recovery = 0.35
        d.cooldown = 3.25
        d.shape = def.combo
        d.requiresHits = 3
        d.effects = __arrL({def.combo}, 1)
        local hits = __arrL(
            {
                hit(
                    nil,
                    0,
                    8,
                    120,
                    -0.08,
                    __get(def.physical, 3)
                ),
                hit(
                    nil,
                    0.28,
                    9,
                    145,
                    -0.18,
                    __get(def.physical, 3)
                ),
                hit(
                    nil,
                    0.58,
                    15,
                    745,
                    -0.4,
                    def.combo
                )
            },
            3
        )
        local f = {hits = hits, grab = 0, sound = "", summon = ""}
        repeat
            local ____switch36 = def.combo
            local ____cond36 = ____switch36 == "gascombo"
            if ____cond36 then
                __get(hits, 2).shape = "gas-burst"
                __get(hits, 2).radius = 47
                f.sound = "fart"
                d.effects = __arrL({"elbow", "knee", "gas-burst"}, 3)
                break
            end
            ____cond36 = ____cond36 or ____switch36 == "army"
            if ____cond36 then
                f.hits = __arrL(
                    {
                        hit(
                            nil,
                            0,
                            6,
                            70,
                            -0.05,
                            "gunbutt"
                        ),
                        hit(
                            nil,
                            0.24,
                            6,
                            80,
                            -0.05,
                            "army-left"
                        ),
                        hit(
                            nil,
                            0.48,
                            6,
                            100,
                            -0.13,
                            "army-right"
                        ),
                        hit(
                            nil,
                            0.76,
                            14,
                            750,
                            -0.37,
                            "army-launch"
                        )
                    },
                    4
                )
                f.summon = "army"
                f.grab = 0.22
                d.transform = 1.1
                d.form = "reeis"
                d.duration = 1.08
                d.effects = __arrL({"crime-army", "muzzle-flash"}, 2)
                d.text = "OHHHH REEEEIS!"
                break
            end
            ____cond36 = ____cond36 or ____switch36 == "muscle"
            if ____cond36 then
                d.transform = 1.15
                d.form = "nikolasMuscle"
                __get(hits, 0).shape = "nose-rub"
                __get(hits, 1).shape = "muscle-punch"
                __get(hits, 2).shape = "slime-smash"
                d.text = "É MEU BOLO!"
                break
            end
            ____cond36 = ____cond36 or ____switch36 == "sketch"
            if ____cond36 then
                f.summon = "drawings"
                d.transform = 1.1
                d.form = "marcoRage"
                __get(hits, 0).shape = "sketch-cage"
                __get(hits, 1).shape = "brainrot-stomp"
                __get(hits, 2).shape = "sixseven-launch"
                d.effects = __arrL({"red-aura", "brainrot", "sixseven"}, 3)
                d.text = "SARUÊ É TU!"
                break
            end
            ____cond36 = ____cond36 or ____switch36 == "sewer"
            if ____cond36 then
                f.grab = 0.16
                __set(
                    hits,
                    0,
                    __assign(
                        {},
                        hit(
                            nil,
                            0,
                            8,
                            325,
                            -0.03,
                            "claw-push"
                        ),
                        {dx = 56}
                    )
                )
                __set(
                    hits,
                    1,
                    __assign(
                        {},
                        hit(
                            nil,
                            0.28,
                            8,
                            125,
                            -0.05,
                            "sewer-emerge"
                        ),
                        {warp = "target", dx = 40, radius = 41}
                    )
                )
                __set(
                    hits,
                    2,
                    __assign(
                        {},
                        hit(
                            nil,
                            0.58,
                            16,
                            765,
                            -0.32,
                            "rat-launch"
                        ),
                        {dx = 48, radius = 42}
                    )
                )
                d.effects = __arrL({"sewer", "claws", "rat-trail"}, 3)
                d.text = "PEGOU AR NO ESGOTO!"
                break
            end
            ____cond36 = ____cond36 or ____switch36 == "earspin"
            if ____cond36 then
                __get(hits, 0).shape = "ear-vacuum"
                __get(hits, 1).shape = "ear-spin"
                __get(hits, 2).shape = "wind-launch"
                __get(hits, 2).angle = -1
                d.effects = __arrL({"ear-fan", "wind-ring"}, 2)
                break
            end
            ____cond36 = ____cond36 or ____switch36 == "bellybounce"
            if ____cond36 then
                f.grab = 0.22
                __set(
                    hits,
                    0,
                    hit(
                        nil,
                        0,
                        7,
                        85,
                        -0.08,
                        "punch-grab"
                    )
                )
                __set(
                    hits,
                    1,
                    hit(
                        nil,
                        0.28,
                        9,
                        105,
                        -0.05,
                        "belly-rebound",
                        {dx = 28, radius = 48}
                    )
                )
                __set(
                    hits,
                    2,
                    hit(
                        nil,
                        0.58,
                        16,
                        780,
                        -0.42,
                        "belly-launch",
                        {dx = 37, radius = 47}
                    )
                )
                d.effects = __arrL({"blue-belly", "rebound-stars"}, 2)
                d.text = "SEM LANCHE? REBATE AÍ!"
                break
            end
            ____cond36 = ____cond36 or ____switch36 == "inspection"
            if ____cond36 then
                __get(hits, 0).shape = "stock"
                __get(hits, 1).shape = "confiscate"
                __get(hits, 2).shape = "iraci-stamp"
                d.text = "IRACI! VOLTA PRA SALA!"
                d.effects = __arrL({"monitor-badge", "paper-scatter"}, 2)
                break
            end
            ____cond36 = ____cond36 or ____switch36 == "freddyspin"
            if ____cond36 then
                __get(hits, 0).shape = "capoeira-elbow"
                __get(hits, 1).shape = "capoeira-kick"
                __get(hits, 2).shape = "capoeira-spin"
                d.effects = __arrL({"foot-arc", "opeesty"}, 2)
                d.text = "OPEESTY DA ROÇA!"
                break
            end
            ____cond36 = ____cond36 or ____switch36 == "smokelift"
            if ____cond36 then
                __get(hits, 0).shape = "smoke-grab"
                __get(hits, 1).shape = "braces-flash"
                __get(hits, 2).shape = "smoke-launch"
                __get(hits, 2).angle = -0.7
                d.effects = __arrL({"smoke-pillar", "braces-spark"}, 2)
                d.text = "SEU GILÓ HOMI!"
                break
            end
            ____cond36 = ____cond36 or ____switch36 == "slapcombo"
            if ____cond36 then
                __get(hits, 0).shape = "slap-left"
                __get(hits, 1).shape = "slap-right"
                __get(hits, 2).shape = "giant-palm"
                f.sound = "slap"
                d.effects = __arrL({"palm-print", "slap-ring"}, 2)
                d.text = "BESTAIADO É TU!"
                break
            end
            ____cond36 = ____cond36 or ____switch36 == "divine"
            if ____cond36 then
                d.transform = 1.1
                d.form = "nicolasAura"
                __get(hits, 0).shape = "divine-pose"
                __get(hits, 1).shape = "aura-upper"
                __get(hits, 2).shape = "protagonist-fall"
                d.effects = __arrL({"gold-aura", "stage-light"}, 2)
                d.text = "ESSA CENA É MINHA!"
                break
            end
            ____cond36 = ____cond36 or ____switch36 == "sixtyseven"
            if ____cond36 then
                f.hits = __arrL(
                    {
                        hit(
                            nil,
                            0,
                            12,
                            140,
                            -0.1,
                            "six-fist",
                            {radius = 38}
                        ),
                        hit(
                            nil,
                            0.36,
                            20,
                            770,
                            -0.45,
                            "seven-smash",
                            {radius = 43}
                        )
                    },
                    2
                )
                d.duration = 0.8
                d.effects = __arrL({"six", "seven", "ink-impact"}, 3)
                d.text = "SIX... SEVEN!"
                break
            end
            ____cond36 = ____cond36 or ____switch36 == "stomp"
            if ____cond36 then
                __get(hits, 0).shape = "dumbbell-hook"
                __get(hits, 1).shape = "supino-upper"
                __get(hits, 2).shape = "stomp-wave"
                __get(hits, 2).radius = 48
                __get(hits, 2).knockback = 765
                d.effects = __arrL({"weight", "ground-crack", "shockwave"}, 3)
                d.text = "HOJE TEM LEG DAY!"
                break
            end
            ____cond36 = ____cond36 or ____switch36 == "frogcombo"
            if ____cond36 then
                f.hits = __arrL(
                    {
                        hit(
                            nil,
                            0,
                            9,
                            100,
                            -0.06,
                            "lowblow",
                            {dx = 43, dy = -19, radius = 26}
                        ),
                        hit(
                            nil,
                            0.28,
                            8,
                            125,
                            -0.2,
                            "tongue-wrap",
                            {dx = 52, radius = 30}
                        ),
                        hit(
                            nil,
                            0.58,
                            15,
                            735,
                            -0.6,
                            "frog-upper",
                            {dx = 48, dy = -33, radius = 34}
                        )
                    },
                    3
                )
                f.grab = 0.18
                d.effects = __arrL({"frog-hop", "cake-star"}, 2)
                d.text = "MEU ALCANCE É NA HUMILDADE!"
                break
            end
            ____cond36 = ____cond36 or ____switch36 == "schoolarsenal"
            if ____cond36 then
                __get(hits, 0).shape = "ruler-cross"
                __get(hits, 1).shape = "eraser-hammer"
                __get(hits, 2).shape = "pencil-case-cannon"
                d.effects = __arrL({"school-parts", "pencil-fan"}, 2)
                d.text = "UMMHUMHUMM!"
                break
            end
            ____cond36 = ____cond36 or ____switch36 == "juggle"
            if ____cond36 then
                __get(hits, 0).shape = "football-lift"
                __get(hits, 1).shape = "football-juggle"
                __get(hits, 2).shape = "football-bicycle"
                __get(hits, 2).angle = -0.55
                d.returnGain = 10
                d.effects = __arrL({"football-trail", "aura-stars"}, 2)
                d.text = "DOMINOU! GOLAÇO!"
                break
            end
            ____cond36 = ____cond36 or ____switch36 == "wallrant"
            if ____cond36 then
                f.grab = 0.2
                __get(hits, 0).shape = "wall-point"
                __get(hits, 1).shape = "monologue-wall"
                __get(hits, 2).shape = "wall-launch"
                d.effects = __arrL({"conversation-wall", "word-rain"}, 2)
                d.text = "EU NEM TAVA FALANDO CONTIGO!"
                break
            end
            ____cond36 = ____cond36 or ____switch36 == "baldflash"
            if ____cond36 then
                __get(hits, 0).shape = "teacher-palm"
                __get(hits, 1).shape = "bald-reflect"
                __get(hits, 2).shape = "bald-flash"
                d.effects = __arrL({"careca-glint", "chalk-burst"}, 2)
                d.text = "AHAHAHA DA ROÇA!"
                break
            end
            ____cond36 = ____cond36 or ____switch36 == "englishcombo"
            if ____cond36 then
                __get(hits, 0).shape = "ruler"
                __get(hits, 1).shape = "beard-brush"
                __get(hits, 2).shape = "english-launch"
                d.effects = __arrL({"english-words", "creuza-star"}, 2)
                d.text = "YOU IS VOANDO, BEAUTIFUL!"
                break
            end
            ____cond36 = ____cond36 or ____switch36 == "barberchair"
            if ____cond36 then
                f.grab = 0.2
                __get(hits, 0).shape = "clipper"
                __get(hits, 1).shape = "barber-chair"
                __get(hits, 2).shape = "barber-spin"
                d.effects = __arrL({"chair-spin", "comb-ring"}, 2)
                d.text = "DEGRADÊ NA TUA MARRA!"
                break
            end
            ____cond36 = ____cond36 or ____switch36 == "towelspin"
            if ____cond36 then
                __get(hits, 0).shape = "towel-snap"
                __get(hits, 1).shape = "brush-spin"
                __get(hits, 2).shape = "towel-launch"
                d.effects = __arrL({"towel-arc", "brush-ring"}, 2)
                d.text = "ACABAMENTO EXPRESSO!"
                break
            end
            ____cond36 = ____cond36 or ____switch36 == "queue"
            if ____cond36 then
                __get(hits, 0).shape = "receipt-slap"
                __get(hits, 1).shape = "queue-bell"
                __get(hits, 2).shape = "reception-launch"
                d.effects = __arrL({"queue-ticket", "bell-stars"}, 2)
                d.text = "A FILA ANDOU!"
                break
            end
            ____cond36 = ____cond36 or ____switch36 == "girlknee"
            if ____cond36 then
                f.hits = __arrL(
                    {
                        hit(
                            nil,
                            0,
                            9,
                            105,
                            -0.1,
                            __get(def.physical, 3)
                        ),
                        hit(
                            nil,
                            0.28,
                            8,
                            115,
                            -0.12,
                            "heel-feint"
                        ),
                        hit(
                            nil,
                            0.58,
                            15,
                            755,
                            -0.7,
                            "deboche-knee",
                            {dx = 47, dy = -40, radius = 36}
                        )
                    },
                    3
                )
                d.sound = "biuriful"
                f.sound = "biuriful"
                d.effects = __arrL({"deboche-pose", "heel-spark", "knee-star"}, 3)
                d.text = "BIURIFUL!"
                break
            end
        until true
        d.finisher = f
        if __t(dir == "up" or dir == "down") then
            local vertical = if dir == "up" then -1 else 1
            for ____, h in __iterar((f.hits)) do
                local ____t_19 = __t
                local ____math_abs_result_18 = math.abs(h.dx)
                __O[2495] = ____math_abs_result_18
                local reach = if ____t_19(____math_abs_result_18) then __O[2495] else 51
                h.dx = 0
                h.dy = -35 + vertical * reach
                h.angle = if dir == "up" then -math.pi / 2 else math.pi / 2
                h.radius = math.max(35, h.radius)
            end
            d.angle = __get(directionAngle, dir)
        end
        return d
    end
    local function attack(self, character, kind, direction, options)
        if kind == nil then
            kind = "physical"
        end
        if direction == nil then
            direction = "neutral"
        end
        if options == nil then
            options = {}
        end
        local id = if __t(__call(profile, "hasOwnProperty", character)) then character else "daroca"
        local dir = if __t(__call(directions, "includes", direction)) then direction else "neutral"
        local result = if kind == "combo" then combo(nil, id, dir, options) else if kind == "ranged" then ranged(nil, id, dir, options) else physical(nil, id, dir, options)
        result.facing = if __TS__Number(options.facing) < 0 then -1 else 1
        result.airborne = not not __t(options.airborne)
        return result
    end
    local function stats(self, character)
        local id = if __t(__call(profile, "hasOwnProperty", character)) then character else "daroca"
        return {
            speed = if id == "lucas" then 1.08 else 1,
            weight = 1,
            renderHeight = if id == "lucas" then 60 else 70,
            hurtbox = {w = 34, h = if id == "lucas" then 60 else 70},
            stocks = 3,
            jumps = 2
        }
    end
    local function damageColor(self, damage)
        local ____t_21 = __t
        local ____TS__Number_result_20 = __TS__Number(damage)
        __O[2496] = ____TS__Number_result_20
        local n = math.max(0, if ____t_21(____TS__Number_result_20) then __O[2496] else 0)
        local stops = __arrL(
            {
                __arrL(
                    {
                        0,
                        __arrL({255, 255, 240}, 3)
                    },
                    2
                ),
                __arrL(
                    {
                        40,
                        __arrL({255, 225, 110}, 3)
                    },
                    2
                ),
                __arrL(
                    {
                        85,
                        __arrL({255, 162, 70}, 3)
                    },
                    2
                ),
                __arrL(
                    {
                        140,
                        __arrL({244, 75, 68}, 3)
                    },
                    2
                ),
                __arrL(
                    {
                        220,
                        __arrL({172, 37, 70}, 3)
                    },
                    2
                )
            },
            5
        )
        do
            local i = 1
            while i < __len(stops) do
                if __le(
                    n,
                    __get(
                        __get(stops, i),
                        0
                    )
                ) then
                    local a, ac = table.unpack(
                        __get(stops, i - 1),
                        1,
                        2
                    )
                    local b, bc = table.unpack(
                        __get(stops, i),
                        1,
                        2
                    )
                    local t = clamp(nil, (n - a) / (b - a), 0, 1)
                    return __add(
                        "#",
                        __call(
                            __call(
                                ac,
                                "map",
                                function(____, c, j) return __call(
                                    __call(
                                        math.floor(c + (__get(bc, j) - c) * t + 0.5),
                                        "toString",
                                        16
                                    ),
                                    "padStart",
                                    2,
                                    "0"
                                ) end
                            ),
                            "join",
                            ""
                        )
                    )
                end
                i = i + 1
            end
        end
        return "#ac2546"
    end
    local function comboReady(self, hits)
        return __isFiniteN(__TS__Number(hits)) and __TS__Number(hits) >= 3
    end
    local function budget(self, character)
        local id = if __t(__call(profile, "hasOwnProperty", character)) then character else "daroca"
        local p = __get(profile, id)
        local comboAttack = combo(nil, id, "neutral", {})
        return {
            physicalDPS = __get(p.physical, 0) / __get(p.physical, 1),
            rangedDPS = __get(p.ranged, 0) / __get(p.ranged, 1),
            comboDamage = __call(
                comboAttack.finisher.hits,
                "reduce",
                function(____, n, h) return __add(n, h.damage) end,
                0
            ),
            comboKnockback = __call(comboAttack.finisher.hits, "at", -1).knockback,
            speed = stats(nil, id).speed
        }
    end
    window.ArenaCombat = __ord(
        {
            version = 2,
            attack = attack,
            getAttack = attack,
            stats = stats,
            damageColor = damageColor,
            comboReady = comboReady,
            budget = budget,
            directions = __arr(__TS__Spread(__iter(directions))),
            ids = __keys(profile)
        },
        "version,attack,getAttack,stats,damageColor,comboReady,budget,directions,ids"
    )
end)(nil)
return ____exports
