/* A Conquista usa o controle, piso e progressão do Terreiro. Seus golpes e efeitos são próprios.
   O modelo de arena de cada entrada conserva as plataformas e a escala de atributos do save. */
(() => {
  'use strict';
  if (window.C2Luta) return;
  // A chave kit identifica o terreno e o perfil numérico usados pelo Terreiro.
  const KIT = {
    creuza: { kit: 'dede', vida: 1.6 },
    tonhao: { kit: 'arthur', vida: 1.6 },
    valdomiro: { kit: 'freddy', vida: 2 },
    kaua: { kit: 'menezes', vida: 1 },
    barao: { kit: 'reeisBoss', vida: 1.7 },
    breno: { kit: 'freddy', vida: 3 },
    gemeos: { kit: 'arthur', vida: 3 },
    fred: { kit: 'reeisBoss', vida: 2.2 },
    jorge: { kit: 'nicolas', vida: 2 }
  };
  let skin = null, aoFim = null, camBase = 0, cam0 = null, entrando = false;
  function iniciar(o = {}, fim) {
    const k = KIT[o.slug]; if (!k || skin || !window.Game?.startSandboxBoss || !window.ConquistaCombate?.chefes[o.slug]) return false;
    const fase=window.CampanhaFases.FASES[o.slug];
    const lugar=window.CampanhaCenarios?.lista.find(d=>d.id===o.cena)?.nome;
    skin = { lugar, nivel:fase.chefe.nivel, kit: k.kit, vida: k.vida, dano: 1.3, tipo: o.tipo, nome: o.nome || o.slug, tema: o.slug, cena: o.cena, bossX: o.bossX };
    const larg = window.CampanhaCenarios?.largura?.(o.cena) || 4000; camBase = Math.max(0, Math.min(larg - 960, (Number(o.bossX) || 480) - 480)); cam0 = null; aoFim = fim;
    try { if (localStorage.getItem('daroca-sandbox-v1') !== '1') localStorage.setItem('daroca-sandbox-v1', '1'); } catch (e) {} // quem chegou na Campanha 2 já terminou a principal
    // a Campanha 2 segura os controles enquanto está aberta (controls-capture); na luta quem joga é o motor da principal
    try { dispatchEvent(new CustomEvent('controls-capture', { detail: { active: false } })); } catch (e) {}
    let ok = false; entrando = true;
    try { ok = !!window.Game.startSandboxBoss(k.kit); } catch (e) { ok = false; } finally { entrando = false; }
    if (ok) window.DayTime?.force?.(o.hora ?? fase.hora);
    else { skin = null; aoFim = null; dispatchEvent(new CustomEvent('controls-capture', {detail:{active:true}})); } return ok;
  }
  addEventListener('sandbox-change', (e) => {
    const d = e.detail;
    if (!skin || !aoFim || entrando) return;
    if (!d) { // O botão de pausa também permite sair diretamente do Terreiro.
      const cb=aoFim; aoFim=null; skin=null; window.DayTime?.force?.(null); cb('recuou'); return;
    }
    if (!d.result || d.type !== skin.kit) return;
    const r = d.result, cb = aoFim; aoFim = null;
    setTimeout(() => { skin = null; window.DayTime?.force?.(null); try { window.Game.exitSandbox(); } catch (x) {} cb?.(r === 'won' ? 'venceu' : r === 'retreat' ? 'recuou' : 'perdeu'); }, r === 'won' ? 700 : 500);
  });
  // fundo: o cenário da Campanha 2 onde o vilão está, acompanhando a câmera da luta
  function desenharFundo(ctx, camera, time) {
    if (!skin) return false; if (cam0 === null) cam0 = camera;
    const larg = window.CampanhaCenarios?.largura?.(skin.cena) || 4000, cx = Math.max(0, Math.min(larg - 960, camBase + (camera - cam0)));
    try { window.Art?.drawScene?.(ctx, skin.cena, cx, time); } catch (e) { return false; } return true;
  }
  const timbres = {
    creuza:[720,'sine'], tonhao:[104,'sawtooth'], valdomiro:[260,'triangle'], kaua:[840,'square'],
    barao:[176,'triangle'], breno:[96,'triangle'], gemeos:[516,'square'], fred:[353,'triangle'], jorge:[286,'sine']
  };
  function som(slug, beep, fase) {
    const [hz,onda]=timbres[slug];beep(hz+(slug==='jorge'?fase*24:0),.11,onda,.023);
  }
  window.C2Luta = Object.freeze({ get skin() { return skin; }, iniciar, desenharFundo, som, kits: KIT });
})();
