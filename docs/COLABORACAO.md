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
