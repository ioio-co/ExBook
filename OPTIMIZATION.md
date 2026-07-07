# ExBook 可优化点清单

> 基于 2026-07-07 重构后的代码（`ExBook.cls` 837 行）梳理。
> 优先级：🔴 建议优先处理（存在实际错误）｜🟡 值得做（可维护性/健壮性收益明显）｜🟢 可选（锦上添花）。

## 一、遗留 Bug

> ✅ 本节 1、2、3 已全部修复（见提交 "fix small bugs: textwater, qitems key defaults, comments"），以下保留原始分析备查。

### ~~🔴 1. `\textwater` 命令定义错误，会吞掉后续内容~~（已修复）
```latex
\newcommand{\textwater}{\def\ExBook@value@TextWater}   % 现状
```
`\textwater` 展开后是一个悬空的 `\def`，会把后面的命令当作参数分隔符吞掉。
官方示例 `example_text_type.tex` 第 5 题就踩中了：`\textwater` 后面紧跟
`\fourchoices{数据元素}...`，渲染结果中 **A–D 选项全部消失**，剩余选项文字被排成正文
（可在 PDF 第 2 页第 5 题验证）。正确定义应为：
```latex
\newcommand{\textwater}{\ExBook@value@TextWater}   % 输出行内文字水印
```
注意：修复后旧文档的渲染会变化（被吞掉的内容会重新出现），属于修 bug 的预期变化。

### ~~🔴 2. `qitems` 键默认值在两处定义且互相矛盾~~（已修复，顺带解决了第 13 条）
`\define@key{qitems}{optsuffix}[]`（写了键名但不给值 → 空）与环境内
`\ifx\@optsuffix\undefined \def\@optsuffix{.}`（不写键 → `.`）不一致，
`prefix`/`suffix`/`optprefix` 同理散落两处。建议在 `qitems` 环境开头统一
预置默认值，再让 `\setkeys` 覆盖，删掉全部 `\ifx...\undefined` 分支。

### ~~🟡 3. 注释与实现不符（复制残留）~~（已修复）
- `\onlinecheckurl`、`\noreftitle` 的注释写着“空白下划线”；
- `\randomtextwater` 注释说“生成 0 到 1 之间的随机数”，实际是 0–100，
  且默认参数 1 意味着 1% 概率，注释未说明。

## 二、瘦身（死代码与无用依赖）

### 🟡 4. 约 10 个宏包加载后从未使用
经逐包核查，以下宏包在 `ExBook.cls` 与示例文档中均无对应命令出现：
`afterpage`、`zhnumber`、`adjustbox`、`multicol`、`bm`、`romannum`、
`bbding`、`titling`、`caption`、`ifthen`（选择题重构后 `\ifthenelse` 已不再使用）。
另外 `fontspec`、`pgfmath`、`pgffor` 由 ctex/tikz 隐式加载，可以不显式列出；
`fontawesome5` 仅 `contents/print.tex` 在用，可下放到文档层。
删减后可加快编译、减少包冲突面（删前建议用编译矩阵回归一遍）。

### 🟡 5. `\@pageformat` 是死代码
六个 `\DeclareOption` 都给它赋值，但整个类中没有任何地方读取它，
版式分派完全依赖 `\myPageFormat`。二选一即可。

### 🟢 6. `\hideheaderfooter` 每次调用都重新定义 pagestyle
`\fancypagestyle{emptyheaderfooter}{...}` 应在类载入时定义一次，
命令本身只保留 `\thispagestyle{emptyheaderfooter}`。

## 三、结构与可维护性

### 🟡 7. `\myPageFormat` 魔法数字
版式用 0–5 编号 + `\ifcase` 分派，新增版式需要记住数字含义。
可改为具名判断（如 `\ifdefstring{\@pageformat}{padl}{...}{...}`，
正好能救活第 5 条的死代码），可读性更好。

### 🟡 8. 目录/章节样式仍有重复
`\if@notocnum` 两个分支里的 `\titlespacing`（section/subsection）完全相同，
`\titlecontents`/`\titleformat` 也只差“编号”一处，可以把公共部分提出、
编号部分参数化——手法与已完成的版式重构相同。

### 🟢 9. `\qanswerloc` 的深浅色 if/else
可像 `\exbook@lstbg` 一样收敛成一个颜色宏，顺带让深浅色文字颜色
（`white!61.8` / `themeColor`）在全类只定义一处。

### 🟢 10. hyperref 加载顺序
惯例是 hyperref 尽量最后加载，目前其后还有十几个包。当前能工作，
但这是 LaTeX 生态中最常见的“莫名其妙出问题”来源之一。

### 🟢 11. xkeyval → 内核键值
LaTeX 内核已内置键值支持（`\DeclareKeys`/l3keys），可去掉 xkeyval 依赖。
低优先级，现有方案没有实际问题。

## 四、健壮性

### 🟡 12. `\setmainfont{Times New Roman}` 硬编码
Linux 及部分精简 TeX 环境没有该字体，编译直接失败（本次重构在容器里
就需要手工造一份同名字体才能编译）。建议：
```latex
\IfFontExistsTF{Times New Roman}
    {\setmainfont{Times New Roman}}
    {\setmainfont{TeX Gyre Termes}}   % texlive 自带的 Times 替代
```

### ~~🟡 13. 选择题命令在 `qitems` 外使用时报错难懂~~（已随第 2 条修复）
`\@optprefix`/`\@optsuffix` 只在 `qitems` 环境内被赋默认值，
在环境外直接用 `\fourchoices` 会报“未定义控制序列”。给类级默认值
（与第 2 条一起处理）即可让它在任何位置可用。

### 🟢 14. `\setThemeColor` 未知主题名静默回退蓝色
建议加 `\ClassWarning{ExBook}{未知主题 '#1'，已回退为 blue}`，
拼错主题名时用户能从日志得到提示。

### 🟢 15. 封面坐标是绝对厘米值
`xshift=14cm`、`xshift=16.5cm` 等隐含了 A4/特定 Pad 纸张尺寸，
新增版式或改纸张就要逐个重调。改为 `\paperwidth`/`\paperheight`
的比例表达可让封面自适应（改动会有细微像素差，需回归对比）。

## 五、仓库工程化

### 🟡 16. 缺少 .gitignore，编译产物入库
`.DS_Store`、`*.synctex.gz`、约 3.8MB 的示例 PDF 都在版本库里。
建议添加 .gitignore（`*.aux *.log *.out *.toc *.synctex.gz .DS_Store` 等），
示例 PDF 移到 GitHub Releases 或文档站。

### 🟡 17. 没有任何自动化测试
本次重构使用的验证手段可以直接沉淀进仓库：
- 编译矩阵：6 版式 × 深色/打印/水印/在线勘误等开关，共 15 种组合；
- 逐像素回归：pdftoppm 渲染 + 与基线图像对比。
配一个 GitHub Actions workflow（texlive 容器）即可在每次 push 时自动
把关，杜绝再次出现 `\sixchoices` 那类“复制粘贴改坏了没人发现”的问题。

### 🟢 18. 版本信息未维护
`\fileversion{1.1}`/`\filedate{2025/1/15}` 长期未随修改更新，建议每次
发布 bump 版本并维护 CHANGELOG（本轮修复与重构值得记一版）。

### 🟢 19. README 未覆盖的公开命令
`\hideheaderfooter`、`\noreftitle`、`\randomtextwater`、`\eblankbox`、
`\autotitle`（新别名）、`\imgin` 的三个参数含义等均无文档。
另外 `\autotilte` 建议在 README 标注为“兼容旧拼写，推荐用 \autotitle”。

## 六、可选的现代化方向

### 🟢 20. 选择题核心迁移 expl3
现实现为经典 LaTeX2e 循环（`\@for` + `\appto`），可用且已验证；
迁移 l3seq/l3int 只是风格现代化，收益有限。

### 🟢 21. 打包发布
整理为 `.dtx` 文学式编程格式并发布 CTAN，Overleaf 用户可直接
`\documentclass{ExBook}` 而无需复制类文件。

### 🟢 22. 无障碍 PDF
`\DocumentMetadata` + tagged PDF 是 LaTeX 官方演进方向，刷题本场景
优先级不高，列此备忘。

---

## 建议的处理顺序

| 批次 | 条目 | 理由 |
|---|---|---|
| ~~第一批~~ | ~~1、2、3~~ | ✅ 已完成（13 也一并解决） |
| 第二批 | 16、17 | 一次投入，之后所有改动都有安全网 |
| 第三批 | 4、5、6、12 | 瘦身与健壮性，回归成本低 |
| 按需 | 其余 | 视维护意愿与时间 |
