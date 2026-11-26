#!/usr/bin/env bash
# Refaz dist/vendor/pixelfx.js com os efeitos de tools/pixelfx/efeitos.txt (pixelfx MIT, commit fixo).
set -euo pipefail
AQUI="$(cd "$(dirname "$0")" && pwd)"; RAIZ="$AQUI/../.."; TMP="$(mktemp -d)"
git clone -q https://github.com/patch-gg/pixelfx "$TMP/pixelfx" && git -C "$TMP/pixelfx" checkout -q 5294518
(cd "$TMP" && npm i --silent esbuild@0.25.10 >/dev/null)
python3 - "$TMP/pixelfx" "$AQUI/efeitos.txt" "$TMP/entrada.js" <<'PY'
import sys,os
px,lista,saida=sys.argv[1:4]; ids=open(lista).read().split()
L=['import * as core from "%s/src/core/index.js";'%px,'import { PAL } from "%s/src/core/color.js";'%px]; m=[]
for n,i in enumerate(ids): L.append('import * as f%d from "%s/src/fx/%s.js";'%(n,px,i)); m.append('"%s": f%d'%(i,n))
L.append('const FX = {%s};'%', '.join(m))
L.append('window.PixelFXLib = Object.freeze({ ...core, PAL, FX, ids: Object.keys(FX), versao: "pixelfx 0.3.1 · MIT · Copyright (c) 2026 Patch, Copyright (c) 2026 Hugo Duprez" });')
open(saida,'w').write('\n'.join(L))
PY
"$TMP/node_modules/.bin/esbuild" "$TMP/entrada.js" --bundle --format=iife --minify --legal-comments=none --outfile="$TMP/pixelfx.js"
{ echo "/*! pixelfx 0.3.1 — https://github.com/patch-gg/pixelfx — MIT License. Copyright (c) 2026 Patch. Copyright (c) 2026 Hugo Duprez. Partes adaptadas de Sprite Fusion (Hugo Duprez, MIT) e Hollow Crown (rehan-remade, MIT). Seleção empacotada para o Da Roça Adventure; veja vendor/pixelfx-LICENSE.txt. */"; cat "$TMP/pixelfx.js"; } > "$RAIZ/dist/vendor/pixelfx.js"
{ cat "$TMP/pixelfx/LICENSE"; echo; echo; cat "$TMP/pixelfx/NOTICE.md"; } > "$RAIZ/dist/vendor/pixelfx-LICENSE.txt"
echo "ok: $(wc -c < "$RAIZ/dist/vendor/pixelfx.js") bytes"; rm -rf "$TMP"
