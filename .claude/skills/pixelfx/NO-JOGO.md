# pixelfx no Da Roça Adventure

Esta skill é a do projeto [patch-gg/pixelfx](https://github.com/patch-gg/pixelfx) (MIT, Patch e Hugo Duprez). Ela foi copiada sem mudanças em `SKILL.md`, com a licença em `LICENSE`.

## Como os efeitos entram no jogo

- `dist/vendor/pixelfx.js` é uma seleção de 124 efeitos, empacotada com esbuild em `window.PixelFXLib`.
  - Para refazer o pacote: `bash tools/pixelfx/montar.sh`, que clona o pixelfx no commit fixo, lê `tools/pixelfx/efeitos.txt` e grava o arquivo.
  - Para pôr outro efeito no jogo, acrescente o id em `efeitos.txt` e rode o script de novo.
- `dist/fx-pixel.js` (`window.FxPixel`) é a ponte:
  - carrega a biblioteca depois da tela inicial;
  - desenha em 480×270, ampliado 2×, acompanhando a câmera;
  - `FxPixel.tocar('categoria/efeito', { x, y, palette, flip, dono })` toca um efeito na posição do mundo (pixels do jogo).
- No `game.js`, os efeitos são desenhados ao lado do `CampaignVfx` (camadas atrás e frente), e `FxPixel.perigo(h)` roda quando um ataque de área de chefe dispara.

**Regra do dono:** no acerto, o inimigo só pisca. Os efeitos vão nos golpes, nas magias e nos ataques de área, não no impacto.

Para ver um efeito antes de usar, clone o pixelfx e rode `node tools/render.mjs <id>`. Ele gera `records/<id>/contact.png`.
