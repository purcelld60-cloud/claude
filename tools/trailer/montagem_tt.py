# Trailer vertical para TikTok (1080x1920, 30 qps): cortes no compasso, recorte que segue a ação,
# quadro inteiro com fundo desfocado nas cutscenes, legendas grandes dentro da área segura.
import subprocess, os, json
from PIL import Image, ImageDraw, ImageFont, ImageFilter, ImageEnhance
W, H, FPS, BAR = 1080, 1920, 30, 1.875
FONTE = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', '..', 'dist', 'assets', 'pixel.ttf')
if not os.path.exists(FONTE): FONTE = '/home/user/claude/dist/assets/pixel.ttf'
F = lambda s: ImageFont.truetype(FONTE, s)
Q = 'quadros-tt'; FOCO = json.load(open('foco.json'))
GANCHO = ('UM JOGO FEITO', 'EM ITABUNA, BAHIA')
CHEFES = ['dede', 'kaique', 'arthur', 'freddy', 'menezes', 'giant', 'marco', 'nicolas', 'nikolas', 'reeisBoss']
VILOES = ['creuza', 'tonhao', 'valdomiro', 'kaua', 'barao', 'breno', 'gemeos', 'fred']
# (cena, compassos, modo, início, título, subtítulo, selo)
L = []
for c, ini, modo in [('chefe_nicolas', 22, 'crop'), ('chefe_marco', 22, 'crop'), ('ollyan', 75, 'caixa'), ('c2_luta_jorge', 24, 'crop'), ('mapa_c1', 30, 'crop'), ('jorge_anime', 12, 'crop'), ('chefe_giant', 22, 'crop'), ('c2_luta_tonhao', 24, 'crop')]:
    L.append((c, .25, modo, ini, *GANCHO, None))
L.append(('#logo', 1, 'logo', 0, None, None, None))
L += [('abertura', 1, 'caixa', 0, 'ITABUNA, BAHIA', 'O bolo, a vingança e o açaí de quarta', None),
      ('roca', 1, 'crop', 5, 'EXPLORE A ROÇA', 'Dash, peidão e bolinha de papel', None)]
for c in ['chegada_escola', 'chegada_favela', 'chegada_rayssa']: L.append((c, .5, 'caixa', 0, 'A CIDADE INTEIRA', 'Escola, favela, academia, praça...', None))
for i, c in enumerate(CHEFES): L.append(('chefe_' + c, .5, 'crop', 8, '10 CHEFES', 'Cada um com seus golpes', f'{i + 1}/10'))
L += [('ollyan', 1, 'caixa', 0, 'O BAILE DO OLLYAN', None, None), ('mapa_c1', 1, 'crop', 0, 'VOE DE CARRO A GÁS', None, None),
      ('fliperama', .5, 'caixa', 6, '10 MINIGAMES', 'No fliperama da roça', None), ('jorge_anime', 1, 'crop', 0, 'MAS ALGO', 'AINDA FALTAVA...', None),
      ('#c2', 1, 'c2', 0, None, None, None),
      ('c2_voo', 1, 'caixa', 0, 'UM ANO DEPOIS...', None, None), ('c2_cidade', 1, 'crop', 5, 'VITÓRIA DA CONQUISTA', 'Uma cidade nova (e gelada)', None)]
for i, v in enumerate(VILOES): L.append(('vilao_' + v, .5, 'caixa', 10, '8 VILÕES NOVOS', None, f'{i + 1}/8'))
L += [('c2_luta_tonhao', .75, 'crop', 8, 'ARENA EM CADA LUTA', 'Barra de chefe, dash e golpes em área', None), ('c2_luta_kaua', .75, 'crop', 8, 'ARENA EM CADA LUTA', 'Barra de chefe, dash e golpes em área', None),
      ('c2_luta_barao', .75, 'crop', 8, 'ARENA EM CADA LUTA', 'Barra de chefe, dash e golpes em área', None), ('c2_luta_jorge', .75, 'crop', 8, 'O ACERTO DE CONTAS', None, None),
      ('mapa_c2', 1, 'crop', 0, 'TÁXI PELA CIDADE', None, None), ('c2_final', 1, 'caixa', 0, 'E O FINAL?', 'Só jogando pra saber', None),
      ('#final', 4 + 1.2 / BAR, 'final', 0, None, None, None)]
total = sum(x[1] for x in L) * BAR; NF = int(round(total * FPS)); print('total', round(total, 2), 's', NF, 'quadros')

cacheL = {}
def lista(c):
    if c not in cacheL: d = os.path.join(Q, c); cacheL[c] = sorted(os.listdir(d)) if os.path.isdir(d) else []
    return cacheL[c]
suave = {}
def focos(c):  # foco suavizado (ida e volta) para o recorte não tremer
    if c not in suave:
        a = FOCO.get(c) or [960] * len(lista(c)); s = list(a); k = .18
        for i in range(1, len(s)): s[i] = s[i - 1] + (a[i] - s[i - 1]) * k
        for i in range(len(s) - 2, -1, -1): s[i] = s[i + 1] + (s[i] - s[i + 1]) * k
        suave[c] = s
    return suave[c]
def quadro(c, i):
    l = lista(c); i = max(0, min(len(l) - 1, i)); return Image.open(os.path.join(Q, c, l[i])).convert('RGB'), i

BANDA = 400  # faixa de título no topo: o jogo fica inteiro embaixo, sem texto por cima
FAIXA = Image.new('RGB', (W, BANDA), '#1c1108'); _d = ImageDraw.Draw(FAIXA)
for _y in range(BANDA): _d.line([(0, _y), (W, _y)], fill=(int(20 + 22 * _y / BANDA), int(12 + 14 * _y / BANDA), int(6 + 8 * _y / BANDA)))
_d.rectangle([0, BANDA - 10, W, BANDA - 5], fill='#a87a49'); _d.rectangle([0, BANDA - 5, W, BANDA], fill='#1c1108')
def modo_crop(src, cx, zoom=1.0):
    gh = H - BANDA; cw = 1080 * 1080 / gh / zoom; ch = 1080 / zoom; cx = max(cw / 2, min(1920 - cw / 2, cx)); cy = 540
    im = Image.new('RGB', (W, H)); im.paste(FAIXA, (0, 0)); im.paste(src.crop((int(cx - cw / 2), int(cy - ch / 2), int(cx + cw / 2), int(cy + ch / 2))).resize((W, gh), Image.BICUBIC), (0, BANDA)); return im
def fundo_borrado(src):
    s = src.resize((480, 270)); s = s.crop((150, 0, 302, 270)).resize((216, 384)).filter(ImageFilter.GaussianBlur(6))
    return ImageEnhance.Brightness(s.resize((W, H), Image.BILINEAR)).enhance(.42)
FY = 600  # topo do quadro no modo caixa
def modo_caixa(src, zoom=1.0):
    im = fundo_borrado(src); fw = int(W * zoom); fh = int(fw * 1080 / 1920); fr = src.resize((fw, fh), Image.BICUBIC)
    x, y = (W - fw) // 2, FY + (608 - fh) // 2; d = ImageDraw.Draw(im); d.rectangle([x - 8, y - 8, x + fw + 7, y + fh + 7], fill='#1c1108'); d.rectangle([x - 4, y - 4, x + fw + 3, y + fh + 3], fill='#a87a49')
    im.paste(fr, (x, y)); return im

def texto(d, xy, s, tam, cor, borda=7, sombra='#1c1108', anc='mm'):
    f = F(tam); x, y = xy
    while f.getlength(s) > W - 120 and tam > 20: tam -= 4; f = F(tam)
    d.text((x, y + borda), s, font=f, fill=sombra, anchor=anc, stroke_width=borda, stroke_fill=sombra); d.text((x, y), s, font=f, fill=cor, anchor=anc, stroke_width=borda, stroke_fill=sombra)
def legenda(im, tit, sub, selo, k, modo, novo):
    d = ImageDraw.Draw(im); e = 1 if not novo else min(1, k * 8); e = 1 - (1 - e) ** 3
    ty = (FY - 150) if modo == 'caixa' else 215
    if tit: texto(d, (W / 2 + (1 - e) * -700, ty), tit, 86, '#ffd36b', borda=8)
    if sub: texto(d, (W / 2 + (1 - e) * 700, ty + 95 if modo != 'caixa' else FY + 608 + 90), sub, 38, '#fff4dc', borda=5)
    if selo:
        f = F(34); w = f.getlength(selo) + 44; x0 = W - 110 - w; y0 = FY - 70 if modo == 'caixa' else BANDA + 24
        d.rounded_rectangle([x0, y0, x0 + w, y0 + 60], 10, fill='#1c1108'); d.rounded_rectangle([x0 + 4, y0 + 4, x0 + w - 4, y0 + 56], 8, fill='#e9c27a'); d.text((x0 + w / 2, y0 + 31), selo, font=f, fill='#1c1108', anchor='mm')
    return im

# telas especiais
tit_src, _ = quadro('titulo', 50)
PLACA = tit_src.crop((612, 124, 1304, 360))
BG_TIT = fundo_borrado(tit_src)
def madeira():
    im = Image.new('RGB', (W, H), '#2a1a0e'); d = ImageDraw.Draw(im)
    for y in range(0, H, 36):
        c = (58 + (y // 36 % 3) * 6, 38 + (y // 36 % 3) * 4, 22); d.rectangle([0, y, W, y + 33], fill=c); d.rectangle([0, y + 33, W, y + 35], fill='#1a0f07')
        for x in range((y * 37) % 200, W, 260): d.rectangle([x, y + 12, x + 60, y + 14], fill=(c[0] - 10, c[1] - 7, c[2] - 4))
    return im
MADEIRA = madeira()
def tela_logo(k):
    im = BG_TIT.copy(); z = .92 + .08 * min(1, k * 2.5); pw = int(1000 * z); ph = int(pw * PLACA.height / PLACA.width)
    im.paste(PLACA.resize((pw, ph), Image.NEAREST), ((W - pw) // 2, 760 - ph // 2)); d = ImageDraw.Draw(im)
    if k > .3: texto(d, (W / 2, 1060), 'O bolo, a vingança e o açaí de quarta', 34, '#fff4dc', borda=5)
    return im
def tela_c2(k):
    im = MADEIRA.copy(); d = ImageDraw.Draw(im); z = 1 + .05 * k
    texto(d, (W / 2, 760), 'CAMPANHA 2', int(120 * z), '#bfe4ff', sombra='#0c1420', borda=9)
    texto(d, (W / 2, 900), 'VITÓRIA DA CONQUISTA', 58, '#ffffff', sombra='#0c1420', borda=7)
    if k > .25: texto(d, (W / 2, 1010), 'Um ano depois · a busca pelo Jorge', 34, '#e9c27a', borda=5)
    return im
def tela_final(k):
    im = BG_TIT.copy(); pw = 1000; ph = int(pw * PLACA.height / PLACA.width); im.paste(PLACA.resize((pw, ph), Image.NEAREST), ((W - pw) // 2, 560 - ph // 2)); d = ImageDraw.Draw(im)
    a = min(1, max(0, (k - .08) * 5))
    if a > 0:
        texto(d, (W / 2, 880), 'JOGUE AGORA', 110, '#ffd36b', borda=9)
        texto(d, (W / 2, 990), 'No celular e no PC', 44, '#fff4dc', borda=6)
        y0 = 1090; f = F(44); w = f.getlength('LINK NA BIO') + 80; pulso = 1 + .05 * abs(((k * 6) % 2) - 1)
        ww, hh = w * pulso, 96 * pulso; d.rounded_rectangle([W / 2 - ww / 2, y0, W / 2 + ww / 2, y0 + hh], 22, fill='#1c1108'); d.rounded_rectangle([W / 2 - ww / 2 + 6, y0 + 6, W / 2 + ww / 2 - 6, y0 + hh - 6], 18, fill='#8fc46b')
        d.text((W / 2, y0 + hh / 2), 'LINK NA BIO', font=F(int(44 * pulso)), fill='#1c1108', anchor='mm')
        texto(d, (W / 2, 1290), 'Campanha 1 · Campanha 2', 30, '#e9c27a', borda=4); texto(d, (W / 2, 1340), 'Arena online · Fliperama', 30, '#e9c27a', borda=4)
    return im

proc = subprocess.Popen(['ffmpeg', '-y', '-loglevel', 'error', '-f', 'rawvideo', '-pix_fmt', 'rgb24', '-s', f'{W}x{H}', '-r', str(FPS), '-i', '-', '-i', 'musica-tt.wav',
                         '-c:v', 'libx264', '-preset', 'medium', '-crf', '19', '-pix_fmt', 'yuv420p', '-profile:v', 'high', '-c:a', 'aac', '-b:a', '192k', '-ar', '44100',
                         '-shortest', '-movflags', '+faststart', 'DaRoca-Trailer-TikTok.mp4'], stdin=subprocess.PIPE)
cortes = []; t = 0
for x in L: cortes.append((t, t + x[1] * BAR, *x)); t += x[1] * BAR
ultimo_tit = None
for f in range(NF):
    ts = f / FPS
    j = next((i for i, cc in enumerate(cortes) if cc[0] <= ts < cc[1]), len(cortes) - 1)
    c0, c1, cena, bars, modo, ini, tit, sub, selo = cortes[j]; k = (ts - c0) / (c1 - c0); lf = int((ts - c0) * FPS)
    # a legenda só entra animada quando muda (no gancho e na sequência de chefes ela fica parada)
    g0 = j
    while g0 > 0 and cortes[g0 - 1][6] == tit and tit: g0 -= 1
    kg = (ts - cortes[g0][0]) / max(.3, cortes[j][1] - cortes[g0][0]) if tit else k
    soco = 1 + .06 * max(0, 1 - lf / 6)  # "soco" de zoom a cada corte
    if modo == 'logo': im = tela_logo(k)
    elif modo == 'c2': im = tela_c2(k)
    elif modo == 'final': im = tela_final(k)
    else:
        src, i = quadro(cena, ini + lf)
        if modo == 'crop': im = modo_crop(src, focos(cena)[i] if focos(cena) else 960, soco)
        else: im = modo_caixa(src, min(1.0, .96 * soco))
        im = legenda(im, tit, sub, selo, (ts - cortes[g0][0]) / BAR, modo, True)
    if lf < 3 and f > 0 and not modo.startswith('#'): im = Image.blend(im, Image.new('RGB', (W, H), '#fff6dc'), .5 * (1 - lf / 3))
    fimp = total - ts
    if fimp < 1.2: im = Image.blend(Image.new('RGB', (W, H)), im, max(0, fimp / 1.2))
    proc.stdin.write(im.tobytes())
proc.stdin.close(); proc.wait(); print('ok')
