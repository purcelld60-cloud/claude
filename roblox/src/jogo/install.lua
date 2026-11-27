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
        local ____t_48 = __t
        local ____t_47 = __t
        local ____t_45 = __t
        local ____t_43 = __t
        local ____temp_42 = if __t(nativeApp) then nativeApp else not __t(offlineAllowed)
        __O[2436] = ____temp_42
        local ____temp_44 = if ____t_43(____temp_42) then __O[2436] else not __t(installed)
        __O[2437] = ____temp_44
        local ____temp_46 = if ____t_45(____temp_44) then __O[2437] else not __t(window.navigator.onLine)
        __O[2438] = ____temp_46
        if ____t_48(if ____t_47(____temp_46) then __O[2438] else not __t(window.navigator.serviceWorker)) then
            return
        end
        local ____self_51 = window.navigator.serviceWorker.ready
        ____self_51["then"](
            ____self_51,
            function(____, reg)
                local ____opt_49 = reg.active
                return ____opt_49 and ____opt_49:postMessage({type = "preparar-trilhas"})
            end
        )
    end
    local ____ = "use strict"
    local ____t_1 = __t
    local ____temp_0 = window.location.protocol == "file:" or window.location.protocol == "daroca:"
    __O[2425] = ____temp_0
    nativeApp = if ____t_1(____temp_0) then __O[2425] else __call(
        __new("URLSearchParams", window.location.search),
        "has",
        "native"
    )
    local function standalone()
        local ____t_3 = __t
        local ____table_matches_2 = window:matchMedia("(display-mode: standalone)").matches
        __O[2426] = ____table_matches_2
        return if ____t_3(____table_matches_2) then __O[2426] else not not __t(window.navigator.standalone)
    end
    local ____t_5 = __t
    local ____re_test_result_4 = __re_test(
        __re("iPhone|iPad|iPod", ""),
        window.navigator.userAgent
    )
    __O[2427] = ____re_test_result_4
    local isIOS = if ____t_5(____re_test_result_4) then __O[2427] else window.navigator.platform == "MacIntel" and window.navigator.maxTouchPoints > 1
    local status = window.document:getElementById("offlineStatus")
    local buttons = __arr(__TS__Spread(__iter(window.document:querySelectorAll("#installAppBtn,[data-install-app]"))))
    local guide = window.document:getElementById("installGuide")
    local installPrompt = nil
    local guideModal = nil
    local resumeAfterGuide = false
    if __t(if __t(nativeApp) then nativeApp else standalone(nil)) then
        __call(window.document.body.classList, "add", "installed-game")
        local ____opt_6 = window.GameView
        if ____opt_6 ~= nil then
            ____opt_6:enterFullscreen()
        end
    end
    local function showGuide(self)
        if not __t(guideModal) then
            guideModal = window.document:createElement("dialog")
            guideModal.className = "iphone-screen-guide"
            guideModal.id = "phoneInstallGuide"
            guideModal:setAttribute("aria-labelledby", "phoneInstallHeading")
            guideModal.innerHTML = if __t(isIOS) then "<h2 id=\"phoneInstallHeading\">A ROÇA NA TELA TODA</h2><p>O Safari controla as barras do navegador. Para jogar sem essas barras:</p><ol><li>Toque em <b>Compartilhar</b> no Safari: o quadrado com uma seta para cima.</li><li>Escolha <b>Adicionar à Tela de Início</b> e confirme em <b>Adicionar</b>.</li><li>Abra o ícone <b>Da Roça</b> na Tela de Início e deite o iPhone.</li></ol><p>Abra conectado uma vez para preparar o jogo offline. O jogo salva o progresso no aparelho. A Tela de Início pode ter um save separado do Safari.</p><button type=\"button\" class=\"primary-btn\">ENTENDI · VOLTAR AO JOGO</button>" else "<h2 id=\"phoneInstallHeading\">LEVE A AVENTURA COM VOCÊ</h2><p>No menu do navegador, escolha <b>Instalar app</b> ou <b>Adicionar à Tela de Início</b>. Abra o ícone Da Roça para jogar sem as barras do navegador.</p><p>Essa opção instala a versão do site. O APK continua disponível para instalação direta.</p><button type=\"button\" class=\"primary-btn\">ENTENDI · VOLTAR AO JOGO</button>"
            local ____t_9 = __t
            local ____temp_8 = window.document:getElementById("gameShell")
            __O[2428] = ____temp_8
            if ____t_9(____temp_8) then __O[2428] else window.document.body:append(guideModal)
            guideModal:querySelector("button"):addEventListener(
                "click",
                function() return guideModal:close() end
            )
            guideModal:addEventListener(
                "click",
                function(____, e)
                    if e.target == guideModal then
                        local b = guideModal:getBoundingClientRect()
                        local ____t_14 = __t
                        local ____t_13 = __t
                        local ____t_11 = __t
                        local ____temp_10 = __lt(e.clientX, b.left) or __gt(e.clientX, b.right)
                        __O[2429] = ____temp_10
                        local ____temp_12 = if ____t_11(____temp_10) then __O[2429] else __lt(e.clientY, b.top)
                        __O[2430] = ____temp_12
                        if ____t_14(if ____t_13(____temp_12) then __O[2430] else __gt(e.clientY, b.bottom)) then
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
                        local ____opt_17 = window.Game
                        if ____opt_17 ~= nil then
                            ____opt_17 = ____opt_17.resume
                        end
                        if ____opt_17 ~= nil then
                            ____opt_17(____opt_17)
                        end
                    end
                end
            )
        end
        if __t(guideModal.open) then
            return
        end
        local ____opt_19 = window.Game
        if ____opt_19 ~= nil then
            ____opt_19 = ____opt_19:getState()
        end
        local state = ____opt_19
        local ____t_29 = __t
        local ____t_28 = __t
        local ____t_26 = __t
        local ____t_24 = __t
        local ____opt_result_23
        if state ~= nil then
            ____opt_result_23 = state.started
        end
        __O[2431] = ____opt_result_23
        local ____temp_25 = if ____t_24(____opt_result_23) then not __t(state.paused) else __O[2431]
        __O[2432] = ____temp_25
        local ____temp_27 = if ____t_26(____temp_25) then not __t(state.won) else __O[2432]
        __O[2433] = ____temp_27
        resumeAfterGuide = not not ____t_29(if ____t_28(____temp_27) then not __t(state.defeated) else __O[2433])
        local ____opt_32 = window.Game
        if ____opt_32 ~= nil then
            ____opt_32 = ____opt_32.releaseInputs
        end
        if ____opt_32 ~= nil then
            ____opt_32(____opt_32)
        end
        if __t(resumeAfterGuide) then
            local ____opt_36 = window.Game
            if ____opt_36 ~= nil then
                ____opt_36 = ____opt_36.pause
            end
            if ____opt_36 ~= nil then
                ____opt_36(____opt_36)
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
                guide.textContent = if __t(isIOS) then "No Safari, toque em Compartilhar → Adicionar à Tela de Início → Adicionar. Abra pelo ícone Da Roça e deite o iPhone para jogar sem as barras do navegador." else "Use o menu do navegador → Instalar app ou Adicionar à Tela de Início. Essa opção instala o jogo do site sem baixar o APK."
            end
            showGuide(nil)
        end)
    end
    __call(
        buttons,
        "forEach",
        function(____, button) return button:addEventListener("click", install) end
    )
    local ____t_39 = __t
    local ____standalone_result_38 = standalone(nil)
    __O[2434] = ____standalone_result_38
    installed = if ____t_39(____standalone_result_38) then __O[2434] else __call(
        __new("URLSearchParams", window.location.search),
        "has",
        "installed"
    )
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
    local ____t_41 = __t
    local ____temp_40 = not __t(__call(
        __arrL({"localhost", "127.0.0.1"}, 2),
        "includes",
        window.location.hostname
    ))
    __O[2435] = ____temp_40
    offlineAllowed = if ____t_41(____temp_40) then __O[2435] else __call(
        __new("URLSearchParams", window.location.search),
        "has",
        "offline-test"
    )
    local ____t_58 = __t
    local ____t_57 = __t
    local ____t_55 = __t
    local ____t_53 = __t
    local ____temp_52 = not __t(nativeApp)
    __O[2439] = ____temp_52
    local ____temp_54 = if ____t_53(____temp_52) then offlineAllowed else __O[2439]
    __O[2440] = ____temp_54
    local ____temp_56 = if ____t_55(____temp_54) then window.navigator.serviceWorker ~= nil else __O[2440]
    __O[2441] = ____temp_56
    if ____t_58(if ____t_57(____temp_56) then __call(
        __arrL({"https:", "http:"}, 2),
        "includes",
        window.location.protocol
    ) else __O[2441]) then
        window.navigator.serviceWorker:addEventListener(
            "message",
            function(____, e)
                local ____t_63 = __t
                local ____t_62 = __t
                local ____opt_59 = e.data
                if ____opt_59 ~= nil then
                    ____opt_59 = ____opt_59.type
                end
                local ____temp_61 = ____opt_59 == "trilhas-offline"
                __O[2442] = ____temp_61
                if ____t_63(if ____t_62(____temp_61) then status else __O[2442]) then
                    status.textContent = if __t(e.data.ready) then "Jogo e trilhas originais disponíveis offline." else "O jogo está salvo. Abra conectado para terminar de guardar as trilhas."
                end
            end
        )
        window:addEventListener("online", prepareMusic)
        local ____self_65 = window.navigator.serviceWorker:register("./sw.js")
        local ____self_64 = ____self_65["then"](
            ____self_65,
            function() return window.navigator.serviceWorker.ready end
        )
        ____self_64["then"](
            ____self_64,
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
