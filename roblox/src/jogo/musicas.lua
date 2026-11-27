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
        return __re_replace(
            __re_replace(
                __re_replace(
                    __re_replace(
                        __call(
                            __call(
                                tostring(if __t(s) then s else ""),
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
            return if __re_test(
                __re("^[a-zA-Z0-9_.-]{1,90}$", ""),
                __call(key, "trim")
            ) then __call(key, "trim") else nil
        end
        if __t(__get(PLACES, k)) then
            return __get(PLACES, k)
        end
        local m
        local ____t_2 = __t
        local ____t_1 = __t
        m = __re_match(
            k,
            __re("^chefe-([a-z]+)(?:-fase-?(\\d))?$", "")
        )
        local ____m_0 = m
        __O[2287] = ____m_0
        if ____t_2(if ____t_1(____m_0) then __get(
            BOSS,
            __get(m, 1)
        ) else __O[2287]) then
            return __add(
                __add(
                    "battles.",
                    __get(
                        BOSS,
                        __get(m, 1)
                    )
                ),
                if __t(__get(m, 2)) then __add(
                    ".phase",
                    __get(m, 2)
                ) else ""
            )
        end
        local ____t_5 = __t
        local ____t_4 = __t
        m = __re_match(
            k,
            __re("^apresentacao-([a-z]+)$", "")
        )
        local ____m_3 = m
        __O[2288] = ____m_3
        if ____t_5(if ____t_4(____m_3) then __get(
            BOSS,
            __get(m, 1)
        ) else __O[2288]) then
            return __add("events.boss_", if __get(m, 1) == "reeis" then "reeis" else __get(
                BOSS,
                __get(m, 1)
            ))
        end
        local ____t_6 = __t
        m = __re_match(
            k,
            __re("^cutscene-([a-z0-9_-]+)$", "")
        )
        if ____t_6(m) then
            return __add(
                "cutscenes.",
                __re_replace(
                    __get(m, 1),
                    __re("-", "g"),
                    "_"
                )
            )
        end
        local ____t_7 = __t
        m = __re_match(
            k,
            __re("^conversa-([a-z]+)$", "")
        )
        if ____t_7(m) then
            return __add(
                "characters.",
                __get(m, 1)
            )
        end
        local ____t_8 = __t
        m = __re_match(
            k,
            __re("^fliperama-([a-z]+)$", "")
        )
        if ____t_8(m) then
            return __add(
                "minigames.fliperama.",
                __get(m, 1)
            )
        end
        local ____t_9 = __t
        m = __re_match(
            k,
            __re("^minigame-([a-z]+)$", "")
        )
        if ____t_9(m) then
            return __add(
                "activities.",
                __get(m, 1)
            )
        end
        local ____t_10 = __t
        m = __re_match(
            k,
            __re("^evento-([a-z0-9_-]+)$", "")
        )
        if ____t_10(m) then
            return __add(
                "events.",
                __re_replace(
                    __get(m, 1),
                    __re("-", "g"),
                    "_"
                )
            )
        end
        local ____t_13 = __t
        local ____t_12 = __t
        m = __re_match(
            k,
            __re("^dupla-([a-z]+)$", "")
        )
        local ____m_11 = m
        __O[2289] = ____m_11
        if ____t_13(if ____t_12(____m_11) then __get(
            BOSS,
            __get(m, 1)
        ) else __O[2289]) then
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
        __call(
            __re_split(
                tostring(if __t(text) then text else ""),
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
                local ____iter_18 = __iter
                local ____call_17 = __call
                local ____re_split_16 = __re_split
                local ____t_15 = __t
                local ____get_result_14 = __get(fm, 2)
                __O[2290] = ____get_result_14
                for ____, tok in __TS__Iterator(____iter_18(____call_17(
                    ____re_split_16(
                        if ____t_15(____get_result_14) then __O[2290] else "",
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
                    local where = if __call(s, "slice", 9) == "camacan" then "praca" else if __call(s, "slice", 9) == "tinta" then "caderno" else __call(s, "slice", 9)
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
                ____hasReturned = true
                ____returnValue = if __t(r.ok) then __TS__Await(r:text()) else nil
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
                local pre = if __t(window.DAROCA_MUSICAS) then window.DAROCA_MUSICAS else nil
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
                local ____t_21 = __t
                local ____t_20 = __t
                local ____temp_19 = not __t(list)
                __O[2291] = ____temp_19
                if ____t_21(if ____t_20(____temp_19) then pre else __O[2291]) then
                    list = pre
                end
                local ____t_24 = __t
                local ____t_23 = __t
                local ____temp_22 = txt == nil
                __O[2292] = ____temp_22
                if ____t_24(if ____t_23(____temp_22) then pre else __O[2292]) then
                    txt = if __t(pre.txt) then pre.txt else ""
                end
                local ____call_35 = __call
                local ____t_28 = __t
                local ____opt_result_27
                if list ~= nil then
                    ____opt_result_27 = list.arquivos
                end
                __O[2293] = ____opt_result_27
                local files = ____call_35(
                    if ____t_28(____opt_result_27) then __O[2293] else __arrL({}, 0),
                    "filter",
                    function(____, f)
                        local ____t_34 = __t
                        local ____t_32 = __t
                        local ____t_30 = __t
                        local ____temp_29 = if __t(f) then type(f.nome) == "string" else f
                        __O[2294] = ____temp_29
                        local ____temp_31 = if ____t_30(____temp_29) then EXT:test(f.nome) else __O[2294]
                        __O[2295] = ____temp_31
                        local ____temp_33 = if ____t_32(____temp_31) then not __re_test(
                            __re("\\\\|\\.\\.", ""),
                            f.nome
                        ) else __O[2295]
                        __O[2296] = ____temp_33
                        return if ____t_34(____temp_33) then __re_test(
                            __re("^[^/]+(\\/[^/]+)?$", ""),
                            f.nome
                        ) else __O[2296]
                    end
                )
                local parsed = parseTxt(nil, if __t(txt) then txt else "")
                ambientMap = parsed.ambient
                local ____call_41 = __call
                local ____parsed_warnings_40 = parsed.warnings
                local ____t_39 = __t
                local ____opt_result_38
                if list ~= nil then
                    ____opt_result_38 = list.avisos
                end
                __O[2297] = ____opt_result_38
                lastWarnings = ____call_41(____parsed_warnings_40, "concat", if ____t_39(____opt_result_38) then __O[2297] else __arrL({}, 0))
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
                    local ____id_46 = id
                    local ____re_replace_result_47 = __re_replace(
                        __call(name, "replace", EXT, ""),
                        __re("^.*\\/", ""),
                        ""
                    )
                    local ____add_result_48 = __add("musicas/", name)
                    local ____t_43 = __t
                    local ____TS__Number_result_42 = __TS__Number(meta.bytes)
                    __O[2298] = ____TS__Number_result_42
                    local ____temp_49 = if ____t_43(____TS__Number_result_42) then __O[2298] else 0
                    local ____t_45 = __t
                    local ____TS__Number_result_44 = __TS__Number(meta.duracao)
                    __O[2299] = ____TS__Number_result_44
                    local t = {
                        id = ____id_46,
                        title = ____re_replace_result_47,
                        categoryId = "pasta",
                        file = ____add_result_48,
                        sha256 = "",
                        bytes = ____temp_49,
                        duration = if ____t_45(____TS__Number_result_44) then __O[2299] else 0,
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
                    if __t(__call(f.nome, "includes", "/")) then
                        continue
                    end
                    local place = placeOf(
                        nil,
                        __call(f.nome, "replace", EXT, "")
                    )
                    if __t(place) then
                        __set(bindings, place, {trackId = if __t(f.original) then f.original else track(nil, f.nome, f).id, enabled = true})
                    end
                end
                local porLugar = {}
                for ____, f in __iterar((files)) do
                    local ____t_52 = __t
                    local ____t_51 = __t
                    local ____temp_50 = not __t(__call(f.nome, "includes", "/")) or type(f.lugar) ~= "string"
                    __O[2300] = ____temp_50
                    if ____t_52(if ____t_51(____temp_50) then __O[2300] else not __re_test(
                        __re("^[a-zA-Z0-9_.-]{1,90}$", ""),
                        f.lugar
                    )) then
                        continue
                    end
                    local ____call_53 = __call
                    do
                        __O[2301] = porLugar
                        __O[2302] = f.lugar
                    end
                    ____call_53(if __t(__get(__O[2301], __O[2302])) then __get(__O[2301], __O[2302]) else __set(
                        __O[2301],
                        __O[2302],
                        __arrL({}, 0)
                    ), "push", f)
                end
                for ____, ____value in __iterar((__entries(porLugar))) do
                    local lugar = ____value[1]
                    local fs = ____value[2]
                    local f = __get(
                        fs,
                        math.floor(math.random() * __len(fs))
                    )
                    __set(bindings, lugar, {trackId = if __t(f.original) then f.original else track(nil, f.nome, f).id, enabled = true})
                end
                for ____, l in __iterar((parsed.lines)) do
                    local meta = __call(
                        files,
                        "find",
                        function(____, f) return f.nome == l.file end
                    )
                    local ____t_56 = __t
                    local ____t_55 = __t
                    local ____temp_54 = not __t(meta)
                    __O[2303] = ____temp_54
                    if ____t_56(if ____t_55(____temp_54) then __len(files) else __O[2303]) then
                        __call(
                            lastWarnings,
                            "push",
                            __add("arquivo não encontrado na pasta: ", l.file)
                        )
                    end
                    local t = track(nil, l.file, if __t(meta) then meta else {})
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
