# Fases 0 e 1: diagnóstico e direção de arte

Documento de trabalho do plano em fases. Ele registra o estado do projeto, as referências pesquisadas e as regras de arte que valem daqui para frente.

## Fase 0: diagnóstico

### Engine e repositório

- **Engine:** nenhuma. O jogo é HTML + JavaScript puro com Canvas 2D, sem etapa de compilação. A Festa 3D usa Three.js.
- **Repositório:** `purcelld60-cloud/claude`. O jogo fica em `dist/`.
- **Site:** `https://purcelld60-cloud.github.io/claude/`, publicado a cada mudança na `main`.

### O que já existe

| Área | Estado |
| --- | --- |
| Campanha | Completa, com chefes, missões e dificuldades. Lógica em `game.js`, desenho em `art.js`. |
| Arena | Luta de plataforma com bots, física refeita nesta sessão. |
| Dupla e salas online | O código do cliente existe (`coop.js`, `arena-net.js`, `network.js`), mas o servidor (`worker/`) não veio no envio. Hoje só funciona treino com bots. |
| Festa 3D | Existe (`party*.js`), com rede própria que também depende do servidor ausente. |
| Minigames | Há atividades dentro da campanha (`activities.js`), mas não há um menu de minigames. |
| Cutscenes | Sistema próprio em `cinematics.js`, com roteiro dentro do código. |
| Música | Player e painel prontos (`music-player.js`), mas a biblioteca está vazia e o painel depende do servidor. |
| Gráficos | Três modos (Realista, Shader, Leve), cenário vivo, aves, vento, efeitos de chefe. |
| iOS | Projeto novo em `native/ios` e workflow que gera IPA sem assinatura. |
| Android e Android TV | Nada no repositório: `native/android` não veio no envio. |
| Roblox | Protótipo separado em `roblox/`, ainda não testado no Studio. |

### Problemas e riscos

1. **Toda a arte é desenhada por código.** Não existem arquivos de sprite: cada personagem é uma função com retângulos. Isso limita o quanto o visual pode subir e torna impossível um artista ou gerador de imagem trocar um desenho sem programar. É o maior limite para a fase 2.
2. **Linhas gigantes.** `game.js` e `art.js` têm linhas com milhares de caracteres. Qualquer mudança é arriscada e difícil de revisar.
3. **Sem testes automáticos.** Tudo é verificado jogando ou com robô de navegador.
4. **Servidor ausente.** Dupla online, salas, painel de músicas e modo TV dependem de um servidor que precisa ser escrito de novo.
5. **Shader atual é de tela inteira.** Ele trata o quadro pronto como uma foto. Luz dinâmica com normal map exige desenhar o jogo em camadas, o que pede uma mudança na forma de renderizar.
6. **Arquivos que não vieram:** dois efeitos de voz da Arena, as pastas `worker/`, `tools/` e `native/android`.

### O que não pode piorar

Controles, ritmo, hitboxes, tempos de ataque, dificuldade e o save `da-roca-adventure-v1`. Toda mudança visual continua separada da lógica, com o modo Leve como garantia para aparelhos fracos.

## Fase 1: referências

### Jogos de referência

| Jogo | O que torna o visual forte | O que aproveitar |
| --- | --- | --- |
| **Sea of Stars** | Luz dinâmica sobre pixel art, com hora do dia mudando em tempo real. A luz teve um programador dedicado por cinco anos e toda a produção foi adaptada a ela. | Ciclo de dia e noite que muda cor e sombra do cenário. É caro: escolher poucas luzes bem feitas. |
| **Dead Cells** | Personagens modelados em 3D e renderizados como sprites, o que dá animação fluida com um artista só. Cenários em pixel art ganham normal maps para receber luz dinâmica. | Normal maps nos cenários; animação com muitos quadros gerada por ferramenta em vez de desenhada quadro a quadro. |
| **Octopath Traveler (HD-2D)** | Sprites 2D em mundo com profundidade, com desfoque de distância, tilt-shift e ênfase em luz e sombra. | Desfoque leve nas camadas distantes e de primeiro plano; luz volumétrica. Os personagens continuam nítidos. |
| **Eastward** | Arte pixelada reconstruída em ambiente 3D, com mapas de relevo pintados à mão para a luz funcionar. Clima e hora do dia vêm dos shaders. | Luzes coloridas de lâmpadas, letreiros e janelas agindo sobre o cenário. |
| **Celeste** | Animação com amassar e esticar no pulo, poeira no pouso, pausa de poucos quadros e tremor mínimo no impulso. Sprites pequenos e muito legíveis. | Regras de "sensação de jogo": antecipação curta, pausa no impacto, tremor escalonado por tipo de evento. |
| **Hyper Light Drifter** | Paleta estreita, dominada por azul e roxo com neons, usada para destacar o que importa na jogabilidade. | Paleta limitada por fase, com uma cor de destaque reservada para perigo e outra para interação. |
| **Owlboy** | "Hi-bit": pixels menores e em maior número, sobretudo nos fundos, com várias camadas de parallax. Personagens definidos por forma e cor para se destacarem. | Fundos com mais camadas e mais detalhe que os personagens, sem competir com eles. |
| **Noita** | Cada pixel do mundo é simulado como areia, líquido ou gás. | Não copiar o motor. Aproveitar a ideia em pequenos efeitos: fogo que se espalha, água que reage, destroços. |
| **Children of Morta** | Animação quadro a quadro, arte pintada e luz moderna. Os sprites são ampliados cerca de 4 vezes para a luz ter resolução de jogo HD. | Calcular luz e efeitos em resolução maior que a do pixel art, mantendo os pixels nítidos. |

### Minigames e modo TV

- **Microjogos de 5 segundos (estilo WarioWare):** cada um dura cerca de 4 a 5 segundos e pede uma tarefa com um verbo só. Serve de modelo para uma sequência rápida de desafios.
- **Minigames de festa:** os melhores são curtos e decididos por habilidade, não por sorte, com formatos de equipe e de 3 contra 1.
- **Celular como controle (estilo Jackbox):** a tela compartilhada mostra o jogo, cada jogador entra por uma página web com um código de sala, sem instalar aplicativo.

### Candidatos de minigame

Todos com mecânica e arte próprias, no tema do jogo. Nenhum usa nome, personagem ou arte de terceiros.

| Minigame | Tipo | Ideia |
| --- | --- | --- |
| Corrida de carrinho de mão | Dupla competitivo | Corrida lateral com obstáculos da roça. |
| Cobrinha da colheita | Individual | Cobra que cresce colhendo milho, com galinhas atrapalhando. |
| Rebate na praça | Dupla competitivo | Rebater a bola entre duas raquetes, com vento e pombos desviando. |
| Quebra-caixotes | Individual ou cooperativo | Quebrar fileiras de caixotes com uma bola. |
| Memória da feira | Individual ou por turnos | Achar pares de cartas com itens do jogo. |
| Reflexo do monitor | Dupla competitivo | Apertar no instante certo; quem aperta antes perde. |
| Tiro ao alvo com estilingue | Individual ou alternado | Alvos móveis com vento. |
| Cabo de guerra | Dupla competitivo | Toques ritmados; lama no meio. |
| Esquiva da barrigada | Cooperativo | Sobreviver a ondas de ataques do Igor. |
| Pega-galinha | Dupla competitivo | Pegar mais galinhas no cercado em 30 segundos. |
| Sequência relâmpago | Individual ou dupla | Microdesafios de 5 segundos em sequência, cada vez mais rápidos. |
| Empilha-feno | Cooperativo | Soltar fardos no tempo certo para a pilha não cair. |

## Guia de direção de arte

### Resolução e pixels

- **Resolução base:** 480x270, ampliada por número inteiro (2x no canvas atual de 960x540). Um "pixel de arte" passa a ter 2x2 pixels de tela em tudo.
- **Uma densidade só:** personagens, cenário, efeitos e interface usam o mesmo tamanho de pixel. Nada de sprite ampliado ao lado de sprite fino.
- **Sem borrão:** ampliação sempre por vizinho mais próximo. Luz, névoa e brilho podem ser suaves, mas são calculados por cima e nunca filtram o sprite.

### Paleta

- **Paleta mestre de 48 a 64 cores**, com rampas de 5 tons por material (pele, tecido, madeira, pedra, folha, metal).
- **Sombra puxa para o frio, luz puxa para o quente.** Nada de escurecer com preto puro.
- **Uma paleta de clima por fase:** roça dourada, praça alaranjada, escola fria, noite azul e roxa.
- **Cores reservadas:** vermelho-alaranjado só para perigo; amarelo vivo só para o que é interativo ou recompensa.

### Sombreamento e contorno

- Luz principal vinda de cima e da esquerda em todos os sprites.
- Três a quatro tons por área, com dithering só em superfícies grandes de cenário.
- Contorno escuro colorido (não preto) nos personagens e sem contorno no fundo, para separar as camadas.
- Luz de recorte fina no lado oposto à luz principal nas cenas de chefe.

### Iluminação

- Sprites e tiles ganham **normal map** para receber luz dinâmica.
- Poucas luzes por cena (até 8 no alto, 4 no médio, nenhuma no baixo), sempre com cor: lâmpadas quentes, letreiros neon, fogo.
- Ciclo de dia e noite por fase, mudando a paleta de clima e o ângulo das sombras.
- Pós-processo: brilho, névoa por distância, desfoque leve só no fundo distante e no primeiro plano, vinheta.

### Animação

- **Quadros mínimos:** parado 4, andar 6, correr 8, ataque 5 a 7 (antecipação, golpe, recuperação), dano 2, morte 6.
- **Antecipação antes, exagero no impacto, recuperação depois.** Igor já segue essa regra.
- **Amassar e esticar** conservando a área do sprite.
- **Pausa de impacto** de 2 a 6 quadros conforme a força do golpe.
- **Tremor de câmera em três níveis** (leve, médio, forte), nunca aplicado à interface.
- **Partículas** em todo contato: poeira no pouso, faísca no golpe, folhas, estilhaços.

### Interface

- Fonte pixelada única para títulos e números; fonte limpa para textos longos.
- Painéis com moldura de 2 pixels de arte, cantos chanfrados e sombra deslocada.
- Barras de vida em blocos, com atraso de cor ao perder vida.
- Botões de toque translúcidos, com área de toque mínima de 44 pontos.
- Interface de TV: foco sempre visível, navegação só com as quatro direções e um botão.

### Limite da arte por código

O jogo hoje não tem arquivos de imagem. Para a fase 2, a proposta é criar um carregador de sprites: o jogo procura `assets/sprites/<nome>.png` (com `<nome>.json` de quadros) e, se não achar, usa o desenho por código atual. Assim dá para trocar arte sem mexer em código, vinda de artista ou de gerador de imagem.

## Fontes

- Sea of Stars: [entrevista com Thierry Boulanger (MobileSyrup)](https://mobilesyrup.com/2023/09/11/sea-of-stars-level-design-sabotage-studio-thierry-boulanger-interview/), [kit de imprensa da Sabotage](https://sabotagestudio.com/presskits/sea-of-stars)
- Dead Cells: [pipeline de arte dos personagens (80 Level)](https://80.lv/articles/case-study-dead-cells-character-art-pipeline), [entrevista com a Motion Twin (80 Level)](https://80.lv/articles/interview-with-the-developers-of-dead-cells)
- Octopath Traveler: [HD-2D (Wikipedia)](https://en.wikipedia.org/wiki/HD-2D), [entrevista sobre Octopath Traveler II (Unreal Engine)](https://www.unrealengine.com/en-us/developer-interviews/octopath-traveler-ii-builds-a-bigger-bolder-world-in-its-stunning-hd-2d-style)
- Eastward: [criadores de Eastward (Game Developer)](https://www.gamedeveloper.com/art/eastward-s-creators-share-insights-on-making-pixel-art-adventures), [Eastward (80 Level)](https://80.lv/articles/eastward-charming-chinese-pixel-art-adventure)
- Celeste: [transcrições do GMTK](https://huggingface.co/datasets/taesiri/GMTK-Transcripts/viewer/default/train?p=335), [por que Celeste é tão bom de jogar (Tildes)](https://tildes.net/~games/g4m/why_does_celeste_feel_so_good_to_play)
- Hyper Light Drifter: [AV Club](https://avclub.com/hyper-light-drifter-blended-past-and-present-to-become-1798255620), [Road to the IGF (Game Developer)](https://gamedeveloper.com/design/road-to-the-igf-heart-machine-s-i-hyper-light-drifter-i-)
- Owlboy: [Wikipedia](https://en.wikipedia.org/wiki/Owlboy), [gráficos para expressar personagem e tema (Game Developer)](https://gamedeveloper.com/art/using-graphics-to-express-character-and-theme-in-i-owlboy-i-)
- Noita: [palestra na GDC 2019 (GDC Vault)](https://gdcvault.com/play/1025695/Exploring-the-Tech-and-Design), [Wikipedia](https://en.wikipedia.org/wiki/Noita_(video_game))
- Children of Morta: [postmortem (Game Developer)](https://gamedeveloper.com/design/postmortem-children-of-morta), [como a Dead Mage criou a arte (TechRaptor)](https://techraptor.net/content/how-dead-mage-created-the-art-for-children-of-morta)
- Minigames e modo TV: [como WarioWare acertou a fórmula (GamesRadar)](https://www.gamesradar.com/warioware-inc-minigame-mania-rnailed-generations), [Microgame (Super Mario Wiki)](https://www.mariowiki.com/Microgame), [princípios de design da Jackbox (Built In)](https://builtin.com/articles/jackbox-games-design-party-pack), [melhores jogos de festa (TheGamer)](https://www.thegamer.com/best-party-games-not-mario-party/)

As conclusões sobre o que aproveitar em cada jogo são análise própria a partir dessas fontes. Em alguns casos (Celeste, Hyper Light Drifter) não foi encontrado material técnico dos próprios criadores, só análises de terceiros.
