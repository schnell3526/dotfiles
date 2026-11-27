#!/usr/bin/env bash
# docs/figures/*.js から同名の PNG を生成する。
#   ./render.sh                 全図
#   ./render.sh <name> ...      指定した図 (拡張子なし)
# 必要なもの: google-chrome (headless) / ネットワーク (rough.js と Klee One を CDN から取得)
set -euo pipefail

cd "$(dirname "$0")"
ROUGH_URL="https://cdn.jsdelivr.net/npm/roughjs@4.6.6/bundled/rough.js"
FONT_URL="https://fonts.googleapis.com/css2?family=Klee+One:wght@400;600&display=swap"
CHROME="${CHROME:-google-chrome}"

if [ "$#" -gt 0 ]; then
  names=("$@")
else
  names=()
  for f in *.js; do
    case "$f" in _*) continue ;; esac
    names+=("${f%.js}")
  done
fi

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

for name in "${names[@]}"; do
  # 先頭行の "// size: 900x330" から画像サイズを読む
  size="$(sed -n '1s#^// size: \([0-9]*x[0-9]*\)$#\1#p' "$name.js")"
  if [ -z "$size" ]; then
    echo "$name.js: 1 行目に '// size: <幅>x<高さ>' が必要" >&2
    exit 1
  fi
  w="${size%x*}"
  h="${size#*x}"

  cat > "$tmp/$name.html" <<HTML
<!doctype html>
<meta charset="utf-8">
<link rel="stylesheet" href="$FONT_URL">
<style>html,body{margin:0;background:#fff}svg{display:block}</style>
<body>
<script src="$ROUGH_URL"></script>
<script src="file://$PWD/_lib.js"></script>
<script src="file://$PWD/$name.js"></script>
</body>
HTML

  "$CHROME" --headless=new --no-sandbox --disable-gpu --hide-scrollbars \
    --allow-file-access-from-files \
    --force-device-scale-factor=2 --window-size="$w,$h" \
    --virtual-time-budget=10000 \
    --screenshot="$PWD/$name.png" "file://$tmp/$name.html" >/dev/null 2>&1
  echo "$name.png (${w}x${h} @2x)"
done
