# Orientações para agentes de programação

Este arquivo orienta GPT/Codex, Claude e outros agentes que editam Da Roça Adventure. Os direitos de uso são definidos por `LICENSE`; estas são orientações de manutenção.

## Comece pelo projeto real

1. Leia `README.md` e `docs/MODIFICAR-COM-IA.md`.
2. Identifique se está em uma cópia independente do ZIP ou no checkout oficial autorizado. A cópia pública não inclui `.openai/hosting.json`, credenciais nem chaves de assinatura.
3. Leia os arquivos envolvidos antes de alterar contratos entre módulos. A aplicação usa scripts globais e a ordem em `dist/index.html` faz parte desse contrato.
4. Faça a alteração solicitada, preservando o restante do jogo. Não substitua a aplicação por um protótipo ou por uma página de demonstração.

## Executar

- `python3 tools/dev-server.py` serve `dist/` em `http://127.0.0.1:8080`.
- Alternativa: `python3 -m http.server 8080 --bind 127.0.0.1 --directory dist`.
- Campanha e treino com bots funcionam localmente. Painel de trilhas e salas precisam de backend configurado.
- Para compilar o Worker sem SDK/APK base: `python3 tools/build-worker.py --web-only`.
- O projeto não depende de npm para executar o cliente. Não introduza um framework ou um processo de build sem uma necessidade da tarefa.

## Contratos que merecem cuidado

- Progresso da campanha: chave local `da-roca-adventure-v1`. Preserve campos antigos ao acrescentar dados; não limpe os saves como solução para um bug.
- Dificuldade Fácil: permanece travada naquele save depois de escolhida. Uma nova campanha inicia outro registro.
- Cronômetro: a edição dos controles e a pausa não devem contar como tempo ativo. Preserve o registro de dificuldade e a indicação de saves antigos com tempo parcial.
- Controles: teclado configurável e liberação de teclas/toques depois de diálogos, pausa e editores. Layouts de campanha e Arena são independentes e separados por orientação.
- Áudio: cada cutscene tem um relógio contínuo. Trocar de plano ou avançar uma fala não deve reiniciar o MP3. Preserve volume, silêncio, segundos iniciais, atrasos e transições.
- Arena: física e combate são confirmados pelo anfitrião; animação prevista e câmera não podem alterar vida, dano, acertos ou estoque de vidas. Preserve os golpes direcionais e a saída visual do 67, salvo pedido explícito para alterá-los.
- Personagens e pixel art: preserve identidades, roupas e proporções. Aica e os demais personagens devem ter membros proporcionais, sem duplicações.
- Cenários: decoração não cria colisões; alterações de chão ou plataformas precisam mudar renderização e física juntas.
- Desempenho: limite efeitos, partículas e caches. Não acrescente grandes filtros ou camadas opacas que escondam os ataques.

## Arquivos e validação

Consulte a tabela do README para encontrar o módulo correto. Depois de editar, rode `node --check caminho/do/arquivo.js` nos scripts alterados e teste o comportamento no navegador. Mudanças Python podem ser conferidas com `python3 -m py_compile caminho/do/script.py`.

Use testes que confirmem o comportamento afetado. Para mudanças visuais, veja o resultado real no jogo, em tamanho de desktop e celular; uma folha de sprites isolada não comprova a animação durante uma luta. Distinga testes em navegador, emulação de tela, compilação e teste em aparelho físico.

Ao adicionar ou renomear um arquivo do cliente, atualize `dist/index.html` e `dist/sw.js`. Ao preparar uma distribuição, regenere os pacotes correspondentes e verifique se contêm os arquivos atuais. Não edite `dist/server/index.js` manualmente: ele é gerado de `worker/` e `dist/`.

## Cópias independentes e publicação

Use a infraestrutura e a identidade de aplicativo que pertencem à cópia em que está trabalhando. Não copie um ID de hospedagem oficial para um novo projeto nem suponha acesso administrativo ao site original. Em um checkout oficial com publicação autorizada, preserve sua configuração e sua identidade existentes.

Para um fork Android independente, adapte identificador, atividade Java, origem HTTPS, certificado esperado e ferramentas que validam a identidade. Use uma chave própria, mantida fora do código. Para atualizar a instalação oficial, seria necessária a chave oficial do proprietário, obtida por um meio privado; ela não está no pacote público.

Não coloque senhas, tokens, keystores, chaves privadas, bancos, logs pessoais ou MP3 enviados ao painel dentro do código público. Preserve `LICENSE` e os avisos das dependências.
