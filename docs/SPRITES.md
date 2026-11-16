# Trocar a arte por imagens (sprites)

O jogo desenha tudo por código, mas aceita imagens PNG no lugar. Não é preciso mexer em código: basta colocar o arquivo na pasta e registrar o nome no manifesto.

## Passo a passo

1. Coloque o PNG em `dist/assets/sprites/`.
2. Registre em `dist/assets/sprites/manifest.json`:

```json
{
  "versao": 1,
  "sprites": {
    "personagem-igor": {
      "arquivo": "igor.png",
      "quadro": [64, 64],
      "fps": 8,
      "animacoes": {
        "parado": [0, 1, 2, 3],
        "andar": [4, 5, 6, 7, 8, 9],
        "pulo": [10],
        "ataque": [11, 12, 13, 14, 15],
        "dano": [16, 17]
      }
    }
  }
}
```

3. Recarregue o jogo. Se o nome não estiver no manifesto ou a imagem falhar, o jogo usa o desenho por código.

## Regras das imagens

- **Formato:** PNG com fundo transparente.
- **Densidade:** desenhe em 1x; o jogo amplia 2x sem filtro. Um personagem comum tem cerca de 24x48 pixels dentro de um quadro de 64x64.
- **Folha de quadros:** quadros do mesmo tamanho, da esquerda para a direita e de cima para baixo. O índice começa em 0.
- **Âncora:** o centro da base do quadro fica nos pés. Para mudar, use `"ancora": [x, y]`.
- **Direção:** desenhe olhando para a direita; o jogo espelha.
- **Luz:** vinda de cima e da esquerda, sem sombra no chão (o jogo desenha a sombra).

## Nomes aceitos

| Nome | O que troca | Tamanho |
| --- | --- | --- |
| `personagem-<tipo>` | Um personagem (`daroca`, `igor`, `kaique`...) | Folha com quadros iguais |
| `arena-igor-parede` | Parede, balcões e piso da cantina do Igor | 780x270, com as janelas transparentes |

Animações de personagem: `parado`, `andar`, `pulo`, `ataque`, `dano`. Se faltar alguma, vale `parado`.

A troca de personagem por imagem ainda não foi testada com uma folha real; o carregador e a troca da parede da cantina seguem o mesmo caminho.
