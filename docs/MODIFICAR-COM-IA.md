# Modificar Da Roça Adventure com GPT, Claude ou manualmente

O pacote público contém os arquivos editáveis do jogo, os projetos Android/iOS, o backend e a documentação. A licença MIT permite modificar e redistribuir o trabalho original mantendo o aviso da licença. Consulte também [os avisos de terceiros](../THIRD_PARTY_NOTICES.md).

## Abrir e testar

1. Extraia o ZIP inteiro em uma pasta.
2. Abra essa pasta no editor de código ou na ferramenta de programação com IA. Se o serviço aceitar anexos, você também pode enviar o ZIP e pedir que comece por `README.md` e `AGENTS.md`.
3. No terminal dessa pasta, execute `python3 tools/dev-server.py`. No Windows, use `py -3 tools/dev-server.py` se necessário.
4. Abra `http://127.0.0.1:8080`, teste a campanha e o treino da Arena e confira o comportamento antes de mudar arquivos.
5. Faça uma cópia ou um commit antes de uma alteração maior. Edite, atualize o navegador e teste de novo.

Você não precisa de uma chave da OpenAI ou da Anthropic para executar o jogo. A ferramenta de IA que você escolher tem seu próprio acesso; ela apenas ajuda a editar os arquivos comuns do projeto.

## Um bom primeiro pedido para a IA

```text
Este é o código-fonte de Da Roça Adventure, sob licença MIT.
Leia README.md e AGENTS.md e identifique os módulos relacionados à tarefa.
Quero [descreva a alteração]. Preserve o resto da campanha, os saves, os
controles, o áudio contínuo das cutscenes e o estilo pixelado.
Implemente a mudança nos arquivos reais e execute testes adequados.
Explique quais arquivos mudou, como posso testar e o que não foi testado.
Estou trabalhando em uma cópia local; não publique no site oficial.
```

Troque a última frase se você estiver trabalhando na sua própria hospedagem e quiser publicá-la. Informe a URL e a configuração que realmente pertencem à sua cópia. Nunca envie senhas ou uma chave de assinatura em uma conversa pública.

## Exemplos de tarefas pequenas

```text
Melhore a decoração da praça sem mudar o chão, as plataformas ou os NPCs.
Use scene-details.js e confira a composição no jogo em 844×390 e no desktop.
```

```text
Quero acrescentar uma fala ao personagem Kaua. Localize os diálogos reais,
preserve as outras falas e teste abrir, avançar e fechar a conversa.
```

```text
Quero um botão maior para pular na campanha. Confira primeiro o editor
campaign-controls.js; preserve o layout já salvo e a separação por orientação.
```

```text
Refine o recuo do ataque à distância de Caleb na Arena, mantendo os mesmos
tempos, alcance e dano. Veja arena-art.js e os descritores de arena-combat.js.
Teste a pose durante um disparo real e não apenas num desenho isolado.
```

O [mapa do README](../README.md#onde-alterar-cada-parte) ajuda a selecionar os arquivos. Para uma tarefa maior, peça à IA que implemente em etapas que você consiga jogar e conferir.

## O que acompanha a cópia pública

O cliente está em `dist/`, o servidor em `worker/`, o banco em `drizzle/`, os aplicativos em `native/` e as ferramentas em `tools/`. O catálogo original fica em `dist/music/config.json`. Depois de clonar, rode `python3 .github/scripts/restaurar_trilhas.py` para recuperar e verificar as 12 músicas. O ZIP de distribuição com trilhas já vem com os arquivos. Fotos pessoais ficam fora do pacote. Os efeitos sonoros originais do jogo e suas informações de procedência continuam incluídos.

O pacote não contém o banco de jogadores, senhas do painel, tokens, arquivos `.env`, keystores, chaves privadas ou a identidade de hospedagem do projeto oficial. Ter o código de autenticação permite adaptá-lo à sua instalação; não concede uma sessão de administrador no serviço original.

## Fazer uma versão Android independente

Para testar visualmente, comece pelo navegador: não é preciso compilar um APK a cada alteração. Para distribuir uma cópia instalável própria, prepare Java 17/21, Python 3, Android SDK 35 e sua assinatura.

Antes de compilar uma distribuição independente, peça à IA para conferir estes pontos na sua cópia:

| Configuração | Onde conferir |
| --- | --- |
| Identificador do aplicativo, nome e atividade | `native/android/AndroidManifest.xml` |
| Declaração Java e caminho da classe da atividade | `native/android/src/br/com/daroca/adventure/MainActivity.java` e sua pasta |
| Origem HTTPS das atualizações e salas nativas | `HOST` em `MainActivity.java` |
| Origem e certificado das atualizações web | `dist/updates.js` |
| URLs de fallback das salas | `dist/arena.js`, `coop.js` e ponte `network.js` |
| Versão e URL de atualização | `dist/app-version.json`, `app-version.js` e manifesto Android |
| Validações da identidade oficial em ferramentas | `tools/ci-android.py`, `tools/prepare-apk-shell.py`, `tools/build-worker.py`, `native/package.py` |

Mudar somente o atributo `package` do manifesto pode deixar a atividade apontando para uma classe inexistente. Atualize a declaração e o caminho da classe Java de modo coerente, ou use o nome totalmente qualificado correto no manifesto. As ferramentas da distribuição oficial preservam a identidade oficial por desenho; adapte suas validações à identidade do fork.

Com o manifesto e o código preparados, configure no ambiente `DAROCA_KEYSTORE`, `DAROCA_KEY_ALIAS`, `DAROCA_STORE_PASSWORD`, `DAROCA_KEY_PASSWORD` e `DAROCA_CERT_SHA256` com sua própria chave. Mantenha os valores fora do repositório. Depois:

```sh
python3 native/android/build.py --bootstrap --game-dir dist --output build/meu-jogo.apk
```

`--bootstrap` prepara ferramentas públicas do SDK e do compilador; não cria uma chave. Consulte [as instruções de compilação](../native/android/README.pt-BR.md) para os requisitos completos.

Uma nova assinatura não atualiza a instalação oficial do APK. Usar outro identificador permite instalar a sua versão ao lado dela, com armazenamento próprio. Para o proprietário atualizar a instalação oficial preservando sua identidade, é necessária a chave oficial existente, mantida privadamente; ela nunca é incluída no código público.

O projeto iOS exige um Mac com Xcode, seu Bundle Identifier e sua assinatura Apple. Confira [native/ios/README.pt-BR.md](../native/ios/README.pt-BR.md), `Info.plist`, o projeto Xcode e as origens do serviço em `GameViewController.swift`.

## Serviços online e hospedagem

Um servidor estático basta para a campanha e o treino. Ele não fornece `/api/arena`, o painel de MP3, armazenamento de músicas ou geração de APK em nuvem.

Para gerar o Worker web sem APK nem SDK instalados:

```sh
python3 tools/build-worker.py --web-only
```

O resultado é `dist/server/index.js`. Hospede-o no seu serviço compatível, configure os bindings `DB` (D1) e `BUCKET` (R2) e aplique as migrações `drizzle/0000` a `0004` em ordem. A configuração da implantação oficial não acompanha o ZIP.

As salas públicas estão em `worker/arena.mjs`. A administração das músicas está em `worker/index.mjs` e espera autenticação de um proxy confiável. Se hospedar em outra plataforma, implemente a autenticação adequada e remova ou rejeite cabeçalhos de identidade fornecidos diretamente pelo visitante. `ADMIN_EMAILS` é uma autorização complementar, não uma autenticação por si só.

Defina os segredos de sua própria instalação no serviço, como `SESSION_SECRET` e, quando necessário, `BOOTSTRAP_TOKEN`. A geração nativa exige ainda seu APK base assinado e sua configuração privada de assinatura, incluindo `SIGNING_KEY_PKCS8`, `SIGNING_CERT_DER` e `CERT_SHA256`. O modo `--web-only` não prepara essa identidade nativa.

`tools/preview-music.mjs` é uma ferramenta de QA com identidade simulada e configuração local privada. Não a use como servidor administrativo público. Para uma configuração nova, adapte a autenticação, os bindings e os endereços reais da sua instalação.

## Conferir a alteração e compartilhar

- Teste os comandos envolvidos, incluindo soltar os botões, fechar diálogos e voltar da pausa.
- Veja o desenho no tamanho real em que se joga. Não confunda uma captura estática bonita com uma animação funcionando.
- Se alterou controles ou dados do jogador, confira um save já existente sem apagá-lo.
- Ao acrescentar um script do cliente, atualize sua ordem em `dist/index.html` e o cache em `dist/sw.js`.
- Preserve `LICENSE`, as licenças das fontes e de Three.js e os avisos dos novos arquivos que você acrescentar.
- Antes de distribuir um ZIP ou criar um repositório, confira que não incluiu senhas, arquivos de assinatura, dados pessoais ou gravações sem permissão de redistribuição.

Você pode compartilhar a cópia por ZIP ou publicar um repositório próprio, inclusive no GitHub. Informe suas mudanças e diferencie o que foi implementado, executado no navegador, compilado e testado num aparelho físico.
