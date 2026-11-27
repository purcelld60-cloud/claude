--!native
--[[ Som do jogo no Roblox: imita o WebAudio do navegador (AudioContext, osciladores, ganho, filtros, ruído)
  e o <audio> das músicas. O Roblox não gera ondas na hora; então cada oscilador vira um som em laço já enviado
  (seno, quadrada, serra, triângulo ou ruído, em 220 Hz), com a altura mudada pela velocidade de reprodução e o
  volume calculado pelos nós de ganho até a saída, quadro a quadro.
  O hospedeiro informa N.som = { tocar(id, tipo, taxa, volume), ajustar(id, taxa, volume), parar(id), musica(src, volume, laco) }. ]]
local A = {}
local BASE = 220 -- frequência dos arquivos de onda (roblox/audio/onda_*.ogg)

function A.iniciar(N, JS)
  local window = N.window
  local ativos, proxId = {}, 1
  local function agora() return N.agora() / 1000 end

  -- parâmetro com automação (setValueAtTime, rampas e alvo)
  local function novoParam(v)
    local p = { value = v, _ev = {} }
    local function add(e) local ev = p._ev; ev[#ev + 1] = e; table.sort(ev, function(a, b) return a.t < b.t end) end
    p.setValueAtTime = function(_, v2, t) add({ t = tonumber(t) or 0, v = tonumber(v2) or 0, tipo = "set" }); return p end
    p.linearRampToValueAtTime = function(_, v2, t) add({ t = tonumber(t) or 0, v = tonumber(v2) or 0, tipo = "lin" }); return p end
    p.exponentialRampToValueAtTime = function(_, v2, t) add({ t = tonumber(t) or 0, v = math.max(1e-4, tonumber(v2) or 1e-4), tipo = "exp" }); return p end
    p.setTargetAtTime = function(_, v2, t, tc) add({ t = tonumber(t) or 0, v = tonumber(v2) or 0, tipo = "alvo", tc = math.max(1e-3, tonumber(tc) or .1) }); return p end
    p.cancelScheduledValues = function(_, t) local ev = p._ev; for i = #ev, 1, -1 do if ev[i].t >= (tonumber(t) or 0) then table.remove(ev, i) end end; return p end
    p.cancelAndHoldAtTime = p.cancelScheduledValues
    p.valorEm = function(t)
      local v, t0 = tonumber(p.value) or 0, -math.huge
      for _, e in ipairs(p._ev) do
        if e.t <= t then
          if e.tipo == "alvo" then v = e.v + (v - e.v) * math.exp(-(t - e.t) / e.tc) else v = e.v end
          t0 = e.t
        else
          if e.tipo == "lin" then local k = (t - t0) / math.max(1e-6, e.t - t0); if t0 == -math.huge then k = 0 end; return v + (e.v - v) * math.max(0, math.min(1, k)) end
          if e.tipo == "exp" then local k = (t - t0) / math.max(1e-6, e.t - t0); if t0 == -math.huge then k = 0 end; local a = math.max(1e-4, v); return a * (e.v / a) ^ math.max(0, math.min(1, k)) end
          return v
        end
      end
      return v
    end
    return p
  end

  local function novoNo(ctx, tipo)
    local n = { _tipo = tipo, _saidas = {}, context = ctx, numberOfInputs = 1, numberOfOutputs = 1, channelCount = 2 }
    n.connect = function(_, dest) if dest then n._saidas[#n._saidas + 1] = dest end; return dest end
    n.disconnect = function(_, dest) if dest == nil then n._saidas = {} else for i = #n._saidas, 1, -1 do if n._saidas[i] == dest then table.remove(n._saidas, i) end end end end
    n.addEventListener = function(_, tipo2, f) if tipo2 == "ended" then n.onended = f end end
    n.removeEventListener = function() end
    return n
  end
  -- volume do caminho até a saída (multiplica os ganhos; filtros passa-alta/passa-banda abaixam um pouco)
  local function volumeAte(no, t, prof)
    if prof > 12 then return 0 end
    if no._tipo == "saida" then return 1 end
    local melhor = 0
    for _, s in ipairs(no._saidas) do
      local v = volumeAte(s, t, prof + 1)
      if s._tipo == "ganho" then v = v * (s.gain.valorEm(t)) elseif s._tipo == "filtro" and (s.type == "highpass" or s.type == "bandpass") then v = v * .6 end
      if v > melhor then melhor = v end
    end
    return melhor
  end

  local function Contexto()
    local ctx = { sampleRate = 44100, state = "running", baseLatency = 0, outputLatency = 0 }
    setmetatable(ctx, { __index = function(_, k) if k == "currentTime" then return agora() end end })
    ctx.destination = novoNo(ctx, "saida"); ctx.destination.maxChannelCount = 2
    ctx.listener = { positionX = novoParam(0), positionY = novoParam(0), positionZ = novoParam(0) }
    ctx.resume = function() ctx.state = "running"; return N.Promise.resolve(nil) end
    ctx.suspend = function() ctx.state = "suspended"; return N.Promise.resolve(nil) end
    ctx.close = function() ctx.state = "closed"; for id, s in pairs(ativos) do if s.ctx == ctx then if N.som then N.som.parar(id) end; ativos[id] = nil end end; return N.Promise.resolve(nil) end
    ctx.addEventListener = function() end; ctx.removeEventListener = function() end
    ctx.createGain = function() local g = novoNo(ctx, "ganho"); g.gain = novoParam(1); return g end
    ctx.createBiquadFilter = function() local f = novoNo(ctx, "filtro"); f.type = "lowpass"; f.frequency = novoParam(350); f.Q = novoParam(1); f.gain = novoParam(0); f.detune = novoParam(0); return f end
    ctx.createDelay = function() local d = novoNo(ctx, "atraso"); d.delayTime = novoParam(0); return d end
    ctx.createDynamicsCompressor = function() local d = novoNo(ctx, "comp"); for _, k in ipairs({ "threshold", "knee", "ratio", "attack", "release" }) do d[k] = novoParam(0) end; return d end
    ctx.createStereoPanner = function() local d = novoNo(ctx, "pan"); d.pan = novoParam(0); return d end
    ctx.createAnalyser = function() local d = novoNo(ctx, "analise"); d.fftSize = 2048; d.frequencyBinCount = 1024; d.getByteFrequencyData = function() end; d.getFloatTimeDomainData = function() end; d.getByteTimeDomainData = function() end; return d end
    ctx.createMediaElementSource = function(_, el) local d = novoNo(ctx, "midia"); d.mediaElement = el; return d end
    ctx.createConvolver = function() return novoNo(ctx, "conv") end
    ctx.createWaveShaper = function() local d = novoNo(ctx, "forma"); d.curve = nil; return d end
    ctx.createBuffer = function(_, canais, len, taxa)
      len = math.max(1, math.floor(tonumber(len) or 1))
      local b = { numberOfChannels = canais or 1, length = len, sampleRate = taxa or 44100, duration = len / (taxa or 44100), _dados = {} }
      b.getChannelData = function(_, c) c = c or 0; local d = b._dados[c]; if not d then d = JS.tipada("Float32Array", len); b._dados[c] = d end; return d end
      b.copyToChannel = function() end
      return b
    end
    local function fonte(tipo)
      local s = novoNo(ctx, "fonte")
      s._som = tipo
      s.start = function(_, quando, _offset, dur)
        local id = proxId; proxId = proxId + 1
        s._id = id; s._inicio = math.max(agora(), tonumber(quando) or 0)
        if dur then s._fim = s._inicio + tonumber(dur) end
        s._tocando = false; s.ctx = ctx
        ativos[id] = s
      end
      s.stop = function(_, quando) s._fim = math.max(agora(), tonumber(quando) or agora()) end
      return s
    end
    ctx.createOscillator = function()
      local o = fonte("sine"); o.frequency = novoParam(440); o.detune = novoParam(0)
      setmetatable(o, { __index = function(_, k) if k == "type" then return rawget(o, "_som") end end, __newindex = function(t, k, v) if k == "type" then rawset(t, "_som", v) else rawset(t, k, v) end end })
      o.setPeriodicWave = function() end
      return o
    end
    ctx.createBufferSource = function()
      local b = fonte("ruido"); b.playbackRate = novoParam(1); b.detune = novoParam(0); b.loop = false; b.buffer = nil
      return b
    end
    ctx.createPeriodicWave = function() return {} end
    ctx.decodeAudioData = function() return N.Promise.reject("sem decodificação no Roblox") end
    return ctx
  end
  window.AudioContext = function() return Contexto() end
  window.webkitAudioContext = window.AudioContext
  window.OfflineAudioContext = window.AudioContext
  N.CRIAR.AudioContext = Contexto
  N.CRIAR.webkitAudioContext = Contexto

  -- a cada quadro: começa, ajusta e para os sons
  function A.passo()
    local t = agora()
    for id, s in pairs(ativos) do
      if t >= s._inicio then
        local vol = volumeAte(s, t, 0)
        local taxa
        if s._som == "ruido" then
          taxa = s.playbackRate.valorEm(t)
          if not s.loop and s.buffer and not s._fim then s._fim = s._inicio + (s.buffer.duration or 1) / math.max(.05, taxa) end
        else
          taxa = (s.frequency.valorEm(math.max(t, s._inicio)) * 2 ^ (s.detune.valorEm(t) / 1200)) / BASE
        end
        local comecouAgora = false
        if not s._tocando then
          -- começa mesmo que o som seja mais curto que um quadro: o hospedeiro para sozinho depois da duração
          s._tocando = true; comecouAgora = true
          if N.som then N.som.tocar(id, s._som, taxa, s._fim and volumeAte(s, s._inicio, 0) or vol, s._fim and math.max(.03, s._fim - s._inicio) or nil) end
        elseif N.som then N.som.ajustar(id, taxa, vol) end
        if s._fim and t >= s._fim then
          if not comecouAgora and N.som then N.som.parar(id) end
          ativos[id] = nil
          local f = s.onended; if type(f) == "function" then pcall(f, s, { type = "ended", target = s }) end
        end
      end
    end
  end

  -- músicas: <audio> e new Audio(src)
  local EL = N.EL
  EL.play = function(el) rawset(el, "paused", false); if N.som and N.som.musica then N.som.musica(el, true) end; N.despachar(el, N.novoEvento("play")); return N.Promise.resolve(nil) end
  EL.pause = function(el) rawset(el, "paused", true); if N.som and N.som.musica then N.som.musica(el, false) end; N.despachar(el, N.novoEvento("pause")) end
  EL.load = function() end
  EL.canPlayType = function() return "maybe" end
  return A
end
return A
