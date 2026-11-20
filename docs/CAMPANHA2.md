# Campanha 2 · Vitória da Conquista

Continuação canônica, um ano depois da campanha principal. A Campanha 2 fica em arquivos separados, dentro de `dist/campanha2/`, e não muda a campanha original.

A construção vai passo a passo. Cada passo só começa depois da aprovação do anterior.

| Passo | Conteúdo | Situação |
| --- | --- | --- |
| 1 | Personagens no mesmo traço | feito e aprovado |
| 2 | Cenários (2A a 2D): ambientes, camadas, 7 cenários novos, moradores | feito e aprovado |
| 3 | Poderes de Da Roça e mural para trocar | feito e aprovado |
| 4 | Locomoção: mapas, táxi do Seu Zé e loja de garrafadas | feito e aprovado |
| 5 | Cutscenes | **feito, aguardando aprovação** |
| 6 | O resto: menu "Campanha 2", missões, chefes, bloqueio depois do embarque, save e créditos no jogo | — |

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
