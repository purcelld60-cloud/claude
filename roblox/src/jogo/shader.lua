--!native
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
        local ____t_121 = __t
        local ____t_result_120
        local ____t_119 = __t
        local ____temp_118 = not __t(cv.offsetWidth) or cs.display == "none"
        __O[29] = ____temp_118
        if ____t_119(____temp_118) then
            ____t_result_120 = __O[29]
        else
            ____t_result_120 = cs.visibility == "hidden"
        end
        if ____t_121(____t_result_120) then
            el.style.display = "none"
            return
        end
        el.style.cssText = __add(
            ((((((("position:absolute;left:" .. tostring(cv.offsetLeft)) .. "px;top:") .. tostring(cv.offsetTop)) .. "px;width:") .. tostring(cv.offsetWidth)) .. "px;height:") .. tostring(cv.offsetHeight)) .. "px;margin:0;padding:0;border:0;pointer-events:none;",
            (((((((((((("object-fit:" .. cs.objectFit) .. ";object-position:") .. cs.objectPosition) .. ";image-rendering:") .. cs.imageRendering) .. ";transform:") .. (cs.transform == "none" and "none" or cs.transform)) .. ";transform-origin:") .. cs.transformOrigin) .. ";border-radius:") .. cs.borderRadius) .. ";opacity:") .. cs.opacity
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
        local ____t_125 = __t
        local ____t_result_124
        local ____t_123 = __t
        local ____temp_122 = target ~= canvas or glCanvas.nextSibling ~= itemsCv
        __O[30] = ____temp_122
        if ____t_123(____temp_122) then
            ____t_result_124 = __O[30]
        else
            ____t_result_124 = canvas.nextSibling ~= glCanvas
        end
        if ____t_125(____t_result_124) then
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
        local ____t_result_7
        local ____t_6 = __t
        local ____TS__Number_result_5 = __TS__Number(camera)
        __O[21] = ____TS__Number_result_5
        if ____t_6(____TS__Number_result_5) then
            ____t_result_7 = __O[21]
        else
            ____t_result_7 = 0
        end
        local camL = math.floor(____t_result_7 / 2)
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
        local ____t_19 = __t
        local ____t_result_18
        local ____t_11 = __t
        local ____t_result_10
        if __t(broken) then
            ____t_result_10 = broken
        else
            ____t_result_10 = not __t(canvas)
        end
        __O[22] = ____t_result_10
        if ____t_11(____t_result_10) then
            ____t_result_18 = __O[22]
        else
            local ____t_17 = __t
            local ____opt_14 = window.Graphics
            if ____opt_14 ~= nil then
                ____opt_14 = ____opt_14.isShader
            end
            local ____opt_result_16
            if ____opt_14 ~= nil then
                ____opt_result_16 = ____opt_14(____opt_14)
            end
            ____t_result_18 = not ____t_17(____opt_result_16)
        end
        if ____t_19(____t_result_18) then
            return false
        end
        if window.performance:now() < esperaAte then
            return false
        end
        local ____t_23 = __t
        local ____t_result_22
        if __t(gl) then
            local ____this_21
            ____this_21 = gl
            local ____opt_20 = ____this_21.isContextLost
            if ____opt_20 ~= nil then
                ____opt_20 = ____opt_20(____this_21)
            end
            ____t_result_22 = ____opt_20
        else
            ____t_result_22 = gl
        end
        if ____t_23(____t_result_22) then
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
                local ____t_result_26
                local ____t_25 = __t
                local ____TS__Number_result_24 = __TS__Number(s.time)
                __O[23] = ____TS__Number_result_24
                if ____t_25(____TS__Number_result_24) then
                    ____t_result_26 = __O[23]
                else
                    ____t_result_26 = 0
                end
                local t = ____t_result_26
                local ____t_result_27
                if __t(s.sun) then
                    ____t_result_27 = nil
                else
                    ____t_result_27 = sky(nil, s.camera)
                end
                local k = ____t_result_27
                local ____t_result_28
                if __t(k) then
                    ____t_result_28 = k.s.night
                else
                    ____t_result_28 = 0
                end
                local night = ____t_result_28
                local ____t_result_35
                local ____t_34 = __t
                local ____opt_31 = window.Weather
                if ____opt_31 ~= nil then
                    ____opt_31 = ____opt_31.state
                end
                local ____opt_result_33
                if ____opt_31 ~= nil then
                    ____opt_result_33 = ____opt_31(____opt_31)
                end
                __O[24] = ____opt_result_33
                if ____t_34(____opt_result_33) then
                    ____t_result_35 = __O[24]
                else
                    ____t_result_35 = {}
                end
                local wx = ____t_result_35
                local ____t_result_37
                if __t(s.sun) then
                    ____t_result_37 = __get(s.sun, 0)
                else
                    local ____t_result_36
                    if __t(k) then
                        ____t_result_36 = k.x
                    else
                        ____t_result_36 = 0.76
                    end
                    ____t_result_37 = ____t_result_36
                end
                local sunX = ____t_result_37
                local ____t_result_39
                if __t(s.sun) then
                    ____t_result_39 = __get(s.sun, 1)
                else
                    local ____t_result_38
                    if __t(k) then
                        ____t_result_38 = k.y
                    else
                        ____t_result_38 = 0.18
                    end
                    ____t_result_39 = ____t_result_38
                end
                local sunY = ____t_result_39
                local ____t_result_45
                if __t(outdoor) then
                    local ____t_result_44
                    local ____t_41 = __t
                    local ____t_result_40
                    if __t(k) then
                        ____t_result_40 = k.y < 0
                    else
                        ____t_result_40 = k
                    end
                    if ____t_41(____t_result_40) then
                        ____t_result_44 = 0
                    else
                        local ____t_43 = __t
                        local ____t_result_42
                        if __t(k) then
                            ____t_result_42 = k.moon
                        else
                            ____t_result_42 = k
                        end
                        ____t_result_44 = ____t_43(____t_result_42) and 0.45 or (scene == 3 and 1.15 or 1)
                    end
                    ____t_result_45 = ____t_result_44
                else
                    ____t_result_45 = 0
                end
                local rays = ____t_result_45
                local ____t_result_46
                if __t(wx.rain) then
                    ____t_result_46 = wx.rain
                else
                    ____t_result_46 = 0
                end
                local ____temp_48 = 1 - ____t_result_46 * 0.85
                local ____t_result_47
                if __t(wx.snow) then
                    ____t_result_47 = wx.snow
                else
                    ____t_result_47 = 0
                end
                rays = rays * (____temp_48 - ____t_result_47 * 0.5)
                gl:uniform1i(loc.img, 0)
                gl:uniform2f(loc.res, w, h)
                gl:uniform2f(loc.sun, sunX, sunY)
                gl:uniform1f(
                    loc.rays,
                    math.max(0, rays)
                )
                local ____t_result_59
                local ____t_54 = __t
                local ____t_result_53
                local ____t_52 = __t
                local ____t_result_51
                local ____t_50 = __t
                local ____t_result_49
                if __t(outdoor) then
                    ____t_result_49 = k
                else
                    ____t_result_49 = outdoor
                end
                __O[25] = ____t_result_49
                if ____t_50(____t_result_49) then
                    ____t_result_51 = not __t(k.moon)
                else
                    ____t_result_51 = __O[25]
                end
                __O[26] = ____t_result_51
                if ____t_52(____t_result_51) then
                    ____t_result_53 = k.y >= 0
                else
                    ____t_result_53 = __O[26]
                end
                if ____t_54(____t_result_53) then
                    local ____math_max_result_56 = math.max(
                        0,
                        math.min(1, 1 - k.up * 1.7)
                    )
                    local ____t_result_55
                    if __t(wx.rain) then
                        ____t_result_55 = wx.rain
                    else
                        ____t_result_55 = 0
                    end
                    local ____temp_58 = ____math_max_result_56 * (1 - ____t_result_55 * 0.8)
                    local ____t_result_57
                    if __t(wx.snow) then
                        ____t_result_57 = wx.snow
                    else
                        ____t_result_57 = 0
                    end
                    ____t_result_59 = ____temp_58 * (1 - ____t_result_57 * 0.5)
                else
                    ____t_result_59 = 0
                end
                local golden = ____t_result_59
                gl:uniform1f(loc.golden, golden)
                local ____gl_72 = gl
                local ____gl_uniform1f_73 = gl.uniform1f
                local ____loc_rim_71 = loc.rim
                local ____t_result_70
                local ____t_65 = __t
                local ____t_result_64
                local ____t_63 = __t
                local ____t_result_62
                local ____t_61 = __t
                local ____t_result_60
                if __t(outdoor) then
                    ____t_result_60 = k
                else
                    ____t_result_60 = outdoor
                end
                __O[27] = ____t_result_60
                if ____t_61(____t_result_60) then
                    ____t_result_62 = not __t(k.moon)
                else
                    ____t_result_62 = __O[27]
                end
                __O[28] = ____t_result_62
                if ____t_63(____t_result_62) then
                    ____t_result_64 = k.y >= 0
                else
                    ____t_result_64 = __O[28]
                end
                if ____t_65(____t_result_64) then
                    local ____temp_67 = (0.35 + golden * 0.65) * math.min(1, k.up * 3 + 0.2)
                    local ____t_result_66
                    if __t(wx.rain) then
                        ____t_result_66 = wx.rain
                    else
                        ____t_result_66 = 0
                    end
                    local ____temp_69 = ____temp_67 * (1 - ____t_result_66 * 0.8)
                    local ____t_result_68
                    if __t(wx.snow) then
                        ____t_result_68 = wx.snow
                    else
                        ____t_result_68 = 0
                    end
                    ____t_result_70 = ____temp_69 * (1 - ____t_result_68 * 0.4)
                else
                    ____t_result_70 = 0
                end
                ____gl_uniform1f_73(____gl_72, ____loc_rim_71, ____t_result_70)
                gl:uniform1f(loc.warm, (scene == 6 and 0.3 or 0.7) * (1 - night * 0.6))
                gl:uniform1f(loc.t, t)
                local ____t_result_74
                if __t(k) then
                    ____t_result_74 = k.lean
                else
                    ____t_result_74 = -0.4
                end
                local lean = ____t_result_74
                local ____gl_79 = gl
                local ____gl_uniform2f_80 = gl.uniform2f
                local ____loc_ldir_77 = loc.ldir
                local ____temp_78 = -lean * 0.9
                local ____temp_76 = -0.55
                local ____t_result_75
                if __t(k) then
                    ____t_result_75 = k.up
                else
                    ____t_result_75 = 0.5
                end
                ____gl_uniform2f_80(____gl_79, ____loc_ldir_77, ____temp_78, ____temp_76 - ____t_result_75 * 0.35)
                local ____gl_86 = gl
                local ____gl_uniform1f_87 = gl.uniform1f
                local ____loc_relief_85 = loc.relief
                local ____temp_84
                if s.arena == "menu" then
                    ____temp_84 = 0
                else
                    local ____temp_83 = __t(outdoor) and 0.32 or 0.22
                    local ____t_82 = __t
                    local ____t_result_81
                    if __t(k) then
                        ____t_result_81 = k.moon
                    else
                        ____t_result_81 = k
                    end
                    ____temp_84 = ____temp_83 * (____t_82(____t_result_81) and 0.55 or 1)
                end
                ____gl_uniform1f_87(____gl_86, ____loc_relief_85, ____temp_84)
                local ____t_result_88
                if __t(k) then
                    ____t_result_88 = k.s.bot
                else
                    ____t_result_88 = __arrL({0.8, 0.85, 0.9}, 3)
                end
                local fog = ____t_result_88
                gl:uniform3f(
                    loc.fogCol,
                    __get(fog, 0),
                    __get(fog, 1),
                    __get(fog, 2)
                )
                gl:uniform1f(loc.fogY, 0.56)
                local ____gl_94 = gl
                local ____gl_uniform1f_95 = gl.uniform1f
                local ____loc_fogAmt_93 = loc.fogAmt
                local ____t_result_92
                if __t(outdoor) then
                    local ____t_result_89
                    if __t(wx.rain) then
                        ____t_result_89 = wx.rain
                    else
                        ____t_result_89 = 0
                    end
                    local ____temp_91 = 0.1 + ____t_result_89 * 0.2
                    local ____t_result_90
                    if __t(wx.snow) then
                        ____t_result_90 = wx.snow
                    else
                        ____t_result_90 = 0
                    end
                    ____t_result_92 = ____temp_91 + ____t_result_90 * 0.25
                else
                    ____t_result_92 = 0
                end
                ____gl_uniform1f_95(____gl_94, ____loc_fogAmt_93, ____t_result_92)
                local ____t_result_96
                if __t(outdoor) then
                    ____t_result_96 = __get(WATER, scene)
                else
                    ____t_result_96 = outdoor
                end
                local wa = ____t_result_96
                local ____gl_101 = gl
                local ____gl_uniform3f_102 = gl.uniform3f
                local ____loc_water_99 = loc.water
                local ____temp_100 = __t(wa) and 1 or 0
                local ____t_result_97
                if __t(wa) then
                    ____t_result_97 = __get(wa, 0)
                else
                    ____t_result_97 = 0
                end
                local ____t_result_98
                if __t(wa) then
                    ____t_result_98 = __get(wa, 1)
                else
                    ____t_result_98 = 0
                end
                ____gl_uniform3f_102(
                    ____gl_101,
                    ____loc_water_99,
                    ____temp_100,
                    ____t_result_97,
                    ____t_result_98
                )
                local ____t_result_105
                local ____t_104 = __t
                local ____t_result_103
                if __t(k) then
                    ____t_result_103 = not __t(k.moon)
                else
                    ____t_result_103 = k
                end
                if ____t_104(____t_result_103) then
                    ____t_result_105 = math.max(0, k.up - 0.55) * 2.2
                else
                    ____t_result_105 = 0
                end
                local midday = ____t_result_105
                local ____gl_112 = gl
                local ____gl_uniform1f_113 = gl.uniform1f
                local ____loc_heat_111 = loc.heat
                local ____t_result_110
                local ____t_107 = __t
                local ____t_result_106
                if __t(outdoor) then
                    ____t_result_106 = __get(HOT, scene)
                else
                    ____t_result_106 = outdoor
                end
                if ____t_107(____t_result_106) then
                    local ____temp_109 = __get(HOT, scene) * midday
                    local ____t_result_108
                    if __t(wx.rain) then
                        ____t_result_108 = wx.rain
                    else
                        ____t_result_108 = 0
                    end
                    ____t_result_110 = ____temp_109 * (1 - ____t_result_108)
                else
                    ____t_result_110 = 0
                end
                ____gl_uniform1f_113(____gl_112, ____loc_heat_111, ____t_result_110)
                gl:uniform1f(loc.night, night)
                local ____gl_116 = gl
                local ____gl_uniform1f_117 = gl.uniform1f
                local ____loc_wet_115 = loc.wet
                local ____t_result_114
                if __t(wx.rain) then
                    ____t_result_114 = wx.rain
                else
                    ____t_result_114 = 0
                end
                ____gl_uniform1f_117(____gl_116, ____loc_wet_115, ____t_result_114)
                gl:uniform1f(
                    loc.dof,
                    __t(outdoor) and 0.35 or 0
                )
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
        local ____t_131 = __t
        local ____t_result_130
        local ____t_129 = __t
        local ____t_result_128
        local ____t_127 = __t
        local ____temp_126 = not __t(itemsCtx) or not __t(gl)
        __O[31] = ____temp_126
        if ____t_127(____temp_126) then
            ____t_result_128 = __O[31]
        else
            ____t_result_128 = window.performance:now() - lastApply > 50
        end
        __O[32] = ____t_result_128
        if ____t_129(____t_result_128) then
            ____t_result_130 = __O[32]
        else
            ____t_result_130 = itemsCv.style.display == "none"
        end
        if ____t_131(____t_result_130) then
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
                            local ____opt_136 = x and x.getExtension
                            local ____opt_134 = ____opt_136 and ____opt_136(x, "WEBGL_lose_context")
                            local ____opt_132 = ____opt_134 and ____opt_134.loseContext
                            if ____opt_132 ~= nil then
                                ____opt_132(____opt_134)
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
