# Fase 3: shaders, clima e qualidade

## Menu de qualidade (pausa → QUALIDADE)

| Nível | O que liga | Para quem |
| --- | --- | --- |
| BAIXA | Arte antiga, sem clima nem efeitos | Celulares simples |
| MÉDIA | Cenários novos, hora do dia, clima e partículas, sem WebGL | Celulares bons e TV Android |
| ALTA | Tudo da média + pós-processamento em WebGL | Computadores e celulares fortes |
| AUTO | Escolhe pelo aparelho e desce um nível se o jogo ficar lento | Padrão |

O automático reconhece TV Android (escolhe MÉDIA), celulares com pouca memória ou poucos núcleos (BAIXA) e computadores com WebGL (ALTA).

## Efeitos da qualidade ALTA (`dist/shader.js`)

- Relevo de luz: o shader estima uma normal para cada pixel a partir do brilho dos vizinhos e ilumina pela direção do sol ou da lua da hora do dia. Não há normal maps desenhados à mão; quando houver, o carregador de sprites pode recebê-los.
- Brilho nas luzes, raios de sol volumétricos que seguem o sol e a lua, faixas de luz e poeira dourada.
- Névoa no horizonte (mais forte na chuva e na neve).
- Reflexo e ondulação no rio da Praça Camacan.
- Distorção de calor ao meio-dia na quadra, na favela e no campo.
- Profundidade de campo leve só no céu distante.
- Correção de cor (luz quente, sombra fria, mais azul à noite) e vinheta.
- O pixel art continua nítido: a imagem é lida sem filtro e tudo que desloca a imagem anda em pixels inteiros.

## Clima (pausa → CLIMA, `dist/weather.js`)

Automático, Sol, Chuva, Neve e Vento. Funciona nas fases ao ar livre, nas qualidades MÉDIA e ALTA.

- Chuva: nuvens carregadas, gotas inclinadas pelo vento, respingos e poças brilhando no chão, trovões.
- Neve: flocos balançando e o chão ficando branco aos poucos.
- Vento: rajadas e folhas voando.
- Poeira: nuvem baixa e grãos rolando na quadra, favela e campo.

Tudo é só aparência: física, tempos, dificuldade e saves não mudam.
