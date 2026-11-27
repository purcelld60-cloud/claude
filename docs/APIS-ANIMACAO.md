# Bibliotecas públicas para animação e cutscenes (pesquisa de 2026-11-27)

O dono pediu para pesquisar bibliotecas e APIs públicas que melhorem as cutscenes e as animações. Este é o resumo do que existe e do que vale para o Da Roça Adventure, um jogo em canvas 2D com pixel art desenhada em código.

## O que já usamos

| Biblioteca | Licença | Para quê | Onde |
| --- | --- | --- | --- |
| **pixelfx** (Patch e Hugo Duprez) | MIT | 244 efeitos de pixel art em código (fogo, fumaça, raios de luz, chuva, eclipse, fogos…) | `dist/vendor/pixelfx.js` + `dist/fx-pixel.js` |

A pixelfx é a melhor opção para este jogo porque:
- desenha pixel a pixel, na mesma densidade dos personagens;
- não usa imagens;
- os efeitos aceitam paleta, posição, espelhamento, atraso, duração e avanço no tempo.

Ela já está nas lutas, no baile (luz pelo teto), na luta do Ollyan, na cutscene do Jorge e nos lugares novos.

## Outras opções avaliadas

| Biblioteca | Licença | O que faz | Vale para nós? |
| --- | --- | --- | --- |
| [Rekapi](https://npmjs.org/package/rekapi) | MIT | Keyframes com renderizador para canvas 2D | Só se as cutscenes forem reescritas em quadros-chave. Hoje o kit de cutscenes (`roteiro.js`, `campanha2/cutscenes.js`) já faz isso com JSON. |
| [jcc2d](https://github.com/jasonChen1982/jcc2d) | MIT | Motor canvas 2D com animador e linha do tempo (pausa, velocidade) | Traria um motor inteiro novo. Não compensa. |
| [animation-timeline-js](https://www.npmjs.com/package/animation-timeline-js) | MIT | Editor visual de linha do tempo | Útil para uma ferramenta de edição de cutscenes no futuro (`cutscene-preview.js`), não para o jogo. |
| [tsParticles](https://www.npmjs.com/package/tsparticles-engine) | MIT | Partículas genéricas (confete, fogos) | Não é pixel art. A pixelfx cobre melhor. |
| [mz-particles](https://www.npmjs.com/package/mz-particles) | MIT | Partículas em canvas | Mesmo caso: a pixelfx cobre. |
| [pixi-particles](https://npmjs.com/package/pixi-particles) | conferir | Partículas para PixiJS | Só serve com PixiJS, que o jogo não usa. |

## Decisão

- Continuar com a pixelfx e ampliar o pacote quando precisar de efeitos novos: `tools/pixelfx/efeitos.txt` e depois `bash tools/pixelfx/montar.sh`.
- Para cutscenes, seguir com os roteiros em JSON e os desenhos em código, que já têm câmera, balões, tremor e trilha.
- Se um dia houver um editor visual de cutscenes, avaliar o `animation-timeline-js` só para a ferramenta.
