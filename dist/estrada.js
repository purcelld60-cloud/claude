/* Da Roça Adventure — a viagem na estrada com o carro a gás (Campanha 1).
   Aparece depois do voo no mapa e antes da chegada animada na fase (chegada-carro.js).
   Cena em pixel art com várias camadas andando em velocidades diferentes:
   céu (dia ou noite, conforme a hora do jogo), nuvens, serra, morros com pés de cacau ou prédios
   da cidade, postes com fios, cercas, vaquinha, placa verde com o nome do destino, asfalto com
   faixas, mato na frente e o Da Roça no carro soltando fumacinha de gás. No topo, uma placa de
   madeira mostra "A CAMINHO DE ..." com o carrinho andando na linha da rota.
   API (usada pelo game.js): EstradaViagem.desenhar(ctx, { t, dur, de, para, nomes, time, W, H, carro(c, x, y) }). */
(() => {
  'use strict';
  if (window.EstradaViagem) return;
  const DUR = 2.8;
  const clamp = (v, a, b) => Math.max(a, Math.min(b, v)), ease = (u) => 1 - Math.pow(1 - clamp(u, 0, 1), 3);
  const hash = (n) => { const x = Math.sin(n * 127.1 + 311.7) * 43758.5453; return x - Math.floor(x); };
  const hx = (c) => c[0] === '#' ? [parseInt(c.slice(1, 3), 16), parseInt(c.slice(3, 5), 16), parseInt(c.slice(5, 7), 16)] : c.match(/\d+/g).slice(0, 3).map(Number); // aceita #hex e rgb()
  const mix = (a, b, k) => { const A = hx(a), B = hx(b); return `rgb(${A.map((v, i) => Math.round(v + (B[i] - v) * k)).join(',')})`; };
  const mod = (a, n) => ((a % n) + n) % n;
  const CIDADE = new Set([1, 2, 3, 4, 5, 8, 9, 10, 11]); // destinos dentro da cidade (Itabuna)
  let c = null;
  const R = (x, y, w, h, col) => { c.fillStyle = col; c.fillRect(Math.round(x), Math.round(y), Math.round(w), Math.round(h)); };

  function nuvem(x, y, k, col) { R(x + 8 * k, y, 20 * k, 4 * k, col); R(x, y + 4 * k, 40 * k, 6 * k, col); R(x + 4 * k, y + 10 * k, 30 * k, 3 * k, col); R(x + 24 * k, y - 3 * k, 10 * k, 4 * k, col); }
  function cacau(x, y, noite) { // pé de cacau: tronco e copa redonda com frutos amarelos
    R(x - 2, y - 26, 5, 26, mix('#6a4426', '#241a20', noite)); const v = mix('#3e8a34', '#16302a', noite), v2 = mix('#5aaa44', '#1e3a30', noite);
    R(x - 16, y - 44, 32, 14, v); R(x - 12, y - 52, 24, 8, v); R(x - 20, y - 36, 40, 8, v); R(x - 10, y - 50, 12, 5, v2); R(x - 16, y - 42, 8, 4, v2);
    if (noite < .6) { R(x - 6, y - 24, 3, 5, '#e8b030'); R(x + 4, y - 20, 3, 5, '#d88a28'); }
  }
  function casinha(x, y, cor, noite) { R(x, y - 24, 34, 24, mix(cor, '#2a2440', noite * .7)); R(x - 4, y - 32, 42, 9, mix('#b0482e', '#3a2030', noite * .7)); R(x + 13, y - 14, 8, 14, mix('#6a4426', '#241a20', noite)); R(x + 4, y - 19, 6, 6, noite > .4 ? '#ffd880' : mix('#bfe4ff', '#304060', noite)); R(x + 24, y - 19, 6, 6, noite > .4 ? '#ffd880' : mix('#bfe4ff', '#304060', noite)); }
  function predio(x, y, w, h, i, noite) {
    R(x, y - h, w, h, mix(['#c8b8a0', '#a8b8c8', '#d8c0a8', '#b0a8c0'][i % 4], '#28284a', noite * .8)); R(x, y - h, w, 3, mix('#e8e0d0', '#3a3a5a', noite));
    for (let wy = y - h + 8; wy < y - 8; wy += 11) for (let wx = x + 5; wx < x + w - 6; wx += 9) { const aceso = hash(wx * 7 + wy) > .45; R(wx, wy, 5, 6, noite > .35 ? (aceso ? '#ffd870' : '#2a2a40') : mix('#8ac0e0', '#5a7a90', hash(wx + wy) * .5)); }
  }
  function vaca(x, y, t) { const rabo = Math.round(Math.sin(t * 5) * 2);
    R(x, y - 14, 26, 11, '#f4f2ea'); R(x + 4, y - 12, 7, 5, '#2a2a2a'); R(x + 15, y - 14, 6, 4, '#2a2a2a'); R(x + 24, y - 18, 9, 8, '#f4f2ea'); R(x + 30, y - 14, 4, 4, '#f0b0b0'); R(x + 27, y - 16, 2, 2, '#141018'); R(x + 24, y - 20, 2, 3, '#e8dcc0');
    R(x + 2, y - 3, 3, 4, '#f4f2ea'); R(x + 9, y - 3, 3, 4, '#f4f2ea'); R(x + 16, y - 3, 3, 4, '#f4f2ea'); R(x + 21, y - 3, 3, 4, '#f4f2ea'); R(x - 3, y - 13 + rabo, 3, 8, '#2a2a2a'); }
  function poste(x, y, noite) { R(x, y - 120, 5, 120, mix('#8a7a68', '#3a3440', noite)); R(x - 14, y - 116, 33, 4, mix('#6a5a48', '#2a2430', noite)); R(x - 12, y - 119, 3, 3, '#4a5a68'); R(x + 14, y - 119, 3, 3, '#4a5a68'); if (noite > .4) { c.globalAlpha = .25 * noite; R(x - 30, y - 112, 64, 112, '#ffe8a0'); c.globalAlpha = 1; R(x + 15, y - 112, 6, 4, '#fff0b0'); } }
  function placaVerde(x, y, txt, sub) { // placa de rodovia
    c.font = 'bold 15px Pixel, monospace'; const w = Math.max(150, Math.ceil(c.measureText(txt).width) + 44), h = 52;
    R(x + 12, y - 40, 6, 40, '#5a6068'); R(x + w - 18, y - 40, 6, 40, '#5a6068');
    R(x - 3, y - 40 - h - 3, w + 6, h + 6, '#1a1020'); R(x, y - 40 - h, w, h, '#1f7a46'); R(x + 3, y - 40 - h + 3, w - 6, h - 6, '#f4f4ec'); R(x + 5, y - 40 - h + 5, w - 10, h - 10, '#1f7a46');
    c.fillStyle = '#f4f4ec'; c.textAlign = 'left'; c.textBaseline = 'middle'; c.fillText(txt, x + 14, y - 40 - h + 22); c.font = '10px Pixel, monospace'; c.fillText(sub, x + 14, y - 40 - h + 39);
    R(x + w - 30, y - 40 - h + 16, 14, 4, '#f4f4ec'); R(x + w - 22, y - 40 - h + 12, 4, 12, '#f4f4ec'); R(x + w - 18, y - 40 - h + 14, 3, 8, '#f4f4ec'); // seta
  }

  function desenhar(ctx, o) {
    c = ctx; const W = o.W || 960, H = o.H || 540, t = o.t || 0, dur = o.dur || DUR, u = clamp(t / dur, 0, 1), s = t * 660, time = o.time || t;
    const de = o.de ?? 0, para = o.para ?? 0, nomes = o.nomes || [], urb = CIDADE.has(para) ? ease((u - .15) / .55) : 0, roca = para === 0 || para === 7 ? 1 : 1 - urb;
    let noite = 0; try { noite = clamp(window.DayTime?.state?.()?.night || 0, 0, 1); } catch (e) {} if (para === 11) noite = Math.max(noite, ease(u * 1.3)); // o baile é de noite
    const ROAD = 372, CHAO = 470;
    ctx.save(); ctx.imageSmoothingEnabled = false;
    // céu em faixas (degradê pixelado)
    for (let i = 0; i < 14; i++) R(0, i * 24, W, 24, mix(mix('#6cc0f4', '#d8f2ff', i / 13), mix('#0e1030', '#4a2a5a', i / 13), noite));
    if (noite < .5) { const sx = 760, sy = 82; c.globalAlpha = .25 * (1 - noite * 2); R(sx - 44, sy - 44, 88, 88, '#fff6c0'); c.globalAlpha = 1; R(sx - 22, sy - 22, 44, 44, '#fff2a0'); R(sx - 26, sy - 14, 52, 28, '#fff2a0'); R(sx - 14, sy - 26, 28, 52, '#fff2a0'); R(sx - 16, sy - 16, 20, 10, '#fffbe0'); }
    else { R(770, 70, 30, 30, '#f4f0d8'); R(778, 66, 30, 30, mix('#0e1030', '#4a2a5a', .1)); for (let i = 0; i < 40; i++) if (hash(i) < noite) R(hash(i * 3) * W, hash(i * 7) * 220, 2, 2, Math.floor(time * 3 + i) % 5 ? '#ffffff' : '#ffe8a0'); }
    for (let i = 0; i < 6; i++) nuvem(mod(i * 230 - s * .05 + hash(i) * 180, W + 260) - 130, 40 + hash(i + 9) * 110, 1 + hash(i + 3), mix('#ffffff', '#3a3a5a', noite * .85));
    // serra azulada lá no fundo
    for (let x = 0; x < W; x += 4) { const X = x + s * .08, y = 248 - Math.sin(X * .006) * 34 - Math.sin(X * .017 + 1) * 14; R(x, y, 4, ROAD - y, mix('#8ab8d0', '#22264a', noite)); }
    // prédios da cidade chegando (só nos destinos da cidade)
    if (urb > 0) { c.globalAlpha = urb; for (let i = 0; i < 14; i++) { const bw = 46 + hash(i) * 40, bh = 70 + hash(i + 5) * 110; predio(mod(i * 86 - s * .22, W + 200) - 100, 312, bw, bh, i, noite); } c.globalAlpha = 1; }
    // morros verdes
    for (let x = 0; x < W; x += 4) { const X = x + s * .3, y = 292 - Math.sin(X * .009) * 18 - Math.sin(X * .021 + 2) * 8; R(x, y, 4, ROAD - y, mix('#7ccf50', '#1c3a2c', noite)); R(x, y, 4, 4, mix('#b0e870', '#2a4a34', noite)); }
    // roça: pés de cacau e casinhas
    if (roca > 0) { c.globalAlpha = roca; for (let i = 0; i < 9; i++) { const x = mod(i * 140 - s * .34 + hash(i) * 60, W + 200) - 100; if (hash(i + 20) > .72) casinha(x, 330, ['#f0e0b0', '#c8e0f0', '#f0c8c8'][i % 3], noite); else cacau(x, 334 + hash(i + 4) * 10, noite); } c.globalAlpha = 1; }
    // cerca e vaquinha
    const cerca = mix('#b08858', '#3a3040', noite); R(0, ROAD - 22, W, 3, cerca); R(0, ROAD - 12, W, 3, cerca); for (let x = mod(-s * .6, 40) - 40; x < W; x += 40) R(x, ROAD - 28, 5, 28, cerca);
    if (!urb || urb < .6) { const vx = mod(380 - s * .6, W + 600) - 120; vaca(vx, ROAD - 2, time); }
    for (let i = 0; i < 4; i++) poste(mod(i * 300 + 90 - s * .75, W + 300) - 150, ROAD, noite);
    c.strokeStyle = mix('#3a3a40', '#101018', noite); c.lineWidth = 2; for (const dy of [0, 6]) { c.beginPath(); for (let x = 0; x <= W; x += 8) { const ph = mod(x + s * .75 - 90, 300) / 300, y = ROAD - 115 + dy + Math.sin(ph * Math.PI) * 14; x ? c.lineTo(x, y) : c.moveTo(x, y); } c.stroke(); }
    // placa verde com o destino passando
    const nome = String(nomes[para] || 'Destino').toUpperCase(); const px = W + 60 - (t - .55) * 640 * .78; if (px < W + 40 && px > -360) placaVerde(px, ROAD - 4, nome, 'SIGA EM FRENTE · ' + (1 + Math.round((1 - u) * 4)) + ' KM');
    // asfalto
    R(0, ROAD - 4, W, 5, mix('#d8d0b0', '#4a4450', noite)); R(0, ROAD, W, CHAO - ROAD, mix('#5e6068', '#24242e', noite)); R(0, ROAD + 2, W, 3, mix('#f4f4ec', '#8a8a98', noite)); R(0, CHAO - 6, W, 3, mix('#f4f4ec', '#8a8a98', noite));
    for (let i = 0; i < 40; i++) R(mod(hash(i) * 2000 - s, W + 40) - 20, ROAD + 8 + hash(i + 2) * 52, 3, 2, mix('#6e7078', '#2e2e38', noite)); // pedrinhas no asfalto
    for (let x = mod(-s, 120) - 120; x < W; x += 120) R(x, ROAD + 42, 64, 6, mix('#f2c63a', '#8a7a3a', noite)); // faixa amarela
    // o carro a gás com o Da Roça
    const cx = 300 + ease(u) * 80 + Math.sin(t * 1.7) * 8, buraco = Math.abs(Math.sin(t * 9)) > .97 ? -3 : 0, cy = ROAD + 66 + Math.round(Math.sin(t * 22)) + buraco;
    for (let k = 0; k < 10; k++) { const a = (t * 2.4 + k / 10) % 1, r = 4 + a * 12; c.globalAlpha = (1 - a) * .55; R(cx - 66 - a * 150, cy - 20 - a * 26 - r / 2, r, r, mix('#d8f0ff', '#8a9ab0', noite)); } c.globalAlpha = 1; // fumacinha de gás
    for (let k = 0; k < 4; k++) { const a = (t * 3 + k / 4) % 1; c.globalAlpha = (1 - a) * .7; R(cx - 90 - a * 260, cy - 40 + k * 11, 30 + a * 40, 2, '#ffffff'); } c.globalAlpha = 1; // traços de velocidade
    c.globalAlpha = .3; R(cx - 60, cy - 2, 120, 7, '#141018'); c.globalAlpha = 1;
    ctx.save(); ctx.translate(cx, cy); ctx.scale(1.4, 1.4); ctx.translate(-cx, -cy); try { o.carro?.(ctx, cx, cy); } catch (e) {} ctx.restore(); // carro maior, em destaque
    if (noite > .3) { c.globalAlpha = .22 * noite; c.beginPath(); c.moveTo(cx + 56, cy - 22); c.lineTo(cx + 300, cy - 60); c.lineTo(cx + 300, cy + 14); c.closePath(); c.fillStyle = '#fff0b0'; c.fill(); c.globalAlpha = 1; } // farol
    // mato na frente
    R(0, CHAO, W, H - CHAO, mix('#5cb040', '#183022', noite)); R(0, CHAO, W, 4, mix('#8ad060', '#22402a', noite));
    for (let i = 0; i < 30; i++) { const x = mod(hash(i) * 2400 - s * 1.35, W + 60) - 30, y = CHAO + 10 + hash(i + 7) * 50; R(x, y, 3, 8, mix('#3e8a30', '#10241a', noite)); R(x + 4, y + 2, 3, 6, mix('#3e8a30', '#10241a', noite)); if (hash(i + 11) > .6) R(x + 1, y - 3, 4, 4, ['#ffe14a', '#ff8ab0', '#ffffff'][i % 3]); }
    // faixas de cinema e placa de madeira com o destino e a rota
    R(0, 0, W, 30, '#0c0810'); R(0, H - 30, W, 30, '#0c0810');
    const bw = 380, bx = Math.round(W / 2 - bw / 2), by = 96, entra = ease(t / .4); // no céu, abaixo dos avisos do jogo (embaixo ficam os botões de toque)
    c.save(); c.translate(0, Math.round((1 - entra) * -150));
    R(bx + 40, 30, 4, by - 30, '#3a2414'); R(bx + bw - 44, 30, 4, by - 30, '#3a2414'); // cordas: a placa desce pendurada
        R(bx - 3, by - 3, bw + 6, 66, '#2a1a10'); R(bx, by, bw, 60, '#a8643a'); R(bx, by, bw, 3, '#c88a5a'); R(bx, by + 20, bw, 1, '#8a4e2a'); R(bx, by + 40, bw, 1, '#8a4e2a');
    c.textAlign = 'center'; c.textBaseline = 'middle'; c.fillStyle = '#ffe9b8'; c.font = '10px Pixel, monospace'; c.fillText('A CAMINHO DE', W / 2, by + 12); c.fillStyle = '#fff6dc'; c.font = 'bold 16px Pixel, monospace'; c.fillText(nome, W / 2, by + 30);
    const lx0 = bx + 24, lx1 = bx + bw - 24, ly = by + 48; for (let x = lx0; x < lx1; x += 10) R(x, ly, 6, 2, '#5a3018'); R(lx0 - 4, ly - 3, 8, 8, '#3a6a8a'); R(lx1 - 4, ly - 3, 8, 8, '#e8433a');
    const kx = Math.round(lx0 + (lx1 - lx0) * ease(u)); R(kx - 7, ly - 6, 14, 6, '#5aa0d8'); R(kx - 4, ly - 9, 8, 3, '#5aa0d8'); R(kx - 6, ly, 4, 3, '#141018'); R(kx + 3, ly, 4, 3, '#141018');
    c.restore();
    // escurecer na entrada (vindo do mapa) e na saída (indo para a chegada)
    const fade = t < .35 ? 1 - t / .35 : u > .86 ? (u - .86) / .14 : 0; if (fade > 0) { c.globalAlpha = clamp(fade, 0, 1); R(0, 0, W, H, '#0c0810'); c.globalAlpha = 1; }
    ctx.restore(); c = null; return true;
  }
  window.EstradaViagem = Object.freeze({ desenhar, duracao: DUR });
})();
