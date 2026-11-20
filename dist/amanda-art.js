/* Pixel art original da Amanda e da Varanda do Cacau. Coordenadas do restaurante em 480 × 270. */
(() => {
  'use strict';
  function rect(c, x, y, w, h, color) {
    c.fillStyle = color;
    c.fillRect(Math.round(x), Math.round(y), w, h);
  }
  // Degraus inteiros também nas diagonais, como nos contornos de um sprite.
  function shape(c, points, color) {
    c.fillStyle = color;
    const ys = points.map(p => p[1]);
    const bottom = Math.max(...ys);
    for (let y = Math.min(...ys); y < bottom; y++) {
      const cuts = [];
      for (let i = 0; i < points.length; i++) {
        const a = points[i], b = points[(i + 1) % points.length], mid = y + .5;
        if ((a[1] > mid) !== (b[1] > mid)) cuts.push(a[0] + (mid - a[1]) * (b[0] - a[0]) / (b[1] - a[1]));
      }
      cuts.sort((a, b) => a - b);
      for (let i = 0; i + 1 < cuts.length; i += 2)
        c.fillRect(Math.round(cuts[i]), y, Math.round(cuts[i + 1]) - Math.round(cuts[i]), 1);
    }
  }
  function oval(c, x, y, rx, ry, color) {
    c.fillStyle = color;
    for (let i = -ry; i <= ry; i++) {
      const w = Math.round(rx * Math.sqrt(1 - (i / ry) ** 2));
      c.fillRect(Math.round(x) - w, Math.round(y) + i, w * 2 + 1, 1);
    }
  }
  const ink = '#2b1c30', hair = '#352234', sheen = '#654052', gold = '#ffc768';
  const spots = [[-9,-24],[-7,-20],[-9,-16],[-5,-13],[-4,-22],[-3,-17],[5,-23],[7,-20],[5,-16],[7,-12]];
  function drawCharacter(c, x, y, o = {}) {
    const t = o.frame || 0, sc = 2 * (o.scale || 1), blink = (t + .5) % 3.7 < .14;
    c.save();
    c.translate(Math.round(x), Math.round(y));
    c.scale(o.facing < 0 ? -sc : sc, sc);
    if (Number.isFinite(o.opacity)) c.globalAlpha *= o.opacity;
    // Pantalona de cintura alta e botinhas ameixa.
    shape(c, [[-7,-17],[6,-17],[8,-2],[2,-2],[0,-11],[-2,-2],[-9,-2]], ink);
    shape(c, [[-6,-16],[-1,-16],[-3,-3],[-7,-3]], '#584055');
    shape(c, [[1,-15],[5,-16],[7,-3],[3,-3]], '#493348');
    rect(c,-7,-9,1,5,'#916074');
    rect(c,-9,-3,7,3,ink); rect(c,2,-3,9,3,ink);
    rect(c,-7,-3,5,1,'#b56c72'); rect(c,5,-3,4,1,'#d78b83');
    c.translate(0, Math.sin(t * 2.2) > .66 ? -1 : 0);
    // Ondas compridas e franja de lado, com luz castanha nas mechas.
    shape(c,[[-13,-15],[-13,-20],[-11,-25],[-12,-30],[-10,-39],[-6,-43],[2,-45],[7,-43],[10,-39],[10,-31],[8,-27],[10,-22],[8,-17],[4,-15]],ink);
    shape(c,[[-12,-18],[-9,-25],[-10,-32],[-8,-39],[-3,-42],[1,-42],[-4,-36],[-5,-29],[-4,-22],[-8,-16]],hair);
    shape(c,[[-11,-19],[-8,-25],[-9,-30],[-7,-35],[-7,-29],[-6,-25],[-9,-18]],sheen);
    // Blusa de gola alta, cinto e casaco de onça com rosetas abertas.
    shape(c,[[-7,-27],[-1,-29],[6,-27],[10,-24],[10,-13],[8,-9],[2,-10],[-1,-12],[-8,-9],[-11,-12],[-11,-21]],ink);
    shape(c,[[-6,-26],[4,-27],[6,-13],[-5,-13]],'#542a45');
    rect(c,-3,-15,8,2,'#261c2b'); rect(c,0,-15,2,2,gold);
    shape(c,[[-8,-26],[-3,-27],[-1,-24],[-3,-18],[-2,-12],[-9,-10],[-10,-13],[-10,-22]],'#c88846');
    shape(c,[[3,-27],[8,-25],[9,-22],[8,-17],[9,-11],[5,-10],[3,-15],[4,-21]],'#dfaa60');
    shape(c,[[-9,-25],[-4,-27],[-2,-25],[-4,-22],[-6,-23],[-6,-21]],'#f1c482');
    shape(c,[[4,-27],[8,-25],[6,-22],[4,-21]],'#f6d394');
    for (const [sx, sy] of spots) {
      rect(c,sx,sy,2,1,'#633a38'); rect(c,sx-1,sy+1,1,1,'#75443a');
      rect(c,sx+1,sy+1,1,1,'#8e543e');
    }
    const gesture = o.talking || (o.seated && Math.sin(t * 1.7) > .45);
    shape(c,gesture ? [[7,-24],[10,-23],[11,-19],[14,-21],[15,-19],[12,-15],[8,-16],[6,-20]] :
      [[7,-24],[10,-23],[11,-18],[10,-14],[7,-15],[7,-19]],'#c18a50');
    rect(c,8,-22,2,1,'#56333a'); rect(c,9,-19,2,1,'#633a38');
    if (gesture) { rect(c,12,-21,3,2,gold); rect(c,13,-23,3,3,'#e6aa90'); }
    else { rect(c,7,-15,4,1,gold); rect(c,7,-14,3,3,'#d69a82'); }
    // Rosto em três quartos, sobrancelha arqueada, delineado e argola dourada.
    rect(c,-1,-31,5,5,'#b97967'); rect(c,0,-28,4,2,'#e9a98c');
    shape(c,[[-6,-38],[-2,-41],[5,-40],[8,-37],[8,-33],[9,-32],[8,-30],[6,-28],[2,-27],[-4,-30],[-6,-33]],'#c88978');
    shape(c,[[-3,-37],[2,-40],[6,-38],[7,-36],[7,-32],[8,-32],[7,-30],[4,-28],[1,-29],[-2,-31]],'#efb498');
    rect(c,5,-33,2,1,'#ffd1ac'); rect(c,1,-31,3,1,'#dc9786');
    shape(c,[[-9,-32],[-10,-37],[-7,-41],[-2,-44],[4,-43],[8,-41],[10,-38],[7,-39],[2,-39],[-1,-36],[-5,-35],[-6,-30],[-8,-27]],hair);
    shape(c,[[-8,-36],[-6,-40],[-1,-42],[4,-42],[0,-41],[-4,-39]],sheen);
    rect(c,-5,-39,3,1,'#98616a'); rect(c,-7,-33,1,4,'#86535f');
    rect(c,0,-36,4,1,'#563343'); rect(c,6,-37,2,1,'#563343');
    rect(c,-1,-35,1,1,ink); rect(c,0,-34,4,1,ink); rect(c,6,-35,2,1,ink);
    if (!blink) {
      rect(c,1,-33,3,1,'#fff0d3'); rect(c,3,-33,1,1,'#675840');
      rect(c,6,-34,2,1,'#f5dfc3'); rect(c,7,-34,1,1,ink);
    }
    rect(c,4,-30,3,1,'#a44964'); if (gesture) rect(c,5,-29,2,1,'#d97a82');
    rect(c,-5,-32,2,2,'#e1a38a'); rect(c,-5,-30,1,3,gold);
    rect(c,-4,-28,2,1,'#ffe49a'); rect(c,-2,-30,1,2,'#d99945');
    c.restore();
  }

  function light(c,x,y,r,color) {
    const g = c.createRadialGradient(x,y,0,x,y,r);
    g.addColorStop(0,color); g.addColorStop(1,'rgba(255,176,91,0)');
    c.fillStyle = g; c.fillRect(x-r,y-r,2*r,2*r);
  }
  function fern(c,x,y,flip) {
    c.save(); c.translate(x,y); c.scale(flip,1);
    for (let j=0; j<9; j++) {
      const dx = (j-4)*5, h = 28 - Math.abs(j-4)*3;
      for (let n=0; n<10; n++) {
        const k=n/10, px=Math.round(dx*k), py=Math.round(-h*Math.sin(k*1.6));
        rect(c,px,py,2,3,'#28433c');
        if(n>2) { rect(c,px-3,py-1,4,2,'#416755'); rect(c,px+1,py-3,4,2,'#628269'); }
      }
    }
    shape(c,[[-10,0],[11,0],[8,15],[-7,15]],'#824352'); rect(c,-11,-1,23,4,'#ca795d');
    rect(c,-6,5,2,7,'#ae6659'); c.restore();
  }
  function city(c) {
    const twilight=c.createLinearGradient(0,18,0,142);
    twilight.addColorStop(0,'#24253e'); twilight.addColorStop(.46,'#564764'); twilight.addColorStop(1,'#e69377');
    c.fillStyle=twilight; c.fillRect(44,0,392,149);
    for(let i=0;i<55;i++) rect(c,53+(i*167)%365,9+(i*37)%84,i%8?1:2,1,i%3?'#ae9db7':'#eee1c5');
    oval(c,329,52,10,10,'#ffdda5'); oval(c,333,49,9,9,'#453c56');
    for(let i=0;i<3;i++) {
      const pts=[[40,150],[40,96+i*9]];
      for(let j=0;j<=20;j++) pts.push([42+j*20,Math.round(88+i*11+Math.sin(j*.88+i)*9+Math.cos(j*1.32)*4)]);
      pts.push([444,150]); shape(c,pts,['#796785','#635778','#4a4867'][i]);
    }
    // Casario ao redor da praça e a torre da igreja.
    for(let i=0;i<24;i++) {
      const x=45+i*17, y=123-(i*13%16), h=22+i*3%9;
      rect(c,x,y,15,h,['#654b58','#82616a','#785660'][i%3]);
      shape(c,[[x-2,y],[x+5,y-6],[x+12,y-6],[x+16,y]],'#453c50');
      for(let k=0;k<2;k++) rect(c,x+3+7*k,y+4,2,3,(i+k)%3?'#efb079':'#49445a');
    }
    rect(c,148,96,10,34,'#b88a80'); rect(c,150,91,6,8,'#ad8080');
    shape(c,[[147,93],[153,82],[160,93]],'#494358'); rect(c,152,79,1,5,'#514858');
    rect(c,151,100,2,5,'#674f61'); rect(c,155,100,1,5,'#674f61');
    for(let i=0;i<18;i++) oval(c,45+i*24,140-i*3%7,15,9,i%3?'#324849':'#3d5150');
  }
  function curtain(c,x,flip) {
    c.save(); c.translate(x,0); c.scale(flip,1);
    shape(c,[[0,0],[94,0],[86,14],[71,31],[46,48],[33,66],[21,77],[30,127],[26,141],[5,142],[0,124]],'#502e46');
    shape(c,[[3,2],[84,2],[67,24],[48,39],[29,62],[18,73],[22,89],[15,104],[17,136],[8,138],[4,104]],'#863f53');
    shape(c,[[19,2],[42,2],[32,22],[17,42],[12,60],[11,53],[15,29]],'#ac565d');
    shape(c,[[60,2],[75,2],[57,24],[38,41],[27,55],[34,39]],'#b86264');
    rect(c,11,73,14,3,'#dda264'); rect(c,18,76,2,9,'#ba804d'); rect(c,17,84,4,4,'#f1b672');
    c.restore();
  }
  let backdrop;
  function makeBackdrop() {
    const cv = document.createElement('canvas'); cv.width=480; cv.height=270;
    const c=cv.getContext('2d'); c.imageSmoothingEnabled=false;
    rect(c,0,0,480,270,'#935b52');
    for(let i=0;i<23;i++) rect(c,0,i*7,480,1,i%2?'#975f55':'#a56a59');
    rect(c,32,0,416,148,'#4c3343'); rect(c,36,0,408,145,'#bf805c');
    city(c);
    // Galeria de madeira com arcos recortados e ferragens de latão.
    for(let j=0;j<3;j++) {
      const x=40+j*133;
      for(let k=0;k<=132;k++) {
        const edge=Math.abs((k-66)/66), y=Math.round(5+edge**3*46);
        rect(c,x+k,0,1,y,'#6a4247'); rect(c,x+k,y,1,3,'#b57857'); rect(c,x+k,y+3,1,1,'#edb77a');
      }
      rect(c,x-2,39,6,104,'#533d46'); rect(c,x,41,2,100,'#b77957');
    }
    rect(c,437,35,5,107,'#61424a'); rect(c,37,139,405,4,'#432f3b');
    rect(c,32,142,416,4,'#ce8b65'); rect(c,33,146,414,2,'#ebaf78');
    curtain(c,35,1); curtain(c,444,-1);
    for(let x=41;x<439;x++) {
      const y=18+Math.round(15*Math.sin((x-41)*Math.PI/198)**2);
      rect(c,x,y,1,1,'#332b3a');
      if((x-48)%23===0) { rect(c,x,y+1,2,3,'#6a4b46'); light(c,x+1,y+5,7,'rgba(255,197,116,.23)'); rect(c,x,y+4,3,3,'#ffe7a3'); }
    }
    for(const x of [12,467]) {
      light(c,x,65,28,'rgba(255,191,121,.48)'); rect(c,x-1,59,3,19,'#70494b');
      rect(c,x-6,76,13,3,'#513945'); shape(c,[[x-8,66],[x-4,57],[x+4,57],[x+8,66]],'#f0b67b');
      rect(c,x-6,66,12,2,'#ffe0a0'); rect(c,x-2,69,4,4,'#c28a61');
    }
    rect(c,0,150,480,47,'#694449'); rect(c,0,149,480,2,'#dfa074');
    for(let x=0;x<480;x+=22) { rect(c,x,152,2,43,'#4e353d'); rect(c,x+3,153,1,40,'#86594e'); }
    rect(c,0,193,480,6,'#48343c'); rect(c,0,199,480,71,'#a16b5a');
    for(let row=0;row<5;row++) for(let col=-1;col<14;col++){
      const x=col*38+(row%2)*19, y=199+row*15;
      shape(c,[[x,y],[x+18,y+7],[x,y+14],[x-18,y+7]],(row+col)%2?'#81565a':'#966366');
    }
    // Banco de couro com costura capitonê.
    rect(c,74,136,332,47,'#372b39'); rect(c,77,133,326,43,'#693749'); rect(c,80,133,320,3,'#c88670');
    for(let x=85;x<397;x+=22){
      shape(c,[[x,140],[x+10,146],[x+20,140],[x+10,149]],'#844654');
      rect(c,x+9,147,2,2,'#c68069');
    }
    rect(c,76,174,328,5,'#a65f5b'); rect(c,79,179,322,10,'#53333d');
    fern(c,32,180,1); fern(c,451,181,-1);
    return cv;
  }
  function glass(c,x,y) {
    shape(c,[[x-4,y-7],[x+5,y-7],[x+4,y],[x+1,y+2],[x-2,y]],'#e1c0a3');
    rect(c,x-3,y-5,6,4,'#bd665d'); rect(c,x-2,y-6,1,4,'#fff0c7');
    rect(c,x,y+2,1,4,'#eacead'); rect(c,x-3,y+6,7,1,'#f3d8b7');
  }
  function dinnerTable(c, course, t) {
    shape(c,[[128,154],[345,154],[373,179],[365,189],[114,189],[106,179]],'#392b38');
    rect(c,137,184,7,43,'#69434b'); rect(c,340,184,7,43,'#69434b');
    shape(c,[[127,152],[345,152],[370,173],[357,189],[332,185],[309,192],[155,192],[134,187],[116,192],[108,173]],'#b36c65');
    shape(c,[[127,152],[345,152],[370,173],[107,173]],'#f0c89e');
    rect(c,111,173,255,3,'#ffdcad');
    shape(c,[[210,152],[253,152],[261,172],[260,191],[218,191],[218,173]],'#47655e');
    rect(c,220,175,2,15,'#99a583'); rect(c,257,175,1,14,'#d8b98c');
    for(let x=225;x<256;x+=7){rect(c,x,184,3,1,'#d5be8e');rect(c,x+1,183,1,3,'#d5be8e');}
    for(const x of [179,295]){
      oval(c,x,163,16,4,'#bb927c'); oval(c,x,162,15,3,'#ffdfb3'); oval(c,x,162,11,2,'#c8b49c');
      rect(c,x-22,157,1,10,'#8a7776'); rect(c,x-24,157,1,3,'#8a7776'); rect(c,x-24,160,3,1,'#8a7776');
      if(course===0){oval(c,x-3,160,6,3,'#b9764e');rect(c,x-5,157,6,2,'#ffe0a0');rect(c,x+4,161,3,1,'#6e7f54');}
      if(course===1){oval(c,x,161,10,3,'#784746');oval(c,x,159,10,3,'#d7784c');rect(c,x-4,158,5,2,'#f4be63');rect(c,x+3,158,3,2,'#6e884b');}
      if(course===2){rect(c,x-5,156,10,6,'#764452');rect(c,x-5,157,10,1,'#e7ae81');rect(c,x-5,155,10,2,'#533342');rect(c,x,153,3,2,'#d87972');}
    }
    glass(c,202,156); glass(c,273,156);
    oval(c,237,160,7,2,'#b67d61'); rect(c,235,145,4,15,'#ffe3b0'); rect(c,238,147,1,12,'#d7a875');
    const flicker=Math.sin(t*4.5)>.25?1:0;
    light(c,237,142,15+flicker,'rgba(255,191,112,.26)'); rect(c,236,139+flicker,2,5-flicker,'#ffbc72'); rect(c,236,142,2,2,'#fff4ba');
    rect(c,250,151,6,7,'#71958a'); rect(c,251,150,3,1,'#b4bb92'); rect(c,252,141,1,10,'#657453');
    rect(c,249,139,6,3,'#c85c72'); rect(c,250,137,4,3,'#f2998a'); rect(c,253,139,2,1,'#f8af92');
  }
  function drawDinner(c,s) {
    if (!backdrop) backdrop=makeBackdrop();
    c.save(); c.scale(2,2); c.imageSmoothingEnabled=false;
    c.drawImage(backdrop,0,0);
    const t=s.time, nervous=s.phase==='breath', speak=s.phase==='choice'||s.phase==='outcome';
    const lift=nervous?Math.round(Math.sin(t*4)):0;
    window.Art.drawCharacter(c,'daroca',170,177+lift,{frame:t,facing:1,scale:1.18,grounded:true,muscular:s.options.trained,talking:s.phase==='reply'});
    window.Art.drawCharacter(c,'amanda',305,175,{frame:t,facing:-1,scale:1.03,talking:speak,seated:true});
    dinnerTable(c,s.course,t);
    if(s.phase==='outcome' && s.score>=2) {
      const y=88+Math.round(Math.sin(t*2)*2);
      shape(c,[[234,y],[237,y],[239,y+2],[241,y],[244,y],[246,y+2],[246,y+5],[239,y+11],[232,y+5],[232,y+2]],'#f5ae9e');
      rect(c,234,y+2,2,1,'#ffe5bf');
    }
    c.restore();
  }
  window.AmandaArt=Object.freeze({drawCharacter,drawDinner});
})();
