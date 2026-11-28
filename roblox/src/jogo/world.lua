--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __mod, __ord, __arrL, __iterar, __t, __get, __arr, __len, __call, __add, __iter, __values = __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__arr, __JSR.__len, __JSR.__call, __JSR.__add, __JSR.__iter, __JSR.__values
local __assign = __JSR.__assign
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__Spread = ____lualib.__TS__Spread
local __TS__SparseArrayNew = ____lualib.__TS__SparseArrayNew
local __TS__SparseArrayPush = ____lualib.__TS__SparseArrayPush
local __TS__SparseArraySpread = ____lualib.__TS__SparseArraySpread
local Set = ____lualib.Set
local __TS__New = ____lualib.__TS__New
local ____exports = {};
(function()
    local ____ = "use strict"
    local floor = 440
    local widths = __arrL({
        4800,
        6200,
        5000,
        5200,
        6000,
        7200,
        6600,
        4800,
        3600,
        4200,
        3600,
        4800
    }, 12)
    local platforms = __arrL(
        {
            __arrL(
                {
                    __arrL({1060, 384, 150}, 3),
                    __arrL({1250, 328, 140}, 3),
                    __arrL({1390, 384, 150}, 3),
                    __arrL({1580, 328, 150}, 3),
                    __arrL({1770, 384, 150}, 3),
                    __arrL({1990, 376, 150}, 3),
                    __arrL({2180, 312, 140}, 3),
                    __arrL({2360, 248, 140}, 3),
                    __arrL({2540, 312, 150}, 3),
                    __arrL({2720, 384, 150}, 3),
                    __arrL({2910, 328, 150}, 3),
                    __arrL({3100, 384, 150}, 3),
                    __arrL({3320, 376, 150}, 3),
                    __arrL({3510, 312, 150}, 3),
                    __arrL({3700, 376, 150}, 3),
                    __arrL({3960, 384, 150}, 3),
                    __arrL({4150, 320, 150}, 3),
                    __arrL({4340, 384, 150}, 3)
                },
                18
            ),
            __arrL(
                {
                    __arrL({1030, 384, 140}, 3),
                    __arrL({1200, 384, 140}, 3),
                    __arrL({1590, 384, 150}, 3),
                    __arrL({1780, 328, 150}, 3),
                    __arrL({1970, 384, 150}, 3),
                    __arrL({2500, 384, 140}, 3),
                    __arrL({2690, 320, 150}, 3),
                    __arrL({2880, 256, 140}, 3),
                    __arrL({3060, 320, 150}, 3),
                    __arrL({4150, 384, 140}, 3),
                    __arrL({4330, 328, 150}, 3),
                    __arrL({4520, 384, 150}, 3),
                    __arrL({4700, 376, 145}, 3),
                    __arrL({4885, 312, 150}, 3),
                    __arrL({5075, 376, 145}, 3),
                    __arrL({5740, 384, 150}, 3),
                    __arrL({5930, 320, 140}, 3)
                },
                17
            ),
            __arrL(
                {
                    __arrL({760, 384, 150}, 3),
                    __arrL({950, 320, 150}, 3),
                    __arrL({1140, 376, 150}, 3),
                    __arrL({1240, 384, 150}, 3),
                    __arrL({1430, 328, 150}, 3),
                    __arrL({1620, 384, 150}, 3),
                    __arrL({1820, 376, 140}, 3),
                    __arrL({2000, 312, 150}, 3),
                    __arrL({2190, 248, 140}, 3),
                    __arrL({2370, 312, 150}, 3),
                    __arrL({2540, 384, 150}, 3),
                    __arrL({2730, 328, 150}, 3),
                    __arrL({2920, 384, 150}, 3),
                    __arrL({3140, 376, 150}, 3),
                    __arrL({3330, 312, 150}, 3),
                    __arrL({3520, 376, 150}, 3),
                    __arrL({3840, 384, 150}, 3),
                    __arrL({4030, 328, 150}, 3),
                    __arrL({4220, 384, 150}, 3),
                    __arrL({4460, 376, 150}, 3),
                    __arrL({4650, 312, 150}, 3)
                },
                21
            ),
            __arrL(
                {
                    __arrL({650, 384, 150}, 3),
                    __arrL({840, 320, 140}, 3),
                    __arrL({1020, 376, 145}, 3),
                    __arrL({1140, 384, 150}, 3),
                    __arrL({1330, 328, 150}, 3),
                    __arrL({1520, 384, 150}, 3),
                    __arrL({1720, 376, 150}, 3),
                    __arrL({1910, 312, 150}, 3),
                    __arrL({2100, 248, 140}, 3),
                    __arrL({2280, 312, 145}, 3),
                    __arrL({2420, 384, 150}, 3),
                    __arrL({2610, 328, 150}, 3),
                    __arrL({2800, 384, 150}, 3),
                    __arrL({3040, 376, 145}, 3),
                    __arrL({3225, 312, 145}, 3),
                    __arrL({3440, 384, 150}, 3),
                    __arrL({3630, 328, 140}, 3),
                    __arrL({3810, 384, 150}, 3),
                    __arrL({4850, 384, 145}, 3),
                    __arrL({5030, 320, 140}, 3)
                },
                20
            )
        },
        4
    )
    local gaps = __arrL(
        {
            __arrL(
                {
                    __arrL({1450, 360}, 2),
                    __arrL({2780, 380}, 2),
                    __arrL({4020, 360}, 2)
                },
                3
            ),
            __arrL(
                {
                    __arrL({1080, 180}, 2),
                    __arrL({1660, 340}, 2),
                    __arrL({4200, 350}, 2)
                },
                3
            ),
            __arrL(
                {
                    __arrL({1300, 330}, 2),
                    __arrL({2600, 360}, 2),
                    __arrL({3900, 340}, 2)
                },
                3
            ),
            __arrL(
                {
                    __arrL({1200, 320}, 2),
                    __arrL({2480, 360}, 2),
                    __arrL({3500, 250}, 2)
                },
                3
            )
        },
        4
    )
    local gapCheckpoints = __call(
        gaps,
        "map",
        function(____, scene) return __call(
            scene,
            "map",
            function(____, ____bindingPattern0)
                local x
                x = ____bindingPattern0[1]
                return x - 140
            end
        ) end
    )
    local checkpoints = __arrL(
        {
            __arrL({
                230,
                940,
                1310,
                1950,
                2640,
                3300,
                3880,
                4550
            }, 8),
            __arrL({
                230,
                810,
                940,
                1410,
                1520,
                2110,
                2460,
                3300,
                4060,
                4630,
                5750
            }, 11),
            __arrL({
                230,
                660,
                1160,
                1760,
                2460,
                3070,
                3760,
                4380,
                4840
            }, 9),
            __arrL({
                230,
                560,
                1060,
                1690,
                2340,
                2960,
                3360,
                3850,
                4800
            }, 9)
        },
        4
    )
    local doors = __arrL(
        {
            __ord({
                id = "almiro",
                teacher = "almiro",
                scene = 1,
                x = 1350,
                label = "SALA DO ALMIRO",
                width = 960,
                exitX = 90,
                teacherX = 600
            }, "id,teacher,scene,x,label,width,exitX,teacherX"),
            __ord({
                id = "miqueias",
                teacher = "miqueias",
                scene = 1,
                x = 2350,
                label = "SALA DO MIQUEIAS",
                width = 960,
                exitX = 90,
                teacherX = 600
            }, "id,teacher,scene,x,label,width,exitX,teacherX")
        },
        2
    )
    local bosses = __ord(
        {
            igor = __ord({scene = 1, x = 1810}, "scene,x"),
            kaique = __ord({scene = 1, x = 3000}, "scene,x"),
            marco = __ord({scene = 1, x = 3700}, "scene,x"),
            menezes = __ord({scene = 1, x = 5200}, "scene,x"),
            nikolas = __ord({scene = 3, x = 4300}, "scene,x")
        },
        "igor,kaique,marco,menezes,nikolas"
    )
    local minions = __arrL({}, 0)
    local schoolCovers = __arrL(
        {
            __ord({x = 1510, width = 66, label = "ARMÁRIOS"}, "x,width,label"),
            __ord({x = 2130, width = 70, label = "ARMÁRIOS"}, "x,width,label"),
            __ord({x = 2770, width = 68, label = "ARMÁRIOS"}, "x,width,label"),
            __ord({x = 3190, width = 72, label = "ARMÁRIOS"}, "x,width,label")
        },
        4
    )
    local iraciTraps = __arrL(
        {__ord({scene = 1, x = 3120, width = 84}, "scene,x,width")},
        1
    )
    local arenaPlatforms = __ord(
        {
            marco = __arrL(
                {
                    __arrL({-330, 384, 150}, 3),
                    __arrL({-140, 320, 145}, 3),
                    __arrL({45, 256, 140}, 3),
                    __arrL({225, 320, 150}, 3)
                },
                4
            ),
            menezes = __arrL(
                {
                    __arrL({-350, 384, 155}, 3),
                    __arrL({-155, 320, 150}, 3),
                    __arrL({35, 256, 150}, 3),
                    __arrL({225, 320, 145}, 3)
                },
                4
            ),
            nikolas = __arrL(
                {
                    __arrL({-325, 384, 145}, 3),
                    __arrL({-140, 320, 150}, 3),
                    __arrL({50, 256, 145}, 3),
                    __arrL({235, 320, 145}, 3)
                },
                4
            )
        },
        "marco,menezes,nikolas"
    )
    arenaPlatforms.igor = __arrL(
        {
            __arrL({-285, 360, 130}, 3),
            __arrL({170, 360, 130}, 3)
        },
        2
    )
    arenaPlatforms.kaique = __arrL(
        {
            __arrL({-300, 364, 135}, 3),
            __arrL({-90, 300, 140}, 3),
            __arrL({150, 364, 135}, 3)
        },
        3
    )
    local arenaBounds = __ord(
        {
            igor = __arrL({-430, 430}, 2),
            kaique = __arrL({-430, 430}, 2),
            marco = __arrL({-430, 430}, 2),
            menezes = __arrL({-430, 430}, 2),
            nikolas = __arrL({-430, 430}, 2)
        },
        "igor,kaique,marco,menezes,nikolas"
    )
    local parkourZones = __arrL(
        {
            __ord({
                scene = 0,
                from = 1020,
                to = 1950,
                name = "Cercas do milho",
                theme = "wood"
            }, "scene,from,to,name,theme"),
            __ord({
                scene = 0,
                from = 2150,
                to = 3300,
                name = "Trilha do pomar",
                theme = "wood"
            }, "scene,from,to,name,theme"),
            __ord({
                scene = 0,
                from = 3890,
                to = 4550,
                name = "Travessia do riacho",
                theme = "wood"
            }, "scene,from,to,name,theme"),
            __ord({
                scene = 1,
                from = 1020,
                to = 1420,
                name = "Passarela das salas",
                theme = "school"
            }, "scene,from,to,name,theme"),
            __ord({
                scene = 1,
                from = 1530,
                to = 2130,
                name = "Obra no corredor",
                theme = "school"
            }, "scene,from,to,name,theme"),
            __ord({
                scene = 1,
                from = 2500,
                to = 3320,
                name = "Ronda dos monitores",
                theme = "school"
            }, "scene,from,to,name,theme"),
            __ord({
                scene = 1,
                from = 4140,
                to = 4750,
                name = "Escadaria da provocação",
                theme = "words"
            }, "scene,from,to,name,theme"),
            __ord({
                scene = 2,
                from = 730,
                to = 1780,
                name = "Circuito do leg day",
                theme = "gym"
            }, "scene,from,to,name,theme"),
            __ord({
                scene = 2,
                from = 1980,
                to = 3090,
                name = "Barras de respeito",
                theme = "gym"
            }, "scene,from,to,name,theme"),
            __ord({
                scene = 2,
                from = 3780,
                to = 4410,
                name = "Travessia dos halteres",
                theme = "gym"
            }, "scene,from,to,name,theme"),
            __ord({
                scene = 3,
                from = 620,
                to = 1690,
                name = "Arquibancada elevada",
                theme = "court"
            }, "scene,from,to,name,theme"),
            __ord({
                scene = 3,
                from = 1890,
                to = 2970,
                name = "Circuito dos cones",
                theme = "court"
            }, "scene,from,to,name,theme"),
            __ord({
                scene = 3,
                from = 3390,
                to = 3960,
                name = "Reta final da quadra",
                theme = "court"
            }, "scene,from,to,name,theme")
        },
        13
    )
    local foreshadow = __arrL(
        {
            __ord({scene = 1, x = 2570, type = "drawing", text = "OS RABISCOS ESTÃO VIVOS"}, "scene,x,type,text"),
            __ord({scene = 1, x = 3070, type = "drawing", text = "MARCO DESENHOU. AGORA CORRE."}, "scene,x,type,text"),
            __ord({scene = 1, x = 4420, type = "blackboard", text = "DA ROÇA PEGOU AR"}, "scene,x,type,text"),
            __ord({scene = 1, x = 4760, type = "blackboard", text = "TEKETEKETEKETEKE"}, "scene,x,type,text"),
            __ord({scene = 1, x = 4920, type = "blackboard", text = "DA ROÇA POUDIAAAM"}, "scene,x,type,text")
        },
        5
    )
    local collectibles = __arrL(
        {
            __ord({
                id = "parkour-farm-01",
                scene = 0,
                x = 1320,
                y = 294,
                type = "gas"
            }, "id,scene,x,y,type"),
            __ord({
                id = "parkour-farm-02",
                scene = 0,
                x = 2430,
                y = 214,
                type = "paper"
            }, "id,scene,x,y,type"),
            __ord({
                id = "parkour-farm-03",
                scene = 0,
                x = 4220,
                y = 286,
                type = "gas"
            }, "id,scene,x,y,type"),
            __ord({
                id = "parkour-school-01",
                scene = 1,
                x = 1850,
                y = 294,
                type = "paper"
            }, "id,scene,x,y,type"),
            __ord({
                id = "parkour-school-02",
                scene = 1,
                x = 2950,
                y = 222,
                type = "gas"
            }, "id,scene,x,y,type"),
            __ord({
                id = "parkour-school-03",
                scene = 1,
                x = 4400,
                y = 294,
                type = "paper"
            }, "id,scene,x,y,type"),
            __ord({
                id = "parkour-gym-01",
                scene = 2,
                x = 1020,
                y = 286,
                type = "gas"
            }, "id,scene,x,y,type"),
            __ord({
                id = "parkour-gym-02",
                scene = 2,
                x = 2260,
                y = 214,
                type = "paper"
            }, "id,scene,x,y,type"),
            __ord({
                id = "parkour-gym-03",
                scene = 2,
                x = 4100,
                y = 294,
                type = "gas"
            }, "id,scene,x,y,type"),
            __ord({
                id = "parkour-court-01",
                scene = 3,
                x = 1400,
                y = 294,
                type = "paper"
            }, "id,scene,x,y,type"),
            __ord({
                id = "parkour-court-02",
                scene = 3,
                x = 2170,
                y = 214,
                type = "gas"
            }, "id,scene,x,y,type"),
            __ord({
                id = "parkour-court-03",
                scene = 3,
                x = 3700,
                y = 294,
                type = "paper"
            }, "id,scene,x,y,type")
        },
        12
    )
    local newGaps = __arrL(
        {
            __arrL(
                {
                    __arrL({1420, 320}, 2),
                    __arrL({2860, 360}, 2),
                    __arrL({4310, 320}, 2)
                },
                3
            ),
            __arrL(
                {
                    __arrL({1680, 280}, 2),
                    __arrL({3290, 320}, 2),
                    __arrL({4910, 300}, 2)
                },
                3
            ),
            __arrL(
                {
                    __arrL({1420, 320}, 2),
                    __arrL({2580, 350}, 2),
                    __arrL({3810, 330}, 2)
                },
                3
            ),
            __arrL(
                {
                    __arrL({1880, 300}, 2),
                    __arrL({3210, 340}, 2)
                },
                2
            )
        },
        4
    )
    local highRoutes = __arrL(
        {
            __arrL(
                {
                    __arrL({740, 384, 150}, 3),
                    __arrL({930, 320, 150}, 3),
                    __arrL({1120, 384, 150}, 3),
                    __arrL({2130, 376, 150}, 3),
                    __arrL({2320, 312, 150}, 3),
                    __arrL({2510, 248, 140}, 3),
                    __arrL({2690, 312, 145}, 3),
                    __arrL({3650, 384, 150}, 3),
                    __arrL({3840, 320, 150}, 3),
                    __arrL({4030, 384, 150}, 3),
                    __arrL({5100, 376, 150}, 3),
                    __arrL({5290, 312, 150}, 3),
                    __arrL({5480, 376, 150}, 3)
                },
                13
            ),
            __arrL(
                {
                    __arrL({670, 384, 150}, 3),
                    __arrL({860, 320, 150}, 3),
                    __arrL({1050, 256, 140}, 3),
                    __arrL({1230, 320, 145}, 3),
                    __arrL({2440, 384, 150}, 3),
                    __arrL({2630, 320, 150}, 3),
                    __arrL({2820, 384, 150}, 3),
                    __arrL({3980, 384, 150}, 3),
                    __arrL({4170, 320, 150}, 3),
                    __arrL({4360, 256, 145}, 3),
                    __arrL({4545, 320, 150}, 3),
                    __arrL({5480, 384, 150}, 3),
                    __arrL({5670, 320, 150}, 3)
                },
                13
            ),
            __arrL(
                {
                    __arrL({610, 384, 150}, 3),
                    __arrL({800, 320, 150}, 3),
                    __arrL({990, 256, 140}, 3),
                    __arrL({1170, 320, 145}, 3),
                    __arrL({1970, 384, 150}, 3),
                    __arrL({2160, 320, 150}, 3),
                    __arrL({2350, 384, 150}, 3),
                    __arrL({3200, 384, 150}, 3),
                    __arrL({3390, 320, 150}, 3),
                    __arrL({3580, 256, 140}, 3),
                    __arrL({3760, 320, 145}, 3),
                    __arrL({4470, 384, 150}, 3),
                    __arrL({4660, 320, 150}, 3),
                    __arrL({4850, 384, 150}, 3)
                },
                14
            ),
            __arrL(
                {
                    __arrL({790, 384, 150}, 3),
                    __arrL({980, 320, 150}, 3),
                    __arrL({1170, 384, 150}, 3),
                    __arrL({2290, 376, 150}, 3),
                    __arrL({2480, 312, 150}, 3),
                    __arrL({2670, 248, 145}, 3),
                    __arrL({2855, 312, 150}, 3),
                    __arrL({3850, 384, 150}, 3),
                    __arrL({4040, 320, 150}, 3),
                    __arrL({4230, 384, 150}, 3)
                },
                10
            )
        },
        4
    )
    __call(
        newGaps,
        "forEach",
        function(____, sceneGaps, i)
            local index = i + 4
            local chain = __arrL({}, 0)
            for ____, ____value in __iterar((sceneGaps)) do
                local x = ____value[1]
                local width = ____value[2]
                __call(
                    chain,
                    "push",
                    __arrL({x - 60, 384, 150}, 3),
                    __arrL({x + 130, 328, 150}, 3),
                    __arrL({x + width, 384, 150}, 3)
                )
            end
            local ____call_3 = __call
            local ____call_2 = __call
            local ____arr_1 = __arr
            local ____array_0 = __TS__SparseArrayNew(__TS__Spread(__iter(__get(highRoutes, i))))
            __TS__SparseArrayPush(
                ____array_0,
                __TS__Spread(__iter(chain))
            )
            ____call_3(
                platforms,
                "push",
                ____call_2(
                    ____arr_1(__TS__SparseArraySpread(____array_0)),
                    "sort",
                    function(____, a, b) return __get(a, 0) - __get(b, 0) end
                )
            )
            __call(gaps, "push", sceneGaps)
            __call(
                gapCheckpoints,
                "push",
                __call(
                    sceneGaps,
                    "map",
                    function(____, ____bindingPattern0)
                        local x
                        x = ____bindingPattern0[1]
                        return x - 140
                    end
                )
            )
            local ____call_10 = __call
            local ____call_9 = __call
            local ____arr_8 = __arr
            local ____iter_7 = __iter
            local ____Set_6 = Set
            local ____arr_5 = __arr
            local ____array_4 = __TS__SparseArrayNew(
                230,
                __TS__Spread(__iter(__call(
                    sceneGaps,
                    "map",
                    function(____, ____bindingPattern0)
                        local x
                        x = ____bindingPattern0[1]
                        return x - 140
                    end
                )))
            )
            __TS__SparseArrayPush(
                ____array_4,
                __TS__Spread(__iter(__call(
                    sceneGaps,
                    "map",
                    function(____, ____bindingPattern0)
                        local w
                        local x
                        x = ____bindingPattern0[1]
                        w = ____bindingPattern0[2]
                        return x + w + 170
                    end
                )))
            )
            __TS__SparseArrayPush(
                ____array_4,
                __get(widths, index) - 180
            )
            ____call_10(
                checkpoints,
                "push",
                ____call_9(
                    ____arr_8(__TS__Spread(____iter_7(__TS__New(
                        ____Set_6,
                        ____arr_5(__TS__SparseArraySpread(____array_4))
                    )))),
                    "sort",
                    function(____, a, b) return a - b end
                )
            )
        end
    )
    __call(
        platforms,
        "push",
        __arrL(
            {
                __arrL({1250, 384, 150}, 3),
                __arrL({1450, 328, 150}, 3),
                __arrL({1820, 384, 150}, 3),
                __arrL({2020, 328, 150}, 3),
                __arrL({2220, 384, 150}, 3),
                __arrL({2740, 384, 150}, 3),
                __arrL({2940, 328, 150}, 3),
                __arrL({3140, 384, 150}, 3)
            },
            8
        )
    )
    __call(
        gaps,
        "push",
        __arrL({}, 0)
    )
    __call(
        gapCheckpoints,
        "push",
        __arrL({}, 0)
    )
    __call(
        checkpoints,
        "push",
        __arrL({
            230,
            1050,
            1740,
            2660,
            3380
        }, 5)
    )
    __call(
        parkourZones,
        "push",
        __ord({
            scene = 8,
            from = 1210,
            to = 1630,
            name = "Prateleiras do degradê",
            theme = "barbershop"
        }, "scene,from,to,name,theme"),
        __ord({
            scene = 8,
            from = 1800,
            to = 2410,
            name = "Passarela dos pentes",
            theme = "barbershop"
        }, "scene,from,to,name,theme"),
        __ord({
            scene = 8,
            from = 2700,
            to = 3350,
            name = "Arquivo da resenha",
            theme = "barbershop"
        }, "scene,from,to,name,theme")
    )
    __call(
        collectibles,
        "push",
        __ord({
            id = "bigodon-alto-01",
            scene = 8,
            x = 1520,
            y = 294,
            type = "gas"
        }, "id,scene,x,y,type"),
        __ord({
            id = "bigodon-alto-02",
            scene = 8,
            x = 2090,
            y = 294,
            type = "paper"
        }, "id,scene,x,y,type"),
        __ord({
            id = "bigodon-alto-03",
            scene = 8,
            x = 3010,
            y = 294,
            type = "gas"
        }, "id,scene,x,y,type")
    )
    __call(
        platforms,
        "push",
        __arrL(
            {
                __arrL({1050, 384, 150}, 3),
                __arrL({1240, 328, 150}, 3),
                __arrL({1430, 384, 150}, 3),
                __arrL({1740, 376, 150}, 3),
                __arrL({1930, 312, 150}, 3),
                __arrL({2120, 376, 150}, 3),
                __arrL({3410, 384, 150}, 3),
                __arrL({3600, 328, 150}, 3),
                __arrL({3790, 384, 150}, 3)
            },
            9
        )
    )
    __call(
        gaps,
        "push",
        __arrL({}, 0)
    )
    __call(
        gapCheckpoints,
        "push",
        __arrL({}, 0)
    )
    __call(
        checkpoints,
        "push",
        __arrL({
            230,
            940,
            1650,
            2370,
            3330,
            4010
        }, 6)
    )
    __call(
        parkourZones,
        "push",
        __ord({
            scene = 9,
            from = 1020,
            to = 1620,
            name = "Bancos do recreio",
            theme = "school"
        }, "scene,from,to,name,theme"),
        __ord({
            scene = 9,
            from = 1710,
            to = 2310,
            name = "Passarela do pátio",
            theme = "school"
        }, "scene,from,to,name,theme"),
        __ord({
            scene = 9,
            from = 3370,
            to = 3980,
            name = "Caminho da cantina",
            theme = "school"
        }, "scene,from,to,name,theme")
    )
    __call(
        collectibles,
        "push",
        __ord({
            id = "patio-alto-01",
            scene = 9,
            x = 1310,
            y = 294,
            type = "gas"
        }, "id,scene,x,y,type"),
        __ord({
            id = "patio-alto-02",
            scene = 9,
            x = 2000,
            y = 278,
            type = "paper"
        }, "id,scene,x,y,type"),
        __ord({
            id = "patio-alto-03",
            scene = 9,
            x = 3670,
            y = 294,
            type = "gas"
        }, "id,scene,x,y,type")
    )
    __call(
        platforms,
        "push",
        __arrL(
            {
                __arrL({1920, 384, 150}, 3),
                __arrL({2110, 328, 150}, 3),
                __arrL({2300, 384, 150}, 3),
                __arrL({2670, 384, 150}, 3),
                __arrL({2860, 328, 150}, 3),
                __arrL({3050, 384, 150}, 3)
            },
            6
        )
    )
    __call(
        gaps,
        "push",
        __arrL({}, 0)
    )
    __call(
        gapCheckpoints,
        "push",
        __arrL({}, 0)
    )
    __call(
        checkpoints,
        "push",
        __arrL({
            230,
            420,
            1060,
            1650,
            1840,
            2580,
            3390
        }, 7)
    )
    __call(
        parkourZones,
        "push",
        __ord({
            scene = 10,
            from = 1880,
            to = 2490,
            name = "Prateleiras da sala",
            theme = "house"
        }, "scene,from,to,name,theme"),
        __ord({
            scene = 10,
            from = 2630,
            to = 3260,
            name = "Varanda da resenha",
            theme = "house"
        }, "scene,from,to,name,theme")
    )
    __call(
        collectibles,
        "push",
        __ord({
            id = "casa-rayssa-alto-01",
            scene = 10,
            x = 2180,
            y = 294,
            type = "gas"
        }, "id,scene,x,y,type"),
        __ord({
            id = "casa-rayssa-alto-02",
            scene = 10,
            x = 2930,
            y = 294,
            type = "paper"
        }, "id,scene,x,y,type")
    )
    __call(
        platforms,
        "push",
        __arrL(
            {
                __arrL({1070, 384, 150}, 3),
                __arrL({1260, 328, 150}, 3),
                __arrL({1450, 384, 150}, 3),
                __arrL({2080, 384, 150}, 3),
                __arrL({2270, 328, 150}, 3),
                __arrL({2460, 384, 150}, 3),
                __arrL({3840, 384, 150}, 3),
                __arrL({4030, 328, 150}, 3),
                __arrL({4220, 384, 150}, 3)
            },
            9
        )
    )
    __call(
        gaps,
        "push",
        __arrL({}, 0)
    )
    __call(
        gapCheckpoints,
        "push",
        __arrL({}, 0)
    )
    __call(
        checkpoints,
        "push",
        __arrL({
            230,
            950,
            1820,
            2740,
            3160,
            3750,
            4560
        }, 7)
    )
    __call(
        parkourZones,
        "push",
        __ord({
            scene = 11,
            from = 1020,
            to = 1650,
            name = "Passarela dos refletores",
            theme = "baile"
        }, "scene,from,to,name,theme"),
        __ord({
            scene = 11,
            from = 2020,
            to = 2640,
            name = "Camarote da resenha",
            theme = "baile"
        }, "scene,from,to,name,theme"),
        __ord({
            scene = 11,
            from = 3780,
            to = 4410,
            name = "Bastidores do palco",
            theme = "baile"
        }, "scene,from,to,name,theme")
    )
    __call(
        collectibles,
        "push",
        __ord({
            id = "baile-alto-01",
            scene = 11,
            x = 1330,
            y = 294,
            type = "gas"
        }, "id,scene,x,y,type"),
        __ord({
            id = "baile-alto-02",
            scene = 11,
            x = 2340,
            y = 294,
            type = "paper"
        }, "id,scene,x,y,type"),
        __ord({
            id = "baile-alto-03",
            scene = 11,
            x = 4100,
            y = 294,
            type = "gas"
        }, "id,scene,x,y,type")
    )
    bosses.reeisBoss = __ord({scene = 5, x = 6400}, "scene,x")
    bosses.giant = __ord({scene = 6, x = 5650}, "scene,x")
    bosses.freddy = __ord({scene = 5, x = 5680}, "scene,x")
    bosses.nicolas = __ord({scene = 4, x = 5350}, "scene,x")
    bosses.dede = __ord({scene = 5, x = 5000}, "scene,x")
    bosses.arthur = __ord({scene = 9, x = 2850}, "scene,x")
    arenaPlatforms.reeisBoss = __arrL(
        {
            __arrL({-350, 384, 155}, 3),
            __arrL({-155, 320, 150}, 3),
            __arrL({35, 256, 150}, 3),
            __arrL({225, 320, 145}, 3)
        },
        4
    )
    arenaPlatforms.giant = __arrL(
        {
            __arrL({-370, 384, 150}, 3),
            __arrL({-185, 320, 150}, 3),
            __arrL({35, 256, 150}, 3),
            __arrL({220, 320, 150}, 3),
            __arrL({320, 384, 145}, 3)
        },
        5
    )
    arenaBounds.reeisBoss = __arrL({-430, 430}, 2)
    arenaBounds.giant = __arrL({-470, 470}, 2)
    arenaPlatforms.freddy = __arrL(
        {
            __arrL({-300, 384, 140}, 3),
            __arrL({-100, 320, 140}, 3),
            __arrL({100, 320, 140}, 3),
            __arrL({280, 384, 120}, 3)
        },
        4
    )
    arenaPlatforms.nicolas = __arrL(
        {
            __arrL({-300, 384, 140}, 3),
            __arrL({-100, 320, 140}, 3),
            __arrL({100, 320, 140}, 3),
            __arrL({280, 384, 120}, 3)
        },
        4
    )
    arenaBounds.freddy = __arrL({-400, 400}, 2)
    arenaBounds.nicolas = __arrL({-400, 400}, 2)
    arenaPlatforms.dede = __arrL(
        {
            __arrL({-280, 384, 130}, 3),
            __arrL({-90, 320, 140}, 3),
            __arrL({120, 384, 140}, 3)
        },
        3
    )
    arenaPlatforms.arthur = __arrL(
        {
            __arrL({-280, 384, 130}, 3),
            __arrL({-90, 320, 140}, 3),
            __arrL({120, 384, 140}, 3)
        },
        3
    )
    arenaBounds.dede = __arrL({-360, 360}, 2)
    arenaBounds.arthur = __arrL({-360, 360}, 2)
    local questPickups = __arrL(
        {
            __ord({
                id = "fan",
                type = "carPart",
                scene = 0,
                x = 1320,
                y = 294,
                label = "Ventoinha do carro"
            }, "id,type,scene,x,y,label"),
            __ord({
                id = "pipe",
                type = "carPart",
                scene = 0,
                x = 2430,
                y = 214,
                label = "Cano de gás"
            }, "id,type,scene,x,y,label"),
            __ord({
                id = "spark",
                type = "carPart",
                scene = 0,
                x = 4220,
                y = 286,
                label = "Vela de ignição"
            }, "id,type,scene,x,y,label"),
            __ord({
                id = "caderno-01",
                type = "notebook",
                scene = 1,
                x = 1640,
                y = 350,
                label = "Caderno de exercícios"
            }, "id,type,scene,x,y,label"),
            __ord({
                id = "caderno-02",
                type = "notebook",
                scene = 1,
                x = 2050,
                y = 350,
                label = "Caderno de revisão"
            }, "id,type,scene,x,y,label"),
            __ord({
                id = "caderno-03",
                type = "notebook",
                scene = 1,
                x = 2950,
                y = 222,
                label = "Caderno de desafio"
            }, "id,type,scene,x,y,label")
        },
        6
    )
    local sarueTraps = __arrL(
        {__ord({
            id = "sarue-marco-01",
            scene = 1,
            x = 3420,
            width = 70,
            target = "marco",
            label = "SARUÊ"
        }, "id,scene,x,width,target,label")},
        1
    )
    local rageMinions = __arrL(
        {
            __ord({
                type = "doodle",
                kind = 1,
                design = "brainrot",
                variant = "brainrot",
                hp = 72,
                damage = 12,
                range = 65,
                provocation = "BRAINROT POUDII!",
                xp = 45
            }, "type,kind,design,variant,hp,damage,range,provocation,xp"),
            __ord({
                type = "doodle",
                kind = 2,
                design = "sixseven",
                variant = "sixseven",
                hp = 80,
                damage = 13,
                range = 50,
                provocation = "SIX SEVEN!",
                xp = 50
            }, "type,kind,design,variant,hp,damage,range,provocation,xp"),
            __ord({
                type = "doodle",
                kind = 0,
                design = "spindle",
                variant = "spindle",
                hp = 76,
                damage = 12,
                range = 95,
                provocation = "TRRRR! GIRO POUDII!",
                xp = 48
            }, "type,kind,design,variant,hp,damage,range,provocation,xp"),
            __ord({
                type = "doodle",
                kind = 1,
                design = "wobbler",
                variant = "wobbler",
                hp = 78,
                damage = 13,
                range = 75,
                provocation = "BALANÇA MAS NÃO CAI!",
                xp = 48
            }, "type,kind,design,variant,hp,damage,range,provocation,xp"),
            __ord({
                type = "doodle",
                kind = 2,
                design = "pasta",
                variant = "pasta",
                hp = 82,
                damage = 14,
                range = 60,
                provocation = "MACARRÃO DA CONFUSÃO!",
                xp = 52
            }, "type,kind,design,variant,hp,damage,range,provocation,xp")
        },
        5
    )
    local doodlePhrases = __arrL({
        "Da roça pegou ar!",
        "Poudiaaam!",
        "Teketeketeketeke!",
        "SIX SEVEN!",
        "Marco desenhou, agora corre!"
    }, 5)
    __call(
        minions,
        "forEach",
        function(____, m, i) return __assign(
            m,
            {
                type = "doodle",
                tier = 1 + math.floor(i / 2),
                level = 2 + math.floor(i / 2),
                hp = 48 + i * 4,
                xp = 30 + i * 3,
                design = __get(
                    __arrL({
                        "ink",
                        "brainrot",
                        "sixseven",
                        "spindle",
                        "wobbler",
                        "pasta"
                    }, 6),
                    __mod(i, 6)
                ),
                provocation = __get(
                    doodlePhrases,
                    __mod(
                        i,
                        __len(doodlePhrases)
                    )
                )
            }
        ) end
    )
    __call(
        __arrL({
            1050,
            1930,
            2370,
            3420,
            3820,
            4800
        }, 6),
        "forEach",
        function(____, x, i) return __call(
            minions,
            "push",
            {
                id = __add("praca-rabisco-", i + 1),
                scene = 4,
                x = x,
                y = floor,
                type = "doodle",
                kind = __mod(i, 3),
                tier = 1 + math.floor(i / 3),
                level = 1 + math.floor(i / 2),
                hp = 34 + i * 4,
                range = 45,
                damage = 6 + math.floor(i / 2),
                xp = 25 + i * 3,
                design = __t(__mod(i, 2)) and "brainrot" or "ink",
                provocation = __get(
                    doodlePhrases,
                    __mod(
                        i,
                        __len(doodlePhrases)
                    )
                )
            }
        ) end
    )
    local thugPositions = __arrL({
        850,
        1060,
        1270,
        1480,
        1740,
        1960,
        2180,
        2400,
        2680,
        2900,
        3120,
        3340,
        3560,
        3780,
        3990,
        4200
    }, 16)
    __call(
        thugPositions,
        "forEach",
        function(____, x, i)
            local tier = 1 + math.floor(i / 4)
            local ____temp_13
            if tier == 1 then
                ____temp_13 = "pistol"
            else
                local ____temp_12
                if tier == 2 then
                    ____temp_12 = __t(__mod(i, 2)) and "scatter" or "pistol"
                else
                    local ____temp_11
                    if tier == 3 then
                        ____temp_11 = __t(__mod(i, 2)) and "carbine" or "scatter"
                    else
                        ____temp_11 = __t(__mod(i, 3)) and "carbine" or "scatter"
                    end
                    ____temp_12 = ____temp_11
                end
                ____temp_13 = ____temp_12
            end
            local weapon = ____temp_13
            __call(
                minions,
                "push",
                {
                    id = __add(
                        "favela-encontro-",
                        __call(
                            tostring(i + 1),
                            "padStart",
                            2,
                            "0"
                        )
                    ),
                    scene = 5,
                    x = x,
                    y = floor,
                    type = "thug",
                    kind = 2,
                    tier = tier,
                    level = 1 + math.floor(i / 2),
                    weapon = weapon,
                    hp = __get(
                        __arrL({38, 58, 84, 116}, 4),
                        tier - 1
                    ),
                    range = i == 15 and 35 or 45,
                    damage = __get(
                        __arrL({8, 10, 13, 16}, 4),
                        tier - 1
                    ),
                    xp = 24 + tier * 12,
                    provocation = __get(
                        __arrL({"O rei tá esperando!", "Não passa sem encarar!", "Essa rua é desafio de verdade!", "Você quer falar com o Reeis?"}, 4),
                        __mod(i, 4)
                    )
                }
            )
        end
    )
    __call(
        __arrL({
            850,
            1150,
            1900,
            2250,
            3100,
            3470,
            4250,
            4550
        }, 8),
        "forEach",
        function(____, x, i) return __call(
            minions,
            "push",
            {
                id = __add("caderno-monstro-", i + 1),
                scene = 6,
                x = x,
                y = floor,
                type = "doodle",
                kind = __mod(i, 3),
                tier = 3 + math.floor(i / 4),
                level = 6 + math.floor(i / 2),
                hp = 85 + i * 7,
                range = 45,
                damage = 12 + math.floor(i / 3),
                xp = 45 + i * 4,
                design = __get(
                    __arrL({
                        "spindle",
                        "wobbler",
                        "pasta",
                        "brainrot",
                        "sixseven"
                    }, 5),
                    __mod(i, 5)
                ),
                variant = __get(
                    __arrL({
                        "spindle",
                        "wobbler",
                        "pasta",
                        "brainrot",
                        "sixseven"
                    }, 5),
                    __mod(i, 5)
                ),
                provocation = __get(
                    __arrL({
                        "GIRO POUDII!",
                        "BALANÇA MAS NÃO CAI!",
                        "MACARRÃO DA CONFUSÃO!",
                        "O desenho vai pegar ar!",
                        "SIX SEVEN!"
                    }, 5),
                    __mod(i, 5)
                )
            }
        ) end
    )
    local zoneNames = __arrL(
        {
            __arrL({"Fontes e passarelas", "Calçadão do rio", "Mirante de Camacan"}, 3),
            __arrL({"Escadaria do morro", "Telhados da travessa", "Passagem dos becos"}, 3),
            __arrL({"Papel rasgado", "Pontes de tinta", "Reta dos rabiscos"}, 3),
            __arrL({"Arquibancadas do treino", "Circuito dos cones"}, 2)
        },
        4
    )
    __call(
        newGaps,
        "forEach",
        function(____, gs, i) return __call(
            gs,
            "forEach",
            function(____, ____bindingPattern0, j)
                local w
                local x
                x = ____bindingPattern0[1]
                w = ____bindingPattern0[2]
                return __call(
                    parkourZones,
                    "push",
                    {
                        scene = i + 4,
                        from = x - 150,
                        to = x + w + 180,
                        name = __get(
                            __get(zoneNames, i),
                            j
                        ),
                        theme = __get(
                            __arrL({"square", "favela", "ink", "football"}, 4),
                            i
                        )
                    }
                )
            end
        ) end
    )
    __call(
        foreshadow,
        "push",
        __ord({scene = 1, x = 1540, type = "sign", text = "MONITORES EM RONDA · ARMÁRIOS ESCONDEM"}, "scene,x,type,text"),
        __ord({scene = 1, x = 2550, type = "sign", text = "KAIQUE FISCALIZA AS BOLINHAS DE PAPEL"}, "scene,x,type,text"),
        __ord({scene = 4, x = 440, type = "sign", text = "PRAÇA CAMACAN · ITABUNA"}, "scene,x,type,text"),
        __ord({scene = 4, x = 3300, type = "sign", text = "RIO CACHOEIRA"}, "scene,x,type,text"),
        __ord({scene = 5, x = 680, type = "sign", text = "SUBA ATÉ O REEIS"}, "scene,x,type,text"),
        __ord({scene = 5, x = 3580, type = "drawing", text = "O DESAFIO FICA MAIS FORTE"}, "scene,x,type,text"),
        __ord({scene = 5, x = 4560, type = "sign", text = "DEDÉ · A FUMAÇA DO BECO"}, "scene,x,type,text"),
        __ord({scene = 5, x = 5270, type = "sign", text = "FREDDY · O BRAÇO FORTE DO REEIS"}, "scene,x,type,text"),
        __ord({scene = 5, x = 6000, type = "sign", text = "O REI DO MORRO"}, "scene,x,type,text"),
        __ord({scene = 6, x = 700, type = "drawing", text = "CADERNO DO CAOS"}, "scene,x,type,text"),
        __ord({scene = 6, x = 5100, type = "drawing", text = "MARCO DESENHOU GRANDE DEMAIS"}, "scene,x,type,text"),
        __ord({scene = 7, x = 360, type = "sign", text = "CAMPO DO MOTA · TREINO DE CRAQUE"}, "scene,x,type,text"),
        __ord({scene = 4, x = 4940, type = "sign", text = "NICOLAS CARVALHO · AURA SUPREMA?"}, "scene,x,type,text"),
        __ord({scene = 8, x = 360, type = "sign", text = "BIGODON · BARBA, CABELO E RESENHA"}, "scene,x,type,text"),
        __ord({scene = 8, x = 1120, type = "sign", text = "DAVI CORTA. VITOR CONFERE. A RESENHA NÃO PARA."}, "scene,x,type,text"),
        __ord({scene = 8, x = 110, type = "sign", text = "ALLEF · RECEPÇÃO DA BIGODON"}, "scene,x,type,text"),
        __ord({scene = 9, x = 360, type = "sign", text = "PÁTIO DO COLÉGIO ADVENTISTA"}, "scene,x,type,text"),
        __ord({scene = 9, x = 900, type = "sign", text = "RECREIO BOM É SEM PUXAR CABELO"}, "scene,x,type,text"),
        __ord({scene = 9, x = 2400, type = "sign", text = "ARTHUR · RESOLVA A CONFUSÃO DO PÁTIO"}, "scene,x,type,text"),
        __ord({scene = 10, x = 290, type = "sign", text = "CASA DE RAYSSA · CHEGA NA RESENHA"}, "scene,x,type,text"),
        __ord({scene = 10, x = 1800, type = "sign", text = "AFF, VEYR, JURO · A CONVERSA CONTINUA"}, "scene,x,type,text"),
        __ord({scene = 11, x = 340, type = "sign", text = "BAILE FUNK · A NOITE DA RESENHA"}, "scene,x,type,text"),
        __ord({scene = 11, x = 2840, type = "sign", text = "OLLYAN · ORELHAS AO VENTO"}, "scene,x,type,text")
    )
    __call(
        __arrL(
            {
                __arrL({4, 1000, 286}, 3),
                __arrL({4, 2580, 214}, 3),
                __arrL({4, 5360, 278}, 3),
                __arrL({5, 1120, 222}, 3),
                __arrL({5, 2730, 286}, 3),
                __arrL({5, 4430, 222}, 3),
                __arrL({6, 1060, 222}, 3),
                __arrL({6, 3460, 286}, 3),
                __arrL({6, 4730, 286}, 3),
                __arrL({7, 1050, 286}, 3),
                __arrL({7, 2740, 214}, 3),
                __arrL({7, 4110, 286}, 3)
            },
            12
        ),
        "forEach",
        function(____, ____bindingPattern0, i)
            local y
            local x
            local scene
            scene = ____bindingPattern0[1]
            x = ____bindingPattern0[2]
            y = ____bindingPattern0[3]
            return __call(
                collectibles,
                "push",
                {
                    id = __add("campanha-alto-", i + 1),
                    scene = scene,
                    x = x,
                    y = y,
                    type = __t(__mod(i, 2)) and "paper" or "gas"
                }
            )
        end
    )
    local sceneNames = __arrL({
        "A roça",
        "Colégio Adventista",
        "Academia do Caleb",
        "A quadra",
        "Praça Camacan",
        "Favela do Reeis",
        "Caderno do Caos",
        "Campo do Mota",
        "Bigodon",
        "Pátio da escola",
        "Casa de Rayssa",
        "Baile funk"
    }, 12)
    local npcEntries = __ord(
        {
            amanda = __ord({name = "Amanda", scene = 4, x = 515}, "name,scene,x"),
            ollyan = __ord({name = "Ollyan · Orelhas ao Vento", scene = 11, x = 3260, y = 440}, "name,scene,x,y"),
            allef = __ord({name = "Allef · recepção da Bigodon", scene = 8, x = 240}, "name,scene,x"),
            eloisa = __ord({name = "Eloisa", scene = 10, x = 450}, "name,scene,x"),
            giselle = __ord({name = "Giselle", scene = 10, x = 820}, "name,scene,x"),
            rayssa = __ord({name = "Rayssa", scene = 10, x = 1220}, "name,scene,x"),
            analaura = __ord({name = "Ana Laura", scene = 10, x = 1580}, "name,scene,x")
        },
        "amanda,ollyan,allef,eloisa,giselle,rayssa,analaura"
    )
    local landmarks = __ord(
        {
            school = __ord({
                name = "COLÉGIO ADVENTISTA",
                wall = "#f6f7f1",
                trim = "#17385d",
                chair = "#28569a",
                board = "#81c8c2"
            }, "name,wall,trim,chair,board"),
            square = __ord({name = "Praça Camacan", officialName = "Praça Otávio Mangabeira", inspiration = "Itabuna, Bahia", river = "Rio Cachoeira"}, "name,officialName,inspiration,river"),
            bigodon = __ord({
                name = "BIGODON",
                kind = "barbershop",
                barber = "Davi Costa",
                assistant = "Vitor",
                inspiration = "Uma barbearia fictícia da turma",
                floor = 440
            }, "name,kind,barber,assistant,inspiration,floor"),
            patio = __ord({
                name = "PÁTIO DO COLÉGIO ADVENTISTA",
                wall = "#f6f7f1",
                trim = "#17385d",
                floor = 440,
                kind = "school-courtyard"
            }, "name,wall,trim,floor,kind"),
            rayssaHouse = __ord(
                {
                    name = "CASA DE RAYSSA",
                    kind = "house",
                    floor = 440,
                    width = 3600,
                    residents = __arrL({"eloisa", "giselle", "rayssa", "analaura"}, 4),
                    inspiration = "Uma casa fictícia da turma para conversar e explorar"
                },
                "name,kind,floor,width,residents,inspiration"
            ),
            baileFunk = __ord({
                name = "BAILE FUNK",
                kind = "night-party",
                floor = 440,
                width = 4800,
                encounter = "ollyan",
                inspiration = "Uma festa fictícia da turma, com palco, dança e batalha aérea"
            }, "name,kind,floor,width,encounter,inspiration")
        },
        "school,square,bigodon,patio,rayssaHouse,baileFunk"
    )
    for ____, ____value in __iterar((__arrL(
        {
            __arrL(
                {
                    0,
                    __arrL({2720, 3240, 3620, 4540}, 4),
                    32
                },
                3
            ),
            __arrL(
                {
                    2,
                    __arrL({2050, 2820, 3520}, 3),
                    40
                },
                3
            ),
            __arrL(
                {
                    3,
                    __arrL({1830, 2610, 3330}, 3),
                    64
                },
                3
            ),
            __arrL(
                {
                    9,
                    __arrL({1870, 2250}, 2),
                    38
                },
                3
            )
        },
        4
    ))) do
        local region = ____value[1]
        local positions = ____value[2]
        local baseHP = ____value[3]
        __call(
            positions,
            "forEach",
            function(____, x, i) return __call(
                minions,
                "push",
                {
                    id = __add(
                        __add(
                            __add("trilha-v38-", region),
                            "-"
                        ),
                        i
                    ),
                    scene = region,
                    x = x,
                    y = floor,
                    type = "doodle",
                    kind = __mod(i, 3),
                    tier = 1 + math.floor(i / 2),
                    hp = baseHP + i * 6,
                    damage = 6 + i * 2,
                    range = 45,
                    xp = 32 + i * 7,
                    design = __get(
                        __arrL({"spindle", "wobbler", "pasta"}, 3),
                        __mod(i, 3)
                    ),
                    provocation = __get(
                        __arrL({"O CHAPÉU NÃO PASSA AQUI!", "TEU GÁS TÁ NO CHEIRINHO!", "MARCO MANDOU UM ABRAÇO!"}, 3),
                        __mod(i, 3)
                    )
                }
            ) end
        )
    end
    local data = __ord({
        version = "3.8.0",
        floor = floor,
        widths = widths,
        platforms = platforms,
        gaps = gaps,
        gapCheckpoints = gapCheckpoints,
        checkpoints = checkpoints,
        doors = doors,
        bosses = bosses,
        minions = minions,
        arenaPlatforms = arenaPlatforms,
        arenaBounds = arenaBounds,
        parkourZones = parkourZones,
        foreshadow = foreshadow,
        collectibles = collectibles,
        questPickups = questPickups,
        sarueTraps = sarueTraps,
        iraciTraps = iraciTraps,
        schoolCovers = schoolCovers,
        rageMinions = rageMinions,
        sceneNames = sceneNames,
        npcEntries = npcEntries,
        landmarks = landmarks
    }, "version,floor,widths,platforms,gaps,gapCheckpoints,checkpoints,doors,bosses,minions,arenaPlatforms,arenaBounds,parkourZones,foreshadow,collectibles,questPickups,sarueTraps,iraciTraps,schoolCovers,rageMinions,sceneNames,npcEntries,landmarks")
    local function freeze(self, value)
        local ____t_15 = __t
        local ____t_result_14
        if __t(value) then
            ____t_result_14 = type(value) == "table"
        else
            ____t_result_14 = value
        end
        if ____t_15(____t_result_14) then
            __call(
                __values(value),
                "forEach",
                freeze
            )
            local ____ = value
        end
        return value
    end
    window.WorldData = freeze(nil, data)
end)(nil)
return ____exports
