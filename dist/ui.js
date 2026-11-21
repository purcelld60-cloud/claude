(() => {
'use strict';
const characters={
amanda:{name:'Amanda',role:'PRAÇA CAMACAN',description:'Foi a própria Amanda quem pintou as manchas do casaco de onça. Perto da entrada da praça, ela tem um convite para Da Roça.',power:'No jantar, respire no ritmo e escute Amanda. Davi e Vitor guardam um presente para o casal na Bigodon.'},
igor:{name:'Igor',role:'MONITOR · O FISCAL DO LANCHE',description:'Careca, gordinho, de barbinha e pele laranja clara, Igor fiscaliza os corredores. Ele quer saber se Da Roça trouxe lanche. Esconda-se atrás dos armários e saia do cone de visão para passar sem uma luta.',power:'Sem lanche, a barriga vira arma! Igor cresce, salta, rola pelo chão e cria ondas. Observe os avisos, use as plataformas e ataque nas pausas.'},
kaique:{name:'Kaique',role:'MONITOR · VOLTA PRA SALA!',description:'Alto, magro e branco, de cabelo e barba curta pretos, Kaique quer que Da Roça volte à sala e entregue as bolinhas de papel. A patrulha substitui os rabiscos pequenos da escola.',power:'Rajadas de metralhadora cartunizada e pausas para recarregar. A armadilha IRACI deixa Kaique furioso. Evite a palavra no chão, use as coberturas e desvie do alvo travado.'},
daroca:{name:'Da Roça',role:'O PROTAGONISTA · O DONO DO BOLO',description:'Um garoto da roça com um grande coração e um tanque de gás natural. Quando Nikolas Arroganti rouba o bolo de sapo que Lucas preparou para ele, Da Roça junta os amigos e transforma a resenha numa missão.',power:'Voo com peido, combo de gás, bolinhas elementais e o carro a gás do seu pai. Ganhe níveis e distribua pontos para criar seu próprio estilo.'},
reeis:{name:'Gabriel Reeis',role:'O ALIADO · DIRETO DE ITABUNA',description:'Gabriel Reis vem das favelas de Itabuna e carrega a fama de “rei do crime”. Primeiro você terá de atravessar a favela e enfrentar o rei do morro. Depois da luta, peça sua ajuda para recuperar o bolo: ele se torna um aliado da turma.',power:'OHHHH REEEEIS! Seu aliado corre até você, carrega uma aura dourada e se transforma. Depois, entra na luta por alguns segundos. Aperte R depois de derrotá-lo e recrutá-lo na favela.'},
nikolas:{name:'Nikolas Arroganti',role:'O CHEFÃO · TAMBÉM CONHECIDO COMO NIKOLAS POUDI',description:'Já foi um grande amigo de Da Roça. Mas a fome de bolo de chocolate falou mais alto e ele roubou o presente do Lucas! Agora esfrega seu enorme nariz de batata para carregar o catarro e foge das zoeiras do antigo amigo.',power:'Cada esfregada no nariz aumenta a carga de catarro. Ao disparar uma rajada, ele gasta tudo e precisa começar de novo. Essa é sua chance!'},
menezes:{name:'Menezes, o Rato',role:'O VILÃO SECUNDÁRIO · PROVOCAÇÃO EM PESSOA',description:'“Da Roça poudiaaam!”, “Reeeis pouddiaaam!”, “Da Roça pegou ar!”, “Teketeketeketeke!” e “Ó pra Ravid falando sozinho!”. Moreno, de cabelo preto cacheado e óculos, Menezes transforma essas provocações em palavras físicas que atravessam o pátio.',power:'Provocações viram projéteis. Desvie das paredes de palavras, pule as ondas de provocação e cuidado com os ecos que voltam. Ele mergulha em bueiros para reaparecer em outro lugar e chama um exército temporário de ratos. Observe as marcas no chão e ataque quando ele sair do esgoto!'},
lucas:{name:'Lucas, o Sapo',role:'O ALIADO · MESTRE DOS BOLOS',description:'De cabelo preto, casaco cinza, calça azul-escura e tênis branco, Lucas é um confeiteiro de baixa estatura apelidado de Sapo, e o autor do bolo de chocolate que começou toda essa confusão. Está na roça esperando Da Roça para contar o que viu e ajudar a consertar o carro do seu pai.',power:'A melhor receita de bolo de sapo da região e as chaves do carro a gás do pai de Da Roça para viajar entre as missões.'},
caleb:{name:'Caleb',role:'O ALIADO · PROFESSOR DA ACADEMIA',description:'Branco, loiro e de olhos castanhos, Caleb prepara Da Roça com um desafio de reflexo e ritmo. Depois de derrotar Menezes, procure o treinador na academia para provar que você domina o gás.',power:'Minigame com 3 rodadas. Acerte o marcador na faixa verde com E, Espaço ou o botão ACERTAR! Se errar, tente de novo. Complete o treino para aumentar seus ataques.'},
marco:{name:'Marco',role:'O VILÃO TERCIÁRIO · DESENHISTA DO CAOS',description:'Branco e magro, de moletom preto e cabelo preto, Marco ocupa a área dos rabiscos da escola com um caderno cheio de criaturas horríveis. O problema é que tudo o que ele desenha ganha vida, sai do papel e persegue Da Roça. Desvie dos rabiscos ou devolva o ataque. Seu caderno agora cria mais criaturas e ataques de tinta.',power:'A armadilha SARUÊ fica no chão. Se você pisar, Marco carrega uma aura vermelha, os olhos ficam vermelhos e ele desenha brainrots e criaturas Six Seven. Cuidado onde pisa!' },
kaua:{name:'Kaua',role:'O ALIADO · CRIADOR DE ARMAS',description:'A oficina do Kaua fica na roça. Ele transforma objetos simples e materiais escolares em armas de desenho poderosas. Colete lápis, borrachas e clipes pelo cenário e converse com ele para entregar os itens.',power:'3 itens criam o Lançador de Régua. Depois, outros 5 itens evoluem para o Canhão de Estojo. A arma aumenta o poder do seu ataque de papel (J).'},
almiro:{name:'Professor Almiro',role:'NPC · PROFESSOR DA ESCOLA',description:'Moreno, sem óculos, de camisa azul, jeans escuro e tênis verde neon, Almiro fica na sua própria sala na escola e está sempre pronto para uma conversa com Da Roça. Ele pede ajuda para recuperar três cadernos e ensina o combo de gás quando você volta com tudo.',power:'Ajude com os cadernos. A recompensa é experiência e o combo de três peidos: acerte K em sequência, com ritmo.'},
miqueias:{name:'Professor Miqueias',role:'NPC · ENGLISH DO JEITINHO DELE',description:'ALLRIGHT! Branco, de barba ruiva bem cheia, óculos e uma barriguinha, o professor Miqueias dá aula em outra sala da escola e conversa num inglês bem malfeito, misturado com os bordões da resenha. Complete seu quiz para aprender as papaias elementais e seguir a campanha.',power:'“ALLRIGHT”, “é ou não é”, “beleza creuza”, “concorda ou sem corda”. Chegue perto e converse com E.'},
mota:{name:'Gabriel Mota',role:'MOTA · O CRAQUE DO COLÉGIO',description:'Branco, loiro e magro, Mota joga futebol pela escola e vai ensinar Da Roça a acertar a mira e a força do chute. Procure o atleta no Campo do Mota e enfrente o goleiro em um minigame de cinco chutes.',power:'Faça três gols para ganhar experiência e liberar o dash. Depois você pode repetir o futebol para continuar evoluindo.'},
giant:{name:'Colosso Six Seven',role:'O MONSTRO GIGANTE · SAIU DO CADERNO',description:'Marco desenhou um monstro que ficou grande demais para o próprio caderno. Atravesse o reino de papel e tinta para encarar o colosso, seus golpes no chão e a chuva de rabiscos.',power:'Uma arena própria, ataques de grande alcance e invocações. Ganhe níveis, melhore seus atributos e aprenda a ler os avisos antes dos golpes.'},
allef:{name:'Allef',role:'BIGODON · A RECEPÇÃO DA RESENHA',description:'Gordinho, negro e de cabelo cacheado para cima, Allef cuida da recepção da Bigodon. O Da Roça mal entra e o chapéu já vira assunto na fila.',power:'Converse mais de uma vez. Allef sempre tem outra provocação preparada para a sua chegada.'},
eloisa:{name:'Eloisa',role:'CASA DE RAYSSA · A RESENHA CHEGOU',description:'De pele clara levemente morena, cabelo liso e batom rosa, Eloisa usa camisa branca com faixa azul escura à esquerda e calça azul escura. Ela está na casa de Rayssa com as amigas.',power:'Cada conversa traz uma resenha diferente. Aff veyr juro: nem o chapéu de Da Roça escapa dos comentários.'},
giselle:{name:'Giselle',role:'CASA DE RAYSSA · COMENTÁRIO NA PONTA DA LÍNGUA',description:'Negra, de tranças estilo crochet, Giselle usa o uniforme branco e azul escuro da turma. Na casa de Rayssa, acompanha cada história com um comentário certeiro.',power:'Converse novamente para ouvir outra zoeira. O assunto muda; a resenha continua.'},
rayssa:{name:'Rayssa',role:'A DONA DA CASA · SEM BARRO NO TAPETE',description:'Negra, de cabelo preto cacheado, Rayssa recebe a turma com camisa branca, faixa azul escura à esquerda e calça azul escura. O sofá não faz parte do circuito de parkour.',power:'Visite a casa com o carro a gás e converse com as quatro amigas. A primeira visita rende experiência.'},
analaura:{name:'Ana Laura',role:'CASA DE RAYSSA · JÁ QUER SABER DO LANCHE',description:'Branca, de cachos longos e soltos, Ana Laura tem uma silhueta discretamente mais cheia. Usa a mesma camisa branca com faixa e calça azul escura das amigas.',power:'As conversas variam a cada visita. Prepare o bolo, o açaí e uma boa história para a turma.'},
dede:{name:'Dedé',role:'FAVELA DO REEIS · O CAPANGA DA FUMAÇA',description:'Moreno e magro, de cabelo curto levantado e aparelho nos dentes, Dedé transforma a fumaça que solta em parte da luta. Na favela, ele se esconde entre nuvens e usa o beco como uma cortina de fumaça. É mais um capanga de Reeis no caminho da resenha.',power:'Confronto opcional. Observe os avisos e saia das nuvens antes de elas se fecharem; ataque quando Dedé reaparecer. A ajuda de Reeis continua seguindo a campanha principal.'},
aica:{name:'Aica',role:'PÁTIO DA ESCOLA · A AMIGA QUE FICA JUNTO',description:'De pele morena clara e cabelo longo e liso, Aica está no pátio da escola ajudando Ravile, que caiu depois de Arthur puxar seu cabelo. Converse com as duas para entender o que aconteceu.',power:'Uma história secundária. Ajude a dupla e acompanhe a revanche depois do desafio de Arthur.'},
ravile:{name:'Ravile',role:'PÁTIO DA ESCOLA · PRECISANDO DE AJUDA',description:'Morena e magra, de cabelo longo e liso, Ravile está caída e com dor quando Da Roça chega ao pátio. Aica cuida dela, e Ravile conta que Arthur puxou seu cabelo.',power:'Converse com Ravile ou Aica para iniciar a missão. Enfrente Arthur e veja o que acontece quando Ravile vai cobrar uma explicação. A missão não bloqueia o final do bolo.'},
arthur:{name:'Arthur',role:'PÁTIO DA ESCOLA · O PODER DO TAPA',description:'Branco, de cabelo raspado bem curtinho e óculos, Arthur tem movimentos e gestos expressivos. Ele arrumou uma confusão ao puxar o cabelo de Ravile; agora Da Roça precisa ajudar a amiga.',power:'Vários tipos de tapa, incluindo ataques à distância. Espere os avisos, desvie das rajadas e encontre as pausas. Confronto de uma missão secundária, separado da busca pelo bolo.'},
davi:{name:'Davi Costa',role:'BIGODON · BARBEIRO DA RESENHA',description:'Gordinho, de moletom preto e cabelo castanho liso e curto, Davi Costa comanda a Bigodon. A barbearia é uma parada para descansar, trocar ideia e ouvir uma resenha que vem junto com o corte.',power:'Converse na Bigodon para recuperar a vida e o gás. A primeira visita também rende experiência. Depois, volte sempre que precisar de um descanso.'},
vitor:{name:'Vitor',role:'BIGODON · O AJUDANTE',description:'Branco, de moletom cinza, cabelo preto curtinho e óculos, Vitor ajuda Davi Costa na Bigodon. Cuida da barbearia e nunca deixa a resenha do chefe passar sem um comentário.',power:'Procure Vitor ao lado de Davi e converse. Conhecer a dupla rende experiência na primeira visita e novas falas para a turma.'},
freddy:{name:'Freddy',role:'FAVELA DO REEIS · O CAPANGA MAIS FORTE',description:'Negro, magro, de cabelo preto cacheado em corte tijela com franja encaracolada, Freddy é o capanga mais forte de Reeis. Nem o chefe escapa das zoeiras dele: “Ô REEEIS!”. Você vai encontrá-lo no alto da favela, antes da arena do rei.',power:'Uma luta própria, com golpes fortes e avisos antes dos ataques. Use o dash do Mota para desviar e ataque na recuperação. Derrote Freddy para continuar até Reeis.'},
nicolas:{name:'Nicolas Carvalho',role:'PRAÇA CAMACAN · O AUTOPROCLAMADO PROTAGONISTA',description:'Branco, de cabelo curto e liso, Nicolas Carvalho tem certeza de que o mundo gira em torno dele. No fim da Praça Camacan, desafie o garoto para descobrir até onde vai a sua aura suprema.',power:'Desafio opcional com fases, uma arena celestial e ataques dourados. Aprenda o dash do Mota, observe os avisos e encontre as brechas entre os golpes. A conclusão guarda uma boa resenha.'},
ravid:{name:'Ravid',role:'O NPC · CONVERSANDO COM A PAREDE',description:'Você pode tentar conversar com Ravid na escola. Ele vai escutar? Talvez. Vai responder olhando para você? Pouco provável. A parede parece estar no meio de um assunto muito importante.',power:'Uma conversa infinita consigo mesmo. Chegue perto, aperte E e tente acompanhar o raciocínio.'}
};
let modalWasRunning=false;
function openModal(el){if(!shell.contains(el))shell.append(el);const state=window.Game?.getState();modalWasRunning=!!(state?.started&&!state.paused&&!state.won&&!state.defeated);if(modalWasRunning)Game.pause();el.showModal();}
function closeModal(el){el.close();}
document.querySelectorAll('[data-open-help]').forEach(btn=>btn.addEventListener('click',()=>openModal(document.getElementById('helpModal'))));
document.querySelectorAll('[data-close-modal]').forEach(btn=>btn.addEventListener('click',()=>closeModal(btn.closest('dialog'))));
document.querySelectorAll('dialog').forEach(el=>{el.addEventListener('close',()=>{if(modalWasRunning){modalWasRunning=false;Game.resume();}});el.addEventListener('click',e=>{if(e.target===el){const b=el.getBoundingClientRect();if(e.clientX<b.left||e.clientX>b.right||e.clientY<b.top||e.clientY>b.bottom)closeModal(el);}});});
function portrait(canvas,type,detail=false){if(!window.Art||!canvas)return;const c=canvas.getContext('2d');c.imageSmoothingEnabled=false;c.clearRect(0,0,canvas.width,canvas.height);if(detail){c.fillStyle=type==='nikolas'?'#4b3d50':'#36482f';c.fillRect(0,0,240,180);}const x=canvas.width/2,y=canvas.height-5;const scale=type==='giant'?(detail?.78:.5):detail?1.85:type==='lucas'?1.55:1.25;c.fillStyle='#10241b45';c.fillRect(x-30*scale,y-4,60*scale,6);Art.drawCharacter(c,type,x,y,{facing:1,frame:0,scale,muscular:type==='daroca'&&!!window.Game?.getState().q.trained});}
document.querySelectorAll('[data-character]').forEach(btn=>btn.addEventListener('click',()=>{const id=btn.dataset.character,c=characters[id];document.getElementById('detailName').textContent=c.name;document.getElementById('detailRole').textContent=c.role;document.getElementById('detailDescription').textContent=c.description;document.getElementById('detailPower').textContent=c.power;portrait(document.getElementById('detailPortrait'),id,true);openModal(document.getElementById('characterModal'));}));
document.querySelectorAll('[data-portrait]').forEach(c=>portrait(c,c.dataset.portrait));
const mini=document.getElementById('miniPortrait');if(window.Art&&mini){const c=mini.getContext('2d');c.imageSmoothingEnabled=false;Art.drawCharacter(c,'daroca',21,42,{facing:1,frame:0,scale:.55});}
document.querySelectorAll('.map-image').forEach((el,i)=>{el.querySelector('span')?.remove();const c=document.createElement('canvas');c.width=240;c.height=135;const ctx=c.getContext('2d');ctx.imageSmoothingEnabled=false;ctx.scale(.25,.25);Art.drawScene(ctx,i,0,0);el.append(c);});
const shell=document.querySelector('.game-shell');shell.id='gameShell';
const fullscreenBtn=document.getElementById('fullscreenBtn');
const rotateHint=document.getElementById('rotateHint');
let immersive=false,wasNative=false,rotationDismissed=false,previousScroll=0,travelWasRunning=false;
const isIOS=/iPhone|iPad|iPod/.test(navigator.userAgent)||(navigator.platform==='MacIntel'&&navigator.maxTouchPoints>1);
const standalone=()=>location.protocol==='file:'||new URLSearchParams(location.search).has('native')||matchMedia('(display-mode: standalone)').matches||!!navigator.standalone;
const isNative=()=>document.fullscreenElement===shell||document.webkitFullscreenElement===shell;
let fillScreen=true;
try{fillScreen=localStorage.getItem('daroca-screen-fit')!=='frame';}catch{}
const fitTools=document.createElement('div');fitTools.className='screen-fit-tools';fitTools.hidden=true;
const fitButton=document.createElement('button');fitButton.id='screenFitBtn';fitButton.type='button';
const iosHelp=document.createElement('button');iosHelp.id='iphoneFullscreenHelp';iosHelp.type='button';iosHelp.textContent='SEM BARRAS?';iosHelp.setAttribute('aria-haspopup','dialog');iosHelp.hidden=!isIOS||standalone();
fitTools.append(fitButton,iosHelp);shell.append(fitTools);
function fitImmersive(){
 if(!immersive)return;
 const vv=window.visualViewport;
 const width=Math.round(vv?.width||window.innerWidth),height=Math.round(vv?.height||window.innerHeight);
 shell.style.setProperty('--visible-width',width+'px');shell.style.setProperty('--visible-height',height+'px');
 shell.style.setProperty('--visible-left',(isNative()?0:vv?.offsetLeft||0)+'px');shell.style.setProperty('--visible-top',(isNative()?0:vv?.offsetTop||0)+'px');
 const wide=width>height&&height<700;
 shell.classList.toggle('screen-wide',wide);
 const story=!document.getElementById('startScreen').hidden||['is-dialog','is-cutscene','is-training','is-activity','is-room','is-paused','is-ollyan-flight'].some(c=>shell.classList.contains(c));
 if(shell.classList.contains('screen-story')!==story)shell.classList.toggle('screen-story',story);
 shell.classList.toggle('screen-fill',fillScreen);
 // Extremely wide windows stay framed so upper parkour platforms remain visible.
 shell.classList.toggle('screen-crop-safe',wide&&width/height<=3.2&&height>=280);
 const top=(shell.querySelector('.game-topbar')?.getBoundingClientRect().height||0)+(shell.querySelector('.progress-hud')?.getBoundingClientRect().height||0);
 shell.style.setProperty('--screen-hud-height',top+'px');
 const style=getComputedStyle(shell),px=v=>parseFloat(v)||0;
 const availW=shell.clientWidth-px(style.paddingLeft)-px(style.paddingRight),availH=Math.max(120,shell.clientHeight-top-px(style.paddingTop)-px(style.paddingBottom));
 const w=Math.min(availW,availH*16/9);
 shell.style.setProperty('--stage-width',w+'px');shell.style.setProperty('--stage-height',(w*9/16)+'px');
 fitTools.hidden=!wide;
 fitButton.disabled=width/height>3.2||height<280;
 fitButton.textContent=fitButton.disabled?'CENÁRIO INTEIRO':fillScreen?'ENQUADRAR':'PREENCHER';fitButton.setAttribute('aria-pressed',String(fillScreen));fitButton.setAttribute('aria-label',fillScreen?'Enquadrar todo o cenário':'Preencher a tela durante o jogo');
 fitButton.title=fitButton.disabled?'Esta proporção mantém o cenário inteiro visível.':'Alternar entre preencher a tela e mostrar todo o cenário';
 iosHelp.hidden=!isIOS||standalone()||isNative();
 rotateHint.hidden=rotationDismissed||height<=width||!(matchMedia('(pointer: coarse)').matches||width<800);
}
const baseGameShell=()=>document.body.classList.contains('shell-experience');
function updateFullscreenButton(){
 const native=isNative(),active=baseGameShell()?native:immersive;
 fullscreenBtn.setAttribute('aria-pressed',String(active));
 fullscreenBtn.setAttribute('aria-label',active?'Sair da tela cheia':'Jogar em tela cheia');
 fullscreenBtn.title=active?'Sair da tela cheia':'Jogar em tela cheia';
 fullscreenBtn.innerHTML=active?'<svg viewBox="0 0 24 24" width="20" height="20" aria-hidden="true"><path fill="currentColor" d="M7 3h3v7H3V7h4zm7 0h3v4h4v3h-7zM3 14h7v7H7v-4H3zm11 0h7v3h-4v4h-3z"/></svg><small>SAIR</small>':'<svg viewBox="0 0 24 24" width="20" height="20" aria-hidden="true"><path fill="currentColor" d="M3 3h7v3H6v4H3zm11 0h7v7h-3V6h-4zM3 14h3v4h4v3H3zm15 0h3v7h-7v-3h4z"/></svg><small>TELA CHEIA</small>';
}
function leaveImmersive(){
 window.Game?.releaseInputs?.();wasNative=false;
 if(baseGameShell()){updateFullscreenButton();fitImmersive();return;}
 immersive=false;rotationDismissed=false;shell.classList.remove('immersive','screen-wide','screen-fill','screen-story','screen-crop-safe');document.body.classList.remove('game-immersive');fitTools.hidden=true;updateFullscreenButton();rotateHint.hidden=true;
 try{screen.orientation?.unlock?.();}catch{}window.scrollTo(0,previousScroll);
}
async function enterImmersive(options={}){
 const pageOnly=options?.pageOnly===true;
 window.Game?.releaseInputs?.();
 if(!immersive){previousScroll=window.scrollY;immersive=true;rotationDismissed=false;shell.classList.add('immersive');document.body.classList.add('game-immersive');}
 fitImmersive();
 if(!pageOnly&&!isNative()){
  try{
   if(!standalone()&&shell.requestFullscreen)await shell.requestFullscreen({navigationUI:'hide'});
   else if(!standalone()&&shell.webkitRequestFullscreen)await shell.webkitRequestFullscreen();
  }catch{/* Safari keeps the game in the visible page viewport. */}
 }
 wasNative=isNative();updateFullscreenButton();
 if(immersive){if(!pageOnly){try{await screen.orientation?.lock?.('landscape');}catch{}}fitImmersive();}
}
async function exitImmersive(){
 if(isNative()){try{if(document.exitFullscreen)await document.exitFullscreen();else document.webkitExitFullscreen?.();}catch{}}
 if(immersive)leaveImmersive();
}
fullscreenBtn.addEventListener('click',()=>baseGameShell()?(isNative()?exitImmersive():enterImmersive()):(immersive?exitImmersive():enterImmersive()));
document.querySelectorAll('[data-enter-fullscreen]').forEach(b=>b.addEventListener('click',enterImmersive));
fitButton.addEventListener('click',()=>{window.Game?.releaseInputs?.();fillScreen=!fillScreen;try{localStorage.setItem('daroca-screen-fit',fillScreen?'fill':'frame');}catch{}fitImmersive();});
iosHelp.addEventListener('click',()=>window.GameInstall?.showGuide?.());
document.getElementById('rotateDismissBtn').addEventListener('click',()=>{rotationDismissed=true;rotateHint.hidden=true;});
const onFullscreenChange=()=>{if(isNative()){wasNative=true;updateFullscreenButton();fitImmersive();}else if(wasNative&&immersive)leaveImmersive();};
document.addEventListener('fullscreenchange',onFullscreenChange);document.addEventListener('webkitfullscreenchange',onFullscreenChange);
window.addEventListener('resize',fitImmersive);window.visualViewport?.addEventListener('resize',fitImmersive);window.visualViewport?.addEventListener('scroll',fitImmersive);
const onOrientationChange=()=>{window.Game?.releaseInputs?.();fitImmersive();requestAnimationFrame(fitImmersive);setTimeout(fitImmersive,180);setTimeout(fitImmersive,420);};screen.orientation?.addEventListener?.('change',onOrientationChange);window.addEventListener('orientationchange',onOrientationChange);
new MutationObserver(fitImmersive).observe(shell,{attributes:true,attributeFilter:['class']});
new MutationObserver(fitImmersive).observe(document.getElementById('startScreen'),{attributes:true,attributeFilter:['hidden']});
document.addEventListener('keydown',e=>{if(e.code==='Escape'&&immersive&&!baseGameShell()&&!isNative()&&!document.querySelector('dialog[open]'))exitImmersive();});
// Follow high jumps in cropped landscape mode instead of losing the player above the screen.
let fillPan=null;
function followFill(){
 if(window.Campanha2?.aberto?.()){requestAnimationFrame(followFill);return;} // com a Campanha 2 aberta não mede nem mexe no layout da principal a cada quadro
 if(immersive&&shell.classList.contains('screen-wide')&&shell.classList.contains('screen-fill')&&shell.classList.contains('screen-crop-safe')&&!shell.classList.contains('screen-story')){
  const viewport=shell.querySelector('.viewport'),w=viewport.clientWidth,h=viewport.clientHeight,scale=w/960;
  const playerY=window.Game?.getViewTarget?.().y??440;
  const hud=parseFloat(shell.style.getPropertyValue('--screen-hud-height'))||72;
  const safeTop=parseFloat(getComputedStyle(shell).paddingTop)||0;
  const minFoot=hud+safeTop+Math.min(64,62*scale)+24;
  const bottom=Math.min(0,h-540*scale);
  const target=Math.min(80,Math.max(bottom,minFoot-playerY*scale));
  fillPan=fillPan===null?target:fillPan+(target-fillPan)*.5;
  shell.style.setProperty('--fill-offset',fillPan.toFixed(2)+'px');
 }else fillPan=null;
 requestAnimationFrame(followFill);
}
requestAnimationFrame(followFill);
const travelPanel=document.getElementById('travelPanel'),travelBtn=document.getElementById('travelBtn'),boardBtn=document.getElementById('boardCarBtn');
function refreshRoutes(preferred){const state=Game.getState();const hint=document.getElementById('routeHint');hint.textContent=!state.started?'Comece a aventura e converse com Lucas para consertar o carro.':!state.q.lucas?'O carro do seu pai está quebrado. Busque as três peças na roça e leve tudo a Lucas.':!state.vehicle?'Entre no carro a gás para escolher uma rota. É o carro do pai de Da Roça!':'Motor ligado! Escolha o destino e deixe o carro a gás levar você.';boardBtn.hidden=!!state.vehicle;boardBtn.disabled=!state.started||!state.q.lucas;travelPanel.querySelectorAll('[data-route]').forEach(b=>{const n=Number(b.dataset.route);b.classList.toggle('active',n===(preferred??state.scene));const gate=window.Campaign?.canTravel(n,state.q)||{ok:true,reason:''};b.classList.toggle('locked',!gate.ok);b.setAttribute('aria-disabled',String(!gate.ok));b.title=gate.reason||'Escolher esta rota';});}
function closeTravel(){travelPanel.hidden=true;travelBtn.setAttribute('aria-expanded','false');shell.classList.remove('is-routing');}
function openTravel(preferred){const state=Game.getState();if(state.defeated||state.won||state.training?.active||state.activity||state.dialog||state.paused||state.activeBoss||state.routeTransition||state.cutscene||state.room)return;if(state.started&&window.MapasJogo?.abrirCampanha1?.(preferred)){Game.releaseInputs?.();return;}/* mapa 3D; sem WebGL fica a lista antiga */Game.releaseInputs?.();travelPanel.hidden=false;travelBtn.setAttribute('aria-expanded','true');shell.classList.add('is-routing');refreshRoutes(preferred);}
travelBtn.addEventListener('click',()=>travelPanel.hidden?openTravel():closeTravel());document.getElementById('travelCloseBtn').addEventListener('click',closeTravel);
travelPanel.querySelectorAll('[data-route]').forEach(b=>b.addEventListener('click',()=>{if(Game.getState().paused){closeTravel();return;}if(Game.travel(Number(b.dataset.route)))closeTravel();else refreshRoutes(Number(b.dataset.route));}));
document.querySelectorAll('[data-scene]').forEach(b=>b.addEventListener('click',e=>{e.preventDefault();e.stopImmediatePropagation();openTravel(Number(b.dataset.scene));},true));
window.addEventListener('car-route-request',e=>openTravel(e.detail?.scene));
window.addEventListener('game-input-reset',()=>{const st=Game.getState();if(st.paused||st.defeated||st.dialog||st.training?.active||st.activity||st.cutscene||st.room)closeTravel();});
window.addEventListener('player-trained',()=>{document.querySelectorAll('[data-portrait="daroca"]').forEach(c=>portrait(c,'daroca'));const c=mini.getContext('2d');c.clearRect(0,0,42,42);Art.drawCharacter(c,'daroca',21,42,{facing:1,frame:0,scale:.55,muscular:true});});
window.GameView={enterFullscreen:enterImmersive,exitFullscreen:exitImmersive,isFullscreen:()=>immersive,isNativeFullscreen:isNative,fit:fitImmersive,openRoutes:openTravel,closeRoutes:closeTravel,openHelp:()=>openModal(document.getElementById('helpModal'))};
// Safari: keep game gestures local; page zoom and scrolling still work outside the game.
const preventGesture=e=>{if(e.cancelable)e.preventDefault();};
['gesturestart','gesturechange','gestureend','dblclick','contextmenu','dragstart','selectstart'].forEach(type=>shell.addEventListener(type,preventGesture,{passive:false}));
// Pointer controls act on pointerdown, so their native touch click must not zoom or repeat.
document.querySelectorAll('#gameShell [data-action]').forEach(btn=>{
 ['touchstart','touchmove','touchend'].forEach(type=>btn.addEventListener(type,preventGesture,{passive:false}));
});
shell.addEventListener('touchmove',e=>{if(e.touches.length>1||e.target.closest?.('.touch-controls,#gameCanvas,.training-action'))preventGesture(e);},{passive:false});
// XP and attribute allocation stay separate from the real-time action controls.
function updateProgress(){if(!window.Progression)return;const p=Progression.getState(),bonus=Progression.bonuses();document.getElementById('levelValue').textContent=p.level;document.getElementById('pointsValue').textContent=p.points+' '+(p.points===1?'PONTO':'PONTOS');document.getElementById('xpLabel').textContent=p.nextXP?p.xp+' / '+p.nextXP+' XP':'NÍVEL MÁXIMO';document.getElementById('xpFill').style.width=(p.nextXP?Math.min(100,p.xp/p.nextXP*100):100)+'%';document.getElementById('statsBtn').classList.toggle('has-points',p.points>0);document.getElementById('statsSummary').textContent='Nível '+p.level+' · '+p.points+' pontos disponíveis';for(const stat of ['vigor','forca','gas','agilidade'])document.getElementById('stat-'+stat).textContent=p.stats[stat];document.querySelectorAll('[data-spend-stat]').forEach(b=>b.disabled=p.points<1||p.stats[b.dataset.spendStat]>=40);document.getElementById('statsBonuses').textContent=bonus.maxHP+' de vida · '+bonus.maxGas+' de gás · '+Math.round((bonus.damageMultiplier-1)*100)+'% de dano extra · velocidade '+Math.round(bonus.moveSpeed)+' · dash a cada '+bonus.dashCooldown.toFixed(2).replace('.',',')+'s · recuperação '+bonus.gasRegen.toFixed(1).replace('.',',')+' gás/s';updateJournal();}
let journalSignature='';
function updateJournal(){if(!window.Campaign||!window.Game)return;const q=Game.getState().q;const rows=Campaign.chapterState(q),sideRows=Campaign.sideQuestState?.(q)||[],signature=rows.map(r=>r.complete?'1':'0').join('')+'|'+sideRows.map(r=>r.complete?'1':'0').join('');if(signature===journalSignature)return;journalSignature=signature;const story=rows.filter(r=>!r.epilogue),current=story.find(r=>!r.complete);const list=document.getElementById('campaignSteps');list.replaceChildren();for(const row of rows){const li=document.createElement('li');li.className=row.complete?'complete':row.id===current?.id?'current':'';const n=document.createElement('span');n.textContent=row.complete?'✓':row.epilogue?'✦':String(row.index).padStart(2,'0');const b=document.createElement('b');b.textContent=row.title;const small=document.createElement('small');small.textContent=Campaign.sceneNames[row.scene]+(row.epilogue?' · NO EPÍLOGO':'');li.append(n,b,small);list.append(li);}const sideList=document.getElementById('sideQuestSteps');if(sideList){sideList.replaceChildren();for(const row of sideRows){const li=document.createElement('li');li.className=row.complete?'complete':'current';li.title=row.description||'';const mark=document.createElement('span');mark.textContent=row.complete?'✓':'✦';const label=document.createElement('b');label.textContent=row.title;const place=document.createElement('small');place.textContent=Campaign.sceneNames[row.scene]+(row.complete?' · CONCLUÍDO':' · EXPLORE');li.append(mark,label,place);sideList.append(li);}}document.getElementById('chapterCount').textContent=story.filter(r=>r.complete).length+' / '+story.length+' CONCLUÍDOS';document.getElementById('campaignChapter').textContent=current?'CAPÍTULO '+current.index+' / '+story.length:'CAMPANHA CONCLUÍDA';}
document.getElementById('statsBtn').addEventListener('click',()=>{updateProgress();openModal(document.getElementById('statsModal'));});document.querySelectorAll('[data-spend-stat]').forEach(b=>b.addEventListener('click',()=>{if(window.Game?.spendStat)Game.spendStat(b.dataset.spendStat);else Progression.spend(b.dataset.spendStat);updateProgress();}));window.addEventListener('progression-change',updateProgress);updateProgress();setInterval(updateJournal,800);
Game.setSoundEnabled(Game.soundOn());

})();
