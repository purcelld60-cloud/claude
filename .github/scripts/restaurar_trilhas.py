"""Prepara os MP3 da edição 3.12.1 para o site e os apps. Aceita também o APK offline."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import re
from tempfile import NamedTemporaryFile
from time import sleep
from urllib.request import Request, urlopen
from zipfile import ZipFile


PASTA = Path(__file__).resolve().parents[2] / "dist" / "music"
ORIGEM = "https://da-roca-adventure-jogo.davims99.chatgpt.site/music/"


def conferir(arquivo, faixa):
    if not arquivo.is_file() or arquivo.stat().st_size != faixa["bytes"]:
        return False
    digest = hashlib.sha256()
    with arquivo.open("rb") as mp3:
        for bloco in iter(lambda: mp3.read(256 * 1024), b""):
            digest.update(bloco)
    return digest.hexdigest() == faixa["sha256"]


def copiar(fonte, destino, faixa):
    with NamedTemporaryFile(dir=destino.parent, delete=False) as tmp:
        parcial = Path(tmp.name)
    try:
        with parcial.open("wb") as saida:
            restante = faixa["bytes"]
            while restante:
                bloco = fonte.read(min(256 * 1024, restante))
                if not bloco:
                    break
                saida.write(bloco)
                restante -= len(bloco)
            if restante or fonte.read(1):
                raise ValueError("quantidade de bytes diferente do catálogo")
        if not conferir(parcial, faixa):
            raise ValueError("SHA-256 diferente do catálogo")
        parcial.chmod(0o644)
        os.replace(parcial, destino)
    finally:
        parcial.unlink(missing_ok=True)


def baixar(destino, faixa):
    pedido = Request(ORIGEM + destino.name, headers={"User-Agent": "DaRoca-restauracao", "Accept": "audio/mpeg"})
    for tentativa in range(3):
        try:
            with urlopen(pedido, timeout=45) as resposta:
                copiar(resposta, destino, faixa)
            return
        except (OSError, ValueError):
            if tentativa == 2:
                raise
            sleep(tentativa + 1)


def preparar(pasta, apk=None):
    catalogo = json.loads((pasta / "config.json").read_text(encoding="utf-8"))
    for faixa in catalogo["tracks"]:
        codigo = faixa["id"]
        if not re.fullmatch(r"[a-f0-9]{64}", codigo) or faixa["sha256"] != codigo or faixa["file"] != f"music/{codigo}.mp3":
            raise ValueError("faixa inválida no catálogo")
        destino = pasta / (codigo + ".mp3")
        if conferir(destino, faixa):
            continue
        try:
            if apk:
                with apk.open("assets/game/" + faixa["file"]) as fonte:
                    copiar(fonte, destino, faixa)
            else:
                baixar(destino, faixa)
        except (OSError, KeyError, ValueError) as erro:
            raise RuntimeError(f"Falha ao restaurar {faixa['title']}: {erro}") from erro
    # O WebView e o service worker leem o mesmo catálogo sem uma requisição a uma API.
    js = "self.DAROCA_MUSIC_CONFIG=" + json.dumps(catalogo, ensure_ascii=False, separators=(",", ":")) + ";\n"
    arquivo_js = pasta / "config.js"
    if not arquivo_js.exists() or arquivo_js.read_text(encoding="utf-8") != js:
        arquivo_js.write_text(js, encoding="utf-8")
    print(f"{len(catalogo['tracks'])} trilhas verificadas, {len(catalogo['bindings'])} associações.")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--apk", type=Path, help="APK 3.12.1 que já contém as músicas, para restaurar sem internet")
    args = parser.parse_args()
    if args.apk:
        with ZipFile(args.apk) as pacote:
            preparar(PASTA, pacote)
    else:
        preparar(PASTA)
