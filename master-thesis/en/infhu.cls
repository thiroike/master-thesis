\NeedsTeXFormat{pLaTeX2e}
\ProvidesClass{infhu}
  [2022/11/17 Akira Furui]
\newif\ifdraft
\DeclareOption{draft}{\drafttrue}
\DeclareOption{final}{\draftfalse}
\newif\ifjisfont
\jisfonttrue
\DeclareOption{mingoth}{\jisfontfalse}
\newif\ifwinjis
\winjisfalse
\DeclareOption{winjis}{\winjistrue}
\newif\iftombow
\tombowfalse
\DeclareOption{tombow}{\tombowtrue}
\newif\iftombo
\tombofalse
\DeclareOption{tombo}{\tombotrue}
\newif\ifmentuke
\mentukefalse
\DeclareOption{mentuke}{\mentuketrue}
\DeclareOption{oneside}{\@twosidefalse}
\DeclareOption{twoside}{\@twosidetrue}
\newif\ifpapersize
\papersizefalse
\DeclareOption{papersize}{\papersizetrue}
\newif\if@english
\@englishfalse
\DeclareOption{english}{\@englishtrue}
\newif\if@undergraduate
\DeclareOption{bachelor}{\@undergraduatetrue}
\DeclareOption{master}{\@undergraduatefalse}
\ExecuteOptions{final,twoside,mi,bachelor}
\ProcessOptions
\LoadClass[a4paper,dvipdfmx,onecolumn,titlepage,12pt
\ifdraft ,draft\else ,final\fi%
\ifwinjis ,winjis\else\ifjisfont\else ,mingoth\fi\fi%
\iftombow ,tombow\else\iftombo ,tombo\else\ifmentuke ,mentuke\fi\fi\fi%
\if@twoside ,twoside,openright\else ,oneside,openany\fi%
\ifpapersize ,papersize\fi%
\if@english ,english\fi%
]{jsarticle}


\iftombowdate
  \newcount\@totalpage
  \def\@lastoftotalpage{?}
  \AtEndDocument{\protected@write\@auxout{\let\the\relax}%
      {\gdef\string\@lastoftotalpage{\the\@totalpage}}}
  \def\@put@totalpage{\global\advance\@totalpage1
      \raise4pt\hbox to\z@{\hss
          \@bannerfont page \the\@totalpage\ of \@lastoftotalpage.\hskip5mm}}
  \AtBeginDocument{%
      \let\@@TR\@TR
      \def\@TR{\@@TR\@put@totalpage}}
\fi
\setlength{\fullwidth}{\paperwidth}
\addtolength{\fullwidth}{-36mm}
\@tempdima=1zw
\divide\fullwidth\@tempdima \multiply\fullwidth\@tempdima
\ifdim \fullwidth>42zw
  \setlength{\fullwidth}{42zw}
\fi
\setlength{\textwidth}{0.92\fullwidth}
\setlength{\oddsidemargin}{\paperwidth}
\addtolength{\oddsidemargin}{-\textwidth}
\setlength{\oddsidemargin}{.5\oddsidemargin}
\iftombow
  \addtolength{\oddsidemargin}{-1in}
\else
  \addtolength{\oddsidemargin}{-1truein}
\fi
\setlength{\evensidemargin}{\oddsidemargin}
\def\ps@plainhead{%
  \let\@mkboth\@gobbletwo
  \let\@oddfoot\@empty
  \let\@evenfoot\@empty
  \def\@oddhead{\hbox to \fullwidth{\hfil%
      {\small\textbf{\headfont\thepage}}}\hss}
  \if@twoside
    \def\@evenhead{\hss \hbox to \fullwidth{%
        {\small\textbf{\headfont\thepage}}\hfil}}
  \else
    \let\@evenhead\@oddhead
  \fi
}

\def\ps@headings{%
  \let\@oddfoot\@empty
  \let\@evenfoot\@empty
  \if@twoside
    \def\@oddhead{\hbox to \fullwidth{\hfil%
        {\small\headfont\rightmark\qquad\textbf{\thepage}}}\hss}%
    \def\@evenhead{\hss \hbox to \fullwidth{%
        {\small\headfont\textbf{\thepage}\qquad\leftmark}\hfil}}%
  \else
    \def\@oddhead{\hbox to \fullwidth{\hfil%
        {\small\headfont\leftmark\qquad\textbf{\thepage}}}\hss}%
    \let\@evenhead\@oddhead
  \fi
  \let\@mkboth\markboth
  \def\chaptermark##1{\markboth{%
    \ifnum \c@secnumdepth >\m@ne
      \if@mainmatter
        \@chapapp\thechapter\@chappos\hskip1zw
      \fi
    \fi
    ##1}{}}%
  \def\sectionmark##1{\markright{%
    \ifnum \c@secnumdepth >\z@ \thesection \hskip1zw\fi
    ##1}}}%
\renewenvironment{titlepage}{%
  \cleardoublepage
  \newpage
  \thispagestyle{empty}%
  \setcounter{page}\@ne
}%
{\newpage}
\newcommand*{\titlewidth}[1]{\gdef\title@width{#1}}% #1:タイトル幅
\gdef\title@width{\hsize}
\newcommand*{\studentid}[1]{\gdef\@studentid{#1}}% #1: 学籍番号
\renewcommand{\and}{\\ &}% 
\newcommand*{\supervisor}[1]{\gdef\@supervisor{#1}}% #1: 指導教員名
\gdef\@supervisor@prefix{\if@english Supervisor\else 指導教員\fi}
\newcommand*{\handin}[3]{\year #1 \month #2 \day #3}% #1: 年, #2: 月, #3: 日
\newcommand*{\eauthor}[1]{\gdef\@eauthor{#1}}% #1: 著者名英語つづり
\newcommand*{\email}[1]{\gdef\authors@email{#1}}% #1: e-mail アドレス
\newcommand*{\keywords}[1]{\gdef\@keywords{#1}}% #1: キーワード
\if@undergraduate
  \if@english
    \gdef\@subtitle{Bachelor's~Thesis}
    \gdef\@belongsto{Data Science Course\\%
    School of Informatics and Data Science\\%
    Hiroshima University}%
  \else
    \gdef\@subtitle{卒業論文}
    \gdef\@belongsto{広島大学 情報科学部 情報科学科\\%
        データサイエンスコース}%
  \fi
\else
  \if@english
    \gdef\@belongsto{Informatics and Data Science Program\\%
      Graduate School of Advanced Science and Engineering\\%
      Hiroshima University}%
  \else
    \gdef\@belongsto{広島大学 大学院先進理工系科学研究科 \\%
        情報科学プログラム}%
  \fi
  \if@english
    \gdef\@subtitle{Master's~Thesis}
  \else
    \gdef\@subtitle{修士論文}
  \fi
\fi
\renewcommand{\maketitle}{%
  \global\let\thanks\relax
  \global\let\@thanks\@empty
  \begin{titlepage}%
    \let\footnote\relax
    \null\vskip50\p@

    \begin{center}
      {\headfont\large \@subtitle \par}
    \end{center}%

    \begin{center}\headfont\huge%
      \parbox{\title@width}{\begin{center}\@title\end{center}}%
    \end{center}
    \vfill
    \begin{center}
      \large\headfont
      {\begin{tabular}[t]{rl}%
        \ifx\@studentid\@undefined\else\@studentid\fi &
          {\Large\@author} \\[16\p@]
        \@supervisor@prefix & \@supervisor
      \end{tabular}\par}%
      \vskip 2cm
      {\@date\par}%
      \vskip 2cm
      {\@belongsto \par}%
    \end{center}\par
    \@thanks%
    \vskip60\p@\null
    \newpage\clearpage
    \thispagestyle{empty}
    \setcounter{page}{0}
    \null\vfill
    \begin{flushleft}
      Copyright {\copyright} {\number\year},~%
      \ifx\@eauthor\@undefined \@author\else\@eauthor\fi.
    \end{flushleft}\par
    \vskip60\p@\null
  \end{titlepage}
  \setcounter{footnote}{0}%
  \global\let\maketitle\relax
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\subtitle\relax
  \global\let\title\relax
  \global\let\supervisor\relax
  \global\let\belongto\relax
  \global\let\email\relax
  \global\let\eauthor\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
}

% \renewcommand{\figurename}{Fig.~}
% \renewcommand{\tablename}{Table~}
\def\fnum@figure{Fig. \thefigure.}
\def\fnum@table{Table \thetable.}
\newcommand{\argmax}{\mathop{\mathrm{arg~max}}\limits}
\newcommand{\argmin}{\mathop{\mathrm{arg~min}}\limits}


\renewenvironment{thebibliography}[1]{%
  \global\let\presectionname\relax
  \global\let\postsectionname\relax
  \section*{\refname}\@mkboth{\refname}{}%
  \list{\@biblabel{\@arabic\c@enumiv}}%
       {\settowidth\labelwidth{\@biblabel{#1}}%
        \leftmargin\labelwidth
        \advance\leftmargin\labelsep
        \@openbib@code
        \usecounter{enumiv}%
        \let\p@enumiv\@empty
        \renewcommand\theenumiv{\@arabic\c@enumiv}}%
  \sloppy
  \clubpenalty4000
  \@clubpenalty\clubpenalty
  \widowpenalty4000%
  \sfcode`\.\@m}
  {\def\@noitemerr
    {\@latex@warning{Empty `thebibliography' environment}}%
  \endlist}