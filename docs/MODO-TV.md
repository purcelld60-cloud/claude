# Modo TV: a TV mostra o jogo e o celular é o controle (Fase 8)

Funciona como os jogos de festa em que cada pessoa joga pelo próprio celular: a TV mostra o jogo e um código, e cada celular vira um controle.

## Como jogar na Android TV

1. **Instale o APK na TV.** Baixe `DaRoca.apk` em Releases (o mesmo APK serve para celular e TV). Para pôr na TV:
   - pelo pendrive, com um gerenciador de arquivos; ou
   - pelo app "Downloader".

   Permita "instalar apps desconhecidos" e abra **Da Roça** no menu da TV. Ele aparece com o banner, na fileira de apps.
2. No menu inicial, escolha **📺 MODO TV**. A TV mostra o código da sala, um QR code e um endereço como `192.168.0.15:8787`.
3. **Em cada celular, na mesma rede Wi-Fi da TV:** aponte a câmera para o QR code, ou abra o endereço no navegador e digite o código. Escreva o nome e toque em **ENTRAR**. Até 4 celulares: P1, P2, P3 e P4.
4. Toque em **PERSONAGEM** para escolher quem você é. São 14 personagens da turma.
5. O **P1** escolhe o jogo com o direcional e o A do celular. O controle remoto da TV também funciona: setas e OK.

Não precisa de internet nem de conta: o servidor roda dentro do app da TV e tudo acontece na rede da casa.

## O controle no celular

- **Direcional:** arraste o dedo no círculo; vale as 8 direções.
- **A e B:** botões grandes.
- **Vibração:** curta a cada toque. Também vibra quando o jogo avisa: batida, derrota ou vitória.
- **Status:** o topo mostra o seu número (P1 a P4) na sua cor e o que a TV está mostrando.
- **Tela acesa:** a tela fica ligada durante o jogo e o controle reconecta sozinho se a internet do celular piscar.
- **Baixa latência:** cada toque é enviado na hora, sem esperar.

## Jogos com 2 a 4 jogadores

| Até 4 jogadores | Até 2 jogadores |
| --- | --- |
| Minhoca do Cafezal, Tiro ao Alvo no Açude, Reflexo do Galo, Chuva de Chinelo, Subida do Morro e Memória da Feira | Pingue-Pongue, Quebra-Caderno, Cabo de Guerra e Corrida da Estradinha |

Num jogo de até 2 com mais gente conectada, jogam P1 e P2. Com só um celular, o jogo é no modo sozinho.

## Sem Android TV (TV com computador ou Chromecast)

O modo TV também funciona no navegador, com o servidor online da Fase 7 (`docs/SERVIDOR-ONLINE.md`):

1. Abra o jogo pelo endereço do servidor na tela grande, ou no computador ligado à TV.
2. Entre em **MODO TV**.
3. O QR code leva os celulares para `endereço-do-servidor/controle.html`.

Pela internet a resposta é um pouco mais lenta do que na rede de casa.

## Como funciona (para quem mexe no código)

| Arquivo | Função |
| --- | --- |
| `native/android/.../TvServer.java` | Servidor HTTP e WebSocket dentro do app, na porta 8787 (ou a próxima livre até 8797). Serve `controle.html` aos celulares e repassa os comandos para a TV, com o mesmo protocolo do servidor online. |
| `MainActivity.java` | Liga o servidor, descobre o IP da TV na rede e abre o jogo com `?tvport=` e `tvip=`. |
| `dist/fliperama.js` | Lobby da TV (código, QR, endereço e cartões P1 a P4). Os comandos de cada celular entram como P1 a P4. Avisos e vibração vão para os celulares. |
| `dist/controle.html`, `controle.js`, `controle.css` | O controle no celular. |
| `dist/vendor/qrcode.js` | Gerador de QR code (licença MIT, Kazuhiko Arase). |

## Limites honestos

- **Testes:** o jogo na TV e o controle foram testados no navegador do computador, com 1 tela de TV e 3 celulares simulados. O app foi compilado, mas **não foi testado numa Android TV de verdade**. Se algo não abrir na sua TV, me conte o modelo.
- **Arena e campanha em dupla:** com celular como controle, isso ainda não foi feito. Na TV, a Arena continua com os controles normais ou com a Arena online.
- **Rede da escola ou de empresa:** se a rede bloquear a conversa entre aparelhos ("isolamento de clientes"), os celulares não acham a TV. Na rede de casa isso costuma funcionar.
