/* Modo desenvolvedor. Fica DESLIGADO no site e nos apps normais.
   O IPA de desenvolvedor (workflow "Gerar IPA" com a opção dev) troca o false por true na hora de compilar.
   Para testar no navegador sem mexer aqui, abra o jogo com ?dev no fim do endereço. */
window.DAROCA_DEV = false;
if (/[?&]dev\b/.test(location.search)) window.DAROCA_DEV = true;
