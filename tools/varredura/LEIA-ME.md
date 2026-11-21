# Varredura de bugs

Scripts em Playwright que procuram bugs no jogo. Suba o servidor (`python3 tools/dev-server.py`), entre na pasta e rode `node <script>.js`.

| Script | O que procura |
| --- | --- |
| `cenarios.js` | Cortes, faixas vazias e bordas em todos os cenários das duas campanhas (bordas e meio), no PC, no celular deitado e no celular em pé. Salva fotos em `fotos/`. |
| `fisica.js` | Vãos (cair, voltar do lado certo, não atravessar por baixo), bordas do mundo e NaN. |
| `pulo.js` | Se cada vão da Campanha 2 dá para atravessar pulando ou pulando com dash. |
| `shader.js` | Cada cenário nas qualidades baixa, média e alta, com clima e hora variando. |
| `perda.js` | Perda do contexto WebGL com o shader ligado (como no iPhone em segundo plano). |
| `botoes.js` | Botões fora da tela, cobertos ou pequenos demais, em 6 aparelhos e em todas as telas. |
| `saves.js` | Saves corrompidos, antigos ou com NaN, nas duas campanhas e em todas as outras chaves. |
| `chefes-conquista.js` | Percorre os golpes dos nove chefes, a derrota, o retorno ao checkpoint e as cinco barras do Jorge até os créditos e a gravação do progresso. |
| `luta-c2-real.js` | Entra numa luta da Campanha 2 pelo caminho do jogador e confere se o Da Roça anda (teclado e joystick). |
| `dialogo-c2.js` | Na Campanha 2, os botões de toque somem nos diálogos e voltam depois; tocar na tela avança a fala. |
| `macaco.js` | Teclas aleatórias por vários minutos: erros, NaN, quedas e travas. |

`comum.js` abre o jogo com ganchos de teste e dá para teleportar (`__go`, `__c2go`). Os ganchos só existem dentro do teste; o jogo publicado não muda.
