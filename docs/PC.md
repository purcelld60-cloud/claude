# Versão para PC (Windows e Linux)

O jogo também sai como programa de computador, feito com **Electron** (o mesmo motor do Chrome). Fica em `native/pc/`.

## Como é gerado
- A cada merge na `main`, o GitHub Actions roda **"Gerar versão de PC"** (`.github/workflows/pc.yml`). Também dá para rodar à mão em Actions › Run workflow.
- Ele copia a pasta `dist` para dentro do programa e monta:
  - **Windows:** `DaRoca-Instalador-<versão>.exe` (instalador com atalho na área de trabalho e no menu Iniciar) e `DaRoca-Portatil-<versão>.exe` (abre direto, sem instalar);
  - **Linux:** `DaRoca-<versão>.AppImage`.
- Tudo é publicado em Releases com a etiqueta `pc-bN`.

## Como funciona por dentro
- `main.js` abre um mini-servidor só neste computador (`127.0.0.1`, porta fixa `47913`). Ele entrega os arquivos do jogo para a janela, então tudo carrega igual ao navegador: cutscenes, músicas e mapas.
- **Saves:** ficam guardados no PC. A porta é fixa para eles estarem sempre no mesmo lugar.
- **Janela:** abre com `?native=1`, então o jogo ocupa a janela inteira e não usa service worker.
- **Tela cheia:** F11 ou Alt+Enter.
- **Música:** a do menu toca ao abrir.
- **Links de fora:** abrem no navegador do computador.
- **Online (Arena e Dupla):** usa o servidor do `servidor.json`, como os apps de celular.

## Avisos para quem instala
- **Windows:** o programa não tem assinatura paga, então o Windows pode mostrar "O Windows protegeu o computador" (SmartScreen). É só clicar em **Mais informações › Executar assim mesmo**.
- **Linux:** dê permissão de execução ao AppImage (`chmod +x DaRoca-*.AppImage`) e abra.

## Testar no seu computador
```
cp -R dist native/pc/jogo
cp dist/assets/app-icon-1024.png native/pc/icone.png
cd native/pc && npm install && npx electron .
```
