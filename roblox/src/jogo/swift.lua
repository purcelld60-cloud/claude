--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __ord, __arrL, __iterar, __t, __call, __add = __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__call, __JSR.__add
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Number = ____lualib.__TS__Number
local __TS__Iterator = ____lualib.__TS__Iterator
local ____exports = {}
local __O = {};
(function()
    local updateCurrent, addChoice, renderQuestion, renderModes, choose, finishSession, finish, npc, modal, session, settings
    function updateCurrent(self)
        modal:querySelector(".swift-current").textContent = __add(
            "SEU JOGO: ",
            settings(nil).label
        )
    end
    function addChoice(self, label, id, callback, description)
        local button = window.document:createElement("button")
        button.type = "button"
        button.dataset.swiftChoice = id
        button.textContent = label
        if __t(description) then
            local small = window.document:createElement("small")
            small.textContent = description
            button:append(small)
        end
        button:addEventListener("click", callback)
        modal:querySelector(".swift-choices"):append(button)
        return button
    end
    function renderQuestion(self)
        updateCurrent(nil)
        local ____t_15 = __t
        local ____opt_12 = window.Difficulty
        if ____opt_12 ~= nil then
            ____opt_12 = ____opt_12.isLocked
        end
        local ____opt_result_14
        if ____opt_12 ~= nil then
            ____opt_result_14 = ____opt_12(____opt_12)
        end
        if ____t_15(____opt_result_14) then
            modal:querySelector(".swift-question").textContent = "Fácil escolhido, chapéu! Essa aventura ficou no modo bebezinho. Só criando um novo save pra trocar, viu?"
            modal:querySelector(".swift-choices"):replaceChildren()
            modal:querySelector(".swift-back").hidden = true
            addChoice(
                nil,
                "SEGUIR NO FÁCIL",
                "no",
                function() return finish(nil) end
            )
            return
        end
        modal:querySelector(".swift-question").textContent = "Ô, Da Roça! Tá difícil demais? Quer mudar a dificuldade?"
        modal:querySelector(".swift-choices"):replaceChildren()
        modal:querySelector(".swift-back").hidden = true
        __call(
            addChoice(nil, "SIM, QUERO ESCOLHER", "yes", renderModes).classList,
            "add",
            "swift-yes"
        )
        addChoice(
            nil,
            "NÃO, BORA CONTINUAR",
            "no",
            function() return finish(nil) end
        )
        if __t(modal.open) then
            modal:querySelector("[data-swift-choice=\"yes\"]"):focus({preventScroll = true})
        end
    end
    function renderModes(self)
        updateCurrent(nil)
        modal:querySelector(".swift-question").textContent = "Escolhe aí. O bolo continua no mesmo lugar!"
        modal:querySelector(".swift-choices"):replaceChildren()
        modal:querySelector(".swift-back").hidden = false
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({"easy", "FÁCIL", "Chefes com menos vida. Fica travado neste save; só uma nova aventura permite trocar."}, 3),
                __arrL({"normal", "NORMAL", "O desafio original da campanha."}, 3),
                __arrL({"hard", "DIFÍCIL", "Chefes mais agressivos e golpes que tiram o dobro."}, 3)
            },
            3
        ))) do
            local id = ____value[1]
            local label = ____value[2]
            local description = ____value[3]
            local button = addChoice(
                nil,
                label,
                id,
                function() return choose(nil, id) end,
                description
            )
            button:setAttribute(
                "aria-pressed",
                tostring(settings(nil).id == id)
            )
            local ____t_21 = __t
            local ____opt_18 = window.Difficulty
            if ____opt_18 ~= nil then
                ____opt_18 = ____opt_18.isLocked
            end
            local ____opt_result_20
            if ____opt_18 ~= nil then
                ____opt_result_20 = ____opt_18(____opt_18)
            end
            button.disabled = not not ____t_21(____opt_result_20) and id ~= "easy"
        end
        local ____opt_22 = modal:querySelector(__add(
            __add(
                "[data-swift-choice=\"",
                settings(nil).id
            ),
            "\"]"
        ))
        if ____opt_22 ~= nil then
            ____opt_22:focus({preventScroll = true})
        end
    end
    function choose(self, mode)
        if __t(not __t(session) or not __t(__call(
            __arrL({"easy", "normal", "hard"}, 3),
            "includes",
            mode
        ))) then
            return false
        end
        local ____t_29 = __t
        local ____opt_26 = window.Difficulty
        if ____opt_26 ~= nil then
            ____opt_26 = ____opt_26.setMode
        end
        local ____opt_result_28
        if ____opt_26 ~= nil then
            ____opt_result_28 = ____opt_26(____opt_26, mode)
        end
        if not ____t_29(____opt_result_28) then
            local ____this_31
            ____this_31 = session.api
            local ____opt_30 = ____this_31.toast
            if ____opt_30 ~= nil then
                ____opt_30(____this_31, "O modo Fácil ficou travado neste save. Crie uma nova aventura para mudar.")
            end
            return false
        end
        session.result = mode
        finish(nil)
        return true
    end
    function finishSession(self)
        local ____t_36 = __t
        local ____t_35 = __t
        local ____opt_result_34
        if modal ~= nil then
            ____opt_result_34 = modal.open
        end
        __O[1439] = ____opt_result_34
        if ____t_36(if ____t_35(____opt_result_34) then __O[1439] else not __t(session)) then
            return
        end
        local prior = session
        session = nil
        local ____opt_39 = window.Game
        if ____opt_39 ~= nil then
            ____opt_39 = ____opt_39.releaseInputs
        end
        if ____opt_39 ~= nil then
            ____opt_39(____opt_39)
        end
        if __t(prior.resumeAfter) then
            local ____opt_43 = window.Game
            if ____opt_43 ~= nil then
                ____opt_43 = ____opt_43.resume
            end
            if ____opt_43 ~= nil then
                ____opt_43(____opt_43)
            end
        end
        local ____opt_47 = window.CampaignRun
        if ____opt_47 ~= nil then
            ____opt_47 = ____opt_47.confirmInitialMode
        end
        if ____opt_47 ~= nil then
            ____opt_47(____opt_47)
        end
        if __t(prior.result) then
            local mode = prior.result
            local ____this_50
            ____this_50 = prior.api
            local ____opt_49 = ____this_50.say
            if ____opt_49 ~= nil then
                ____opt_49(
                    ____this_50,
                    __arrL({{name = npc.name, text = if mode == "easy" then "Frouxo! Bebezinho, não aguenta nem o normal, pô!" else if mode == "hard" then "Aí sim, Da Roça! No difícil é reflexo afiado e atributo em dia. Respeito!" else "Normal? Fechou, Da Roça! Desafio de respeito. Agora vai buscar teu bolo!"}}, 1)
                )
            end
        else
            local ____opt_51 = window.document:getElementById("gameCanvas")
            if ____opt_51 ~= nil then
                ____opt_51:focus({preventScroll = true})
            end
        end
    end
    function finish(self)
        local ____t_56 = __t
        local ____opt_result_55
        if modal ~= nil then
            ____opt_result_55 = modal.open
        end
        if ____t_56(____opt_result_55) then
            modal:close()
            finishSession(nil)
        end
    end
    local ____ = "use strict"
    npc = __ord({id = "swift", name = "Irmão de Clara Swift", scene = 0, x = 340}, "id,name,scene,x")
    modal = nil
    session = nil
    local function draw(self, c, x, y, options)
        if options == nil then
            options = {}
        end
        local ____t_1 = __t
        local ____TS__Number_result_0 = __TS__Number(options.frame)
        __O[1436] = ____TS__Number_result_0
        local t = if ____t_1(____TS__Number_result_0) then __O[1436] else 0
        local bob = math.floor(math.sin(t * 2.4) * 1.2)
        local talk = options.talking
        c:save()
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
        c:scale(if options.facing == -1 then -1 else 1, 1)
        c:scale(if __t(options.scale) then options.scale else 1, if __t(options.scale) then options.scale else 1)
        c.imageSmoothingEnabled = false
        local function r(____, xx, yy, w, h, color)
            c.fillStyle = color
            c:fillRect(xx, yy, w, h)
        end
        r(
            nil,
            -13,
            -2,
            26,
            4,
            "#243a3445"
        )
        r(
            nil,
            -8,
            -23,
            6,
            21,
            "#233c52"
        )
        r(
            nil,
            3,
            -23,
            6,
            21,
            "#29465e"
        )
        r(
            nil,
            -10,
            -4,
            10,
            4,
            "#e4e4cb"
        )
        r(
            nil,
            3,
            -4,
            11,
            4,
            "#d4dcc5"
        )
        c:translate(0, bob)
        r(
            nil,
            -10,
            -45,
            20,
            25,
            "#243a43"
        )
        r(
            nil,
            -8,
            -43,
            16,
            23,
            "#65919a"
        )
        r(
            nil,
            -3,
            -44,
            6,
            4,
            "#c18d64"
        )
        r(
            nil,
            -2,
            -37,
            4,
            15,
            "#81a8ac"
        )
        r(
            nil,
            -12,
            -42,
            5,
            19,
            "#a76e48"
        )
        r(
            nil,
            8,
            -42,
            5,
            19,
            "#b78056"
        )
        local hand = if __t(talk) then math.floor(math.sin(t * 5) * 3) else 0
        r(
            nil,
            9,
            -27 - hand,
            5,
            7,
            "#c28c61"
        )
        r(
            nil,
            -13,
            -27,
            5,
            7,
            "#bb8258"
        )
        r(
            nil,
            -10,
            -66,
            20,
            24,
            "#2b2927"
        )
        r(
            nil,
            -8,
            -64,
            16,
            21,
            "#b67b52"
        )
        r(
            nil,
            -9,
            -66,
            18,
            7,
            "#151d24"
        )
        r(
            nil,
            -10,
            -62,
            3,
            7,
            "#1c242a"
        )
        r(
            nil,
            7,
            -62,
            3,
            7,
            "#192128"
        )
        r(
            nil,
            -10,
            -55,
            3,
            7,
            "#ac714d"
        )
        r(
            nil,
            8,
            -55,
            3,
            7,
            "#b67b52"
        )
        local blink = math.sin(t * 1.7) > 0.993
        r(
            nil,
            -6,
            -57,
            5,
            if __t(blink) then 1 else 6,
            "#f5ebcf"
        )
        r(
            nil,
            3,
            -57,
            5,
            if __t(blink) then 1 else 6,
            "#f5ebcf"
        )
        if not __t(blink) then
            r(
                nil,
                -4,
                -55,
                2,
                3,
                "#25292a"
            )
            r(
                nil,
                5,
                -55,
                2,
                3,
                "#25292a"
            )
        end
        r(
            nil,
            -6,
            -60,
            5,
            2,
            "#292523"
        )
        r(
            nil,
            3,
            -60,
            5,
            2,
            "#292523"
        )
        r(
            nil,
            0,
            -53,
            2,
            4,
            "#9a603e"
        )
        r(
            nil,
            -3,
            -46,
            if __t(talk) then 7 else 6,
            if __t(talk) then 3 else 2,
            if __t(talk) then "#623c32" else "#794737"
        )
        c:restore()
    end
    local function ensureModal(self)
        if __t(modal) then
            return modal
        end
        local style = window.document:createElement("style")
        style.textContent = "\n  .swift-dialog{width:min(510px,calc(100vw - 28px));max-height:calc(100dvh - 24px);overflow:auto;box-sizing:border-box;border:4px solid #78502d;border-radius:5px;padding:0;background:#f0e2bb;color:#3a3828;box-shadow:0 0 0 3px #bd9755,0 16px 60px #081d30a0;font:15px/1.6 Arial,sans-serif}.swift-dialog::backdrop{background:#12283ab8}.swift-heading{display:flex;align-items:center;justify-content:space-between;gap:12px;padding:11px 17px;background:#38594d;color:#fff0c5;border-bottom:3px solid #b28b4f}.swift-heading span{font:bold 11px/1.4 monospace;letter-spacing:1px}.swift-close{width:36px;height:36px;flex-shrink:0;border:2px solid #849979;background:#29493f;color:#fff1cd;font:24px Arial;cursor:pointer}.swift-content{padding:16px 22px 20px}.swift-speaker{display:flex;align-items:center;gap:16px;margin-bottom:6px}.swift-speaker canvas{width:80px;height:90px;image-rendering:pixelated;flex-shrink:0;background:#cfdbc0;border:2px solid #8d9f7b}.swift-speaker h2{font:bold 22px/1.2 Georgia,serif;margin:0 0 4px}.swift-current{font:12px/1.4 monospace;color:#596643}.swift-question{margin:14px 0 18px;font-size:17px;font-weight:bold}.swift-choices{display:grid;gap:10px}.swift-choices button,.swift-back{font:bold 14px/1.4 Arial,sans-serif;min-height:49px;text-align:left;border:2px solid #887244;border-bottom-width:5px;border-radius:3px;padding:10px 14px;background:#f8edce;color:#374334;cursor:pointer;touch-action:manipulation}.swift-choices button:hover{background:#fff8df;border-color:#507347}.swift-choices button:focus-visible,.swift-close:focus-visible,.swift-back:focus-visible{outline:3px solid #2c7a95;outline-offset:3px}.swift-choices button small{display:block;font-weight:normal;color:#626a4d;font-size:12px;margin-top:3px}.swift-choices button[aria-pressed=\"true\"]{background:#d2e2ac;border-color:#56743b}.swift-choices .swift-yes{background:#d7e5b2}.swift-back{margin-top:12px;background:transparent;min-height:40px;padding:7px 12px;font-size:12px}.swift-hint{font-size:12px;color:#6e7156;margin:15px 0 0}@media(max-height:410px) and (orientation:landscape){.swift-dialog{width:min(630px,calc(100vw - 28px))}.swift-heading{padding:6px 14px}.swift-content{padding:10px 18px}.swift-speaker canvas{width:48px;height:54px}.swift-speaker h2{font-size:20px}.swift-question{margin:7px 0 10px;font-size:15px}.swift-choices{grid-template-columns:repeat(3,minmax(0,1fr));gap:8px}.swift-choices button{font-size:12px;padding:8px;min-height:45px}.swift-choices button small{font-size:10px}.swift-hint{margin:8px 0 0}.swift-back{margin-top:8px}}\n  "
        window.document.head:append(style)
        modal = window.document:createElement("dialog")
        modal.className = "swift-dialog"
        modal.id = "swiftGuideDialog"
        modal:setAttribute("aria-labelledby", "swiftGuideName")
        modal:setAttribute("aria-describedby", "swiftGuideQuestion")
        modal.innerHTML = "<div class=\"swift-heading\"><span>NA ENTRADA DA ROÇA</span><button class=\"swift-close\" type=\"button\" aria-label=\"Fechar conversa\">×</button></div><div class=\"swift-content\"><div class=\"swift-speaker\"><canvas width=\"80\" height=\"90\" aria-label=\"Irmão de Clara Swift: moreno, magro, cabelo preto curto e olhos abertos\"></canvas><div><h2 id=\"swiftGuideName\"></h2><div class=\"swift-current\"></div></div></div><p class=\"swift-question\" id=\"swiftGuideQuestion\"></p><div class=\"swift-choices\"></div><button class=\"swift-back\" type=\"button\" hidden>← VOLTAR À PERGUNTA</button><p class=\"swift-hint\">Normal e Difícil podem ser trocados. Escolher Fácil trava esta aventura; para mudar, crie um novo save.</p></div>"
        local ____t_3 = __t
        local ____temp_2 = window.document:getElementById("gameShell")
        __O[1437] = ____temp_2
        if ____t_3(____temp_2) then __O[1437] else window.document.body:append(modal)
        modal:querySelector("h2").textContent = npc.name
        local portrait = modal:querySelector("canvas")
        draw(
            nil,
            portrait:getContext("2d"),
            40,
            84,
            {scale = 1.1, facing = 1, frame = 0}
        )
        modal:querySelector(".swift-close"):addEventListener(
            "click",
            function() return finish(nil) end
        )
        modal:querySelector(".swift-back"):addEventListener(
            "click",
            function() return renderQuestion(nil) end
        )
        modal:addEventListener(
            "cancel",
            function(____, e)
                e:preventDefault()
                finish(nil)
            end
        )
        modal:addEventListener("close", finishSession)
        return modal
    end
    settings = function()
        local ____t_9 = __t
        local ____opt_6 = window.Difficulty
        if ____opt_6 ~= nil then
            ____opt_6 = ____opt_6.getSettings
        end
        local ____opt_result_8
        if ____opt_6 ~= nil then
            ____opt_result_8 = ____opt_6(____opt_6)
        end
        __O[1438] = ____opt_result_8
        return if ____t_9(____opt_result_8) then __O[1438] else {id = "normal", label = "NORMAL"}
    end
    local function open(self, api)
        if api == nil then
            api = {}
        end
        local ____opt_59 = window.Game
        if ____opt_59 ~= nil then
            ____opt_59 = ____opt_59.getState
        end
        local ____opt_result_61
        if ____opt_59 ~= nil then
            ____opt_result_61 = ____opt_59(____opt_59)
        end
        local state = ____opt_result_61
        local ____t_90 = __t
        local ____t_89 = __t
        local ____t_87 = __t
        local ____t_85 = __t
        local ____t_83 = __t
        local ____t_79 = __t
        local ____t_77 = __t
        local ____t_75 = __t
        local ____t_73 = __t
        local ____t_71 = __t
        local ____t_69 = __t
        local ____t_67 = __t
        local ____t_65 = __t
        local ____opt_result_64
        if state ~= nil then
            ____opt_result_64 = state.started
        end
        local ____temp_66 = if __t(session) then session else not ____t_65(____opt_result_64)
        __O[1440] = ____temp_66
        local ____temp_68 = if ____t_67(____temp_66) then __O[1440] else state.sandbox
        __O[1441] = ____temp_68
        local ____temp_70 = if ____t_69(____temp_68) then __O[1441] else state.cutscene
        __O[1442] = ____temp_70
        local ____temp_72 = if ____t_71(____temp_70) then __O[1442] else state.dialog
        __O[1443] = ____temp_72
        local ____temp_74 = if ____t_73(____temp_72) then __O[1443] else state.activeBoss
        __O[1444] = ____temp_74
        local ____temp_76 = if ____t_75(____temp_74) then __O[1444] else state.room
        __O[1445] = ____temp_76
        local ____temp_78 = if ____t_77(____temp_76) then __O[1445] else state.activity
        __O[1446] = ____temp_78
        local ____opt_80 = state.training
        if ____opt_80 ~= nil then
            ____opt_80 = ____opt_80.active
        end
        local ____temp_82 = if ____t_79(____temp_78) then __O[1446] else ____opt_80
        __O[1447] = ____temp_82
        local ____temp_84 = if ____t_83(____temp_82) then __O[1447] else state.defeated
        __O[1448] = ____temp_84
        local ____temp_86 = if ____t_85(____temp_84) then __O[1448] else state.won
        __O[1449] = ____temp_86
        local ____temp_88 = if ____t_87(____temp_86) then __O[1449] else state.chapterEnded
        __O[1450] = ____temp_88
        if ____t_90(if ____t_89(____temp_88) then __O[1450] else window.document:querySelector("dialog[open]")) then
            return false
        end
        ensureModal(nil)
        session = {
            api = api,
            resumeAfter = not __t(state.paused),
            result = nil
        }
        local ____opt_93 = window.Game
        if ____opt_93 ~= nil then
            ____opt_93 = ____opt_93.releaseInputs
        end
        if ____opt_93 ~= nil then
            ____opt_93(____opt_93)
        end
        if __t(session.resumeAfter) then
            local ____opt_97 = window.Game
            if ____opt_97 ~= nil then
                ____opt_97 = ____opt_97.pause
            end
            if ____opt_97 ~= nil then
                ____opt_97(____opt_97)
            end
        end
        renderQuestion(nil)
        modal:showModal()
        local ____opt_99 = modal:querySelector("[data-swift-choice]")
        if ____opt_99 ~= nil then
            ____opt_99:focus({preventScroll = true})
        end
        return true
    end
    window.SwiftGuide = __ord(
        {
            npc = npc,
            draw = draw,
            open = open,
            firstPrompt = open,
            close = finish,
            isOpen = function()
                local ____t_104 = __t
                local ____opt_result_103
                if modal ~= nil then
                    ____opt_result_103 = modal.open
                end
                return not not ____t_104(____opt_result_103)
            end
        },
        "npc,draw,open,firstPrompt,close,isOpen"
    )
end)(nil)
return ____exports
