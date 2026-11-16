/* Da Roça Adventure 3.7 — doze ambientes, rotas seguras e novas resenhas. */
(() => {
  'use strict';
  const floor=440;
  const widths=[4800,6200,5000,5200,6000,7200,6600,4800,3600,4200,3600,4800];
  // Cada degrau sobe no máximo 64 px; as cadeias sobre os vãos funcionam sem voo.
  const platforms=[
    [
      [1060,384,150],[1250,328,140],
      [1390,384,150],[1580,328,150],[1770,384,150],
      [1990,376,150],[2180,312,140],[2360,248,140],[2540,312,150],
      [2720,384,150],[2910,328,150],[3100,384,150],
      [3320,376,150],[3510,312,150],[3700,376,150],
      [3960,384,150],[4150,320,150],[4340,384,150]
    ],
    [
      [1030,384,140],[1200,384,140],
      [1590,384,150],[1780,328,150],[1970,384,150],
      [2500,384,140],[2690,320,150],[2880,256,140],[3060,320,150],
      [4150,384,140],[4330,328,150],[4520,384,150],
      [4700,376,145],[4885,312,150],[5075,376,145],
      [5740,384,150],[5930,320,140]
    ],
    [
      [760,384,150],[950,320,150],[1140,376,150],
      [1240,384,150],[1430,328,150],[1620,384,150],
      [1820,376,140],[2000,312,150],[2190,248,140],[2370,312,150],
      [2540,384,150],[2730,328,150],[2920,384,150],
      [3140,376,150],[3330,312,150],[3520,376,150],
      [3840,384,150],[4030,328,150],[4220,384,150],
      [4460,376,150],[4650,312,150]
    ],
    [
      [650,384,150],[840,320,140],[1020,376,145],
      [1140,384,150],[1330,328,150],[1520,384,150],
      [1720,376,150],[1910,312,150],[2100,248,140],[2280,312,145],
      [2420,384,150],[2610,328,150],[2800,384,150],
      [3040,376,145],[3225,312,145],
      [3440,384,150],[3630,328,140],[3810,384,150],
      [4850,384,145],[5030,320,140]
    ]
  ];
  // Vãos do cenário recebem pontes no mesmo nível do piso físico seguro, y=440.
  const gaps=[
    [[1450,360],[2780,380],[4020,360]],
    [[1080,180],[1660,340],[4200,350]],
    [[1300,330],[2600,360],[3900,340]],
    [[1200,320],[2480,360],[3500,250]]
  ];
  const gapCheckpoints=gaps.map(scene=>scene.map(([x])=>x-140));
  const checkpoints=[
    [230,940,1310,1950,2640,3300,3880,4550],
    [230,810,940,1410,1520,2110,2460,3300,4060,4630,5750],
    [230,660,1160,1760,2460,3070,3760,4380,4840],
    [230,560,1060,1690,2340,2960,3360,3850,4800]
  ];
  const doors=[
    {id:'almiro',teacher:'almiro',scene:1,x:1350,label:'SALA DO ALMIRO',width:960,exitX:90,teacherX:600},
    {id:'miqueias',teacher:'miqueias',scene:1,x:2350,label:'SALA DO MIQUEIAS',width:960,exitX:90,teacherX:600}
  ];
  const bosses={igor:{scene:1,x:1810},kaique:{scene:1,x:3000},marco:{scene:1,x:3700},menezes:{scene:1,x:5200},nikolas:{scene:3,x:4300}};
  // Corredor dos rabiscos: seis criaturas físicas antes da arena do desenhista.
  // Os monitores substituem os rabiscos pequenos apenas nos corredores da escola.
  const minions=[];
  const schoolCovers=[{x:1510,width:66,label:'ARMÁRIOS'},{x:2130,width:70,label:'ARMÁRIOS'},{x:2770,width:68,label:'ARMÁRIOS'},{x:3190,width:72,label:'ARMÁRIOS'}];
  const iraciTraps=[{scene:1,x:3120,width:84}];
  // Plataformas relativas ao centro da arena (homeX), com silhuetas próprias por chefe.
  const arenaPlatforms={
    marco:[[-330,384,150],[-140,320,145],[45,256,140],[225,320,150]],
    menezes:[[-350,384,155],[-155,320,150],[35,256,150],[225,320,145]],
    nikolas:[[-325,384,145],[-140,320,150],[50,256,145],[235,320,145]]
  };
  arenaPlatforms.igor=[[-285,360,130],[170,360,130]];
  arenaPlatforms.kaique=[[-300,364,135],[-90,300,140],[150,364,135]];
  const arenaBounds={igor:[-430,430],kaique:[-430,430],marco:[-430,430],menezes:[-430,430],nikolas:[-430,430]};
  const parkourZones=[
    {scene:0,from:1020,to:1950,name:'Cercas do milho',theme:'wood'},
    {scene:0,from:2150,to:3300,name:'Trilha do pomar',theme:'wood'},
    {scene:0,from:3890,to:4550,name:'Travessia do riacho',theme:'wood'},
    {scene:1,from:1020,to:1420,name:'Passarela das salas',theme:'school'},
    {scene:1,from:1530,to:2130,name:'Obra no corredor',theme:'school'},
    {scene:1,from:2500,to:3320,name:'Ronda dos monitores',theme:'school'},
    {scene:1,from:4140,to:4750,name:'Escadaria da provocação',theme:'words'},
    {scene:2,from:730,to:1780,name:'Circuito do leg day',theme:'gym'},
    {scene:2,from:1980,to:3090,name:'Barras de respeito',theme:'gym'},
    {scene:2,from:3780,to:4410,name:'Travessia dos halteres',theme:'gym'},
    {scene:3,from:620,to:1690,name:'Arquibancada elevada',theme:'court'},
    {scene:3,from:1890,to:2970,name:'Circuito dos cones',theme:'court'},
    {scene:3,from:3390,to:3960,name:'Reta final da quadra',theme:'court'}
  ];
  const foreshadow=[
    {scene:1,x:2570,type:'drawing',text:'OS RABISCOS ESTÃO VIVOS'},
    {scene:1,x:3070,type:'drawing',text:'MARCO DESENHOU. AGORA CORRE.'},
    {scene:1,x:4420,type:'blackboard',text:'DA ROÇA PEGOU AR'},
    {scene:1,x:4760,type:'blackboard',text:'TEKETEKETEKETEKE'},
    {scene:1,x:4920,type:'blackboard',text:'DA ROÇA POUDIAAAM'}
  ];
  // Recompensas extras convidam a explorar os caminhos altos sem bloquear as missões.
  const collectibles=[
    {id:'parkour-farm-01',scene:0,x:1320,y:294,type:'gas'},
    {id:'parkour-farm-02',scene:0,x:2430,y:214,type:'paper'},
    {id:'parkour-farm-03',scene:0,x:4220,y:286,type:'gas'},
    {id:'parkour-school-01',scene:1,x:1850,y:294,type:'paper'},
    {id:'parkour-school-02',scene:1,x:2950,y:222,type:'gas'},
    {id:'parkour-school-03',scene:1,x:4400,y:294,type:'paper'},
    {id:'parkour-gym-01',scene:2,x:1020,y:286,type:'gas'},
    {id:'parkour-gym-02',scene:2,x:2260,y:214,type:'paper'},
    {id:'parkour-gym-03',scene:2,x:4100,y:294,type:'gas'},
    {id:'parkour-court-01',scene:3,x:1400,y:294,type:'paper'},
    {id:'parkour-court-02',scene:3,x:2170,y:214,type:'gas'},
    {id:'parkour-court-03',scene:3,x:3700,y:294,type:'paper'}
  ];
  // Novas regiões são cenários fictícios inspirados na cidade e no universo do jogo.
  const newGaps=[
    [[1420,320],[2860,360],[4310,320]],
    [[1680,280],[3290,320],[4910,300]],
    [[1420,320],[2580,350],[3810,330]],
    [[1880,300],[3210,340]]
  ];
  const highRoutes=[
    [[740,384,150],[930,320,150],[1120,384,150],[2130,376,150],[2320,312,150],[2510,248,140],[2690,312,145],[3650,384,150],[3840,320,150],[4030,384,150],[5100,376,150],[5290,312,150],[5480,376,150]],
    [[670,384,150],[860,320,150],[1050,256,140],[1230,320,145],[2440,384,150],[2630,320,150],[2820,384,150],[3980,384,150],[4170,320,150],[4360,256,145],[4545,320,150],[5480,384,150],[5670,320,150]],
    [[610,384,150],[800,320,150],[990,256,140],[1170,320,145],[1970,384,150],[2160,320,150],[2350,384,150],[3200,384,150],[3390,320,150],[3580,256,140],[3760,320,145],[4470,384,150],[4660,320,150],[4850,384,150]],
    [[790,384,150],[980,320,150],[1170,384,150],[2290,376,150],[2480,312,150],[2670,248,145],[2855,312,150],[3850,384,150],[4040,320,150],[4230,384,150]]
  ];
  newGaps.forEach((sceneGaps,i)=>{
    const index=i+4,chain=[];
    for(const [x,width] of sceneGaps)chain.push([x-60,384,150],[x+130,328,150],[x+width,384,150]);
    platforms.push([...highRoutes[i],...chain].sort((a,b)=>a[0]-b[0]));gaps.push(sceneGaps);
    gapCheckpoints.push(sceneGaps.map(([x])=>x-140));
    checkpoints.push([...new Set([230,...sceneGaps.map(([x])=>x-140),...sceneGaps.map(([x,w])=>x+w+170),widths[index]-180])].sort((a,b)=>a-b));
  });
  // A Bigodon é uma parada de resenha: piso contínuo, cadeiras no salão e coletas nas prateleiras.
  platforms.push([[1250,384,150],[1450,328,150],[1820,384,150],[2020,328,150],[2220,384,150],[2740,384,150],[2940,328,150],[3140,384,150]]);
  gaps.push([]);gapCheckpoints.push([]);checkpoints.push([230,1050,1740,2660,3380]);
  parkourZones.push({scene:8,from:1210,to:1630,name:'Prateleiras do degradê',theme:'barbershop'},{scene:8,from:1800,to:2410,name:'Passarela dos pentes',theme:'barbershop'},{scene:8,from:2700,to:3350,name:'Arquivo da resenha',theme:'barbershop'});
  collectibles.push({id:'bigodon-alto-01',scene:8,x:1520,y:294,type:'gas'},{id:'bigodon-alto-02',scene:8,x:2090,y:294,type:'paper'},{id:'bigodon-alto-03',scene:8,x:3010,y:294,type:'gas'});
  // O pátio mantém o branco e azul-marinho do colégio, com passagem contínua sob os parkours.
  platforms.push([[1050,384,150],[1240,328,150],[1430,384,150],[1740,376,150],[1930,312,150],[2120,376,150],[3410,384,150],[3600,328,150],[3790,384,150]]);
  gaps.push([]);gapCheckpoints.push([]);checkpoints.push([230,940,1650,2370,3330,4010]);
  parkourZones.push({scene:9,from:1020,to:1620,name:'Bancos do recreio',theme:'school'},{scene:9,from:1710,to:2310,name:'Passarela do pátio',theme:'school'},{scene:9,from:3370,to:3980,name:'Caminho da cantina',theme:'school'});
  collectibles.push({id:'patio-alto-01',scene:9,x:1310,y:294,type:'gas'},{id:'patio-alto-02',scene:9,x:2000,y:278,type:'paper'},{id:'patio-alto-03',scene:9,x:3670,y:294,type:'gas'});
  // A casa é uma visita social: recepção livre, piso contínuo e prateleiras baixas ao fundo.
  platforms.push([[1920,384,150],[2110,328,150],[2300,384,150],[2670,384,150],[2860,328,150],[3050,384,150]]);
  gaps.push([]);gapCheckpoints.push([]);checkpoints.push([230,420,1060,1650,1840,2580,3390]);
  parkourZones.push({scene:10,from:1880,to:2490,name:'Prateleiras da sala',theme:'house'},{scene:10,from:2630,to:3260,name:'Varanda da resenha',theme:'house'});
  collectibles.push({id:'casa-rayssa-alto-01',scene:10,x:2180,y:294,type:'gas'},{id:'casa-rayssa-alto-02',scene:10,x:2930,y:294,type:'paper'});
  // O baile tem piso contínuo: a batalha aérea acontece em um modo separado.
  platforms.push([[1070,384,150],[1260,328,150],[1450,384,150],[2080,384,150],[2270,328,150],[2460,384,150],[3840,384,150],[4030,328,150],[4220,384,150]]);
  gaps.push([]);gapCheckpoints.push([]);checkpoints.push([230,950,1820,2740,3160,3750,4560]);
  parkourZones.push({scene:11,from:1020,to:1650,name:'Passarela dos refletores',theme:'baile'},{scene:11,from:2020,to:2640,name:'Camarote da resenha',theme:'baile'},{scene:11,from:3780,to:4410,name:'Bastidores do palco',theme:'baile'});
  collectibles.push({id:'baile-alto-01',scene:11,x:1330,y:294,type:'gas'},{id:'baile-alto-02',scene:11,x:2340,y:294,type:'paper'},{id:'baile-alto-03',scene:11,x:4100,y:294,type:'gas'});
  bosses.reeisBoss={scene:5,x:6400};bosses.giant={scene:6,x:5650};
  bosses.freddy={scene:5,x:5680};bosses.nicolas={scene:4,x:5350};
  bosses.dede={scene:5,x:5000};bosses.arthur={scene:9,x:2850};
  arenaPlatforms.reeisBoss=[[-350,384,155],[-155,320,150],[35,256,150],[225,320,145]];
  arenaPlatforms.giant=[[-370,384,150],[-185,320,150],[35,256,150],[220,320,150],[320,384,145]];
  arenaBounds.reeisBoss=[-430,430];arenaBounds.giant=[-470,470];
  arenaPlatforms.freddy=[[-300,384,140],[-100,320,140],[100,320,140],[280,384,120]];
  arenaPlatforms.nicolas=[[-300,384,140],[-100,320,140],[100,320,140],[280,384,120]];
  arenaBounds.freddy=[-400,400];arenaBounds.nicolas=[-400,400];
  arenaPlatforms.dede=[[-280,384,130],[-90,320,140],[120,384,140]];
  arenaPlatforms.arthur=[[-280,384,130],[-90,320,140],[120,384,140]];
  arenaBounds.dede=[-360,360];arenaBounds.arthur=[-360,360];
  // Coletas têm nomes próprios: peças do carro nunca gastam materiais da oficina.
  const questPickups=[
    {id:'fan',type:'carPart',scene:0,x:1320,y:294,label:'Ventoinha do carro'},
    {id:'pipe',type:'carPart',scene:0,x:2430,y:214,label:'Cano de gás'},
    {id:'spark',type:'carPart',scene:0,x:4220,y:286,label:'Vela de ignição'},
    {id:'caderno-01',type:'notebook',scene:1,x:1640,y:350,label:'Caderno de exercícios'},
    {id:'caderno-02',type:'notebook',scene:1,x:2050,y:350,label:'Caderno de revisão'},
    {id:'caderno-03',type:'notebook',scene:1,x:2950,y:222,label:'Caderno de desafio'}
  ];
  const sarueTraps=[{id:'sarue-marco-01',scene:1,x:3420,width:70,target:'marco',label:'SARUÊ'}];
  const rageMinions=[
    {type:'doodle',kind:1,design:'brainrot',variant:'brainrot',hp:72,damage:12,range:65,provocation:'BRAINROT POUDII!',xp:45},
    {type:'doodle',kind:2,design:'sixseven',variant:'sixseven',hp:80,damage:13,range:50,provocation:'SIX SEVEN!',xp:50},
    {type:'doodle',kind:0,design:'spindle',variant:'spindle',hp:76,damage:12,range:95,provocation:'TRRRR! GIRO POUDII!',xp:48},
    {type:'doodle',kind:1,design:'wobbler',variant:'wobbler',hp:78,damage:13,range:75,provocation:'BALANÇA MAS NÃO CAI!',xp:48},
    {type:'doodle',kind:2,design:'pasta',variant:'pasta',hp:82,damage:14,range:60,provocation:'MACARRÃO DA CONFUSÃO!',xp:52}
  ];
  const doodlePhrases=['Da roça pegou ar!','Poudiaaam!','Teketeketeketeke!','SIX SEVEN!','Marco desenhou, agora corre!'];
  minions.forEach((m,i)=>Object.assign(m,{type:'doodle',tier:1+Math.floor(i/2),level:2+Math.floor(i/2),hp:48+i*4,xp:30+i*3,design:['ink','brainrot','sixseven','spindle','wobbler','pasta'][i%6],provocation:doodlePhrases[i%doodlePhrases.length]}));
  [1050,1930,2370,3420,3820,4800].forEach((x,i)=>minions.push({id:'praca-rabisco-'+(i+1),scene:4,x,y:floor,type:'doodle',kind:i%3,tier:1+Math.floor(i/3),level:1+Math.floor(i/2),hp:34+i*4,range:45,damage:6+Math.floor(i/2),xp:25+i*3,design:i%2?'brainrot':'ink',provocation:doodlePhrases[i%doodlePhrases.length]}));
  // Encontros de ação cartunesca: os inimigos do jogo não representam moradores reais.
  // Os grupos deixam as arenas de Dedé e Freddy e as conversas pós-luta com espaço seguro.
  const thugPositions=[850,1060,1270,1480,1740,1960,2180,2400,2680,2900,3120,3340,3560,3780,3990,4200];
  thugPositions.forEach((x,i)=>{const tier=1+Math.floor(i/4),weapon=tier===1?'pistol':tier===2?(i%2?'scatter':'pistol'):tier===3?(i%2?'carbine':'scatter'):(i%3?'carbine':'scatter');minions.push({id:'favela-encontro-'+String(i+1).padStart(2,'0'),scene:5,x,y:floor,type:'thug',kind:2,tier,level:1+Math.floor(i/2),weapon,hp:[38,58,84,116][tier-1],range:i===15?35:45,damage:[8,10,13,16][tier-1],xp:24+tier*12,provocation:['O rei tá esperando!','Não passa sem encarar!','Essa rua é desafio de verdade!','Você quer falar com o Reeis?'][i%4]});});
  [850,1150,1900,2250,3100,3470,4250,4550].forEach((x,i)=>minions.push({id:'caderno-monstro-'+(i+1),scene:6,x,y:floor,type:'doodle',kind:i%3,tier:3+Math.floor(i/4),level:6+Math.floor(i/2),hp:85+i*7,range:45,damage:12+Math.floor(i/3),xp:45+i*4,design:['spindle','wobbler','pasta','brainrot','sixseven'][i%5],variant:['spindle','wobbler','pasta','brainrot','sixseven'][i%5],provocation:['GIRO POUDII!','BALANÇA MAS NÃO CAI!','MACARRÃO DA CONFUSÃO!','O desenho vai pegar ar!','SIX SEVEN!'][i%5]}));
  const zoneNames=[['Fontes e passarelas','Calçadão do rio','Mirante de Camacan'],['Escadaria do morro','Telhados da travessa','Passagem dos becos'],['Papel rasgado','Pontes de tinta','Reta dos rabiscos'],['Arquibancadas do treino','Circuito dos cones']];
  newGaps.forEach((gs,i)=>gs.forEach(([x,w],j)=>parkourZones.push({scene:i+4,from:x-150,to:x+w+180,name:zoneNames[i][j],theme:['square','favela','ink','football'][i]})));
  foreshadow.push(
    {scene:1,x:1540,type:'sign',text:'MONITORES EM RONDA · ARMÁRIOS ESCONDEM'},
    {scene:1,x:2550,type:'sign',text:'KAIQUE FISCALIZA AS BOLINHAS DE PAPEL'},
    {scene:4,x:440,type:'sign',text:'PRAÇA CAMACAN · ITABUNA'},
    {scene:4,x:3300,type:'sign',text:'RIO CACHOEIRA'},
    {scene:5,x:680,type:'sign',text:'SUBA ATÉ O REEIS'},
    {scene:5,x:3580,type:'drawing',text:'O DESAFIO FICA MAIS FORTE'},
    {scene:5,x:4560,type:'sign',text:'DEDÉ · A FUMAÇA DO BECO'},
    {scene:5,x:5270,type:'sign',text:'FREDDY · O BRAÇO FORTE DO REEIS'},
    {scene:5,x:6000,type:'sign',text:'O REI DO MORRO'},
    {scene:6,x:700,type:'drawing',text:'CADERNO DO CAOS'},
    {scene:6,x:5100,type:'drawing',text:'MARCO DESENHOU GRANDE DEMAIS'},
    {scene:7,x:360,type:'sign',text:'CAMPO DO MOTA · TREINO DE CRAQUE'},
    {scene:4,x:4940,type:'sign',text:'NICOLAS CARVALHO · AURA SUPREMA?'},
    {scene:8,x:360,type:'sign',text:'BIGODON · BARBA, CABELO E RESENHA'},
    {scene:8,x:1120,type:'sign',text:'DAVI CORTA. VITOR CONFERE. A RESENHA NÃO PARA.'},
    {scene:8,x:110,type:'sign',text:'ALLEF · RECEPÇÃO DA BIGODON'},
    {scene:9,x:360,type:'sign',text:'PÁTIO DO COLÉGIO ADVENTISTA'},
    {scene:9,x:900,type:'sign',text:'RECREIO BOM É SEM PUXAR CABELO'},
    {scene:9,x:2400,type:'sign',text:'ARTHUR · RESOLVA A CONFUSÃO DO PÁTIO'},
    {scene:10,x:290,type:'sign',text:'CASA DE RAYSSA · CHEGA NA RESENHA'},
    {scene:10,x:1800,type:'sign',text:'AFF, VEYR, JURO · A CONVERSA CONTINUA'},
    {scene:11,x:340,type:'sign',text:'BAILE FUNK · A NOITE DA RESENHA'},
    {scene:11,x:2840,type:'sign',text:'OLLYAN · ORELHAS AO VENTO'}
  );
  [[4,1000,286],[4,2580,214],[4,5360,278],[5,1120,222],[5,2730,286],[5,4430,222],[6,1060,222],[6,3460,286],[6,4730,286],[7,1050,286],[7,2740,214],[7,4110,286]].forEach(([scene,x,y],i)=>collectibles.push({id:'campanha-alto-'+(i+1),scene,x,y,type:i%2?'paper':'gas'}));
  const sceneNames=['A roça','Colégio Adventista','Academia do Caleb','A quadra','Praça Camacan','Favela do Reeis','Caderno do Caos','Campo do Mota','Bigodon','Pátio da escola','Casa de Rayssa','Baile funk'];
  const npcEntries={ollyan:{name:'Ollyan · Orelhas ao Vento',scene:11,x:3260,y:440},allef:{name:'Allef · recepção da Bigodon',scene:8,x:240},eloisa:{name:'Eloisa',scene:10,x:450},giselle:{name:'Giselle',scene:10,x:820},rayssa:{name:'Rayssa',scene:10,x:1220},analaura:{name:'Ana Laura',scene:10,x:1580}};
  const landmarks={school:{name:'COLÉGIO ADVENTISTA',wall:'#f6f7f1',trim:'#17385d',chair:'#28569a',board:'#81c8c2'},square:{name:'Praça Camacan',officialName:'Praça Otávio Mangabeira',inspiration:'Itabuna, Bahia',river:'Rio Cachoeira'},bigodon:{name:'BIGODON',kind:'barbershop',barber:'Davi Costa',assistant:'Vitor',inspiration:'Uma barbearia fictícia da turma',floor:440},patio:{name:'PÁTIO DO COLÉGIO ADVENTISTA',wall:'#f6f7f1',trim:'#17385d',floor:440,kind:'school-courtyard'},rayssaHouse:{name:'CASA DE RAYSSA',kind:'house',floor:440,width:3600,residents:['eloisa','giselle','rayssa','analaura'],inspiration:'Uma casa fictícia da turma para conversar e explorar'},baileFunk:{name:'BAILE FUNK',kind:'night-party',floor:440,width:4800,encounter:'ollyan',inspiration:'Uma festa fictícia da turma, com palco, dança e batalha aérea'}};
  // Optional encounters on the longer trails, away from teachers and safe shops.
  for(const [region,positions,baseHP] of [[0,[2720,3240,3620,4540],32],[2,[2050,2820,3520],40],[3,[1830,2610,3330],64],[9,[1870,2250],38]])positions.forEach((x,i)=>minions.push({id:'trilha-v38-'+region+'-'+i,scene:region,x,y:floor,type:'doodle',kind:i%3,tier:1+Math.floor(i/2),hp:baseHP+i*6,damage:6+i*2,range:45,xp:32+i*7,design:['spindle','wobbler','pasta'][i%3],provocation:['O CHAPÉU NÃO PASSA AQUI!','TEU GÁS TÁ NO CHEIRINHO!','MARCO MANDOU UM ABRAÇO!'][i%3]}));
  const data={version:'3.8.0',floor,widths,platforms,gaps,gapCheckpoints,checkpoints,doors,bosses,minions,arenaPlatforms,arenaBounds,parkourZones,foreshadow,collectibles,questPickups,sarueTraps,iraciTraps,schoolCovers,rageMinions,sceneNames,npcEntries,landmarks};
  function freeze(value){if(value&&typeof value==='object'){Object.values(value).forEach(freeze);Object.freeze(value);}return value;}
  window.WorldData=freeze(data);
})();
