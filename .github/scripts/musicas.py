#!/usr/bin/env python3
"""Gera a lista da pasta de músicas (dist/musicas/lista.json e lista.js).

A pasta dist/musicas tem uma subpasta para cada lugar do jogo (lista em dist/musicas/pastas.json):
basta pôr o .mp3/.ogg/.m4a dentro da pasta do lugar. Com várias músicas na mesma pasta, o jogo
sorteia uma. Arquivos soltos na raiz continuam valendo pelo nome (roca.mp3) ou pelo musicas.txt.

Roda sozinho nos builds do GitHub (site, APK, IPA e PC) e no workflow "Lista de músicas".
Uso local:
  python3 .github/scripts/musicas.py                 gera a lista
  python3 .github/scripts/musicas.py --criar-pastas  cria as pastas que faltam, com LEIA-ME.txt
  python3 .github/scripts/musicas.py --zip saida.zip monta o ZIP com as pastas e as músicas originais
                                                     (rode antes o restaurar_trilhas.py)
"""
import argparse
import hashlib
import json
import os
import re
import shutil
import subprocess
import sys
import zipfile

RAIZ = os.path.normpath(os.path.join(os.path.dirname(__file__), '..', '..'))
PASTA = os.path.join(RAIZ, 'dist', 'musicas')
ORIGINAIS = os.path.join(RAIZ, 'dist', 'music')
EXT = re.compile(r'\.(mp3|ogg|m4a|wav)$', re.I)
PASTA_OK = re.compile(r'^[a-z0-9][a-z0-9-]{0,60}$')


def duracao(caminho):
    if not shutil.which('ffprobe'):
        return 0
    try:
        out = subprocess.run(['ffprobe', '-v', 'error', '-show_entries', 'format=duration', '-of', 'csv=p=0', caminho],
                             capture_output=True, text=True, timeout=30).stdout.strip()
        return round(float(out), 2)
    except Exception:
        return 0


def sha256(caminho):
    d = hashlib.sha256()
    with open(caminho, 'rb') as f:
        for bloco in iter(lambda: f.read(256 * 1024), b''):
            d.update(bloco)
    return d.hexdigest()


def ler_pastas():
    with open(os.path.join(PASTA, 'pastas.json'), encoding='utf-8') as f:
        return json.load(f)['pastas']


def ler_config():
    try:
        with open(os.path.join(ORIGINAIS, 'config.json'), encoding='utf-8') as f:
            return json.load(f)
    except Exception:
        return {'tracks': [], 'bindings': {}}


def originais_por_pasta(pastas, config):
    """Para cada pasta, as faixas originais que já tocam lá (pelas 48 associações do jogo)."""
    faixas = {t['id']: t for t in config.get('tracks', [])}
    bind = config.get('bindings', {})
    out = {}
    for nome, info in pastas.items():
        lugar = info['lugar']
        ids = []
        for chave, b in bind.items():
            if chave == lugar or chave.startswith(lugar + '.phase'):
                if b.get('trackId') in faixas and b['trackId'] not in ids:
                    ids.append(b['trackId'])
        if not ids and lugar == 'menu.title' and 'maps.roca' in bind:
            ids.append(bind['maps.roca']['trackId'])  # sem música própria, o menu toca a da Roça
        out[nome] = [faixas[i] for i in ids]
    return out


def nome_original(faixa):
    t = re.sub(r'[\\/:*?"<>|]+', ' ', faixa.get('title') or 'musica').strip()[:70]
    return f'ORIGINAL - {t}.mp3'


def leia_me(nome, info, originais):
    linhas = [
        f'PASTA: {nome}',
        f'TOCA EM: {info["descricao"]}',
        '',
        'Como usar: coloque aqui músicas .mp3, .ogg ou .m4a (até 15 MB cada).',
        'Com mais de uma música nesta pasta, o jogo sorteia uma delas.',
        'Pasta sem música = o jogo continua com a música de sempre.',
        '',
    ]
    if originais:
        linhas.append('Música que o jogo já toca aqui hoje:')
        linhas += [f'  - {f.get("title")}' for f in originais]
        linhas.append('(no ZIP "DaRoca-Pasta-de-Musicas" ela vem nesta pasta com o nome "ORIGINAL - ...".')
        linhas.append(' Para trocar, apague o ORIGINAL e ponha a sua. Se deixar o ORIGINAL junto,')
        linhas.append(' o jogo sorteia entre ele e as suas.)')
    else:
        linhas.append('Hoje este lugar não tem música gravada: toca a trilha feita pelo próprio jogo.')
    return '\n'.join(linhas) + '\n'


def criar_pastas(pastas, config):
    orig = originais_por_pasta(pastas, config)
    for nome, info in pastas.items():
        d = os.path.join(PASTA, nome)
        os.makedirs(d, exist_ok=True)
        with open(os.path.join(d, 'LEIA-ME.txt'), 'w', encoding='utf-8') as f:
            f.write(leia_me(nome, info, orig[nome]))
    print(f'{len(pastas)} pastas prontas em dist/musicas/.')


def montar_zip(destino, pastas, config):
    orig = originais_por_pasta(pastas, config)
    faltando = set()
    with zipfile.ZipFile(destino, 'w', zipfile.ZIP_STORED) as z:
        base = 'DaRoca-Musicas'
        z.writestr(f'{base}/COMO-USAR.txt', (
            'PASTA DE MÚSICAS DO DA ROÇA ADVENTURE\n\n'
            'Cada pasta é um lugar do jogo (cenário, luta, menu...). O nome da pasta diz onde toca.\n'
            '1. Coloque a música (.mp3, .ogg ou .m4a) dentro da pasta do lugar.\n'
            '2. Pode pôr várias: o jogo sorteia uma.\n'
            '3. As músicas que o jogo já usa vêm nas pastas com o nome "ORIGINAL - ...".\n'
            '   Para trocar, apague o ORIGINAL e ponha a sua.\n'
            '4. Envie as pastas de volta (dentro de dist/musicas no GitHub ou mandando o ZIP para a IA).\n'
            '   O site, o APK, o IPA e o PC são gerados de novo sozinhos.\n'))
        for nome, info in pastas.items():
            z.writestr(f'{base}/{nome}/LEIA-ME.txt', leia_me(nome, info, orig[nome]))
            for f in orig[nome]:
                mp3 = os.path.join(ORIGINAIS, f['id'] + '.mp3')
                if os.path.isfile(mp3):
                    z.write(mp3, f'{base}/{nome}/{nome_original(f)}')
                else:
                    faltando.add(f.get('title'))
            for arq in sorted(os.listdir(os.path.join(PASTA, nome))) if os.path.isdir(os.path.join(PASTA, nome)) else []:
                if EXT.search(arq) and not arq.startswith('ORIGINAL - '):
                    z.write(os.path.join(PASTA, nome, arq), f'{base}/{nome}/{arq}')
    print(f'ZIP pronto: {destino} ({os.path.getsize(destino) // 1048576} MB)')
    for t in sorted(faltando):
        print('AVISO: música original não encontrada (rode o restaurar_trilhas.py):', t)
    return 1 if faltando else 0


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--criar-pastas', action='store_true')
    ap.add_argument('--zip')
    ap.add_argument('--limpar', action='store_true', help='apaga cópias dos ORIGINAIS que já tocam na própria pasta')
    a = ap.parse_args()
    os.makedirs(PASTA, exist_ok=True)
    pastas, config = ler_pastas(), ler_config()
    if a.criar_pastas:
        criar_pastas(pastas, config)
    if a.zip:
        return montar_zip(a.zip, pastas, config)
    por_sha = {t.get('sha256'): t['id'] for t in config.get('tracks', []) if t.get('sha256')}
    ja_toca = {n: {f['id'] for f in fs} for n, fs in originais_por_pasta(pastas, config).items()}
    limpar = a.limpar or bool(os.environ.get('GITHUB_ACTIONS'))
    arquivos, avisos = [], []

    def registrar(rel, caminho, pasta=None):
        tamanho = os.path.getsize(caminho)
        if tamanho > 15 * 1024 * 1024:
            avisos.append(f'{rel}: arquivo grande ({tamanho // 1048576} MB); prefira .ogg ou .mp3 de até 15 MB')
        item = {'nome': rel, 'bytes': tamanho, 'duracao': duracao(caminho)}
        if pasta:
            item['lugar'] = pastas[pasta]['lugar']
        orig = por_sha.get(sha256(caminho))
        if orig:
            item['original'] = orig  # a mesma música que já vem no jogo: usa a faixa original
        arquivos.append(item)

    for nome in sorted(os.listdir(PASTA)):
        caminho = os.path.join(PASTA, nome)
        if os.path.isfile(caminho) and EXT.search(nome):
            registrar(nome, caminho)
        elif os.path.isdir(caminho):
            if nome not in pastas:
                if any(EXT.search(x) for x in os.listdir(caminho)):
                    avisos.append(f'pasta "{nome}" não é de nenhum lugar do jogo (veja dist/musicas/pastas.json)')
                continue
            sons = [x for x in sorted(os.listdir(caminho)) if EXT.search(x) and os.path.isfile(os.path.join(caminho, x))]
            for x in sons:
                if not PASTA_OK.match(nome) or '/' in x or '\\' in x:
                    continue
                cam = os.path.join(caminho, x)
                # cópia do ORIGINAL sozinha na pasta onde ele já toca: não muda nada, não precisa ir no app
                if limpar and len(sons) == 1 and por_sha.get(sha256(cam)) in ja_toca.get(nome, set()):
                    os.remove(cam)
                    print(f'{nome}/{x}: é a música original deste lugar; removida do pacote (o jogo já toca).')
                    continue
                registrar(f'{nome}/{x}', cam, nome)
    txt_path = os.path.join(PASTA, 'musicas.txt')
    txt = open(txt_path, encoding='utf-8').read() if os.path.exists(txt_path) else ''
    nomes = {x['nome'] for x in arquivos}
    for n, linha in enumerate(txt.splitlines(), 1):
        linha = re.sub(r'#.*$', '', linha).strip()
        if not linha:
            continue
        if '=' not in linha:
            avisos.append(f'musicas.txt linha {n}: falta o "="')
            continue
        resto = linha.split('=', 1)[1].strip()
        m = re.match(r'^(.+?\.(?:mp3|ogg|m4a|wav))(?:\s|$)', resto, re.I)
        if not m:
            avisos.append(f'musicas.txt linha {n}: escreva o nome do arquivo com .mp3, .ogg ou .m4a')
        elif m.group(1).strip() not in nomes:
            avisos.append(f'musicas.txt linha {n}: o arquivo "{m.group(1).strip()}" não está na pasta dist/musicas')
    lista = {'arquivos': arquivos, 'avisos': avisos}
    with open(os.path.join(PASTA, 'lista.json'), 'w', encoding='utf-8') as f:
        json.dump(lista, f, ensure_ascii=False, indent=1)
        f.write('\n')
    # lista.js: a mesma lista + o musicas.txt, para o app do iPhone (abre os arquivos sem servidor)
    with open(os.path.join(PASTA, 'lista.js'), 'w', encoding='utf-8') as f:
        f.write('/* Gerado por .github/scripts/musicas.py: não edite à mão. */\n')
        f.write('window.DAROCA_MUSICAS=' + json.dumps({**lista, 'txt': txt}, ensure_ascii=False) + ';\n')
    print(f'Músicas: {len(arquivos)} arquivo(s) na pasta.')
    for a_ in avisos:
        print('AVISO:', a_)
        if os.environ.get('GITHUB_ACTIONS'):
            print(f'::warning title=Músicas::{a_}')
    return 0


if __name__ == '__main__':
    sys.exit(main())
