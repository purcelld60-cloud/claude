/* Festa da Roça: original low-poly characters and fully 3D festival arenas. */
(() => {
'use strict';
const palette=['#ffd166','#65d9ec','#ff837f','#b991ff','#8be3aa','#ffa763','#8ebcff','#eda6d2'];
const looks={
 daroca:{skin:'#c89561',shirt:'#e29b4d',pants:'#41626a',hair:'#553325',hat:true},
 reeis:{skin:'#75452f',shirt:'#447b78',pants:'#253947',hair:'#171b20',curls:true,strong:true},
 lucas:{skin:'#efc4a3',shirt:'#8e989f',pants:'#243d69',hair:'#242126',short:true},
 caleb:{skin:'#f2cfb3',shirt:'#e4b958',pants:'#4a5860',hair:'#e6be58',strong:true},
 mota:{skin:'#f0cbae',shirt:'#203f7a',pants:'#25365e',hair:'#dfb454',slim:true},
 marco:{skin:'#edc6ab',shirt:'#202631',pants:'#343847',hair:'#1b1e25',hood:true,slim:true},
 menezes:{skin:'#bd8c64',shirt:'#5f8a94',pants:'#354d5b',hair:'#1d222a',curls:true,glasses:true},
 nikolas:{skin:'#e4b699',shirt:'#8f6597',pants:'#3d4359',hair:'#4c3541',nose:true},
 kaua:{skin:'#cb976d',shirt:'#658d8d',pants:'#2c4962',hair:'#25212b'},
 eloisa:{skin:'#d9af90',shirt:'#f6f2e8',pants:'#233f6d',hair:'#45302a',long:true,lip:true},
 giselle:{skin:'#795035',shirt:'#f6f2e8',pants:'#233f6d',hair:'#17191e',braids:true},
 rayssa:{skin:'#815338',shirt:'#f6f2e8',pants:'#233f6d',hair:'#19171e',curls:true,long:true},
 analaura:{skin:'#f2ccb2',shirt:'#f6f2e8',pants:'#233f6d',hair:'#62402d',curls:true,long:true},
 almiro:{skin:'#a9744d',shirt:'#367cba',pants:'#23354b',hair:'#5a3827',bald:true},
 miqueias:{skin:'#f0c7a7',shirt:'#617b70',pants:'#354653',hair:'#87472d',beard:true,glasses:true},
 freddy:{skin:'#74472f',shirt:'#9e7457',pants:'#324556',hair:'#171b20',curls:true,slim:true},
 dede:{skin:'#b78360',shirt:'#73917e',pants:'#344858',hair:'#252027',spikes:true},
 davi:{skin:'#c79271',shirt:'#222833',pants:'#394957',hair:'#68472f',hood:true,plump:true},
 ravid:{skin:'#d5ae87',shirt:'#7c93a1',pants:'#374a5e',hair:'#5a3d31',glasses:true}
};
const TAU=Math.PI*2;
const clamp=(v,a,b)=>Math.max(a,Math.min(b,v));
function create(canvas,options={}){
 const T=window.THREE;if(!T)throw Error('O motor 3D ainda não carregou. Reabra o modo Festa.');
 let renderer;
 try{renderer=new T.WebGLRenderer({canvas,antialias:true,alpha:false,powerPreference:'high-performance'});}catch(e){options.onError?.(e);throw Error('Este aparelho não conseguiu iniciar o visual 3D. Atualize o navegador ou tente outro aparelho.');}
 renderer.outputColorSpace=T.SRGBColorSpace;renderer.toneMapping=T.ACESFilmicToneMapping;renderer.toneMappingExposure=1.05;
 renderer.shadowMap.enabled=true;renderer.shadowMap.type=T.PCFSoftShadowMap;
 const scene=new T.Scene();scene.background=new T.Color('#93d8f0');scene.fog=new T.Fog('#9bddeb',65,130);
 const camera=new T.PerspectiveCamera(37,16/9,.15,600);camera.position.set(27,30,34);
 const look=new T.Vector3(0,0,0),targetPosition=new T.Vector3(),targetLook=new T.Vector3();
 const hemi=new T.HemisphereLight('#e8fbff','#5d7b70',1.55);scene.add(hemi);
 const sun=new T.DirectionalLight('#fff2cc',2.55);sun.position.set(-18,31,15);sun.castShadow=true;sun.shadow.mapSize.set(window.innerWidth<900?512:1024,window.innerWidth<900?512:1024);sun.shadow.camera.left=-25;sun.shadow.camera.right=25;sun.shadow.camera.top=25;sun.shadow.camera.bottom=-25;sun.shadow.camera.near=.5;sun.shadow.camera.far=80;sun.shadow.normalBias=.035;sun.shadow.bias=-.0001;scene.add(sun);
 const fill=new T.DirectionalLight('#97d9ff',.65);fill.position.set(12,8,-18);scene.add(fill);
 const level=new T.Group(),entities=new T.Group(),actors=new T.Group(),ambience=new T.Group();scene.add(level,entities,actors,ambience);
 const geom=new Map(),mats=new Map(),labelTextures=new Map(),ownedSpriteMaterials=new Set(),ownedInstances=new Set(),dynamic=new Map(),people=new Map(),animators=[];
 let map='',frame=0,lastState=null,localId=null,aspect=16/9,width=960,height=540,quality=1,disposed=false,overview=true,visualTime=0;
 const v=new T.Vector3(),up=new T.Vector3(0,1,0);
 function g(key,make){if(!geom.has(key))geom.set(key,make());return geom.get(key);}
 function material(color,extra={}){const key=color+JSON.stringify(extra);if(!mats.has(key))mats.set(key,new T.MeshStandardMaterial({color,roughness:.78,metalness:.02,...extra}));return mats.get(key);}
 function basic(color,opacity=1){const key='basic'+color+opacity;if(!mats.has(key))mats.set(key,new T.MeshBasicMaterial({color,transparent:opacity<1,opacity,depthWrite:opacity===1,side:T.DoubleSide}));return mats.get(key);}
 function mesh(parent,geometry,mat,x=0,y=0,z=0,cast=false){const o=new T.Mesh(geometry,mat);o.position.set(x,y,z);o.castShadow=cast;o.receiveShadow=true;parent.add(o);return o;}

 function cube(parent,x,y,z,w,h,d,color,extra={}){const o=mesh(parent,g('box',()=>new T.BoxGeometry(1,1,1)),material(color,extra),x,y,z,true);o.scale.set(w,h,d);return o;}
 function cyl(parent,x,y,z,r,h,color,top=r,segments=12){const o=mesh(parent,g('cyl:'+r+':'+top+':'+h+':'+segments,()=>new T.CylinderGeometry(top,r,h,segments)),material(color),x,y,z,true);return o;}
 function batchStatic(parent,skip=null){
  parent.updateMatrixWorld(true);const groups=new Map(),inverse=new T.Matrix4().copy(parent.matrixWorld).invert();
  function collect(o){if(o===skip||!o.visible)return;if(o.isMesh&&!o.isInstancedMesh&&o.material&&!Array.isArray(o.material)&&!o.material.transparent){const key=o.geometry.uuid+o.material.uuid+o.castShadow+o.receiveShadow;if(!groups.has(key))groups.set(key,[]);groups.get(key).push(o);}for(const c of o.children)collect(c);}
  collect(parent);for(const items of groups.values()){if(items.length<2)continue;const first=items[0],inst=new T.InstancedMesh(first.geometry,first.material,items.length),m=new T.Matrix4();inst.castShadow=first.castShadow;inst.receiveShadow=first.receiveShadow;for(let i=0;i<items.length;i++){m.copy(inverse).multiply(items[i].matrixWorld);inst.setMatrixAt(i,m);items[i].parent.remove(items[i]);}inst.instanceMatrix.needsUpdate=true;parent.add(inst);ownedInstances.add(inst);}
 }
 function batchBoxes(parent,list){
  const groups=new Map();for(const a of list){const key=a.color||'#fff';if(!groups.has(key))groups.set(key,[]);groups.get(key).push(a);}
  for(const [color,items] of groups){const inst=new T.InstancedMesh(g('box',()=>new T.BoxGeometry(1,1,1)),material(color),items.length),o=new T.Object3D();inst.castShadow=false;inst.receiveShadow=true;for(let i=0;i<items.length;i++){const a=items[i];o.position.set(a.x||0,a.y||0,a.z||0);o.rotation.set(a.rx||0,a.ry||0,a.rz||0);o.scale.set(a.w||1,a.h||1,a.d||1);o.updateMatrix();inst.setMatrixAt(i,o.matrix);}inst.instanceMatrix.needsUpdate=true;parent.add(inst);ownedInstances.add(inst);}
 }
 function ball(parent,x,y,z,r,color,segments=8){return mesh(parent,g('sphere:'+r+':'+segments,()=>new T.SphereGeometry(r,segments,6)),material(color),x,y,z,true);}
 function ring(parent,x,y,z,r,t,color,opacity=1){const o=mesh(parent,g('torus:'+r+':'+t,()=>new T.TorusGeometry(r,t,5,48)),opacity<1?basic(color,opacity):material(color,{emissive:color,emissiveIntensity:.15}),x,y,z);o.rotation.x=-Math.PI/2;return o;}
 function beam(parent,a,b,r,color){const av=new T.Vector3(...a),bv=new T.Vector3(...b),dir=bv.clone().sub(av),o=mesh(parent,g('cylinderunit',()=>new T.CylinderGeometry(1,1,1,6)),material(color),...(av.add(bv).multiplyScalar(.5).toArray()),true);o.scale.set(r,dir.length(),r);o.quaternion.setFromUnitVectors(up,dir.normalize());return o;}
 function disc(parent,x,y,z,r,color){const o=mesh(parent,g('disc',()=>new T.CircleGeometry(1,48)),material(color),x,y,z);o.rotation.x=-Math.PI/2;o.scale.setScalar(r);return o;}
 function label(text,color='#fff1c6',size=4.4,bg='rgba(23,38,50,.84)'){
  const key=text+color+bg;let texture=labelTextures.get(key);
  if(!texture){const c=document.createElement('canvas');c.width=512;c.height=112;const cx=c.getContext('2d');cx.fillStyle=bg;cx.beginPath();if(cx.roundRect)cx.roundRect(7,13,498,86,25);else cx.rect(7,13,498,86);cx.fill();cx.strokeStyle=color;cx.lineWidth=3;cx.stroke();cx.fillStyle=color;cx.textAlign='center';cx.textBaseline='middle';cx.font='800 34px system-ui, sans-serif';let t=String(text);while(cx.measureText(t).width>460&&t.length>2)t=t.slice(0,-2)+'…';cx.fillText(t,256,57);texture=new T.CanvasTexture(c);texture.colorSpace=T.SRGBColorSpace;labelTextures.set(key,texture);}
  const mat=new T.SpriteMaterial({map:texture,transparent:true,depthTest:false,depthWrite:false});ownedSpriteMaterials.add(mat);const spr=new T.Sprite(mat);spr.scale.set(size,size*112/512,1);spr.renderOrder=40;spr.userData.ownedMaterial=true;return spr;
 }
 function title(parent,text,x,y,z,color='#fff1c6',scale=8){const l=label(text,color,scale);l.position.set(x,y,z);parent.add(l);return l;}
 function model(type='daroca',accent='#ffd166'){
  const l=looks[type]||looks.daroca,root=new T.Group(),body=new T.Group();root.add(body);
  const short=l.short?.78:1,wide=l.strong?1.1:l.plump?1.2:l.slim?.82:1;
  root.userData={body,parts:{},type};
  const shadow=mesh(root,g('shadowdisc',()=>new T.CircleGeometry(.72,20)),basic('#193943',.2),0,.025,0);shadow.rotation.x=-Math.PI/2;shadow.scale.set(1, .65,1);
  const marker=ring(root,0,.035,0,.69,.065,accent);root.userData.marker=marker;
  const hips=cube(body,0,.76,0,.67*wide,.25,.4,l.pants),torso=cube(body,0,1.12,0,.83*wide,.67,.47,l.shirt);
  cube(body,0,1.43,.025,.23,.11,.25,l.skin);
  const head=cube(body,0,1.78,.015,.7,.69,.63,l.skin);root.userData.head=head;
  const parts=root.userData.parts;
  for(const sign of [-1,1]){
   const leg=new T.Group();leg.position.set(sign*.22*wide,.67,0);body.add(leg);cube(leg,0,-.24,0,.27,.5,.3,l.pants);cube(leg,0,-.57,.085,.32,.15,.48,type==='almiro'?'#b2f152':'#f3f0dc');parts[sign<0?'leftLeg':'rightLeg']=leg;
   const arm=new T.Group();arm.position.set(sign*.52*wide,1.38,0);body.add(arm);cube(arm,0,-.23,0,l.strong?.32:.24,.46,.29,l.shirt);cube(arm,0,-.49,.025,l.strong?.29:.22,.24,.24,l.skin);parts[sign<0?'leftArm':'rightArm']=arm;
   cube(body,sign*.16,1.83,.337,.072,.09,.033,'#25272d');cube(body,sign*.17,1.95,.339,.14,.025,.032,l.hair);
  }
  cube(body,0,1.61,.337,.17,.028,.028,l.lip?'#df638d':'#93664f');
  if(l.nose){ball(body,0,1.74,.42,.23,'#d59b82');ball(body,-.055,1.68,.59,.038,'#a97568');}
  else cube(body,0,1.72,.35,.095,.09,.09,l.skin);
  if(!l.bald){
   cube(body,0,2.09,-.015,.76,.18,.68,l.hair);cube(body,0,1.91,-.31,.75,.39,.1,l.hair);
   if(l.curls){for(let i=0;i<5;i++)ball(body,(i-2)*.16,2.16+(i%2)*.035,.05,.15,l.hair);}
   if(l.long||l.braids){for(const sign of[-1,1]){cube(body,sign*.34,1.52,-.13,.18,.95,.31,l.hair);if(l.curls)for(let j=0;j<3;j++)ball(body,sign*.35,1.37+j*.23,.015,.15,l.hair);}if(l.braids)for(let j=-2;j<=2;j++)beam(body,[j*.13,2.19,-.2],[j*.16,1.18,-.35],.06,l.hair);}
   if(l.spikes)for(let i=-1;i<=1;i++){const h=mesh(body,g('hairspike',()=>new T.ConeGeometry(.16,.4,4)),material(l.hair),i*.18,2.3,-.04);h.rotation.z=i*.25;}
  }else{ball(body,0,2.04,.02,.31,l.skin).scale.set(1,.4,1);cube(body,-.13,2.12,.18,.1,.025,.08,'#ffe7bf');}
  if(l.plump)cube(body,0,1.04,.08,.91,.55,.58,l.shirt);
  if(l.hood){cube(body,0,1.48,-.23,.7,.34,.29,'#303947');cube(body,0,1.13,.251,.09,.3,.02,'#748087');}
  if(l.glasses){for(const sign of[-1,1]){const gl=ring(body,sign*.17,1.84,.37,.136,.025,'#263340');gl.rotation.x=0;}cube(body,0,1.84,.38,.1,.025,.035,'#263340');}
  if(l.beard){cube(body,0,1.51,.26,.6,.45,.3,'#9d4b2c');cube(body,0,1.67,.39,.39,.11,.12,'#a45833');}
  if(l.hat){cyl(body,0,2.14,.015,.59,.1,'#d9a950',.59,10);cyl(body,0,2.32,-.01,.35,.31,'#e4bd68',.31,8);cyl(body,0,2.23,-.01,.355,.095,'#77502e',.35,8);}
  if(['eloisa','giselle','rayssa','analaura','mota'].includes(type))cube(body,-.26,1.16,.245,.1,.6,.027,'#234b82');
  if(type==='daroca'){cube(body,-.25,1.15,.25,.027,.57,.02,'#835f3b');cube(body,.25,1.15,.25,.027,.57,.02,'#835f3b');cube(body,0,1.15,.252,.75,.025,.02,'#f3c46e');}
  if(type==='mota'){title(body,'10',0,1.13,.27,'#fff5da',.5);}
  const fixed=new T.Group(),movingParts=new Set(Object.values(parts));for(const child of [...body.children])if(!movingParts.has(child)){body.remove(child);fixed.add(child);}body.add(fixed);batchStatic(fixed);root.scale.setScalar(short);return root;
 }
 function car(accent,character){const root=new T.Group(),base=new T.Group();root.add(base);root.userData.base=base;root.userData.wheels=[];
  cube(base,0,.55,0,1.45,.52,2.18,accent);cube(base,0,.88,-.18,1.3,.47,1.2,accent);cube(base,0,.82,.66,1.12,.24,.39,'#f2dca4');cube(base,0,.93,-.35,1.03,.35,.6,'#334859');
  for(const x of[-.77,.77])for(const z of[-.65,.68]){const wheel=cyl(base,x,.37,z,.32,.22,'#263344',.32,10);wheel.rotation.z=Math.PI/2;root.userData.wheels.push(wheel);const hub=cyl(base,x*1.03,.37,z,.15,.23,'#d8d9c9',.15,8);hub.rotation.z=Math.PI/2;}
  for(const x of[-.45,.45])cube(base,x,.67,1.115,.32,.17,.04,'#fff1b3',{emissive:'#f6d76c',emissiveIntensity:.5});
  cube(base,0,.42,-1.15,1.15,.13,.14,'#d7dcca');const tank=cyl(base,.85,.72,-.18,.18,.7,'#a6c4ce',.18,10);tank.rotation.x=Math.PI/2;
  const driver=model(character,accent);driver.position.set(0,.4,-.24);driver.scale.setScalar(.53);base.add(driver);driver.userData.marker.visible=false;batchStatic(driver);
  const flame=mesh(base,g('boostcone',()=>new T.ConeGeometry(.26,1.25,7)),material('#75ecbd',{emissive:'#58ffd0',emissiveIntensity:.8}),0,.4,-1.7);flame.rotation.x=-Math.PI/2;root.userData.flame=flame;
  return root;
 }
 function tree(parent,x,z,scale=1){const t=new T.Group();t.position.set(x,0,z);t.scale.setScalar(scale);parent.add(t);const trunk=cyl(t,0,1.4,0,.17,2.8,'#b87d51',.115,7);trunk.rotation.z=.08;
  for(let i=0;i<5;i++){const a=i*Math.PI*2/5,leaf=mesh(t,g('palmleaf',()=>new T.ConeGeometry(.63,2.2,4)),material(i%2?'#4ea976':'#78bf78'),Math.sin(a)*.7,2.7,Math.cos(a)*.7);leaf.rotation.z=Math.PI/2;leaf.rotation.y=-a;leaf.rotation.x=.28;}
  ball(t,0,2.69,0,.21,'#9b633b');return t;
 }
 function pine(parent,x,z,scale=1){const t=new T.Group();t.position.set(x,0,z);t.scale.setScalar(scale);parent.add(t);cyl(t,0,.7,0,.15,1.4,'#ae7855');for(let i=0;i<3;i++)mesh(t,g('pine'+i,()=>new T.ConeGeometry(1.1-i*.2,1.5,7)),material(i%2?'#439581':'#55a36f'),0,1.2+i*.6,0);return t;}
 function building(parent,x,z,w,d,h,color,style='house'){
  const b=new T.Group();b.position.set(x,0,z);parent.add(b);cube(b,0,h/2,0,w,h,d,color);cube(b,0,.11,d*.08,w+.25,.22,d+.25,'#e9cb98');
  if(style==='school'){cube(b,0,h*.75,d/2+.02,w,.33,.05,'#295681');cube(b,0,h+.12,0,w+.3,.24,d+.3,'#f7f1df');for(let i=-1;i<=1;i++)cube(b,i*w*.26,h*.48,d/2+.03,w*.14,h*.29,.06,'#548eaf');title(b,'COLÉGIO',0,h+1,0,'#e9f4fb',4.8);}
  else{const roof=mesh(b,g('roof',()=>new T.CylinderGeometry(0,1,1,4)),material('#b86d5d'),0,h+.48,0,true);roof.rotation.y=Math.PI/4;roof.scale.set(w*.82,.95,d*.82);cube(b,0,h*.32,d/2+.03,w*.2,h*.64,.07,'#4b6b76');for(const sign of[-1,1])cube(b,sign*w*.29,h*.6,d/2+.04,w*.2,h*.27,.08,'#9cdbdb');}
  return b;
 }
 function streetLamp(parent,x,z){const t=new T.Group();t.position.set(x,0,z);parent.add(t);cyl(t,0,1.8,0,.07,3.6,'#355668',.07,6);cube(t,0,3.6,.3,.58,.1,.7,'#416478');cube(t,0,3.5,.3,.43,.11,.5,'#ffdf8a',{emissive:'#ffd46e',emissiveIntensity:.45});return t;}
 function acai(parent,x,y,z,scale=1){const q=new T.Group();q.position.set(x,y,z);q.scale.setScalar(scale);parent.add(q);cyl(q,0,.25,0,.3,.5,'#f4dca1',.44,12);cyl(q,0,.51,0,.42,.08,'#653b90',.42,12);for(let i=0;i<5;i++)ball(q,Math.sin(i)*.23,.57,Math.cos(i)*.23,.08,i%2?'#cb94cf':'#f6d17a');beam(q,[.25,.4,0],[.4,1.05,.04],.035,'#d8b57f');return q;}
 function flag(parent,x,z,color){const t=new T.Group();t.position.set(x,0,z);parent.add(t);cyl(t,0,2,0,.045,4,'#e9e3d1',.045,6);cube(t,.6,3.25,0,1.2,.67,.055,color);return t;}
 function island(parent,rx,rz,color='#77bd86',y=-.45){const o=cyl(parent,0,y-.24,0,1,.95,'#bd9471',1,64);o.scale.set(rx,1,rz);const top=cyl(parent,0,y+.29,0,1,.16,color,1,64);top.scale.set(rx+.03,1,rz+.03);return top;}
 function buildEnvironment(){
  const ocean=mesh(ambience,g('ocean',()=>new T.PlaneGeometry(260,260,1,1)),material('#1ba9bd',{roughness:.3,metalness:.12}),0,-1.8,0);ocean.rotation.x=-Math.PI/2;
  for(let i=0;i<22;i++){const a=i*2.4,r=25+i%5*6,x=Math.sin(a)*r,z=Math.cos(a)*r;const w=ring(ambience,x,-1.76,z,1.2+(i%3)*.5,.025,'#bcf7ed',.38);w.scale.y=.34;animators.push(t=>{w.position.y=-1.76+Math.sin(t*.8+i)*.025;w.scale.x=1+Math.sin(t*.3+i)*.09;});}
  for(let i=0;i<7;i++){const group=new T.Group();group.position.set((i-3)*13,11+i%3*3,-24-i%2*10);ambience.add(group);for(let j=-1;j<=1;j++){const c=ball(group,j*1.5,(j===0?.4:0),0,1.7,'#e8f8ed',8);c.scale.set(1.35,.54,1);}const ox=group.position.x;animators.push(t=>{group.position.x=ox+Math.sin(t*.035+i)*3;});}
  for(let i=0;i<6;i++){const is=new T.Group();is.position.set(Math.sin(i*2.1)*(35+i),-1.1,Math.cos(i*2.1)*(31+i));ambience.add(is);island(is,4+i%2,3,'#77b899',-.3);tree(is,-1,0,.9);pine(is,1,-.6,.7);}
  for(let i=0;i<3;i++){const bird=new T.Group();ambience.add(bird);const l=cube(bird,-.22,0,0,.5,.035,.16,'#527888'),r=cube(bird,.22,0,0,.5,.035,.16,'#527888');animators.push(t=>{bird.position.set(Math.sin(t*.11+i*2)*25,10+Math.sin(t*.18+i),Math.cos(t*.11+i*2)*23);bird.rotation.y=-t*.11-i*2;l.rotation.z=Math.sin(t*5+i)*.35;r.rotation.z=-Math.sin(t*5+i)*.35;});}
 }
 buildEnvironment();
 function clearMap(){level.userData={};for(const o of[...level.children])level.remove(o);for(const o of[...entities.children])entities.remove(o);for(const o of[...actors.children])actors.remove(o);dynamic.clear();people.clear();}
 function makeBoard(s){
  island(level,34,26,'#83bd7a',-.36);const nodes=s.board.nodes,roads=[],arrows=[];
  const colors={blue:'#6fbdda',red:'#df8883',event:'#b38ad7',shop:'#f2bd65',item:'#8fce8c',trap:'#a579ac',swap:'#e6a6cd',lucky:'#8fd2a3',junction:'#f3d381',start:'#eee6c0'};
  for(const n of nodes)for(const to of n.next||[]){const q=nodes[to],dx=q.x-n.x,dz=q.z-n.z,length=Math.hypot(dx,dz),angle=Math.atan2(dx,dz);roads.push({x:(n.x+q.x)/2,y:.045,z:(n.z+q.z)/2,w:1.5,h:.09,d:length+.3,ry:angle,color:'#e9d7ad'});if(n.id%3===0){const a=new T.Group();a.position.set((n.x+q.x)/2,.16,(n.z+q.z)/2);a.rotation.y=angle;cube(a,0,0,-.05,.08,.025,.35,'#9c9472');const arrow=mesh(a,g('patharrow',()=>new T.ConeGeometry(.15,.3,3)),material('#9c9472'),0,.015,.2);arrow.rotation.x=Math.PI/2;level.add(a);}}
  batchBoxes(level,roads);
  const path=new T.InstancedMesh(g('boardtile',()=>new T.CylinderGeometry(.65,.65,.17,12)),material('#ffffff'),nodes.length),rim=new T.InstancedMesh(g('boardtilerim',()=>new T.TorusGeometry(.48,.025,4,20)),material('#fff1c6'),nodes.length),d=new T.Object3D(),color=new T.Color();for(let i=0;i<nodes.length;i++){const n=nodes[i];d.position.set(n.x,.16,n.z);d.rotation.set(0,0,0);d.scale.set(1,1,1);d.updateMatrix();path.setMatrixAt(i,d.matrix);color.set(colors[n.type]||colors.blue);path.setColorAt(i,color);d.position.y=.26;d.rotation.x=-Math.PI/2;d.updateMatrix();rim.setMatrixAt(i,d.matrix);if(['trap','shop','swap','item','lucky'].includes(n.type))title(level,{trap:'!',shop:'$',swap:'↔',item:'?',lucky:'+'}[n.type],n.x,.65,n.z,'#fff4d0',.75);}
  path.receiveShadow=true;path.instanceMatrix.needsUpdate=rim.instanceMatrix.needsUpdate=true;path.instanceColor.needsUpdate=true;level.add(path,rim);ownedInstances.add(path);ownedInstances.add(rim);
  // Each district has its own footprint; roads and junctions stay unobstructed.
  building(level,-15,-10,5,3.6,3.2,'#e4a778');title(level,'ROÇA DO SAPO',-15,5.1,-12.5,'#ffe4a0',7);
  const farm=[];for(let x=-21;x<=-9;x+=.7)for(let z=-14;z<=-12;z+=.7)farm.push({x,y:.38,z,w:.12,h:.65,d:.1,color:(Math.round(x*10)+Math.round(z*10))%2?'#e4cd76':'#afbd61'});batchBoxes(level,farm);cube(level,-15,-.02,-13,14,.11,4,'#b19762');
  for(const x of[-21.5,-8.5])for(let z=-14;z<=-11;z+=1)cube(level,x,.65,z,.1,1.2,.12,'#e4c698');for(const x of[-21.5,-8.5])cube(level,x,.85,-12.5,.12,.12,4,'#f0d6a8');
  const mill=new T.Group();mill.position.set(-28,0,-11);level.add(mill);cyl(mill,0,2,0,1.1,4,'#eee0b2',.75,8);mesh(mill,g('millroof',()=>new T.ConeGeometry(1.25,1.5,8)),material('#9d6756'),0,4.5,0);cube(mill,0,2.3,1,1,.9,.12,'#4d7b7b');
  building(level,-14,9,7,4,3.3,'#f3ece0','school');const pitch=cube(level,-14,.01,3.5,8,.09,4,'#69a782');for(const z of[1.5,5.5])cube(level,-14,.08,z,8,.025,.05,'#dbecc7');cube(level,-14,.08,3.5,.05,.025,4,'#dbecc7');title(level,'COLÉGIO',-14,5.5,10,'#d5eff6',7);
  const barber=building(level,15,10,5,3.2,2.8,'#f0dbc2');title(barber,'BIGODON',0,4.1,0,'#ffe2ab',6);for(let i=0;i<8;i++)cyl(level,18,.25+i*.4,11.8,.16,.4,i%2?'#d37d7c':'#f1ebd0',.16,8);cube(level,14,.45,13,4,.3,.65,'#a87e5e');
  for(let j=0;j<7;j++){const x=11+(j%3)*3.5,z=-12+Math.floor(j/3)*3.4;building(level,x,z,2.8,2.5,2+j%3*.55,['#d8a28c','#91bfc2','#bba9ce'][j%3]);}title(level,'FAVELA DO REEIS',16,5.8,-13,'#f7d4ab',8);
  cyl(level,5,.17,7,2.8,.45,'#b8c8b1',2.8,24);cyl(level,5,.45,7,2.35,.25,'#62bdbe',2.35,24);cyl(level,5,1,7,.5,1,'#e4d6af',.4,12);title(level,'PRAÇA CAMACAN',6,4,11,'#e4f2bd',7);
  // Small bridges, flower beds, palms, signs and fences give the larger board landmarks.
  for(const[x,z,k]of[[-29,8,1.3],[-22,18,1],[-20,20,1.1],[-9,22,.8],[9,22,1.2],[25,15,1.2],[29,4,1.4],[28,-10,1.1],[4,-22,1],[-11,-21,1.1]])tree(level,x,z,k);
  for(const[x,z]of[[-5,-7],[5,7],[-10,14],[21,7],[-21,-7],[10,-16]]){streetLamp(level,x,z);cyl(level,x+1,.25,z,.55,.4,'#d2b68c',.7,8);for(let j=0;j<4;j++)ball(level,x+1+Math.sin(j*1.7)*.3,.6,z+Math.cos(j*1.7)*.3,.18,['#e898a0','#e9cc83','#bba3d9'][j%3]);}
  for(let j=0;j<10;j++){const x=-6+j*1.25;cube(level,x,.4,-8,1,.16,.55,'#dfc397');cube(level,x,.72,-8.25,1,.45,.1,'#e8cea5');}
  // A central gazebo is offset from the four-way intersection.
  for(const x of[-4,-1])for(const z of[6,9])cyl(level,x,1.6,z,.09,3.2,'#e3c69a',.09,6);const roof=mesh(level,g('gazeboroof',()=>new T.ConeGeometry(3,1.6,6)),material('#ab7974'),-2.5,3.8,7.5);title(level,'O CRUZAMENTO DA RESENHA',0,4.5,-5,'#fff1b7',10);
 }
 function starShape(parent,color='#f1cc64',size=1){const shape=new T.Shape();for(let i=0;i<10;i++){const a=i*Math.PI/5,r=i%2?.44:1,x=Math.sin(a)*r,y=Math.cos(a)*r;if(!i)shape.moveTo(x,y);else shape.lineTo(x,y);}shape.closePath();const o=mesh(parent,g('star3d',()=>new T.ExtrudeGeometry(shape,{depth:.22,bevelEnabled:true,bevelSegments:1,steps:1,bevelSize:.05,bevelThickness:.06})),material(color,{metalness:.26,roughness:.4,emissive:'#bb862b',emissiveIntensity:.14}));o.scale.setScalar(size);return o;}
 function diceModel(){const root=new T.Group();cube(root,0,0,0,1.5,1.5,1.5,'#ffefc5');const layout={1:[[0,0]],2:[[-1,-1],[1,1]],3:[[-1,-1],[0,0],[1,1]],4:[[-1,-1],[-1,1],[1,-1],[1,1]],5:[[-1,-1],[-1,1],[0,0],[1,-1],[1,1]],6:[[-1,-1],[-1,0],[-1,1],[1,-1],[1,0],[1,1]]};for(const[value,normal]of[[1,[0,0,1]],[6,[0,0,-1]],[2,[0,1,0]],[5,[0,-1,0]],[3,[1,0,0]],[4,[-1,0,0]]]){const face=new T.Group();face.quaternion.setFromUnitVectors(new T.Vector3(0,0,1),new T.Vector3(...normal));face.position.set(...normal.map(x=>x*.765));for(const[x,y]of layout[value])ball(face,x*.29,y*.29,.01,.09,'#846145');root.add(face);}return root;}
 function makeCollapse(){
  for(const x of[-12,12])for(const z of[-12,12]){const p=cyl(level,x,-2,z,.7,6,'#7d6991',.95,7);ring(level,x,.9,z,1,.1,'#f0ca8d');ball(level,x,1.2,z,.55,'#b78ce4');}
  const back=cube(level,0,.15,-13.2,12,.45,2.5,'#8d79a8');const marco=model('marco','#e7a8d6');marco.position.set(0,.4,-13.5);marco.scale.setScalar(1.8);level.add(marco);title(level,'O CADERNO GANHOU VIDA',0,5.4,-14,'#f4d3fa',10);
  for(let i=0;i<8;i++){const b=cube(level,(i-3.5)*2,.1,-11.8,.8,.25,1.2,i%2?'#e6d9b7':'#c6a4dc');b.rotation.y=(i%3)*.3;}
 }
 function ellipseRoad(rx,rz,half,color,y){const seg=96,positions=[],indices=[];for(let i=0;i<=seg;i++){const a=i/seg*Math.PI*2;for(const sign of[-1,1])positions.push(Math.sin(a)*(rx+sign*half),y,Math.cos(a)*(rz+sign*half));if(i<seg){const k=i*2;indices.push(k,k+1,k+2,k+1,k+3,k+2);}}const geo=new T.BufferGeometry();geo.setAttribute('position',new T.Float32BufferAttribute(positions,3));geo.setIndex(indices);geo.computeVertexNormals();return mesh(level,g('road:'+rx+rz+half+y,()=>geo),material(color));}
 function makeRace(){
  island(level,19,15,'#85be89',-.5);ellipseRoad(13,9,3.2,'#d6ba8c',-.07);ellipseRoad(13,9,2.85,'#627985',.04);ellipseRoad(13,9,.045,'#f2deb0',.065);
  const kerbs=[];for(let i=0;i<72;i++){const a=i/72*Math.PI*2;for(const sign of[-1,1])kerbs.push({x:Math.sin(a)*(13+sign*3),y:.08,z:Math.cos(a)*(9+sign*3),w:.7,h:.1,d:.35,color:i%2?'#eb8e82':'#fff0cf',ry:a});}batchBoxes(level,kerbs);
  island(level,8.8,4.8,'#a3cb87',-.25);building(level,-2,-1,3,2,2.2,'#e7b887');tree(level,3.5,1,1.4);tree(level,-5,0,1.1);const tank=cyl(level,2,.9,-1.6,.6,1.8,'#b0c8d1',.6,12);ring(level,2,1.8,-1.6,.6,.05,'#f4d99e');title(level,'CARRO A GÁS GP',0,5.3,-4,'#ffedb4',9.7);
  beam(level,[-4,.1,9],[-4,4.2,9],.14,'#f2d5a2');beam(level,[4,.1,9],[4,4.2,9],.14,'#f2d5a2');cube(level,0,4,9,8,.65,.18,'#264a61');title(level,'LARGADA',0,4.1,9.18,'#fff0c0',5);
  for(let i=0;i<8;i++)for(let j=0;j<2;j++)cube(level,-2.8+i*.8,.08,8.65+j*.7,.78,.045,.68,(i+j)%2?'#f3e5bf':'#314853');
  for(const[x,z]of[[-16,-7],[16,-7],[-14,11],[14,11]])flag(level,x,z,'#e7ae6c');
 }
 function goal(x){const sg=Math.sign(x);const q=new T.Group();q.position.x=x;level.add(q);for(const z of[-3,3])beam(q,[0,.05,z],[0,3,z],.11,'#f1ede0');beam(q,[0,3,-3],[0,3,3],.11,'#f1ede0');for(const z of[-3,3]){beam(q,[0,.1,z],[sg*1.7,.1,z],.07,'#e1d7b9');beam(q,[0,3,z],[sg*1.7,2.2,z],.07,'#e1d7b9');beam(q,[sg*1.7,.1,z],[sg*1.7,2.2,z],.07,'#e1d7b9');}
 const verts=[];for(let z=-3;z<=3;z+=.5)verts.push(sg*1.7,.1,z,sg*1.7,2.2,z);for(let y=.4;y<=2.2;y+=.4)verts.push(sg*1.7,y,-3,sg*1.7,y,3);const geometry=g('net'+sg,()=>{const b=new T.BufferGeometry();b.setAttribute('position',new T.Float32BufferAttribute(verts,3));return b;});const matkey='netlines';if(!mats.has(matkey))mats.set(matkey,new T.LineBasicMaterial({color:'#b5ccd0'}));q.add(new T.LineSegments(geometry,mats.get(matkey)));}

 function pitchLine(x,z,w,d){cube(level,x,.06,z,w,.035,d,'#edf0d9');}
 function makeFootball(){
  island(level,19,15,'#7caa82',-.5);cube(level,0,-.14,0,29,.3,20,'#497b66');for(let i=0;i<10;i++)cube(level,-11.7+i*2.6,.025,0,2.58,.03,18,i%2?'#79b785':'#6bae7c');pitchLine(0,0,.11,18);for(const z of[-9,9])pitchLine(0,z,26,.12);for(const x of[-13,13])pitchLine(x,0,.12,18);ring(level,0,.08,0,3,.045,'#edf0d9');for(const x of[-10.8,10.8]){pitchLine(x,0,.12,10);pitchLine((x+Math.sign(x)*13)/2,-5,4.4,.12);pitchLine((x+Math.sign(x)*13)/2,5,4.4,.12);}goal(-13.25);goal(13.25);
  const crowd=[];for(const z of[-12,12]){cube(level,0,.28,z,25,.65,1.4,'#608f92');cube(level,0,.95,z+Math.sign(z)*.5,25,.6,1.2,'#729da0');for(let i=0;i<18;i++){crowd.push({x:-11+i*1.3,y:1.55,z,w:.42,h:.43,d:.4,color:palette[i%8]},{x:-11+i*1.3,y:1.22,z,w:.4,h:.4,d:.3,color:palette[(i+3)%8]});}}
  batchBoxes(level,crowd);for(const[x,z]of[[-16,-11],[16,-11],[-16,11],[16,11]]){const l=streetLamp(level,x,z);l.scale.y=1.7;}
  title(level,'QUADRA CAÓTICA',0,4.5,-13.4,'#f7e7b1',9);const mota=model('mota','#91baf7');mota.position.set(16,0,0);mota.scale.setScalar(1.4);level.add(mota);
 }
 function makeSpotlight(){
  island(level,13,18,'#7baa91',-.45);cube(level,0,-.05,0,20,.25,29,'#bbae8c');for(let i=0;i<14;i++)cube(level,0,.09,-12.5+i*1.9,18,.025,.025,'#d3c8a2');
  building(level,-11,-8,2.6,3,3.2,'#ccacb7');building(level,11,-9,2.8,3,3.6,'#93b2ba');for(const[x,z]of[[-11,3],[11,3],[-11,11],[11,11]])pine(level,x,z,1.2);
  cube(level,0,.25,-15,8,.7,3.2,'#7e6c93');const n=model('nikolas','#f0a8d4');n.scale.setScalar(2.25);n.position.set(0,.6,-15.2);level.add(n);n.userData.parts.leftArm.rotation.x=-.65;
  cube(level,0,.7,-10,2.4,.18,1.3,'#8e715f');for(const x of[-.9,.9])cube(level,x,.35,-10,.15,.7,.8,'#8e715f');cyl(level,0,.99,-10,.57,.4,'#7e4d3a',.6,12);cyl(level,0,1.22,-10,.62,.08,'#e9b889',.62,12);for(let i=0;i<3;i++)ball(level,Math.sin(i*2)*.32,1.33,-10+Math.cos(i*2)*.3,.13,'#87bf72');
  cube(level,0,.1,12.5,18,.08,1.2,'#6fb5b1');title(level,'TRAGA O BOLO DE VOLTA',0,4.2,13.6,'#d2f5df',9);title(level,'NÃO ACORDE O NARIZ',0,7,-16,'#f4d4e6',10);
 }
 function makePages(){
  island(level,15,17,'#91bfb0',-.5);cube(level,0,-.08,0,23,.3,29,'#d1c3a1');for(let i=-5;i<=5;i++)cube(level,i*2,.09,0,.035,.015,28,'#b1b8ae');for(let i=-6;i<=6;i++)cube(level,0,.09,i*2,23,.015,.035,'#b1b8ae');
  for(const sign of[-1,1])for(let i=-2;i<=2;i++){const x=sign*12.5,z=i*5;cube(level,x,1.7,z,1.1,3.4,3.2,'#526b7d');for(let k=0;k<5;k++){const b=cube(level,x-sign*.6,1+k*.45,z+(k%2?.3:-.3),.18,.35,1.8,palette[(i+k+8)%8]);b.rotation.x=.06;}cube(level,x,2.55,z,1.3,.12,3.5,'#e1cca6');}
  const back=cube(level,0,2.5,-16,22,5,1,'#619294');title(level,'BIBLIOTECA DOS RABISCOS',0,6.5,-16,'#e7e8b8',11);for(let i=-3;i<=3;i++){const paper=cube(level,i*2.8,2.5,-15.4,1.8,2.2,.05,'#f3e8c7');for(let j=0;j<3;j++)cube(level,i*2.8,2.9-j*.4,-15.34,1.2,.045,.03,j%2?'#ae80a4':'#748f98');}
 }
 function makeWaves(){
  const platform=new T.Group();level.add(platform);level.userData.wavePlatform=platform;cyl(platform,0,-.56,0,11.1,1.15,'#b38b6d',11.1,64);cyl(platform,0,.025,0,11,.12,'#a5b69d',11,64);disc(platform,0,.1,0,10.4,'#c4c496');ring(platform,0,.13,0,10.75,.17,'#e8d294');for(let r=2;r<10;r+=2)ring(platform,0,.15,0,r,.025,'#8ba895');
  const stage=cube(level,0,.1,-15,10,.4,3.3,'#5b8a85');const reeis=model('reeis','#e6d189');reeis.position.set(0,.35,-15);reeis.scale.setScalar(2);level.add(reeis);reeis.userData.parts.leftArm.rotation.z=-.7;reeis.userData.parts.rightArm.rotation.z=.7;ring(level,0,.45,-15,1.8,.08,'#f3d98d');title(level,'ONDAS DA RESENHA',0,6,-16,'#fff0b3',10);
  for(const sign of[-1,1])for(let i=0;i<4;i++){const a=sign*(.6+i*.22),x=Math.sin(a)*14,z=Math.cos(a)*14;flag(level,x,z,palette[(i+2)%8]);}
 }
 function makeHarvest(){island(level,19,14,'#8fbc76',-.45);cube(level,0,-.1,0,29,.22,19,'#b29468');for(let z=-6;z<=6;z+=4)cube(level,0,.05,z,20,.06,2.4,'#8eaa65');for(const team of[0,1]){const x=team?12:-12;cube(level,x,.6,0,2,1,3.6,team?'#cf9069':'#69a6c5');for(const z of[-1.3,1.3])for(const sign of[-1,1]){const w=cyl(level,x+sign*1.05,.28,z,.4,.18,'#4c4d42',.4,8);w.rotation.z=Math.PI/2;}title(level,team?'CARROÇA CORAL':'CARROÇA AZUL',x,3.1,-2,team?'#ffd5aa':'#d3f4f4',5);}building(level,0,-11.5,5,3,3,'#d8b084');title(level,'MUTIRÃO DO SAPO',0,5.6,-11,'#fff0ae',10);for(const[x,z]of[[-16,-9],[16,-9],[-16,9],[16,9]])pine(level,x,z,1.4);}
 function makeSketch(){island(level,16,16,'#b5a1b9',-.5);cube(level,0,-.12,0,25,.25,23,'#e2d3b6');for(let i=-5;i<=5;i++)cube(level,0,.02,i*2,24,.02,.025,'#b7b5ba');cube(level,0,.3,-14,10,.6,4,'#7e6b91');cube(level,0,.25,9,4,.5,2,'#7aa28d');title(level,'MOCHILA DA TURMA',0,2.5,10.3,'#d8f0bb',6);title(level,'UM SARUÊ CONTRA TODOS',0,7,-16,'#f8c7de',11);for(const[x,z]of[[-14,-8],[14,-8],[-14,8],[14,8]])flag(level,x,z,'#d599bd');}
 function makeRaft(){island(level,21,17,'#77af88',-.5);ellipseRoad(13,9,3.5,'#d6bd8a',-.1);ellipseRoad(13,9,3.1,'#4eb4b7',.03);ellipseRoad(13,9,.025,'#a4e5dc',.04);island(level,8,4.7,'#accc86',-.3);tree(level,3,0,1.6);tree(level,-3,1,1.1);building(level,-1,-1,3,2,2.2,'#c89972');title(level,'REMADA DA RESENHA',0,5,-4,'#e8f2bd',10);for(let j=0;j<8;j++)cube(level,-2.8+j*.8,.15,9,.75,.1,5,j%2?'#c79e6e':'#ddbe8a');}
 function makePodium(){
  island(level,16,12,'#82bd9c',-.4);cube(level,0,.15,0,12,.4,6,'#b89c7a');const cols=['#e4c065','#d5dddc','#d6a483'],xs=[0,-3,3],hs=[2,1.2,.7];for(let i=0;i<3;i++){cube(level,xs[i],.3+hs[i]/2,0,2.7,hs[i],2.7,cols[i]);title(level,String(i+1),xs[i],.9+hs[i]/2,1.4,'#fff6d8',1.5);}for(const x of[-10,10]){flag(level,x,-4,'#db8caf');tree(level,x,4,1.2);}title(level,'A FESTA É DA TURMA',0,6.6,-4.5,'#fff0bd',12);acai(level,0,0,-4,2.1);
 }
 function buildMap(key,s){clearMap();map=key;if(key==='board')makeBoard(s);else if(key==='podium')makePodium();else({collapse:makeCollapse,race:makeRace,football:makeFootball,spotlight:makeSpotlight,pages:makePages,waves:makeWaves,harvest:makeHarvest,sketch:makeSketch,raft:makeRaft}[key]||makeBoard)(s);batchStatic(level,level.userData.wavePlatform);}
 function entity(key,build){let o=dynamic.get(key);if(!o){o=build();entities.add(o);dynamic.set(key,o);}o.visible=true;o.userData.frame=frame;return o;}
 function updateEntities(s,t){
  const e=s.game?.entities||{},id=s.game?.id;
  for(const o of dynamic.values())o.visible=false;
  if(map==='board'){
   const b=s.board,p=b.nodes[b.prizeIndex];if(p){const prize=entity('boardprize',()=>{const a=new T.Group();cyl(a,0,.14,0,1.25,.28,'#e6cd91',1.3,12);for(const x of[-1,1])cyl(a,x,1.3,0,.07,2.6,'#ae7e58',.07,6);cube(a,0,2.6,0,2.5,.22,1.2,'#9463ad');starShape(a,'#f0ce68',.7).position.set(0,1.5,.25);title(a,'ESTRELA · 20',0,3.5,0,'#ffe4a0',5);return a;});prize.position.set(p.x,0,p.z);}
   const active=s.players.find(p=>p.id===b.activeId);if(active&&!b.shop){const die=entity('turn-dice',diceModel);die.position.set(active.x,4.2+Math.sin(t*4)*.18,active.z);const number=b.baseDice||b.dice||1;const faces={1:[0,0,0],2:[Math.PI/2,0,0],3:[0,-Math.PI/2,0],4:[0,Math.PI/2,0],5:[-Math.PI/2,0,0],6:[0,Math.PI,0]};if(b.rolling)die.rotation.set(t*12,t*14,t*7);else die.rotation.set(...faces[number]);const result=entity('dieresult'+b.dice,()=>{const q=new T.Group();title(q,b.dice?String(b.dice)+' CASAS':'SUA VEZ',0,0,0,'#fff1b8',3.5);return q;});result.position.set(active.x,6,active.z);}
   for(const id of b.choices||[]){const n=b.nodes[id],q=entity('choice'+id,()=>{const a=new T.Group();ring(a,0,.3,0,1.1,.1,'#ffe18a');return a;});q.position.set(n.x,.12,n.z);q.scale.setScalar(1+Math.sin(t*5)*.08);}
   for(const trap of b.traps||[]){const n=b.nodes[trap.node],q=entity('trap'+trap.node,()=>{const a=new T.Group();disc(a,0,.29,0,.7,'#84548e');title(a,'TINTA!',0,1,0,'#f4c7e2',2);return a;});q.position.set(n.x,0,n.z);}
   const mill=entity('windmillblades',()=>{const q=new T.Group();for(let i=0;i<4;i++){const a=new T.Group();a.rotation.z=i*Math.PI/2;cube(a,0,1.5,0,.35,3,.12,'#e4c591');cube(a,.35,2.15,0,.65,1.4,.13,'#f4e0b3');q.add(a);}ball(q,0,0,.1,.25,'#82624f');return q;});mill.position.set(-28,3.7,-9.9);mill.rotation.z=t*.32;
   for(let i=0;i<6;i++){const jet=entity('fountain'+i,()=>ball(new T.Group(),0,0,0,.12,'#b3f1dd'));jet.position.set(5+Math.sin(i*TAU/6)*.5,.9+Math.abs(Math.sin(t*2+i))*.9,7+Math.cos(i*TAU/6)*.5);}
   const cart=entity('villagecar',()=>car('#c4a368','daroca'));cart.position.set(Math.sin(t*.08)*28,0,Math.cos(t*.08)*21);cart.rotation.y=Math.atan2(Math.cos(t*.08)*28,-Math.sin(t*.08)*21);
   return;
  }
  if(id==='collapse'){
   const tiles=e.tiles||[];if(tiles.length){const pool=entity('tilepool',()=>{const q=new T.Group(),N=tiles.length;const bases=new T.InstancedMesh(g('box',()=>new T.BoxGeometry(1,1,1)),material('#7a7395'),N),tops=new T.InstancedMesh(g('box',()=>new T.BoxGeometry(1,1,1)),material('#ffffff'),N),rims=new T.InstancedMesh(g('tilerim',()=>new T.TorusGeometry(.72,.025,4,20)),material('#efe0aa'),N);bases.castShadow=true;bases.receiveShadow=tops.receiveShadow=true;q.add(bases,tops,rims);q.userData.parts=[bases,tops,rims];for(const x of q.userData.parts)ownedInstances.add(x);return q;});const d=new T.Object3D(),color=new T.Color();for(let i=0;i<tiles.length;i++){const a=tiles[i],gone=a.state==='gone',w=gone?0:1;d.rotation.set(0,0,a.state==='warning'?Math.sin(t*22+i)*.016:0);d.position.set(a.x,-.2,a.z);d.scale.set(2.84*w,.4*w,2.84*w);d.updateMatrix();pool.userData.parts[0].setMatrixAt(i,d.matrix);d.position.y=.035;d.scale.set(2.68*w,.06*w,2.68*w);d.updateMatrix();pool.userData.parts[1].setMatrixAt(i,d.matrix);color.set(a.state==='warning'?(Math.sin(t*14)>0?'#ef8d8e':'#f4d286'):a.color||'#b8b4cd');pool.userData.parts[1].setColorAt(i,color);d.rotation.set(-Math.PI/2,0,Math.PI/4);d.position.y=.09;d.scale.set(w,w,w);d.updateMatrix();pool.userData.parts[2].setMatrixAt(i,d.matrix);}for(const p of pool.userData.parts){p.instanceMatrix.needsUpdate=true;if(p.instanceColor)p.instanceColor.needsUpdate=true;}}

   for(let i=0;i<(e.pickups||[]).length;i++){const a=e.pickups[i];if(a.taken||a.active===false)continue;const q=entity('pickup'+(a.id??i),()=>{const k=new T.Group();cube(k,0,0,0,.55,.07,.7,'#ffdb76');cube(k,.08,.06,.05,.22,.04,.28,'#fff2bd');return k;});q.position.set(a.x,.7+Math.sin(t*3+i)*.12,a.z);q.rotation.y=t*1.4;}
  }
  if(id==='race'){
   for(let i=0;i<(e.obstacles||[]).length;i++){const a=e.obstacles[i],q=entity('obstacle'+i,()=>{const k=new T.Group();if(a.type==='oil'){const sp=disc(k,0,.06,0,.8,'#2e4655');sp.scale.y=.7;ring(k,0,.07,0,.5,.025,'#6992a2');}else if(a.type==='fuel'||a.type==='gas'||a.type==='boost'){cube(k,0,.55,0,.55,1,.38,'#79d6b6');cube(k,0,1.1,0,.25,.12,.15,'#e7e1bd');}else{mesh(k,g('cone',()=>new T.ConeGeometry(.38,1,6)),material('#ee9d62'),0,.5,0,true);cube(k,0,.45,0,.56,.14,.56,'#ffe3ab');}return k;});const lane=a.lane||0,ang=a.angle||0;q.position.set(Math.sin(ang)*(13+lane),0,Math.cos(ang)*(9+lane*.65));q.rotation.y=ang;}
  }
  if(id==='football'){
   const a=e.ball;if(a){const q=entity('ball',()=>{const k=new T.Group();ball(k,0,0,0,.43,'#fff2dc',12);for(let i=0;i<6;i++){const p=cube(k,Math.sin(i*2.4)*.31,Math.cos(i*2.4)*.28,Math.sin(i*1.8)*.28,.18,.18,.18,'#314856');p.rotation.set(i*.5,i*.9,0);}return k;});q.position.set(a.x,a.y??.43,a.z);q.rotation.x=t*2;q.rotation.z=t;const sh=entity('ballshadow',()=>{const k=disc(new T.Group(),0,.1,0,.5,'#344f4a');return k;});sh.position.set(a.x,.1,a.z);}
   const score=entity('teamscore'+(s.game.teamScores||[]).join(':'),()=>{const q=new T.Group();title(q,(s.game.teamScores||[0,0]).join('  :  '),0,0,0,'#fff2c2',4.2);return q;});score.position.set(0,3.5,-10.7);
  }
  if(id==='spotlight'){
   for(let i=0;i<(e.covers||[]).length;i++){const a=e.covers[i],q=entity('cover'+i,()=>{const k=new T.Group();cube(k,0,.8,0,(a.r||1.3)*1.55,1.6,(a.r||1.3)*1.3,'#6a967c');cube(k,0,1.7,0,(a.r||1.3)*1.68,.22,(a.r||1.3)*1.48,'#7bb58b');cube(k,0,.85,(a.r||1.3)*.7,(a.r||1.3)*1.2,.12,.04,'#b9d69b');return k;});q.position.set(a.x,0,a.z);}
   const sig=s.game.signal||'sleep',color=sig==='watch'?'#f07f86':sig==='warning'?'#f2c463':'#7dd6d3';const watch=entity('watchcone',()=>{const q=new T.Group();const c=mesh(q,g('watchcone',()=>new T.ConeGeometry(12,29,32,1,true)),basic('#ef7d82',.1),0,0,0);c.scale.z=.004;c.rotation.x=-Math.PI/2;return q;});watch.position.set(0,.12,-.8);watch.visible=sig==='watch';
   const signal=entity('signal'+sig,()=>{const q=new T.Group();ball(q,0,0,0,.55,color);ring(q,0,0,0,.8,.06,color);return q;});signal.position.set(0,6,-14);signal.scale.setScalar(1+Math.sin(t*(sig==='warning'?12:2))*.08);
  }
  if(id==='pages'){
   for(let i=0;i<(e.walls||[]).length;i++){const a=e.walls[i],q=entity('page'+(a.id??i),()=>{
    const k=new T.Group(),height=a.height||4.8,faceKey='pageface'+a.id;let pageMaterial=mats.get(faceKey);if(!pageMaterial){pageMaterial=new T.MeshStandardMaterial({color:a.color||'#f0ddb1',roughness:.8,transparent:true,opacity:.94});mats.set(faceKey,pageMaterial);}k.userData.paperMaterial=pageMaterial;const holes=[...(a.holes||[])].sort((x,y)=>x.x-y.x);let left=-10;
    const segment=(l,r)=>{if(r-l<=.02)return;cube(k,(l+r)/2,height/2,0,r-l,height,.28,'#f0ddb1').material=pageMaterial;for(let j=0;j<Math.max(1,Math.floor((r-l)/2));j++){cube(k,l+.6+j*1.7,height*.6,.16,.8,.06,.025,'#b78aa4');cube(k,l+.6+j*1.7,height*.45,.16,.8,.04,.025,'#8e9da3');}};
    for(const h of holes){const l=clamp(h.x-h.width/2,-10,10),r=clamp(h.x+h.width/2,-10,10);segment(left,l);if(height>2)cube(k,(l+r)/2,height-.3,0,r-l,.6,.28,'#e9cda1').material=pageMaterial;ring(k,(l+r)/2,.16,0,.55,.04,'#78cfb3');left=r;}segment(left,10);batchStatic(k);return k;
   });q.position.set(0,.12,a.z);const local=s.players?.find(p=>p.id===localId);if(q.userData.paperMaterial){const faded=local&&a.z>local.z+.65;q.userData.paperMaterial.opacity=faded?.2:.94;q.userData.paperMaterial.depthWrite=!faded;}}
  }
  if(id==='waves'){
   const radius=e.platformRadius||s.game.radius||s.game.platformRadius||11;if(level.userData.wavePlatform)level.userData.wavePlatform.scale.set(radius/11,1,radius/11);const edge=entity('waveedge',()=>ring(new T.Group(),0,.18,0,1,.02,'#eab18d'));edge.scale.set(radius,radius,radius);
   for(let i=0;i<(e.rings||[]).length;i++){const a=e.rings[i],q=entity('wave'+(a.id??i),()=>{const k=new T.Group();const r=ring(k,0,0,0,1,.035,a.high?'#f4bd76':'#73d9be');return k;});q.position.y=a.y??.4;q.scale.set(a.radius,1,a.radius);}
   for(let i=0;i<(e.bars||[]).length;i++){const a=e.bars[i],q=entity('bar'+(a.id??i),()=>{const k=new T.Group();cube(k,0,0,0,1,.22,.4,'#e99d76');cube(k,0,.13,0,.95,.07,.34,'#ffda9d');return k;});q.position.set(0,a.y??.6,0);q.rotation.y=-(a.angle||0);q.scale.x=a.length||20;}
  }
  if(id==='harvest'){
   for(const f of e.fruits||[]){if(!f.active)continue;const q=entity('fruit'+f.id,()=>{const a=new T.Group();ball(a,0,.45,0,.38,['#e9b558','#df7d63','#927251'][f.type]);cube(a,0,.82,0,.07,.2,.07,'#6f8e4f');return a;});q.position.set(f.x,0,f.z);}
   for(const o of e.pumpkins||[]){const q=entity('pumpkin'+o.id,()=>{const a=new T.Group();ball(a,0,.5,0,.65,'#dd955b');cube(a,0,1.15,0,.15,.3,.15,'#6b7952');return a;});q.position.set(o.x,0,o.z);q.rotation.z=t*4;}
  }
  if(id==='sketch'){
   const aim=s.game.aim,q=entity('sketchaim',()=>{const a=new T.Group();ring(a,0,.2,0,.8,.07,'#edb6d1');cube(a,0,.2,0,2,.04,.06,'#f5dfb5');cube(a,0,.2,0,.06,.04,2,'#f5dfb5');return a;});q.position.set(aim.x,0,aim.z);
   for(const h of e.stamps||[]){const q=entity('stamp'+h.id,()=>{const a=new T.Group();disc(a,0,.1,0,h.r,'#bd7fa7').material=basic('#e694a8',.48);ring(a,0,.13,0,h.r,.09,'#ffe0ab');return a;});q.position.set(h.x,.02,h.z);q.scale.setScalar(h.delay>0?1:1.12);}
   for(const f of e.ink||[]){if(!f.active)continue;const q=entity('ink'+f.id,()=>{const a=new T.Group();cube(a,0,.55,0,.5,.8,.5,'#f6d382');cube(a,0,1,0,.3,.15,.3,'#795b73');return a;});q.position.set(f.x,Math.sin(t*3+f.id)*.1,f.z);}
   for(const r of e.rings||[]){const q=entity('sketchring'+r.id,()=>ring(new T.Group(),0,.4,0,1,.04,'#a36aa5'));q.scale.set(r.radius,1,r.radius);}
  }
  if(id==='raft'){
   for(const b of e.boats||[]){const q=entity('boat'+b.team,()=>{const a=new T.Group();for(let i=-2;i<=2;i++){const log=cyl(a,i*.48,.19,0,.3,4.3,'#b38b60',.3,8);log.rotation.x=Math.PI/2;}cube(a,0,.48,0,2.6,.18,3.7,b.team?'#da9e77':'#83b8bf');for(const side of[-1,1])cube(a,side*1.1,.85,0,.08,.6,3.4,'#e2c59b');flag(a,0,-1.3,b.team?'#e4a07d':'#84c5d7');return a;});q.position.set(b.x,Math.sin(t*3+b.team)*.06,b.z);q.rotation.y=b.yaw;}
   for(const o of e.rocks||[]){const q=entity('riverobstacle'+o.id,()=>{const a=new T.Group();if(o.type==='cargo')cube(a,0,.5,0,.8,.8,.8,'#e2bc7c');else{const rock=ball(a,0,.2,0,.7,'#829e9b',5);rock.scale.set(1,1.2,1);}return a;});q.position.set(Math.sin(o.angle)*(13+o.lane),0,Math.cos(o.angle)*(9+o.lane*.65));}
  }

 }
 function updatePeople(s,t,dt){
  const race=map==='race',podium=map==='podium',rank=[...(s.players||[])].sort((a,b)=>(b.stars||0)-(a.stars||0)||(b.coins||0)-(a.coins||0)||(b.score||0)-(a.score||0));
  for(const q of people.values())q.visible=false;
  for(let i=0;i<(s.players||[]).length;i++){
   const p=s.players[i],char=p.character||'daroca',accent=p.color||palette[i%8];let q=people.get(p.id);if(q&&(q.userData.character!==char||q.userData.playerName!==p.name)){actors.remove(q);people.delete(p.id);q=null;}
   if(!q){q=new T.Group();const avatar=race?car(accent,char):model(char,accent);q.add(avatar);q.userData.avatar=avatar;q.userData.character=char;q.userData.playerName=p.name;q.userData.pos=new T.Vector3();q.userData.ready=false;
    const tag=label((i+1)+' · '+p.name+(p.bot?' · CPU':''),p.id===localId?'#fff0ab':'#e8f5ee',race?4.1:3.7);tag.position.y=race?2.8:3.3;q.add(tag);q.userData.tag=tag;q.userData.tagScale=tag.scale.clone();
    if(!race){const stars=new T.Group();for(let j=0;j<3;j++)ball(stars,Math.sin(j*2.1)*.5,0,Math.cos(j*2.1)*.5,.09,'#ffe18d');stars.position.y=2.6;avatar.add(stars);q.userData.stars=stars;const carried=acai(avatar,0,1,.55,.75);carried.visible=false;q.userData.carried=carried;const halo=ring(avatar,0,.17,0,1,.085,'#a2ecb2',.65);halo.visible=false;q.userData.halo=halo;}
    actors.add(q);people.set(p.id,q);
   }
   q.visible=true;const avatar=q.userData.avatar;let x=Number(p.x)||0,z=Number(p.z)||0,y=Number(p.y)||0,yaw=Number(p.yaw)||0;
   if(podium){const at=rank.findIndex(a=>a.id===p.id),positions=[[0,2.32,0],[-3,1.52,0],[3,1.02,0],[-6,.35,1],[6,.35,1],[-8,.35,3],[8,.35,3],[0,.35,4]];[x,y,z]=positions[at]||positions[7];yaw=.1;}
   if(s.phase==='board'&&!Number.isFinite(p.x)){const n=s.board?.nodes?.[p.boardPos||0];if(n){x=n.x;z=n.z;y=.2;}}
   const pos=q.userData.pos;v.set(x,y,z);if(!q.userData.ready||Math.abs(pos.x-x)+Math.abs(pos.z-z)>8){pos.copy(v);q.userData.ready=true;}else pos.lerp(v,1-Math.exp(-clamp(dt,.001,.1)*22));q.position.copy(pos);
   avatar.rotation.y=yaw;if(map==='sketch'&&p.solo){avatar.scale.setScalar(2.4);q.userData.tag.position.y=6.8;}const moving=Math.hypot(p.vx||0,p.vz||0),walk=Math.sin(t*(race?6:10)+i);
   if(race){const base=avatar.userData.base;const laneVelocity=((p.lane||0)-(q.userData.lastLane??(p.lane||0)))/Math.max(.008,dt);q.userData.lastLane=p.lane||0;base.rotation.z=clamp(laneVelocity*-.04,-.12,.12);for(const wheel of avatar.userData.wheels)wheel.rotation.x=t*(p.speed||0)*1.2;base.position.y=Math.sin(t*25+i)*Math.min(.025,(p.speed||0)*.003);avatar.userData.flame.visible=(p.boost||p.boostTime||0)>0||(p.speed||0)>12;avatar.userData.flame.scale.y=.8+Math.sin(t*25)*.2;}
   else{
    const b=avatar.userData.body,parts=avatar.userData.parts,jumping=y>.35&&!podium,celebrate=podium||p.finished;
    b.position.y=(moving>.5?Math.abs(walk)*.055:Math.sin(t*2+i)*.018);parts.leftLeg.rotation.x=moving>.5?walk*.65:0;parts.rightLeg.rotation.x=-parts.leftLeg.rotation.x;
    parts.leftArm.rotation.x=celebrate?-2.5:jumping?-1.3:-parts.leftLeg.rotation.x*.7;parts.rightArm.rotation.x=celebrate?-2.5:jumping?-1.3:parts.leftLeg.rotation.x*.7;
    parts.leftArm.rotation.z=celebrate?-.45:0;parts.rightArm.rotation.z=celebrate?.45:0;
    if((p.charge||0)>.1){parts.leftArm.rotation.x=-1.35;parts.rightArm.rotation.x=-1.35;}
    q.userData.stars.visible=(p.stun||0)>0;q.userData.stars.rotation.y=t*6;
    q.userData.halo.visible=(p.attack||0)>0||(p.charge||0)>.15;q.userData.halo.scale.setScalar(1+Math.max(p.attack||0,(p.charge||0)*.45));
    q.userData.carried.visible=!!(p.carry||p.carrying||p.hasCake||p.cake);
    const marker=avatar.userData.marker;marker.material=material(p.id===localId?'#fff09b':['football','harvest','raft'].includes(s.game?.id)?(p.team?'#ef9b77':'#75cce5'):accent,{emissive:p.id===localId?'#ffd56a':accent,emissiveIntensity:.2});
    if(p.alive===false&&s.phase==='play'){q.visible=y>-8;q.userData.tag.visible=false;}else q.userData.tag.visible=true;
   }
   const focus=s.phase==='board'&&s.board?.activeId===p.id;q.userData.tag.scale.copy(q.userData.tagScale).multiplyScalar(focus?1.12:1);
  }
 }
 function resize(w,h,dpr){if(disposed)return;width=Math.max(1,Math.floor(w||canvas.clientWidth||960));height=Math.max(1,Math.floor(h||canvas.clientHeight||540));aspect=width/height;camera.aspect=aspect;camera.updateProjectionMatrix();renderer.setPixelRatio(Math.min(quality>0?1.5:1,Math.max(1,dpr||window.devicePixelRatio||1)));renderer.setSize(width,height,false);}
 function render(s,id,dt=1/60){if(disposed||!s)return;localId=id;lastState=s;frame++;visualTime+=clamp(dt,0,.1);const t=Number(s.time)||visualTime,key=['ceremony','results'].includes(s.phase)?'podium':s.phase==='board'?'board':s.game?.id||'board';if(key!==map)buildMap(key,s);scene.fog.near=key==='board'?145:65;scene.fog.far=key==='board'?230:130;
  updateEntities(s,t);updatePeople(s,t,dt);for(const f of animators)f(t);
  const intro=s.phase==='intro',podium=key==='podium',board=key==='board';let distance=podium?22:board?(overview?74:27):key==='race'||key==='raft'?39:key==='spotlight'||key==='pages'?38:key==='football'?36:32;
  if(aspect<1.3)distance*=1.3/aspect;scene.fog.near=Math.max(65,distance*1.35+22);scene.fog.far=scene.fog.near+100;
  const az=podium?.12:board?.42:key==='race'||key==='raft'?.52:.18;
  targetLook.set(0,podium?1.2:0,key==='spotlight'||key==='pages'?-1:0);if(board&&!overview){const actor=s.players.find(p=>p.id===s.board?.activeId);if(actor)targetLook.set(actor.x,2.2,actor.z);}
  targetPosition.set(targetLook.x+Math.sin(az)*distance,distance*.92,targetLook.z+Math.cos(az)*distance);
  if(intro){targetPosition.x+=Math.sin(t*.35)*1.4;targetPosition.y+=.5;}
  camera.position.lerp(targetPosition,frame<3?1:1-Math.exp(-clamp(dt,.001,.1)*3));look.lerp(targetLook,.08);camera.lookAt(look);
  if(podium){for(let i=0;i<30;i++){const c=entity('confetti'+i,()=>cube(new T.Group(),0,0,0,.11,.08,.21,palette[i%8]));c.position.set(Math.sin(i*4.7)*11,2+(i*.81-t*1.6)%8,Math.cos(i*3.3)*7);c.rotation.set(t+i,t*.7,i);}}
  renderer.render(scene,camera);
 }
 function setQuality(value){quality=value==='low'||value===0?0:1;renderer.shadowMap.enabled=quality>0;resize(width,height);}
 function dispose(){if(disposed)return;disposed=true;canvas.removeEventListener('webglcontextlost',contextLost);for(const x of geom.values())x.dispose();for(const x of mats.values())x.dispose();for(const x of labelTextures.values())x.dispose();for(const x of ownedSpriteMaterials)x.dispose();for(const x of ownedInstances)x.dispose();renderer.dispose();people.clear();dynamic.clear();}
 function contextLost(e){e.preventDefault();if(!disposed)options.onError?.(Error('O visual 3D foi interrompido. Feche o modo Festa e abra novamente.'));}
 canvas.addEventListener('webglcontextlost',contextLost);resize(canvas.clientWidth||960,canvas.clientHeight||540);
 return{render,resize,dispose,setQuality,setOverview:value=>{overview=!!value;},getInfo:()=>({calls:renderer.info.render.calls,triangles:renderer.info.render.triangles,geometries:renderer.info.memory.geometries,textures:renderer.info.memory.textures,map})};
}
window.PartyArt=Object.freeze({create,looks,palette});
})();
