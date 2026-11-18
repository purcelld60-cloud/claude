# Campanha 2 · Vitória da Conquista

Continuação canônica, um ano depois da campanha principal. A Campanha 2 fica em arquivos separados, dentro de `dist/campanha2/`, e não muda a campanha original.

A construção vai passo a passo. Cada passo só começa depois da aprovação do anterior.

| Passo | Conteúdo | Situação |
| --- | --- | --- |
| 1 | Personagens no mesmo traço | **feito, aguardando aprovação** |
| 2 | Cenários: os 10 novos e o reuso do mapa de Itabuna | — |
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
| Trio | `jorge_gordo` | Jorge na época do trio, o "Gordo": cabelo cacheado em tigela com franjinha |
| Trio | `jorge` | Jorge hoje: mais magro, mesma tigela, de moletom e celular |
| Amigo | `miguel` | Miguel: forte (estilo Caleb), óculos azuis, cabelo curto e liso de lado, alça de mochila de viajante |
| Amigo do Jorge | `fred_conquista` | Fred de Conquista: mullet preto e liso. É um tipo separado do `freddy` da campanha 1 |
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
- **Ataques específicos dos chefes:** o mullet do Fred e os golpes do Jorge entram no passo dos poderes e dos chefes.
