-- Imita o "buffer" do Luau no Lua 5.3 (só para testar o caminho do Roblox): guarda u32 por posição em bytes
buffer = {
  create = function(n) return setmetatable({ _n = n }, { __name = "buffer" }) end,
  readu32 = function(b, o) assert(o % 4 == 0 and o >= 0 and o + 4 <= b._n, "posição fora do buffer: " .. tostring(o)); return b[o] or 0 end,
  writeu32 = function(b, o, v) assert(o % 4 == 0 and o >= 0 and o + 4 <= b._n, "posição fora do buffer: " .. tostring(o)); assert(v == math.floor(v) and v >= 0 and v < 4294967296, "valor inválido " .. tostring(v)); b[o] = v end,
}
