--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __fapply, __lt, __getq, __mod, __ord, __arrL, __t, __get, __len, __call, __add, __new = __JSR.__fapply, __JSR.__lt, __JSR.__getq, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__t, __JSR.__get, __JSR.__len, __JSR.__call, __JSR.__add, __JSR.__new
local __iter, __entries, __re, __re_test = __JSR.__iter, __JSR.__entries, __JSR.__re, __JSR.__re_test
local ____lualib = require(script.Parent.lualib_bundle)
local Map = ____lualib.Map
local __TS__New = ____lualib.__TS__New
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__Number = ____lualib.__TS__Number
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    if __t(window.Sprites) then
        return
    end
    local BASE = "assets/sprites/"
    local sheets = __TS__New(Map)
    local ready = false
    local function add(self, name, def)
        local ____t_2 = __t
        local ____t_1 = __t
        local ____temp_0 = not __t(def) or type(def.arquivo) ~= "string"
        __O[272] = ____temp_0
        if ____t_2(if ____t_1(____temp_0) then __O[272] else __re_test(
            __re("^[a-z]+:|^\\/|\\.\\.", "i"),
            def.arquivo
        )) then
            return
        end
        local img = __new("Image")
        local entry = {img = img, ok = false, def = def}
        img.onload = function()
            entry.ok = true
        end
        img.src = __add(BASE, def.arquivo)
        __call(sheets, "set", name, entry)
    end
    local ____self_10 = window:fetch(
        __add(BASE, "manifest.json"),
        {cache = "no-cache"}
    )
    local ____self_9 = ____self_10["then"](
        ____self_10,
        function(____, r) return if __t(r.ok) then r:json() else nil end
    )
    ____self_9["then"](
        ____self_9,
        function(____, data)
            local ____iter_8 = __iter
            local ____entries_7 = __entries
            local ____t_6 = __t
            local ____opt_result_5
            if data ~= nil then
                ____opt_result_5 = data.sprites
            end
            __O[273] = ____opt_result_5
            for ____, ____value in __TS__Iterator(____iter_8(____entries_7(if ____t_6(____opt_result_5) then __O[273] else {}))) do
                local name = ____value[1]
                local def = ____value[2]
                add(nil, name, def)
            end
            ready = true
        end
    ):catch(function()
        ready = true
    end)
    local function get(____, name)
        local e = __call(sheets, "get", name)
        return if __t(if __t(e) then e.ok else e) then e else nil
    end
    local function draw(self, c, name, x, y, o)
        if o == nil then
            o = {}
        end
        local e = get(nil, name)
        if not __t(e) then
            return false
        end
        local d = e.def
        local ____t_12 = __t
        local ____getq_result_11 = __getq(d.quadro, 0)
        __O[274] = ____getq_result_11
        local fw = if ____t_12(____getq_result_11) then __O[274] else e.img.width
        local ____t_14 = __t
        local ____getq_result_13 = __getq(d.quadro, 1)
        __O[275] = ____getq_result_13
        local fh = if ____t_14(____getq_result_13) then __O[275] else e.img.height
        local cols = math.max(
            1,
            math.floor(e.img.width / fw)
        )
        local ____t_20 = __t
        local ____t_16 = __t
        local ____getq_result_15 = __getq(d.animacoes, o.anim)
        __O[276] = ____getq_result_15
        local ____opt_17 = d.animacoes
        if ____opt_17 ~= nil then
            ____opt_17 = ____opt_17.parado
        end
        local ____temp_19 = if ____t_16(____getq_result_15) then __O[276] else ____opt_17
        __O[277] = ____temp_19
        local frames = if ____t_20(____temp_19) then __O[277] else __arrL({0}, 1)
        local fps = if __t(d.fps) then d.fps else 8
        local ____t_26 = __t
        local ____get_24 = __get
        local ____mod_23 = __mod
        local ____t_22 = __t
        local ____TS__Number_result_21 = __TS__Number(o.time)
        __O[278] = ____TS__Number_result_21
        local ____get_24_result_25 = ____get_24(
            frames,
            ____mod_23(
                math.floor(if ____t_22(____TS__Number_result_21) then __O[278] else 0 * fps),
                __len(frames)
            )
        )
        __O[279] = ____get_24_result_25
        local idx = if ____t_26(____get_24_result_25) then __O[279] else 0
        local scale = if __t(d.escala) then d.escala else 2 * if __t(o.scale) then o.scale else 1
        local ____getq_result_27 = __getq(d.ancora, 0)
        if ____getq_result_27 == nil then
            ____getq_result_27 = fw / 2
        end
        local ax = ____getq_result_27
        local ____getq_result_28 = __getq(d.ancora, 1)
        if ____getq_result_28 == nil then
            ____getq_result_28 = fh
        end
        local ay = ____getq_result_28
        c:save()
        c.imageSmoothingEnabled = false
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
        c:scale(if __lt(o.facing, 0) then -1 else 1 * scale, scale)
        c:drawImage(
            e.img,
            __mod(idx, cols) * fw,
            math.floor(idx / cols) * fh,
            fw,
            fh,
            __TS__Number(-ax),
            __TS__Number(-ay),
            fw,
            fh
        )
        c:restore()
        return true
    end
    window.Sprites = __ord(
        {
            get = get,
            draw = draw,
            has = function(____, n) return not not __t(get(nil, n)) end,
            ready = function() return ready end
        },
        "get,draw,has,ready"
    )
    local art = window.Art
    if __t(if __t(art) then type(art.drawCharacter) == "function" else art) then
        local original = art.drawCharacter
        art.drawCharacter = function(self, ...)
            local __args = {...}
            local c, ____type, x, y, o = table.unpack(__args, 1, 5)
            if o == nil then
                o = {}
            end
            local name = __add("personagem-", ____type)
            if __t(if __t(sheets.size) then get(nil, name) else sheets.size) then
                local ____t_31 = __t
                local ____t_30 = __t
                local ____temp_29 = if __t(o.attack) then o.attack else o.attacking
                __O[280] = ____temp_29
                local anim = if __t(o.hit) then "dano" else if ____t_31(if ____t_30(____temp_29) then __O[280] else o.punch) then "ataque" else if o.grounded == false then "pulo" else if __t(o.moving) then "andar" else "parado"
                if __t(draw(
                    nil,
                    c,
                    name,
                    x,
                    y,
                    {anim = anim, time = o.frame, facing = o.facing, scale = o.scale}
                )) then
                    return
                end
            end
            return __fapply(original, self, __args)
        end
    end
end)(nil)
return ____exports
