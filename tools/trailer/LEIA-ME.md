# Trailer do jogo

Scripts que geram o `DaRoca-Trailer.mp4` (80 s, 1280×720, 30 qps) a partir do próprio jogo. A trilha é original: um chiptune em levada de baião, gerado por código.

## Como gerar

Precisa de Node com Playwright, Python 3 com numpy e Pillow, e ffmpeg.

1. Suba o servidor local: `python3 tools/dev-server.py`.
2. Entre na pasta e filme as cenas: `cd tools/trailer && node captura.js`.
   - O relógio do jogo é controlado e cada quadro vira um JPG em `quadros/<cena>/`.
   - Para refazer só algumas cenas, passe os nomes: `node captura.js luta_arthur,mapa_c1`.
3. Gere a trilha: `python3 musica.py` (cria `musica.wav`).
4. Monte o vídeo: `python3 montagem.py` (cria `DaRoca-Trailer.mp4`).

Os cortes, legendas e pontos de início de cada cena ficam na lista `LINHA` do `montagem.py`. A duração de cada cena é medida em compassos da música: 1 compasso = 1,875 s.

`quadros/`, `musica.wav` e o `.mp4` não vão para o Git.

## Versão vertical (TikTok, Reels e Shorts)

59 s, 1080×1920 e 30 qps, com cortes rápidos: os 10 chefes da campanha 1, os 8 vilões da campanha 2, a turma, o baile, o fliperama e as lutas na arena.

1. `node captura-tiktok.js` filma em 1920×1080 e grava em `foco.json` onde está a ação em cada quadro.
2. `python3 musica_tt.py` gera `musica-tt.wav`, a mesma trilha rearranjada para começar com tudo.
3. `python3 montagem_tt.py` gera `DaRoca-Trailer-TikTok.mp4`.

Na montagem, as lutas e a cidade são recortadas na vertical seguindo o Da Roça, com uma faixa de título no topo. As cutscenes aparecem inteiras sobre fundo desfocado. Os textos ficam fora da área que o TikTok cobre (embaixo e à direita).
