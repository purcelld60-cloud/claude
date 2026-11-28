#!/usr/bin/env python3
"""Fala com o Roblox pela Open Cloud (apis.roblox.com): roda Luau no lugar do jogo e publica versões.

A chave da API NÃO fica aqui nem em variável: neste ambiente ela é guardada como segredo de rede e o proxy põe o
cabeçalho x-api-key sozinho. Em outro computador, defina ROBLOX_API_KEY (nunca escreva a chave em arquivo do repositório).

Uso (na raiz do repositório):
  python3 roblox/ferramentas/nuvem.py publicar <universo> <lugar> <arquivo.rbxlx> [Saved|Published]
      Saved: guarda uma versão sem colocar no ar (bom para testar). Published: publica para os jogadores.
  python3 roblox/ferramentas/nuvem.py executar <universo> <lugar> <script.lua> [versão] [tempo_s]
      Roda o script num servidor do Roblox com o lugar (na versão pedida ou na publicada) e mostra o que ele imprimiu.
"""
import json
import os
import subprocess
import sys
import time

BASE = "https://apis.roblox.com"


def curl(metodo, url, corpo=None, tipo="application/json", arquivo=None):
    cmd = ["curl", "-sS", "-X", metodo, url, "-w", "\n%{http_code}"]
    chave = os.environ.get("ROBLOX_API_KEY")
    if chave:
        cmd += ["-H", "x-api-key: " + chave]
    if arquivo:
        cmd += ["-H", "Content-Type: " + tipo, "--data-binary", "@" + arquivo]
    elif corpo is not None:
        cmd += ["-H", "Content-Type: " + tipo, "--data-binary", "@-"]
    r = subprocess.run(cmd, input=(json.dumps(corpo).encode() if corpo is not None and not arquivo else None), capture_output=True)
    saida = r.stdout.decode("utf-8", "replace")
    texto, _, codigo = saida.rpartition("\n")
    if r.returncode != 0:
        raise SystemExit("curl falhou: " + r.stderr.decode("utf-8", "replace"))
    try:
        dados = json.loads(texto) if texto.strip() else {}
    except ValueError:
        dados = {"texto": texto[:2000]}
    return int(codigo or 0), dados


def publicar(universo, lugar, arquivo, tipo_versao="Saved"):
    url = f"{BASE}/universes/v1/{universo}/places/{lugar}/versions?versionType={tipo_versao}"
    tipo = "application/xml" if arquivo.endswith(".rbxlx") else "application/octet-stream"
    codigo, dados = curl("POST", url, tipo=tipo, arquivo=arquivo)
    print(codigo, json.dumps(dados, ensure_ascii=False))
    return dados.get("versionNumber")


def executar(universo, lugar, script, versao=None, tempo=290):
    fonte = open(script, encoding="utf-8").read()
    caminho = f"universes/{universo}/places/{lugar}" + (f"/versions/{versao}" if versao else "")
    codigo, tarefa = curl("POST", f"{BASE}/cloud/v2/{caminho}/luau-execution-session-tasks", {"script": fonte, "timeout": f"{int(tempo)}s"})
    if codigo >= 300 or "path" not in tarefa:
        raise SystemExit(f"não criou a tarefa ({codigo}): {json.dumps(tarefa, ensure_ascii=False)}")
    path = tarefa["path"]
    print("tarefa:", path, file=sys.stderr)
    inicio = time.time()
    while True:
        time.sleep(3)
        codigo, tarefa = curl("GET", f"{BASE}/cloud/v2/{path}")
        estado = tarefa.get("state")
        if estado in ("COMPLETE", "FAILED", "CANCELLED") or time.time() - inicio > tempo + 120:
            break
    token, linhas = "", []
    while True:
        codigo, logs = curl("GET", f"{BASE}/cloud/v2/{path}/logs?maxPageSize=10000" + (f"&pageToken={token}" if token else ""))
        for bloco in logs.get("luauExecutionSessionTaskLogs", []):
            linhas += bloco.get("messages", [])
        token = logs.get("nextPageToken") or ""
        if not token:
            break
    for l in linhas:
        print(l)
    print("estado:", estado, file=sys.stderr)
    if tarefa.get("error"):
        print("erro:", json.dumps(tarefa["error"], ensure_ascii=False), file=sys.stderr)
    if tarefa.get("output"):
        print("retorno:", json.dumps(tarefa["output"], ensure_ascii=False)[:4000], file=sys.stderr)


if __name__ == "__main__":
    a = sys.argv[1:]
    if len(a) >= 4 and a[0] == "publicar":
        publicar(a[1], a[2], a[3], a[4] if len(a) > 4 else "Saved")
    elif len(a) >= 4 and a[0] == "executar":
        executar(a[1], a[2], a[3], a[4] if len(a) > 4 and a[4] != "-" else None, int(a[5]) if len(a) > 5 else 290)
    else:
        print(__doc__)
