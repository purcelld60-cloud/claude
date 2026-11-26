/* Original pixel-film sequences: friendship, a stolen cake and the potato-nose reckoning. */
(() => {
  'use strict';
  const INTRO = Object.freeze([
    {title:'ANTES DO PRIMEIRO FARELO',speaker:'Da Roça',text:'Eu e Nikolas? A gente era unha e carne. Dividia a resenha, a carona… e até o último pedaço de bolo.'},
    {title:'PARCEIROS DE RECREIO',speaker:'Nikolas Arroganti',text:'Se alguém mexer com Da Roça, vai ter que mexer comigo! Amizade de verdade é assim, pô.'},
    {title:'O BOLO QUE MUDOU TUDO',speaker:'Lucas · o Sapo',text:'Fiz um bolo de sapo de chocolate pra Da Roça! Pode olhar, Nikolas. Olhar ainda não engorda.'},
    {title:'UMA FOME MUITO SUSPEITA',speaker:'Nikolas Arroganti',text:'Só um pedacinho… talvez metade… ou o bolo inteiro. Ih, meu estômago já está fazendo campanha.'},
    {title:'UM NARIZ, UMA BATATA, UM PLANO',speaker:'Da Roça',text:'Ô, Nikolas! Para de esfregar essa batata aí. Tá tentando descascar o nariz ou esconder alguma coisa?'},
    {title:'A FOME QUEBROU A AMIZADE',speaker:'Nikolas Arroganti',text:'Foi mal, parceiro… minha fome falou mais alto! Esse bolo agora é meu! Nikolas poudi!'},
    {title:'UM AMIGO A MENOS. UMA MISSÃO A MAIS.',speaker:'Da Roça',text:'Trocou amizade por cobertura?! Lucas, bora consertar o carro do meu pai e buscar esse bolo!'}
  ]);
  const OUTRO = Object.freeze([
    {title:'O BOLO VOLTOU PARA CASA',speaker:'Da Roça',text:'O bolo tá inteiro. Sua pose de chefão, não! Vai colher essa batata do nariz com uma enxada?'},
    {title:'O REI DO CATARRO PERDEU O TRONO',speaker:'Nikolas Arroganti',text:'Pô, Da Roça… eu só queria um pedacinho. E meu nariz não é uma batata! É… aerodinâmico.'},
    {title:'BATATA ASSADA NA RESENHA',speaker:'Da Roça',text:'Aerodinâmico? Quando você espirra, a roça inteira pergunta se já é época de colher! Hahaha, ô batatão!'},
    {title:'UM PEDAÇO DE BOM SENSO',speaker:'Lucas · o Sapo',text:'Tem bolo pra turma toda. Nikolas, pede um pedaço da próxima vez. E lava essa mão que passou o jogo no nariz!'},
    {title:'A AMIZADE AINDA TEM COBERTURA',speaker:'Da Roça',text:'Toma um pedaço, nariz de batata. Amigo pede. Ladrão corre. Na próxima você vai lavar a forma, combinado?'},
    {title:'FIM… OU SÓ O PRIMEIRO PEDAÇO?',speaker:'Reeis',text:'OHHHH REEEEIS! O bolo é nosso! Agora corta logo antes que o batata entre na fase dois da fome!'}
  ]);
  const EXTRA = Object.freeze({
    boss_dede: Object.freeze([
      {title:'MAIS UM CAPANGA NA SUBIDA',speaker:'Dedé',text:'SEU GILÓ HOMI! Sou Dedé. Antes do Freddy, você ainda vai passar pela minha fumaça!'},
      {title:'CADÊ A VISTA DO MORRO?',speaker:'Da Roça',text:'Dedé, teu olho tá mais vermelho que a brasa desse cigarro. Isso é arena ou máquina de neblina?'},
      {title:'O GUARDA DA ÚLTIMA PASSAGEM',speaker:'Dedé',text:'O Reeis mandou segurar a entrada. Eu acendi um... depois outro... e agora o morro todo virou fumaça. Mistério, homi.'},
      {title:'VENTILAÇÃO DA ROÇA',speaker:'Da Roça',text:'Então abre uma janela, porque eu trouxe papel e uma ventilação movida a gás.'}
    ]),
    dede_defeat: Object.freeze([
      {title:'A NEBLINA BAIXOU',speaker:'Dedé',text:'SEU GILÓ HOMI! A fumaça baixou e o chapéu me venceu. Não espalha essa resenha!'},
      {title:'CAMINHO ABERTO PARA O REI',speaker:'Da Roça',text:'Meu papel venceu a névoa. E o bolo continua me esperando.'},
      {title:'NÃO ESPALHA ESSA RESENHA',speaker:'Dedé',text:'Vai lá. Acho que vou largar esse cigarro: perdi pro chapéu tossindo. Só não conta pro Freddy.'}
    ]),
    boss_arthur: Object.freeze([
      {title:'A RESENHA PASSOU DO LIMITE',speaker:'Aica',text:'Aff veyr juro! Arthur puxou o cabelo dela. Bestaiado, você se passou! Da Roça, ajuda!'},
      {title:'BRINCADEIRA TEM LIMITE',speaker:'Arthur',text:'Foi só uma brincadeira! Por que todo mundo tá olhando pra mim desse jeito?'},
      {title:'RESPEITO ANTES DO DESAFIO',speaker:'Da Roça',text:'Se machucou alguém, não é brincadeira. Chega junto e pede desculpa.'},
      {title:'O DESAFIO DO PÁTIO',speaker:'Arthur',text:'Tá bom, mas primeiro quero ver esse chapéu me alcançar!'}
    ]),
    arthur_revenge: Object.freeze([
      {title:'RAVILE VOLTOU À RESENHA',speaker:'Ravile',text:'Aff veyr juro, Arthur. Idiota! Você se passou. Agora vem ouvir o recado bem de pertinho.'},
      {title:'O GRITO ECOOU NO PÁTIO',speaker:'Aica',text:'OPEEEESTIIIIIIIII'},
      {title:'UM PEDIDO DE DESCULPA',speaker:'Arthur',text:'Ai! Entendi! Foi errado puxar seu cabelo. Desculpa, Ravile. Não vou fazer de novo.'},
      {title:'O PÁTIO FEZ AS PAZES',speaker:'Da Roça',text:'Pronto. Respeito aprendido. Agora só pode puxar conversa, cadeira e saco de farinha.'}
    ]),
    celebration: Object.freeze([
      {title:'O BOLO E A TURMA INTEIRA',speaker:'Lucas · o Sapo',text:'O bolo voltou! A mesa é da turma inteira. Nikolas, corta um pedaço. Um pedaço, viu?'},
      {title:'A AULA AGORA É NA MESA',speaker:'Professor Miqueias',text:'ALLRIGHT! Everybody is de parabéns! Bolo is recovered, amizade is strong e a dieta is amanhã!'},
      {title:'HOJE NINGUÉM É INIMIGO DA SOBREMESA',speaker:'Freddy',text:'OPEESTY DA ROÇA! Ô REEEIS! Trouxe a turma toda. Hoje a única briga é pela colher!'},
      {title:'TODO MUNDO CABE NESSA RESENHA',speaker:'Aica',text:'Aff veyr juro! Ravile tá bem, Arthur pediu desculpa e até o monstro trouxe guardanapo!'},
      {title:'A RESENHA CHEGOU EM PESO',speaker:'Rayssa',text:'Aff veyr juro! Trouxe as meninas e o Allef. Se toca, menino: hoje o bolo é da turma inteira!'},
      {title:'O PRÊMIO ESPECIAL DA QUARTA',speaker:'Da Roça',text:'AÇAÍ NA QUARTA-FEIRA! Bolo recuperado, vingança cumprida e colher na mão. Esse prêmio é meu!'},
      {title:'A AVENTURA CONTINUA DE COLHER NA MÃO',speaker:'Reeis',text:'OHHHH REEEEIS! A quarta é nossa! Curta a festa, guarde o prêmio e bora explorar com a turma!'}
    ]),
    boss_freddy: Object.freeze([
      {title:'A ÚLTIMA ESCADARIA TEM DONO',speaker:'Freddy',text:'OPEESTY DA ROÇA! Ô REEEIS! Eu seguro a escadaria, você segura essa pose de chefe!'},
      {title:'O PORTEIRO DA RESENHA',speaker:'Da Roça',text:'Cê é o último capanga ou o porteiro da resenha? Até a subida daqui tem fase dois!'},
      {title:'O BRAÇO MAIS FORTE DO MORRO',speaker:'Freddy',text:'Sou Freddy, o braço mais forte do Reeis. E chamo ele de Reeeis sem pedir licença!'},
      {title:'FREDDY ENTRA NA RODA',speaker:'Freddy',text:'Primeiro passa por mim. Depois cê sobe. Ô Reeeis, assiste e aprende!'}
    ]),
    freddy_defeat: Object.freeze([
      {title:'O CAPANGA PERDEU. A ZOEIRA NÃO.',speaker:'Freddy',text:'OPEESTY DA ROÇA! Esse papel veio com assinatura de concreto. Tá liberado, chapéu!'},
      {title:'RESPEITO SEM PERDER A RESENHA',speaker:'Da Roça',text:'Você perdeu e ainda tá zoando o chefe? Essa amizade aí tem armadura própria!'},
      {title:'O RECADO VAI SUBINDO',speaker:'Freddy',text:'REEEIS! Se perder pro chapéu também, amanhã o morro inteiro vai saber!'}
    ]),
    boss_nicolas: Object.freeze([
      {title:'O PROTAGONISTA DA PRAÇA',speaker:'Nicolas Carvalho',text:'Finalmente! O coadjuvante chegou. Sou Nicolas Carvalho, o protagonista definitivo de Camacan!'},
      {title:'UM DISCURSO PARA A FONTE',speaker:'Da Roça',text:'Protagonista? Você tava treinando discurso no reflexo da fonte.'},
      {title:'DESPERTAR DA AURA SUPREMA',speaker:'Nicolas Carvalho',text:'Silêncio! Testemunhe a AURA SUPREMA! Até o céu pediu ingresso pra minha batalha final!'},
      {title:'A LENDA QUE ELE ESCREVEU SOZINHO',speaker:'Nicolas Carvalho',text:'Os pilares despertaram. O tempo parou. Minha lenda começa AGORA!'},
      {title:'O CHAPÉU CONTRA O COSMOS',speaker:'Da Roça',text:'Tá, lenda. Se esse brilho estragar meu chapéu, você vai pagar a lavanderia.'}
    ]),
    nicolas_reveal: Object.freeze([
      {title:'A LENDA PERDEU O ROTEIRO',speaker:'Nicolas Carvalho',text:'Impossível! Minha aura suprema... meus mil anos de poder... meu roteiro!'},
      {title:'O TROVÃO VEIO DA BOCA',speaker:'Da Roça',text:'Mil anos? Nicolas, você tá fazendo barulho de trovão com a boca.'},
      {title:'CORTE PARA A VIDA REAL',speaker:'Narrador',text:'Era tudo imaginação de Nicolas. Na Praça Camacan, ele só girava os braços. A fonte nem parou.'},
      {title:'UM HERÓI SEM TESTEMUNHAS',speaker:'Nicolas Carvalho',text:'Vocês viram? Derrubei um deus! O brilho sumiu porque minha aura entrou no modo discreto.'},
      {title:'A PRAÇA VOLTA À PROGRAMAÇÃO NORMAL',speaker:'Da Roça',text:'Vi sim. A lixeira venceu por nocaute e a fonte tá pedindo revanche.'}
    ]),
    boss_marco: Object.freeze([
      {title:'O CADERNO NÃO ERA SÓ RASCUNHO',speaker:'Marco',text:'Você passou dos meus desenhos? Então vem conhecer o artista. Hoje a prova de artes vale a sua barra de vida!'},
      {title:'RABISCO RUIM, IDEIA PIOR',speaker:'Da Roça',text:'Isso é um tomate de tênis ou um caderno pedindo socorro? Até meu papel ficou preocupado!'},
      {title:'NÃO PISE NA PROVOCAÇÃO',speaker:'Marco',text:'Olhe onde pisa! Se o chão disser SARUÊ, meus brainrots vão sair do controle!'},
      {title:'O ARTISTA ENTRA EM CENA',speaker:'Da Roça',text:'Então desenha uma saída, porque eu vou buscar meu bolo. E dessa vez eu trouxe borracha em forma de peido.'}
    ]),
    boss_menezes: Object.freeze([
      {title:'O PALCO DA PROVOCAÇÃO',speaker:'Menezes · Rato',text:'Da roça poudiaaam! Reeeis pouddiaaam! Hoje minhas palavras vão ocupar a arena inteira!'},
      {title:'UMA FRASE, TRÊS PROBLEMAS',speaker:'Da Roça',text:'Tem parede de palavra, eco e onda no chão? Menezes, você transformou a recuperação de português num chefão!'},
      {title:'TEKETEKETEKETEKE',speaker:'Menezes · Rato',text:'Da Roça pegou ar! Pula a onda, procura o espaço e cuidado com a frase que volta. O eco também sabe provocar!'},
      {title:'O SINAL TOCOU. A RESENHA NÃO.',speaker:'Da Roça',text:'Respira entre as provocações, Menezes. É nessa hora que meu papel vai te responder!'}
    ]),
    boss_nikolas: Object.freeze([
      {title:'UM AMIGO. UM BOLO. UM TRONO.',speaker:'Da Roça',text:'Nikolas… a gente dividia tudo. Você realmente trocou nossa amizade por cobertura e um trono de farelo?'},
      {title:'A BATATA ESTÁ CARREGADA',speaker:'Nikolas Arroganti',text:'Eu ia dividir! Mas o primeiro pedaço era o bolo inteiro… e essa batata ainda tem força!'},
      {title:'A ÚLTIMA ESFREGADA NO NARIZ',speaker:'Nikolas Arroganti',text:'Meu catarro já tem fases de fome que não acabam. Desvia se puder, Da Roça! Hoje a cobertura sou eu que mando!'},
      {title:'AMIZADE NÃO SE ROUBA',speaker:'Da Roça',text:'Era só pedir um pedaço. Agora vou buscar o bolo e colher essa sua arrogância, batatão!'}
    ]),
    boss_reeis: Object.freeze([
      {title:'NO ALTO DA FAVELA',speaker:'Gabriel Reeis',text:'Eu sou Reeis, o rei do morro! Você veio falar de bolo ou testar seu fôlego?'},
      {title:'O REI DA RESENHA',speaker:'Da Roça',text:'Vim pedir ajuda, parceiro. Mas pelo tamanho dessa recepção… tô vendo que primeiro vai ter prova prática.'},
      {title:'RESPEITO SE CONQUISTA',speaker:'Gabriel Reeis',text:'Mostra o reflexo! Desvie das rajadas. Se aguentar, a gente conversa sobre esse bolo.'},
      {title:'DA ROÇA NÃO VEIO PARA TRÁS',speaker:'Da Roça',text:'Fiz tarefa, parkour e consertei o carro do meu pai. Essa amizade ainda nem começou!'}
    ]),
    boss_giant: Object.freeze([
      {title:'ALGO SAIU DA MARGEM',speaker:'Da Roça',text:'Esse caderno tá respirando? Marco, você desenhou um monstro ou a conta de luz de um estádio?!'},
      {title:'O GIGANTE DO CADERNO',speaker:'Monstro de Marco',text:'SIIIXXX… SEVEEEEN! RRRRÁÁÁ!'},
      {title:'UM RABISCO QUE COBRE O CÉU',speaker:'Da Roça',text:'Mão no chão, papel no céu e bicho pra todo lado… vou ler os avisos antes de virar rodapé!'},
      {title:'A BORRACHA É PEQUENA. A CORAGEM NÃO.',speaker:'Da Roça',text:'Reeis, segura essa página! Eu vou mostrar que até um monstro desse tamanho cabe num combo de peido bem dado.'}
    ]),
    marco_rage: Object.freeze([
      {title:'O CHÃO FALOU SOZINHO',speaker:'Armadilha de tinta',text:'S A R U Ê !'},
      {title:'VOCÊ PISOU NO NOME ERRADO',speaker:'Marco',text:'NÃO. ME. CHAMA. DE. SARUÊ! Nem o chão, nem você, nem esse chapéu de milho!'},
      {title:'FÚRIA VERMELHA',speaker:'Da Roça',text:'Eu nem falei nada! Foi meu tênis! Ih… olho vermelho. Esse desenho virou problema!'},
      {title:'SIX SEVEN DO CAOS',speaker:'Marco · em fúria',text:'SIX SEVEN! BRAINROTS, SAIAM DO CADERNO! Agora cada rabisco tem raiva, e cada número quer arrancar sua vida!'}
    ]),
    reeis_recruit: Object.freeze([
      {title:'DEPOIS DA ÚLTIMA RAJADA',speaker:'Gabriel Reeis',text:'Você aguentou a subida e a minha resenha. Que bolo é esse que vale tanta aventura?'},
      {title:'UM PEDIDO DE AMIZADE',speaker:'Da Roça',text:'Nikolas era meu amigo e roubou o bolo que Lucas fez pra mim. Me ajuda a buscar de volta?'},
      {title:'UM CRIME CONTRA O CHOCOLATE',speaker:'Gabriel Reeis',text:'Roubar bolo de amigo? Aí passou dos limites da resenha. Fechou, parceiro! Quando apertar, grita OHHHH REEEEIS!'},
      {title:'O PODER DO GRITO',speaker:'Da Roça',text:'OHHHH REEEEIS! Agora sim! Um parceiro desse tamanho… Nikolas vai precisar de uma colheita inteira de batata!'},
      {title:'NINGUÉM BUSCA UM BOLO SOZINHO',speaker:'Gabriel Reeis',text:'Use R! Eu chego correndo e viro grandão. Deixa meu fôlego voltar entre os gritos, parceiro!'}
    ])
  });
  const clamp=(v,a,b)=>Math.max(a,Math.min(b,v));
  const ease=v=>1-Math.pow(1-clamp(v,0,1),3);
  function rect(c,x,y,w,h,color){c.fillStyle=color;c.fillRect(Math.round(x),Math.round(y),Math.max(0,Math.round(w)),Math.max(0,Math.round(h)));}
  function poly(c,points,color){c.fillStyle=color;c.beginPath();points.forEach((p,i)=>i?c.lineTo(p[0],p[1]):c.moveTo(p[0],p[1]));c.closePath();c.fill();}
  function line(c,points,width,color){for(let i=1;i<points.length;i++){const a=points[i-1],b=points[i],steps=Math.max(1,Math.ceil(Math.max(Math.abs(b[0]-a[0]),Math.abs(b[1]-a[1]))/3));for(let j=0;j<=steps;j++){const t=j/steps;rect(c,a[0]+(b[0]-a[0])*t-width/2,a[1]+(b[1]-a[1])*t-width/2,width,width,color);}}}
  function word(c,t,x,y,size=14,color='#fff1ca',align='center'){c.save();c.font=`bold ${size}px monospace`;c.textAlign=align;c.textBaseline='middle';c.fillStyle='#1c3028';c.fillText(t,x+2,y+2);c.fillStyle=color;c.fillText(t,x,y);c.restore();}
  function heart(c,x,y,s=1,broken=false,t=0){c.save();c.translate(Math.round(x),Math.round(y));c.scale(s,s);const split=broken?Math.min(13,t*7):0;poly(c,[[-split,-4],[-split-5,-9],[-split-13,-9],[-split-18,-4],[-split-18,3],[-split-2,18],[-split+1,11],[-split-3,6],[1-split,2]],broken?'#c97070':'#f2979a');poly(c,[[split,-4],[split+5,-9],[split+13,-9],[split+18,-4],[split+18,3],[split+2,18],[split-1,11],[split+3,6],[-1+split,2]],broken?'#e4a49a':'#edb1a4');if(broken){line(c,[[0,-10],[-4,-1],[3,6],[-2,18]],2,'#f9e1ad');}else rect(c,-12,-5,6,3,'#ffe1c7');c.restore();}
  function sparkle(c,x,y,t,s=1,color='#fff3a8'){const p=2+Math.round((.5+Math.sin(t*5)*.5)*3);rect(c,x-p*s,y-s,p*2*s,2*s,color);rect(c,x-s,y-p*s,2*s,p*2*s,color);}
  function confetti(c,t,amount=35){for(let i=0;i<amount;i++){const x=(i*113+t*(i%2?17:-13)+1800)%960,y=55+(i*29+t*(20+i%8))%340;rect(c,x,y,4+(i%3),3,['#e6c56b','#e89a79','#c6dd87','#e3b4d6'][i%4]);}}
  function actor(c,type,x,y,t,options={}){if(window.Art?.drawCharacter)Art.drawCharacter(c,type,x,y,{facing:1,frame:t,scale:1.65,grounded:true,moving:false,...options});else{rect(c,x-15,y-65,30,65,type==='daroca'?'#e39d56':'#93769e');}}
  function cake(c,x,y,scale=1){c.save();c.translate(Math.round(x),Math.round(y));c.scale(scale,scale);if(window.Art?.drawCake)Art.drawCake(c,0,0);else{rect(c,-24,-28,48,28,'#78503c');rect(c,-26,-32,52,9,'#b98b65');}c.restore();}
  function bench(c,x,y){rect(c,x-116,y-40,232,10,'#79573d');rect(c,x-116,y-75,232,11,'#a37a4c');rect(c,x-116,y-59,232,10,'#bd945c');rect(c,x-105,y-37,11,37,'#4c5040');rect(c,x+94,y-37,11,37,'#4c5040');}
  function table(c,x,y){rect(c,x-70,y-41,140,12,'#77503b');rect(c,x-74,y-47,148,9,'#d0a16c');rect(c,x-61,y-29,11,53,'#71513b');rect(c,x+50,y-29,11,53,'#71513b');}
  function backdrop(c,state,scene=0,camera=0){if(window.Art?.drawScene)Art.drawScene(c,scene,camera+Math.round(Math.sin(state.time*.35)*8),state.time*.7+state.index*2);else{rect(c,0,0,960,540,'#8bc4e4');}rect(c,0,0,960,540,state.kind==='intro'&&state.index<2?'#f4d5a414':'#0e29191c');rect(c,0,374,960,50,'#687a43');rect(c,0,374,960,5,'#b7c974');for(let i=0;i<25;i++)rect(c,i*43-12,391+(i%3)*7,19,3,'#7d8d4a');}
  function stomach(c,x,y,t){const pulse=Math.sin(t*11)*4;line(c,[[x-27,y],[x-33-pulse,y-5],[x-28,y-13]],3,'#edc96f');line(c,[[x+27,y],[x+33+pulse,y-5],[x+28,y-13]],3,'#edc96f');if(Math.sin(t*4)>.1)word(c,'GRRRR…',x,y-37,14,'#ffe296');}
  function intro(c,s){const t=s.time,i=s.index;backdrop(c,s,i===1?1:0,i===1?180:0);
    if(i===0){bench(c,470,390);const e=ease(t/1.1);actor(c,'daroca',330+e*60,378,t,{facing:1,moving:t<1.1,speed:t<1.1?80:0,pose:t>=1.1?'fistbump':undefined,emotion:'friend'});actor(c,'nikolas',590-e*80,378,t,{facing:-1,moving:t<1.1,speed:t<1.1?80:0,pose:t>=1.1?'fistbump':undefined,emotion:'friend'});if(t>1.1)sparkle(c,450,301,t,2);heart(c,460,220+Math.sin(t*2)*4,1.3,false,t);}
    else if(i===1){const sway=Math.sin(t*2)*5;actor(c,'daroca',300+sway,378,t,{facing:1,moving:true,speed:100,emotion:'friend'});actor(c,'nikolas',610+sway,378,t,{facing:-1,moving:true,speed:100,emotion:'friend'});const px=300+(Math.sin(t*1.7)*.5+.5)*310;rect(c,px,270-Math.sin(t*1.7)*20,10,8,'#fff4d5');for(let k=0;k<3;k++)rect(c,px-k*13,275-Math.sin(t*1.7)*20,5,2,'#eee9cbb0');heart(c,460,200+Math.sin(t*2.3)*3,1,false,t);}
    else if(i===2){table(c,480,365);actor(c,'lucas',160,378,t,{facing:1,scale:1.55});actor(c,'daroca',340,378,t,{facing:1});actor(c,'nikolas',660,378,t,{facing:-1});cake(c,480,315,1.15);for(let j=0;j<6;j++)sparkle(c,420+j*23,248+Math.sin(t*2+j)*12,t+j,1);}
    else if(i===3){table(c,410,365);cake(c,410,315,1.2);actor(c,'daroca',185,378,t,{facing:1,scale:1.45});actor(c,'nikolas',647-ease(t/3)*35,379,t,{facing:-1,scale:2.05,emotion:'greed',attack:true,noseRub:true,attackType:'slime',attackProgress:.6});stomach(c,620,325,t);for(let j=0;j<3;j++){const u=(t*.5+j/3)%1;rect(c,505+u*55,265+Math.sin(u*Math.PI)*-18,4,4,'#84513d');}}
    else if(i===4){actor(c,'daroca',265,378,t,{facing:1,scale:1.9,attack:true,attackType:'punch',attackProgress:.48});actor(c,'nikolas',640,378,t,{facing:-1,scale:2.2,emotion:'taunted',noseRub:true,attack:true,attackType:'slime',attackProgress:.6});const w=Math.sin(t*12)*3;line(c,[[595,257],[582+w,252],[590,242]],3,'#f1d18c');line(c,[[590,271],[578-w,268],[585,260]],3,'#f1d18c');}
    else if(i===5){table(c,420,365);const run=ease(t/2.4),nx=575+run*240;actor(c,'daroca',280,378,t,{facing:1,scale:1.85,recoil:.5,emotion:'sad'});actor(c,'nikolas',nx,378,t,{facing:1,scale:1.7,moving:true,speed:260,pose:'steal',emotion:'greed',noseRub:t<.4});cake(c,nx+42,337,1);heart(c,450,230,1.5,true,t);for(let j=0;j<10;j++){const xx=530+j*26+(t*130)%40;if(xx<nx)rect(c,xx,375-j%3*7,5,3,'#d6bd82');}}
    else{actor(c,'daroca',360,378,t,{facing:1,scale:2,attack:t%3<1.5,attackType:'paper',attackProgress:(t%1.5)/1.5});actor(c,'lucas',650,378,t,{facing:-1,scale:1.55});if(window.Art?.drawVehicle)Art.drawVehicle(c,810,389,t);for(let j=0;j<5;j++)sparkle(c,310+j*31,217-Math.sin(t*3+j)*8,t+j,1,'#d8eda4');}
  }
  function outro(c,s){const t=s.time,i=s.index,strong=!!s.options.trained;backdrop(c,s,3,1100);if(i>=3)backdrop(c,s,0,0);
    if(i===0){actor(c,'daroca',310,378,t,{facing:1,scale:1.8,muscular:strong});actor(c,'nikolas',650,378,t,{facing:-1,scale:1.65,recoil:.7,emotion:'sad'});cake(c,470,379,1.25);confetti(c,t,25);}
    else if(i===1){actor(c,'daroca',290,378,t,{facing:1,scale:1.8,muscular:strong});actor(c,'nikolas',630,378,t,{facing:-1,scale:2.2,emotion:'taunted',noseRub:true,attack:true,attackType:'slime',attackProgress:.6});line(c,[[487,215],[520,236],[580,257]],3,'#eed09b');}
    else if(i===2){actor(c,'daroca',290,378,t,{facing:1,scale:2,muscular:strong,attack:true,attackType:'punch',attackProgress:.5});actor(c,'nikolas',652,378,t,{facing:-1,scale:1.9,recoil:.5,noseRub:false,emotion:'taunted'});word(c,'BATATA!',515,255+Math.sin(t*6)*4,23,'#ffda87');for(let k=0;k<3;k++){const yy=228+k*24;word(c,'HA',402+k*19,yy-Math.sin(t*5+k)*5,13,'#e5dfae');}const p=.5+Math.sin(t*4)*.5;sparkle(c,675,292,t,1+p);}
    else if(i===3){actor(c,'lucas',220,378,t,{facing:1,scale:1.7});actor(c,'daroca',378,390,t,{facing:1,scale:1.65,muscular:strong});actor(c,'nikolas',670,378,t,{facing:-1,scale:1.6,noseRub:t%3<1});table(c,520,365);cake(c,520,315,1.2);rect(c,735,300,26,45,'#d5e5dd');rect(c,739,294,18,8,'#88c0b0');rect(c,745,308,7,15,'#80ada3');}
    else if(i===4){actor(c,'daroca',330,378,t,{facing:1,scale:1.8,muscular:strong,pose:'offer',emotion:'friend'});actor(c,'nikolas',625,378,t,{facing:-1,scale:1.7,pose:'offer',emotion:'friend'});const e=ease(t/1.6);cake(c,380+e*196,330-Math.sin(e*Math.PI)*25,.7);heart(c,480,220+Math.sin(t*2)*4,1.1,false,t);}
    else{actor(c,'lucas',190,378,t,{facing:1,scale:1.35});actor(c,'daroca',365,378,t,{facing:1,scale:1.6,muscular:strong});actor(c,'nikolas',610,378,t,{facing:-1,scale:1.5,noseRub:t%4<.7});actor(c,'reeis',805,378,t,{facing:-1,scale:1.5});table(c,490,365);cake(c,490,315,1.2);confetti(c,t,42);for(let j=0;j<8;j++)sparkle(c,190+j*84,220+Math.sin(t*2+j)*13,t+j,1,'#f4e7a1');}
  }
  function battleBackdrop(c,s,type,scene=1){
    if(window.Art?.drawArena)Art.drawArena(c,type,0,s.time,480);else backdrop(c,s,scene,0);
    rect(c,0,0,960,413,'#071c191f');
    const floorColors={marco:'#514160',menezes:'#725b4a',nikolas:'#977151',reeisBoss:'#485460',giant:'#302c46',freddy:'#5d4c4b',nicolas:'#b4af90'};rect(c,0,378,960,35,floorColors[type]||'#4d6250');rect(c,0,378,960,4,type==='giant'?'#a99bbd':'#bfba91');
    for(let i=0;i<12;i++){const x=(i*97+s.time*(i%2?23:-19)+1400)%1080-60,y=77+(i*37)%260;rect(c,x,y,3,3,i%2?'#d4dca266':'#fff2b633');}
  }
  function streaks(c,t,color='#f8e7b9',intensity=1){c.save();c.globalAlpha*=.32*intensity;for(let i=0;i<15;i++){const y=50+i*23+Math.sin(t*17+i)*8,side=i%2;line(c,[[side?0:960,y],[side?150:810,y+Math.sin(i)*12]],2,color);}c.restore();}
  function shockRing(c,x,y,t,color='#f6d383',max=170){const phase=(t*.7)%1;const radius=20+phase*max;c.save();c.globalAlpha*=1-phase;for(let i=0;i<30;i++){const a=i/30*Math.PI*2;rect(c,x+Math.cos(a)*radius,y+Math.sin(a)*radius,5,3,color);}c.restore();}
  function redAura(c,x,y,t,s=1){c.save();c.translate(x,y);c.scale(s,s);const shake=Math.sin(t*25)*2;c.globalAlpha*=.43;poly(c,[[-35,0],[-44,-30],[-29,-36],[-37,-67],[-20,-59],[-16,-87],[-4,-75],[3+shake,-104],[12,-76],[28,-92],[24,-60],[41,-68],[30,-36],[46,-29],[35,0]],'#f64752');c.globalAlpha/= .43;c.globalAlpha*=.8;for(const side of [-1,1])line(c,[[side*32,-10],[side*37,-24],[side*29,-35],[side*38,-49],[side*29,-65],[side*32,-82]],2,'#ffb2aa');for(let i=0;i<14;i++){const yy=-((t*95+i*19)%112),xx=Math.sin(i*2.3+t)*32;rect(c,xx,yy,3,6,i%3?'#ff4949':'#ffd2ba');}c.restore();}
  function sketchbook(c,x,y,t,open=1){const spread=42+open*22;poly(c,[[x-spread,y-25],[x-3,y-13],[x-3,y+41],[x-spread,y+26]],'#b8a9c4');poly(c,[[x+3,y-13],[x+spread,y-25],[x+spread,y+26],[x+3,y+41]],'#e1cedc');rect(c,x-3,y-14,6,55,'#514460');for(let i=0;i<4;i++){rect(c,x-spread+8,y-11+i*10,spread-18,2,'#8d789c');rect(c,x+10,y-11+i*10,spread-18,2,'#a68fae');}sparkle(c,x,y-31-Math.sin(t*3)*5,t,1,'#f6d7ff');}
  function drawing(c,x,y,t,kind='brainrot',scale=1){c.save();c.translate(x,y);c.scale(scale,scale);if(window.Art?.drawMinion)Art.drawMinion(c,0,0,kind==='sixseven'?3:1,t,{type:kind,moving:true,range:20});else if(window.Art?.drawDoodle)Art.drawDoodle(c,0,-18,kind==='sixseven'?2:1,t,true);else{rect(c,-14,-30,28,28,'#bb93d2');rect(c,-8,-23,5,5,'#fff6ce');rect(c,5,-23,5,5,'#fff6ce');}c.restore();}
  function phraseBlock(c,text,x,y,t,color='#d49ab4'){const w=text.length*10+22;c.save();c.translate(Math.round(x),Math.round(y+Math.sin(t*3)*4));rect(c,-w/2,-15,w,29,'#2a263be6');rect(c,-w/2,12,w,3,color);word(c,text,0,0,16,color);c.restore();}
  function giantShadow(c,t){const pulse=Math.sin(t*2)*8;poly(c,[[180,374],[190,213],[248,188],[260,121],[332,118],[364,80],[582,80],[624,123],[704,140],[730,209],[790,241],[779,374]],'#151d2b');for(let i=0;i<8;i++)rect(c,210+i*77,330-Math.sin(t*2+i)*13,25,56,'#1f2238');rect(c,350,167,64,22,'#c4f173');rect(c,547,167,64,22,'#c4f173');rect(c,368,168,14,20,'#29322e');rect(c,565,168,14,20,'#29322e');rect(c,434,237+pulse*.2,90,14,'#b679a5');}
  function celestialSeal(c,x,y,t,scale=1){
    c.save();c.translate(Math.round(x),Math.round(y));c.scale(scale,scale);
    for(let i=0;i<12;i++){const a=i/12*Math.PI*2+t*.14,cs=Math.cos(a),sn=Math.sin(a),r=83+Math.sin(t*3+i)*5;line(c,[[cs*r,sn*r*.58],[cs*(r+18),sn*(r+18)*.58]],3,i%2?'#8be8ee':'#ffe09c');}
    for(let i=0;i<5;i++){const a=i/5*Math.PI*2-t*.12;const x=Math.cos(a)*113,y=Math.sin(a)*62;line(c,[[x-6,y+4],[x,y-7],[x+7,y+4],[x-6,y+4]],2,'#ffe8a6');}
    c.restore();shockRing(c,x,y,t,'#8fe9e7',120*scale);
  }
  function supremeSky(c,t){
    c.save();c.globalAlpha=.28;
    for(let i=0;i<6;i++){const x=90+i*159+Math.sin(t*.6+i)*13;poly(c,[[x,205],[x+31,205],[x+85,378],[x-65,378]],i%2?'#83e2e8':'#ffe39a');}
    c.restore();
    for(let i=0;i<14;i++){const x=360+Math.sin(i*2.7+t*.7)*285,y=212+((i*29-t*32)%185+185)%185;rect(c,x,y,3,6,i%2?'#c5faf3':'#ffe5a1');}
  }
  function realityBin(c,x,y){rect(c,x-20,y-48,40,47,'#4a6c5f');rect(c,x-23,y-52,46,7,'#325148');rect(c,x-12,y-40,4,31,'#739481');rect(c,x+8,y-40,4,31,'#739481');rect(c,x-9,y-58,18,6,'#325148');}
  function freddyFilm(c,s){
    const t=s.time,i=s.index,strong=!!s.options.trained,defeat=s.kind==='freddy_defeat';
    battleBackdrop(c,s,'freddy',5);
    actor(c,'daroca',230+(defeat?ease(t)*35:0),378,t,{facing:1,scale:1.7,muscular:strong,attack:!defeat&&i===1,attackType:'paper',attackProgress:.48});
    const enter=!defeat&&i===0?ease(t/1.1):1,fx=defeat?665:810-enter*140;
    actor(c,'freddy',fx,378,t,{facing:defeat&&i===2?1:-1,scale:defeat?2:2.12,moving:!defeat&&i===0&&t<1.1,speed:180,recoil:defeat&&i===0?.6:0,attack:!defeat&&i===2,attackType:'punch',attackProgress:(t*.6)%1,pose:defeat&&i===1?'fistbump':undefined});
    if((!defeat&&i===0)||(!defeat&&i===3)||(defeat&&i===2)){
      word(c,'Ô REEEIS!',550,210+Math.sin(t*4)*4,22,'#f8d19c');
      for(let j=0;j<3;j++)line(c,[[740+j*19,260-j*9],[749+j*19,253-j*9],[744+j*19,244-j*9]],2,'#f7d9a0');
    }
    if(!defeat&&i===2){shockRing(c,fx,370,t,'#e4bb82',75);word(c,'O MAIS FORTE DOS CAPANGAS',475,215,17,'#f1c69d');}
    if(!defeat&&i===3){streaks(c,t,'#e9b48f',.7);shockRing(c,fx,372,t,'#efc08e',110);}
    if(defeat&&i===0){rect(c,fx-53,310,12,8,'#fff1d4');rect(c,fx-40,306,11,5,'#d1d9c9');}
    if(defeat&&i===1){heart(c,475,235+Math.sin(t*2)*3,.8,false,t);}
  }
  function nicolasFilm(c,s){
    const t=s.time,i=s.index,strong=!!s.options.trained,reveal=s.kind==='nicolas_reveal';
    if(!reveal){
      if(i<2)backdrop(c,s,4,4700);
      else{backdrop(c,s,4,4700);c.save();c.globalAlpha=i===2?ease(t/1.15):1;battleBackdrop(c,s,'nicolas',4);supremeSky(c,t);c.restore();}
      const awakened=i>=2,charge=i===2&&t<1.15,hover=awakened?Math.sin(t*2)*3:0;
      if(awakened){celestialSeal(c,650,302,t,1);streaks(c,t,'#e3f6e5',i===2?.45:.8);}
      actor(c,'daroca',i===4?270:230,378,t,{facing:1,scale:i===4?1.85:1.7,muscular:strong,recoil:i===2?.4:0,attack:i===1||i===4,attackType:i===1?'punch':'paper',attackProgress:.5});
      actor(c,'nicolas',650,378-hover,t,{facing:-1,scale:awakened?2.05:1.85,supreme:awakened,powered:awakened,transformed:awakened,energy:awakened,charging:charge,attack:i===3,attackType:'cast',attackProgress:(t*.5)%1});
      if(i===0)word(c,'PROTAGONISTA',650,226+Math.sin(t*2)*3,18,'#e7d299');
      if(i===1){rect(c,566,363,167,8,'#74b7ba');rect(c,578,367,140,4,'#b8e4d8');sparkle(c,641,363,t,1,'#d5f2eb');}
      if(i===2&&t>1.15){shockRing(c,650,312,t-1.15,'#f9dc91',200);word(c,'AURA SUPREMA',480,210,24,'#fff0ad');}
      if(i===3){for(let k=0;k<3;k++){const x=350+k*122,y=240+Math.sin(t*2+k)*17;line(c,[[x-8,y],[x,y-12],[x+8,y],[x,y+12],[x-8,y]],2,k%2?'#9cebef':'#ffe5a2');}}
    }else{
      const dissolve=i===1?ease(t/1.2):i>1?1:0;
      backdrop(c,s,4,4700);
      if(dissolve<1){c.save();c.globalAlpha=1-dissolve;battleBackdrop(c,s,'nicolas',4);supremeSky(c,t);celestialSeal(c,650,302,t,1);actor(c,'nicolas',650,378,t,{facing:-1,scale:2.05,supreme:true,powered:true,transformed:true,energy:true,recoil:.65});c.restore();}
      actor(c,'daroca',265,378,t,{facing:1,scale:1.8,muscular:strong,attack:i===1||i===4,attackType:'punch',attackProgress:.4});
      if(dissolve>0){c.save();c.globalAlpha=dissolve;realityBin(c,760,378);actor(c,'nicolas',650,378,t,{facing:i===3?1:-1,scale:1.8,moving:i===2,speed:i===2?70:0,attack:i===2||i===3,attackType:'punch',attackProgress:(t*.8)%1});c.restore();}
      if(i===0){for(let k=0;k<10;k++){const a=k/10*Math.PI*2;rect(c,650+Math.cos(a+t)*100,300+Math.sin(a+t)*68,7,4,k%2?'#d3ffff':'#fbe2a4');}word(c,'ROTEIRO INTERROMPIDO',480,214,18,'#ffe6b5');}
      if(i===1){for(let k=0;k<9;k++){const x=300+k*62,y=214+((t*145+k*29)%160);line(c,[[x-7,y],[x+8,y+2],[x+3,y+17],[x-7,y]],2,'#c1ece5');}}
      if(i===2){word(c,'VRUM! PÁ! CABUM!',650,222+Math.sin(t*7)*4,17,'#e5ce97');const x=650+Math.sin(t*4)*45;line(c,[[x+28,303],[x+43,300]],2,'#d0b66e');}
      if(i===3){word(c,'FOI ÉPICO. EU TAVA LÁ.',650,225,16,'#eadcaa');sparkle(c,648,270,t,.6,'#e3d9a9');}
      if(i===4){const paperX=690+Math.sin(t*3)*4;rect(c,paperX,361,6,5,'#e7e3ce');word(c,'…',760,304+Math.sin(t*2)*2,24,'#cee0c7');}
    }
  }
  function dedeFilm(c,s){
    const t=s.time,i=s.index,defeat=s.kind==='dede_defeat';
    battleBackdrop(c,s,'dede',5);
    actor(c,'daroca',245,378,t,{facing:1,scale:1.8,muscular:!!s.options.trained,attack:!defeat&&i===3,attackType:'fart',attackProgress:(t*.6)%1});
    actor(c,'dede',665,378,t,{facing:-1,scale:2,recoil:defeat&&i===0?.5:0,attack:!defeat&&i===2,attackType:'cast',attackProgress:(t*.6)%1,smoke:!defeat});
    if(!defeat){
      c.save();c.globalAlpha=.2;
      for(let k=0;k<8;k++){const x=510+Math.sin(t*.4+k)*90+k*25,y=288-((t*19+k*27)%95);rect(c,x,y,42+k%3*14,17,'#c5d1c6');rect(c,x+10,y-8,23,9,'#d6ded0');}
      c.restore();
      if(i===1||i===3){for(let k=0;k<5;k++){const x=300+(t*155+k*47)%310;line(c,[[x,320+k*8],[x+24,315+k*8],[x+39,320+k*8]],2,'#d5e9b8');}}
    }else{for(let k=0;k<4;k++)rect(c,690+(t*24+k*32)%120,288-k*21,15,3,'#d2dbbf88');if(i===2)word(c,'O FREDDY NEM VAI FICAR SABENDO...',480,228,13,'#ecd2aa');}
  }
  function arthurFilm(c,s){
    const t=s.time,i=s.index,revenge=s.kind==='arthur_revenge';backdrop(c,s,9,1050);
    if(!revenge){
      actor(c,'daroca',155,378,t,{facing:1,scale:1.7,muscular:!!s.options.trained,attack:i===2,attackType:'punch',attackProgress:.4});
      actor(c,'ravile',380,378,t,{facing:1,scale:1.65,injured:true,fallen:true});
      actor(c,'aica',292,378,t,{facing:1,scale:1.7,helping:true});
      actor(c,'arthur',710,378,t,{facing:-1,scale:1.9,expressive:true,moving:i===3,speed:i===3?70:0,pose:i===1?'offer':undefined});
      if(i===0){heart(c,350,278,.65,false,t);word(c,'EI, CALMA!',267,249,15,'#f3d6a9');}
      if(i===2){line(c,[[190,318],[217,312],[233,315]],2,'#f2dfaf');}
      if(i===3)streaks(c,t,'#eee3b6',.45);
    }else{
      actor(c,'daroca',155,378,t,{facing:1,scale:1.7,muscular:!!s.options.trained});
      actor(c,'aica',302,378,t,{facing:1,scale:1.75,helping:i===0,attack:i===1,attackType:'punch',attackProgress:.35});
      if(i===1){
        actor(c,'arthur',575,378,t,{facing:-1,scale:1.7,expressive:true,pose:'earpulled',recoil:.25});
        actor(c,'ravile',500,378,t,{facing:1,scale:1.7,pose:'earpull'});
        for(let k=0;k<3;k++)line(c,[[562+k*9,277-k*7],[566+k*9,269-k*7]],2,'#f6d58f');
        word(c,'OPEEEESTIIIIIIIII',480,222+Math.sin(t*4)*2,21,'#ffe4ad');
      }else{
        actor(c,'ravile',480,378,t,{facing:1,scale:1.7,pose:i===3?'offer':undefined});
        actor(c,'arthur',655,378,t,{facing:-1,scale:1.8,expressive:true,pose:i===2||i===3?'offer':undefined,recoil:i===0?.2:0});
        if(i===3){heart(c,558,245+Math.sin(t*2)*3,.95,false,t);sparkle(c,565,320,t,1,'#e1ebbc');}
      }
    }
  }
  const PARTY_GROUPS=Object.freeze([
    Object.freeze(['daroca','lucas','reeis','nikolas','davi','vitor']),
    Object.freeze(['mota','caleb','almiro','miqueias','kaua']),
    Object.freeze(['freddy','dede','marco','menezes','nicolas']),
    Object.freeze(['aica','ravile','arthur','ravid','giant']),
    Object.freeze(['allef','eloisa','giselle','rayssa','analaura','amanda'])
  ]);
  const PARTY_CAST=Object.freeze(PARTY_GROUPS.flat());
  function acai(c,x,y,t,scale=1){
    if(window.Art?.drawAcai){Art.drawAcai(c,x,y,t,{scale});return;}
    c.save();c.translate(x,y);c.scale(scale,scale);poly(c,[[-26,-13],[26,-13],[18,12],[-18,12]],'#c2a56e');rect(c,-28,-19,56,10,'#563463');rect(c,-23,-19,46,3,'#926494');for(let j=0;j<3;j++){rect(c,-16+j*13,-21,9,6,'#ead7a0');rect(c,-14+j*13,-20,4,2,'#c5ab70');}line(c,[[17,-15],[32,-41]],4,'#e6e1c7');c.restore();
  }
  function partyBackdrop(c,s){
    backdrop(c,s,4,3130);rect(c,0,0,960,373,'#77506b14');
    const t=s.time;
    line(c,[[0,216],[240,235],[480,224],[720,235],[960,215]],2,'#53604b');
    for(let j=0;j<15;j++){const x=28+j*66,y=218+Math.sin(j/14*Math.PI)*13;poly(c,[[x-11,y],[x+11,y+1],[x,y+17]],['#e6bc6f','#b989b0','#b7d28b','#8cbec4'][j%4]);sparkle(c,x+25,y+3,t+j,.55,j%2?'#fae5a2':'#dedda3');}
    rect(c,0,378,960,32,'#6c7848');rect(c,0,378,960,4,'#b4c27c');
    rect(c,65,405,830,20,'#e4cba0');rect(c,65,405,830,5,'#f3deb2');for(let j=0;j<9;j++)rect(c,83+j*92,410,42,4,j%2?'#b68bb0':'#a6b97b');
  }
  function partyGuest(c,type,x,y,t,focus=false){
    const giant=type==='giant';actor(c,type,x,y,t,{facing:x<480?1:-1,scale:giant?.48:focus?1.65:1.35,muscular:type==='daroca',smoke:false,talking:type==='ravid',moving:false,pose:Math.sin(t*1.6+x)>.55?'offer':undefined,emotion:'friend',frame:t+x*.012});
  }
  function celebration(c,s){
    const t=s.time,i=s.index;partyBackdrop(c,s);confetti(c,t,36);
    if(i<PARTY_GROUPS.length){
      const group=PARTY_GROUPS[i],step=group.length===6?145:165,start=group.length===6?110:150;
      group.forEach((type,j)=>partyGuest(c,type,start+j*step,378+Math.sin(t*2+j)*2,t));
      table(c,340,414);table(c,655,414);cake(c,340,364,1.15);acai(c,655,367,t,1.2);
      if(i===2)word(c,'HOJE A ÚNICA BATALHA É PELA COLHER!',480,265,14,'#f8e5b6');
      if(i===3){rect(c,828,302,15,22,'#eee7d0');rect(c,830,305,11,2,'#c3c8ae');word(c,'O MONSTRO TROUXE GUARDANAPO.',480,261,13,'#e8edc5');}
    }else if(i===PARTY_GROUPS.length){
      partyGuest(c,'daroca',315,378,t,true);partyGuest(c,'lucas',630,378,t,true);partyGuest(c,'davi',795,378,t);partyGuest(c,'vitor',130,378,t);
      table(c,490,394);cake(c,425,345,1);acai(c,550,342,t,1.85);for(let j=0;j<7;j++)sparkle(c,465+j*23,277+Math.sin(t*3+j)*10,t+j,.75,'#ead3f1');
      word(c,'QUARTA-FEIRA · AÇAÍ DA VITÓRIA',480,238,19,'#f1d2ec');heart(c,480,281+Math.sin(t*2)*3,.65,false,t);
    }else{
      // Five earlier shots show every guest clearly; this tracking shot connects
      // them into one continuous banquet rather than claiming a party offscreen.
      const backgroundGuests=PARTY_CAST.filter(type=>type!=='daroca'&&type!=='reeis'),offset=ease(t/4)*(backgroundGuests.length*126-820);
      backgroundGuests.forEach((type,j)=>{const x=90+j*126-offset;if(x>-70&&x<1030)partyGuest(c,type,x,364+Math.sin(t*2+j)*2,t);});
      rect(c,0,397,960,18,'#e5c693');rect(c,0,397,960,4,'#f1ddae');
      for(let j=0;j<7;j++){const x=(j*175-offset*.6+2000)%1175-80;if(j%2)cake(c,x,397,.6);else acai(c,x,398,t,.72);}
      partyGuest(c,'daroca',150,411,t);partyGuest(c,'reeis',730,411,t);
      word(c,'BOLO RECUPERADO. RESENHA LIBERADA.',480,244,19,'#f7e6b9');
      word(c,'A QUARTA-FEIRA TEM GOSTO DE VITÓRIA!',480,272,13,'#e4c8ee');
    }
  }
  function bossFilm(c,s){const t=s.time,i=s.index,strong=!!s.options.trained;
    if(s.kind==='boss_dede'||s.kind==='dede_defeat'){dedeFilm(c,s);
    }else if(s.kind==='boss_arthur'||s.kind==='arthur_revenge'){arthurFilm(c,s);
    }else if(s.kind==='celebration'){celebration(c,s);
    }else if(s.kind==='boss_freddy'||s.kind==='freddy_defeat'){freddyFilm(c,s);
    }else if(s.kind==='boss_nicolas'||s.kind==='nicolas_reveal'){nicolasFilm(c,s);
    }else if(s.kind==='boss_marco'){
      battleBackdrop(c,s,'marco',1);
      if(i===0){sketchbook(c,515,311,t,ease(t));actor(c,'marco',650-ease(t)*70,378,t,{facing:-1,scale:2.1,attack:true,attackType:'doodle',attackProgress:(t*.7)%1});actor(c,'daroca',220,378,t,{facing:1,scale:1.65,muscular:strong});}
      else if(i===1){actor(c,'daroca',260,378,t,{facing:1,scale:1.85,muscular:strong,emotion:'taunted'});drawing(c,505+Math.sin(t*2)*25,341-Math.abs(Math.sin(t*3))*24,t,'brainrot',1.6);drawing(c,730+Math.cos(t*2)*24,352,t,'sixseven',1.65);word(c,'6  7',714,205+Math.sin(t*3)*5,29,'#f0d68f');}
      else if(i===2){actor(c,'marco',645,378,t,{facing:-1,scale:2.2,attack:true,attackType:'doodle',attackProgress:.5});rect(c,338,364,174,13,'#9c669f');rect(c,344,367,162,4,'#dcaddc');word(c,'SARUÊ!',425,351,20,'#ecc4e8');shockRing(c,425,371,t,'#d2a7e5',95);actor(c,'daroca',210,378,t,{facing:1,scale:1.75,muscular:strong});}
      else{actor(c,'daroca',270+ease(t/1.4)*35,378,t,{facing:1,scale:1.9,muscular:strong,attack:true,attackType:'paper',attackProgress:(t*.5)%1});actor(c,'marco',680,378,t,{facing:-1,scale:2.15,attack:true,attackType:'doodle',attackProgress:(t*.6)%1});streaks(c,t,'#e8c5ec');}
    }else if(s.kind==='boss_menezes'){
      battleBackdrop(c,s,'menezes',1);
      actor(c,'daroca',220,378,t,{facing:1,scale:1.7,muscular:strong});actor(c,'menezes',690,378,t,{facing:-1,scale:i===2?2.3:2,attack:true,attackType:'word',attackProgress:(t*.9)%1});
      if(i===0){phraseBlock(c,'DA ROÇA POUDIAAAM',465-ease(t/1.8)*120,233,t);phraseBlock(c,'REEEIS POUDDIAAAM',560+ease(t/1.8)*80,286,t+2,'#e5c78d');}
      else if(i===1){for(let k=0;k<4;k++)phraseBlock(c,k%2?'PEGOU AR':'POUDI',560+k*8,190+k*37,t+k,'#edb3ce');shockRing(c,660,374,t,'#d1d89c',240);}
      else if(i===2){const x=700-(t*150)%680;phraseBlock(c,'TEKETEKETEKE',x,259,t,'#e7b7cf');phraseBlock(c,'TEKETEKETEKE',960-x,307,t+1,'#aabddd');for(let k=0;k<8;k++)rect(c,175+k*87,365+Math.sin(t*7+k)*8,34,5,'#debc95');}
      else{streaks(c,t,'#eed19b');actor(c,'daroca',266,378,t,{facing:1,scale:1.9,muscular:strong,attack:true,attackType:'paper',attackProgress:(t*.7)%1});phraseBlock(c,'VULNERÁVEL!',665,209,t,'#d9ebae');}
    }else if(s.kind==='boss_nikolas'){
      battleBackdrop(c,s,'nikolas',3);actor(c,'daroca',230,378,t,{facing:1,scale:1.8,muscular:strong});actor(c,'nikolas',665,378,t,{facing:-1,scale:i===1||i===2?2.45:2.05,attack:i!==0,noseRub:i!==0,attackType:'slime',attackProgress:.6,emotion:i===0?'sad':'greed'});cake(c,500,347,1.1);
      if(i===0){c.save();c.globalAlpha=.22;heart(c,475,188,1.7,true,t);c.restore();}
      else if(i===1){stomach(c,650,316,t);word(c,'BATATA!',480,208+Math.sin(t*3)*5,24,'#f1d18c');}
      else if(i===2){for(let k=0;k<9;k++){const a=k/9*Math.PI*2;rect(c,651+Math.cos(a+t)*82,255+Math.sin(a+t)*70,7,10,'#c9e37b');}streaks(c,t,'#e5f2b1',.7);}
      else{actor(c,'daroca',262,378,t,{facing:1,scale:2,muscular:strong,attack:true,attackType:'fart',attackProgress:(t*.6)%1});shockRing(c,485,340,t,'#f5d5a1',210);}
    }else if(s.kind==='boss_reeis'){
      battleBackdrop(c,s,'reeisBoss',5);const enter=ease(t/1.2);actor(c,'daroca',200+enter*35,378,t,{facing:1,scale:1.55,muscular:strong,moving:t<1.2,speed:100});actor(c,'reeis',665,378,t,{facing:-1,scale:1.35,transformed:true,powered:i>1,aura:i>1,charging:i===2,attack:i===2,attackType:'gun',attackProgress:(t*.8)%1});
      if(i===0){for(let k=0;k<7;k++)rect(c,535+k*27,126+k%2*7,10,3,'#e3ce87');}
      else if(i===1){word(c,'REI DO MORRO',645,160+Math.sin(t*2)*5,20,'#e7d392');shockRing(c,655,364,t,'#e4c07c',160);}
      else if(i===2){streaks(c,t,'#fff0ae');for(let k=0;k<5;k++){const x=610-(t*190+k*69)%450;rect(c,x,285+k*12,17,5,'#e5ce8c');}}
      else{actor(c,'daroca',285,378,t,{facing:1,scale:1.9,muscular:strong,attack:true,attackType:'paper',attackProgress:(t*.6)%1});heart(c,433,229+Math.sin(t*3)*4,1,false,t);}
    }else if(s.kind==='boss_giant'){
      battleBackdrop(c,s,'giant',6);actor(c,'daroca',175,378,t,{facing:1,scale:1.5,muscular:strong});
      if(i===0){giantShadow(c,t);sketchbook(c,495,352,t,1);for(let k=0;k<12;k++)rect(c,300+k*29,320-((t*60+k*11)%170),5,8,'#d4b4e2');actor(c,'daroca',165,378,t,{facing:1,scale:1.5,muscular:strong});}
      else if(i===1){actor(c,'giant',625,383,t,{facing:-1,scale:1.3,attack:true,attackType:'smash',attackProgress:(t*.65)%1});word(c,'SIX… SEVEN!',660,70+Math.sin(t*4)*5,26,'#d8f39a');streaks(c,t,'#d9b4ed');}
      else if(i===2){actor(c,'giant',642,383,t,{facing:-1,scale:1.18,attack:true,attackType:'smash',attackProgress:(t*.7)%1});shockRing(c,605,373,t,'#d0a1df',260);for(let k=0;k<5;k++){const yy=95+(t*82+k*39)%250;rect(c,315+k*93,yy,25,32,'#dfcee2');rect(c,320+k*93,yy+9,15,2,'#9b83a6');}drawing(c,383,376,t,'sixseven',1.3);}
      else{actor(c,'giant',682,383,t,{facing:-1,scale:1.25,attack:false});actor(c,'reeis',320,378,t,{facing:1,scale:1.15,transformed:true,powered:true,aura:true});actor(c,'daroca',175,378,t,{facing:1,scale:1.6,muscular:strong,attack:true,attackType:'fart',attackProgress:(t*.7)%1});streaks(c,t,'#f3dfb0');}
    }else if(s.kind==='marco_rage'){
      battleBackdrop(c,s,'marco',1);
      if(i===0){const step=ease(t/.85);rect(c,364,366,176,13,'#8c5d94');word(c,'SARUÊ!',452,350,25,'#f3c8ee');actor(c,'daroca',210+step*186,378,t,{facing:1,scale:1.8,muscular:strong,moving:t<.85,speed:160});actor(c,'marco',690,378,t,{facing:-1,scale:1.8});shockRing(c,452,370,t,'#ed9ad4',135);}
      else if(i===1){redAura(c,615,379,t,1.55);actor(c,'marco',615,378,t,{facing:-1,scale:2.3,rage:true,angry:true,charging:true,attack:true,attackType:'doodle',attackProgress:.5});actor(c,'daroca',200,378,t,{facing:1,scale:1.65,muscular:strong,recoil:.5});streaks(c,t,'#ff8585');}
      else if(i===2){redAura(c,615,379,t,1.9);actor(c,'marco',615,378,t,{facing:-1,scale:2.45,rage:true,angry:true,charging:t<1,powered:t>=1,attack:true,attackType:'doodle',attackProgress:(t*.9)%1});shockRing(c,615,300,t,'#ff706f',185);actor(c,'daroca',183,378,t,{facing:1,scale:1.6,muscular:strong,recoil:.5});}
      else{redAura(c,650,379,t,1.9);actor(c,'marco',650,378,t,{facing:-1,scale:2.2,rage:true,angry:true,powered:true,attack:true,attackType:'doodle',attackProgress:(t*.9)%1});drawing(c,260+Math.sin(t*2)*18,355-Math.abs(Math.sin(t*3))*20,t,'brainrot',1.7);drawing(c,432,363,t,'sixseven',1.8);word(c,'SIX  SEVEN!',406,230+Math.sin(t*4)*4,25,'#ffc4ae');streaks(c,t,'#ff9b92');}
    }else if(s.kind==='reeis_recruit'){
      battleBackdrop(c,s,'reeisBoss',5);
      if(i===0){actor(c,'daroca',245,378,t,{facing:1,scale:1.7,muscular:strong});actor(c,'reeis',675,378,t,{facing:-1,scale:1.9,recoil:.4});}
      else if(i===1){actor(c,'daroca',315,378,t,{facing:1,scale:1.9,muscular:strong,emotion:'sad',pose:'offer'});actor(c,'reeis',652,378,t,{facing:-1,scale:1.85});cake(c,470,289,.8);heart(c,473,220,1.2,true,t);}
      else if(i===2){const e=ease(t/1.1);actor(c,'daroca',325+e*40,378,t,{facing:1,scale:1.85,muscular:strong,pose:'fistbump',emotion:'friend'});actor(c,'reeis',615-e*65,378,t,{facing:-1,scale:1.9,pose:'fistbump',emotion:'friend'});heart(c,460,220+Math.sin(t*2)*5,1.4,false,t);if(t>1)sparkle(c,457,303,t,2);}
      else if(i===3){const run=t<.9,charge=t>=.9&&t<1.8,powered=t>=1.8;const x=run?-90+ease(t/.9)*605:515;actor(c,'daroca',245,378,t,{facing:1,scale:1.7,muscular:strong});actor(c,'reeis',x,378,t,{facing:1,scale:powered?1.15:1.75,moving:run,speed:run?400:0,charging:charge,transformed:powered,powered,aura:charge||powered});if(powered){shockRing(c,515,303,t-1.8,'#ffe59d',210);streaks(c,t,'#f7e4aa');}word(c,'OHHHH REEEEIS!',650,140+Math.sin(t*5)*3,23,'#ffe7a3');}
      else{actor(c,'daroca',330,378,t,{facing:1,scale:1.8,muscular:strong,emotion:'friend'});actor(c,'reeis',615,378,t,{facing:-1,scale:1.8,emotion:'friend'});confetti(c,t,26);heart(c,480,224+Math.sin(t*2)*4,1.3,false,t);for(let j=0;j<5;j++)sparkle(c,320+j*74,190+Math.sin(t*2+j)*12,t+j,1);}
    }
  }
  function isEpilogue(s){return s?.kind==='jorge_epilogue';}
  // A configured cinematic soundtrack opts into this shared edit rhythm.
  // Unconfigured conversations retain their original click-to-advance behavior.
  const frameDuration=frame=>Number.isFinite(frame.duration)?frame.duration:Math.round(clamp((frame.text||'').length/19+1.35,4.5,9)*100)/100;
  function timeline(kind='intro'){
    if(kind&&typeof kind==='object')return timelinePosition(kind);
    const frames=kind==='jorge_epilogue'?window.JorgeEpilogue?.shots:kind==='intro'?INTRO:kind==='outro'?OUTRO:EXTRA[kind];
    if(!frames)return null;
    let start=0;
    const shots=frames.map((frame,index)=>{const duration=frameDuration(frame),shot={id:frame.id||String(index),index,start,duration,label:frame.title||'Quadro '+(index+1),speaker:frame.speaker||'',text:frame.text||''};start+=duration;return Object.freeze(shot);});
    return Object.freeze({id:kind,duration:Math.round(start*100)/100,manualDefault:kind!=='jorge_epilogue',shots:Object.freeze(shots)});
  }
  function timelinePosition(s){
    if(!s)return 0;const timing=timeline(s.kind);if(!timing)return 0;
    if(s.done)return timing.duration;
    const index=clamp(Math.floor(Number(s.index)||0),0,timing.shots.length-1),shot=timing.shots[index];
    return clamp(shot.start+Math.max(0,Number(s.time)||0),0,timing.duration);
  }
  function stateAt(kind,seconds=0,options={}){
    const timing=timeline(kind);if(!timing)return null;
    const elapsed=clamp(Number(seconds)||0,0,timing.duration),last=timing.shots.length-1;
    let index=timing.shots.findIndex(shot=>elapsed<shot.start+shot.duration);if(index<0)index=last;
    return {kind,index,time:elapsed-timing.shots[index].start,elapsed,done:elapsed>=timing.duration,options:{...options,musicTimed:true}};
  }
  function create(kind='intro',options={}){
    if(kind==='jorge_epilogue')return window.JorgeEpilogue?.create(options)||{kind,index:0,time:0,elapsed:0,done:false,options:{...options}};
    return {kind:kind==='outro'||Object.prototype.hasOwnProperty.call(EXTRA,kind)?kind:'intro',index:0,time:0,elapsed:0,done:false,options:{...options}};
  }
  function list(s){return isEpilogue(s)?window.JorgeEpilogue?.shots||[]:EXTRA[s.kind]||(s.kind==='outro'?OUTRO:INTRO);}
  function beat(s){if(!s)return null;if(isEpilogue(s))return window.JorgeEpilogue?.beat(s)||{index:0,number:1,total:1,speaker:'',text:'JORGE',cinematic:true};const beats=list(s),index=clamp(Math.floor(Number(s.index)||0),0,beats.length-1);return {...beats[index],index,number:index+1,total:beats.length};}
  function update(s,dt){if(!s||s.done)return;if(isEpilogue(s)){if(window.JorgeEpilogue)JorgeEpilogue.update(s,dt);else s.done=true;return;}dt=clamp(Number(dt)||0,0,.1);s.time+=dt;s.elapsed=(s.elapsed||0)+dt;if(s.options?.musicTimed){const timing=timeline(s.kind);while(!s.done&&s.time>=timing.shots[s.index].duration){const duration=timing.shots[s.index].duration;if(s.index+1>=timing.shots.length){s.done=true;s.time=duration;s.elapsed=timing.duration;break;}s.time-=duration;s.index++;}if(!s.done)s.elapsed=timelinePosition(s);}}
  function advance(s){if(!s||s.done)return false;if(isEpilogue(s)){if(window.JorgeEpilogue)return JorgeEpilogue.advance(s);s.done=true;return false;}if(s.index+1>=list(s).length){s.done=true;return false;}s.index++;s.time=0;if(s.options?.musicTimed)s.elapsed=timelinePosition(s);return true;}
  // The bubble rectangle is deliberately separate from the actor frame. Root UI
  // places the accessible HTML balloon here instead of covering the action.
  function revengeAnchorX(s){return s.kind==='arthur_revenge'&&s.index===1?575:s.kind==='arthur_revenge'?655:710;}
  function anchor(s){
    if(!s)return {x:285,y:65,width:410,tail:'left',speakerX:300,speakerY:290};
    if(isEpilogue(s))return {x:480,y:460,width:700,speakerX:480,speakerY:270,cinematic:true};
    const b=beat(s),i=s.index,t=Number(s.time)||0,who=b?.speaker||'';
    let actorX=who.includes('Da Roça')?265:who.includes('Nikolas')?645:who.includes('Lucas')?190:who.includes('Reeis')?650:who.includes('Menezes')?690:who.includes('Marco')?635:452;
    let actorY=who.includes('Lucas')?322:who.includes('Monstro')?165:who.includes('Armadilha')?380:278;
    if(who.includes('Freddy'))actorX=670;
    if(who.includes('Nicolas'))actorX=650;
    if(who==='Narrador'){actorX=265;actorY=278;}
    if(who.includes('Dedé'))actorX=665;
    if(who==='Arthur')actorX=revengeAnchorX(s);
    if(who==='Aica')actorX=302;
    if(who==='Ravile'){actorX=s.kind==='boss_arthur'?380:480;actorY=s.kind==='boss_arthur'?354:278;}
    if(s.kind==='celebration'){const partySpeakers=[245,645,150,150,645,315,730];actorX=partySpeakers[i]||315;actorY=290;}
    if(s.kind==='intro'){
      if(i===0&&who.includes('Da Roça'))actorX=330+ease(t/1.1)*60;
      if(i===1&&who.includes('Nikolas'))actorX=610+Math.sin(t*2)*5;
      if(i===2&&who.includes('Lucas'))actorX=160;
      if(i===3&&who.includes('Nikolas')){actorX=647-ease(t/3)*35;actorY=268;}
      if(i===5&&who.includes('Nikolas'))actorX=575+ease(t/2.4)*240;
      if(i===6&&who.includes('Da Roça'))actorX=360;
    }else if(s.kind==='outro'){
      if(i===5&&who.includes('Reeis'))actorX=805;
      if(i===3&&who.includes('Lucas'))actorX=220;
    }
    const large=s.kind==='boss_giant',left=large||actorX<480;
    return {x:large?245:left?285:680,y:large?61:65,width:large?390:410,tail:left&&!large?'left':'right',speakerX:clamp(actorX+Math.round(Math.sin(t*.4)*4),40,920),speakerY:actorY+30,safeBottom:large?194:235};
  }
  function draw(c,s){
    if(!c||!s)return;if(isEpilogue(s)){if(window.JorgeEpilogue)JorgeEpilogue.draw(c,s);else{c.fillStyle='#000';c.fillRect(0,0,960,540);}return;}c.save();c.imageSmoothingEnabled=false;c.clearRect(0,0,960,540);
    rect(c,0,0,960,540,s.kind==='boss_giant'?'#25263b':s.kind==='boss_nicolas'&&s.index>=2?'#223647':'#8ec7e1');
    c.save();c.translate(Math.round(Math.sin(s.time*.4)*4),30);
    if(s.kind==='outro')outro(c,s);else if(EXTRA[s.kind])bossFilm(c,s);else intro(c,s);
    c.restore();
    // Small cinema rails replace the former 127px opaque dialogue slab.
    rect(c,0,0,960,24,'#10241ff0');rect(c,0,520,960,20,'#10241fe0');
    const fade=1-clamp(s.time/.28,0,1);
    if(fade>0){c.fillStyle=`rgba(13,29,24,${fade*.65})`;c.fillRect(0,24,960,496);}
    c.restore();
  }
  window.Cinematics={create,update,advance,beat,draw,anchor,timeline,timelinePosition,stateAt,celebrationCast:[...PARTY_CAST],metadata:{intro:INTRO.map(x=>({...x})),outro:OUTRO.map(x=>({...x})),jorge_epilogue:(window.JorgeEpilogue?.shots||[]).map(x=>({...x})),...Object.fromEntries(Object.entries(EXTRA).map(([kind,beats])=>[kind,beats.map(x=>({...x}))]))}};
})();
