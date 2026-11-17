#!/usr/bin/env python3
"""Gera a lista da pasta de músicas (dist/musicas/lista.json e lista.js).

Roda sozinho nos builds do GitHub (site, APK e IPA) e no workflow "Lista de músicas".
Também confere o musicas.txt e avisa de lugares desconhecidos ou arquivos que faltam.
Uso local: python3 .github/scripts/musicas.py
"""
import json
import os
import re
import shutil
import subprocess
import sys

PASTA = os.path.join(os.path.dirname(__file__), '..', '..', 'dist', 'musicas')
PASTA = os.path.normpath(PASTA)
EXT = re.compile(r'\.(mp3|ogg|m4a|wav)$', re.I)


def duracao(caminho):
    if not shutil.which('ffprobe'):
        return 0
    try:
        out = subprocess.run(['ffprobe', '-v', 'error', '-show_entries', 'format=duration', '-of', 'csv=p=0', caminho],
                             capture_output=True, text=True, timeout=30).stdout.strip()
        return round(float(out), 2)
    except Exception:
        return 0


def main():
    os.makedirs(PASTA, exist_ok=True)
    arquivos, avisos = [], []
    for nome in sorted(os.listdir(PASTA)):
        caminho = os.path.join(PASTA, nome)
        if not os.path.isfile(caminho) or not EXT.search(nome):
            continue
        tamanho = os.path.getsize(caminho)
        if tamanho > 15 * 1024 * 1024:
            avisos.append(f'{nome}: arquivo grande ({tamanho // 1048576} MB); prefira .ogg ou .mp3 de até 15 MB')
        arquivos.append({'nome': nome, 'bytes': tamanho, 'duracao': duracao(caminho)})
    txt_path = os.path.join(PASTA, 'musicas.txt')
    txt = open(txt_path, encoding='utf-8').read() if os.path.exists(txt_path) else ''
    nomes = {a['nome'] for a in arquivos}
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
    for a in avisos:
        print('AVISO:', a)
        if os.environ.get('GITHUB_ACTIONS'):
            print(f'::warning title=Músicas::{a}')
    return 0


if __name__ == '__main__':
    sys.exit(main())
