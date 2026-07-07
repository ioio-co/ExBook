#!/usr/bin/env python3
"""逐页像素对比两个渲染目录，报告每页差异像素数。

用法：
    python3 tests/compare.py <基线目录> <新版目录>

两个目录均为 tests/compile-matrix.sh --render 的输出（build/render/）。
典型流程——对比工作区与某个历史版本：
    git stash / 切到基线版本 → compile-matrix.sh --render → mv build/render /tmp/base
    切回新版 → compile-matrix.sh --render
    python3 tests/compare.py /tmp/base build/render

依赖：pip install pillow
"""
import sys, os
from PIL import Image, ImageChops

base, new = sys.argv[1], sys.argv[2]
bfiles = sorted(f for f in os.listdir(base) if f.endswith(".png"))
nfiles = sorted(f for f in os.listdir(new) if f.endswith(".png"))
if not bfiles or not nfiles:
    print(f"错误: 基线 {len(bfiles)} 张 / 新版 {len(nfiles)} 张 PNG，无法对比")
    sys.exit(2)
print(f"基线 {len(bfiles)} 张, 新版 {len(nfiles)} 张")

only_b = set(bfiles) - set(nfiles)
only_n = set(nfiles) - set(bfiles)
if only_b: print("仅基线有:", sorted(only_b))
if only_n: print("仅新版有:", sorted(only_n))

worst = []
for f in sorted(set(bfiles) & set(nfiles)):
    a = Image.open(os.path.join(base, f)).convert("RGB")
    b = Image.open(os.path.join(new, f)).convert("RGB")
    if a.size != b.size:
        print(f"{f}: 尺寸不同 {a.size} vs {b.size}")
        continue
    diff = ImageChops.difference(a, b)
    if diff.getbbox() is None:
        continue
    npix = sum(1 for p in diff.getdata() if p != (0, 0, 0))
    maxch = max(max(p) for p in diff.getdata())
    pct = 100.0 * npix / (a.size[0] * a.size[1])
    worst.append((npix, pct, maxch, f, diff.getbbox()))

worst.sort(reverse=True)
if not worst:
    print("所有页面逐像素一致 ✓")
else:
    print(f"{len(worst)} 页存在差异（最大通道差 ≤2 通常为渲染舍入噪声，可忽略）:")
    for npix, pct, maxch, f, bbox in worst:
        print(f"  {f}: {npix} px ({pct:.3f}%) 最大通道差={maxch} 区域={bbox}")
