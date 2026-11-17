# Da Roça Adventure

> **Sobre este repositório:** ele contém a pasta `dist/` (o jogo completo para navegador) e a documentação. As pastas `worker/`, `drizzle/`, `native/` e `tools/` do pacote original ainda não foram incluídas, então por enquanto use a alternativa com `python3 -m http.server` abaixo:
>
> ```sh
> python3 -m http.server 8080 --bind 127.0.0.1 --directory dist
> ```
>
> Arquivos reconstruídos nesta cópia, porque não vieram no envio: `dist/updates.js` (aviso de nova versão), `dist/music/config.*` (biblioteca vazia), `dist/icon.svg` e os ícones em `dist/assets/`. As fontes Silkscreen e Space Grotesk (SIL OFL 1.1) e a Three.js r159 (MIT) foram obtidas das versões públicas oficiais. Os dois efeitos de voz da Arena (`assets/sfx/biuriful.mp3` e `gugu-dada.mp3`) não estão incluídos; o jogo segue sem eles.

Jogo 2D em pixel art, com campanha, chefes, missões, Arena da Resenha, Dupla online e Festa da Roça 3D. O código original está disponível sob a [licença MIT](LICENSE): você pode estudar, modificar, distribuir e usar comercialmente, mantendo o aviso de copyright e a licença.

O projeto usa HTML, CSS, JavaScript, Python e um Worker JavaScript. A campanha e o treino da Arena não precisam de uma API de IA, conta do ChatGPT ou credenciais para rodar localmente. GPT, Codex e Claude podem ajudar a editar os mesmos arquivos que você editaria manualmente.

## Jogar e modificar no computador

Extraia o pacote completo, abra um terminal na pasta que contém este README e use Python 3.10 ou mais recente:

```sh
python3 tools/dev-server.py
```

No Windows, se necessário:

```bat
py -3 tools/dev-server.py
```

Abra **http://127.0.0.1:8080**. O servidor serve a pasta `dist`, sem instalar pacotes. Para encerrar, use `Ctrl+C`. Uma alternativa equivalente para o jogo estático é:

```sh
python3 -m http.server 8080 --bind 127.0.0.1 --directory dist
```

Edite os arquivos e atualize a página. Não existe etapa de compilação para testar a campanha no navegador. O endereço local tem seu próprio progresso, separado do site oficial e do aplicativo. O servidor local estático não implementa o painel de músicas nem o serviço de salas online; o treino com bots continua disponível.

Veja o [guia para modificar com IA](docs/MODIFICAR-COM-IA.md), as [orientações de contribuição](docs/CONTRIBUTING.md) e o [mapa para agentes de programação](AGENTS.md).

## Onde alterar cada parte

| Parte | Arquivos principais |
| --- | --- |
| Página, menu e aparência | `dist/index.html`, `style.css`, `theme.css`, `menu.js`, `menu.css`, `safari.css` |
| Campanha, controles de jogo e renderização | `dist/game.js` |
| Mapas, personagens e progressão | `dist/world.js`, `campaign.js`, `progression.js`, `world-life.js`, `activities.js` |
| Dificuldade e cronômetro | `dist/difficulty.js`, `campaign-run.js` |
| Pixel art, cenários e efeitos | `dist/art.js`, `scene-details.js`, `campaign-vfx.js` |
| Cutscenes e final | `dist/cinematics.js`, `epilogue.js`, `easy-ending.js`, `baile.js`; roteiros em dados: `dist/roteiro.js` + `dist/roteiros/*.json` (guia em `docs/ROTEIROS.md`) |
| Teclado, joystick, botões e pausa | `dist/controls.js`, `control-settings.js`, `joystick.js`, `campaign-controls.js`, `pause-menu.js` e respectivos CSS |
| Arena e seus personagens | `dist/arena.js`, `arena-roster.js`, `arena-combat.js`, `arena-motion.js`, `arena-art.js`, `arena-controls.js` |
| Transporte das salas e Dupla | `dist/arena-net.js`, `network.js`, `coop.js`, `worker/arena.mjs` |
| Festa 3D | `dist/party*.js`, `party.css`, `dist/vendor/three.min.js` |
| Músicas, painel e atualizações | `dist/music-player.js`, `music-contexts.js`, `admin.js`, `cutscene-preview.js`, `updates.js` |
| Servidor, APK automático e validação MP3 | `worker/index.mjs`, `apk.mjs`, `digest-stream.mjs`, `mp3.mjs` |
| Servidor online próprio (Arena, Dupla e Fliperama online) | `server/server.js`, `dist/online.js`, `dist/servidor.json` (guia em `docs/SERVIDOR-ONLINE.md`) |
| Fliperama (10 minigames, sozinho, dupla e online) | `dist/fliperama.js`, `dist/fliperama.css` (guia em `docs/FLIPERAMA.md`) |
| Modo TV: TV anfitriã e celular como controle | `dist/controle.html`, `controle.js`, `native/android/.../TvServer.java` (guia em `docs/MODO-TV.md`) |
| Banco do servidor | Migrações SQL em `drizzle/`, na ordem numérica |
| Aplicativos Android e iOS | `native/android/`, `native/ios/` |
| Empacotamento e ferramentas | `tools/`, `native/package.py` |

Os módulos JavaScript usam objetos em `window` e são carregados na ordem de `dist/index.html`; não são módulos npm. Preserve as dependências ao acrescentar scripts. O cache offline é definido em `dist/sw.js`.

## Conteúdo do código-fonte público

O pacote inclui o cliente, o painel administrativo, o código do servidor, as migrações, os projetos nativos, ferramentas, documentação e avisos de terceiros. O acervo de MP3 enviado ao site não acompanha o código; a configuração de músicas da cópia pública começa vazia.

Não fazem parte do pacote: senhas, chaves de assinatura, tokens, dados de jogadores, banco do site, pastas locais de trabalho, identidade de hospedagem da implantação oficial e binários gerados. Isso não impede editar ou executar a campanha. Serviços online e builds assinados usam a configuração da sua própria instalação.

## Hospedar uma cópia

O jogo estático pode ser publicado em uma hospedagem web. Para gerar o Worker a partir de uma cópia limpa, sem Android SDK nem APK pronto:

```sh
python3 tools/build-worker.py --web-only
```

A saída é `dist/server/index.js`. O modo web não fornece um APK nativo base nem uma identidade de assinatura. Para usar salas, painel e armazenamento, configure seu próprio serviço com banco D1, bucket R2, migrações e autenticação. Leia [a seção de serviços do guia](docs/MODIFICAR-COM-IA.md#serviços-online-e-hospedagem).

A autenticação administrativa do Worker original espera uma identidade inserida por um proxy autenticador confiável. Em outra plataforma, adapte essa autenticação e rejeite os cabeçalhos de identidade enviados diretamente pelo cliente. Apenas definir um e-mail administrador não substitui o autenticador.

O ZIP público não contém um ID de projeto da hospedagem oficial. Nenhuma cópia deve inferir acesso administrativo ao serviço original a partir dos endereços públicos presentes no código.

## Android e iPhone

O Android é uma WebView nativa com os arquivos locais do jogo. A compilação Linux usa Python 3, Java 17/21 e Android SDK 35. [As instruções Android](native/android/README.pt-BR.md) explicam os comandos e as variáveis de assinatura. Para uma distribuição independente, ajuste o identificador, os endereços de serviço e o certificado esperado na sua cópia, e use uma chave própria. A chave do aplicativo oficial não faz parte do código-fonte.

O projeto iOS exige macOS, Xcode e sua assinatura Apple. Consulte [o README iOS](native/ios/README.pt-BR.md). Ter o código não significa que um IPA assinado esteja incluído.

## Licenças

O código original, a documentação e a arte procedural original do projeto usam MIT, salvo indicação específica em outro arquivo. Three.js e as fontes mantêm suas próprias licenças. MP3 e fotos adicionados separadamente pelos usuários não recebem automaticamente a licença MIT do programa. Veja [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).

Um repositório no GitHub é opcional: a licença e o pacote completo permitem modificar o jogo sem ele. Se publicar sua própria cópia em um repositório, mantenha `LICENSE` e os avisos de terceiros junto do código.
