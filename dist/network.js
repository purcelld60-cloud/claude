/* The native game keeps local assets offline. Only arena requests use this bridge. */
(() => {
  'use strict';
  const pending=new Map();let serial=0;
  const safePath=path=>/^\/api\/arena\/rooms(?:\/[A-Z0-9]{6}(?:\/(?:join|sync|leave|signal))?)?$/.test(path);
  function request(path,options={}) {
    if(!safePath(path)||options.method!=='POST')return Promise.reject(new Error('Pedido de arena inválido.'));
    const body=typeof options.body==='string'?options.body:JSON.stringify(options.body||{});
    if(new TextEncoder().encode(body).length>65536)return Promise.reject(new Error('Pedido de arena muito grande.'));
    const native=window.DaRocaArena?.request||window.webkit?.messageHandlers?.arenaRequest;
    if(!native)return fetch(path,{...options,body,credentials:'omit',cache:'no-store',headers:{'Content-Type':'application/json',...options.headers}});
    return new Promise((resolve,reject)=>{
      const id='arena_'+Date.now().toString(36)+'_'+(++serial),authorization=new Headers(options.headers||{}).get('Authorization')||'';
      const timer=setTimeout(()=>{pending.delete(id);reject(new Error('A arena demorou para responder. Confira a internet.'));},18000);
      pending.set(id,{resolve,reject,timer});
      try{
        if(window.DaRocaArena?.request)window.DaRocaArena.request(id,path,'POST',body,authorization);
        else window.webkit.messageHandlers.arenaRequest.postMessage({id,path,method:'POST',body,authorization});
      }catch(error){clearTimeout(timer);pending.delete(id);reject(error);}
    });
  }
  window.addEventListener('daroca-arena-response',event=>{
    const detail=event.detail||{},entry=pending.get(detail.id);if(!entry)return;
    pending.delete(detail.id);clearTimeout(entry.timer);
    entry.resolve(new Response(detail.body||'{}',{status:Math.max(200,Math.min(599,Number(detail.status)||503)),headers:{'Content-Type':'application/json'}}));
  });
  window.DaRocaNetwork=Object.freeze({request});
})();
