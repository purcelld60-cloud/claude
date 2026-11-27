# Como colocar o Da Roça Adventure no Roblox: passo a passo

Este guia leva o jogo do zero até publicado no Roblox, jogável no celular, no PC e com controle de Xbox ou PlayStation.
Leva uns 20 minutos. Você **não precisa programar** e **não precisa instalar nada além do Roblox Studio**.

> O que só você pode fazer (precisa da sua conta): entrar no Roblox Studio, publicar, enviar os sons e fazer a
> verificação de idade e documento (ID) que o Roblox pede para jogos que desenham a tela como o nosso.

---

## Antes de começar

- **Conta no Roblox**, com **13 anos ou mais** e **verificação de idade/ID** feita. Sem isso, o jogo funciona no
  Studio, mas o Roblox não deixa a tela do jogo aparecer no jogo publicado. A verificação fica em
  roblox.com → Configurações (engrenagem) → Informações da conta → **Verificar minha idade**.
- **Computador Windows ou Mac** com o **Roblox Studio** (grátis): baixe em **create.roblox.com** → "Começar a criar".

---

## Passo 1 · Baixar os arquivos do jogo

1. Abra a página do projeto no GitHub e clique em **Releases** (à direita).
2. Procure a versão mais nova chamada **"Da Roça no Roblox (build N)"**.
3. Baixe os dois arquivos:
   - **DaRocaAdventure.rbxlx**: o lugar do Roblox com o jogo inteiro dentro (cerca de 20 MB);
   - **DaRoca-sons-do-roblox.zip**: os 5 sons base do jogo.

## Passo 2 · Abrir no Roblox Studio

1. Abra o Roblox Studio e entre com a sua conta.
2. Menu **File (Arquivo) → Open from File… (Abrir do arquivo)** e escolha o **DaRocaAdventure.rbxlx**.
3. Espere carregar. Na primeira vez demora um pouco, porque o jogo é grande.

No painel **Explorer** (Exibir → Explorer) você vai ver:

| Onde | O que é |
| --- | --- |
| ReplicatedStorage › DaRoca › runtime | O "navegador" que roda o jogo dentro do Roblox |
| ReplicatedStorage › DaRoca › jogo | O jogo convertido (cenários, personagens, chefes, cutscenes, menus) |
| ServerScriptService › DaRocaServidor | Guarda o save de cada jogador |
| StarterPlayer › StarterPlayerScripts › DaRocaCliente | Mostra a tela do jogo e lê teclado, toque e controle |

**Não mexa nesses scripts.** Se mudar algo, o jogo pode quebrar.

## Passo 3 · Ligar as permissões do jogo

1. Aba **Home (Início) → Game Settings (Configurações do jogo)**. Se o botão estiver cinza, publique primeiro
   (Passo 5) e volte aqui.
2. Em **Security (Segurança)**, ligue:
   - **Allow Mesh / Image APIs**: obrigatório; é o que deixa o jogo desenhar a tela;
   - **Enable Studio Access to API Services**: para o save funcionar quando você testar no Studio.
3. Clique em **Save (Salvar)**.

## Passo 4 · Testar no Studio

1. Aperte **Play (F5)**.
2. Aparece "Carregando o Da Roça…" e, em seguida, a tela inicial do jogo.
3. Antes de jogar aparece o **guia de controles do seu aparelho**: teclado no PC, Xbox ou PlayStation. Para ver de
   novo: **F1** no PC, botão **View/Share** no controle ou o **?** no canto.
4. Para sair do teste, aperte **Stop (Shift+F5)**.

**Celular:** no Studio, use o botão **Device (Dispositivo)** para simular um celular e testar os botões de toque.

**Controle:** ligue um controle de Xbox ou PlayStation no computador antes de apertar Play.

## Passo 5 · Publicar

1. **File (Arquivo) → Publish to Roblox (Publicar no Roblox)**.
2. Escolha **Create new experience (Criar nova experiência)** e preencha:
   - nome: **Da Roça Adventure**;
   - descrição;
   - gênero: Aventura.
3. Clique em **Create (Criar)**.
4. Volte ao **Passo 3** e confira se as duas opções de segurança continuam ligadas.

## Passo 6 · Colocar o som

Sem este passo o jogo funciona, mas fica mudo.

1. Descompacte o **DaRoca-sons-do-roblox.zip**. Dentro da pasta `audio` estão 5 arquivos `.ogg`.
2. No Studio: **View (Exibir) → Asset Manager (Gerenciador de recursos)**, clique no ícone de importar
   (**Bulk Import**) e escolha os 5 arquivos.
3. Espere o Roblox aprovar os sons. Pode levar alguns minutos, e o Roblox pode pedir a verificação da conta para
   enviar áudio.
4. No Asset Manager, clique com o botão direito em cada som → **Copy Asset ID (Copiar ID)**.
5. No Explorer, abra **ReplicatedStorage › DaRoca › runtime › sons** (clique duas vezes) e cole cada ID entre as
   aspas, no formato `"rbxassetid://NÚMERO"`:

   ```lua
   sine = "rbxassetid://111",      -- onda_seno.ogg
   square = "rbxassetid://222",    -- onda_quadrada.ogg
   sawtooth = "rbxassetid://333",  -- onda_serra.ogg
   triangle = "rbxassetid://444",  -- onda_triangulo.ogg
   ruido = "rbxassetid://555",     -- onda_ruido.ogg
   ```

6. **File → Publish to Roblox** de novo, para salvar.

As músicas em MP3 da pasta `dist/musicas` não vêm junto. Se quiser, envie cada uma pelo Asset Manager e ligue pelo
nome no mesmo arquivo `sons`, em `musicas`. Só envie músicas que são suas ou que você tem direito de usar.

## Passo 7 · Deixar o jogo aberto para todo mundo

1. Entre em **create.roblox.com → Creations (Criações)** e clique no **Da Roça Adventure**.
2. Responda o **questionário de maturidade** (Maturity & Compliance) com sinceridade. O jogo tem personagem que
   fuma (Dedé Fumacinha) e um personagem bêbado no baile.
3. Em **Configure → Settings/Privacy**, mude para **Public (Público)**.
4. Pronto: procure "Da Roça Adventure" no aplicativo do Roblox, no celular, no PC ou no Xbox.

---

## Quando o jogo for atualizado

1. Baixe o **DaRocaAdventure.rbxlx** mais novo em Releases.
2. Abra no Studio.
3. Faça os passos do som de novo (cole os mesmos IDs no `sons`). Os sons enviados continuam na sua conta.
4. **File → Publish to Roblox As… (Publicar como…)** e escolha o **Da Roça Adventure que já existe**, para
   substituir a versão antiga.

O save dos jogadores continua, porque fica guardado na experiência e não no arquivo.

Se você já usa o **Rojo**: rode `rojo serve` dentro da pasta `roblox` do projeto e clique em **Connect** no plugin
do Rojo. Os arquivos entram direto no Studio aberto.

---

## Controles

| Ação | PC | Xbox | PlayStation |
| --- | --- | --- | --- |
| Andar | A / D ou ← → | Alavanca esquerda ou setas | Alavanca esquerda ou setas |
| Pular | Espaço | A | ✕ |
| Jogar papel | J | X | □ |
| Peidão | K | B | ○ |
| Dash | L ou Shift | RB | R1 |
| Falar, entrar e pegar | E ou Enter | Y | △ |
| Chamar o Reeis | R | LB | L1 |
| Bivolt | B | RT | R2 |
| Provocar | T | LT | L2 |
| Carro a gás | V | Apertar a alavanca (L3) | Apertar a alavanca (L3) |
| Pausa e menu | Esc | Menu | Options |
| Ver o guia de novo | F1 | View | Share |

No celular, aparecem os botões de toque do próprio jogo.

A **qualidade gráfica do Roblox** (menu do Roblox → Configurações → Qualidade gráfica) vira a do jogo:

- 1 a 3 → **BAIXA**;
- 4 a 7 → **MÉDIA**;
- 8 a 10 → **ALTA**;
- Automático → **AUTOMÁTICA**.

---

## Problemas comuns

| O que acontece | O que fazer |
| --- | --- |
| Tela preta no jogo publicado (no Studio funciona) | Ligue **Allow Mesh / Image APIs** (Passo 3) e confira se a conta dona do jogo tem 13+ e ID verificado. |
| O jogo fica lento | Diminua a qualidade gráfica do Roblox para 1 a 3 (qualidade BAIXA do jogo). |
| Sem som | Confira os 5 IDs no `sons` (Passo 6). Sons recém-enviados podem levar alguns minutos para tocar. |
| O save não volta no Studio | Ligue **Enable Studio Access to API Services**. No jogo publicado o save funciona sozinho. |
| Aparece erro em vermelho na janela **Output** | Copie o texto do Output (Exibir → Output) e me mande; eu corrijo. |
| O Roblox barrou o jogo | Por causa do Dedé fumando ou do Ollyan bêbado. Me peça a versão do Roblox com esses trechos suavizados. |

## O que fica diferente do navegador

- O **modo online** (Arena online) não funciona dentro do Roblox; a campanha é para um jogador.
- A qualidade **ALTA** usa WebGL no navegador; no Roblox ela fica igual à MÉDIA.
- **Janelas que não foram fotografadas:** a interface do Roblox é redesenhada a partir de fotos das telas do jogo.
  Se aparecer uma janela que não estava nas fotos, ela vem num painel simples no estilo do jogo, com o mesmo texto e
  os mesmos botões funcionando.
