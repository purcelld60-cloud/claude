--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __gt, __arrL, __t, __arr, __call, __new, __iter, __re, __re_test = __JSR.__lt, __JSR.__gt, __JSR.__arrL, __JSR.__t, __JSR.__arr, __JSR.__call, __JSR.__new, __JSR.__iter, __JSR.__re, __JSR.__re_test
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Spread = ____lualib.__TS__Spread
local __TS__AsyncAwaiter = ____lualib.__TS__AsyncAwaiter
local __TS__Await = ____lualib.__TS__Await
local ____exports = {}
local __O = {};
(function()
    local prepareMusic, nativeApp, installed, offlineAllowed
    function prepareMusic(self)
        local ____t_59 = __t
        local ____t_result_58
        local ____t_57 = __t
        local ____t_result_56
        local ____t_55 = __t
        local ____t_result_54
        local ____t_53 = __t
        local ____t_result_52
        if __t(nativeApp) then
            ____t_result_52 = nativeApp
        else
            ____t_result_52 = not __t(offlineAllowed)
        end
        __O[2486] = ____t_result_52
        if ____t_53(____t_result_52) then
            ____t_result_54 = __O[2486]
        else
            ____t_result_54 = not __t(installed)
        end
        __O[2487] = ____t_result_54
        if ____t_55(____t_result_54) then
            ____t_result_56 = __O[2487]
        else
            ____t_result_56 = not __t(window.navigator.onLine)
        end
        __O[2488] = ____t_result_56
        if ____t_57(____t_result_56) then
            ____t_result_58 = __O[2488]
        else
            ____t_result_58 = not __t(window.navigator.serviceWorker)
        end
        if ____t_59(____t_result_58) then
            return
        end
        local ____self_62 = window.navigator.serviceWorker.ready
        ____self_62["then"](
            ____self_62,
            function(____, reg)
                local ____opt_60 = reg.active
                return ____opt_60 and ____opt_60:postMessage({type = "preparar-trilhas"})
            end
        )
    end
    local ____ = "use strict"
    local ____t_result_2
    local ____t_1 = __t
    local ____temp_0 = window.location.protocol == "file:" or window.location.protocol == "daroca:"
    __O[2475] = ____temp_0
    if ____t_1(____temp_0) then
        ____t_result_2 = __O[2475]
    else
        ____t_result_2 = __call(
            __new("URLSearchParams", window.location.search),
            "has",
            "native"
        )
    end
    nativeApp = ____t_result_2
    local function standalone()
        local ____t_result_5
        local ____t_4 = __t
        local ____table_matches_3 = window:matchMedia("(display-mode: standalone)").matches
        __O[2476] = ____table_matches_3
        if ____t_4(____table_matches_3) then
            ____t_result_5 = __O[2476]
        else
            ____t_result_5 = not not __t(window.navigator.standalone)
        end
        return ____t_result_5
    end
    local ____t_result_8
    local ____t_7 = __t
    local ____re_test_result_6 = __re_test(
        __re("iPhone|iPad|iPod", ""),
        window.navigator.userAgent
    )
    __O[2477] = ____re_test_result_6
    if ____t_7(____re_test_result_6) then
        ____t_result_8 = __O[2477]
    else
        ____t_result_8 = window.navigator.platform == "MacIntel" and window.navigator.maxTouchPoints > 1
    end
    local isIOS = ____t_result_8
    local status = window.document:getElementById("offlineStatus")
    local buttons = __arr(__TS__Spread(__iter(window.document:querySelectorAll("#installAppBtn,[data-install-app]"))))
    local guide = window.document:getElementById("installGuide")
    local installPrompt = nil
    local guideModal = nil
    local resumeAfterGuide = false
    local ____t_10 = __t
    local ____t_result_9
    if __t(nativeApp) then
        ____t_result_9 = nativeApp
    else
        ____t_result_9 = standalone(nil)
    end
    if ____t_10(____t_result_9) then
        __call(window.document.body.classList, "add", "installed-game")
        local ____opt_11 = window.GameView
        if ____opt_11 ~= nil then
            ____opt_11:enterFullscreen()
        end
    end
    local function showGuide(self)
        if not __t(guideModal) then
            guideModal = window.document:createElement("dialog")
            guideModal.className = "iphone-screen-guide"
            guideModal.id = "phoneInstallGuide"
            guideModal:setAttribute("aria-labelledby", "phoneInstallHeading")
            guideModal.innerHTML = __t(isIOS) and "<h2 id=\"phoneInstallHeading\">A ROÇA NA TELA TODA</h2><p>O Safari controla as barras do navegador. Para jogar sem essas barras:</p><ol><li>Toque em <b>Compartilhar</b> no Safari: o quadrado com uma seta para cima.</li><li>Escolha <b>Adicionar à Tela de Início</b> e confirme em <b>Adicionar</b>.</li><li>Abra o ícone <b>Da Roça</b> na Tela de Início e deite o iPhone.</li></ol><p>Abra conectado uma vez para preparar o jogo offline. O jogo salva o progresso no aparelho. A Tela de Início pode ter um save separado do Safari.</p><button type=\"button\" class=\"primary-btn\">ENTENDI · VOLTAR AO JOGO</button>" or "<h2 id=\"phoneInstallHeading\">LEVE A AVENTURA COM VOCÊ</h2><p>No menu do navegador, escolha <b>Instalar app</b> ou <b>Adicionar à Tela de Início</b>. Abra o ícone Da Roça para jogar sem as barras do navegador.</p><p>Essa opção instala a versão do site. O APK continua disponível para instalação direta.</p><button type=\"button\" class=\"primary-btn\">ENTENDI · VOLTAR AO JOGO</button>"
            local ____t_result_15
            local ____t_14 = __t
            local ____temp_13 = window.document:getElementById("gameShell")
            __O[2478] = ____temp_13
            if ____t_14(____temp_13) then
                ____t_result_15 = __O[2478]
            else
                ____t_result_15 = window.document.body
            end
            ____t_result_15:append(guideModal)
            guideModal:querySelector("button"):addEventListener(
                "click",
                function() return guideModal:close() end
            )
            guideModal:addEventListener(
                "click",
                function(____, e)
                    if e.target == guideModal then
                        local b = guideModal:getBoundingClientRect()
                        local ____t_21 = __t
                        local ____t_result_20
                        local ____t_19 = __t
                        local ____t_result_18
                        local ____t_17 = __t
                        local ____temp_16 = __lt(e.clientX, b.left) or __gt(e.clientX, b.right)
                        __O[2479] = ____temp_16
                        if ____t_17(____temp_16) then
                            ____t_result_18 = __O[2479]
                        else
                            ____t_result_18 = __lt(e.clientY, b.top)
                        end
                        __O[2480] = ____t_result_18
                        if ____t_19(____t_result_18) then
                            ____t_result_20 = __O[2480]
                        else
                            ____t_result_20 = __gt(e.clientY, b.bottom)
                        end
                        if ____t_21(____t_result_20) then
                            guideModal:close()
                        end
                    end
                end
            )
            guideModal:addEventListener(
                "close",
                function()
                    if __t(resumeAfterGuide) then
                        resumeAfterGuide = false
                        local ____opt_24 = window.Game
                        if ____opt_24 ~= nil then
                            ____opt_24 = ____opt_24.resume
                        end
                        if ____opt_24 ~= nil then
                            ____opt_24(____opt_24)
                        end
                    end
                end
            )
        end
        if __t(guideModal.open) then
            return
        end
        local ____opt_26 = window.Game
        if ____opt_26 ~= nil then
            ____opt_26 = ____opt_26:getState()
        end
        local state = ____opt_26
        local ____t_37 = __t
        local ____t_result_36
        local ____t_35 = __t
        local ____t_result_34
        local ____t_33 = __t
        local ____t_result_32
        local ____t_31 = __t
        local ____opt_result_30
        if state ~= nil then
            ____opt_result_30 = state.started
        end
        __O[2481] = ____opt_result_30
        if ____t_31(____opt_result_30) then
            ____t_result_32 = not __t(state.paused)
        else
            ____t_result_32 = __O[2481]
        end
        __O[2482] = ____t_result_32
        if ____t_33(____t_result_32) then
            ____t_result_34 = not __t(state.won)
        else
            ____t_result_34 = __O[2482]
        end
        __O[2483] = ____t_result_34
        if ____t_35(____t_result_34) then
            ____t_result_36 = not __t(state.defeated)
        else
            ____t_result_36 = __O[2483]
        end
        resumeAfterGuide = not not ____t_37(____t_result_36)
        local ____opt_40 = window.Game
        if ____opt_40 ~= nil then
            ____opt_40 = ____opt_40.releaseInputs
        end
        if ____opt_40 ~= nil then
            ____opt_40(____opt_40)
        end
        if __t(resumeAfterGuide) then
            local ____opt_44 = window.Game
            if ____opt_44 ~= nil then
                ____opt_44 = ____opt_44.pause
            end
            if ____opt_44 ~= nil then
                ____opt_44(____opt_44)
            end
        end
        guideModal:showModal()
    end
    window.GameInstall = {showGuide = showGuide}
    window:addEventListener(
        "beforeinstallprompt",
        function(____, e)
            e:preventDefault()
            installPrompt = e
            __call(
                buttons,
                "forEach",
                function(____, button)
                    button.textContent = "INSTALAR NA TELA DE INÍCIO"
                    return "INSTALAR NA TELA DE INÍCIO"
                end
            )
        end
    )
    local function install(self)
        return __TS__AsyncAwaiter(function(____awaiter_resolve)
            if __t(installPrompt) then
                local prompt = installPrompt
                installPrompt = nil
                __TS__Await(prompt:prompt())
                __TS__Await(prompt.userChoice)
                return ____awaiter_resolve(nil)
            end
            if __t(guide) then
                guide.hidden = false
                guide.textContent = __t(isIOS) and "No Safari, toque em Compartilhar → Adicionar à Tela de Início → Adicionar. Abra pelo ícone Da Roça e deite o iPhone para jogar sem as barras do navegador." or "Use o menu do navegador → Instalar app ou Adicionar à Tela de Início. Essa opção instala o jogo do site sem baixar o APK."
            end
            showGuide(nil)
        end)
    end
    __call(
        buttons,
        "forEach",
        function(____, button) return button:addEventListener("click", install) end
    )
    local ____t_result_48
    local ____t_47 = __t
    local ____standalone_result_46 = standalone(nil)
    __O[2484] = ____standalone_result_46
    if ____t_47(____standalone_result_46) then
        ____t_result_48 = __O[2484]
    else
        ____t_result_48 = __call(
            __new("URLSearchParams", window.location.search),
            "has",
            "installed"
        )
    end
    installed = ____t_result_48
    window:addEventListener(
        "appinstalled",
        function()
            installed = true
            installPrompt = nil
            __call(window.document.body.classList, "add", "installed-game")
            __call(
                buttons,
                "forEach",
                function(____, button)
                    button.textContent = "INSTALADO NA TELA DE INÍCIO"
                    return "INSTALADO NA TELA DE INÍCIO"
                end
            )
            prepareMusic(nil)
        end
    )
    local ____t_result_51
    local ____t_50 = __t
    local ____temp_49 = not __t(__call(
        __arrL({"localhost", "127.0.0.1"}, 2),
        "includes",
        window.location.hostname
    ))
    __O[2485] = ____temp_49
    if ____t_50(____temp_49) then
        ____t_result_51 = __O[2485]
    else
        ____t_result_51 = __call(
            __new("URLSearchParams", window.location.search),
            "has",
            "offline-test"
        )
    end
    offlineAllowed = ____t_result_51
    local ____t_70 = __t
    local ____t_result_69
    local ____t_68 = __t
    local ____t_result_67
    local ____t_66 = __t
    local ____t_result_65
    local ____t_64 = __t
    local ____temp_63 = not __t(nativeApp)
    __O[2489] = ____temp_63
    if ____t_64(____temp_63) then
        ____t_result_65 = offlineAllowed
    else
        ____t_result_65 = __O[2489]
    end
    __O[2490] = ____t_result_65
    if ____t_66(____t_result_65) then
        ____t_result_67 = window.navigator.serviceWorker ~= nil
    else
        ____t_result_67 = __O[2490]
    end
    __O[2491] = ____t_result_67
    if ____t_68(____t_result_67) then
        ____t_result_69 = __call(
            __arrL({"https:", "http:"}, 2),
            "includes",
            window.location.protocol
        )
    else
        ____t_result_69 = __O[2491]
    end
    if ____t_70(____t_result_69) then
        window.navigator.serviceWorker:addEventListener(
            "message",
            function(____, e)
                local ____t_76 = __t
                local ____t_result_75
                local ____t_74 = __t
                local ____opt_71 = e.data
                if ____opt_71 ~= nil then
                    ____opt_71 = ____opt_71.type
                end
                local ____temp_73 = ____opt_71 == "trilhas-offline"
                __O[2492] = ____temp_73
                if ____t_74(____temp_73) then
                    ____t_result_75 = status
                else
                    ____t_result_75 = __O[2492]
                end
                if ____t_76(____t_result_75) then
                    status.textContent = __t(e.data.ready) and "Jogo e trilhas originais disponíveis offline." or "O jogo está salvo. Abra conectado para terminar de guardar as trilhas."
                end
            end
        )
        window:addEventListener("online", prepareMusic)
        local ____self_78 = window.navigator.serviceWorker:register("./sw.js")
        local ____self_77 = ____self_78["then"](
            ____self_78,
            function() return window.navigator.serviceWorker.ready end
        )
        ____self_77["then"](
            ____self_77,
            function()
                if __t(status) then
                    status.textContent = "Jogo preparado para abrir offline pela Tela de Início."
                end
                prepareMusic(nil)
            end
        ):catch(function()
            if __t(status) then
                status.textContent = "Abra conectado para preparar o offline. No Android, o APK inclui o jogo completo."
            end
        end)
    end
end)(nil)
return ____exports
