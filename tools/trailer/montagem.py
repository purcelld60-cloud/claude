# Monta o trailer: cortes no compasso da trilha, legendas em pixel, cartelas e cartela final.
import subprocess, os, math
from PIL import Image, ImageDraw, ImageFont, ImageFilter, ImageEnhance
W, H, FPS = 1280, 720, 30
BAR = 1.875
FONTE = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', '..', 'dist', 'assets', 'pixel.ttf')
F = lambda s: ImageFont.truetype(FONTE, s)
Q = 'quadros'

# (cena, compassos, início no clipe, legenda, sublegenda)
LINHA = [
    ('#cartela1', 2, 0, None, None),
    ('titulo', 2, 0, None, None),
    ('abertura', 2, 20, 'ITABUNA, BAHIA', 'O bolo, a vingança e o açaí de quarta'),
    ('roca', 2, 10, 'EXPLORE A ROÇA', 'Dash, peido em área e bolinha de papel'),
    ('luta_arthur', 2, 15, 'CHEFES DE VERDADE', 'Cada um com seus golpes'),
    ('luta_ollyan', 2, 15, 'O BAILE DO OLLYAN', 'E a fuga pelo céu de Itabuna'),
    ('luta_marco', 2, 15, 'BRAINROTS!', 'Projéteis, investidas e ataques em área'),
    ('luta_nicolas', 2, 15, 'SUBA DE NÍVEL', 'XP, atributos e itens'),
    ('jorge_anime', 2, 88, 'MAS ALGO AINDA FALTAVA...', None),
    ('mapa_c1', 2, 28, 'VOE DE CARRO A GÁS', None),
    ('#cartela2', 2, 0, None, None),
    ('c2_voo', 2, 10, 'UM ANO DEPOIS', None),
    ('c2_cidade', 2.5, 10, 'UMA CIDADE NOVA', 'O frio de Vitória da Conquista'),
    ('c2_luta_tonhao', 2.5, 15, '8 VILÕES NOVOS', 'Arena de chefe em cada luta'),
    ('c2_luta_kaua', 2, 15, 'KAUÃ INFLUENCER', None),
    ('c2_luta_jorge', 2.5, 15, 'O ACERTO DE CONTAS', None),
    ('mapa_c2', 2, 24, 'TÁXI PELA CIDADE', None),
    ('c2_final', 2.5, 0, None, None),
    ('#final', 4 + 1.2 / BAR, 0, None, None),
]

def quadros(nome):
    d = os.path.join(Q, nome); return sorted(os.listdir(d)) if os.path.isdir(d) else []

def texto(dr, xy, s, fonte, cor, sombra='#1c1108', anc='la', borda=3):
    x, y = xy
    for dx in range(-borda, borda + 1):
        for dy in range(-borda, borda + 1):
            if dx or dy: dr.text((x + dx, y + dy), s, font=fonte, fill=sombra, anchor=anc)
    dr.text((x, y + borda + 1), s, font=fonte, fill=sombra, anchor=anc); dr.text((x, y), s, font=fonte, fill=cor, anchor=anc)

def fundo_madeira():
    im = Image.new('RGB', (W, H), '#2a1a0e'); dr = ImageDraw.Draw(im)
    for y in range(0, H, 24):  # tábuas
        c = (58 + (y // 24 % 3) * 6, 38 + (y // 24 % 3) * 4, 22); dr.rectangle([0, y, W, y + 22], fill=c); dr.rectangle([0, y + 22, W, y + 23], fill='#1a0f07')
        for x in range((y * 37) % 160, W, 210): dr.rectangle([x, y + 8, x + 40, y + 9], fill=(c[0] - 10, c[1] - 7, c[2] - 4))
    vin = Image.new('L', (W, H), 0); dv = ImageDraw.Draw(vin)
    for i in range(40): dv.rectangle([i * 6, i * 4, W - i * 6, H - i * 4], outline=int(255 * (1 - i / 40) ** 2 * .7))
    return Image.composite(Image.new('RGB', (W, H), '#0c0704'), im, vin.filter(ImageFilter.GaussianBlur(30)))

BASE = fundo_madeira()
def cartela1(k):
    im = BASE.copy(); dr = ImageDraw.Draw(im)
    texto(dr, (W / 2, H / 2 - 30), 'UMA AVENTURA CULTIVADA', F(40), '#ffd36b', anc='mm', borda=4)
    texto(dr, (W / 2, H / 2 + 30), 'EM ITABUNA', F(40), '#ffd36b', anc='mm', borda=4)
    texto(dr, (W / 2, H / 2 + 100), '·  ·  ·', F(22), '#e9c27a', anc='mm')
    return im
def cartela2(k):
    im = BASE.copy(); dr = ImageDraw.Draw(im); z = 1 + .04 * k
    texto(dr, (W / 2, H / 2 - 60), 'CAMPANHA 2', F(int(70 * z)), '#bfe4ff', sombra='#0c1420', anc='mm', borda=5)
    texto(dr, (W / 2, H / 2 + 20), 'VITÓRIA DA CONQUISTA', F(40), '#ffffff', sombra='#0c1420', anc='mm', borda=4)
    texto(dr, (W / 2, H / 2 + 85), 'Um ano depois · a busca pelo Jorge', F(20), '#e9c27a', anc='mm')
    return im
def preparar_final():
    src = os.path.join(Q, 'titulo', quadros('titulo')[min(100, len(quadros('titulo')) - 1)])
    tit = Image.open(src).convert('RGB'); bg = ImageEnhance.Brightness(tit.filter(ImageFilter.GaussianBlur(10))).enhance(.45)
    placa = tit.crop((300, 100, 980, 315)); return bg, placa
FIN = None
def final(k):
    global FIN
    if FIN is None: FIN = preparar_final()
    bg, placa = FIN; im = bg.copy(); s = 1.0 + .06 * min(1, k * 3) - .06 * min(1, k * 3) ** 2 + .03 * min(1, k * 2)
    pw, ph = int(placa.width * s), int(placa.height * s); im.paste(placa.resize((pw, ph), Image.NEAREST), ((W - pw) // 2, 120 + (215 - ph) // 2))
    dr = ImageDraw.Draw(im); a = min(1, max(0, (k - .15) * 4))
    if a > 0:
        texto(dr, (W / 2, 430), 'JOGUE AGORA', F(54), '#ffd36b', anc='mm', borda=5)
        texto(dr, (W / 2, 500), 'No celular e no PC', F(24), '#fff4dc', anc='mm')
        texto(dr, (W / 2, 560), 'Campanha 1 · Campanha 2 · Arena online · Fliperama', F(16), '#e9c27a', anc='mm', borda=2)
    return im

def legenda(im, tit, sub, k):  # faixa de madeira entrando pela esquerda
    if not tit: return im
    e = min(1, k * 6); e = 1 - (1 - e) ** 3; sai = max(0, (k - .9) * 10)
    x0 = int(-560 + 600 * e - 600 * sai); y0 = H - 150
    ov = Image.new('RGBA', (W, H), (0, 0, 0, 0)); dr = ImageDraw.Draw(ov)
    w = max(F(40).getlength(tit) + 70, F(20).getlength(sub or '') + 70, 320)
    dr.rectangle([x0 - 4, y0 - 4, x0 + w + 4, y0 + (98 if sub else 70) + 4], fill=(28, 17, 8, 235))
    dr.rectangle([x0, y0, x0 + w, y0 + (98 if sub else 70)], fill=(122, 85, 50, 235)); dr.rectangle([x0, y0, x0 + w, y0 + 4], fill=(168, 122, 73, 255))
    texto(dr, (x0 + 28, y0 + 16), tit, F(40), '#ffd36b')
    if sub: texto(dr, (x0 + 30, y0 + 68), sub, F(20), '#fff4dc', borda=2)
    return Image.alpha_composite(im.convert('RGBA'), ov).convert('RGB')

total = sum(b for _, b, *_ in LINHA) * BAR
NF = int(round(total * FPS))
proc = subprocess.Popen(['ffmpeg', '-y', '-loglevel', 'error', '-f', 'rawvideo', '-pix_fmt', 'rgb24', '-s', f'{W}x{H}', '-r', str(FPS), '-i', '-',
                         '-i', 'musica.wav', '-c:v', 'libx264', '-preset', 'medium', '-crf', '18', '-pix_fmt', 'yuv420p', '-c:a', 'aac', '-b:a', '192k',
                         '-shortest', '-movflags', '+faststart', 'DaRoca-Trailer.mp4'], stdin=subprocess.PIPE)
cortes = []; t = 0
for cena, b, ini, tit, sub in LINHA: cortes.append((t, t + b * BAR, cena, ini, tit, sub)); t += b * BAR
cache = {}
for f in range(NF):
    ts = f / FPS
    for c0, c1, cena, ini, tit, sub in cortes:
        if c0 <= ts < c1 or c1 >= total - 1e-6 and ts >= c0: break
    k = (ts - c0) / (c1 - c0); lf = int((ts - c0) * FPS)
    if cena == '#cartela1': im = cartela1(k)
    elif cena == '#cartela2': im = cartela2(k)
    elif cena == '#final': im = final(k)
    else:
        lista = cache.setdefault(cena, quadros(cena))
        if not lista: im = BASE.copy()
        else: im = Image.open(os.path.join(Q, cena, lista[min(len(lista) - 1, ini + lf)])).convert('RGB')
        im = legenda(im, tit, sub, k)
    # transições: entra do preto nas cartelas; clarão curto nos cortes de gameplay; fim em preto
    if cena.startswith('#') and lf < 8: im = Image.blend(Image.new('RGB', (W, H)), im, lf / 8)
    elif lf < 4 and f > 0: im = Image.blend(im, Image.new('RGB', (W, H), '#fff6dc'), .55 * (1 - lf / 4))
    fimp = total - ts
    if fimp < 1.2: im = Image.blend(Image.new('RGB', (W, H)), im, max(0, fimp / 1.2))
    if ts < .5: im = Image.blend(Image.new('RGB', (W, H)), im, ts / .5)
    proc.stdin.write(im.tobytes())
proc.stdin.close(); proc.wait(); print('ok', NF, 'quadros', round(total, 2), 's')
