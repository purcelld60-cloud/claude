# Gerar o IPA pelo Codemagic

O Codemagic é outra opção quando os Macs do GitHub Actions estão demorando. O arquivo `codemagic.yaml`, na raiz do repositório, faz o mesmo que o workflow **Gerar IPA** do GitHub:

- gera o IPA **sem assinatura**;
- não usa senha, certificado nem conta da Apple.

O plano gratuito do Codemagic dá cerca de 500 minutos de Mac por mês, e cada IPA leva uns 5 a 10 minutos. Confira o limite atual no site do Codemagic.

## Primeira vez

1. Entre em codemagic.io com a sua conta do GitHub.
2. Em **Set up application**:
   - em **Select repository**, escolha `claude (purcelld60-cloud)`;
   - em **Select project type**, escolha **iOS**.
3. Toque em **Finish: Add application**.
4. Se o Codemagic perguntar entre **Workflow Editor** e **codemagic.yaml**, escolha **codemagic.yaml**. Ele encontra o arquivo sozinho no branch `main`; se não encontrar, toque em **Check for configuration file**.

## Gerar um IPA

1. Na tela do app, toque em **Start new build**.
2. Escolha o branch `main` e o workflow **IPA sem assinatura**, depois toque em **Start new build**.
3. Quando terminar, abra o build e baixe o arquivo `DaRoca-…ipa` em **Artifacts**.

Depois da primeira vez, o Codemagic gera um IPA novo a cada merge no `main`, se o webhook do GitHub estiver ligado (ele costuma ligar sozinho). Para desligar os builds automáticos, apague o bloco `triggering:` do `codemagic.yaml`.

## Instalar no iPhone

O IPA não tem assinatura. Para instalar, use um instalador como TrollStore, AltStore, SideStore, Sideloadly ou ESign, do mesmo jeito que o IPA do GitHub.
