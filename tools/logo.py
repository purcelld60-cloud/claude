# Logo do Da Roça Adventure em pixel art 64x64: bolo de sapo com chapéu de palha no pôr do sol.
from PIL import Image
import math
N=64
img=Image.new('RGBA',(N,N),(0,0,0,0)); P=img.load()
def px(x,y,c):
    if 0<=x<N and 0<=y<N: P[x,y]=c if len(c)==4 else c+(255,)
def H(h): h=h.lstrip('#'); return tuple(int(h[i:i+2],16) for i in (0,2,4))
def rect(x0,y0,x1,y1,c):
    for y in range(y0,y1+1):
        for x in range(x0,x1+1): px(x,y,H(c))
def ell(cx,cy,rx,ry,c,cond=None):
    for y in range(N):
        for x in range(N):
            if ((x+.5-cx)/rx)**2+((y+.5-cy)/ry)**2<=1 and (cond is None or cond(x,y)): px(x,y,H(c))
# ---- fundo: céu em faixas (pôr do sol), sol, morros, cerca ----
ceu=['#1a1f4a','#2a2f66','#3f3f80','#5f4a8c','#8a5288','#b85a72','#e0705a','#f08f50','#f6b052']
for y in range(N):
    i=min(len(ceu)-1,int(y/40*len(ceu))); rect(0,y,N-1,y,ceu[i])
for (x,y) in [(6,5),(14,9),(52,6),(58,12),(44,3),(23,4),(9,15),(55,19)]: px(x,y,H('#fff6d0'))
ell(32,40,15,15,'#ffd27a'); ell(32,40,13,13,'#ffe6a0')
ell(12,52,22,11,'#3f7a35'); ell(54,53,20,10,'#356b2e'); rect(0,50,N-1,N-1,'#4f8a3a')
for x in range(0,N): 
    if (x*7)%5==0: px(x,50,H('#6aa848'))
for x in range(2,N,8): rect(x,44,x,52,'#6a4a2a'); px(x,43,H('#8a6a3a'))
rect(0,46,N-1,46,'#7a5530'); rect(0,49,N-1,49,'#7a5530')
fundo=img.copy()
# ---- primeiro plano (bolo + sapo + chapéu) num layer separado para ganhar contorno ----
fg=Image.new('RGBA',(N,N),(0,0,0,0)); F=fg.load()
def f(x,y,c):
    if 0<=x<N and 0<=y<N: F[x,y]=H(c)+(255,)
def frect(x0,y0,x1,y1,c):
    for y in range(y0,y1+1):
        for x in range(x0,x1+1): f(x,y,c)
def fell(cx,cy,rx,ry,c,cond=None):
    for y in range(N):
        for x in range(N):
            if ((x+.5-cx)/rx)**2+((y+.5-cy)/ry)**2<=1 and (cond is None or cond(x,y)): f(x,y,c)
# prato
fell(32,58,25,3.2,'#e8e4dc'); fell(32,57.5,23,2.2,'#ffffff')
# andar de baixo (chocolate) com recheio
frect(10,44,53,56,'#7a4a2a'); frect(10,44,53,45,'#9a6038'); frect(10,55,53,56,'#5a3418')
frect(10,49,53,50,'#f3e0b0'); frect(10,50,53,50,'#e0c890')
for x in range(13,52,7): f(x,47,'#ffd24a'); f(x+3,53,'#ff6a8a'); f(x+1,52,'#7ad8ff')
# cobertura escorrendo (creme)
frect(10,42,53,43,'#fff4d8')
for x,h in [(12,3),(17,5),(22,2),(27,4),(33,6),(38,3),(43,5),(48,2),(52,4)]:
    for y in range(44,44+h): f(x,y,'#fff4d8'); f(x+1,y,'#f6e2b8') if y<44+h-1 else None
# sapo (corpo-bolo verde) em cima
fell(32,33,19,12,'#6ab84a'); fell(32,32.5,18,11,'#7fcc58'); fell(32,40,19,4,'#5aa03e',lambda x,y:y>=39)
# olhos grandes
for ex in (21,43):
    fell(ex,27,7,7,'#5aa03e'); fell(ex,26.5,6.2,6.2,'#7fcc58')
    fell(ex,26.5,4.6,4.6,'#ffffff'); fell(ex+1,27,2.6,2.8,'#1a1410'); f(ex,25,'#ffffff'); f(ex-1,25,'#ffffff')
# bochechas, boca sorrindo
fell(17,35,3,1.6,'#ff8aa0'); fell(47,35,3,1.6,'#ff8aa0')
fell(32,37.5,6,3,'#2a1a10',lambda x,y:y>=37); fell(32,38,4.5,2,'#e8435a',lambda x,y:y>=38); f(30,37,'#ffffff'); f(34,37,'#ffffff')
f(25,36,'#2a4a1a'); f(39,36,'#2a4a1a')
# manchinhas
for (x,y) in [(26,31),(39,32),(36,30),(28,33)]: f(x,y,'#5aa03e')
# chapéu de palha do Da Roça, inclinado na cabeça
for y in range(N):
    for x in range(N):
        # aba
        if ((x+.5-32)/15)**2+((y+.5-18)/2.8)**2<=1: f(x,y,'#e8c060')
for y in range(N):
    for x in range(N):
        if ((x+.5-32)/8)**2+((y+.5-13)/5.5)**2<=1 and y<=17: f(x,y,'#f0cc6a')
frect(25,15,39,16,'#c43c3a'); frect(25,16,39,16,'#a02a28')  # fita vermelha
for x in range(19,46,3): f(x,18,'#c89a40')   # trama da palha
for x in range(26,39,3): f(x,11,'#d8aa4a'); f(x+1,13,'#d8aa4a')
f(28,9,'#fff0b0'); f(29,9,'#fff0b0'); f(27,10,'#fff0b0')
# vela acesa
frect(50,30,51,40,'#ff6a8a'); f(50,32,'#ffffff'); f(50,35,'#ffffff'); f(50,38,'#ffffff'); f(51,29,'#3a2a1c')
fg_vela=[(50,26,'#fff6b0'),(51,26,'#ffd24a'),(50,27,'#ffd24a'),(51,27,'#ff8a3a'),(51,25,'#fff6b0'),(50,28,'#ff8a3a'),(51,28,'#ff6a3a')]
for x,y,c in fg_vela: f(x,y,c)
# contorno escuro em volta do primeiro plano
OUT=H('#1a0e08')+(255,)
cont=[]
for y in range(N):
    for x in range(N):
        if F[x,y][3]==0 and any(0<=x+dx<N and 0<=y+dy<N and F[x+dx,y+dy][3]>0 for dx,dy in ((1,0),(-1,0),(0,1),(0,-1))): cont.append((x,y))
for x,y in cont: F[x,y]=OUT
img=Image.alpha_composite(fundo,fg)
# brilhos
for (x,y) in [(8,30),(57,24),(14,38)]:
    for d in ((0,0),(1,0),(-1,0),(0,1),(0,-1)): img.putpixel((x+d[0],y+d[1]),H('#fffbe0')+(255,))
img.save('logo64.png')
img.resize((512,512),Image.NEAREST).save('logo512.png')
img.resize((1024,1024),Image.NEAREST).save('logo1024.png')
img.resize((192,192),Image.NEAREST).save('logo192.png')
