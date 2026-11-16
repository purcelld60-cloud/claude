/* Original side activities: Mota's football challenge and Miqueias's English class. */
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
    if(kind==='quiz')return {kind,options,time:0,done:false,success:false,cancelled:false,score:0,correct:0,attempts:0,questionIndex:0,phase:'question',phaseTime:0,cooldown:0,feedback:'',feedbackGood:true,selected:null,questions:QUESTIONS};
    return {kind:'football',options,time:0,done:false,success:false,cancelled:false,score:0,phase:'aim',phaseTime:0,cooldown:.15,aim:.18,aimDirection:1,aimSpeed:.58,power:.05,powerDirection:1,powerSpeed:1.02,keeper:.5,lockedAim:null,lockedKeeper:null,target:null,shot:null,shots:0,totalShots:0,maxShots:5,goals:0,goalArea:{x:548,y:120,w:320,h:205},feedback:'Mota: mira no canto e manda essa bola pra rede!',feedbackGood:true};
  }
  function bounce(s,key,direction,speed,dt){s[key]+=s[direction]*speed*dt;if(s[key]>1){s[key]=2-s[key];s[direction]=-1;}else if(s[key]<0){s[key]=-s[key];s[direction]=1;}}
  function nextShot(s){s.phase='aim';s.phaseTime=0;s.cooldown=.18;s.aim=(.17+s.shots*.21)%1;s.aimDirection=s.shots%2?-1:1;s.power=.05;s.powerDirection=1;s.lockedAim=null;s.lockedKeeper=null;s.shot=null;s.target=null;s.feedback='Mota: mais uma! Três gols e o treino é seu.';}
  function update(s,dt){
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
  function football(c,s){
    rect(c,0,0,960,540,'#77bfe7');rect(c,0,76,960,70,'#cadede');rect(c,0,110,960,430,'#367f44');for(let i=0;i<8;i++)rect(c,0,110+i*54,960,27,i%2?'#388647':'#3c8d49');
    for(let i=0;i<32;i++){const x=i*33-12;rect(c,x,83,20,34,'#25516a');rect(c,x+3,80,14,8,i%3?'#e9d7a7':'#885c43');rect(c,x+4,93,12,16,i%2?'#244875':'#ecefe3');}
    rect(c,70,25,300,44,'#183d4c');rect(c,75,30,290,34,'#265268');text(c,'MOTA · TREINO DE CRAQUE',220,47,14,'#e6f1cd');
    line(c,[[40,302],[920,302],[920,420],[40,420],[40,302]],'#d0e7ad',3);line(c,[[490,305],[490,420]],'#d0e7ad',3);
    const g=s.goalArea;rect(c,g.x-9,g.y-9,g.w+18,g.h+16,'#1c5145');rect(c,g.x,g.y,g.w,g.h,'#49715f');for(let x=g.x;x<=g.x+g.w;x+=23)line(c,[[x,g.y],[x,g.y+g.h]],'#a5c2a275',1);for(let y=g.y;y<=g.y+g.h;y+=20)line(c,[[g.x,y],[g.x+g.w,y]],'#a5c2a275',1);line(c,[[g.x-6,g.y+g.h],[g.x-6,g.y-7],[g.x+g.w+6,g.y-7],[g.x+g.w+6,g.y+g.h]],'#f8f5d9',7);
    const keeper=s.lockedKeeper!==null&&(s.phase==='flight'||s.phase==='result')?s.lockedKeeper:s.keeper,kx=g.x+keeper*g.w;rect(c,kx-20,306,40,7,'#1b493340');actor(c,'mota',kx,315,{frame:s.time,scale:1.18,facing:-1,moving:s.phase==='aim'||s.phase==='power',speed:60});rect(c,kx-31,260,14,11,'#f7f2d2');rect(c,kx+16,260,14,11,'#f7f2d2');
    actor(c,'daroca',193,325,{frame:s.time,muscular:!!s.options.trained,animation:s.phase==='flight'?'paper':'idle',spriteFrame:s.phase==='flight'?3:0,attack:s.phase==='flight',attackType:'paper',attackProgress:.6});
    const aim=s.lockedAim??s.aim,tx=g.x+aim*g.w,ty=g.y+101;const cross=s.phase==='aim'?'#e0efad':'#f8d786';line(c,[[tx-12,ty],[tx+12,ty]],cross,2);line(c,[[tx,ty-12],[tx,ty+12]],cross,2);
    if(s.phase==='flight'||s.phase==='result'){const b=s.shot;if(b)ball(c,b.x,b.y,b.rotation,1.15);}else ball(c,236,319,s.time*.4,1.15);
    text(c,'MIRA: procure o canto livre',160,332,11,'#d5e7b5','left');meter(c,160,348,630,aim,'#7cbb76');rect(c,160+clamp(keeper-.135,0,1)*630,348,Math.min(.27,1-clamp(keeper-.135,0,1))*630,15,'#d08d77');rect(c,160+aim*630-3,342,6,27,'#fff7d2');
    text(c,'FORÇA: acerte no verde',160,385,11,'#d5e7b5','left');meter(c,430,377,360,s.power,'#aa7861',.35,.85);
    text(c,`${s.goals} / 3 GOLS`,805,56,17,'#f7f0bd');text(c,`CHUTE ${Math.min(s.shots+1,s.maxShots)} / ${s.maxShots}`,805,80,11,'#e1e5bf');
    if(s.phase==='result'){text(c,s.shot.goal?'GOLAÇO!':s.shot.blocked?'DEFENDEU!':'PRA FORA!',475,92,34,s.shot.goal?'#fff0a0':'#f4baa1');if(s.shot.goal){const shake=Math.sin(s.phaseTime*35)*4;for(let i=0;i<22;i++){const xx=430+(i*47+s.phaseTime*24)%490,yy=112+(i*31+s.phaseTime*55)%188;rect(c,xx,yy,4,4,['#f4dd87','#c8eb99','#efb5b5'][i%3]);}line(c,[[g.x-6,g.y-7],[g.x+g.w+6,g.y-7+shake]],'#f8f5d9',5);}}
  }
  function quizIcon(c,kind,x,y,t){
    if(kind==='book'){rect(c,x-35,y-32,70,60,'#264c62');rect(c,x-31,y-28,28,52,'#e8ead2');rect(c,x+3,y-28,28,52,'#f5efd3');rect(c,x-2,y-32,4,63,'#7397a0');for(let j=0;j<4;j++){rect(c,x-26,y-18+j*10,18,2,'#a0b3aa');rect(c,x+8,y-18+j*10,18,2,'#a0b3aa');}}
    else if(kind==='goal'){line(c,[[x-39,y+27],[x-39,y-29],[x+39,y-29],[x+39,y+27]],'#eaf2dd',5);for(let i=-25;i<=25;i+=13)line(c,[[x+i,y-25],[x+i,y+25]],'#a0bcb0',1);ball(c,x+Math.sin(t*2)*21,y+4,t,1.4);}
    else if(kind==='friend'){actor(c,'daroca',x-25,y+35,{scale:.85});actor(c,'reeis',x+26,y+35,{scale:.85,facing:-1});rect(c,x-5,y-30,10,10,'#efb0ad');rect(c,x-10,y-34,9,8,'#efb0ad');rect(c,x+2,y-34,9,8,'#efb0ad');}
    else if(kind==='blue'){rect(c,x-31,y-30,62,60,'#487fcb');rect(c,x-24,y-24,17,9,'#80b9ec');}
    else if(window.Art?.drawCake)window.Art.drawCake(c,x,y+22);
  }
  function quiz(c,s){
    if(window.Art?.drawClassroom)window.Art.drawClassroom(c,'miqueias',s.time);else{rect(c,0,0,960,540,'#e5e9dd');rect(c,60,70,840,310,'#8cc1b8');}
    rect(c,0,0,960,540,'#142f294f');rect(c,180,55,600,335,'#204a46');rect(c,188,63,584,319,'#85bcb1');rect(c,193,68,574,309,'#9bcfc2');rect(c,201,76,558,3,'#c5e3d6');line(c,[[215,95],[310,75]],'#d7e9df77',9);line(c,[[232,121],[360,92]],'#d7e9df45',5);
    actor(c,'miqueias',105,360,{frame:s.time,scale:1.1,talking:true});actor(c,'daroca',861,360,{frame:s.time,scale:1.05,muscular:!!s.options.trained});const q=QUESTIONS[s.questionIndex%QUESTIONS.length];text(c,'ENGLISH DO MIQUEIAS',480,98,22,'#174a47');text(c,'How you say…',480,134,13,'#36665c');text(c,q.word+'?',480,171,27,'#fff5d4');quizIcon(c,q.icon,480,240,s.time);
    for(let i=0;i<3;i++){rect(c,423+i*40,333,27,9,i<s.correct?'#f6df93':'#629c91');rect(c,423+i*40,333,27,2,i<s.correct?'#fff1bc':'#b4dacb');}
    if(s.phase==='feedback'){line(c,[[703,285],[715,300],[739,268]],'#fff0a0',6);text(c,'ALLRIGHT!',480,306,18,'#fff2bd');}else if(s.feedback&&!s.feedbackGood){line(c,[[707,274],[732,299]],'#ae655c',5);line(c,[[732,274],[707,299]],'#ae655c',5);}
  }
  function draw(c,s){if(!s)return;c.save();c.imageSmoothingEnabled=false;if(s.kind==='quiz')quiz(c,s);else football(c,s);c.restore();}
  window.Activities={create,update,submit,view,draw,cancel};
})();
