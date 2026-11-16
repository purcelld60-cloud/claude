# Da Roça Adventure no Roblox (protótipo)

Esta pasta contém uma primeira versão jogável do Da Roça Adventure para o Roblox. Ela foi reescrita em Luau, a linguagem do Roblox, porque o Roblox não roda o código do jogo do navegador.

## O que já tem

- **Câmera lateral** como no jogo 2D: todo mundo anda numa pista só, para a esquerda e para a direita.
- **Fase completa em blocos:**
  - **Roça:** casinha com fumaça na chaminé, cerca, milharal, vacas, árvores e galinhas.
  - **Rio:** tábuas e uma balsa que vai e volta. Quem cai na água volta para a última bandeira.
  - **Estrada:** postes e ponto de ônibus.
  - **Praça:** prédios com janelas acesas, chafariz, bancos, postes com luz, pombos e caixotes.
  - **Escola:** arquibancada com torcida pulando e holofotes.
- **Luz de fim de tarde** com névoa, brilho e raios de sol.
- **Cenário vivo:**
  - Galinhas e pombos bicam o chão e fogem voando quando você chega perto.
  - Folhas e mato balançam com o vento.
- **Controles:**
  - Pulo duplo, com anel de ar no segundo pulo.
  - Soco com rastro de luz e faíscas ao acertar.
- **Valentões** que patrulham, perseguem e batem. Cada um aguenta 3 socos e volta depois de um tempo.
- **Igor, o chefe:**
  - Pulo de barriga com as mesmas poses da campanha: agacha com os braços para trás, solta os braços na subida, abre na descida e pousa amortecendo.
  - Antes do pulo, uma sombra em pixels marca onde ele vai cair.
  - No pouso, uma onda de blocos do chão se levanta para os dois lados e o chão racha.
  - Com metade da vida, ele fica **furioso**: dá dois pulos seguidos e às vezes rola como uma bola de barriga. Use o pulo duplo para passar por cima.
- **Barra de vida do chefe**, faixa de apresentação, tela de vitória com confete e bandeiras de ponto de controle.
- **Multijogador:** vários jogadores podem enfrentar o Igor juntos.

## Como abrir e testar (precisa de um computador)

O Roblox Studio só existe para Windows e Mac. Não dá para criar jogos de Roblox pelo celular.

1. Instale o **Roblox Studio** pelo site oficial do Roblox (create.roblox.com) e entre com sua conta.
2. Baixe o arquivo [`DaRocaAdventure.rbxlx`](DaRocaAdventure.rbxlx) desta pasta. No GitHub, abra o arquivo e use o botão de baixar (*Download raw file*).
3. No Roblox Studio, use **File → Open from File** e escolha o arquivo baixado.
4. Aperte **Play** (ou F5). O mapa é montado na hora em que o jogo começa.

**Controles:**
- No computador: **A/D** para andar, **Espaço** para pular (aperte de novo no ar para o pulo duplo), **F** ou **clique** para socar.
- No celular: analógico, botão de pulo e botão **SOCO**.

**Para testar com mais de uma pessoa:** use a aba **Test → Clients and Servers**, com 2 jogadores.

## Publicar no Roblox

1. Com o lugar aberto, use **File → Publish to Roblox**.
2. Dê nome e descrição e escolha o gênero.
3. Em **Game Settings**:
   - Libere **Phone/Tablet**.
   - Em **Permissions**, deixe o jogo **Public** quando quiser que outras pessoas joguem.
4. O Roblox vai pedir o **questionário de maturidade** (Experience Questionnaire). Responda com sinceridade. Este protótipo tem só socos com estilo de desenho, sem sangue e sem armas.

**Cuidados com as regras do Roblox:**
- Não use nomes, fotos ou o rosto de pessoas reais sem a permissão delas.
- Não coloque bebidas alcoólicas nem armas de fogo.
- Por isso o baile e alguns itens do jogo do navegador não foram trazidos.

## Como mudar

Os scripts ficam em `src/`:

| Arquivo | O que faz |
| --- | --- |
| `src/server/Mundo.server.lua` | Monta o mapa, a luz, as bandeiras e o nascimento. |
| `src/server/Combate.server.lua` | Cuida do soco, dos valentões e do Igor (vida, ataques e poses). |
| `src/client/Cliente.client.lua` | Câmera, pulo duplo, efeitos, aves, torcida, balsa e tela. |

Depois de mudar um script, gere o arquivo de novo:

```sh
python3 roblox/tools/gerar_rbxlx.py
```

Quem usa o [Rojo](https://rojo.space) pode sincronizar a pasta direto com o Studio usando `default.project.json`.

## O que ainda falta

- **Sons:** o Roblox só toca áudios enviados para a plataforma, então as músicas do jogo precisam ser enviadas por você.
- Os outros chefes, as cutscenes e a Arena.
- **Animações próprias do herói:** por enquanto, o soco move o braço do avatar do jogador.

Este protótipo ainda não foi testado dentro do Roblox Studio, porque não há Roblox Studio onde ele foi escrito. Se aparecer um erro vermelho na janela **Output** do Studio, mande uma foto do erro que eu corrijo.
