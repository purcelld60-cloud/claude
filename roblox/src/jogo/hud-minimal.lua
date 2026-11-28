--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __ord, __arrL, __t, __add, __new = __JSR.__ord, __JSR.__arrL, __JSR.__t, __JSR.__add, __JSR.__new
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__ParseFloat = ____lualib.__TS__ParseFloat
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    if __t(window.HudMinimal) then
        return
    end
    local bar = window.document:querySelector(".game-topbar")
    local progress = window.document:querySelector(".progress-hud")
    local ____t_3 = __t
    local ____t_result_2
    local ____t_1 = __t
    local ____temp_0 = not __t(bar)
    __O[3193] = ____temp_0
    if ____t_1(____temp_0) then
        ____t_result_2 = __O[3193]
    else
        ____t_result_2 = bar.dataset.minimal
    end
    if ____t_3(____t_result_2) then
        return
    end
    bar.dataset.minimal = "1"
    local function _____24(____, s)
        local ____t_result_6
        local ____t_5 = __t
        local ____temp_4 = bar:querySelector(s)
        __O[3194] = ____temp_4
        if ____t_5(____temp_4) then
            ____t_result_6 = __O[3194]
        else
            ____t_result_6 = window.document:querySelector(s)
        end
        return ____t_result_6
    end
    local function el(____, tag, cls, html)
        local e = window.document:createElement(tag)
        if __t(cls) then
            e.className = cls
        end
        if html ~= nil then
            e.innerHTML = html
        end
        return e
    end
    local hearts = _____24(nil, "#hpValue")
    local ammo = _____24(nil, ".ammo")
    local playerInfo = _____24(nil, ".player-info")
    local gas = _____24(nil, ".gas-block")
    local inv = _____24(nil, ".inventory-hud")
    local loc = _____24(nil, ".location")
    local actions = _____24(nil, ".game-actions")
    local statsBtn = progress and progress:querySelector("#statsBtn")
    local xp = progress and progress:querySelector(".xp-block")
    local chapter = progress and progress:querySelector("#campaignChapter")
    local ____t_16 = __t
    local ____t_result_15
    local ____t_14 = __t
    local ____temp_13 = not __t(hearts) or not __t(ammo)
    __O[3195] = ____temp_13
    if ____t_14(____temp_13) then
        ____t_result_15 = __O[3195]
    else
        ____t_result_15 = not __t(actions)
    end
    if ____t_16(____t_result_15) then
        return
    end
    local left = el(nil, "div", "hud-min-left")
    local gasMini = el(nil, "div", "hud-gas-mini", "GÁS<i><b></b></i>")
    left:append(hearts, ammo, gasMini)
    local dataPanel = el(nil, "div", "hud-panel", "")
    local invPanel = el(nil, "div", "hud-panel", "")
    dataPanel.id = "hudDataPanel"
    invPanel.id = "hudInvPanel"
    invPanel.hidden = true
    dataPanel.hidden = true
    dataPanel:setAttribute("role", "dialog")
    dataPanel:setAttribute("aria-label", "Dados")
    invPanel:setAttribute("role", "dialog")
    invPanel:setAttribute("aria-label", "Inventário")
    dataPanel:append(el(nil, "h3", "", "DADOS"))
    if __t(playerInfo) then
        dataPanel:append(playerInfo)
    end
    if __t(gas) then
        dataPanel:append(gas)
    end
    if __t(loc) then
        dataPanel:append(loc)
    end
    if __t(statsBtn) then
        dataPanel:append(statsBtn)
    end
    if __t(xp) then
        dataPanel:append(xp)
    end
    if __t(chapter) then
        dataPanel:append(chapter)
    end
    invPanel:append(el(nil, "h3", "", "INVENTÁRIO"))
    local paperRow = el(nil, "div", "hud-row", "<span>◆ PAPEL</span><b id=\"hudPaperMirror\">∞</b>")
    invPanel:append(paperRow)
    if __t(inv) then
        invPanel:append(inv)
    end
    invPanel:append(el(nil, "div", "hud-sub", "Materiais servem para o Kaua melhorar a sua arma."))
    local dataBtn = el(nil, "button", "hud-btn", "DADOS<span class=\"hud-dot\"></span>")
    local invBtn = el(nil, "button", "hud-btn", "INVENTÁRIO")
    invBtn.type = "button"
    dataBtn.type = "button"
    dataBtn:setAttribute("aria-expanded", "false")
    invBtn:setAttribute("aria-expanded", "false")
    dataBtn:setAttribute("aria-controls", "hudDataPanel")
    invBtn:setAttribute("aria-controls", "hudInvPanel")
    local right = el(nil, "div", "hud-min-right")
    right:append(dataBtn, invBtn, actions)
    bar.textContent = ""
    bar:append(left, right, dataPanel, invPanel)
    if __t(progress) then
        progress.textContent = ""
    end
    local function close(self)
        invPanel.hidden = true
        dataPanel.hidden = true
        dataBtn:setAttribute("aria-expanded", "false")
        invBtn:setAttribute("aria-expanded", "false")
    end
    local function toggle(self, panel, btn, other, otherBtn)
        local open = panel.hidden
        close(nil)
        if __t(open) then
            panel.hidden = false
            btn:setAttribute("aria-expanded", "true")
        end
    end
    dataBtn:addEventListener(
        "click",
        function() return toggle(nil, dataPanel, dataBtn) end
    )
    invBtn:addEventListener(
        "click",
        function() return toggle(nil, invPanel, invBtn) end
    )
    window.document:addEventListener(
        "pointerdown",
        function(____, e)
            local ____t_18 = __t
            local ____t_result_17
            if __t(dataPanel.hidden) then
                ____t_result_17 = invPanel.hidden
            else
                ____t_result_17 = dataPanel.hidden
            end
            if ____t_18(____t_result_17) then
                return
            end
            if __t(e.target:closest(".hud-panel,.hud-btn,dialog")) then
                return
            end
            close(nil)
        end,
        true
    )
    window.document:addEventListener(
        "keydown",
        function(____, e)
            local ____t_22 = __t
            local ____temp_21 = e.key == "Escape"
            if ____temp_21 then
                local ____t_20 = __t
                local ____t_result_19
                if __t(dataPanel.hidden) then
                    ____t_result_19 = invPanel.hidden
                else
                    ____t_result_19 = dataPanel.hidden
                end
                ____temp_21 = not ____t_20(____t_result_19)
            end
            if ____t_22(____temp_21) then
                close(nil)
            end
        end
    )
    if statsBtn ~= nil then
        statsBtn:addEventListener("click", close)
    end
    local paper = ammo:querySelector("#paperValue")
    local mirror = invPanel:querySelector("#hudPaperMirror")
    local ____t_26 = __t
    local ____t_result_25
    if __t(paper) then
        ____t_result_25 = mirror
    else
        ____t_result_25 = paper
    end
    if ____t_26(____t_result_25) then
        local function sync()
            mirror.textContent = paper.textContent
        end
        sync(nil)
        __new("MutationObserver", sync):observe(
            paper,
            __ord({childList = true, characterData = true, subtree = true}, "childList,characterData,subtree")
        )
    end
    local ____opt_result_29
    if gas ~= nil then
        ____opt_result_29 = gas:querySelector("#gasPercent")
    end
    local gasPct = ____opt_result_29
    local ____opt_result_32
    if gas ~= nil then
        ____opt_result_32 = gas:querySelector("#gasFill")
    end
    local gasFill = ____opt_result_32
    local mini = gasMini:querySelector("b")
    local ____t_34 = __t
    local ____t_result_33
    if __t(gasPct) then
        ____t_result_33 = gasFill
    else
        ____t_result_33 = gasPct
    end
    if ____t_34(____t_result_33) then
        local function sync()
            local ____t_result_37
            local ____t_36 = __t
            local ____TS__ParseFloat_result_35 = __TS__ParseFloat(gasPct.textContent)
            __O[3196] = ____TS__ParseFloat_result_35
            if ____t_36(____TS__ParseFloat_result_35) then
                ____t_result_37 = __O[3196]
            else
                ____t_result_37 = 0
            end
            local v = ____t_result_37
            mini.style.width = __add(
                math.max(
                    0,
                    math.min(100, v)
                ),
                "%"
            )
            gasMini.classList:toggle("on", v < 99.5)
        end
        sync(nil)
        __new("MutationObserver", sync):observe(
            gasPct,
            __ord({childList = true, characterData = true, subtree = true}, "childList,characterData,subtree")
        )
    end
    if __t(statsBtn) then
        local function sync()
            return dataBtn.classList:toggle(
                "alert",
                statsBtn.classList:contains("has-points")
            )
        end
        sync(nil)
        __new("MutationObserver", sync):observe(
            statsBtn,
            __ord(
                {
                    attributes = true,
                    attributeFilter = __arrL({"class"}, 1)
                },
                "attributes,attributeFilter"
            )
        )
    end
    window.HudMinimal = {close = close}
    window:setTimeout(
        function() return window:dispatchEvent(__new("Event", "resize")) end,
        0
    )
end)(nil)
return ____exports
