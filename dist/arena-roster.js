/* Elenco da Arena da Resenha: identidade, leitura dos golpes e orçamento comum. */
(() => {
 'use strict';
 const rows=[
  ['daroca','Da Roça','Gás no talo','#e8a35d','Cotovelada do chapéu','Papel propulsor','Trinca do feijão','Meu combustível é caseiro, pô!','elbow','paper','gascombo','chapeu','passinho'],
  ['reeis','Gabriel REEEIS','O rei chegou','#67d5ce','Coronhada do rei','Rajada da favela','Bonde do REEEIS','OHHHH REEEEIS! Chamou, chegou!','gunbutt','bullet','army','rei','ombro'],
  ['nikolas','Nikolas Arroganti','Fome de bolo','#c6a4ee','Soco da arrogância','Catarro de batata','Fome de gigante','O bolo tava dando sopa, Da Roça!','nosepunch','goo','muscle','nariz','arrogante'],
  ['marco','Marco','Rabisco do caos','#fa7978','Régua do desenhista','Brainrot de bolso','SARUÊ EM FÚRIA','Chamou de saruê? Agora segura o desenho!','ruler','brainrot','sketch','desenho','rabisco'],
  ['menezes','Menezes','Provocação física','#9fd4ae','Arranhão do rato','Palavra que pega ar','Atalho do esgoto','Da Roça pegou ar! Teketeketeke!','claw','words','sewer','rato','teketeke'],
  ['ollyan','Ollyan','Turbina de orelha','#b4a5ff','Orelhada cruzada','Rajada de vento','Ventilador nervoso','Sai da frente que a orelha decolou!','ear','wind','earspin','orelha','ventilador'],
  ['igor','Igor','O fiscal do lanche','#73b8f6','Soco sem merenda','Ondão da barriga','Rebate na barriga','Cadê o lanche, pivete? Fortalece o pai!','punch','bellywave','bellybounce','lanche','barriga'],
  ['kaique','Kaique','Fiscal da sala','#b8d3df','Coronhada fiscal','Rajada confiscada','IRACI, VOLTA PRA SALA!','Ô pivete, entrega essas bolinhas aí, moral!','stock','bullet','inspection','sala','fiscal'],
  ['freddy','Freddy','O capanga ligeiro','#efb56e','Cotovelada OPEESTY','Pedrada do capanga','Passinho da pancada','OPEESTY DA ROÇA! Bora ver se é ligeiro!','capoeira','stone','freddyspin','opeesty','capanga'],
  ['dede','Dédé','Nuvem de resenha','#b7b1c6','Tapa esfumaçado','Anel de fumaça','SEU GILÓ HOMI!','SEU GILÓ HOMI! Perdeu na fumaça, foi?','smokepalm','smoke','smokelift','aparelho','fumaca'],
  ['arthur','Arthur','Mestre do tapa','#efb1c5','Tapa atravessado','Tapão de vento','Sequência bestaiada','Eu só encostei, veyr!','slap','palm','slapcombo','pose','passinho'],
  ['nicolas','Nicolas Carvalho','Protagonista supremo','#f4d981','Punho do protagonista','Faísca da aura','Cena principal','Essa luta já tava no meu roteiro!','divinepunch','light','divine','aura','protagonista'],
  ['giant','Monstro 67','Do caderno à arena','#b0ed76','Soco SIX','SEVEN voador','SIX… SEVEN!','SIX... SEVEN!','stonefist','six','sixtyseven','sixseven','sixseven'],
  ['caleb','Caleb','Shape de respeito','#ffd083','Supino de mão','Anilha voadora','Leg day sísmico','Esse cardio tá com cheiro de peido, meu filho!','dumbbell','weight','stomp','shape','supino'],
  ['lucas','Lucas Sapo','Baixinho, língua longa','#b4c6d5','Golpe baixo do Sapo','Língua de sapo','Bolo no ponto baixo','Foi golpe baixo? Eu já sou baixo, pô!','lowblow','tongue','frogcombo','sapo','pulinho'],
  ['kaua','Kaua','Oficina escolar','#82cdb7','Réguada da oficina','Caneta propulsora','Estojo sem limite','Ummhumhumm... Oprai Da Roça!','rulertool','pen','schoolarsenal','inventor','oficina'],
  ['mota','Mota','Craque da quadra','#a8d1ff','Chute de primeira','Bola que volta','Domínio e golaço','Foi mal, a bola voltou pro pé porque tem contrato!','footballkick','ball','juggle','embaixadinha','futebol'],
  ['ravid','Ravid','Conversa com a parede','#b3d5df','Gestão de monólogo','Assunto atravessado','Debate com a parede','Eu tava falando aqui comigo mesmo…','point','monologue','wallrant','parede','conversa'],
  ['almiro','Professor Almiro','Careca reluzente','#8fcdff','Chamada na palma','Giz reluzente','Reflexo da careca','Ahahaha, Da Roça sacana é com cerveja!','teacherpalm','chalk','baldflash','careca','recreio'],
  ['miqueias','Professor Miqueias','English do jeito dele','#efad76','Réguada ALLRIGHT','Concorda ou sem corda','BEAUTIFUL, beleza Creuza','You is pronto for the surra? É ou não é?','teacheruler','english','englishcombo','allright','english'],
  ['davi','Davi Costa','Corte da resenha','#a5c9df','Máquina na régua','Pente bumerangue','Degradê giratório','Senta que esse corte agora é na tua marra!','clipper','comb','barberchair','degrade','tesourinha'],
  ['vitor','Vitor','Ajudante ligeiro','#b9c5d7','Toalhada certeira','Escova que retorna','Acabamento expresso','Já marquei teu horário pra tomar essa resenha!','towel','brush','towelspin','oculos','escova'],
  ['allef','Allef','Recepção sem filtro','#ffca88','Tapão da senha','Ficha da provocação','A FILA ANDOU','Teu chapéu pegou senha e perdeu a vez!','receiptslap','ticket','queue','recepcao','fila'],
  ['aica','Aica','Não se passa','#ffc5cd','Chute se toca','Salto que volta','Joelhada OPEEESTI','Se toca, bestaiado! Aff veyr juro!','heelkick','heel','girlknee','deboche','deboche'],
  ['ravile','Ravile','Resenha com troco','#e7b4ea','Pernada você se passou','Salto do troco','Joelhada da revanche','Idiota, você se passou! Aff veyr juro!','roundkick','heel','girlknee','deboche','deboche'],
  ['eloisa','Eloisa','Comentário certeiro','#ffa5cf','Salto no argumento','Salto rosa bumerangue','Joelhada se toca','Aff veyr juro, menino, se toca!','highkick','heel','girlknee','deboche','deboche'],
  ['giselle','Giselle','Trança e presença','#c8a2fc','Giro de perna','Salto crochet','Joelhada sem filtro','Aff veyr juro, você se passou bonito!','spinkick','heel','girlknee','deboche','deboche'],
  ['rayssa','Rayssa','Dona da resenha','#8ee5c3','Pernada da dona da casa','Salto da varanda','Joelhada da casa','Na minha casa a vergonha tem limite. Aff veyr juro!','sidekick','heel','girlknee','deboche','deboche'],
  ['analaura','Ana Laura','Riso com resposta','#e8bddf','Salto no deboche','Salto sem paciência','Joelhada aff veyr','Aff veyr juro… foi isso tudo pra errar?','backkick','heel','girlknee','deboche','deboche']
 ];
 const kits=rows.map(([id,name,title,color,physical,ranged,combo,quote,style,shot,comboStyle,emote,dance])=>Object.freeze({
  id,name,title,color,physical,ranged,combo,basic:physical,special:ranged,ultimate:combo,quote,style,shot,comboStyle,
  skill:style,superSkill:comboStyle,speed:id==='lucas'?1.08:1,health:1,weight:1,renderHeight:id==='lucas'?60:70,
  hitbox:Object.freeze({w:34,h:id==='lucas'?60:70}),
  emote:Object.freeze({id:emote,text:id==='mota'?'FARMANDO AURA':quote,duration:1.8}),
  dance:Object.freeze({id:dance,text:id==='menezes'?'TEKETEKETEKE':id==='mota'?'OLHA O DOMÍNIO':id==='caleb'?'CARDIO DO SHAPE':'PASSINHO DA RESENHA',duration:3})
 }));
 const byId=new Map(kits.map(k=>[k.id,k]));
 window.ArenaRoster=Object.freeze({version:2,all:Object.freeze(kits),get:id=>byId.get(id)||kits[0]});
})();
