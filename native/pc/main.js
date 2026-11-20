/* Da Roça Adventure para PC (Electron).
   O jogo inteiro (a pasta dist, copiada para "jogo" na hora do build) vai dentro do programa e roda offline.
   Um mini-servidor local, só neste PC (127.0.0.1, porta fixa para os saves ficarem sempre no mesmo lugar),
   entrega os arquivos do jogo para a janela, então tudo funciona igual ao navegador.
   F11 ou Alt+Enter: tela cheia. O online (Arena e Dupla) usa o servidor do servidor.json, como nos apps. */
const { app, BrowserWindow, shell, Menu } = require('electron');
const path = require('path'), fs = require('fs'), http = require('http');

app.commandLine.appendSwitch('autoplay-policy', 'no-user-gesture-required'); // a música do menu toca ao abrir
const PASTA = path.join(__dirname, 'jogo'), PORTA = 47913;
const TIPOS = { '.html': 'text/html; charset=utf-8', '.js': 'text/javascript; charset=utf-8', '.css': 'text/css; charset=utf-8', '.json': 'application/json; charset=utf-8', '.png': 'image/png', '.jpg': 'image/jpeg', '.jpeg': 'image/jpeg', '.svg': 'image/svg+xml', '.ttf': 'font/ttf', '.woff2': 'font/woff2', '.mp3': 'audio/mpeg', '.ogg': 'audio/ogg', '.wav': 'audio/wav', '.mp4': 'video/mp4', '.txt': 'text/plain; charset=utf-8', '.webmanifest': 'application/manifest+json', '.ico': 'image/x-icon' };

if (!app.requestSingleInstanceLock()) app.quit();
let janela = null;

function servidor() {
  return new Promise((ok, falha) => {
    const srv = http.createServer((req, res) => {
      let rel = decodeURIComponent((req.url || '/').split('?')[0]); if (rel === '/' || rel === '') rel = '/index.html';
      const arquivo = path.normalize(path.join(PASTA, rel));
      if (!arquivo.startsWith(PASTA)) { res.writeHead(403); res.end(); return; }
      fs.stat(arquivo, (erro, st) => {
        if (erro || !st.isFile()) { res.writeHead(404, { 'Content-Type': 'text/plain' }); res.end('não encontrado'); return; }
        const tipo = TIPOS[path.extname(arquivo).toLowerCase()] || 'application/octet-stream', faixa = /bytes=(\d*)-(\d*)/.exec(req.headers.range || '');
        if (faixa) { const ini = faixa[1] ? +faixa[1] : 0, fim = faixa[2] ? +faixa[2] : st.size - 1; // músicas: tocar e pular para qualquer ponto
          res.writeHead(206, { 'Content-Type': tipo, 'Content-Range': `bytes ${ini}-${fim}/${st.size}`, 'Accept-Ranges': 'bytes', 'Content-Length': fim - ini + 1 }); fs.createReadStream(arquivo, { start: ini, end: fim }).pipe(res); return; }
        res.writeHead(200, { 'Content-Type': tipo, 'Content-Length': st.size, 'Accept-Ranges': 'bytes', 'Cache-Control': 'no-cache' }); fs.createReadStream(arquivo).pipe(res);
      });
    });
    srv.on('error', falha); srv.listen(PORTA, '127.0.0.1', () => ok(srv));
  });
}

function criarJanela() {
  janela = new BrowserWindow({
    width: 1280, height: 760, minWidth: 960, minHeight: 540, show: false,
    backgroundColor: '#000000', title: 'Da Roça Adventure', autoHideMenuBar: true,
    icon: path.join(PASTA, 'assets', 'app-icon-512.png'),
    webPreferences: { contextIsolation: true, sandbox: true, backgroundThrottling: false, spellcheck: false }
  });
  Menu.setApplicationMenu(null);
  janela.once('ready-to-show', () => janela.show());
  const casa = `http://127.0.0.1:${PORTA}/`;
  // links de fora abrem no navegador do computador
  janela.webContents.setWindowOpenHandler(({ url }) => { if (/^https?:/i.test(url) && !url.startsWith(casa)) shell.openExternal(url); return { action: 'deny' }; });
  janela.webContents.on('will-navigate', (e, url) => { if (!url.startsWith(casa)) { e.preventDefault(); if (/^https?:/i.test(url)) shell.openExternal(url); } });
  // tela cheia: F11 ou Alt+Enter
  janela.webContents.on('before-input-event', (e, tecla) => {
    if (tecla.type !== 'keyDown') return;
    if (tecla.key === 'F11' || (tecla.alt && tecla.key === 'Enter')) { janela.setFullScreen(!janela.isFullScreen()); e.preventDefault(); }
  });
  janela.webContents.setVisualZoomLevelLimits(1, 1);
  janela.loadURL(casa + 'index.html?native=1&pc=1');
}

app.whenReady().then(async () => {
  try { await servidor(); } catch (e) { require('electron').dialog.showErrorBox('Da Roça Adventure', 'Não consegui abrir o jogo: a porta ' + PORTA + ' já está em uso por outro programa.'); app.quit(); return; }
  criarJanela();
  app.on('second-instance', () => { if (janela) { if (janela.isMinimized()) janela.restore(); janela.focus(); } });
});
app.on('window-all-closed', () => app.quit());
