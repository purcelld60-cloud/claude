/* An original, timed cel-shaded epilogue. Every face, prop and camera move is drawn here. */
(() => {
  'use strict';
  const SHOTS=Object.freeze([
    {id:'afterglow',duration:7,title:'DEPOIS DA FESTA',speaker:'Da Roça',text:'Pera… acabou?'},
    {id:'empty',duration:7.5,title:'O SILÊNCIO FICOU',speaker:'Da Roça',text:'Pq eu ainda me sinto vazio?'},
    {id:'vibration',duration:4.5,title:'UMA VIBRAÇÃO NO BOLSO',speaker:'',text:'O celular começa a vibrar.'},
    {id:'reach',duration:5,title:'A LIGAÇÃO',speaker:'',text:'Da Roça tira o celular do bolso.'},
    {id:'caller',duration:5,title:'CHAMADA RECEBIDA',speaker:'',text:'JORGE'},
    {id:'recognition',duration:3.5,title:'ELE CONHECE ESSE NOME',speaker:'Da Roça',text:'JORGE…'},
    {id:'tremor',duration:4,title:'O CORPO NÃO RESPONDE',speaker:'',text:'Os olhos se arregalam. A mão começa a tremer.'},
    {id:'falling',duration:4,title:'A QUEDA',speaker:'',text:'O celular escapa da mão.'},
    {id:'kneeling',duration:5.5,title:'SEM PALAVRAS',speaker:'',text:'Da Roça cai de joelhos no escuro.'},
    {id:'eyes',duration:8,title:'O PRÓXIMO CAPÍTULO',speaker:'',text:'FIM DE JOGO, aguardando nova atualização…'}
  ].map(Object.freeze));
  const TOTAL=SHOTS.reduce((n,s)=>n+s.duration,0);
  const clamp=(v,a=0,b=1)=>Math.max(a,Math.min(b,v));
  const smooth=v=>{v=clamp(v);return v*v*(3-2*v);};
  const lerp=(a,b,p)=>a+(b-a)*p;
  const poly=(c,points,color)=>{c.fillStyle=color;c.beginPath();points.forEach((p,i)=>i?c.lineTo(...p):c.moveTo(...p));c.closePath();c.fill();};
  function stroke(c,points,color,width=2){c.beginPath();points.forEach((p,i)=>i?c.lineTo(...p):c.moveTo(...p));c.strokeStyle=color;c.lineWidth=width;c.lineCap='round';c.lineJoin='round';c.stroke();}
  function ellipse(c,x,y,rx,ry,color){c.fillStyle=color;c.beginPath();c.ellipse(x,y,Math.max(.01,rx),Math.max(.01,ry),0,0,Math.PI*2);c.fill();}
  function text(c,value,x,y,size,color='#f5ebdc',align='left',weight=500){c.font=`${weight} ${size}px Space,Arial,sans-serif`;c.textAlign=align;c.textBaseline='middle';c.fillStyle=color;c.fillText(value,x,y);}
  function tracked(c,value,x,y,size=11,spacing=3,color='#a49bb9'){c.font=`600 ${size}px Space,Arial,sans-serif`;const chars=[...value],width=chars.reduce((n,l)=>n+c.measureText(l).width,0)+(chars.length-1)*spacing;let at=x-width/2;c.fillStyle=color;c.textBaseline='middle';for(const l of chars){c.fillText(l,at,y);at+=c.measureText(l).width+spacing;}}
  function glow(c,x,y,r,color,alpha=.3){c.save();c.globalAlpha*=alpha;const g=c.createRadialGradient(x,y,0,x,y,r);g.addColorStop(0,color);g.addColorStop(1,'#00000000');c.fillStyle=g;c.fillRect(x-r,y-r,r*2,r*2);c.restore();}
  function atmosphere(c,t,amount=24){for(let i=0;i<amount;i++){const x=(i*127.31+Math.sin(t*.17+i)*23+1100)%960,y=(i*79.17-t*(3+i%5)+2200)%540;c.save();c.globalAlpha=.06+(i%4)*.015;ellipse(c,x,y,i%3===0?1.4:.7,i%3===0?1.4:.7,'#d5bdff');c.restore();}}
  function grain(c,t){c.save();c.globalAlpha=.033;const tick=Math.floor(t*12);for(let i=0;i<190;i++){const x=(i*191+tick*7)%960,y=(i*i*17+tick*31)%540;c.fillStyle=i%2?'#d3c2d9':'#050509';c.fillRect(x,y,1+(i%3===0),1);}c.restore();}
  function ground(c,x,y,w=270){c.save();c.translate(x,y);c.scale(1,.2);const g=c.createRadialGradient(0,0,0,0,0,w);g.addColorStop(0,'#75618345');g.addColorStop(.5,'#33264024');g.addColorStop(1,'#00000000');c.fillStyle=g;c.fillRect(-w,-w,w*2,w*2);c.restore();}
  function eye(c,x,y,side,openness=0,pupil=.6,t=0,lookX=0,blink=0){
    const h=Math.max(1.2,lerp(9,29,clamp(openness))*(1-clamp(blink)*.94)),left=x-35,right=x+35;
    poly(c,[[left,y+1],[x-20,y-h*.75],[x+17,y-h],[right,y-2],[x+23,y+h*.62],[x-15,y+h*.72]],'#111016');
    poly(c,[[left+5,y+1],[x-18,y-h*.62],[x+17,y-h*.82],[right-5,y-1],[x+20,y+h*.48],[x-14,y+h*.55]],'#eadfd4');
    if(blink<.9){
      ellipse(c,x+lookX,y+openness,lerp(12,11,openness),Math.min(14,h*.72),'#624a35');
      ellipse(c,x+lookX,y+openness,lerp(5.8,3.8,openness),Math.min(5.8,h*.52),'#151318');
      ellipse(c,x+lookX-3,y-3,2.2,Math.min(2.9,h*.4),'#fff2d9');
    }
    stroke(c,[[left,y+1],[x-18,y-h*.77],[x+17,y-h],[right,y-2]],'#18131a',4);
    const base=y-9-18,outer=base-openness*10,inner=base-openness*27;
    stroke(c,side<0?[[left-2,outer],[x-17,base-6-openness*16],[right-1,inner]]:[[left-2,inner],[x+13,base-6-openness*16],[right-1,outer]],'#251c1d',8);
    if(openness>.7)stroke(c,[[left+4,y+h+7],[x-5,y+h+11],[right-4,y+h+6]],'#8e5a47',1.6);
  }
  function hat(c,t,tilt=0){
    c.save();c.translate(0,-105);c.rotate(tilt);
    ellipse(c,1,0,181,33,'#4c3023');
    ellipse(c,-2,-7,177,31,'#a77d43');
    poly(c,[[-94,-13],[-80,-91],[-57,-107],[58,-108],[91,-87],[105,-8]],'#a67e43');
    poly(c,[[-80,-16],[-68,-86],[-52,-98],[51,-100],[78,-80],[91,-13]],'#d6b56f');
    poly(c,[[-65,-89],[-43,-98],[44,-99],[68,-82],[22,-85]],'#ebcd85');
    poly(c,[[45,-99],[77,-79],[90,-13],[55,-12]],'#b18a4c');
    poly(c,[[-87,-35],[96,-32],[99,-14],[-91,-16]],'#6c422c');
    poly(c,[[-84,-32],[57,-30],[58,-18],[-87,-20]],'#9b5b34');
    ellipse(c,-2,-6,172,24,'#d4b06a');
    poly(c,[[-168,-5],[-84,-17],[45,-17],[169,-1],[102,6],[-69,8]],'#e7c27c');
    stroke(c,[[-165,-3],[-81,-15],[60,-13],[162,0]],'#f6d892',2);
    for(let i=-6;i<7;i++)stroke(c,[[i*22,-16],[i*24,5]],'#a9834c',1);
    for(let i=-3;i<4;i++)stroke(c,[[i*18,-91],[i*22,-39]],'#b99456',1);
    c.restore();
  }
  function face(c,x,y,s,t,o={}){
    c.save();c.translate(x,y+Math.sin(t*1.65)*(o.fear>.5?.5:1.5));c.scale(s,s);c.rotate(o.tilt||0);
    // Broad cel-shaded planes keep the face related to the pixel hero, while the camera can move in close.
    poly(c,[[-80,112],[-72,163],[69,168],[78,111]],'#89523a');
    poly(c,[[-58,116],[-51,159],[24,169],[65,150],[63,107]],'#b87950');
    poly(c,[[-130,155],[-72,135],[-20,172],[29,174],[77,132],[140,161],[177,342],[-174,342]],'#9c4d2e');
    poly(c,[[-128,159],[-82,143],[-23,183],[28,185],[78,143],[132,165],[153,342],[-151,342]],'#ce7540');
    poly(c,[[78,145],[126,163],[150,342],[93,342]],'#713729');
    poly(c,[[-100,155],[-67,174],[-35,230],[-80,210]],'#e59958');
    poly(c,[[-22,180],[-10,342],[14,342],[27,181]],'#965032');
    stroke(c,[[-98,214],[-69,266],[-78,319]],'#9e4c2c',3);
    stroke(c,[[83,217],[63,281],[80,333]],'#ed9a54',2);
    ellipse(c,-102,17,22,37,'#8f563c');ellipse(c,102,18,23,37,'#7e4936');
    ellipse(c,-103,16,12,24,'#bf8055');
    poly(c,[[-102,-87],[-72,-119],[60,-122],[101,-87],[103,50],[73,112],[26,141],[-18,140],[-75,111],[-104,54]],'#714231');
    poly(c,[[-94,-81],[-67,-109],[58,-111],[94,-81],[93,47],[65,105],[23,131],[-16,130],[-68,104],[-95,49]],'#bf8259');
    poly(c,[[-94,-81],[-66,-107],[-17,-110],[-31,40],[-18,128],[-67,103],[-95,49]],'#d39a68');
    poly(c,[[52,-109],[93,-79],[93,48],[65,106],[24,132],[34,54]],'#9b6045');
    poly(c,[[69,-49],[93,-76],[93,48],[66,103],[73,36]],'#704233');
    poly(c,[[-84,58],[-63,97],[-18,122],[-21,106],[-64,71]],'#b3714f');
    poly(c,[[-13,1],[-17,49],[2,59],[24,49],[5,43],[1,0]],'#93583f');
    stroke(c,[[2,3],[6,42],[23,48]],'#dfaa78',2);
    if(o.fear>.6){const quiver=Math.sin(t*31)*.7;ellipse(c,2,97+quiver,17,15,'#342126');stroke(c,[[-20,94+quiver],[-9,86],[10,87],[21,93+quiver]],'#8a5142',2);poly(c,[[-10,86],[12,87],[11,90],[-9,89]],'#d6b295');}
    else{stroke(c,[[-30,97],[0,91],[28,96]],'#744333',2.5);stroke(c,[[-10,103],[7,104]],'#a5684e',1);}
    const blink=o.fear>.4?0:clamp(1-Math.abs(t-3.9)/.18),look=o.fear>.4?0:-2.5;
    eye(c,-48,13,-1,o.fear||0,o.fear>.5?.42:.9,t,look,blink);
    eye(c,47,10,1,o.fear||0,o.fear>.5?.42:.9,t,look,blink);
    // Straw-brim shadow and a thin rim of light replace the flat sprite outline.
    const shade=c.createLinearGradient(0,-80,0,75);shade.addColorStop(0,'#17131bd9');shade.addColorStop(.65,'#19141c44');shade.addColorStop(1,'#17131b00');c.fillStyle=shade;c.fillRect(-98,-88,197,147);
    stroke(c,[[-96,-67],[-97,41],[-67,102]],'#edbd82',2);
    stroke(c,[[94,-58],[94,42],[66,104]],'#a28cbd',1.7);
    if(o.sweat){const p=(t*.28)%1;c.save();c.globalAlpha=.65;poly(c,[[77,31+p*42],[73,42+p*42],[77,47+p*42],[81,42+p*42]],'#c3d8df');c.restore();}
    hat(c,t,o.hatTilt||0);
    c.restore();
  }
  function palm(c,x,y,s=1,rotation=0){c.save();c.translate(x,y);c.rotate(rotation);c.scale(s,s);poly(c,[[-27,-8],[-22,-41],[-9,-45],[-7,-10],[0,-54],[12,-52],[13,-9],[21,-46],[32,-42],[28,2],[35,-25],[46,-18],[35,26],[14,48],[-15,39],[-31,15]],'#6e4438');poly(c,[[-22,-7],[-18,-35],[-12,-37],[-10,1],[4,-47],[9,-46],[9,-2],[24,-39],[28,-36],[23,9],[37,-17],[41,-13],[31,22],[13,40],[-11,33],[-25,12]],'#c38a63');poly(c,[[-17,11],[-6,6],[17,16],[12,35],[-10,29]],'#d7a277');stroke(c,[[-9,14],[8,9],[20,14]],'#a66d50',2);c.restore();}
  function phone(c,x,y,scale,t,o={}){
    c.save();c.translate(x,y);c.rotate(o.angle||0);c.scale(scale,scale);c.transform(1,o.skew||0,o.perspective||0,1,0,0);
    const w=232,h=420;
    if(o.hand)palm(c,-81,121,2,-.18);
    c.save();c.shadowColor='#8163b8';c.shadowBlur=o.glow?28:8;c.fillStyle='#15141e';c.fillRect(-w/2-5,-h/2+8,w+12,h+4);c.restore();
    poly(c,[[-w/2,-h/2],[w/2,-h/2],[w/2+7,-h/2+9],[w/2+7,h/2+5],[-w/2,h/2]],'#5e5d71');
    c.fillStyle='#252330';c.fillRect(-w/2,-h/2,w,h);
    const glass=c.createLinearGradient(0,-h/2,0,h/2);glass.addColorStop(0,'#17202d');glass.addColorStop(.55,'#11141e');glass.addColorStop(1,'#080a11');c.fillStyle=glass;c.fillRect(-w/2+6,-h/2+7,w-12,h-14);
    stroke(c,[[-w/2+2,h/2-3],[-w/2+2,-h/2+2],[w/2-2,-h/2+2]],'#bab8c3',1.5);
    c.fillStyle='#080912';c.fillRect(-35,-h/2+10,70,12);ellipse(c,43,-h/2+16,4,4,'#464958');
    text(c,'CHAMADA RECEBIDA',0,-127,11,'#c0c3d4','center',600);
    text(c,o.concealCaller?'…':'JORGE',0,-81,38,'#f5f3ff','center',650);
    text(c,'celular',0,-47,11,'#81889f','center');
    ellipse(c,0,20,47,47,'#252938');ellipse(c,0,8,14,16,'#8991a4');ellipse(c,0,39,26,15,'#8991a4');
    for(const side of [-1,1]){const xx=side*58;ellipse(c,xx,132,24,24,side<0?'#9f4859':'#4a8b74');c.save();c.translate(xx,132);c.rotate(side<0?Math.PI:0);stroke(c,[[-11,-3],[-7,-8],[1,-9],[9,-4]],'#f4efec',4);c.fillStyle='#f4efec';c.fillRect(-14,-3,5,8);c.fillRect(7,-3,5,8);c.restore();text(c,side<0?'Recusar':'Atender',xx,168,10,'#b7becf','center');}
    c.save();c.globalAlpha=.1;poly(c,[[-w/2+7,-h/2+8],[-w/2+78,-h/2+8],[w/2-7,120],[w/2-7,202]],'#a6b7dc');c.restore();
    if(o.hand){poly(c,[[99,55],[122,71],[111,140],[84,158],[72,151],[84,111]],'#b17a58');stroke(c,[[108,71],[95,127],[84,145]],'#dbab7f',3);}
    c.restore();
  }
  function pocket(c,t,p){
    c.save();c.translate(485,278);c.rotate(-.07);c.scale(1.6,1.6);
    poly(c,[[-150,-142],[-48,-163],[88,-137],[157,162],[-153,163]],'#713a2b');
    poly(c,[[-139,-135],[-47,-152],[78,-129],[136,163],[-143,163]],'#c57543');
    poly(c,[[17,-140],[76,-126],[134,163],[45,163]],'#9c4d32');
    stroke(c,[[-99,-111],[-84,23],[-104,139]],'#e3a365',3);stroke(c,[[18,-112],[35,158]],'#76402e',4);
    poly(c,[[-15,-6],[83,-14],[91,81],[-3,90]],'#8c4a32');poly(c,[[-12,0],[79,-8],[84,75],[2,81]],'#af623d');stroke(c,[[-13,-2],[81,-10]],'#e3a468',3);
    const shake=Math.sin(t*51)*2.1+Math.sin(t*29);
    c.save();c.translate(35+shake,12);c.rotate(.16);c.fillStyle='#26232f';c.fillRect(-20,-42,43,60);c.fillStyle='#6f7184';c.fillRect(-17,-39,37,4);c.restore();
    if(p>.05)palm(c,92-p*38,-97+p*103,1.75,-.2-p*.2);
    c.restore();
    for(const side of [-1,1]){const x=525+side*101;stroke(c,[[x,290],[x+side*8,299],[x,311],[x+side*8,322]],'#a8a0bf',2);}
    tracked(c,'brr…  brr…',518,428,13,3,'#b5a9c9');
  }
  function purpleEye(c,x,y,side,t){
    c.save();c.translate(x,y);c.scale(side,1);
    glow(c,0,0,170,'#9455ef',.23);
    poly(c,[[-122,-18],[-61,-40],[10,-22],[112,10],[49,34],[-23,37],[-88,18]],'#4b2480');
    poly(c,[[-113,-14],[-57,-31],[10,-16],[103,9],[47,26],[-19,28],[-83,12]],'#ae6aff');
    poly(c,[[-98,-9],[-50,-22],[9,-9],[86,10],[44,18],[-17,20],[-74,9]],'#d5a6ff');
    ellipse(c,0,2,12,28,'#2b123f');ellipse(c,-2,0,3.5,25,'#09050f');ellipse(c,-7,-10,3,5,'#f0d2ff');
    stroke(c,[[-126,-26],[-66,-51],[6,-32],[117,4]],'#a574ed',4);
    stroke(c,[[-89,22],[-23,44],[53,39],[115,15]],'#6a3498',2);
    for(let i=0;i<5;i++){const phase=(t*.15+i*.21)%1;c.save();c.globalAlpha=(1-phase)*.23;const yy=-32-phase*80,xx=-70+i*39+Math.sin(t+i)*11;ellipse(c,xx,yy,2,3,'#d5a5ff');c.restore();}
    c.restore();
  }
  function drawEnd(c,t=8){
    c.save();c.fillStyle='#030207';c.fillRect(0,0,960,540);
    const eyes=smooth((t-.35)/1.7);c.save();c.globalAlpha=eyes;purpleEye(c,282,199,1,t);purpleEye(c,678,199,-1,t+.7);c.restore();
    const words=smooth((t-1.8)/1.8);c.save();c.globalAlpha=words;text(c,'FIM DE JOGO',480,351,35,'#eee6f7','center',650);text(c,'aguardando nova atualização…',480,393,18,'#aa95bf','center',400);tracked(c,'UM NOVO CAPÍTULO VAI COMEÇAR',480,448,9,3,'#705e82');c.restore();
    grain(c,t);c.restore();
  }
  // Each leg is a connected hip/knee/ankle chain. In the final three-quarter
  // pose the shins fold behind the knees, instead of forming a fixed M shape.
  function trouserLimb(c,a,b,wa,wb,near=false){
    const dx=b[0]-a[0],dy=b[1]-a[1],len=Math.hypot(dx,dy)||1,nx=-dy/len,ny=dx/len;
    const edge=(p,w,side)=>[p[0]+nx*w*side,p[1]+ny*w*side];
    poly(c,[edge(a,wa,1),edge(b,wb,1),edge(b,wb,-1),edge(a,wa,-1)],'#171e2b');
    poly(c,[edge(a,wa-3,1),edge(b,wb-3,1),edge(b,wb-3,-1),edge(a,wa-3,-1)],near?'#435570':'#2e3c52');
    stroke(c,[[a[0]-nx*(wa-5),a[1]-ny*(wa-5)],[lerp(a[0],b[0],.72)-nx*(wb-4),lerp(a[1],b[1],.72)-ny*(wb-4)]],near?'#718096':'#4d5b73',2);
  }
  function kneelingShoe(c,ankle,p,near=false){
    c.save();c.translate(ankle[0],ankle[1]);
    const heel=lerp(10,13,p),toe=lerp(-18,-31,p);
    poly(c,[[toe,-3],[toe+5,-10],[2,-12],[heel,-7],[heel,6],[toe-2,6]],'#151a25');
    poly(c,[[toe+3,-3],[toe+7,-7],[1,-9],[heel-3,-5],[heel-3,2],[toe+1,2]],near?'#a9b8c7':'#738396');
    stroke(c,[[toe,5],[heel-1,5]],near?'#d8d9d8':'#9cabb9',3);
    stroke(c,[[-6,-6],[1,-4],[-7,-2]],'#384354',1.5);
    c.restore();
  }
  function kneel(c,t,p=1){
    const drop=smooth(p),landing=clamp((p-.78)/.22),breath=Math.sin(t*2.1),tremble=Math.sin(t*19)*.45*drop;
    ground(c,475,473,295);glow(c,551,386,150,'#66608e',.055);
    c.save();c.translate(464,467);c.scale(.95,.95);
    ellipse(c,13,7,106,10,'#0b0b1488');
    const farHip=[lerp(-17,-12,drop),lerp(-146,-74,drop)],nearHip=[lerp(17,13,drop),lerp(-145,-68,drop)];
    const farKnee=[lerp(-23,24,drop),lerp(-75,-15,drop)],nearKnee=[lerp(26,57,drop),lerp(-76,-5,drop)];
    const farAnkle=[lerp(-27,-48,drop),lerp(-9,-13,drop)],nearAnkle=[lerp(38,-28,drop),lerp(-7,-3,drop)];
    // Shoes and folded shins are behind the thighs; neither shin crosses the hips.
    kneelingShoe(c,farAnkle,drop);trouserLimb(c,farKnee,farAnkle,13,9);
    kneelingShoe(c,nearAnkle,drop,true);trouserLimb(c,nearKnee,nearAnkle,16,10,true);
    trouserLimb(c,farHip,farKnee,18,15);
    ellipse(c,farKnee[0],farKnee[1],15,13,'#263347');
    poly(c,[[farHip[0]-15,farHip[1]-10],[nearHip[0]+18,nearHip[1]-11],[nearHip[0]+15,nearHip[1]+16],[farHip[0]-12,farHip[1]+14]],'#29364a');
    trouserLimb(c,nearHip,nearKnee,21,18,true);
    ellipse(c,nearKnee[0],nearKnee[1],18,14,'#35465f');
    stroke(c,[[nearKnee[0]-10,nearKnee[1]-8],[nearKnee[0]+3,nearKnee[1]-10],[nearKnee[0]+11,nearKnee[1]-4]],'#8991a2',2);
    stroke(c,[[nearHip[0]+6,nearHip[1]+17],[nearKnee[0]-10,nearKnee[1]-10]],'#263248',2);
    if(landing>.9){ellipse(c,farKnee[0],3,20,3,'#100e1b66');ellipse(c,nearKnee[0],9,22,3,'#100e1b77');}
    // The pelvis actually descends with the legs. Torso and head pivot from it.
    const hipY=(farHip[1]+nearHip[1])/2;
    c.translate(lerp(0,5,drop)+tremble,hipY+34+breath*.7*drop);
    c.rotate(lerp(-.035,.16,drop)+Math.sin(t*1.7)*.008*drop);
    poly(c,[[-44,-141],[-70,-118],[-55,-47],[-21,-30],[34,-32],[63,-54],[72,-117],[44,-143]],'#75412f');
    poly(c,[[-37,-132],[-58,-112],[-47,-52],[-19,-40],[28,-42],[51,-59],[58,-113],[35,-136]],'#c37a42');
    poly(c,[[32,-134],[57,-112],[50,-59],[29,-42],[18,-74]],'#975332');
    poly(c,[[-37,-130],[-13,-119],[-20,-66],[-35,-73],[-45,-108]],'#d58c4e');
    stroke(c,[[-37,-97],[-17,-76],[-23,-46]],'#e7a05a',2);stroke(c,[[21,-103],[11,-57]],'#734329',3);
    stroke(c,[[-32,-58],[-6,-53],[9,-57]],'#8f4e32',2);stroke(c,[[27,-79],[36,-69],[31,-52]],'#b66a3c',2);
    poly(c,[[-64,-113],[-77,-73],[-65,-23],[-48,-24],[-58,-70],[-39,-109]],'#965839');
    poly(c,[[57,-112],[82,-76],[74,-18],[57,-19],[59,-68],[36,-109]],'#9f603f');
    poly(c,[[-65,-28],[-69,-10],[-61,3],[-47,1],[-44,-12],[-48,-29]],'#bc825c');
    poly(c,[[57,-24],[54,-6],[61,8],[74,5],[81,-8],[74,-25]],'#b9805a');
    stroke(c,[[-61,-8],[-58,0],[-54,-1]],'#d9a478',1.4);stroke(c,[[61,-6],[64,3],[69,1]],'#d9a478',1.4);
    poly(c,[[-25,-151],[-24,-129],[-5,-117],[24,-132],[27,-153]],'#82533b');
    // The face bows with the shoulders, still attached beneath the brim.
    poly(c,[[-31,-193],[-34,-169],[-26,-148],[-6,-135],[24,-147],[34,-171],[30,-194]],'#8f5e43');
    poly(c,[[-28,-189],[-27,-165],[-18,-148],[-5,-141],[17,-150],[26,-173],[25,-192]],'#b17a50');
    stroke(c,[[-27,-178],[-23,-160],[-13,-150]],'#d5a373',1.5);
    stroke(c,[[17,-164],[22,-155],[17,-147]],'#674633',1.3);
    c.save();c.translate(0,-124);c.scale(.72,.72);hat(c,t,.13+drop*.025);c.restore();
    c.restore();
  }
  function impactRing(c,x,y,t,at,strength=1){
    const age=t-at;if(age<0||age>1.05)return;const p=age/1.05;
    c.save();c.globalAlpha=(1-p)*.3*strength;c.strokeStyle='#b8a3ca';c.lineWidth=1.3;
    c.beginPath();c.ellipse(x,y,13+p*90,2+p*13,0,0,Math.PI*2);c.stroke();
    for(let i=0;i<7;i++){const a=i*.9;c.globalAlpha=(1-p)*.2*strength;ellipse(c,x+Math.cos(a)*(18+p*62),y-2-Math.sin(p*Math.PI)*(4+i%3),1.2,1,'#bcb0c8');}
    c.restore();
  }
  function draw(c,s){
    if(!c||!s)return;c.save();c.imageSmoothingEnabled=true;c.fillStyle='#020207';c.fillRect(0,0,960,540);
    const shot=SHOTS[clamp(Math.floor(s.index||0),0,SHOTS.length-1)],t=Math.max(0,Number(s.time)||0),p=clamp(t/shot.duration),u=smooth(p),elapsed=Number(s.elapsed)||t;
    if(shot.id==='eyes'){drawEnd(c,t);c.restore();return;}
    glow(c,547,260,330,'#39293f',.2);atmosphere(c,elapsed);
    if(shot.id==='afterglow'){
      const scale=lerp(.9,1.04,u);c.save();c.globalAlpha=smooth(t/1.6);face(c,555,278,scale,t,{tilt:-.025});c.restore();
      c.save();c.globalAlpha=smooth((t-1.1)/1.4);text(c,'Pera… acabou?',67,431,28,'#e9dfd2','left',450);c.restore();
      tracked(c,'DEPOIS DO ÚLTIMO PEDAÇO',244,476,9,2.4,'#7f7187');
    }else if(shot.id==='empty'){
      face(c,536,281,lerp(1.08,1.23,u),t,{tilt:-.018});
      c.save();c.globalAlpha=smooth((t-.5)/1.5);text(c,'Pq eu ainda me sinto vazio?',56,466,26,'#e2d7da','left',450);c.restore();
    }else if(shot.id==='vibration'){
      pocket(c,t,smooth((t-1.9)/1.8));
    }else if(shot.id==='reach'){
      phone(c,lerp(590,486,u),lerp(555,278,u),lerp(.48,.96,u),t,{angle:lerp(.6,-.09,u),skew:lerp(.16,.035,u),perspective:lerp(.1,-.035,u),hand:true,glow:true,concealCaller:true});
      if(t<1.2){c.save();c.globalAlpha=1-smooth(t/1.2);text(c,'brr…',730,420,15,'#93869e','center');c.restore();}
    }else if(shot.id==='caller'){
      glow(c,480,267,330,'#5f407d',.13);phone(c,480+Math.sin(t*45)*1.3,273,lerp(1.05,1.13,u),t,{angle:Math.sin(t*8)*.004,hand:true,glow:true});
    }else if(shot.id==='recognition'){
      c.save();c.translate(Math.sin(t*27)*1.5,Math.cos(t*21)*.9);face(c,492,271,2.32,t,{fear:smooth(t/.5),sweat:true});c.restore();
      if(t<.12){c.save();c.globalAlpha=(1-t/.12)*.5;c.fillStyle='#e9e1ed';c.fillRect(0,0,960,540);c.restore();}
      c.save();c.globalAlpha=smooth((t-.65)/.7);text(c,'JORGE…',791,469,20,'#ac97c3','center',600);c.restore();
    }else if(shot.id==='tremor'){
      const quake=(1+p)*2.2;face(c,478+Math.sin(t*35)*quake,267+Math.cos(t*24)*1.5,1.25,t,{fear:1,sweat:true,tilt:.025,hatTilt:-.025});
      const leave=smooth((t-1.7)/1.7);phone(c,735+leave*87,lerp(326,580,leave),.56,t,{angle:-.1+leave*.9,hand:leave<.25,glow:false});
    }else if(shot.id==='falling'){
      const contact=2.45,impact=clamp(1-Math.abs(t-contact)/.25),shake=Math.sin(t*61)*impact*2;
      c.save();c.translate(shake,Math.cos(t*47)*impact);kneel(c,t,clamp((t-.55)/1.9));c.restore();
      // Accelerating slow-motion descent, then one small bounce on the floor.
      const fall=clamp(t/1.95),drop=fall*fall,bounce=t>1.95?Math.sin(clamp((t-1.95)/.38)*Math.PI)*8:0;
      const y=lerp(120,461,drop)-bounce,spin=lerp(-.2,1.65,smooth(fall)),scale=lerp(.7,.31,drop);
      phone(c,lerp(620,722,smooth(fall)),y,scale,t,{angle:spin,skew:.1*(1-drop),perspective:.1*(1-drop)});
      impactRing(c,725,473,t,1.95,.75);impactRing(c,507,475,t,contact,.9);
    }else if(shot.id==='kneeling'){
      kneel(c,t+4,1);phone(c,722,461,.31,t,{angle:1.65});
      const darkness=smooth((t-2.4)/3.1);c.save();c.globalAlpha=darkness*.95;c.fillStyle='#020207';c.fillRect(0,0,960,540);c.restore();
    }
    // A dark edge and quiet grain make the cuts feel photographic without hiding the face.
    const vignette=c.createRadialGradient(480,270,160,480,270,560);vignette.addColorStop(0,'#00000000');vignette.addColorStop(1,'#000000bd');c.fillStyle=vignette;c.fillRect(0,0,960,540);grain(c,elapsed);
    c.restore();
  }
  function create(options={}){return {kind:'jorge_epilogue',index:0,time:0,elapsed:0,done:false,options:{...options}};}
  function beat(s){const index=clamp(Math.floor(Number(s?.index)||0),0,SHOTS.length-1);return {...SHOTS[index],index,number:index+1,total:SHOTS.length,cinematic:true};}
  function advance(s){if(!s||s.done)return false;if(s.index+1>=SHOTS.length){s.done=true;return false;}s.index++;s.time=0;return true;}
  function update(s,dt){if(!s||s.done)return;dt=clamp(Number(dt)||0,0,.1);s.time+=dt;s.elapsed=(s.elapsed||0)+dt;while(s.time>=SHOTS[s.index].duration&&!s.done){s.time-=SHOTS[s.index].duration;if(s.index+1>=SHOTS.length){s.done=true;s.time=SHOTS[s.index].duration;break;}s.index++;}}
  window.JorgeEpilogue=Object.freeze({create,update,advance,beat,draw,drawEnd,shots:SHOTS.map(s=>({...s})),duration:TOTAL});
})();
