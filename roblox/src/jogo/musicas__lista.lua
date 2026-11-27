--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __ord, __arrL = __JSR.__ord, __JSR.__arrL
local ____exports = {}
window.DAROCA_MUSICAS = __ord(
    {
        arquivos = __arrL({}, 0),
        avisos = __arrL({}, 0),
        txt = "# ============================================================\n#  MÚSICAS DO DA ROÇA: qual música toca em cada lugar\n# ============================================================\n# 1. Coloque o arquivo de música (.mp3, .ogg ou .m4a) nesta pasta (dist/musicas).\n# 2. Escreva uma linha:  lugar = nome-do-arquivo.mp3\n# 3. Envie para o GitHub. O site, o APK e o IPA são gerados de novo sozinhos.\n#\n# Atalho: se o arquivo tiver o nome do lugar (ex.: roca.mp3, chefe-marco.ogg),\n# ele já toca lá sem precisar escrever nada aqui.\n#\n# Opções no fim da linha (todas opcionais):\n#   volume=0.8   (0 a 1)          fade=2      (segundos de transição)\n#   inicio=12    (começa no seg. 12)  atraso=1  (espera 1 s, só em cutscenes)\n#   sem-repetir  (toca uma vez só)\n#\n# LUGARES:\n#   menu, pausa, derrota, fim, comemoracao\n#   roca, escola, academia, quadra, praca, favela, caderno (Reino de Tinta),\n#   campo, bigodon, patio, rayssa, baile, sala-almiro, sala-miqueias\n#   chefe-marco, chefe-menezes, chefe-nikolas, chefe-reeis, chefe-freddy,\n#   chefe-nicolas, chefe-dede, chefe-arthur, chefe-colosso, chefe-igor,\n#   chefe-kaique, chefe-ollyan   (por fase: chefe-nikolas-fase2 ...)\n#   apresentacao-marco ... (a cutscene antes de cada chefe)\n#   cutscene-abertura, cutscene-intro, cutscene-creditos, cutscene-chegada_praca ...\n#   arena, arena-menu, arena-resultado, dupla, dupla-marco ...\n#   fliperama, fliperama-minhoca, fliperama-pong, fliperama-quebra, fliperama-cabo,\n#   fliperama-chinelo, fliperama-galo, fliperama-memoria, fliperama-tiro,\n#   fliperama-corrida, fliperama-subida\n#   conversa-davi, conversa-lucas ... (quando conversa com alguém)\n#   ambiente-roca, ambiente-praca, ambiente-favela ... (som de fundo da fase,\n#   no lugar do ambiente que o jogo faz sozinho)\n#\n# EXEMPLOS (tire o # do começo para usar):\n# roca = tema-da-roca.mp3\n# chefe-marco = batalha-do-caderno.ogg volume=0.9 fade=1\n# fliperama = fliperama.mp3\n# cutscene-creditos = creditos.mp3 sem-repetir\n# ambiente-praca = rio-e-cidade.ogg\n"
    },
    "arquivos,avisos,txt"
)
return ____exports
