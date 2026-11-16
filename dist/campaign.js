/* Campaign data only: chapter order, travel permissions and useful journal guidance. */
(() => {
  'use strict';
  const sceneNames=['A roça','Colégio Adventista','Academia do Caleb','A quadra','Praça Camacan','Favela do Reeis','Caderno do Caos','Campo do Mota','Bigodon','Pátio da escola','Casa de Rayssa','Baile funk'];
  const chapters=[
    {id:'carro',flag:'lucas',scene:0,title:'O carro do pai',description:'Busque três peças nos parkours da roça e leve tudo a Lucas para consertar o carro a gás.'},
    {id:'futebol',flag:'mota',scene:7,title:'Treino de craque',description:'Conheça Gabriel Mota no campo. Vença o desafio de futebol, ganhe experiência e libere o dash.'},
    {id:'cadernos',flag:'almiro',scene:1,title:'Operação caderno',description:'Ajude Almiro a recuperar três cadernos nos corredores e plataformas do colégio.'},
    {id:'english',flag:'miqueias',scene:1,title:'English da resenha',description:'Entre na sala de Miqueias e passe pelo desafio de inglês para despertar as bolinhas elementais.'},
    {id:'braco-forte',flag:'freddy',scene:5,title:'O braço forte do Reeis',description:'Suba a favela e desafie Freddy no pátio antes do rei. O capanga mais forte ainda tira onda do próprio chefe.'},
    {id:'rei-do-morro',flag:'reeis',scene:5,title:'O rei do morro',description:'Atravesse os encontros da favela, enfrente Reeis e peça sua ajuda para resgatar o bolo.'},
    {id:'desenhista',flag:'marco',scene:1,title:'Rabiscos perigosos',description:'Volte ao colégio e enfrente Marco. Cuidado com a armadilha SARUÊ e a fúria vermelha.'},
    {id:'monstro-gigante',flag:'giant',scene:6,title:'O desenho ficou enorme',description:'Explore o Caderno do Caos e derrote o monstro gigante que Marco criou.'},
    {id:'provocacao',flag:'menezes',scene:1,title:'O palco da provocação',description:'Volte ao fim da escola para a luta contra Menezes, suas paredes de palavras e ondas de provocação.'},
    {id:'shape',flag:'trained',scene:2,title:'O treino do bolo',description:'Complete o treino de reflexo de Caleb para ficar bombado e preparar a luta final.'},
    {id:'amizade-bolo',flag:'nikolas',scene:3,title:'Um amigo e um bolo',description:'Leve o carro até a quadra, enfrente Nikolas e decida o futuro dessa amizade.'}
  ];
  const npcEntries={ollyan:{name:'Ollyan · Orelhas ao Vento',scene:11,x:3260,y:440},mota:{name:'Gabriel Mota · craque',scene:7,x:500},davi:{name:'Davi Costa · barbeiro',scene:8,x:520},vitor:{name:'Vitor · ajudante',scene:8,x:850},freddy:{name:'Freddy · braço forte do Reeis',scene:5,x:5680},nicolas:{name:'Nicolas Carvalho',scene:4,x:5350},aica:{name:'Aica',scene:9,x:500},ravile:{name:'Ravile',scene:9,x:670},arthur:{name:'Arthur',scene:9,x:2850},dede:{name:'Dedé · capanga do Reeis',scene:5,x:5000},allef:{name:'Allef · recepção da Bigodon',scene:8,x:240},eloisa:{name:'Eloisa',scene:10,x:450},giselle:{name:'Giselle',scene:10,x:820},rayssa:{name:'Rayssa',scene:10,x:1220},analaura:{name:'Ana Laura',scene:10,x:1580}};
  // Essas resenhas rendem recompensas, mas nunca bloqueiam a busca pelo bolo.
  const sideQuests=[
    {id:'bigodon',flag:'bigodon',scene:8,title:'Na régua da resenha',description:'Visite a Bigodon e converse com Davi Costa para dar uma pausa na aventura e recuperar o fôlego.'},
    {id:'ajudante-bigodon',flag:'vitor',scene:8,title:'O fiscal do degradê',description:'Conheça Vitor, o ajudante de óculos da Bigodon. Até conferir o corte rende uma boa resenha.'},
    {id:'aura-suprema',flag:'nicolas',scene:4,title:'O protagonista de Camacan',description:'Treine o dash com Mota e desafie Nicolas Carvalho no fim da praça. A aura suprema dele esconde uma surpresa.'},
    {id:'ajuda-patio',flag:'arthur',scene:9,title:'Ajuda no pátio',description:'Converse com Ravile e Aica no Pátio da escola. Arthur puxou o cabelo de Ravile; ajude a encerrar essa confusão.'},
    {id:'fumaca-beco',flag:'dede',scene:5,title:'Fumaça no beco',description:'Na favela, encontre Dedé antes da arena de Freddy e desfaça suas cortinas de fumaça. O confronto é opcional.'},
    {id:'resenha-rayssa',flag:'rayssaVisit',scene:10,title:'Aff, veyr, juro',description:'Visite a Casa de Rayssa para conhecer Eloisa, Giselle, Rayssa e Ana Laura. Uma primeira conversa conclui a visita; depois, volte para novas resenhas.'},
    {id:'bivolt-rayssa',flag:'bivoltUnlocked',scene:10,title:'Energia da resenha',description:'Converse com as garotas na Casa de Rayssa. Encontre os três ingredientes nas prateleiras e devolva tudo para liberar o energético Bivolt: dez segundos de atributos turbinados.'},
    {id:'baile-ollyan',flag:'ollyan',scene:11,title:'Orelhas ao vento',description:'Vá ao baile noturno com o carro a gás consertado. Ollyan perdeu o compasso; prepare-se para uma perseguição aérea de três fases. Nível 8 sugerido.'}
  ];
  const ok=()=>({ok:true,reason:''});
  const no=reason=>({ok:false,reason});
  function has(q,key){return !!q?.[key];}
  function canTravel(scene,q={}){
    const n=Number(scene);if(!Number.isInteger(n)||n<0||n>=sceneNames.length)return no('Essa rota ainda não existe.');
    if(n===0)return ok();
    if(!has(q,'lucas'))return no('O carro está quebrado! Colete as três peças na roça e entregue a Lucas.');
    if([1,4,7,8,9,10,11].includes(n))return ok();
    if(n===5){if(!has(q,'mota'))return no('Treine futebol com Mota para liberar o dash antes de subir o morro.');if(!has(q,'almiro'))return no('Ajude Almiro com os três cadernos na primeira sala do colégio.');if(!has(q,'miqueias'))return no('Complete o English da resenha com Miqueias na segunda sala.');return ok();}
    if(n===6)return has(q,'marco')?ok():no('Enfrente Marco no colégio para descobrir a entrada do Caderno do Caos.');
    if(n===2)return has(q,'menezes')?ok():no('Resolva a provocação de Menezes no fim do colégio antes do treino com Caleb.');
    if(n===3){if(!has(q,'giant'))return no('O monstro gigante do Caderno do Caos ainda está solto!');if(!has(q,'menezes'))return no('Derrote Menezes no fim do colégio antes de buscar Nikolas.');if(!has(q,'trained'))return no('Caleb precisa terminar seu treino de reflexo na academia.');return ok();}
    return ok();
  }
  function bossRequirement(type,q={}){
    if(type==='ollyan')return has(q,'lucas')?ok():no('Conserte o carro a gás com Lucas antes de perseguir Ollyan no céu.');
    if(type==='arthur')return has(q,'patioAccepted')?ok():no('Converse com Ravile ou Aica na entrada do Pátio da escola para entender a confusão antes de enfrentar Arthur.');
    if(type==='dede'){
      if(!has(q,'mota'))return no('Treine o dash com Mota antes de enfrentar a fumaça de Dedé.');
      if(!has(q,'almiro')||!has(q,'miqueias'))return no('Complete as missões dos professores para subir a favela e encarar Dedé.');return ok();
    }
    if(type==='nicolas')return has(q,'mota')?ok():no('Aprenda o dash com Mota no campo de futebol antes de desafiar a aura suprema de Nicolas na Praça Camacan.');
    if(type==='freddy'){
      if(!has(q,'mota'))return no('Treine o dash com Mota antes de enfrentar Freddy, o capanga mais forte do Reeis.');
      if(!has(q,'almiro')||!has(q,'miqueias'))return no('Complete as missões de Almiro e Miqueias no colégio antes de desafiar Freddy na favela.');return ok();
    }
    if(type==='reeisBoss'||type==='reeis'){
      if(!has(q,'mota'))return no('Mota precisa ensinar o dash. Procure o craque no campo de futebol.');
      if(!has(q,'almiro')||!has(q,'miqueias'))return no('Termine as missões dos dois professores antes de enfrentar o rei do morro.');
      if(!has(q,'reeis')&&!has(q,'freddy'))return no('Freddy guarda o caminho do rei. Vença o capanga mais forte no pátio anterior, antes de desafiar Reeis.');return ok();
    }
    if(type==='marco'){
      if(!has(q,'almiro')||!has(q,'miqueias'))return no('Ajude Almiro e Miqueias para preparar seus poderes contra Marco.');
      if(!has(q,'reeis'))return no('Primeiro atravesse a favela e convença Reeis a ajudar na busca pelo bolo.');return ok();
    }
    if(type==='giant')return has(q,'marco')?ok():no('Derrote Marco para entrar no desafio do monstro gigante.');
    if(type==='menezes'){
      if(!has(q,'marco'))return no('Marco ainda está espalhando rabiscos no colégio. Enfrente ele primeiro.');
      if(!has(q,'giant'))return no('O monstro gigante bloqueia a conclusão da missão! Vá ao Caderno do Caos.');
      if(!has(q,'almiro')||!has(q,'miqueias'))return no('Complete as duas missões dos professores antes da provocação final.');return ok();
    }
    if(type==='nikolas')return canTravel(3,q);
    return ok();
  }
  const count=(value,fallback=0)=>Array.isArray(value)?new Set(value).size:typeof value==='number'?Math.max(0,Math.floor(value)):fallback;
  function currentQuest(q={},extra={}){
    if(!q.lucas){const parts=Math.min(3,count(q.carParts,count(extra.carParts)));return !q.carMissionAccepted?['O carro não pega','Fale com Lucas na roça. O carro a gás do seu pai precisa de três peças para voltar à aventura.']:parts<3?['Peças pela roça',`${parts}/3 peças encontradas. Atravesse os parkours do pomar, da trilha alta e do riacho. Depois volte a Lucas.`]:['Chave na mão, gás no motor','As três peças estão com você! Volte a Lucas na roça e conserte o carro a gás.'];}
    if(!q.mota)return ['Mota, o craque da escola','Entre no carro e vá ao Campo do Mota. Vença o treino de futebol para ganhar XP e liberar o dash.'];
    if(!q.almiro){const books=Math.min(3,count(q.notebooks,count(extra.notebooks)));if(books>=3)return ['Cadernos recuperados','Volte à primeira sala do colégio e entregue os três cadernos ao professor Almiro.'];return !q.almiroAccepted?['Uma missão com Almiro','No Colégio Adventista, entre na primeira sala com E e converse com Almiro.']:['Operação caderno',`${books}/3 cadernos recuperados. Explore as plataformas e corredores antes de Marco; devolva tudo na sala de Almiro.`];}
    if(!q.miqueias)return ['ALLRIGHT! Hora do English','Entre na segunda sala do colégio e faça o desafio de Miqueias. Ele vai liberar seu poder elemental.'];
    if(!q.reeis&&!q.freddy)return ['Freddy segura a passagem','Suba a Favela do Reeis e desafie Freddy no pátio antes do rei. O braço forte do chefe também é o primeiro a gritar REEEIS!'];
    if(!q.reeis)return ['Um reforço no alto do morro','Use o carro para chegar à Favela do Reeis. Os inimigos ficam mais fortes no caminho; vença Reeis para pedir sua ajuda.'];
    if(!q.marco)return ['O desenhista do caos','Volte ao Colégio Adventista, atravesse os rabiscos e enfrente Marco. Pisar em SARUÊ desperta sua fúria vermelha!'];
    if(!q.giant)return ['Um monstro de outro tamanho','Entre no carro e vá ao Caderno do Caos. No fim do caminho, enfrente o monstro gigante desenhado por Marco.'];
    if(!q.menezes)return ['A provocação tem endereço','Volte ao final do colégio e enfrente Menezes. Pule as ondas, desvie dos ecos e encontre as brechas nas paredes de palavras.'];
    if(!q.trained)return ['Caleb vai cobrar esse treino',q.training?'Retome o treino na academia: acerte o marcador na faixa verde em três rodadas para ganhar seu novo shape.':'Vá à academia e converse com Caleb. O treino de reflexo vai deixar Da Roça bombado para o confronto final.'];
    if(!q.nikolas)return ['O último pedaço do bolo','A quadra está liberada. Entre no carro, enfrente Nikolas e use o que aprendeu: dash, combos, bolinhas elementais e OHHHH REEEEIS!'];
    if(q.jorgeSeen)return ['Uma ligação. Um novo capítulo.','JORGE ligou. O próximo capítulo aguarda uma nova atualização. Enquanto isso, explore os doze lugares, visite a Casa de Rayssa e reencontre a turma.'];
    return ['O bolo e a resenha voltaram','O bolo voltou e o açaí de quarta-feira está garantido. Explore os doze lugares e visite a Casa de Rayssa; depois da festa, uma ligação muda a resenha.'];
  }
  // Saves antigos que já recrutaram Reeis mantêm o capítulo e a campanha concluídos.
  function chapterDone(c,q){return !!q[c.flag]||(c.flag==='freddy'&&!!q.reeis);}
  function chapterState(q={}){return chapters.map((c,index)=>({...c,index:index+1,complete:chapterDone(c,q)}));}
  function sideQuestState(q={}){
    const rows=sideQuests.map(c=>({...c,complete:!!q[c.flag],...(c.flag==='arthur'&&q.patioAccepted&&!q.arthur?{description:'Ravile e Aica pediram ajuda. Encontre Arthur no fim do pátio e encerre a confusão sem puxar o cabelo de ninguém.'}:{})}));
    for(const [id,scene,title,description]of [['zefa',0,'O pedido de Dona Zefa','Fale com Dona Zefa, resolva a bomba do pomar, confira o caixote de frutas e volte à quitanda.'],['tonico',8,'Circuito limpo, praça acesa','Converse com Seu Tonico na Bigodon. Conserte as luzes da Camacan, complete a coleta do pátio e volte para receber seus materiais.']])rows.push({id:'vida-'+id,scene,title,description,complete:!!q.worldLife?.quests?.[id]?.done});
    for(const [id,scene,title]of [['pump-roca',0,'Água para o pomar'],['sort-school',1,'Coleta no corredor'],['switch-camacan',4,'Acenda a Praça Camacan'],['pump-campo',7,'Bolas no ponto'],['sort-patio',9,'Mutirão do recreio'],['switch-baile',11,'Luzes para o show']])rows.push({id:'vida-'+id,scene,title,description:'Encontre o objeto com este nome e complete o desafio. A primeira vitória dá XP e materiais; depois, pratique para melhorar seu recorde.',complete:!!q.worldLife?.completed?.[id]});
    return rows;
  }
  function completion(q={}){return Math.round(chapters.filter(c=>chapterDone(c,q)).length/chapters.length*100);}
  const rewards={repair:180,football:220,footballReplay:70,almiro:240,miqueias:240,bigodon:120,vitor:60,freddy:420,nicolas:700,arthur:450,dede:340,reeisBoss:550,marco:480,giant:800,menezes:600,training:300,nikolas:1000,rayssaVisit:90,bivoltUnlocked:180,ollyan:700};
  const data={version:'3.4.0',sceneNames,chapters,sideQuests,npcEntries,rewards,canTravel,bossRequirement,currentQuest,chapterState,sideQuestState,completion,repairParts:['fan','pipe','spark'],notebookIds:['caderno-01','caderno-02','caderno-03']};
  function freeze(o){if(o&&typeof o==='object'){Object.values(o).forEach(freeze);Object.freeze(o);}return o;}
  window.Campaign=freeze(data);
})();
