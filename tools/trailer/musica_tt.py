# Trilha original do trailer: chiptune com levada de baião (zabumba, triângulo, baixo), em Sol mixolídio.
# 128 bpm, compasso 4/4. Seções: intro 4 c. | groove 16 c. | pausa 2 c. | groove (um tom acima) 16 c. | final 4 c.
import numpy as np, wave
SR = 44100; BPM = 128; BEAT = 60 / BPM; BAR = 4 * BEAT; S16 = BEAT / 4
INTRO, G1, BRK, G2, OUT = 3, 12, 1, 11, 4
TOTAL_BARS = INTRO + G1 + BRK + G2 + OUT
N = int((TOTAL_BARS * BAR + 3) * SR)
mix = np.zeros((N, 2))
rng = np.random.default_rng(7)

def hz(n): return 440 * 2 ** ((n - 69) / 12)
NOTE = {'C': 0, 'D': 2, 'E': 4, 'F': 5, 'G': 7, 'A': 9, 'B': 11}
def m(s):  # 'F#5' -> midi
    n = NOTE[s[0]]; i = 1
    if s[i] == '#': n += 1; i += 1
    elif s[i] == 'b': n -= 1; i += 1
    return 12 * (int(s[i:]) + 1) + n

def env(n, a=.005, d=.08, s=.6, r=.06):
    t = np.arange(n) / SR; e = np.ones(n) * s
    ai = int(a * SR); di = int(d * SR); ri = int(r * SR)
    if ai: e[:ai] = np.linspace(0, 1, ai)
    if di: e[ai:ai + di] = np.linspace(1, s, len(e[ai:ai + di]))
    if ri and n > ri: e[-ri:] *= np.linspace(1, 0, ri)
    return e

def osc(kind, f, n, duty=.5, vib=0):
    t = np.arange(n) / SR
    if vib: f = f * (1 + vib * np.sin(2 * np.pi * 5.5 * t) * np.clip(t * 4 - .3, 0, 1))
    ph = np.cumsum(np.ones(n) * f / SR) if np.isscalar(f) else np.cumsum(f / SR)
    ph %= 1
    if kind == 'sq': return np.where(ph < duty, 1., -1.)
    if kind == 'tri': return 4 * np.abs(ph - .5) - 1
    if kind == 'saw': return 2 * ph - 1
    return np.sin(2 * np.pi * ph)

def put(t0, sig, vol=.2, pan=0.):
    i = int(t0 * SR); j = min(N, i + len(sig))
    if j <= i: return
    l = np.cos((pan + 1) * np.pi / 4); r = np.sin((pan + 1) * np.pi / 4)
    mix[i:j, 0] += sig[:j - i] * vol * l * 1.41; mix[i:j, 1] += sig[:j - i] * vol * r * 1.41

def nota(t0, midi, dur, kind='sq', vol=.12, duty=.5, vib=0, pan=0, a=.005, d=.08, s=.6, r=.05):
    n = int(dur * SR); put(t0, osc(kind, hz(midi), n, duty, vib) * env(n, a, d, s, r), vol, pan)

def kick(t0, vol=.55):
    n = int(.22 * SR); t = np.arange(n) / SR; f = 50 + 120 * np.exp(-t * 30)
    put(t0, np.sin(2 * np.pi * np.cumsum(f) / SR) * np.exp(-t * 14), vol)
def zabumba_aro(t0, vol=.16):  # o "tá" do bacalhau (vareta)
    n = int(.06 * SR); t = np.arange(n) / SR; put(t0, rng.uniform(-1, 1, n) * np.exp(-t * 60), vol, .2)
def caixa(t0, vol=.18):
    n = int(.18 * SR); t = np.arange(n) / SR; s = rng.uniform(-1, 1, n) * np.exp(-t * 22) + .5 * np.sin(2 * np.pi * 190 * t) * np.exp(-t * 30)
    put(t0, s, vol, -.1)
def triangulo(t0, aberto, vol=.05):
    n = int((.16 if aberto else .04) * SR); t = np.arange(n) / SR
    s = (np.sin(2 * np.pi * 5200 * t) + .6 * np.sin(2 * np.pi * 7400 * t)) * np.exp(-t * (14 if aberto else 70))
    put(t0, s, vol, .45)
def prato(t0, vol=.14, dur=2.2):
    n = int(dur * SR); t = np.arange(n) / SR; s = rng.uniform(-1, 1, n); s = s - np.convolve(s, np.ones(3) / 3, 'same')
    put(t0, s * np.exp(-t * 2.2), vol, .3)
def subida(t0, dur, vol=.12):  # ruído que sobe antes da virada
    n = int(dur * SR); t = np.arange(n) / SR; s = rng.uniform(-1, 1, n); k = np.clip((t / dur) ** 2, 0, 1)
    out = np.zeros(n); y = 0.
    a = .02 + .6 * k
    for i in range(n): y += a[i] * (s[i] - y); out[i] = y
    put(t0, out * k, vol)

CH = {'G': ['G2', 'B3', 'D4', 'G4'], 'F': ['F2', 'A3', 'C4', 'F4'], 'C': ['C3', 'E3', 'G3', 'C4'], 'D': ['D3', 'F#3', 'A3', 'D4'], 'Em': ['E2', 'G3', 'B3', 'E4']}
PROG = ['G', 'F', 'C', 'G', 'G', 'F', 'C', 'G', 'G', 'F', 'C', 'D', 'G', 'F', 'C', 'D']
MEL = [  # (nota, 16 avos) — 4 frases de 4 compassos
    [('D5', 2), ('B4', 2), ('D5', 2), ('G5', 4), ('F5', 2), ('E5', 2), ('D5', 2)], [('C5', 2), ('F5', 2), ('A5', 4), ('G5', 2), ('F5', 2), ('E5', 2), ('F5', 2)],
    [('E5', 4), ('G5', 2), ('E5', 2), ('C5', 4), ('D5', 2), ('E5', 2)], [('D5', 6), ('B4', 2), ('G4', 8)],
    [('D5', 2), ('B4', 2), ('D5', 2), ('G5', 4), ('F5', 2), ('E5', 2), ('D5', 2)], [('C5', 2), ('F5', 2), ('A5', 4), ('G5', 2), ('F5', 2), ('E5', 2), ('F5', 2)],
    [('E5', 4), ('G5', 2), ('E5', 2), ('C5', 4), ('D5', 2), ('E5', 2)], [('D5', 2), ('F5', 2), ('E5', 2), ('D5', 2), ('B4', 2), ('A4', 2), ('G4', 4)],
    [('G5', 2), ('G5', 2), ('F5', 2), ('G5', 2), ('A5', 4), ('G5', 2), ('F5', 2)], [('F5', 2), ('F5', 2), ('E5', 2), ('F5', 2), ('G5', 4), ('F5', 2), ('E5', 2)],
    [('E5', 2), ('G5', 2), ('C6', 4), ('B5', 2), ('A5', 2), ('G5', 4)], [('A5', 4), ('F#5', 2), ('D5', 2), ('E5', 2), ('F#5', 2), ('A5', 4)],
    [('B5', 2), ('A5', 2), ('G5', 2), ('A5', 2), ('B5', 4), ('D6', 4)], [('C6', 2), ('A5', 2), ('F5', 2), ('A5', 2), ('C6', 4), ('A5', 4)],
    [('G5', 2), ('E5', 2), ('C5', 2), ('E5', 2), ('G5', 2), ('C6', 2), ('B5', 2), ('A5', 2)], [('A5', 4), ('F#5', 2), ('A5', 2), ('D6', 8)]]

def compasso(t0, ch, tr, nivel):
    ns = [m(x) + tr for x in CH[ch]]; root = ns[0]
    # baião: 3+3+2 (em colcheias) duas vezes por compasso
    for meio in (0, 2 * BEAT):
        for off, dur in ((0, 3), (3 * S16 * 2 / 2 * 1, 3), (6 * S16 * 2 / 2, 2)):
            pass
    for k, (o16, d16, oit) in enumerate([(0, 3, 0), (3, 3, 0), (6, 2, 12), (8, 3, 0), (11, 3, 7), (14, 2, 12)]):
        nota(t0 + o16 * S16, root + oit, d16 * S16 * .9, 'tri', .30, a=.002, d=.05, s=.8)
    if nivel >= 1:
        for o16 in (0, 3, 8, 11): kick(t0 + o16 * S16, .5 if o16 in (0, 8) else .32)
        for o16 in (6, 14): zabumba_aro(t0 + o16 * S16)
        for i in range(16): triangulo(t0 + i * S16, i % 4 == 2, .05 if i % 2 else .03)
    if nivel >= 2:
        for o16 in (4, 12): caixa(t0 + o16 * S16, .14)
    # acorde em "sanfona": pulsos curtos no contratempo
    for o16 in (2, 6, 10, 14):
        for x in ns[1:]: nota(t0 + o16 * S16, x + 12, S16 * 1.4, 'sq', .028, duty=.25, a=.003, d=.05, s=.5, pan=-.35)
    if nivel >= 3:  # arpejo
        arp = ns[1:] + [ns[1] + 12]
        for i in range(16): nota(t0 + i * S16, arp[i % 4] + 12, S16 * .8, 'sq', .022, duty=.125, a=.001, d=.03, s=.4, pan=.4)

def melodia(t0, frase, tr, vol=.085):
    t = t0
    for n, d in frase:
        nota(t, m(n) + tr, d * S16 * .92, 'sq', vol, duty=.5, vib=.006, pan=.05, a=.004, d=.06, s=.7, r=.04)
        nota(t + S16 * .75, m(n) + tr, d * S16 * .8, 'sq', vol * .25, duty=.25, pan=-.5, a=.004, d=.06, s=.6, r=.04)  # eco
        t += d * S16

def pad(t0, ch, dur, tr, vol=.05):
    for x in CH[ch][1:]:
        n = int(dur * SR); f = hz(m(x) + tr)
        s = (osc('saw', f, n) + osc('saw', f * 1.004, n)) / 2; s = np.convolve(s, np.ones(18) / 18, 'same')
        put(t0, s * env(n, a=.6, d=.2, s=.8, r=.6), vol)

t = 0.
# GANCHO (2 compassos): já entra com tudo, frase mais animada
for i, ch in enumerate(['G', 'D']):
    compasso(t + i * BAR, ch, 0, 3); melodia(t + i * BAR, MEL[8 + i * 3], 0, .09)
kick(t, .6); prato(t, .16)
t += 2 * BAR
# LOGO (1 compasso): pancada, acorde segurado e subida
kick(t, .65); prato(t, .2, 2.5); pad(t, 'C', BAR, 0, .06)
for x in CH['C']: nota(t, m(x) + 12, BAR * .9, 'sq', .03, duty=.25, a=.005, d=.3, s=.5, r=.3)
subida(t + BAR * .25, BAR * .75, .13)
t += BAR; prato(t, .16)
# CAMPANHA 1 (12 compassos)
for i in range(G1):
    compasso(t + i * BAR, PROG[i], 0, 2 if i < 2 else 3); melodia(t + i * BAR, MEL[i if i < 8 else i + 4], 0)
t += G1 * BAR
# virada para a Campanha 2 (1 compasso)
for o16 in (0, 3, 6, 8, 10, 12, 13, 14, 15): kick(t + o16 * S16, .3 + o16 * .02)
pad(t, 'D', BAR, 0, .05); subida(t, BAR, .15); t += BAR; prato(t, .18)
# CAMPANHA 2 (11 compassos), um tom acima
for i in range(G2):
    compasso(t + i * BAR, PROG[i], 2, 3); melodia(t + i * BAR, MEL[i], 2, .09)
t += G2 * BAR
# FINAL: dois compassos e o acorde final
compasso(t, 'G', 2, 3); melodia(t, [('B5', 2), ('A5', 2), ('B5', 2), ('D6', 2), ('E6', 4), ('D6', 4)], 2)
compasso(t + BAR, 'F', 2, 3); melodia(t + BAR, [('C6', 2), ('A5', 2), ('F5', 2), ('A5', 2), ('G5', 8)], 2)
t += 2 * BAR; kick(t, .6); prato(t, .2, 4)
for x in CH['G']: nota(t, m(x) + 2 + 12, BAR * 2, 'sq', .03, duty=.25, a=.01, d=.3, s=.5, r=1.2)
nota(t, m('G5') + 2, BAR * 2, 'sq', .07, vib=.01, a=.01, d=.3, s=.6, r=1.2); nota(t, m('G2') + 2, BAR * 2, 'tri', .3, a=.01, d=.4, s=.6, r=1.2)
pad(t, 'G', BAR * 2, 2, .06)
y = np.tanh(mix * 1.6) * .9
fim = int((TOTAL_BARS * BAR + 1.2) * SR); y = y[:fim]; y[-int(1.2 * SR):] *= np.linspace(1, 0, int(1.2 * SR))[:, None]
with wave.open('musica-tt.wav', 'wb') as w:
    w.setnchannels(2); w.setsampwidth(2); w.setframerate(SR); w.writeframes((y * 32767).astype('<i2').tobytes())
print('duração', len(y) / SR)
