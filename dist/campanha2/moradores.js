/* Campanha 2 · Passo 2D: 10 personagens novos com história e 20 moradores só para conversar.
   Cada um fica num cenário, parado no seu canto. Chegando perto aparece [E] CONVERSAR; a conversa abre uma caixa
   com retrato, nome e assuntos para escolher: quem é a pessoa, o que ela conta da cidade e a história dela.
   Quem você já conheceu fica anotado no caderninho (chave própria no navegador, separada do save do jogo).
   Os fatos da cidade são gerais e conhecidos; lenda vem com "dizem que". Ninguém aqui é sólido nem briga. */
(() => {
  'use strict';
  if (window.CampanhaMoradores || !window.CampanhaPersonagens?.registrar || !window.Art?.drawCharacter) return;
  const CP = window.CampanhaPersonagens;
  const KEY = 'daroca-c2-conhecidos', FLOOR = 440;
  const S = { claro: ['#efc6a9', '#c2977c'], trigo: ['#e3b48f', '#b58665'], moreno: ['#d9a57f', '#ac7856'], canela: ['#c48a60', '#956445'], jambo: ['#b67a52', '#875438'], cobre: ['#a96f48', '#7c4f33'], escuro: ['#8a5a3c', '#5f3d2a'], preto: ['#7c4f35', '#55362a'] };
  const pele = (k) => ({ skin: S[k][0], shade: S[k][1] });

  /* =====================================================================
     OS 10 PERSONAGENS NOVOS (têm história mais longa e voltam nas missões)
     ===================================================================== */
  const PERSONAGENS = [
    { id: 'c2n_lucia', nome: 'Professora Lúcia', papel: 'professora de História da UESB', cena: 31, x: 2560, spec: { ...pele('moreno'), build: 'normal', h: .93, top: '#5a6a8a', topKind: 'cardigan', inner: '#f2ecda', skirt: '#3a3f4a', hair: { style: 'bun', color: '#d8d4cc', gray: '#a8a49c' }, glasses: '#3a2a1a', scarf: '#c4743a', item: 'book', pose: 'read' },
      oi: 'Ah, um rosto novo no campus! Senta aí, meu filho. Professora de História não perde uma chance de contar história.',
      temas: [
        ['Quem é você?', ['Lúcia, professora de História aqui na UESB há mais de vinte anos. Já dei aula pra metade da cidade, incluindo uns três prefeitos e o rapaz da xerox.', 'Meu orgulho é o acervo de fotos antigas da cidade que eu junto. Toda semana aparece alguém com uma caixa de sapato cheia de retrato do avô.']],
        ['Me fala da cidade', ['Antes de tudo, esta terra era dos povos indígenas: os Mongoió, os Imboré, os Pataxó. O nome "Conquista" vem justamente da luta pela terra no século dezoito. É por isso que tem o Monumento ao Índio lá na avenida: pra ninguém esquecer.', 'Depois a cidade já se chamou Imperial Vila da Vitória, passou a ser só Conquista e o nome de hoje juntou os dois. Cresceu com a Rio-Bahia passando no meio, com o café do planalto e virou a terceira maior cidade da Bahia.', 'E não esquece: Glauber Rocha nasceu aqui. "Uma câmera na mão e uma ideia na cabeça." Elomar também é daqui, cantando o sertão. Cidade fria, mas de gente quente.']],
        ['E a sua história?', ['Eu vim da roça, igual a você. Estudei à luz de candeeiro e o primeiro livro que eu li inteiro foi um almanaque de farmácia.', 'Quando a universidade abriu as portas, fui da primeira turma da minha família a pisar numa sala de aula de faculdade. Hoje eu digo pros meus alunos: o planalto é alto, mas dá pra subir.']]
      ] },
    { id: 'c2n_bene', nome: 'Seu Bené Engraxate', papel: 'engraxate da rodoviária há 40 anos', cena: 30, x: 560, spec: { ...pele('preto'), build: 'slim', h: .92, hunch: true, top: '#e8e2d0', topKind: 'polo', sleeve: 'short', pattern: '#c8c2b0', pants: '#4a4a42', hat: { kind: 'cap', color: '#3a3a36' }, hair: { style: 'short', color: '#d0ccc4' }, mustache: '#e0dcd4', pose: 'offer' },
      oi: 'Graxa, meu jovem? Bota o pé aqui. Ô, mas é botina de roça! Essa aí já viu muita estrada, hein?',
      temas: [
        ['Quem é você?', ['Benedito, mas ninguém me chama assim nem em velório. Bené. Engraxo sapato nessa rodoviária há quarenta anos. Já engraxei sapato de deputado, de noivo atrasado e de cantor de arrocha.']],
        ['Me fala da cidade', ['Daqui eu vejo a cidade inteira chegar e partir. A Rio-Bahia passa aqui do lado: quem vai do Sul pro Nordeste passa por Conquista, querendo ou não.', 'Ônibus pra Salvador, pra Itabuna, pra Jequié, pra São Paulo... Todo mundo que chega desce com cara de frio. Aí eu já sei: é gente nova na Suíça Baiana.']],
        ['E a sua história?', ['Cheguei num ônibus de madrugada, com dezesseis anos, uma mala de papelão e uma lata de graxa que era do meu pai. Ia ficar uma semana. Tô aqui até hoje.', 'Criei três filhos com essa escova. Uma é enfermeira, o outro é motorista de ônibus e passa por mim buzinando. O caçula é engraxate também, mas de tênis. Chama de "customização".']]
      ] },
    { id: 'c2n_taina', nome: 'Tainá', papel: 'guia voluntária do Monumento ao Índio', cena: 16, x: 3260, spec: { ...pele('cobre'), build: 'slim', h: .94, top: '#c4743a', topKind: 'tee', sleeve: 'short', pants: '#2c3a4f', hair: { style: 'long', color: '#14100c' }, earrings: '#e8c24c', item: 'map', pose: 'offer' },
      oi: 'Oi! Quer saber do monumento? Eu sou guia aqui nos fins de semana. A visita é de graça, mas ouvir até o fim é obrigatório.',
      temas: [
        ['Quem é você?', ['Tainá, estudante de Antropologia na UESB. Minha família tem raiz indígena aqui da região. Minha avó contava as histórias e eu resolvi contar também, só que pra mais gente.']],
        ['Me fala da cidade', ['O monumento lembra os povos que viviam neste planalto antes da cidade existir, como os Mongoió e os Imboré. Eles conheciam cada nascente, cada serra e cada bicho daqui.', 'Muita palavra que a gente usa veio deles e nem percebe. Quando você atravessar a rotatória, olha pro arco e lembra: a história desta terra é bem mais antiga que o asfalto.']],
        ['E a sua história?', ['Na escola eu tinha vergonha de falar da minha família. Hoje eu tenho é orgulho, e um mapa cheio de lugares que a minha avó me ensinou.', 'Meu sonho é montar um museu vivo, com língua, comida e música. Se precisar de ajuda pra achar alguma coisa nesta cidade, pode me chamar. Eu sei onde fica tudo, até o que não tá no mapa.']]
      ] },
    { id: 'c2n_ze_pandeiro', nome: 'Mestre Zé Pandeiro', papel: 'sanfoneiro e cantador da feira', cena: 17, x: 1640, spec: { ...pele('escuro'), build: 'belly', top: '#f2efe6', topKind: 'tee', sleeve: 'short', print: '#c43c3a', pants: '#3a4a5a', hat: { kind: 'straw', color: '#d7b665' }, hair: { style: 'short', color: '#c8c4bc' }, mustache: '#e0dcd4', item: 'mic', pose: 'sing' },
      oi: 'Ôôô, chegou mais um pra roda! Vem cá, menino. Na minha feira ninguém compra calado: tem que sair cantando.',
      temas: [
        ['Quem é você?', ['Zé Pandeiro! O nome é pandeiro, mas eu toco sanfona, triângulo, zabumba e, quando a pressão sobe, colher de pau. Canto na feira toda semana desde que o biscoito custava um tostão.']],
        ['Me fala da cidade', ['Conquista no São João é outra coisa: fogueira na rua, forró pé de serra, quentão pra espantar o frio e licor de jenipapo, que é mais perigoso que cobra.', 'E no inverno tem o Festival de Inverno, com show grande. Mas o melhor palco ainda é este aqui, entre a banca de banana e a de biscoito.']],
        ['E a sua história?', ['Aprendi sanfona com meu pai num fole remendado com fita isolante. A primeira vez que toquei em público foi num casamento. O noivo fugiu, mas a festa foi boa.', 'Tô ensinando os meninos da feira a tocar, de graça. Música de raiz não pode morrer. Se você souber um forró da roça, vem cantar comigo. Se não souber, eu te ensino.']]
      ] },
    { id: 'c2n_fabi', nome: 'Doutora Fabi', papel: 'veterinária da feira de adoção do Parcão', cena: 33, x: 4280, spec: { ...pele('claro'), build: 'slim', h: .95, top: '#f6f6f2', topKind: 'coat', pants: '#3a5a8a', hair: { style: 'ponytail', color: '#6a3a1c' }, glasses: '#3a6aa8', item: 'phone', pose: 'hips' },
      oi: 'Cuidado onde pisa! Brincadeira, o parcão é limpinho. Veio adotar um amigo de quatro patas? Já viu o Tripé? Ele corre mais que muito atleta.',
      temas: [
        ['Quem é você?', ['Fabiana, veterinária. Todo sábado eu faço feira de adoção aqui no Parcão e vacino bicho de graça. Domingo eu durmo. Às vezes.']],
        ['Me fala da cidade', ['Conquista tem cachorro caramelo em todo canto: na praça, na rodoviária, até no campus da UESB, onde tem um que assiste aula de Filosofia.', 'No frio, os bichinhos de rua sofrem. A gente faz campanha de cobertor velho no inverno. Se você tiver um sobrando, a cachorrada agradece.']],
        ['E a sua história?', ['Quando eu era criança, achei um filhote na chuva e escondi no meu quarto por três semanas. Minha mãe só descobriu quando ele comeu o sofá.', 'Ali eu soube o que queria ser. Já ajudei a adotar mais de mil bichos. O Tripé, aquele de três patas, foi o primeiro que eu não consegui doar. Ele me adotou primeiro.']]
      ] },
    { id: 'c2n_gabi', nome: 'Gabi do Voo Livre', papel: 'piloto de parapente da Serra do Marçal', cena: 34, x: 2940, spec: { ...pele('jambo'), build: 'strong', h: .97, top: '#e8433a', topKind: 'puffer', pants: '#2a3038', hat: { kind: 'helmet', color: '#f2c94c', visor: '#2a3a46' }, pose: 'thumb', mood: 'happy' },
      oi: 'E aí, vai voar hoje? O vento tá perfeito! Brincadeira, primeiro tem curso. Mas olha essa vista e me diz se não dá vontade.',
      temas: [
        ['Quem é você?', ['Gabriela, mas na rampa todo mundo me chama de Gabi. Sou instrutora de parapente aqui na Serra do Marçal. Já voei mais de mil vezes e ainda grito em todas.']],
        ['Me fala da cidade', ['Daqui de cima a gente vê o planalto acabando e o vale começando lá embaixo. De manhã cedo as nuvens ficam abaixo da gente, tipo um mar branco. Parece que dá pra pisar.', 'A estrada desce a serra cheia de curvas. Lá embaixo é mais quente: você desce de casaco e chega de camiseta.']],
        ['E a sua história?', ['Eu era mototaxista e morria de medo de altura. Não subia nem em escada de dois degraus.', 'Um dia trouxe um passageiro até aqui pra ele voar. Ele voltou chorando de alegria e eu pensei: "eu quero isso". Subi a rampa tremendo e voei. Hoje o medo vai junto, mas quem pilota sou eu.']]
      ] },
    { id: 'c2n_zefa', nome: 'Dona Zefa do Café', papel: 'cafeicultora mais antiga do planalto', cena: 18, x: 1180, spec: { ...pele('cobre'), build: 'normal', h: .9, hunch: true, top: '#7a8a4a', topKind: 'apron', apron: '#e9dcc0', skirt: '#5a4a3a', hat: { kind: 'straw', color: '#d7b665' }, hair: { style: 'bun', color: '#c8c4bc' }, item: 'mug', pose: 'mug' },
      oi: 'Chega, meu filho. Toma um cafezinho que acabou de passar no coador de pano. Coador de pano, viu? Não aceito máquina na minha cozinha.',
      temas: [
        ['Quem é você?', ['Josefa, mas é Zefa desde o batizado. Planto café neste planalto há sessenta safras. Conheço cada pé pelo nome, e alguns pelo apelido.']],
        ['Me fala da cidade', ['O frio e a altura deixam o café daqui doce e encorpado. Tem gente de fora que vem só provar. O café de Conquista viaja o mundo e volta em pacote bonito, custando o triplo.', 'Na colheita, a fazenda inteira vira festa: pano no chão, peneira, rodo no terreiro, e a molecada correndo atrás das galinhas.']],
        ['E a sua história?', ['Teve um ano em que deu geada e queimou quase tudo. Meu marido queria vender a terra pro Barão. Eu disse: "sobre o meu cadáver". Replantei pé por pé, com as minhas mãos.', 'O Barão do Café vive querendo comprar a minha terra até hoje. Ele tem dinheiro, mas eu tenho paciência, e café bom é feito de paciência.']]
      ] },
    { id: 'c2n_rafa', nome: 'Rafa Goleiro', papel: 'goleiro do Planalto FC', cena: 29, x: 2480, spec: { ...pele('canela'), build: 'strong', top: '#2c8a3a', topKind: 'tee', sleeve: 'short', print: '#f2c94c', pants: '#1e1e22', hair: { style: 'buzz', color: '#1b1714' }, gloves: '#f2c94c', pose: 'cocky' },
      oi: 'Opa! Pode chegar, mas não pisa na linha da pista com o pé esquerdo, que dá azar. É sério. Eu levei um frango no dia que alguém pisou.',
      temas: [
        ['Quem é você?', ['Rafael, goleiro titular do Planalto FC. Fechei o gol em sete jogos seguidos. No oitavo, a bola bateu num pombo e entrou. O pombo tá bem, eu que não tô.']],
        ['Me fala da cidade', ['Dia de jogo no Lomantão a cidade para. Tem espetinho na porta, buzinaço, criança com a cara pintada e o BODÃO, nosso mascote, dançando mais que o time joga.', 'E o frio! Jogo de noite no inverno é luva, touca e torcida soltando fumaça pela boca. Parece que todo mundo tá fumando, mas é só o frio mesmo.']],
        ['E a sua história?', ['Comecei no campinho de terra do bairro, defendendo com chinelo nas mãos porque luva era luxo. Minha mãe costurou a primeira com pano de prato.', 'Meu sonho é jogar na Série A e levar o nome de Conquista. Até lá, entro em campo sempre com o pé direito, beijo a trave duas vezes e falo com a bola. Ela me entende.']]
      ] },
    { id: 'c2n_celeste', nome: 'Irmã Celeste', papel: 'freira da Catedral (e fã de heavy metal)', cena: 14, x: 2180, spec: { ...pele('trigo'), build: 'normal', h: .93, top: '#2a2f3a', topKind: 'robe', robeDots: '#2a2f3a', pants: '#2a2f3a', hair: { style: 'short', color: '#2a2f3a' }, glasses: '#2a2a2a', headset: '#c43c3a', item: 'book', pose: 'talk', mood: 'happy' },
      oi: 'A paz, meu filho! Hã? Ah, os fones. É... um hino. Um hino bem animado. Com guitarra. E bateria dupla.',
      temas: [
        ['Quem é você?', ['Irmã Celeste. Cuido da cozinha solidária aqui da Catedral: sopa quente todo dia de inverno pra quem precisa. E nas horas vagas eu escuto heavy metal. Deus entende, ele fez o trovão.']],
        ['Me fala da cidade', ['A Catedral Nossa Senhora das Vitórias é o coração do centro. A praça em volta junta todo mundo: aposentado, pombo, namorado, vendedor e turista perdido.', 'No inverno, quando a neblina desce, a torre some lá em cima. Os mais velhos dizem que é a santa se cobrindo do frio.']],
        ['E a sua história?', ['Antes de entrar pro convento, eu tocava bateria numa banda chamada "Neblina Mortal". A gente era horrível. Maravilhosamente horrível.', 'Hoje eu toco bateria só no bazar beneficente, uma vez por ano. A fila é enorme. Metade vem pela caridade e a outra metade pelo solo de bateria.']]
      ] },
    { id: 'c2n_kiko', nome: 'Kiko do Pedalinho', papel: 'aluga pedalinho na Lagoa das Bateias', cena: 32, x: 3880, spec: { ...pele('preto'), build: 'slim', h: .88, top: '#3c8ad8', topKind: 'tank', pants: '#c47a35', hat: { kind: 'capback', color: '#e8433a' }, hair: { style: 'short', color: '#14100c' }, pose: 'pockets', mood: 'happy' },
      oi: 'Ô, moço! Pedalinho de cisne, dez reais a meia hora. Se o cisne virar, o banho é cortesia. Brincadeira, nunca virou. Quase.',
      temas: [
        ['Quem é você?', ['Kiko, quinze anos, gerente, piloto de testes e único funcionário da Pedalinhos do Kiko. O dono é meu tio, mas quem manda nos cisnes sou eu.']],
        ['Me fala da cidade', ['A Lagoa das Bateias é o lugar mais calmo da cidade: gente correndo na pista, garça pescando, pato desfilando com os filhotes. Bateia é aquela bacia de garimpar ouro.', 'Dizem que antigamente tinha garimpo por aqui e que ainda tem uma pepita no fundo da lagoa. Eu já mergulhei três vezes. Achei um chinelo, uma moeda de dez centavos e um celular de 2009.']],
        ['E a sua história?', ['Meu pai pescava aqui todo domingo e me trazia junto. Hoje quem pesca é o Seu Toninho, ali no píer, mas eu guardo o lugar do meu pai.', 'Tô juntando dinheiro dos pedalinhos pra fazer faculdade de Biologia na UESB. Quero cuidar da lagoa e dos bichos dela. Os cisnes de plástico já tão aprovados no estágio.']]
      ] }
  ];

  /* =====================================================================
     OS 20 MORADORES (só pra conversar, conhecer a cidade e a história deles)
     ===================================================================== */
  const M = (id, nome, papel, cena, x, spec, oi, quem, cidade, historia) => ({ id, nome, papel, cena, x, spec, oi, temas: [['Quem é você?', quem], ['Me fala da cidade', cidade], ['E a sua história?', historia]] });
  const MORADORES = [
    M('c2m_agenor', 'Seu Agenor', 'aposentado do banco da praça', 14, 2060, { ...pele('canela'), build: 'belly', h: .92, top: '#7a5a3a', topKind: 'cardigan', inner: '#e8e2d0', pants: '#4a4a42', hat: { kind: 'cap', color: '#5a4a3a' }, hair: { style: 'bald', color: '#c8c4bc' }, mustache: '#e0dcd4', item: 'cane', pose: 'cane' },
      'Bom dia, rapaz. Senta aqui no banco, que o sol tá batendo bonitinho. Em Conquista, sol de inverno é ouro.',
      ['Agenor, aposentado dos Correios. Hoje meu emprego é dar milho pros pombos e opinião pros outros. As duas coisas de graça.'],
      ['Esta praça já viu de tudo: comício, procissão, desfile e namoro escondido atrás da árvore. Inclusive o meu, em 1968.', 'Frio de verdade é em junho e julho. Tem dia que amanhece com neblina tão grossa que a gente cumprimenta poste achando que é gente.'],
      ['Entreguei carta nesta cidade por trinta e cinco anos, a pé. Conheço o endereço de todo mundo. Se quiser achar alguém, me pergunta antes de perguntar pro celular.']),
    M('c2m_neide', 'Dona Neide', 'dona da banca de revista', 14, 1320, { ...pele('moreno'), build: 'normal', h: .93, top: '#c43c6a', topKind: 'cardigan', inner: '#f2e8d8', skirt: '#4a3a5a', hair: { style: 'curlyShort', color: '#6a3a2a' }, glasses: '#c43c3a', item: 'book', pose: 'read' },
      'Jornal, revista, figurinha, palavra cruzada? Ou só veio ler a capa de graça igual todo mundo?',
      ['Neide da banca. Tô aqui há trinta anos. Hoje vendo mais figurinha e chip de celular do que jornal, mas a banca continua firme.'],
      ['O centro de Conquista é comércio de ponta a ponta. De manhã é buzina, à tarde é promoção e à noite é friozinho com cheiro de pipoca.', 'Já reparou que as lojas daqui têm nome parecido com as de fora? CASAS BAIXA, PAGUE MAIS... É a criatividade do conquistense.'],
      ['Minha mãe abriu esta banca com um caixote e três revistas. Eu cresci lendo gibi escondida debaixo do balcão. Hoje minha neta faz a mesma coisa e eu finjo que não vejo.']),
    M('c2m_wellington', 'Wellington', 'mototaxista', 16, 1760, { ...pele('jambo'), build: 'normal', top: '#3a3f44', topKind: 'vest', vest: '#f08a24', vestBand: '#e8f06a', pants: '#2a3038', hat: { kind: 'helmet', color: '#2c5a9e', visor: '#2a3a46' }, pose: 'thumb' },
      'Corrida? Pra qualquer bairro, preço justo! Diferente de um certo Tonhão que eu não vou falar o nome... Ops.',
      ['Wellington, mototaxista há dez anos. Conheço todo atalho, buraco e lombada desta cidade. Os buracos, inclusive, têm nome.'],
      ['Conquista cresceu muito, rapaz. Onde era mato agora é condomínio, e onde era condomínio agora é engarrafamento.', 'Dica de mototaxista: no inverno, casaco por baixo do colete. O vento na Olívia Flores corta mais que faca de açougueiro.'],
      ['Comprei minha primeira moto com o dinheiro de vender picolé no Lomantão. Hoje sustento minha família com ela. Ela chama Dona Cleide. Não me pergunte por quê.']),
    M('c2m_lia', 'Lia', 'ciclista e entregadora', 21, 960, { ...pele('claro'), build: 'slim', h: .93, top: '#3c8a5a', topKind: 'hoodie', inner: '#2a3a2c', pants: '#22262c', hair: { style: 'ponytail', color: '#c8a050' }, pose: 'hips' },
      'Ufa! Parei só pra respirar. Já pedalei vinte quilômetros hoje, mas a ciclovia da Olívia é a melhor parte.',
      ['Lia, entregadora de bike. Levo comida, documento e, uma vez, um papagaio. Ele não gostou da viagem e me xingou o caminho todo.'],
      ['A Olívia Flores é a avenida mais bonita da cidade: canteiro verde, ciclovia, gente correndo de manhã e academia ao ar livre.', 'Só cuidado com a subida perto da escola. Na bike ela parece o Everest.'],
      ['Comecei a pedalar pra economizar a passagem. Virou paixão. Ano que vem vou tentar uma prova de ciclismo em Salvador. Vou de bike até lá? Não, aí também não.']),
    M('c2m_cotinha', 'Dona Cotinha', 'dona da biscoitaria', 17, 470, { ...pele('canela'), build: 'belly', h: .9, top: '#c47a35', topKind: 'apron', apron: '#f6ecd0', skirt: '#6a4a3a', hair: { style: 'bun', color: '#e0dcd4' }, item: 'biscuit', pose: 'offer' },
      'Prova um biscoitinho, meu bem. Tá quentinho, saiu agora. Se não gostar, eu como de volta.',
      ['Cotinha, da biscoitaria. Faço biscoito de polvilho, sequilho e bolo de puba. A receita é da minha avó e o segredo vai comigo pro túmulo.'],
      ['Biscoito em Conquista é coisa séria: tem no café da manhã, no lanche, na rodoviária e na bolsa da sua tia.', 'No frio, um café com biscoito resolve quase tudo. O que não resolve, resolve com dois.'],
      ['Comecei vendendo na porta de casa, em bacia. Hoje tenho loja, três fornos e uma fila que dobra a esquina no sábado. O Fusca do Seu Arlindo para aqui todo dia, por isso tem engarrafamento.']),
    M('c2m_pedro', 'Pedro', 'estudante de Medicina', 31, 1500, { ...pele('escuro'), build: 'slim', top: '#f6f6f2', topKind: 'coat', pants: '#2c3646', hair: { style: 'curly', color: '#14100c' }, glasses: '#2a2a2a', item: 'book', pose: 'read', mood: 'sad' },
      'Desculpa, eu tô estudando pra prova de Anatomia. São 206 ossos e eu só lembro do fêmur. E mal.',
      ['Pedro, terceiro ano de Medicina. Durmo quatro horas por noite e o resto é café. Minha corrente sanguínea é sessenta por cento cafezinho.'],
      ['Conquista é polo de saúde da região toda. Vem gente de muita cidade do sudoeste baiano se tratar aqui: hospital, clínica e universidade.', 'E o RU é a salvação do estudante: almoço barato, bandeja cheia e fila que dá pra fazer amizade.'],
      ['Sou o primeiro médico da minha família. Quer dizer, vou ser. Minha mãe já me apresenta como "doutor" desde o vestibular. A pressão é grande.']),
    M('c2m_josue', 'Josué', 'segurança do shopping', 20, 520, { ...pele('preto'), build: 'strong', top: '#1f2226', topKind: 'tee', sleeve: 'short', pants: '#1f2226', hair: { style: 'bald', color: '#1b1714' }, shades: true, pose: 'hips' },
      'Boa tarde, cidadão. Sem correr no shopping. E sem pular nas plataformas de vidro... Ah, deixa, você parece responsável.',
      ['Josué, segurança do shopping. Pareço bravo, mas choro em filme de cachorro. Não conta pra ninguém.'],
      ['O shopping é o ponto de encontro da cidade: cinema, lan house, praça de alimentação e gente fugindo do frio.', 'No Festival de Inverno fica lotado de turista. Todo mundo pergunta onde compra casaco. Eu aponto pra RIACHORRO.'],
      ['Fui lutador de boxe amador. Perdi mais do que ganhei, mas aprendi a ficar de pé. Hoje treino a molecada do bairro de graça, nos domingos.']),
    M('c2m_rosa', 'Tia Rosa', 'vendedora de acarajé', 13, 2760, { ...pele('preto'), build: 'belly', h: .94, top: '#f6f6f2', topKind: 'robe', robeDots: '#e8c24c', pants: '#f6f6f2', hair: { style: 'bun', color: '#14100c' }, earrings: '#e8c24c', scarf: '#e8433a', pose: 'offer', mood: 'happy' },
      'Acarajé quente ou frio? Quente quer dizer com pimenta, viu, meu filho? Já vi gente de fora chorar e pedir mais.',
      ['Rosa, baiana de acarajé. Tabuleiro na esquina há vinte e cinco anos, chova ou faça frio. E aqui faz frio.'],
      ['Conquista é Bahia também, viu? Pode ser fria, mas o tempero é o mesmo. Acarajé, abará, vatapá e caruru: tem tudo.', 'O bairro da pensão é bom de morar: vizinho que empresta açúcar, cachorro que cumprimenta e Dona Lurdes que sabe de tudo antes de acontecer.'],
      ['Aprendi a fazer acarajé com minha mãe, em Salvador. Vim pra cá atrás do meu marido, que veio atrás de emprego. O emprego acabou, o marido também. O acarajé ficou.']),
    M('c2m_marquinhos', 'Marquinhos', 'dono do lava-jato', 16, 5300, { ...pele('cobre'), build: 'normal', top: '#3c6aa8', topKind: 'overall', inner: '#e8e2d0', pants: '#3c6aa8', hat: { kind: 'capback', color: '#f2c94c' }, hair: { style: 'short', color: '#1c1714' }, item: 'wrench', pose: 'carry' },
      'Lavagem completa por trinta! Mas se for o Fusca do Seu Arlindo, cobro cinquenta: aquilo tem biscoito até no motor.',
      ['Marquinhos, do lava-jato e borracharia. Conserto pneu, lavo carro e dou conselho amoroso. O conselho é de graça e geralmente errado.'],
      ['Na Avenida passa o mundo inteiro: caminhão da Rio-Bahia, ônibus, moto e carro de som anunciando promoção de colchão.', 'Quando chove, a poça da frente vira piscina. Já vi criança de boia ali.'],
      ['Comecei com um balde e uma esponja na porta do posto. Hoje tenho dois funcionários e uma máquina de espuma que eu chamo de "Nuvem". Ela entende.']),
    M('c2m_dalva', 'Vó Dalva', 'moradora mais antiga do bairro', 13, 1240, { ...pele('trigo'), build: 'normal', h: .86, hunch: true, top: '#8a5aa0', topKind: 'cardigan', inner: '#efe2c8', skirt: '#5b4a62', hair: { style: 'curlyShort', color: '#f2efe6' }, glasses: '#8a7a6a', scarf: '#3c6aa8', item: 'cane', pose: 'cane' },
      'Chega mais perto, meu neto, que minha vista não é mais aquela. Ah, é o rapaz do chapéu! Lurdes falou de você.',
      ['Dalva, noventa e um anos. Moro nesta rua desde que ela era de barro. Já fui costureira, parteira e, por um verão, campeã de dominó.'],
      ['Antigamente Conquista era pequenininha: uma igreja, umas ruas e muito boi. A Rio-Bahia veio e trouxe gente de todo lado. Hoje é cidade grande, mas o frio continua o mesmo.', 'Teve inverno de geada branquinha no capim, parecendo açúcar. A criançada achava que era neve e saía correndo de pé descalço.'],
      ['Fiz o parto de metade dos meninos desta rua, de lamparina na mão. Quando vejo um deles de terno, penso: esse aí eu segurei pelas perninhas.']),
    M('c2m_caua', 'Cauã', 'menino da pipa', 33, 2560, { ...pele('jambo'), build: 'slim', h: .78, top: '#e8c24c', topKind: 'tee', sleeve: 'short', pants: '#3c6aa8', hair: { style: 'short', color: '#14100c' }, pose: 'thumb', mood: 'happy' },
      'Olha minha pipa lá em cima! É a vermelha, a mais alta! As outras são da molecada da outra rua. Perdedores.',
      ['Cauã, nove anos, campeão de pipa do Parque da Cidade. Título dado por mim mesmo, mas tá valendo.'],
      ['Agosto é mês de vento bom em Conquista. O céu fica cheio de pipa. Mas cerol é proibido, viu? Corta o pescoço dos motoqueiros. Pipa boa é com linha limpa.', 'No parque tem tudo: balanço, skate, picolé e o trenzinho, que eu acho meio de bebê, mas eu ando escondido.'],
      ['Meu avô me ensinou a fazer pipa com vareta de bambu e papel de seda. A minha dura mais que a da loja. Um dia vou fazer uma do tamanho de uma porta.']),
    M('c2m_toninho', 'Seu Toninho', 'pescador do píer', 32, 1700, { ...pele('canela'), build: 'belly', h: .94, top: '#5a7a4a', topKind: 'vest', vest: '#c8b48a', vestBand: '#8a7a5a', pants: '#4a4a42', hat: { kind: 'straw', color: '#d7b665' }, hair: { style: 'short', color: '#c8c4bc' }, mustache: '#c8c4bc', pose: 'relaxed' },
      'Psiu! Fala baixinho que o peixe escuta. Ontem eu peguei um deste tamanho. Tá, deste tamanho. Tá bom, era um lambari.',
      ['Antônio, pescador de fim de semana, contador de história de segunda a sexta. Aposentado da prefeitura.'],
      ['A lagoa é o quintal de quem não tem quintal. Tem garça, pato, gente correndo e casal brigando no pedalinho.', 'De manhã cedo a neblina fica em cima da água que nem fumaça. É a hora mais bonita, e a hora que o peixe morde.'],
      ['Pescava aqui com o pai do Kiko, o menino dos pedalinhos. Grande amigo. Hoje eu ensino o Kiko a ter paciência. Ele não aprende, mas eu tenho paciência.']),
    M('c2m_jurema', 'Jurema', 'vendedora de passagens', 30, 1160, { ...pele('moreno'), build: 'normal', h: .94, top: '#2c5a9e', topKind: 'tee', sleeve: 'short', pants: '#2a2f3a', hair: { style: 'long', color: '#3a2418' }, earrings: '#e8c24c', lipstick: '#c4384e', item: 'phone', pose: 'phone' },
      'Próximo! Ah, não é cliente. Tudo bem, a fila tá vazia mesmo. Fica à vontade, só não senta na mala de ninguém.',
      ['Jurema, do guichê da Novo Horizontinho. Vendo passagem pra Salvador, Brumado, Jequié... e escuto cada história que dava novela.'],
      ['A rodoviária é a porta da cidade. Gente chegando pra estudar na UESB, pra se tratar no hospital, pra visitar a avó ou fugindo de namorado.', 'Sexta à noite é um formigueiro. Domingo à noite, todo mundo volta com sacola de biscoito e café pra família.'],
      ['Já vendi passagem pra noivo fugindo do casamento e, uma hora depois, pra noiva indo atrás. Os dois voltaram casados. Eu fui madrinha.']),
    M('c2m_beto', 'Beto Taxista', 'taxista do aeroporto', 12, 3900, { ...pele('claro'), build: 'belly', top: '#e8e2d0', topKind: 'polo', sleeve: 'short', pattern: '#c8c2b0', pants: '#3a3f46', hair: { style: 'side', color: '#6a5040' }, mustache: '#6a5040', item: 'keys', pose: 'talk' },
      'Táxi? Ah, já tem o Seu Zé, né? Aquele lá rouba cliente com conversa. Eu roubo com desconto.',
      ['Roberto, taxista do aeroporto. Rival declarado do Seu Zé do Táxi. A gente briga por passageiro e depois toma café junto.'],
      ['O aeroporto Glauber Rocha leva o nome do cineasta mais famoso da cidade. Quem desce do avião já sente o frio na escada e pergunta: "isso aqui é Bahia mesmo?"', 'Do aeroporto ao centro é rapidinho. A não ser que o Seu Zé pegue o passageiro, aí ele dá um tour e cobra.'],
      ['Era caminhoneiro na Rio-Bahia. Rodei o Brasil inteiro e escolhi parar aqui, por causa do clima. E de uma moça da padaria. Hoje ela é minha esposa e a padaria é nossa.']),
    M('c2m_anaclara', 'Ana Clara', 'guia da trilha do Cristo', 15, 1260, { ...pele('trigo'), build: 'slim', h: .95, top: '#e8833a', topKind: 'puffer', pants: '#3a4a3a', hair: { style: 'ponytail', color: '#3a2418' }, hat: { kind: 'cap', color: '#3c8a5a' }, item: 'map', pose: 'offer' },
      'Oi! Subindo pro Cristo? Leva água e casaco. Lá em cima venta tanto que já vi peruca voando.',
      ['Ana Clara, guia de trilha. Subo a Serra do Periperi umas cinco vezes por semana. Minha panturrilha tem CPF próprio.'],
      ['O Cristo daqui é diferente: alongado, de concreto, feito pelo artista Mário Cravo. Lá de cima dá pra ver a cidade inteira espalhada no planalto.', 'Nascer do sol no mirante com neblina embaixo é a coisa mais bonita de Conquista. Vale acordar às quatro. Quase.'],
      ['Comecei a fazer trilha depois de uma fase difícil. Cada subida foi me deixando mais forte. Hoje levo outras pessoas e vejo elas chegando lá em cima com a mesma cara que eu fiz.']),
    M('c2m_ronaldo', 'Ronaldo', 'guarda-parque do Poço Escuro', 28, 4160, { ...pele('escuro'), build: 'strong', top: '#4a6a3a', topKind: 'vest', vest: '#5a7a3a', vestBand: '#e8c24c', pants: '#3a4a3a', hat: { kind: 'rancher', color: '#6b5a3c', band: '#3a2a1a' }, hair: { style: 'short', color: '#1c1714' }, pose: 'hips' },
      'Bem-vindo à reserva! Regras: não jogue lixo, não alimente os saguis e não toque no sapo. Ele tem mais seguidor que eu.',
      ['Ronaldo, guarda-parque da Reserva do Poço Escuro. Cuido da mata, das trilhas e dos visitantes que se perdem a cinquenta metros da entrada.'],
      ['É mata atlântica no meio da cidade, acredita? Tem nascente, sagui, tucano, bromélia e árvore com raiz em aba, a tal da sapopemba.', 'Essa mata ajuda a segurar a água e o ar fresco de Conquista. Sem ela, a cidade ficava mais seca e mais quente.'],
      ['Quando criança eu caçava passarinho de estilingue. Um dia vi um tucano de perto e larguei o estilingue no chão. Hoje passo o dia protegendo os passarinhos que eu tentava pegar.']),
    M('c2m_tialourdinha', 'Tia Lourdinha', 'dona da cantina da UESB', 31, 1180, { ...pele('canela'), build: 'belly', h: .92, top: '#e8433a', topKind: 'apron', apron: '#f6f2ea', skirt: '#4a3a5a', hair: { style: 'curlyShort', color: '#3a2418' }, glasses: '#8a3a3a', item: 'mug', pose: 'mug', mood: 'happy' },
      'Pastel de queijo, de carne ou de vento? O de vento é pra quem tá no fim do mês. Esse eu dou de graça.',
      ['Lourdinha, a "Tia da Cantina". Alimento estudante há quinze anos. Já vi muito calouro virar doutor comendo meu pastel.'],
      ['A UESB mudou a cidade: veio gente de toda a região estudar aqui, abriu república, xerox e cantina. Conquista ficou mais jovem.', 'Semana do calouro é uma festa. Tem trote, tinta e calouro perdido procurando o módulo de aulas. Fica à direita, sempre.'],
      ['Comecei vendendo pastel numa caixa de isopor na porta do campus. O reitor da época comprava todo dia. Foi ele que me deu a cantina. Até hoje guardo o primeiro isopor.']),
    M('c2m_thiaguinho', 'DJ Thiaguinho', 'DJ do Festival de Inverno', 19, 1240, { ...pele('preto'), build: 'slim', top: '#7a2a8a', topKind: 'hoodie', inner: '#2a1a3a', pants: '#1f2430', hat: { kind: 'capback', color: '#1e1e22' }, hair: { style: 'short', color: '#14100c' }, headset: '#f2c94c', chain: '#e8c24c', pose: 'cocky' },
      'Ôôô, o som tá passando agora, ouviu? Teste, teste... Esse grave é pra esquentar o frio, meu irmão!',
      ['Thiaguinho, DJ. Toco arrocha, pagode, forró e, se pedir com jeitinho, até valsa de quinze anos.'],
      ['O Festival de Inverno é a época mais animada da cidade: palco grande, turista, roda-gigante e gente dançando de casaco e touca.', 'E o Teatro Glauber Rocha traz peça, cinema e show o ano todo. Hoje mesmo tem Bia do Arrocha!'],
      ['Comecei com um som de carro e um pendrive emprestado, tocando em aniversário de bairro. Um dia o DJ principal do festival passou mal e me chamaram. Toquei por quatro horas. Desde então, todo ano.']),
    M('c2m_zezinho', 'Seu Zezinho', 'colhedor de café', 18, 3000, { ...pele('cobre'), build: 'slim', top: '#a8b48a', topKind: 'tee', sleeve: 'long', pants: '#4a4a3a', hat: { kind: 'straw', color: '#d7b665' }, hair: { style: 'short', color: '#2a231d' }, pose: 'carry' },
      'Ê, chegou na hora boa: tá na época da colheita! Quer ajudar a derriçar o pé? Pago em café.',
      ['José, o Zezinho. Colho café na fazenda da Dona Zefa desde menino. Minhas mãos têm o cheiro do grão, nem sabão tira.'],
      ['O café do planalto precisa do frio da noite e do sol do dia. É por isso que ele é bom: sofre um pouquinho, igual a gente.', 'Depois de colhido, ele seca no terreiro e a gente vira com o rodo, devagar, o dia todo. Café bom é café paciente.'],
      ['Meu pai colhia aqui, meu avô colhia aqui. Meu filho estuda Agronomia na UESB pra cuidar do cafezal com ciência. Eu ensino o resto: o jeito da mão.']),
    M('c2m_marina', 'Marina', 'fotógrafa', 34, 1300, { ...pele('claro'), build: 'slim', h: .94, top: '#2c3a5a', topKind: 'puffer', pants: '#3a3f46', hair: { style: 'long', color: '#c8a050' }, scarf: '#e8c24c', item: 'selfie', pose: 'selfie' },
      'Shhh, espera... a nuvem tá chegando... AGORA! Ah, passou um caminhão. De novo.',
      ['Marina, fotógrafa de paisagem. Venho pra Serra do Marçal toda semana caçar a foto perfeita do mar de nuvens.'],
      ['Conquista tem paisagem que pouca gente conhece: o mar de nuvens daqui, o pôr do sol no Cristo, a neblina na lagoa e as torres eólicas girando no fim da tarde.', 'Inverno é a melhor época pra foto. O céu fica limpo e azul de dia e a neblina fica bonita de manhã.'],
      ['Ganhei minha primeira câmera de presente da minha avó, que vendeu umas joias pra comprar. Toda foto que eu tiro, eu penso nela. A melhor ainda não saiu. Um dia sai.'])
  ];

  const TODOS = PERSONAGENS.map((p) => ({ ...p, tipo: 'personagem' })).concat(MORADORES.map((p) => ({ ...p, tipo: 'morador' })));
  for (const p of TODOS) CP.registrar(p.id, { name: p.nome, ...p.spec }, p.tipo === 'personagem' ? 'personagem (2D)' : 'morador');

  /* ---------- caderninho: quem você já conheceu ---------- */
  let conhecidos = new Set();
  try { conhecidos = new Set(JSON.parse(localStorage.getItem(KEY) || '[]')); } catch (e) { conhecidos = new Set(); }
  const salvar = () => { try { localStorage.setItem(KEY, JSON.stringify([...conhecidos])); } catch (e) {} };

  /* ---------- desenho no mundo (atrás do herói) ---------- */
  const daCena = (cena) => TODOS.filter((p) => p.cena === cena);
  function desenhar(c, o) {
    const L = daCena(Number(o.scene)); if (!L.length) return; const t = Number(o.time) || 0, hx = Number(o.player?.x) || -9999, cam = Number(o.camera) || 0;
    for (const p of L) {
      if (p.x < cam - 80 || p.x > cam + 1040) continue;
      const perto = Math.abs(p.x - hx) < 160, facing = perto ? (hx > p.x ? 1 : -1) : (p.facing || (p.x % 2 ? 1 : -1));
      window.Art.drawCharacter(c, p.id, p.x, FLOOR, { frame: t + p.x * .01, facing, moving: false, grounded: true, vy: 0 });
      const novo = !conhecidos.has(p.id), y = FLOOR - 112 + Math.round(Math.sin(t * 3 + p.x) * 2);
      if (novo || perto) { // balãozinho em cima da cabeça: ! (ainda não conhece) ou … (já conhece)
        const col = novo ? (p.tipo === 'personagem' ? '#ffd24a' : '#8ae0ff') : '#f3d89e', bx = Math.round(p.x) - 10, by = y - 12;
        c.fillStyle = '#2a1a14'; c.fillRect(bx - 2, by - 2, 24, 22); c.fillRect(bx + 8, by + 20, 6, 4); c.fillStyle = col; c.fillRect(bx, by, 20, 18); c.fillRect(bx + 10, by + 18, 2, 2); c.fillStyle = '#2a1a14';
        if (novo) { c.fillRect(bx + 8, by + 3, 4, 8); c.fillRect(bx + 8, by + 13, 4, 3); } else for (let k = 0; k < 3; k++) c.fillRect(bx + 3 + k * 6, by + 8, 3, 3); }
    }
  }
  function perto(cena, x) { let best = null, d = 70; for (const p of daCena(Number(cena))) { const dd = Math.abs(p.x - x); if (dd < d) { d = dd; best = p; } } return best; }

  /* ---------- caixa de conversa ---------- */
  let box = null, cur = null, fila = [], texto = '', shown = 0, typing = null, onClose = null, modo = 'menu', lidos = new Set();
  function css() {
    if (document.getElementById('c2MoradoresCss')) return; const st = document.createElement('style'); st.id = 'c2MoradoresCss';
    st.textContent = `.c2m-box{position:fixed;left:50%;bottom:max(14px,env(safe-area-inset-bottom));transform:translateX(-50%);width:min(920px,calc(100vw - 20px));z-index:2147483000;display:flex;gap:14px;align-items:stretch;background:#2a1e14;border:4px solid #e8c66a;box-shadow:0 0 0 4px #2a1e14,0 10px 30px rgba(0,0,0,.6);padding:12px;font-family:Pixel,monospace;color:#f6ead0;image-rendering:pixelated}
.c2m-box[hidden]{display:none}.c2m-ret{flex:0 0 auto;width:120px;height:120px;background:linear-gradient(#5a7a8a,#2c3a44);border:3px solid #120c08;image-rendering:pixelated}
.c2m-main{flex:1;display:flex;flex-direction:column;gap:8px;min-width:0}.c2m-nome{font-size:15px;color:#ffd98a;letter-spacing:1px}.c2m-papel{font-size:10px;color:#c8b48a;margin-left:8px}
.c2m-txt{font-size:13px;line-height:1.55;min-height:62px;white-space:pre-wrap}.c2m-ops{display:flex;flex-wrap:wrap;gap:6px}.c2m-ops button{font:inherit;font-size:11px;padding:7px 10px;background:#4a3420;color:#f6ead0;border:2px solid #e8c66a;cursor:pointer}
.c2m-ops button:hover,.c2m-ops button:focus{background:#e8c66a;color:#2a1e14;outline:none}.c2m-ops button.lido{opacity:.65}.c2m-dica{font-size:9px;color:#a8946a;display:flex;justify-content:space-between}
@media (max-width:600px){.c2m-ret{width:72px;height:72px}.c2m-txt{font-size:11px}.c2m-ops button{font-size:10px;padding:6px 8px}}`;
    document.head.appendChild(st);
  }
  function montar() {
    css(); box = document.createElement('div'); box.className = 'c2m-box'; box.hidden = true; box.setAttribute('role', 'dialog');
    box.innerHTML = '<canvas class="c2m-ret" width="60" height="60"></canvas><div class="c2m-main"><div><span class="c2m-nome"></span><span class="c2m-papel"></span></div><div class="c2m-txt" aria-live="polite"></div><div class="c2m-ops"></div><div class="c2m-dica"><span class="c2m-pass">E / ENTER: continuar · ESC: sair</span><span class="c2m-cad"></span></div></div>';
    document.body.appendChild(box);
    box.addEventListener('click', (e) => { if (e.target.closest('button')) return; avancar(); });
  }
  function retrato() { // desenha a pessoa grande, do peito pra cima
    const cv = box.querySelector('.c2m-ret'), c = cv.getContext('2d'); c.imageSmoothingEnabled = false; c.clearRect(0, 0, 60, 60);
    c.save(); c.translate(30, 68); window.Art.drawCharacter(c, cur.id, 0, 0, { frame: performance.now() / 1000, facing: 1, moving: false, grounded: true }); c.restore();
  }
  function digitar(str) { texto = str; shown = 0; clearInterval(typing); const el = box.querySelector('.c2m-txt'); el.textContent = ''; typing = setInterval(() => { shown = Math.min(texto.length, shown + 2); el.textContent = texto.slice(0, shown); if (shown >= texto.length) { clearInterval(typing); typing = null; if (!fila.length) menu(); } }, 18); }
  function menu() {
    modo = 'menu'; const ops = box.querySelector('.c2m-ops'); ops.innerHTML = '';
    cur.temas.forEach(([q], i) => { const b = document.createElement('button'); b.type = 'button'; b.textContent = `${i + 1}. ${q}${lidos.has(i) ? ' ✓' : ''}`; if (lidos.has(i)) b.className = 'lido'; b.addEventListener('click', () => tema(i)); ops.appendChild(b); });
    const b = document.createElement('button'); b.type = 'button'; b.textContent = `${cur.temas.length + 1}. Tchau!`; b.addEventListener('click', fechar); ops.appendChild(b);
    box.querySelector('.c2m-pass').textContent = '1 a 4 ou toque: escolher · E: próximo assunto · ESC: sair';
  }
  function tema(i) { lidos.add(i); modo = 'fala'; fila = cur.temas[i][1].slice(); box.querySelector('.c2m-ops').innerHTML = ''; box.querySelector('.c2m-pass').textContent = 'E / ENTER / toque: continuar · ESC: sair'; digitar(fila.shift()); }
  function avancar() {
    if (!cur) return; const el = box.querySelector('.c2m-txt');
    if (typing) { clearInterval(typing); typing = null; el.textContent = texto; if (!fila.length) menu(); return; }
    if (fila.length) { digitar(fila.shift()); return; }
    if (modo !== 'menu') menu();
  }
  function conversar(id, opts = {}) {
    const p = TODOS.find((q) => q.id === id); if (!p) return false; if (!box) montar();
    cur = p; lidos = new Set(); onClose = opts.onClose || null; fila = [];
    const novo = !conhecidos.has(id); conhecidos.add(id); salvar();
    box.querySelector('.c2m-nome').textContent = p.nome.toUpperCase(); box.querySelector('.c2m-papel').textContent = p.papel;
    box.querySelector('.c2m-cad').textContent = `CADERNINHO: ${conhecidos.size}/${TODOS.length} conhecidos${novo ? ' · NOVO!' : ''}`;
    box.querySelector('.c2m-ops').innerHTML = ''; box.hidden = false; retrato(); modo = 'oi'; digitar(p.oi);
    window.dispatchEvent(new CustomEvent('controls-capture', { detail: { owner: 'moradores', active: true } }));
    return true;
  }
  function fechar() { if (!box || box.hidden) return; clearInterval(typing); typing = null; box.hidden = true; cur = null; window.dispatchEvent(new CustomEvent('controls-capture', { detail: { owner: 'moradores', active: false } })); const f = onClose; onClose = null; f?.(); }
  addEventListener('keydown', (e) => {
    if (!box || box.hidden) return; const k = e.key;
    if (k === 'Escape') { fechar(); } else if (modo === 'menu' && /^[1-9]$/.test(k)) { const i = Number(k) - 1; if (i < cur.temas.length) tema(i); else if (i === cur.temas.length) fechar(); }
    else if (k === 'Enter' || k === ' ' || k.toLowerCase() === 'e') { if (modo === 'menu') { const i = cur.temas.findIndex((_, j) => !lidos.has(j)); if (i >= 0) tema(i); else fechar(); } else avancar(); } // E segue pro próximo assunto e, no fim, dá tchau else { e.stopImmediatePropagation(); return; }
    e.preventDefault(); e.stopImmediatePropagation(); // a tecla é da conversa: não vai pro jogo nem pro visualizador
  }, true);

  window.CampanhaMoradores = Object.freeze({
    desenhar, perto, conversar, fechar,
    aberto: () => !!box && !box.hidden,
    lista: () => TODOS.map(({ id, nome, papel, cena, x, tipo }) => ({ id, nome, papel, cena, x, tipo })),
    conhecidos: () => [...conhecidos],
    esquecer: () => { conhecidos = new Set(); salvar(); }
  });
})();
