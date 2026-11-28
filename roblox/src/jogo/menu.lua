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
        fullscreenButton:setAttribute(
            "aria-label",
            __t(active) and "Sair da tela cheia" or "Jogar em tela cheia"
        )
        fullscreenButton.title = __t(active) and "Sair da tela cheia" or "Tela cheia"
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
                    local ____t_result_19
                    local ____t_18 = __t
                    local ____re_test_result_17 = __re_test(
                        __re("iPhone|iPad|iPod", ""),
                        window.navigator.userAgent
                    )
                    __O[2471] = ____re_test_result_17
                    if ____t_18(____re_test_result_17) then
                        ____t_result_19 = __O[2471]
                    else
                        ____t_result_19 = window.navigator.platform == "MacIntel" and window.navigator.maxTouchPoints > 1
                    end
                    local ios = ____t_result_19
                    local ____t_result_26
                    local ____t_25 = __t
                    local ____t_result_24
                    local ____t_23 = __t
                    local ____t_result_22
                    local ____t_21 = __t
                    local ____temp_20 = not not __t(window.navigator.standalone)
                    __O[2472] = ____temp_20
                    if ____t_21(____temp_20) then
                        ____t_result_22 = __O[2472]
                    else
                        ____t_result_22 = window:matchMedia("(display-mode: standalone)").matches
                    end
                    __O[2473] = ____t_result_22
                    if ____t_23(____t_result_22) then
                        ____t_result_24 = __O[2473]
                    else
                        ____t_result_24 = window.location.protocol == "file:"
                    end
                    __O[2474] = ____t_result_24
                    if ____t_25(____t_result_24) then
                        ____t_result_26 = __O[2474]
                    else
                        ____t_result_26 = __call(
                            __new("URLSearchParams", window.location.search),
                            "has",
                            "native"
                        )
                    end
                    local installed = ____t_result_26
                    local ____t_36 = __t
                    local ____t_result_35
                    local ____t_28 = __t
                    local ____t_result_27
                    if __t(ios) then
                        ____t_result_27 = not __t(installed)
                    else
                        ____t_result_27 = ios
                    end
                    __O[2475] = ____t_result_27
                    if ____t_28(____t_result_27) then
                        local ____t_34 = __t
                        local ____opt_31 = window.GameView
                        if ____opt_31 ~= nil then
                            ____opt_31 = ____opt_31.isNativeFullscreen
                        end
                        local ____opt_result_33
                        if ____opt_31 ~= nil then
                            ____opt_result_33 = ____opt_31(____opt_31)
                        end
                        ____t_result_35 = not ____t_34(____opt_result_33)
                    else
                        ____t_result_35 = __O[2475]
                    end
                    if ____t_36(____t_result_35) then
                        local ____opt_39 = window.GameInstall
                        if ____opt_39 ~= nil then
                            ____opt_39 = ____opt_39.showGuide
                        end
                        if ____opt_39 ~= nil then
                            ____opt_39(____opt_39)
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
                button.tabIndex = __t(on) and 0 or -1
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
        local ____opt_41 = window.Game
        if ____opt_41 ~= nil then
            ____opt_41 = ____opt_41:getState()
        end
        local state = ____opt_41
        local ____t_52 = __t
        local ____t_result_51
        local ____t_50 = __t
        local ____t_result_49
        local ____t_48 = __t
        local ____t_result_47
        local ____t_46 = __t
        local ____opt_result_45
        if state ~= nil then
            ____opt_result_45 = state.started
        end
        __O[2476] = ____opt_result_45
        if ____t_46(____opt_result_45) then
            ____t_result_47 = not __t(state.paused)
        else
            ____t_result_47 = __O[2476]
        end
        __O[2477] = ____t_result_47
        if ____t_48(____t_result_47) then
            ____t_result_49 = not __t(state.won)
        else
            ____t_result_49 = __O[2477]
        end
        __O[2478] = ____t_result_49
        if ____t_50(____t_result_49) then
            ____t_result_51 = not __t(state.defeated)
        else
            ____t_result_51 = __O[2478]
        end
        resumeAfterInfo = not not ____t_52(____t_result_51)
        local ____opt_55 = window.Game
        if ____opt_55 ~= nil then
            ____opt_55 = ____opt_55.releaseInputs
        end
        if ____opt_55 ~= nil then
            ____opt_55(____opt_55)
        end
        if __t(resumeAfterInfo) then
            window.Game:pause()
        end
        local ____temp_64 = window.document:getElementById("acaiPrize")
        local ____t_63 = __t
        local ____opt_result_61
        if state ~= nil then
            ____opt_result_61 = state.q
        end
        local ____opt_result_62
        if ____opt_result_61 ~= nil then
            ____opt_result_62 = ____opt_result_61.acai
        end
        ____temp_64.hidden = not ____t_63(____opt_result_62)
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
                local ____opt_67 = window.Game
                if ____opt_67 ~= nil then
                    ____opt_67 = ____opt_67.resume
                end
                if ____opt_67 ~= nil then
                    ____opt_67(____opt_67)
                end
            end
        end
    )
    info:addEventListener(
        "click",
        function(____, event)
            if event.target == info then
                local r = info:getBoundingClientRect()
                local ____t_74 = __t
                local ____t_result_73
                local ____t_72 = __t
                local ____t_result_71
                local ____t_70 = __t
                local ____temp_69 = event.clientX < r.left or event.clientX > r.right
                __O[2479] = ____temp_69
                if ____t_70(____temp_69) then
                    ____t_result_71 = __O[2479]
                else
                    ____t_result_71 = event.clientY < r.top
                end
                __O[2480] = ____t_result_71
                if ____t_72(____t_result_71) then
                    ____t_result_73 = __O[2480]
                else
                    ____t_result_73 = event.clientY > r.bottom
                end
                if ____t_74(____t_result_73) then
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
                __mod(i + (event.key == "ArrowRight" and 1 or 2), 3)
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
            local ____opt_77 = window.GameView
            if ____opt_77 ~= nil then
                ____opt_77 = ____opt_77.openHelp
            end
            local ____opt_result_79
            if ____opt_77 ~= nil then
                ____opt_result_79 = ____opt_77(____opt_77)
            end
            return ____opt_result_79
        end
    )
    info:addEventListener(
        "click",
        function(____, event)
            local ____this_81
            ____this_81 = event.target
            local ____opt_80 = ____this_81.closest
            if ____opt_80 ~= nil then
                ____opt_80 = ____opt_80(____this_81, "[data-scene]")
            end
            local stop = ____opt_80
            if not __t(stop) then
                return
            end
            event:preventDefault()
            event:stopImmediatePropagation()
            local ____opt_82 = window.Game
            if ____opt_82 ~= nil then
                ____opt_82 = ____opt_82:getState()
            end
            local state = ____opt_82
            local ____t_87 = __t
            local ____opt_result_86
            if state ~= nil then
                ____opt_result_86 = state.started
            end
            if not ____t_87(____opt_result_86) then
                window.document:getElementById("infoNotice").textContent = "Escolha a dificuldade no pause. Cada nível dá 2 pontos para investir em ATRIBUTOS. Comece ou continue a aventura e prepare seu shape antes dos chefes."
                return
            end
            local ____t_97 = __t
            local ____t_result_96
            local ____t_93 = __t
            local ____t_result_92
            local ____t_91 = __t
            local ____t_result_90
            local ____t_89 = __t
            local ____t_result_88
            if __t(state.activeBoss) then
                ____t_result_88 = state.activeBoss
            else
                ____t_result_88 = state.room
            end
            __O[2481] = ____t_result_88
            if ____t_89(____t_result_88) then
                ____t_result_90 = __O[2481]
            else
                ____t_result_90 = state.cutscene
            end
            __O[2482] = ____t_result_90
            if ____t_91(____t_result_90) then
                ____t_result_92 = __O[2482]
            else
                ____t_result_92 = state.activity
            end
            __O[2483] = ____t_result_92
            if ____t_93(____t_result_92) then
                ____t_result_96 = __O[2483]
            else
                local ____opt_94 = state.training
                if ____opt_94 ~= nil then
                    ____opt_94 = ____opt_94.active
                end
                ____t_result_96 = ____opt_94
            end
            if ____t_97(____t_result_96) then
                window.document:getElementById("infoNotice").textContent = "Retome a exploração fora da luta, sala ou desafio para escolher uma viagem."
                return
            end
            resumeAfterInfo = false
            closeInfo(nil)
            local ____opt_100 = window.Game
            if ____opt_100 ~= nil then
                ____opt_100 = ____opt_100.resume
            end
            if ____opt_100 ~= nil then
                ____opt_100(____opt_100)
            end
            local ____opt_104 = window.GameView
            if ____opt_104 ~= nil then
                ____opt_104 = ____opt_104.openRoutes
            end
            if ____opt_104 ~= nil then
                ____opt_104(
                    ____opt_104,
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
                local ____opt_108 = window.Game
                if ____opt_108 ~= nil then
                    ____opt_108 = ____opt_108.returnToMenu
                end
                if ____opt_108 ~= nil then
                    ____opt_108(____opt_108)
                end
            end
        )
        pauseMenu:append(book, home)
    end
    local function syncTitle(self)
        local on = not __t(start.hidden)
        shell.classList:toggle("in-main-menu", on)
        if __t(on) then
            local ____opt_112 = window.Game
            if ____opt_112 ~= nil then
                ____opt_112 = ____opt_112.releaseInputs
            end
            if ____opt_112 ~= nil then
                ____opt_112(____opt_112)
            end
            local ____opt_116 = window.GameView
            if ____opt_116 ~= nil then
                ____opt_116 = ____opt_116.closeRoutes
            end
            if ____opt_116 ~= nil then
                ____opt_116(____opt_116)
            end
        end
        local ____opt_120 = window.GameView
        if ____opt_120 ~= nil then
            ____opt_120 = ____opt_120.fit
        end
        if ____opt_120 ~= nil then
            ____opt_120(____opt_120)
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
    local ____opt_124 = window.GameView
    if ____opt_124 ~= nil then
        ____opt_124 = ____opt_124.enterFullscreen
    end
    if ____opt_124 ~= nil then
        ____opt_124(____opt_124, {pageOnly = true})
    end
    syncTitle(nil)
    window.AdventureMenu = __ord({openInfo = openInfo, closeInfo = closeInfo, showTab = selectTab}, "openInfo,closeInfo,showTab")
end)(nil)
return ____exports
