// Abra dist/ com o servidor do README antes de rodar. Os atalhos são injetados só na página de teste.
const {chromium, devices} = require('playwright');
const assert = require('node:assert/strict');
const fs = require('node:fs/promises');
const path = require('node:path');
const url = process.env.JOGO_URL || 'http://127.0.0.1:8080/';
const pasta = process.env.CAPTURAS_CONQUISTA;
async function instrumentar(p) {
  await p.route('**/game.js?*',async route=>{
    const res=await route.fetch();
    let js=await res.text();
    assert(js.includes('window.Game={') && js.includes('const dt=Math.min(.035,(now-last)/1000);'));
    js=js.replace('const dt=Math.min(.035,(now-last)/1000);','const dt=window.relogioManual?0:Math.min(.035,(now-last)/1000);')
      .replace('window.Game={',`window.testeConquista={
        bater:()=>damageEnemy(activeBoss,1e7,'paper'),
        perder:()=>{player.inv=0;hurt(1e7,player.x+50);},
        passo:(n,proteger=true)=>{for(let i=0;i<n;i++){if(proteger)player.inv=2;update(1/60);updateEpic(1/60);}draw();},
        get luta(){return activeBoss?.conquista;}
      };window.Game={`);
    await route.fulfill({response:res,body:js});
  });
}
async function capturar(p,nome) {
  if (!pasta) return;
  const png=await p.locator('#gameCanvas').evaluate(c=>c.toDataURL('image/png').split(',')[1]);
  await fs.writeFile(path.join(pasta,nome+'.png'),Buffer.from(png,'base64'));
}
async function main() {
  if(pasta)await fs.mkdir(pasta,{recursive:true});
  const b=await chromium.launch({executablePath:process.env.PLAYWRIGHT_CHROMIUM_EXECUTABLE_PATH||undefined});
  try {
    const celular=process.env.TELA_CONQUISTA==='celular';
    const tela=celular?devices['iPhone 13 landscape']:{viewport:{width:1280,height:720}};
    const contexto=await b.newContext({...tela,deviceScaleFactor:1,serviceWorkers:'block'});
    const p=await contexto.newPage(), erros=[]; p.on('pageerror',e=>erros.push(e.message));
    await instrumentar(p);
    await p.addInitScript(()=>{
      localStorage.setItem('daroca-sandbox-v1','1');
      localStorage.setItem('daroca-c2-save',JSON.stringify({v:1,passo:'jorge',cena:14,x:2080,hp:100,flags:{embarcou:1,venceu_fred:1}}));
    });
    await p.goto(url); await p.waitForFunction(()=>window.Game&&window.ConquistaCombate&&window.Campanha2);
    // Percorre todos os padrões com o controle de vida, a atualização e o renderizador usados pelo jogo.
    const slugs=await p.evaluate(()=>CampanhaFases.lista());
    for(const slug of slugs) {
      assert(await p.evaluate(s=>{
        window.resultadoC2='';const F=CampanhaFases.FASES[s];
        return C2Luta.iniciar({slug:s,tipo:F.chefe.tipo,nome:F.chefe.nome,cena:F.cena,bossX:F.chefe.x},r=>window.resultadoC2=r);
      },slug));
      if(slug==='creuza'){
        await p.waitForFunction(()=>Game.getBossStatus()?.state==='windup');
        const hp=await p.evaluate(()=>Game.getBossStatus().hp);
        if(celular)await p.locator('[data-action="paper"]:visible').first().tap();
        else await p.keyboard.press('KeyJ');
        await p.waitForFunction(antes=>Game.getBossStatus().hp<antes,hp,{timeout:4500});
      }
      const vistos=await p.evaluate(s=>{
        window.relogioManual=true; const qa=window.testeConquista, listas=ConquistaCombate.chefes[s].fases;
        const vistos=new Set();
        for(let fase=0;fase<listas.length;fase++){
          const esperados=new Set(listas[fase]);
          for(let i=0;i<1800&&esperados.size;i++){
            qa.passo(5);
            if(qa.luta.estado==='firing'&&qa.luta.tempo>.06){
              vistos.add(qa.luta.golpe); esperados.delete(qa.luta.golpe);
              if(!qa.luta.objetos.length||Game.getState().shots.some(o=>o.owner==='enemy'))throw Error('Ataque incorreto '+s);
            }
          }
          if(esperados.size)throw Error('Padrões ausentes '+[...esperados]);
          if(fase<listas.length-1){qa.bater();if(qa.luta.fase!==fase+2)throw Error('Sem virada '+s);}
        }
        return [...vistos];
      },slug);
      await capturar(p,slug);
      console.log(slug,vistos.length,'golpes renderizados');
      await p.evaluate(s=>{if(s==='fred')Game.exitSandbox();else Game.retreatBoss();window.relogioManual=false;},slug);
      await p.waitForFunction(()=>window.resultadoC2==='recuou'&&!C2Luta.skin);
    }
    // A revanche de Nikolas segue com as quatro barras originais.
    assert(await p.evaluate(()=>Game.startSandboxBoss('nikolas')));
    assert.deepEqual(await p.evaluate(()=>[Game.getBossStatus().phaseCount,!!testeConquista.luta]),[4,false]);
    await p.evaluate(()=>Game.exitSandbox());

    // Checkpoint da praça -> cena do Centro -> perder -> checkpoint -> cinco barras -> final -> créditos -> save.
    await p.evaluate(()=>document.getElementById('menuJogarBtn').click());
    await p.evaluate(()=>document.querySelector('[data-open-campanha2]').click());
    await p.evaluate(()=>document.querySelector('#c2Painel [data-a="cont"]').click());
    const entrar=async()=>{
      await p.waitForFunction(()=>Campanha2.aberto()&&Campanha2._fase()?.slug==='jorge');
      await p.evaluate(()=>Campanha2._pos(2310,440));
      await p.waitForFunction(()=>Campanha2.estado().cutscene);
      await p.evaluate(()=>Campanha2._pular());
      await p.waitForFunction(()=>Campanha2.emLuta()&&Game.getBossStatus()?.state==='windup');
    };
    await entrar();
    await p.evaluate(()=>testeConquista.perder());
    await p.waitForFunction(()=>!Campanha2.emLuta()&&Campanha2.aberto());
    assert.equal(await p.evaluate(()=>Campanha2.estado().passo),'jorge');
    const voltar=p.locator('.c2j button[data-a="de-novo"]');
    await voltar.click(); await entrar();
    await p.evaluate(()=>{window.relogioManual=true;});
    for(let i=1;i<=5;i++){
      const st=await p.evaluate(()=>Game.getBossStatus());
      assert.equal(st.phase,i);assert.equal(st.phaseCount,5);assert.equal(st.max,st.hp);
      await p.waitForFunction(n=>document.getElementById('bossHud').dataset.phase===String(n),i);
      assert.equal(await p.locator('#bossHudPhase i[data-phase]').count(),5);
      await p.evaluate(()=>{const qa=testeConquista;for(let i=0;i<160&&!(qa.luta.estado==='firing'&&qa.luta.tempo>.29);i++)qa.passo(2);});
      await capturar(p,'jorge-fase-'+i);
      await p.evaluate(()=>testeConquista.bater());
      if(i<5){
        assert.deepEqual(await p.evaluate(()=>{const qa=testeConquista;const hp=Game.getBossStatus().hp;qa.bater();return [qa.luta.estado,qa.luta.objetos.length,qa.luta.marcas.length,hp===Game.getBossStatus().hp];}),['phaseChange',0,0,true]);
        await p.evaluate(()=>testeConquista.passo(48)); await capturar(p,'jorge-virada-'+(i+1));
      }
    }
    await p.evaluate(()=>{window.relogioManual=false;});
    await p.waitForFunction(()=>Campanha2.aberto()&&Campanha2.estado().cutscene==='c2_final_jogo');
    assert.equal(await p.evaluate(()=>!!Campanha2.estado().flags?.zerou),false);
    await p.evaluate(()=>Campanha2._pular());
    await p.waitForFunction(()=>Campanha2.estado().cutscene==='c2_creditos');
    await p.evaluate(()=>Campanha2._pular());
    await p.waitForFunction(()=>JSON.parse(localStorage.getItem('daroca-c2-save')).flags.zerou===1);
    assert.deepEqual(erros,[]); console.log('Final, créditos, save, checkpoint e HUD 5/5 OK');
  } finally {await b.close();}
}
main().catch(e=>{console.error(e);process.exitCode=1;});
