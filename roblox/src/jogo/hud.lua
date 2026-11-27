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
    local ____t_4 = __t
    local ____t_3 = __t
    local ____t_1 = __t
    local ____temp_0 = not __t(shell) or not __t(hud)
    __O[3044] = ____temp_0
    local ____temp_2 = if ____t_1(____temp_0) then __O[3044] else not __t(ending)
    __O[3045] = ____temp_2
    if ____t_4(if ____t_3(____temp_2) then __O[3045] else not __t(endCanvas)) then
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
        local ____t_8 = __t
        local ____TS__Number_result_7 = __TS__Number(boss.phaseCount)
        __O[3046] = ____TS__Number_result_7
        local count = math.max(
            1,
            math.min(
                5,
                math.floor(if ____t_8(____TS__Number_result_7) then __O[3046] else 3)
            )
        )
        local ____t_10 = __t
        local ____TS__Number_result_9 = __TS__Number(boss.phase)
        __O[3047] = ____TS__Number_result_9
        local current = math.max(
            1,
            math.min(
                count,
                math.floor(if ____t_10(____TS__Number_result_9) then __O[3047] else 1)
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
        phase.title = __add(
            __add(
                __add(
                    __add("Fase ", current),
                    " de "
                ),
                count
            ),
            if __t(boss.phaseName) then __add(" · ", boss.phaseName) else ""
        )
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
        local ____t_13 = __t
        local ____t_12 = __t
        local ____temp_11 = not __t(statsModal)
        __O[3048] = ____temp_11
        if ____t_13(if ____t_12(____temp_11) then __O[3048] else statsModal.dataset.ranchReady) then
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
            local number = window.document:getElementById(__add("stat-", stat))
            local row = number and number.parentElement
            local button = row and row:querySelector("[data-spend-stat]")
            if __t(not __t(row) or not __t(button)) then
                continue
            end
            __call(row.classList, "add", "ranch-stat-row")
            row.dataset.stat = stat
            local ____callq_20 = __callq
            local ____opt_18 = row:querySelector("span")
            ____callq_20(____opt_18 and ____opt_18.classList, "add", "ranch-stat-copy")
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
        local footer = window.document:createElement("p")
        footer.className = "stats-ranch-note"
        footer.textContent = "Cada ponto é semente. Cultive o seu jeito de vencer."
        local ____opt_21 = statsModal:querySelector(".primary-btn")
        if ____opt_21 ~= nil then
            ____opt_21:before(footer)
        end
    end
    local function updateRanchStats(self)
        local ____opt_25 = window.Progression
        if ____opt_25 ~= nil then
            ____opt_25 = ____opt_25.getState
        end
        local ____opt_result_27
        if ____opt_25 ~= nil then
            ____opt_result_27 = ____opt_25(____opt_25)
        end
        local state = ____opt_result_27
        if __t(not __t(state) or not __t(statsModal)) then
            return
        end
        statsModal.dataset.available = if __gt(state.points, 0) then "true" else "false"
        for ____, stat in __iterar((__arrL({"vigor", "forca", "gas", "agilidade"}, 4))) do
            local row = statsModal:querySelector(__add(
                __add("[data-stat=\"", stat),
                "\"]"
            ))
            local ____t_29 = __t
            local ____TS__Number_result_28 = __TS__Number(__getq(state.stats, stat))
            __O[3049] = ____TS__Number_result_28
            local level = if ____t_29(____TS__Number_result_28) then __O[3049] else 0
            local teto = if __t(state.teto) then state.teto else 0
            if row ~= nil then
                row.style:setProperty(
                    "--stat-growth",
                    __add(if __t(teto) then math.min(100, level / teto * 100) else 100, "%")
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
            local ____opt_36 = window.Game
            if ____opt_36 ~= nil then
                ____opt_36 = ____opt_36.returnToMenu
            end
            local ____opt_result_38
            if ____opt_36 ~= nil then
                ____opt_result_38 = ____opt_36(____opt_36)
            end
            return ____opt_result_38
        end
    )
    window.document:getElementById("endingExploreBtn"):addEventListener(
        "click",
        function()
            local ____opt_41 = window.Game
            if ____opt_41 ~= nil then
                ____opt_41 = ____opt_41.continueExploring
            end
            local ____opt_result_43
            if ____opt_41 ~= nil then
                ____opt_result_43 = ____opt_41(____opt_41)
            end
            return ____opt_result_43
        end
    )
    local ____opt_44 = window.document:getElementById("defeatStatsBtn")
    if ____opt_44 ~= nil then
        ____opt_44:addEventListener(
            "click",
            function()
                local ____opt_45 = window.document:getElementById("statsBtn")
                return ____opt_45 and ____opt_45:click()
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
        sound.textContent = if __t(on) then "SOM LIGADO" else "LIGAR SOM"
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
    local ____opt_52 = window.document:querySelector(".cinematic-buttons")
    if ____opt_52 ~= nil then
        ____opt_52:append(sound)
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
            local ____opt_58 = window.Game
            if ____opt_58 ~= nil then
                ____opt_58 = ____opt_58.resume
            end
            if ____opt_58 ~= nil then
                ____opt_58(____opt_58)
            end
            local ____opt_62 = window.Game
            if ____opt_62 ~= nil then
                ____opt_62 = ____opt_62.replayEpilogue
            end
            if ____opt_62 ~= nil then
                ____opt_62(____opt_62)
            end
        end
    )
    local ____opt_64 = window.document:querySelector("#pauseScreen .game-modal")
    if ____opt_64 ~= nil then
        ____opt_64:append(replay)
    end
    local pause = window.document:getElementById("pauseScreen")
    if __t(pause) then
        __new(
            "MutationObserver",
            function()
                if not __t(pause.hidden) then
                    local ____t_74 = __t
                    local ____opt_70 = window.Game
                    if ____opt_70 ~= nil then
                        ____opt_70 = ____opt_70.getState
                    end
                    local ____opt_result_72
                    if ____opt_70 ~= nil then
                        ____opt_result_72 = ____opt_70(____opt_70).q
                    end
                    local ____opt_result_73
                    if ____opt_result_72 ~= nil then
                        ____opt_result_73 = ____opt_result_72.jorgeSeen
                    end
                    replay.hidden = not ____t_74(____opt_result_73)
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
        local ____t_80 = __t
        local ____opt_77 = window.Campanha2
        if ____opt_77 ~= nil then
            ____opt_77 = ____opt_77.aberto
        end
        local ____opt_result_79
        if ____opt_77 ~= nil then
            ____opt_result_79 = ____opt_77(____opt_77)
        end
        if ____t_80(____opt_result_79) then
            window:requestAnimationFrame(tick)
            return
        end
        if now - last >= 60 then
            last = now
            local ____t_88 = __t
            local ____t_86 = __t
            local ____t_84 = __t
            local ____t_82 = __t
            local ____temp_81 = shell.classList:contains("in-main-menu")
            __O[3050] = ____temp_81
            local ____temp_83 = if ____t_82(____temp_81) then __O[3050] else shell.classList:contains("is-cutscene")
            __O[3051] = ____temp_83
            local ____temp_85 = if ____t_84(____temp_83) then __O[3051] else shell.classList:contains("is-dialog")
            __O[3052] = ____temp_85
            local ____temp_87 = if ____t_86(____temp_85) then __O[3052] else shell.classList:contains("is-paused")
            __O[3053] = ____temp_87
            local hidden = if ____t_88(____temp_87) then __O[3053] else shell.classList:contains("is-chapter-ended")
            local ____opt_91 = window.Game
            if ____opt_91 ~= nil then
                ____opt_91 = ____opt_91.getBossStatus
            end
            local ____opt_result_93
            if ____opt_91 ~= nil then
                ____opt_result_93 = ____opt_91(____opt_91)
            end
            local boss = if __t(hidden) then nil else ____opt_result_93
            hud.hidden = not __t(boss)
            if __t(boss) then
                local ____t_95 = __t
                local ____TS__Number_result_94 = __TS__Number(boss.hp)
                __O[3054] = ____TS__Number_result_94
                local hp = math.max(0, if ____t_95(____TS__Number_result_94) then __O[3054] else 0)
                local ____t_99 = __t
                local ____t_97 = __t
                local ____TS__Number_result_96 = __TS__Number(boss.phaseMaxHp)
                __O[3055] = ____TS__Number_result_96
                local ____temp_98 = if ____t_97(____TS__Number_result_96) then __O[3055] else __TS__Number(boss.max)
                __O[3056] = ____temp_98
                local max = math.max(1, if ____t_99(____temp_98) then __O[3056] else 1)
                local ratio = math.max(
                    0,
                    math.min(1, hp / max)
                )
                hud.dataset.boss = boss.type
                name.textContent = boss.name
                renderBossPhase(nil, boss)
                hud.dataset.state = tostring(if __t(boss.state) then boss.state else "")
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
                local ____t_101 = __t
                local ____get_result_100 = __get({
                    underground = "NO ESGOTO",
                    windup = "PREPARANDO GOLPE",
                    recover = "ABERTURA PARA ATACAR",
                    dashing = "INVESTIDA",
                    firing = "DESVIE!"
                }, boss.state)
                __O[3057] = ____get_result_100
                cue.textContent = if ____t_101(____get_result_100) then __O[3057] else "CHEFÃO"
            end
            local film = if __t(shell.classList:contains("is-epilogue")) then "jorge" else ""
            if film ~= lastFilm then
                lastFilm = film
                local skip = window.document:getElementById("cutsceneSkipBtn")
                if __t(skip) then
                    skip.textContent = if __t(film) then "Pular epílogo" else "Pular história"
                end
                local ____opt_104 = window.GameView
                if ____opt_104 ~= nil then
                    ____opt_104 = ____opt_104.fit
                end
                if ____opt_104 ~= nil then
                    ____opt_104(____opt_104)
                end
            end
        end
        local on = not __t(ending.hidden)
        if __t(if __t(on) then not __t(wasEnding) else on) then
            endAt = now
            ending.classList:remove("show-options")
            local ____opt_108 = window.GameView
            if ____opt_108 ~= nil then
                ____opt_108 = ____opt_108.fit
            end
            if ____opt_108 ~= nil then
                ____opt_108(____opt_108)
            end
        end
        if __t(on) then
            local ____t_112 = __t
            local ____opt_110 = window.JorgeEpilogue
            if ____opt_110 ~= nil then
                ____opt_110 = ____opt_110.drawEnd
            end
            if ____t_112(____opt_110) then
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
