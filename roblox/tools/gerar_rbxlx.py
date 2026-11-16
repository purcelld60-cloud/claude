#!/usr/bin/env python3
"""Gera roblox/DaRocaAdventure.rbxlx a partir dos scripts em roblox/src.

O arquivo .rbxlx abre direto no Roblox Studio (Arquivo > Abrir). Rode de novo
sempre que mudar um script:  python3 roblox/tools/gerar_rbxlx.py
"""
from pathlib import Path
from xml.sax.saxutils import escape

RAIZ = Path(__file__).resolve().parent.parent
SCRIPTS = {
    "ServerScriptService": [("Script", "Mundo", "src/server/Mundo.server.lua"),
                            ("Script", "Combate", "src/server/Combate.server.lua")],
    "StarterPlayerScripts": [("LocalScript", "Cliente", "src/client/Cliente.client.lua")],
}
ref = 0


def novo_ref():
    global ref
    ref += 1
    return f"RBX{ref:08X}"


def item_script(classe, nome, caminho):
    fonte = (RAIZ / caminho).read_text(encoding="utf-8")
    if "]]>" in fonte:
        raise SystemExit(f"{caminho} contém ']]>', que quebra o CDATA")
    return (f'<Item class="{classe}" referent="{novo_ref()}"><Properties>'
            f'<string name="Name">{escape(nome)}</string>'
            f'<bool name="Disabled">false</bool>'
            f'<ProtectedString name="Source"><![CDATA[{fonte}]]></ProtectedString>'
            f'</Properties></Item>')


def servico(classe, filhos):
    return (f'<Item class="{classe}" referent="{novo_ref()}"><Properties>'
            f'<string name="Name">{classe}</string></Properties>{filhos}</Item>')


sss = servico("ServerScriptService", "".join(item_script(*s) for s in SCRIPTS["ServerScriptService"]))
sps = servico("StarterPlayerScripts", "".join(item_script(*s) for s in SCRIPTS["StarterPlayerScripts"]))
starter = servico("StarterPlayer", sps)
xml = ('<roblox xmlns:xmime="http://www.w3.org/2005/05/xmlmime" '
       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" '
       'xsi:noNamespaceSchemaLocation="http://www.roblox.com/roblox.xsd" version="4">'
       f'{sss}{starter}</roblox>\n')
saida = RAIZ / "DaRocaAdventure.rbxlx"
saida.write_text(xml, encoding="utf-8")
print(f"gerado {saida} ({len(xml)//1024} KB)")
