\def\fileversion{1.1}
\def\filedate{2025/1/15}

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ExBook}[\filedate\space Version \fileversion\space by
 MA WEI JIAN]
 
 % adobe 使用adobe字体
 % ubuntu 使用ubuntu字体
 % windows 使用windows字体
 % fandol 使用fandol字体，随texlive默认安装
 % mac 使用mac字体

\newcommand\@fontset{fandol} 
\DeclareOption{adobe}{\renewcommand\@fontset{adobe}}
\DeclareOption{ubuntu}{\renewcommand\@fontset{ubuntu}}
\DeclareOption{mac}{\renewcommand\@fontset{mac}}
\DeclareOption{windows}{\renewcommand\@fontset{windows}}
\DeclareOption{fandol}{\renewcommand\@fontset{fandol}}

% 是否是打印模式
\newif\if@printmode  \@printmodefalse
\DeclareOption{printmode}{\@printmodetrue}

% 是否显示封面在线文档链接
\newif\if@online  \@onlinefalse
\DeclareOption{online}{\@onlinetrue}

%是否显示全局页面水印
\newif\if@water  \@waterfalse
\DeclareOption{water}{\@watertrue}

% 是否显示章节序号
\newif\if@notocnum  \@notocnumfalse
\DeclareOption{notocnum}{\@notocnumtrue}

% 是否启用深色模式
\newif\if@darkmode  \@darkmodefalse
\DeclareOption{darkmode}{\@darkmodetrue}

% 是否显示页脚标签
\newif\if@showmark  \@showmarkfalse
\DeclareOption{showmark}{\@showmarktrue}

% 版式名称（默认 standard），类末尾按名字派发到 \exbook@setup@<版式名>
\newcommand{\exbook@format}{standard}
\DeclareOption{compact}{\renewcommand{\exbook@format}{compact}}
\DeclareOption{standard}{\renewcommand{\exbook@format}{standard}}
\DeclareOption{padl}{\renewcommand{\exbook@format}{padl}}
\DeclareOption{loose}{\renewcommand{\exbook@format}{loose}}
\DeclareOption{single}{\renewcommand{\exbook@format}{single}}
\DeclareOption{padp}{\renewcommand{\exbook@format}{padp}}

% 加载基础类
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass{article}

%                    *****************************
%                    **        加载宏包       **
%                    *****************************
\RequirePackage[fontset = \@fontset, punct=kaiming,zihao=-4]{ctex}
\RequirePackage{tabularx} % 排选项用
\RequirePackage{xcolor,graphicx} % 彩色、图片
\RequirePackage{geometry,fancyhdr} % 纸张、边距、页眉、页脚
\RequirePackage{etoolbox} % \appto 等工具
\RequirePackage{amsmath,amssymb} % ams数学相关
\RequirePackage{fourier} % 数学字体
\RequirePackage{pifont} % 带圈数字\ding
\RequirePackage{enumitem} % 小问列表
\RequirePackage{listings} % 代码
\RequirePackage{tikz} % 绘图（封面、页眉、水印）
\RequirePackage{titletoc} % 目录
\RequirePackage{titlesec} % 标题
\RequirePackage{hyperref}
\RequirePackage{fontspec} % \setmainfont、\IfFontExistsTF
\RequirePackage{lastpage} % 页脚总页数
\RequirePackage{fontawesome5} % 图标（contents/ 模板页使用）
\RequirePackage{pgffor} % \foreach 循环
\RequirePackage{xkeyval} % qitems 键值参数
\RequirePackage{pgfmath} % \pgfmathsetmacro 随机数
\RequirePackage{truncate} % 页脚标签截断

\usetikzlibrary{fadings}
\usetikzlibrary{shapes, positioning}
\punctstyle{quanjiao} % 全角（主要是为了让中文逗号占满一个字符的宽度）
\ctexset{linestretch = 4, autoindent = 0pt}
\if@darkmode
    \hypersetup {colorlinks=true,linkcolor=white, urlcolor=white!61.8, citecolor=white!61.8}
\else
    \hypersetup {colorlinks=true,linkcolor=black, urlcolor=themeColor, citecolor=red}
\fi
% 全局英文字体：优先 Times New Roman，系统缺失时回退到
% TeX Gyre Termes（texlive 自带的 Times 兼容字体，Linux/CI 下可直接编译）。
% 回退先按字体名查找（fontconfig），再按文件名查找（kpathsea，
% 覆盖 tex-gyre 装在 texmf 树而 fontconfig 未收录的情况）
\IfFontExistsTF{Times New Roman}
    {\setmainfont{Times New Roman}}
    {\IfFontExistsTF{TeX Gyre Termes}
        {\setmainfont{TeX Gyre Termes}}
        {\setmainfont{texgyretermes}[
            Extension = .otf,
            UprightFont = *-regular,
            BoldFont = *-bold,
            ItalicFont = *-italic,
            BoldItalicFont = *-bolditalic]}}

\renewcommand\arraystretch{1.3}  % 表格行高（选择题选项间距）
\renewcommand{\baselinestretch}{1.3} % 设置行间距

%                         *****************
 %                         ** 主题颜色设置  **
 %                         *****************

% 主题色统一以 exbook@ 前缀注册，新增主题只需在此加一行 \definecolor
\definecolor{exbook@blue}{HTML}{015697}   % 经典·蓝
\definecolor{exbook@green}{HTML}{01847c}  % 经典·绿
\definecolor{exbook@purple}{HTML}{61589b} % 经典·紫
\definecolor{exbook@orange}{HTML}{EA4C0E} % 经典·橙
\definecolor{exbook@infj}{HTML}{3b4676}   % 个性·infj
\definecolor{exbook@enfp}{HTML}{d58a05}   % 个性·enfp
\definecolor{exbook@infp}{HTML}{3b6079}   % 个性·infp
\definecolor{exbook@esfp}{HTML}{d86b09}   % 个性·esfp
\definecolor{exbook@intj}{HTML}{38558f}   % 个性·intj
\definecolor{exbook@entp}{HTML}{8c2b2b}   % 个性·entp
\definecolor{exbook@isfj}{HTML}{4d417e}   % 个性·isfj
\definecolor{exbook@enfj}{HTML}{e15715}   % 个性·enfj

% 兼容旧配置的 \setThemeColor{\blue} 写法：这些宏展开为主题名字符串
\newcommand{\blue}{blue}
\newcommand{\green}{green}
\newcommand{\purple}{purple}
\newcommand{\orange}{orange}
\newcommand{\infj}{infj}
\newcommand{\enfp}{enfp}
\newcommand{\infp}{infp}
\newcommand{\esfp}{esfp}
\newcommand{\intj}{intj}
\newcommand{\entp}{entp}
\newcommand{\isfj}{isfj}
\newcommand{\enfj}{enfj}

% 切换主题：\setThemeColor{blue} 与 \setThemeColor{\blue} 均可，
% 按名字查找 exbook@<主题名>，未注册的主题名回退到蓝色
\newcommand{\setThemeColor}[1]{%
    \begingroup
    \edef\exbook@theme{#1}%
    \ifcsname\string\color@exbook@\exbook@theme\endcsname
        \edef\exbook@do{\endgroup\noexpand\colorlet{themeColor}{exbook@\exbook@theme}}%
    \else
        \def\exbook@do{\endgroup\colorlet{themeColor}{exbook@blue}}%
    \fi
    \exbook@do
}

% 默认主题（未调用 \setThemeColor 时也可直接编译）
\colorlet{themeColor}{exbook@blue}

\definecolor{bg}{HTML}{212121} % 自定义颜色 

% listings代码样式（深色模式下仅背景色不同）
\if@darkmode
    \def\exbook@lstbg{bg!61.8}
\else
    \def\exbook@lstbg{themeColor!6.2}
\fi
\lstset{
    language=C, % 设置默认语言
    breaklines=true, % 自动换行
    basicstyle=\ttfamily,
    backgroundcolor=\color{\exbook@lstbg},
    showspaces=false,
    showstringspaces=false,
    escapeinside={(*@}{@*)}, % 设置逃逸字符
}



% 封面设置
\def\ExBook@value@PreTitle{\textbf{ExBook · 刷题本模板}}
\def\ExBook@value@Title{\heiti 此处填写主标题}
\def\ExBook@value@TitleDescription{\textbf{此处填写副标题}}
\def\ExBook@value@TypeOne{\textbf{A4紧凑版}}
\def\ExBook@value@TypeTwo{\textbf{A4标准版}}
\def\ExBook@value@TypeThree{\textbf{横版Pad版}}
\def\ExBook@value@TypeFour{\textbf{A4宽松版}}
\def\ExBook@value@TypeFive{\textbf{A4单题版}}
\def\ExBook@value@TypeSix{\textbf{竖版Pad版}}
\def\ExBook@value@motto{\kaishu “心无旁骛，行稳致远。”}
\def\ExBook@value@Creator{\textbf{研小布}}
\def\ExBook@value@UpdateTime{\textbf{最后更新时间：\today}}

\def\ExBook@value@Lhead{微信公众号·研小布}
\def\ExBook@value@Chead{2025考研}
\def\ExBook@value@Rhead{408WD数据结构选择题刷题本}
\def\ExBook@value@LheadC{公众号·研小布·}
\def\ExBook@value@TextWater{\textcolor{black!38}{\selectfont【微信公众号·研小布】}}
\def\ExBook@value@waterImg{img/water.png}
\def\ExBook@value@coverImg{img/cov01.jpg}
\def\ExBook@value@onlineCheckUrl{https://github.com/ExBook/ExBook}

\newcommand\PreTitle[1]{\def\ExBook@value@PreTitle{\textbf{#1}}}
\newcommand\Title[1]{\def\ExBook@value@Title{\heiti \textbf{#1}}} 
\newcommand\TitleDescription[1]{\def\ExBook@value@TitleDescription{\textbf{#1}}}
\newcommand\TypeOne[1]{\def\ExBook@value@TypeOne{\textbf{#1}}}
\newcommand\TypeTwo[1]{\def\ExBook@value@TypeTwo{\textbf{#1}}}
\newcommand\TypeThree[1]{\def\ExBook@value@TypeThree{\textbf{#1}}}
\newcommand\TypeFour[1]{\def\ExBook@value@TypeFour{\textbf{#1}}}
\newcommand\TypeFive[1]{\def\ExBook@value@TypeFive{\textbf{#1}}}
\newcommand\TypeSix[1]{\def\ExBook@value@TypeSix{\textbf{#1}}}
\newcommand\motto[1]{\def\ExBook@value@motto{\kaishu “#1”}}
\newcommand\Creator[1]{\def\ExBook@value@Creator{\textbf{#1}}}
\newcommand\UpdateTime[1]{\def\ExBook@value@UpdateTime{\textbf{最后更新时间：#1}}}
\newcommand\Lhead[1]{\def\ExBook@value@Lhead{\textbf{#1}}}
\newcommand\Chead[1]{\def\ExBook@value@Chead{\textbf{#1}}}
\newcommand\Rhead[1]{\def\ExBook@value@Rhead{\textbf{#1}}}
\newcommand\LheadC[1]{\def\ExBook@value@LheadC{\textbf{#1}}}
\newcommand\TextWater[1]{\def\ExBook@value@TextWater{\textcolor{black!38}{\selectfont #1}}}
\newcommand{\textwater}{\ExBook@value@TextWater} % 输出行内文字水印
\newcommand\WaterImg[1]{\def\ExBook@value@waterImg{#1}}
\newcommand\CoverImg[1]{\def\ExBook@value@coverImg{#1}}
\newcommand\OnlineCheckUrl[1]{\def\ExBook@value@onlineCheckUrl{#1}}

\if@darkmode
    \newcommand{\qanswerloc}[1]{\textcolor{white!61.8}{\selectfont \ding{226} 此部分答案见原书P#1}}
\else
    \newcommand{\qanswerloc}[1]{\textcolor{themeColor}{\selectfont \ding{226} 此部分答案见原书P#1}}
\fi
\newcommand{\blankbox}{（\hspace{1.5em}）} % 中文空括号
\newcommand{\eblankbox}{(\hspace{1.5em})} % 英文空括号
\newcommand{\blankline}{\underline{\hspace{3em}}} % 空白下划线
\newcommand{\noreftitle}[1]{\par \textbf{#1} \par} % 无索引标题
\newcommand{\onlinecheckurl}{\ExBook@value@onlineCheckUrl} % 在线勘误文档地址

% 只隐藏当前页的页眉和页脚
\fancypagestyle{emptyheaderfooter}{\fancyhf{}}
\newcommand{\hideheaderfooter}{\thispagestyle{emptyheaderfooter}}

% 对齐方式选择：参数为空则居中，l 左对齐，r 右对齐，其他值居中
\newcommand{\exbook@align}[1]{%
    \ifx&#1&%
        \centering
    \else
        \ifx#1l%
            \raggedright
        \else
            \ifx#1r%
                \raggedleft
            \else
                \centering
            \fi
        \fi
    \fi
}

% 插入图片命令，参数1为缩放比例，参数2为对齐方式，参数3为图片路径
\newcommand{\imgin}[3][0.38]{
    \par
    \begin{minipage}[t]{1.0\textwidth}
        \exbook@align{#2}
        \includegraphics[scale=#1]{#3}
    \end{minipage}
}

% 自由标题：可选参数为对齐方式，参数2为标题，参数3为附加内容
\newcommand{\autotilte}[3][]{
    \par

    \exbook@align{#1}
    \begingroup \heiti{#2} \endgroup #3
    \par
}
% 拼写正确的别名（\autotilte 保留以兼容旧文档）
\newcommand{\autotitle}{\autotilte}

\newcommand{\insertimg}[5]{
    \foreach \n in {#1,...,#2} {
        \begin{bbox}
            \imgin[#3]{#4}{#5/\n.png}
        \end{bbox}
    }
}

% 按概率显示句子：可选参数为显示概率（百分比，默认 1 即 1%），参数 2 为句子内容
\newcommand{\randomtextwater}[2][1]{
    \pgfmathsetmacro{\randnum}{int(rnd*100)} % 生成一个 0 到 99 之间的随机整数
    \ifnum \randnum<#1
        #2 % 显示句子
    \fi
}

%                         ***********************
%                         **    版式公共构件    **
%                         ***********************

% 页面右下角图片水印，#1 为不透明度
\newcommand{\exbook@watermark}[1]{%
    \if@water
        \begin{tikzpicture}[overlay,remember picture]
            \node[anchor=east, opacity=#1] at ([xshift=-1.2cm, yshift=4.8cm]current page.south east)  {\includegraphics[width=0.16\textwidth]{\ExBook@value@waterImg}};
        \end{tikzpicture}%
    \fi
}

% 页眉页脚使用的章节标记
\newcommand{\exbook@setsectionmarks}{%
    \if@notocnum
        \renewcommand{\sectionmark}[1]{\markboth{##1}{}}%
        \renewcommand{\subsectionmark}[1]{\markright{##1}{}}%
    \else
        \renewcommand{\sectionmark}[1]{\markboth{\thesection ##1}{}}%
        \renewcommand{\subsectionmark}[1]{\markright{\thesubsection ##1}{}}%
    \fi
}

% ---------- A4 系版式（紧凑/标准/宽松/单题）共用 ----------

\newcommand{\exbook@afour@geometry}{%
    \if@printmode
        \geometry{a4paper, twoside, left=18mm, right=18mm, top=25mm, bottom=25mm, headsep=5mm, bindingoffset = 1cm}%
    \else
        \geometry{a4paper, left=18mm, right=18mm, top=25mm, bottom=25mm, headsep=5mm}%
    \fi
}

% A4 封面：#1 版式标识 #2 座右铭纵向偏移 #3 标识字号
\newcommand{\exbook@afour@cover}[3]{%
    \begin{titlepage}
        \begin{tikzpicture}[remember picture, overlay]
            \node[anchor=north, inner sep=0pt] at (current page.north) {\includegraphics[width=\paperwidth, height=\paperheight, keepaspectratio]{\ExBook@value@coverImg}};
            \fill[themeColor!6.2] ([yshift=2cm]current page.west) rectangle ++(\paperwidth,2cm);
            \node[anchor=west, align=left, text width=\textwidth, inner sep=0] at ([yshift=3cm, xshift=1.5cm]current page.west) {\color{themeColor} \fontsize{24pt}{0}{\ExBook@value@PreTitle}};
            \node[anchor=west, align=left, text width=\textwidth, inner sep=0] at ([yshift=0cm, xshift=1.5cm]current page.west) {\fontsize{36pt}{0}{\ExBook@value@Title}};
            \node[anchor=west, align=left, text width=\textwidth, inner sep=0] at ([yshift=-1.8cm, xshift=1.5cm]current page.west) {\fontsize{32pt}{0}{\ExBook@value@TitleDescription}};
            \fill[themeColor!6.2] (current page.south west) rectangle ++(\paperwidth,2cm);
            \node[anchor=south, align=center] at ([yshift=0.8cm]current page.south) {\color{themeColor}\fontsize{16pt}{0}{\ExBook@value@Creator}};
            \node[anchor=south, align=center] at ([yshift=0.2cm]current page.south) {\color{themeColor}\fontsize{12pt}{0}{\ExBook@value@UpdateTime}};
            \node[anchor=south, align=center] at ([yshift=#2]current page.south) {\color{themeColor}\fontsize{12pt}{0}{\ExBook@value@motto}};
            \fill[themeColor!6.2, rounded corners=16pt] ([yshift=4cm, xshift=14cm]current page.south west) rectangle ++(5cm,2cm);
            \node[anchor=south, align=center] at ([yshift=4.5cm, xshift=16.5cm]current page.south west) {\color{themeColor}\fontsize{#3}{0}#1};
            \if@online
                \node[anchor=south, align=center] at ([yshift=5.5cm, xshift=4.5cm]current page.south west) {\color{themeColor}\fontsize{14pt}{0}\textbf{\kaishu 遇到录入错误，可查看：}};
                \fill[themeColor!6.2, rounded corners=6pt] ([yshift=4.5cm, xshift=1.50cm]current page.south west) rectangle ++(7cm,1cm);
                \node[anchor=south, align=center] at ([yshift=4.5cm, xshift=5.2cm]current page.south west) {\color{themeColor}\fontsize{16pt}{0}\textbf{\href{\ExBook@value@onlineCheckUrl}{在线勘误文档（\underline{点击跳转}）}}};
            \fi
        \end{tikzpicture}
    \end{titlepage}%
}

% printmode 下在封面背面留一页空白
\newcommand{\exbook@printblankpage}{%
    \if@printmode
        \clearpage
        \null
        \thispagestyle{empty}
        \clearpage
    \fi
}

% A4 页眉页脚
\newcommand{\exbook@afour@headfoot}{%
    \pagestyle{fancy}%
    \fancyhf{}%
    \fancyhead[L]{\color{themeColor} \fontsize{10pt}{0}{\textbf{\ExBook@value@Lhead}}}%
    \fancyhead[C]{\color{themeColor} \fontsize{10pt}{0}{\textbf{\ExBook@value@Chead}} }%
    \fancyhead[R]{\color{themeColor} \fontsize{10pt}{0}{\textbf{\ExBook@value@Rhead}} }%
    \fancyfoot[C]{\color{themeColor}第 \thepage 页  / 共 \pageref{LastPage} 页 }%
    \if@showmark
        \fancyfoot[L]{\color{themeColor}\kaishu  \truncate{7cm}{\leftmark}}%
        \fancyfoot[R]{\color{themeColor}\kaishu  \truncate{7cm}{\rightmark}}%
        \exbook@setsectionmarks
    \fi
    \renewcommand{\headrulewidth}{0.4pt}%
    \renewcommand{\footrulewidth}{0pt}%
}

%                         *****************
%                         **   版式定义   **
%                         *****************

% 深色 / 浅色模式的差异集中在以下四个定义
\if@darkmode
    \tikzset{exbook@pad@dim/.style={opacity=0.382}}% 深色下色块整体减淡
    \def\exbook@pad@second{themeColor!61.8}% 次要色块颜色
    \def\exbook@pad@secondwd{0.217}% 页眉次要色块宽度（\paperwidth 的倍数）
    \def\exbook@pad@text{white!61.8}% 强调文字颜色
    \pagecolor{bg}% 页面背景颜色
    \color{white}% 全局文字颜色
\else
    \tikzset{exbook@pad@dim/.style={}}
    \def\exbook@pad@second{themeColor!6.2}
    \def\exbook@pad@secondwd{0.23}
    \def\exbook@pad@text{themeColor}
\fi

% Pad 版封面：#1 封面图位置 #2 副标题纵向偏移 #3 标识底框位置
%             #4 标识文字位置 #5 版式标识 #6 在线勘误区块
\newcommand{\exbook@padcover}[6]{%
\begin{titlepage}
    \begin{tikzpicture}[remember picture, overlay]
        \node[anchor=north, inner sep=0pt](image) at ([#1]current page.north west) {\includegraphics[width=\paperwidth, height=\paperheight, keepaspectratio]{\ExBook@value@coverImg}};

        \fill[fill=\exbook@pad@second, exbook@pad@dim] ([yshift=0cm]current page.west) rectangle ++(\paperwidth,2cm);
        \node[anchor=west, align=left, text width=\textwidth, inner sep=0] at ([yshift=1cm, xshift=1cm]current page.west) {\color{\exbook@pad@text} \fontsize{24pt}{0}{\textbf{\ExBook@value@PreTitle}}};
        \node[anchor=west, align=left, text width=\textwidth, inner sep=0] at ([yshift=-1cm, xshift=1cm]current page.west) {\fontsize{32pt}{0}{\textbf{\kaishu \ExBook@value@Title}}};
        \node[anchor=west, align=left, text width=\textwidth, inner sep=0] at ([yshift=#2, xshift=1cm]current page.west) {\fontsize{28pt}{0}{\textbf{\ExBook@value@TitleDescription}}};
        \fill[fill=\exbook@pad@second, exbook@pad@dim] (current page.south west) rectangle ++(\paperwidth,2cm);
        \node[anchor=south, align=center] at ([yshift=0.8cm]current page.south) {\color{\exbook@pad@text}\fontsize{16pt}{0}{\ExBook@value@Creator}};
        \node[anchor=south, align=center] at ([yshift=0.2cm]current page.south) {\color{\exbook@pad@text}\fontsize{12pt}{0}{\ExBook@value@UpdateTime}};

        \node[anchor=south, align=center] at ([yshift=2.4cm]current page.south) {\color{\exbook@pad@text}\fontsize{12pt}{0}{\ExBook@value@motto}};

        \fill[fill=\exbook@pad@second, exbook@pad@dim, rounded corners=12pt] ([#3]current page.south west) rectangle ++(3.5cm,1.5cm);
        \node[anchor=south, align=center] at ([#4]current page.south west) {\color{\exbook@pad@text}\fontsize{16pt}{0}\textbf{#5}};

        \if@online
            #6%
        \fi
    \end{tikzpicture}
\end{titlepage}%
}

% 页眉横条文字
\newcommand{\myrecttext}{\fontsize{14}{0} \textbf{\ExBook@value@LheadC \ExBook@value@Chead \ExBook@value@Rhead}}
\newcommand{\myrecttexttwo}{\fontsize{8pt}{0}{\textbf{  \kaishu  \truncate{4cm}{\leftmark}}}}
\newcommand{\myrecttextthree}{\fontsize{8pt}{0}{\textbf{ \kaishu \truncate{4cm}{\rightmark}}}}

% 页眉横条（含页码）
\newcommand{\exbook@padheader}{%
\begin{tikzpicture}[remember picture,overlay]
    \fill[fill=themeColor, exbook@pad@dim] (current page.north west) rectangle ++(0.668\paperwidth,-0.8cm);
    \node[anchor=north west, text width=\paperwidth, text height=0.4cm, align=left] at ([xshift=0.0em]current page.north west) {%
    \textcolor{white}{\myrecttext}
    };

    \fill[fill=\exbook@pad@second, exbook@pad@dim] ([xshift=-0.332\paperwidth]current page.north east) rectangle ++(\exbook@pad@secondwd\paperwidth,-0.8cm);
    \node[anchor=north west, text width=\paperwidth, text height=0.16cm, align=left, font=\bfseries] at ([xshift=0.66\paperwidth]current page.north west) {%
    \textcolor{\exbook@pad@text}{\myrecttexttwo}
    };
    \node[anchor=north west, text width=\paperwidth, text height=0.52cm, align=left, font=\bfseries] at ([xshift=0.66\paperwidth]current page.north west) {%
    \textcolor{\exbook@pad@text}{\myrecttextthree}
    };

    \fill[fill=themeColor, exbook@pad@dim] ([xshift=-0.115\paperwidth]current page.north east) rectangle ++(0.027\paperwidth,-0.8cm);
    \fill[fill=themeColor!60, exbook@pad@dim] ([xshift=-0.075\paperwidth]current page.north east) rectangle ++(0.027\paperwidth,-0.8cm);
    \fill[fill=themeColor!20, exbook@pad@dim] ([xshift=-0.024\paperwidth]current page.north east) rectangle ++(0.027\paperwidth,-0.8cm);

    \draw[line width=1.5pt, color=themeColor] (current page.north west) ++(0,-0.8cm) -- ++(\paperwidth,0);

    \node[anchor=east, text height=1.2cm, font=\small] at ([xshift=-8.5cm, yshift=1.5cm]current page.south east) {\color{\exbook@pad@text}  第 \thepage 页  / 共 \pageref{LastPage} 页};
\end{tikzpicture}%
}


% ---------- 各版式的执行部分 ----------
% 每个版式一个 \exbook@setup@<版式名> 宏，类末尾按名字派发；
% 新增版式 = 新增一个 setup 宏并在文件开头声明同名选项。

% A4 系（紧凑/标准/宽松/单题）共用
\newcommand{\exbook@setup@afour}{%
    \exbook@afour@geometry
    \exbook@afour@headfoot
}

% Pad 系（横版/竖版）共用
\newcommand{\exbook@setup@pad}{%
    \if@darkmode
        \pagecolor{bg}% 页面背景颜色
        \color{white}% 全局文字颜色
    \fi
    \pagestyle{fancy}
    \fancyhf{}
    \renewcommand{\headrulewidth}{0pt}% 移除页眉底部的横线
    \renewcommand{\footrulewidth}{0pt}
    \exbook@setsectionmarks
    \chead{\exbook@padheader}
    \newenvironment{bbox}
    {
        \begingroup
    }
    {
        \endgroup
        \exbook@watermark{0.08}
        \newpage % 在环境结束时插入新页面
    }
}

% A4紧凑版：题目间无空隙
\newcommand{\exbook@setup@compact}{%
    \exbook@setup@afour
    \renewcommand{\maketitle}{\exbook@afour@cover{\ExBook@value@TypeOne}{2.5cm}{22pt}\exbook@printblankpage}
    \newenvironment{bbox}
    {

    }
    {
    \exbook@watermark{0.01}
    }
}

% A4标准版：题目不跨页，题目后留 2.5cm
\newcommand{\exbook@setup@standard}{%
    \exbook@setup@afour
    \renewcommand{\maketitle}{\exbook@afour@cover{\ExBook@value@TypeTwo}{3cm}{24pt}\exbook@printblankpage}
    \newenvironment{bbox}
    {
    \begin{minipage}{\textwidth}
    }
    {

    \vspace*{2.5cm}
    \end{minipage}

    \exbook@watermark{0.02}
    }
}

% A4宽松版：题目不跨页，题目后留 7.5cm
\newcommand{\exbook@setup@loose}{%
    \exbook@setup@afour
    \renewcommand{\maketitle}{\exbook@afour@cover{\ExBook@value@TypeFour}{3cm}{24pt}}
    \newenvironment{bbox}
    {
        \begingroup
        \begin{minipage}{\textwidth}
    }
    {
        \vspace*{7.5cm}
        \end{minipage}
        \exbook@watermark{0.02}
        \endgroup
    }
}

% A4单题版：一页一题
\newcommand{\exbook@setup@single}{%
    \exbook@setup@afour
    \renewcommand{\maketitle}{\exbook@afour@cover{\ExBook@value@TypeFive}{3cm}{24pt}}
    \newenvironment{bbox}
    {
        \begingroup
    }
    {
        \exbook@watermark{0.02}
        \endgroup
        \newpage % 在环境结束时插入新页面
    }
}

% 横版Pad
\newcommand{\exbook@setup@padl}{%
    \exbook@setup@pad
    \geometry{paperheight=150mm, paperwidth=200mm,left=12mm,right=12mm,top=10mm,bottom=15mm}
    \renewcommand{\maketitle}{%
        \exbook@padcover{xshift=10cm, yshift=5cm}{-2.5cm}%
            {yshift=2.5cm, xshift=15.5cm}{yshift=2.8cm, xshift=17.3cm}%
            {\ExBook@value@TypeThree}{%
            \node[anchor=south, align=center] at ([yshift=1.0cm, xshift=3.25cm]current page.south west) {\color{\exbook@pad@text}\fontsize{10pt}{0}\textbf{\kaishu 遇到录入错误，可查看：}};
            \node[anchor=south, align=center] at ([yshift=0.35cm, xshift=3.4cm]current page.south west) {\color{\exbook@pad@text}\fontsize{10pt}{0}\textbf{\href{\ExBook@value@onlineCheckUrl}{在线勘误文档（\underline{点击跳转}）}}};
            }%
    }
}

% 竖版Pad
\newcommand{\exbook@setup@padp}{%
    \exbook@setup@pad
    \geometry{paperheight=250mm, paperwidth=200mm,left=12mm,right=12mm,top=10mm,bottom=15mm}
    \renewcommand{\maketitle}{%
        \exbook@padcover{xshift=10cm, yshift=0cm}{-2.8cm}%
            {yshift=3.5cm, xshift=15.0cm}{yshift=3.8cm, xshift=16.8cm}%
            {\ExBook@value@TypeSix}{%
            \node[anchor=south, align=center] at ([yshift=5.5cm, xshift=3.8cm]current page.south west) {\color{\exbook@pad@text}\fontsize{14pt}{0}\textbf{\kaishu 遇到录入错误，可查看：}};
            \fill[fill=\exbook@pad@second, exbook@pad@dim, rounded corners=6pt] ([yshift=4.5cm, xshift=0.80cm]current page.south west) rectangle ++(7cm,1cm);
            \node[anchor=south, align=center] at ([yshift=4.5cm, xshift=4.5cm]current page.south west) {\color{\exbook@pad@text}\fontsize{16pt}{0}\textbf{\href{\ExBook@value@onlineCheckUrl}{在线勘误文档（\underline{点击跳转}）}}};
            }%
    }
}

% 按版式名派发
\csname exbook@setup@\exbook@format\endcsname

%                         *****************
%                         **   题目相关   **
%                         *****************
\newcounter{QuestionCounter}

\newif\if@resetcounter
\newif\if@showcounter

\@resetcountertrue 
\@showcountertrue   

\define@key{qitems}{unreset}[true]{\@resetcounterfalse}
\define@key{qitems}{unshow}[true]{\@showcounterfalse}
\define@key{qitems}{prefix}[]{\def\@prefix{#1}}
\define@key{qitems}{suffix}[.]{\def\@suffix{#1}}
\define@key{qitems}{optprefix}[]{\def\@optprefix{#1}}
\define@key{qitems}{optsuffix}[.]{\def\@optsuffix{#1}}
\define@key{qitems}{startnum}[0]{\def\@startnum{#1}}

% 各键的默认值只在这里定义一处；类级默认值也让选择题命令在 qitems 外可用
\def\@prefix{}
\def\@suffix{.}
\def\@optprefix{}
\def\@optsuffix{.}
\def\@startnum{} % 空表示沿用当前题号

% 定义题目环境
\newenvironment{qitems}[1][]{
    \begingroup
    \setkeys{qitems}{#1} % 解析传入的键值对

    \if@resetcounter
        \setcounter{QuestionCounter}{0}
    \fi

    \ifdefvoid{\@startnum}{}{%
        \setcounter{QuestionCounter}{\@startnum}%
        \addtocounter{QuestionCounter}{-1}}

	\par \begingroup \par
}{
	\par \endgroup \par
    \endgroup
    \clearpage
}

% 定义题目命令 
\NewDocumentCommand{\qitem}{O{} O{}}{
	\stepcounter{QuestionCounter}
    \vspace{2mm} 
    \if@showcounter
        #1\@prefix\arabic{QuestionCounter}\@suffix#2
    \else
        #1\@prefix\@suffix#2
    \fi
}



% 定义小问环境
\newlist{subqitems}{enumerate}{2}
\setlist[subqitems,1]{label=(\arabic*)}
\setlist[subqitems,2]{label=(\roman*)}

% 定义新增小问命令
\newcommand{\subqitem}{\item} 

% 选择题选项自动排版（参考了 BHCexam.cls 的实现）：
% 测量最宽选项后按每行 1 / 2 / 4 个自动布局。
% \choices{{选项1},{选项2},...} 支持任意数量的选项（选项内含逗号时需用花括号包裹），
% \threechoices ~ \sixchoices 为固定数量选项的便捷写法。

\newcounter{exbook@choiceidx}
\newlength{\exbook@choicewd}
\newlength{\exbook@choicemax}
\newcount\exbook@choicecol

% 单个选项单元格：#1 选项字母 #2 选项内容
\newcommand{\exbook@choicecell}[2]{\@optprefix #1\@optsuffix~#2~~~}

% 把当前选项追加到表体：先展开选项内容，再展开选项字母
\newcommand{\exbook@choiceadd}{\expandafter\exbook@choiceadd@a\expandafter{\exbook@opt}}
\newcommand{\exbook@choiceadd@a}[1]{\expandafter\exbook@choiceadd@b\expandafter{\exbook@lbl}{#1}}
\newcommand{\exbook@choiceadd@b}[2]{\appto\exbook@choicebody{\exbook@choicecell{#1}{#2}}}

% 排版核心：#1 为逗号分隔的选项列表
\newcommand{\exbook@choices}[1]{%
    \par
    % 第一遍循环：测量最宽的选项
    \setlength{\exbook@choicemax}{0pt}%
    \setcounter{exbook@choiceidx}{0}%
    \@for\exbook@opt:=#1\do{%
        \stepcounter{exbook@choiceidx}%
        \settowidth{\exbook@choicewd}{\exbook@choicecell{\Alph{exbook@choiceidx}}{\exbook@opt}}%
        \ifdim\exbook@choicewd>\exbook@choicemax
            \setlength{\exbook@choicemax}{\exbook@choicewd}%
        \fi}%
    % 根据最宽选项决定每行选项数
    \ifdim\exbook@choicemax>0.4\linewidth
        \def\exbook@percol{1}%
    \else\ifdim\exbook@choicemax>0.2\linewidth
        \def\exbook@percol{2}%
    \else
        \def\exbook@percol{4}%
    \fi\fi
    % 第二遍循环：构造表格内容
    \def\exbook@choicebody{}%
    \setcounter{exbook@choiceidx}{0}%
    \exbook@choicecol=0\relax
    \@for\exbook@opt:=#1\do{%
        \stepcounter{exbook@choiceidx}%
        \edef\exbook@lbl{\Alph{exbook@choiceidx}}%
        \exbook@choiceadd
        \advance\exbook@choicecol\@ne
        \ifnum\exbook@choicecol=\exbook@percol\relax
            \appto\exbook@choicebody{\\}%
            \exbook@choicecol=0\relax
        \else
            \appto\exbook@choicebody{&}%
        \fi}%
    \ifnum\exbook@choicecol>0
        \appto\exbook@choicebody{\\}%
    \fi
    % 输出表格
    \ifcase\exbook@percol\relax\or
        \begin{tabularx}{\linewidth}{X}\exbook@choicebody\end{tabularx}\or
        \begin{tabularx}{\linewidth}{XX}\exbook@choicebody\end{tabularx}\or\or
        \begin{tabularx}{\linewidth}{XXXX}\exbook@choicebody\end{tabularx}\fi
    \unskip \unskip
}

% 任意数量选项
\newcommand{\choices}[1]{\exbook@choices{#1}}

% 固定数量选项
\newcommand{\threechoices}[3]{\exbook@choices{{#1},{#2},{#3}}}
\newcommand{\fourchoices}[4]{\exbook@choices{{#1},{#2},{#3},{#4}}}
\newcommand{\fivechoices}[5]{\exbook@choices{{#1},{#2},{#3},{#4},{#5}}}
\newcommand{\sixchoices}[6]{\exbook@choices{{#1},{#2},{#3},{#4},{#5},{#6}}}

%                         *************************
%                         **   章节标题与目录显示   **
%                         *************************

% 有无章节编号（notocnum 选项）只差“编号”部分，差异集中在以下几个宏
\if@notocnum
    \def\exbook@toc@seclabel{}
    \def\exbook@toc@sublabel{}
    \def\exbook@sec@size{\fontsize{13pt}{0}}
    \def\exbook@sec@label{}
    \def\exbook@sec@sep{0em}
    \def\exbook@subsec@label{}
    \def\exbook@subsec@sep{0em}
\else
    \def\exbook@toc@seclabel{第\thecontentslabel\ 章\hspace{1em}}
    \def\exbook@toc@sublabel{\thecontentslabel \hspace{1em}}
    \def\exbook@sec@size{\normalsize}
    \def\exbook@sec@label{第\thesection 章}
    \def\exbook@sec@sep{1em}
    \def\exbook@subsec@label{\thesubsection}
    \def\exbook@subsec@sep{0.6em}
\fi

% 目录条目样式
\titlecontents{section}[0em]
{\heiti}
{\exbook@toc@seclabel}
{}
{\titlerule*[0.4pc]{.}\contentspage}

\titlecontents{subsection}[2em]
{}
{\exbook@toc@sublabel}
{}
{\titlerule*[0.4pc]{.}\contentspage}

\titlecontents{subsubsection}[4em]
{}
{\exbook@toc@sublabel}
{}
{\titlerule*[0.4pc]{.}\contentspage}

% 标题间距
\titlespacing{\section}
{0pt} % 左边距
{2pt plus 2pt minus 2pt} % 上边距
{4pt plus 2pt minus 2pt} % 下边距

\titlespacing{\subsection}
{0pt} % 左边距
{2pt plus 2pt minus 2pt} % 上边距
{2pt plus 2pt minus 2pt} % 下边距

% 标题样式：每个 section 另起一页、居中
\titleformat{\section}[block]
{\newpage \centering\heiti\exbook@sec@size}
{\exbook@sec@label}
{\exbook@sec@sep}
{}

\titleformat{\subsection}
{\normalfont\normalsize\bfseries}
{\exbook@subsec@label}
{\exbook@subsec@sep}
{}

% 无编号模式下 subsubsection 也做同样处理（有编号模式沿用默认样式）
\if@notocnum
    \titlespacing{\subsubsection}
    {0pt}
    {2pt plus 2pt minus 2pt}
    {2pt plus 2pt minus 2pt}

    \titleformat{\subsubsection}
    {\normalfont\normalsize\bfseries}
    {}
    {0em}
    {}
\fi

\AtBeginDocument{
	\pagenumbering{arabic}  % 使用阿拉伯数字页码
}

\endinput
