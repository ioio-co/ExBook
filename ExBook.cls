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

% 定义默认页面格式
\def\@pageformat{standard}
\newcommand{\myPageFormat}{1}

% 定义选项，每个选项对应一个字符串值，并设置 \myPageFormat 的值
\DeclareOption{compact}{\def\@pageformat{compact}\def\myPageFormat{0}}  
\DeclareOption{standard}{\def\@pageformat{standard}\def\myPageFormat{1}} 
\DeclareOption{padl}{\def\@pageformat{padl}\def\myPageFormat{2}}  
\DeclareOption{loose}{\def\@pageformat{loose}\def\myPageFormat{3}}  
\DeclareOption{single}{\def\@pageformat{single}\def\myPageFormat{4}}  
\DeclareOption{padp}{\def\@pageformat{padp}\def\myPageFormat{5}}  

% 加载基础类
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass{article}

%                    *****************************
%                    **        加载宏包       **
%                    *****************************
\RequirePackage[fontset = \@fontset, punct=kaiming,zihao=-4]{ctex}
\RequirePackage{tabularx, ifthen} % 排选项用
\RequirePackage{xcolor,graphicx,caption} % 彩色、图片、图释
\RequirePackage{geometry,fancyhdr} % 纸张、边距、页眉、页脚
\RequirePackage{etoolbox} 
\RequirePackage{amsmath,amssymb} % ams数学相关
\RequirePackage{fourier}
% \RequirePackage{mathpazo}
% \RequirePackage{mathptmx}
% \RequirePackage{unicode-math}
\RequirePackage{pifont} % 带圈数字\ding
\RequirePackage{bbding} % 图案
\RequirePackage{romannum} % 罗马数字
\RequirePackage{enumitem}
\RequirePackage{listings} % 代码
\RequirePackage{tikz} % 绘图
\RequirePackage{titletoc} % 目录
\RequirePackage{titlesec} % 标题
\RequirePackage{hyperref}
\RequirePackage{afterpage} 
\RequirePackage{zhnumber}
\RequirePackage{fontspec}
\RequirePackage{lastpage}
\RequirePackage{titling}
\RequirePackage{adjustbox}
\RequirePackage{fontawesome5}
\RequirePackage{multicol}
\RequirePackage{bm}
\RequirePackage{pgffor}    % 用于循环
\RequirePackage{xkeyval}
\RequirePackage{pgfmath} % 导入随机数生成包
\RequirePackage{truncate}

\usetikzlibrary{fadings}
\usetikzlibrary{shapes, positioning}
\punctstyle{quanjiao} % 全角（主要是为了让中文逗号占满一个字符的宽度）
\ctexset{linestretch = 4, autoindent = 0pt}
\if@darkmode
    \hypersetup {colorlinks=true,linkcolor=white, urlcolor=white!61.8, citecolor=white!61.8}
\else
    \hypersetup {colorlinks=true,linkcolor=black, urlcolor=themeColor, citecolor=red}
\fi
\setmainfont{Times New Roman} % 设置全局英文字体为 Times New Roman

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
\newcommand{\textwater}{\def\ExBook@value@TextWater}
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
\newcommand{\onlinecheckurl}{\ExBook@value@onlineCheckUrl} % 空白下划线

% 定义一个只隐藏当前页的页眉和页脚的命令
\newcommand{\hideheaderfooter}{
  \fancypagestyle{emptyheaderfooter}{
    \fancyhf{}  % 清空页眉和页脚
  }
  \thispagestyle{emptyheaderfooter}
}

% 插入图片命令，参数1为缩放比例，参数2为对齐方式，参数3为图片路径，
\newcommand{\imgin}[3][0.38]{ % 默认缩放比例为 1.0
    \par
    \begin{minipage}[t]{1.0\textwidth}
        \ifx&#2& % 判断是否有对齐参数
            \centering
        \else
            \ifx#2l % 左对齐
                \raggedright
            \else
                \ifx#2r % 右对齐
                    \raggedleft
                \else % 默认居中
                    \centering
                \fi
            \fi
        \fi
        \includegraphics[scale=#1]{#3} 
    \end{minipage}
}

\newcommand{\autotilte}[3][]{
    \par

    \ifx&#1& % 判断是否有对齐参数
        \centering
    \else
        \ifx#1l % 左对齐
            \raggedright
        \else
            \ifx#1r % 右对齐
                \raggedleft
            \else % 默认居中
                \centering
            \fi
        \fi
    \fi
    \begingroup \heiti{#2} \endgroup #3
    \par
}

\newcommand{\insertimg}[5]{
    \foreach \n in {#1,...,#2} {
        \begin{bbox}
            \imgin[#3]{#4}{#5/\n.png}
        \end{bbox}
    }
}

% 定义一个命令，按照一定概率显示句子
\newcommand{\randomtextwater}[2][1]{
    \pgfmathsetmacro{\randnum}{int(rnd*100)} % 生成一个 0 到 1 之间的随机数
    \ifnum \randnum<#1 
        #2 % 显示句子
    \fi 
}

\ifcase\myPageFormat
 %                         *****************
 %                         **   A4紧凑版   **
 %                         *****************
    \if@printmode
        \geometry{a4paper, twoside, left=18mm, right=18mm, top=25mm, bottom=25mm, headsep=5mm, bindingoffset = 1cm}
    \else
        \geometry{a4paper, left=18mm, right=18mm, top=25mm, bottom=25mm, headsep=5mm}   
    \fi

    % 自定义封面样式
    \renewcommand{\maketitle}{
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
            \node[anchor=south, align=center] at ([yshift=2.5cm]current page.south) {\color{themeColor}\fontsize{12pt}{0}{\ExBook@value@motto}};
            \fill[themeColor!6.2, rounded corners=16pt] ([yshift=4cm, xshift=14cm]current page.south west) rectangle ++(5cm,2cm);
            \node[anchor=south, align=center] at ([yshift=4.5cm, xshift=16.5cm]current page.south west) {\color{themeColor}\fontsize{22pt}{0}\ExBook@value@TypeOne};
            
            \if@online
                \node[anchor=south, align=center] at ([yshift=5.5cm, xshift=4.5cm]current page.south west) {\color{themeColor}\fontsize{14pt}{0}\textbf{\kaishu 遇到录入错误，可查看：}};
                \fill[themeColor!6.2, rounded corners=6pt] ([yshift=4.5cm, xshift=1.50cm]current page.south west) rectangle ++(7cm,1cm);
                \node[anchor=south, align=center] at ([yshift=4.5cm, xshift=5.2cm]current page.south west) {\color{themeColor}\fontsize{16pt}{0}\textbf{\href{\ExBook@value@onlineCheckUrl}{在线勘误文档（\underline{点击跳转}）}}};
            \fi
        \end{tikzpicture}
    \end{titlepage}

    \if@printmode
        \clearpage
        \null
        \thispagestyle{empty}
        \clearpage
    \fi
    }

    % 启用自定义页眉
    \pagestyle{fancy}
    
    % 清除当前的页眉和页脚设置
    \fancyhf{}

    % 设置页眉内容
    \fancyhead[L]{\color{themeColor} \fontsize{10pt}{0}{\textbf{\ExBook@value@Lhead}}}
    \fancyhead[C]{\color{themeColor} \fontsize{10pt}{0}{\textbf{\ExBook@value@Chead}} }
    \fancyhead[R]{\color{themeColor} \fontsize{10pt}{0}{\textbf{\ExBook@value@Rhead}} }

    % 设置页码位置
    \fancyfoot[C]{\color{themeColor} 第 \thepage 页  / 共 \pageref{LastPage} 页}
    \if@showmark
        \fancyfoot[L]{\color{themeColor}\kaishu  \truncate{7cm}{\leftmark}}
        \fancyfoot[R]{\color{themeColor}\kaishu  \truncate{7cm}{\rightmark}}
        \if@notocnum
            \renewcommand{\sectionmark}[1]{\markboth{#1}{}}
            \renewcommand{\subsectionmark}[1]{\markright{#1}{}}
        \else
            \renewcommand{\sectionmark}[1]{\markboth{\thesection #1}{}}
            \renewcommand{\subsectionmark}[1]{\markright{\thesubsection #1}{}}
        \fi
    \fi

    % 设置分隔线
    \renewcommand{\headrulewidth}{0.4pt}
    \renewcommand{\footrulewidth}{0pt}

    % 创建单个题目环境
    \newenvironment{bbox}
    {

    }
    {
    \if@water
        \begin{tikzpicture}[overlay,remember picture]
            \node[anchor=east, opacity=0.01,] at ([xshift=-1.2cm, yshift=4.8cm]current page.south east)  {\includegraphics[width=0.16\textwidth]{\ExBook@value@waterImg}}; 
        \end{tikzpicture}
    \fi
    }
    
\or
 %                         *****************
 %                         **   A4标准版   **
 %                         *****************
    \if@printmode
    \geometry{a4paper, twoside, left=18mm, right=18mm, top=25mm, bottom=25mm, headsep=5mm, bindingoffset = 1cm}
    \else
        \geometry{a4paper, left=18mm, right=18mm, top=25mm, bottom=25mm, headsep=5mm}   
    \fi

    % 自定义封面样式
    \renewcommand{\maketitle}{
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
            \node[anchor=south, align=center] at ([yshift=3cm]current page.south) {\color{themeColor}\fontsize{12pt}{0}{\ExBook@value@motto}};
            \fill[themeColor!6.2, rounded corners=16pt] ([yshift=4cm, xshift=14cm]current page.south west) rectangle ++(5cm,2cm);
            \node[anchor=south, align=center] at ([yshift=4.5cm, xshift=16.5cm]current page.south west) {\color{themeColor}\fontsize{24pt}{0}\ExBook@value@TypeTwo};
            \if@online
                \node[anchor=south, align=center] at ([yshift=5.5cm, xshift=4.5cm]current page.south west) {\color{themeColor}\fontsize{14pt}{0}\textbf{\kaishu 遇到录入错误，可查看：}};
                \fill[themeColor!6.2, rounded corners=6pt] ([yshift=4.5cm, xshift=1.50cm]current page.south west) rectangle ++(7cm,1cm);
                \node[anchor=south, align=center] at ([yshift=4.5cm, xshift=5.2cm]current page.south west) {\color{themeColor}\fontsize{16pt}{0}\textbf{\href{\ExBook@value@onlineCheckUrl}{在线勘误文档（\underline{点击跳转}）}}};
            \fi
        \end{tikzpicture}
    \end{titlepage}
    \if@printmode
        \clearpage
        \null
        \thispagestyle{empty}
        \clearpage
    \fi
    }

    \pagestyle{fancy} % 启用自定义页眉

    % 清除当前的页眉和页脚设置
    \fancyhf{}

    % 设置页眉内容
    \fancyhead[L]{\color{themeColor} \fontsize{10pt}{0}{\textbf{\ExBook@value@Lhead}}}
    \fancyhead[C]{\color{themeColor} \fontsize{10pt}{0}{\textbf{\ExBook@value@Chead}} }
    \fancyhead[R]{\color{themeColor} \fontsize{10pt}{0}{\textbf{\ExBook@value@Rhead}} }

    % 设置页码位置
    \fancyfoot[C]{\color{themeColor}第 \thepage 页  / 共 \pageref{LastPage} 页 }
    
    \if@showmark
        \fancyfoot[L]{\color{themeColor}\kaishu  \truncate{7cm}{\leftmark}}
        \fancyfoot[R]{\color{themeColor}\kaishu  \truncate{7cm}{\rightmark}}
        \if@notocnum
            \renewcommand{\sectionmark}[1]{\markboth{#1}{}}
            \renewcommand{\subsectionmark}[1]{\markright{#1}{}}
        \else
            \renewcommand{\sectionmark}[1]{\markboth{\thesection #1}{}}
            \renewcommand{\subsectionmark}[1]{\markright{\thesubsection #1}{}}
        \fi
    \fi

    % 设置分隔线
    \renewcommand{\headrulewidth}{0.4pt}
    \renewcommand{\footrulewidth}{0pt}

    \newenvironment{bbox}
    {
    \begin{minipage}{\textwidth}
    }
    {

    \vspace*{2.5cm}
    \end{minipage}

    \if@water
        \begin{tikzpicture}[overlay,remember picture]
            \node[anchor=east, opacity=0.02] at ([xshift=-1.2cm, yshift=4.8cm]current page.south east)  {\includegraphics[width=0.16\textwidth]{\ExBook@value@waterImg}}; 
        \end{tikzpicture}
    \fi
    % \newpage % 在环境结束时插入新页面
    }
\or
 %                         *****************
 %                         **   横Pad版    **
 %                         *****************

    \geometry{paperheight=150mm, paperwidth=200mm,left=12mm,right=12mm,top=10mm,bottom=15mm}
    \if@darkmode
        % 设置页面背景颜色
        \pagecolor{bg} % 使用 10% 不透明度的蓝色作为页面背景颜色

        % 设置全局文字颜色
        \color{white} % 将全局文字颜色设置为红色
    \fi
    % 自定义封面样式
    \renewcommand{\maketitle}{
    \begin{titlepage}
        \if@darkmode
        \begin{tikzpicture}[remember picture, overlay]
            \node[anchor=north, inner sep=0pt](image) at ([xshift=10cm, yshift=5cm]current page.north west) {\includegraphics[width=\paperwidth, height=\paperheight, keepaspectratio]{\ExBook@value@coverImg}};

            \fill[themeColor!61.8, opacity=0.382] ([yshift=0cm]current page.west) rectangle ++(\paperwidth,2cm);
            \node[anchor=west, align=left, text width=\textwidth, inner sep=0] at ([yshift=1cm, xshift=1cm]current page.west) {\color{white!61.8} \fontsize{24pt}{0}{\textbf{\ExBook@value@PreTitle}}};
            \node[anchor=west, align=left, text width=\textwidth, inner sep=0] at ([yshift=-1cm, xshift=1cm]current page.west) {\fontsize{32pt}{0}{\textbf{\kaishu \ExBook@value@Title}}};
            \node[anchor=west, align=left, text width=\textwidth, inner sep=0] at ([yshift=-2.5cm, xshift=1cm]current page.west) {\fontsize{28pt}{0}{\textbf{\ExBook@value@TitleDescription}}};
            \fill[themeColor!61.8, opacity=0.382] (current page.south west) rectangle ++(\paperwidth,2cm);
            \node[anchor=south, align=center] at ([yshift=0.8cm]current page.south) {\color{white!61.8}\fontsize{16pt}{0}{\ExBook@value@Creator}};
            \node[anchor=south, align=center] at ([yshift=0.2cm]current page.south) {\color{white!61.8}\fontsize{12pt}{0}{\ExBook@value@UpdateTime}};

            \node[anchor=south, align=center] at ([yshift=2.4cm]current page.south) {\color{white!61.8}\fontsize{12pt}{0}{\ExBook@value@motto}};

            \fill[themeColor!61.8, opacity=0.382, rounded corners=12pt] ([yshift=2.5cm, xshift=15.5cm]current page.south west) rectangle ++(3.5cm,1.5cm);
            \node[anchor=south, align=center] at ([yshift=2.8cm, xshift=17.3cm]current page.south west) {\color{white!61.8}\fontsize{16pt}{0}\textbf{\ExBook@value@TypeThree}};

            \if@online
                \node[anchor=south, align=center] at ([yshift=1.0cm, xshift=3.25cm]current page.south west) {\color{white!61.8}\fontsize{10pt}{0}\textbf{\kaishu 遇到录入错误，可查看：}};
                \node[anchor=south, align=center] at ([yshift=0.35cm, xshift=3.4cm]current page.south west) {\color{white!61.8}\fontsize{10pt}{0}\textbf{\href{\ExBook@value@onlineCheckUrl}{在线勘误文档（\underline{点击跳转}）}}};
            \fi
        \end{tikzpicture} 
        \else
        \begin{tikzpicture}[remember picture, overlay]
            \node[anchor=north, inner sep=0pt](image) at ([xshift=10cm, yshift=5cm]current page.north west) {\includegraphics[width=\paperwidth, height=\paperheight, keepaspectratio]{\ExBook@value@coverImg}};

            \fill[themeColor!6.2] ([yshift=0cm]current page.west) rectangle ++(\paperwidth,2cm);
            \node[anchor=west, align=left, text width=\textwidth, inner sep=0] at ([yshift=1cm, xshift=1cm]current page.west) {\color{themeColor} \fontsize{24pt}{0}{\textbf{\ExBook@value@PreTitle}}};
            \node[anchor=west, align=left, text width=\textwidth, inner sep=0] at ([yshift=-1cm, xshift=1cm]current page.west) {\fontsize{32pt}{0}{\textbf{\kaishu \ExBook@value@Title}}};
            \node[anchor=west, align=left, text width=\textwidth, inner sep=0] at ([yshift=-2.5cm, xshift=1cm]current page.west) {\fontsize{28pt}{0}{\textbf{\ExBook@value@TitleDescription}}};
            \fill[themeColor!6.2] (current page.south west) rectangle ++(\paperwidth,2cm);
            \node[anchor=south, align=center] at ([yshift=0.8cm]current page.south) {\color{themeColor}\fontsize{16pt}{0}{\ExBook@value@Creator}};
            \node[anchor=south, align=center] at ([yshift=0.2cm]current page.south) {\color{themeColor}\fontsize{12pt}{0}{\ExBook@value@UpdateTime}};

            \node[anchor=south, align=center] at ([yshift=2.4cm]current page.south) {\color{themeColor}\fontsize{12pt}{0}{\ExBook@value@motto}};

            \fill[themeColor!6.2, rounded corners=12pt] ([yshift=2.5cm, xshift=15.5cm]current page.south west) rectangle ++(3.5cm,1.5cm);
            \node[anchor=south, align=center] at ([yshift=2.8cm, xshift=17.3cm]current page.south west) {\color{themeColor}\fontsize{16pt}{0}\textbf{\ExBook@value@TypeThree}};

            \if@online
                \node[anchor=south, align=center] at ([yshift=1.0cm, xshift=3.25cm]current page.south west) {\color{themeColor}\fontsize{10pt}{0}\textbf{\kaishu 遇到录入错误，可查看：}};
                \node[anchor=south, align=center] at ([yshift=0.35cm, xshift=3.4cm]current page.south west) {\color{themeColor}\fontsize{10pt}{0}\textbf{\href{\ExBook@value@onlineCheckUrl}{在线勘误文档（\underline{点击跳转}）}}};
            \fi
        \end{tikzpicture}
        \fi
        
    \end{titlepage}
    }

    \pagestyle{fancy}
    \fancyhf{} % 清空当前设置

    \renewcommand{\headrulewidth}{0pt} % 移除页眉底部的横线
    \renewcommand{\footrulewidth}{0pt} % 页面底部横线 \faWeixin{}
    \newcommand{\myrecttext}{\fontsize{14}{0} \textbf{\ExBook@value@LheadC \ExBook@value@Chead \ExBook@value@Rhead}}
    \newcommand{\myrecttextolus}{\fontsize{14}{0}\heiti \leftmark}
    \newcommand{\myrecttexttwo}{\fontsize{8pt}{0}{\textbf{  \kaishu  \truncate{4cm}{\leftmark}}}}
    \newcommand{\myrecttextthree}{\fontsize{8pt}{0}{\textbf{ \kaishu \truncate{4cm}{\rightmark}}}}

    \if@notocnum
        \renewcommand{\sectionmark}[1]{\markboth{#1}{}}
        \renewcommand{\subsectionmark}[1]{\markright{#1}{}}
    \else
        \renewcommand{\sectionmark}[1]{\markboth{\thesection #1}{}}
        \renewcommand{\subsectionmark}[1]{\markright{\thesubsection #1}{}}
    \fi


    % 在每页的页眉位置添加矩形
    \chead{%
    \if@darkmode
    \begin{tikzpicture}[remember picture,overlay]
        \fill[themeColor, opacity=0.382] (current page.north west) rectangle ++(0.668\paperwidth,-0.8cm);
        \node[anchor=north west, text width=\paperwidth, text height=0.4cm, align=left] at ([xshift=0.0em]current page.north west) {%
        \textcolor{white}{\myrecttext}
        };
        
        \fill[themeColor!61.8, opacity=0.382] ([xshift=-0.332\paperwidth]current page.north east) rectangle ++(0.217\paperwidth,-0.8cm);
        \node[anchor=north west, text width=\paperwidth, text height=0.16cm, align=left, font=\bfseries] at ([xshift=0.66\paperwidth]current page.north west) {%
        \textcolor{white!61.8}{\myrecttexttwo}
        };
        \node[anchor=north west, text width=\paperwidth, text height=0.52cm, align=left, font=\bfseries] at ([xshift=0.66\paperwidth]current page.north west) {%
        \textcolor{white!61.8}{\myrecttextthree}
        };

        \fill[themeColor, opacity=0.382] ([xshift=-0.115\paperwidth]current page.north east) rectangle ++(0.027\paperwidth,-0.8cm);
        \node[anchor=east, text=white, text height=1.2cm] at (current page.north east) {};

        \fill[themeColor!60, opacity=0.382] ([xshift=-0.075\paperwidth]current page.north east) rectangle ++(0.027\paperwidth,-0.8cm);
        \node[anchor=east, text=white, text height=1.2cm] at (current page.north east) {};

        \fill[themeColor!20, opacity=0.382] ([xshift=-0.024\paperwidth]current page.north east) rectangle ++(0.027\paperwidth,-0.8cm);
        \node[anchor=east, text=white, text height=1.2cm] at (current page.north east) {};

        \draw[line width=1.5pt, color=themeColor] (current page.north west) ++(0,-0.8cm) -- ++(\paperwidth,0);

        \node[anchor=east, text height=1.2cm, font=\small] at ([xshift=-8.5cm, yshift=1.5cm]current page.south east) {\color{white!61.8}  第 \thepage 页  / 共 \pageref{LastPage} 页};
    \end{tikzpicture}
    \else
    \begin{tikzpicture}[remember picture,overlay]
        \fill[themeColor] (current page.north west) rectangle ++(0.668\paperwidth,-0.8cm);
        \node[anchor=north west, text width=\paperwidth, text height=0.4cm, align=left] at ([xshift=0.0em]current page.north west) {%
        \textcolor{white}{\myrecttext}
        };
        
        \fill[themeColor!6.2] ([xshift=-0.332\paperwidth]current page.north east) rectangle ++(0.23\paperwidth,-0.8cm);
        \node[anchor=north west, text width=\paperwidth, text height=0.16cm, align=left, font=\bfseries] at ([xshift=0.66\paperwidth]current page.north west) {%
        \textcolor{themeColor}{\myrecttexttwo}
        };
        \node[anchor=north west, text width=\paperwidth, text height=0.52cm, align=left, font=\bfseries] at ([xshift=0.66\paperwidth]current page.north west) {%
        \textcolor{themeColor}{\myrecttextthree}
        };

        \fill[themeColor] ([xshift=-0.115\paperwidth]current page.north east) rectangle ++(0.027\paperwidth,-0.8cm);
        \node[anchor=east, text=white, text height=1.2cm] at (current page.north east) {};

        \fill[themeColor!60] ([xshift=-0.075\paperwidth]current page.north east) rectangle ++(0.027\paperwidth,-0.8cm);
        \node[anchor=east, text=white, text height=1.2cm] at (current page.north east) {};

        \fill[themeColor!20] ([xshift=-0.024\paperwidth]current page.north east) rectangle ++(0.027\paperwidth,-0.8cm);
        \node[anchor=east, text=white, text height=1.2cm] at (current page.north east) {};

        \draw[line width=1.5pt, color=themeColor] (current page.north west) ++(0,-0.8cm) -- ++(\paperwidth,0);

        \node[anchor=east, text height=1.2cm, font=\small] at ([xshift=-8.5cm, yshift=1.5cm]current page.south east) {\color{themeColor}  第 \thepage 页  / 共 \pageref{LastPage} 页};
    \end{tikzpicture}
    \fi
    
    }
    
    \newenvironment{bbox}
    {
        \begingroup
    }
    {
        \endgroup
        \if@water
        \begin{tikzpicture}[overlay,remember picture]
            \node[anchor=east, opacity=0.08] at ([xshift=-1.2cm, yshift=4.8cm]current page.south east)  {\includegraphics[width=0.16\textwidth]{\ExBook@value@waterImg}}; 
        \end{tikzpicture}
        \fi
        \newpage % 在环境结束时插入新页面
    }
\or
 %                         *****************
 %                         **   A4宽松版   **
 %                         *****************

    \if@printmode
        \geometry{a4paper, twoside, left=18mm, right=18mm, top=25mm, bottom=25mm, headsep=5mm, bindingoffset = 1cm}
    \else
        \geometry{a4paper, left=18mm, right=18mm, top=25mm, bottom=25mm, headsep=5mm}   
    \fi

    % 自定义封面样式
    \renewcommand{\maketitle}{
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

            \node[anchor=south, align=center] at ([yshift=3cm]current page.south) {\color{themeColor}\fontsize{12pt}{0}{\ExBook@value@motto}};

            \fill[themeColor!6.2, rounded corners=16pt] ([yshift=4cm, xshift=14cm]current page.south west) rectangle ++(5cm,2cm);
            \node[anchor=south, align=center] at ([yshift=4.5cm, xshift=16.5cm]current page.south west) {\color{themeColor}\fontsize{24pt}{0}\ExBook@value@TypeFour}; 
            \if@online
                \node[anchor=south, align=center] at ([yshift=5.5cm, xshift=4.5cm]current page.south west) {\color{themeColor}\fontsize{14pt}{0}\textbf{\kaishu 遇到录入错误，可查看：}};
                \fill[themeColor!6.2, rounded corners=6pt] ([yshift=4.5cm, xshift=1.50cm]current page.south west) rectangle ++(7cm,1cm);
                \node[anchor=south, align=center] at ([yshift=4.5cm, xshift=5.2cm]current page.south west) {\color{themeColor}\fontsize{16pt}{0}\textbf{\href{\ExBook@value@onlineCheckUrl}{在线勘误文档（\underline{点击跳转}）}}};
            \fi
        \end{tikzpicture}
    \end{titlepage}
    }

    \pagestyle{fancy} % 启用自定义页眉

    % 清除当前的页眉和页脚设置
    \fancyhf{}

    % 设置页眉内容
    \fancyhead[L]{\color{themeColor} \fontsize{10pt}{0}{\textbf{\ExBook@value@Lhead}}}
    \fancyhead[C]{\color{themeColor} \fontsize{10pt}{0}{\textbf{\ExBook@value@Chead}} }
    \fancyhead[R]{\color{themeColor} \fontsize{10pt}{0}{\textbf{\ExBook@value@Rhead}} }

    % 设置页码位置
    \fancyfoot[C]{\color{themeColor}第 \thepage 页  / 共 \pageref{LastPage} 页 }
    \if@showmark
        \fancyfoot[L]{\color{themeColor}\kaishu  \truncate{7cm}{\leftmark}}
        \fancyfoot[R]{\color{themeColor}\kaishu  \truncate{7cm}{\rightmark}}
        \if@notocnum
            \renewcommand{\sectionmark}[1]{\markboth{#1}{}}
            \renewcommand{\subsectionmark}[1]{\markright{#1}{}}
        \else
            \renewcommand{\sectionmark}[1]{\markboth{\thesection #1}{}}
            \renewcommand{\subsectionmark}[1]{\markright{\thesubsection #1}{}}
        \fi
    \fi

    % 设置分隔线
    \renewcommand{\headrulewidth}{0.4pt}
    \renewcommand{\footrulewidth}{0pt}

    \newenvironment{bbox}
    {
        \begingroup
        \begin{minipage}{\textwidth}
    }
    {
        \vspace*{7.5cm}
        \end{minipage}
        \if@water
            \begin{tikzpicture}[overlay,remember picture]
                \node[anchor=east, opacity=0.02] at ([xshift=-1.2cm, yshift=4.8cm]current page.south east)  {\includegraphics[width=0.16\textwidth]{\ExBook@value@waterImg}}; 
            \end{tikzpicture}
        \fi
        \endgroup
    % \newpage % 在环境结束时插入新页面
    }

\or
 %                         *****************
 %                         **   A4单题版   **
 %                         *****************
    % 当变量为1时，选择页面格式为b
    \if@printmode
        \geometry{a4paper, twoside, left=18mm, right=18mm, top=25mm, bottom=25mm, headsep=5mm, bindingoffset = 1cm}
    \else
        \geometry{a4paper, left=18mm, right=18mm, top=25mm, bottom=25mm, headsep=5mm}   
    \fi

    % 自定义封面样式
    \renewcommand{\maketitle}{
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
        
            \node[anchor=south, align=center] at ([yshift=3cm]current page.south) {\color{themeColor}\fontsize{12pt}{0}{\ExBook@value@motto}};
        
            \fill[themeColor!6.2, rounded corners=16pt] ([yshift=4cm, xshift=14cm]current page.south west) rectangle ++(5cm,2cm);
            \node[anchor=south, align=center] at ([yshift=4.5cm, xshift=16.5cm]current page.south west) {\color{themeColor}\fontsize{24pt}{0}\ExBook@value@TypeFive};
        
            \if@online
                \node[anchor=south, align=center] at ([yshift=5.5cm, xshift=4.5cm]current page.south west) {\color{themeColor}\fontsize{14pt}{0}\textbf{\kaishu 遇到录入错误，可查看：}};
                \fill[themeColor!6.2, rounded corners=6pt] ([yshift=4.5cm, xshift=1.50cm]current page.south west) rectangle ++(7cm,1cm);
                \node[anchor=south, align=center] at ([yshift=4.5cm, xshift=5.2cm]current page.south west) {\color{themeColor}\fontsize{16pt}{0}\textbf{\href{\ExBook@value@onlineCheckUrl}{在线勘误文档（\underline{点击跳转}）}}};
            \fi
        \end{tikzpicture}
    \end{titlepage}
    }

    \pagestyle{fancy} % 启用自定义页眉

    % 清除当前的页眉和页脚设置
    \fancyhf{}

    % 设置页眉内容
    \fancyhead[L]{\color{themeColor} \fontsize{10pt}{0}{\textbf{\ExBook@value@Lhead}}}
    \fancyhead[C]{\color{themeColor} \fontsize{10pt}{0}{\textbf{\ExBook@value@Chead}} }
    \fancyhead[R]{\color{themeColor} \fontsize{10pt}{0}{\textbf{\ExBook@value@Rhead}} }

    % 设置页码位置
    \fancyfoot[C]{\color{themeColor}第 \thepage 页  / 共 \pageref{LastPage} 页 }

    \if@showmark
        \fancyfoot[L]{\color{themeColor}\kaishu  \truncate{7cm}{\leftmark}}
        \fancyfoot[R]{\color{themeColor}\kaishu  \truncate{7cm}{\rightmark}}
        \if@notocnum
            \renewcommand{\sectionmark}[1]{\markboth{#1}{}}
            \renewcommand{\subsectionmark}[1]{\markright{#1}{}}
        \else
            \renewcommand{\sectionmark}[1]{\markboth{\thesection #1}{}}
            \renewcommand{\subsectionmark}[1]{\markright{\thesubsection #1}{}}
        \fi
    \fi
    

    % 设置分隔线
    \renewcommand{\headrulewidth}{0.4pt}
    \renewcommand{\footrulewidth}{0pt}

    \newenvironment{bbox}
    {
        \begingroup
    }
    {
        \if@water
            \begin{tikzpicture}[overlay,remember picture]
                \node[anchor=east, opacity=0.02] at ([xshift=-1.2cm, yshift=4.8cm]current page.south east)  {\includegraphics[width=0.16\textwidth]{\ExBook@value@waterImg}}; 
            \end{tikzpicture}
        \fi
        \endgroup
        \newpage % 在环境结束时插入新页面
    }

\or
 %                         *****************
 %                         **   竖Pad版   **
 %                         *****************
    \newcommand{\myCFormat}{1}
    \geometry{paperheight=250mm, paperwidth=200mm,left=12mm,right=12mm,top=10mm,bottom=15mm}

    \if@darkmode
        % 设置页面背景颜色
        \pagecolor{bg} % 使用 10% 不透明度的蓝色作为页面背景颜色

        % 设置全局文字颜色
        \color{white} % 将全局文字颜色设置为红色
    \fi
    % 自定义封面样式
    \renewcommand{\maketitle}{
    \begin{titlepage}
        \if@darkmode
            \begin{tikzpicture}[remember picture, overlay]
            \node[anchor=north, inner sep=0pt](image) at ([xshift=10cm, yshift=0cm]current page.north west) {\includegraphics[width=\paperwidth, height=\paperheight, keepaspectratio]{\ExBook@value@coverImg}};
       
            \fill[themeColor!61.8, opacity=0.382] ([yshift=0cm]current page.west) rectangle ++(\paperwidth,2cm);
            \node[anchor=west, align=left, text width=\textwidth, inner sep=0] at ([yshift=1cm, xshift=1cm]current page.west) {\color{white!61.8} \fontsize{24pt}{0}{\textbf{\ExBook@value@PreTitle}}};
            \node[anchor=west, align=left, text width=\textwidth, inner sep=0] at ([yshift=-1cm, xshift=1cm]current page.west) {\fontsize{32pt}{0}{\textbf{\kaishu \ExBook@value@Title}}};
            \node[anchor=west, align=left, text width=\textwidth, inner sep=0] at ([yshift=-2.8cm, xshift=1cm]current page.west) {\fontsize{28pt}{0}{\textbf{\ExBook@value@TitleDescription}}};
            \fill[themeColor!61.8, opacity=0.382] (current page.south west) rectangle ++(\paperwidth,2cm);
            \node[anchor=south, align=center] at ([yshift=0.8cm]current page.south) {\color{white!61.8}\fontsize{16pt}{0}{\ExBook@value@Creator}};
            \node[anchor=south, align=center] at ([yshift=0.2cm]current page.south) {\color{white!61.8}\fontsize{12pt}{0}{\ExBook@value@UpdateTime}};

            \node[anchor=south, align=center] at ([yshift=2.4cm]current page.south) {\color{white!61.8}\fontsize{12pt}{0}{\ExBook@value@motto}};
        
            \fill[themeColor!61.8, opacity=0.382, rounded corners=12pt] ([yshift=3.5cm, xshift=15.0cm]current page.south west) rectangle ++(3.5cm,1.5cm);
            \node[anchor=south, align=center] at ([yshift=3.8cm, xshift=16.8cm]current page.south west) {\color{white!61.8}\fontsize{16pt}{0}\textbf{\ExBook@value@TypeSix}};
            
            \if@online
                \node[anchor=south, align=center] at ([yshift=5.5cm, xshift=3.8cm]current page.south west) {\color{white!61.8}\fontsize{14pt}{0}\textbf{\kaishu 遇到录入错误，可查看：}};
                \fill[themeColor!61.8, opacity=0.382, rounded corners=6pt] ([yshift=4.5cm, xshift=0.80cm]current page.south west) rectangle ++(7cm,1cm);
                \node[anchor=south, align=center] at ([yshift=4.5cm, xshift=4.5cm]current page.south west) {\color{white!61.8}\fontsize{16pt}{0}\textbf{\href{\ExBook@value@onlineCheckUrl}{在线勘误文档（\underline{点击跳转}）}}};
            \fi
        \end{tikzpicture}

        \else
            \begin{tikzpicture}[remember picture, overlay]
                \node[anchor=north, inner sep=0pt](image) at ([xshift=10cm, yshift=0cm]current page.north west) {\includegraphics[width=\paperwidth, height=\paperheight, keepaspectratio]{\ExBook@value@coverImg}};
        
                \fill[themeColor!6.2] ([yshift=0cm]current page.west) rectangle ++(\paperwidth,2cm);
                \node[anchor=west, align=left, text width=\textwidth, inner sep=0] at ([yshift=1cm, xshift=1cm]current page.west) {\color{themeColor} \fontsize{24pt}{0}{\textbf{\ExBook@value@PreTitle}}};
                \node[anchor=west, align=left, text width=\textwidth, inner sep=0] at ([yshift=-1cm, xshift=1cm]current page.west) {\fontsize{32pt}{0}{\textbf{\kaishu \ExBook@value@Title}}};
                \node[anchor=west, align=left, text width=\textwidth, inner sep=0] at ([yshift=-2.8cm, xshift=1cm]current page.west) {\fontsize{28pt}{0}{\textbf{\ExBook@value@TitleDescription}}};
                \fill[themeColor!6.2] (current page.south west) rectangle ++(\paperwidth,2cm);
                \node[anchor=south, align=center] at ([yshift=0.8cm]current page.south) {\color{themeColor}\fontsize{16pt}{0}{\ExBook@value@Creator}};
                \node[anchor=south, align=center] at ([yshift=0.2cm]current page.south) {\color{themeColor}\fontsize{12pt}{0}{\ExBook@value@UpdateTime}};

                \node[anchor=south, align=center] at ([yshift=2.4cm]current page.south) {\color{themeColor}\fontsize{12pt}{0}{\ExBook@value@motto}};
            
                \fill[themeColor!6.2, rounded corners=12pt] ([yshift=3.5cm, xshift=15.0cm]current page.south west) rectangle ++(3.5cm,1.5cm);
                \node[anchor=south, align=center] at ([yshift=3.8cm, xshift=16.8cm]current page.south west) {\color{themeColor}\fontsize{16pt}{0}\textbf{\ExBook@value@TypeSix}};
                
                \if@online
                    \node[anchor=south, align=center] at ([yshift=5.5cm, xshift=3.8cm]current page.south west) {\color{themeColor}\fontsize{14pt}{0}\textbf{\kaishu 遇到录入错误，可查看：}};
                    \fill[themeColor!6.2, rounded corners=6pt] ([yshift=4.5cm, xshift=0.80cm]current page.south west) rectangle ++(7cm,1cm);
                    \node[anchor=south, align=center] at ([yshift=4.5cm, xshift=4.5cm]current page.south west) {\color{themeColor}\fontsize{16pt}{0}\textbf{\href{\ExBook@value@onlineCheckUrl}{在线勘误文档（\underline{点击跳转}）}}};
                \fi
            \end{tikzpicture}
        \fi
        
    \end{titlepage}
    }

    \pagestyle{fancy}
    \fancyhf{} % 清空当前设置

    \renewcommand{\headrulewidth}{0pt} % 移除页眉底部的横线
    \renewcommand{\footrulewidth}{0pt} % 页面底部横线 \faWeixin{}
    \newcommand{\myrecttext}{\fontsize{14}{0} \textbf{\ExBook@value@LheadC \ExBook@value@Chead \ExBook@value@Rhead}}
    \newcommand{\myrecttextolus}{\fontsize{14}{0}\heiti \leftmark}
    \newcommand{\myrecttexttwo}{\fontsize{8pt}{0}{\textbf{  \kaishu  \truncate{4cm}{\leftmark}}}}
    \newcommand{\myrecttextthree}{\fontsize{8pt}{0}{\textbf{ \kaishu \truncate{4cm}{\rightmark}}}}
    
    \if@notocnum
        \renewcommand{\sectionmark}[1]{\markboth{#1}{}}
        \renewcommand{\subsectionmark}[1]{\markright{#1}{}}
    \else
        \renewcommand{\sectionmark}[1]{\markboth{\thesection #1}{}}
        \renewcommand{\subsectionmark}[1]{\markright{\thesubsection #1}{}}
    \fi

    % 在每页的页眉位置添加矩形
    \chead{%
    \if@darkmode
    \begin{tikzpicture}[remember picture,overlay]
        \fill[themeColor, opacity=0.382] (current page.north west) rectangle ++(0.668\paperwidth,-0.8cm);
        \node[anchor=north west, text width=\paperwidth, text height=0.4cm, align=left] at ([xshift=0.0em]current page.north west) {%
        \textcolor{white}{\myrecttext}
        };
        
        \fill[themeColor!61.2, opacity=0.382] ([xshift=-0.332\paperwidth]current page.north east) rectangle ++(0.217\paperwidth,-0.8cm);
        \node[anchor=north west, text width=\paperwidth, text height=0.16cm, align=left, font=\bfseries] at ([xshift=0.66\paperwidth]current page.north west) {%
        \textcolor{white!61.8}{\myrecttexttwo}
        };
        \node[anchor=north west, text width=\paperwidth, text height=0.52cm, align=left, font=\bfseries] at ([xshift=0.66\paperwidth]current page.north west) {%
        \textcolor{white!61.8}{\myrecttextthree}
        };

        \fill[themeColor, opacity=0.382] ([xshift=-0.115\paperwidth]current page.north east) rectangle ++(0.027\paperwidth,-0.8cm);
        \node[anchor=east, text=white, text height=1.2cm] at (current page.north east) {};

        \fill[themeColor!60, opacity=0.382] ([xshift=-0.075\paperwidth]current page.north east) rectangle ++(0.027\paperwidth,-0.8cm);
        \node[anchor=east, text=white, text height=1.2cm] at (current page.north east) {};

        \fill[themeColor!20, opacity=0.382] ([xshift=-0.024\paperwidth]current page.north east) rectangle ++(0.027\paperwidth,-0.8cm);
        \node[anchor=east, text=white, text height=1.2cm] at (current page.north east) {};

        \draw[line width=1.5pt, color=themeColor] (current page.north west) ++(0,-0.8cm) -- ++(\paperwidth,0);

        \node[anchor=east, text height=1.2cm, font=\small] at ([xshift=-8.5cm, yshift=1.5cm]current page.south east) {\color{white!61.8}  第 \thepage 页  / 共 \pageref{LastPage} 页};
    \end{tikzpicture}
    \else
    \begin{tikzpicture}[remember picture,overlay]
        \fill[themeColor] (current page.north west) rectangle ++(0.668\paperwidth,-0.8cm);
        \node[anchor=north west, text width=\paperwidth, text height=0.4cm, align=left] at ([xshift=0.0em]current page.north west) {%
        \textcolor{white}{\myrecttext}
        };
        
        \fill[themeColor!6.2] ([xshift=-0.332\paperwidth]current page.north east) rectangle ++(0.23\paperwidth,-0.8cm);
        \node[anchor=north west, text width=\paperwidth, text height=0.16cm, align=left, font=\bfseries] at ([xshift=0.66\paperwidth]current page.north west) {%
        \textcolor{themeColor}{\myrecttexttwo}
        };
        \node[anchor=north west, text width=\paperwidth, text height=0.52cm, align=left, font=\bfseries] at ([xshift=0.66\paperwidth]current page.north west) {%
        \textcolor{themeColor}{\myrecttextthree}
        };

        \fill[themeColor] ([xshift=-0.115\paperwidth]current page.north east) rectangle ++(0.027\paperwidth,-0.8cm);
        \node[anchor=east, text=white, text height=1.2cm] at (current page.north east) {};

        \fill[themeColor!60] ([xshift=-0.075\paperwidth]current page.north east) rectangle ++(0.027\paperwidth,-0.8cm);
        \node[anchor=east, text=white, text height=1.2cm] at (current page.north east) {};

        \fill[themeColor!20] ([xshift=-0.024\paperwidth]current page.north east) rectangle ++(0.027\paperwidth,-0.8cm);
        \node[anchor=east, text=white, text height=1.2cm] at (current page.north east) {};

        \draw[line width=1.5pt, color=themeColor] (current page.north west) ++(0,-0.8cm) -- ++(\paperwidth,0);

        \node[anchor=east, text height=1.2cm, font=\small] at ([xshift=-8.5cm, yshift=1.5cm]current page.south east) {\color{themeColor}  第 \thepage 页  / 共 \pageref{LastPage} 页};
    \end{tikzpicture}
    \fi
    
    }
    
    \newenvironment{bbox}
    {
        \begingroup
    }
    {
        \if@water
        \begin{tikzpicture}[overlay,remember picture]
            \node[anchor=east, opacity=0.08] at ([xshift=-1.2cm, yshift=4.8cm]current page.south east)  {\includegraphics[width=0.16\textwidth]{\ExBook@value@waterImg}}; 
        \end{tikzpicture}
        \fi
        \endgroup
        \newpage % 在环境结束时插入新页面
    }

\fi

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
\define@key{qitems}{optsuffix}[]{\def\@optsuffix{#1}} 
\define@key{qitems}{startnum}[0]{\def\@startnum{#1}} 

% 定义题目环境
\newenvironment{qitems}[1][]{
    \begingroup
    \setkeys{qitems}{#1} % 解析传入的键值对
    
    \if@resetcounter
        \setcounter{QuestionCounter}{0}
    \fi

    \ifx\@prefix\undefined
        \def\@prefix{} 
    \fi
    \ifx\@suffix\undefined
        \def\@suffix{.} 
    \fi

    \ifx\@optprefix\undefined
        \def\@optprefix{}
    \fi
    \ifx\@optsuffix\undefined
        \def\@optsuffix{.} 
    \fi 

    \ifx\@startnum\undefined
        \def\@startnum{0}
    \else
        \setcounter{QuestionCounter}{\@startnum}
        \addtocounter{QuestionCounter}{-1}
    \fi

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
\if@notocnum
    % 不显示目录编号
    \titlecontents{section}[0em]
    {\heiti}
    {}
    {}
    {\titlerule*[0.4pc]{.}\contentspage}

    \titlecontents{subsection}[2em]
    {}
    {}
    {}
    {\titlerule*[0.4pc]{.}\contentspage}

    \titlecontents{subsubsection}[4em]
    {}
    {}
    {}
    {\titlerule*[0.4pc]{.}\contentspage}

    \titlespacing{\section}
    {0pt} % 左边距
    {2pt plus 2pt minus 2pt} % 上边距
    {4pt plus 2pt minus 2pt} % 下边距

    \titlespacing{\subsection}
    {0pt} % 左边距
    {2pt plus 2pt minus 2pt} % 上边距
    {2pt plus 2pt minus 2pt} % 下边距

    \titlespacing{\subsubsection}
    {0pt} % 左边距
    {2pt plus 2pt minus 2pt} % 上边距
    {2pt plus 2pt minus 2pt} % 下边距

    % 自定义 \section 标题样式
    \titleformat{\section}[block]
    {\newpage \centering\heiti\fontsize{13pt}{0}}
    {}
    {0em}
    {} % 居中、字体和大小，每一个section都重启一页

    % 自定义 \subsection 标题样式
    \titleformat{\subsection}
    {\normalfont\normalsize\bfseries} % 字体和大小
    {} % 标题编号
    {0em} % 与标题编号的间距
    {} % 标题之后的间距

    % 自定义 \subsubsection 标题样式
    \titleformat{\subsubsection}
    {\normalfont\normalsize\bfseries} % 字体和大小
    {} % 标题编号
    {0em} % 与标题编号的间距
    {} % 标题之后的间距

\else
    % 自定义 \section 标题在目录中的样式
    \titlecontents{section}[0em]
    {\heiti}
    {第\thecontentslabel\ 章\hspace{1em}}
    {}
    {\titlerule*[0.4pc]{.}\contentspage}

    \titlecontents{subsection}[2em]
    {}
    {\thecontentslabel \hspace{1em}}
    {}
    {\titlerule*[0.4pc]{.}\contentspage}

    \titlecontents{subsubsection}[4em]
    {}
    {\thecontentslabel \hspace{1em}}
    {}
    {\titlerule*[0.4pc]{.}\contentspage}

    \titlespacing{\section}
    {0pt} % 左边距
    {2pt plus 2pt minus 2pt} % 上边距
    {4pt plus 2pt minus 2pt} % 下边距

    \titlespacing{\subsection}
    {0pt} % 左边距
    {2pt plus 2pt minus 2pt} % 上边距
    {2pt plus 2pt minus 2pt} % 下边距

    % 自定义 \section 标题样式
    \titleformat{\section}[block]
    {\newpage \centering\heiti\normalsize}
    {第\thesection 章}
    {1em}
    {} % 居中、字体和大小，每一个section都重启一页

    % 自定义 \subsection 标题样式
    \titleformat{\subsection}
    {\normalfont\normalsize\bfseries} % 字体和大小
    {\thesubsection} % 标题编号
    {0.6em} % 与标题编号的间距
    {} % 标题之后的间距
\fi

\AtBeginDocument{
	\pagenumbering{arabic}  % 使用阿拉伯数字页码
}

\endinput
