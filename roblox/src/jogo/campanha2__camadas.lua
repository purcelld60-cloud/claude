--!native
--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __NumberV, __lt, __gt, __mod, __ord, __arrL, __iterar, __t, __get, __set, __del, __len = __JSR.__NumberV, __JSR.__lt, __JSR.__gt, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__set, __JSR.__del, __JSR.__len
local __call, __add, __iter, __keys, __assign, __re, __re_replace = __JSR.__call, __JSR.__add, __JSR.__iter, __JSR.__keys, __JSR.__assign, __JSR.__re, __JSR.__re_replace
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__SparseArrayNew = ____lualib.__TS__SparseArrayNew
local __TS__SparseArrayPush = ____lualib.__TS__SparseArrayPush
local __TS__SparseArraySpread = ____lualib.__TS__SparseArraySpread
local Set = ____lualib.Set
local __TS__New = ____lualib.__TS__New
local __TS__Spread = ____lualib.__TS__Spread
local __TS__Number = ____lualib.__TS__Number
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    local ____t_4 = __t
    local ____t_result_3
    if __t(window.CampanhaCamadas) then
        ____t_result_3 = window.CampanhaCamadas
    else
        local ____t_2 = __t
        local ____opt_0 = window.CampanhaCenarios
        if ____opt_0 ~= nil then
            ____opt_0 = ____opt_0.arte
        end
        ____t_result_3 = not ____t_2(____opt_0)
    end
    if ____t_4(____t_result_3) then
        return
    end
    local A = window.CampanhaCenarios.arte
    local R = A.R
    local ell = A.ell
    local mk = A.mk
    local hash = A.hash
    local cl = A.cl
    local limb = A.limb
    local tile = A.tile
    local vis = A.vis
    local night = A.night
    local shadeHex = A.shadeHex
    local pick = A.pick
    local lightAdd = A.lightAdd
    local vgrad = A.vgrad
    local reflexo = A.reflexo
    local gente = A.gente
    local pessoa = A.pessoa
    local roofTiles = A.roofTiles
    local cachorro = A.cachorro
    local GY = A.GY
    local LW = 482
    local LH = 270
    local T = 1440
    local function wrap(____, v, W)
        if W == nil then
            W = T
        end
        return __mod(
            __mod(v, W) + W,
            W
        )
    end
    local function HERO()
        return A:heroiPos()
    end
    local TAU = math.pi * 2
    local G = __ord({
        A = "010101111101101",
        B = "110101110101110",
        C = "011100100100011",
        D = "110101101101110",
        E = "111100110100111",
        F = "111100110100100",
        G = "011100101101011",
        H = "101101111101101",
        I = "111010010010111",
        J = "001001001101010",
        K = "101101110101101",
        L = "100100100100111",
        M = "101111111101101",
        N = "110101101101101",
        O = "010101101101010",
        P = "110101110100100",
        Q = "010101101110011",
        R = "110101110101101",
        S = "011100010001110",
        T = "111010010010010",
        U = "101101101101111",
        V = "101101101101010",
        W = "101101111111101",
        X = "101101010101101",
        Y = "101101010010010",
        Z = "111001010100111",
        ["0"] = "111101101101111",
        ["1"] = "010110010010111",
        ["2"] = "110001010100111",
        ["3"] = "110001010001110",
        ["4"] = "101101111001001",
        ["5"] = "111100110001110",
        ["6"] = "011100111101111",
        ["7"] = "111001010010010",
        ["8"] = "111101111101111",
        ["9"] = "111101111001110",
        ["&"] = "010101010101011",
        ["."] = "000000000000010",
        [","] = "000000000010100",
        ["!"] = "010010010000010",
        ["-"] = "000000111000000",
        ["'"] = "010010000000000",
        ["°"] = "010101010000000",
        ["%"] = "101001010100101",
        ["/"] = "001001010100100",
        ["+"] = "000010111010000",
        [":"] = "000010000010000",
        ["?"] = "110001010000010",
        ["$"] = "011110010011110",
        ["#"] = "101111101111101",
        ["("] = "010100100100010",
        [")"] = "010001001001010"
    }, "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,&,.,,,!,-,',°,%,/,+,:,?,$,#,(,)")
    local function limpa(____, s)
        return __call(
            __re_replace(
                __call(
                    tostring(s),
                    "normalize",
                    "NFD"
                ),
                __re("[̀-ͯ]", "g"),
                ""
            ),
            "toUpperCase"
        )
    end
    local function pxText(self, c, str, x, y, col, o)
        if o == nil then
            o = {}
        end
        local s = limpa(nil, str)
        local ____t_result_5
        if __t(o.s) then
            ____t_result_5 = o.s
        else
            ____t_result_5 = 1
        end
        local sc = ____t_result_5
        local w = __len(s) * 4 * sc - sc
        local ____temp_7
        if o.align == "left" then
            ____temp_7 = x
        else
            local ____temp_6
            if o.align == "right" then
                ____temp_6 = x - w
            else
                ____temp_6 = x - w / 2
            end
            ____temp_7 = ____temp_6
        end
        local x0 = math.floor(____temp_7 + 0.5)
        if __t(o.sombra) then
            pxText(
                nil,
                c,
                s,
                x0 + sc,
                __add(y, sc),
                o.sombra,
                {s = sc, align = "left"}
            )
        end
        c.fillStyle = col
        local xx = x0
        for ____, ch in __iterar((s)) do
            local g = __get(G, ch)
            if __t(g) then
                do
                    local i = 0
                    while i < 15 do
                        if __get(g, i) == "1" then
                            c:fillRect(
                                xx + __mod(i, 3) * sc,
                                math.floor(y + 0.5) + math.floor(i / 3) * sc,
                                sc,
                                sc
                            )
                        end
                        i = i + 1
                    end
                end
            end
            xx = xx + 4 * sc
        end
        return w
    end
    local function largura(____, s, sc)
        if sc == nil then
            sc = 1
        end
        return __len(limpa(nil, s)) * 4 * sc - sc
    end
    local LOJAS_RUA = __arrL(
        {
            __arrL({"CASAS BAIXA", "#1d4ab8", "#ffffff"}, 3),
            __arrL({"PAGUE MAIS", "#2c8a3a", "#ffffff"}, 3),
            __arrL({"ESCURO CELULARES", "#c43c3a", "#ffffff"}, 3),
            __arrL({"RICARDO ELETRICO", "#d84a2a", "#fff6d0"}, 3),
            __arrL({"INSISTENTE", "#7a2a8a", "#ffffff"}, 3),
            __arrL({"OTICA DIZ-QUE-VE", "#2a2a2a", "#f2c94c"}, 3),
            __arrL({"LOTERICA SORTE GRANDE", "#2c5a9e", "#f2c94c"}, 3),
            __arrL({"C&A", "#2c6ab8", "#ffffff"}, 3),
            __arrL({"PERNAMBUCRANAS", "#3c7a4a", "#ffffff"}, 3),
            __arrL({"RAVAIANAS", "#f2c94c", "#2a2a2a"}, 3),
            __arrL({"DROGARIA SAO PAULINHO", "#c43c3a", "#ffffff"}, 3),
            __arrL({"HABIBIS", "#e8833a", "#ffffff"}, 3),
            __arrL({"BOBO'S", "#c43c3a", "#f2c94c"}, 3),
            __arrL({"CHILLI BEICO", "#2a2a2a", "#e8433a"}, 3),
            __arrL({"NATURRA", "#c47a35", "#fff6d0"}, 3),
            __arrL({"POLISHOPE", "#1c1c24", "#5ae0d0"}, 3),
            __arrL({"KALUNGO", "#2c5a9e", "#f2c94c"}, 3),
            __arrL({"BANCO DO BRASIU", "#f2c94c", "#1d3a8a"}, 3),
            __arrL({"RENE", "#2a2a2a", "#ffffff"}, 3),
            __arrL({"SUBUAI", "#2c8a3a", "#f2c94c"}, 3),
            __arrL({"BURGUER QUINGUE", "#d8642a", "#fff6d0"}, 3),
            __arrL({"STARBUCHO CAFE", "#1f6a4a", "#ffffff"}, 3),
            __arrL({"ATACAREJAO", "#c43c3a", "#f2c94c"}, 3),
            __arrL({"G. BARBUDA", "#e8833a", "#ffffff"}, 3),
            __arrL({"SMART FAT", "#f2c94c", "#2a2a2a"}, 3),
            __arrL({"MAGAZINE LURDES", "#2c6ab8", "#ffffff"}, 3),
            __arrL({"AMENICANAS", "#c43c3a", "#ffffff"}, 3)
        },
        27
    )
    local OUTDOORS = __arrL(
        {
            __arrL({"NETFLIQUIS", "#1c1c1c", "#e8433a"}, 3),
            __arrL({"CASAS BAIXA: QUER PAGAR QUANTO?", "#1d4ab8", "#ffffff"}, 3),
            __arrL({"ESCURO 5G: SINAL? TALVEZ", "#c43c3a", "#ffffff"}, 3),
            __arrL({"SMART FAT: VEM SUAR", "#f2c94c", "#2a2a2a"}, 3),
            __arrL({"BISCOITO DA SERRA", "#c47a35", "#fff6d0"}, 3),
            __arrL({"UBE: CHEGA QUANDO DER", "#1c1c1c", "#ffffff"}, 3),
            __arrL({"PAGUE MAIS: E PAGUE MESMO", "#2c8a3a", "#ffffff"}, 3),
            __arrL({"FESTIVAL DE INVERNO", "#2c3a6a", "#f2c94c"}, 3),
            __arrL({"CAFE DO PLANALTO", "#5a3420", "#f2e8c8"}, 3),
            __arrL({"COMPRE UM CASACO", "#3c6aa8", "#ffffff"}, 3)
        },
        10
    )
    local SKIN = __arrL({
        "#e0b08a",
        "#9a6440",
        "#c88a60",
        "#6a4430",
        "#f0c8a8"
    }, 5)
    local ROUPA = __arrL({
        "#3a4a6a",
        "#7a3a3a",
        "#4a6a4a",
        "#5a4a6a",
        "#c47a35",
        "#2a3a4a",
        "#d84a7a",
        "#e8c24c",
        "#3c8ad8",
        "#f2efe6"
    }, 10)
    local CURT = __arrL({
        "#e8d8a8",
        "#c9d8e8",
        "#e8c4c4",
        "#d4e8c8",
        "#f2efe6",
        "#c8b8d8"
    }, 6)
    local function pessoinha(self, c, x, y, i, t, anda)
        if anda == nil then
            anda = true
        end
        local sh = __get(
            ROUPA,
            __mod(
                i,
                __len(ROUPA)
            )
        )
        local sk = __get(
            SKIN,
            __mod(
                i,
                __len(SKIN)
            )
        )
        local ____t_result_8
        if __t(anda) then
            ____t_result_8 = __mod(
                math.floor(t * 5 + i * 0.7),
                2
            )
        else
            ____t_result_8 = 0
        end
        local f = ____t_result_8
        x = math.floor(x + 0.5)
        R(
            nil,
            c,
            x,
            y - 3,
            1,
            3 - f,
            "#2a2f3a"
        )
        R(
            nil,
            c,
            x + 2,
            y - 3,
            1,
            2 + f,
            "#2a2f3a"
        )
        R(
            nil,
            c,
            x,
            y - 7,
            3,
            4,
            sh
        )
        R(
            nil,
            c,
            x + 2,
            y - 7,
            1,
            4,
            shadeHex(nil, sh, 0.75)
        )
        R(
            nil,
            c,
            x,
            y - 9,
            3,
            2,
            sk
        )
        R(
            nil,
            c,
            x,
            y - 10,
            3,
            1,
            pick(
                nil,
                __arrL({"#2a201a", "#1a1a1a", "#6a4a2a", "#c8a050"}, 4),
                i
            )
        )
        if __mod(i, 4) == 1 then
            R(
                nil,
                c,
                x + 3,
                y - 5,
                2,
                3,
                pick(
                    nil,
                    __arrL({"#c43c3a", "#2c5a9e", "#e8c24c"}, 3),
                    i
                )
            )
        end
    end
    local function carrinho(self, c, x, y, col, dir)
        if dir == nil then
            dir = 1
        end
        x = math.floor(x + 0.5)
        R(
            nil,
            c,
            x,
            y - 5,
            15,
            3,
            col
        )
        R(
            nil,
            c,
            x + (dir > 0 and 3 or 4),
            y - 8,
            8,
            3,
            col
        )
        R(
            nil,
            c,
            x + (dir > 0 and 4 or 5),
            y - 7,
            6,
            2,
            "#9fc4d0"
        )
        R(
            nil,
            c,
            x + 2,
            y - 2,
            3,
            2,
            "#1c1c1c"
        )
        R(
            nil,
            c,
            x + 10,
            y - 2,
            3,
            2,
            "#1c1c1c"
        )
        local ____R_11 = R
        local ____c_10 = c
        local ____temp_9
        if dir > 0 then
            ____temp_9 = x + 14
        else
            ____temp_9 = x
        end
        ____R_11(
            nil,
            ____c_10,
            ____temp_9,
            y - 5,
            1,
            1,
            "#fff2b0"
        )
    end
    local function janelaM(self, c, n, x, y, seed, aceso)
        if aceso == nil then
            aceso = 0.58
        end
        R(
            nil,
            c,
            x - 1,
            y - 1,
            6,
            8,
            "#3a3a36"
        )
        vgrad(
            nil,
            c,
            x,
            y,
            4,
            6,
            "#a4c4d0",
            "#5f8496"
        )
        if __gt(
            hash(nil, seed),
            0.55
        ) then
            R(
                nil,
                c,
                x,
                y,
                1,
                6,
                pick(nil, CURT, seed)
            )
        end
        if __gt(
            hash(nil, seed * 1.3),
            0.85
        ) then
            R(
                nil,
                c,
                x + 1,
                y + 4,
                2,
                2,
                pick(
                    nil,
                    __arrL({"#4f8a3a", "#e86a7a"}, 2),
                    seed
                )
            )
        end
        local ____t_13 = __t
        local ____t_result_12
        if __t(n) then
            ____t_result_12 = __gt(
                hash(nil, seed * 1.7 + 3),
                aceso
            )
        else
            ____t_result_12 = n
        end
        if ____t_13(____t_result_12) then
            R(
                nil,
                n,
                x,
                y,
                4,
                6,
                pick(
                    nil,
                    __arrL({"#ffd98a", "#ffe6b0", "#fff2d0", "#a8c8ff"}, 4),
                    seed
                )
            )
        end
        R(
            nil,
            c,
            x - 1,
            y + 6,
            6,
            1,
            "#d8d2c0"
        )
    end
    local function lojaM(self, c, n, x, w, base, L, seed, pos)
        local nome, cor, letra = table.unpack(L, 1, 3)
        local y = base - 16
        R(
            nil,
            c,
            x,
            y,
            w,
            16,
            "#e8e2d2"
        )
        R(
            nil,
            c,
            x + 1,
            y,
            w - 2,
            8,
            "#1c1f24"
        )
        vgrad(
            nil,
            c,
            x + 2,
            y + 1,
            w - 4,
            6,
            shadeHex(nil, cor, 1.15),
            shadeHex(nil, cor, 0.85)
        )
        pxText(
            nil,
            c,
            nome,
            x + w / 2,
            y + 2,
            letra
        )
        do
            local k = 0
            while __lt(k, w) do
                local ____R_16 = R
                local ____array_15 = __TS__SparseArrayNew(
                    nil,
                    c,
                    x + k,
                    y + 8,
                    math.min(4, w - k),
                    3
                )
                local ____t_result_14
                if __t(__mod(k / 4, 2)) then
                    ____t_result_14 = cor
                else
                    ____t_result_14 = "#f2efe6"
                end
                __TS__SparseArrayPush(____array_15, ____t_result_14)
                ____R_16(__TS__SparseArraySpread(____array_15))
                k = k + 4
            end
        end
        R(
            nil,
            c,
            x,
            y + 11,
            w,
            1,
            "rgba(0,0,0,.25)"
        )
        R(
            nil,
            c,
            x + 2,
            y + 11,
            w - 4,
            5,
            "#3c4c58"
        )
        R(
            nil,
            c,
            x + 3,
            y + 12,
            w - 6,
            4,
            "#9fc0cc"
        )
        do
            local k = 0
            while k < (w - 10) / 5 do
                R(
                    nil,
                    c,
                    x + 5 + k * 5,
                    y + 13,
                    3,
                    3,
                    pick(
                        nil,
                        __arrL({
                            "#d9634a",
                            "#e8c24c",
                            "#5f9fd0",
                            "#7cbf6a",
                            "#c86ab8",
                            "#f2efe6"
                        }, 6),
                        seed + k
                    )
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            x + math.floor(w / 2 + 0.5) - 2,
            y + 11,
            4,
            5,
            "#2a2c30"
        )
        if __t(n) then
            n:save()
            n.globalAlpha = 0.55
            R(
                nil,
                n,
                x + 2,
                y + 1,
                w - 4,
                6,
                cor
            )
            n.globalAlpha = 1
            pxText(
                nil,
                n,
                nome,
                x + w / 2,
                y + 2,
                "#fff6dc"
            )
            R(
                nil,
                n,
                x + 3,
                y + 12,
                w - 6,
                4,
                "rgba(255,226,170,.8)"
            )
            n:restore()
        end
        if __t(pos) then
            __call(pos, "push", {
                nome = nome,
                x = x,
                w = w,
                y = y,
                cor = cor
            })
        end
    end
    local function outdoorM(self, c, n, x, top, L, w)
        if w == nil then
            w = 0
        end
        local txt, bg, fg = table.unpack(L, 1, 3)
        local ____t_result_17
        if __t(w) then
            ____t_result_17 = w
        else
            ____t_result_17 = largura(nil, txt) + 10
        end
        local ww = ____t_result_17
        R(
            nil,
            c,
            x + 4,
            top - 4,
            2,
            4,
            "#5a5e62"
        )
        R(
            nil,
            c,
            x + ww - 6,
            top - 4,
            2,
            4,
            "#5a5e62"
        )
        R(
            nil,
            c,
            x,
            top - 16,
            ww,
            12,
            "#2a2f34"
        )
        R(
            nil,
            c,
            x + 1,
            top - 15,
            ww - 2,
            10,
            bg
        )
        R(
            nil,
            c,
            x + 1,
            top - 15,
            ww - 2,
            1,
            shadeHex(nil, bg, 1.3)
        )
        pxText(
            nil,
            c,
            txt,
            x + ww / 2,
            top - 12,
            fg
        )
        do
            local k = 4
            while k < ww do
                R(
                    nil,
                    c,
                    x + k,
                    top - 18,
                    1,
                    2,
                    "#5a5e62"
                )
                k = k + 10
            end
        end
        if __t(n) then
            n:save()
            n.globalAlpha = 0.4
            R(
                nil,
                n,
                x + 1,
                top - 15,
                ww - 2,
                10,
                bg
            )
            n.globalAlpha = 0.9
            pxText(
                nil,
                n,
                txt,
                x + ww / 2,
                top - 12,
                fg
            )
            n:restore()
        end
        return ww
    end
    local function predioM(self, c, n, x, w, floors, col, seed, base, o)
        if o == nil then
            o = {}
        end
        local fh = 11
        local lh = __t(o.loja) and 16 or 0
        local top = base - lh - floors * fh
        R(
            nil,
            c,
            x,
            top,
            w,
            base - top,
            col
        )
        do
            local i = 0
            while i < w * (base - top) / 14 do
                local ____R_20 = R
                local ____array_19 = __TS__SparseArrayNew(
                    nil,
                    c,
                    x + hash(nil, i * 3.1 + seed) * w,
                    top + hash(nil, i * 7.7 + seed) * (base - top),
                    1,
                    1
                )
                local ____t_result_18
                if __t(__mod(i, 2)) then
                    ____t_result_18 = shadeHex(nil, col, 1.05)
                else
                    ____t_result_18 = shadeHex(nil, col, 0.92)
                end
                __TS__SparseArrayPush(____array_19, ____t_result_18)
                ____R_20(__TS__SparseArraySpread(____array_19))
                i = i + 1
            end
        end
        R(
            nil,
            c,
            x,
            top,
            w,
            2,
            shadeHex(nil, col, 1.15)
        )
        R(
            nil,
            c,
            __add(x, w) - 2,
            top,
            2,
            base - top,
            shadeHex(nil, col, 0.8)
        )
        R(
            nil,
            c,
            x - 1,
            top - 2,
            w + 2,
            2,
            shadeHex(nil, col, 0.72)
        )
        do
            local f = 0
            while __lt(f, floors) do
                do
                    local yy = top + f * fh + 3
                    local nW = math.max(
                        1,
                        math.floor((w - 4) / 7)
                    )
                    if __t(o.vidro) then
                        vgrad(
                            nil,
                            c,
                            x + 2,
                            yy - 2,
                            w - 6,
                            fh - 2,
                            "#9cc0d2",
                            "#4f7488"
                        )
                        R(
                            nil,
                            c,
                            x + 2,
                            yy + fh - 4,
                            w - 6,
                            1,
                            "#2f4450"
                        )
                        do
                            local k = 0
                            while k < nW do
                                R(
                                    nil,
                                    c,
                                    x + 2 + k * 7,
                                    yy - 2,
                                    1,
                                    fh - 2,
                                    "#3f5a68"
                                )
                                local ____t_22 = __t
                                local ____t_result_21
                                if __t(n) then
                                    ____t_result_21 = __gt(
                                        hash(nil, seed + f * 7 + k),
                                        0.55
                                    )
                                else
                                    ____t_result_21 = n
                                end
                                if ____t_22(____t_result_21) then
                                    R(
                                        nil,
                                        n,
                                        x + 3 + k * 7,
                                        yy - 1,
                                        5,
                                        fh - 4,
                                        pick(
                                            nil,
                                            __arrL({"#ffe6b0", "#fff2d0", "#cfe0ff"}, 3),
                                            k + f
                                        )
                                    )
                                end
                                k = k + 1
                            end
                        end
                        do f = f + 1 continue end
                    end
                    do
                        local k = 0
                        while k < nW do
                            local wx = math.floor(x + 3 + k * ((w - 6) / nW) + 0.5)
                            janelaM(
                                nil,
                                c,
                                n,
                                wx,
                                yy,
                                seed * 13 + f * 7 + k
                            )
                            if __gt(
                                hash(nil, seed + f * 5 + k),
                                0.84
                            ) then
                                R(
                                    nil,
                                    c,
                                    wx + 5,
                                    yy + 3,
                                    3,
                                    2,
                                    "#d8dcdc"
                                )
                                R(
                                    nil,
                                    c,
                                    wx + 6,
                                    yy + 5,
                                    1,
                                    2,
                                    "#7a7e80"
                                )
                            end
                            k = k + 1
                        end
                    end
                    local ____t_24 = __t
                    local ____t_result_23
                    if __t(o.sacada) then
                        ____t_result_23 = __mod(f, 2) == 1
                    else
                        ____t_result_23 = o.sacada
                    end
                    if ____t_24(____t_result_23) then
                        R(
                            nil,
                            c,
                            x + 1,
                            yy + 7,
                            w - 4,
                            1,
                            "#3a3a36"
                        )
                        do
                            local k = 1
                            while k < w - 4 do
                                R(
                                    nil,
                                    c,
                                    x + 1 + k,
                                    yy + 5,
                                    1,
                                    2,
                                    "#3a3a36"
                                )
                                k = k + 2
                            end
                        end
                    end
                    R(
                        nil,
                        c,
                        x,
                        yy + fh - 3,
                        w,
                        1,
                        shadeHex(nil, col, 0.88)
                    )
                end
                f = f + 1
            end
        end
        if __t(o.vidro) then
            reflexo(
                nil,
                c,
                x + 2,
                top + 2,
                w - 6,
                floors * fh - 2
            )
        end
        if __gt(
            hash(nil, seed + 31),
            0.35
        ) then
            local cx = x + 3 + math.floor(hash(nil, seed + 32) * math.max(0, w - 12) + 0.5)
            R(
                nil,
                c,
                cx,
                top - 7,
                8,
                5,
                "#3c6aa8"
            )
            R(
                nil,
                c,
                cx,
                top - 7,
                8,
                1,
                "#6a9ad0"
            )
            R(
                nil,
                c,
                cx + 1,
                top - 2,
                1,
                2,
                "#5a5a56"
            )
            R(
                nil,
                c,
                cx + 6,
                top - 2,
                1,
                2,
                "#5a5a56"
            )
        end
        if __gt(
            hash(nil, seed + 34),
            0.5
        ) then
            R(
                nil,
                c,
                __add(x, w) - 5,
                top - 11,
                1,
                9,
                "#6a6a66"
            )
            do
                local k = 0
                while k < 3 do
                    R(
                        nil,
                        c,
                        __add(x, w) - 7 + k,
                        top - 10 + k * 2,
                        5 - k * 2,
                        1,
                        "#6a6a66"
                    )
                    k = k + 1
                end
            end
        end
        local ____t_26 = __t
        local ____t_result_25
        if __t(n) then
            ____t_result_25 = __gt(
                hash(nil, seed + 35),
                0.6
            )
        else
            ____t_result_25 = n
        end
        if ____t_26(____t_result_25) then
            R(
                nil,
                n,
                __add(x, w) - 5,
                top - 12,
                1,
                1,
                "#ff4a3a"
            )
        end
        if __t(o.loja) then
            lojaM(
                nil,
                c,
                n,
                x,
                w,
                base,
                o.loja,
                seed,
                o.pos
            )
        end
        return top
    end
    local function arvoreM(self, c, x, base, seed, s)
        if s == nil then
            s = 1
        end
        R(
            nil,
            c,
            x,
            base - 12 * s,
            2,
            12 * s,
            "#5a4232"
        )
        do
            local k = 0
            while k < 7 do
                ell(
                    nil,
                    c,
                    x + 1 + (hash(nil, seed + k) - 0.5) * 10 * s,
                    base - 14 * s - hash(nil, seed * 3 + k) * 8 * s,
                    4 * s,
                    3.5 * s,
                    __t(__mod(k, 3)) and "#4f7a46" or "#6a9a52"
                )
                k = k + 1
            end
        end
    end
    local function nevoa(self, c, W, col)
        c:save()
        c.globalCompositeOperation = "source-atop"
        c.fillStyle = col
        c:fillRect(0, 0, W, LH)
        c:restore()
    end
    local function buildRua(self, cfg)
        local cv, c = table.unpack(
            mk(nil, T, LH),
            1,
            2
        )
        local nv, n = table.unpack(
            mk(nil, T, LH),
            1,
            2
        )
        local base = cfg.base
        local pos = __arrL({}, 0)
        local tops = __arrL({}, 0)
        local x = 4
        local i = 0
        local ____t_result_27
        if __t(cfg.lojaIni) then
            ____t_result_27 = cfg.lojaIni
        else
            ____t_result_27 = 0
        end
        local li = ____t_result_27
        local ____t_result_28
        if __t(cfg.outIni) then
            ____t_result_28 = cfg.outIni
        else
            ____t_result_28 = 0
        end
        local oi = ____t_result_28
        while x < T - 30 do
            local ____lt_result_33
            if __lt(
                hash(nil, i * 3 + cfg.seed),
                cfg.lojaChance
            ) then
                local ____get_32 = __get
                local ____cfg_lojas_31 = cfg.lojas
                local ____mod_30 = __mod
                local ____li_29 = li
                li = ____li_29 + 1
                ____lt_result_33 = ____get_32(
                    ____cfg_lojas_31,
                    ____mod_30(
                        ____li_29,
                        __len(cfg.lojas)
                    )
                )
            else
                ____lt_result_33 = nil
            end
            local L = ____lt_result_33
            local ____t_result_34
            if __t(L) then
                ____t_result_34 = largura(
                    nil,
                    __get(L, 0)
                ) + 8
            else
                ____t_result_34 = 20
            end
            local w = math.max(
                ____t_result_34,
                __get(cfg.w, 0) + math.floor(hash(nil, i + cfg.seed) * (__get(cfg.w, 1) - __get(cfg.w, 0)) + 0.5)
            )
            if x + w > T - 6 then
                break
            end
            local floors = __get(cfg.f, 0) + math.floor(hash(nil, i * 7 + cfg.seed) ^ 1.3 * (__get(cfg.f, 1) - __get(cfg.f, 0)) + 0.5)
            local ____predioM_37 = predioM
            local ____array_36 = __TS__SparseArrayNew(
                nil,
                c,
                n,
                x,
                w,
                floors,
                pick(nil, cfg.pal, i + cfg.seed),
                cfg.seed + i * 11,
                base
            )
            local ____t_result_35
            if __t(cfg.vidro) then
                ____t_result_35 = __gt(
                    hash(nil, i + 9 + cfg.seed),
                    0.5
                )
            else
                ____t_result_35 = cfg.vidro
            end
            __TS__SparseArrayPush(
                ____array_36,
                {
                    loja = L,
                    vidro = ____t_result_35,
                    sacada = __gt(
                        hash(nil, i + 5),
                        0.5
                    ),
                    pos = pos
                }
            )
            local top = ____predioM_37(__TS__SparseArraySpread(____array_36))
            __call(tops, "push", {x = x, w = w, top = top})
            local ____t_41 = __t
            local ____t_result_40
            local ____t_39 = __t
            local ____t_result_38
            if __t(cfg.outdoors) then
                ____t_result_38 = __mod(i, cfg.outdoors) == 2
            else
                ____t_result_38 = cfg.outdoors
            end
            __O[432] = ____t_result_38
            if ____t_39(____t_result_38) then
                ____t_result_40 = w > 30
            else
                ____t_result_40 = __O[432]
            end
            if ____t_41(____t_result_40) then
                local ____outdoorM_46 = outdoorM
                local ____array_45 = __TS__SparseArrayNew(
                    nil,
                    c,
                    n,
                    x + 2,
                    top - 2
                )
                local ____get_44 = __get
                local ____mod_43 = __mod
                local ____oi_42 = oi
                oi = ____oi_42 + 1
                __TS__SparseArrayPush(
                    ____array_45,
                    ____get_44(
                        OUTDOORS,
                        ____mod_43(
                            ____oi_42 + cfg.seed,
                            __len(OUTDOORS)
                        )
                    )
                )
                ____outdoorM_46(__TS__SparseArraySpread(____array_45))
            end
            local ____cfg_gap_47 = cfg.gap
            if ____cfg_gap_47 == nil then
                ____cfg_gap_47 = 2
            end
            local ____temp_49 = w + ____cfg_gap_47
            local ____t_result_48
            if __t(cfg.gapR) then
                ____t_result_48 = math.floor(hash(nil, i * 17 + cfg.seed) * cfg.gapR + 0.5)
            else
                ____t_result_48 = 0
            end
            x = x + (____temp_49 + ____t_result_48)
            i = i + 1
        end
        R(
            nil,
            c,
            0,
            base,
            T,
            4,
            "#cfc8b6"
        )
        R(
            nil,
            c,
            0,
            base,
            T,
            1,
            "#e6e0d0"
        )
        R(
            nil,
            c,
            0,
            base + 3,
            T,
            1,
            "#8a8478"
        )
        if __t(cfg.rua) then
            R(
                nil,
                c,
                0,
                base + 4,
                T,
                10,
                "#6a6e72"
            )
            do
                local k = 0
                while k < T do
                    R(
                        nil,
                        c,
                        k,
                        base + 9,
                        8,
                        1,
                        "#e8dc8a"
                    )
                    k = k + 16
                end
            end
        end
        do
            local k = 30
            while k < T do
                R(
                    nil,
                    c,
                    k,
                    base - 26,
                    1,
                    26,
                    "#6a6a66"
                )
                R(
                    nil,
                    c,
                    k - 3,
                    base - 27,
                    5,
                    2,
                    "#5a5a56"
                )
                if __t(n) then
                    R(
                        nil,
                        n,
                        k - 3,
                        base - 25,
                        5,
                        1,
                        "#fff2c0"
                    )
                    n:save()
                    n.globalAlpha = 0.25
                    ell(
                        nil,
                        n,
                        k,
                        base - 14,
                        9,
                        12,
                        "#ffe6a0"
                    )
                    n:restore()
                end
                k = k + 120
            end
        end
        do
            local k = 0
            while k < T do
                if __mod(k, 120) > 12 then
                    arvoreM(
                        nil,
                        c,
                        k,
                        base + 1,
                        k
                    )
                end
                k = k + (40 + math.floor(hash(nil, k) * 70 + 0.5))
            end
        end
        local ____nevoa_52 = nevoa
        local ____c_51 = c
        local ____t_result_50
        if __t(cfg.nevoa) then
            ____t_result_50 = cfg.nevoa
        else
            ____t_result_50 = "rgba(200,214,226,.16)"
        end
        ____nevoa_52(nil, ____c_51, T, ____t_result_50)
        local ____cv_55 = cv
        local ____nv_56 = nv
        local ____base_57 = base
        local ____pos_58 = pos
        local ____tops_59 = tops
        local ____t_result_53
        if __t(cfg.par) then
            ____t_result_53 = cfg.par
        else
            ____t_result_53 = 0.4
        end
        local ____cfg_rua_60 = cfg.rua
        local ____cfg_gente_54 = cfg.gente
        if ____cfg_gente_54 == nil then
            ____cfg_gente_54 = 22
        end
        return {
            cv = ____cv_55,
            nv = ____nv_56,
            base = ____base_57,
            pos = ____pos_58,
            tops = ____tops_59,
            f = ____t_result_53,
            rua = ____cfg_rua_60,
            gente = ____cfg_gente_54
        }
    end
    local function noiteTile(self, c, s, img, off, k)
        if k == nil then
            k = 1
        end
        local a = night(nil, s) * k
        if __t(a < 0.03 or not __t(img)) then
            return
        end
        c:save()
        c.globalCompositeOperation = "lighter"
        c.globalAlpha = a
        tile(nil, c, img, off)
        c:restore()
    end
    local function andaRua(self, c, M, s, t, camL)
        local f = M.f
        do
            local i = 0
            while __lt(i, M.gente) do
                local dir = __t(__mod(i, 2)) and 1 or -1
                local wx = wrap(
                    nil,
                    hash(nil, i * 5 + M.base) * T + t * (5 + __mod(i, 4) * 1.6) * dir
                )
                local sx = wrap(nil, wx - camL * f)
                for ____, xx in __iterar((__arrL({sx, sx - T}, 2))) do
                    if __t(xx > -6 and xx < LW + 6) then
                        pessoinha(
                            nil,
                            c,
                            xx,
                            M.base + 2,
                            i,
                            t
                        )
                    end
                end
                i = i + 1
            end
        end
        if __t(M.rua) then
            do
                local i = 0
                while i < 7 do
                    local dir = __t(__mod(i, 2)) and 1 or -1
                    local wx = wrap(
                        nil,
                        i * 211 + t * (22 + __mod(i, 3) * 8) * dir
                    )
                    local sx = wrap(nil, wx - camL * f)
                    for ____, xx in __iterar((__arrL({sx, sx - T}, 2))) do
                        if __t(xx > -20 and xx < LW + 20) then
                            carrinho(
                                nil,
                                c,
                                xx,
                                M.base + (dir > 0 and 9 or 13),
                                pick(
                                    nil,
                                    __arrL({
                                        "#c43c3a",
                                        "#f2f2ee",
                                        "#3c6aa8",
                                        "#2a2a2a",
                                        "#9aa0a6",
                                        "#e8c24c"
                                    }, 6),
                                    i
                                ),
                                dir
                            )
                        end
                    end
                    i = i + 1
                end
            end
        end
    end
    local function scr(____, M, wx, camL)
        local sx = wrap(nil, wx - camL * M.f)
        local ____temp_61
        if sx > T - 60 then
            ____temp_61 = sx - T
        else
            ____temp_61 = sx
        end
        return ____temp_61
    end
    local MEIO = {}
    local function lazy(____, id, fn)
        local ____t_result_64
        local ____t_63 = __t
        local ____get_result_62 = __get(MEIO, id)
        __O[433] = ____get_result_62
        if ____t_63(____get_result_62) then
            ____t_result_64 = __O[433]
        else
            ____t_result_64 = __set(
                MEIO,
                id,
                fn(nil)
            )
        end
        return ____t_result_64
    end
    local function buildPatio(self)
        local cv, c = table.unpack(
            mk(nil, T, LH),
            1,
            2
        )
        local nv, n = table.unpack(
            mk(nil, T, LH),
            1,
            2
        )
        local b = 132
        R(
            nil,
            c,
            0,
            b - 2,
            T,
            3,
            "#9aa2a6"
        )
        R(
            nil,
            c,
            0,
            b + 1,
            T,
            LH - b,
            "#7f878c"
        )
        for ____, hx in __iterar((__arrL({80, 760}, 2))) do
            do
                local k = 0
                while k < 90 do
                    local h = math.floor(math.sqrt(1 - ((k - 45) / 45) ^ 2) * 14 + 0.5)
                    R(
                        nil,
                        c,
                        hx + k,
                        b - 26 - h,
                        1,
                        26 + h,
                        __t(__mod(k, 6)) and "#c8ccd0" or "#a8b0b4"
                    )
                    k = k + 1
                end
            end
            R(
                nil,
                c,
                hx + 14,
                b - 22,
                62,
                22,
                "#2a3036"
            )
            R(
                nil,
                c,
                hx + 22,
                b - 12,
                40,
                6,
                "#e8ecef"
            )
            R(
                nil,
                c,
                hx + 56,
                b - 16,
                6,
                8,
                "#3c6aa8"
            )
            pxText(
                nil,
                c,
                __add("HANGAR ", hx > 400 and 2 or 1),
                hx + 45,
                b - 36,
                "#5a6066"
            )
        end
        local tw = 420
        R(
            nil,
            c,
            tw,
            b - 60,
            8,
            60,
            "#d8d4cc"
        )
        R(
            nil,
            c,
            tw + 6,
            b - 60,
            2,
            60,
            "#b0aca4"
        )
        R(
            nil,
            c,
            tw - 5,
            b - 72,
            18,
            12,
            "#2c4a5a"
        )
        R(
            nil,
            c,
            tw - 4,
            b - 71,
            16,
            8,
            "#7ac0d0"
        )
        R(
            nil,
            c,
            tw - 6,
            b - 74,
            20,
            2,
            "#d8d4cc"
        )
        R(
            nil,
            c,
            tw + 3,
            b - 82,
            1,
            8,
            "#6a6a66"
        )
        R(
            nil,
            n,
            tw - 4,
            b - 71,
            16,
            8,
            "#bfe8f2"
        )
        R(
            nil,
            n,
            tw + 3,
            b - 83,
            1,
            1,
            "#ff4a3a"
        )
        local function aviao(____, x, s, col)
            R(
                nil,
                c,
                x,
                b - 12 * s,
                60 * s,
                7 * s,
                "#f2f4f6"
            )
            R(
                nil,
                c,
                x + 58 * s,
                b - 11 * s,
                6 * s,
                5 * s,
                "#e8ecef"
            )
            R(
                nil,
                c,
                x - 4 * s,
                b - 22 * s,
                7 * s,
                12 * s,
                col
            )
            R(
                nil,
                c,
                x + 18 * s,
                b - 6 * s,
                24 * s,
                2 * s,
                "#c9ced2"
            )
            do
                local k = 0
                while k < 10 do
                    R(
                        nil,
                        c,
                        x + 8 * s + k * 5 * s,
                        b - 10 * s,
                        2 * s,
                        2 * s,
                        "#3c4a5a"
                    )
                    k = k + 1
                end
            end
            R(
                nil,
                c,
                x,
                b - 7 * s,
                60 * s,
                1,
                col
            )
            R(
                nil,
                c,
                x + 14 * s,
                b - 4 * s,
                2,
                4 * s,
                "#5a5a56"
            )
            R(
                nil,
                c,
                x + 44 * s,
                b - 4 * s,
                2,
                4 * s,
                "#5a5a56"
            )
        end
        aviao(nil, 230, 1, "#c43c3a")
        aviao(nil, 1000, 1.2, "#2c8a5a")
        aviao(nil, 1260, 0.8, "#3c6aa8")
        for ____, fx in __iterar((__arrL({600, 1180}, 2))) do
            R(
                nil,
                c,
                fx,
                b - 10,
                22,
                10,
                "#e8ecef"
            )
            R(
                nil,
                c,
                fx,
                b - 10,
                22,
                1,
                "#ffffff"
            )
            ell(
                nil,
                c,
                fx,
                b - 5,
                3,
                5,
                "#d8dce0"
            )
            ell(
                nil,
                c,
                fx + 22,
                b - 5,
                3,
                5,
                "#d8dce0"
            )
            pxText(
                nil,
                c,
                "JET-A",
                fx + 11,
                b - 8,
                "#c43c3a"
            )
        end
        do
            local k = 0
            while k < T do
                R(
                    nil,
                    c,
                    k,
                    b - 30,
                    1,
                    30,
                    "#8a949a"
                )
                R(
                    nil,
                    c,
                    k - 2,
                    b - 31,
                    5,
                    2,
                    "#5a5e62"
                )
                R(
                    nil,
                    n,
                    k - 2,
                    b - 30,
                    5,
                    1,
                    "#fff2c0"
                )
                k = k + 60
            end
        end
        do
            local k = 0
            while k < T do
                R(
                    nil,
                    c,
                    k,
                    b + 6,
                    4,
                    1,
                    "#e8c24c"
                )
                k = k + 8
            end
        end
        nevoa(nil, c, T, "rgba(205,218,228,.2)")
        return {
            cv = cv,
            nv = nv,
            base = b,
            f = 0.3,
            gente = 0,
            pos = __arrL({}, 0)
        }
    end
    local function meioPatio(self, c, s, t, camL)
        local M = lazy(nil, 12, buildPatio)
        tile(nil, c, M.cv, camL * M.f)
        noiteTile(
            nil,
            c,
            s,
            M.nv,
            camL * M.f
        )
        do
            local sx = scr(
                nil,
                M,
                wrap(nil, t * 18),
                camL
            )
            R(
                nil,
                c,
                sx,
                146,
                8,
                4,
                "#e8c24c"
            )
            R(
                nil,
                c,
                sx + 5,
                143,
                3,
                3,
                "#2a2a2a"
            )
            do
                local k = 0
                while k < 3 do
                    R(
                        nil,
                        c,
                        sx - 10 - k * 10,
                        146,
                        8,
                        3,
                        "#3c6aa8"
                    )
                    R(
                        nil,
                        c,
                        sx - 9 - k * 10,
                        143,
                        6,
                        3,
                        pick(
                            nil,
                            __arrL({"#c43c3a", "#e8c24c", "#4a8a5a"}, 3),
                            k
                        )
                    )
                    k = k + 1
                end
            end
        end
        do
            local sx = scr(
                nil,
                M,
                wrap(nil, 900 - t * 26),
                camL
            )
            R(
                nil,
                c,
                sx,
                145,
                10,
                4,
                "#f2c94c"
            )
            R(
                nil,
                c,
                sx + 2,
                142,
                5,
                3,
                "#2a2a2a"
            )
            if math.sin(t * 8) > 0 then
                R(
                    nil,
                    c,
                    sx + 4,
                    141,
                    2,
                    1,
                    "#f08a24"
                )
            end
            pxText(
                nil,
                c,
                "SIGA-ME",
                sx + 5,
                136,
                "#f2c94c"
            )
        end
        do
            local ph = __mod(t / 60, 1)
            local sx = scr(nil, M, 300 + ph * 900, camL)
            R(
                nil,
                c,
                sx,
                140,
                30,
                5,
                "#f2f4f6"
            )
            R(
                nil,
                c,
                sx - 3,
                134,
                4,
                7,
                "#e8833a"
            )
            R(
                nil,
                c,
                sx + 10,
                143,
                12,
                1,
                "#c9ced2"
            )
        end
        do
            local sx = scr(nil, M, 296, camL)
            local up = math.sin(t * 3) > 0
            R(
                nil,
                c,
                sx,
                141,
                2,
                8,
                "#f08a24"
            )
            R(
                nil,
                c,
                sx - 2,
                __t(up) and 140 or 143,
                2,
                1,
                "#ff6a3a"
            )
            R(
                nil,
                c,
                sx + 2,
                __t(up) and 143 or 140,
                2,
                1,
                "#ff6a3a"
            )
        end
    end
    local function buildEncosta(self)
        local cv, c = table.unpack(
            mk(nil, T, LH),
            1,
            2
        )
        local nv, n = table.unpack(
            mk(nil, T, LH),
            1,
            2
        )
        local function hy(____, x)
            return 120 + math.sin(x / T * TAU * 2) * 14 + math.sin(x / T * TAU * 7 + 1) * 6 + math.sin(x / T * TAU * 19) * 2
        end
        do
            local x = 0
            while x < T do
                local y = math.floor(hy(nil, x) + 0.5)
                do
                    local yy = y
                    while yy < 206 do
                        R(
                            nil,
                            c,
                            x,
                            yy,
                            1,
                            2,
                            A:lerpC("#8aa462", "#6f8a4c", (yy - y) / 90)
                        )
                        yy = yy + 2
                    end
                end
                R(
                    nil,
                    c,
                    x,
                    y,
                    1,
                    1,
                    "#a8c07a"
                )
                x = x + 1
            end
        end
        do
            local i = 0
            while i < 900 do
                R(
                    nil,
                    c,
                    hash(nil, i + 70) * T,
                    hy(
                        nil,
                        hash(nil, i + 70) * T
                    ) + 3 + hash(nil, i + 71) * 70,
                    2,
                    1,
                    __t(__mod(i, 2)) and "#7a9456" or "#9ab46a"
                )
                i = i + 1
            end
        end
        local COR = __arrL({
            "#f2c4c4",
            "#f2e2a8",
            "#c8dcf0",
            "#d4ecc8",
            "#f6f2e8",
            "#e8c8e8",
            "#f0d0a0",
            "#c8e8e0"
        }, 8)
        do
            local r = 0
            while r < 4 do
                do
                    local x = 6 + r * 7
                    local i = 0
                    while x < T - 30 do
                        do
                            local w = 12 + math.floor(hash(nil, i * 3 + r * 50) * 12 + 0.5)
                            local h = 9 + math.floor(hash(nil, i * 5 + r * 50) * 5 + 0.5)
                            local cx = x + w / 2
                            local bse = math.floor(hy(nil, cx) + 10 + r * 18 + 0.5)
                            if __t(__lt(
                                hash(nil, i * 7 + r * 31),
                                0.18
                            ) or bse > 200) then
                                arvoreM(
                                    nil,
                                    c,
                                    x + 6,
                                    bse,
                                    i + r * 40,
                                    0.9
                                )
                                x = x + (w + 6)
                                do i = i + 1 continue end
                            end
                            local col = pick(nil, COR, i + r * 9)
                            R(
                                nil,
                                c,
                                x,
                                bse - h,
                                w,
                                h,
                                col
                            )
                            R(
                                nil,
                                c,
                                x + w - 2,
                                bse - h,
                                2,
                                h,
                                shadeHex(nil, col, 0.82)
                            )
                            R(
                                nil,
                                c,
                                x,
                                bse - 1,
                                w,
                                1,
                                shadeHex(nil, col, 0.75)
                            )
                            if __gt(
                                hash(nil, i + r * 3),
                                0.45
                            ) then
                                roofTiles(
                                    nil,
                                    c,
                                    x - 1,
                                    bse - h - 3,
                                    w + 2,
                                    3,
                                    pick(
                                        nil,
                                        __arrL({"#b8644a", "#a8543c"}, 2),
                                        i
                                    )
                                )
                            else
                                R(
                                    nil,
                                    c,
                                    x - 1,
                                    bse - h - 1,
                                    w + 2,
                                    1,
                                    shadeHex(nil, col, 0.7)
                                )
                                if __gt(
                                    hash(nil, i + 1),
                                    0.4
                                ) then
                                    R(
                                        nil,
                                        c,
                                        x + 2,
                                        bse - h - 5,
                                        5,
                                        4,
                                        "#3c6aa8"
                                    )
                                    R(
                                        nil,
                                        c,
                                        x + 2,
                                        bse - h - 5,
                                        5,
                                        1,
                                        "#6a9ad0"
                                    )
                                end
                            end
                            do
                                local k = 0
                                while k < math.floor(w / 6) do
                                    local wx = x + 2 + k * 6
                                    R(
                                        nil,
                                        c,
                                        wx,
                                        bse - h + 3,
                                        3,
                                        3,
                                        "#4a6a7a"
                                    )
                                    R(
                                        nil,
                                        c,
                                        wx,
                                        bse - h + 3,
                                        3,
                                        1,
                                        "#7a9aaa"
                                    )
                                    if __gt(
                                        hash(nil, i * 11 + k + r),
                                        0.5
                                    ) then
                                        R(
                                            nil,
                                            n,
                                            wx,
                                            bse - h + 3,
                                            3,
                                            3,
                                            pick(
                                                nil,
                                                __arrL({"#ffd98a", "#ffe6b0"}, 2),
                                                k
                                            )
                                        )
                                    end
                                    k = k + 1
                                end
                            end
                            R(
                                nil,
                                c,
                                x + w - 5,
                                bse - 5,
                                3,
                                5,
                                "#6a4a32"
                            )
                            if __gt(
                                hash(nil, i + r * 7),
                                0.7
                            ) then
                                do
                                    local k = 0
                                    while k < w do
                                        R(
                                            nil,
                                            c,
                                            x + k,
                                            bse - h - 6 + math.floor(math.sin(k / w * math.pi) + 0.5),
                                            2,
                                            2,
                                            pick(
                                                nil,
                                                __arrL({"#d9634a", "#3c6aa8", "#f2efe6", "#e8c24c"}, 4),
                                                k + i
                                            )
                                        )
                                        k = k + 3
                                    end
                                end
                            end
                            x = x + (w + 2 + math.floor(hash(nil, i * 13 + r) * 6 + 0.5))
                        end
                        i = i + 1
                    end
                end
                r = r + 1
            end
        end
        local ESC = __arrL({180, 520, 980, 1300}, 4)
        for ____, ex in __iterar((ESC)) do
            local top = math.floor(hy(nil, ex) + 0.5) + 4
            do
                local y = top
                while y < 204 do
                    local ____t_result_65
                    if __t(__mod(
                        math.floor(y / 8),
                        2
                    )) then
                        ____t_result_65 = __mod(y, 8)
                    else
                        ____t_result_65 = 8 - __mod(y, 8)
                    end
                    local xx = ex + ____t_result_65
                    R(
                        nil,
                        c,
                        xx,
                        y,
                        4,
                        1,
                        "#ece6d6"
                    )
                    R(
                        nil,
                        c,
                        xx,
                        y + 1,
                        4,
                        1,
                        "#b8b2a2"
                    )
                    y = y + 2
                end
            end
            do
                local y = top + 10
                while y < 200 do
                    R(
                        nil,
                        c,
                        ex + 12,
                        y - 8,
                        1,
                        8,
                        "#6a6a66"
                    )
                    R(
                        nil,
                        n,
                        ex + 11,
                        y - 8,
                        3,
                        1,
                        "#fff2c0"
                    )
                    y = y + 24
                end
            end
        end
        local ig = 700
        local iy = math.floor(hy(nil, ig + 12) + 0.5) + 12
        R(
            nil,
            c,
            ig,
            iy - 18,
            26,
            18,
            "#f6f2e8"
        )
        R(
            nil,
            c,
            ig + 24,
            iy - 18,
            2,
            18,
            "#d8d2c0"
        )
        do
            local k = 0
            while k < 13 do
                R(
                    nil,
                    c,
                    ig + k,
                    iy - 18 - k * 0.8,
                    26 - k * 2,
                    1,
                    "#e8e2d0"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            ig + 9,
            iy - 40,
            8,
            22,
            "#f6f2e8"
        )
        R(
            nil,
            c,
            ig + 9,
            iy - 40,
            8,
            1,
            "#ffffff"
        )
        R(
            nil,
            c,
            ig + 11,
            iy - 36,
            4,
            5,
            "#5a6a7a"
        )
        R(
            nil,
            c,
            ig + 12,
            iy - 50,
            2,
            10,
            "#5a5a56"
        )
        R(
            nil,
            c,
            ig + 10,
            iy - 47,
            6,
            1,
            "#5a5a56"
        )
        R(
            nil,
            c,
            ig + 10,
            iy - 10,
            6,
            10,
            "#6a4a32"
        )
        R(
            nil,
            n,
            ig + 11,
            iy - 36,
            4,
            5,
            "#ffe6b0"
        )
        local cp = 1100
        local cy = math.floor(hy(nil, cp + 40) + 0.5) + 26
        R(
            nil,
            c,
            cp,
            cy,
            80,
            10,
            "#c49a6a"
        )
        R(
            nil,
            c,
            cp,
            cy,
            80,
            1,
            "#d8b080"
        )
        R(
            nil,
            c,
            cp + 2,
            cy + 4,
            76,
            1,
            "rgba(255,255,255,.5)"
        )
        for ____, gx in __iterar((__arrL({cp + 1, cp + 75}, 2))) do
            R(
                nil,
                c,
                gx,
                cy - 5,
                1,
                6,
                "#f2efe6"
            )
            R(
                nil,
                c,
                gx + 3,
                cy - 5,
                1,
                6,
                "#f2efe6"
            )
            R(
                nil,
                c,
                gx,
                cy - 5,
                4,
                1,
                "#f2efe6"
            )
        end
        nevoa(nil, c, T, "rgba(204,218,228,.2)")
        return {
            cv = cv,
            nv = nv,
            base = 200,
            f = 0.3,
            gente = 0,
            hy = hy,
            ESC = ESC,
            cp = cp,
            cy = cy,
            ig = ig,
            iy = iy
        }
    end
    local function meioEncosta(self, c, s, t, camL)
        local M = lazy(nil, 13, buildEncosta)
        tile(nil, c, M.cv, camL * M.f)
        noiteTile(
            nil,
            c,
            s,
            M.nv,
            camL * M.f
        )
        do
            local i = 0
            while i < 4 do
                local ex = __get(M.ESC, i)
                local k = __mod(t * 0.025 + i * 0.27, 1)
                local top = M:hy(ex) + 4
                local y = 204 - k * (204 - top)
                local ____temp_67 = ex + 2
                local ____t_result_66
                if __t(__mod(
                    math.floor(y / 8),
                    2
                )) then
                    ____t_result_66 = __mod(y, 8)
                else
                    ____t_result_66 = 8 - __mod(y, 8)
                end
                local sx = scr(nil, M, ____temp_67 + ____t_result_66, camL)
                if __t(sx > -10 and sx < LW + 10) then
                    pessoinha(
                        nil,
                        c,
                        sx,
                        y,
                        i + 3,
                        t
                    )
                end
                i = i + 1
            end
        end
        if __lt(
            night(nil, s),
            0.6
        ) then
            local bx = M.cp + 40 + math.sin(t * 1.7) * 30
            local by = M.cy - 2 - math.abs(math.sin(t * 3.4)) * 8
            do
                local k = 0
                while k < 6 do
                    local px = M.cp + 8 + k * 12 + math.sin(t * 1.7 + k) * 6
                    local sx = scr(nil, M, px, camL)
                    if __t(vis(nil, sx, 10)) then
                        pessoinha(
                            nil,
                            c,
                            sx,
                            M.cy + 6,
                            k + 1,
                            t
                        )
                    end
                    k = k + 1
                end
            end
            local sb = scr(nil, M, bx, camL)
            if __t(vis(nil, sb, 10)) then
                R(
                    nil,
                    c,
                    sb,
                    by,
                    2,
                    2,
                    "#f2efe6"
                )
            end
        end
        do
            local sx = scr(nil, M, M.ig + 13, camL)
            if __t(vis(nil, sx, 20)) then
                local sw = math.floor(math.sin(t * 2.4) * 1.5 + 0.5)
                R(
                    nil,
                    c,
                    sx - 1 + sw,
                    M.iy - 35,
                    2,
                    3,
                    "#c8a24a"
                )
            end
        end
    end
    local function meioComercio(self, c, s, t, camL)
        local M = lazy(
            nil,
            14,
            function() return buildRua(
                nil,
                {
                    seed = 140,
                    base = 188,
                    f = __arrL({5, 10}, 2),
                    w = __arrL({26, 46}, 2),
                    pal = __arrL({
                        "#ebe8de",
                        "#e0d6c2",
                        "#f3f0e8",
                        "#d4cab6",
                        "#dfe6ea",
                        "#e8dcc8"
                    }, 6),
                    lojas = LOJAS_RUA,
                    lojaChance = 0.9,
                    outdoors = 3,
                    rua = true
                }
            ) end
        )
        tile(nil, c, M.cv, camL * M.f)
        noiteTile(
            nil,
            c,
            s,
            M.nv,
            camL * M.f
        )
        andaRua(
            nil,
            c,
            M,
            s,
            t,
            camL
        )
        local tp = __get(M.tops, 6)
        if __t(tp) then
            local sx = scr(nil, M, tp.x + tp.w / 2, camL)
            if __t(vis(nil, sx, 30)) then
                R(
                    nil,
                    c,
                    sx - 1,
                    tp.top - 12,
                    2,
                    12,
                    "#5a5e62"
                )
                R(
                    nil,
                    c,
                    sx - 17,
                    tp.top - 24,
                    34,
                    13,
                    "#1a1c20"
                )
                R(
                    nil,
                    c,
                    sx - 16,
                    tp.top - 23,
                    32,
                    11,
                    "#0c0e10"
                )
                local ____s_h_68 = s.h
                if ____s_h_68 == nil then
                    ____s_h_68 = 12
                end
                local h = ____s_h_68
                local temp = math.floor(13 + 6 * math.sin((h - 9) / 24 * TAU) + 0.5)
                local hh = math.floor(h)
                local mm = math.floor((h - hh) * 60)
                local ____t_result_69
                if __t(__mod(
                    math.floor(t / 3),
                    2
                )) then
                    ____t_result_69 = tostring(temp) .. "°C"
                else
                    ____t_result_69 = (tostring(__call(
                        tostring(hh),
                        "padStart",
                        2,
                        "0"
                    )) .. ":") .. tostring(__call(
                        tostring(mm),
                        "padStart",
                        2,
                        "0"
                    ))
                end
                local txt = ____t_result_69
                pxText(
                    nil,
                    c,
                    txt,
                    sx,
                    tp.top - 20,
                    "#ffa83a"
                )
            end
        end
    end
    local function meioAvenida(self, c, s, t, camL)
        local M = lazy(
            nil,
            16,
            function() return buildRua(
                nil,
                {
                    seed = 160,
                    base = 184,
                    f = __arrL({3, 10}, 2),
                    w = __arrL({28, 50}, 2),
                    gap = 3,
                    gapR = 18,
                    nevoa = "rgba(200,214,226,.24)",
                    pal = __arrL({
                        "#ebe8de",
                        "#dfe6ea",
                        "#f3f0e8",
                        "#d4cab6",
                        "#cfd6dc",
                        "#e8dcc8"
                    }, 6),
                    lojas = LOJAS_RUA,
                    lojaIni = 14,
                    lojaChance = 0.85,
                    outdoors = 4,
                    outIni = 3,
                    vidro = true,
                    gente = 26
                }
            ) end
        )
        tile(nil, c, M.cv, camL * M.f)
        noiteTile(
            nil,
            c,
            s,
            M.nv,
            camL * M.f
        )
        andaRua(
            nil,
            c,
            M,
            s,
            t,
            camL
        )
        local tp = __get(M.tops, 9)
        if __t(tp) then
            local sx = scr(nil, M, tp.x + tp.w / 2, camL)
            if __t(vis(nil, sx, 60)) then
                local L = __get(
                    OUTDOORS,
                    __mod(
                        math.floor(t / 4),
                        __len(OUTDOORS)
                    )
                )
                local w = math.max(
                    54,
                    largura(
                        nil,
                        __get(L, 0)
                    ) + 10
                )
                R(
                    nil,
                    c,
                    sx - 1,
                    tp.top - 8,
                    2,
                    8,
                    "#5a5e62"
                )
                R(
                    nil,
                    c,
                    sx - w / 2 - 1,
                    tp.top - 24,
                    w + 2,
                    16,
                    "#14161a"
                )
                R(
                    nil,
                    c,
                    sx - w / 2,
                    tp.top - 23,
                    w,
                    14,
                    __get(L, 1)
                )
                do
                    local k = 0
                    while k < w do
                        R(
                            nil,
                            c,
                            sx - w / 2 + k,
                            tp.top - 23,
                            1,
                            14,
                            "rgba(0,0,0,.18)"
                        )
                        k = k + 2
                    end
                end
                pxText(
                    nil,
                    c,
                    __get(L, 0),
                    sx,
                    tp.top - 18,
                    __get(L, 2)
                )
            end
        end
    end
    local function buildSerraM(self)
        local cv, c = table.unpack(
            mk(nil, T, LH),
            1,
            2
        )
        local nv, n = table.unpack(
            mk(nil, T, LH),
            1,
            2
        )
        local function ry(____, x)
            return 86 + math.sin(x / T * TAU * 2) * 13 + math.sin(x / T * TAU * 5 + 2) * 6 + math.sin(x / T * TAU * 13) * 2.5
        end
        do
            local x = 0
            while x < T do
                local y = math.floor(ry(nil, x) + 0.5)
                do
                    local yy = y
                    while yy < 200 do
                        R(
                            nil,
                            c,
                            x,
                            yy,
                            1,
                            2,
                            A:lerpC("#8e9c8a", "#748476", (yy - y) / 100)
                        )
                        yy = yy + 2
                    end
                end
                R(
                    nil,
                    c,
                    x,
                    y,
                    1,
                    1,
                    "#b4c0b4"
                )
                x = x + 1
            end
        end
        do
            local i = 0
            while i < 70 do
                local x = hash(nil, i + 15) * T
                local y = ry(nil, x) + 6 + hash(nil, i + 16) * 60
                ell(
                    nil,
                    c,
                    x,
                    y,
                    3 + hash(nil, i) * 6,
                    2 + hash(nil, i * 3) * 3,
                    "#8a8a80"
                )
                ell(
                    nil,
                    c,
                    x - 1,
                    y - 1,
                    2 + hash(nil, i) * 3,
                    1.5,
                    "#a6a69a"
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 260 do
                local x = hash(nil, i + 150) * T
                local y = ry(nil, x) + 4 + hash(nil, i + 151) * 80
                ell(
                    nil,
                    c,
                    x,
                    y,
                    1.5 + hash(nil, i) * 2,
                    1.2,
                    __t(__mod(i, 2)) and "#5a7a3c" or "#6a8a44"
                )
                i = i + 1
            end
        end
        local TR = __arrL({}, 0)
        for ____, x0 in __iterar((__arrL({140, 820}, 2))) do
            local pts = __arrL({}, 0)
            local x = x0
            local y = 190
            do
                local k = 0
                while y > ry(nil, x) + 6 do
                    __call(
                        pts,
                        "push",
                        __arrL({x, y}, 2)
                    )
                    x = x + (__t(__mod(k, 2)) and -34 or 38)
                    y = y - 13
                    k = k + 1
                end
            end
            __call(
                pts,
                "push",
                __arrL(
                    {
                        x,
                        ry(nil, x) + 3
                    },
                    2
                )
            )
            __call(TR, "push", pts)
            do
                local k = 1
                while k < __len(pts) do
                    limb(
                        nil,
                        c,
                        __arrL(
                            {
                                __get(pts, k - 1),
                                __get(pts, k)
                            },
                            2
                        ),
                        2,
                        "#c8b48a"
                    )
                    k = k + 1
                end
            end
        end
        local ax = 520
        local ay = math.floor(ry(nil, ax) + 0.5)
        R(
            nil,
            c,
            ax,
            ay - 40,
            2,
            40,
            "#9a3a34"
        )
        do
            local k = 0
            while k < 40 do
                R(
                    nil,
                    c,
                    ax - 3,
                    ay - 40 + k,
                    8,
                    1,
                    "#d8d8d0"
                )
                k = k + 5
            end
        end
        R(
            nil,
            n,
            ax,
            ay - 42,
            2,
            2,
            "#ff4a3a"
        )
        local mx = 1120
        local my = math.floor(ry(nil, mx) + 0.5)
        R(
            nil,
            c,
            mx - 10,
            my - 4,
            22,
            2,
            "#8a6a45"
        )
        do
            local k = 0
            while k < 22 do
                R(
                    nil,
                    c,
                    mx - 10 + k,
                    my - 8,
                    1,
                    4,
                    "#6a4a32"
                )
                k = k + 3
            end
        end
        R(
            nil,
            c,
            mx - 10,
            my - 8,
            22,
            1,
            "#6a4a32"
        )
        nevoa(nil, c, T, "rgba(196,210,224,.36)")
        return {
            cv = cv,
            nv = nv,
            base = 200,
            f = 0.06,
            gente = 0,
            TR = TR,
            ry = ry,
            ax = ax,
            ay = ay
        }
    end
    local function naTrilha(self, pts, u)
        local n = __len(pts) - 1
        local k = math.min(
            n - 1,
            math.floor(u * n)
        )
        local f = u * n - k
        return __arrL(
            {
                __get(
                    __get(pts, k),
                    0
                ) + (__get(
                    __get(pts, k + 1),
                    0
                ) - __get(
                    __get(pts, k),
                    0
                )) * f,
                __get(
                    __get(pts, k),
                    1
                ) + (__get(
                    __get(pts, k + 1),
                    1
                ) - __get(
                    __get(pts, k),
                    1
                )) * f
            },
            2
        )
    end
    local function meioSerra(self, c, s, t, camL)
        local M = lazy(nil, 15, buildSerraM)
        tile(nil, c, M.cv, camL * M.f)
        noiteTile(
            nil,
            c,
            s,
            M.nv,
            camL * M.f
        )
        if __lt(
            night(nil, s),
            0.7
        ) then
            do
                local i = 0
                while i < 6 do
                    local pts = __get(
                        M.TR,
                        __mod(i, 2)
                    )
                    local u = __mod(t * 0.012 + i * 0.19, 1)
                    local ____naTrilha_71 = naTrilha
                    local ____t_result_70
                    if __t(__mod(i, 3)) then
                        ____t_result_70 = u
                    else
                        ____t_result_70 = 1 - u
                    end
                    local x, y = table.unpack(
                        ____naTrilha_71(nil, pts, ____t_result_70),
                        1,
                        2
                    )
                    local sx = scr(nil, M, x, camL)
                    if __t(vis(nil, sx, 10)) then
                        pessoinha(
                            nil,
                            c,
                            sx,
                            y,
                            i + 5,
                            t
                        )
                        R(
                            nil,
                            c,
                            sx + 2,
                            y - 7,
                            2,
                            3,
                            pick(
                                nil,
                                __arrL({"#c43c3a", "#e8833a", "#3c6aa8"}, 3),
                                i
                            )
                        )
                    end
                    i = i + 1
                end
            end
        end
        do
            local a = t * 0.18
            local x = 700 + math.cos(a) * 120
            local y = 54 + math.sin(a * 2) * 10
            local sx = scr(nil, M, x, camL)
            if __t(vis(nil, sx, 30)) then
                do
                    local k = -6
                    while k <= 6 do
                        R(
                            nil,
                            c,
                            sx + k * 2,
                            y - math.floor(math.sqrt(1 - (k / 7) ^ 2) * 3 + 0.5),
                            2,
                            2,
                            __t(__mod(k, 2)) and "#e8433a" or "#f2c94c"
                        )
                        k = k + 1
                    end
                end
                limb(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({sx - 11, y}, 2),
                            __arrL({sx, y + 10}, 2)
                        },
                        2
                    ),
                    1,
                    "rgba(60,60,60,.7)"
                )
                limb(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({sx + 11, y}, 2),
                            __arrL({sx, y + 10}, 2)
                        },
                        2
                    ),
                    1,
                    "rgba(60,60,60,.7)"
                )
                R(
                    nil,
                    c,
                    sx - 1,
                    y + 9,
                    3,
                    4,
                    "#2c4a6a"
                )
            end
        end
    end
    local function buildMercado(self)
        local M = buildRua(
            nil,
            {
                seed = 170,
                base = 182,
                f = __arrL({4, 8}, 2),
                w = __arrL({26, 44}, 2),
                pal = __arrL({"#ece4cf", "#dde4d4", "#f2e4d8", "#e4dccb"}, 4),
                lojas = LOJAS_RUA,
                lojaIni = 21,
                lojaChance = 0.8,
                outdoors = 4,
                outIni = 4
            }
        )
        local c = M.cv:getContext("2d")
        local n = M.nv:getContext("2d")
        for ____, mx in __iterar((__arrL({300, 1000}, 2))) do
            local w = 220
            local b = 182
            R(
                nil,
                c,
                mx,
                b - 40,
                w,
                40,
                "#f2ece0"
            )
            do
                local k = 0
                while k < 8 do
                    local ax = mx + 8 + k * 27
                    R(
                        nil,
                        c,
                        ax,
                        b - 30,
                        16,
                        30,
                        "#7a5a3a"
                    )
                    ell(
                        nil,
                        c,
                        ax + 8,
                        b - 30,
                        8,
                        6,
                        "#7a5a3a"
                    )
                    R(
                        nil,
                        c,
                        ax + 2,
                        b - 24,
                        12,
                        24,
                        "#3a2a1a"
                    )
                    R(
                        nil,
                        n,
                        ax + 2,
                        b - 24,
                        12,
                        10,
                        "rgba(255,214,140,.6)"
                    )
                    k = k + 1
                end
            end
            do
                local k = 0
                while k < 5 do
                    local ax = mx + k * 44
                    do
                        local j = 0
                        while j <= 44 do
                            R(
                                nil,
                                c,
                                ax + j,
                                b - 44 - math.floor(math.sin(j / 44 * math.pi) * 12 + 0.5),
                                1,
                                4,
                                __t(__mod(j, 4)) and "#9aa4ac" or "#7a848c"
                            )
                            j = j + 1
                        end
                    end
                    k = k + 1
                end
            end
            R(
                nil,
                c,
                mx - 2,
                b - 44,
                w + 4,
                4,
                "#c43c3a"
            )
            pxText(
                nil,
                c,
                "MERCADO MUNICIPAL",
                mx + w / 2,
                b - 38,
                "#c43c3a"
            )
        end
        local ix = 720
        local b = 182
        R(
            nil,
            c,
            ix,
            b - 50,
            40,
            50,
            "#f6f2e8"
        )
        R(
            nil,
            c,
            ix + 38,
            b - 50,
            2,
            50,
            "#d8d2c0"
        )
        do
            local k = 0
            while k < 18 do
                R(
                    nil,
                    c,
                    ix + k,
                    b - 50 - k * 0.9,
                    40 - k * 2,
                    1,
                    "#e8e2d0"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            ix + 14,
            b - 96,
            12,
            46,
            "#f6f2e8"
        )
        R(
            nil,
            c,
            ix + 14,
            b - 96,
            12,
            1,
            "#ffffff"
        )
        R(
            nil,
            c,
            ix + 16,
            b - 90,
            8,
            8,
            "#5a6a7a"
        )
        R(
            nil,
            c,
            ix + 19,
            b - 110,
            2,
            14,
            "#5a5a56"
        )
        R(
            nil,
            c,
            ix + 16,
            b - 106,
            8,
            2,
            "#5a5a56"
        )
        R(
            nil,
            c,
            ix + 14,
            b - 20,
            12,
            20,
            "#6a4a32"
        )
        ell(
            nil,
            c,
            ix + 20,
            b - 36,
            4,
            4,
            "#5a6a7a"
        )
        R(
            nil,
            n,
            ix + 16,
            b - 90,
            8,
            8,
            "#ffe6b0"
        )
        nevoa(nil, c, T, "rgba(200,214,226,.1)")
        M.ig = ix + 20
        M.igy = b - 86
        return M
    end
    local function meioMercado(self, c, s, t, camL)
        local M = lazy(nil, 17, buildMercado)
        tile(nil, c, M.cv, camL * M.f)
        noiteTile(
            nil,
            c,
            s,
            M.nv,
            camL * M.f
        )
        andaRua(
            nil,
            c,
            M,
            s,
            t,
            camL
        )
        local sx = scr(nil, M, M.ig, camL)
        if __t(vis(nil, sx, 40)) then
            local sw = math.floor(math.sin(t * 2.2) * 2 + 0.5)
            R(
                nil,
                c,
                sx - 2 + sw,
                M.igy,
                4,
                4,
                "#c8a24a"
            )
            do
                local i = 0
                while i < 5 do
                    local a = t * 1.2 + i * 1.25
                    R(
                        nil,
                        c,
                        sx + math.cos(a) * 20,
                        M.igy - 16 + math.sin(a) * 6,
                        2,
                        1,
                        "#5a5e66"
                    )
                    i = i + 1
                end
            end
        end
    end
    local function buildCafezal(self)
        local cv, c = table.unpack(
            mk(nil, T, LH),
            1,
            2
        )
        local nv, n = table.unpack(
            mk(nil, T, LH),
            1,
            2
        )
        local function morro(____, x, k)
            return (__t(k) and 92 or 74) + math.sin(x / T * TAU * (__t(k) and 3 or 2) + k * 2) * (__t(k) and 10 or 12) + math.sin(x / T * TAU * 7 + k) * 3
        end
        for ____, k in __iterar((__arrL({0, 1}, 2))) do
            do
                local x = 0
                while x < T do
                    local y = math.floor(morro(nil, x, k) + 0.5)
                    do
                        local yy = y
                        while yy < 200 do
                            R(
                                nil,
                                c,
                                x,
                                yy,
                                1,
                                2,
                                A:lerpC(
                                    __t(k) and "#7a9a52" or "#90aa6a",
                                    __t(k) and "#5f7f40" or "#7a9658",
                                    (yy - y) / 80
                                )
                            )
                            yy = yy + 2
                        end
                    end
                    R(
                        nil,
                        c,
                        x,
                        y,
                        1,
                        1,
                        __t(k) and "#a4bc78" or "#b4c890"
                    )
                    x = x + 1
                end
            end
            do
                local r = 0
                while r < 18 do
                    do
                        local x = __mod(r, 2) * 2
                        while x < T do
                            do
                                local y = morro(nil, x, k) + 5 + r * 4.5
                                if y > 200 then
                                    do x = x + 3 continue end
                                end
                                R(
                                    nil,
                                    c,
                                    x,
                                    math.floor(y + 0.5),
                                    2,
                                    2,
                                    __t(__mod(r + k, 2)) and "#2f5a34" or "#3a6a3c"
                                )
                                if __gt(
                                    hash(nil, x * 3 + r),
                                    0.93
                                ) then
                                    R(
                                        nil,
                                        c,
                                        x,
                                        math.floor(y + 0.5),
                                        1,
                                        1,
                                        "#c43c3a"
                                    )
                                end
                            end
                            x = x + 3
                        end
                    end
                    r = r + 1
                end
            end
            do
                local i = 0
                while i < 14 do
                    local x = hash(nil, i * 7 + k * 50) * T
                    arvoreM(
                        nil,
                        c,
                        x,
                        morro(nil, x, k) + 14 + hash(nil, i) * 30,
                        i + k * 20,
                        1.2
                    )
                    i = i + 1
                end
            end
        end
        local road = __arrL({}, 0)
        do
            local x = 0
            while x <= T do
                __call(
                    road,
                    "push",
                    __arrL(
                        {
                            x,
                            morro(nil, x, 1) + 40 + math.sin(x / T * TAU * 4) * 8
                        },
                        2
                    )
                )
                x = x + 24
            end
        end
        do
            local k = 1
            while k < __len(road) do
                limb(
                    nil,
                    c,
                    __arrL(
                        {
                            __get(road, k - 1),
                            __get(road, k)
                        },
                        2
                    ),
                    3,
                    "#c8a878"
                )
                k = k + 1
            end
        end
        local hx = 600
        local hy = math.floor(morro(nil, hx, 0) + 0.5) + 10
        R(
            nil,
            c,
            hx,
            hy - 10,
            22,
            10,
            "#f6f2e8"
        )
        roofTiles(
            nil,
            c,
            hx - 2,
            hy - 14,
            26,
            4,
            "#a8543c"
        )
        R(
            nil,
            c,
            hx + 3,
            hy - 7,
            3,
            3,
            "#5a6a7a"
        )
        R(
            nil,
            c,
            hx + 15,
            hy - 7,
            3,
            7,
            "#6a4a32"
        )
        R(
            nil,
            n,
            hx + 3,
            hy - 7,
            3,
            3,
            "#ffd98a"
        )
        local gx = 1180
        local gy = math.floor(morro(nil, gx, 0) + 0.5) + 14
        R(
            nil,
            c,
            gx,
            gy - 12,
            26,
            12,
            "#a83a2a"
        )
        do
            local k = 0
            while k < 13 do
                R(
                    nil,
                    c,
                    gx + k,
                    gy - 12 - k * 0.6,
                    26 - k * 2,
                    1,
                    "#8a2a20"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            gx + 9,
            gy - 8,
            8,
            8,
            "#f2efe6"
        )
        nevoa(nil, c, T, "rgba(204,218,226,.18)")
        return {
            cv = cv,
            nv = nv,
            base = 200,
            f = 0.26,
            gente = 0,
            road = road,
            morro = morro
        }
    end
    local function meioCafezal(self, c, s, t, camL)
        local M = lazy(nil, 18, buildCafezal)
        tile(nil, c, M.cv, camL * M.f)
        noiteTile(
            nil,
            c,
            s,
            M.nv,
            camL * M.f
        )
        do
            local u = __mod(t * 0.01, 1)
            local x = u * T
            local k = math.min(
                __len(M.road) - 2,
                math.floor(x / 24)
            )
            local y = __get(
                __get(M.road, k),
                1
            ) + (__get(
                __get(M.road, k + 1),
                1
            ) - __get(
                __get(M.road, k),
                1
            )) * (x / 24 - k)
            local sx = scr(nil, M, x, camL)
            if __t(vis(nil, sx, 30)) then
                R(
                    nil,
                    c,
                    sx,
                    y - 5,
                    8,
                    4,
                    "#c43c3a"
                )
                R(
                    nil,
                    c,
                    sx + 5,
                    y - 9,
                    4,
                    4,
                    "#c43c3a"
                )
                R(
                    nil,
                    c,
                    sx + 6,
                    y - 8,
                    2,
                    2,
                    "#9fc4d0"
                )
                ell(
                    nil,
                    c,
                    sx + 1,
                    y - 1,
                    2,
                    2,
                    "#1c1c1c"
                )
                ell(
                    nil,
                    c,
                    sx + 7,
                    y,
                    1.5,
                    1.5,
                    "#1c1c1c"
                )
                do
                    local i = 0
                    while i < 5 do
                        local q = __mod(t * 1.5 + i / 5, 1)
                        ell(
                            nil,
                            c,
                            sx - 3 - q * 16,
                            y - 2 - q * 4,
                            2 + q * 4,
                            1 + q * 2,
                            ("rgba(210,190,150," .. tostring((1 - q) * 0.45)) .. ")"
                        )
                        i = i + 1
                    end
                end
            end
        end
        if __lt(
            night(nil, s),
            0.6
        ) then
            do
                local i = 0
                while i < 7 do
                    local x = 200 + i * 170 + math.sin(t * 0.2 + i) * 10
                    local y = M:morro(x, 1) + 14 + __mod(i, 3) * 9
                    local sx = scr(nil, M, x, camL)
                    if __t(vis(nil, sx, 10)) then
                        pessoinha(
                            nil,
                            c,
                            sx,
                            y,
                            i + 2,
                            t,
                            false
                        )
                        R(
                            nil,
                            c,
                            sx - 1,
                            y - 11,
                            5,
                            1,
                            "#d8b878"
                        )
                        R(
                            nil,
                            c,
                            sx + (math.sin(t * 3 + i) > 0 and 3 or -2),
                            y - 6,
                            2,
                            1,
                            __get(
                                SKIN,
                                __mod(i, 5)
                            )
                        )
                    end
                    i = i + 1
                end
            end
        end
        do
            local i = 0
            while i < 5 do
                local x = 900 + i * 22 + math.sin(t * 0.1 + i * 2) * 12
                local y = M:morro(x, 0) + 22 + __mod(i, 2) * 4
                local sx = scr(nil, M, x, camL)
                if __t(vis(nil, sx, 10)) then
                    R(
                        nil,
                        c,
                        sx,
                        y - 4,
                        7,
                        3,
                        "#f2efe6"
                    )
                    R(
                        nil,
                        c,
                        sx + 2,
                        y - 4,
                        2,
                        2,
                        "#2a2a2a"
                    )
                    R(
                        nil,
                        c,
                        sx + (__t(__mod(i, 2)) and 6 or -1),
                        y - 5 + (math.sin(t + i) > 0.6 and 1 or 0),
                        2,
                        2,
                        "#f2efe6"
                    )
                    R(
                        nil,
                        c,
                        sx + 1,
                        y - 1,
                        1,
                        1,
                        "#2a2a2a"
                    )
                    R(
                        nil,
                        c,
                        sx + 5,
                        y - 1,
                        1,
                        1,
                        "#2a2a2a"
                    )
                end
                i = i + 1
            end
        end
    end
    local function meioParque(self, c, s, t, camL)
        local M = lazy(
            nil,
            19,
            function()
                local m = buildRua(
                    nil,
                    {
                        seed = 190,
                        base = 186,
                        f = __arrL({2, 5}, 2),
                        w = __arrL({24, 40}, 2),
                        gap = 2,
                        gapR = 10,
                        pal = __arrL({"#c8ccd4", "#b8b4a8", "#cfd6dc", "#c4bcae"}, 4),
                        lojas = LOJAS_RUA,
                        lojaIni = 7,
                        lojaChance = 0.6,
                        outdoors = 5,
                        outIni = 7,
                        nevoa = "rgba(40,50,90,.18)",
                        gente = 30
                    }
                )
                local c2 = m.cv:getContext("2d")
                local n2 = m.nv:getContext("2d")
                do
                    local k = 0
                    while k < 6 do
                        local bx = 940 + k * 34
                        R(
                            nil,
                            c2,
                            bx,
                            166,
                            30,
                            20,
                            pick(
                                nil,
                                __arrL({
                                    "#c43c3a",
                                    "#2c5a9e",
                                    "#e8c24c",
                                    "#3c8a5a",
                                    "#7a3a8a"
                                }, 5),
                                k
                            )
                        )
                        do
                            local j = 0
                            while j < 30 do
                                R(
                                    nil,
                                    c2,
                                    bx + j,
                                    166,
                                    2,
                                    3,
                                    "#f2efe6"
                                )
                                j = j + 4
                            end
                        end
                        R(
                            nil,
                            c2,
                            bx + 2,
                            172,
                            26,
                            10,
                            "#3a2a1a"
                        )
                        R(
                            nil,
                            n2,
                            bx + 2,
                            172,
                            26,
                            10,
                            "rgba(255,214,140,.8)"
                        )
                        k = k + 1
                    end
                end
                do
                    local x = 930
                    while x < 1150 do
                        local y = 160 + math.floor(math.sin((x - 930) / 220 * math.pi) * 6 + 0.5)
                        R(
                            nil,
                            c2,
                            x,
                            y,
                            1,
                            1,
                            "#3a3a36"
                        )
                        if __mod(x, 9) == 0 then
                            R(
                                nil,
                                n2,
                                x,
                                y + 1,
                                1,
                                1,
                                pick(
                                    nil,
                                    __arrL({"#ffe39a", "#ff8a8a", "#8ad0ff"}, 3),
                                    x
                                )
                            )
                        end
                        x = x + 3
                    end
                end
                pxText(
                    nil,
                    c2,
                    "FESTIVAL DE INVERNO",
                    1040,
                    150,
                    "#f2c94c",
                    {sombra = "#2a2a2a"}
                )
                return m
            end
        )
        local a = night(nil, s)
        if __gt(a, 0.2) then
            do
                local i = 0
                while i < 3 do
                    local per = 5 + i * 1.3
                    local ph = __mod(t + i * 2.1, per) / per
                    local bx = 80 + __mod(
                        math.floor((t + i * 2.1) / per) * 137 + i * 151,
                        320
                    )
                    local by = 30 + i * 12
                    if ph < 0.25 then
                        R(
                            nil,
                            c,
                            bx,
                            by + 60 * (1 - ph / 0.25),
                            1,
                            3,
                            "#f2e8c8"
                        )
                    else
                        local r = (ph - 0.25) * 50
                        local al = 1 - (ph - 0.25) / 0.75
                        local col = __get(
                            __arrL({"#ff6a6a", "#f2c94c", "#6ad0ff"}, 3),
                            i
                        )
                        c:save()
                        c.globalAlpha = al * a
                        do
                            local k = 0
                            while k < 12 do
                                local an = k / 12 * TAU
                                R(
                                    nil,
                                    c,
                                    bx + math.cos(an) * r,
                                    by + math.sin(an) * r * 0.9,
                                    2,
                                    2,
                                    col
                                )
                                k = k + 1
                            end
                        end
                        c:restore()
                    end
                    i = i + 1
                end
            end
        end
        do
            local sx = scr(nil, {f = 0.2}, 620, camL)
            local cy = 92
            local r = 50
            local rot = t * 0.12
            if __t(vis(nil, sx, 70)) then
                R(
                    nil,
                    c,
                    sx - 1,
                    cy,
                    3,
                    96,
                    "#5a5e66"
                )
                limb(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({sx, cy}, 2),
                            __arrL({sx - 30, 188}, 2)
                        },
                        2
                    ),
                    2,
                    "#5a5e66"
                )
                limb(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({sx, cy}, 2),
                            __arrL({sx + 30, 188}, 2)
                        },
                        2
                    ),
                    2,
                    "#5a5e66"
                )
                do
                    local k = 0
                    while k < 64 do
                        local an = k / 64 * TAU
                        R(
                            nil,
                            c,
                            sx + math.cos(an) * r,
                            cy + math.sin(an) * r,
                            2,
                            2,
                            "#8a8e98"
                        )
                        k = k + 1
                    end
                end
                do
                    local k = 0
                    while k < 12 do
                        local an = rot + k / 12 * TAU
                        local ex = sx + math.cos(an) * r
                        local ey = cy + math.sin(an) * r
                        limb(
                            nil,
                            c,
                            __arrL(
                                {
                                    __arrL({sx, cy}, 2),
                                    __arrL({ex, ey}, 2)
                                },
                                2
                            ),
                            1,
                            "#7a7e88"
                        )
                        R(
                            nil,
                            c,
                            ex - 3,
                            ey + 1,
                            7,
                            6,
                            pick(
                                nil,
                                __arrL({"#c43c3a", "#2c5a9e", "#e8c24c", "#3c8a5a"}, 4),
                                k
                            )
                        )
                        R(
                            nil,
                            c,
                            ex - 2,
                            ey + 2,
                            5,
                            2,
                            "#f6e8b8"
                        )
                        if __t(__gt(a, 0.2) and __mod(
                            k + math.floor(t * 3),
                            3
                        ) == 0) then
                            R(
                                nil,
                                c,
                                ex,
                                ey,
                                2,
                                2,
                                "#fff2c0"
                            )
                        end
                        k = k + 1
                    end
                end
                ell(
                    nil,
                    c,
                    sx,
                    cy,
                    4,
                    4,
                    "#c8ccd4"
                )
            end
        end
        tile(nil, c, M.cv, camL * M.f)
        noiteTile(
            nil,
            c,
            s,
            M.nv,
            camL * M.f,
            1.2
        )
        andaRua(
            nil,
            c,
            M,
            s,
            t,
            camL
        )
    end
    local function meioCondominio(self, c, s, t, camL)
        local M = lazy(
            nil,
            21,
            function() return buildRua(
                nil,
                {
                    seed = 210,
                    base = 172,
                    f = __arrL({7, 14}, 2),
                    w = __arrL({30, 50}, 2),
                    gap = 3,
                    gapR = 14,
                    pal = __arrL({
                        "#f2efe6",
                        "#e9e6dc",
                        "#dfe4e6",
                        "#ece4d4",
                        "#d8dee6"
                    }, 5),
                    lojas = __arrL(
                        {
                            __get(LOJAS_RUA, 24),
                            __get(LOJAS_RUA, 1),
                            __get(LOJAS_RUA, 19),
                            __get(LOJAS_RUA, 21),
                            __get(LOJAS_RUA, 12),
                            __get(LOJAS_RUA, 10)
                        },
                        6
                    ),
                    lojaChance = 0.5,
                    outdoors = 6,
                    outIni = 1,
                    vidro = true,
                    gente = 18
                }
            ) end
        )
        tile(nil, c, M.cv, camL * M.f)
        noiteTile(
            nil,
            c,
            s,
            M.nv,
            camL * M.f
        )
        andaRua(
            nil,
            c,
            M,
            s,
            t,
            camL
        )
        for ____, p in __iterar((M.pos)) do
            do
                local sx = scr(nil, M, p.x, camL)
                if not __t(vis(nil, sx, 60)) then
                    continue
                end
                if p.nome == "SMART FAT" then
                    do
                        local k = 0
                        while k < math.floor((p.w - 8) / 9) do
                            local x = sx + 5 + k * 9
                            local f = __mod(
                                math.floor(t * 8 + k),
                                2
                            )
                            R(
                                nil,
                                c,
                                x - 1,
                                p.y + 15,
                                7,
                                1,
                                "#2a2a2a"
                            )
                            R(
                                nil,
                                c,
                                x + 1,
                                p.y + 15 - 2 - f,
                                1,
                                2,
                                "#2a2f3a"
                            )
                            R(
                                nil,
                                c,
                                x + 3,
                                p.y + 15 - 1 - (1 - f),
                                1,
                                1 + (1 - f),
                                "#2a2f3a"
                            )
                            R(
                                nil,
                                c,
                                x + 1,
                                p.y + 11,
                                3,
                                3,
                                pick(nil, ROUPA, k)
                            )
                            R(
                                nil,
                                c,
                                x + 1,
                                p.y + 10,
                                3,
                                1,
                                __get(
                                    SKIN,
                                    __mod(k, 5)
                                )
                            )
                            k = k + 1
                        end
                    end
                end
                if __t(p.nome == "PAGUE MAIS" and math.sin(t * 4) > -0.2) then
                    local x = sx + p.w - 6
                    R(
                        nil,
                        c,
                        x,
                        p.y - 8,
                        2,
                        6,
                        "#3ae06a"
                    )
                    R(
                        nil,
                        c,
                        x - 2,
                        p.y - 6,
                        6,
                        2,
                        "#3ae06a"
                    )
                end
            end
        end
    end
    local function letreiros(self, c, id, camL, nomes, t)
        local L = A:lojas(id)
        __call(
            L,
            "forEach",
            function(____, ____bindingPattern0, i)
                local w
                local x
                x = ____bindingPattern0[1]
                w = ____bindingPattern0[2]
                local sx = x - camL
                if not __t(vis(nil, sx, w + 10)) then
                    return
                end
                local nome = __get(
                    nomes,
                    __mod(
                        i,
                        __len(nomes)
                    )
                )
                local col = __get(nome, 1)
                R(
                    nil,
                    c,
                    sx + 2,
                    GY - 31,
                    w - 4,
                    11,
                    "#1c1f24"
                )
                vgrad(
                    nil,
                    c,
                    sx + 3,
                    GY - 30,
                    w - 6,
                    9,
                    shadeHex(nil, col, 1.2),
                    shadeHex(nil, col, 0.8)
                )
                R(
                    nil,
                    c,
                    sx + 3,
                    GY - 30,
                    w - 6,
                    1,
                    "rgba(255,255,255,.35)"
                )
                pxText(
                    nil,
                    c,
                    __get(nome, 0),
                    sx + w / 2,
                    GY - 28,
                    __get(nome, 2),
                    {sombra = "rgba(0,0,0,.35)"}
                )
                local ____t_75 = __t
                local ____t_result_74
                local ____t_73 = __t
                local ____temp_72 = __mod(i, 3) == 1
                __O[434] = ____temp_72
                if ____t_73(____temp_72) then
                    ____t_result_74 = __mod(
                        math.floor(t * 1.5 + i),
                        4
                    )
                else
                    ____t_result_74 = __O[434]
                end
                if ____t_75(____t_result_74) then
                    local nx = sx + w - 26
                    R(
                        nil,
                        c,
                        nx,
                        GY - 13,
                        20,
                        7,
                        "#1a1a1e"
                    )
                    pxText(
                        nil,
                        c,
                        "ABERTO",
                        nx + 10,
                        GY - 12,
                        "#ff5a8a"
                    )
                end
            end
        )
    end
    local function sobre(self, id, c, s, t, camL)
        if id == 14 then
            letreiros(
                nil,
                c,
                14,
                camL,
                LOJAS_RUA,
                t
            )
        elseif id == 16 then
            letreiros(
                nil,
                c,
                16,
                camL,
                __call(
                    __call(LOJAS_RUA, "slice", 14),
                    "concat",
                    __call(LOJAS_RUA, "slice", 0, 6)
                ),
                t
            )
            do
                local x = 620 - camL
                if __t(vis(nil, x, 130)) then
                    pxText(
                        nil,
                        c,
                        "MOTOTAXI?",
                        x + 60,
                        66,
                        "#2a2a2a",
                        {s = 2}
                    )
                    pxText(
                        nil,
                        c,
                        "SO NO PRECO JUSTO",
                        x + 60,
                        82,
                        "#5a3a10"
                    )
                    pxText(
                        nil,
                        c,
                        "LIGUE: TONHAO",
                        x + 60,
                        92,
                        "#c43c3a"
                    )
                    c:save()
                    c:translate(x + 2 - 0, 100 - GY)
                    A:moto(c, 0, "#f08a24")
                    c:restore()
                end
            end
            do
                local x = 2140 - camL
                if __t(vis(nil, x, 130)) then
                    pxText(
                        nil,
                        c,
                        "COMPRE UM",
                        x + 60,
                        64,
                        "#ffffff",
                        {s = 2, sombra = "#2c5a8a"}
                    )
                    pxText(
                        nil,
                        c,
                        "CASACO.",
                        x + 60,
                        76,
                        "#ffffff",
                        {s = 2, sombra = "#2c5a8a"}
                    )
                    pxText(
                        nil,
                        c,
                        "SERIO. AQUI FAZ 12°C",
                        x + 60,
                        92,
                        "#1d3a6a"
                    )
                    R(
                        nil,
                        c,
                        x + 6,
                        70,
                        12,
                        16,
                        "#7a3a3a"
                    )
                    R(
                        nil,
                        c,
                        x + 4,
                        72,
                        3,
                        12,
                        "#7a3a3a"
                    )
                    R(
                        nil,
                        c,
                        x + 17,
                        72,
                        3,
                        12,
                        "#7a3a3a"
                    )
                    R(
                        nil,
                        c,
                        x + 11,
                        70,
                        2,
                        16,
                        "#5a2a2a"
                    )
                end
            end
        elseif id == 13 then
            local x = A.BAIRRO.PEN + 82 - camL
            if __t(vis(nil, x, 30)) then
                local nt = night(nil, s)
                if __lt(nt, 0.5) then
                    R(
                        nil,
                        c,
                        x + 3,
                        112,
                        10,
                        14,
                        "#3a3026"
                    )
                    ell(
                        nil,
                        c,
                        x + 8,
                        116,
                        3,
                        3,
                        "#d9a57f"
                    )
                    R(
                        nil,
                        c,
                        x + 5,
                        112,
                        6,
                        3,
                        "#3a312c"
                    )
                    R(
                        nil,
                        c,
                        x + 4,
                        119,
                        9,
                        8,
                        "#7a5a8c"
                    )
                    local k = math.sin(t * 1.4)
                    R(
                        nil,
                        c,
                        x + 12,
                        121 + k,
                        7,
                        4,
                        "#3c8a5a"
                    )
                    R(
                        nil,
                        c,
                        x + 18,
                        122 + k,
                        3,
                        1,
                        "#3c8a5a"
                    )
                    if k > 0.2 then
                        do
                            local i = 0
                            while i < 3 do
                                R(
                                    nil,
                                    c,
                                    x + 21,
                                    125 + __mod(t * 30 + i * 4, 12),
                                    1,
                                    2,
                                    "#9fd0f0"
                                )
                                i = i + 1
                            end
                        end
                    end
                else
                    R(
                        nil,
                        c,
                        x + 4,
                        112,
                        8,
                        14,
                        "rgba(40,30,20,.55)"
                    )
                    ell(
                        nil,
                        c,
                        x + 8,
                        116,
                        3,
                        3,
                        "rgba(40,30,20,.6)"
                    )
                end
            end
        elseif id == 17 then
            local F = A.FEIRA
            do
                local i = 0
                local x = 16
                while x < F.W - 60 do
                    do
                        if __t(__call(
                            F.BISC,
                            "some",
                            function(____, b) return x > b - 74 and __lt(x, b + 124) end
                        )) then
                            do do i = i + 1 x = x + 92 end continue end
                        end
                        local sx = x - camL + 34
                        if not __t(vis(nil, sx, 20)) then
                            do do i = i + 1 x = x + 92 end continue end
                        end
                        local sk = __get(
                            SKIN,
                            __mod(i + 2, 5)
                        )
                        local sh = pick(nil, ROUPA, i * 3)
                        R(
                            nil,
                            c,
                            sx,
                            150,
                            7,
                            8,
                            sh
                        )
                        R(
                            nil,
                            c,
                            sx + 1,
                            143,
                            5,
                            6,
                            sk
                        )
                        R(
                            nil,
                            c,
                            sx + 1,
                            142,
                            5,
                            2,
                            pick(
                                nil,
                                __arrL({"#2a201a", "#1a1a1a", "#6a6a66"}, 3),
                                i
                            )
                        )
                        if __t(__mod(i, 2)) then
                            R(
                                nil,
                                c,
                                sx - 1,
                                140,
                                9,
                                2,
                                "#d8b878"
                            )
                        end
                        local ar = math.sin(t * 2.5 + i)
                        R(
                            nil,
                            c,
                            sx + 7,
                            151 + math.floor(ar * 2 + 0.5),
                            4,
                            2,
                            sk
                        )
                        if ar > 0.5 then
                            R(
                                nil,
                                c,
                                sx + 10,
                                150,
                                4,
                                5,
                                "#f2efe6"
                            )
                        end
                    end
                    do
                        i = i + 1
                        x = x + 92
                    end
                end
            end
        elseif id == 18 then
            for ____, ____value in __iterar((__arrL(
                {
                    __arrL({880, 0}, 2),
                    __arrL({1060, 1}, 2)
                },
                2
            ))) do
                local x0 = ____value[1]
                local k = ____value[2]
                do
                    local x = x0 + math.sin(t * 0.5 + k) * 26 - camL
                    if not __t(vis(nil, x, 30)) then
                        continue
                    end
                    local sw = math.sin(t * 2.6 + k)
                    gente(
                        nil,
                        c,
                        x,
                        205,
                        k + 3,
                        false
                    )
                    R(
                        nil,
                        c,
                        x - 1,
                        184,
                        8,
                        2,
                        "#d8b878"
                    )
                    limb(
                        nil,
                        c,
                        __arrL(
                            {
                                __arrL({x + 5, 194}, 2),
                                __arrL({x + 14 + sw * 4, 204}, 2)
                            },
                            2
                        ),
                        1,
                        "#8a6a45"
                    )
                    R(
                        nil,
                        c,
                        x + 10 + sw * 4,
                        204,
                        9,
                        2,
                        "#6a4a32"
                    )
                end
            end
        elseif id == 21 then
            for ____, gx in __iterar((__arrL({300, 700}, 2))) do
                do
                    local x = gx - camL
                    if not __t(vis(nil, x, 60)) then
                        continue
                    end
                    local up = math.abs(math.sin(t * 1.8))
                    gente(
                        nil,
                        c,
                        x + 8,
                        206 - math.floor(up * 6 + 0.5),
                        7,
                        false
                    )
                    R(
                        nil,
                        c,
                        x + 6,
                        190,
                        2,
                        4 + math.floor(up * 2 + 0.5),
                        __get(SKIN, 1)
                    )
                    R(
                        nil,
                        c,
                        x + 13,
                        190,
                        2,
                        4 + math.floor(up * 2 + 0.5),
                        __get(SKIN, 1)
                    )
                    local l = math.sin(t * 3) * 4
                    gente(
                        nil,
                        c,
                        x + 34,
                        206,
                        2,
                        false
                    )
                    R(
                        nil,
                        c,
                        x + 33 + l,
                        204,
                        2,
                        4,
                        "#2a2f3a"
                    )
                    R(
                        nil,
                        c,
                        x + 37 - l,
                        204,
                        2,
                        4,
                        "#2a2f3a"
                    )
                end
            end
        elseif id == 12 then
            do
                local k = 0
                while k < 4 do
                    do
                        local j = 0
                        while j < 3 do
                            do
                                local x = 40 + k * 112 - 18 - j * 14 - camL
                                if __t(not __t(vis(nil, x, 20)) or __mod(k + j, 3) == 2) then
                                    do j = j + 1 continue end
                                end
                                local bob = math.floor(math.sin(t * 1.3 + k + j * 2) * 0.6 + 0.5)
                                pessoa(
                                    nil,
                                    c,
                                    x,
                                    208 + bob,
                                    k * 3 + j + 1
                                )
                                R(
                                    nil,
                                    c,
                                    x - 6,
                                    200,
                                    5,
                                    8,
                                    pick(
                                        nil,
                                        __arrL({"#2c4a6a", "#c43c3a", "#4a8a5a", "#7a3a8a"}, 4),
                                        k + j
                                    )
                                )
                                R(
                                    nil,
                                    c,
                                    x - 5,
                                    197,
                                    3,
                                    3,
                                    "#5a5a56"
                                )
                            end
                            j = j + 1
                        end
                    end
                    k = k + 1
                end
            end
        elseif id == 19 then
            local nt = night(nil, s)
            do
                local lx = 100
                while lx < A.CULTURA.W - 260 do
                    do
                        local x0 = lx - camL
                        local x1 = lx + 260 - camL
                        if __t(x1 < -10 or x0 > LW + 10) then
                            do lx = lx + 260 continue end
                        end
                        do
                            local x = x0
                            while x <= x1 do
                                local u = (x - x0) / 260
                                local y = 122 + math.floor(math.sin(u * math.pi) * 14 + 0.5)
                                R(
                                    nil,
                                    c,
                                    x,
                                    y,
                                    2,
                                    1,
                                    "#2a2a2a"
                                )
                                if __mod(
                                    math.floor(x - x0 + 0.5),
                                    12
                                ) == 0 then
                                    local ____R_82 = R
                                    local ____array_81 = __TS__SparseArrayNew(
                                        nil,
                                        c,
                                        x,
                                        y + 1,
                                        2,
                                        2
                                    )
                                    local ____t_result_80
                                    local ____t_79 = __t
                                    local ____t_result_78
                                    local ____t_77 = __t
                                    local ____gt_result_76 = __gt(nt, 0.2)
                                    __O[435] = ____gt_result_76
                                    if ____t_77(____gt_result_76) then
                                        ____t_result_78 = __mod(
                                            math.floor(t * 2) + math.floor(x - x0 + 0.5) / 12,
                                            3
                                        )
                                    else
                                        ____t_result_78 = __O[435]
                                    end
                                    if ____t_79(____t_result_78) then
                                        ____t_result_80 = pick(
                                            nil,
                                            __arrL({"#ffe39a", "#ff9a9a", "#9ad8ff", "#b8f0a0"}, 4),
                                            math.floor(x - x0 + 0.5) / 12
                                        )
                                    else
                                        ____t_result_80 = "#8a8478"
                                    end
                                    __TS__SparseArrayPush(____array_81, ____t_result_80)
                                    ____R_82(__TS__SparseArraySpread(____array_81))
                                end
                                x = x + 2
                            end
                        end
                    end
                    lx = lx + 260
                end
            end
        end
    end
    local POVO = {
        ["12"] = 12,
        ["13"] = 12,
        ["14"] = 20,
        ["16"] = 16,
        ["17"] = 18,
        ["19"] = 16,
        ["21"] = 14,
        ["15"] = 3
    }
    local TRILHA = __TS__New(
        Set,
        __arrL({15}, 1)
    )
    local function populacao(self, id, c, s, t, camL)
        local n = __get(POVO, id)
        if not __t(n) then
            return
        end
        local W = window.CampanhaCenarios:largura(id) / 2
        local AIR = A.AIR
        do
            local i = 0
            while __lt(i, n) do
                do
                    local dir = __t(__mod(i * 7 + id, 2)) and 1 or -1
                    local sp = 9 + hash(nil, i * 3 + id) * 9
                    local wx = wrap(
                        nil,
                        hash(nil, i * 11 + id) * W + t * sp * dir,
                        W
                    )
                    local sx = wx - camL
                    local ____t_89 = __t
                    local ____t_result_88
                    local ____t_84 = __t
                    local ____temp_83 = not __t(vis(nil, sx, 20))
                    __O[437] = ____temp_83
                    if ____t_84(____temp_83) then
                        ____t_result_88 = __O[437]
                    else
                        local ____t_result_87
                        local ____t_86 = __t
                        local ____temp_85 = id == 12 and wx > AIR.TAR - 10
                        __O[436] = ____temp_85
                        if ____t_86(____temp_85) then
                            ____t_result_87 = __lt(wx, AIR.GR + 10)
                        else
                            ____t_result_87 = __O[436]
                        end
                        ____t_result_88 = ____t_result_87
                    end
                    if ____t_89(____t_result_88) then
                        do i = i + 1 continue end
                    end
                    local y = 216 + (__mod(i, 3) == 0 and 1 or 0)
                    local k = i * 5 + id
                    local passo = __mod(
                        math.floor(t * 6 + i),
                        2
                    )
                    if __t(__call(TRILHA, "has", id)) then
                        gente(
                            nil,
                            c,
                            sx,
                            y,
                            k,
                            true
                        )
                        R(
                            nil,
                            c,
                            sx + (dir > 0 and -3 or 6),
                            y - 14,
                            3,
                            7,
                            "#c43c3a"
                        )
                        limb(
                            nil,
                            c,
                            __arrL(
                                {
                                    __arrL({sx + (dir > 0 and 7 or -1), y - 9}, 2),
                                    __arrL({sx + (dir > 0 and 10 or -4), y}, 2)
                                },
                                2
                            ),
                            1,
                            "#6a4a32"
                        )
                        do i = i + 1 continue end
                    end
                    if __mod(i, 3) == 0 then
                        pessoa(
                            nil,
                            c,
                            sx,
                            y,
                            k
                        )
                    else
                        gente(
                            nil,
                            c,
                            sx,
                            y,
                            k,
                            true
                        )
                    end
                    R(
                        nil,
                        c,
                        sx + 1 - passo,
                        y - 1,
                        2,
                        1,
                        "rgba(0,0,0,.2)"
                    )
                    local ____t_93 = __t
                    local ____temp_92 = __mod(i, 5) == 2
                    if ____temp_92 then
                        local ____gt_91 = __gt
                        local ____t_result_90
                        if __t(s.rain) then
                            ____t_result_90 = s.rain
                        else
                            ____t_result_90 = 0
                        end
                        ____temp_92 = ____gt_91(____t_result_90, 0.1)
                    end
                    if ____t_93(____temp_92) then
                        R(
                            nil,
                            c,
                            sx - 3,
                            y - 24,
                            12,
                            2,
                            pick(
                                nil,
                                __arrL({"#2a2a2a", "#c43c3a", "#3c6aa8"}, 3),
                                i
                            )
                        )
                        R(
                            nil,
                            c,
                            sx + 2,
                            y - 23,
                            1,
                            8,
                            "#5a5a56"
                        )
                    elseif __mod(i, 7) == 3 then
                        R(
                            nil,
                            c,
                            sx + (dir > 0 and 6 or -2),
                            y - 16,
                            2,
                            3,
                            "#1c1c24"
                        )
                        R(
                            nil,
                            c,
                            sx + (dir > 0 and 6 or -2),
                            y - 16,
                            2,
                            1,
                            "#5ab8e8"
                        )
                    elseif __mod(i, 9) == 4 then
                        local cx = sx + (dir > 0 and 10 or -14)
                        cachorro(
                            nil,
                            c,
                            cx,
                            y,
                            pick(
                                nil,
                                __arrL({"#c98a43", "#f2efe6", "#2a2a2a"}, 3),
                                i
                            )
                        )
                        limb(
                            nil,
                            c,
                            __arrL(
                                {
                                    __arrL({sx + 3, y - 10}, 2),
                                    __arrL({cx + (dir > 0 and 2 or 12), y - 8}, 2)
                                },
                                2
                            ),
                            1,
                            "#c43c3a"
                        )
                    elseif __mod(i, 11) == 6 then
                        pessoa(
                            nil,
                            c,
                            sx + (dir > 0 and -8 or 8),
                            y,
                            k + 1
                        )
                        R(
                            nil,
                            c,
                            sx + (dir > 0 and -4 or 7),
                            y - 11,
                            4,
                            1,
                            __get(
                                SKIN,
                                __mod(i, 5)
                            )
                        )
                    end
                end
                i = i + 1
            end
        end
    end
    local JAM = {
        ["14"] = __ord({fusca = 2080, lane = 245}, "fusca,lane"),
        ["16"] = __ord({fusca = 930, lane = 245}, "fusca,lane")
    }
    local CHANCE = 0.4
    local jamOn = {}
    local forcado = {}
    local ultima = 0
    local ultimoT = 0
    local chegada = 0
    local function entrar(self, id)
        local now = window.performance:now()
        if __t(id ~= ultima or now - ultimoT > 2500) then
            chegada = now
            local ____t_97 = __t
            local ____t_result_96
            local ____t_95 = __t
            local ____get_result_94 = __get(JAM, id)
            __O[438] = ____get_result_94
            if ____t_95(____get_result_94) then
                ____t_result_96 = not __t(__get(forcado, id))
            else
                ____t_result_96 = __O[438]
            end
            if ____t_97(____t_result_96) then
                __set(
                    jamOn,
                    id,
                    math.random() < CHANCE
                )
            end
        end
        ultima = id
        ultimoT = now
    end
    local function engarrafado(____, id)
        local ____t_101 = __t
        local ____t_result_100
        local ____t_99 = __t
        local ____get_result_98 = __get(JAM, id)
        __O[439] = ____get_result_98
        if ____t_99(____get_result_98) then
            ____t_result_100 = __get(jamOn, id)
        else
            ____t_result_100 = __O[439]
        end
        return not not ____t_101(____t_result_100)
    end
    local CORES = __arrL({
        "#c43c3a",
        "#f2f2ee",
        "#3c6aa8",
        "#2a2a2a",
        "#9aa0a6",
        "#e8c24c",
        "#3c8a5a",
        "#7a2a3a",
        "#d8d2c0"
    }, 9)
    local function cabeca(self, c, x, y, sk, cabelo)
        R(
            nil,
            c,
            x,
            y,
            4,
            4,
            sk
        )
        R(
            nil,
            c,
            x,
            y - 1,
            4,
            2,
            cabelo
        )
    end
    local function carroG(self, c, x, y, col, kind, seed, t)
        local L = kind == "van" and 58 or (kind == "pickup" and 60 or (kind == "sedan" and 58 or 52))
        local vib = __t(__mod(
            math.floor(t * 14 + seed),
            2
        )) and 0 or 1
        local yy = y - vib * 0
        R(
            nil,
            c,
            x + 3,
            y,
            L - 6,
            2,
            "rgba(0,0,0,.28)"
        )
        R(
            nil,
            c,
            x,
            yy - 13,
            L,
            10,
            col
        )
        R(
            nil,
            c,
            x + 1,
            yy - 13,
            L - 2,
            1,
            shadeHex(nil, col, 1.3)
        )
        R(
            nil,
            c,
            x,
            yy - 5,
            L,
            2,
            shadeHex(nil, col, 0.7)
        )
        R(
            nil,
            c,
            x + 2,
            yy - 9,
            L - 4,
            1,
            shadeHex(nil, col, 0.85)
        )
        if kind == "van" then
            R(
                nil,
                c,
                x + 2,
                yy - 24,
                L - 10,
                11,
                col
            )
            R(
                nil,
                c,
                x + 2,
                yy - 24,
                L - 10,
                1,
                shadeHex(nil, col, 1.3)
            )
            do
                local k = 0
                while k < 3 do
                    R(
                        nil,
                        c,
                        x + 6 + k * 14,
                        yy - 22,
                        11,
                        6,
                        "#7a9aaa"
                    )
                    k = k + 1
                end
            end
            R(
                nil,
                c,
                x + L - 10,
                yy - 20,
                6,
                7,
                "#9fc4d0"
            )
        elseif kind == "pickup" then
            R(
                nil,
                c,
                x + L - 26,
                yy - 22,
                20,
                9,
                col
            )
            R(
                nil,
                c,
                x + L - 23,
                yy - 21,
                14,
                6,
                "#9fc4d0"
            )
            R(
                nil,
                c,
                x + 2,
                yy - 16,
                L - 30,
                3,
                shadeHex(nil, col, 0.8)
            )
            do
                local k = 0
                while k < 3 do
                    R(
                        nil,
                        c,
                        x + 6 + k * 8,
                        yy - 19,
                        6,
                        4,
                        pick(
                            nil,
                            __arrL({"#c49a6a", "#3c6aa8", "#e8c24c"}, 3),
                            seed + k
                        )
                    )
                    k = k + 1
                end
            end
        else
            local c0 = kind == "sedan" and 14 or 8
            R(
                nil,
                c,
                x + c0,
                yy - 21,
                30,
                8,
                col
            )
            R(
                nil,
                c,
                x + c0 + 2,
                yy - 20,
                12,
                6,
                "#9fc4d0"
            )
            R(
                nil,
                c,
                x + c0 + 16,
                yy - 20,
                12,
                6,
                "#9fc4d0"
            )
            R(
                nil,
                c,
                x + c0 + 14,
                yy - 20,
                2,
                7,
                col
            )
            R(
                nil,
                c,
                x + c0 + 3,
                yy - 20,
                3,
                6,
                "rgba(255,255,255,.3)"
            )
        end
        R(
            nil,
            c,
            x + L - 3,
            yy - 11,
            3,
            2,
            "#fff2b0"
        )
        R(
            nil,
            c,
            x,
            yy - 11,
            2,
            3,
            "#e8433a"
        )
        R(
            nil,
            c,
            x + L - 1,
            yy - 6,
            2,
            3,
            "#c8ccd0"
        )
        R(
            nil,
            c,
            x - 1,
            yy - 6,
            2,
            3,
            "#c8ccd0"
        )
        for ____, wx in __iterar((__arrL({x + 10, x + L - 11}, 2))) do
            ell(
                nil,
                c,
                wx,
                y - 3,
                4.5,
                4.5,
                "#1c1c1c"
            )
            ell(
                nil,
                c,
                wx,
                y - 3,
                2,
                2,
                "#9aa0a6"
            )
        end
        return L
    end
    local function fusca(self, c, x, y, t)
        local col = "#7ab8d8"
        R(
            nil,
            c,
            x + 3,
            y,
            40,
            2,
            "rgba(0,0,0,.28)"
        )
        ell(
            nil,
            c,
            x + 22,
            y - 10,
            22,
            9,
            col
        )
        ell(
            nil,
            c,
            x + 20,
            y - 17,
            13,
            7,
            col
        )
        R(
            nil,
            c,
            x + 10,
            y - 20,
            9,
            5,
            "#9fc4d0"
        )
        R(
            nil,
            c,
            x + 21,
            y - 20,
            9,
            5,
            "#9fc4d0"
        )
        R(
            nil,
            c,
            x + 19,
            y - 21,
            2,
            7,
            col
        )
        ell(
            nil,
            c,
            x + 19,
            y - 22,
            10,
            2,
            shadeHex(nil, col, 1.2)
        )
        R(
            nil,
            c,
            x,
            y - 7,
            44,
            3,
            shadeHex(nil, col, 0.75)
        )
        ell(
            nil,
            c,
            x + 10,
            y - 3,
            4.5,
            4.5,
            "#1c1c1c"
        )
        ell(
            nil,
            c,
            x + 34,
            y - 3,
            4.5,
            4.5,
            "#1c1c1c"
        )
        ell(
            nil,
            c,
            x + 10,
            y - 3,
            2,
            2,
            "#c8ccd0"
        )
        ell(
            nil,
            c,
            x + 34,
            y - 3,
            2,
            2,
            "#c8ccd0"
        )
        local pisca = __t(__mod(
            math.floor(t * 3),
            2
        )) and "#ffb02a" or "#7a4a10"
        R(
            nil,
            c,
            x + 42,
            y - 11,
            2,
            2,
            pisca
        )
        R(
            nil,
            c,
            x,
            y - 11,
            2,
            2,
            pisca
        )
        R(
            nil,
            c,
            x + 41,
            y - 13,
            2,
            2,
            "#fff2b0"
        )
        cabeca(
            nil,
            c,
            x + 25,
            y - 19,
            "#d8a985",
            "#d0ccc4"
        )
        local din = math.sin(t * 2) > 0
        R(
            nil,
            c,
            x + 29,
            y - 15,
            5,
            2,
            "#d8a985"
        )
        if __t(din) then
            R(
                nil,
                c,
                x + 33,
                y - 17,
                4,
                3,
                "#7ac85a"
            )
        end
        local vx = x + 47
        R(
            nil,
            c,
            vx,
            y - 2,
            2,
            2,
            "#2a2f3a"
        )
        R(
            nil,
            c,
            vx + 4,
            y - 2,
            2,
            2,
            "#2a2f3a"
        )
        R(
            nil,
            c,
            vx,
            y - 12,
            6,
            10,
            "#2a2f3a"
        )
        R(
            nil,
            c,
            vx - 1,
            y - 24,
            8,
            12,
            "#f2efe6"
        )
        ell(
            nil,
            c,
            vx + 3,
            y - 27,
            3,
            3,
            "#9a6440"
        )
        R(
            nil,
            c,
            vx,
            y - 31,
            7,
            3,
            "#e8c24c"
        )
        R(
            nil,
            c,
            vx - 10,
            y - 20,
            12,
            2,
            "#8a6a45"
        )
        do
            local k = 0
            while k < 4 do
                ell(
                    nil,
                    c,
                    vx - 8 + k * 3,
                    y - 21,
                    1.5,
                    1.5,
                    "#f6ecd0"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            vx + 8,
            y - 8,
            7,
            8,
            "#eef4f6"
        )
        R(
            nil,
            c,
            vx + 8,
            y - 8,
            7,
            2,
            "#3e7cc0"
        )
    end
    local function balao(self, c, x, y, txt, cor)
        if cor == nil then
            cor = "#1c1c22"
        end
        local s = limpa(nil, txt)
        local lines = __arrL({}, 0)
        local cur = ""
        for ____, w in __iterar((__call(s, "split", " "))) do
            local ____t_105 = __t
            local ____t_result_104
            local ____t_103 = __t
            local ____temp_102 = __len(__call(
                __add(
                    __add(cur, " "),
                    w
                ),
                "trim"
            )) > 17
            __O[440] = ____temp_102
            if ____t_103(____temp_102) then
                ____t_result_104 = cur
            else
                ____t_result_104 = __O[440]
            end
            if ____t_105(____t_result_104) then
                __call(lines, "push", cur)
                cur = w
            else
                cur = __call(
                    __add(
                        __add(cur, " "),
                        w
                    ),
                    "trim"
                )
            end
        end
        if __t(cur) then
            __call(lines, "push", cur)
        end
        local w = math.max(__TS__Spread(__iter(__call(
            lines,
            "map",
            function(____, l) return largura(nil, l) end
        )))) + 8
        local h = __len(lines) * 7 + 5
        local bx = math.floor(math.max(
            2,
            math.min(LW - w - 2, x - w / 2)
        ) + 0.5)
        local by = math.floor(y - h - 5 + 0.5)
        R(
            nil,
            c,
            bx + 1,
            by,
            w - 2,
            h,
            cor
        )
        R(
            nil,
            c,
            bx,
            by + 1,
            w,
            h - 2,
            cor
        )
        R(
            nil,
            c,
            bx + 2,
            by + 1,
            w - 4,
            h - 2,
            "#fbf8ef"
        )
        R(
            nil,
            c,
            bx + 1,
            by + 2,
            w - 2,
            h - 4,
            "#fbf8ef"
        )
        local tx = math.floor(math.max(
            bx + 4,
            math.min(bx + w - 6, x)
        ) + 0.5)
        R(
            nil,
            c,
            tx,
            by + h - 1,
            4,
            2,
            "#fbf8ef"
        )
        R(
            nil,
            c,
            tx - 1,
            by + h - 1,
            1,
            3,
            cor
        )
        R(
            nil,
            c,
            tx + 4,
            by + h - 1,
            1,
            2,
            cor
        )
        R(
            nil,
            c,
            tx + 1,
            by + h + 1,
            2,
            2,
            "#fbf8ef"
        )
        R(
            nil,
            c,
            tx + 3,
            by + h + 1,
            1,
            2,
            cor
        )
        R(
            nil,
            c,
            tx + 1,
            by + h + 3,
            2,
            1,
            cor
        )
        __call(
            lines,
            "forEach",
            function(____, l, i) return pxText(
                nil,
                c,
                l,
                bx + w / 2,
                by + 3 + i * 7,
                "#2a2a2a"
            ) end
        )
    end
    local FALAS = __arrL(
        {
            __arrL({"c", "ANDA, CRIATURA!"}, 2),
            __arrL({"r", "BUZINA MAIS, CLEITON!"}, 2),
            __arrL({"a", "CALMA! É SÓ UM PACOTINHO!"}, 2),
            __arrL({"v", "BISCOITO QUENTINHO! 3 POR 5!"}, 2),
            __arrL({"c", "TÁ VERDE, MEU REI!"}, 2),
            __arrL({"r", "VOU PERDER MINHA CONSULTA!"}, 2),
            __arrL({"c", "EU TENHO CORRIDA NO SHOPPING!"}, 2),
            __arrL({"r", "EU AVISEI PRA IR PELA OLÍVIA!"}, 2),
            __arrL({"a", "QUER UM TAMBÉM, MOÇO?"}, 2),
            __arrL({"c", "QUERO É QUE O SENHOR ANDE!"}, 2)
        },
        10
    )
    local PERTO = __arrL(
        {
            __arrL({"c", "Ô DA ROÇA! EMPURRA ESSE FUSCA AÍ!"}, 2),
            __arrL({"r", "MOÇO, TEM BISCOITO SOBRANDO?"}, 2)
        },
        2
    )
    local function engarrafamento(self, id, c, s, t, camL)
        local J = __get(JAM, id)
        local y = J.lane
        local fx = J.fusca
        local cx = fx - 66
        local hx = HERO(nil).x / 2
        do
            local i = 0
            while i < 2 do
                local wx = wrap(nil, i * 1400 - t * 40, 3000) - 200
                local sx = wx - camL
                if __t(vis(nil, sx, 60)) then
                    carroG(
                        nil,
                        c,
                        sx,
                        267,
                        pick(nil, CORES, i + 3),
                        __t(i) and "sedan" or "hatch",
                        i,
                        t
                    )
                end
                i = i + 1
            end
        end
        local ____call_110 = __call
        local ____t_result_109
        local ____t_108 = __t
        local ____opt_106 = window.CampanhaCenarios:layout(id)
        if ____opt_106 ~= nil then
            ____opt_106 = ____opt_106.gaps
        end
        __O[441] = ____opt_106
        if ____t_108(____opt_106) then
            ____t_result_109 = __O[441]
        else
            ____t_result_109 = __arrL({}, 0)
        end
        local vaos = ____call_110(
            ____t_result_109,
            "map",
            function(____, ____bindingPattern0)
                local gw
                local gx
                gx = ____bindingPattern0[1]
                gw = ____bindingPattern0[2]
                return __arrL(
                    {
                        gx / 2 - 4,
                        __add(gx, gw) / 2 + 4
                    },
                    2
                )
            end
        )
        do
            local k = 1
            while k < 26 do
                do
                    local x = cx - k * 64 - math.floor(hash(nil, k + id) * 6 + 0.5)
                    local sx = x - camL
                    local ____t_114 = __t
                    local ____t_result_113
                    local ____t_112 = __t
                    local ____temp_111 = not __t(vis(nil, sx, 70))
                    __O[442] = ____temp_111
                    if ____t_112(____temp_111) then
                        ____t_result_113 = __O[442]
                    else
                        ____t_result_113 = __call(
                            vaos,
                            "some",
                            function(____, ____bindingPattern0)
                                local b
                                local a
                                a = ____bindingPattern0[1]
                                b = ____bindingPattern0[2]
                                return __gt(x + 60, a) and __lt(x, b)
                            end
                        )
                    end
                    if ____t_114(____t_result_113) then
                        do k = k + 1 continue end
                    end
                    local kind = pick(
                        nil,
                        __arrL({
                            "hatch",
                            "sedan",
                            "pickup",
                            "van",
                            "hatch"
                        }, 5),
                        k * 3 + id
                    )
                    local col = pick(nil, CORES, k + id)
                    local L = carroG(
                        nil,
                        c,
                        sx,
                        y,
                        col,
                        kind,
                        k,
                        t
                    )
                    if kind ~= "pickup" then
                        local ____cabeca_118 = cabeca
                        local ____c_117 = c
                        local ____temp_116
                        if kind == "sedan" then
                            ____temp_116 = 34
                        else
                            local ____temp_115
                            if kind == "van" then
                                ____temp_115 = L - 9
                            else
                                ____temp_115 = 28
                            end
                            ____temp_116 = ____temp_115
                        end
                        ____cabeca_118(
                            nil,
                            ____c_117,
                            sx + ____temp_116,
                            y - 19,
                            pick(nil, SKIN, k),
                            pick(
                                nil,
                                __arrL({"#2a201a", "#1a1a1a", "#6a4a2a", "#c8a050"}, 4),
                                k
                            )
                        )
                    end
                    do
                        local i = 0
                        while i < 2 do
                            local q = __mod(t * 1.2 + i / 2 + k * 0.3, 1)
                            ell(
                                nil,
                                c,
                                sx - 3 - q * 10,
                                y - 6 - q * 6,
                                1.5 + q * 3,
                                1 + q * 2,
                                ("rgba(200,200,200," .. tostring((1 - q) * 0.4)) .. ")"
                            )
                            i = i + 1
                        end
                    end
                    local slot = math.floor(t / 1.6 + k * 1.7)
                    if __gt(
                        hash(nil, slot * 13 + k),
                        0.82
                    ) then
                        pxText(
                            nil,
                            c,
                            __gt(
                                hash(nil, slot + k),
                                0.5
                            ) and "BI-BI!" or "FOM!",
                            sx + L / 2,
                            y - 34,
                            "#f2c94c",
                            {sombra = "#2a2a2a"}
                        )
                    end
                end
                k = k + 1
            end
        end
        do
            local mx = wrap(nil, t * 30, 1600) + fx - 1640
            local sx = mx - camL
            if __t(vis(nil, sx, 30)) then
                c:save()
                c:translate(0, y + 9 - GY)
                A:moto(c, sx, "#f08a24")
                R(
                    nil,
                    c,
                    sx + 7,
                    GY - 22,
                    6,
                    8,
                    "#f08a24"
                )
                R(
                    nil,
                    c,
                    sx + 8,
                    GY - 27,
                    5,
                    5,
                    "#c9372f"
                )
                c:restore()
            end
        end
        local sx = cx - camL
        if __t(vis(nil, sx, 140)) then
            carroG(
                nil,
                c,
                sx,
                y,
                "#b8bec4",
                "hatch",
                99,
                t
            )
            pxText(
                nil,
                c,
                "UBE",
                sx + 24,
                y - 11,
                "#2a2a2a"
            )
            cabeca(
                nil,
                c,
                sx + 13,
                y - 19,
                "#e3b48f",
                "#7a4a34"
            )
            do
                local k = 0
                while k < 3 do
                    R(
                        nil,
                        c,
                        sx + 13 + k * 2,
                        y - 21,
                        1,
                        1,
                        "#f08ab0"
                    )
                    k = k + 1
                end
            end
            R(
                nil,
                c,
                sx + 15,
                y - 18,
                3,
                1,
                "#5a3a8a"
            )
            if __t(__mod(
                math.floor(t * 4),
                2
            )) then
                R(
                    nil,
                    c,
                    sx + 16,
                    y - 16,
                    1,
                    1,
                    "#7a2a2a"
                )
            end
            cabeca(
                nil,
                c,
                sx + 28,
                y - 19,
                "#b47a50",
                "#1c1612"
            )
            R(
                nil,
                c,
                sx + 27,
                y - 21,
                6,
                2,
                "#1e2a36"
            )
            R(
                nil,
                c,
                sx + 32,
                y - 20,
                2,
                1,
                "#e8c24c"
            )
            R(
                nil,
                c,
                sx + 29,
                y - 16,
                3,
                1,
                "#1c1612"
            )
            R(
                nil,
                c,
                sx + 31,
                y - 18,
                1,
                1,
                "#1c1612"
            )
            local sh = math.sin(t * 9)
            limb(
                nil,
                c,
                __arrL(
                    {
                        __arrL({sx + 33, y - 14}, 2),
                        __arrL({sx + 40, y - 19 + sh * 2}, 2),
                        __arrL({sx + 42, y - 25 + sh * 3}, 2)
                    },
                    3
                ),
                2,
                "#b47a50"
            )
            R(
                nil,
                c,
                sx + 41,
                y - 28 + sh * 3,
                3,
                3,
                "#b47a50"
            )
            fusca(
                nil,
                c,
                fx - camL,
                y,
                t
            )
            local near = math.abs(hx - (cx + 26)) < 80
            local ____t_result_119
            if __t(near) then
                ____t_result_119 = PERTO
            else
                ____t_result_119 = FALAS
            end
            local seq = ____t_result_119
            local step = math.floor(t / 2.6)
            local quem, fala = table.unpack(
                __get(
                    seq,
                    __mod(
                        step,
                        __len(seq)
                    )
                ),
                1,
                2
            )
            local ____t_123 = __t
            local ____t_result_122
            local ____t_121 = __t
            local ____temp_120 = quem == "c"
            __O[443] = ____temp_120
            if ____t_121(____temp_120) then
                ____t_result_122 = __mod(
                    math.floor(t * 5),
                    2
                )
            else
                ____t_result_122 = __O[443]
            end
            if ____t_123(____t_result_122) then
                do
                    local k = 0
                    while k < 3 do
                        R(
                            nil,
                            c,
                            sx + 54 + k * 2,
                            y - 14 - k * 2,
                            1,
                            4 + k * 2,
                            "#f2c94c"
                        )
                        k = k + 1
                    end
                end
                pxText(
                    nil,
                    c,
                    "BEEE!",
                    sx + 60,
                    y - 30,
                    "#f2c94c",
                    {sombra = "#2a2a2a", align = "left"}
                )
            end
            local px = __get({c = sx + 30, r = sx + 15, a = fx - camL + 27, v = fx - camL + 50}, quem)
            local py = __get({c = y - 24, r = y - 24, a = y - 24, v = y - 34}, quem)
            balao(
                nil,
                c,
                px,
                py,
                fala
            )
            if __t(near) then
                pxText(
                    nil,
                    c,
                    "CLEITON",
                    sx + 34,
                    y + 4,
                    "#f2c94c",
                    {sombra = "#2a2a2a"}
                )
                pxText(
                    nil,
                    c,
                    "DONA ROSILDA",
                    sx + 4,
                    y + 10,
                    "#f08ab0",
                    {sombra = "#2a2a2a"}
                )
            end
        end
    end
    local function frente(self, id, c, s, t, camL)
        if __t(not (POVO[id] ~= nil) and not __t(__get(JAM, id))) then
            return
        end
        populacao(
            nil,
            id,
            c,
            s,
            t,
            camL
        )
        if __t(engarrafado(nil, id)) then
            engarrafamento(
                nil,
                id,
                c,
                s,
                t,
                camL
            )
        end
    end
    local FG = __ord(
        {
            cidade = __arrL({
                "arbusto",
                "grade",
                "flores",
                "hidrante",
                "sacos",
                "bike",
                "cone",
                "arbusto"
            }, 8),
            natureza = __arrL({
                "capim",
                "pedra",
                "samambaia",
                "capim",
                "flores",
                "cafe"
            }, 6),
            cafe = __arrL({
                "cafe",
                "capim",
                "cafe",
                "pedra",
                "cafe"
            }, 5),
            interno = __arrL({"cadeiras", "pilastra", "vaso", "cadeiras"}, 4)
        },
        "cidade,natureza,cafe,interno"
    )
    local FGSET = {
        ["12"] = "interno",
        ["13"] = "cidade",
        ["14"] = "cidade",
        ["15"] = "natureza",
        ["16"] = "cidade",
        ["17"] = "cidade",
        ["18"] = "cafe",
        ["19"] = "cidade",
        ["21"] = "cidade"
    }
    local PEC
    PEC = __ord(
        {
            arbusto = function(____, c, x, y)
                do
                    local k = 0
                    while k < 7 do
                        ell(
                            nil,
                            c,
                            x + k * 6,
                            y - 6 - __mod(k, 3) * 3,
                            7,
                            6,
                            __t(__mod(k, 2)) and "#2a4a26" or "#35582e"
                        )
                        k = k + 1
                    end
                end
                do
                    local k = 0
                    while k < 6 do
                        R(
                            nil,
                            c,
                            x + 2 + k * 6,
                            y - 12 - __mod(k, 2) * 3,
                            3,
                            1,
                            "#4f7a3e"
                        )
                        k = k + 1
                    end
                end
            end,
            grade = function(____, c, x, y)
                R(
                    nil,
                    c,
                    x,
                    y - 14,
                    70,
                    2,
                    "#1e2226"
                )
                R(
                    nil,
                    c,
                    x,
                    y - 4,
                    70,
                    2,
                    "#1e2226"
                )
                do
                    local k = 0
                    while k < 70 do
                        R(
                            nil,
                            c,
                            x + k,
                            y - 16,
                            2,
                            16,
                            "#262a2e"
                        )
                        R(
                            nil,
                            c,
                            x + k,
                            y - 18,
                            2,
                            2,
                            "#3a4046"
                        )
                        k = k + 5
                    end
                end
            end,
            flores = function(____, c, x, y)
                PEC:arbusto(c, x, y)
                do
                    local k = 0
                    while k < 9 do
                        R(
                            nil,
                            c,
                            x + 2 + k * 4.5,
                            y - 13 - __mod(k, 3) * 2,
                            2,
                            2,
                            pick(
                                nil,
                                __arrL({"#c84a5a", "#d8a83a", "#a85ab8", "#e8e2d2"}, 4),
                                k + x
                            )
                        )
                        k = k + 1
                    end
                end
            end,
            hidrante = function(____, c, x, y)
                R(
                    nil,
                    c,
                    x,
                    y - 16,
                    10,
                    16,
                    "#7a2422"
                )
                R(
                    nil,
                    c,
                    x - 2,
                    y - 18,
                    14,
                    3,
                    "#8a2c2a"
                )
                R(
                    nil,
                    c,
                    x - 3,
                    y - 11,
                    16,
                    3,
                    "#6a1e1c"
                )
                R(
                    nil,
                    c,
                    x + 2,
                    y - 16,
                    2,
                    14,
                    "#9a3a36"
                )
            end,
            sacos = function(____, c, x, y)
                ell(
                    nil,
                    c,
                    x + 8,
                    y - 6,
                    9,
                    7,
                    "#121418"
                )
                ell(
                    nil,
                    c,
                    x + 20,
                    y - 5,
                    7,
                    6,
                    "#1a1c22"
                )
                R(
                    nil,
                    c,
                    x + 6,
                    y - 14,
                    3,
                    3,
                    "#121418"
                )
                R(
                    nil,
                    c,
                    x + 5,
                    y - 9,
                    3,
                    1,
                    "#3a3c44"
                )
            end,
            bike = function(____, c, x, y)
                for ____, wx in __iterar((__arrL({x + 6, x + 30}, 2))) do
                    ell(
                        nil,
                        c,
                        wx,
                        y - 7,
                        7,
                        7,
                        "#16181c"
                    )
                    ell(
                        nil,
                        c,
                        wx,
                        y - 7,
                        5,
                        5,
                        "rgba(0,0,0,0)"
                    )
                    R(
                        nil,
                        c,
                        wx - 1,
                        y - 8,
                        2,
                        2,
                        "#5a5e66"
                    )
                end
                limb(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({x + 6, y - 7}, 2),
                            __arrL({x + 16, y - 16}, 2),
                            __arrL({x + 30, y - 7}, 2)
                        },
                        3
                    ),
                    2,
                    "#7a2a2a"
                )
                limb(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({x + 16, y - 16}, 2),
                            __arrL({x + 26, y - 17}, 2),
                            __arrL({x + 30, y - 7}, 2)
                        },
                        3
                    ),
                    2,
                    "#7a2a2a"
                )
                R(
                    nil,
                    c,
                    x + 13,
                    y - 19,
                    7,
                    2,
                    "#16181c"
                )
            end,
            cone = function(____, c, x, y)
                do
                    local k = 0
                    while k < 16 do
                        R(
                            nil,
                            c,
                            x + k * 0.35,
                            y - k,
                            12 - k * 0.7,
                            1,
                            __mod(k, 6) < 3 and "#a8501a" or "#d8d2c0"
                        )
                        k = k + 1
                    end
                end
                R(
                    nil,
                    c,
                    x - 3,
                    y - 2,
                    18,
                    2,
                    "#1e2226"
                )
            end,
            capim = function(____, c, x, y, seed, t)
                do
                    local k = 0
                    while k < 14 do
                        local h = 10 + hash(nil, seed + k) * 14
                        local sw = math.sin(t * 1.6 + k + seed) * 2
                        limb(
                            nil,
                            c,
                            __arrL(
                                {
                                    __arrL({x + k * 2, y}, 2),
                                    __arrL(
                                        {
                                            x + k * 2 + sw + (__t(__mod(k, 2)) and 2 or -2),
                                            y - h
                                        },
                                        2
                                    )
                                },
                                2
                            ),
                            1,
                            __t(__mod(k, 3)) and "#3f5a2a" or "#56703a"
                        )
                        k = k + 1
                    end
                end
            end,
            pedra = function(____, c, x, y)
                ell(
                    nil,
                    c,
                    x + 12,
                    y - 5,
                    14,
                    8,
                    "#4a4a44"
                )
                ell(
                    nil,
                    c,
                    x + 8,
                    y - 8,
                    8,
                    4,
                    "#5f5f56"
                )
                R(
                    nil,
                    c,
                    x + 4,
                    y - 10,
                    5,
                    1,
                    "#6f6f66"
                )
            end,
            samambaia = function(____, c, x, y)
                do
                    local k = 0
                    while k < 6 do
                        local a = -2.6 + k * 0.45
                        do
                            local j = 0
                            while j < 14 do
                                local px = x + 12 + math.cos(a) * j * 1.6
                                local py = y - math.abs(math.sin(a)) * j * 1.4
                                R(
                                    nil,
                                    c,
                                    px,
                                    py,
                                    2,
                                    1,
                                    "#2f5a2e"
                                )
                                if __t(__mod(j, 2)) then
                                    R(
                                        nil,
                                        c,
                                        px,
                                        py - 2,
                                        1,
                                        2,
                                        "#3f6a36"
                                    )
                                end
                                j = j + 1
                            end
                        end
                        k = k + 1
                    end
                end
            end,
            cafe = function(____, c, x, y)
                do
                    local k = 0
                    while k < 6 do
                        ell(
                            nil,
                            c,
                            x + k * 6,
                            y - 8 - __mod(k, 2) * 4,
                            7,
                            7,
                            __t(__mod(k, 2)) and "#1f3a22" or "#2a4a2c"
                        )
                        k = k + 1
                    end
                end
                do
                    local k = 0
                    while k < 7 do
                        R(
                            nil,
                            c,
                            x + 3 + k * 5,
                            y - 10 - __mod(k, 3) * 3,
                            2,
                            2,
                            __t(__mod(k, 2)) and "#8a1e1a" or "#a8302a"
                        )
                        k = k + 1
                    end
                end
            end,
            cadeiras = function(____, c, x, y)
                do
                    local k = 0
                    while k < 4 do
                        R(
                            nil,
                            c,
                            x + k * 13,
                            y - 18,
                            11,
                            12,
                            "#1f3a5a"
                        )
                        R(
                            nil,
                            c,
                            x + k * 13,
                            y - 18,
                            11,
                            1,
                            "#2f4a6a"
                        )
                        k = k + 1
                    end
                end
                R(
                    nil,
                    c,
                    x,
                    y - 6,
                    52,
                    3,
                    "#2a2e32"
                )
                R(
                    nil,
                    c,
                    x + 4,
                    y - 3,
                    2,
                    3,
                    "#2a2e32"
                )
                R(
                    nil,
                    c,
                    x + 46,
                    y - 3,
                    2,
                    3,
                    "#2a2e32"
                )
            end,
            pilastra = function(____, c, x, y)
                R(
                    nil,
                    c,
                    x,
                    y - 22,
                    3,
                    22,
                    "#5a5e64"
                )
                R(
                    nil,
                    c,
                    x + 40,
                    y - 22,
                    3,
                    22,
                    "#5a5e64"
                )
                R(
                    nil,
                    c,
                    x + 3,
                    y - 20,
                    37,
                    2,
                    "#2a3a6a"
                )
                R(
                    nil,
                    c,
                    x - 2,
                    y - 2,
                    7,
                    2,
                    "#3a3e44"
                )
                R(
                    nil,
                    c,
                    x + 38,
                    y - 2,
                    7,
                    2,
                    "#3a3e44"
                )
            end,
            vaso = function(____, c, x, y)
                R(
                    nil,
                    c,
                    x,
                    y - 10,
                    16,
                    10,
                    "#4a3a2e"
                )
                do
                    local k = 0
                    while k < 6 do
                        ell(
                            nil,
                            c,
                            x + 2 + k * 2.4,
                            y - 16 - __mod(k, 3) * 4,
                            4,
                            6,
                            __t(__mod(k, 2)) and "#24401e" or "#305028"
                        )
                        k = k + 1
                    end
                end
            end
        },
        "arbusto,grade,flores,hidrante,sacos,bike,cone,capim,pedra,samambaia,cafe,cadeiras,pilastra,vaso"
    )
    local fgCv = nil
    local fgC = nil
    local FGDRAW = {}
    local function primeiroPlano(self, ctx, o)
        local id = o.scene
        local ____t_result_127
        local ____t_125 = __t
        local ____get_result_124 = __get(
            FG,
            __get(FGSET, id)
        )
        __O[444] = ____get_result_124
        if ____t_125(____get_result_124) then
            ____t_result_127 = __O[444]
        else
            local ____t_result_126
            if __t(__get(FGDRAW, id)) then
                ____t_result_126 = __arrL({}, 0)
            else
                ____t_result_126 = nil
            end
            ____t_result_127 = ____t_result_126
        end
        local set = ____t_result_127
        local ____t_133 = __t
        local ____t_result_132
        local ____t_131 = __t
        local ____t_result_130
        local ____t_129 = __t
        local ____temp_128 = not __t(set)
        __O[445] = ____temp_128
        if ____t_129(____temp_128) then
            ____t_result_130 = __O[445]
        else
            ____t_result_130 = o.arena
        end
        __O[446] = ____t_result_130
        if ____t_131(____t_result_130) then
            ____t_result_132 = __O[446]
        else
            ____t_result_132 = o.room
        end
        if ____t_133(____t_result_132) then
            return
        end
        if not __t(fgCv) then
            do
                do
                    __O[447] = __iter(mk(nil, LW, LH))
                    fgCv = __get(__O[447], 0)
                end
                fgC = __get(__O[447], 1)
            end
            local ____ = __O[447]
        end
        local c = fgC
        local ____t_result_136
        local ____t_135 = __t
        local ____TS__Number_result_134 = __TS__Number(o.camera)
        __O[448] = ____TS__Number_result_134
        if ____t_135(____TS__Number_result_134) then
            ____t_result_136 = __O[448]
        else
            ____t_result_136 = 0
        end
        local cam = ____t_result_136
        local camL = cam / 2
        local ____t_result_139
        local ____t_138 = __t
        local ____TS__Number_result_137 = __TS__Number(o.time)
        __O[449] = ____TS__Number_result_137
        if ____t_138(____TS__Number_result_137) then
            ____t_result_139 = __O[449]
        else
            ____t_result_139 = 0
        end
        local t = ____t_result_139
        local k = 1.45
        local ____t_result_142
        local ____t_141 = __t
        local ____temp_140 = window.CampanhaCenarios:largura(id)
        __O[450] = ____temp_140
        if ____t_141(____temp_140) then
            ____t_result_142 = __O[450]
        else
            ____t_result_142 = 4000
        end
        local W = ____t_result_142 / 2 * k
        c:clearRect(0, 0, LW, LH)
        if __t(__len(set)) then
            do
                local i = 0
                local x = 60
                while x < W do
                    local sx = x - camL * k
                    if __t(sx > -90 and sx < LW + 10) then
                        __get(
                            PEC,
                            pick(nil, set, i * 7 + id)
                        )(
                            nil,
                            c,
                            math.floor(sx + 0.5),
                            LH + 2,
                            i * 13 + id,
                            t
                        )
                    end
                    x = x + (190 + hash(nil, i * 5 + id) * 260)
                    i = i + 1
                end
            end
        end
        local ____opt_143 = __get(FGDRAW, id)
        if ____opt_143 ~= nil then
            ____opt_143(nil, c, camL * k, t)
        end
        local ____t_result_151
        local ____t_150 = __t
        local ____opt_147 = window.DayTime
        if ____opt_147 ~= nil then
            ____opt_147 = ____opt_147.state
        end
        local ____opt_result_149
        if ____opt_147 ~= nil then
            ____opt_result_149 = ____opt_147(____opt_147)
        end
        __O[451] = ____opt_result_149
        if ____t_150(____opt_result_149) then
            ____t_result_151 = __O[451]
        else
            ____t_result_151 = {night = 0}
        end
        local s = ____t_result_151
        local a = night(nil, s)
        c:save()
        c.globalCompositeOperation = "source-atop"
        c.fillStyle = ("rgba(8,12,26," .. tostring(0.25 + a * 0.5)) .. ")"
        c:fillRect(0, 0, LW, LH)
        c:restore()
        ctx:save()
        ctx:translate(
            math.floor(cam + 0.5),
            0
        )
        ctx.imageSmoothingEnabled = false
        ctx:drawImage(
            fgCv,
            0,
            0,
            LW * 2,
            LH * 2
        )
        ctx:restore()
    end
    local function luzes(self, id, g, s, t, camL)
        local a = night(nil, s)
        if __lt(a, 0.05) then
            return
        end
        if __t(engarrafado(nil, id)) then
            local J = __get(JAM, id)
            local y = J.lane
            do
                local k = 0
                while k < 26 do
                    local x = J.fusca - 66 - k * 64 - camL
                    if __t(vis(nil, x, 60)) then
                        lightAdd(
                            nil,
                            x,
                            y - 10,
                            0.35 * a,
                            14
                        )
                        lightAdd(
                            nil,
                            x + 52,
                            y - 10,
                            0.3 * a,
                            22
                        )
                    end
                    k = k + 1
                end
            end
            if __t(__mod(
                math.floor(t * 3),
                2
            )) then
                lightAdd(
                    nil,
                    J.fusca - camL + 2,
                    y - 10,
                    0.6 * a,
                    20
                )
            end
        end
        if id == 19 then
            local sx = scr(nil, {f = 0.2}, 620, camL)
            if __t(vis(nil, sx, 80)) then
                lightAdd(
                    nil,
                    sx,
                    92,
                    0.5 * a,
                    70
                )
            end
        end
    end
    local MEIOFN = {
        ["12"] = meioPatio,
        ["13"] = meioEncosta,
        ["14"] = meioComercio,
        ["15"] = meioSerra,
        ["16"] = meioAvenida,
        ["17"] = meioMercado,
        ["18"] = meioCafezal,
        ["19"] = meioParque,
        ["21"] = meioCondominio
    }
    local function meio(self, id, c, s, t, camL)
        local f = __get(MEIOFN, id)
        if __t(f) then
            f(
                nil,
                c,
                s,
                t,
                camL
            )
        end
    end
    window.CampanhaCamadas = __ord(
        {
            meio = meio,
            sobre = sobre,
            frente = frente,
            luzes = luzes,
            entrar = entrar,
            primeiroPlano = primeiroPlano,
            falas = function() return nil end,
            engarrafado = engarrafado,
            engarrafamento = function(____, id, v)
                if not __t(__get(JAM, id)) then
                    return false
                end
                if __t(v == nil or v == nil) then
                    __del(forcado, id)
                    return engarrafado(nil, id)
                end
                __set(forcado, id, true)
                __set(
                    jamOn,
                    id,
                    not not __t(v)
                )
                return __get(jamOn, id)
            end,
            texto = pxText,
            configurar = function(____, id, o)
                if o == nil then
                    o = {}
                end
                if __t(o.povo) then
                    __set(POVO, id, o.povo)
                end
                if __t(o.fg) then
                    __set(FGSET, id, o.fg)
                end
                if __t(o.trilha) then
                    __call(TRILHA, "add", id)
                end
                if __t(o.pecas) then
                    __assign(PEC, o.pecas)
                end
                if __t(o.fgLista) then
                    __set(
                        FG,
                        __add("c", id),
                        o.fgLista
                    )
                    __set(
                        FGSET,
                        id,
                        __add("c", id)
                    )
                end
                if __t(o.fgDraw) then
                    __set(FGDRAW, id, o.fgDraw)
                end
            end,
            kit = __ord({
                pxText = pxText,
                largura = largura,
                pessoinha = pessoinha,
                carrinho = carrinho,
                janelaM = janelaM,
                lojaM = lojaM,
                outdoorM = outdoorM,
                predioM = predioM,
                arvoreM = arvoreM,
                nevoa = nevoa,
                buildRua = buildRua,
                noiteTile = noiteTile,
                andaRua = andaRua,
                scr = scr,
                wrap = wrap,
                balao = balao,
                carroG = carroG,
                cabeca = cabeca,
                LOJAS_RUA = LOJAS_RUA,
                OUTDOORS = OUTDOORS,
                SKIN = SKIN,
                ROUPA = ROUPA,
                T = T
            }, "pxText,largura,pessoinha,carrinho,janelaM,lojaM,outdoorM,predioM,arvoreM,nevoa,buildRua,noiteTile,andaRua,scr,wrap,balao,carroG,cabeca,LOJAS_RUA,OUTDOORS,SKIN,ROUPA,T"),
            lojas = function() return __call(
                LOJAS_RUA,
                "map",
                function(____, l) return __get(l, 0) end
            ) end,
            cenasComEngarrafamento = function() return __call(
                __keys(JAM),
                "map",
                __NumberV
            ) end
        },
        "meio,sobre,frente,luzes,entrar,primeiroPlano,falas,engarrafado,engarrafamento,texto,configurar,kit,lojas,cenasComEngarrafamento"
    )
end)(nil)
return ____exports
