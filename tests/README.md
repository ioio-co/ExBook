# ExBook 测试

## 编译矩阵

15 种「版式 × 选项开关」组合（6 种版式、深色模式、打印模式、水印、
在线勘误、页脚标签、无编号目录，外加截图型示例），任一组合编译失败即退出非零：

```bash
tests/compile-matrix.sh            # 仅编译（CI 每次 push 自动执行）
tests/compile-matrix.sh --render   # 编译并渲染 PNG 到 build/render/
```

依赖：texlive（xelatex、ctex、fandol 字体、tex-gyre）；`--render` 需要 poppler-utils。

## 像素级回归对比

修改 `ExBook.cls` 后，用渲染结果对比基线版本，确认改动没有意外影响排版：

```bash
# 1. 用基线版本（如 main）渲染
git worktree add /tmp/exbook-base main
(cd /tmp/exbook-base && tests/compile-matrix.sh --render)

# 2. 用当前工作区渲染
tests/compile-matrix.sh --render

# 3. 逐像素对比（需 pip install pillow）
python3 tests/compare.py /tmp/exbook-base/build/render build/render
```

判读标准：

- **逐像素一致**：改动无渲染影响；
- **最大通道差 ≤ 2 的少量像素**：渲染舍入噪声，可忽略；
- **其他差异**：逐页目视确认是否为预期改动。
