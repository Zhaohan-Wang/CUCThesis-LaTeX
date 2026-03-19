\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{CUCThesis}[isaac]
% 在 AtBeginDocument 阶段暂时把 \clearpage 设为无操作，避免某包在封面前先排出一页空白；正文开头调用 \CUCThesisRestoreClearpage 恢复
\let\CUCThesis@saved@clearpage\clearpage
\AtBeginDocument{\let\clearpage\relax}
\newcommand{\CUCThesisRestoreClearpage}{\let\clearpage\CUCThesis@saved@clearpage}
\usepackage{float}
\setlength{\parskip}{0pt} % 禁用默认段落间距
\setlength{\lineskip}{0pt} % 消除行间粘合间隙
\usepackage{setspace}
% 论文参数设置
\RequirePackage{pgfkeys}
\pgfkeys{
  % 论文类别
  Type/.store in = \CUCThesis@Type,
  % 页眉
  Header/.store in = \CUCThesis@Header,
  % 分类号
  Classification/.store in = \CUCThesis@Classification,
  % 密级
  Security/.store in = \CUCThesis@Security,
  % 学号
  StudentID/.store in = \CUCThesis@StudentID,
  % 中文论文题目（封面）
  TitleinCover/.store in = \CUCThesis@TitleinCover,
  % 英文论文题目（封面）
  TitleinCoverEN/.store in = \CUCThesis@TitleinCoverEN,
  % 中文论文题目（正文）
  TitleinBody/.store in = \CUCThesis@TitleinBody,
  % 英文论文题目（正文）
  TitleinBodyEN/.store in = \CUCThesis@TitleinBodyEN,
  % 申请人姓名
  Author/.store in = \CUCThesis@Author,
  % 指导教师
  Supervisor/.store in = \CUCThesis@Supervisor,
  % 专业名称
  Major/.store in = \CUCThesis@Major,
  % 研究方向
  Research/.store in = \CUCThesis@Research,
  % 所在学院
  College/.store in = \CUCThesis@College,
  % 提交日期
  Date/.store in = \CUCThesis@Date,
  % 中文关键词
  Keywords/.store in = \CUCThesis@Keywords,
  % 英文关键词
  KeywordsEN/.store in = \CUCThesis@KeywordsEN,
}
\newcommand{\setup}[1]{\pgfkeys{#1}}

% =============================== 论文版面设置 ===============================

% 调整为A4纸，小四号字；oneside 避免双面排版在奇数页前插入空白页
\LoadClass[a4paper, zihao=-4, openany, oneside]{ctexbook}

% 设置英文字体为 Times New Roman
\RequirePackage{fontspec}
\setmainfont{Times New Roman}

% 调整页边距为：左右边距为2.5CM，上下边距为3.5CM
\RequirePackage[left=2.5cm,right=2.5cm,top=3.5cm,bottom=3.5cm]{geometry}

\usepackage[colorlinks,            linkcolor=black,   urlcolor=black，         anchorcolor=blue,            citecolor=green            ]{hyperref}


% 页码页眉设置
\RequirePackage{fancyhdr}
\fancypagestyle{thesis}{
    \fancyhf{}
    \fancyhead[L]{\zihao{-5} \CUCThesis@Header}
    \fancyhead[R]{\zihao{-5} \leftmark}
    \renewcommand{\headrulewidth}{0.4pt}
    \fancyfoot[C]{\zihao{-5} \thepage}
}
\ctexset{chapter/pagestyle = thesis}
\pagestyle{thesis}

% 目录页强制无页眉：\tableofcontents 完成后立即设为 empty
\renewcommand{\tableofcontents}{%
  \chapter*{\contentsname
    \@mkboth{\MakeUppercase\contentsname}{\MakeUppercase\contentsname}}%
  \thispagestyle{empty}%
  \@starttoc{toc}%
}
\fancypagestyle{frontmatterstyle}{
    \fancyhf{}
    \fancyhead[L]{\zihao{-5} \CUCThesis@Header}
    \fancyhead[R]{\zihao{-5} 目 \quad 录}
    \renewcommand{\headrulewidth}{0.4pt}
}

\fancypagestyle{nofoot}{
    \fancyhf{}
    \fancyhead[L]{\zihao{-5} \CUCThesis@Header}
    \fancyhead[R]{\zihao{-5} \leftmark}
    \renewcommand{\headrulewidth}{0.4pt}
}
% 调整行间距
\RequirePackage{setspace}
% 正文行距：固定值 22pt（符合中传毕业论文规范）
\AtBeginDocument{%
  \setlength{\baselineskip}{22pt}%
}

\ctexset{
    chapter = {
        format     = \centering\CJKfamily{heiti}\zihao{3}, % 章标题：三号黑体居中
        name       = {第,章},
        number     = \chinese{chapter},
        aftername  = \hspace{1em},
        beforeskip = 22pt,   % 章前不额外加大间距（页面顶部已有天头）
        afterskip  = 44pt    % 章标题下空两行（2×22pt）
    },
    section = {
        format     = \centering\CJKfamily{heiti}\zihao{-3}, % 节标题：小三号黑体居中
        name       = {第,节},
        number     = \chinese{section},
        aftername  = \hspace{1em},
        beforeskip = 44pt,   % 节前空两行
        afterskip  = 22pt    % 节标题下空一行
    },
    subsection = {
        format     = \CJKfamily{heiti}\zihao{4}, % 条标题：四号黑体左起空两字
        name       = {},
        number     = \chinese{subsection}、,
        aftername  = \hspace{0em},
        beforeskip = 22pt,
        afterskip  = 0pt,
        indent     = 2em
    },
    subsubsection = {
        format     = \CJKfamily{heiti}\zihao{-4}, % 款标题：小四号黑体左起空两字
        name       = {（,）},
        number     = \chinese{subsubsection},
        aftername  = \hspace{0em},
        beforeskip = 0pt,
        afterskip  = 0pt,
        indent     = 2em
    }
}



% 插图
\RequirePackage{graphicx}
\RequirePackage{booktabs}
% 插图、公式、表格编号样式
\RequirePackage{caption}
\captionsetup{labelformat=default,labelsep=space, skip=5pt}

% 数学公式宏包
\RequirePackage{amsmath}


\RequirePackage{titlesec}

% 列举
\RequirePackage{enumitem}

% 目录
\RequirePackage{tocloft}
\setcounter{tocdepth}{2}  % 只显示到 subsection（第三级）

% 目录标题：黑体三号加粗居中，"目 录"中间一个空格
\renewcommand{\contentsname}{}
\renewcommand{\cfttoctitlefont}{\hfill\CJKfamily{heiti}\bfseries\zihao{3}}
\renewcommand{\cftaftertoctitle}{\hfill}
\setlength{\cftbeforetoctitleskip}{0pt}
\setlength{\cftaftertoctitleskip}{2em}
\AtBeginDocument{\renewcommand{\contentsname}{目\hspace{1em}录}}

% 点线
\renewcommand{\cftchapleader}{\cftdotfill{0.6}}
\renewcommand{\cftsecleader}{\cftdotfill{0.6}}
\renewcommand{\cftsubsecleader}{\cftdotfill{0.6}}

% 缩进：章顶格，节一级缩进，子节二级缩进
\cftsetindents{chapter}{0em}{0em}
\cftsetindents{section}{2em}{0em}
\cftsetindents{subsection}{4em}{0em}

% 章一级：黑体四号不加粗，段后 10pt
\renewcommand{\cftchapfont}{\heiti\zihao{4}}
\renewcommand{\cftchappagefont}{\heiti\zihao{4}}
\setlength{\cftbeforechapskip}{0pt}
\renewcommand{\cftchapafterpnum}{\vspace{3.5pt}}

% 节一级：黑体小四，段后 8pt
\renewcommand{\cftsecfont}{\heiti\zihao{-4}}
\renewcommand{\cftsecpagefont}{\heiti\zihao{-4}}
\setlength{\cftbeforesecskip}{0pt}
\renewcommand{\cftsecafterpnum}{\vspace{2.5pt}}

% 子节一级：宋体小四，段后 8pt
\renewcommand{\cftsubsecfont}{\songti\zihao{-4}}
\renewcommand{\cftsubsecpagefont}{\songti\zihao{-4}}
\setlength{\cftbeforesubsecskip}{0pt}
\renewcommand{\cftsubsecafterpnum}{\vspace{2.5pt}}


% 插图清单
\newcommand{\listoffiguresandtables}{
  \def\listfigurename{插图清单}%
  % \def\listtablename{附表清单}%

  \let\oldnumberline\numberline
  \renewcommand{\numberline}{图~\oldnumberline}

  % 调整插图清单这几个字的格式
  \renewcommand{\cftloftitlefont}{\hfill\heiti\zihao{3}\bfseries}
  \renewcommand{\cftafterloftitle}{\hfill}

  \renewcommand{\cftfigleader}{\cftdotfill{0.6}}
  \renewcommand{\cfttableader}{\cftdotfill{0.6}}

  \renewcommand{\cftlottitlefont}{\hfill\heiti\zihao{3}\bfseries}
  \renewcommand{\cftafterlottitle}{\hfill}

  \vspace*{-5em}
  \phantomsection     % 超链接
  \markboth{插图清单}{}
  \addcontentsline{toc}{chapter}{插图清单}
  \listoffigures
  \thispagestyle{thesis}
  \clearpage
  \renewcommand{\numberline}{表~\oldnumberline}
  \vspace*{-5em}
  \phantomsection     % 超链接
  \markboth{附表清单}{}
  \addcontentsline{toc}{chapter}{附表清单}
  \listoftables
  \thispagestyle{thesis}
  \let\numberline\oldnumberline
  \clearpage
}


% 内容模板
% 封面
\newcommand{\dunderline}[3][-6pt]{{
  \setbox0=\hbox{#3}
  \ooalign{\copy0\cr\rule[\dimexpr#1-#2\relax]{\wd0}{#2}}
}}

\newcommand{\datebox}[2]{
    \hspace{1.4cm}{\CJKfamily{songti}\bfseries\zihao{3}\selectfont{#1~\dunderline{1pt}{\makebox[6cm][c]{#2}}}}
}

\RequirePackage{xcolor}
\RequirePackage{tabularray}
\RequirePackage[normalem]{ulem}
\renewcommand\ULthickness{1pt} 
\RequirePackage{xparse}
\RequirePackage{xstring}

\NewDocumentCommand{\customtitle}{m}{%
  \def\do##1{\uline{\hfill{##1}\hfill}\par}%
  \docsvlist{#1}%
}

\newcommand{\coverpage}{
  \begin{titlepage}

    \vspace*{-1cm}
  
    \noindent
    \begin{tblr}{
      rows = {8mm},
      colspec = {X[1]X[3]X[0.5]X[1]X[2]},
      width = \textwidth
      }
      分类号: & \uline{\hfill \CUCThesis@Classification \hfill} & & 单位代码: & \uline{ \hfill 10033 \hfill} \\
      密 \hspace*{0.5em} 级: & \uline{\hfill \CUCThesis@Security \hfill} & & 学 \hspace*{1.4em} 号: & \uline{\hfill \CUCThesis@StudentID \hfill} \\
    \end{tblr}


    \vspace*{0.6cm}
    \vfill

    % 插入一张图
    \begin{figure}[htbp]
      \centering
      \includegraphics[width=0.48\textwidth]{coverimg/CUCText.png}
    \end{figure}

    \vspace*{-3mm}
    \centering\zihao{-1}\songti{ \CUCThesis@Type }
    
    \vspace{0.6cm}
    \vfill

    \begin{figure}[htbp]
      \centering
      \includegraphics[width=0.18\textwidth]{coverimg/CUCLogo.png}
    \end{figure}

    \vfill

    \noindent
    \zihao{-3}{\CJKfamily{songti}\bfseries
    \begin{tblr}{
      colspec = {cX},
      }
      中文论文题目: & \CUCThesis@TitleinCover \\
      英文论文题目: & \CUCThesis@TitleinCoverEN \\
    \end{tblr}
    }
    
    \vspace{10mm}
    \vfill

    \noindent \centering
    \begin{tblr}{
      colspec = {cX},
      width = 0.65\textwidth,
      }
      申请人姓名: & \uline{\hfill \CUCThesis@Author \hfill} \\
      指导教师: & \uline{\hfill \CUCThesis@Supervisor \hfill} \\
      专业名称: & \uline{\hfill \CUCThesis@Major \hfill} \\
      研究方向: & \uline{\hfill \CUCThesis@Research \hfill} \\
      所在学院: & \uline{\hfill \CUCThesis@College \hfill} \\
    \end{tblr}

    \vspace{8mm}

    \centering
    \datebox{论文提交日期}{\CUCThesis@Date}
  \end{titlepage}
  % 去掉 \clearpage，避免封面和独创性声明之间多出一页空白
}

% 中国传媒大学研究生学位论文独创性声明
\newcommand\copyrightpage[1][]{%
  \thispagestyle{empty}%
  \begin{center}
    \zihao{3} \songti 中国传媒大学研究生学位论文独创性声明
  \end{center}

  \vspace{1.5em}

  \setlength{\parindent}{2em}%
  \indent 本学位论文作者声明所呈交的学位论文是本人在导师指导下进行的研究工作及取得的研究成果。除了文中特别加以标注和致谢的地方外，论文中不包含其他人已经发表或撰写过的研究成果，也不包含为获得\underline{\,{\CJKfamily{kaiti}\bfseries 中国传媒大学}\,}或其他教育机构的学位或证书而使用过的材料。其他个人或组织对本研究所做的任何贡献，均已在论文中作了明确的说明并表示谢意。

  \vspace{2em}

  \noindent
  \begin{minipage}[t]{0.5\textwidth}
    作者签名：\hspace{6em}\\[1.8em]
    签字日期：\hspace{3em}年\hspace{2em}月\hspace{2em}日
  \end{minipage}%
  \begin{minipage}[t]{0.5\textwidth}
    导师签名：\hspace{6em}\\[1.8em]
    签字日期：\hspace{3em}年\hspace{2em}月\hspace{2em}日
  \end{minipage}

  \vspace{4em}

  \begin{center}
    \zihao{3} \songti 学位论文版权使用授权书
  \end{center}

  \vspace{1.5em}

  \indent 本学位论文作者完全了解\underline{\,{\CJKfamily{kaiti}\bfseries 中国传媒大学}\,}有权保留并向国家有关部门或机构送交本论文的复印件和电子版，允许论文被查阅和借阅。论文作者授权\underline{\,{\CJKfamily{kaiti}\bfseries 中国传媒大学}\,}可以将学位论文的全部或部分内容编入有关数据库进行检索和传播，可以采用影印、缩印、扫描或拷贝等复制手段保存、汇编学位论文。

  \indent（保密的学位论文在解密后适用本授权书）

  \vspace{2em}

  \noindent
  \begin{minipage}[t]{0.5\textwidth}
    作者签名：\hspace{6em}\\[1.8em]
    签字日期：\hspace{3em}年\hspace{2em}月\hspace{2em}日
  \end{minipage}%
  \begin{minipage}[t]{0.5\textwidth}
    导师签名：\hspace{6em}\\[1.8em]
    签字日期：\hspace{3em}年\hspace{2em}月\hspace{2em}日
  \end{minipage}

  \clearpage
}

% 人工智能使用诚信声明页
\newcommand\aistatementpage{%
  \thispagestyle{empty}%
  \begin{center}
    {\CJKfamily{heiti}\bfseries\zihao{-2} 中国传媒大学}\\[0.1em]
    {\CJKfamily{heiti}\bfseries\zihao{-2} 研究生学位论文人工智能使用诚信声明}
  \end{center}

  \vspace{0.8em}

  \setlength{\parindent}{2em}%

  \begin{center}
    {\CJKfamily{songti}\bfseries\zihao{-3} 关于未使用人工智能的诚信声明}
  \end{center}

  \vspace{0.5em}

  \indent 本学位论文作者郑重承诺：本人在学位论文（设计）的撰写过程中，未使用任何人工智能辅助工具；所有内容均基于个人研究、文献阅读及实验数据，学位论文中不存在任何人工智能辅助生成的内容，参考文献中不含AI为作者的论文。本人深知学术诚信的重要性，如经查实存在违法违规使用人工智能的情况或未声明的使用行为，本人自愿承担由此导致的学术不端责任。

  \vspace{1.5em}

  \noindent
  \begin{minipage}[t]{0.5\textwidth}
    作者签名：\hspace{6em}\\[1.8em]
    签字日期：\hspace{3em}年\hspace{2em}月\hspace{2em}日
  \end{minipage}%
  \begin{minipage}[t]{0.5\textwidth}
    导师签名：\hspace{6em}\\[1.8em]
    签字日期：\hspace{3em}年\hspace{2em}月\hspace{2em}日
  \end{minipage}

  \vspace{3em}

  \begin{center}
    {\CJKfamily{songti}\bfseries\zihao{-3} 关于使用人工智能的诚信声明}
  \end{center}

  \vspace{0.5em}

  \indent 本学位论文作者郑重承诺：关于人工智能使用情况的声明和陈述真实无误，已对使用此类技术的所有细节进行了全面且诚实的报告（详见附录中《关于人工智能使用的声明》）；对于人工智能辅助完成的内容，已进行严格审查和修改，参考文献中不含AI为作者的论文；作品中根据实际情况已添加了显式标识或隐式标识。本人深知学术诚信的重要性，如经查实存在违法违规使用人工智能的情况或未声明的使用行为，本人自愿承担由此导致的学术不端责任。

  \vspace{1.5em}

  \noindent
  \begin{minipage}[t]{0.5\textwidth}
    作者签名：\hspace{6em}\\[1.8em]
    签字日期：\hspace{3em}年\hspace{2em}月\hspace{2em}日
  \end{minipage}%
  \begin{minipage}[t]{0.5\textwidth}
    导师签名：\hspace{6em}\\[1.8em]
    签字日期：\hspace{3em}年\hspace{2em}月\hspace{2em}日
  \end{minipage}

  \clearpage
}

% 关于人工智能使用的声明（附录页）
\newcommand\aiusagepage{%
  \thispagestyle{empty}%
  \setlength{\parindent}{2em}%

  \begin{center}
    % 标题：微软雅黑小三加粗带下划线（\CJKfontspec 直接指定 CJK 字体）
    {\zihao{-3}\CJKfontspec{Microsoft YaHei}\underline{（研究生姓名）关于人工智能使用的声明}}
  \end{center}

  \vspace{1em}

  % 楷体段落：单倍行距
  {\setstretch{1.0}\zihao{-4}\CJKfamily{kaiti}%
  \indent 须对人工智能辅助生成内容做出客观、全面、真实的说明，须明确说明在文中的确切位置，AI工具信息（名称、版本等）、详细使用过程以及作用。可能的应用包括但不限于用AI工具收集和分析数据、制作图片或论文中的图形元素、生成程序算法、辅助作品设计、生成文本或进行文字润色等。{\color{red}如未按照实际情况予以说明，则视为违规使用。}\par}

  \vspace{1.5em}

  % 参考示例标注：红色，"参考示例"为正体，括号内为斜体
  \noindent{\color{red}\zihao{-4}\textbf{参考示例}\textit{（正式填写时请将参考示例删除）}：}

  \vspace{0.5em}

  % 示例正文：灰色宋体，单倍行距
  {\setstretch{1.0}\color{gray}\zihao{-4}\songti%
  \indent 本人在学位论文（设计）的撰写过程中，使用了人工智能工具来辅助论文撰写等工作。具体包括：\par
  \indent 1.第**章"**"的撰写中，使用**工具**版本，对第*节第*段文字进行润色。本文在该生成文本的基础上，对***进行了修改。\par
  \indent 2.第**章"**"的图*中，使用**工具**版本，进行了图片生成，提示词为：***。本文在该图片基础上，对***进行了修改。\par
  \indent ……\par}

  % 签名区：正文后空三行，不放页底
  \vspace{3\baselineskip}

  \noindent\hfill 研究生（本人签字）：\hspace{6em}

  \vspace{2em}

  \noindent\hfill 年\hspace{3em}月\hspace{3em}日\hspace{2em}

  \clearpage
}

\newenvironment{cnabstract}[1][关键词]{
  \phantomsection     % 超链接
  \markboth{摘 \quad 要}{}
  % 罗马数字页码
  \pagenumbering{Roman}
  % 居中
  \setup{
  % 中文关键词
  Keywords = #1,
  }

  \begin{center}
    \heiti\zihao{3} \bfseries \CUCThesis@TitleinBody
  \end{center}

  \vspace{\baselineskip}

  \begin{center}
    \heiti\zihao{-3} \bfseries 摘 \quad 要
  \end{center}

  \vspace{\baselineskip}

}{

  \vspace{\baselineskip}
  \noindent{\heiti\zihao{4} 关键词：}\CUCThesis@Keywords
  \clearpage
}

% 英文摘要（不在此处 \clearpage，紧接中文摘要后，避免多出空白页）
\newenvironment{enabstract}[1][Keywords]{
  \phantomsection     % 超链接
  \markboth{ABSTRACT}{}
  \setup{
  % 英文关键词
  KeywordsEN = #1,
  }

  % 标题全大写，两侧各留约 2.8cm（≈5个三号字宽）边距
  \begin{center}
    \begin{minipage}[t]{0.64\textwidth}
      \centering
      \zihao{3} \bfseries \MakeUppercase{\CUCThesis@TitleinBodyEN}
    \end{minipage}
  \end{center}

  % 标题到 ABSTRACT 空三行
  \vspace{3\baselineskip}

  \begin{center}
    \zihao{4} \bfseries ABSTRACT
  \end{center}

  % ABSTRACT 到正文空两行
  \vspace{2\baselineskip}

}{
  % 正文到 KEYWORDS 空两行
  \vspace{2\baselineskip}

  \noindent
  {\zihao{4} \bfseries KEYWORDS:}~~%
  \edef\CUCThesis@TmpKW{\CUCThesis@KeywordsEN}%
  \StrSubstitute{\CUCThesis@TmpKW}{;}{~~~}[\CUCThesis@KWResult]%
  \textit{\MakeLowercase{\CUCThesis@KWResult}}
  \clearpage
}


% 参考文献
\RequirePackage[backend=biber,hyperref=true,sorting=none,style=gb7714-2015,url=false,gbtype=true]{biblatex}
\ExecuteBibliographyOptions{
  gbnamefmt = lowercase,
  gbpub     = false,
  gbalign   = left,
}
% 脚注字号设为小五号
\renewcommand{\footnotesize}{\zihao{-5}}
% 脚注编号格式：正文处上标显示 [n]，脚注区域内平排显示 [n]（不作上标）
\renewcommand{\thefootnote}{[\arabic{footnote}]}
\renewcommand{\@makefnmark}{\textsuperscript{\normalfont\thefootnote}}
\renewcommand{\@makefntext}[1]{%
  \noindent\hspace{2em}{\normalfont\thefootnote}\enspace#1}
% \citefoot{key}：正文处显示脚注编号上标，当页脚注输出完整文献信息
% 不使用 \supercite（避免两套编号并列），只用脚注编号作为正文标注
\newcommand{\citefoot}[1]{\footnote{\zihao{-5}\fullcite{#1}}}

\newenvironment{reference}{
  \clearpage
  \phantomsection
  \markboth{参考文献}{}
  \addcontentsline{toc}{chapter}{参考文献}
  \begin{center}
    \CJKfamily{heiti}\zihao{3} 参\quad 考\quad 文\quad 献
  \end{center}

}{}

% 作者简历及在学期间所取得的科研成果
\newenvironment{resume}{
  \clearpage
  \phantomsection     % 超链接
  \markboth{作者简历及在学期间所取得的科研成果}{}
  \addcontentsline{toc}{chapter}{作者简历及在学期间所取得的科研成果}
  % 居中
  \begin{center}
    \heiti\zihao{3} \bfseries 作者简历及在学期间所取得的科研成果
  \end{center}

  \newlist{achievements}{enumerate}{1}
  \setlist[achievements]{
    label      = [\arabic*],
    align      = left,
    leftmargin = 10mm,
    topsep     = 6bp,
    parsep     = 0bp,
    partopsep  = 0bp,
    itemsep    = 6bp,
    labelsep   = !,
    resume     = achievements,
  }
  \ctexset{
    section = {
      format    += \centering,
      numbering = false,
    },
    subsection = {
      format     += \centering,
      numbering  = false,
    },
  }%
}{}

% 附录环境设置
\newenvironment{my_appendix}{
  \clearpage
  \phantomsection
  \markboth{附 \quad 录}{}
  \addcontentsline{toc}{chapter}{附 \quad 录}
  \thispagestyle{nofoot}
  \begin{center}
    \CJKfamily{heiti}\zihao{3} 附 \quad 录
  \end{center}
  % 局部修改section样式
  \ctexset{
    section = {
      format = \centering \zihao{-3} \heiti,
      name = 附录,
      number = \chinese{section},
      aftername = \hspace{1em}, % 附录编号与标题间距
      beforeskip = 24bp,
      afterskip = 12bp
    }
  }
  \setcounter{section}{0} % 重置计数器从"一"开始
}{}

% 致谢
\newenvironment{acknowledgements}{
  \clearpage
  \phantomsection
  \markboth{致谢}{}
  \addcontentsline{toc}{chapter}{致谢}
  \thispagestyle{nofoot}
  \begin{center}
    \CJKfamily{heiti}\zihao{3} 致\quad 谢
  \end{center}

}{}