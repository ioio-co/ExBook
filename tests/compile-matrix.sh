#!/bin/bash
# ExBook 编译矩阵：对每种版式/选项组合编译示例文档，任一组合失败则以非零码退出。
#
# 用法（在仓库根目录执行）：
#   tests/compile-matrix.sh            # 仅编译（CI 用）
#   tests/compile-matrix.sh --render   # 编译并渲染 PNG 到 build/render/（需 pdftoppm）
#
# 渲染出的 PNG 可配合 tests/compare.py 做两个版本间的逐像素回归对比。
set -u
cd "$(dirname "$0")/.."
REPO=$PWD
RENDER=0
[[ "${1:-}" == "--render" ]] && RENDER=1
OUT="$REPO/build/render"
mkdir -p "$REPO/build" "$OUT"

# 版式 × 选项开关的组合，覆盖全部 6 种版式及深色/打印/水印/在线勘误/页脚标签/无编号
declare -A CONFIGS=(
  [compact]="compact"
  [standard]="standard"
  [loose]="loose"
  [single]="single"
  [padl]="padl"
  [padp]="padp"
  [padl-dark]="padl,darkmode"
  [padp-dark]="padp,darkmode"
  [standard-flags]="standard,printmode,water,showmark,online"
  [compact-notoc]="compact,notocnum"
  [padl-flags]="padl,online,water"
  [padp-flags]="padp,online,water"
  [padl-dark-flags]="padl,darkmode,online"
  [single-flags]="single,online,water"
)

fail=0

compile_one() { # $1 名称  $2 主文件内容来源(.tex)  $3 版式选项(空=不替换)
  local name=$1 src=$2 opts=$3
  local work; work=$(mktemp -d)
  cp -r "$REPO"/{config.tex,contents,fig,img,split-images} "$work/"
  cp "$REPO/ExBook.cls" "$work/"
  if [[ -n "$opts" ]]; then
    sed "s/documentclass\[[^]]*\]/documentclass[$opts]/" "$src" > "$work/main.tex"
  else
    cp "$src" "$work/main.tex"
  fi
  if ( cd "$work" && timeout 300 xelatex -interaction=nonstopmode -halt-on-error main.tex > c1.log 2>&1 \
                  && timeout 300 xelatex -interaction=nonstopmode -halt-on-error main.tex > c2.log 2>&1 ); then
    echo "$name: OK"
    if [[ $RENDER == 1 ]]; then
      pdftoppm -r 60 -png "$work/main.pdf" "$OUT/$name" 2>/dev/null
    fi
  else
    echo "$name: FAILED (workdir: $work)"
    ls -la "$work" || true
    for f in "$work/c1.log" "$work/c2.log" "$work/main.log" "$work/missfont.log"; do
      if [ -s "$f" ]; then
        echo "----- ${f##*/} (tail) -----"
        tail -50 "$f"
      fi
    done
    cp "$work"/c*.log "$REPO/build/" 2>/dev/null
    fail=1
  fi
  rm -rf "$work"
}

for name in compact standard loose single padl padp padl-dark padp-dark \
            standard-flags compact-notoc padl-flags padp-flags padl-dark-flags single-flags; do
  compile_one "$name" "$REPO/example_text_type.tex" "${CONFIGS[$name]}"
done
# 截图型示例按其自带版式编译
compile_one "imgtype" "$REPO/example_image_type.tex" ""

exit $fail
