% Peking University dissertation document class
%
% Copyright (c) 2008-2009 solvethis
% Copyright (c) 2010-2021 Casper Ti. Vector
% Copyright (c) 2021 Kurapica
% Copyright (c) 2021 iofu728
%
% This work may be distributed and/or modified under the conditions of the
% LaTeX Project Public License, either version 1.3 of this license or (at
% your option) any later version.
% The latest version of this license is in
%   https://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX version
% 2005/12/01 or later.
%
% This work has the LPPL maintenance status `maintained'.
% The current maintainer of this work is Casper Ti. Vector.
%
% This work consists of the following files:
%   pkuthss.cls
%   pkuthss.def
%   pkuthss-gbk.def
%   pkuthss-utf8.def
%   pkulogo.eps
%   pkuword.eps

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{pkuthss}
	[2021/03/29 v1.9.0 Peking University dissertation document class]
\def\pkuthss{pkuthss}
\def\iofupkuthss{iofu728/pkuthss}
\def\iofuversion{v1.0.0}
\def\iofubaseversion{v1.9.0}
\newcommand\thss@error[1]{%
  \ClassError{pkuthss}{#1}{}%
}
\newcommand\thss@warning[1]{%
  \ClassWarning{pkuthss}{#1}{}%
}
\RequirePackage{iftex}
\ifXeTeX\else
    \thss@error{%
      The Overleaf pkuthss class requires Xe\TeX{}.\\\\
      You must change your typesetting engine to, e.g.,
      "xelatex" instead of "latex", "lualatex" or "pdflatex".
    }
\fi
\RequirePackage{kvdefinekeys}
\RequirePackage{kvsetkeys}
\RequirePackage{kvoptions}
\SetupKeyvalOptions{
  family=thss,
  prefix=thss@opt@,
  setkeys=\kvsetkeys}
\newcommand\thss@setup[1]{%
  \kvsetkeys{thss}{#1}%
}
\newcommand\thss@define@key[1]{%
  \kvsetkeys{thss@key}{#1}%
}
\kv@set@family@handler{thss@key}{%
  \@namedef{thss@#1@@name}{#1}%
  \def\thss@@default{}%
  \def\thss@@choices{}%
  \kv@define@key{thss@value}{name}{%
    \@namedef{thss@#1@@name}{##1}%
  }%
  \@namedef{thss@#1@@check}{}%
  \@namedef{thss@#1@@code}{}%
  \kv@define@key{thss@value}{choices}{%
    \def\thss@@choices{##1}%
    \@namedef{thss@#1@@reset}{}%
    \@namedef{thss@#1@@check}{%
      \@ifundefined{%
        ifthss@\@nameuse{thss@#1@@name}@\@nameuse{thss@\@nameuse{thss@#1@@name}}%
      }{%
        \thss@error{Invalid value "#1 = \@nameuse{thss@\@nameuse{thss@#1@@name}}"}%
      }%
      \@nameuse{thss@#1@@reset}%
      \@nameuse{thss@\@nameuse{thss@#1@@name}@\@nameuse{thss@\@nameuse{thss@#1@@name}}true}%
    }%
  }%
  \kv@define@key{thss@value}{default}{%
    \def\thss@@default{##1}%
  }%
  \kvsetkeys{thss@value}{#2}%
  \@namedef{thss@\@nameuse{thss@#1@@name}}{}%
  \kv@set@family@handler{thss@choice}{%
    \ifx\thss@@default\@empty
      \def\thss@@default{##1}%
    \fi
    \expandafter\newif\csname ifthss@\@nameuse{thss@#1@@name}@##1\endcsname
    \expandafter\g@addto@macro\csname thss@#1@@reset\endcsname{%
      \@nameuse{thss@\@nameuse{thss@#1@@name}@##1false}%
    }%
  }%
  \kvsetkeys@expandafter{thss@choice}{\thss@@choices}%
  \expandafter\let\csname thss@\@nameuse{thss@#1@@name}\endcsname\thss@@default
  \expandafter\ifx\csname thss@\@nameuse{thss@#1@@name}\endcsname\@empty\else
    \@nameuse{thss@#1@@check}%
  \fi
  \kv@define@key{thss}{#1}{%
    \@namedef{thss@\@nameuse{thss@#1@@name}}{##1}%
    \@nameuse{thss@#1@@check}%
    \@nameuse{thss@#1@@code}%
  }%
}
\thss@define@key{
  fontset = {
    choices = {
      auto,
      windows,
      windows@overleaf,
      mac,
      ubuntu,
      fandol,
      none,
    },
    default = auto,
  },
  encoding = {
    choices = {
      UTF8,
      GBK,
    },
    default = UTF8,
  },
}
% eg. `\thss@int@boolopt{spacing}{true}' will expand to:
%   \newif\ifthss@opt@spacing \thss@opt@spacingtrue
%   \DeclareOption{spacing}{\thss@opt@spacingtrue}
%   \DeclareOption{nospacing}{\thss@opt@spacingfalse}
\def\thss@int@boolopt#1#2{
	\DeclareBoolOption[#2]{#1}
}
% Whether to enable `\Uppercase' (works problematically) in heading marks.
\thss@int@boolopt{uppermark}{false}
% Whether to modify fonts according to school regulation.
\thss@int@boolopt{pkufont}{true}
% Whether to modify footnote format according to school regulation.
\thss@int@boolopt{pkufoot}{true}
% Whether to modify spacing according to school regulation.
\thss@int@boolopt{pkuspace}{true}
% Whether to use some common settings for adjusting spacing.
\thss@int@boolopt{spacing}{true}
% Add PDF bookmark for table of contents.
\thss@int@boolopt{pdftoc}{true}
% Whether to enable the `\spacialchap' command.
\thss@int@boolopt{spechap}{true}
% Whether to automatically set up properties for generated PDF from user
% defined document information (author, title, etc.).
\thss@int@boolopt{pdfprop}{true}
% Whether to disable some infractions intended to make the style less ugly.
\thss@int@boolopt{ugly}{false}
% Whether in bind mode.
\thss@int@boolopt{blind}{false}
% Pass all other options to `ctexbook' document class.
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{ctexbook}}
% Process all class options now.
\ProcessKeyvalOptions*

% Prevent fontspec (loaded by xeCJK) from interfering with newtxmath.
\ifthss@opt@pkufont\PassOptionsToPackage{no-math}{fontspec}\fi
% Work around the `\lvert already defined' error.
% cf. <https://github.com/CTeX-org/ctex-kit/issues/454>.
\ifthss@opt@pkufont\RequirePackage{amsmath}\fi
% pkuthss is based on ctexbook; we use `xiao 4' as default font size.
\LoadClass[a4paper,\thss@encoding,zihao=-4,fontset=none]{ctexbook}[2014/03/06]
% ctex 2.x no longer loads ifpdf and ifxetex by itself.
\RequirePackage{ifpdf, ifxetex}
% Provides support for `key = val' grammar.
\RequirePackage{keyval}
% Graphics support.
\RequirePackage{graphicx}[1999/02/16]
% Provides utilities for setting up page layout.
\RequirePackage{geometry}
% fancyhdr provides utilities for setting up headers and footers.
\RequirePackage{fancyhdr}
% Provides `\uline' used in `\maketitle' (but do not mess with `\emph').
\RequirePackage[normalem]{ulem}
% Provides tableofcontents setting.
\RequirePackage{titletoc}
% Provides cover the scanned version pdf.
\RequirePackage[absolute,overlay]{textpos}
\RequirePackage{color}
% Preset subcaption labelformat to simple.
\RequirePackage[labelformat=simple]{subcaption}
% Provides fontset.
\RequirePackage{xeCJKfntef}
% `\AtEndOfClass' used to avoid `PDF destination not defined' with setspace.
\AtEndOfClass{\RequirePackage{hyperref}}

\ifthss@encoding@GBK
	\input{pkuthss-gbk.def}
	\ifxetex
		% No support for XeLaTeX compilation in non-unicode encoding, i.e. GBK.
		\ClassError{pkuthss}%
			{XeLaTeX compilation is not supported without UTF-8}%
			{%
				XeLaTeX compilation without UTF-8 is very problematic.\MessageBreak
				Therefore please use UTF-8 encoding for the LaTeX code.%
			}
	\fi
\else
	\input{pkuthss-utf8.def}
\fi

\ifthss@opt@pkufont
	% Use Times New Roman / Arial according to school regulation.
	% Option used to prevent newtxtext from manipulating footnote marks.
	\RequirePackage[defaultsups]{newtxtext}
	\RequirePackage[cmintegrals, varg]{newtxmath}
\else
	% Provides `\Box' for originauth.tex if newtx is absent.
	\RequirePackage{latexsym}
\fi

\ifthss@opt@pkufoot
    % Recounter for each page.
    \RequirePackage{chngcntr}
    \counterwithout{footnote}{chapter}
    \counterwithin{footnote}{page}
	% Handle the `Unparsed material' issue with latex/dvipdfmx compilation.
	\unless\ifxetex\unless\ifpdf
		\newcommand*{\pgfsysdriver}{pgfsys-dvipdfm.def}
	\fi\fi
	% Circled text, cf. <https://tex.stackexchange.com/questions/7032/>.
	\RequirePackage{tikz}
	\newcommand*{\thss@int@circled}[1]{%
		\scalebox{0.8}{\tikz[baseline = (char.base)]{
			\node[
				shape = circle, draw = black, minimum size = 1.25em, inner sep = 0pt
			] (char) {#1};
		}}%
	}
	% Use circled numbers as footnote symbols. Does not affect title page, but
	% footnote is rarely used in dissertation covers ;)
	\renewcommand*{\thefootnote}{\protect\thss@int@circled{\arabic{footnote}}}
	\renewcommand*{\thempfootnote}{\protect\thss@int@circled{\arabic{mpfootnote}}}
	% Provides utility to modify footnote spacing.
	% Option used to make sure it does not render interleaf pages totally blank.
	\RequirePackage[cleardoublepage = current]{scrextend}
	% Set up footnote spacing: whole paragraph indent 2 ccwd, 0.5 ccwd after mark.
	\deffootnote{2\ccwd}{0pt}{\thefootnotemark\hspace{0.5\ccwd}}
\fi

\ifthss@opt@pkuspace
	% lineskip / baselineskip = 20 bp / (12 bp * (6 / 5)).
	\linespread{1.39}\selectfont
	% Provides utilities for setting TOC format; `titles' applied to avoid
	% interfering with LaTeX's own title mechanism.
	\RequirePackage[titles]{tocloft}
	\setlength{\cftbeforechapskip}{6bp plus 1bp}
	\setlength{\cftsecindent}{\ccwd}
	\setlength{\cftsubsecindent}{2\ccwd}
	\setlength{\cftsubsubsecindent}{4\ccwd}
	% `caption' modifies font size and separator of captions.  `subcaption'
	% provides functions similar to `subfigure'/`subfig' but does not clash with
	% `tocloft'; it clashes with `subfigure'/`subfig', but the error message will
	% say they cannot be used simultaneously.
	\RequirePackage{caption}
	\ifthss@opt@ugly
		\DeclareCaptionFont{capfsize}{\fontsize{11bp}{13.2bp}}
	\else
		\DeclareCaptionFont{capfsize}{\zihao{5}}
	\fi
	\DeclareCaptionLabelSeparator{quad}{\quad}
	\captionsetup{font = capfsize, labelsep = quad}
	\captionsetup[sub]{font = capfsize}
\fi

\ifthss@opt@spacing
	% Make spacing nicer in some situations (eg. footnotes and verbatims).
	\RequirePackage{setspace}
	% Remove superfluous spacing between footnotes.
	\setlength{\footnotesep}{0pt}
	% Lists often appear to be too sparse when items are just one or two lines
	% long. Here we cancel the extra vertical spacing between list items.
	% The list margin is adjusted due to Chinese typesetting traditions.
	\RequirePackage[shortlabels]{enumitem}
	\setlist{nolistsep, leftmargin = 1.5\parindent}
\fi

\ifthss@opt@spechap
	% This command is used to start a chapter without numbering, and correctly set
	% up the headers and footers in the chapter.
	\newcommand{\specialchap}[1]{%
		\chapter*{#1}\addcontentsline{toc}{chapter}{#1}
		\markboth{#1}{}\phantomsection%
	}
\fi

\AtBeginDocument{
	% Set up spacing for displayed formulae.
	\setlength{\abovedisplayskip}{\belowdisplayshortskip}
	\setlength{\belowdisplayskip}{\abovedisplayskip}
    \hypersetup{
        linktoc            = all,
        bookmarksdepth     = 2,
        bookmarksnumbered  = true,
        bookmarksopen      = true,
        bookmarksopenlevel = 1,
        bookmarksdepth     = 3,
        unicode            = true,
        psdextra           = true,
        breaklinks         = true,
        plainpages         = false,
        pdfdisplaydoctitle = true,
        hidelinks,
    }%

	\ifthss@opt@pdftoc
		% Add PDF bookmark for table of contents.
		\let\thss@tmp@tableofcontents\tableofcontents
		\renewcommand{\tableofcontents}{%
			\thss@int@pdfmark{\contentsname}{contents}
			\thss@tmp@tableofcontents%
		}
	\fi

	\ifthss@opt@pdfprop
		% Automatically generate properties for generated PDF.
		% Use English properties to avoid problems with character encodings.
		\newcommand*{\setpdfproperties}{%
			\hypersetup{
				pdfauthor = {\@eauthor}, pdftitle = {\@etitle},
				pdfsubject = {\euniversity\ \ethesisname}, pdfkeywords = {\@ekeywords}
			}%
		}
		% Set up the properties when generating the title page because the document
		% information should have been all defined before this.
		\let\thss@tmp@maketitle\maketitle
		% NOTE: `\hypersetup' must appear before `\maketitle', otherwise it might
		% not act as expected.
		\renewcommand{\maketitle}{\setpdfproperties\thss@tmp@maketitle}
	\fi
}

% eg. `\thss@int@infoitema{ctitle}' will expand to:
%   \def\ctitle#1{\def\@ctitle{#1}}
%   \define@key{thss@info}{ctitle}{\ctitle{#1}}
\def\thss@int@infoitema#1{
	\@namedef{#1}##1{\@namedef{@#1}{##1}}
	\define@key{thss@info}{#1}{\@nameuse{#1}{##1}}
}
% eg. `\thss@int@infoitemb{cuniversity}' will expand to:
%   \define@key{thss@info}{cuniversity}{\def\cuniversity{#1}}
\def\thss@int@infoitemb#1{
	\define@key{thss@info}{#1}{\@namedef{#1}{##1}}
}
% Set up document information entries.
\thss@int@infoitema{ctitle}
\thss@int@infoitema{etitle}
\thss@int@infoitema{cauthor}
\thss@int@infoitema{eauthor}
\thss@int@infoitema{studentid}
\thss@int@infoitema{date}
\thss@int@infoitema{school}
\thss@int@infoitema{cmajor}
\thss@int@infoitema{emajor}
\thss@int@infoitema{direction}
\thss@int@infoitema{cmentor}
\thss@int@infoitema{ementor}
\thss@int@infoitema{ckeywords}
\thss@int@infoitema{ekeywords}
\thss@int@infoitema{blindid}
\thss@int@infoitema{discipline}
\thss@int@infoitemb{cuniversity}
\thss@int@infoitemb{euniversity}
\thss@int@infoitemb{cthesisname}
\thss@int@infoitemb{ethesisname}
\thss@int@infoitemb{thesiscover}
\thss@int@infoitemb{mentorlines}
\thss@int@infoitemb{cabstractname}
\thss@int@infoitemb{eabstractname}
\thss@int@infoitemb{denotationname}
% Set up document information using the `key = value' grammar.
\newcommand*{\pkuthssinfo}[1]{\setkeys{thss@info}{#1}}
% Becomes \newline in the \makeblind scope.
\newcommand{\thssnl}{\\}

% Set up page layout.
\geometry{a4paper, hmargin = 2.6cm, headheight = 0.5cm, headsep = 0.6cm}
\ifthss@opt@ugly
	\geometry{top = 3.1cm, bottom = 3.0cm, footskip = 0.8cm}
\else
	\geometry{top = 3.0cm, bottom = 3.1cm, footskip = 1.1cm}
\fi

% Set up chapter/section/... captions.
% The `*skip' values are not supposed to be modified by the `ugly' option:
% the actual style of the school's guide and Word template seem to be different
% from the written specification (when applied verbatim in LaTeX), and here the
% actual style is used.
\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{2}
\ctexset{
	chapter = {beforeskip = {0bp}, afterskip = {18bp plus 0.2ex}},
	section =
		{beforeskip = {20bp plus 1ex minus 0.2ex}, afterskip = {5bp plus 0.2ex}},
	subsection =
		{beforeskip = {12bp plus 1ex minus 0.2ex}, afterskip = {5bp plus 0.2ex}},
	subsubsection =
		{beforeskip = {12bp plus 1ex minus 0.2ex}, afterskip = {5bp plus 0.2ex}}
}
\ctexset{
	chapter = {nameformat = {}, titleformat = {}},
	subsubsection = {format = {\zihao{-4}\heiti}}
}
\ifthss@opt@ugly
	\ctexset{
		chapter =
			{nameformat = {\zihao{3}\bfseries}, titleformat = {\zihao{3}\bfseries}},
		section = {format = {\zihao{4}\bfseries}},
		subsection =
			{format = {\fontsize{13bp}{15.6bp}\selectfont\bfseries}},
		subsubsection = {format = {\zihao{-4}\bfseries}}
	}
\else
	\ctexset{
		chapter = {format = {\zihao{-2}\heiti\centering}},
		section = {format = {\zihao{-3}\heiti}},
		subsection = {format = {\zihao{4}\heiti}}
	}
\fi

% 	\ctexset{
% 		chapter = {format = {\zihao{3}\heiti\centering}},
% 		section = {format = {\zihao{4}\heiti}},
% 		subsection = {format = {\fontsize{13bp}{15.6bp}\selectfont\heiti}}
% 	}

% `\MakeUppercase' works problematically.
% eg. it converts `\cite{ctex}' into `\cite{CTEX}'.
% This option can disable `\MakeUppercase' in left/right heading marks.
\ifthss@opt@uppermark
	\def\thss@int@setcase#1{#1}
\else
	% Code copied from fancyhdr's `\nouppercase', with the redefinition of
	% `\uppercase' dropped to avoid disrupting CJKutf8.
	% cf. <https://code.google.com/p/ctex-kit/issues/detail?id=147>.
	\def\thss@int@setcase#1{%
		\let\MakeUppercase\relax%
		\expandafter\let\csname MakeUppercase \endcsname\relax%
		#1%
	}
\fi
% The actual page style setup.
\fancypagestyle{plain}{
	\fancyhf{}\renewcommand*{\headrulewidth}{0.75bp}
	\fancyfoot[C]{\zihao{5}\normalfont{\thepage}}
	\if@twoside
		\fancyhead[CE]{\zihao{5}\normalfont{\cuniversity\cthesisname}}
		\fancyhead[CO]{\zihao{5}\normalfont\thss@int@setcase{\leftmark}}
	\else
		\fancyhead[C]{\zihao{5}\normalfont\thss@int@setcase{\leftmark}}
	\fi
}
\pagestyle{plain}

% This places a bookmark pointing to somewhere near the page header;
% Result of simple `\chapter{...} \pdfbookmark{...}' does not look nice,
% because the bookmark will point to somewhere below the chapter mark.
\def\thss@int@pdfmark#1#2{%
	\if@openright\cleardoublepage\else\clearpage\fi
	\pdfbookmark[0]{#1}{#2}%
}

% Usage: \thss@int@fillinblank{(number of lines)}{(line width)}{(contents)}
\def\thss@int@fillinblank#1#2#3{%
	\makebox[0pt][l]{\parbox[t]{#2}{\centering{#3}}}\mbox{}%
	\parbox[t]{#2}{%
		\newcount\thss@tmp@linecount
		\thss@tmp@linecount=#1
		\loop\ifnum\thss@tmp@linecount>0
			% Fill specified space with underline on the bottom line. `\underline'
			% draws line on the baseline (not the bottom line), and this is why
			% `\uline' is used here instead.
			\ifnum\thss@tmp@linecount=1
				\uline{\makebox[#2]{}}
			\else
				\uline{\makebox[#2]{}}\\
			\fi
		\advance\thss@tmp@linecount by -1\relax
		\repeat%
	}%
}

% Set up format of the title page (cover).
\newcommand{\maketitle@normal}{%
	\thss@int@pdfmark{\titlepagename}{titlepage}
	% Make the title page centered.
	\begin{titlepage}\centering
		% Emblem and inscription of the university, and type of thesis.
		{%
			\ifthss@opt@ugly%
				\zihao{-0}\includegraphics[height = 1.9em]{pkulogo}\hspace{0.3em}%
				\raisebox{0.32em}{\includegraphics[height = 1.3em]{pkuword}}\\[0.5em]
			\else%
				\zihao{1}\includegraphics[height = 2.4em]{pkulogo}\hspace{0.4em}%
				\raisebox{0.4em}{\includegraphics[height = 1.6em]{pkuword}}\\[0.8em]
			\fi%
			{\heiti\ifx\thesiscover\empty{\cthesisname}\else{\thesiscover}\fi}%
		}
		\vfill
		% Title of the thesis.
		{%
			\zihao{2}\linespread{1.6}\selectfont{\label@ctitle}%
			\thss@int@fillinblank{2}{0.64\textwidth}{\heiti{\zihao{1}\@ctitle}}%
		}
		\vfill
		% Information about the author.
		{%
			% Slightly adjust the line skip when using new font size.
			\zihao{3}\linespread{1.75}\selectfont
			\def\thss@tmp@len{0.56\textwidth}
			\begin{tabular}{l@{\extracolsep{0.2em}}c}
				{\heiti{\zihao{-3}\label@cauthor}}		&
				\thss@int@fillinblank{1}{\thss@tmp@len}{\fangsong\@cauthor}		\\
				{\heiti{\zihao{-3}\label@studentid}}	&
				\thss@int@fillinblank{1}{\thss@tmp@len}{\fangsong\@studentid}	\\
				{\heiti{\zihao{-3}\label@school}}		&
				\thss@int@fillinblank{1}{\thss@tmp@len}{\fangsong\@school}		\\
				{\heiti{\zihao{-3}\label@cmajor}}		&
				\thss@int@fillinblank{1}{\thss@tmp@len}{\fangsong\@cmajor}		\\
				{\heiti{\zihao{-3}\label@direction}}	&
				\thss@int@fillinblank{1}{\thss@tmp@len}{\fangsong\@direction}	\\
				{\heiti{\zihao{-3}\label@cmentor}}		&
				\thss@int@fillinblank{\mentorlines}{\thss@tmp@len}{\fangsong\@cmentor}		\\
			\end{tabular}%
		}
		\vfill
		% Date.
		{\ifthss@opt@ugly\zihao{3}\else\zihao{-2}\fi\@date}
	\par\end{titlepage}%
}

% Typeset the title page for double-blind review.
\newcommand{\makeblind}{%
	\thss@int@pdfmark{\titlepagename}{titlepage}
	\begin{titlepage}\renewcommand{\thssnl}{\newline}
		\centering\zihao{3}\selectfont\fangsong\vspace*{0.5cm}
		{\zihao{-0}\heiti\cuniversity\cthesisname}\\[0.36\baselineskip]
		{\zihao{-2}\fangsong\label@blindcover}%
		\par\vspace{4\baselineskip}
		\renewcommand{\arraystretch}{1.25}
		\begin{tabular}{lp{0.75\textwidth}}
			\label@blindctitle	&	{\@ctitle}	\\
			\label@blindetitle	&	{\@etitle}	\\\\
			\label@blinddiscipline	&	{\@discipline}	\\
			\label@blindmajor	&	{\@cmajor}	\\
			\label@blindid	&	{\@blindid}	\\
		\end{tabular}\par\vfill
		{\@date}\par\vspace*{0.5cm}
	\end{titlepage}%
}

% Unified Set up format of the cover two mode.
\renewcommand{\maketitle}{%
  \ifthss@opt@blind \makeblind
  \else\maketitle@normal
  \fi
}

% Typeset the Chinese abstract.
\newenvironment{cabstract}{%
	\thss@int@pdfmark{\cabstractname}{cabstract}
	\chapter*{\cabstractname}\markboth{\cabstractname}{}%
}{% Keywords at the bottom of the page.
	\vfill\noindent\label@ckeywords{\@ckeywords}%
}

% Typeset the English abstract & double-blind review.
\newenvironment{eabstract}{%
	\thss@int@pdfmark{\eabstractname}{eabstract}
	\chapter*{\sffamily\@etitle}\markboth{\eabstractname}{}
  \ifthss@opt@blind
    \begin{center}\textbf{\sffamily\eabstractname}\end{center}\par%
  \else
    \begin{center}
	  	{\@eauthor} ({\@emajor})\\
	  	{\label@ementor}{\@ementor}\\[2em]
		  \textbf{\sffamily\eabstractname}
	  \end{center}
  \fi\par%
}{% Keywords at the bottom of the page.
	\vfill\noindent\label@ekeywords{\@ekeywords}%
}


% Typeset the tableofcontents.
\renewcommand*{\tableofcontents}{%
    \chapter*{\contentsname}%
    \@mkboth{\MakeUppercase\contentsname}%
            {\MakeUppercase\contentsname}%
    \@starttoc{toc}%
}
\newcommand\thss@leaders{\titlerule*[4.4bp]{.}}
\newcommand\thss@set@toc@format{%
  \contentsmargin{\z@}%
  \titlecontents{chapter}
    [\z@]{\addvspace{6bp}\zihao{-4}\heiti\bfseries}
    {\contentspush{\thecontentslabel\quad}}{}
    {\thss@leaders\thecontentspage}%
  \titlecontents{section}
    [1em]{}
    {\contentspush{\thecontentslabel\quad}}{}
    {\thss@leaders\thecontentspage}%
  \titlecontents{subsection}
    [2em]{}
    {\contentspush{\thecontentslabel\quad}}{}
    {\thss@leaders\thecontentspage}%
}
\thss@set@toc@format
\titlecontents{table}
  [\z@]{}
  {\tablename~\thecontentslabel\quad}{}
  {\thss@leaders\thecontentspage}
\titlecontents{figure}
  [\z@]{}
  {\figurename~\thecontentslabel\quad}{}
  {\thss@leaders\thecontentspage}
  
% Subfigure reference format.
\renewcommand\thesubfigure{(\alph{subfigure})}

% Typeset the item of denotation.
\newlist{thss@denotation}{description}{1}
\setlist[thss@denotation]{%
  nosep,
  font=\normalfont,
  align=left,
  leftmargin=!, % sum of the following 3 lengths
  labelindent=0pt,
  labelwidth=5.5cm,
  labelsep*=0.5cm,
  itemindent=0pt,
}

% Typeset the denotation.
\newenvironment{denotation}[1][5.5cm]{%
  \thss@int@pdfmark{\denotationname}{denotation}
  \chapter*{\denotationname}\markboth{\denotationname}{}%
  \vskip-30bp\zihao{-4}\begin{thss@denotation}[labelwidth=#1]
}{%
  \end{thss@denotation}
}

% Auto mode fontset.
\ifthss@fontset@auto
  \IfFontExistsTF{simsun.ttf}{
    \thss@setup{fontset = windows}
  }{
    \IfFileExists{/System/Library/Fonts/Menlo.ttc}{
      \thss@setup{fontset = mac}
    }{
      \thss@setup{fontset = fandol}
    }
  }
\fi

\newcommand\thss@set@cjk@font@windows{%
  \xeCJKsetup{EmboldenFactor=3}%
  \setCJKmainfont{SimSun}[
    AutoFakeBold = true,
    ItalicFont   = KaiTi,
  ]%
  \setCJKsansfont{SimHei}[AutoFakeBold]%
  \setCJKmonofont{FangSong}%
  \setCJKfamilyfont{zhsong}{SimSun}[AutoFakeBold]%
  \setCJKfamilyfont{zhhei}{SimHei}[AutoFakeBold]%
  \setCJKfamilyfont{zhkai}{KaiTi}%
  \setCJKfamilyfont{zhfs}{FangSong}%
}
\newcommand\thss@set@cjk@font@windows@overleaf{%
  \xeCJKsetup{EmboldenFactor=3}%
  \setCJKmainfont{simsun.ttf}[
    AutoFakeBold = true,
    ItalicFont   = simkai.ttf,
  ]%
  \setCJKsansfont{simhei.ttf}[AutoFakeBold]%
  \setCJKmonofont{simfang.ttf}%
  \setCJKfamilyfont{zhsong}{simsun.ttf}[AutoFakeBold]%
  \setCJKfamilyfont{zhhei}{simhei.ttf}[AutoFakeBold]%
  \setCJKfamilyfont{zhkai}{simkai.ttf}%
  \setCJKfamilyfont{zhfs}{simfang.ttf}%
}
\newcommand\thss@set@cjk@font@mac{%
  \defaultCJKfontfeatures{}%
  \setCJKmainfont{Songti SC}[
    UprightFont    = * Light,
    BoldFont       = * Bold,
    ItalicFont     = Kaiti SC Regular,
    BoldItalicFont = Kaiti SC Bold,
  ]%
  \setCJKsansfont{Heiti SC}[
    UprightFont    = * Light,
    BoldFont       = * Medium,
  ]%
  \setCJKmonofont{STFangsong}
  \setCJKfamilyfont{zhsong}{Songti SC}[
    UprightFont    = * Light,
    BoldFont       = * Bold,
  ]%
  \setCJKfamilyfont{zhhei}{Heiti SC}[
    UprightFont    = * Light,
    BoldFont       = * Medium,
  ]%
  \setCJKfamilyfont{zhfs}{STFangsong}%
  \setCJKfamilyfont{zhkai}{Kaiti SC}[
    UprightFont    = * Regular,
    BoldFont       = * Bold,
  ]%
  \setCJKfamilyfont{zhli}{Baoli SC}%
  \setCJKfamilyfont{zhyuan}{Yuanyi SC}[
    UprightFont    = * Light,
    BoldFont       = * Bold,
  ]%
}
\newcommand\thss@set@cjk@font@ubuntu{%
  \defaultCJKfontfeatures{}%
  \setCJKmainfont{Noto Serif CJK SC}[
    UprightFont    = * Light,
    BoldFont       = * Bold,
    ItalicFont     = FandolKai-Regular,
    ItalicFeatures = {Extension = .otf},
    Script         = CJK,
  ]%
  \setCJKsansfont{Noto Sans CJK SC}[
    BoldFont       = * Medium,
    Script         = CJK,
  ]%
  \setCJKmonofont{FandolFang}
  \setCJKfamilyfont{zhsong}{Noto Serif CJK SC}[
    UprightFont    = * Light,
    UprightFont    = * Bold,
    Script         = CJK,
  ]%
  \setCJKfamilyfont{zhhei}{Noto Sans CJK SC}[
    BoldFont       = * Medium,
    Script         = CJK,
  ]%
  \setCJKfamilyfont{zhfs}{FandolFang}[
    Extension      = .otf,
    UprightFont    = *-Regular,
  ]%
  \setCJKfamilyfont{zhkai}{FandolKai}[
    Extension      = .otf,
    UprightFont    = *-Regular,
  ]%
}
\newcommand\thss@set@cjk@font@fandol{%
  \defaultCJKfontfeatures{}%
  \setCJKmainfont{FandolSong}[
    Extension   = .otf,
    UprightFont = *-Regular,
    BoldFont    = *-Bold,
    ItalicFont  = FandolKai-Regular,
    ItalicFeatures = {Extension = .otf},
  ]%
  \setCJKsansfont{FandolHei}[
    Extension   = .otf,
    UprightFont = *-Regular,
    BoldFont    = *-Bold,
  ]%
  \setCJKmonofont{FandolFang}[
    Extension   = .otf,
    UprightFont = *-Regular,
  ]%
  \setCJKfamilyfont{zhsong}{FandolSong}[
    Extension   = .otf,
    UprightFont = *-Regular,
    BoldFont    = *-Bold,
  ]%
  \setCJKfamilyfont{zhhei}{FandolHei}[
    Extension   = .otf,
    UprightFont = *-Regular,
    BoldFont    = *-Bold,
  ]%
  \setCJKfamilyfont{zhfs}{FandolFang}[
    Extension   = .otf,
    UprightFont = *-Regular,
  ]%
  \setCJKfamilyfont{zhkai}{FandolKai}[
    Extension   = .otf,
    UprightFont = *-Regular,
  ]%
}
\newcommand\thss@set@cjk@font{%
  \ifthss@fontset@none\else
    \@nameuse{thss@set@cjk@font@\thss@fontset}%
    \providecommand\songti{\CJKfamily{zhsong}}
    \providecommand\heiti{\CJKfamily{zhhei}}
    \providecommand\fangsong{\CJKfamily{zhfs}}
    \providecommand\kaishu{\CJKfamily{zhkai}}
  \fi
}
\ifthss@opt@pkufoot
    \thss@set@cjk@font
\fi

\endinput
% vim:ft=tex:ts=2:sw=2
