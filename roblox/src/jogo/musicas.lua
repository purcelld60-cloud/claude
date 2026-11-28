--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __ord, __arrL, __iterar, __t, __get, __set, __len, __call, __add, __iter, __entries, __assign = __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__set, __JSR.__len, __JSR.__call, __JSR.__add, __JSR.__iter, __JSR.__entries, __JSR.__assign
local __re, __re_test, __re_replace, __re_split, __re_match = __JSR.__re, __JSR.__re_test, __JSR.__re_replace, __JSR.__re_split, __JSR.__re_match
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Number = ____lualib.__TS__Number
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__AsyncAwaiter = ____lualib.__TS__AsyncAwaiter
local __TS__Await = ____lualib.__TS__Await
local Map = ____lualib.Map
local __TS__New = ____lualib.__TS__New
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    if __t(window.DarocaMusicas) then
        return
    end
    local EXT = __re("\\.(mp3|ogg|m4a|wav)$", "i")
    local function slug(____, s)
        local ____re_replace_6 = __re_replace
        local ____re_replace_5 = __re_replace
        local ____re_replace_4 = __re_replace
        local ____re_replace_3 = __re_replace
        local ____call_2 = __call
        local ____call_1 = __call
        local ____t_result_0
        if __t(s) then
            ____t_result_0 = s
        else
            ____t_result_0 = ""
        end
        return ____re_replace_6(
            ____re_replace_5(
                ____re_replace_4(
                    ____re_replace_3(
                        ____call_2(
                            ____call_1(
                                tostring(____t_result_0),
                                "toLowerCase"
                            ),
                            "normalize",
                            "NFD"
                        ),
                        __re("[̀-ͯ]", "g"),
                        ""
                    ),
                    __re("\\.[a-z0-9]+$", ""),
                    ""
                ),
                __re("[^a-z0-9.]+", "g"),
                "-"
            ),
            __re("^-+|-+$", "g"),
            ""
        )
    end
    local PLACES = __ord({
        menu = "menu.title",
        inicio = "menu.title",
        pausa = "menu.pause",
        derrota = "events.defeat",
        fim = "events.chapter_end",
        ["fim-do-capitulo"] = "events.chapter_end",
        comemoracao = "events.celebration",
        ["transformacao-reeis"] = "events.reeis_transform",
        roca = "maps.roca",
        escola = "maps.escola",
        academia = "maps.academia",
        quadra = "maps.quadra",
        praca = "maps.camacan",
        camacan = "maps.camacan",
        favela = "maps.favela",
        caderno = "maps.caderno",
        tinta = "maps.caderno",
        ["reino-de-tinta"] = "maps.caderno",
        campo = "maps.campo",
        bigodon = "maps.bigodon",
        patio = "maps.patio",
        rayssa = "maps.rayssa",
        ["casa-da-rayssa"] = "maps.rayssa",
        baile = "maps.baile",
        ["jantar-amanda"] = "activity.dinner",
        ["sala-almiro"] = "rooms.almiro",
        ["sala-miqueias"] = "rooms.miqueias",
        arena = "arena.battle",
        ["arena-menu"] = "arena.menu",
        ["arena-resultado"] = "arena.results",
        fliperama = "minigames.fliperama",
        dupla = "coop.menu",
        ["dupla-menu"] = "coop.menu"
    }, "menu,inicio,pausa,derrota,fim,fim-do-capitulo,comemoracao,transformacao-reeis,roca,escola,academia,quadra,praca,camacan,favela,caderno,tinta,reino-de-tinta,campo,bigodon,patio,rayssa,casa-da-rayssa,baile,jantar-amanda,sala-almiro,sala-miqueias,arena,arena-menu,arena-resultado,fliperama,dupla,dupla-menu")
    local BOSS = __ord({
        marco = "marco",
        menezes = "menezes",
        nikolas = "nikolas",
        reeis = "reeisBoss",
        freddy = "freddy",
        nicolas = "nicolas",
        dede = "dede",
        arthur = "arthur",
        colosso = "giant",
        gigante = "giant",
        giant = "giant",
        igor = "igor",
        kaique = "kaique",
        ollyan = "ollyan"
    }, "marco,menezes,nikolas,reeis,freddy,nicolas,dede,arthur,colosso,gigante,giant,igor,kaique,ollyan")
    local AMBIENT = __arrL({
        "roca",
        "escola",
        "academia",
        "quadra",
        "praca",
        "favela",
        "caderno",
        "campo",
        "bigodon",
        "patio",
        "rayssa"
    }, 11)
    local function placeOf(self, key)
        local k = slug(nil, key)
        if not __t(k) then
            return nil
        end
        if __t(__call(k, "includes", ".")) then
            local ____re_test_result_7
            if __re_test(
                __re("^[a-zA-Z0-9_.-]{1,90}$", ""),
                __call(key, "trim")
            ) then
                ____re_test_result_7 = __call(key, "trim")
            else
                ____re_test_result_7 = nil
            end
            return ____re_test_result_7
        end
        if __t(__get(PLACES, k)) then
            return __get(PLACES, k)
        end
        local m
        local ____t_11 = __t
        local ____t_result_10
        local ____t_9 = __t
        m = __re_match(
            k,
            __re("^chefe-([a-z]+)(?:-fase-?(\\d))?$", "")
        )
        local ____m_8 = m
        __O[2306] = ____m_8
        if ____t_9(____m_8) then
            ____t_result_10 = __get(
                BOSS,
                __get(m, 1)
            )
        else
            ____t_result_10 = __O[2306]
        end
        if ____t_11(____t_result_10) then
            local ____add_14 = __add
            local ____add_result_13 = __add(
                "battles.",
                __get(
                    BOSS,
                    __get(m, 1)
                )
            )
            local ____t_result_12
            if __t(__get(m, 2)) then
                ____t_result_12 = __add(
                    ".phase",
                    __get(m, 2)
                )
            else
                ____t_result_12 = ""
            end
            return ____add_14(____add_result_13, ____t_result_12)
        end
        local ____t_18 = __t
        local ____t_result_17
        local ____t_16 = __t
        m = __re_match(
            k,
            __re("^apresentacao-([a-z]+)$", "")
        )
        local ____m_15 = m
        __O[2307] = ____m_15
        if ____t_16(____m_15) then
            ____t_result_17 = __get(
                BOSS,
                __get(m, 1)
            )
        else
            ____t_result_17 = __O[2307]
        end
        if ____t_18(____t_result_17) then
            return __add(
                "events.boss_",
                __get(m, 1) == "reeis" and "reeis" or __get(
                    BOSS,
                    __get(m, 1)
                )
            )
        end
        local ____t_19 = __t
        m = __re_match(
            k,
            __re("^cutscene-([a-z0-9_-]+)$", "")
        )
        if ____t_19(m) then
            return __add(
                "cutscenes.",
                __re_replace(
                    __get(m, 1),
                    __re("-", "g"),
                    "_"
                )
            )
        end
        local ____t_20 = __t
        m = __re_match(
            k,
            __re("^conversa-([a-z]+)$", "")
        )
        if ____t_20(m) then
            return __add(
                "characters.",
                __get(m, 1)
            )
        end
        local ____t_21 = __t
        m = __re_match(
            k,
            __re("^fliperama-([a-z]+)$", "")
        )
        if ____t_21(m) then
            return __add(
                "minigames.fliperama.",
                __get(m, 1)
            )
        end
        local ____t_22 = __t
        m = __re_match(
            k,
            __re("^minigame-([a-z]+)$", "")
        )
        if ____t_22(m) then
            return __add(
                "activities.",
                __get(m, 1)
            )
        end
        local ____t_23 = __t
        m = __re_match(
            k,
            __re("^evento-([a-z0-9_-]+)$", "")
        )
        if ____t_23(m) then
            return __add(
                "events.",
                __re_replace(
                    __get(m, 1),
                    __re("-", "g"),
                    "_"
                )
            )
        end
        local ____t_27 = __t
        local ____t_result_26
        local ____t_25 = __t
        m = __re_match(
            k,
            __re("^dupla-([a-z]+)$", "")
        )
        local ____m_24 = m
        __O[2308] = ____m_24
        if ____t_25(____m_24) then
            ____t_result_26 = __get(
                BOSS,
                __get(m, 1)
            )
        else
            ____t_result_26 = __O[2308]
        end
        if ____t_27(____t_result_26) then
            return __add(
                "coop.",
                __get(
                    BOSS,
                    __get(m, 1)
                )
            )
        end
        return nil
    end
    local function parseTxt(self, text)
        local lines = __arrL({}, 0)
        local warnings = __arrL({}, 0)
        local ambient = {}
        local ____call_36 = __call
        local ____re_split_29 = __re_split
        local ____t_result_28
        if __t(text) then
            ____t_result_28 = text
        else
            ____t_result_28 = ""
        end
        ____call_36(
            ____re_split_29(
                tostring(____t_result_28),
                __re("\\r?\\n", "")
            ),
            "forEach",
            function(____, raw, n)
                local line = __call(
                    __re_replace(
                        raw,
                        __re("#.*$", ""),
                        ""
                    ),
                    "trim"
                )
                if not __t(line) then
                    return
                end
                local eq = __call(line, "indexOf", "=")
                if eq < 0 then
                    __call(
                        warnings,
                        "push",
                        __add(
                            __add("linha ", n + 1),
                            ": falta o \"=\""
                        )
                    )
                    return
                end
                local key = __call(
                    __call(line, "slice", 0, eq),
                    "trim"
                )
                local rest = __call(
                    __call(line, "slice", eq + 1),
                    "trim"
                )
                local fm = __re_match(
                    rest,
                    __re("^(.+?\\.(?:mp3|ogg|m4a|wav))(?:\\s+(.*))?$", "i")
                )
                if not __t(fm) then
                    __call(
                        warnings,
                        "push",
                        __add(
                            __add("linha ", n + 1),
                            ": escreva o nome do arquivo com .mp3, .ogg ou .m4a"
                        )
                    )
                    return
                end
                local file = __re_replace(
                    __call(
                        __get(fm, 1),
                        "trim"
                    ),
                    __re("^\\.?\\/?(dist\\/)?musicas\\/", ""),
                    ""
                )
                local opts = {}
                local ____iter_35 = __iter
                local ____call_34 = __call
                local ____re_split_33 = __re_split
                local ____t_result_32
                local ____t_31 = __t
                local ____get_result_30 = __get(fm, 2)
                __O[2309] = ____get_result_30
                if ____t_31(____get_result_30) then
                    ____t_result_32 = __O[2309]
                else
                    ____t_result_32 = ""
                end
                for ____, tok in __TS__Iterator(____iter_35(____call_34(
                    ____re_split_33(
                        ____t_result_32,
                        __re("\\s+", "")
                    ),
                    "filter",
                    window.Boolean
                ))) do
                    local k, v = table.unpack(
                        __call(
                            __call(tok, "toLowerCase"),
                            "split",
                            "="
                        ),
                        1,
                        2
                    )
                    if k == "volume" then
                        opts.volume = math.max(
                            0,
                            math.min(
                                1,
                                __TS__Number(v)
                            )
                        )
                    elseif k == "fade" then
                        opts.fadeMs = math.max(
                            0,
                            math.min(
                                10,
                                __TS__Number(v)
                            )
                        ) * 1000
                    elseif k == "inicio" then
                        opts.startSeconds = math.max(
                            0,
                            __TS__Number(v)
                        )
                    elseif k == "atraso" then
                        opts.delaySeconds = math.max(
                            0,
                            __TS__Number(v)
                        )
                    elseif k == "sem-repetir" then
                        opts.loop = false
                    elseif k == "repetir" then
                        opts.loop = true
                    end
                end
                local s = slug(nil, key)
                if __t(__call(s, "startsWith", "ambiente-")) then
                    local where = __call(s, "slice", 9) == "camacan" and "praca" or (__call(s, "slice", 9) == "tinta" and "caderno" or __call(s, "slice", 9))
                    if __t(__call(AMBIENT, "includes", where)) then
                        __set(
                            ambient,
                            where,
                            __add("musicas/", file)
                        )
                    else
                        __call(
                            warnings,
                            "push",
                            __add(
                                __add(
                                    __add(
                                        __add("linha ", n + 1),
                                        ": lugar de ambiente desconhecido \""
                                    ),
                                    key
                                ),
                                "\""
                            )
                        )
                    end
                    return
                end
                local place = placeOf(nil, key)
                if not __t(place) then
                    __call(
                        warnings,
                        "push",
                        __add(
                            __add(
                                __add(
                                    __add("linha ", n + 1),
                                    ": lugar desconhecido \""
                                ),
                                key
                            ),
                            "\""
                        )
                    )
                    return
                end
                __call(lines, "push", {place = place, file = file, opts = opts})
            end
        )
        return {lines = lines, warnings = warnings, ambient = ambient}
    end
    local ambientMap = {}
    local lastWarnings = __arrL({}, 0)
    local loaded = nil
    local function getText(self, url)
        return __TS__AsyncAwaiter(function(____awaiter_resolve)
            local ____hasReturned, ____returnValue
            local ____try = __TS__AsyncAwaiter(function()
                local r = __TS__Await(window:fetch(url, {cache = "no-cache"}))
                local ____t_result_37
                if __t(r.ok) then
                    ____t_result_37 = __TS__Await(r:text())
                else
                    ____t_result_37 = nil
                end
                ____hasReturned = true
                ____returnValue = ____t_result_37
                return
            end)
            ____try = ____try.catch(
                ____try,
                function(____, e)
                    return __TS__AsyncAwaiter(function()
                        ____hasReturned = true
                        ____returnValue = nil
                        return
                    end)
                end
            )
            __TS__Await(____try)
            if ____hasReturned then
                return ____awaiter_resolve(nil, ____returnValue)
            end
        end)
    end
    local function load(self)
        if __t(loaded) then
            return loaded
        end
        loaded = (function()
            return __TS__AsyncAwaiter(function(____awaiter_resolve)
                local ____t_result_38
                if __t(window.DAROCA_MUSICAS) then
                    ____t_result_38 = window.DAROCA_MUSICAS
                else
                    ____t_result_38 = nil
                end
                local pre = ____t_result_38
                local list = nil
                local txt = nil
                local lj = __TS__Await(getText(nil, "musicas/lista.json"))
                if __t(lj) then
                    local ____try = __TS__AsyncAwaiter(function()
                        list = window.JSON:parse(lj)
                    end)
                    ____try = ____try.catch(
                        ____try,
                        function(____, e)
                            return __TS__AsyncAwaiter(function()
                            end)
                        end
                    )
                    __TS__Await(____try)
                end
                txt = __TS__Await(getText(nil, "musicas/musicas.txt"))
                local ____t_42 = __t
                local ____t_result_41
                local ____t_40 = __t
                local ____temp_39 = not __t(list)
                __O[2310] = ____temp_39
                if ____t_40(____temp_39) then
                    ____t_result_41 = pre
                else
                    ____t_result_41 = __O[2310]
                end
                if ____t_42(____t_result_41) then
                    list = pre
                end
                local ____t_46 = __t
                local ____t_result_45
                local ____t_44 = __t
                local ____temp_43 = txt == nil
                __O[2311] = ____temp_43
                if ____t_44(____temp_43) then
                    ____t_result_45 = pre
                else
                    ____t_result_45 = __O[2311]
                end
                if ____t_46(____t_result_45) then
                    local ____t_result_47
                    if __t(pre.txt) then
                        ____t_result_47 = pre.txt
                    else
                        ____t_result_47 = ""
                    end
                    txt = ____t_result_47
                end
                local ____call_60 = __call
                local ____t_result_52
                local ____t_51 = __t
                local ____opt_result_50
                if list ~= nil then
                    ____opt_result_50 = list.arquivos
                end
                __O[2312] = ____opt_result_50
                if ____t_51(____opt_result_50) then
                    ____t_result_52 = __O[2312]
                else
                    ____t_result_52 = __arrL({}, 0)
                end
                local files = ____call_60(
                    ____t_result_52,
                    "filter",
                    function(____, f)
                        local ____t_result_59
                        local ____t_58 = __t
                        local ____t_result_57
                        local ____t_56 = __t
                        local ____t_result_55
                        local ____t_54 = __t
                        local ____t_result_53
                        if __t(f) then
                            ____t_result_53 = type(f.nome) == "string"
                        else
                            ____t_result_53 = f
                        end
                        __O[2313] = ____t_result_53
                        if ____t_54(____t_result_53) then
                            ____t_result_55 = EXT:test(f.nome)
                        else
                            ____t_result_55 = __O[2313]
                        end
                        __O[2314] = ____t_result_55
                        if ____t_56(____t_result_55) then
                            ____t_result_57 = not __re_test(
                                __re("\\\\|\\.\\.", ""),
                                f.nome
                            )
                        else
                            ____t_result_57 = __O[2314]
                        end
                        __O[2315] = ____t_result_57
                        if ____t_58(____t_result_57) then
                            ____t_result_59 = __re_test(
                                __re("^[^/]+(\\/[^/]+)?$", ""),
                                f.nome
                            )
                        else
                            ____t_result_59 = __O[2315]
                        end
                        return ____t_result_59
                    end
                )
                local ____parseTxt_62 = parseTxt
                local ____t_result_61
                if __t(txt) then
                    ____t_result_61 = txt
                else
                    ____t_result_61 = ""
                end
                local parsed = ____parseTxt_62(nil, ____t_result_61)
                ambientMap = parsed.ambient
                local ____call_69 = __call
                local ____parsed_warnings_68 = parsed.warnings
                local ____t_result_67
                local ____t_66 = __t
                local ____opt_result_65
                if list ~= nil then
                    ____opt_result_65 = list.avisos
                end
                __O[2316] = ____opt_result_65
                if ____t_66(____opt_result_65) then
                    ____t_result_67 = __O[2316]
                else
                    ____t_result_67 = __arrL({}, 0)
                end
                lastWarnings = ____call_69(____parsed_warnings_68, "concat", ____t_result_67)
                local tracks = __arrL({}, 0)
                local bindings = {}
                local byName = __TS__New(Map)
                local function track(____, name, meta)
                    if meta == nil then
                        meta = {}
                    end
                    if __t(__call(byName, "has", name)) then
                        return __call(byName, "get", name)
                    end
                    local id = __add(
                        __add(
                            __add(
                                "m-",
                                __call(
                                    __re_replace(
                                        slug(nil, name),
                                        __re("\\.", "g"),
                                        "-"
                                    ),
                                    "slice",
                                    0,
                                    60
                                )
                            ),
                            "-"
                        ),
                        __len(tracks) + 1
                    )
                    local ____id_76 = id
                    local ____re_replace_result_77 = __re_replace(
                        __call(name, "replace", EXT, ""),
                        __re("^.*\\/", ""),
                        ""
                    )
                    local ____add_result_78 = __add("musicas/", name)
                    local ____t_result_72
                    local ____t_71 = __t
                    local ____TS__Number_result_70 = __TS__Number(meta.bytes)
                    __O[2317] = ____TS__Number_result_70
                    if ____t_71(____TS__Number_result_70) then
                        ____t_result_72 = __O[2317]
                    else
                        ____t_result_72 = 0
                    end
                    local ____t_result_75
                    local ____t_74 = __t
                    local ____TS__Number_result_73 = __TS__Number(meta.duracao)
                    __O[2318] = ____TS__Number_result_73
                    if ____t_74(____TS__Number_result_73) then
                        ____t_result_75 = __O[2318]
                    else
                        ____t_result_75 = 0
                    end
                    local t = {
                        id = ____id_76,
                        title = ____re_replace_result_77,
                        categoryId = "pasta",
                        file = ____add_result_78,
                        sha256 = "",
                        bytes = ____t_result_72,
                        duration = ____t_result_75,
                        volume = 1,
                        loop = true,
                        fadeMs = 1200,
                        url = __add(
                            "musicas/",
                            window:encodeURI(name)
                        ),
                        ["local"] = true
                    }
                    __call(tracks, "push", t)
                    __call(byName, "set", name, t)
                    return t
                end
                for ____, f in __iterar((files)) do
                    do
                        if __t(__call(f.nome, "includes", "/")) then
                            continue
                        end
                        local place = placeOf(
                            nil,
                            __call(f.nome, "replace", EXT, "")
                        )
                        if __t(place) then
                            local ____set_80 = __set
                            local ____t_result_79
                            if __t(f.original) then
                                ____t_result_79 = f.original
                            else
                                ____t_result_79 = track(nil, f.nome, f).id
                            end
                            ____set_80(bindings, place, {trackId = ____t_result_79, enabled = true})
                        end
                    end
                end
                local porLugar = {}
                for ____, f in __iterar((files)) do
                    do
                        local ____t_84 = __t
                        local ____t_result_83
                        local ____t_82 = __t
                        local ____temp_81 = not __t(__call(f.nome, "includes", "/")) or type(f.lugar) ~= "string"
                        __O[2319] = ____temp_81
                        if ____t_82(____temp_81) then
                            ____t_result_83 = __O[2319]
                        else
                            ____t_result_83 = not __re_test(
                                __re("^[a-zA-Z0-9_.-]{1,90}$", ""),
                                f.lugar
                            )
                        end
                        if ____t_84(____t_result_83) then
                            continue
                        end
                        local ____call_86 = __call
                        do
                            __O[2320] = porLugar
                            __O[2321] = f.lugar
                        end
                        local ____t_result_85
                        if __t(__get(__O[2320], __O[2321])) then
                            ____t_result_85 = __get(__O[2320], __O[2321])
                        else
                            ____t_result_85 = __set(
                                __O[2320],
                                __O[2321],
                                __arrL({}, 0)
                            )
                        end
                        ____call_86(____t_result_85, "push", f)
                    end
                end
                for ____, ____value in __iterar((__entries(porLugar))) do
                    local lugar = ____value[1]
                    local fs = ____value[2]
                    local f = __get(
                        fs,
                        math.floor(math.random() * __len(fs))
                    )
                    local ____set_89 = __set
                    local ____lugar_88 = lugar
                    local ____t_result_87
                    if __t(f.original) then
                        ____t_result_87 = f.original
                    else
                        ____t_result_87 = track(nil, f.nome, f).id
                    end
                    ____set_89(bindings, ____lugar_88, {trackId = ____t_result_87, enabled = true})
                end
                for ____, l in __iterar((parsed.lines)) do
                    local meta = __call(
                        files,
                        "find",
                        function(____, f) return f.nome == l.file end
                    )
                    local ____t_93 = __t
                    local ____t_result_92
                    local ____t_91 = __t
                    local ____temp_90 = not __t(meta)
                    __O[2322] = ____temp_90
                    if ____t_91(____temp_90) then
                        ____t_result_92 = __len(files)
                    else
                        ____t_result_92 = __O[2322]
                    end
                    if ____t_93(____t_result_92) then
                        __call(
                            lastWarnings,
                            "push",
                            __add("arquivo não encontrado na pasta: ", l.file)
                        )
                    end
                    local ____l_file_95 = l.file
                    local ____t_result_94
                    if __t(meta) then
                        ____t_result_94 = meta
                    else
                        ____t_result_94 = {}
                    end
                    local t = track(nil, ____l_file_95, ____t_result_94)
                    __set(
                        bindings,
                        l.place,
                        __assign({}, {trackId = t.id, enabled = true}, l.opts)
                    )
                end
                if __t(__len(lastWarnings)) then
                    local ____try = __TS__AsyncAwaiter(function()
                        print(
                            "Músicas:",
                            __call(lastWarnings, "join", " · ")
                        )
                    end)
                    ____try = ____try.catch(
                        ____try,
                        function(____, e)
                            return __TS__AsyncAwaiter(function()
                            end)
                        end
                    )
                    __TS__Await(____try)
                end
                return ____awaiter_resolve(nil, {tracks = tracks, bindings = bindings, warnings = lastWarnings})
            end)
        end)(nil)
        return loaded
    end
    window.DarocaMusicas = __ord(
        {
            load = load,
            reload = function()
                loaded = nil
                return load(nil)
            end,
            ambient = function() return __assign({}, ambientMap) end,
            warnings = function() return __call(lastWarnings, "slice") end,
            placeOf = placeOf,
            parse = parseTxt
        },
        "load,reload,ambient,warnings,placeOf,parse"
    )
end)(nil)
return ____exports
