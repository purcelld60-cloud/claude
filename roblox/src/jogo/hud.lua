--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __gt, __ge, __getq, __callq, __ord, __arrL, __iterar, __t, __get, __call, __add, __new = __JSR.__gt, __JSR.__ge, __JSR.__getq, __JSR.__callq, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__call, __JSR.__add, __JSR.__new
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Number = ____lualib.__TS__Number
local __TS__Iterator = ____lualib.__TS__Iterator
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    local shell = window.document:getElementById("gameShell")
    local hud = window.document:getElementById("bossHud")
    local ending = window.document:getElementById("chapterEndScreen")
    local endCanvas = window.document:getElementById("endingCanvas")
    local ____t_5 = __t
    local ____t_result_4
    local ____t_3 = __t
    local ____t_result_2
    local ____t_1 = __t
    local ____temp_0 = not __t(shell) or not __t(hud)
    __O[3084] = ____temp_0
    if ____t_1(____temp_0) then
        ____t_result_2 = __O[3084]
    else
        ____t_result_2 = not __t(ending)
    end
    __O[3085] = ____t_result_2
    if ____t_3(____t_result_2) then
        ____t_result_4 = __O[3085]
    else
        ____t_result_4 = not __t(endCanvas)
    end
    if ____t_5(____t_result_4) then
        return
    end
    local fill = window.document:getElementById("bossHudFill")
    local meter = window.document:getElementById("bossHudMeter")
    local name = window.document:getElementById("bossHudName")
    local phase = window.document:getElementById("bossHudPhase")
    local value = window.document:getElementById("bossHudValue")
    local cue = window.document:getElementById("bossHudCue")
    local endContext = endCanvas:getContext("2d")
    local last = 0
    local endAt = 0
    local wasEnding = false
    local lastFilm = ""
    local heading = hud:querySelector(".boss-hud-heading")
    if heading ~= nil then
        heading:append(value)
    end
    __call(phase.classList, "add", "boss-phase-pips")
    phase:setAttribute("role", "img")
    local phaseCount = 0
    local lastBossType = ""
    local lastPhase = 0
    local phaseGlowTimer = 0
    local function renderBossPhase(self, boss)
        local ____t_result_10
        local ____t_9 = __t
        local ____TS__Number_result_8 = __TS__Number(boss.phaseCount)
        __O[3086] = ____TS__Number_result_8
        if ____t_9(____TS__Number_result_8) then
            ____t_result_10 = __O[3086]
        else
            ____t_result_10 = 3
        end
        local count = math.max(
            1,
            math.min(
                5,
                math.floor(____t_result_10)
            )
        )
        local ____t_result_13
        local ____t_12 = __t
        local ____TS__Number_result_11 = __TS__Number(boss.phase)
        __O[3087] = ____TS__Number_result_11
        if ____t_12(____TS__Number_result_11) then
            ____t_result_13 = __O[3087]
        else
            ____t_result_13 = 1
        end
        local current = math.max(
            1,
            math.min(
                count,
                math.floor(____t_result_13)
            )
        )
        if count ~= phaseCount then
            phaseCount = count
            phase:replaceChildren()
            do
                local n = 1
                while n <= count do
                    local mark = window.document:createElement("i")
                    mark.dataset.phase = tostring(n)
                    mark:setAttribute("aria-hidden", "true")
                    phase:append(mark)
                    n = n + 1
                end
            end
            local caption = window.document:createElement("span")
            caption.className = "boss-phase-caption"
            caption:setAttribute("aria-hidden", "true")
            phase:append(caption)
        end
        phase:querySelector(".boss-phase-caption").textContent = __add(
            __add(current, "/"),
            count
        )
        phase:setAttribute(
            "aria-label",
            __add(
                __add(
                    __add("Fase ", current),
                    " de "
                ),
                count
            )
        )
        local ____add_16 = __add
        local ____add_result_15 = __add(
            __add(
                __add("Fase ", current),
                " de "
            ),
            count
        )
        local ____t_result_14
        if __t(boss.phaseName) then
            ____t_result_14 = __add(" · ", boss.phaseName)
        else
            ____t_result_14 = ""
        end
        phase.title = ____add_16(____add_result_15, ____t_result_14)
        for ____, pip in __iterar((phase:querySelectorAll("i[data-phase]"))) do
            pip.classList:toggle(
                "active",
                __TS__Number(pip.dataset.phase) <= current
            )
        end
        hud.dataset.phase = tostring(current)
        hud.dataset.phaseCount = tostring(count)
        if __t(lastBossType == boss.type and current > lastPhase) then
            window:clearTimeout(phaseGlowTimer)
            hud.classList:remove("phase-up")
            local ____ = hud.offsetWidth
            __call(hud.classList, "add", "phase-up")
            phaseGlowTimer = window:setTimeout(
                function() return hud.classList:remove("phase-up") end,
                800
            )
        end
        lastBossType = boss.type
        lastPhase = current
    end
    local statArt = __ord({vigor = "<path d=\"M24 4 40 10v12c0 11-7 18-16 23C15 40 8 33 8 22V10z\" fill=\"#597c4e\"/><path d=\"M24 4 40 10v12c0 11-7 18-16 23C15 40 8 33 8 22V10z\" fill=\"none\" stroke=\"#35553b\" stroke-width=\"2.5\"/><path d=\"M24 32 14 22c-5-7 4-14 10-7 6-7 15 0 10 7z\" fill=\"#f6c486\"/><path d=\"m15 13 7-3\" stroke=\"#9dc18a\" stroke-width=\"2\"/>", forca = "<path d=\"m14 33 18-22 7 6-20 24-7 2z\" fill=\"#9a5e33\" stroke=\"#684126\" stroke-width=\"2.5\"/><path d=\"m8 12 8-7 21 17-8 10z\" fill=\"#6d8490\" stroke=\"#3e5663\" stroke-width=\"2.5\"/><path d=\"m12 12 4-3 15 12-4 3z\" fill=\"#b5c4bd\"/><path d=\"m9 41 8 3m17-5 6 2m-3-9 7-1\" stroke=\"#d2a44e\" stroke-width=\"2.5\" stroke-linecap=\"round\"/>", gas = "<path d=\"M16 10h16v5l5 6v20H11V21l5-6z\" fill=\"#78975c\" stroke=\"#455b37\" stroke-width=\"2.5\"/><path d=\"M18 4h12v7H18z\" fill=\"#ddbc70\" stroke=\"#8e7139\" stroke-width=\"2\"/><path d=\"m27 17-10 14h8l-3 10 12-16h-8z\" fill=\"#ffe19b\"/><path d=\"M15 20v14\" stroke=\"#a8bd7a\" stroke-width=\"2\"/><path d=\"M7 17 3 14m38 3 4-3M5 29H1m42 0h4\" stroke=\"#b59c59\" stroke-width=\"2\" stroke-linecap=\"round\"/>", agilidade = "<path d=\"m20 6 13 3-2 21 11 5v8H12l-4-7 9-6z\" fill=\"#a66c3f\" stroke=\"#674629\" stroke-width=\"2.5\"/><path d=\"m20 7 13 3-1 6-13-3z\" fill=\"#d6b15c\"/><path d=\"M13 36h13l5-6m-17 9h24\" fill=\"none\" stroke=\"#e6c891\" stroke-width=\"2.5\"/><path d=\"m20 20 10 2m-11 4 10 2M4 17h9M2 23h10M5 29h5\" stroke=\"#6c8748\" stroke-width=\"2.5\" stroke-linecap=\"round\"/>"}, "vigor,forca,gas,agilidade")
    local statsModal = window.document:getElementById("statsModal")
    local function ranchStats(self)
        local ____t_20 = __t
        local ____t_result_19
        local ____t_18 = __t
        local ____temp_17 = not __t(statsModal)
        __O[3088] = ____temp_17
        if ____t_18(____temp_17) then
            ____t_result_19 = __O[3088]
        else
            ____t_result_19 = statsModal.dataset.ranchReady
        end
        if ____t_20(____t_result_19) then
            return
        end
        statsModal.dataset.ranchReady = "true"
        local title = statsModal:querySelector("h2")
        if __t(title) then
            local seed = window.document:createElement("span")
            seed.className = "stats-title-sprig"
            seed:setAttribute("aria-hidden", "true")
            seed.innerHTML = "<svg viewBox=\"0 0 36 44\"><path d=\"M18 41V9m0 24L8 24m10 0L28 15\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"3\"/><path d=\"M18 12C6 14 5 5 7 2c9 0 13 4 11 10Zm0 14C5 28 3 21 5 16c9-1 14 4 13 10Zm1-7C31 21 34 12 31 8c-9 0-14 5-12 11Z\" fill=\"currentColor\"/></svg>"
            title:prepend(seed)
        end
        for ____, stat in __iterar((__arrL({"vigor", "forca", "gas", "agilidade"}, 4))) do
            do
                local number = window.document:getElementById(__add("stat-", stat))
                local row = number and number.parentElement
                local button = row and row:querySelector("[data-spend-stat]")
                if __t(not __t(row) or not __t(button)) then
                    continue
                end
                __call(row.classList, "add", "ranch-stat-row")
                row.dataset.stat = stat
                local ____callq_27 = __callq
                local ____opt_25 = row:querySelector("span")
                ____callq_27(____opt_25 and ____opt_25.classList, "add", "ranch-stat-copy")
                local icon = window.document:createElement("span")
                icon.className = "ranch-stat-icon"
                icon:setAttribute("aria-hidden", "true")
                icon.innerHTML = __add(
                    __add(
                        "<svg viewBox=\"0 0 48 48\">",
                        __get(statArt, stat)
                    ),
                    "</svg>"
                )
                row:prepend(icon)
                local growth = window.document:createElement("span")
                growth.className = "ranch-stat-growth"
                growth:setAttribute("aria-hidden", "true")
                growth.innerHTML = "<i></i>"
                row:append(growth)
                __call(button.classList, "add", "ranch-stat-up")
                button.innerHTML = "<svg viewBox=\"0 0 24 24\" aria-hidden=\"true\"><path d=\"M12 4v16M4 12h16\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"3\" stroke-linecap=\"square\"/></svg><small>UPAR</small>"
                button.title = __add(
                    "Investir 1 ponto em ",
                    __get({vigor = "Vigor", forca = "Força", gas = "Gás", agilidade = "Agilidade"}, stat)
                )
            end
        end
        local footer = window.document:createElement("p")
        footer.className = "stats-ranch-note"
        footer.textContent = "Cada ponto é semente. Cultive o seu jeito de vencer."
        local ____opt_28 = statsModal:querySelector(".primary-btn")
        if ____opt_28 ~= nil then
            ____opt_28:before(footer)
        end
    end
    local function updateRanchStats(self)
        local ____opt_32 = window.Progression
        if ____opt_32 ~= nil then
            ____opt_32 = ____opt_32.getState
        end
        local ____opt_result_34
        if ____opt_32 ~= nil then
            ____opt_result_34 = ____opt_32(____opt_32)
        end
        local state = ____opt_result_34
        if __t(not __t(state) or not __t(statsModal)) then
            return
        end
        statsModal.dataset.available = __gt(state.points, 0) and "true" or "false"
        for ____, stat in __iterar((__arrL({"vigor", "forca", "gas", "agilidade"}, 4))) do
            local row = statsModal:querySelector(__add(
                __add("[data-stat=\"", stat),
                "\"]"
            ))
            local ____t_result_37
            local ____t_36 = __t
            local ____TS__Number_result_35 = __TS__Number(__getq(state.stats, stat))
            __O[3089] = ____TS__Number_result_35
            if ____t_36(____TS__Number_result_35) then
                ____t_result_37 = __O[3089]
            else
                ____t_result_37 = 0
            end
            local level = ____t_result_37
            local ____t_result_38
            if __t(state.teto) then
                ____t_result_38 = state.teto
            else
                ____t_result_38 = 0
            end
            local teto = ____t_result_38
            if row ~= nil then
                local ____self_42 = row.style
                local ____self_42_setProperty_43 = ____self_42.setProperty
                local ____add_41 = __add
                local ____t_result_40
                if __t(teto) then
                    ____t_result_40 = math.min(100, level / teto * 100)
                else
                    ____t_result_40 = 100
                end
                ____self_42_setProperty_43(
                    ____self_42,
                    "--stat-growth",
                    ____add_41(____t_result_40, "%")
                )
            end
            if row ~= nil then
                row.classList:toggle(
                    "at-cap",
                    not not __t(teto) and __ge(level, teto)
                )
            end
        end
    end
    ranchStats(nil)
    updateRanchStats(nil)
    window:addEventListener("progression-change", updateRanchStats)
    window.document:getElementById("endingMenuBtn"):addEventListener(
        "click",
        function()
            local ____opt_49 = window.Game
            if ____opt_49 ~= nil then
                ____opt_49 = ____opt_49.returnToMenu
            end
            local ____opt_result_51
            if ____opt_49 ~= nil then
                ____opt_result_51 = ____opt_49(____opt_49)
            end
            return ____opt_result_51
        end
    )
    window.document:getElementById("endingExploreBtn"):addEventListener(
        "click",
        function()
            local ____opt_54 = window.Game
            if ____opt_54 ~= nil then
                ____opt_54 = ____opt_54.continueExploring
            end
            local ____opt_result_56
            if ____opt_54 ~= nil then
                ____opt_result_56 = ____opt_54(____opt_54)
            end
            return ____opt_result_56
        end
    )
    local ____opt_57 = window.document:getElementById("defeatStatsBtn")
    if ____opt_57 ~= nil then
        ____opt_57:addEventListener(
            "click",
            function()
                local ____opt_58 = window.document:getElementById("statsBtn")
                return ____opt_58 and ____opt_58:click()
            end
        )
    end
    local sound = window.document:createElement("button")
    sound.type = "button"
    sound.id = "epilogueSoundBtn"
    sound.className = "epilogue-sound"
    sound:setAttribute("aria-label", "Ativar ou desativar som da cena")
    local sourceSound = window.document:getElementById("soundBtn")
    local function updateSound(self)
        local on = (sourceSound and sourceSound:getAttribute("aria-pressed")) == "true"
        sound.textContent = __t(on) and "SOM LIGADO" or "LIGAR SOM"
        sound:setAttribute(
            "aria-pressed",
            tostring(on)
        )
    end
    sound:addEventListener(
        "click",
        function()
            if sourceSound ~= nil then
                sourceSound:click()
            end
            updateSound(nil)
        end
    )
    local ____opt_65 = window.document:querySelector(".cinematic-buttons")
    if ____opt_65 ~= nil then
        ____opt_65:append(sound)
    end
    if sourceSound ~= nil then
        sourceSound:addEventListener("click", updateSound)
    end
    updateSound(nil)
    local replay = window.document:createElement("button")
    replay.type = "button"
    replay.id = "replayEpilogueBtn"
    replay.className = "text-button"
    replay.textContent = "Rever o epílogo"
    replay.hidden = true
    replay:addEventListener(
        "click",
        function()
            local ____opt_71 = window.Game
            if ____opt_71 ~= nil then
                ____opt_71 = ____opt_71.resume
            end
            if ____opt_71 ~= nil then
                ____opt_71(____opt_71)
            end
            local ____opt_75 = window.Game
            if ____opt_75 ~= nil then
                ____opt_75 = ____opt_75.replayEpilogue
            end
            if ____opt_75 ~= nil then
                ____opt_75(____opt_75)
            end
        end
    )
    local ____opt_77 = window.document:querySelector("#pauseScreen .game-modal")
    if ____opt_77 ~= nil then
        ____opt_77:append(replay)
    end
    local pause = window.document:getElementById("pauseScreen")
    if __t(pause) then
        __new(
            "MutationObserver",
            function()
                if not __t(pause.hidden) then
                    local ____t_87 = __t
                    local ____opt_83 = window.Game
                    if ____opt_83 ~= nil then
                        ____opt_83 = ____opt_83.getState
                    end
                    local ____opt_result_85
                    if ____opt_83 ~= nil then
                        ____opt_result_85 = ____opt_83(____opt_83).q
                    end
                    local ____opt_result_86
                    if ____opt_result_85 ~= nil then
                        ____opt_result_86 = ____opt_result_85.jorgeSeen
                    end
                    replay.hidden = not ____t_87(____opt_result_86)
                end
            end
        ):observe(
            pause,
            __ord(
                {
                    attributes = true,
                    attributeFilter = __arrL({"hidden"}, 1)
                },
                "attributes,attributeFilter"
            )
        )
    end
    local function tick(self, now)
        local ____t_93 = __t
        local ____opt_90 = window.Campanha2
        if ____opt_90 ~= nil then
            ____opt_90 = ____opt_90.aberto
        end
        local ____opt_result_92
        if ____opt_90 ~= nil then
            ____opt_result_92 = ____opt_90(____opt_90)
        end
        if ____t_93(____opt_result_92) then
            window:requestAnimationFrame(tick)
            return
        end
        if now - last >= 60 then
            last = now
            local ____t_result_102
            local ____t_101 = __t
            local ____t_result_100
            local ____t_99 = __t
            local ____t_result_98
            local ____t_97 = __t
            local ____t_result_96
            local ____t_95 = __t
            local ____temp_94 = shell.classList:contains("in-main-menu")
            __O[3090] = ____temp_94
            if ____t_95(____temp_94) then
                ____t_result_96 = __O[3090]
            else
                ____t_result_96 = shell.classList:contains("is-cutscene")
            end
            __O[3091] = ____t_result_96
            if ____t_97(____t_result_96) then
                ____t_result_98 = __O[3091]
            else
                ____t_result_98 = shell.classList:contains("is-dialog")
            end
            __O[3092] = ____t_result_98
            if ____t_99(____t_result_98) then
                ____t_result_100 = __O[3092]
            else
                ____t_result_100 = shell.classList:contains("is-paused")
            end
            __O[3093] = ____t_result_100
            if ____t_101(____t_result_100) then
                ____t_result_102 = __O[3093]
            else
                ____t_result_102 = shell.classList:contains("is-chapter-ended")
            end
            local hidden = ____t_result_102
            local ____t_result_108
            if __t(hidden) then
                ____t_result_108 = nil
            else
                local ____opt_105 = window.Game
                if ____opt_105 ~= nil then
                    ____opt_105 = ____opt_105.getBossStatus
                end
                local ____opt_result_107
                if ____opt_105 ~= nil then
                    ____opt_result_107 = ____opt_105(____opt_105)
                end
                ____t_result_108 = ____opt_result_107
            end
            local boss = ____t_result_108
            hud.hidden = not __t(boss)
            if __t(boss) then
                local ____t_result_111
                local ____t_110 = __t
                local ____TS__Number_result_109 = __TS__Number(boss.hp)
                __O[3094] = ____TS__Number_result_109
                if ____t_110(____TS__Number_result_109) then
                    ____t_result_111 = __O[3094]
                else
                    ____t_result_111 = 0
                end
                local hp = math.max(0, ____t_result_111)
                local ____t_result_116
                local ____t_115 = __t
                local ____t_result_114
                local ____t_113 = __t
                local ____TS__Number_result_112 = __TS__Number(boss.phaseMaxHp)
                __O[3095] = ____TS__Number_result_112
                if ____t_113(____TS__Number_result_112) then
                    ____t_result_114 = __O[3095]
                else
                    ____t_result_114 = __TS__Number(boss.max)
                end
                __O[3096] = ____t_result_114
                if ____t_115(____t_result_114) then
                    ____t_result_116 = __O[3096]
                else
                    ____t_result_116 = 1
                end
                local max = math.max(1, ____t_result_116)
                local ratio = math.max(
                    0,
                    math.min(1, hp / max)
                )
                hud.dataset.boss = boss.type
                name.textContent = boss.name
                renderBossPhase(nil, boss)
                local ____hud_dataset_118 = hud.dataset
                local ____t_result_117
                if __t(boss.state) then
                    ____t_result_117 = boss.state
                else
                    ____t_result_117 = ""
                end
                ____hud_dataset_118.state = tostring(____t_result_117)
                value.textContent = __add(
                    __add(
                        math.ceil(hp),
                        " / "
                    ),
                    math.ceil(max)
                )
                fill.style.transform = __add(
                    __add("scaleX(", ratio),
                    ")"
                )
                meter:setAttribute(
                    "aria-valuemax",
                    tostring(math.ceil(max))
                )
                meter:setAttribute(
                    "aria-valuenow",
                    tostring(math.ceil(hp))
                )
                meter:setAttribute(
                    "aria-valuetext",
                    __add(
                        __add(
                            __add(
                                __add(
                                    __add(boss.name, ": "),
                                    math.ceil(hp)
                                ),
                                " de "
                            ),
                            math.ceil(max)
                        ),
                        " de vida"
                    )
                )
                local ____t_result_121
                local ____t_120 = __t
                local ____get_result_119 = __get({
                    underground = "NO ESGOTO",
                    windup = "PREPARANDO GOLPE",
                    recover = "ABERTURA PARA ATACAR",
                    dashing = "INVESTIDA",
                    firing = "DESVIE!"
                }, boss.state)
                __O[3097] = ____get_result_119
                if ____t_120(____get_result_119) then
                    ____t_result_121 = __O[3097]
                else
                    ____t_result_121 = "CHEFÃO"
                end
                cue.textContent = ____t_result_121
            end
            local film = __t(shell.classList:contains("is-epilogue")) and "jorge" or ""
            if film ~= lastFilm then
                lastFilm = film
                local skip = window.document:getElementById("cutsceneSkipBtn")
                if __t(skip) then
                    skip.textContent = __t(film) and "Pular epílogo" or "Pular história"
                end
                local ____opt_124 = window.GameView
                if ____opt_124 ~= nil then
                    ____opt_124 = ____opt_124.fit
                end
                if ____opt_124 ~= nil then
                    ____opt_124(____opt_124)
                end
            end
        end
        local on = not __t(ending.hidden)
        local ____t_127 = __t
        local ____t_result_126
        if __t(on) then
            ____t_result_126 = not __t(wasEnding)
        else
            ____t_result_126 = on
        end
        if ____t_127(____t_result_126) then
            endAt = now
            ending.classList:remove("show-options")
            local ____opt_130 = window.GameView
            if ____opt_130 ~= nil then
                ____opt_130 = ____opt_130.fit
            end
            if ____opt_130 ~= nil then
                ____opt_130(____opt_130)
            end
        end
        if __t(on) then
            local ____t_134 = __t
            local ____opt_132 = window.JorgeEpilogue
            if ____opt_132 ~= nil then
                ____opt_132 = ____opt_132.drawEnd
            end
            if ____t_134(____opt_132) then
                window.JorgeEpilogue:drawEnd(endContext, 8 + (now - endAt) / 1000)
            else
                endContext.fillStyle = "#030207"
                endContext:fillRect(0, 0, 960, 540)
            end
            ending.classList:toggle("show-options", now - endAt > 1800)
        end
        wasEnding = on
        window:requestAnimationFrame(tick)
    end
    window:requestAnimationFrame(tick)
end)(nil)
return ____exports
