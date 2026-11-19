# Campanha 2 · Vitória da Conquista

Continuação canônica, um ano depois da campanha principal. A Campanha 2 fica em arquivos separados, dentro de `dist/campanha2/`, e não muda a campanha original.

A construção vai passo a passo. Cada passo só começa depois da aprovação do anterior.

| Passo | Conteúdo | Situação |
| --- | --- | --- |
| 1 | Personagens no mesmo traço | feito e aprovado |
| 2 | Cenários: os 10 novos e o reuso do mapa de Itabuna | **feito, aguardando aprovação** |
| 3 | Poderes de Da Roça e sistema de escolher poder no quarto | — |
| 4 | Cutscenes | — |
| 5 | O resto: menu "Campanha 2", missões, chefes, bloqueio depois do embarque, save e créditos | — |

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
| 20 | Shopping | Dois andares de lojas, praça de alimentação, cinema com cartazes, lan house com telas piscando e escada rolante |
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
