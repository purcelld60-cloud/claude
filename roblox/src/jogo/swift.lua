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
        local ____t_23 = __t
        local ____opt_20 = window.Difficulty
        if ____opt_20 ~= nil then
            ____opt_20 = ____opt_20.isLocked
        end
        local ____opt_result_22
        if ____opt_20 ~= nil then
            ____opt_result_22 = ____opt_20(____opt_20)
        end
        if ____t_23(____opt_result_22) then
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
            local ____t_29 = __t
            local ____opt_26 = window.Difficulty
            if ____opt_26 ~= nil then
                ____opt_26 = ____opt_26.isLocked
            end
            local ____opt_result_28
            if ____opt_26 ~= nil then
                ____opt_result_28 = ____opt_26(____opt_26)
            end
            button.disabled = not not ____t_29(____opt_result_28) and id ~= "easy"
        end
        local ____opt_30 = modal:querySelector(__add(
            __add(
                "[data-swift-choice=\"",
                settings(nil).id
            ),
            "\"]"
        ))
        if ____opt_30 ~= nil then
            ____opt_30:focus({preventScroll = true})
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
        local ____t_37 = __t
        local ____opt_34 = window.Difficulty
        if ____opt_34 ~= nil then
            ____opt_34 = ____opt_34.setMode
        end
        local ____opt_result_36
        if ____opt_34 ~= nil then
            ____opt_result_36 = ____opt_34(____opt_34, mode)
        end
        if not ____t_37(____opt_result_36) then
            local ____this_39
            ____this_39 = session.api
            local ____opt_38 = ____this_39.toast
            if ____opt_38 ~= nil then
                ____opt_38(____this_39, "O modo Fácil ficou travado neste save. Crie uma nova aventura para mudar.")
            end
            return false
        end
        session.result = mode
        finish(nil)
        return true
    end
    function finishSession(self)
        local ____t_45 = __t
        local ____t_result_44
        local ____t_43 = __t
        local ____opt_result_42
        if modal ~= nil then
            ____opt_result_42 = modal.open
        end
        __O[1473] = ____opt_result_42
        if ____t_43(____opt_result_42) then
            ____t_result_44 = __O[1473]
        else
            ____t_result_44 = not __t(session)
        end
        if ____t_45(____t_result_44) then
            return
        end
        local prior = session
        session = nil
        local ____opt_48 = window.Game
        if ____opt_48 ~= nil then
            ____opt_48 = ____opt_48.releaseInputs
        end
        if ____opt_48 ~= nil then
            ____opt_48(____opt_48)
        end
        if __t(prior.resumeAfter) then
            local ____opt_52 = window.Game
            if ____opt_52 ~= nil then
                ____opt_52 = ____opt_52.resume
            end
            if ____opt_52 ~= nil then
                ____opt_52(____opt_52)
            end
        end
        local ____opt_56 = window.CampaignRun
        if ____opt_56 ~= nil then
            ____opt_56 = ____opt_56.confirmInitialMode
        end
        if ____opt_56 ~= nil then
            ____opt_56(____opt_56)
        end
        if __t(prior.result) then
            local mode = prior.result
            local ____this_59
            ____this_59 = prior.api
            local ____opt_58 = ____this_59.say
            if ____opt_58 ~= nil then
                ____opt_58(
                    ____this_59,
                    __arrL({{name = npc.name, text = mode == "easy" and "Frouxo! Bebezinho, não aguenta nem o normal, pô!" or (mode == "hard" and "Aí sim, Da Roça! No difícil é reflexo afiado e atributo em dia. Respeito!" or "Normal? Fechou, Da Roça! Desafio de respeito. Agora vai buscar teu bolo!")}}, 1)
                )
            end
        else
            local ____opt_60 = window.document:getElementById("gameCanvas")
            if ____opt_60 ~= nil then
                ____opt_60:focus({preventScroll = true})
            end
        end
    end
    function finish(self)
        local ____t_65 = __t
        local ____opt_result_64
        if modal ~= nil then
            ____opt_result_64 = modal.open
        end
        if ____t_65(____opt_result_64) then
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
        local ____t_result_2
        local ____t_1 = __t
        local ____TS__Number_result_0 = __TS__Number(options.frame)
        __O[1470] = ____TS__Number_result_0
        if ____t_1(____TS__Number_result_0) then
            ____t_result_2 = __O[1470]
        else
            ____t_result_2 = 0
        end
        local t = ____t_result_2
        local bob = math.floor(math.sin(t * 2.4) * 1.2)
        local talk = options.talking
        c:save()
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
        c:scale(options.facing == -1 and -1 or 1, 1)
        local ____c_5 = c
        local ____c_scale_6 = c.scale
        local ____t_result_3
        if __t(options.scale) then
            ____t_result_3 = options.scale
        else
            ____t_result_3 = 1
        end
        local ____t_result_4
        if __t(options.scale) then
            ____t_result_4 = options.scale
        else
            ____t_result_4 = 1
        end
        ____c_scale_6(____c_5, ____t_result_3, ____t_result_4)
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
        local ____t_result_7
        if __t(talk) then
            ____t_result_7 = math.floor(math.sin(t * 5) * 3)
        else
            ____t_result_7 = 0
        end
        local hand = ____t_result_7
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
            __t(blink) and 1 or 6,
            "#f5ebcf"
        )
        r(
            nil,
            3,
            -57,
            5,
            __t(blink) and 1 or 6,
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
            __t(talk) and 7 or 6,
            __t(talk) and 3 or 2,
            __t(talk) and "#623c32" or "#794737"
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
        local ____t_result_10
        local ____t_9 = __t
        local ____temp_8 = window.document:getElementById("gameShell")
        __O[1471] = ____temp_8
        if ____t_9(____temp_8) then
            ____t_result_10 = __O[1471]
        else
            ____t_result_10 = window.document.body
        end
        ____t_result_10:append(modal)
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
        local ____t_result_17
        local ____t_16 = __t
        local ____opt_13 = window.Difficulty
        if ____opt_13 ~= nil then
            ____opt_13 = ____opt_13.getSettings
        end
        local ____opt_result_15
        if ____opt_13 ~= nil then
            ____opt_result_15 = ____opt_13(____opt_13)
        end
        __O[1472] = ____opt_result_15
        if ____t_16(____opt_result_15) then
            ____t_result_17 = __O[1472]
        else
            ____t_result_17 = {id = "normal", label = "NORMAL"}
        end
        return ____t_result_17
    end
    local function open(self, api)
        if api == nil then
            api = {}
        end
        local ____opt_68 = window.Game
        if ____opt_68 ~= nil then
            ____opt_68 = ____opt_68.getState
        end
        local ____opt_result_70
        if ____opt_68 ~= nil then
            ____opt_result_70 = ____opt_68(____opt_68)
        end
        local state = ____opt_result_70
        local ____t_100 = __t
        local ____t_result_99
        local ____t_98 = __t
        local ____t_result_97
        local ____t_96 = __t
        local ____t_result_95
        local ____t_94 = __t
        local ____t_result_93
        local ____t_92 = __t
        local ____t_result_91
        local ____t_88 = __t
        local ____t_result_87
        local ____t_86 = __t
        local ____t_result_85
        local ____t_84 = __t
        local ____t_result_83
        local ____t_82 = __t
        local ____t_result_81
        local ____t_80 = __t
        local ____t_result_79
        local ____t_78 = __t
        local ____t_result_77
        local ____t_76 = __t
        local ____t_result_75
        if __t(session) then
            ____t_result_75 = session
        else
            local ____t_74 = __t
            local ____opt_result_73
            if state ~= nil then
                ____opt_result_73 = state.started
            end
            ____t_result_75 = not ____t_74(____opt_result_73)
        end
        __O[1474] = ____t_result_75
        if ____t_76(____t_result_75) then
            ____t_result_77 = __O[1474]
        else
            ____t_result_77 = state.sandbox
        end
        __O[1475] = ____t_result_77
        if ____t_78(____t_result_77) then
            ____t_result_79 = __O[1475]
        else
            ____t_result_79 = state.cutscene
        end
        __O[1476] = ____t_result_79
        if ____t_80(____t_result_79) then
            ____t_result_81 = __O[1476]
        else
            ____t_result_81 = state.dialog
        end
        __O[1477] = ____t_result_81
        if ____t_82(____t_result_81) then
            ____t_result_83 = __O[1477]
        else
            ____t_result_83 = state.activeBoss
        end
        __O[1478] = ____t_result_83
        if ____t_84(____t_result_83) then
            ____t_result_85 = __O[1478]
        else
            ____t_result_85 = state.room
        end
        __O[1479] = ____t_result_85
        if ____t_86(____t_result_85) then
            ____t_result_87 = __O[1479]
        else
            ____t_result_87 = state.activity
        end
        __O[1480] = ____t_result_87
        if ____t_88(____t_result_87) then
            ____t_result_91 = __O[1480]
        else
            local ____opt_89 = state.training
            if ____opt_89 ~= nil then
                ____opt_89 = ____opt_89.active
            end
            ____t_result_91 = ____opt_89
        end
        __O[1481] = ____t_result_91
        if ____t_92(____t_result_91) then
            ____t_result_93 = __O[1481]
        else
            ____t_result_93 = state.defeated
        end
        __O[1482] = ____t_result_93
        if ____t_94(____t_result_93) then
            ____t_result_95 = __O[1482]
        else
            ____t_result_95 = state.won
        end
        __O[1483] = ____t_result_95
        if ____t_96(____t_result_95) then
            ____t_result_97 = __O[1483]
        else
            ____t_result_97 = state.chapterEnded
        end
        __O[1484] = ____t_result_97
        if ____t_98(____t_result_97) then
            ____t_result_99 = __O[1484]
        else
            ____t_result_99 = window.document:querySelector("dialog[open]")
        end
        if ____t_100(____t_result_99) then
            return false
        end
        ensureModal(nil)
        session = {
            api = api,
            resumeAfter = not __t(state.paused),
            result = nil
        }
        local ____opt_103 = window.Game
        if ____opt_103 ~= nil then
            ____opt_103 = ____opt_103.releaseInputs
        end
        if ____opt_103 ~= nil then
            ____opt_103(____opt_103)
        end
        if __t(session.resumeAfter) then
            local ____opt_107 = window.Game
            if ____opt_107 ~= nil then
                ____opt_107 = ____opt_107.pause
            end
            if ____opt_107 ~= nil then
                ____opt_107(____opt_107)
            end
        end
        renderQuestion(nil)
        modal:showModal()
        local ____opt_109 = modal:querySelector("[data-swift-choice]")
        if ____opt_109 ~= nil then
            ____opt_109:focus({preventScroll = true})
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
                local ____t_114 = __t
                local ____opt_result_113
                if modal ~= nil then
                    ____opt_result_113 = modal.open
                end
                return not not ____t_114(____opt_result_113)
            end
        },
        "npc,draw,open,firstPrompt,close,isOpen"
    )
end)(nil)
return ____exports
