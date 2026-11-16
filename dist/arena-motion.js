/* Shared, fixed-step movement for the authority and local input prediction. */
(() => {
 'use strict';
 const clamp=(n,a,b)=>Math.max(a,Math.min(b,n)),timers=['dashTime','dashCD','inv','stun','slow','dropThrough','wallKick','jumpAnim','landTimer','launch'];
 function create(p){p.used={...(p.used||{}),jumpPress:p.used?.jumpPress||0,dash:p.used?.dash||0};for(const key of timers)p[key]=Math.max(0,Number(p[key])||0);p.wallSide=0;p.wallGrip=Number.isFinite(p.wallGrip)?p.wallGrip:1.35;p.wallTouches=Number(p.wallTouches)||0;p.motion=p.motion||'idle';p.motionTime=Number(p.motionTime)||0;return p;}
 function state(p,name,dt){if(p.motion!==name){p.motion=name;p.motionTime=0;}else p.motionTime=(p.motionTime||0)+dt;}
 function step(p,i,dt,options={}){
  if(!p||p.stocks<=0||p.respawn>0)return p;dt=clamp(Number(dt)||0,0,.05);i=i||{};p.used=p.used||{};
  for(const key of timers)p[key]=Math.max(0,(p[key]||0)-dt);
  const previousY=p.y,previousX=p.x,wasGround=!!p.ground,x=clamp(Number(i.x)||0,-1,1),y=clamp(Number(i.y)||0,-1,1),speed=300*(options.speed||1)*(p.slow>0?(p.slowFactor||.7):1),response=clamp(Number(i.response)||options.response||1,.5,2),stage=options.platforms||[];
  p.landed=false;
  if(x&&p.stun<=0&&p.wallKick<=0)p.facing=Math.sign(x);
  if(p.launch>0&&Math.abs(p.vx)<speed*.55&&p.stun<=0)p.launch=0;
  if(p.stun>0){p.vx*=Math.exp(-dt*(p.ground?5:.6));p.vx+=x*60*dt;}
  else if(p.dashTime<=0&&p.wallKick<=0){if(!p.ground&&p.launch>0){p.vx*=Math.exp(-dt*.9);p.vx+=x*speed*1.6*dt;}else p.vx+=(x*speed-p.vx)*Math.min(1,dt*(p.ground?15:7)*response);}
  const jumpPress=Number(i.jumpPress)||0;
  if(jumpPress>(p.used.jumpPress||0)){
   p.used.jumpPress=jumpPress;
   if(p.stun<=0&&p.wallSide&&p.wallGrip>0&&p.wallTouches<4){p.vx=-p.wallSide*360;p.vy=-435;p.facing=-p.wallSide;p.wallKick=.20;p.jumpAnim=.24;p.jumps=1;p.wallTouches++;p.wallGrip=Math.max(0,p.wallGrip-.22);p.wallSide=0;p.ground=false;p.emote=0;options.emit?.('wallJump',p);}
   else if(p.stun<=0&&p.jumps<3){
    if(y>.5&&p.ground){p.dropThrough=.25;p.y+=5;p.vy=100;p.ground=false;}
    else{p.vy=p.jumps===0?-470:-430;p.jumps++;p.launch=0;p.ground=false;p.emote=0;p.jumpAnim=.24;options.emit?.(p.jumps>=2?'doubleJump':'jump',p);}
   }
  }
  const dashPress=Number(i.dash)||0;if(dashPress>(p.used.dash||0)){p.used.dash=dashPress;if(p.dashCD<=0&&p.stun<=0){p.dashTime=.17;p.dashCD=1;p.launch=0;p.vx=(x||p.facing)*610;p.vy=y<-.5?-200:p.vy*.3;p.inv=Math.max(p.inv,.26);p.wallSide=0;p.emote=0;options.emit?.('dash',p);}}
  {const fast=!p.ground&&y>.55&&p.vy>-40&&p.stun<=0;p.vy=Math.min(fast?1350:1080,p.vy+(fast?2100:1180)*dt);}p.x+=p.vx*dt;p.y+=p.vy*dt;p.ground=false;
  // The main island is solid only at its visible cliff faces. Upper ledges stay one-way.
  const main=stage.find(s=>s.main);let wall=0;
  if(main&&p.y>main.y+12&&p.y-64<main.y+170){
   const left=main.x,right=main.x+main.w;
   if(previousX+17<=left+3&&p.x+17>=left){p.x=left-17;p.vx=Math.min(0,p.vx);if(x>.15)wall=1;}
   else if(previousX-17>=right-3&&p.x-17<=right){p.x=right+17;p.vx=Math.max(0,p.vx);if(x<-.15)wall=-1;}
  }
  if(wall&&p.stun<=0&&p.wallKick<=0&&p.wallGrip>0&&p.wallTouches<4&&p.dashTime<=0){p.wallSide=wall;p.wallGrip=Math.max(0,p.wallGrip-dt);p.vy=Math.min(p.vy,72);p.facing=wall;}
  else p.wallSide=0;
  if(p.dropThrough<=0&&p.vy>=0)for(const platform of stage)if(previousY<=platform.y+3&&p.y>=platform.y&&p.x>=platform.x-10&&p.x<=platform.x+platform.w+10){p.y=platform.y;p.vy=0;p.ground=true;p.jumps=0;p.launch=0;p.recoveryUsed=false;p.wallSide=0;p.wallTouches=0;p.wallGrip=1.35;if(!wasGround){p.landTimer=.12;p.landed=true;}break;}
  const motion=p.wallKick>0?'wallJump':p.wallSide?'wallSlide':p.dashTime>0?'dash':p.landTimer>0?'land':!p.ground?(p.jumpAnim>0&&p.jumps>=2?'doubleJump':p.vy<0?'jump':'fall'):Math.abs(p.vx)>22?'run':'idle';state(p,motion,dt);return p;
 }
 window.ArenaMotion=Object.freeze({version:2,create,step,timers:Object.freeze(timers)});
})();
