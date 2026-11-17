# Fliperama da Roça (Fase 6)

Minigames 2D em pixel art, para jogar sozinho ou em dupla no mesmo aparelho. O código fica em `dist/fliperama.js` e o visual em `dist/fliperama.css`.

## Onde fica

- **Menu inicial:** botão 🕹 FLIPERAMA.
- **Pausa:** "Fliperama da Roça".
- **INVENTÁRIO:** linha do fliperama com as fichas, as medalhas e o botão JOGAR.
- **Nos mapas:** máquinas de fliperama na roça, escola, quadra, praça, favela, campo e pátio. Chegue perto e aperte E.

Enquanto o fliperama está aberto, a campanha fica parada e o cronômetro não conta. O progresso do fliperama fica salvo só neste aparelho (`daroca-fliperama-v1`) e não muda o save da campanha.

## Os 6 minigames

| Jogo | Inspirado em | Sozinho | Dupla |
| --- | --- | --- | --- |
| Minhoca do Cafezal | cobrinha | come café, cresce e foge do milho dourado | contra: quem bater primeiro perde |
| Pingue-Pongue do Pátio | pong | contra o Nikolas até 7 | contra, até 7 |
| Quebra-Caderno | quebra-blocos | 4 cadernos que se repetem cada vez mais rápido; itens lápis, borracha, cola e coração | juntos: duas réguas e vidas em comum |
| Cabo de Guerra | apertar rápido | melhor de 3 contra o Nikolas | contra, melhor de 3 |
| Chuva de Chinelo | desviar | sobreviva e pegue açaí | juntos: pontos somados, coração revive o parceiro |
| Reflexo do Galo | reflexo | 5 rodadas, com sons falsos para enganar | contra: vence quem fizer 3 |

Cada jogo mostra regras e controles antes de começar e de novo na contagem regressiva. Depois vêm o placar, as medalhas (bronze, prata e ouro no modo sozinho) e as fichas. O ranking guarda os 5 melhores com iniciais de 3 letras, no estilo fliperama; nos jogos de dupla "contra", ele conta as vitórias de cada um.

## Controles

| Quem | Teclado | Controle | Toque |
| --- | --- | --- | --- |
| Jogando sozinho | setas ou WASD; A = J, Espaço ou Enter; B = K | controle 1 | direcional à esquerda, A e B à direita |
| P1 em dupla | WASD; A = J; B = K | controle 1 | metade esquerda da tela |
| P2 em dupla | setas; A = Enter; B = Shift direito | controle 2 | metade direita da tela |

Esc ou o ✕ volta uma tela; durante a partida, pausa. P também pausa.

## Criar um minigame novo

Acrescente um objeto na lista `GAMES` em `dist/fliperama.js`, ou chame `Fliperama.register({...})` de outro script carregado depois:

```js
{
  id: 'meujogo', name: 'MEU JOGO', sub: 'Frase curta.', color: '#e8823a',
  duo: 'coop',            // 'coop' (juntos) ou 'versus' (contra)
  medals: [100, 300, 600], // pontos para bronze, prata e ouro (modo sozinho)
  rules: ['Regra 1', 'Regra 2', 'Regra 3'], rulesDuo: ['Regra em dupla'],
  controls: ['Direcional: mover', 'A: pular'],
  init(st) { /* st.mode é 'solo' ou 'duo'; st.score = [0, 0] */ },
  update(st, dt) { /* use P[0] e P[1]: x, y (-1/0/1), a, b, ap e bp (apertou agora); termine com st.end({ score }) ou st.end({ winner: 0 }) */ },
  drawLow(g, st) { /* cenário em 480x270, ampliado 2x com pixels nítidos */ },
  drawMain(c, st) { /* textos e personagens em 960x540 */ }
}
```

Para desenhar o ícone no menu, acrescente um caso em `gameIcon`. Os sons (`sfx('pick')`, `'hit'`, `'win'` e outros) são sintetizados e não precisam de arquivo.
