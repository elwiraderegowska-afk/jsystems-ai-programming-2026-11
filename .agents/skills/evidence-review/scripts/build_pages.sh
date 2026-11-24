#!/usr/bin/env bash
# Build artifact fragments and standalone HTML pages (PL + EN) from one template.
# Usage: build_pages.sh <template.html> <fragment-dir> <standalone-dir> <slug> "<PL title>" "<EN title>"
# The template contains the placeholders __LANG__ and __TITLE__ and starts with <title>…<style>…</style>.
set -euo pipefail

template=$1 frag_dir=$2 out_dir=$3 slug=$4 title_pl=$5 title_en=$6
mkdir -p "$frag_dir" "$out_dir"

for lang in pl en; do
  title=$title_pl
  [ "$lang" = en ] && title=$title_en
  frag="$frag_dir/$slug.$lang.html"
  sed "s/__LANG__/$lang/; s|__TITLE__|$title|" "$template" > "$frag"

  {
    printf '<!doctype html>\n<html lang="%s">\n<head>\n<meta charset="utf-8">\n' "$lang"
    printf '<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">\n'
    printf '<style>:root{color-scheme:light;padding-top:env(safe-area-inset-top,0px);padding-bottom:env(safe-area-inset-bottom,0px)}body{margin:0}img{max-width:100%%}[hidden]{display:none!important}</style>\n'
    sed -n '1,/^<\/style>$/p' "$frag"
    printf '</head>\n<body>\n'
    sed '1,/^<\/style>$/d' "$frag"
    printf '</body>\n</html>\n'
  } > "$out_dir/$slug.$lang.html"
  echo "built $frag and $out_dir/$slug.$lang.html"
done
