/* Da Roça Adventure — os bichos que o Marco desenha viraram brainrots famosos.
   Desenhados aqui mesmo em pixel art, cada um com uma animação simples e gostosa de ver
   (pulinho com esticar/achatar, rabo abanando, hélice girando, banana abrindo...).
   Só troca a aparência: vida, dano e comportamento dos inimigos continuam os mesmos.
   rabisco 0 → Brr Brr Patapim · rabisco 1 → Lirili Larilà · rabisco 2 → Trippi Troppi
   brainrot → Tralalero Tralalà · sixseven → Tung Tung Tung Sahur (taco "67")
   spindle → Ballerina Cappuccina · wobbler → Bombardiro Crocodilo · pasta → Chimpanzini Bananini */
(() => {
  'use strict';
  if (!window.Art || window.Art.__brainrots) return;
  const original = window.Art.drawMinion;
  let c = null;
  const R = (x, y, w, h, col) => { c.fillStyle = col; c.fillRect(Math.round(x), Math.round(y), Math.max(1, Math.round(w)), Math.max(1, Math.round(h))); };
  const E = (cx, cy, rx, ry, col) => { c.fillStyle = col; for (let y = -ry; y <= ry; y++) { const w = Math.round(rx * Math.sqrt(Math.max(0, 1 - (y / ry) * (y / ry)))); c.fillRect(Math.round(cx - w), Math.round(cy + y), w * 2 + 1, 1); } };
  const EO = (cx, cy, rx, ry, col, borda = '#1c1418') => { E(cx, cy, rx + 1, ry + 1, borda); E(cx, cy, rx, ry, col); }; // elipse com contorno
  const olho = (x, y, bravo, tam = 3) => { R(x - tam, y - tam, tam * 2 + 1, tam * 2 + 1, '#1c1418'); R(x - tam + 1, y - tam + 1, tam * 2 - 1, tam * 2 - 1, '#ffffff'); R(x, y - 1, 2, 3, '#1c1418'); R(x - 1, y - 2, 1, 1, '#ffffff'); if (bravo) R(x - tam, y - tam - 2, tam * 2 + 1, 2, '#1c1418'); };
  const sombra = (w) => { c.globalAlpha = .28; E(0, 1, w, 3, '#0c140c'); c.globalAlpha = 1; };
  const pulinho = (t, vel = 6, alt = 6) => { const f = (t * vel) % 1, h = Math.sin(f * Math.PI) * alt, sq = f < .12 ? (1 - f / .12) * .14 : 0; return { h, sq }; }; // salto com achatar na chegada

  // ---------- Tralalero Tralalà: tubarão azul de tênis, três pernas ----------
  function tralalero(t, bravo) {
    const anda = Math.sin(t * 10), h = Math.abs(Math.sin(t * 10)) * 2; sombra(20);
    for (const [k, px] of [[0, -10], [1, 0], [2, 10]]) { const fase = Math.sin(t * 10 + k * 2.1), py = -2 - Math.max(0, fase) * 3; // pernas com tênis
      R(px - 1, -14 - h, 3, 12 + py + 2, '#e8c8a8'); R(px - 4, py - 3, 9, 5, '#1c1418'); R(px - 3, py - 2, 7, 3, '#f6f6f6'); R(px - 3, py, 7, 1, '#3c6ab8'); R(px + 1, py - 2, 2, 1, '#3c6ab8'); }
    c.save(); c.translate(0, -22 - h); c.rotate(anda * .04);
    const rabo = Math.sin(t * 12) * 5; c.fillStyle = '#1c1418'; c.beginPath(); c.moveTo(-20, -2); c.lineTo(-34, -12 + rabo); c.lineTo(-31, 0); c.lineTo(-34, 11 + rabo); c.closePath(); c.fill(); c.fillStyle = '#5a8cc0'; c.beginPath(); c.moveTo(-20, -1); c.lineTo(-32, -10 + rabo); c.lineTo(-30, 0); c.lineTo(-32, 9 + rabo); c.closePath(); c.fill();
    EO(0, 0, 22, 10, '#6a9ad0'); E(2, 4, 18, 5, '#f2f2f0'); E(-2, -5, 14, 3, '#8ab8e8'); // corpo, barriga e brilho
    c.fillStyle = '#1c1418'; c.beginPath(); c.moveTo(-6, -9); c.lineTo(2, -22); c.lineTo(6, -9); c.fill(); c.fillStyle = '#5a8cc0'; c.beginPath(); c.moveTo(-4, -9); c.lineTo(2, -19); c.lineTo(4, -9); c.fill(); // barbatana
    olho(12, -3, bravo, 2); R(10, 3, 13, 4, '#1c1418'); for (let k = 0; k < 4; k++) R(11 + k * 3, 3, 2, 2, '#ffffff'); R(-8, 0, 1, 4, '#4a7ab0'); R(-5, 0, 1, 4, '#4a7ab0');
    c.restore();
  }
  // ---------- Tung Tung Tung Sahur: tronco de madeira pulando e batendo o taco "67" ----------
  function tungTung(t, bravo) {
    const { h, sq } = pulinho(t, 3.2, 10); sombra(12 - h * .4); c.save(); c.scale(1 + sq, 1 - sq);
    const y0 = -h; R(-11, y0 - 46, 22, 44, '#1c1418'); R(-10, y0 - 45, 20, 42, '#b07a44'); R(-10, y0 - 45, 5, 42, '#c8925a'); R(6, y0 - 45, 4, 42, '#8a5a30'); // tronco
    for (const yy of [-38, -24, -12]) R(-9, y0 + yy, 18, 1, '#8a5a30'); E(0, y0 - 46, 10, 3, '#d8a870'); E(0, y0 - 46, 6, 2, '#b07a44'); // anéis e topo cortado
    olho(-4, y0 - 34, bravo, 3); olho(5, y0 - 34, bravo, 3); R(-5, y0 - 24, 11, 4, '#1c1418'); R(-4, y0 - 23, 9, 2, '#e8433a');
    R(-12, y0 - 4, 5, 4, '#8a5a30'); R(7, y0 - 4, 5, 4, '#8a5a30'); // pezinhos
    const golpe = Math.sin(t * 6.4) > .6 ? -.25 : .55; R(9, y0 - 20, 6, 3, '#8a5a30'); c.save(); c.translate(15, y0 - 18); c.rotate(golpe); // braço segurando o taco do lado de fora
    R(-3, -26, 7, 28, '#1c1418'); R(-2, -25, 5, 26, '#e8d0a0'); R(-2, -25, 5, 4, '#c8a070'); c.font = '5px monospace'; c.fillStyle = '#c43c3a'; c.save(); c.translate(2, -8); c.rotate(-Math.PI / 2); c.fillText('67', 0, 0); c.restore(); c.restore();
    if (Math.sin(t * 6.4) > .9) { c.fillStyle = '#ffe14a'; for (let k = 0; k < 5; k++) R(26 + Math.cos(k) * 6, y0 - 30 + Math.sin(k * 1.3) * 6, 2, 2, '#ffe14a'); }
    c.restore();
  }
  // ---------- Ballerina Cappuccina: cabeça de xícara de cappuccino, rodopiando ----------
  function ballerina(t, bravo) {
    const gira = Math.cos(t * 7), { h } = pulinho(t, 1.6, 4); sombra(10); c.save(); c.translate(0, -h); c.scale(.55 + Math.abs(gira) * .45, 1);
    R(-2, -18, 2, 16, '#f2d0b8'); R(1, -18, 2, 14, '#f2d0b8'); R(-3, -3, 4, 3, '#f29ab8'); R(2, -6, 4, 3, '#f29ab8'); // pernas na ponta
    E(0, -20, 15, 4, '#1c1418'); E(0, -21, 14, 3, '#f8b8d0'); for (let k = -12; k <= 12; k += 4) R(k, -21, 2, 3, '#ffd8e8'); // tutu
    R(-5, -32, 10, 12, '#1c1418'); R(-4, -31, 8, 11, '#f29ab8'); R(-9, -30, 5, 2, '#f2d0b8'); R(4, -30, 5, 2, '#f2d0b8'); // corpinho e braços
    R(-10, -46, 20, 14, '#1c1418'); R(-9, -45, 18, 12, '#f6f2ea'); R(-9, -45, 18, 3, '#e8d8c0'); E(0, -46, 9, 2, '#c8a070'); E(-2, -47, 4, 1, '#f6ead8'); // xícara com espuma
    R(9, -42, 4, 6, '#1c1418'); R(10, -41, 2, 4, '#f6f2ea'); olho(-3, -40, bravo, 2); olho(4, -40, bravo, 2); R(-1, -35, 3, 1, '#c86a8a');
    c.restore(); if (Math.sin(t * 7) > .95) { R(-14, -40 - h, 2, 2, '#ffffff'); R(13, -24 - h, 2, 2, '#ffffff'); }
  }
  // ---------- Bombardiro Crocodilo: crocodilo-avião voando, hélice girando ----------
  function bombardiro(t, bravo) {
    const voo = 26 + Math.sin(t * 3) * 4; sombra(16 - Math.sin(t * 3) * 2);
    c.save(); c.translate(0, -voo); c.rotate(Math.sin(t * 2.2) * .06);
    const bomba = Math.sin(t * 3.4) * 2; R(-1, 6, 2, 4, '#3a3f44'); EO(0 + bomba, 13, 3, 4, '#3a3f44'); R(-1 + bomba, 7, 2, 2, '#c43c3a'); // bomba pendurada
    R(-12, -4, 24, 3, '#1c1418'); R(-11, -3, 22, 1, '#9aa0a6'); R(-6, -10, 12, 3, '#1c1418'); R(-5, -9, 10, 1, '#b8bcc0'); // asas
    EO(0, 0, 20, 6, '#5a9a4a'); E(0, 3, 16, 2, '#c8d890'); for (let k = -14; k <= 10; k += 4) R(k, -6, 2, 2, '#3a7a3a'); // corpo de crocodilo
    R(16, -3, 12, 6, '#1c1418'); R(17, -2, 10, 4, '#5a9a4a'); for (let k = 0; k < 4; k++) R(18 + k * 2, 1, 1, 1, '#ffffff'); olho(13, -5, bravo, 2); // focinho
    R(-24, -3, 6, 3, '#5a9a4a'); R(-26, -8, 3, 9, '#3a7a3a'); // rabo com leme
    const pa = Math.floor(t * 30) % 2; R(28, -1, 2, 2, '#3a3f44'); if (pa) R(29, -8, 2, 16, '#d8dce0'); else R(22, 0, 16, 2, '#d8dce0'); // hélice
    c.restore();
  }
  // ---------- Chimpanzini Bananini: macaquinho dentro da banana que abre e fecha ----------
  function chimpanzini(t, bravo) {
    const { h, sq } = pulinho(t, 1.8, 5), abre = (Math.sin(t * 3) + 1) / 2; sombra(11); c.save(); c.translate(0, -h); c.scale(1 + sq, 1 - sq);
    EO(0, -18, 10, 16, '#f2d24a'); E(-3, -20, 4, 10, '#fff08a'); R(-1, -35, 3, 4, '#5a4a1a'); // banana
    E(0, -22, 7, 8, '#6a4a2a'); E(0, -20, 5, 5, '#e8c8a0'); olho(-2, -23, bravo, 2); olho(3, -23, bravo, 2); R(-2, -17, 5, 1, '#5a3a1a'); R(-9, -22, 3, 4, '#6a4a2a'); R(7, -22, 3, 4, '#6a4a2a'); // macaco
    for (const lado of [-1, 1]) { c.save(); c.translate(lado * 8, -6); c.rotate(lado * (.2 + abre * .9)); R(-3, -24, 6, 22, '#1c1418'); R(-2, -23, 4, 20, '#f2d24a'); R(-2, -23, 4, 3, '#e8b83a'); c.restore(); } // casca abrindo
    R(-6, -2, 4, 3, '#6a4a2a'); R(3, -2, 4, 3, '#6a4a2a'); c.restore();
  }
  // ---------- Brr Brr Patapim: tronco-macaco de pés gigantes, pisando forte ----------
  function patapim(t, bravo) {
    const passo = Math.sin(t * 7); sombra(16);
    for (const [lado, fase] of [[-1, passo], [1, -passo]]) { const py = -Math.max(0, fase) * 5; R(lado * 7 - 9, py - 6, 18, 7, '#1c1418'); R(lado * 7 - 8, py - 5, 16, 5, '#d8a878'); for (let k = 0; k < 4; k++) R(lado * 7 - 8 + k * 4 + (lado > 0 ? 2 : 0), py - 6, 2, 2, '#c08a5a'); if (fase > .95) { c.globalAlpha = .5; E(lado * 12, 0, 5, 2, '#e8dcc0'); c.globalAlpha = 1; } } // pés gigantes
    R(-7, -34, 14, 30, '#1c1418'); R(-6, -33, 12, 28, '#8a5a30'); R(-6, -33, 3, 28, '#a87040'); R(-12, -26, 6, 2, '#8a5a30'); R(6, -24, 7, 2, '#8a5a30'); // tronco e galhos-braço
    E(0, -42, 15, 9, '#2a5a2a'); E(-3, -44, 11, 6, '#3f8a3a'); E(-6, -46, 5, 3, '#5aa84a'); // copa
    E(0, -30, 7, 6, '#e8c8a0'); olho(-3, -32, bravo, 2); olho(3, -32, bravo, 2); E(0, -27, 3, 2, '#c8986a'); R(-1, -27, 1, 1, '#5a3a1a'); R(1, -27, 1, 1, '#5a3a1a'); // carinha de macaco
  }
  // ---------- Lirili Larilà: elefante-cacto de sandália, tromba balançando ----------
  function lirili(t, bravo) {
    const { h, sq } = pulinho(t, 2.2, 4), tromba = Math.sin(t * 5); sombra(12); c.save(); c.translate(0, -h); c.scale(1 + sq, 1 - sq);
    for (const lx of [-6, 4]) { R(lx, -10, 4, 9, '#5a9a4a'); R(lx - 2, -2, 8, 3, '#1c1418'); R(lx - 1, -2, 6, 1, '#a8643a'); R(lx + 1, -4, 2, 2, '#a8643a'); } // pernas de cacto com sandália
    EO(0, -20, 11, 12, '#5aa04a'); for (let k = 0; k < 8; k++) R(-9 + (k * 5) % 18, -28 + Math.floor(k / 4) * 10 + (k % 2) * 3, 1, 2, '#f2f2d0'); // corpo de cacto com espinhos
    EO(4, -36, 10, 8, '#9aa0aa'); E(-4, -38, 5, 6, '#b8bcc8'); olho(7, -38, bravo, 2); // cabeça de elefante e orelha
    for (let k = 0; k < 8; k++) R(12 + Math.sin(k * .5 + tromba) * k * .6 + k * .3, -33 + k * 2.2, 4, 3, k % 2 ? '#8a909a' : '#9aa0aa'); // tromba
    R(-1, -44, 3, 4, '#e86a8a'); c.restore();
  }
  // ---------- Trippi Troppi: camarão com cara de gato, rabo batendo ----------
  function trippi(t, bravo) {
    const { h, sq } = pulinho(t, 2.6, 7), flick = Math.sin(t * 9) * .35; sombra(13); c.save(); c.translate(0, -h); c.scale(1 + sq, 1 - sq);
    for (let k = 0; k < 5; k++) { const a = Math.PI * (.15 + k * .17), x = Math.cos(a) * -12, y = -14 - Math.sin(a) * 10; EO(x, y, 6 - k * .6, 5 - k * .5, k % 2 ? '#f0885a' : '#f8a070'); } // corpo de camarão curvado
    c.save(); c.translate(10, -10); c.rotate(flick); R(0, -2, 8, 4, '#1c1418'); R(0, -1, 7, 2, '#f8a070'); R(6, -4, 3, 8, '#e86a3a'); c.restore(); // rabo batendo
    for (let k = 0; k < 4; k++) R(-6 + k * 4, -6, 1, 5, '#c85a3a'); // perninhas
    EO(-12, -30, 8, 7, '#c8c0b8'); R(-19, -38, 4, 5, '#c8c0b8'); R(-9, -38, 4, 5, '#c8c0b8'); R(-18, -37, 2, 3, '#f2a0b0'); R(-8, -37, 2, 3, '#f2a0b0'); // cabeça de gato
    olho(-15, -31, bravo, 2); olho(-9, -31, bravo, 2); R(-13, -27, 3, 2, '#f2a0b0'); for (const s of [-1, 1]) R(s > 0 ? -5 : -24, -27, 6, 1, '#4a4a4a'); // focinho e bigodes
    c.restore();
  }

  const DESENHOS = { brainrot: tralalero, sixseven: tungTung, spindle: ballerina, wobbler: bombardiro, pasta: chimpanzini };
  const RABISCOS = [patapim, lirili, trippi];
  function desenhar(ctx, x, y, kind = 0, t = 0, o = {}) {
    const design = String(o.design || o.variant || (o.type && o.type !== 'doodle' ? o.type : '') || '');
    let fn = DESENHOS[design]; if (!fn && (design === '' || design === 'ink' || design === 'doodle' || /^\d$/.test(design))) fn = RABISCOS[(Number(kind) || 0) % 3];
    if (!fn) return original.call(window.Art, ctx, x, y, kind, t, o);
    c = ctx; c.save(); c.translate(Math.round(x), Math.round(y)); c.scale(o.facing < 0 ? -1 : 1, 1);
    try { fn(t + (Number(kind) || 0) * .37, !!o.angry); } catch (e) {}
    if (o.hit) { c.globalAlpha *= .6; c.fillStyle = '#fff6e0'; c.fillRect(-26, -58, 52, 60); }
    c.restore(); c = null;
  }
  window.Art.drawMinion = desenhar;
  window.Art.drawBrainrot = (ctx, nome, x, y, t, o = {}) => { const fn = { tralalero, tungTung, ballerina, bombardiro, chimpanzini, patapim, lirili, trippi }[nome]; if (!fn) return; c = ctx; c.save(); c.translate(Math.round(x), Math.round(y)); c.scale(o.facing < 0 ? -1 : 1, 1); try { fn(t, !!o.angry); } catch (e) {} c.restore(); c = null; };
  window.Art.__brainrots = true;
})();
