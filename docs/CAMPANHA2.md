# Campanha 2 · Vitória da Conquista

Continuação canônica, um ano depois da campanha principal. A Campanha 2 fica em arquivos separados, dentro de `dist/campanha2/`, e não muda a campanha original.

A construção vai passo a passo. Cada passo só começa depois da aprovação do anterior.

| Passo | Conteúdo | Situação |
| --- | --- | --- |
| 1 | Personagens no mesmo traço | feito e aprovado |
| 2 | Cenários (2A a 2D): ambientes, camadas, 7 cenários novos, moradores | feito e aprovado |
| 3 | Poderes de Da Roça e mural para trocar | feito e aprovado |
| 4 | Locomoção: mapas, táxi do Seu Zé e loja de garrafadas | feito e aprovado |
| 5 | Cutscenes | feito e aprovado |
| 6 | O jogo: 6A prólogo jogável · 6B vilões 1 a 4 · 6C vilões 5 a 8 · 6D Jorge, final e créditos (a Campanha 2 inteira jogável) | 6A, 6B e 6C feitos · **6D feito, aguardando aprovação** |

## Passo 1 · Personagens (`dist/campanha2/personagens.js`)

**Como foram feitos**
- **Esqueleto:** o mesmo dos personagens mais novos do `art.js`, com as mesmas medidas de cabeça, tronco e membros e as mesmas cores de contorno e sombra.
- **Acabamento:** o arquivo carrega antes do `char-detail.js`, então os novos também ganham o contorno, a luz de borda e o sombreado da qualidade realista.
- **Uso:** `Art.drawCharacter(ctx, tipo, x, y, opções)`. As opções são `frame`, `facing`, `moving`, `grounded`, `attack`, `attackProgress`, `hit`, `dash`, `charging` e `emotion`. Valores de `emotion`: `sad`, `cry`, `shock`, `angry`, `happy` e `smug`. As opções da cutscene final são `reach` (mão estendida), `rage` e `item: false`.
- **Personagens antigos:** continuam idênticos. A comparação pixel a pixel deu 0 diferenças.

**Lista de personagens**

| Grupo | Tipo no código | Personagem |
| --- | --- | --- |
| Trio | `daroca`, `reeis` | os mesmos de sempre |
| Trio | `jorge_gordo` | Jorge na época do trio, o "Gordo": gordinho, cachos, óculos finos e moletom preto com estampa de pizza com contorno branco |
| Trio | `jorge` | Jorge hoje: magro, cachos, óculos finos, bigodinho ralo e camiseta marrom |
| Trio | `jorge_celular` | o mesmo Jorge de hoje, com o celular na orelha (cenas da ligação) |
| Amigo | `miguel` | Miguel: forte (estilo Caleb), óculos azuis, cabelo curto e liso de lado, alça de mochila de viajante |
| Amigo do Jorge | `fred_conquista` | Fred de Conquista: cabelo preto ondulado com topetinho pequeno. É um tipo separado do `freddy` da campanha 1 |
| Flashback | `crianca_daroca`, `crianca_reeis`, `crianca_jorge` | o trio criança |
| Flashback | `pre_daroca`, `pre_reeis`, `pre_jorge` | o trio com uns 12 anos |
| Aliados | `c2_ze_taxi` | Seu Zé do Táxi |
| Aliados | `c2_lurdes` | Dona Lurdes |
| Aliados | `c2_mel` | Mel |
| Aliados | `c2_biscoito` | Biscoito, o cachorro caramelo |
| Aliados | `c2_picole` | Tio do Picolé, tremendo de frio |
| Aliados | `c2_nando` | Nando Skatista |
| Aliados | `c2_vo_cida` | Vó Cida |
| Aliados | `c2_juninho` | Juninho Mecânico |
| Aliados | `c2_larissa` | Larissa da Biblioteca |
| Aliados | `c2_gugu` | Gugu do Ferro-Velho |
| Aliados | `c2_bia` | Bia do Arrocha |
| Aliados | `c2_carlinhos` | Carlinhos |
| Vilões | `c2_creuza` | Dona Creuza |
| Vilões | `c2_tonhao` | Tonhão do Mototáxi |
| Vilões | `c2_valdomiro` | Seu Valdomiro |
| Vilões | `c2_kaua_influencer` | Kauã Influencer. O nome é diferente do `kaua` da campanha 1 |
| Vilões | `c2_barao` | Barão do Café, com o olho tremendo de cafeína |
| Vilões | `c2_breno` | Breno Pitbull, com fase de fúria |
| Vilões | `c2_ryan`, `c2_bryan` | os gêmeos Ryan e Bryan |
| Vilões | `fred_conquista` | Fred |
| Chefe final | `jorge` | Jorge |

**O que fica para os próximos passos**
- **Falas, histórias e missões:** dependem dos cenários e das cutscenes.
- **Ataques específicos dos chefes:** o cabelo do Fred e os golpes do Jorge entram no passo dos poderes e dos chefes.

## Passo 2 · Cenários (`dist/campanha2/cenarios.js`)

**Pesquisa:** antes de desenhar, olhei fotos reais do Wikimedia Commons:
- o Cristo de Mário Cravo na Serra do Periperi;
- a Catedral Nossa Senhora das Vitórias;
- a marquise do Aeroporto Glauber Rocha;
- a Avenida Olívia Flores, com a ciclovia no canteiro central;
- o Centro de Cultura, o comércio do centro e a vista da cidade.

O que as fotos mostram de Conquista:
- **Cidade:** um planalto plano coberto de prédios brancos e bege.
- **Catedral:** fachada creme, uma torre central com relógio e agulha, janelas ogivais, nave lateral e grade de ferro na frente.
- **Cristo:** uma cruz alta e fina, sobre um disco num pilar.
- **Clima:** o frio e a neblina viraram piada recorrente nos cenários.

**Como funciona:** os cenários usam o mesmo motor dos cenários HD atuais. O `hd-maps.js` ganhou duas coisas:
- `HdMaps.register`, para registrar as cenas 12 e seguintes;
- `HdMaps.kit`, com as ferramentas de desenho.

Por isso os cenários novos têm o mesmo céu realista, a hora do dia, as sombras do sol, as luzes à noite, as folhas que reagem e o shader. As fases 0 a 11 não mudaram: passei por todas nas três qualidades, com sol, chuva e neve, e não apareceu nenhum erro.

| Cena | Cenário | Destaques |
| --- | --- | --- |
| 12 | Aeroportos | **Itabuna:** saguão, check-in com fila de fitas, painel de voos, raio-X com esteira e pórtico, portão de embarque. **Pista:** o avião com escada. **Glauber Rocha:** marquise branca com letreiro azul, vidraças, esteira de bagagem e o táxi do Seu Zé na saída |
| 13 | Bairro da pensão | Pensão Dona Lurdes (sobrado), casinhas coloridas com muro, padaria com fumaça de pão quente, mercadinho, postes com fiação e muita neblina |
| 14 | Centro e Praça da Catedral | Catedral (fiel à foto), Praça Tancredo Neves com coqueiros, bancos, pombos e postes, comércio com toldos, Memorial e fiação. À noite, a catedral iluminada |
| 15 | Serra do Periperi | Morro de pedra e cerrado, cactos cabeça-de-frade (típicos da serra), torres de antena, vento no capim, neblina passando e a cidade lá embaixo. No alto, o Cristo de Mário Cravo. Fase de subida com 3 ravinas |
| 16 | Monumento ao Índio | Avenida com trânsito nos dois sentidos (carros, ônibus, motos), semáforos, posto, outdoors com piadas e a rotatória com a estátua de bronze. Fase de perseguição com buracos de obra |
| 17 | Feira e biscoitarias | Barracas de lona colorida com frutas e grãos, três biscoitarias com potes de biscoito de polvilho e vapor saindo do forno |
| 18 | Fazendas de café | Fileiras de café com grãos vermelhos, eucaliptos, sede com varanda, terreiro de secagem, secador girando, descascadora e caixa-d'água. Canais de irrigação |
| 19 | Teatro e Planetário | Centro de Cultura (bloco cinza), Teatro Glauber Rocha com marquise de lâmpadas e cartazes, cúpula do Planetário, holofotes e estrelas. Fase noturna |
| 20 | Shopping | Redesenhado com profundidade. **Fundo:** átrio com cobertura de vidro e treliça, dois andares de lojas ao longe com guarda-corpo, gente e escadas rolantes cruzando o vão. **Frente:** mezanino com guarda-corpo de vidro e corrimão cromado, colunas cilíndricas sombreadas, forro com spots. **Térreo:** lojas com revestimento de granito, letreiro em caixa de luz e vitrine iluminada com produtos sombreados (manequins, games, tênis, perfumes, livros, pelúcias), praça de alimentação com menu iluminado e balcão de inox, cinema art déco com pôsteres e tapete vermelho, lan house com neon. **Piso:** mármore polido com veios e reflexo das lojas. Elevador panorâmico, escada rolante, fonte, faixas do Festival de Inverno e muita gente |
| 21 | Olívia Flores e Escola SESI | Avenida com ciclovia no canteiro central, coqueiros e prédios altos. Na escola: pátio, quadra coberta em arco, auditório e laboratório de informática |

**Versão detalhada:** a primeira versão estava seca. Os cenários foram refeitos no nível dos mapas da campanha principal.
- **Fundo em camadas:** a serra azulada com antenas e o Cristo bem pequeno. A cidade longe, com caixas-d'água, antenas, faixas coloridas e guindastes. A cidade perto, com varandas, ar-condicionado e casinhas de telhado vermelho. Uma faixa de árvores com ipês roxos e amarelos. Pássaros em bando e pipas.
- **Fachadas:** reboco com manchas, tijolo, telhas, janelas com grade, veneziana ou vidro, cortinas, plantas na janela, varandas com varal ou vasos, ar-condicionado, caixa-d'água, antena e parabólica.
- **Rua:**
  - mobiliário: orelhão, banca de revista, ponto de ônibus, lixeiras, hidrante, placa de rua, postes com transformador e fiação;
  - comércio: camelôs com guarda-sol, motos, bicicletas e carros;
  - decoração: bandeirinhas, grafite e cartazes;
  - vida: gatos, cachorro, pombos, galinhas, gente de casaco e cachecol (faz frio) e trânsito andando;
  - chão: calçada com meio-fio pintado, faixa de pedestre, bueiro e calçadão de pedra portuguesa.
- **Interativos:** usam o mesmo sistema da campanha principal, por meio do `Interact.addScene` novo:
  - quebram: caixotes, vasos, melancias, fardos de feno, barris e cercas;
  - rolam: lixeiras, cones, bolas, baldes e pneus;
  - outros: portas que abrem, poças, capim que pega fogo e churrasqueiras;
  - alavancas com efeitos: luzes de festa, holofotes, irrigador na fazenda e sinal da escola.

**Plataformas de cada cenário** (`CampanhaCenarios.plataforma`, usada pelo `drawPlank` do jogo nas cenas 12 e seguintes):

| Cenário | Plataforma |
| --- | --- |
| Aeroporto | Passarela de metal com grade, faixa de segurança e rebites |
| Bairro | Laje de concreto pintada, com azulejo, ferro aparecendo e vasinho |
| Centro | Cornija de pedra com molduras, mísulas e pombo |
| Serra | Ilha de terra com camadas, pedras, raízes, musgo, flores e o cacto da serra |
| Avenida | Mureta de concreto com faixas refletivas e pichação |
| Feira | Caixotes de madeira com frutas |
| Fazenda | Ilha de terra roxa com pés de café |
| Teatro | Treliça de palco com lâmpadas piscando |
| Shopping | Vidro com borda cromada e plantas |
| SESI | Concreto com faixa azul e grama |

**Plantinhas interativas** (`dist/campanha2/plantas.js`): canteiros de capim, flores, samambaias, matinho de calçada com dente-de-leão, pés de café e floreiras.
- **Ao passar:** as plantas se abrem quando o Da Roça passa e voltam balançando, com som de mato.
- **O que soltam:** pétalas, folhas, sementes voando e grãos de café.
- **Golpe:** corta as plantas, e elas crescem de volta.
- **Cacto da serra:** dá um "AI!", sem tirar vida.

**Objetos de cenário:**
- **Cidade:** bancos, vasos grandes, sacos de lixo, caixas, cavaletes de promoção, carrinho de pipoca, caixa de correio, cadeiras de plástico, placa de PARE e isopor.
- **Natureza:** troncos, tocos, pedras, cupinzeiros, carrinho de mão, regador e placas de trilha.
- **Lugares fechados:** carrinho de bagagem e placa de piso molhado.
- **Chão da frente:** folhas secas, papéis e pedrinhas.

**Fundo vivo:**
- **Ao longe:** carrinhos na estrada do planalto, com farol à noite. Guindastes girando com o gancho balançando, fumaça subindo da cidade, bandeiras tremulando, árvores balançando com o vento, pássaros e pipas.
- **Céu:** às vezes passa um avião deixando rastro.
- **À noite:** janelas acendendo e apagando e as luzes das antenas da serra piscando.
- **Fios dos postes:** no bairro e no centro há passarinhos que saem voando quando o Da Roça chega perto ou pula, e voltam depois. Para isso, o jogo informa a posição do herói com `CampanhaCenarios.heroi`.

**Visualizador:** abra o jogo com `?cenarios2` no fim do endereço.
- **Andar:** setas ou ◀ ▶.
- **Pular:** espaço.
- **Bater:** J. Quebra os objetos e liga as alavancas.
- **Trocar de cenário:** `[` e `]`, ou os botões.
- **Trocar a hora:** os botões ou as teclas 1 a 4.

**Itabuna:** a missão do passaporte reusa a fase 0 (a Roça) e o mapa de Itabuna que já existem. Não há cenário novo; o reuso entra no Passo 5.

**O que fica para o Passo 5:**
- ligar as cenas 12 a 21 ao jogo: menu "Campanha 2", portas, missões, inimigos, chefes, save e bloqueio de Itabuna depois do embarque;
- o clima de chuva e neve nessas cenas. A neblina já vem nos cenários.

## Passo 2A · Ambientes com entrada (`dist/campanha2/ambientes.js`)

O Passo 2 foi dividido em partes:
- **2A:** ambientes com entrada.
- **2B:** redesenho dos outros cenários, paródias de lojas, população e engarrafamento.
- **2C:** 7 cenários novos.
- **2D:** 10 personagens com história e 20 moradores para conversar.

O Passo 4 passa a ser a forma de locomoção.

| Cena | Ambiente | Como se chega |
| --- | --- | --- |
| 22 | Frente do Shopping: fachada com átrio de vidro, porta giratória, marquise, lojas âncora (AMENICANAS, RIACHORRO), cartazes de cinema, totem, estacionamento com cancela, táxis e ponto de ônibus | botão **ENTRAR NO SHOPPING**, que leva ao shopping (cena 20). Lá dentro, **SAIR DO SHOPPING** volta |
| 23 | Shopping, piso 2: cobertura de vidro em arcos, lojas paródia (RIACHORRO, MAGAZINE LURDES, SENTAURO, O BUTECÁRIO, CACAU CHOU, LIVRARIA CUTUCADA, GAMESTOPA, RI TRISTE, AMENICANAS), escada rolante descendo | **escada rolante interativa**: no térreo, **SUBIR** faz o Da Roça subir os degraus e chegar ao piso 2. No piso 2, **DESCER** volta |
| 24 | Corredor da pensão em **recorte estilo Terraria**: caixa menor no meio da tela, borda de blocos e o resto preto. Papel de parede florido, lambri de tábuas, portas 1 a 5 (a 4 com tapetinho vermelho), tochas que tremulam, lustres, quadros de Conquista, cabideiro, relógio de pêndulo, estante, baú, vaso, janelinha com neblina, gato respirando, tapete vermelho e a mesinha com o bilhete "CADÊ MEU RÁDIO? —LURDES" | **ENTRAR NA PENSÃO** no bairro (cena 13). As paredes da caixa seguram o Da Roça (`limites`) |
| 25 | Quarto do Da Roça, **pequeno e estilo Terraria**: só cama, lamparina, janela, mesa com computador e armário. A janela mostra a neblina de dia e o céu com estrelas e luzes da cidade à noite | porta **QUARTO 4** do corredor. O **computador abre o Fliperama**. O **armário abre a personalização** da roupa (a mesma tela do espelho da Bigodon, com o título "ARMÁRIO DO QUARTO 4") |
| 26 | Escola SESI por dentro: forro com luminárias, janelas, salas com a turma no visor, armários com adesivos, mural de cortiça, desenhos dos alunos, troféus, bebedouro, extintor, alarme, lixeiras coloridas e banco. **Sala da escada:** degraus com faixa amarela, corrimão azul, patamar com a porta do pátio, aviso "não corra", desenho de aluno, luz de emergência, extintor e vaso | **ENTRAR NA ESCOLA** na Olívia Flores (cena 21). Ao passar pela **porta ESCADA**, a parede some e **todo o resto da escola fica preto**, como o corredor; só a sala da escada aparece, com borda de blocos. O Da Roça sobe andando |
| 27 | Pátio no 2º andar: cantina, mesas, mural de mosaico, pingue-pongue, cesta de basquete, coleta seletiva e a cidade atrás do guarda-corpo | no alto da escada da escola. A porta **DESCER A ESCADA** volta |

No visualizador, ao chegar perto de uma passagem aparece o balão **[E] …** e o botão grande **ENTRAR / SAIR / SUBIR / DESCER / USAR**.

## Passo 2B · Camadas, lojas paródia, população e engarrafamento (`dist/campanha2/camadas.js`)

Os nove cenários de rua (12 a 19 e 21) ganharam uma camada do meio entre a cidade lá longe e a rua do Da Roça. Ela tem parallax próprio, gente andando, carros, letreiros e janelas acesas à noite. Também ganharam detalhes no plano das fachadas, mais gente na calçada e um primeiro plano perto da câmera. Os letreiros usam uma fonte pixel 3x5 (`CampanhaCamadas.texto`).

| Cena | Camada do meio | No plano das fachadas e na frente |
| --- | --- | --- |
| 12 Aeroportos | Pátio visto pelas vidraças: hangares, torre de controle, aviões parados, caminhão de combustível, trem de bagagem, carro SIGA-ME, avião taxiando e sinaleiro com as varetas | Fila do check-in com malas; poltronas e pilastras com fita em primeiro plano |
| 13 Bairro | Encosta com casinhas coloridas em quatro degraus, escadarias com gente subindo e descendo, varais, caixas-d'água, igrejinha com sino e campinho de terra com a molecada jogando bola | Dona Lurdes regando as plantas na sacada da pensão (à noite, a silhueta na janela) |
| 14 Centro | Rua de trás com prédios altos, lojas paródia, outdoors nos telhados e o relógio-termômetro que alterna a hora com a temperatura (de 7 °C a 19 °C, conforme a hora) | Letreiros de caixa de luz nas lojas da frente e placas ABERTO piscando |
| 15 Serra | Uma serra lá atrás com trilha em zigue-zague, trilheiros de mochila, antena com luz e mirante; parapente voando em círculos | Trilheiros com cajado; capim, pedras e samambaias em primeiro plano |
| 16 Avenida | Torres de vidro e prédios com lojas paródia, outdoors e um painel de LED que troca de propaganda | Letreiros das lojas; outdoors "MOTOTÁXI? SÓ NO PREÇO JUSTO" e "COMPRE UM CASACO. SÉRIO. AQUI FAZ 12°C" redesenhados |
| 17 Feira | Mercado Municipal com cobertura em arcos, igrejinha com sino e pombos, comércio com lojas paródia | Feirantes atrás das bancas, mexendo os braços |
| 18 Café | Dois morros de cafezal com fileiras e grãos vermelhos, árvores de sombra, sede e celeiro, trator levantando poeira na estradinha, colhedores e vacas | Trabalhadores puxando o café no terreiro com o rodo; pés de café em primeiro plano |
| 19 Teatro (noite) | Festival de Inverno: roda-gigante girando com luzes, fogos de artifício, barracas iluminadas com gambiarra e a faixa do festival | Gambiarra de lâmpadas coloridas entre os postes |
| 21 Olívia Flores | Torres com sacadas e vidro, academia SMART FAT com gente correndo nas esteiras e farmácia PAGUE MAIS com a cruz piscando | Gente se exercitando na academia ao ar livre |

**Lojas paródia** (só o nome brinca com o original; não há logotipos): CASAS BAIXA, PAGUE MAIS, ESCURO CELULARES, RICARDO ELÉTRICO, INSISTENTE, ÓTICA DIZ-QUE-VÊ, LOTÉRICA SORTE GRANDE, C&Á, PERNAMBUCRANAS, RAVAIANAS, DROGARIA SÃO PAULINHO, HABIBIS, BOBO'S, CHILLI BEIÇO, NATURRA, POLISHOPE, KALUNGO, BANCO DO BRASIU, RENÊ, SUBUÁI, BURGUER QUINGUE, STARBUCHO CAFÉ, ATACAREJÃO, G. BARBUDA, SMART FAT, MAGAZINE LURDES e AMENICANAS. Os outdoors brincam com NETFLIQUIS, o Ubé ("CHEGA QUANDO DER") e o frio de Conquista.

**População:** cada cenário tem de 12 a 20 pessoas a mais andando nos dois sentidos, sem interação. Há gente com sacola, gente olhando o celular, gente passeando com cachorro, mãe de mãos dadas com a criança e guarda-chuva quando chove. A camada do meio tem mais gente pequena e carros na rua de trás.

**Engarrafamento:** a cada chegada na Avenida (16) ou no Centro (14), há 40% de chance de a faixa da frente estar parada.
- Na frente está o Fusca azul do Seu Arlindo, com o pisca-alerta ligado. Ele parou para comprar biscoito de polvilho do vendedor, que fica com o tabuleiro na janela.
- Logo atrás vem o carro prata do Ubé, com os dois personagens novos:
  - **Cleiton do Ubé** (`c2_cleiton`): motorista de aplicativo, de boné e bigode. Buzina sem parar e põe o braço para fora sacudindo o punho porque tem corrida marcada no Shopping.
  - **Dona Rosilda** (`c2_rosilda`): a sogra dele, de bobes cor-de-rosa e óculos. Vai para a consulta, reclama do Fusca e reclama do Cleiton também ("EU AVISEI PRA IR PELA OLÍVIA!").
- As falas aparecem em balões, uma de cada vez. Quando o Da Roça chega perto, eles falam com ele ("Ô DA ROÇA! EMPURRA ESSE FUSCA AÍ!") e aparecem os nomes.
- A fila tem uns 25 carros (hatch, sedã, picape e van), com motoristas na janela, fumaça do escapamento, buzinas "BI-BI!" e uma moto costurando entre os carros. Nenhum carro para em cima de um buraco da pista. A outra faixa continua andando devagar e, à noite, acendem faróis, lanternas e o pisca-alerta.
- Para testar: `CampanhaCamadas.engarrafamento(16, true)` (ou `false`; `null` volta ao sorteio).

Os dois também estão em `personagens.js`, para as missões. Nada nesta camada é sólido nem interativo, e a campanha 1 não muda.

## Passo 2C · Sete cenários novos (`dist/campanha2/novos-a.js` e `novos-b.js`)

Os sete cenários seguem o mesmo padrão dos outros: arte de 482x270 escalada 2x, chão em y=220 e várias camadas com parallax. Todos têm gente andando, animações no fundo, luzes à noite, objetos interativos (Interact), plataformas com tema próprio, plantinhas interativas e primeiro plano. As empresas e marcas são paródias (só o nome).

| Cena | Cenário | Camadas e detalhes | Plataformas |
| --- | --- | --- | --- |
| 28 | **Reserva do Poço Escuro** | **Fundo:** morros de mata azulados, copas mais perto e o interior da mata com troncos, cipós, bromélias e o teto de folhas.<br>**Na trilha:** árvores enormes com sapopemba, musgo, orquídea, orelha-de-pau e oco; cerquinha de madeira e placas ("NÃO ALIMENTE OS SAGUIS"); tronco caído com cogumelos, cupinzeiro e a guarita do guarda-parque.<br>**O poço:** paredão de pedra com cascata animada, espuma, névoa e ondas na água escura, com um sapinho na pedra.<br>**Bichos e efeitos:** saguis pulando de galho em galho, tucano voando, borboletas azuis, folhas caindo e raios de sol entre as folhas. À noite aparecem vaga-lumes e a coruja no oco.<br>**Vão:** um riacho com água. | tronco com musgo, cogumelos e raízes |
| 29 | **Estádio Lomanto Júnior** | **Lado de fora:** fachada de concreto com nervuras e arcos com a torcida, bilheteria com fila, espetinho com fumaça, pipoca, camisas penduradas e o PORTÃO 3 com catracas.<br>**Lado de dentro:** a pista de atletismo; do outro lado do gramado, a arquibancada lotada com cobertura, refletores e placas de publicidade paródia.<br>**O jogo:** jogadores correndo atrás da bola, goleiro e placar PLANALTO x CACAUEIROS com o tempo de jogo. A torcida faz a ola.<br>**Gol (a cada 45 s):** a torcida pula, o placar pisca "GOOOL!" e sobem sinalizadores.<br>**Na pista:** banco de reservas, técnico gritando, câmera de TV e o mascote BODÃO dançando.<br>**Primeiro plano:** a torcida de costas com bandeiras, levantando os braços no gol. | arquibancada de concreto com cadeiras coloridas |
| 30 | **Terminal Rodoviário** | **Saguão:** guichês de NOVO HORIZONTINHO, ÁGUIA BRANQUINHA, SÃO GERALDINHO, RÁPIDO FEDERALZINHO, GONTIJINHO e CAMURUJIPINHO. Tem painel de partidas que vai trocando (EMBARQUE piscando, ATRASADO), letreiro de aviso correndo e COXINHA DO TERMINAL. Também tem banca, guarda-volumes, WC R$1, cadeiras com um dorminhoco, vendedor de amendoim e pombos.<br>**Plataformas 1 a 7:** ônibus chegando, abrindo o bagageiro para o embarque e indo embora, com destino no letreiro (Salvador, Itabuna, Jequié, Brumado...).<br>**Atrás:** a avenida com lojas e trânsito. | pilhas de malas |
| 31 | **UESB** | **Prédios:** módulo de aulas com pilotis e a faixa da semana do calouro, Cantina da Tia com cardápio e mesas, Biblioteca Central de vidro com estantes, muro do DCE grafitado com mural de avisos, RU com fila e cardápio do dia, e Xerox do Seu Zé ("APOSTILA R$0,10 A FOLHA").<br>**Área verde:** ipês, bicicletário e ponto do CIRCULAR.<br>**Atrás:** mais módulos, a caixa-d'água da UESB, eucaliptos e o ônibus circular passando.<br>**Vida no campus:** roda de violão com notinhas subindo, frisbee, estudante atrasado para a prova com folhas voando e o Caramelo do campus dormindo. | pilhas de livros |
| 32 | **Lagoa das Bateias** | **A lagoa:** a outra margem com casinhas e árvores refletidas na água, marolinhas, brilho do sol e, à noite, o reflexo dos postes e da lua. Tem ilhota com garças, uma garça voando, pedalinhos de cisne, família de patos e peixe pulando.<br>**Na margem:** píer com pescador ("PEGUEI UM!"), quiosque de água de coco, aluguel de pedalinho, academia ao ar livre e pista de caminhada com marcação de metros.<br>**Vão:** um braço d'água. | deque de madeira |
| 33 | **Parque da Cidade** | **Brinquedos:** parquinho com balanços, escorregador e gangorra animados e caixa de areia; pista de skate com skatista no bowl.<br>**Turma do parque:** academia da terceira idade e mesa de dominó ("BATI!", "É CARROÇA!"), piquenique com famílias, moço das bolhas de sabão e carrinhos de picolé, algodão-doce e pipoca.<br>**Parcão:** cachorros correndo atrás da bolinha.<br>**Atrás:** o trenzinho passando entre as árvores. | brinquedo de parquinho |
| 34 | **Serra do Marçal** | **O vale lá embaixo:** retalhos de plantação, rio e cidadezinhas que acendem à noite. Por cima passa um mar de nuvens.<br>**A encosta:** a estrada em curvas com carros e caminhões descendo e torres eólicas girando.<br>**No mirante:** defensa metálica, barraca de MEL · REQUEIJÃO · CAFÉ, caminhão parado com o caminhoneiro comendo marmita e o cruzeiro com velas.<br>**Voo livre e vento:** a rampa de voo livre tem biruta e um parapente que corre, decola e plana para o vale. Há torres de rádio e vento passando.<br>**Vão:** uma ravina. | ilha de pedra com cactos |

Para os cenários novos, `CampanhaCamadas.configurar` liga a população, o primeiro plano e os trilheiros, e `CampanhaPlantas.adicionar` cria os canteiros de plantinhas. Um vão pode ter cor própria com `vao: { fundo, borda }`: água na lagoa e no riacho.

## Passo 2D · 10 personagens novos e 20 moradores (`dist/campanha2/moradores.js`)

Cada pessoa fica parada no seu canto de um cenário. Quem você ainda não conhece tem um **!** em cima da cabeça: amarelo para os personagens e azul para os moradores. Chegando perto aparece **[E] CONVERSAR COM …** (no celular, o botão **FALAR**).

A caixa de conversa mostra o retrato, o nome, quem a pessoa é e o texto aparecendo aos poucos. Há três assuntos para escolher, com o mouse, com o toque ou pelas teclas de 1 a 4: **Quem é você?**, **Me fala da cidade** e **E a sua história?**, mais **Tchau!**. Os assuntos já lidos ganham ✓.

O **caderninho** conta quantos dos 30 você já conheceu. Ele fica guardado no navegador em `daroca-c2-conhecidos`, separado do save do jogo. Durante a conversa o controle do Da Roça fica pausado.

Os fatos da cidade são gerais e conhecidos: os povos indígenas do planalto, os nomes antigos da cidade, a Rio-Bahia, o café, o frio, Glauber Rocha, Elomar, o Cristo de Mário Cravo, a UESB e o Festival de Inverno. Lenda aparece como lenda ("dizem que…").

**Personagens novos** (têm história mais longa e podem voltar nas missões):

| Personagem | Onde | Quem é |
| --- | --- | --- |
| **Professora Lúcia** (`c2n_lucia`) | UESB | Professora de História há mais de 20 anos. Junta fotos antigas da cidade e conta dos povos indígenas, dos nomes antigos e de Glauber e Elomar. Veio da roça e foi a primeira da família na faculdade. |
| **Seu Bené Engraxate** (`c2n_bene`) | Rodoviária | Engraxa sapato há 40 anos. Chegou com 16 anos, uma mala de papelão e a lata de graxa do pai, "pra ficar uma semana". |
| **Tainá** (`c2n_taina`) | Monumento ao Índio | Estudante de Antropologia com raiz indígena e guia voluntária. Sonha com um museu vivo. |
| **Mestre Zé Pandeiro** (`c2n_ze_pandeiro`) | Feira | Sanfoneiro e cantador. Fala do São João, do forró pé de serra e do licor de jenipapo. Ensina a molecada a tocar de graça. |
| **Doutora Fabi** (`c2n_fabi`) | Parque da Cidade (Parcão) | Veterinária da feira de adoção. O Tripé, cachorro de três patas, foi quem adotou ela. |
| **Gabi do Voo Livre** (`c2n_gabi`) | Serra do Marçal | Ex-mototaxista com medo de altura que virou instrutora de parapente. |
| **Dona Zefa do Café** (`c2n_zefa`) | Fazenda de café | Sessenta safras e coador de pano. Replantou o cafezal depois da geada e não vende a terra para o Barão do Café, o vilão. |
| **Rafa Goleiro** (`c2n_rafa`) | Lomantão | Goleiro supersticioso do Planalto FC. Começou com luva de pano de prato e sonha com a Série A. |
| **Irmã Celeste** (`c2n_celeste`) | Catedral | Cuida da sopa solidária e escuta heavy metal escondido. Era baterista da banda "Neblina Mortal". |
| **Kiko do Pedalinho** (`c2n_kiko`) | Lagoa das Bateias | Tem 15 anos e diz que é "gerente" dos cisnes. Conta a lenda da pepita no fundo da lagoa e junta dinheiro para estudar Biologia. |

**Moradores** (só para conversar): Seu Agenor e Dona Neide (Centro); Wellington Mototaxista e Marquinhos do Lava-Jato (Avenida); Lia Ciclista (Olívia Flores); Dona Cotinha da Biscoitaria (Feira); Pedro, estudante de Medicina, e Tia Lourdinha da Cantina (UESB); Josué, segurança do Shopping; Tia Rosa do Acarajé e Vó Dalva (Bairro); Cauã, o menino da pipa (Parque); Seu Toninho Pescador (Lagoa); Jurema da Rodoviária; Beto Taxista, rival do Seu Zé (Aeroporto); Ana Clara, guia do Cristo (Serra do Periperi); Ronaldo, guarda-parque (Poço Escuro); DJ Thiaguinho (Teatro e Festival); Seu Zezinho, colhedor de café (Fazenda); e Marina Fotógrafa (Serra do Marçal).

Os moradores citam uns aos outros e os personagens da campanha: o Fusca do Seu Arlindo, o Tonhão, o Seu Zé do Táxi, a Dona Lurdes e o Barão do Café.

No código: `CampanhaMoradores.conversar(id)`, `lista()`, `conhecidos()` e `esquecer()`. Os desenhos estão em `CampanhaPersonagens.registrar`.

## Passo 3 · Poderes e o sistema de escolher poder (`dist/campanha2/poderes.js` e `treino.js`)

**O que o Da Roça leva para Conquista.** Ficam os botões da campanha 1 que você escolheu: **joystick, FALAR, PULAR/VOAR, PEIDO, BOLINHA DE PAPEL e DASH**, com as mesmas teclas (E, Espaço, K, J e L). **Reeis, Bivolt, Batata e o carro a gás somem** enquanto a Campanha 2 está ativa (cenas 12 em diante), tanto os botões quanto as teclas R, B, T e V. Na campanha 1 nada muda.

**Os dois botões novos.** **PODER 1 (tecla U)** e **PODER 2 (tecla I)** usam o mesmo visual dos botões da campanha 1 (mesma moldura, ícone pixelado e nome dentro). Eles ficam onde estavam o Reeis e o Bivolt. Também aparecem no editor de posição dos controles ("Poder 1/2 (Campanha 2)") e nas configurações de teclas. Uma sombra mostra a recarga.

**Os 8 poderes.** Cada vilão derrotado entrega um poder. O Gugu do Ferro-Velho melhora cada um em até 3 níveis.

| Poder | Quem entrega | O que faz | Nível 1 → 3 |
| --- | --- | --- | --- |
| FOFOCA CONFUSA | Dona Creuza | Balões de fofoca ("PSIU", "JURA?"); quem estiver perto fica confuso e bate nos colegas | 4 → 6 s, raio 210 → 300 |
| BUZINA TURBO | Tonhão | Onda sonora em leque ("FOOOM!") que empurra e machuca | dano 6 → 12, empurrão maior |
| RAJADA DE BISCOITO | Seu Valdomiro | Leque de biscoitos de polvilho girando, que viram farelo ao acertar | 5 → 9 biscoitos |
| FLASH DO STORY | Kauã Influencer | Flash de celular que clareia a tela e atordoa com estrelinhas | 2 → 3 s |
| CAFEZÃO | Barão do Café | Xícara fumegando e aura de café: mais velocidade e mais força | 6 → 10 s, até +60% e +80% |
| SUPERSOCO | Breno Pitbull | Segure para carregar (barra e punho brilhando) e solte o "POW!" que arremessa | dano 20 → 36, carga mais rápida |
| CLONE DE LAN | Ryan e Bryan | Um Da Roça digital ciano, com linhas de tela, que segue e joga papel | 8 → 12 s |
| AURA DE AMIZADE | Fred | Escudo dourado com coraçõezinhos: nenhum golpe passa | 4 → 6 s |

**Onde troca.** No **MURAL DOS PODERES**, a cortiça com cartõezinhos na parede do quarto, em cima da cama. Chegando perto aparece **[E] MURAL DOS PODERES**.
- **Espaços equipados:** os dois espaços (PODER 1 e PODER 2) ficam no alto.
- **Sempre com você:** a faixa com os básicos, com os ícones tirados dos próprios botões da campanha 1.
- **Os oito cartões:** cada um tem o retrato do vilão que entrega o poder. Os bloqueados aparecem como silhueta, com "vença Fulano".
- **Detalhe do poder:** mostra o nível atual, o próximo (com o Gugu) e a recarga.
- **Como equipar:** com o mouse, o toque ou o teclado (setas, 1 e 2).

O estado fica em `daroca-c2-poderes` até o save da Campanha 2 existir (passo 6).

**Treino (no visualizador).** O botão **TREINO (P)** coloca três espantalhos de treino com barra de vida e mostra a barra de controles da Campanha 2. São os botões da campanha 1, com estilo e ícones copiados do jogo. Com eles dá para testar o peido, o papel, o dash, o voo (segurar o pulo no ar, com barra de gás) e os dois poderes equipados. O botão **MURAL** e o mural do quarto têm, só no visualizador, **TESTE: LIBERAR TODOS** e **TESTE: UPGRADE DO GUGU**.

**Para o passo 6.** O motor dos poderes não depende do jogo: recebe um "mundo" com o herói, os inimigos e funções de dano, empurrão, atordoar e confundir. Falta ligar `CampanhaPoderes.acionarNoJogo` às lutas da campanha: inimigos de verdade, o soltar do supersoco e a aura bloqueando o dano no `hurt()`.

## Passo 4 · Mapas, táxi e loja de garrafadas (`dist/mapa3d.js`, `dist/mapas.js` e `dist/campanha2/loja.js`)

**Mapa em pixel art com cara de 3D.** `mapa3d.js` desenha um mapa visto de cima e um pouco de frente, como nos RPGs de pixel. Usa blocos de 16 px, com:
- relevo em níveis: barrancos de terra de dois blocos de altura com sombra;
- rios com espuma e pontes;
- ruas de paralelepípedo e asfalto, trilhas de terra e grama com tufos e flores;
- casas com telhado e fachada, prédios, árvores redondas, cercas, postes, bancos e fontes.

Os objetos são ordenados pela altura (quem está mais embaixo fica na frente).

**Terreno orgânico.** O relevo e o tipo do chão ficam numa grade fina (4 px). Cada pixel é pintado consultando essa grade num ponto deslocado por um ruído suave, por isso rios, barrancos, gramados e ruas têm bordas curvas, sem cara de quadradinho.
- **Ruas:** são curvas suaves (`T.curva`), e os cruzamentos viram pracinhas redondas.
- **Barrancos:** têm faixas de terra, pedrinhas, cipós e sombra no pé.
- **Água:** tem fundo mais escuro, parte rasa, espuma, juncos e vitórias-régias.
- **Chão:** grama com tufos e flores, cerrado, trigal, cafezal em fileiras curvas, paralelepípedo, calçada e nuvens.
- **Árvores:** novas árvores de copa fofa (vários tufos), além de eucalipto, cacaueiro, mamoeiro e pinheiro.
- **Carros:** andam pelas curvas nos dois sentidos.
- **Casas e prédios:** só nascem em terreno livre.

**Áreas trancadas.** O lugar que ainda não foi liberado fica mais escuro, com o chão em volta apagado, e ganha um cadeado vermelho pulsando em cima. Ao tocar nele, o cadeado treme e abre um balão dizendo quem é preciso derrotar. O painel também mostra o cadeado e o botão **🔒 TRANCADO**.
- **Campanha 1:** usa as regras do jogo (`Campaign.canTravel`):
  - Caderno do Caos: derrotar o Marco;
  - Academia: derrotar o Menezes;
  - Quadra: derrotar o monstro do Caderno do Caos e o Menezes, e fazer o treino do Caleb;
  - Favela: o desafio do Mota, a missão do Almiro e o English do Miqueias;
  - antes de consertar o carro com o Lucas, tudo fica trancado.
  Fora do carro, os lugares liberados não escurecem, só pedem para entrar no carro.
- **Campanha 2:** cada área abre depois de vencer o vilão anterior:
  - livres desde o começo: aeroporto, pensão e centro;
  - depois da Dona Creuza: Monumento, rodoviária e lagoa;
  - depois do Tonhão: feira, Poço Escuro e parque;
  - depois do Seu Valdomiro: Cristo e Lomantão;
  - depois do Kauã: café e UESB;
  - depois do Barão: teatro e Marçal;
  - depois do Breno: shopping;
  - depois de Ryan e Bryan: Escola SESI.

  Os vencidos ficam em `daroca-c2-vencidos` até o save da Campanha 2 (passo 6). API: `CampanhaTaxi.vencer('creuza')`, `vencidos()` e `zerarVencidos()`. No visualizador, o botão **TESTE: VENCER …** no alto do mapa vence o próximo vilão.

**Referências da campanha no mapa de Itabuna:**
- na roça: a oficina do Lucas com as três peças do carro brilhando na bancada, a árvore do balanço, o espantalho no trigal, as galinhas soltas, o caixote do Kauã com lápis, borracha e clipe, e a barcaça de cacau no morro;
- no Campo do Mota: o Mota treinando com bola e cones;
- no colégio: os mamoeiros das papaias do Miqueias, os três cadernos do Almiro no banco e o saruê espiando da moita;
- no Caderno do Caos: folhas voando até ele e rabiscos andando em volta;
- na quadra: o bolo na mesa;
- na Praça Camacan: dominó dos aposentados, sorvete e pombos;
- na Academia do Caleb: o sinal de reflexo verde e vermelho e alguém fazendo flexão;
- no Bigodon: o poste de barbeiro girando e o bigodão no telhado;
- na Casa de Rayssa: as latinhas Bivolt soltando faísca;
- no baile: o som do paredão e um carro roxo voando no céu;
- na favela: a pichação "OOO REEEIS", a barraca da BATATA, pipas e varais;
- pela cidade: a lanchonete com fliperama na porta, a canoa com pescador, os patos no açude e a placa ITABUNA.

**Referências da campanha no mapa de Conquista:**
- o Ferro-Velho do Gugu, com guindaste e carcaças;
- a janela da Dona Creuza soltando "PSIU" e "JURA?";
- a Dona Lurdes regando as plantas e o varal na laje da pensão;
- o ponto de mototáxi do Tonhão, com motos rodando a rotatória;
- o engarrafamento buzinando na avenida, de Cleiton e Dona Rosilda;
- a biscoitaria do Seu Valdomiro soltando vapor e o carrinho das garrafadas do Seu Lindomar;
- o ring light do Kauã Influencer piscando o flash;
- a LAN house em neon dos gêmeos;
- o saco de pancada e o cachorro do Breno;
- as sacas e a xícara do Barão do Café, com o café secando no terreiro;
- o relógio-termômetro marcando 12 °C e a neblina passando;
- a roda-gigante do festival, o avião decolando, os ônibus da rodoviária e as antenas da serra piscando;
- cactos cabeça-de-frade, saguis, garças, o menino da bateia, a criança no balanço, o cachorro com a bolinha, os outdoors (SMART FAT, PAGUE MAIS, CASAS BAIXA) e as plaquinhas de TÁXI em cada ponto do Seu Zé.

Ao tocar num lugar:
- a câmera desliza e dá zoom até ele;
- o desenho do lugar dá um pulinho;
- o painel abre com a **prévia ao vivo** do cenário e o botão **IR PARA LÁ**.

O botão **ⓘ** mostra uma descrição com suspense, sem spoiler.

Ao confirmar, o veículo faz o caminho até lá. O carro a gás vai **voando**, em arco; o táxi vai **pelas ruas**, em L. Depois a tela escurece e o jogo leva o jogador ao lugar.

Controles do mapa:
- arrastar passeia pelo mapa;
- `+`/`−` dão zoom;
- setas trocam o lugar;
- Enter vai;
- `I` abre a descrição;
- Esc volta e fecha.

O formato do mapa (`chave`, `terreno`, `objetos`, `locais` com `caixa`, `desenho`, `descricao`...) está no começo de `mapa3d.js`.

**Campanha 1 · Itabuna (carro a gás).** `MapasJogo.abrirCampanha1` substitui a lista antiga de rotas em `ui.js`. A lista continua como reserva se o mapa não carregar. O mapa tem os 12 lugares da campanha 1, cada um desenhado à mão, com o rio, as pontes e a favela no morro. Também tem animações: moinho, fumaça, chafariz, carros, pessoas, luzes do baile, pipa e passarinhos.

Os bloqueios são as mesmas regras do jogo (`Campaign.canTravel`), com o motivo aparecendo no painel. Fora do carro, todos os lugares mostram "Entre no carro a gás (tecla V ou botão CARRO)". A viagem chama `Game.travel`, então a chegada, o save e as cutscenes não mudaram.

**Campanha 2 · Conquista (táxi do Seu Zé).** Na Campanha 2 não tem carro a gás: o jogador anda, e o táxi só existe no **começo e no fim de cada parte**, sempre do lado de fora. Por exemplo, o táxi para na **entrada da Escola SESI**, nunca dentro dela. São 17 pontos (`CampanhaTaxi.pontos`), cada um com a cena e a posição de chegada, e o mapa mostra só esses pontos. O táxi amarelo, com placa no teto e o Seu Zé no volante, aparece no cenário. Chegando perto, surge **CHAMAR O TÁXI DO SEU ZÉ**.

**Loja de garrafadas · Seu Lindomar.** A loja é um vendedor original, um raizeiro com carrinho de madeira na Feira do Planalto (cena 17). A tela é ilustrada e animada:
- o vendedor pisca, aponta, ri e balança a cabeça;
- tem prateleiras, lamparina balançando e poeira no ar;
- cada poção (um poder) tem um frasco diferente.

O cartão de pergaminho mostra o poder e o preço, com **COMPRAR** e **MONTAR BUILD** (abre o mural para equipar). As moedas aparecem no alto e voam ao comprar.

| Garrafada | Preço |
| --- | --- |
| Fofoca Confusa | 30 |
| Buzina Turbo | 40 |
| Rajada de Biscoito | 45 |
| Flash do Story | 60 |
| Cafezão | 70 |
| Supersoco | 85 |
| Clone de LAN | 110 |
| Aura de Amizade | 150 |

As moedas vêm de **inimigos derrotados** (hoje, os espantalhos do treino dão 8 cada). Elas ficam em `daroca-c2-loja` até o save da Campanha 2 (passo 6). API: `CampanhaLoja.abrir`, `moedas`, `ganhar`, `precos`.

**Ainda falta (passo 6).**
- Inimigos reais soltando moedas.
- Decidir se cada garrafada só aparece na loja depois de vencer o vilão dela (como no plano original) ou se fica toda à venda.
- Ligar o táxi à progressão: depois de embarcar não dá para voltar.


**Garrafada só depois do vilão.** Cada garrafada só chega na banca depois que o vilão dela é vencido, porque o ingrediente está com ele. Antes disso:
- o frasco aparece escuro, com um cadeado vermelho e preço "???";
- o Seu Lindomar diz com quem está o ingrediente;
- o botão mostra **🔒 TRANCADA**.

A Feira, onde fica a banca, abre junto com o Monumento, depois da Dona Creuza.

## Passo 5 · Cutscenes (`dist/campanha2/cutscenes.js` e `dist/roteiros/c2_*.json`)

As cutscenes usam o mesmo motor de roteiros da campanha 1 (`roteiro.js`): mesmos botões, mesma câmera e mesmos personagens. O motor ganhou extensões genéricas, que a campanha 1 não usa:
- fases 12+;
- fundos pintados;
- efeitos, animações e sons extras;
- ganchos por quadro;
- **balões de fala**.

**Balão de fala** (`"balao": true` no roteiro):
- o balão é desenhado em cima de quem fala, com rabinho apontando para a boca e etiqueta colorida com o nome;
- frases gritadas viram balão vermelho com pontas e tremor;
- frases entre parênteses viram balão de pensamento (nuvenzinha);
- "..." ganha borda tracejada;
- o narrador aparece em legenda de quadrinho no canto;
- quem fala fora da tela (no celular) ganha balão embaixo, com retratinho.

No jogo, a caixa de fala antiga fica escondida nesses roteiros, mas o texto continua nela para leitores de tela.

**Trilha original sintetizada** (sem arquivos e sem copiar música): `saudade`, `flashback`, `tensao`, `vilao`, `conquista` e `final`. O roteiro escolhe com `"trilha"` (no roteiro ou na cena; `null` para). Se o jogador escolheu uma música própria para a cena no painel, a dele toca no lugar.

**Músicas gravadas por lugar:** fora das cutscenes, a Campanha 2 toca a música que estiver nas pastas `dist/musicas/c2-cenario-<chave>` (contexto `c2.maps.<chave>`) e `dist/musicas/c2-luta-<chefe>` (contexto `c2.battles.<chefe>`, enquanto a arena está ativa). As pastas `c2-todos-os-cenarios` e `c2-todas-as-lutas` valem para os lugares sem música própria. Sem nenhuma música nas pastas, tudo fica como antes. Guia: `docs/MUSICAS.md`.

**Fundos pintados (closes):**

| Fundo | O que mostra |
| --- | --- |
| `celular` | Chamando, ligando, recusada, perdida ou videochamada, com a mão segurando e o polegar recusando a ligação |
| `aviao_janela` | Decolagem, voo e pouso na neblina, com Da Roça na poltrona e o cafezinho tremendo |
| `aviao_ceu` | O avião cruzando o céu |
| `sala_aula` | Sala de aula do flashback |
| `rodoviaria` | O ônibus levando o Jorge, com ele acenando na janela |
| `ceu_noite` | O céu da roça |
| `quarto_jorge` | O quarto em Conquista, com a foto do trio escondida no espelho |

**Efeitos novos:** `titulo_c2`, `coracao_partido`, `batimento`, `polaroids`, `foto_trio`, `pensamento`, `neblina`, `frio`, `estrelas`, `pb`, `flashback`, `vs`, `poder`, `fim`, `luz_final`, `barras`, `flash_memoria` e `chat`.

**Animações por cima dos atores** (junte com `+`): `chorando`, `frio`, `treme`, `ajoelhado`, `deitado`, `celular`, `celular_mao`, `zzz`, `exclama`, `pergunta`, `raiva`, `suor`, `coracao`, `coracao_partido`, `brilho`, `chama`, `mao`, `agarra_pernas` (desenho próprio do Da Roça de bruços: cabeça erguida chorando e gritando, chapéu torto, mochila nas costas, pernas batendo e as mãos fechadas nos tornozelos de quem está na frente; o ator fica no x das mãos), `sacudindo` (balança e chuta tentando se soltar), `silhueta` e `fantasma`.

**Sons novos:** `vibrar`, `toque`, `coracao`, `quebra`, `aviao`, `vento`, `desliga`, `vs`, `poder`, `abraco`, `digitar` e `soluco`.

**As 24 cutscenes:**

| Roteiro | O que acontece |
| --- | --- |
| `c2_abertura` | Abertura com o trio. Pequenos, correm pelo corredor, fazem bagunça na sala e ficam de castigo juntos. Maiores, aparecem na casa de Rayssa e na foto do trio. Depois vêm a mudança na rodoviária, a volta em janeiro e julho, quando Jorge passa reto na chuva e o coração parte. A montagem de polaroides mostra a vida nova. Na noite na roça, Da Roça pensa no trio e o celular vibra com JORGE (recriando o final da campanha 1). Ele cai de joelhos, liga de volta e Jorge recusa: "Foi sem querer... nem sei mais quem é esse cara". A câmera vai até a foto do trio no espelho dele. Termina com a decisão e o título |
| `c2_aeroporto` | Miguel aparece no aeroporto de Itabuna, dá a aula de viagem e o portão vira ponto sem volta ("Leva meu casaco." "Casaco? Na Bahia?") |
| `c2_voo` | Decolagem, voo, "onze graus?!" e o pouso na neblina da Suíça Baiana |
| `c2_chegada` | O frio no Glauber Rocha e o Seu Zé do Táxi, que não para de falar |
| `c2_primeira_noite` | Dona Lurdes e a primeira noite no quarto 4. De manhã, OOO REEEIS... e nada: os poderes ficaram em Itabuna. Termina com o mural de procurados |
| `c2_vilao_*` | Entrada de cada vilão no cenário dele, terminando no cartão **VS** com nome e apelido |
| `c2_derrota_*` | O vilão vencido dá uma pista do Jorge e a garrafada é liberada (cartão **NOVO PODER!** com o ícone) |
| `c2_vilao_fred` | Fred e Jorge com o toque secreto e o chat "FRED & JORGE". Jorge vai embora sem responder e Fred diz "O que eu sou com o Jorge, você nunca vai ser". O coração parte |
| `c2_centro` | A praça da Catedral à noite. Da Roça se joga no chão e agarra Jorge pelas pernas. Jorge sacode, chuta o ar e tenta se soltar, enquanto Da Roça é arrastado junto sem largar. Jorge grita "EU NÃO CONHEÇO ESSE CARA!", a cor some e começa a batalha final |
| `c2_final` | Da Roça prepara o golpe e para. Estende a mão, Jorge confessa a vergonha e vem o abraço, com flashes do trio. Fred faz as pazes, Reeis aparece em videochamada, as fotos do trio (pequenos, maiores e agora) e o **FIM** |
| `c2_creditos` | Créditos com todo o elenco |

Nenhuma delas toca sozinha ainda: o passo 6 liga cada uma ao seu momento no jogo. Durante essas cutscenes, o engarrafamento aleatório fica desligado.

**Para assistir:** abra `?cenarios2` e clique em **CUTSCENES**. A galeria toca qualquer uma com trilha e sons, mesmo com o som do jogo desligado. Também dá para abrir direto com `?roteiro=c2_abertura`.

**Conserto:** o engarrafamento aleatório (passo 2B) tinha um erro que deixava o cenário preto no centro e na avenida quando a fila aparecia. Está corrigido.


## Passo 6A · O jogo da Campanha 2 e o prólogo jogável (`dist/campanha2/jogo.js`)

**Como entra.** Na tela inicial há o botão **❄ CAMPANHA 2 · CONQUISTA**. Ele é liberado quando a campanha principal foi zerada (a ligação do Jorge, `q.jorgeSeen`, a mesma regra do Sandbox dos chefes). Para testar sem zerar, abra o site com `?campanha2`. O painel tem **COMEÇAR** e **CONTINUAR** (quando há save).

**Motor.** É uma tela própria, por cima do jogo, que junta tudo dos passos 1 a 5:
- os cenários, as portas, a escada rolante e a escada da escola;
- os moradores, o táxi, a loja e o mural;
- os botões da campanha 1 sem Reeis, Bivolt e Batata, com voo, peido, papel, dash e os 2 poderes;
- o joystick no celular;
- as cutscenes com balão de fala tocando dentro do jogo.

Na tela ficam:
- o **objetivo** no alto, com uma seta até o lugar (ou na beirada da tela, se o lugar estiver fora);
- vida em corações, gás do voo e moedas;
- a **pausa** (☰ ou Esc), com som e **SALVAR E SAIR**;
- **PULAR CENA** nas cutscenes.

**Save.** O progresso fica em `daroca-c2-save`: a missão, a cena, a posição e a vida. O jogo salva a cada missão e a cada porta, e a cama do quarto 4 salva e cura. O save da campanha principal nunca é tocado.

**O prólogo (6A):**
1. A cutscene de abertura.
2. A roça de Itabuna (o mapa da campanha 1, reaproveitado), sem combate:
   - a despedida opcional de Reeis, Caleb, Mota e Kaua;
   - o passaporte em cima dos fardos de feno, alcançado pulando de fardo em fardo.
3. O Lucas na trilha dá carona no carro a gás até o aeroporto.
4. O minijogo do Miguel. Check-in e raio-X com escolhas: as erradas rendem piada e a certa avança.
5. O portão com a despedida e o aviso **"Depois de embarcar, você não poderá voltar para Itabuna. Continuar?"**. Depois de embarcar, Itabuna fica fechada (`flags.embarcou`).
6. As cutscenes do voo e da chegada.
7. O táxi do Seu Zé até a pensão (a única corrida liberada nessa hora).
8. A Dona Lurdes e a primeira noite.
9. A manhã no quarto 4, onde o jogo salva.

O próximo objetivo (o bairro e a Dona Creuza) chega no 6B.


## Passo 6B · As fases dos vilões 1 a 4 (`dist/campanha2/fases.js`)

Mesmo sistema de fases da campanha 1:
- **Caminho com inimigos:** cada inimigo derrotado dá 6 moedas e às vezes solta um biscoito.
- **Biscoitos de polvilho:** curam 20 de vida.
- **Ponto de controle:** fica antes do chefe.
- **Arena:** chegando perto do chefe, a cutscene de entrada toca no próprio lugar da luta, deslocada para onde ele está. As barreiras de obra fecham a arena e a placa mostra o nome e o nível.
- **Chefe com 3 fases:**
  - na troca de fase a vida renova e ele fica mais forte e mais rápido;
  - pontos antecipam a trajetória dos objetos e cantos marcam a área atingida. A mira fica onde o chefe a colocou, dando tempo para sair dela.
  - depois de atacar ele fica **ABERTO!** e toma dano cheio; fora disso, defende parte do dano;
  - a barra no alto tem o nome, o nível e as 3 marcas de fase.
- **Vitória:** placa **DERROTADO!**, 60 moedas, a cutscene da derrota (pista do Jorge e NOVO PODER) e a garrafada liberada na loja.
- **Desmaio:** se a vida acaba, você volta no ponto de controle com a vida cheia. O chefe recomeça, mas os inimigos vencidos continuam vencidos.

Também valem os golpes do jogador: papel, peido, dash e os 2 poderes. A Fofoca faz os inimigos brigarem entre si, inclusive contra o chefe, e a Aura bloqueia o dano.

| Fase | Onde | Inimigos | Chefe e golpes |
| --- | --- | --- | --- |
| Dona Creuza (nv 3) | Bairro da pensão | Vizinhas fofoqueiras (jogam balões de fofoca), pombos que mergulham | Abre janelas de fofoca em sequência e encaminha áudios que atravessam o bairro e voltam |
| Tonhão (nv 5) | Avenida, depois da rotatória | Mototaxistas que aceleram em cima de você, pombos | Bandeirada de moto, recibos ondulantes, retorno pela mesma faixa e cones na contramão |
| Seu Valdomiro (nv 7) | Feira do Planalto | Feirantes que jogam frutas, pombos | Biscoitos de goma que quicam, saco que espalha polvilho e pratos de balança que descem alternados |
| Kauã (nv 9) | Serra do Periperi, no Cristo | Seguidores com flash de celular (deixam lento), urubus | O visor delimita o corte da live. Curtidas caem em arco e o replay captura a mesma posição duas vezes |

**Missões do 6B:**
1. Do quarto até a Dona Creuza.
2. Táxi até o Monumento e o Tonhão.
3. Táxi até a Feira e o Seu Valdomiro.
4. Táxi até a Trilha do Cristo e o Kauã.
5. Descansar na pensão.

Os nove chefes de Vitória da Conquista têm sete tipos de ataque cada. Os oito primeiros apresentam três na primeira barra e abrem novos padrões nas seguintes. Dona Creuza joga a edição extra do jornal e os pregadores do varal. Tonhão deixa óleo na pista e perde o pneu. Valdomiro abre a massa com o rolo e deixa escapar vapor do tabuleiro. Kauã faz uma enquete e corta o enquadramento com a tesoura. O Barão gira a moenda e varre o terreiro. Breno solta o lustre que atravessa o palco como um pêndulo. Ryan e Bryan travam o caminho com a tecla ESC e trazem invasores de oito bits. Fred arremessa o convite, a pulseira e os broches do clube.

Depois de cada vitória, a garrafada do poder aparece na banca do Seu Lindomar, na Feira.


## Passo 6C · As fases dos vilões 5 a 8

Mesmo sistema do 6B, com inimigos novos e golpes novos.

| Fase | Onde | Inimigos | O que tem de novo no chefe |
| --- | --- | --- | --- |
| Barão do Café (nv 11) | Fazendas de café, pulando os canais de irrigação | Capangas do Barão (corpo a corpo), maritacas | O grão cai onde vai nascer o cafeeiro. Na florada, os pés brotam em sequência, e o bule solta vapor rente ao chão |
| Breno Pitbull (nv 12) | Festival de Inverno, à noite, depois do Planetário | Valentões, morcegos | Refletores marcam o palco, contrapesos caem e uma tábua corre pelo piso. A abertura entre as cortinas antecipa a investida |
| Ryan e Bryan (nv 13) | LAN house do shopping (entrando pela frente do shopping) | Gamers que jogam controles, drones | Os gêmeos dividem a vida. Ryan manda comandos baixos, Bryan rebate por cima e os cabos dos dois controles se cruzam |
| Fred (nv 15, o mais difícil) | Pátio do 2º andar da Escola SESI | A turma do Fred (alunos e alunas que jogam pão de queijo) | O pente volta como bumerangue, o pão de queijo quica e a sequência de palmas imita o toque secreto dele com Jorge |

**Missões do 6C:**
1. Táxi até o café e o Barão.
2. Táxi até o Teatro e o Breno.
3. Táxi até a frente do shopping, entrar e achar os gêmeos na LAN.
4. Sair do shopping, táxi até a escola, entrar, subir a escada até o pátio e o Fred.

A seta do objetivo também mostra o caminho pelas portas, como a entrada do shopping e a escada da escola. Depois do Fred, a garrafada da Aura de Amizade fica liberada e o objetivo aponta para a praça da Catedral à noite (o 6D).


## Passo 6D · A batalha final, o final feliz e os créditos

**O caminho:**
1. Depois do Fred, descer a escada da escola, sair e pegar o táxi até o Centro.
2. À noite, andar até a praça da Catedral, passando pela turma nova do Jorge.
3. Chegando perto, a cutscene do centro toca no próprio lugar da luta: o Jorge finge não conhecer o Da Roça, o Da Roça agarra as pernas dele e começa a batalha final.

**Jorge (nv 20)** tem cinco barras de vida. Entre elas, os ataques em curso desaparecem e o jogador tem tempo de se reposicionar. No Normal, as barras têm 2.240, 2.720, 3.200, 3.720 e 4.120 PV.

| Fase | Nome | Como ler o ataque |
| --- | --- | --- |
| 1 | Bilhete sem resposta | Jorge chega como na praça. O bilhete atravessa a arena em onda. Quando rasga a foto do trio, as metades caem para lados opostos. |
| 2 | O peso da lembrança | Jorge cresce e veste o moletom de pizza do trio. Ele encolhe as pernas antes de saltar com a barriga e emenda um segundo quique, mais curto. Os dois pousos aparecem no chão. |
| 3 | Palavras que partem | De jaqueta vinho, ele lança farpas como “Nem senti falta.” e “Você ficou pra trás.”. O balão inteiro causa dano. Salte sobre a frase ou passe por baixo. |
| 4 | O céu se abre | Uma aura azul e violeta leva Jorge até as nuvens. Seis vitrais da Catedral sobem e descem. Depois do primeiro rasante, três recebem rachaduras e setas e caem. Os outros três continuam sólidos. Os pedaços voltam após 2,45 segundos. |
| 5 | Atende, sou eu | A luta volta à praça. Jorge veste uma jaqueta clara e segura o celular junto ao ouvido. As duas metades da foto se encontram no centro, o sinal toca e ele lança a passagem para Itabuna. |

**O final.** Quando o Jorge cai na quinta fase, a história continua.
- a cutscene do final feliz: a mão estendida, a confissão, o abraço, a videochamada com o Reeis e o FIM;
- os créditos;
- a tela **CAMPANHA 2 COMPLETA!**, com CONTINUAR EXPLORANDO ou VOLTAR AO MENU.

O save marca a campanha como zerada (`flags.zerou`) e o painel da Campanha 2 passa a mostrar "✔ Campanha 2 completa".


## Extras · Missões dos aliados e a Oficina de melhorias (`dist/campanha2/aliados.js` e `dist/campanha2/oficina.js`)

**Os aliados** ficam espalhados pela cidade. Um "!" em cima indica missão nova, um "?" indica que dá para entregar e um "●" indica loja ou oficina. As missões aparecem em **📜 MISSÕES**, na pausa.

| Aliado | Onde | Missão | Recompensa |
| --- | --- | --- | --- |
| Dona Lurdes | Porta da pensão | Achar o radinho roubado (na avenida do Monumento) | +20 de vida máxima (um coração a mais) |
| Mel | Centro | Juntar os 3 pedaços do mapa do avô (fim do centro, fim da feira, beira da lagoa) | 40 moedas e o mapa verdadeiro: marcas verdes mostram as missões extras |
| Biscoito (cachorro caramelo) | Rua da pensão | Dar um biscoito de polvilho (comprado com o Tio do Picolé) | Vira companheiro e morde os inimigos nas lutas |
| Tio do Picolé | Feira | Lojinha | Picolé Sigma (cura 40), Picolé Mega Chad (vida cheia), biscoito do cachorro |
| Nando Skatista | Centro | Corrida até a bandeira e de volta antes dele | Skate: anda 20% mais rápido |
| Juninho Mecânico | Avenida | Trazer a corrente (com o Gugu) e o pneu (na rodoviária) | Bicicleta: anda 40% mais rápido |
| Bia do Arrocha | Teatro | Minijogo de ritmo no palco (← ↓ ↑ → ou D F J K, ou tocar nas trilhas) com 65% ou mais | Moral: +15% de força |
| Gugu do Ferro-Velho | Fim da rua da pensão (ferro-velho) | **Oficina de melhorias** | Turbina os poderes até o nível 3 |
| Vó Cida, Larissa (UESB) e Carlinhos (shopping) | — | As 3 pistas do Jorge | 90 moedas |

**A Oficina de melhorias do Gugu** é uma tela própria em pixel art realista:
- um galpão de zinco enferrujado, com uma lâmpada pendurada que balança e mexe a luz e as sombras;
- um quadro de ferramentas, prateleiras com potes e latas, pneus, um capô velho e poeira no ar;
- a MÁQUINA DE TURBINAR, com manômetro, canos e vapor.

Você escolhe um poder e vê o nível de agora e o próximo. O Gugu põe a garrafada na máquina, martela e solda (com faíscas e clarão), o manômetro sobe, a garrafa sai brilhando e o carimbo **TURBINADO!** marca o nível novo. O nível 2 custa 80 moedas e o nível 3 custa 160.


## Modo desenvolvedor (`dist/dev-mode.js` e `dist/campanha2/dev.js`)

O modo fica desligado no site e nos apps normais. Há duas formas de ligar:
- **IPA de desenvolvedor:** no GitHub, abra Actions › "Gerar IPA" › Run workflow e marque **dev**. A Release sai como "DESENVOLVEDOR" (`ios-dev-bN`), com o arquivo `DaRoca-DEV-...ipa`.
- **No navegador:** abra o jogo com `?dev` no fim do endereço.

Com ele ligado:
- **🎬 CUTSCENES · DEV** na tela inicial: todas as cutscenes. São 56: as 24 da Campanha 2, os roteiros da campanha 1 e as cenas do motor do jogo.
- **Terreiro dos Chefes (sandbox)** liberado.
- **Campanha 2** liberada, com **🛠 ESCOLHER CAPÍTULO**: do prólogo ao pós-final, já com os vilões anteriores vencidos, os poderes deles liberados e 600 moedas.
- **⚡ LIBERAR TUDO:** os 8 poderes no nível 3, 999 moedas e os extras.
- Uma etiqueta amarela "MODO DESENVOLVEDOR" no canto da tela.


## Lutas, menu de pausa e botões (`botoes.js`, `roca-ui.css`)

**Golpes:** quando apanha, o inimigo (ou o chefe, ou o espantalho do treino) **só pisca** e mostra o número do dano. Não há onomatopeias nem outros efeitos extras: o dono pediu assim. O piscar fica em `treino.js` (`CampanhaTreino.piscando`).

**Quando a Campanha 2 abre:** só depois de terminar a Campanha 1. No modo desenvolvedor ela fica sempre aberta.

**Menu de pausa da Campanha 2 no estilo roça:** placa pendurada por cordas e botões de madeira nas cores antigas.
- Botões: CONTINUAR, ⚙ OPÇÕES, MISSÕES, SOM e SALVAR E SAIR.
- Nas OPÇÕES: hora do dia (no automático segue a história), clima, qualidade e MUDAR BOTÕES DE LUGAR.

**Pausa da campanha principal = mesma pausa da Campanha 2:** placa pendurada e botões de madeira com moldura dourada em uma coluna.
- Botões: ▶ CONTINUAR, ⚙ OPÇÕES, Terreiro, Diário, Rever história, Arena, Dupla local, Fliperama e Menu principal.
- Nas OPÇÕES: hora do dia, clima, qualidade, som, controles e teclas, mudar botões de lugar e dificuldade.
- **Os botões de toque e o joystick da principal continuam os originais.**

**Ao sair da Campanha 2**, os botões de toque da campanha principal voltam iguais: Reeis, Bivolt e Carro voltam, e os poderes da Campanha 2 somem. Enquanto a Campanha 2 está aberta, a campanha principal e a animação do título param de desenhar por trás, o que deixa o jogo bem mais leve.

**Mapa no celular** (`mapa3d.js`)
- Abre mostrando a cidade e dá para afastar até ver o mapa inteiro.
- Zoom com pinça (dois dedos).
- Título compacto.
- Faixa embaixo com todos os lugares (🔒 trancado, ● você está aqui).
- Com o celular deitado, a ficha do lugar abre ao lado.
- No computador, nada muda.

**Mudar botões de lugar na Campanha 2** (`campanha2/botoes.js`)
- Arraste o joystick e cada botão; ajuste o TAMANHO.
- RESTAURAR volta ao padrão.
- Fica salvo no aparelho (`daroca-c2-layout-v1`), fora dos saves.


## Menu principal (`dist/menu-inicio.js` e `menu-inicio.css`)

A tela inicial tem só três botões: **JOGAR**, **MULTIPLAYER** e **DIÁRIO E TURMA**.
- **JOGAR:**
  - Campanha 1 · Itabuna, com CONTINUAR (se houver save) e NOVA AVENTURA;
  - Campanha 2 · Vitória da Conquista, com 🔒 até terminar a 1;
  - **＋ MAIS MODOS:** Dupla online, Terreiro dos Chefes, Fliperama e, no modo dev, 🎬 Cutscenes.
- **MULTIPLAYER:** Arena online e Modo TV.

Os botões são os originais de cada modo, só mudados de lugar. Qualquer botão novo que outro arquivo puser na tela inicial vai sozinho para o "+".

**A Festa da Roça 3D (party) foi removida do jogo**, junto com o three.js que só ela usava. O jogo abre mais leve.

**Joystick da Campanha 2:** é o mesmo da campanha principal (madeira com botão verde). O estilo é copiado de lá quando o jogo abre.


## Abertura e logo (`dist/abertura.js`, `abertura.css` e `tools/logo.py`)

**Abertura**
- Sequência: tela preta com estrelinhas, logo que pula com brilho atrás, **DA ROÇA ADVENTURE** letra por letra, subtítulo, barra de carregamento em blocos com dicas, **PRONTO!** e então o menu.
- As animações são de CSS, por isso continuam rodando enquanto o jogo carrega.
- A abertura só sai depois que o jogo terminou de carregar e passaram ~4 s. Tocar na tela pula assim que estiver pronto.
- Em testes automáticos ela não aparece. Use `?abertura` para ver.
- No iPhone, a tela de lançamento do app ficou preta (`LaunchPreto`) para emendar com a abertura.

**Logo nova**
- Bolo de sapo em pixel art 64×64: sapo de chapéu de palha em cima do bolo de dois andares, vela acesa e pôr do sol.
- Gerada por `python3 tools/logo.py`.
- Vira `assets/app-icon-192/512/1024.png` e `icon.svg`. O IPA usa o de 1024 direto, sem borrar.


## Mapa de dia (`mapa3d.js`)
- Ao montar o mapa, as cores ganham "luz de dia": ficam mais claras, mais quentes e mais saturadas.
- As áreas trancadas têm sombra mais suave.
- O fundo em volta é azul-céu.
- Vida no mapa: bandos de passarinhos em V batendo as asas, borboletas e raios de sol se mexendo devagar.
- Grama, mata e plantação em **verde-limão claro** (pedido do dono). A mata fica um tom mais fundo, para ter contraste.

**Lugares do mapa com a cara de cada fase** (`mapas.js`, campo `desenho` de cada lugar). Cada lugar mostra o que tem no cenário da fase.
- **Campanha 1:**
  - Caderno do Caos: caderno roxo gigante, lápis e o rabisco-monstro;
  - Pátio: prédio com faixa azul, bandeirinhas e coqueiro;
  - Quadra: piso de tijolo com bandeirinhas;
  - Bigodon: barbearia com toldo, poste de barbeiro e placa de bigode;
  - Academia CALEB;
  - Casa da Rayssa: cortinas rosa;
  - Baile funk: palco, luzes e multidão;
  - Praça Camacan: coqueiros, placa e quiosque;
  - Colégio com placa.
- **Campanha 2:**
  - Monumento ao Índio: estátua de bronze com arco;
  - Teatro de tijolo com portas coloridas, mais o Centro de Cultura e o planetário;
  - Shopping: vidro, placa laranja e estacionamento;
  - SESI: muro grafitado e quadra;
  - Rodoviária: plataformas e ônibus;
  - UESB: ipês e ponto do circular;
  - Lagoa: pista vermelha com distâncias;
  - Parque: parquinho e grafite;
  - Placas da Fazenda, do Lomantão, do Mel da Serra e do Biscoito.
- **Lugares trancados:** um véu leve por cima. Continuam reconhecíveis, com o cadeado.

**Mapa de Itabuna é uma ilha** (`MAPA1`: `ilha: { margem: 300 }`, `relevo: true`; código em `mapa3d.js`: `fazerIlha` e `relevo`)
- **Costa:** em volta do mapa, a terra continua até uma costa irregular, com praia, coqueiros, pedras, guarda-sóis e um farol. O rio desemboca no mar.
- **Mar:** depois da costa vêm água rasa e mar. Dá para afastar a câmera até ver só água em volta.
- **Animações:** ondas brilhando, espuma batendo na praia, barquinhos à vela dando a volta na ilha, golfinhos pulando e a luz do farol piscando.
- **Relevo:** morros suaves na grama, com luz vindo de cima à esquerda.
- **Bigodon:** bigode gigante em cima da barbearia.
- **Academia do Caleb:** haltere gigante de "200KG" no telhado.

**Mapa de Vitória da Conquista também é ilha** (`MAPA2`: `ilha: { margem: 300, eolicas: 7, parapentes: 3, balao: true }`, `relevo: true`)
- Tudo o que o mapa de Itabuna tem: costa com praia, farol, mar animado, barcos, golfinhos e relevo.
- Detalhes de Conquista:
  - eólicas com as pás girando na costa;
  - parapentes planando em círculos;
  - um balão colorido atravessando a cidade;
  - o "mar de nuvens" da Serra do Marçal cai direto no mar.
