const { chromium, devices, abrir, comecarC1 } = require('./comum');
(async () => { const b = await chromium.launch();
 const { p, errs } = await abrir(b, devices['iPhone 13 landscape'], { init: () => { try { localStorage.setItem('daroca-graphics-v1', 'high'); } catch (e) {} } });
 await comecarC1(p); await p.evaluate(() => { DayTime.force(13); Weather.set('sol'); __go(0, 900); }); await p.waitForTimeout(500);
 const est = () => p.evaluate(() => { const c = document.querySelector('.shader-layer'); return c ? { disp: c.style.display, lost: c.getContext('webgl')?.isContextLost?.() } : 'sem camada'; });
 await p.screenshot({ path: 'pd-0.jpg', type: 'jpeg', quality: 60 }); console.log('antes', await est());
 for (let i = 1; i <= 3; i++) {
  await p.evaluate(() => { const c = document.querySelector('.shader-layer'); const ext = c.getContext('webgl').getExtension('WEBGL_lose_context'); window.__e = ext; ext.loseContext(); });
  await p.waitForTimeout(300); await p.screenshot({ path: `pd-${i}a.jpg`, type: 'jpeg', quality: 60 }); console.log(i, 'logo depois', await est());
  await p.waitForTimeout(1800); await p.screenshot({ path: `pd-${i}b.jpg`, type: 'jpeg', quality: 60 }); console.log(i, 'depois de 2 s', await est(), 'shader', await p.evaluate(() => Graphics.isShader()));
 }
 console.log('errs', errs); await b.close(); })();
