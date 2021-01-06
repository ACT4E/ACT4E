\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{presentationclass}[Beamer class]

% Packages
\RequirePackage[utf8]{inputenc}
\RequirePackage{amsthm,amssymb,amsmath}
\RequirePackage{mathtools,dsfont}
\RequirePackage{xcolor,color}
\RequirePackage{etoolbox}
\RequirePackage{pifont}
\RequirePackage{ifthen}
\RequirePackage{stmaryrd}
\RequirePackage{units}
\RequirePackage{adjustbox}
\RequirePackage{amssymb}
\RequirePackage{appendixnumberbeamer}
\RequirePackage{graphicx,epstopdf}
\graphicspath{Presentation/pics}
% Default options
\newbool{showOutline}
\setbool{showOutline}{true}
\newbool{stanfordTheme}
\setbool{stanfordTheme}{false}

% Options
\DeclareOption{no outline}    {\setbool{showOutline}{false}}
\DeclareOption{outline=false} {\setbool{showOutline}{false}}
\DeclareOption{stanford}	      {\setbool{stanfordTheme}{true}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{beamer}}
\ProcessOptions*\relax

% Load class
%\LoadClass[compress,handout]{beamer}
\LoadClass[compress]{beamer}

% Hypereff
\hypersetup{colorlinks=false}

% Clever references
\RequirePackage[capitalise,noabbrev]{cleveref}

% Enumerate
%\RequirePackage{enumitem}
\RequirePackage{enumerate}

% Tables
\RequirePackage{multirow}
\RequirePackage{multicol}
\RequirePackage{booktabs}

% Boxes
\RequirePackage[skins]{tcolorbox}

% Glossary
\RequirePackage[acronym,nomain,nonumberlist]{glossaries}

% Date
\RequirePackage[nodayofweek]{datetime}

% Units
\RequirePackage[per-mode=symbol]{siunitx}
\DeclareSIUnit\eur{\euro}
\DeclareSIUnit\usd{USD}
\DeclareSIUnit{\mph}{mph}
\DeclareSIUnit\month{month}

% Page number
\newcommand{\backupbegin}{
   \newcounter{finalframe}
   \setcounter{finalframe}{\value{framenumber}}
}
\newcommand{\backupend}{
   \setcounter{framenumber}{\value{finalframe}}
}

% Colors
\definecolor{stanfordRed}{RGB}{31,64,122}
\definecolor{stanfordGrey}{RGB}{77,79,83}

% Tikz
\RequirePackage{tikz,pgfplots,grffile}
\pgfplotsset{compat=newest}
\usetikzlibrary{positioning,intersections,patterns,calc,shadows,shapes,arrows.meta,external,cd,math,decorations.markings,decorations.pathmorphing, decorations.pathreplacing,}
\usepgfplotslibrary{patchplots,external,statistics}
\tikzstyle{boxCommentPlot}=[rectangle,very thick,draw=stanfordRed,rounded corners,align=center,font=\normalsize,inner sep=8pt]



\tikzcdset{arrow style=tikz, diagrams={>=To}}

\tikzset{
    invisible/.style={opacity=0},
    visible on/.style={alt={#1{}{invisible}}},
    alt/.code args={<#1>#2#3}{%
      \alt<#1>{\pgfkeysalso{#2}}{\pgfkeysalso{#3}}%
  }
}

% Tikz
\usetikzlibrary{positioning,intersections, hobby, patterns, calc, decorations.pathmorphing, decorations.markings, shadows,shapes, cd,arrows.meta, fit,quotes}
\usepackage{bm}



\tikzstyle{block} = [draw, rectangle, minimum height=2em, minimum width=3em,rounded corners,thick, font=\bfseries]
\tikzstyle{block1} = [draw, rectangle, minimum height=1.5em, minimum width=2.5em]
\tikzstyle{blockDyn} = [draw, rectangle, minimum height=2.5em, minimum width=3.5em, align=center, inner sep=10pt, thick, fill=white, copy shadow={draw=black,fill=black,opacity=1,shadow xshift=0.5ex,shadow yshift=-0.5ex}]
\tikzstyle{blockAlg} = [draw, rectangle, minimum height=1.5em, minimum width=2.5em, align=center, inner sep=10pt, thick]
\tikzstyle{sum} = [draw,circle]
\tikzstyle{arrowRes} = [draw,circle,color=red,scale=0.4,fill=red]
\tikzstyle{arrowFun} = [draw,circle,color=green,scale=0.4,fill=green]
\tikzstyle{nodePre} = [circle, draw,inner sep=1pt,node contents={$\preceq$},thick]
\tikzstyle{nodePreEmpty} = [circle, draw,inner sep=1pt,thick]
\tikzstyle{nodePos} = [circle, draw,inner sep=1pt,node contents={$\posceq$},thick]
\tikzstyle{nodeProd} = [rectangle, draw,inner sep=4pt,node contents={$\times$},rounded corners,thick]
\tikzstyle{nodeSum} = [rectangle, draw,inner sep=4pt,node contents={$\mathbf{+}$},rounded corners,thick]

\pgfplotsset{every axis/.append style={tick label style={font=\scriptsize},
                                       legend style={font=\scriptsize}, %,inner sep=2pt,outer sep=2pt},
                                       /pgf/number format/use comma,
	                                   compat=1.7
	                                   },
	         every axis/.append style={font={\footnotesize}},
             }

\renewcommand\mathrm\text

% TIKZ
\tikzstyle{block} = [draw, rectangle, minimum height=2em, minimum width=3em,font=\bfseries,rounded corners,thick]
\tikzstyle{block} = [draw, rectangle, minimum height=2em, minimum width=3em]

\tikzstyle{sum} = [draw,circle]
%\tikzstyle{arrowRes} = [draw,circle,color=red,scale=0.4,fill=red]
%\tikzstyle{arrowFun} = [draw,circle,color=green,scale=0.4,fill=green]
\tikzstyle{nodePre} = [circle, draw,inner sep=1pt,node contents={$\preceq$}]
\tikzstyle{nodePos} = [circle, draw,inner sep=1pt,node contents={$\posceq$}]
\tikzstyle{nodeProd} = [rectangle, draw,inner sep=4pt,node contents={$\times$}]
\tikzstyle{nodeSum} = [rectangle, draw,inner sep=4pt,node contents={$+$}]

\definecolor{DPgreen}{RGB}{34,139,34}
% TIKZ

\tikzset{fcname/.store in =\fcname, fcname={}}
\tikzset{funame/.store in =\funame, funame={}}
\tikzset{rcname/.store in =\rcname, rcname={}}
\tikzset{runame/.store in =\runame, runame={}}
\tikzset{whereres/.store in =\whereres, whereres=0.5}
\tikzset{wherefun/.store in =\wherefun, wherefun=0.5}
\tikzset{relres/.store in =\relres, relres={above}}
\tikzset{relfun/.store in =\relfun, relfun={above}}
\tikzset{posres/.store in =\posres, posres=0.25}
\tikzset{posfun/.store in =\posfun, posfun=0.25}
\tikzset{loos/.store in =\loos, loos=2}
\tikzset{feedback/.store in =\feedback, feedback=0}
\tikzset{
   DP/.style={%everything after equals replaces "DP" in key.
      %every to/.style={out=0,in=180,draw},
      label/.style={
         font=\everymath\expandafter{\the\everymath\scriptstyle},
         inner sep=5pt,
         node distance=2pt and -2pt},
      semithick,
      node distance=1 and 1,
      rconn/.style={color=white,opacity=0.0,postaction={decorate}, shorten <=3.2pt, shorten >= 0.8,
      decoration={markings,
      mark= at position 0 with {
               \coordinate (a);
      },
      mark=at position .5 with
      {
              \ifthenelse{\equal{\feedback}{1}}{\def\angleOut{90}\def\angleIn{90}}{\def\angleOut{0}\def\angleIn{180}}
              \coordinate (b);
              \draw[dashed,dpred,opacity=1.0] (a) to[out=\angleOut,in=\angleIn,looseness=\loos]
              node[pos=\posres,\relres=\whereres mm,dpred,opacity=1,fill=white,inner sep=1pt,outer sep=1pt]{\footnotesize{\rcname}} (b);
      },
      mark= at position 1 with
      {
             \ifthenelse{\equal{\feedback}{1}}{\def\angleOut{0}\def\angleIn{0}}{\def\angleOut{180}\def\angleIn{0}}
              \ifthenelse{\equal{\feedback}{1}}{\def\symbol{\succeq}}{\def\symbol{\preceq}}
              \coordinate (c);
              \draw[dpgreen,opacity=1.0] (c) to[out=\angleOut,in=\angleIn,looseness=\loos]
              node[pos=\posfun,\relfun=\wherefun mm,dpgreen,opacity=1,fill=white,inner sep=1pt,outer sep=1pt]{\footnotesize{\fcname}} (b){}; %bend right
              \node[draw,circle,inner sep=0.5pt,color=black,fill=white,opacity=1.0] at (b) (nodepreceq) {$\symbol$};
      }
      }},
      runconn/.style={color=dpred,dashed,postaction={decorate},
      decoration={markings,
      mark= at position 1 with {
              \coordinate (a);
              \draw[dpred,opacity=1.0,dashed] ($(a)+(0.05,0)$) --++ (0.5,0) node[\relres,pos=\posres]{\footnotesize{\runame}};}
      }
      },
      funconn/.style={color=white,postaction={decorate},
      decoration={markings,
      mark= at position 0 with {
      \coordinate (a);
      \draw[dpgreen] ($(a)+(-0.05,0)$) -- ($(a)+(-0.5,0)$) node[\relfun, pos=\posfun]{\footnotesize{\funame}};}
      }
      },
      execute at begin picture={\tikzset{
         x=\dpx, y=\dpy,
         every fit/.style={inner xsep=\dpx, inner ysep=\dpy}}}
      },
   dpx/.store in=\dpx,
   dpx = 1.5cm,
   dpy/.store in=\dpy,
   dpy = 1.5ex,
   dp port sep/.store in=\dpportsep,
   dp port sep=2,
   dp port length/.store in=\dpportlen,
   dp port length=4pt,
   dp min width/.store in=\dpminwidth,
   dp min width=0.5cm,
   dp rounded corners/.store in=\dpcorners,
   dp rounded corners=2pt,
   dp small/.style={dp port sep=1, dp port length=2.5pt, dpx=.4cm, dp min width=.4cm, dpy=.7ex},
   dp/.code 2 args={%When you see this key, run the code below:
    % put padding rather than minimum height
    % the font size should be the same as the text
      \pgfmathsetlengthmacro{\dpheight}{\dpportsep * (max(#1,#2)) * \dpy}
      \pgfkeysalso{draw,%
        minimum width=\dpminwidth,%
        minimum height=\dpheight,%
        font=\bfseries,
        outer sep=0pt,%
        inner sep=5pt,%
        rounded corners=\dpcorners,
        thick,
        prefix after command={\pgfextra{\let\fixname\tikzlastnode}},
        append after command={\pgfextra{\draw
            \ifnum #1=0{} \else foreach \i in {1,...,#1} {
            ($(\fixname.north west)!{\i/(#1+1)}!(\fixname.south west)$) +(0,0) node[solid,left,circle,color=dpgreen,draw,fill=dpgreen,scale=0.3] {} coordinate (\fixname_fun\i) -- +(0,0) coordinate (\fixname_fun\i')}\fi %Define the endpoints of tickmarks
            \ifnum #2=0{} \else foreach \i in {1,...,#2} {
            ($(\fixname.north east)!{\i/(#2+1)}!(\fixname.south east)$) +(0,0) coordinate (\fixname_res\i') -- +(0,0) node[solid,right,circle,color=dpred,draw,fill=dpred,scale=0.3] {} coordinate (\fixname_res\i)}\fi;
         }}}
         },
      dp name/.style={append after command={\pgfextra{\node[label=center,inner sep=2pt,fill=white] at (\fixname) {\textbf{#1}};}}}
   }

% Themes
%\usetheme{Frankfurt}
%\usetheme{Bergen}
%\usetheme{Singapore}
%\usecolortheme{beaver}

% Inner and outer themes
%\useoutertheme[subsection=false]{miniframes}
%\useinnertheme{circl>es}

\usebackgroundtemplate{
\rule{0pt}{\paperheight}
\hspace*{\paperwidth}
\makebox[-7pt][r]{\includegraphics[width=10mm]{chapters/pics/victo.jpg}}
}
% Style
\setbeamercolor{titlelike}{parent=structure,fg=stanfordRed,bg=stanfordGrey!20}
%\setbeamercolor{frametitle}{fg=stanfordRed,bg=stanfordRed!20}
\setbeamercolor{frametitle}{fg=stanfordRed,bg=white}
\setbeamercolor{section in head/foot}{bg=stanfordRed}
\setbeamercolor{author in head/foot}{fg=black,bg=white}
\setbeamercolor{date in head/foot}{fg=black,bg=white}

% Table of contents
\ifbool{showOutline}{
    \AtBeginSection[]
    {
        \begin{frame}<beamer>
        \frametitle{Outline}
        \tableofcontents[currentsection]
        \end{frame}
    }
    \setcounter{tocdepth}{1}}

% Effects
\setbeamercovered{transparent}

% Email
\newcommand{\insertemail}{\texttt{\href{mailto:\emailauthor}{\emailauthor}}}
\newcommand{\email}[1]{\newcommand{\emailauthor}{#1}}
% Itemize
\setbeamertemplate{itemize items}[blacktriangle]
\setbeamertemplate{itemize subitem}{--}
\setbeamertemplate{itemize/enumerate subbody begin}{\scriptsize}
\setbeamertemplate{enumerate items}[default]
\setbeamercolor{item projected}{fg=black}
\setbeamercolor{local structure}{fg=black}
\setbeamercolor{itemize item}{fg=stanfordRed}
\setbeamercolor{itemize subitem}{fg=stanfordRed}
\setbeamercolor{itemize subsubitem}{fg=stanfordRed}

% Navigations tag
\beamertemplatenavigationsymbolsempty


% Footline
\makeatletter
\setbeamercolor{footlinerule}{use=structure,bg=white}
\setbeamertemplate{footline}{
	\begin{beamercolorbox}[wd=\paperwidth,ht=0.1ex,dp=0ex,center]{footlinerule}
	\end{beamercolorbox}
%	\begin{beamercolorbox}[ht=0.4cm,wd=0.96\paperwidth,center]{footlinecolor}
%		\hspace{10cm}
%		\vspace{0.2cm}
%			\raggedleft{\scriptsize{\mbox{ }\insertframenumber{} of \inserttotalframenumber}}
%	\end{beamercolorbox}
}
\makeatother

% New symbols
\newcommand{\cmark}{\ding{51}}
\newcommand{\xmark}{\ding{55}}

% Environments
%\renewenvironment{problem}[1][]{\begin{tcolorbox}[boxsep=1pt,left=2pt,right=2pt,colback=white,colframe=stanfordRed,title=Problem (#1)]\em}{\end{tcolorbox}}
%\renewenvironment{theorem}[1][]{\begin{tcolorbox}[boxsep=1pt,left=2pt,right=2pt,colback=white,colframe=stanfordRed,title=Theorem (#1),fontupper=\small]\em}{\end{tcolorbox}}
%\renewenvironment{definition}[1][]{\begin{tcolorbox}[boxsep=1pt,left=2pt,right=2pt,colback=white,colframe=stanfordRed,title=Definition (#1),fontupper=\small]}{\end{tcolorbox}}
%\renewenvironment{lemma}[1][]{\begin{tcolorbox}[boxsep=1pt,left=2pt,right=2pt,colback=white,colframe=stanfordRed,title=Lemma (#1)]\em}{\end{tcolorbox}}
%\newenvironment{proposition}[1][]{\begin{tcolorbox}[boxsep=1pt,left=2pt,right=2pt,colback=white,colframe=stanfordRed,title=Proposition (#1)]\em}{\end{tcolorbox}}
%\renewenvironment{corollary}[1][]{\begin{tcolorbox}[boxsep=1pt,left=2pt,right=2pt,colback=white,colframe=stanfordRed,title=Corollary (#1),fontupper= \small]}{\end{tcolorbox}}
%\newenvironment{remark}[1][]{\begin{tcolorbox}[boxsep=1pt,left=2pt,right=2pt,colback=white,colframe=stanfordGrey,title=Remark (#1)]\em}{\end{tcolorbox}}
\renewenvironment{problem}[1][]{\begin{tcolorbox}[boxsep=1pt,left=2pt,right=2pt,colback=white,colframe=stanfordRed,title=Problem ]\em}{\end{tcolorbox}}
\renewenvironment{theorem}[1][]{\begin{tcolorbox}[boxsep=1pt,left=2pt,right=2pt,colback=white,colframe=stanfordRed,title=Theorem,fontupper=\small]\em}{\end{tcolorbox}}
\renewenvironment{definition}[1][]{\begin{tcolorbox}[boxsep=1pt,left=2pt,right=2pt,colback=white,colframe=stanfordRed,title=Definition,fontupper=\small]}{\end{tcolorbox}}
\renewenvironment{lemma}[1][]{\begin{tcolorbox}[boxsep=1pt,left=2pt,right=2pt,colback=white,colframe=stanfordRed,title=Lemma]\em}{\end{tcolorbox}}
\newenvironment{proposition}[1][]{\begin{tcolorbox}[boxsep=1pt,left=2pt,right=2pt,colback=white,colframe=stanfordRed,title=Proposition]\em}{\end{tcolorbox}}
\renewenvironment{corollary}[1][]{\begin{tcolorbox}[boxsep=1pt,left=2pt,right=2pt,colback=white,colframe=stanfordRed,title=Corollary,fontupper= \small]}{\end{tcolorbox}}
\newenvironment{remark}[1][]{\begin{tcolorbox}[boxsep=1pt,left=2pt,right=2pt,colback=white,colframe=stanfordGrey,title=Remark]\em}{\end{tcolorbox}}


\tikzset{
   oriented WD/.style={%everything after equals replaces "oriented WD" in key.
      every to/.style={out=0,in=180,draw},
      label/.style={
         font=\everymath\expandafter{\the\everymath\scriptstyle},
         inner sep=2pt,
         node distance=2pt and -2pt},
      semithick,
      node distance=1 and 1,
      decoration={markings, mark=at position .5 with {\arrow{stealth};}},
      ar/.style={postaction={decorate}},
      execute at begin picture={\tikzset{
         x=\bbx, y=\bby,
         every fit/.style={inner xsep=\bbx, inner ysep=\bby}}}
      },
   bbx/.store in=\bbx,
   bbx = 1.5cm,
   bby/.store in=\bby,
   bby = 1.75ex,
   bb port sep/.store in=\bbportsep,
   bb port sep=2,
   % bb wire sep/.store in=\bbwiresep,
   % bb wire sep=1.75ex,
   bb port length/.store in=\bbportlen,
   bb port length=4pt,
   bb min width/.store in=\bbminwidth,
   bb min width=1cm,
   bb rounded corners/.store in=\bbcorners,
   bb rounded corners=2pt,
   bb small/.style={bb port sep=1, bb port length=2.5pt, bbx=.4cm, bb min width=.4cm, bby=.7ex},
   bb/.code 2 args={%When you see this key, run the code below:
      \pgfmathsetlengthmacro{\bbheight}{\bbportsep * (max(#1,#2)+1) * \bby}
      \pgfkeysalso{draw,minimum height=\bbheight,minimum width=\bbminwidth,outer sep=0pt,font=\bfseries,inner sep=5pt,
         rounded corners=\bbcorners,thick,
         prefix after command={\pgfextra{\let\fixname\tikzlastnode}},
         append after command={\pgfextra{\draw
            \ifnum #1=0{} \else foreach \i in {1,...,#1} {
               ($(\fixname.north west)!{\i/(#1+1)}!(\fixname.south west)$) -- +(-2*\bbportlen,0) coordinate (\fixname_input\i)}\fi %Define the endpoints of tickmarks
            \ifnum #2=0{} \else foreach \i in {1,...,#2} {
               ($(\fixname.north east)!{\i/(#2+1)}!(\fixname.south east)$) -- +(2*\bbportlen,0) coordinate (\fixname_out\i)}\fi;
         }}}
   },
   bb name/.style={append after command={\pgfextra{\node[anchor=north] at (\fixname.north) {#1};}}}
}

\tikzset{
   tick/.style={postaction={
      decorate,
      decoration={markings, mark=at position 0.5 with {\draw[-] (0,.4ex) -- (0,-.4ex);}}}
   }
}