/* Stable soundtrack targets shared by the game and the private music manager. */
(() => {
 'use strict';
 const contexts=[];
 const add=(id,label,group)=>contexts.push(Object.freeze({id,label,group}));
 add('characters.swift','Conversa · Irmão de Clara Swift','Personagens');
 add('arena.menu','Arena online · seleção e sala','Arena online');add('arena.battle','Arena online · confronto','Arena online');add('arena.results','Arena online · resultado','Arena online');
 for(const[id,label]of [['pump','Bombeamento · pomar e campo'],['memory','Memória · luzes da praça e do baile'],['sort','Reciclagem · escola e pátio']])add('activities.'+id,label,'Minigames');
 const maps=[['roca','A roça'],['escola','Colégio Adventista'],['academia','Academia do Caleb'],['quadra','Quadra da escola'],['camacan','Praça Camacan'],['favela','Favela do Reeis'],['caderno','Caderno do Caos'],['campo','Campo do Mota'],['bigodon','Bigodon'],['patio','Pátio da escola'],['rayssa','Casa de Rayssa'],['baile','Baile funk · noite da resenha']];
 for(const[id,name]of maps)add('maps.'+id,name,'Cenários');
 add('rooms.almiro','Sala do professor Almiro','Salas');add('rooms.miqueias','Sala do professor Miqueias','Salas');
 const characters=[['daroca','Da Roça'],['reeis','Gabriel Reeis'],['nikolas','Nikolas Arroganti'],['lucas','Lucas, o Sapo'],['menezes','Menezes, o Rato'],['caleb','Caleb'],['kaua','Kaua'],['marco','Marco'],['ravid','Ravid'],['mota','Gabriel Mota'],['giant','Colosso Six Seven'],['almiro','Professor Almiro'],['miqueias','Professor Miqueias'],['davi','Davi Costa'],['vitor','Vitor'],['freddy','Freddy'],['nicolas','Nicolas Carvalho'],['dede','Dedé'],['aica','Aica'],['ravile','Ravile'],['arthur','Arthur'],['allef','Allef'],['eloisa','Eloisa'],['giselle','Giselle'],['rayssa','Rayssa'],['analaura','Ana Laura'],['ollyan','Ollyan · Orelhas ao Vento']];
 for(const[id,name]of characters)add('characters.'+id,'Conversa · '+name,'Personagens');
 for(const[id,name]of[['igor','Igor'],['kaique','Kaique']]){add('characters.'+id,'Conversa · '+name,'Personagens');add('battles.'+id,'Batalha · '+name,'Batalhas');add('events.boss_'+id,'Apresentação · '+name,'Cenas e eventos');}
 const bosses=[['marco','Marco'],['giant','Colosso Six Seven'],['menezes','Menezes'],['nikolas','Nikolas Arroganti'],['reeisBoss','Reeis'],['freddy','Freddy'],['nicolas','Nicolas Carvalho'],['dede','Dedé'],['arthur','Arthur'],['ollyan','Ollyan · Orelhas ao Vento']];
 for(const[id,name]of bosses){add('battles.'+id,'Batalha · '+name,'Batalhas');if(id!=='ollyan')add('events.boss_'+(id==='reeisBoss'?'reeis':id),'Apresentação · '+name,'Cenas e eventos');}
 for(const[id,name]of [['intro','A amizade e o bolo'],['celebration','Comemoração e açaí'],['jorge_epilogue','Epílogo · a ligação de Jorge'],['reeis_transform','Transformação do Reeis'],['defeat','Derrota'],['chapter_end','Fim do capítulo']])add('events.'+id,name,'Cenas e eventos');
 const phaseNames={nikolas:['O duelo original','Força bruta','Aura do céu','Gigante do catarro'],ollyan:['Orelhas ao vento','Plataformas nas nuvens','Corrente de ar']};
 const phaseBosses=[...new Map([['igor','Igor'],['kaique','Kaique'],...bosses.filter(b=>b[0]!=='giant'),['ollyan','Ollyan']].map(b=>[b[0],b])).values()];
 for(const[id,name]of phaseBosses)for(let phase=1;phase<=(id==='nikolas'?4:3);phase++)add('battles.'+id+'.phase'+phase,'Batalha · '+name+' · Fase '+phase+(phaseNames[id]?' · '+phaseNames[id][phase-1]:''),'Batalhas');
 add('menu.title','Menu inicial','Menus');add('menu.pause','Menu de pausa','Menus');
 add('activity.caleb','Treino com Caleb','Desafios');add('activity.mota','Futebol com Mota','Desafios');add('activity.english','English do Miqueias','Desafios');
 add('party.menu','Festa 3D · recepção e sala Wi-Fi','Festa 3D');add('party.board','Festa 3D · tabuleiro','Festa 3D');
 for(const[id,name]of [['collapse','Piso SARUÊ'],['race','Carro a Gás GP'],['football','Quadra Caótica'],['spotlight','Não Acorde o Nariz'],['pages','Biblioteca em Fuga'],['waves','Ondas da Resenha'],['harvest','Mutirão do Sapo'],['sketch','Um Saruê Contra Todos'],['raft','Remada da Resenha']])add('party.'+id,'Festa 3D · '+name,'Festa 3D');
 add('party.results','Festa 3D · resultado da arena','Festa 3D');add('party.ceremony','Festa 3D · pódio final','Festa 3D');
 add('coop.menu','Dupla · recepção e conexão','Arena em dupla');
 for(const id of ['marco','menezes','nikolas'])add('coop.'+id,'Dupla · '+bosses.find(b=>b[0]===id)[1],'Arena em dupla');
 // These are the complete, real film sequences in Cinematics.metadata. Monitor
 // transformations stay in Events: they are battle animations, not these films.
 const cutscenes=[['easy_finish','Final Fácil · chupeta e Gugu dada'],['intro','A amizade e o bolo'],['outro','O bolo recuperado · revanche de Da Roça'],['boss_dede','Apresentação · Dedé'],['dede_defeat','Dedé derrotado · a fumaça baixou'],['boss_freddy','Apresentação · Freddy'],['freddy_defeat','Freddy derrotado · caminho liberado'],['boss_reeis','Apresentação · Reeis'],['reeis_recruit','Recrutamento e transformação do Reeis'],['boss_marco','Apresentação · Marco'],['marco_rage','Marco · fúria do SARUÊ'],['boss_giant','Apresentação · Colosso Six Seven'],['boss_menezes','Apresentação · Menezes'],['boss_arthur','Apresentação · Arthur'],['arthur_revenge','Ravile e Aica · a orelha de Arthur'],['boss_nicolas','Apresentação · aura suprema de Nicolas'],['nicolas_reveal','Nicolas · a aura era imaginação'],['boss_nikolas','Apresentação · Nikolas'],['celebration','Comemoração · bolo e açaí de quarta'],['jorge_epilogue','Epílogo · a ligação de Jorge'],['ollyan_flight','Ollyan · orelhas ao vento e perseguição no céu']];
 for(const[kind,label]of cutscenes){add('cutscenes.'+kind,label,'Cutscenes');if(!contexts.some(c=>c.id==='events.'+kind))add('events.'+kind,label+' · associação antiga','Cenas e eventos');}
 const kinds=new Set(cutscenes.map(([kind])=>kind));
 window.MusicCutscenes=Object.freeze(cutscenes.map(([id,label])=>Object.freeze({id,label})));
 window.MusicContexts=Object.freeze(contexts.map(context=>{const kind=context.id.replace(/^(?:cutscenes|events)\./,'');return kinds.has(kind)&&/^(?:cutscenes|events)\./.test(context.id)?Object.freeze({...context,previewKind:kind}):context;}));
})();
