# Roteiros: cutscenes em arquivos de dados

O jogo lê as cutscenes novas de arquivos JSON na pasta `dist/roteiros/`. Para criar ou mudar uma cena não é preciso programar: basta editar o texto do arquivo.

O motor fica em `dist/roteiro.js`. Ele usa a mesma caixa de fala do jogo, os mesmos botões CONTINUAR e "Pular história" e o mesmo relógio de música das outras cenas. Nenhum roteiro muda vida, dano, progresso ou controles.

## Os roteiros que já vêm no jogo

| Arquivo | Quando toca |
| --- | --- |
| `abertura.json` | Ao começar uma aventura nova, antes da história do bolo. Também toca ao rever a história. |
| `chegada_*.json` | Na primeira vez que você chega de carro em cada fase. Há chegadas para escola, academia, quadra, praça, favela, Caderno do Caos, campo, Bigodon, pátio e casa de Rayssa. |
| `creditos.json` | Depois da ligação do Jorge, no fim do capítulo 1. Toca uma vez por save. |

## Criar um roteiro novo em 3 passos

1. Copie um arquivo parecido, por exemplo `chegada_praca.json`, e dê um nome novo, como `minha_cena.json`.
2. Troque o `"id"` por um nome único, usando só letras minúsculas, números e `_`. Depois escreva as cenas.
3. Acrescente o nome do arquivo em `dist/roteiros/lista.json`.

Para ver o resultado sem jogar até lá, rode `python3 tools/dev-server.py` e abra `http://127.0.0.1:8080/?roteiro=minha_cena`.
- Clique ou aperte Enter para avançar; Esc fecha.
- Se o arquivo tiver erro, uma mensagem diz qual é. Ela também aparece no console do navegador.

Para o roteiro ir para o site e para os apps, mande o arquivo para o GitHub como qualquer outra mudança. Para ele funcionar sem internet logo na primeira visita, acrescente o nome também na lista `SHELL` de `dist/sw.js`. Os roteiros sempre buscam a versão mais nova quando há internet.

## Quando o roteiro toca

Use um destes campos no topo do arquivo:

| Campo | Exemplo | O que faz |
| --- | --- | --- |
| `antes` | `"antes": "intro"` | Toca logo antes de uma cena do jogo. |
| `depois` | `"depois": "jorge_epilogue"` | Toca logo depois de uma cena do jogo. |
| `chegada` | `"chegada": 4` | Toca quando o jogador chega de carro na fase 4. |
| `uma_vez` | `"uma_vez": true` | Toca só uma vez por save. |
| `substituir` | `"substituir": true` | Troca uma cena do jogo que tem o mesmo `id`. Use com cuidado. |
| `automatico` | `"automatico": true` | As falas passam sozinhas, sem clicar. |
| `musica` | `"musica": "maps.praca"` | Música da cena, com um dos nomes do painel de músicas. |

Cenas do jogo que aceitam `antes` e `depois`:
- `intro`, `outro`, `celebration`, `jorge_epilogue`;
- `boss_marco`, `boss_freddy`, `boss_dede`, `boss_arthur` e as outras apresentações de chefe;
- `dede_defeat`, `freddy_defeat`, `arthur_revenge`, `nicolas_reveal`, `reeis_recruit`, `marco_rage`, `easy_finish`.

Números das fases:

| Número | Fase |
| --- | --- |
| 0 | roça |
| 1 | escola |
| 2 | academia |
| 3 | quadra |
| 4 | praça |
| 5 | favela |
| 6 | Caderno do Caos |
| 7 | campo |
| 8 | Bigodon |
| 9 | pátio |
| 10 | casa de Rayssa |
| 11 | baile |

No campo `cenario` também vale escrever o nome: `"roca"`, `"escola"`, `"praca"`, `"patio"` e assim por diante.

## Cenas (planos)

Cada item de `"cenas"` é um plano com câmera, atores e falas.
- Uma cena **com falas** espera o jogador clicar em cada fala.
- Uma cena **sem falas** passa sozinha depois de `duracao` segundos.

```json
{
  "titulo": "PRAÇA CAMACAN",
  "cenario": "praca",
  "hora": 17.5, "hora_ate": 18.5,
  "duracao": 5,
  "camera": { "de": { "x": 1500, "y": 400, "zoom": 1 }, "para": { "x": 480, "y": 420, "zoom": 1.5 }, "tempo": 4 },
  "atores": [
    { "quem": "daroca", "x": 300, "ate": 520, "tempo": [0.5, 3] },
    { "quem": "reeis", "x": 640, "olhando": -1, "anim": "pulando" }
  ],
  "falas": [
    { "quem": "daroca", "texto": "Olha o chafariz!" },
    { "quem": "reeis", "texto": "OHHHH REEEEIS!", "emocao": "friend" }
  ],
  "efeitos": [ "vinheta", { "tipo": "cartao", "texto": "CAPÍTULO 2", "sub": "A PRAÇA", "t": 0.5, "dur": 3 } ],
  "sons": [ { "som": "sino", "t": 0.2 } ]
}
```

### Câmera

- **`x`**: o ponto do mapa no centro da tela, em pixels. Cada fase tem de 3600 a 7200 pixels de largura e o jogador começa perto de 230.
- **`y`**: a altura que fica parada quando a câmera aproxima. Use 400 a 430 para mirar nos personagens e 100 a 200 para mostrar o céu.
- **`zoom`**: proximidade. 1 é o jogo normal; 1.5, 2 e 2.5 aproximam e mantêm os pixels nítidos.
- **`de` e `para`**: a câmera vai de um ponto ao outro em `tempo` segundos.
- **`curva`**: `"suave"` (padrão) ou `"linear"`, que é bom para passar pela turma em fila.

### Hora do dia

- **`hora`**: de 0 a 24, por exemplo 5.5 para o nascer do sol e 18.3 para o pôr do sol.
- **`hora_ate`**: faz a hora correr durante a cena.
- Sem `hora`, vale a hora que o jogador escolheu.

### Atores

O campo `quem` aceita estes personagens: `daroca`, `lucas`, `nikolas`, `reeis`, `menezes`, `caleb`, `kaua`, `marco`, `ravid`, `mota`, `almiro`, `miqueias`, `davi`, `vitor`, `freddy`, `nicolas`, `dede`, `aica`, `ravile`, `arthur`, `allef`, `eloisa`, `giselle`, `rayssa`, `analaura`, `igor`, `kaique`, `ollyan` e `giant`. Use `carro` para o carro a gás com Da Roça montado.

Os outros campos do ator:

| Campo | O que faz |
| --- | --- |
| `x`, `y` | Posição no mapa. `y` 440 é o chão (padrão). |
| `ate`, `tempo` | Anda até o `x` de `ate` entre os segundos `[início, fim]` da cena. Com `pulo` (altura em pixels), vai pulando. |
| `olhando` | `1` (direita) ou `-1` (esquerda). Sem ele, o ator olha para onde anda. |
| `anim` | `andando`, `correndo`, `pulando`, `ataque`, `tremendo` ou `voando`. |
| `emocao` | `friend`, `sad`, `confused`, `embarrassed`, `greed` ou `taunted`, quando o personagem tem. |
| `escala` | Tamanho. 1 é o normal. |
| `aparece`, `some` | O ator surge ou desaparece num segundo da cena. |
| `camada` | Quem fica na frente: número maior fica na frente. |

### Falas

- **`quem`**: escolhe o retrato e o nome. Use `narrador` para fala sem retrato.
- **`nome`**: troca o nome mostrado.
- **`emocao`**: muda a expressão no retrato.
- **`retrato`**: `false` esconde o retrato.
- **`titulo`**: troca o título no alto da tela só nessa fala.

O texto aparece letra por letra. O primeiro clique mostra tudo; o segundo avança.

### Efeitos

Escreva só o nome (`"vinheta"`) ou um objeto com tempo (`{ "tipo": "flash", "t": 1.2 }`). `t` é o segundo da cena em que começa e `dur` é quanto dura.

| Tipo | O que faz |
| --- | --- |
| `entrada` / `saida` | Escurece no começo ou no fim da cena. |
| `cartao` | Faixa grande no meio da tela com `texto` e `sub`; `y` muda a altura. |
| `letreiro` | Placa que desliza da esquerda (`texto` e `sub`), boa para nome de lugar. |
| `texto` | Onomatopeia grande na tela: `texto`, `x`, `y`, `cor`, `tamanho`. |
| `flash` | Clarão branco. Use `"cor": "vermelho"` para um clarão vermelho. |
| `tremer` | Tremor de câmera, com intensidade em `forca`. |
| `zoom_soco` | Aproximação rápida de impacto. |
| `vinheta` | Bordas escuras. |
| `memoria` | Tom sépia de lembrança. |
| `noite` | Tom azul de noite. |
| `confete`, `coracoes`, `brilhos`, `folhas`, `chuva`, `raios` | Partículas e luz por cima da cena. |

### Sons

`"sons": [{ "som": "sino", "t": 0.5 }]` toca o som no segundo `t` da cena. Os sons são sintetizados: não precisam de arquivo e só tocam com o som do jogo ligado.

Os sons disponíveis são: `sino`, `plim`, `impacto`, `whoosh`, `passos`, `trovao`, `buzina`, `galo`, `tambor`, `fanfarra`, `misterio` e `risada`.

## Dicas e erros comuns

- JSON não aceita vírgula depois do último item de uma lista, e todo texto precisa de aspas duplas. Um validador on-line de JSON ajuda a achar o erro.
- Cada roteiro precisa de um `id` diferente. Se o `id` for igual ao de uma cena do jogo sem `"substituir": true`, o roteiro é ignorado e o aviso aparece no console.
- Os roteiros marcados como vistos ficam no save, no campo `q.roteiros`. Apagar o save faz eles tocarem de novo. Também dá para criar outra aventura.
