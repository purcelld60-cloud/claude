/* Player controls live separately from campaign progress. No server is needed. */
(() => {
  'use strict';
  const STORAGE='daroca-controls-v1',schema=1;
  const definitions=[
    ['left','Esquerda','Movimento',['KeyA','ArrowLeft']],
    ['right','Direita','Movimento',['KeyD','ArrowRight']],
    ['up','Subir / mirar para cima','Movimento',['KeyW','ArrowUp']],
    ['down','Descer / mirar para baixo','Movimento',['KeyS','ArrowDown']],
    ['jump','Pular / segurar para voar','Movimento',['Space']],
    ['paper','Papel / golpe físico','Combate',['KeyJ']],
    ['fart','Peido / ataque à distância','Combate',['KeyK']],
    ['dash','Dash','Combate',['KeyL','ShiftLeft']],
    ['reeis','Reeis / combo da arena','Poderes',['KeyR']],
    ['vehicle','Carro a gás','Poderes',['KeyV']],
    ['bivolt','Bivolt','Poderes',['KeyB']],
    ['taunt','Provocar / emote','Combate',['KeyT']],
    ['poder1','Poder equipado 1 (Campanha 2)','Poderes',['KeyU']],
    ['poder2','Poder equipado 2 (Campanha 2)','Poderes',['KeyI']],
    ['interact','Conversar / interagir','Aventura',['KeyE','Enter']],
    ['pause','Pausar / voltar','Aventura',['Escape']]
  ];
  const actions=Object.freeze(definitions.map(([id,label,group,bindings])=>Object.freeze({id,label,group,defaultBindings:Object.freeze([...bindings])})));
  const canonicalCode=code=>code==='ShiftRight'?'ShiftLeft':String(code||'');
  const validCode=code=>/^(Key[A-Z]|Digit[0-9]|Numpad[0-9]|Numpad(?:Add|Subtract|Multiply|Divide|Decimal|Enter)|Arrow(?:Left|Right|Up|Down)|Space|Enter|Escape|ShiftLeft|Backspace|Delete|Insert|Home|End|PageUp|PageDown|Minus|Equal|BracketLeft|BracketRight|Backslash|Semicolon|Quote|Backquote|Comma|Period|Slash|IntlBackslash|IntlRo|IntlYen)$/.test(code);
  const defaults=()=>({schema,bindings:Object.fromEntries(definitions.map(([id,,,bindings])=>[id,[...bindings]])),sensitivity:1,deadzone:.12});
  const clamp=(n,min,max)=>Math.max(min,Math.min(max,n));
  function restore(){
    const fallback=defaults();
    try{
      const saved=JSON.parse(localStorage.getItem(STORAGE));if(!saved||saved.schema!==schema)return fallback;
      const used=new Set(['Escape']);
      for(const {id} of actions){
        if(id==='pause')continue;
        const candidates=Array.isArray(saved.bindings?.[id])?saved.bindings[id]:fallback.bindings[id];
        const codes=[];
        for(const raw of candidates.slice(0,2)){
          const code=canonicalCode(raw);
          if(validCode(code)&&code!=='Escape'&&!used.has(code)){codes.push(code);used.add(code);}
        }
        fallback.bindings[id]=codes;
      }
      const pauseExtra=canonicalCode(saved.bindings?.pause?.[1]);
      fallback.bindings.pause=['Escape'];
      if(validCode(pauseExtra)&&!used.has(pauseExtra))fallback.bindings.pause.push(pauseExtra);
      // Corrupt or old settings must never leave an action inaccessible.
      if(actions.some(({id})=>!fallback.bindings[id].length))return defaults();
      if(Number.isFinite(Number(saved.sensitivity)))fallback.sensitivity=clamp(Number(saved.sensitivity),.5,2);
      if(Number.isFinite(Number(saved.deadzone)))fallback.deadzone=clamp(Number(saved.deadzone),0,.4);
    }catch{}
    return fallback;
  }
  let state=restore();
  const getState=()=>({schema,bindings:Object.fromEntries(Object.entries(state.bindings).map(([id,codes])=>[id,[...codes]])),sensitivity:state.sensitivity,deadzone:state.deadzone});
  const labels={Space:'Espaço',ArrowLeft:'←',ArrowRight:'→',ArrowUp:'↑',ArrowDown:'↓',Escape:'Esc',Enter:'Enter',ShiftLeft:'Shift',Backspace:'Apagar',Delete:'Del',Insert:'Insert',Home:'Home',End:'End',PageUp:'PgUp',PageDown:'PgDn',Minus:'−',Equal:'=',BracketLeft:'[',BracketRight:']',Backslash:'\\',Semicolon:'Ç / ;',Quote:"'",Backquote:'`',Comma:',',Period:'.',Slash:'/',IntlBackslash:'\\',IntlRo:'/',IntlYen:'¥',NumpadAdd:'Num +',NumpadSubtract:'Num −',NumpadMultiply:'Num ×',NumpadDivide:'Num ÷',NumpadDecimal:'Num .',NumpadEnter:'Num Enter'};
  const labelForCode=raw=>{const code=canonicalCode(raw);return labels[code]||(/^Key[A-Z]$/.test(code)?code.slice(3):/^Digit[0-9]$/.test(code)?code.slice(5):/^Numpad[0-9]$/.test(code)?'Num '+code.slice(6):code||'Sem tecla');};
  function persist(){let saved=true;try{localStorage.setItem(STORAGE,JSON.stringify(state));}catch{saved=false;}window.dispatchEvent(new CustomEvent('controls-change',{detail:{...getState(),saved}}));return {ok:true,saved,state:getState()};}
  const fail=message=>({ok:false,message});
  function setBinding(action,raw,slot=0,options={}){
    if(!state.bindings[action]||!Number.isInteger(slot)||slot<0||slot>1)return fail('Ação ou posição de tecla inválida.');
    const code=canonicalCode(raw);
    if(!validCode(code))return fail('Escolha uma tecla de jogo. Tab, Ctrl, Alt, Windows e atalhos do navegador ficam livres.');
    if((code==='Escape'&&action!=='pause')||(action==='pause'&&slot===0&&code!=='Escape'))return fail('Esc fica reservado para pausar e sair dos menus.');
    if(state.bindings[action][slot]===code)return {ok:true,state:getState(),unchanged:true};
    if(state.bindings[action].some((key,index)=>index!==slot&&key===code))return fail('Esta ação já usa essa tecla. Escolha outra alternativa.');
    const conflicts=[];
    for(const item of actions)if(item.id!==action)state.bindings[item.id].forEach((key,index)=>{if(key===code)conflicts.push({action:item.id,slot:index,label:item.label});});
    const previous=state.bindings[action][slot];
    if(conflicts.length&&!options.replaceConflicts&&!options.swapConflicts)return {ok:false,conflicts,message:'Essa tecla já está em uso. Confirme a troca ou escolha outra.'};
    if(conflicts.length&&options.swapConflicts){
      if(conflicts.length!==1||!previous)return fail('Escolha uma tecla livre para adicionar uma alternativa.');
      const conflict=conflicts[0];state.bindings[conflict.action][conflict.slot]=previous;
    }else if(conflicts.length){
      if(conflicts.some(({action:other})=>state.bindings[other].length<=1))return {...fail('Essa troca deixaria uma ação sem tecla. Use a troca de teclas para manter os dois comandos.'),conflicts};
      for(const {action:other,slot:index} of conflicts)state.bindings[other].splice(index,1);
    }
    state.bindings[action][slot]=code;state.bindings[action]=state.bindings[action].filter(Boolean);
    return persist();
  }
  function clearBinding(action,slot=0){
    if(!state.bindings[action]||!Number.isInteger(slot)||slot<0||slot>1)return fail('Ação ou posição de tecla inválida.');
    if(action==='pause'&&slot===0)return fail('Esc fica reservado para sair dos menus.');
    if(state.bindings[action].length<=1)return fail('Mantenha pelo menos uma tecla para esta ação.');
    state.bindings[action].splice(slot,1);return persist();
  }
  function setNumber(key,value,min,max){const n=Number(value);if(!Number.isFinite(n))return fail('Use um valor numérico válido.');state[key]=clamp(n,min,max);return persist();}
  const matches=(action,code)=>!!state.bindings[action]?.includes(canonicalCode(code));
  function pressed(action,keys={}){return !!state.bindings[action]?.some(code=>keys[code]||code==='ShiftLeft'&&keys.ShiftRight);}
  function transformJoystick(x,y){
    x=clamp(Number(x)||0,-1,1);y=clamp(Number(y)||0,-1,1);
    const magnitude=Math.hypot(x,y);if(magnitude<=state.deadzone)return {x:0,y:0};
    const response=Math.pow(clamp((magnitude-state.deadzone)/(1-state.deadzone),0,1),1/state.sensitivity);
    return {x:x/magnitude*response,y:y/magnitude*response};
  }
  window.ControlSettings=Object.freeze({schema,actions,getState,canonicalCode,labelForCode,
    getLabel:(action,slot)=>slot===undefined?(state.bindings[action]||[]).map(labelForCode).join(' / '):labelForCode(state.bindings[action]?.[slot]),
    matches,pressed,getSensitivity:()=>state.sensitivity,getActionsForCode:code=>actions.filter(({id})=>matches(id,code)).map(({id})=>id),
    setBinding,clearBinding,setSensitivity:value=>setNumber('sensitivity',value,.5,2),setDeadzone:value=>setNumber('deadzone',value,0,.4),
    transformJoystick,reset:()=>{state=defaults();return persist();}
  });
})();
