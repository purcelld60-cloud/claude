--[[ IDs dos sons do Da Roça no Roblox (preencha depois de enviar os arquivos de roblox/audio para a sua conta).
  No Roblox Studio: Asset Manager (Gerenciador de recursos) → Importar → escolha os 5 arquivos onda_*.ogg.
  Depois, clique com o botão direito em cada um → "Copiar ID" e cole aqui no formato "rbxassetid://123456".
  Sem os IDs o jogo funciona, só que sem som. ]]
return {
  sine = "",      -- onda_seno.ogg
  square = "",    -- onda_quadrada.ogg
  sawtooth = "",  -- onda_serra.ogg
  triangle = "",  -- onda_triangulo.ogg
  ruido = "",     -- onda_ruido.ogg
  -- músicas (opcional): o nome do arquivo .mp3 que o jogo toca → ID do áudio enviado
  musicas = {
    -- ["c1-cenario-academia/minha-musica.mp3"] = "rbxassetid://...",
  },
  volume = 3, -- o WebAudio usa volumes baixos (0,02 a 0,2); isto aproxima do volume do navegador
}
