/* Da Roça Adventure — lutas dos vilões da Campanha 2 no MESMO motor de luta da Campanha 1.
   A luta usa o Terreiro dos Chefes do game.js (arena, barra do chefe, dash, ataques em área,
   projéteis, física, HUD e controles da principal). Só a aparência e o nome mudam: cada vilão
   da Campanha 2 usa o repertório de golpes do chefe da principal mais parecido com ele, luta no
   cenário dele em Vitória da Conquista com o palco de arena da principal por cima (boss-arena.js),
   e a vida cresce na ordem da história. Ao vencer ou perder, volta para a Campanha 2.
   API: C2Luta.iniciar({ slug, tipo, nome, cena, bossX }, aoFim('venceu' | 'perdeu')), C2Luta.skin. */
(() => {
  'use strict';
  if (window.C2Luta) return;
  // vilão da Campanha 2 → chefe da principal (golpes) e quanto a vida cresce (o Da Roça chega mais forte)
  const KIT = {
    creuza: { kit: 'dede', vida: 1.6 },       // cortina de fumaça (fofoca), leque, minas e dash
    tonhao: { kit: 'arthur', vida: 1.6 },     // leque, investida e onda
    valdomiro: { kit: 'freddy', vida: 2 },    // leque pesado, dash e pisão
    kaua: { kit: 'menezes', vida: 1 },
    barao: { kit: 'reeisBoss', vida: 1.7 },   // leque da gangue, dash e minas
    breno: { kit: 'freddy', vida: 3 },
    gemeos: { kit: 'arthur', vida: 3 },
    fred: { kit: 'reeisBoss', vida: 2.2 },
    jorge: { kit: 'nicolas', vida: 2 }        // aura e raios: o chefe final
  };
  let skin = null, aoFim = null, camBase = 0, cam0 = null;
  function iniciar(o = {}, fim) {
    const k = KIT[o.slug]; if (!k || !window.Game?.startSandboxBoss) return false;
    skin = { kit: k.kit, vida: k.vida, dano: 1.3, tipo: o.tipo, nome: o.nome || o.slug, tema: o.slug, cena: o.cena, bossX: o.bossX };
    const larg = window.CampanhaCenarios?.largura?.(o.cena) || 4000; camBase = Math.max(0, Math.min(larg - 960, (Number(o.bossX) || 480) - 480)); cam0 = null; aoFim = fim;
    try { if (localStorage.getItem('daroca-sandbox-v1') !== '1') localStorage.setItem('daroca-sandbox-v1', '1'); } catch (e) {} // quem chegou na Campanha 2 já terminou a principal
    let ok = false; try { ok = !!window.Game.startSandboxBoss(k.kit); } catch (e) { ok = false; }
    if (!ok) { skin = null; aoFim = null; } return ok;
  }
  addEventListener('sandbox-change', (e) => {
    const d = e.detail; if (!skin || !d || !d.result) return; const r = d.result, cb = aoFim; aoFim = null;
    setTimeout(() => { try { window.Game.exitSandbox(); } catch (x) {} skin = null; cb?.(r === 'won' ? 'venceu' : r === 'retreat' ? 'recuou' : 'perdeu'); }, r === 'won' ? 700 : 500);
  });
  // fundo: o cenário da Campanha 2 onde o vilão está, acompanhando a câmera da luta
  function desenharFundo(ctx, camera, time) {
    if (!skin) return false; if (cam0 === null) cam0 = camera;
    const larg = window.CampanhaCenarios?.largura?.(skin.cena) || 4000, cx = Math.max(0, Math.min(larg - 960, camBase + (camera - cam0)));
    try { window.Art?.drawScene?.(ctx, skin.cena, cx, time); } catch (e) { return false; } return true;
  }
  window.C2Luta = Object.freeze({ get skin() { return skin; }, iniciar, desenharFundo, kits: KIT });
})();
