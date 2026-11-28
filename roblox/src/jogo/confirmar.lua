--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __t = __JSR.__t
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Promise = ____lualib.__TS__Promise
local __TS__New = ____lualib.__TS__New
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    if __t(window.Confirmar) then
        return
    end
    local SAVE = "da-roca-adventure-v1"
    local css = ".dr-confirma{position:fixed;inset:0;z-index:2147483000;display:grid;place-items:center;background:rgba(14,9,5,.72);backdrop-filter:blur(2px);-webkit-backdrop-filter:blur(2px);animation:drcf .16s ease-out}\n.dr-confirma[hidden]{display:none}\n.dr-confirma .caixa{width:min(92vw,440px);max-height:calc(100dvh - 24px);overflow:auto;box-sizing:border-box;padding:20px 22px 18px;background:linear-gradient(#7a5532,#5d3e22);border:4px solid #2b1a0d;box-shadow:inset 0 0 0 3px #a87a49,0 10px 0 #1c1108,0 18px 40px rgba(0,0,0,.6);color:#fff4dc;font-family:'Press Start 2P','pixel',monospace;text-align:center;image-rendering:pixelated;animation:drcp .2s cubic-bezier(.2,1.6,.4,1)}\n.dr-confirma .ico{font-size:30px;line-height:1;margin-bottom:8px;filter:drop-shadow(0 3px 0 #2b1a0d)}\n.dr-confirma h2{margin:0 0 12px;font-size:13px;line-height:1.5;color:#ffd36b;text-shadow:0 3px 0 #2b1a0d;letter-spacing:.5px}\n.dr-confirma p{margin:0 0 16px;font-size:9px;line-height:1.8;color:#fff4dc;text-shadow:0 2px 0 #2b1a0d}\n.dr-confirma p b{color:#ffb39a}\n.dr-confirma .bts{display:flex;gap:10px;justify-content:center;flex-wrap:wrap}\n.dr-confirma button{flex:1 1 150px;min-height:46px;padding:10px 12px;font:inherit;font-size:9px;cursor:pointer;border:3px solid #2b1a0d;box-shadow:inset 0 -4px 0 rgba(0,0,0,.25),0 4px 0 #1c1108;color:#2b1a0d;background:#e9c27a;letter-spacing:.4px}\n.dr-confirma button:active{transform:translateY(3px);box-shadow:inset 0 -2px 0 rgba(0,0,0,.25),0 1px 0 #1c1108}\n.dr-confirma button.sim.perigo{background:#d9583b;color:#fff4dc;text-shadow:0 2px 0 #5b1a0c}\n.dr-confirma button.nao{background:#8fc46b}\n.dr-confirma button:focus-visible{outline:3px solid #fff4dc;outline-offset:2px}\n@keyframes drcf{from{opacity:0}}@keyframes drcp{from{transform:scale(.86);opacity:0}}"
    local el = nil
    local pendente = nil
    local function montar(self)
        if __t(el) then
            return el
        end
        local st = window.document:createElement("style")
        st.textContent = css
        window.document.head:appendChild(st)
        el = window.document:createElement("div")
        el.className = "dr-confirma"
        el.hidden = true
        el:setAttribute("role", "alertdialog")
        el:setAttribute("aria-modal", "true")
        el.innerHTML = "<div class=\"caixa\"><div class=\"ico\" aria-hidden=\"true\">⚠</div><h2></h2><p></p><div class=\"bts\"><button type=\"button\" class=\"nao\"></button><button type=\"button\" class=\"sim\"></button></div></div>"
        window.document.body:appendChild(el)
        local function fechar(____, r)
            if __t(el.hidden) then
                return
            end
            el.hidden = true
            local f = pendente
            pendente = nil
            if f ~= nil then
                f(nil, r)
            end
        end
        el:addEventListener(
            "click",
            function(____, e)
                if e.target == el then
                    fechar(nil, false)
                end
                local b = e.target:closest("button")
                if __t(b) then
                    e:stopPropagation()
                    fechar(
                        nil,
                        b.classList:contains("sim")
                    )
                end
            end
        )
        window:addEventListener(
            "keydown",
            function(____, e)
                if __t(el.hidden) then
                    return
                end
                e:stopImmediatePropagation()
                if e.key == "Escape" then
                    e:preventDefault()
                    fechar(nil, false)
                else
                    local ____t_5 = __t
                    local ____t_result_4
                    local ____t_3 = __t
                    local ____temp_2 = e.key == "Tab" or e.key == "ArrowLeft"
                    __O[3203] = ____temp_2
                    if ____t_3(____temp_2) then
                        ____t_result_4 = __O[3203]
                    else
                        ____t_result_4 = e.key == "ArrowRight"
                    end
                    if ____t_5(____t_result_4) then
                        e:preventDefault()
                        local n, s = table.unpack(
                            el:querySelectorAll("button"),
                            1,
                            2
                        )
                        local ____temp_6
                        if window.document.activeElement == n then
                            ____temp_6 = s
                        else
                            ____temp_6 = n
                        end
                        ____temp_6:focus()
                    end
                end
            end,
            true
        )
        return el
    end
    local function Confirmar(self, o)
        if o == nil then
            o = {}
        end
        local d = montar(nil)
        if pendente ~= nil then
            pendente(nil, false)
        end
        local ____temp_10 = d:querySelector("h2")
        local ____t_result_9
        if __t(o.titulo) then
            ____t_result_9 = o.titulo
        else
            ____t_result_9 = "Tem certeza?"
        end
        ____temp_10.textContent = ____t_result_9
        local ____temp_12 = d:querySelector("p")
        local ____t_result_11
        if __t(o.html) then
            ____t_result_11 = o.html
        else
            ____t_result_11 = ""
        end
        ____temp_12.innerHTML = ____t_result_11
        if not __t(o.html) then
            local ____temp_14 = d:querySelector("p")
            local ____t_result_13
            if __t(o.texto) then
                ____t_result_13 = o.texto
            else
                ____t_result_13 = ""
            end
            ____temp_14.textContent = ____t_result_13
        end
        local sim = d:querySelector(".sim")
        local nao = d:querySelector(".nao")
        local ____t_result_15
        if __t(o.sim) then
            ____t_result_15 = o.sim
        else
            ____t_result_15 = "SIM"
        end
        sim.textContent = ____t_result_15
        local ____t_result_16
        if __t(o.nao) then
            ____t_result_16 = o.nao
        else
            ____t_result_16 = "CANCELAR"
        end
        nao.textContent = ____t_result_16
        sim.classList:toggle("perigo", o.perigo ~= false)
        d.hidden = false
        window:setTimeout(
            function() return nao:focus() end,
            20
        )
        return __TS__New(
            __TS__Promise,
            function(____, r)
                pendente = r
            end
        )
    end
    window.Confirmar = Confirmar
    local function temSave()
        do
            local function ____catch(e)
                return true, false
            end
            local ____try, ____hasReturned, ____returnValue = pcall(function()
                local ____self_20 = window.JSON
                local ____self_20_parse_21 = ____self_20.parse
                local ____t_result_19
                local ____t_18 = __t
                local ____temp_17 = window.localStorage:getItem(SAVE)
                __O[3204] = ____temp_17
                if ____t_18(____temp_17) then
                    ____t_result_19 = __O[3204]
                else
                    ____t_result_19 = "null"
                end
                local d = ____self_20_parse_21(____self_20, ____t_result_19)
                local ____t_23 = __t
                local ____t_result_22
                if __t(d) then
                    ____t_result_22 = d.q
                else
                    ____t_result_22 = d
                end
                return true, not not ____t_23(____t_result_22)
            end)
            if not ____try then
                ____hasReturned, ____returnValue = ____catch(____hasReturned)
            end
            if ____hasReturned then
                return ____returnValue
            end
        end
    end
    local liberado = false
    window:addEventListener(
        "click",
        function(____, e)
            local ____this_25
            ____this_25 = e.target
            local ____opt_24 = ____this_25.closest
            if ____opt_24 ~= nil then
                ____opt_24 = ____opt_24(____this_25, "#startBtn")
            end
            local b = ____opt_24
            local ____t_31 = __t
            local ____t_result_30
            local ____t_29 = __t
            local ____t_result_28
            local ____t_27 = __t
            local ____temp_26 = not __t(b)
            __O[3205] = ____temp_26
            if ____t_27(____temp_26) then
                ____t_result_28 = __O[3205]
            else
                ____t_result_28 = liberado
            end
            __O[3206] = ____t_result_28
            if ____t_29(____t_result_28) then
                ____t_result_30 = __O[3206]
            else
                ____t_result_30 = not __t(temSave(nil))
            end
            if ____t_31(____t_result_30) then
                return
            end
            e:preventDefault()
            e:stopImmediatePropagation()
            local ____self_32 = Confirmar(nil, {titulo = "JOGAR DO COMEÇO?", html = "Você já tem uma aventura salva.<br>Começar do zero <b>apaga todo o progresso da campanha principal</b>: história, itens, nível e atributos.<br><br>Tem certeza que quer reiniciar o save?", sim = "APAGAR E COMEÇAR", nao = "CANCELAR"})
            ____self_32["then"](
                ____self_32,
                function(____, ok)
                    if not __t(ok) then
                        return
                    end
                    liberado = true
                    do
                        local ____try, ____error = pcall(function()
                            b:click()
                        end)
                        do
                            liberado = false
                        end
                        if not ____try then
                            error(____error, 0)
                        end
                    end
                end
            )
        end,
        true
    )
end)(nil)
return ____exports
