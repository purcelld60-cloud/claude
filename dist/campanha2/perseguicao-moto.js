/* Perseguição do Tonhão. O bagageiro desenhado em cada moto é o apoio usado pelos dois motores. */
(() => {
  'use strict';
  const clamp=(n,l,r)=>Math.max(l,Math.min(r,n));
  const largura=84, cores=['#4b9c99','#ca6955','#776fb5','#4c81ab'];
  const sob=(m,x)=>Math.abs(x-m.x)<=largura/2+4;
  function criar(l,r,piso) {
    const estrada={tempo:0,distancia:0,montou:false,apoio:null,motos:[],fase:1};
    for(let id=0;id<4;id++){
      const base=l+(r-l)*(.12+id*.25), y=piso-57-(id%2)*13;
      const m={id,base,x:base,y,anteriorX:base,anteriorY:y,cor:cores[id],pulo:0};
      m.rival={x:base+25,y:y+3,alto:54,largura:17,hp:0,max:60,hit:0,ejetado:0,dir:-1,
        onDano(n){
          if(this.hp<=0)return false;
          const dano=Math.max(1,Math.round(n));this.hp=Math.max(0,this.hp-dano);this.hit=.16;
          if(!this.hp)this.ejetado=.52;
          return dano;
        }};
      estrada.motos.push(m);
    }
    return estrada;
  }
  function novaFase(f,fase){
    const e=f.estrada;e.fase=fase;
    // Um cobrador na largada, dois nas barras seguintes. Uma moto vazia continua servindo de apoio.
    for(const m of e.motos){
      if((fase===1&&m.id===1)||(fase===2&&(m.id===1||m.id===3))||(fase===3&&(m.id===1||m.id===2))){
        m.rival.max=42+fase*10; m.rival.hp=m.rival.max; m.rival.ejetado=0;
      }else m.rival.hp=0;
    }
  }
  function perto(e,x){
    return e.motos.reduce((a,b)=>Math.abs(b.x-x)<Math.abs(a.x-x)?b:a);
  }
  function avancar(f,dt,p){
    const e=f.estrada;
    if(!e.montou){
      const m=e.motos[0]; p.x=m.x-10;p.y=m.y;p.vx=p.vy=0;p.ground=true;p.facing=1;
      e.montou=true;e.apoio=m.id;
    }
    e.tempo+=dt;e.distancia+=dt*(205+44*f.fase);
    for(const m of e.motos){
      const t=e.tempo, fase=m.id*1.61;
      m.anteriorX=m.x;m.anteriorY=m.y;
      m.x=m.base+22*Math.sin(t*.91+fase)+6*Math.sin(t*2.15+fase);
      m.y=f.piso-60-15*(m.id%2)+7*Math.sin(t*1.6+fase)+2*Math.sin(t*7+fase);
      if(e.apoio===m.id&&p.ground&&p.vy>=0){
        p.x+=m.x-m.anteriorX;p.y+=m.y-m.anteriorY;
      }
      m.rival.x=m.x+25;m.rival.y=m.y+3;
      m.rival.hit=Math.max(0,m.rival.hit-dt);
      m.rival.ejetado=Math.max(0,m.rival.ejetado-dt);
      m.pulo=Math.max(0,m.pulo-dt);
    }
    f.y=f.piso-65+3*Math.sin(e.tempo*5.7);
    for(const o of f.objetos)if(o.moto!==undefined){
      const m=e.motos[o.moto];o.x0=o.x1=m.x;o.y0=o.y1=m.y-o.ry;
    }
    for(const o of f.objetos)if(o.cobrador!==undefined&&!e.motos[o.cobrador].rival.hp&&
      (f.estado==='windup'||(f.estado==='firing'&&f.tempo<o.atraso)))o.fim=true;
  }
  function pousar(f,p,antes,ferir){
    const e=f.estrada,ultimo=e.apoio;e.apoio=null;
    if(p.vy>=0)for(const m of e.motos){
      if(!sob(m,p.x)||antes>Math.max(m.y,m.anteriorY)+3||p.y<m.y)continue;
      if(ultimo!==m.id)m.pulo=.20;
      p.y=m.y;p.vy=0;p.ground=true;e.apoio=m.id;return;
    }
    if(p.y<f.piso+1)return;
    const m=perto(e,p.x);
    ferir(10,p.x); p.x=m.x-12;p.y=m.y;p.vx=p.vy=0;p.ground=true;e.apoio=m.id;m.pulo=.2;
    p.inv=Math.max(p.inv||0,.95);
  }
  function setores(a,art,altura,dois){
    const e=a.f.estrada,m=perto(e,a.x), indices=[m.id];
    if(dois)indices.push(m.id===3?2:m.id+1);
    return indices.map((id,k)=>{
      const apoio=e.motos[id],o=a.area(art,apoio.x,largura+13,altura,k*.44,.76);
      o.moto=id;o.y0=o.y1=apoio.y-o.ry;return o;
    });
  }
  function recibos(a){
    const h=a.f.piso-a.f.y;
    const lista=[a.mov('recibo',a.b,h+41,a.edge,a.altura,.87,{onda:17,rx:13})];
    const e=a.f.estrada;
    for(const m of e.motos)if(m.rival.hp>0){
      lista.push(a.mov('recibo',m.rival.x,a.f.piso-m.rival.y+37,a.alvo(0),a.altura,.78,
        {arco:27,atraso:.28+.24*(lista.length-1),rx:12,ry:10,cobrador:m.id}));
    }
    return lista;
  }
  function alvo(f,p,chefe){
    let escolhido=chefe,dist=Math.sign(chefe.x-p.x)===p.facing?Math.abs(chefe.x-p.x):Infinity;
    for(const m of f.estrada.motos){const r=m.rival,d=(r.x-p.x)*p.facing;
      if(r.hp>0&&d>0&&d<dist){dist=d;escolhido=r;}
    }
    return escolhido;
  }
  function acertar(f,s){
    for(const m of f.estrada.motos){const r=m.rival;
      if(r.hp>0&&Math.abs(s.x-r.x)<r.largura+7&&s.y>r.y-r.alto-6&&s.y<r.y+5){r.onDano(s.damage);return true;}
    }
    return false;
  }
  const px=(c,x,y,w,h,cor)=>{c.fillStyle=cor;c.fillRect(Math.round(x),Math.round(y),Math.round(w),Math.round(h));};
  function pol(c,pts,cor){
    c.fillStyle=cor;c.beginPath();c.moveTo(Math.round(pts[0][0]),Math.round(pts[0][1]));
    for(let i=1;i<pts.length;i++)c.lineTo(Math.round(pts[i][0]),Math.round(pts[i][1]));c.closePath();c.fill();
  }
  function traco(c,pts,cor,w=2){
    c.strokeStyle=cor;c.lineWidth=w;c.lineJoin='bevel';c.beginPath();c.moveTo(Math.round(pts[0][0]),Math.round(pts[0][1]));
    for(let i=1;i<pts.length;i++)c.lineTo(Math.round(pts[i][0]),Math.round(pts[i][1]));c.stroke();
  }
  let paisagem;
  function serra(){
    if(paisagem)return paisagem;
    const img=document.createElement('canvas');img.width=480;img.height=215;const c=img.getContext('2d');
    const g=c.createLinearGradient(0,0,0,204);
    g.addColorStop(0,'#4190c8');g.addColorStop(.57,'#8bd2df');g.addColorStop(1,'#fee2a6');c.fillStyle=g;c.fillRect(0,0,480,215);
    for(const [dy,w] of [[0,11],[2,19],[5,25],[8,29],[14,28],[19,22],[23,14]])px(c,369-w/2,31+dy,w,5,'#fff1b5');
    for(let n=0;n<8;n++){const x=n*69-25,y=28+(n*43)%61;
      pol(c,[[x,y+7],[x+5,y+7],[x+5,y+4],[x+17,y+4],[x+17,y],[x+28,y],[x+28,y+3],[x+38,y+3],[x+38,y+7],[x+49,y+7],[x+49,y+10],[x,y+10]],'#e2eeeb');}
    for(let k=0;k<3;k++){
      const pts=[[0,215]];
      for(let x=0;x<=480;x+=4){const a=x/480*Math.PI*2;pts.push([x,124+23*k+Math.sin(a*(2+k)+k)*15+Math.cos(a*4+k)*6]);}
      pol(c,[...pts,[480,215]],['#96b9bb','#779e9a','#5c8980'][k]);
    }
    for(let k=0;k<32;k++){const x=(k*31)%480,y=165+(k*17)%19,w=6+(k%3)*2;
      px(c,x,y,w,5+k%3,['#d6bd93','#ac9890','#c7b393'][k%3]);pol(c,[[x-1,y],[x+w/2,y-4],[x+w+2,y]],'#9e7161');px(c,x+2,y+1,2,2,'#576b69');}
    return paisagem=img;
  }
  function fundo(c,f){
    const d=f.estrada.distancia, faixa=(((d*.10)%960)+960)%960;
    c.save();c.imageSmoothingEnabled=false;c.drawImage(serra(),-Math.round(faixa),0,960,430);c.drawImage(serra(),960-Math.round(faixa),0,960,430);
    px(c,0,362,960,178,'#556369');px(c,0,362,960,4,'#a3aca0');px(c,0,369,960,6,'#7a8582');
    for(let i=0;i<10;i++){const x=i*126-(d*.64%126);px(c,x,344,5,23,'#5d726e');px(c,x-3,343,12,3,'#c3c3a4');}
    px(c,0,349,960,5,'#b8c2ad');px(c,0,353,960,3,'#778d84');
    for(let i=0;i<9;i++){const x=i*160-(d%160);px(c,x,417,72,3,'#d7b365');px(c,x-12,430,73,3,'#e8c77d');px(c,x-48,496,99,6,'#b7b7a9');}
    for(let i=0;i<35;i++){const x=((i*167-d*.85)%1000+1000)%1000-25;px(c,x,381+i%9*16,5+i%4*4,1,'#46585f');}
    const poste=915-(d*.5%1190);
    px(c,poste,226,7,121,'#576d69');px(c,poste-81,222,157,45,'#344f50');px(c,poste-78,225,151,38,'#488575');
    c.fillStyle='#f7edbe';c.font='bold 13px monospace';c.textAlign='center';c.fillText('BR-116  →',poste,241);c.font='10px monospace';c.fillText('VITÓRIA DA CONQUISTA',poste,256);
    if(f.estrada.tempo<4){
      const dica='PULE ENTRE AS MOTOS E ACERTE OS COBRADORES';
      c.font='bold 15px monospace';
      const w=Math.ceil(c.measureText(dica).width)+24;
      px(c,480-w/2,86,w,24,'#263c44');c.fillStyle='#fff0c5';c.fillText(dica,480,103);
    }
    c.restore();
  }
  function roda(c,x,y,t,cor){
    pol(c,[[x-9,y-13],[x+9,y-13],[x+14,y-8],[x+14,y+7],[x+8,y+13],[x-8,y+13],[x-14,y+7],[x-14,y-7]],'#28333b');
    pol(c,[[x-6,y-9],[x+6,y-9],[x+9,y-5],[x+9,y+5],[x+5,y+8],[x-5,y+8],[x-9,y+5],[x-9,y-5]],'#82969a');
    for(let i=0;i<3;i++){const a=t+i*2.094;traco(c,[[x,y],[x+7*Math.cos(a),y+7*Math.sin(a)]],'#384b55',3);}
    px(c,x-2,y-2,4,4,cor);
  }
  function piloto(c,x,y,cor,capacete,chefe,acao,t,hit){
    c.save();c.translate(Math.round(x),Math.round(y));
    const pele=hit?'#fff2cc':chefe?'#a96f48':'#ad7c59', bal=acao?Math.round(3*Math.sin(t*8)):0;
    traco(c,[[-6,-10],[4,0],[15,6],[10,15]],'#29343f',8);px(c,6,13,13,5,'#34454b');
    pol(c,[[-10,-12],[-11,-31],[-4,-40],[9,-38],[15,-25],[7,-10]],'#263943');
    pol(c,[[-8,-13],[-9,-29],[-3,-37],[7,-35],[12,-25],[5,-13]],cor);
    px(c,-7,-24,17,3,chefe?'#f3e873':'#d6dab9');
    traco(c,[[5,-32],[14,-23+bal],[24,-24+bal]],'#29343d',7);traco(c,[[6,-32],[14,-24+bal],[22,-24+bal]],pele,4);
    pol(c,[[-7,-41],[-8,-50],[-4,-56],[7,-57],[15,-51],[15,-42],[11,-36],[1,-36]],'#2a3540');
    px(c,-5,-52,18,11,capacete);px(c,-2,-55,12,4,capacete);px(c,-2,-53,10,2,'#f1d8af');
    px(c,3,-49,13,5,'#344c5a');px(c,6,-49,8,2,'#b2e1da');px(c,4,-43,9,6,pele);
    if(chefe){px(c,7,-40,7,2,'#302621');px(c,-7,-31,3,14,'#e6da71');}
    if(acao&&!chefe){traco(c,[[-6,-30],[-13,-33],[-17,-41]],pele,4);px(c,-21,-47,11,10,'#f4e0b3');px(c,-20,-44,8,2,'#c47b63');}
    c.restore();
  }
  function moto(c,x,y,cor,t,bal,chefe,rival,f){
    c.save();c.translate(Math.round(x),Math.round(y));
    const treme=Math.round(bal*3+(chefe?Math.sin(t*8)*1.5:0));
    px(c,-39,42,96,3,'#414e55');px(c,-29,45,68,2,'#4c595f');
    for(let i=0;i<3;i++){const u=(t*2.2+i/3)%1;px(c,-46-u*37,22+i*4-u*5,4+u*8,2,i%2?'#a2a8a2':'#8e9a98');}
    roda(c,-31,28,t*17,cor);roda(c,45,28,t*17,cor);
    c.translate(0,treme);
    traco(c,[[-32,27],[-7,7],[16,26],[33,4],[45,27]],'#263742',6);
    traco(c,[[-30,25],[-6,9],[15,24],[33,3],[45,26]],'#bac1b5',3);
    pol(c,[[-44,9],[-36,4],[-23,5],[-10,11],[5,-4],[24,-8],[39,1],[32,13],[13,17],[-5,16],[-13,10]],cor);
    px(c,-14,9,26,8,'#667477');for(let i=0;i<3;i++)px(c,-12,10+i*2,18,1,'#b1b6a9');
    px(c,-46,18,34,4,'#a4a8a2');px(c,-45,21,26,2,'#37474c');
    traco(c,[[28,-1],[35,-20],[44,-22]],'#384953',4);px(c,34,-10,12,8,'#f6d77e');px(c,36,-9,8,4,'#fff3b2');
    px(c,-45,-1,83,5,'#293943');px(c,-41,-1,77,2,'#d5b486');px(c,-33,3,34,3,'#536167');
    if(chefe){piloto(c,6,-2,'#ee8c31','#c84035',true,f.estado==='firing',t,false);}
    else if(rival.hp>0){piloto(c,17,-1,cor,'#414e60',false,f.golpe==='recibo'&&(f.estado==='windup'||f.estado==='firing'),t,rival.hit>0);}
    else if(rival.ejetado>0){const u=1-rival.ejetado/.52;c.save();c.translate(17-u*77,-Math.sin(u*Math.PI)*37+u*18);c.rotate(-u*.8);c.globalAlpha=1-u;piloto(c,0,-1,cor,'#414e60',false,false,t,false);c.restore();}
    else{px(c,18,-10,12,8,'#5c493f');px(c,17,-10,14,2,'#c2a578');}
    if(!chefe&&rival.hp>0&&rival.hp<rival.max){px(c,7,-69,24,3,'#2c3b40');px(c,8,-68,22*rival.hp/rival.max,1,'#eeb57c');}
    if(chefe&&f.estado==='windup'){px(c,37,-9,8,3,Math.sin(t*15)>.1?'#fff8db':'#d79746');}
    c.restore();
  }
  function plataformas(c,f){
    for(const m of f.estrada.motos)moto(c,m.x,m.y,m.cor,f.estrada.tempo,m.pulo/.20,false,m.rival,f);
  }
  function personagem(c,f){moto(c,f.x,f.y,'#e77738',f.estrada.tempo,0,true,null,f);}
  window.PerseguicaoMoto=Object.freeze({criar,novaFase,avancar,pousar,setores,recibos,alvo,acertar,fundo,plataformas,personagem,largura});
})();
