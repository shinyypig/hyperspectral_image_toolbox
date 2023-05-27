% 初始化
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{simplepaper}[2023/1/28 v0.01 SimplePaper class]

% 设置参数
\RequirePackage{kvoptions}
\RequirePackage{etoolbox}
\RequirePackage{calc}

\SetupKeyvalOptions{family=SIMPLE, prefix=SIMPLE@, setkeys=\kvsetkeys}
\newcommand{\skv}[1]{\kvsetkeys{SIMPLE}{#1}}

% 获取语言参数，默认英文
\DeclareStringOption[en]{lang}
\DeclareVoidOption{cn}{\skv{lang=cn}}
\DeclareVoidOption{en}{\skv{lang=en}}

% 获取中文字体参数，默认plain
\DeclareStringOption[plain]{chinesefont}
\DeclareVoidOption{plain}{\skv{chinesefont=plain}}
\DeclareVoidOption{founder}{\skv{chinesefont=founder}}
\DeclareVoidOption{nofont}{\skv{chinesefont=nofont}}

% 获取字体大小参数，默认11pt
\DeclareStringOption[11pt]{fontsize}
\DeclareVoidOption{10pt}{\skv{fontsize=10pt}}
\DeclareVoidOption{11pt}{\skv{fontsize=11pt}}
\DeclareVoidOption{12pt}{\skv{fontsize=12pt}}

% 是否显示行号，默认off
\DeclareStringOption[final]{mode}
\DeclareVoidOption{final}{\skv{mode=final}}
\DeclareVoidOption{preprint}{\skv{mode=preprint}}
\DeclareVoidOption{nocomp}{\skv{mode=nocomp}}

% 设置引用格式
\DeclareStringOption[numeric-comp]{citestyle}
\DeclareStringOption[numeric]{bibstyle}
\DeclareStringOption[biber]{bibend}
\DeclareVoidOption{biber}{\ekv{bibend=biber}}
\DeclareVoidOption{bibtex}{\ekv{bibend=bibtex}}

\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessKeyvalOptions*\relax

\LoadClass{article}

% 数学相关包
\RequirePackage{amsthm}
\RequirePackage{amsmath}
\RequirePackage{amssymb}

% 颜色
\RequirePackage{color}
\RequirePackage{xcolor}
\RequirePackage{framed}

% 图片
\RequirePackage{graphicx}
\RequirePackage{subcaption}
\RequirePackage{float}

% 算法
\RequirePackage{algorithm}
\RequirePackage{algorithmic}
\RequirePackage{listings}
\lstdefinestyle{estyle}{
    basicstyle=%
    \ttfamily
    \lst@ifdisplaystyle\footnotesize\fi
}
\lstset{basicstyle=\scriptsize\ttfamily,style=estyle}
\lstset{language=[LaTeX]TeX,
    texcsstyle=*\color{winered},
    numbers=none,
    breaklines=true,
    keywordstyle=\color{winered},
    frame=tlbr,framesep=4pt,framerule=0pt,
    commentstyle=\color{commentcolor},
    emph={elegantpaper,fontenc,fontspec,xeCJK,FiraMono,xunicode,newtxmath,figure,fig,image,img,table,itemize,enumerate,newtxtext,newtxtt,ctex,microtype,description,times,newtx,booktabs,tabular,PDFLaTeX,XeLaTeX,type1cm,BibTeX,cite,gbt7714,lang},
    emphstyle={\color{frenchplum}},
    morekeywords={DeclareSymbolFont,SetSymbolFont,toprule,midrule,bottomrule,institute,version,includegraphics,setmainfont,setsansfont,setmonofont ,setCJKmainfont,setCJKsansfont,setCJKmonofont,RequirePackage,figref,tabref,email,maketitle,keywords,zhdate,zhtoday},
    tabsize=2,
    backgroundcolor=\color{lightgrey}
}

% 摘要，附录
\RequirePackage{abstract}
\RequirePackage{appendix}

% 其他
\RequirePackage{anyfontsize}
\RequirePackage{iftex}
\RequirePackage{silence}

% 设置字体大小
\WarningsOff
\RequirePackage[\SIMPLE@fontsize]{extsizes}
\WarningsOn


% 定义颜色
\definecolor{HEYELV}{HTML}{1a6840}
\definecolor{YEHUI}{HTML}{847c74}
\definecolor{DANQINZI}{HTML}{e0c8d1}
\definecolor{YOULAN}{HTML}{1781b5}
\definecolor{winered}{rgb}{0.5,0,0}
\definecolor{lightgrey}{rgb}{0.95,0.95,0.95}
\definecolor{commentcolor}{RGB}{0,100,0}
\definecolor{frenchplum}{RGB}{190,20,83}
\definecolor{shadecolor}{rgb}{0.95,0.95,0.95}

% 设置引用格式
\RequirePackage[
    backend=\SIMPLE@bibend,
    citestyle=\SIMPLE@citestyle,
    bibstyle=\SIMPLE@bibstyle,
    sorting=none
]{biblatex}
\defbibheading{simplepaper}[\ebibname]{
    \section*{#1}
    \addcontentsline{toc}{section}{#1}
}
\def\bibfont{\footnotesize}

% 设置引用文件
\addbibresource{ref.bib}

% 设置链接格式
\RequirePackage{hyperref}
\hypersetup{
    pdfborder={0 0 0},
    colorlinks=true,
    linkcolor={HEYELV},
    urlcolor={YEHUI},
    filecolor={DANQINZI},
    citecolor={YOULAN},
    linktoc=all,
}

% 设置页面大小边距等
\RequirePackage[
    left=1in,
    right=1in,
    top=1in,
    bottom=1in,
    headheight=0pt,
    headsep=0pt]{geometry}
\setlength{\headsep}{5pt}
\setlength{\parindent}{4em}
\setlength{\parskip}{0.5em}
\renewcommand{\baselinestretch}{1.25}

% 使用cleveref包用于引用公式图片表格等
\RequirePackage[capitalise]{cleveref}
% 公式引用只显示括号
\crefname{equation}{}{}
% 设置bm为boldsymbol
\newcommand{\bm}[1]{\boldsymbol{#1}}


% 设置字体
\ifcsname kaishu\endcsname
    \newcommand{\citshape}{\kaishu}
\else
    \newcommand{\citshape}{\itshape}
\fi
\ifcsname kaishu\endcsname
    \newcommand{\cnormal}{\kaishu}
\else
    \newcommand{\cnormal}{\normalfont}
\fi

\ifcsname fangsong\endcsname
    \newcommand{\cfs}{\fangsong}
\else
    \newcommand{\cfs}{\normalfont}
\fi

% 判断是否显示行号
\ifdefstring{\SIMPLE@mode}{preprint}{
    \RequirePackage{lineno}
    \linenumbers
}

% 判断是否压缩图片
\ifdefstring{\SIMPLE@mode}{nocomp}{
    \RequirePackage{lineno}
    \linenumbers
    \special{dvipdfmx:config z 0}
}

% 设置中文字体
\ifdefstring{\SIMPLE@lang}{cn}{
    \renewcommand{\today}{\number\year 年 \number\month 月 \number\day 日}
    \ifdefstring{\SIMPLE@chinesefont}{plain}{
        \RequirePackage[UTF8,scheme=plain]{ctex}
    }{\relax}

    \ifdefstring{\SIMPLE@chinesefont}{founder}{
        \RequirePackage[UTF8,scheme=plain,fontset=none]{ctex}
        \setCJKmainfont{FZShuSong-Z01}[
            UprightFont={FZFangSong-Z02},
            BoldFont={FZHei-B01},
            ItalicFont={FZKai-Z03},
            BoldItalicFont={FZHei-B01}
        ]
        \setCJKsansfont{FZKai-Z03}[
            BoldFont={FZHei-B01}
        ]
        \setCJKmonofont{FZFangSong-Z02}[
            BoldFont={FZHei-B01}
        ]
    }{\relax}

    \ifdefstring{\SIMPLE@chinesefont}{nofont}{
        \RequirePackage[UTF8,scheme=plain,fontset=none]{ctex}
    }{\relax}
}{\relax}


% 设置中文环境名称
\ifdefstring{\SIMPLE@lang}{cn}{
    \theoremstyle{plain}% default
    \newtheorem{theorem}{定理}[section] %
    \newtheorem{lemma}[theorem]{引理} %
    \newtheorem{proposition}[theorem]{命题} %
    \newtheorem{property}[theorem]{性质}
    \newtheorem*{corollary}{推论} %
    \theoremstyle{definition} %
    \newtheorem{definition}{定义}[section] %
    \newtheorem{conjecture}{猜想}[section] %
    \newtheorem{example}{例}[section] %
    \theoremstyle{remark} %
    \newtheorem*{remark}{\normalfont\bfseries 评论} %
    \newtheorem*{note}{\normalfont\bfseries 注} %
    \newtheorem{case}{\normalfont\bfseries 案例} %
    \renewcommand*{\proofname}{\normalfont\bfseries 证明} %
    \renewcommand\contentsname{目录}
    \renewcommand\refname{参考文献} %
    \renewcommand\figurename{图} %
    \renewcommand\tablename{表}%
    \newcommand\versiontext{版本：}%
    \newcommand\updatetext{日期：}%
    \newcommand{\ebibname}{参考文献}
    \renewcommand\abstractname{摘\hspace{2em}要}
    \renewcommand{\ALG@name}{算法}
    \setlength\parindent{2\ccwd}
    \renewcommand{\abstracttextfont}{\sffamily\small\noindent\ignorespaces}
    % 新定义的引用名称
    \newcommand{\keywords}[1]{\vskip2ex\par\noindent\normalfont{\bfseries 关键词: } #1}
    \renewcommand{\appendixtocname}{附录}
    \renewcommand{\appendixpagename}{附录}
    \renewcommand{\algorithmicrequire}{\textbf{输入：}}
    \renewcommand{\algorithmicensure}{\textbf{输出：}}

    \newcommand{\crefrangeconjunction}{~到~}
    \newcommand{\crefpairconjunction}{~和~}
    \newcommand{\crefmiddleconjunction}{、}
    \newcommand{\creflastconjunction}{~和~}
    \newcommand{\crefpairgroupconjunction}{~和~}
    \newcommand{\crefmiddlegroupconjunction}{、}
    \newcommand{\creflastgroupconjunction}{~和~}

    \crefname{equation}{式}{式}
    \crefname{figure}{图}{图}
    \crefname{table}{表}{表}
    \crefname{theorem}{定理}{定理}
    \crefname{lemma}{引理}{引理}
    \crefname{proposition}{命题}{命题}
    \crefname{corollary}{推论}{推论}
    \crefname{property}{性质}{性质}
    \crefname{definition}{定义}{定义}
    \crefname{conjecture}{猜想}{猜想}
    \crefname{example}{例}{例}
    \crefname{appendix}{附录}{附录}
    \crefname{algorithm}{算法}{算法}

    \crefname{chapter}{章}{章}
    \crefname{section}{节}{节}
    \crefname{subsection}{小节}{小节}

}{\relax}

% 设置英文环境名称
\ifdefstring{\SIMPLE@lang}{en}{
    \theoremstyle{plain}% default
    \newtheorem{theorem}{Theorem}[section] %
    \newtheorem{lemma}[theorem]{Lemma} %
    \newtheorem{proposition}[theorem]{Proposition} %
    \newtheorem*{corollary}{Corollary} %
    \theoremstyle{definition} %
    \newtheorem{definition}{Definition}[section] %
    \newtheorem{conjecture}{Conjecture}[section] %
    \newtheorem{example}{Example}[section] %
    \theoremstyle{remark} %
    \newtheorem*{remark}{Remark} %
    \newtheorem*{note}{Note} %
    \newtheorem{case}{Case} %
    \renewcommand*{\proofname}{\normalfont\bfseries Proof}%
    \newcommand\versiontext{\itshape Version: }%
    \newcommand\updatetext{\itshape Date: }%
    \setlength\parindent{2em}
    \renewcommand{\abstracttextfont}{\sffamily\small\noindent\ignorespaces}
    % newcommands defined in this template.
    \newcommand{\keywords}[1]{\vskip 2ex\par\noindent\normalfont{\bfseries Keywords: } #1}
    \newcommand\figref[1]{{\bfseries Figure~\ref{#1}}}
    \newcommand\tabref[1]{{\bfseries Table~\ref{#1}}}
    \newcommand{\ebibname}{Reference}
    \renewcommand{\algorithmicrequire}{\textbf{Input:}}
    \renewcommand{\algorithmicensure}{\textbf{Output:}}
}{\relax}

\renewcommand\tableofcontents{
    \hypersetup{linktoc=all, linkcolor=black}
    \section*{\contentsname\@mkboth{\MakeUppercase\contentsname
      }{\MakeUppercase\contentsname}}
    \@starttoc{toc}
}
