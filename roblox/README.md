# Da Roça Adventure no Roblox

Esta pasta coloca **o jogo original** dentro do Roblox, em 2D, com o mesmo pixel, os mesmos cenários, personagens,
falas, menus e botões. Não é uma adaptação: o código do jogo (`dist/*.js`) é convertido automaticamente para Luau
(a linguagem do Roblox) e roda lá dentro. Ele desenha cada quadro pixel a pixel numa imagem do tamanho do jogo
(960 × 540), mostrada na tela do jogador.

## Como funciona

| Peça | O que faz |
| --- | --- |
| `ferramentas/converter.mjs` | Converte os 118 scripts do jogo para Luau (`src/jogo`) e para Lua 5.3 (`teste/jogo`, usado nos testes). Usa o TypeScriptToLua (licença MIT) e regras próprias para o jeito do JavaScript (0 e texto vazio são falsos, listas começam no 0, `+` junta texto etc.). |
| `ferramentas/empacotar.mjs` | Guarda a página (`index.html`), os roteiros e listas em JSON e a ordem dos scripts. |
| `ferramentas/capturar.mjs` | Abre o jogo no navegador e fotografa a interface (HUD, menus, botões) em vários momentos, mais as letras reais das fontes do jogo. O Roblox não tem HTML/CSS; com essas fotos, o Lua redesenha a interface igual. |
| `src/runtime/js.lua` | As regras do JavaScript em Lua: listas, textos, números, JSON, datas, expressões regulares (`regex.lua`). |
| `src/runtime/canvas.lua` | O "canvas" do navegador em Lua: retângulos, caminhos, degradês, transparência, modos de mistura, imagens e texto. |
| `src/runtime/navegador.lua` | Um navegador simulado: `document`, elementos, seletores CSS, eventos de clique/toque/teclado, temporizadores, `localStorage`. |
| `src/runtime/desenhista.lua` | Junta tudo numa tela só: os canvas do jogo e a interface fotografada, com o texto atual. |
| `src/runtime/audio.lua` + `src/runtime/sons.lua` | O som do jogo: imita o WebAudio (osciladores, ganho, ruído) e toca no Roblox com 5 sons base em laço (`audio/onda_*.ogg`), mudando a altura pela velocidade. |
| `src/cliente/DaRoca.client.lua` | O script do jogador: mostra a imagem, lê teclado, mouse, toque e controle, e liga a qualidade do Roblox à do jogo. |
| `src/servidor/DaRoca.server.lua` | Guarda o save de cada jogador no DataStore. |

## Controles

Ao abrir, aparece a página **COMO JOGAR** com cada botão no PC, no Xbox e no PlayStation (botão `?` no canto ou
**Exibir/Share** no controle para ver de novo).

| Ação | PC | Xbox | PlayStation |
| --- | --- | --- | --- |
| Andar | A / D ou ← → | Alavanca esquerda ou setas | Alavanca esquerda ou setas |
| Pular | Espaço | A | ✕ |
| Jogar papel | J | X | □ |
| Peidão | K | B | ○ |
| Dash | L ou Shift | RB | R1 |
| Falar, entrar e pegar | E ou Enter | Y | △ |
| Chamar o Reeis | R | LB | L1 |
| Bivolt | B | RT | R2 |
| Provocar | T | LT | L2 |
| Carro a gás | V | Apertar a alavanca (L3) | Apertar a alavanca (L3) |
| Pausa e menu | Esc | Menu | Options |

No celular, os botões são os do próprio jogo (o mesmo layout do celular).

## Qualidade gráfica

A qualidade que o jogador escolhe no menu do Roblox (**Configurações → Qualidade gráfica**) vira a qualidade do jogo:

- 1 a 3 → **BAIXA** · 4 a 7 → **MÉDIA** · 8 a 10 → **ALTA** · Automático → **AUTOMÁTICA** do jogo.

A ALTA do navegador usa WebGL, que o Roblox não tem; no Roblox ela fica igual à MÉDIA. A AUTOMÁTICA desce
sozinha para a BAIXA se o jogo ficar lento, como no navegador.

## O que só você pode fazer (conta e publicação)

1. **Conta no Roblox e o Roblox Studio** (Windows ou Mac). O Studio é grátis.
2. **Rojo** (programa grátis que leva estes arquivos para o Studio): instale o Rojo e o plugin do Rojo no Studio,
   rode `rojo serve` nesta pasta (`roblox/`) e clique em **Connect** no plugin. Sem o Rojo, dá para arrastar os
   arquivos para o Studio seguindo o `default.project.json`, mas é bem mais trabalhoso.
3. Os arquivos do jogo em Luau (`src/jogo`) **já vêm prontos** nesta pasta. Só se o jogo mudar e você quiser
   atualizar a versão do Roblox, gere de novo (precisa de Node.js):
   ```
   cd roblox
   npm install
   npm run converter
   # com o jogo aberto em http://127.0.0.1:8080 (python3 -m http.server 8080 dentro de dist/):
   node ferramentas/capturar.mjs
   ```
4. **Imagem editável (EditableImage)**: o jogo desenha na tela com ela. Para funcionar num jogo publicado, o Roblox
   exige que o dono da experiência tenha **13 anos ou mais e verificação de idade e de identidade (ID)** na conta.
   Também é preciso ligar **Game Settings → Security → Allow Mesh / Image APIs**.
5. **Save**: ligue **Game Settings → Security → Enable Studio Access to API Services** para testar o save no Studio.
   No jogo publicado o DataStore funciona sozinho.
6. **Publicar**: **File → Publish to Roblox**, depois deixe o jogo público na página da experiência.
7. **Som**: no Studio, abra **Asset Manager → Import** (ou **Bulk Import**) e envie os 5 arquivos da pasta
   `roblox/audio` (`onda_seno`, `onda_quadrada`, `onda_serra`, `onda_triangulo`, `onda_ruido`). Copie o ID de cada
   um (botão direito → Copy ID) e cole em `roblox/src/runtime/sons.lua`. Sem isso o jogo funciona, mas sem som.

## Atenção às regras do Roblox

O Roblox não permite referências a drogas e é rígido com cigarro e bebida. No jogo há o **Dedé Fumacinha** (fuma e
tem golpes de fumaça), o **Ollyan bêbado** no baile e a lenda do Seu Tião sobre o Dedé. Na versão do Roblox, essa
fala do Seu Tião já troca a droga por doce de leite automaticamente; o resto continua igual ao jogo e **pode ser
barrado pela moderação**. Se acontecer, me peça uma versão do Roblox com esses trechos suavizados.

## Limites conhecidos (versão de teste)

- **Memória**: no Roblox os pixels ficam em `buffer` (4 bytes por pixel), 4 vezes menos que numa tabela, e a
  tela vai direto para a imagem sem cópia. Os módulos que mais desenham usam código nativo (`--!native`).
- **Velocidade**: tudo é desenhado pixel a pixel em Luau. Nos testes em Lua 5.3 (mais lento que o Luau do
  Roblox), um quadro do jogo leva de 0,6 a 0,9 s. No Roblox deve ficar várias vezes mais rápido, mas ainda abaixo
  dos 60 quadros do navegador; a qualidade BAIXA ajuda bastante. Só dá para medir de verdade no Studio.
- **Som**: os efeitos do jogo (pulos, golpes, menus, chefes) já tocam no Roblox, imitando o som sintetizado do
  navegador, **depois que você enviar os 5 arquivos `roblox/audio/onda_*.ogg`** para a sua conta (passo 7 acima).
  As músicas em MP3 que você coloca em `dist/musicas` precisam ser enviadas uma a uma e ligadas pelo nome no
  `sons.lua` (envie só músicas que são suas ou que você tem direito de usar).
- **Interface**: telas que não foram fotografadas pelo `capturar.mjs` (a captura passa pela tela inicial, painel
  JOGAR, abertura, jogo, diálogo, pausa, DADOS, inventário, viagem e opções) podem aparecer sem a moldura.
- **Campos de texto**: no PC, digite normalmente; no celular, tocar num campo abre o teclado do Roblox. Para incluir mais telas, acrescente
  estados na lista `ESTADOS` do `capturar.mjs`.
- **Tamanho**: alguns módulos convertidos são grandes (o `vendor__pixelfx` tem cerca de 4 MB). O Studio pode
  demorar para abrir o lugar na primeira vez.
- **Online e multiplayer**: o modo online do navegador não funciona dentro do Roblox; a campanha é para um jogador.

## Testar fora do Roblox

Com o Lua 5.3 instalado (`apt install lua5.3`):

```
cd roblox
npm run converter:teste
lua5.3 teste/sessao.lua /tmp quadros:5 clique:#menuJogarBtn quadros:3 clique:#startBtn quadros:60 tela:jogo
```

Isso liga o jogo inteiro em Lua, aperta os botões e grava a tela em `/tmp/jogo.ppm`.

Fontes consultadas: documentação do Roblox sobre EditableImage (requisitos de idade e ID e a opção Allow Mesh /
Image APIs), DataStoreService, UserInputService e UserGameSettings; TypeScriptToLua (licença MIT).
