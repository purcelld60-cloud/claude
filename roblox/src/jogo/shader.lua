--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __ord, __arrL, __iterar, __t, __get, __set, __add, __new = __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__set, __JSR.__add, __JSR.__new
local ____lualib = require(script.Parent.lualib_bundle)
local Error = ____lualib.Error
local RangeError = ____lualib.RangeError
local ReferenceError = ____lualib.ReferenceError
local SyntaxError = ____lualib.SyntaxError
local TypeError = ____lualib.TypeError
local URIError = ____lualib.URIError
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__Number = ____lualib.__TS__Number
local ____exports = {}
local __O = {};
(function()
    local descartar, place, show, hide, gl, glCanvas, prog, tex, broken, esperaAte, perdas, target, itemsCv, itemsCtx, lastApply, layoutAt, itemsUsed, watching
    function descartar(self)
        hide(nil)
        do
            pcall(function()
                if glCanvas ~= nil then
                    glCanvas:remove()
                end
            end)
        end
        glCanvas = nil
        gl = nil
        prog = nil
        tex = nil
        target = nil
        perdas = perdas + 1
        esperaAte = window.performance:now() + 1200
        if perdas > 6 then
            broken = true
        end
    end
    function place(self, el, cv)
        local cs = window:getComputedStyle(cv)
        local ____t_44 = __t
        local ____t_43 = __t
        local ____temp_42 = not __t(cv.offsetWidth) or cs.display == "none"
        __O[29] = ____temp_42
        if ____t_44(if ____t_43(____temp_42) then __O[29] else cs.visibility == "hidden") then
            el.style.display = "none"
            return
        end
        el.style.cssText = __add(
            ((((((("position:absolute;left:" .. tostring(cv.offsetLeft)) .. "px;top:") .. tostring(cv.offsetTop)) .. "px;width:") .. tostring(cv.offsetWidth)) .. "px;height:") .. tostring(cv.offsetHeight)) .. "px;margin:0;padding:0;border:0;pointer-events:none;",
            (((((((((((("object-fit:" .. cs.objectFit) .. ";object-position:") .. cs.objectPosition) .. ";image-rendering:") .. cs.imageRendering) .. ";transform:") .. if cs.transform == "none" then "none" else cs.transform) .. ";transform-origin:") .. cs.transformOrigin) .. ";border-radius:") .. cs.borderRadius) .. ";opacity:") .. cs.opacity
        )
    end
    function show(self, canvas, w, h)
        local now = window.performance:now()
        lastApply = now
        if not __t(itemsCv) then
            itemsCv = window.document:createElement("canvas")
            itemsCv.className = "shader-items"
            itemsCv:setAttribute("aria-hidden", "true")
            itemsCtx = itemsCv:getContext("2d")
        end
        if __t(itemsCv.width ~= w or itemsCv.height ~= h) then
            itemsCv.width = w
            itemsCv.height = h
        elseif __t(itemsUsed) then
            itemsCtx:clearRect(0, 0, w, h)
        end
        itemsUsed = false
        local ____t_47 = __t
        local ____t_46 = __t
        local ____temp_45 = target ~= canvas or glCanvas.nextSibling ~= itemsCv
        __O[30] = ____temp_45
        if ____t_47(if ____t_46(____temp_45) then __O[30] else canvas.nextSibling ~= glCanvas) then
            target = canvas
            canvas:after(glCanvas)
            glCanvas:after(itemsCv)
            layoutAt = 0
        end
        if __t(now - layoutAt > 300 or glCanvas.style.display == "none") then
            layoutAt = now
            place(nil, glCanvas, canvas)
            place(nil, itemsCv, canvas)
        else
            local op = window:getComputedStyle(canvas).objectPosition
            if op ~= glCanvas.style.objectPosition then
                glCanvas.style.objectPosition = op
                itemsCv.style.objectPosition = op
            end
        end
        if not __t(watching) then
            watching = true
            local watch
            watch = function()
                if window.performance:now() - lastApply > 90 then
                    hide(nil)
                    watching = false
                    return
                end
                window:requestAnimationFrame(watch)
            end
            window:requestAnimationFrame(watch)
        end
    end
    function hide(self)
        if __t(glCanvas) then
            glCanvas.style.display = "none"
        end
        if __t(itemsCv) then
            itemsCv.style.display = "none"
            if __t(itemsUsed) then
                itemsCtx:clearRect(0, 0, itemsCv.width, itemsCv.height)
                itemsUsed = false
            end
        end
        layoutAt = 0
    end
    local ____ = "use strict"
    gl = nil
    glCanvas = nil
    prog = nil
    tex = nil
    local loc = {}
    broken = false
    local VERT = "attribute vec2 p;varying vec2 uv;void main(){uv=vec2(p.x*.5+.5,.5-p.y*.5);gl_Position=vec4(p,0.,1.);}"
    local FRAG = "\nprecision mediump float;\nvarying vec2 uv;\nuniform sampler2D img;\nuniform vec2 res;\nuniform vec2 sun;\nuniform float rays;\nuniform float golden;\nuniform float rim;\nuniform float warm;\nuniform float t;\nuniform vec2 ldir;\nuniform float relief;\nuniform vec3 fogCol;\nuniform float fogY;\nuniform float fogAmt;\nuniform vec3 water;\nuniform float heat;\nuniform float night;\nuniform float wet;\nuniform float dof;\nfloat lum(vec3 c){return dot(c,vec3(.299,.587,.114));}\nfloat hash(vec2 p){return fract(sin(dot(p,vec2(127.1,311.7)))*43758.5453);}\nvec3 at(vec2 p){return texture2D(img,(floor(p)+.5)/res).rgb;}\nvec3 tap(vec2 o){return texture2D(img,uv+o/res).rgb;}\nvoid main(){\n  vec2 pix=floor(uv*res);\n  // calor: as linhas ondulam em passos inteiros de pixel\n  if(heat>0.&&uv.y>.12&&uv.y<.82){float w=sin(pix.y*.35+t*7.)*sin(pix.y*.09-t*2.3);pix.x+=floor(w*heat+.5);}\n  vec3 base=at(pix);\n  // reflexo na água: espelha o que está acima da linha d'água, com ondas\n  if(water.x>0.){float y0=water.y*res.y,y1=water.z*res.y;if(pix.y>y0&&pix.y<y1){float d=pix.y-y0;float wv=floor(sin(pix.y*.6+t*2.6)*1.5+sin(pix.x*.05+t)*.8+.5);vec3 r=at(vec2(pix.x+wv,y0-d*1.15-2.));float k=.34*(1.-d/(y1-y0));base=mix(base,r*vec3(.78,.9,1.02),k);}}\n  // relevo de luz: normal estimada pelo brilho dos pixels vizinhos (2 px = 1 pixel de arte)\n  if(relief>0.){float l0=lum(at(pix+vec2(-2.,0.))),l1=lum(at(pix+vec2(2.,0.))),l2=lum(at(pix+vec2(0.,-2.))),l3=lum(at(pix+vec2(0.,2.)));\n    vec3 n=normalize(vec3((l0-l1)*2.2,(l2-l3)*2.2,1.));vec3 L=normalize(vec3(ldir.x,ldir.y,.9));float sh=dot(n,L)-L.z;\n    base*=1.+relief*clamp(sh,-.6,.6);}\n  // brilho: vizinhos claros espalham luz\n  vec3 glow=vec3(0.);\n  for(int i=0;i<8;i++){float a=float(i)*.7854+.39;vec2 d=vec2(cos(a),sin(a));vec3 n1=tap(d*4.),n2=tap(d*11.);glow+=max(n1-.88,0.)*1.6+max(n2-.86,0.)*1.2;}\n  glow/=8.;\n  // raios volumétricos em direção ao sol (ou à lua)\n  vec3 shaft=vec3(0.);\n  if(rays>0.){vec2 dir=(sun-uv)/16.;vec2 s=uv;float decay=1.;float th=mix(.9,.8,golden);for(int i=0;i<16;i++){s+=dir;vec3 c=texture2D(img,s).rgb;float near=smoothstep(.55,.06,length((s-sun)*vec2(res.x/res.y,1.)));float b=max(lum(c)-th,0.)*step(s.y,.6)*near;shaft+=c*b*decay;decay*=mix(.905,.938,golden);}shaft=min(shaft*rays*(.5+golden*.9)*1.25,vec3(.32+golden*.2))*mix(vec3(1.),vec3(1.15,.82,.6),golden);}\n  vec3 col=base+glow*(.38+night*.4)+shaft;\n  // luz de contorno: a borda virada para o sol (onde o vizinho é céu claro) ganha um fio de luz quente\n  if(rim>0.){vec2 sd=(sun-uv)*res;sd=sd/max(length(sd),1.);vec3 n1=at(pix+floor(sd*2.+.5)),n2=at(pix+floor(sd*7.+.5));\n    float lb=lum(base),e=min(lum(n1),lum(n2))-lb;float edge=smoothstep(.09,.3,e)*smoothstep(.85,.45,lb)*smoothstep(.36,.58,min(lum(n1),lum(n2)));\n    col+=mix(vec3(1.,.92,.72),vec3(1.,.66,.38),golden)*edge*rim*(.34+.3*lum(n2));}\n  if(rays>0.){vec2 q=(uv-sun)*vec2(res.x/res.y,1.);float ang=atan(q.y,q.x),dist=length(q);\n    float bands=.55+.45*sin(ang*26.+t*.35)*sin(ang*11.-t*.22+1.3);float cone=smoothstep(1.25,.05,dist)*smoothstep(-.2,.6,q.y+.15);\n    col+=mix(vec3(1.,.9,.68),vec3(.7,.8,1.),night)*bands*cone*.1*rays;\n    vec2 cell=floor(uv*res/6.);float h=hash(cell+floor(t*.5));col+=vec3(1.,.95,.8)*step(.996,h)*sin(fract(t*.5)*3.1416)*(.6+.4*sin(t*3.+h*40.))*cone*.45*rays;\n    float d=distance(uv*vec2(res.x/res.y,1.),sun*vec2(res.x/res.y,1.));col+=mix(vec3(1.,.82,.55),vec3(.6,.7,1.),night)*exp(-d*5.)*.16*rays;}\n  // hora dourada: luz quente e rosada, sombras arroxeadas e um véu dourado perto do sol (estilo shader de Minecraft)\n  if(golden>0.){float l0=lum(col);col=mix(col,col*vec3(1.16,.9,.72),golden*.55*smoothstep(.15,.9,l0));col=mix(col,col*vec3(.92,.82,1.08),golden*.4*smoothstep(.5,.05,l0));\n    float d2=distance(uv*vec2(res.x/res.y,1.),sun*vec2(res.x/res.y,1.));col+=vec3(1.,.55,.3)*exp(-d2*2.2)*.22*golden;col+=vec3(.9,.35,.3)*smoothstep(.75,.2,uv.y)*smoothstep(.1,.5,uv.y)*.05*golden;}\n  // névoa na faixa do horizonte\n  if(fogAmt>0.){float f=smoothstep(fogY-.16,fogY,uv.y)*smoothstep(fogY+.12,fogY,uv.y);col=mix(col,fogCol,f*fogAmt);}\n  // profundidade de campo leve: só o céu bem distante (topo) amacia um pouco\n  if(dof>0.&&uv.y<.2){vec3 b=(at(pix+vec2(-2.,0.))+at(pix+vec2(2.,0.))+at(pix+vec2(0.,-2.))+at(pix+vec2(0.,2.)))*.25;col=mix(col,b+glow*.45,dof*smoothstep(.2,.02,uv.y));}\n  // chuva: tudo mais frio e com mais contraste\n  if(wet>0.){col=mix(col,col*vec3(.86,.93,1.04),wet);col=(col-.5)*(1.+wet*.08)+.5;}\n  // correção de cor: luzes quentes, sombras frias (mais azuladas à noite)\n  float l=lum(col);\n  col=mix(col,col*vec3(1.08,1.,.9),warm*smoothstep(.35,1.,l));\n  col=mix(col,col*vec3(.86,.95,1.1),smoothstep(.45,0.,l)*(.6+night*.3));\n  col=mix(vec3(lum(col)),col,1.1);\n  col=(col-.5)*1.07+.5;\n  col=col/(1.+max(col-1.,0.)*.6);\n  vec2 v=uv-.5;col*=1.-dot(v,v)*(.55+night*.25);\n  gl_FragColor=vec4(clamp(col,0.,1.),1.);\n}"
    local NAMES = __arrL({
        "img",
        "res",
        "sun",
        "rays",
        "golden",
        "rim",
        "warm",
        "t",
        "ldir",
        "relief",
        "fogCol",
        "fogY",
        "fogAmt",
        "water",
        "heat",
        "night",
        "wet",
        "dof"
    }, 18)
    local function init(self, w, h)
        do
            local function ____catch(e)
                broken = true
                gl = nil
                return true, false
            end
            local ____try, ____hasReturned, ____returnValue = pcall(function()
                glCanvas = window.document:createElement("canvas")
                glCanvas.width = w
                glCanvas.height = h
                glCanvas.className = "shader-layer"
                glCanvas:setAttribute("aria-hidden", "true")
                gl = glCanvas:getContext("webgl", {
                    alpha = false,
                    premultipliedAlpha = false,
                    preserveDrawingBuffer = false,
                    antialias = false,
                    powerPreference = "high-performance"
                })
                if not __t(gl) then
                    error(
                        Error(nil, "no webgl"),
                        0
                    )
                end
                glCanvas:addEventListener(
                    "webglcontextlost",
                    function(____, e)
                        e:preventDefault()
                        descartar(nil)
                    end,
                    false
                )
                local function sh(____, ____type, src)
                    local s = gl:createShader(____type)
                    gl:shaderSource(s, src)
                    gl:compileShader(s)
                    if not __t(gl:getShaderParameter(s, gl.COMPILE_STATUS)) then
                        error(
                            Error(
                                nil,
                                gl:getShaderInfoLog(s)
                            ),
                            0
                        )
                    end
                    return s
                end
                prog = gl:createProgram()
                gl:attachShader(
                    prog,
                    sh(nil, gl.VERTEX_SHADER, VERT)
                )
                gl:attachShader(
                    prog,
                    sh(nil, gl.FRAGMENT_SHADER, FRAG)
                )
                gl:linkProgram(prog)
                if not __t(gl:getProgramParameter(prog, gl.LINK_STATUS)) then
                    error(
                        Error(nil, "link"),
                        0
                    )
                end
                gl:useProgram(prog)
                local buf = gl:createBuffer()
                gl:bindBuffer(gl.ARRAY_BUFFER, buf)
                gl:bufferData(
                    gl.ARRAY_BUFFER,
                    __new(
                        "Float32Array",
                        __arrL({
                            -1,
                            -1,
                            1,
                            -1,
                            -1,
                            1,
                            1,
                            1
                        }, 8)
                    ),
                    gl.STATIC_DRAW
                )
                local p = gl:getAttribLocation(prog, "p")
                gl:enableVertexAttribArray(p)
                gl:vertexAttribPointer(
                    p,
                    2,
                    gl.FLOAT,
                    false,
                    0,
                    0
                )
                tex = gl:createTexture()
                gl:bindTexture(gl.TEXTURE_2D, tex)
                gl:texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.NEAREST)
                gl:texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.NEAREST)
                gl:texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_S, gl.CLAMP_TO_EDGE)
                gl:texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_T, gl.CLAMP_TO_EDGE)
                for ____, n in __iterar((NAMES)) do
                    __set(
                        loc,
                        n,
                        gl:getUniformLocation(prog, n)
                    )
                end
                return true, true
            end)
            if not ____try then
                ____hasReturned, ____returnValue = ____catch(____hasReturned)
            end
            if ____hasReturned then
                return ____returnValue
            end
        end
    end
    local function sky(self, camera)
        local ____opt_2 = window.DayTime
        if ____opt_2 ~= nil then
            ____opt_2 = ____opt_2.state
        end
        local ____opt_result_4
        if ____opt_2 ~= nil then
            ____opt_result_4 = ____opt_2(____opt_2)
        end
        local s = ____opt_result_4
        if not __t(s) then
            return nil
        end
        local ____t_6 = __t
        local ____TS__Number_result_5 = __TS__Number(camera)
        __O[21] = ____TS__Number_result_5
        local camL = math.floor(if ____t_6(____TS__Number_result_5) then __O[21] else 0 / 2)
        if s.sunT ~= nil then
            return {
                s = s,
                x = (40 + s.sunT * 400 - camL * 0.012) / 480,
                y = (168 - math.sin(s.sunT * math.pi) * 128) / 270,
                moon = false,
                lean = (0.5 - s.sunT) * 2,
                up = math.sin(s.sunT * math.pi)
            }
        end
        if s.moonT ~= nil then
            return {
                s = s,
                x = (50 + s.moonT * 380 - camL * 0.012) / 480,
                y = (150 - math.sin(s.moonT * math.pi) * 108) / 270,
                moon = true,
                lean = (0.5 - s.moonT) * 2,
                up = math.sin(s.moonT * math.pi)
            }
        end
        return {
            s = s,
            x = 0.5,
            y = -1,
            moon = true,
            lean = 0,
            up = 0
        }
    end
    local WATER = {["4"] = __arrL({260 / 540, 350 / 540}, 2)}
    local HOT = {["3"] = 1, ["5"] = 1, ["7"] = 0.7}
    esperaAte = 0
    perdas = 0
    local function apply(self, canvas, s)
        if s == nil then
            s = {}
        end
        local ____t_17 = __t
        local ____t_10 = __t
        local ____temp_9 = if __t(broken) then broken else not __t(canvas)
        __O[22] = ____temp_9
        local ____t_16 = __t
        local ____opt_13 = window.Graphics
        if ____opt_13 ~= nil then
            ____opt_13 = ____opt_13.isShader
        end
        local ____opt_result_15
        if ____opt_13 ~= nil then
            ____opt_result_15 = ____opt_13(____opt_13)
        end
        if ____t_17(if ____t_10(____temp_9) then __O[22] else not ____t_16(____opt_result_15)) then
            return false
        end
        if window.performance:now() < esperaAte then
            return false
        end
        local ____t_20 = __t
        local ____this_19
        ____this_19 = gl
        local ____opt_18 = ____this_19.isContextLost
        if ____opt_18 ~= nil then
            ____opt_18 = ____opt_18(____this_19)
        end
        if ____t_20(if __t(gl) then ____opt_18 else gl) then
            descartar(nil)
            return false
        end
        local w = canvas.width
        local h = canvas.height
        if not __t(gl) then
            if not __t(init(nil, w, h)) then
                return false
            end
        end
        if __t(glCanvas.width ~= w or glCanvas.height ~= h) then
            glCanvas.width = w
            glCanvas.height = h
        end
        show(nil, canvas, w, h)
        do
            local function ____catch(e)
                broken = true
                hide(nil)
                return true, false
            end
            local ____try, ____hasReturned, ____returnValue = pcall(function()
                gl:viewport(0, 0, w, h)
                gl:bindTexture(gl.TEXTURE_2D, tex)
                gl:texImage2D(
                    gl.TEXTURE_2D,
                    0,
                    gl.RGBA,
                    gl.RGBA,
                    gl.UNSIGNED_BYTE,
                    canvas
                )
                local scene = __TS__Number(s.scene)
                local outdoor = not not __t(s.outdoor)
                local ____t_22 = __t
                local ____TS__Number_result_21 = __TS__Number(s.time)
                __O[23] = ____TS__Number_result_21
                local t = if ____t_22(____TS__Number_result_21) then __O[23] else 0
                local k = if __t(s.sun) then nil else sky(nil, s.camera)
                local night = if __t(k) then k.s.night else 0
                local ____t_28 = __t
                local ____opt_25 = window.Weather
                if ____opt_25 ~= nil then
                    ____opt_25 = ____opt_25.state
                end
                local ____opt_result_27
                if ____opt_25 ~= nil then
                    ____opt_result_27 = ____opt_25(____opt_25)
                end
                __O[24] = ____opt_result_27
                local wx = if ____t_28(____opt_result_27) then __O[24] else {}
                local sunX = if __t(s.sun) then __get(s.sun, 0) else if __t(k) then k.x else 0.76
                local sunY = if __t(s.sun) then __get(s.sun, 1) else if __t(k) then k.y else 0.18
                local rays = if __t(outdoor) then if __t(if __t(k) then k.y < 0 else k) then 0 else if __t(if __t(k) then k.moon else k) then 0.45 else if scene == 3 then 1.15 else 1 else 0
                rays = rays * (1 - if __t(wx.rain) then wx.rain else 0 * 0.85 - if __t(wx.snow) then wx.snow else 0 * 0.5)
                gl:uniform1i(loc.img, 0)
                gl:uniform2f(loc.res, w, h)
                gl:uniform2f(loc.sun, sunX, sunY)
                gl:uniform1f(
                    loc.rays,
                    math.max(0, rays)
                )
                local ____t_33 = __t
                local ____t_32 = __t
                local ____t_30 = __t
                local ____temp_29 = if __t(outdoor) then k else outdoor
                __O[25] = ____temp_29
                local ____temp_31 = if ____t_30(____temp_29) then not __t(k.moon) else __O[25]
                __O[26] = ____temp_31
                local golden = if ____t_33(if ____t_32(____temp_31) then k.y >= 0 else __O[26]) then math.max(
                    0,
                    math.min(1, 1 - k.up * 1.7)
                ) * (1 - if __t(wx.rain) then wx.rain else 0 * 0.8) * (1 - if __t(wx.snow) then wx.snow else 0 * 0.5) else 0
                gl:uniform1f(loc.golden, golden)
                local ____gl_40 = gl
                local ____gl_uniform1f_41 = gl.uniform1f
                local ____loc_rim_39 = loc.rim
                local ____t_38 = __t
                local ____t_37 = __t
                local ____t_35 = __t
                local ____temp_34 = if __t(outdoor) then k else outdoor
                __O[27] = ____temp_34
                local ____temp_36 = if ____t_35(____temp_34) then not __t(k.moon) else __O[27]
                __O[28] = ____temp_36
                ____gl_uniform1f_41(____gl_40, ____loc_rim_39, if ____t_38(if ____t_37(____temp_36) then k.y >= 0 else __O[28]) then (0.35 + golden * 0.65) * math.min(1, k.up * 3 + 0.2) * (1 - if __t(wx.rain) then wx.rain else 0 * 0.8) * (1 - if __t(wx.snow) then wx.snow else 0 * 0.4) else 0)
                gl:uniform1f(loc.warm, if scene == 6 then 0.3 else 0.7 * (1 - night * 0.6))
                gl:uniform1f(loc.t, t)
                local lean = if __t(k) then k.lean else -0.4
                gl:uniform2f(loc.ldir, -lean * 0.9, -0.55 - if __t(k) then k.up else 0.5 * 0.35)
                gl:uniform1f(loc.relief, if s.arena == "menu" then 0 else if __t(outdoor) then 0.32 else 0.22 * if __t(if __t(k) then k.moon else k) then 0.55 else 1)
                local fog = if __t(k) then k.s.bot else __arrL({0.8, 0.85, 0.9}, 3)
                gl:uniform3f(
                    loc.fogCol,
                    __get(fog, 0),
                    __get(fog, 1),
                    __get(fog, 2)
                )
                gl:uniform1f(loc.fogY, 0.56)
                gl:uniform1f(loc.fogAmt, if __t(outdoor) then 0.1 + if __t(wx.rain) then wx.rain else 0 * 0.2 + if __t(wx.snow) then wx.snow else 0 * 0.25 else 0)
                local wa = if __t(outdoor) then __get(WATER, scene) else outdoor
                gl:uniform3f(loc.water, if __t(wa) then 1 else 0, if __t(wa) then __get(wa, 0) else 0, if __t(wa) then __get(wa, 1) else 0)
                local midday = if __t(if __t(k) then not __t(k.moon) else k) then math.max(0, k.up - 0.55) * 2.2 else 0
                gl:uniform1f(loc.heat, if __t(if __t(outdoor) then __get(HOT, scene) else outdoor) then __get(HOT, scene) * midday * (1 - if __t(wx.rain) then wx.rain else 0) else 0)
                gl:uniform1f(loc.night, night)
                gl:uniform1f(loc.wet, if __t(wx.rain) then wx.rain else 0)
                gl:uniform1f(loc.dof, if __t(outdoor) then 0.35 else 0)
                gl:drawArrays(gl.TRIANGLE_STRIP, 0, 4)
                return true, true
            end)
            if not ____try then
                ____hasReturned, ____returnValue = ____catch(____hasReturned)
            end
            if ____hasReturned then
                return ____returnValue
            end
        end
    end
    target = nil
    itemsCv = nil
    itemsCtx = nil
    lastApply = 0
    layoutAt = 0
    itemsUsed = false
    watching = false
    window:addEventListener(
        "resize",
        function()
            layoutAt = 0
        end
    )
    local function items(self)
        local ____t_52 = __t
        local ____t_51 = __t
        local ____t_49 = __t
        local ____temp_48 = not __t(itemsCtx) or not __t(gl)
        __O[31] = ____temp_48
        local ____temp_50 = if ____t_49(____temp_48) then __O[31] else window.performance:now() - lastApply > 50
        __O[32] = ____temp_50
        if ____t_52(if ____t_51(____temp_50) then __O[32] else itemsCv.style.display == "none") then
            return nil
        end
        itemsUsed = true
        return itemsCtx
    end
    local canGL = nil
    window.Shader = __ord(
        {
            apply = apply,
            items = items,
            hide = hide,
            supported = function()
                if __t(broken) then
                    return false
                end
                if __t(gl) then
                    return true
                end
                if canGL == nil then
                    do
                        local function ____catch(e)
                            canGL = false
                        end
                        local ____try, ____hasReturned = pcall(function()
                            local t = window.document:createElement("canvas")
                            local x = t:getContext("webgl")
                            canGL = not not __t(x)
                            local ____opt_57 = x and x.getExtension
                            local ____opt_55 = ____opt_57 and ____opt_57(x, "WEBGL_lose_context")
                            local ____opt_53 = ____opt_55 and ____opt_55.loseContext
                            if ____opt_53 ~= nil then
                                ____opt_53(____opt_55)
                            end
                        end)
                        if not ____try then
                            ____catch(____hasReturned)
                        end
                    end
                end
                return canGL
            end
        },
        "apply,items,hide,supported"
    )
end)(nil)
return ____exports
