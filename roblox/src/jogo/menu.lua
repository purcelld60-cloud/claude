--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __mod, __ord, __arrL, __iterar, __t, __get, __call, __add, __new, __re, __re_test = __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__call, __JSR.__add, __JSR.__new, __JSR.__re, __JSR.__re_test
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__AsyncAwaiter = ____lualib.__TS__AsyncAwaiter
local __TS__Await = ____lualib.__TS__Await
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__Number = ____lualib.__TS__Number
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    local shell = window.document:getElementById("gameShell")
    local start = window.document:getElementById("startScreen")
    if __t(not __t(shell) or not __t(start)) then
        return
    end
    __call(window.document.body.classList, "add", "shell-experience")
    local menu = start:querySelector(".start-menu")
    local infoButton = window.document:createElement("button")
    infoButton.id = "adventureInfoBtn"
    infoButton.type = "button"
    infoButton.className = "menu-book-button"
    infoButton.innerHTML = "<svg viewBox=\"0 0 24 24\" width=\"21\" height=\"21\" aria-hidden=\"true\" shape-rendering=\"crispEdges\"><path fill=\"currentColor\" d=\"M2 3h8l2 2 2-2h8v17h-8l-2 2-2-2H2z\"/><path fill=\"#f4dfaa\" d=\"M5 6h4l1 1v10H5zm10 0h4v11h-5V7z\"/></svg><span>DIÁRIO E TURMA</span>"
    menu:append(infoButton)
    local fullscreenButton = window.document:createElement("button")
    fullscreenButton.id = "titleFullscreenBtn"
    fullscreenButton.type = "button"
    fullscreenButton.className = "menu-fullscreen"
    fullscreenButton:setAttribute("aria-label", "Jogar em tela cheia")
    fullscreenButton.title = "Tela cheia"
    fullscreenButton.innerHTML = "<svg viewBox=\"0 0 24 24\" width=\"22\" height=\"22\" aria-hidden=\"true\"><path fill=\"currentColor\" d=\"M3 3h7v3H6v4H3zm11 0h7v7h-3V6h-4zM3 14h3v4h4v3H3zm15 0h3v7h-7v-3h4z\"/></svg>"
    start:append(fullscreenButton)
    local function reflectFullscreen(self)
        local ____t_5 = __t
        local ____opt_2 = window.GameView
        if ____opt_2 ~= nil then
            ____opt_2 = ____opt_2.isNativeFullscreen
        end
        local ____opt_result_4
        if ____opt_2 ~= nil then
            ____opt_result_4 = ____opt_2(____opt_2)
        end
        local active = not not ____t_5(____opt_result_4)
        fullscreenButton:setAttribute(
            "aria-pressed",
            tostring(active)
        )
        fullscreenButton:setAttribute("aria-label", if __t(active) then "Sair da tela cheia" else "Jogar em tela cheia")
        fullscreenButton.title = if __t(active) then "Sair da tela cheia" else "Tela cheia"
    end
    fullscreenButton:addEventListener(
        "click",
        function()
            return __TS__AsyncAwaiter(function(____awaiter_resolve)
                local ____t_11 = __t
                local ____opt_8 = window.GameView
                if ____opt_8 ~= nil then
                    ____opt_8 = ____opt_8.isNativeFullscreen
                end
                local ____opt_result_10
                if ____opt_8 ~= nil then
                    ____opt_result_10 = ____opt_8(____opt_8)
                end
                if ____t_11(____opt_result_10) then
                    __TS__Await(window.GameView:exitFullscreen())
                else
                    local ____opt_14 = window.GameView
                    if ____opt_14 ~= nil then
                        ____opt_14 = ____opt_14.enterFullscreen
                    end
                    local ____opt_result_16
                    if ____opt_14 ~= nil then
                        ____opt_result_16 = ____opt_14(____opt_14)
                    end
                    __TS__Await(____opt_result_16)
                    local ____t_18 = __t
                    local ____re_test_result_17 = __re_test(
                        __re("iPhone|iPad|iPod", ""),
                        window.navigator.userAgent
                    )
                    __O[2443] = ____re_test_result_17
                    local ios = if ____t_18(____re_test_result_17) then __O[2443] else window.navigator.platform == "MacIntel" and window.navigator.maxTouchPoints > 1
                    local ____t_24 = __t
                    local ____t_22 = __t
                    local ____t_20 = __t
                    local ____temp_19 = not not __t(window.navigator.standalone)
                    __O[2444] = ____temp_19
                    local ____temp_21 = if ____t_20(____temp_19) then __O[2444] else window:matchMedia("(display-mode: standalone)").matches
                    __O[2445] = ____temp_21
                    local ____temp_23 = if ____t_22(____temp_21) then __O[2445] else window.location.protocol == "file:"
                    __O[2446] = ____temp_23
                    local installed = if ____t_24(____temp_23) then __O[2446] else __call(
                        __new("URLSearchParams", window.location.search),
                        "has",
                        "native"
                    )
                    local ____t_33 = __t
                    local ____t_26 = __t
                    local ____temp_25 = if __t(ios) then not __t(installed) else ios
                    __O[2447] = ____temp_25
                    local ____t_32 = __t
                    local ____opt_29 = window.GameView
                    if ____opt_29 ~= nil then
                        ____opt_29 = ____opt_29.isNativeFullscreen
                    end
                    local ____opt_result_31
                    if ____opt_29 ~= nil then
                        ____opt_result_31 = ____opt_29(____opt_29)
                    end
                    if ____t_33(if ____t_26(____temp_25) then not ____t_32(____opt_result_31) else __O[2447]) then
                        local ____opt_36 = window.GameInstall
                        if ____opt_36 ~= nil then
                            ____opt_36 = ____opt_36.showGuide
                        end
                        if ____opt_36 ~= nil then
                            ____opt_36(____opt_36)
                        end
                    end
                end
                reflectFullscreen(nil)
            end)
        end
    )
    window.document:addEventListener("fullscreenchange", reflectFullscreen)
    window.document:addEventListener("webkitfullscreenchange", reflectFullscreen)
    reflectFullscreen(nil)
    local info = window.document:createElement("dialog")
    info.id = "adventureInfo"
    info.className = "adventure-info"
    info:setAttribute("aria-labelledby", "adventureInfoHeading")
    info.innerHTML = "<div class=\"info-book-header\"><div><span class=\"book-eyebrow\">O CADERNO DA TURMA</span><h2 id=\"adventureInfoHeading\">Dentro da resenha</h2></div><button id=\"closeAdventureInfo\" aria-label=\"Fechar informações\">×</button></div><div class=\"info-book-tabs\" role=\"tablist\" aria-label=\"Informações da aventura\"><button type=\"button\" role=\"tab\" id=\"info-tab-journal\" aria-controls=\"info-journal\" data-info-tab=\"journal\">DIÁRIO</button><button type=\"button\" role=\"tab\" id=\"info-tab-cast\" aria-controls=\"info-cast\" data-info-tab=\"cast\">A TURMA</button><button type=\"button\" role=\"tab\" id=\"info-tab-install\" aria-controls=\"info-install\" data-info-tab=\"install\">INSTALAR</button></div><div class=\"info-book-pages\"><div id=\"info-journal\" role=\"tabpanel\" aria-labelledby=\"info-tab-journal\"><p class=\"info-notice\" id=\"infoNotice\">Escolha a dificuldade no menu de pausa. Ganhe níveis, distribua os 2 pontos de cada nível e prepare seus atributos antes dos chefes.</p><div id=\"acaiPrize\" class=\"acai-prize\" hidden>★ PRÊMIO DA TURMA: AÇAÍ DE QUARTA-FEIRA ★</div></div><div id=\"info-cast\" role=\"tabpanel\" aria-labelledby=\"info-tab-cast\" hidden></div><div id=\"info-install\" role=\"tabpanel\" aria-labelledby=\"info-tab-install\" hidden></div></div><div class=\"info-book-footer\"><button type=\"button\" id=\"bookHelpBtn\">CONTROLES E AJUDA</button><a href=\"references.html\" target=\"_blank\" rel=\"noopener\">Créditos e referências ↗</a><a href=\"https://da-roca-adventure-jogo.davims99.chatgpt.site/admin\" target=\"_blank\" rel=\"noopener\">Estúdio de trilhas ↗</a><span>DA ROÇA · EDIÇÃO 3.9</span></div>"
    shell:append(info)
    __call(
        window.document:querySelectorAll("main > .adventure-desk,main > .campaign-journal"),
        "forEach",
        function(____, el) return info:querySelector("#info-journal"):append(el) end
    )
    local cast = window.document:querySelector("main > .cast-section")
    local install = window.document:querySelector("main > .install-section")
    if __t(cast) then
        info:querySelector("#info-cast"):append(cast)
    end
    if __t(install) then
        info:querySelector("#info-install"):append(install)
    end
    local resumeAfterInfo = false
    local activeTab = "journal"
    local function selectTab(self, tab)
        activeTab = tab
        __call(
            info:querySelectorAll("[data-info-tab]"),
            "forEach",
            function(____, button)
                local on = button.dataset.infoTab == tab
                button:setAttribute(
                    "aria-selected",
                    tostring(on)
                )
                button.tabIndex = if __t(on) then 0 else -1
            end
        )
        for ____, id in __iterar((__arrL({"journal", "cast", "install"}, 3))) do
            info:querySelector(__add("#info-", id)).hidden = id ~= tab
        end
        info:querySelector(".info-book-pages").scrollTop = 0
    end
    local function openInfo(self, tab)
        if tab == nil then
            tab = "journal"
        end
        if __t(info.open) then
            selectTab(nil, tab)
            return
        end
        local ____opt_38 = window.Game
        if ____opt_38 ~= nil then
            ____opt_38 = ____opt_38:getState()
        end
        local state = ____opt_38
        local ____t_48 = __t
        local ____t_47 = __t
        local ____t_45 = __t
        local ____t_43 = __t
        local ____opt_result_42
        if state ~= nil then
            ____opt_result_42 = state.started
        end
        __O[2448] = ____opt_result_42
        local ____temp_44 = if ____t_43(____opt_result_42) then not __t(state.paused) else __O[2448]
        __O[2449] = ____temp_44
        local ____temp_46 = if ____t_45(____temp_44) then not __t(state.won) else __O[2449]
        __O[2450] = ____temp_46
        resumeAfterInfo = not not ____t_48(if ____t_47(____temp_46) then not __t(state.defeated) else __O[2450])
        local ____opt_51 = window.Game
        if ____opt_51 ~= nil then
            ____opt_51 = ____opt_51.releaseInputs
        end
        if ____opt_51 ~= nil then
            ____opt_51(____opt_51)
        end
        if __t(resumeAfterInfo) then
            window.Game:pause()
        end
        local ____temp_60 = window.document:getElementById("acaiPrize")
        local ____t_59 = __t
        local ____opt_result_57
        if state ~= nil then
            ____opt_result_57 = state.q
        end
        local ____opt_result_58
        if ____opt_result_57 ~= nil then
            ____opt_result_58 = ____opt_result_57.acai
        end
        ____temp_60.hidden = not ____t_59(____opt_result_58)
        selectTab(nil, tab)
        info:showModal()
    end
    local function closeInfo(self)
        if __t(info.open) then
            info:close()
        end
    end
    info:addEventListener(
        "close",
        function()
            if __t(resumeAfterInfo) then
                resumeAfterInfo = false
                local ____opt_63 = window.Game
                if ____opt_63 ~= nil then
                    ____opt_63 = ____opt_63.resume
                end
                if ____opt_63 ~= nil then
                    ____opt_63(____opt_63)
                end
            end
        end
    )
    info:addEventListener(
        "click",
        function(____, event)
            if event.target == info then
                local r = info:getBoundingClientRect()
                local ____t_69 = __t
                local ____t_68 = __t
                local ____t_66 = __t
                local ____temp_65 = event.clientX < r.left or event.clientX > r.right
                __O[2451] = ____temp_65
                local ____temp_67 = if ____t_66(____temp_65) then __O[2451] else event.clientY < r.top
                __O[2452] = ____temp_67
                if ____t_69(if ____t_68(____temp_67) then __O[2452] else event.clientY > r.bottom) then
                    closeInfo(nil)
                end
            end
        end
    )
    info:querySelector("#closeAdventureInfo"):addEventListener("click", closeInfo)
    __call(
        info:querySelectorAll("[data-info-tab]"),
        "forEach",
        function(____, button) return button:addEventListener(
            "click",
            function() return selectTab(nil, button.dataset.infoTab) end
        ) end
    )
    info:querySelector(".info-book-tabs"):addEventListener(
        "keydown",
        function(____, event)
            if not __t(__call(
                __arrL({"ArrowLeft", "ArrowRight"}, 2),
                "includes",
                event.key
            )) then
                return
            end
            event:preventDefault()
            local tabs = __arrL({"journal", "cast", "install"}, 3)
            local i = __call(tabs, "indexOf", activeTab)
            local next = __get(
                tabs,
                __mod(i + if event.key == "ArrowRight" then 1 else 2, 3)
            )
            selectTab(nil, next)
            info:querySelector(__add(
                __add("[data-info-tab=\"", next),
                "\"]"
            )):focus()
        end
    )
    infoButton:addEventListener(
        "click",
        function() return openInfo(nil) end
    )
    window.document:getElementById("bookHelpBtn"):addEventListener(
        "click",
        function()
            local ____opt_72 = window.GameView
            if ____opt_72 ~= nil then
                ____opt_72 = ____opt_72.openHelp
            end
            local ____opt_result_74
            if ____opt_72 ~= nil then
                ____opt_result_74 = ____opt_72(____opt_72)
            end
            return ____opt_result_74
        end
    )
    info:addEventListener(
        "click",
        function(____, event)
            local ____this_76
            ____this_76 = event.target
            local ____opt_75 = ____this_76.closest
            if ____opt_75 ~= nil then
                ____opt_75 = ____opt_75(____this_76, "[data-scene]")
            end
            local stop = ____opt_75
            if not __t(stop) then
                return
            end
            event:preventDefault()
            event:stopImmediatePropagation()
            local ____opt_77 = window.Game
            if ____opt_77 ~= nil then
                ____opt_77 = ____opt_77:getState()
            end
            local state = ____opt_77
            local ____t_82 = __t
            local ____opt_result_81
            if state ~= nil then
                ____opt_result_81 = state.started
            end
            if not ____t_82(____opt_result_81) then
                window.document:getElementById("infoNotice").textContent = "Escolha a dificuldade no pause. Cada nível dá 2 pontos para investir em ATRIBUTOS. Comece ou continue a aventura e prepare seu shape antes dos chefes."
                return
            end
            local ____t_91 = __t
            local ____t_88 = __t
            local ____t_86 = __t
            local ____t_84 = __t
            local ____temp_83 = if __t(state.activeBoss) then state.activeBoss else state.room
            __O[2453] = ____temp_83
            local ____temp_85 = if ____t_84(____temp_83) then __O[2453] else state.cutscene
            __O[2454] = ____temp_85
            local ____temp_87 = if ____t_86(____temp_85) then __O[2454] else state.activity
            __O[2455] = ____temp_87
            local ____opt_89 = state.training
            if ____opt_89 ~= nil then
                ____opt_89 = ____opt_89.active
            end
            if ____t_91(if ____t_88(____temp_87) then __O[2455] else ____opt_89) then
                window.document:getElementById("infoNotice").textContent = "Retome a exploração fora da luta, sala ou desafio para escolher uma viagem."
                return
            end
            resumeAfterInfo = false
            closeInfo(nil)
            local ____opt_94 = window.Game
            if ____opt_94 ~= nil then
                ____opt_94 = ____opt_94.resume
            end
            if ____opt_94 ~= nil then
                ____opt_94(____opt_94)
            end
            local ____opt_98 = window.GameView
            if ____opt_98 ~= nil then
                ____opt_98 = ____opt_98.openRoutes
            end
            if ____opt_98 ~= nil then
                ____opt_98(
                    ____opt_98,
                    __TS__Number(stop.dataset.scene)
                )
            end
        end,
        true
    )
    local pauseMenu = window.document:querySelector("#pauseScreen .game-modal")
    if __t(pauseMenu) then
        local book = window.document:createElement("button")
        book.type = "button"
        book.className = "text-button"
        book.id = "pauseInfoBtn"
        book.textContent = "Diário, turma e instalação"
        book:addEventListener(
            "click",
            function() return openInfo(nil) end
        )
        local home = window.document:createElement("button")
        home.type = "button"
        home.className = "text-button"
        home.id = "mainMenuBtn"
        home.textContent = "Menu principal"
        home:addEventListener(
            "click",
            function()
                local ____opt_102 = window.Game
                if ____opt_102 ~= nil then
                    ____opt_102 = ____opt_102.returnToMenu
                end
                if ____opt_102 ~= nil then
                    ____opt_102(____opt_102)
                end
            end
        )
        pauseMenu:append(book, home)
    end
    local function syncTitle(self)
        local on = not __t(start.hidden)
        shell.classList:toggle("in-main-menu", on)
        if __t(on) then
            local ____opt_106 = window.Game
            if ____opt_106 ~= nil then
                ____opt_106 = ____opt_106.releaseInputs
            end
            if ____opt_106 ~= nil then
                ____opt_106(____opt_106)
            end
            local ____opt_110 = window.GameView
            if ____opt_110 ~= nil then
                ____opt_110 = ____opt_110.closeRoutes
            end
            if ____opt_110 ~= nil then
                ____opt_110(____opt_110)
            end
        end
        local ____opt_114 = window.GameView
        if ____opt_114 ~= nil then
            ____opt_114 = ____opt_114.fit
        end
        if ____opt_114 ~= nil then
            ____opt_114(____opt_114)
        end
    end
    __new("MutationObserver", syncTitle):observe(
        start,
        __ord(
            {
                attributes = true,
                attributeFilter = __arrL({"hidden"}, 1)
            },
            "attributes,attributeFilter"
        )
    )
    syncTitle(nil)
    local ____opt_118 = window.GameView
    if ____opt_118 ~= nil then
        ____opt_118 = ____opt_118.enterFullscreen
    end
    if ____opt_118 ~= nil then
        ____opt_118(____opt_118, {pageOnly = true})
    end
    syncTitle(nil)
    window.AdventureMenu = __ord({openInfo = openInfo, closeInfo = closeInfo, showTab = selectTab}, "openInfo,closeInfo,showTab")
end)(nil)
return ____exports
