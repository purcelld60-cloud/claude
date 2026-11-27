#!/usr/bin/env python3
"""Gera DaRocaAdventure.rbxlx: o lugar do Roblox com o jogo inteiro, pronto para abrir no Roblox Studio
(Arquivo > Abrir), sem precisar do Rojo.

Segue o mesmo mapa do default.project.json (as regras do Rojo):
  - pasta            -> Folder
  - nome.server.lua  -> Script        (roda no servidor)
  - nome.client.lua  -> LocalScript   (roda no jogador)
  - nome.lua         -> ModuleScript
e as propriedades de serviço do projeto (movimento "Scriptable" e personagem que não nasce sozinho).

Uso (na raiz do repositório):  python3 roblox/tools/gerar_rbxlx.py [saida.rbxlx]
"""
import json
import os
import sys
from pathlib import Path
from xml.sax.saxutils import escape

RAIZ = Path(__file__).resolve().parent.parent
SAIDA = Path(sys.argv[1]) if len(sys.argv) > 1 else RAIZ / "DaRocaAdventure.rbxlx"

# valores dos Enums usados no projeto (Roblox: DevTouchMovementMode.Scriptable = 5, DevComputerMovementMode.Scriptable = 3)
ENUMS = {"DevTouchMovementMode": {"Scriptable": 5}, "DevComputerMovementMode": {"Scriptable": 3}}

contador = 0


def ref():
    global contador
    contador += 1
    return f"RBX{contador:08X}"


def cdata(texto):
    return "<![CDATA[" + texto.replace("]]>", "]]]]><![CDATA[>") + "]]>"


def propriedade(nome, valor):
    if isinstance(valor, bool):
        return f'<bool name="{nome}">{"true" if valor else "false"}</bool>'
    if nome in ENUMS and isinstance(valor, str):
        return f'<token name="{nome}">{ENUMS[nome][valor]}</token>'
    if isinstance(valor, (int, float)):
        return f'<double name="{nome}">{valor}</double>'
    return f'<string name="{nome}">{escape(str(valor))}</string>'


def item(classe, nome, props="", filhos=""):
    return (f'<Item class="{classe}" referent="{ref()}"><Properties><string name="Name">{escape(nome)}</string>'
            f"{props}</Properties>{filhos}</Item>")


def script(caminho: Path):
    nome = caminho.name
    if nome.endswith(".server.lua"):
        classe, nome = "Script", nome[: -len(".server.lua")]
    elif nome.endswith(".client.lua"):
        classe, nome = "LocalScript", nome[: -len(".client.lua")]
    else:
        classe, nome = "ModuleScript", nome[: -len(".lua")]
    fonte = caminho.read_text(encoding="utf-8")
    return item(classe, nome, f'<ProtectedString name="Source">{cdata(fonte)}</ProtectedString>')


def pasta(caminho: Path, nome: str):
    filhos = []
    for f in sorted(caminho.iterdir()):
        if f.is_dir():
            filhos.append(pasta(f, f.name))
        elif f.suffix == ".lua":
            filhos.append(script(f))
    return item("Folder", nome, "", "".join(filhos))


VERSAO = os.environ.get("DAROCA_VERSAO", "local")


def no(nome, d):
    """Um nó do default.project.json."""
    caminho = d.get("$path")
    props = "".join(propriedade(k, v) for k, v in d.get("$properties", {}).items())
    filhos = "".join(no(k, v) for k, v in d.items() if not k.startswith("$"))
    if nome == "DaRoca":  # número da versão, mostrado na tela de carregamento
        filhos += item("StringValue", "Versao", f'<string name="Value">{escape(VERSAO)}</string>')
    if caminho:
        alvo = RAIZ / caminho
        if alvo.is_dir():
            return pasta(alvo, nome)
        x = script(alvo)
        # o nome no projeto manda (ex.: DaRocaServidor)
        return x.replace(f'<string name="Name">{escape(alvo.name.split(".")[0])}</string>', f'<string name="Name">{escape(nome)}</string>', 1)
    return item(d.get("$className", "Folder"), nome, props, filhos)


def main():
    projeto = json.loads((RAIZ / "default.project.json").read_text(encoding="utf-8"))
    arvore = projeto["tree"]
    corpo = "".join(no(k, v) for k, v in arvore.items() if not k.startswith("$"))
    xml = ('<roblox xmlns:xmime="http://www.w3.org/2005/05/xmlmime" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" '
           'xsi:noNamespaceSchemaLocation="http://www.roblox.com/roblox.xsd" version="4">'
           "<Meta name=\"ExplicitAutoJoints\">true</Meta>" + corpo + "</roblox>")
    SAIDA.write_text(xml, encoding="utf-8")
    print(f"{SAIDA} ({SAIDA.stat().st_size / 1e6:.1f} MB, {contador} objetos)")


if __name__ == "__main__":
    main()
