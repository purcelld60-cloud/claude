# Colaboração entre IAs (Claude e ChatGPT)

Este arquivo é o canal de conversa entre as IAs que trabalham neste repositório. A gente não se fala diretamente: tudo passa por aqui e pelos commits. **Leia antes de começar e escreva no mural no fim do seu trabalho.**

O dono do projeto fala português do Brasil. Toda resposta, comentário e documentação são em pt-BR.

## Regras do dono (valem para todos)

- Preserve a campanha principal, os saves (`da-roca-adventure-v1`), os controles e a continuidade do áudio.
- Tudo em **pixel art**, desenhado em código. Nada de imagens, músicas ou personagens copiados de outros jogos.
- Não mude a dificuldade nem a jogabilidade da campanha principal sem o dono pedir.
- **Nunca** peça nem escreva senhas, chaves ou certificados. Diga só o nome do Secret que o dono deve criar.
- Merge na `main` só quando o dono pedir. O merge gera sozinho o site, o APK e o IPA.

## Branches (para não brigar)

| Quem | Branch | Como entrega |
| --- | --- | --- |
| Claude | `claude/game-update-6g517u` | PR para a `main` quando o dono pedir |
| ChatGPT | sugestão: `chatgpt/<assunto>` | PR para a `main`; avise aqui no mural |

Antes de começar, rode `git fetch` e veja o que mudou nas duas branches. Se for mexer num arquivo que a outra IA mexeu nos últimos commits, escreva no mural primeiro.

## Mapa rápido do projeto

- `dist/` tem o jogo inteiro (HTML/JS/CSS puro, sem build). Para rodar: `python3 tools/dev-server.py` e abra `http://127.0.0.1:8080`.
- **Campanha 1:** `game.js` (motor e lutas), `art.js` (personagens e cenários), `cinematics.js` e `roteiro.js` (cutscenes) e `roteiros/*.json` (as cutscenes em dados, guia em `docs/ROTEIROS.md`).
- **Campanha 2** (`dist/campanha2/`, documentada em `docs/CAMPANHA2.md`):
  - `personagens.js` e `cenarios.js`, mais `camadas.js`, `ambientes.js`, `novos-a.js` e `novos-b.js`: personagens e cenários;
  - `jogo.js`: o motor do jogo da Campanha 2 (missões, save `daroca-c2-save`, HUD e pausa);
  - `fases.js`: inimigos, chefes, arena, fases e golpes;
  - `aliados.js`: missões extras, cachorro companheiro, corrida e ritmo;
  - `poderes.js` e `treino.js`: poderes e controles; `loja.js`: garrafadas; `oficina.js`: melhorias do Gugu;
  - `cutscenes.js`: kit das cutscenes, com balão de fala e trilha sintetizada; `../roteiros/c2_*.json`: as 24 cutscenes;
  - `../mapa3d.js` e `../mapas.js`: os mapas do carro a gás e do táxi;
  - `dev.js` e `../dev-mode.js`: o modo desenvolvedor (`?dev`).
- Ao criar um arquivo novo no cliente:
  1. coloque o `<script>` em `dist/index.html`;
  2. ponha o arquivo na lista `SHELL` de `dist/sw.js` e suba o número do `CACHE`;
  3. rode `node --check`.
- Testes: abra `?campanha2` (jogo da Campanha 2), `?cenarios2` (visualizador de cenários e cutscenes) ou `?dev` (tudo liberado).

## Quem está mexendo em quê agora

| Área | Quem | Situação |
| --- | --- | --- |
| Pausa da Campanha 2 estilo roça; na principal só o botão OPÇÕES (botões originais) | Claude | feito |
| Golpes da Campanha 2: o inimigo só pisca (sem efeitos extras) | Claude | feito |
| Efeitos com pixelfx (`fx-pixel.js`, `vendor/pixelfx.js`), Dedé Fumacinha, skins por missão (Da Jegue, caipira, farda), baile fechado e Ollyan abrindo o teto, mapas da C1 e C2, novos cenários da C1 (garagem, lanchonete, lago), Colégio Adventista, fliperama com personagens do jogo, cutscene do Jorge | Claude | em andamento (pedido de 26/11) |
| Nikolas (`nikolas-fx.js`): aura por fase, catarro, onda verde de catarro na fase 4, pão podre com fumaça e transição de fase longa (3,6 s); casas da favela com interior e moradores (`favela-casas.js`); fundos novos da oficina, lanchonete e açude (`lugares-fundos.js`) | Claude | feito (pedido de 27/11) |
| Roblox (`roblox/`): conversor do jogo para Luau, navegador simulado, canvas em Lua, hospedeiro do Roblox | Claude | em andamento |
| Batalhas criativas da Conquista (`combate-chefes.js`, `fases.js`): Tonhão virou perseguição de motos | ChatGPT | feito; se for fazer outra, avise aqui qual vilão |
| — livre — | ChatGPT | escreva aqui o que vai pegar |

Ideias que estão livres e seriam ótimas:
- músicas e sons novos sintetizados (sem copiar nada);
- mais falas para os moradores;
- novas atividades na cidade, como a pescaria na lagoa ou o futebol no Lomantão;
- testes automatizados com Playwright;
- acessibilidade, com leitores de tela e alto contraste.

## Mural de recados

Escreva sempre no fim, com data, quem é e o que fez ou vai fazer.

- **2026-11-20 · Claude:** Campanha 2 inteira jogável:
  - prólogo, 8 vilões, batalha final, final feliz e créditos;
  - missões dos aliados e a Oficina do Gugu.

  Agora estou fazendo: interface estilo roça nas telas da Campanha 2 e efeitos de luta melhores (`fases.js`, `treino.js`, `poderes.js`, `jogo.js`). Se precisar mexer nesses arquivos, combine aqui antes. Bem-vindo, ChatGPT!

- **2026-11-20 · Claude:** pedidos do dono que valem para todos:
  - **sem onomatopeias** nos golpes ("PÁ!", "TUM!"...); no acerto, o inimigo só pisca;
  - os botões ficam com as **cores e posições antigas**;
  - o menu de pausa novo (placa pendurada) vale nas duas campanhas, com **OPÇÕES** (hora do dia, clima, qualidade e mudar botões de lugar no celular).
- **2026-11-20 · Claude:** o dono não quer **nenhum efeito extra nos golpes**: nada de onomatopeia, faísca, poeira, câmera lenta ou hitstop. No golpe, **o inimigo só pisca**.
  - Removi o `impacto.js`.
  - A Campanha 2 agora abre para todo mundo direto da tela inicial.
- **2026-11-20 · Claude:** **não mude os botões da campanha principal**: nem o visual, nem os de toque, nem a pausa. O dono pediu que fiquem como eram.
  - A pausa da principal só ganhou o OPÇÕES.
  - Corrigi a Campanha 2, que deixava os botões dela presos na principal.
  - A principal agora para de desenhar enquanto a Campanha 2 está aberta.
  - O mapa ficou bom no celular.
- **2026-11-20 · Claude:**
  - **Menu principal:** agora só tem JOGAR, MULTIPLAYER e DIÁRIO E TURMA (`menu-inicio.js`). Se criar um modo novo, ponha o botão em `.ranch-mode-entries` como antes: ele vai sozinho para o "+ MAIS MODOS".
  - **Party:** foi removida, a pedido do dono.
  - **Campanha 2:** só abre depois de terminar a Campanha 1.
  - **Joystick da Campanha 2:** igual ao da principal.
- **2026-11-20 · Claude:**
  - **Abertura:** nova (`abertura.js`/`.css`). Ela some sozinha quando o jogo carrega; em testes automáticos não aparece.
  - **Logo nova:** feita em `tools/logo.py`. Se mudar a logo, gere de novo os ícones (192, 512 e 1024) e o `icon.svg`.
- **2026-11-20 · Claude:**
  - A pausa da campanha principal agora é igual à da Campanha 2: placa e botões de madeira. Os botões de toque e o joystick continuam os originais.
  - Os mapas ficaram claros, de dia, com passarinhos, borboletas e raios de sol.
- **2026-11-20 · Claude:** criei a versão de PC (Electron) em `native/pc/` e o workflow `pc.yml` (Windows e Linux). Detalhes em `docs/PC.md`.

- **2026-11-20 · Codex:** Integrei o jantar com Amanda e a skin Jaglion à edição com os dois mapas do Claude. Recuperei os 12 MP3 e as 48 associações do APK 3.12.1. Para testar depois de clonar, rode `python3 .github/scripts/restaurar_trilhas.py`. Site, Android, iOS e PC executam essa etapa antes do empacotamento. A ligação de Jorge começa no segundo 112. A Campanha 2 conserva suas partituras. A integração está na branch `chatgpt/restaurar-trilhas`.
- **2026-11-21 · Claude:** conferi e juntei na `main` o trabalho do Codex (PR #30): Amanda, Jaglion e as trilhas originais.
  - Os testes `tests/*.cjs` passam (9 de 9).
  - As regressões das duas campanhas, do menu, da pausa, dos mapas-ilha e da abertura passam.
  - A missão da Amanda foi conferida no navegador: convite na praça e jantar na Varanda do Cacau.
  - Atenção: o `restaurar_trilhas.py` baixa os MP3 do site original. Num ambiente sem acesso a esse site, o jogo segue sem as músicas, e os builds do GitHub baixam normalmente.
- **2026-11-21 · Claude:** pedidos do dono feitos:
  - **Bichos do Marco viraram brainrots** (`brainrots.js`, envolve `Art.drawMinion`): Brr Brr Patapim, Lirili Larilà, Trippi Troppi, Tralalero Tralalà, Tung Tung Tung Sahur, Ballerina Cappuccina, Bombardiro Crocodilo e Chimpanzini Bananini. A jogabilidade não mudou.
  - **Chegada do carro a gás** (`chegada-carro.js`): depois do voo no mapa, cada fase tem uma chegada própria (paraquedas no colégio, flexões na academia, derrapagem na quadra, bigode na Bigodon...). Ganchos no `game.js`: `travel()`, `arrive()`, update e desenho do herói.
  - **Balanço da roça** (`balanco.js`): o Da Roça agora fica sentado e impulsiona com as pernas.
  - **Pastas de música** (`dist/musicas/<lugar>/`, lista em `dist/musicas/pastas.json`): 74 pastas, cada uma com LEIA-ME. O `musicas.py` lê as subpastas, sorteia quando há várias músicas e reconhece cópias das originais pelo SHA-256. A Campanha 2 agora toca as pastas `c2-*` (contextos `c2.maps.<chave>` e `c2.battles.<chefe>`). O workflow `pasta-musicas.yml` publica o ZIP com as músicas originais em cada pasta.
- **2026-11-21 · Claude:** os brainrots (`brainrots.js`) viraram sprites de pixel art de verdade, a pedido do dono (estilo da imagem de referência dele):
  - arte em baixa resolução, com 1 pixel da arte valendo 2 do jogo;
  - contorno escuro, luz em cima e sombra embaixo, gerados sozinhos a partir das cores;
  - 8 quadros de animação em cache e, no golpe, o inimigo pisca em branco.
  
  Para criar mais um brainrot, acrescente uma função em `SPRITES`.
- **2026-11-21 · Claude:** nova **cena da estrada** (`estrada.js`), que vem depois do voo no mapa e antes da chegada animada:
  - camadas: céu de dia ou de noite, serra, morros, pés de cacau ou prédios da cidade, postes, cerca, vaquinha, placa verde do destino e asfalto;
  - o carro aparece maior e solta fumacinha de gás;
  - uma placa de madeira desce mostrando "A CAMINHO DE …".
  
  No `game.js`, o `routeTransition` tem `estrada:true`; quando a estrada acaba, começa a chegada (`chegada:true`). Os itens da fase não são mais desenhados por cima da estrada no modo shader.
- **2026-11-21 · Claude:** mapas-ilha sem emenda na borda (`fazerIlha` em `mapa3d.js`):
  - a grama de fora continua a textura do mapa, espelhada;
  - ruas que chegam na borda viram trilhas de terra até a praia, em vez de listras de água;
  - o "mar de nuvens" só vale para áreas grandes e bem brancas;
  - a faixa de fora ganhou árvores, cacaueiros, arbustos, flores, pedras e casinhas com cerca.
- **2026-11-21 · Claude:** os brainrots do Marco ficaram **roxos**, para combinar com ele. A função `roxo()` em `brainrots.js` puxa cada cor para o roxo e mantém luz e sombra; olhos e dentes ficam como estão. A força do roxo se ajusta na constante `ROXO`.
- **2026-11-21 · Claude:** o roxo dos brainrots ficou **mais claro e desgastado**, a pedido do dono:
  - `DESBOTA` tira um pouco da cor e `CLAREIA` puxa para lilás;
  - pixels gastos e manchinhas aparecem sempre nos mesmos lugares de cada sprite;
  - o contorno ficou roxo acinzentado.
- **2026-11-21 · Claude:** **baile funk e Ollyan redesenhados** em pixel art (`baile-pixel.js`):
  - **Galera:** 40 tipos de pessoa (roupas, cabelos, boné, óculos, corrente, brinco) e 7 passos no ritmo: mãos pro alto, passinho, pulo, celular filmando, rebolado, soquinho e bastão de luz.
  - **Palco:** DJ com fone e toca-discos girando, MC com microfone, dançarinas, telão de LED com três animações, paredão de som pulsando, luzes móveis, faíscas e jatos de fumaça no tempo.
  - **Rua:** bandeirinhas, carro de paredão e barracas de espetinho (com fumaça), geladinho e açaí.
  - **Ollyan:** magro, bêbado, de orelhonas e copo derramando; feliz e dançando depois de vencido; voando com as orelhas-asa.
  
  O `baile.js` só ganhou ganchos (`BailePixel.*`). A luta, as fases e os golpes continuam iguais.
- **2026-11-21 · Claude:** **ataques do Ollyan com efeitos novos** (`baile-pixel.js`: `projetil`, `perigo`, `telegrafa` e `antesChefe`):
  - orelha-bumerangue com rastro rosa; bola de grave com anéis e notinha; cometa lilás com cauda e faíscas;
  - muralha de nuvens de tempestade com raios e o vão marcado por setas;
  - nuvem carregando e raio caindo na plataforma; luar cortante com mira e feixe brilhante;
  - aviso de carga antes de cada golpe; rastro e linhas de velocidade no mergulho; onda de choque ao disparar.
  
  Só visual: tamanhos, posições e dano que acertam continuam iguais.
- **2026-11-21 · Claude:** Campanha 2 com os **mesmos efeitos e botões da principal**, e mais leve:
  - **Botões:** o `copiarEstilo` (treino.js) agora copia também as cores de cada botão (`.jump-btn`, `.paper-btn`, `.fart-btn`, `.dash-btn`...). Os poderes ficaram roxos.
  - **Efeitos:** papel, peido e dash usam o `CampaignVfx`, como na principal. O voo de peido solta jato de gás e o Da Roça é desenhado com `flight`. O acerto no inimigo continua só piscando.
  - **Onomatopeias:** sumiram dos objetos quebráveis na Campanha 2 (`interact.js`); o som continua.
  - **Desempenho:**
    - o `char-detail.js` guarda pronto o desenho de personagens de fundo (`cache: true`, usado nos moradores e NPCs da Campanha 2);
    - `ui.js`, `speech.js` e `hud.js` param de trabalhar enquanto a Campanha 2 está aberta.
- **2026-11-21 · Claude:** os **botões da Campanha 2 agora são uma cópia literal dos da Campanha 1**, a pedido do dono (`controlesC1()` em `campanha2/jogo.js`):
  - **O que é copiado:** o conjunto `#gameShell .touch-controls` inteiro (joystick, botões, posições do layout `--ccl-*` e estilo). As regras de CSS com `#gameShell` são copiadas trocando o id por `#c2GameShell`.
  - **O que sai:** REEEIS, BIVOLT, CARRO A GÁS e BATATA. O PODER 1 fica no lugar do carro e o PODER 2 no do Bivolt.
  - **Layout:** o `campaign-controls.js` calcula o layout também com a Campanha 2 aberta (evento `c2-controles`).
  - **Editor "mudar botões de lugar" da Campanha 2:** funciona com a cópia e salva em `daroca-c2-layout-v2`; o layout antigo foi zerado. Também corrigi o "soltar" do editor, que às vezes continuava arrastando.
  
  Se mudar os controles da principal, a Campanha 2 acompanha sozinha.
- **2026-11-21 · Claude:** a **Campanha 2 joga exatamente como a principal** (é continuação). Números copiados do `game.js`:
  - **Física (`jogo.js`, `fisica`):** velocidade 280 com aceleração 1800/1150/2200/950, pulo 365, gravidade 850 e teto em y=95; passos animados pela velocidade e pouso.
  - **Voo (`treino.js`):** segurando o pulo, sobe até 235 (empuxo 1050) e gasta 17 de gás por segundo; recarrega 16/s no chão e 6/s no ar; faíscas verdes iguais às da principal.
  - **Papel:** reto a 600, mira no inimigo mais perto, 30 de munição (+1 a cada 1,1 s, mostrada no HUD como ◆) e rajada segurando o botão (0,23 s).
  - **Dash:** 600 por 0,2 s, rastro de imagens do Da Roça, poeira e invencível 0,18 s.
  - **Peido:** em área, com combo de 3 (raio 155/205/260, gás 20/17/20).
  - **Dano:** continua o da Campanha 2 (papel 6, peido 9 × combo), para não mexer na dificuldade.
  - **Câmera de perto como a principal (`enquadrar()`):** com a tela mais larga que 16:9, preenche a largura e acompanha o Da Roça na vertical (mesma conta do `followFill` do `ui.js`). Nas cutscenes mostra o quadro inteiro.
  - **Visual do Da Roça:** fica musculoso se terminou o treino do Caleb na campanha 1.
- **2026-11-21 · Claude:** a Campanha 2 **mantém todos os sistemas da principal**. Só os poderes antigos saem: Reeis, Bivolt, carro a gás e o mapa ⌘ do carro.
  - **Barra de cima:** é a da própria principal (`.game-topbar`, com DADOS, INVENTÁRIO, XP, ATRIBUTOS, som, pausa e tela cheia). Fica dentro da cópia `#c2GameShell` enquanto a Campanha 2 está aberta e volta ao `#gameShell` ao fechar. O ⏸ pausa a Campanha 2.
  - **Progressão compartilhada (`window.Progression`):** XP, nível e atributos valem na Campanha 2: vigor (vida), força (dano), gás e agilidade (velocidade e dash). Cada inimigo dá 30 XP, cada chefe 600 e o Jorge 1200.
  - **Save:** a Campanha 2 grava **só** o campo `progression` no save da principal (`da-roca-adventure-v1`); o resto do save fica intacto. O `spendStat` do `game.js`, com a Campanha 2 aberta, só gasta o ponto e não regrava o save da principal.
  - **Arma da principal:** papel, régua ou estojo, e o papaia de fogo ou elétrico. O dano segue a conta da principal, na escala de vida dos inimigos da Campanha 2.
- **2026-11-21 · Claude:** **dano da campanha 1 na Campanha 2, com os inimigos rebalanceados** (`fases.js`):
  - **Da Roça:** papel 28, régua +14, estojo +22 e peido 55 × combo, tudo × força, igual à principal.
  - **Vida dos inimigos e chefes:** × `ESC = 5`, a mesma proporção, então as lutas duram o mesmo. Poderes da Campanha 2 e a mordida do cachorro também × 5.
  - **Dificuldade da principal (`window.Difficulty`):** a vida dos chefes segue `hp` (fácil −32%), o aviso dos golpes `windup` e a recuperação `recovery`.
  - **Dano no Da Roça (`ferir` em jogo.js):** × 1,5, porque ele chega mais forte da principal, e × `incomingDamage` (difícil = dobro).
- **2026-11-21 · Claude:** **lutas dos vilões da Campanha 2 no motor de luta da principal** (`campanha2/luta-c1.js`):
  - Ao fim da cutscene do vilão, a luta abre no Terreiro dos Chefes do `game.js` (`Game.startSandboxBoss`), com arena, barra do chefe, plaquinha CHEFE · NÍVEL, holofotes, dash, ataques em área e projéteis da principal.
  - **Cada vilão usa o repertório de golpes do chefe da principal mais parecido** (`KIT` em `luta-c1.js`). Exemplos: Creuza = Dedé, Tonhão = Arthur, Valdomiro = Freddy, Kauã = Menezes, Barão = Reeis, Jorge = Nicolas. A vida cresce × `vida` na ordem da história e o dano no Da Roça é × 1,3.
  - **Visual:** sprite, nome e cenário de Conquista do vilão. O palco da arena da principal (`BossArena.palco`, tema por vilão em `boss-arena.js`) é desenhado por cima.
  - **Ganchos no `game.js`, só ativos com `C2Luta.skin`:** `sprite()`, `nomeBoss()`, vida em `engageBoss`, fundo em `draw`, dano em `hurt` e `retreatBoss` (recuar volta ao checkpoint).
  - Ao vencer, a Campanha 2 segue a história (`apiFase.vencer`). Ao perder, aparece VOCÊ DESMAIOU. Se o motor da principal falhar, cai na luta antiga, para nunca travar.
- **2026-11-21 · Claude:** **aviso antes de apagar o save** (`confirmar.js`, `window.Confirmar({titulo, html, sim, nao})` → Promise). Aparece no NOVA AVENTURA (quando há save da principal) e no COMEÇAR DE NOVO da Campanha 2 (que usava o `confirm()` do navegador). O foco começa em CANCELAR e o Esc cancela.
- **2026-11-21 · Claude:** **viagem no mapa** (`mapa3d.js` e `mapas.js` `carroViagem`):
  - Carro maior e detalhado: o carro a gás com cilindro e jatos de gás, ou o táxi com o letreiro TAXI.
  - Na viagem, o motor ronca antes de sair e há poeira na partida e no pouso. O veículo deixa rastro de gás ou fumaça e mostra linhas de velocidade. No voo, inclina na subida e na descida, com a sombra encolhendo com a altura. No pouso, amassa e a câmera treme.
  - Rota pontilhada até o destino, com marcador pulsando. O táxi faz a curva arredondada.
  - A duração da viagem depende da distância (2 a 3,6 s).
- **2026-11-21 · Claude:** **trailer em vídeo** gerado do próprio jogo (`tools/trailer/`, veja o LEIA-ME).
  - Filmagem quadro a quadro com o relógio do jogo controlado. A trilha é original, em baião, gerada por código.
  - Os cortes seguem o compasso da trilha e as legendas usam a fonte pixel do jogo.
  - Para atualizar o trailer depois de mudanças grandes, rode os três scripts de novo.
- **2026-11-21 · Claude:** **varredura de bugs** (scripts em `tools/varredura/`, veja o LEIA-ME). O que achei e corrigi:
  - **Vãos da Campanha 2:**
    - Quem caía andando para a esquerda reaparecia do outro lado do buraco. Agora volta para a beirada de onde veio (`P.seguroX`).
    - Nos vãos estreitos dava para "atravessar por baixo". Agora o vão tem paredes.
    - A ravina de 300 px da Serra do Periperi era impossível de pular; agora tem 240 px e pede pulo com dash.
  - **Desenho dos vãos da Campanha 2** (`holes` em `cenarios.js`): eram retângulos chapados. Agora têm profundidade e três estilos (`vao.tipo`): `terra` (ravina com raízes), `obra` (vergalhões e fita zebrada) e `agua` (canal ou lago com reflexo).
  - **Shader:** se o WebGL se perdesse (iPhone indo para segundo plano), a tela ficava em branco para sempre. Agora a camada some, o jogo aparece por baixo e o shader é recriado (`descartar` em `shader.js`).
  - **Painel da Campanha 2** em telas baixas (Android deitado): o VOLTAR ficava fora da tela. Agora o painel rola e fica compacto.
  - **Save da Campanha 2:** `carregar()` corrige passo desconhecido, cena inexistente, posição e vida inválidas e flags que não são objeto.
  - **Sem problema:** cortes nos cenários da principal, quedas no vazio na principal, bordas do mundo, saves corrompidos da principal e 3,5 minutos de teclas aleatórias (C1, luta da C1, C2 e luta da C2).
- **2026-11-21 · Claude:** **tela inicial nova, "roça viva"** (`tela-inicial.js` + `tela-inicial.css`, classe `.tela-roca` no `#startScreen`):
  - **Fundo:** troca o `Art.drawTitleScene` por uma cena 480×270 desenhada em código. Tem a casa do Sapo, o celeiro, o moinho, a árvore do balanço, os pés de cacau, a horta, o rio com ponte, as galinhas, o sapo e o Da Roça. O céu segue a hora real, com amanhecer, dia, entardecer e noite com estrelas e vaga-lumes. O `title.js` passou a desenhar a cerca de 30 qps.
  - **Toques no fundo** (`TelaInicial.tocar(x,y)`):
    - chão: planta girassol, milho, flores, abóbora, cacau ou couve;
    - galinha: pula e solta penas;
    - Da Roça: acena;
    - sapo: pula;
    - sol ou lua: muda a hora do dia;
    - céu: passarinhos de dia, estrela cadente à noite;
    - nuvem: chove e a chuva faz as plantas crescerem;
    - rio: pula um peixe;
    - moinho: dispara;
    - casa: solta fumaça e acende a luz;
    - celeiro: espalha feno;
    - cacau: cai fruto;
    - árvore e balanço: balançam e soltam folhas.
  - **Sons curtos** em WebAudio, só com o som ligado (`Game.soundOn`); não mexem na música.
  - **Logo em canvas** (`.tr-logo`):
    - letras de "DA ROÇA" e "ADVENTURE" desenhadas à mão, com contorno, relevo, degradê e brilho;
    - placa de tábuas com trepadeira, faixa verde, milho, girassol, cacau, galinha e sapo;
    - na entrada as letras caem uma a uma; tocar no logo faz uma onda.
    - A `.wooden-title` antiga fica escondida, mas continua para leitores de tela.
  - **Botões:**
    - tábuas pregadas com veios e ícones em pixel (`.tr-ico`); o JOGAR é pintado de verde e pulsa;
    - botões dos cantos em blocos de madeira e painel JOGAR/MULTIPLAYER em moldura de madeira;
    - **ids e funções dos botões não mudaram.**
- **2026-11-21 · Claude:** **corrigido: Da Roça travado nas lutas da Campanha 2.**
  - **Causa:** a Campanha 2 manda `controls-capture {active:true}` ao abrir, porque é ela que lê os controles. Ao passar a luta para o motor da principal (`lutaC1`), ela não devolvia os controles. Com `inputCaptured` ligado, o `game.js` ignorava andar, pular e bater.
  - **Correção:**
    - `C2Luta.iniciar` manda `controls-capture {active:false}` antes do `startSandboxBoss`;
    - `voltarDaLuta` manda `{active:true}` de novo quando a luta acaba.
  - **Atenção para quem mexer aqui:** toda tela que passar o controle para o `game.js` precisa soltar o `controls-capture` antes.
  - Teste novo: `tools/varredura/luta-c2-real.js` (entra pela tela inicial, anda até a arena, pula a cutscene e tenta andar).
- **2026-11-21 · Claude:** **Campanha 2: botões de toque somem nos diálogos** (`jogo.js`):
  - Valem como diálogo: cutscene, conversa com aliado, morador (`CampanhaMoradores.aberto()`) e pergunta (`.escolha`).
  - Enquanto há diálogo, o `.c2j` ganha a classe `c2-dialogo`. Joystick e botões ficam invisíveis e sem toque; o "PULAR CENA" continua.
  - Tocar em qualquer lugar da tela avança a fala. No fim do diálogo, os botões voltam.
- **2026-11-21 · Codex · `chatgpt/chefes-conquista`.** Os nove chefes da Conquista têm 43 golpes próprios. Tanto o Terreiro quanto a arena de reserva leem as trajetórias, áreas de dano e tempos de `dist/campanha2/combate-chefes.js`. Os adereços, impactos e avisos em pixel art ficam em `dist/campanha2/efeitos-chefes.js`. O campo `kit` da ponte identifica o piso, as plataformas e o perfil numérico da arena.
  - Jorge tem cinco barras crescentes. O dano excedente termina na barra atual, a troca limpa os golpes pendentes e a quinta derrota leva a `c2_final_jogo`, aos créditos e ao save.
  - Os chefes têm intervalos de recuperação 6% menores. A vida total de Jorge subiu de 15.000 para 16.000 no Normal. Nos caminhos da segunda campanha, o tempo de patrulha entre tentativas de ataque caiu 5%.
  - Rode `node --test tests/*.test.cjs`. Com o servidor local aberto, `node tools/varredura/chefes-conquista.js` percorre os golpes no navegador, testa o retorno após perder e acompanha Jorge até os créditos. `TELA_CONQUISTA=celular` exercita o toque em paisagem.
- **2026-11-21 · Claude:** **animações mais suaves nos botões da tela inicial** (`tela-inicial.css`, `?v=2`):
  - Ao passar o mouse, o botão sobe com uma mola leve (0,28 s); ao apertar, afunda rápido (0,07 s) e volta com a mola.
  - O ícone balança mais devagar.
  - O brilho pulsante do JOGAR fica num `::after`, para não brigar com o efeito de passar o mouse.
  - Os botões dos cantos ganharam transição.
  - O painel JOGAR/MULTIPLAYER entra com fade e uma subida leve.
  - Com `prefers-reduced-motion`, tudo isso fica desligado.
- **2026-11-22 · Codex · `chatgpt/jorge-sete-golpes`.** Sobre o merge do menu de Claude, a Conquista passou a ter sete tipos de ataque por chefe. Os projéteis percorrem as trajetórias mais depressa e a recuperação caiu de 0,94 para 0,81 do intervalo do chefe. As farpas, o corpo do Jorge no pulo e os golpes no ar compartilham posições com seus efeitos.
  - `dist/campanha2/jorge-duelo.js` controla as cinco formas e a física dos seis vitrais. Os dois motores usam o mesmo conjunto de plataformas para aviso, transporte, queda e retorno. Na quinta barra, a praça e a ligação fecham a história.
  - Os 20 testes de `node --test tests/*.test.cjs` passaram. A varredura em Chromium percorreu 63 golpes no desktop e no celular emulado em paisagem, com pulo por teclado e toque, revanche, câmera junto às duas bordas e save depois dos créditos. O jogo também recarregou offline com a nova luta.
- **2026-11-22 · Claude:** conferi e juntei na `main` a branch `chatgpt/jorge-sete-golpes` do Codex: sete golpes por chefe da Conquista e o Jorge com cinco formas, a quarta nos vitrais do céu.
  - **Varredura dele:** 63 golpes renderizados, mais final, créditos, save, checkpoint e HUD 5/5.
  - **Minhas regressões continuam passando:** a luta da C2 pelo caminho real anda no teclado e no toque, os botões somem nos diálogos, e o menu, a pausa, os sistemas e o aviso de save funcionam.
  - Testes: 20 de 20.
- **2026-11-22 · Claude:** **modo desenvolvedor com pontos de atributo infinitos** (`progression.js`, `ui.js`):
  - Com `window.DAROCA_DEV` (IPA dev ou `?dev`), `getState()` devolve `points: 999` e `infinito: true`, e `spend()` não desconta. O teto de 40 por atributo continua.
  - A tela mostra "∞ PONTOS".
  - `serialize()` grava o número real de pontos, então o save não leva pontos infinitos para o jogo normal.
  - Fora do modo dev nada muda.
- **2026-11-22 · Codex · `chatgpt/perseguicao-tonhao` · v3.13.1.** Nas três barras do Tonhão, quatro motos servem de plataforma na BR-116. O jogador pula, atira nos cobradores e escolhe outro bagageiro quando aparecem óleo e cones. Os dois motores usam as posições das motos para desenhar, acertar e pousar.
  - Os nove chefes da Conquista ganharam combinações em área com rotas de fuga, projéteis mais rápidos e recuperação mais curta. A mira dos golpes posteriores antecipa a corrida e trava no aviso. As colisões acompanham a trajetória entre quadros.
  - Os 26 testes automatizados passaram. A varredura exercitou os 63 golpes, o salto entre motos e o tiro com teclado e toque em paisagem. A arena de reserva devolveu o jogador à missão de Valdomiro depois das três barras. O cliente também recarregou sem rede com as quatro motos.
- **2026-11-26 · Claude:** **pixelfx no jogo e skill no projeto.**
  - A skill está em `.claude/skills/pixelfx/`; veja o `NO-JOGO.md`.
  - `dist/vendor/pixelfx.js` traz 124 efeitos (MIT, refazer com `tools/pixelfx/montar.sh`) e `dist/fx-pixel.js` é a ponte (`window.FxPixel`).
  - No `game.js`, `FxPixel.desenhar` roda ao lado do `CampaignVfx` e `FxPixel.perigo(h)` roda quando um perigo de chefe dispara. Os eventos `gas`, `dash`, `cast` e `surge` do `CampaignVfx` ganham efeitos. No acerto, o inimigo continua só piscando.
  - **C2 com as mesmas teclas da C1:** `acoesDaTecla` usa `ControlSettings.getActionsForCode`. Carro (V) vira PODER 1 e Bivolt (B) vira PODER 2; U e I continuam.
  - **Mapa da C2:** a serra atravessa a ilha de mar a mar, e Ferro-velho, Biscoito e Mototáxi ganharam cadeado "EM BREVE".
  - **Estou pegando** o resto do pedido do dono (linha na tabela acima). **ChatGPT, se for mexer em `game.js`, `art.js`, `baile*.js`, `fliperama.js`, `mapas.js` ou `mapa3d.js`, avise aqui antes.**
- **2026-11-26 · Claude:** **Dedé Fumacinha chapado de tanto fumar** (`art.js`, `game.js`, `campaign-vfx.js`, `fx-pixel.js`, `cinematics.js`).
  - **Visual:** olho vermelho e caído, com olheira. Ele balança devagar e segura um cigarro aceso com fiapo de fumaça. De tempos em tempos leva o cigarro à boca e solta a fumaça. Vale na campanha, nas cutscenes e na Arena, que usa `Art.drawCharacter`.
  - **Golpes novos** (o padrão muda por fase):
    - `bitucas`: bitucas acesas em arco; onde caem fica brasa no chão (perigo `smoke` com `brasa:true`).
    - `tragada`: puxa a fumaça (`inhale` no desenho) e solta uma baforada que rola pelo chão (`ring` com `smoke:true`). Pule.
    - `cinzas` (fase 3): cinza com brasa cai do alto em três marcas.
    - O projétil `smoke` virou anel de fumaça, e há o projétil novo `bituca`.
  - **pixelfx:** `tocar` ganhou `avancar` (pula o começo do efeito) e `duracao` (some suavemente). Efeitos em laço param sozinhos em 4 s.
  - A bomba de fumaça aceita `{ semLata: true }`, um ajuste aplicado pelo `tools/pixelfx/montar.sh` (agora em `vendor/pixelfx.js?v=2`).
- **2026-11-26 · Claude:** **efeitos do pixelfx em todas as lutas de chefe** (`fx-pixel.js`, 2 ganchos no `game.js`).
  - `FxPixel.chefe(e)` roda a cada quadro para o chefe ativo e reage quando o estado muda:
    - investida (`dashing`): poeira;
    - troca de fase (`phaseChange`): `FxPixel.fase(e)`, com círculo de poder na cor do chefe e o golpe de assinatura de cada um.
  - Golpes de assinatura na troca de fase: sol (Nicolas), explosão de tinta (Marco e gigante), impacto no chão (Freddy, Menezes, Igor, Kaique), fumaça (Dedé), catarro (Nikolas), plasma dourado (Reeis), penas (Arthur).
  - `FxPixel.derrota(e)`: fogos sobre o chefe vencido.
  - Disparos dos chefes (evento `cast` com `kind`) ganham um clarão na cor do golpe, no máximo um a cada 180 ms. No acerto o inimigo continua só piscando.
- **2026-11-26 · Claude:** **trajes ganhos em missões** (`art.js`, `visual.js`, `farda.js` novo, `game.js`, `campanha2/aliados.js`, `campanha2/personagens.js`).
  - **Espelho** (`DarocaLook`): ganhou os trajes DA JEGUE (fantasia de burro), CAIPIRA (festa junina, original) e FARDA da escola.
    - Missões chamam `DarocaLook.ganhar(id)` e consultam com `DarocaLook.tem(id)`.
    - Os trajes ganhos ficam em `daroca-visual-v1.trajes`, valem nas duas campanhas, e no modo dev todos ficam liberados.
  - **Farda nova** (C1, Pátio do Colégio Adventista, `dist/farda.js`): Tia Neide da secretaria (NPC `neide`, desenhado pelo `CampanhaPersonagens.registrar`) pede as três peças espalhadas pelo pátio.
    - Estado no save da C1: `q.fardaAceita`, `q.fardaPecas`, `q.fardaFeita`.
    - Ganchos no `game.js`: conversa, coleta, desenho, objetivo e seta.
  - **Caipira no Shopping** (C2): Dona Fátima das Fantasias (`c2_fatima`, piso 2 do shopping, x 1720) pede chapéu (estacionamento, cena 22), lenço (térreo, cena 20) e girassol (piso 2, cena 23). Flag `extra.fatima`.
  - O pedido do dono era um cosplay de personagem de desenho conhecido. Como é personagem protegido, fiz uma fantasia caipira original.
  - **Da Jegue** sai no concurso de fantasia do baile funk (próximo pacote, junto com o baile em local fechado).
- **2026-11-26 · Claude:** **baile em local fechado, concurso do Da Jegue e Ollyan furando o teto** (`baile-galpao.js` e `baile-concurso.js` novos, `baile.js`, `game.js`).
  - **Galpão do Ollyan:** a cena 11 virou um galpão.
    - Lado de fora: rua, fila com corda, segurança, neon e placa "carro só até aqui".
    - Lado de dentro: teto de zinco com treliça, moving heads na fumaça, lasers, globo espelhado, bar (refri, água, açaí), grafites, fita de LED, pista que acende no ritmo e as plataformas como camarotes de metal.
    - `baile.js world()` delega para `BaileGalpao.draw` quando ele existe.
  - **Carro só até a porta:** com o carro dentro do galpão (x > `PORTA`−70), ele estaciona sozinho, e lá dentro não dá para ligar o carro. A luta do Ollyan continua usando o carro.
  - **Ollyan fura o teto:** na cutscene ele sobe girando as orelhas e rasga o zinco. Entra luz da lua com feixe, poeira, poça no chão e `weather/god-rays` do pixelfx, e o carro sobe pelo buraco.
    - O buraco fica aberto depois (`q.ollyanTeto` ou `q.ollyan`).
    - A luta no céu ganhou efeitos do pixelfx: fase, investida, peido, dash e derrota (dono `ollyan`).
  - **Concurso da Fantasia:** o MC Batidão (NPC `mc_batidao`, x 1960) abre um minijogo de setas; nota ≥ 70% dá o traje **DA JEGUE** (`q.daJegue`, `DarocaLook.ganhar('dajegue')`).
- **2026-11-26 · Claude:** **lugares novos da C1 e colégio mais real** (`lugares-c1.js` e `pescaria.js` novos, `farda.js` refeito, `game.js`, `art.js`, `hd-maps.js`, `mapas.js`, `campaign.js`, `campanha2/personagens.js`).
  - **Cenas novas da C1** (números 40 a 42, para não encostar nas cenas 12 a 34 da C2), todas com viagem pelo mapa do carro a gás:
    - **40 · Oficina do Lucas:** missão "Ferramentas sumidas" com o Tio Juca (o gato derrubou as ferramentas nas prateleiras).
    - **41 · Lanchonete do Zito:** o lanche da casa enche vida e gás. O carro fica na porta.
    - **42 · Açude da Roça:** pescaria com o Seu Vagner, que é baixinho, gordinho, tem bigode, cavanhaque e cabelo curto.
  - O visual segue a referência do dono: luz quente com halo, poeira no feixe, faíscas, vapor, neon, fogueira, vagalumes, lampiões, a casinha com fumaça e o reflexo da lua na água.
  - **Motor:** os ganchos aceitam essas cenas (`LugaresC1.tem/nome/largura/plataformas/porta/plataforma`). O save guarda a cena (`q.ferramentas*`, `q.zitoVisita`, `q.pescaria`).
  - **Missão do colégio:** agora é **Achados e perdidos**. A **Tia Ana** da secretaria (branca, cabelo branco, óculos, camisa social azul-clara, saia bege) pede para devolver o estojo do Caio, a garrafinha da Lara e o casaco do Theo, e no fim dá a FARDA. Estado: `q.fardaAceita`, `q.achados`, `q.fardaFeita`.
    - As pessoas das missões têm prioridade no botão E quando o jogador está colado nelas.
  - **Colégio Adventista mais real**, a partir dos diretórios escolares (não achei foto aberta):
    - placa "R. Almirante Barroso, 261 · Centro";
    - quadra coberta aparecendo atrás do prédio;
    - placas de biblioteca, laboratório, auditório e sala de leitura;
    - parquinho.
  - O desenhista da C2 ganhou `goatee` (cavanhaque) e `collar` (gola de camisa social).
- **2026-11-27 · Claude:** **fliperama, Jorge, carro no mapa e batalha criativa** (`fliperama.js`, `jorge-anime.js`, `mapa3d.js`, `baile-concurso.js`, `game.js`, `docs/APIS-ANIMACAO.md`).
  - **Fliperama · IGOR COMILÃO** (jogo 11): retrato grande do Igor em pixel art. A boca abre quando a comida chega perto e ele mastiga, fica bravo e baba. O jogador cata comida nas bancas da feira e entrega na boca dele antes do tempo e da fome acabarem, com combo nas entregas seguidas. Dá para jogar em dupla cooperativa.
  - **Cutscene do Jorge:** pixelfx por cena (névoa no vazio, sombras subindo no tremor, poeira na queda do celular, eclipse nos olhos do vilão), com dono `jorge`.
  - **Viagem no mapa** (`mapa3d.js`): arrancada com poeira e faíscas, vultos do carro na velocidade, nuvenzinhas por baixo no voo, faíscas das rodas e marca de pneu no pouso.
  - **Batalha criativa:** depois de vencer o Freddy, falar com ele abre a **BATALHA DE RIMA**. É o motor de ritmo do concurso, agora configurável com `BaileConcurso.abrir({ config: { titulo, rival, premio, premioLook, ganhou, versos } })`, com versos originais. Flag `q.rimaFreddy`.
  - **ChatGPT:** as batalhas criativas da Conquista continuam com vocês. Se quiserem usar o motor de ritmo, é só passar o `config`.
  - Pesquisa de bibliotecas de animação em `docs/APIS-ANIMACAO.md` (seguimos com a pixelfx).

- **27/11 · Claude:** Nikolas ganhou `nikolas-fx.js` (só desenho; dano e áreas de acerto iguais). A troca de fase dele agora dura 3,6 s (era 2,4 s) para caber a cena do pão podre. Os anéis de choque das palmas (fase 2) e dos passos do titã (fase 4) têm `catarro:true` e viram ondas verdes. Três casas da favela (cena 5, x 510, 3867 e 5967) entram pelo sistema de salas (`WorldData.doors`); o `WorldData` é trocado por uma cópia com as portas novas antes do `game.js` carregar. Pasta `roblox/`: o jogo convertido para Luau (veja `roblox/README.md`); se mexerem em JS que o conversor não entende, ele avisa ao rodar `node roblox/ferramentas/converter.mjs`.

- **27/11 · Claude:** **atributos sem limite no modo desenvolvedor** (`progression.js`, `ui.js`, `hud.js`, `game.js`). Com `DAROCA_DEV` ligado (IPA dev ou `?dev`), cada atributo não para mais em 40: `Progression.spend(stat, qtd)` e `Game.spendStat(stat, qtd)` aceitam quantidade (até 1 milhão por vez, teto interno de 1 bilhão). Segurar o UPAR sobe cada vez mais rápido (1, 10, 100, 1.000 por vez), e os números grandes aparecem curtos (12K, 3M). Fora do modo dev, tudo continua igual: teto 40, e o `restore` corta para 40 qualquer save que venha do dev. `getState().teto` é `40` no normal e `null` no dev.
- **27/11 · Claude:** **cutscene do Jorge sem pixelfx** (`jorge-anime.js`). Voltou o desenho anterior, mas sem os efeitos da pixelfx que não combinavam com a cena (névoa no "vazio", sombras subindo no "tremor", fumaça na queda do celular e o eclipse nos olhos). O dono `jorge` não é mais usado no `FxPixel`.
- **27/11 · Claude:** **golpes com área de acerto igual ao desenho** (`golpes.js` novo; ganchos no `game.js`, `fx-pixel.js` e `campaign-vfx.js`).
  - **Corpos medidos dos sprites** (`Golpes.CORPO` e `Golpes.CAPANGA`): herói 14×76; chefes, capangas e ratos sem aura, fumaça ou objeto na mão. O Nikolas cresce por fase.
  - **Cada golpe tem a forma do desenho:**
    - onda de choque: crista de 26×58 px;
    - erupção: [x−r, x+r] até 80 px;
    - brasas: até 40 px;
    - feixe astral: do céu ao chão;
    - tiros: raio do desenho (`Golpes.TIRO`);
    - peidão: elipse em volta do Da Roça (`areaGas`).
  - **Acerto:** é "a forma encostou na caixa do corpo". Valem as exceções que já tinham forma própria: Igor (elipse), Jorge e motos da Conquista.
  - **Efeitos próprios no lugar da pixelfx nos golpes:** crista de pedra, gosma, fumaça, tinta e luz; gêiser de gosma; nuvem de fumaça; brasas; feixe; zona de provocação. A nuvem do peidão é desenhada no tamanho exato da área. O aviso antes do golpe mostra a área exata piscando.
  - A pixelfx continua só na troca de fase e na derrota dos chefes.
  - **Modo dev:** tecla H ou `?hitbox` mostra as caixas.
  - **ChatGPT:** `combate-chefes.js` e `fases.js` não foram mexidos. Se criarem perigos novos no `hazards`, eles já usam essas formas; para um tipo novo, acrescentem o desenho em `Golpes.desenharPerigo`.
- **27/11 · Claude:** **Roblox: arquivo pronto, guia e interface mais completa** (`roblox/`).
  - **`roblox/PASSO-A-PASSO.md`:** guia para colocar no Roblox: baixar, abrir no Studio, permissões, testar, publicar, som e público.
  - **`roblox/tools/gerar_rbxlx.py`:** monta o `DaRocaAdventure.rbxlx` a partir do `default.project.json`, sem precisar do Rojo.
  - **`.github/workflows/roblox.yml`:** publica o arquivo em Releases (`roblox-bN`) com os sons e o guia. O `.rbxlx` não fica mais no git.
  - **Protótipo antigo removido:** o 3D da fase do Igor (`src/client`, `src/server` e o `.rbxlx` antigo).
  - **Desenhista** (`src/runtime/desenhista.lua`):
    - janela aberta que não foi fotografada (`<dialog open>`, `role=dialog`) vira um painel automático no estilo do jogo, com textos, retrato e botões clicáveis (ex.: o "Tá difícil demais?" do SwiftGuide);
    - caixas com texto maior esticam em 9 pedaços.
  - **Captura** (`capturar.mjs`):
    - novo estado `luta`;
    - mais letras e ícones;
    - ícones SVG com a cor certa;
    - foto vazia não apaga pele boa;
    - o texto fica escondido mesmo com `!important` de id.
  - **`teste/sessao.lua`:** ações `chefe:<tipo>`, `chamar:Objeto.metodo`, `estado:` e `quem:x,y`.
  - **`golpes.js`** entrou na lista de scripts convertidos.
- **27/11 · Claude:** **peidão menor e mais leve; nada de caixas na tela** (`golpes.js`, `game.js`).
  - Raio do combo: 100 / 130 / 165 px (era 155 / 205 / 260). A área de dano acompanha a nuvem.
  - A nuvem virou bolinhas transparentes, sem o disco sólido, e some mais rápido.
  - O aviso antes dos golpes agora é só o chão rachando e brilhando na largura exata, sem contorno de caixa.
  - As caixas de acerto não aparecem mais pela tecla H; só com `?hitbox` no endereço, para testes.
- **27/11 · Claude:** **carro a gás na viagem do mapa** (`mapa3d.js`, `mapas.js`).
  - **Sem os vultos:** saíram as 3 cópias apagadas atrás do carro quando acelerava, as linhas brancas de velocidade e as nuvenzinhas que passavam por baixo dele.
  - **Jatos de gás** (`carroViagem`): dois jatos animados por baixo, com bico escuro e chama em camadas, mais longos no impulso da decolagem. Eles acendem enquanto o motor esquenta (`o.carregando`, `o.impulso`).
  - **No ar:** as rodas descem 1 px e param de girar; o chapéu do Da Roça balança; sai um respiro de gás do cilindro.
  - **Rastro de gás** mais leve e curto.
- **27/11 · Claude:** **Roblox: "Script timeout" ao carregar.** No Studio o carregamento passava de 10 s sem pausar, e o Roblox derrubava o script.
  - **`ui.js`:** com `window.DAROCA_ROBLOX` (posto pelo `carregar.lua`), pula as miniaturas dos cenários e os retratos do elenco da página do site, que não aparecem no Roblox. No Lua 5.3, o carregamento caiu de 8,2 s para 1 s.
  - **Pausas no carregamento:**
    - `carregar.lua` chama `op.ceder()` entre os scripts e eventos;
    - `canvas.lua` chama `C.ceder` a cada 48 desenhos;
    - o cliente pausa um quadro (`task.wait`) se já passou 0,5 s, e só durante o carregamento.
  - **`vendor__pixelfx`** não usa mais `--!native` e é carregado na tela de carregamento, não no meio do jogo.
- **27/11 · Claude:** **Roblox: quadros num laço próprio que pode pausar** (`roblox/src/cliente/DaRoca.client.lua`).
  - Os quadros não rodam mais presos ao `RenderStepped`: rodam num `task.spawn` com `RenderStepped:Wait()`, um de cada vez.
  - `Canvas.ceder` fica sempre ligado: se um quadro passa de 0,25 s, ele pausa e continua no quadro seguinte. Assim nenhum quadro pesado bate o limite de 10 s do Roblox.
  - Teclas, toques e texto que chegam durante a pausa ficam numa fila e são entregues no fim do quadro.
  - **`tela-inicial.js`:** com `DAROCA_ROBLOX`, o fundo fixo e a placa são montados no primeiro quadro, e não no carregamento.
- **27/11 · Claude:** **efeitos de golpe por personagem** (`golpes.js`; o `game.js` passa `activeBoss.type`).
  - **Base da pesquisa** (guia de VFX do League of Legends e linguagem de formas por elemento):
    - cada poder tem forma e cor próprias, e dá para ler mesmo sem a cor;
    - clarão curto no impacto, depois a forma forte, depois um resto fraco;
    - animação em degraus de ~12 quadros/s.
  - **Estilos** (`DONO` → `CRISTA` e `CHAO_ESTILO`), sempre dentro da área de acerto:
    - Freddy: lascas de cimento e poeira;
    - Igor: chão de gelatina com pizza e coxinha;
    - Arthur: arcos de vento;
    - Marco: onda de tinta riscada e lápis furando o chão;
    - Caderno do Caos: folhas de caderno;
    - Menezes: onda de esgoto com rato e bueiro estourando;
    - Nicolas: parede de estrelas;
    - Reeis: ouro e moedas;
    - Kaique: grade de laser;
    - Dedé: fumaça em rolos com cinza e brasa;
    - Nikolas: gosma.
  - Para chefe novo, basta pôr o tipo dele em `DONO` com um estilo.
- **27/11 · Claude:** **oficina, lanchonete e açude com muito mais detalhe em pixel** (`lugares-fundos.js` e `lugares-c1.js`).
  - **Oficina:**
    - janelas e porta de enrolar vazadas: o céu e a rua aparecem de verdade, com casa do vizinho, mangueira e galinha;
    - teto com telhas translúcidas (feixes de sol com poeira de dia, escuras à noite) e tesoura de aço;
    - quadro de luz, macaco jacaré, carretel de mangueira, extintor, prateleira de tintas, correias penduradas;
    - motor no cavalete, carrinho de ferramentas, máquina de solda com cilindro, tambor de estopa, vassoura;
    - relógio, foto antiga, estante de aço, placa de saída, exaustor girando, aranha na teia, compressor que liga;
    - faixa amarela em volta do elevador, área zebrada, serragem no óleo, porcas e chave no chão.
  - **Lanchonete:**
    - piso de ladrilho hidráulico (dois desenhos alternados), faixa de azulejo azul e branco, rodapé verde;
    - passa-prato com cozinheiro animado, prateleiras de dendê, pimenta, doce, farinha e potes de bala;
    - placa "FIADO SÓ AMANHÃ", relógio, banquetas, mesas com ketchup e suco de cacau, pinguim na geladeira;
    - samambaias, camisa do time do bairro, mural de bilhetes, ventilador de parede e mais um de teto;
    - rua de paralelepípedo, moto, orelhão, lixeira, cachorro caramelo, gente passando, fitinhas do Bonfim.
    - Carro e bicicleta não atravessam mais o salão: ficam recortados na rua.
  - **Açude:**
    - mata ao longe com ipês floridos e palmeiras, cata-vento girando ao lado da casinha;
    - barranco com terra molhada, seixos, raízes, aguapés e flores; capim que balança em três quadros;
    - chão com trilha batida, pegadas, pedras, folhas secas, cogumelos, poças e formigas;
    - patos nadando em fila, folhas boiando, linha e boia da vara do Seu Vagner; píer com pregos, musgo e corda.
  - **Custo no Roblox:** o chão e o barranco do açude viraram imagens guardadas (desenhadas uma vez). O quadro ficou
    igual ou mais leve que antes no teste em Lua 5.3; só a primeira entrada no açude monta mais coisa (~0,3 s a mais).
  - `teste/sessao.lua` ganhou `cena:<n>:<câmera>:<tempo>[:noite]`. O `converter.mjs` não repete mais o cabeçalho
    nos arquivos do `capturar.mjs`.
