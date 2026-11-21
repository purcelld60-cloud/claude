# Músicas e áudio (Fase 9)

Para pôr música no jogo você não precisa mexer em código: basta colocar o arquivo na pasta e dizer onde ele toca.

## Trilha original da campanha

O catálogo da edição 3.12.1 guarda as 12 gravações, os volumes e as 48 associações originais. Entre elas estão as músicas da favela, do pátio, dos chefes e da ligação de Jorge. Na ligação, a faixa começa em 1min52s e continua tocando entre os planos. O menu usa o tema da roça até você configurar uma faixa para `menu`. A Arena sorteia músicas da biblioteca.

Em uma cópia recém-clonada, execute na raiz do projeto:

```sh
python3 .github/scripts/restaurar_trilhas.py
```

O script baixa do site original apenas as gravações ausentes ou danificadas e confere tamanho e SHA-256 antes de gravar. Quem já tem o APK 3.12.1 pode usar `python3 .github/scripts/restaurar_trilhas.py --apk caminho/DaRoca.apk` sem internet. O ZIP completo com trilhas já traz os MP3 em `dist/music/`.

Os fluxos de publicação preparam os mesmos arquivos para o site e os aplicativos. No APK, as faixas tocam direto do pacote. No site, o primeiro toque ou tecla libera o áudio. Ao abrir a versão instalada na Tela de Início com conexão, o jogo guarda as trilhas originais para tocar offline. Uma associação personalizada em `musicas.txt` tem prioridade no lugar escolhido.

## Adicionar uma música, passo a passo (dá para fazer pelo celular)

1. No GitHub, abra a pasta **`dist/musicas`** do repositório.
2. Toque em **Add file → Upload files** e envie o arquivo: `.mp3`, `.ogg` ou `.m4a`, de preferência com até 15 MB.
3. Diga onde ele toca, de um destes dois jeitos:
   - **Jeito rápido:** dê ao arquivo o nome do lugar. Por exemplo `roca.mp3` toca na roça e `chefe-marco.ogg` toca na luta contra o Marco.
   - **Jeito com opções:** abra **`dist/musicas/musicas.txt`**, toque no lápis (editar) e escreva uma linha, por exemplo:
     ```
     roca = tema-da-roca.mp3
     chefe-marco = batalha.ogg volume=0.8 fade=2
     ```
4. Toque em **Commit changes**.
5. Espere uns 5 minutos. O GitHub gera sozinho:
   - o **site**, já atualizado;
   - o **APK** (Android e Android TV) e o **IPA** (iPhone), que aparecem em **Releases**: `android-bN` e `ios-bN`.
6. **Baixe e instale.**
   - **Android:** abra o release mais novo e baixe `DaRoca.apk`.
   - **iPhone:** pelo Safari, baixe `DaRoca.ipa` e abra no seu instalador de IPA.

Se algo estiver errado (arquivo que não está na pasta, lugar com nome errado), o aviso aparece em **Actions → Lista de músicas** e o jogo continua funcionando, só sem aquela música.

## Lugares

| Lugar | Quando toca |
| --- | --- |
| `menu`, `pausa`, `derrota`, `fim`, `comemoracao` | menu inicial, pausa, quando perde, fim do capítulo, festa do açaí |
| `roca`, `escola`, `academia`, `quadra`, `praca`, `favela`, `caderno`, `campo`, `bigodon`, `patio`, `rayssa`, `baile` | cada fase da campanha (`caderno` é o Reino de Tinta) |
| `sala-almiro`, `sala-miqueias` | salas de aula |
| `jantar-amanda`, `conversa-amanda` | jantar na Varanda do Cacau e conversa com Amanda na praça, respectivamente |
| `chefe-marco`, `chefe-menezes`, `chefe-nikolas`, `chefe-reeis`, `chefe-freddy`, `chefe-nicolas`, `chefe-dede`, `chefe-arthur`, `chefe-colosso`, `chefe-igor`, `chefe-kaique`, `chefe-ollyan` | luta contra cada chefe |
| `chefe-nikolas-fase2` e outras fases | uma fase específica da luta |
| `apresentacao-marco` e outros chefes | a cutscene antes de cada chefe |
| `cutscene-abertura`, `cutscene-intro`, `cutscene-creditos`, `cutscene-chegada_praca`... | cutscenes; a música não reinicia ao avançar as falas |
| `arena`, `arena-menu`, `arena-resultado` | Arena online |
| `dupla`, `dupla-marco`... | Dupla online |
| `fliperama`, `fliperama-minhoca`, `fliperama-pong`, `fliperama-quebra`, `fliperama-cabo`, `fliperama-chinelo`, `fliperama-galo`, `fliperama-memoria`, `fliperama-tiro`, `fliperama-corrida`, `fliperama-subida` | menu do fliperama e cada minigame |
| `conversa-davi`, `conversa-lucas`... | durante a conversa com alguém |
| `ambiente-roca`, `ambiente-praca`, `ambiente-favela`... | som de fundo da fase, no lugar do ambiente que o jogo faz sozinho |

Para quem conhece o código, um nome com ponto vale como lugar direto do tocador, por exemplo `battles.marco.phase2`.

## Opções no fim da linha

| Opção | O que faz |
| --- | --- |
| `volume=0.8` | volume da faixa, de 0 a 1 |
| `fade=2` | segundos de transição ao entrar e sair |
| `inicio=12` | começa no segundo 12 |
| `atraso=1` | espera 1 s antes de começar (só em cutscenes) |
| `sem-repetir` | toca uma vez e para (o padrão é repetir sem corte) |

## Volume, efeitos e ambiente

- **Pausa:** barras de **MÚSICA** e **EFEITOS** (de 0 a 100%) e a opção **SOM DE AMBIENTE**. Ficam salvas no aparelho.
- **Efeitos:** golpes, cutscenes, fliperama, objetos que quebram, portas, alavancas, poças e fogo obedecem à barra de efeitos.
- **Ambiente de cada fase**, feito pelo próprio jogo, sem arquivo:

  | Fase | Som de fundo |
  | --- | --- |
  | roça | passarinhos e vento (grilos à noite) |
  | praça | rio |
  | quadra e campo | torcida e apito |
  | escola, pátio e favela | conversa ao longe |
  | academia | ferros |
  | Reino de Tinta | zumbido sombrio |
  | Bigodon | máquina de cortar cabelo |
  | casa da Rayssa | relógio |

  A chuva entra por cima quando chove.

## Por dentro (para quem mexe no código)

| Parte | Arquivos |
| --- | --- |
| Leitura da pasta | `dist/musicas.js`: lê `musicas/lista.json` (ou `lista.js` no app do iPhone) e o `musicas.txt`, e monta as faixas e os lugares. |
| Tocador | `dist/music-player.js` junta isso à configuração que já existia: duas vozes, transição suave e relógio contínuo nas cutscenes. Tudo que estiver no `musicas.txt` manda nos lugares. |
| Lista de arquivos | `.github/scripts/musicas.py` gera a lista. Os workflows do site, do APK e do IPA rodam o script antes de empacotar, e o workflow **Lista de músicas** atualiza a lista no repositório. |
| Volumes, efeitos e ambiente | `dist/audio.js` |

## Direitos autorais

Use só músicas suas, compradas com licença para jogos ou de uso livre (por exemplo Creative Commons que permita uso em jogo, com o crédito pedido pelo autor). Música de artista famoso sem permissão pode fazer o site ou o app serem derrubados.
