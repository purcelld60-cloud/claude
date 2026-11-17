# Fase 4: cenário vivo e interativo

Arquivo principal: `dist/interact.js`. Os objetos de cada fase estão na tabela `SPEC` no início do arquivo: para mover, tirar ou acrescentar um objeto, edite a lista (tipo e posição em pixels do mundo).

| Tipo | O que faz | Onde |
| --- | --- | --- |
| Caixote, vaso, fardo, melancia, barril, cerca | Quebra com golpe, papel, tiro de chefe ou chefe correndo; volta depois de uns 30 s | Fases ao ar livre e arenas |
| Pneu, balde, lixeira, bola, cone | Empurra encostando, voa com golpe, rola e quica | Fases ao ar livre |
| Porta | Abre quando você chega perto (casas, escola, favela) | Roça, escola, favela |
| Alavanca | Liga e desliga com um golpe: irrigador com arco-íris, chafariz gigante, luzes de festa, sirene da escola, refletores | Uma por fase |
| Poça | Ondula e espirra ao pisar, pousar, na chuva e com pouso de chefe | Fases ao ar livre |
| Ratoeira | Estala ao pisar (sem dano) e arma de novo | Favela |
| Churrasqueira | Brasa e fumaça; um golpe solta fagulhas que acendem o capim seco perto | Roça, quadra, favela |
| Capim seco | Pega fogo e espalha célula por célula, vira cinza e cresce de novo; chuva e irrigador apagam; raio de tempestade pode acender | Roça, quadra, favela |
| Elevador e balsa | Plataformas que se movem e levam você junto (rotas opcionais) | Fases ao ar livre |

Pousos pesados de chefes e inimigos viram onda de choque: objetos pulam, poças espirram, ratoeiras disparam, portas batem e caem folhas. O dash levanta folhas e empurra objetos leves.

Nada disso causa dano nem muda a dificuldade. Na qualidade BAIXA os objetos ficam desligados; as plataformas móveis continuam.
