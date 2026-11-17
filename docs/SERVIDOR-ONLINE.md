# Servidor online (Fase 7)

**Servidor oficial deste repositório:** `https://daroca-online.onrender.com`, no plano grátis do Render, publicado a partir do `main`. O site do GitHub Pages, o APK e o IPA já usam esse endereço (`dist/servidor.json`). O plano grátis dorme depois de 15 minutos sem uso; o primeiro acesso leva cerca de 1 minuto para acordar.

O código do servidor fica em `server/server.js`. É um único programa em Node.js que faz três coisas:

1. **Serve o jogo.** Quem abre o endereço do servidor joga com o online já ligado, sem configurar nada.
2. **Atende a Arena online (2 a 4 jogadores) e a Dupla online (chefes em dupla)**, que antes só funcionavam no site oficial.
3. **Abre um WebSocket** para o **Fliperama online**: os 10 minigames em dupla, cada pessoa no seu aparelho. O modo TV com celular como controle, da Fase 8, vai usar o mesmo WebSocket.

## Por que Node.js com WebSocket

- O jogo é web (HTML e JavaScript). Com Node.js, o servidor fala a mesma língua do jogo e cabe num arquivo só.
- O WebSocket é a forma mais leve de trocar mensagens em tempo real pelo navegador, pelo app Android e pelo iPhone. Funciona em qualquer hospedagem comum.
- Colyseus e Photon trariam mais peso, contas e limites. Mirror só serve para Unity.
- A Arena e a Dupla já usavam um protocolo de salas por HTTP. O servidor implementa esse mesmo protocolo, então esses modos funcionam sem mudar o código deles.

## O que o servidor faz

| Recurso | Como funciona |
| --- | --- |
| Salas com código | 6 letras e números sem caracteres que confundem (sem O, 0, I e 1). |
| Lobby | Arena e Dupla: a lista de jogadores, o "estou pronto" e o personagem escolhido. Fliperama: a tela com o código e os dois jogadores. |
| Matchmaking simples | **SALA RÁPIDA** na Arena online e no Fliperama online: entra numa sala aberta ou cria uma. |
| Sincronização | Quem cria a sala é o anfitrião e roda a partida. Os outros mandam só os comandos. No fliperama, o estado vai 30 vezes por segundo. |
| Lag | Mostra o ping. Na Arena, o jogo já fazia previsão local e conexão direta entre aparelhos (WebRTC), e o servidor faz a sinalização. |
| Desconexão | O anfitrião percebe em cerca de 3 s, pausa a partida e mostra "O AMIGO CAIU". A vaga fica guardada por 60 s. Na Arena, se o anfitrião sumir por 45 s, outro jogador vira anfitrião. |
| Reconexão | O jogo tenta de novo sozinho e volta para a mesma vaga com um token secreto. Na Arena, o token fica salvo na aba. |
| Proteção básica contra trapaça | Token secreto por jogador. Só o anfitrião manda o estado do jogo. Comandos conferidos (direção entre -1 e 1, botões verdadeiro ou falso). Limite de pedidos e mensagens por segundo e de tamanho. Nomes limpos. Salas abandonadas somem. |

O servidor guarda tudo na memória e não usa banco de dados. Se ele reiniciar, as salas abertas acabam; os saves e rankings continuam, porque ficam nos aparelhos.

## Testar no computador

```bash
cd server
npm install
npm test        # testes automáticos do servidor
npm start       # abre em http://localhost:8080
```

Abra `http://localhost:8080` em duas janelas e teste o caminho:
1. Em uma janela: Fliperama → ONLINE → CRIAR SALA.
2. Na outra: ENTRAR COM CÓDIGO.

Para jogar com outro aparelho na mesma rede Wi-Fi, use o endereço do computador, por exemplo `http://192.168.0.10:8080`.

## Colocar no ar (você faz o deploy; não precisa de senha no código)

Opções baratas ou gratuitas, com os preços que encontrei em novembro de 2026. Confira no site de cada uma antes de assinar.

| Hospedagem | Custo esperado | Observação |
| --- | --- | --- |
| **Render** (plano grátis) | R$ 0 | Dorme depois de 15 minutos sem uso e leva cerca de 1 minuto para acordar. Bom para testar e jogar de vez em quando. O plano pago Starter custa cerca de US$ 7 por mês e não dorme. |
| **Fly.io** | cerca de US$ 2 por mês (shared-cpu-1x com 256 MB, região São Paulo) | Fica parado quando ninguém usa e acorda rápido. O preço muda por região. |
| VPS (Hetzner, Contabo, Oracle Free) | de R$ 0 a R$ 30 por mês | Mais trabalho: você instala o Node.js ou o Docker e um proxy com HTTPS. |

### Render (mais fácil, grátis)

1. Crie uma conta em render.com e conecte o seu GitHub.
2. Toque em **New → Blueprint** e escolha este repositório. O arquivo `render.yaml` já diz tudo: Docker, plano grátis e teste de saúde em `/api/health`.
3. Espere o deploy. O endereço vai ser algo como `https://daroca-online.onrender.com`.

### Fly.io

1. Instale o `flyctl` e entre na conta com `fly auth login`. Isso abre o navegador; nenhuma senha vai para o código.
2. Abra `fly.toml` e troque `daroca-online-TROQUE-ESTE-NOME` por um nome seu.
3. Na raiz do repositório, rode `fly launch --no-deploy --copy-config` e depois `fly deploy`.
4. O endereço será `https://SEU-NOME.fly.dev`.

### Docker (qualquer lugar)

```bash
docker build -f server/Dockerfile -t daroca .
docker run -p 8080:8080 daroca
```

## Manter o servidor do Render atualizado

O Render só publica sozinho quando está ligado ao repositório. Para atualizar a cada merge:

1. **Pegue o endereço secreto no Render:** abra o serviço **daroca-online** → **Settings** → **Deploy Hook** e copie o endereço.
2. **Guarde no GitHub:** no repositório, vá em **Settings → Secrets and variables → Actions → New repository secret**, crie o nome `RENDER_DEPLOY_HOOK` e cole o endereço como valor. O endereço é secreto: não cole em lugar nenhum além desse.
3. **Pronto.** O workflow **Atualizar servidor (Render)** avisa o Render a cada merge no `main`.

Sem isso, dá para atualizar à mão: no serviço do Render, **Manual Deploy → Deploy latest commit**.

## Ligar o site do GitHub Pages e os apps ao servidor

Quem abre o jogo pelo próprio endereço do servidor já está pronto. Para o site do GitHub Pages, o APK e o IPA usarem o servidor:

1. Edite `dist/servidor.json` e coloque o endereço em `url`, por exemplo `{"url": "https://daroca-online.onrender.com"}`.
2. Envie a mudança para o GitHub. O site e os próximos builds de APK e IPA passam a usar esse servidor.

Para testar outro servidor só num aparelho:
- abra o jogo com `?servidor=https://endereco` no fim do endereço; ou
- no Fliperama, vá em ONLINE → SERVIDOR.

Variáveis de ambiente opcionais do servidor:
- **`PORT`:** a porta; o padrão é 8080.
- **`ALLOWED_ORIGINS`:** quais sites podem usar o servidor. Use a lista dos endereços do seu site, separados por vírgula, por exemplo `https://purcelld60-cloud.github.io`. O padrão é qualquer site.

## Limites honestos

- **Campanha em dupla:** a campanha inteira em cooperativo não foi feita. O que existe em dupla é a **Dupla online** (chefes Marco, Menezes e Nikolas em dupla), que agora roda no seu servidor, além da Arena e do Fliperama.
- **Festa da Roça:** a Festa 3D continua só na rede Wi-Fi local, com o pacote próprio dela.
- **Reconexão depois de recarregar:** se a página do fliperama for recarregada, a pessoa precisa entrar de novo com o código. A reconexão automática vale para quedas de internet com a página aberta.
- **Trapaça:** a proteção é básica. Um anfitrião mal-intencionado consegue mexer no próprio jogo, porque o estado vem do aparelho dele. Para partidas casuais entre amigos isso basta.
