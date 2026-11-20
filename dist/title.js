(() => {
'use strict';const panel=document.getElementById('startScreen'),canvas=document.getElementById('titleCanvas');if(!panel||!canvas)return;const ctx=canvas.getContext('2d');ctx.imageSmoothingEnabled=false;let last=0;function tick(now){if(!panel.hidden&&panel.style.display!=='none'&&!document.hidden&&!window.Campanha2?.aberto?.()&&now-last>40){last=now;ctx.clearRect(0,0,960,540);window.Art?.drawTitleScene?.(ctx,now/1000,960,540);}requestAnimationFrame(tick);}requestAnimationFrame(tick);
})();
