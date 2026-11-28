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
        local ____t_3 = __t
        local ____t_result_2
        local ____t_1 = __t
        local ____temp_0 = not __t(def) or type(def.arquivo) ~= "string"
        __O[272] = ____temp_0
        if ____t_1(____temp_0) then
            ____t_result_2 = __O[272]
        else
            ____t_result_2 = __re_test(
                __re("^[a-z]+:|^\\/|\\.\\.", "i"),
                def.arquivo
            )
        end
        if ____t_3(____t_result_2) then
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
    local ____self_13 = window:fetch(
        __add(BASE, "manifest.json"),
        {cache = "no-cache"}
    )
    local ____self_11 = ____self_13["then"](
        ____self_13,
        function(____, r)
            local ____t_result_12
            if __t(r.ok) then
                ____t_result_12 = r:json()
            else
                ____t_result_12 = nil
            end
            return ____t_result_12
        end
    )
    ____self_11["then"](
        ____self_11,
        function(____, data)
            local ____iter_10 = __iter
            local ____entries_9 = __entries
            local ____t_result_8
            local ____t_7 = __t
            local ____opt_result_6
            if data ~= nil then
                ____opt_result_6 = data.sprites
            end
            __O[273] = ____opt_result_6
            if ____t_7(____opt_result_6) then
                ____t_result_8 = __O[273]
            else
                ____t_result_8 = {}
            end
            for ____, ____value in __TS__Iterator(____iter_10(____entries_9(____t_result_8))) do
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
        local ____t_result_16
        local ____t_15 = __t
        local ____t_result_14
        if __t(e) then
            ____t_result_14 = e.ok
        else
            ____t_result_14 = e
        end
        if ____t_15(____t_result_14) then
            ____t_result_16 = e
        else
            ____t_result_16 = nil
        end
        return ____t_result_16
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
        local ____t_result_19
        local ____t_18 = __t
        local ____getq_result_17 = __getq(d.quadro, 0)
        __O[274] = ____getq_result_17
        if ____t_18(____getq_result_17) then
            ____t_result_19 = __O[274]
        else
            ____t_result_19 = e.img.width
        end
        local fw = ____t_result_19
        local ____t_result_22
        local ____t_21 = __t
        local ____getq_result_20 = __getq(d.quadro, 1)
        __O[275] = ____getq_result_20
        if ____t_21(____getq_result_20) then
            ____t_result_22 = __O[275]
        else
            ____t_result_22 = e.img.height
        end
        local fh = ____t_result_22
        local cols = math.max(
            1,
            math.floor(e.img.width / fw)
        )
        local ____t_result_29
        local ____t_28 = __t
        local ____t_result_27
        local ____t_24 = __t
        local ____getq_result_23 = __getq(d.animacoes, o.anim)
        __O[276] = ____getq_result_23
        if ____t_24(____getq_result_23) then
            ____t_result_27 = __O[276]
        else
            local ____opt_25 = d.animacoes
            if ____opt_25 ~= nil then
                ____opt_25 = ____opt_25.parado
            end
            ____t_result_27 = ____opt_25
        end
        __O[277] = ____t_result_27
        if ____t_28(____t_result_27) then
            ____t_result_29 = __O[277]
        else
            ____t_result_29 = __arrL({0}, 1)
        end
        local frames = ____t_result_29
        local ____t_result_30
        if __t(d.fps) then
            ____t_result_30 = d.fps
        else
            ____t_result_30 = 8
        end
        local fps = ____t_result_30
        local ____t_result_38
        local ____t_37 = __t
        local ____get_35 = __get
        local ____mod_34 = __mod
        local ____t_result_33
        local ____t_32 = __t
        local ____TS__Number_result_31 = __TS__Number(o.time)
        __O[278] = ____TS__Number_result_31
        if ____t_32(____TS__Number_result_31) then
            ____t_result_33 = __O[278]
        else
            ____t_result_33 = 0
        end
        local ____get_35_result_36 = ____get_35(
            frames,
            ____mod_34(
                math.floor(____t_result_33 * fps),
                __len(frames)
            )
        )
        __O[279] = ____get_35_result_36
        if ____t_37(____get_35_result_36) then
            ____t_result_38 = __O[279]
        else
            ____t_result_38 = 0
        end
        local idx = ____t_result_38
        local ____t_result_39
        if __t(d.escala) then
            ____t_result_39 = d.escala
        else
            ____t_result_39 = 2
        end
        local ____t_result_40
        if __t(o.scale) then
            ____t_result_40 = o.scale
        else
            ____t_result_40 = 1
        end
        local scale = ____t_result_39 * ____t_result_40
        local ____getq_result_41 = __getq(d.ancora, 0)
        if ____getq_result_41 == nil then
            ____getq_result_41 = fw / 2
        end
        local ax = ____getq_result_41
        local ____getq_result_42 = __getq(d.ancora, 1)
        if ____getq_result_42 == nil then
            ____getq_result_42 = fh
        end
        local ay = ____getq_result_42
        c:save()
        c.imageSmoothingEnabled = false
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
        c:scale(
            (__lt(o.facing, 0) and -1 or 1) * scale,
            scale
        )
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
    local ____t_44 = __t
    local ____t_result_43
    if __t(art) then
        ____t_result_43 = type(art.drawCharacter) == "function"
    else
        ____t_result_43 = art
    end
    if ____t_44(____t_result_43) then
        local original = art.drawCharacter
        art.drawCharacter = function(self, ...)
            local __args = {...}
            local c, ____type, x, y, o = table.unpack(__args, 1, 5)
            if o == nil then
                o = {}
            end
            local name = __add("personagem-", ____type)
            local ____t_46 = __t
            local ____t_result_45
            if __t(sheets.size) then
                ____t_result_45 = get(nil, name)
            else
                ____t_result_45 = sheets.size
            end
            if ____t_46(____t_result_45) then
                local ____t_result_51
                if __t(o.hit) then
                    ____t_result_51 = "dano"
                else
                    local ____t_50 = __t
                    local ____t_result_49
                    local ____t_48 = __t
                    local ____t_result_47
                    if __t(o.attack) then
                        ____t_result_47 = o.attack
                    else
                        ____t_result_47 = o.attacking
                    end
                    __O[280] = ____t_result_47
                    if ____t_48(____t_result_47) then
                        ____t_result_49 = __O[280]
                    else
                        ____t_result_49 = o.punch
                    end
                    ____t_result_51 = ____t_50(____t_result_49) and "ataque" or (o.grounded == false and "pulo" or (__t(o.moving) and "andar" or "parado"))
                end
                local anim = ____t_result_51
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
