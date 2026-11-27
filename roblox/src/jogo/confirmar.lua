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
                    local ____t_4 = __t
                    local ____t_3 = __t
                    local ____temp_2 = e.key == "Tab" or e.key == "ArrowLeft"
                    __O[3175] = ____temp_2
                    if ____t_4(if ____t_3(____temp_2) then __O[3175] else e.key == "ArrowRight") then
                        e:preventDefault()
                        local n, s = table.unpack(
                            el:querySelectorAll("button"),
                            1,
                            2
                        )
                        if window.document.activeElement == n then s else n:focus()
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
        d:querySelector("h2").textContent = if __t(o.titulo) then o.titulo else "Tem certeza?"
        d:querySelector("p").innerHTML = if __t(o.html) then o.html else ""
        if not __t(o.html) then
            d:querySelector("p").textContent = if __t(o.texto) then o.texto else ""
        end
        local sim = d:querySelector(".sim")
        local nao = d:querySelector(".nao")
        sim.textContent = if __t(o.sim) then o.sim else "SIM"
        nao.textContent = if __t(o.nao) then o.nao else "CANCELAR"
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
                local ____self_9 = window.JSON
                local ____self_9_parse_10 = ____self_9.parse
                local ____t_8 = __t
                local ____temp_7 = window.localStorage:getItem(SAVE)
                __O[3176] = ____temp_7
                local d = ____self_9_parse_10(____self_9, if ____t_8(____temp_7) then __O[3176] else "null")
                return true, not not __t(if __t(d) then d.q else d)
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
            local ____this_12
            ____this_12 = e.target
            local ____opt_11 = ____this_12.closest
            if ____opt_11 ~= nil then
                ____opt_11 = ____opt_11(____this_12, "#startBtn")
            end
            local b = ____opt_11
            local ____t_17 = __t
            local ____t_16 = __t
            local ____t_14 = __t
            local ____temp_13 = not __t(b)
            __O[3177] = ____temp_13
            local ____temp_15 = if ____t_14(____temp_13) then __O[3177] else liberado
            __O[3178] = ____temp_15
            if ____t_17(if ____t_16(____temp_15) then __O[3178] else not __t(temSave(nil))) then
                return
            end
            e:preventDefault()
            e:stopImmediatePropagation()
            local ____self_18 = Confirmar(nil, {titulo = "JOGAR DO COMEÇO?", html = "Você já tem uma aventura salva.<br>Começar do zero <b>apaga todo o progresso da campanha principal</b>: história, itens, nível e atributos.<br><br>Tem certeza que quer reiniciar o save?", sim = "APAGAR E COMEÇAR", nao = "CANCELAR"})
            ____self_18["then"](
                ____self_18,
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
