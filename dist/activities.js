/* Campaign activities share one clock, input path and overlay. */
(() => {
  'use strict';
  const clamp=(n,a,b)=>Math.max(a,Math.min(b,n));
  const QUESTIONS=Object.freeze([
    {prompt:'ALLRIGHT! You find the caderno. What is LIVRO in english, é ou não é?',choices:['BOOK','BALL','BEANS'],answer:0,word:'LIVRO',icon:'book'},
    {prompt:'The Mota do the gol! Choose the word GOL, beleza creuza!',choices:['GLASS','GOAL','GAS'],answer:1,word:'GOL',icon:'goal'},
    {prompt:'Da Roça need a amigo. AMIGO is what, concorda ou sem corda?',choices:['FROG','FLOOR','FRIEND'],answer:2,word:'AMIGO',icon:'friend'},
    {prompt:'My classroom is azul! AZUL is what, you is knowing?',choices:['BLUE','BREAD','BROWN'],answer:0,word:'AZUL',icon:'blue'},
    {prompt:'The bolo is very bom! Choose BOLO in english, ALLRIGHT!',choices:['CAPE','CAKE','CABLE'],answer:1,word:'BOLO',icon:'cake'}
  ]);
  function create(kind,options={}) {
    if(kind==='dinner')return window.AmandaDinner.create(options);
    if(kind==='quiz')return {kind,options,time:0,done:false,success:false,cancelled:false,score:0,correct:0,attempts:0,questionIndex:0,phase:'question',phaseTime:0,cooldown:0,feedback:'',feedbackGood:true,selected:null,questions:QUESTIONS};
    return {kind:'football',options,time:0,done:false,success:false,cancelled:false,score:0,phase:'aim',phaseTime:0,cooldown:.15,aim:.18,aimDirection:1,aimSpeed:.58,power:.05,powerDirection:1,powerSpeed:1.02,keeper:.5,lockedAim:null,lockedKeeper:null,target:null,shot:null,shots:0,totalShots:0,maxShots:5,goals:0,goalArea:{x:548,y:120,w:320,h:205},feedback:'Mota: mira no canto e manda essa bola pra rede!',feedbackGood:true};
  }
  function bounce(s,key,direction,speed,dt){s[key]+=s[direction]*speed*dt;if(s[key]>1){s[key]=2-s[key];s[direction]=-1;}else if(s[key]<0){s[key]=-s[key];s[direction]=1;}}
  function nextShot(s){s.phase='aim';s.phaseTime=0;s.cooldown=.18;s.aim=(.17+s.shots*.21)%1;s.aimDirection=s.shots%2?-1:1;s.power=.05;s.powerDirection=1;s.lockedAim=null;s.lockedKeeper=null;s.shot=null;s.target=null;s.feedback='Mota: mais uma! Três gols e o treino é seu.';}
  function update(s,dt){
    if(s?.kind==='dinner')return window.AmandaDinner.update(s,dt);
    if(!s||s.done)return;s.time+=Math.max(0,dt);s.phaseTime+=Math.max(0,dt);s.cooldown=Math.max(0,s.cooldown-dt);
    if(s.kind==='quiz'){
      if(s.phase==='feedback'&&s.phaseTime>=.65){if(s.correct>=3){s.done=true;s.success=true;s.phase='complete';s.feedback='ALLRIGHT! You is aprovado, beleza creuza!';}else{s.questionIndex++;s.phase='question';s.phaseTime=0;s.feedback='';s.selected=null;}}
      return;
    }
    if(s.phase==='aim'||s.phase==='power')s.keeper=.5+Math.sin(s.time*1.55+.45)*.36;
    if(s.phase==='aim')bounce(s,'aim','aimDirection',s.aimSpeed,dt);
    else if(s.phase==='power')bounce(s,'power','powerDirection',s.powerSpeed,dt);
    else if(s.phase==='flight'){
      const u=clamp(s.phaseTime/.82,0,1),ease=1-Math.pow(1-u,1.65);s.shot.x=s.shot.startX+(s.target.x-s.shot.startX)*ease;s.shot.y=s.shot.startY+(s.target.y-s.shot.startY)*ease-Math.sin(u*Math.PI)*(35+s.shot.power*45);s.shot.rotation=u*12;
      if(u>=1){s.phase='result';s.phaseTime=0;s.feedbackGood=s.shot.goal;if(s.shot.goal){s.goals++;s.score+=100+Math.round((1-Math.abs(s.shot.power-.6))*40);s.feedback=['Mota: GOLAÇO! A bola pediu até autógrafo!','Mota: É rede! O gás foi só no chute, hein!','Mota: Tá contratado pro time da resenha!'][Math.min(2,s.goals-1)];}else s.feedback=s.shot.blocked?'Mota: defendi! Espere o goleiro sair do canto.':'Mota: foi parar na roça! Use força dentro da faixa verde.';}
    }else if(s.phase==='result'&&s.phaseTime>=1.05){
      if(s.goals>=3||s.shots>=s.maxShots){s.done=true;s.success=s.goals>=3;s.phase='complete';s.feedback=s.success?'Mota: treino completo! Esse dash agora vai voar.':'Mota: quase! Volte e tente de novo. Craque também erra.';}else nextShot(s);
    }
  }
  function submit(s,value){
    if(s?.kind==='dinner')return window.AmandaDinner.submit(s,value);
    if(!s||s.done||s.cooldown>0)return false;
    if(s.kind==='quiz'){
      if(s.phase!=='question')return false;const answer=Number(value),q=QUESTIONS[s.questionIndex%QUESTIONS.length];if(!Number.isInteger(answer)||answer<0||answer>2)return false;s.attempts++;s.selected=answer;s.cooldown=.25;
      if(answer===q.answer){s.correct++;s.score=s.correct;s.phase='feedback';s.phaseTime=0;s.feedbackGood=true;s.feedback='ALLRIGHT! Your answer is muito certo, beleza creuza!';}
      else{s.feedbackGood=false;s.feedback='Not this, my friend! Try de novo: '+q.prompt;}
      return true;
    }
    if(s.phase==='aim'){s.lockedAim=s.aim;s.phase='power';s.phaseTime=0;s.power=.05;s.powerDirection=1;s.cooldown=.12;s.feedback='Mota: agora acerte a força no verde. O goleiro ainda está se mexendo!';return true;}
    if(s.phase==='power'){
      s.lockedKeeper=s.keeper;s.shots++;s.totalShots=s.shots;const aim=s.lockedAim,goodPower=s.power>=.35&&s.power<=.85,inside=aim>=.04&&aim<=.96,blocked=Math.abs(aim-s.lockedKeeper)<.135;s.target={x:s.goalArea.x+aim*s.goalArea.w,y:s.goalArea.y+105-(s.power-.55)*95};
      if(!goodPower||!inside){s.target.x+=aim<.5?-70:70;s.target.y=s.power>.85?82:345;}
      s.shot={startX:236,startY:319,x:236,y:319,power:s.power,aim,goal:goodPower&&inside&&!blocked,blocked:goodPower&&inside&&blocked,rotation:0};s.phase='flight';s.phaseTime=0;s.cooldown=.85;s.feedback='Mota: vai, vai, vai…';return true;
    }
    return false;
  }
  function view(s){
    if(s?.kind==='dinner')return window.AmandaDinner.view(s);
    if(!s)return {title:'',text:'',scoreLabel:'',actionLabel:'',choices:null};
    if(s.kind==='quiz'){const q=QUESTIONS[s.questionIndex%QUESTIONS.length];return {title:'ENGLISH DO MIQUEIAS',text:s.feedback||q.prompt,scoreLabel:`${s.correct} / 3 acertos · ${s.attempts} respostas`,actionLabel:'',choices:q.choices.map((label,value)=>({label,value,disabled:s.phase!=='question'}))};}
    return {title:'FUTEBOL COM GABRIEL MOTA',text:s.feedback,scoreLabel:`${s.goals} / 3 gols · ${s.shots} / ${s.maxShots} chutes · ${s.score} pontos`,actionLabel:s.phase==='aim'?'MIRAR':s.phase==='power'?'CHUTAR!':s.phase==='complete'?'CONCLUÍDO':'A BOLA ESTÁ NO AR…',choices:null};
  }
  function cancel(s){if(!s||s.done)return;s.done=true;s.success=false;s.cancelled=true;s.phase='cancelled';}
  function rect(c,x,y,w,h,col){c.fillStyle=col;c.fillRect(Math.round(x),Math.round(y),Math.round(w),Math.round(h));}
  function text(c,t,x,y,size=14,col='#f8f0cb',align='center'){c.font=`bold ${size}px monospace`;c.textAlign=align;c.textBaseline='middle';c.fillStyle='#17362b';c.fillText(t,x+1,y+2);c.fillStyle=col;c.fillText(t,x,y);}
  function line(c,points,color='#f5f0cf',width=2){c.strokeStyle=color;c.lineWidth=width;c.beginPath();points.forEach((p,i)=>i?c.lineTo(p[0],p[1]):c.moveTo(p[0],p[1]));c.stroke();}
  function ball(c,x,y,t=0,scale=1){c.save();c.translate(x,y);c.rotate(t);c.scale(scale,scale);rect(c,-7,-5,14,10,'#fcf6db');rect(c,-5,-7,10,14,'#fcf6db');rect(c,-3,-3,6,6,'#2e4241');rect(c,-7,-1,3,3,'#2e4241');rect(c,4,-3,3,3,'#2e4241');rect(c,-1,4,3,3,'#2e4241');c.restore();}
  function actor(c,type,x,y,options={}){if(window.Art?.drawCharacter)window.Art.drawCharacter(c,type,x,y,{frame:0,facing:1,grounded:true,...options});else{rect(c,x-12,y-48,24,48,type==='daroca'?'#e2a04c':'#83a0ba');}}
  function meter(c,x,y,w,value,color,greenStart,greenEnd){rect(c,x-3,y-3,w+6,21,'#18382a');rect(c,x,y,w,15,color);if(greenStart!==undefined)rect(c,x+greenStart*w,y,(greenEnd-greenStart)*w,15,'#b9dd7f');rect(c,x+value*w-3,y-6,6,27,'#fff6cf');rect(c,x+value*w-1,y-3,2,21,'#314b33');}
  // ======== pixel art (1 pixel de arte = 2 pixels da tela) ========
  const P=(c,x,y,w,h,col)=>rect(c,x*2,y*2,w*2,h*2,col);
  const ROUPAS=['#e8433a','#3a6aa8','#f2c94c','#3c8a5a','#c84a8a','#f2f2ee','#e8843a','#2a2a3a'],PELES=['#f0c8a0','#c48a62','#8a5a3c','#5a3a28','#e8b88a'];
  const campos={};
  // estádio do Mota: céu, torres de luz, arquibancada lotada (dois quadros da torcida), placas e gramado listrado
  function campo(quadro){
    if(campos[quadro])return campos[quadro];const PK=window.PixelKit,cv=document.createElement('canvas');cv.width=480;cv.height=270;const c=cv.getContext('2d');c.imageSmoothingEnabled=false;const R=PK.R,h=PK.hash;
    PK.faixas(c,0,0,480,30,['#4a92da','#5aa0e0','#6eb0e8','#86c2ee']);
    for(const x of [10,452]){R(c,x+6,4,4,52,'#5a646e');R(c,x+7,4,1,52,'#8a949e');R(c,x,2,16,8,'#3a444e');for(let k=0;k<4;k++)for(let j=0;j<2;j++)R(c,x+1+k*4,3+j*3,3,2,'#fff6c8');}
    R(c,0,14,480,6,'#5a646e');R(c,0,14,480,1,'#8a949e');for(let x=0;x<480;x+=12)R(c,x,15,1,5,'#3a444e');
    for(let fila=0;fila<4;fila++){const y=20+fila*9;R(c,0,y+7,480,2,'#9aa0a6');R(c,0,y,480,7,fila%2?'#5a6470':'#4a545e');
      for(let k=0;k<70;k++){const x=k*7+(fila%2)*3+Math.round(h(k+fila*70)*2),pula=quadro===1&&(k+fila)%3===0,braco=(k*7+fila)%5===0;if(h(k*3+fila)<.12)continue;PK.pessoa(c,x,y-1,PELES[(k+fila)%5],ROUPAS[(k*3+fila)%8],'#1c1410',pula,braco&&quadro===1);}}
    const placas=[['CACAU DA ROÇA','#c43c3a','#fff2c0'],['ITABUNA','#2c5a9e','#ffffff'],['GÁS DO PAI','#f2c94c','#3a2a0a'],['ESCOLA','#3c8a5a','#ffffff']];
    for(let k=0;k<6;k++){const [txt,f,cor]=placas[k%4],x=k*80;R(c,x,56,79,8,f);R(c,x,56,79,1,'rgba(255,255,255,.35)');R(c,x+79,56,1,8,'#1c1c1c');PK.texto(c,txt,x+40,60,8,cor,'center',null);}
    for(let y=64;y<270;y+=10){const k=Math.floor((y-64)/10);R(c,0,y,480,10,k%2?'#3a8a48':'#348042');}
    for(let i=0;i<2600;i++){const x=h(i*.77)*480,y=64+h(i*1.31)*206;R(c,x,y,1,1,i%3?'#2c7038':'#4a9a54');}
    for(let i=0;i<90;i++){const x=h(i*4.1)*480,y=70+h(i*2.7)*196;R(c,x,y-2,1,2,'#5aaa5a');R(c,x+1,y-1,1,1,'#5aaa5a');}
    // linhas de cal da grande área e a marca do pênalti (giz meio gasto)
    const giz=(x,y,w,hh)=>{for(let xx=0;xx<w;xx++)for(let yy=0;yy<hh;yy++)if(h(x+xx+(y+yy)*7)>.12)R(c,x+xx,y+yy,1,1,'#e8f2d8');};
    giz(20,151,440,1);giz(20,210,440,1);giz(20,151,1,60);giz(459,151,1,60);giz(245,152,1,58);R(c,116,161,3,1,'#e8f2d8');
    return(campos[quadro]=cv);
  }
  let redeCv=null;
  function rede(){if(redeCv)return redeCv;const PK=window.PixelKit;redeCv=document.createElement('canvas');redeCv.width=160;redeCv.height=103;const c=redeCv.getContext('2d');c.imageSmoothingEnabled=false;
    for(let y=0;y<103;y++)for(let x=0;x<160;x++){if((x+y)%6===0||(x-y+600)%6===0)PK.R(c,x,y,1,1,'rgba(235,240,230,.55)');}
    return redeCv;}
  function football(c,s){
    const PK=window.PixelKit;if(!PK){rect(c,0,0,960,540,'#367f44');return;}
    c.drawImage(campo(Math.floor(s.time*2.5)%2),0,0,480,270,0,0,960,540);
    // flashes de foto na arquibancada e bandeirinhas
    for(let k=0;k<4;k++){const ph=(s.time*1.3+k*.37)%1;if(ph<.06)P(c,Math.round(PK.hash(k+Math.floor(s.time*1.3))*470),22+Math.round(PK.hash(k*3+Math.floor(s.time*1.3))*30),2,2,'#ffffff');}
    for(const fx of [60,410]){P(c,fx,24,1,14,'#c8c8c0');for(let y=0;y<6;y++)P(c,fx+1,24+y,8+Math.round(Math.sin(s.time*6+y*.6)*1.5),1,y<3?'#2c5a9e':'#f2c94c');}
    const g=s.goalArea,gx=g.x/2,gy=g.y/2,gw=g.w/2,gh=g.h/2;
    // gol: rede quadriculada em diagonal (treme no golaço), traves brancas com sombra
    const tremendo=s.phase==='result'&&s.shot?.goal?Math.max(0,1-s.phaseTime*1.6):0;
    P(c,gx-2,gy-2,gw+4,gh+3,'rgba(10,30,20,.25)');
    if(tremendo>0){for(let k=0;k<8;k++){const y0=Math.floor(gh*k/8),hh=Math.ceil(gh/8),dx=Math.round(Math.sin(s.phaseTime*30+k)*3*tremendo);c.drawImage(rede(),0,y0,160,hh,(gx+dx)*2,(gy+y0)*2,320,hh*2);}}else c.drawImage(rede(),0,0,160,103,gx*2,gy*2,320,206);
    P(c,gx-4,gy-4,3,gh+4,'#f2f2ee');P(c,gx-2,gy-4,1,gh+4,'#c8c8c0');P(c,gx+gw+1,gy-4,3,gh+4,'#f2f2ee');P(c,gx+gw+3,gy-4,1,gh+4,'#c8c8c0');P(c,gx-4,gy-4,gw+8,3,'#f2f2ee');P(c,gx-4,gy-2,gw+8,1,'#c8c8c0');P(c,gx-3,gy+gh,gw+6,1,'rgba(0,0,0,.25)');
    const keeper=s.lockedKeeper!==null&&(s.phase==='flight'||s.phase==='result')?s.lockedKeeper:s.keeper,kx=g.x+keeper*g.w;rect(c,kx-20,312,40,6,'#1b493355');actor(c,'mota',kx,315,{frame:s.time,scale:1.18,facing:-1,moving:s.phase==='aim'||s.phase==='power',speed:60});P(c,(kx-31)/2,130,7,6,'#f7f2d2');P(c,(kx-31)/2,130,7,1,'#ffffff');P(c,(kx+16)/2,130,7,6,'#f7f2d2');P(c,(kx+16)/2,130,7,1,'#ffffff');
    actor(c,'daroca',193,325,{frame:s.time,muscular:!!s.options.trained,animation:s.phase==='flight'?'paper':'idle',spriteFrame:s.phase==='flight'?3:0,attack:s.phase==='flight',attackType:'paper',attackProgress:.6});
    // mira em pixel (cruz com cantos) e a bola com sombra
    const aim=s.lockedAim??s.aim,tx=Math.round((g.x+aim*g.w)/2),ty=Math.round((g.y+101)/2),cm=s.phase==='aim'?'#e0ff8a':'#ffd24a';
    P(c,tx-6,ty,4,1,cm);P(c,tx+3,ty,4,1,cm);P(c,tx,ty-6,1,4,cm);P(c,tx,ty+3,1,4,cm);for(const [dx,dy] of [[-5,-5],[4,-5],[-5,4],[4,4]]){P(c,tx+dx,ty+dy,2,1,cm);P(c,tx+dx+(dx<0?0:1),ty+dy+(dy<0?0:0),1,2,cm);}
    if(s.phase==='flight'||s.phase==='result'){const b=s.shot;if(b){P(c,Math.round(b.x/2)-4,Math.round(Math.max(b.y,b.startY)/2)+5,8,2,'rgba(0,0,0,.25)');ball(c,b.x,b.y,b.rotation,1.15);}}else{P(c,114,164,8,2,'rgba(0,0,0,.25)');ball(c,236,319,s.time*.4,1.15);}
    // placa do treino e placar eletrônico
    PK.painel(c,20,14,408,44,{u:2,fundo:'#13283a',borda:'#e8d8a0',rebite:'#c8a848'});PK.texto(c,'MOTA · TREINO DE CRAQUE',224,36,16,'#fff2c0');
    PK.painel(c,696,10,248,72,{u:2,fundo:'#0a0a12',borda:'#5a646e',rebite:'#9aa0a6'});PK.texto(c,'GOLS',758,32,16,'#9aa0a6');PK.texto(c,`${s.goals}/3`,758,58,24,'#ffd24a');PK.texto(c,'CHUTE',878,32,16,'#9aa0a6');PK.texto(c,`${Math.min(s.shots+1,s.maxShots)}/${s.maxShots}`,878,58,24,'#7af07a');
    for(let k=0;k<s.maxShots;k++){const feito=k<s.shots;P(c,363+k*5,36,3,3,feito?'#f2f2ee':'#2a2a3a');}
    // medidores em gomos: mira (vermelho = onde o goleiro está) e força (verde = boa)
    PK.painel(c,140,326,680,80,{u:2,fundo:'#14281e',borda:'#a8c878',sombra:true});
    PK.texto(c,'MIRA',158,349,16,'#d5e7b5','left');const kz=[Math.max(0,keeper-.135),Math.min(1,keeper+.135)];PK.barra(c,252,340,548,16,aim,{u:2,gomos:40,ruim:kz,ruimCor:'#c86a5a',vazio:'#3a6a4a',marcador:'#fff7d2'});
    PK.texto(c,'FORÇA',158,385,16,'#d5e7b5','left');PK.barra(c,252,376,548,16,s.power,{u:2,gomos:40,zona:[.35,.85],zonaCor:'#8ad86a',vazio:'#7a4a3a',marcador:'#fff7d2'});
    if(s.phase==='result'&&s.shot){const txt=s.shot.goal?'GOLAÇO!':s.shot.blocked?'DEFENDEU!':'PRA FORA!';PK.contorno(c,txt,480,100,32,s.shot.goal?'#fff0a0':'#f4baa1','#1c1410');
      if(s.shot.goal)for(let i=0;i<26;i++){const xx=430+(i*47+s.phaseTime*24)%490,yy=112+(i*31+s.phaseTime*55)%188;P(c,Math.round(xx/2),Math.round(yy/2),2,2,['#f4dd87','#c8eb99','#efb5b5','#9ad0ff'][i%4]);}}
  }
  // quadro-negro do Miqueias: moldura de madeira, giz meio apagado, bandeja com giz e apagador
  let lousaCv=null;
  function lousa(){if(lousaCv)return lousaCv;const PK=window.PixelKit,R=PK.R,h=PK.hash;lousaCv=document.createElement('canvas');lousaCv.width=304;lousaCv.height=172;const c=lousaCv.getContext('2d');c.imageSmoothingEnabled=false;
    R(c,0,0,304,164,'#5a3a22');for(let x=0;x<304;x+=3)if(h(x*1.7)>.55)R(c,x,1+h(x)*3,2,1,'#7a5232');R(c,0,0,304,1,'#8a5a36');
    R(c,4,4,296,152,'#2a4636');for(let i=0;i<1400;i++)R(c,4+h(i*.91)*295,4+h(i*1.73)*151,1,1,i%3?'#304e3e':'#26402f');
    for(let k=0;k<9;k++){const x=20+h(k*5.1)*250,y=14+h(k*2.3)*120,w=20+h(k)*40;for(let j=0;j<4;j++)for(let xx=0;xx<w;xx+=2)if(h(xx+j*9+k)>.5)R(c,x+xx,y+j*2,2,1,'rgba(200,220,210,.10)');}
    R(c,0,156,304,8,'#7a5232');R(c,0,156,304,1,'#9a7248');R(c,2,164,300,4,'#4a2c18');
    for(const [x,cor] of [[40,'#f2f2ee'],[52,'#f2e27a'],[61,'#f2a8c8'],[250,'#f2f2ee']])R(c,x,153,8,3,cor);R(c,210,151,22,5,'#8a6a4a');R(c,210,154,22,2,'#d8d0c0');
    return lousaCv;}
  // desenhos de giz: traço de pixel meio falhado
  function giz(c,x,y,w,h,cor='rgba(245,248,240,.92)'){const PK=window.PixelKit;for(let xx=0;xx<w;xx++)for(let yy=0;yy<h;yy++)if(PK.hash((x+xx)*3.1+(y+yy)*7.7)>.14)P(c,x+xx,y+yy,1,1,cor);}
  function quizIcon(c,kind,x,y,t){
    x=Math.round(x/2);y=Math.round(y/2);
    if(kind==='book'){giz(c,x-16,y-12,32,1);giz(c,x-16,y+10,32,1);giz(c,x-16,y-12,1,23);giz(c,x+15,y-12,1,23);giz(c,x,y-12,1,23);for(let j=0;j<4;j++){giz(c,x-12,y-7+j*4,9,1,'rgba(245,248,240,.6)');giz(c,x+4,y-7+j*4,9,1,'rgba(245,248,240,.6)');}}
    else if(kind==='goal'){giz(c,x-18,y-12,1,24);giz(c,x+17,y-12,1,24);giz(c,x-18,y-12,36,1);for(let i=-12;i<=12;i+=6)giz(c,x+i,y-10,1,21,'rgba(245,248,240,.45)');ball(c,(x+Math.sin(t*2)*10)*2,(y+4)*2,t,1.2);}
    else if(kind==='friend'){for(const dx of [-10,10]){giz(c,x+dx-2,y-12,5,5);giz(c,x+dx,y-7,1,10);giz(c,x+dx-4,y-4,9,1);giz(c,x+dx-3,y+3,1,6);giz(c,x+dx+3,y+3,1,6);}P(c,x-2,y-14,2,2,'#f2a8c8');P(c,x+1,y-14,2,2,'#f2a8c8');P(c,x-2,y-12,5,2,'#f2a8c8');P(c,x-1,y-10,3,1,'#f2a8c8');}
    else if(kind==='blue'){for(let yy=-11;yy<=11;yy+=2)giz(c,x-14,y+yy,28,1,'rgba(110,160,230,.9)');giz(c,x-14,y-12,28,1);}
    else{giz(c,x-14,y-2,28,1);giz(c,x-14,y+10,28,1);giz(c,x-14,y-2,1,13);giz(c,x+13,y-2,1,13);giz(c,x-10,y-8,20,1);giz(c,x-10,y-8,1,6);giz(c,x+9,y-8,1,6);giz(c,x-14,y+4,28,1,'rgba(242,168,200,.9)');giz(c,x,y-14,1,6,'rgba(242,226,122,.95)');if(Math.sin(t*8)>0)P(c,x,y-16,1,2,'#ffb040');}
  }
  function quiz(c,s){
    const PK=window.PixelKit;
    if(window.Art?.drawClassroom)window.Art.drawClassroom(c,'miqueias',s.time);else rect(c,0,0,960,540,'#e5e9dd');
    rect(c,0,0,960,540,'#142f2940');
    if(!PK){rect(c,180,55,600,335,'#204a46');return;}
    c.drawImage(lousa(),0,0,304,172,176,46,608,344);
    actor(c,'miqueias',105,360,{frame:s.time,scale:1.1,talking:true});actor(c,'daroca',861,360,{frame:s.time,scale:1.05,muscular:!!s.options.trained});
    const q=QUESTIONS[s.questionIndex%QUESTIONS.length];
    PK.texto(c,'ENGLISH DO MIQUEIAS',480,88,16,'#f2f2ea','center','#1a2e24');PK.texto(c,'How you say...',480,124,16,'#b8d8c8','center','#1a2e24');PK.texto(c,q.word+'?',480,162,32,'#f2e27a','center','#1a2e24');
    quizIcon(c,q.icon,480,244,s.time);
    for(let i=0;i<3;i++){const x=228+i*14,y=166,on=i<s.correct;const cor=on?'#f2e27a':'rgba(245,248,240,.35)';P(c,x,y-3,1,7,cor);P(c,x-3,y,7,1,cor);P(c,x-1,y-1,3,3,cor);P(c,x-2,y-2,1,1,cor);P(c,x+2,y-2,1,1,cor);P(c,x-2,y+2,1,1,cor);P(c,x+2,y+2,1,1,cor);}
    if(s.phase==='feedback'){for(let k=0;k<8;k++)P(c,352+k,146+(k<3?k:3-(k-3)*1.6)|0,2,2,'#9aff9a');PK.texto(c,'ALLRIGHT!',480,314,16,'#9aff9a','center','#1a2e24');}
    else if(s.feedback&&!s.feedbackGood){for(let k=0;k<12;k++){P(c,350+k,136+k,2,2,'#ff9a8a');P(c,361-k,136+k,2,2,'#ff9a8a');}}
  }
  function draw(c,s){if(!s)return;if(s.kind==='dinner')return window.AmandaArt.drawDinner(c,s);c.save();c.imageSmoothingEnabled=false;if(s.kind==='quiz')quiz(c,s);else football(c,s);c.restore();}
  window.Activities={create,update,submit,view,draw,cancel};
})();
