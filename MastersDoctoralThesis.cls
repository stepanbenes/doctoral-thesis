%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Masters/Doctoral Thesis 
% Class File
% Version 1.5 (22/11/16)
%
% This class has been downloaded from:
% http://www.LaTeXTemplates.com
%
% Authors:
% Vel (vel@latextemplates.com)
% Johannes Böttcher
%
% Notes:
% 1) This class file defines the structure and layout of the template file (main.tex).
% 2) It has been written in such a way that under most circumstances you should not need
% to edit it; updating it to a newer version will be harder. If you do make changes, please change the name of
% the file and add comments to make your changes more visible.
%
% Class license:
% LPPL v1.3c (http://www.latex-project.org/lppl)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%----------------------------------------------------------------------------------------
%	CLASS DEFINITION AND PARAMETERS
%----------------------------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}[1996/12/01]
\newcommand{\classname}{MastersDoctoralThesis}
\ProvidesClass{\classname}[2016/11/22 v1.5 LaTeXTemplates.com]
\providecommand{\baseclass}{book}

\RequirePackage{etoolbox}
\RequirePackage{xparse}
\newbool{nolistspace}
\newbool{chapteroneline}
\newbool{listtoc}
\newbool{toctoc}
\newbool{parskip}
\newbool{hyperrefsupport}
\booltrue{hyperrefsupport}
\newbool{headsepline}
\newbool{consistentlayout}
\newbool{decreaseabovechapterskip}

\DeclareOption{nohyperref}{\boolfalse{hyperrefsupport}}
\DeclareOption{nolistspacing}{\booltrue{nolistspace}}
\DeclareOption{liststotoc}{\booltrue{listtoc}}
\DeclareOption{chapterinoneline}{\booltrue{chapteroneline}}
\DeclareOption{toctotoc}{\booltrue{toctoc}}
\DeclareOption{parskip}{\booltrue{parskip}}
\DeclareOption{headsepline}{\booltrue{headsepline}}
\DeclareOption{consistentlayout}{\booltrue{consistentlayout}}
\DeclareOption{decreaseabovechapterskip}{\booltrue{decreaseabovechapterskip}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\baseclass}}

\ProcessOptions\relax

\LoadClass{\baseclass}

%  Simple interface for the user  to customize the chapter titles 
\ProvideDocumentCommand{\abovechapterskip}{}{\vspace*{\ifbool{decreaseabovechapterskip}{-10pt}{20pt}}}
\ProvideDocumentCommand{\chapterbelowskip}{}{\vspace*{40pt}}
\ProvideDocumentCommand{\chapterinbetweenskip}{}{\vspace*{20pt}}
\ProvideDocumentCommand{\autodot}{}{}
\ProvideDocumentCommand{\mdtChapapp}{}{}
\ProvideDocumentCommand{\chapteralign}{}{\raggedright}
\ProvideDocumentCommand{\chapterfont}{}{\Huge\bfseries}
\ProvideDocumentCommand{\chapterprefixfont}{}{\LARGE\bfseries}
\DeclareDocumentCommand{\@makechapterhead}{ m }{%
	\abovechapterskip
	{\parindent \z@ \chapteralign \normalfont
		\ifnum \c@secnumdepth >\m@ne
		\if@mainmatter
		\ifbool{chapteroneline}{%
			\chapterfont \mdtChapapp\thechapter\autodot\enspace
		}{%
			\chapterprefixfont \@chapapp\space \thechapter
			\par\nobreak
			\chapterinbetweenskip
		}%
		\fi
		\fi
		\interlinepenalty\@M%
		\chapterfont #1\par\nobreak
		\chapterbelowskip
	}
}
\def\@makeschapterhead#1{%
	\abovechapterskip
	{\parindent \z@ \chapteralign
		\normalfont
		\interlinepenalty\@M
		\chapterfont  #1\par\nobreak
		\chapterbelowskip
	}
}


% Addchap provides unnumbered chapters with an entry in the table of contents as well as an updated header
\ProvideDocumentCommand{\addchap}{ s o m }{%
	\chapter*{#3}%
	\markboth{}{}%
	\IfBooleanTF{#1}{%
	}{%
		\IfNoValueTF{#2}{%
			\addchaptertocentry{#3}%
			\markboth{\MakeMarkcase{#3}}{\MakeMarkcase{#3}}%
		}{%
			\addchaptertocentry{#2}%
			\markboth{\MakeMarkcase{#2}}{\MakeMarkcase{#2}}%
		}%
	}%
}%

\ProvideDocumentCommand{\addsec}{ s o m }{%
	\section*{#3}%
	\markright{}%
	\IfBooleanTF{#1}{%
	}{%
		\IfNoValueTF{#2}{%
			\addcontentsline{toc}{section}{#3}%
			\markright{\MakeMarkcase{#3}}%%
		}{%
			\addcontentsline{toc}{section}{#2}%
			\markright{\MakeMarkcase{#2}}%
		}%
	}%
}%

%----------------------------------------------------------------------------------------
%	CLASS OPTIONS
%----------------------------------------------------------------------------------------

\ifbool{parskip}{\RequirePackage{parskip}} % If the parskip option is passed to the class, require the parskip package 


\ifbool{listtoc}{% If the liststotoc option has been passed to the class, add the lists to the table of contents
	\patchcmd{\listoftables}{\@starttoc{lot}}{%
		\addchaptertocentry{\listtablename}\@starttoc{lot}%
	}{}{}%
	\patchcmd{\listoffigures}{\@starttoc{lof}}{%
		\addchaptertocentry{\listfigurename}\@starttoc{lof}%
	}{}{}%
}

\ifbool{toctoc}{% If the toctotoc options has been passed to the class, add the table of contents to the table of contents
	\patchcmd{\tableofcontents}{\@starttoc{toc}%
}{%
	\addchaptertocentry{\contentsname}\@starttoc{toc}}{}{}%
}

\patchcmd{\tableofcontents}{\MakeUppercase}{\MakeMarkcase}{}{}
\patchcmd{\tableofcontents}{\MakeUppercase}{\MakeMarkcase}{}{}
\patchcmd{\listoffigures}{\MakeUppercase}{\MakeMarkcase}{}{}
\patchcmd{\listoffigures}{\MakeUppercase}{\MakeMarkcase}{}{}
\patchcmd{\listoftables}{\MakeUppercase}{\MakeMarkcase}{}{}
\patchcmd{\listoftables}{\MakeUppercase}{\MakeMarkcase}{}{}

% If the option `nolistspacing' is given, the spacing in the different lists is reduced to single spacing. This option is only useful, if the spacing of the document has been changed to onehalfspacing or doublespacing.
\ifbool{nolistspace}{
	\patchcmd{\listoffigures}{%
		\@starttoc{lof}
	}{%
		\begingroup%
		\singlespace\@starttoc{lof}\endgroup%
	}{}{}%
	\patchcmd{\listoftables}{%
		\@starttoc{lot}
	}{%
		\begingroup%
		\singlespace\@starttoc{lot}\endgroup%
	}{}{}%
	\patchcmd{\tableofcontents}{%
		\@starttoc{toc}
	}{%
		\begingroup%
		\singlespace\@starttoc{toc}\endgroup%
	}{}{}%
}{}


%----------------------------------------------------------------------------------------
%	REQUIRED PACKAGES
%----------------------------------------------------------------------------------------

\RequirePackage{babel} % Required for automatically changing names of document elements to languages besides english

\RequirePackage{scrbase} % Required for handling language-dependent names of sections/document elements

\RequirePackage{scrhack} % Loads fixes for various packages

\RequirePackage{setspace} % Required for changing line spacing

\RequirePackage{longtable} % Required for tables that span multiple pages (used in the symbols, abbreviations and physical constants pages)

\RequirePackage{siunitx} % Required for \SI commands

\RequirePackage{graphicx} % Required to include images
\graphicspath{{Figures/}{./}} % Specifies where to look for included images

\RequirePackage{booktabs} % Required for better table rules

\RequirePackage{caption} % Required for customising the captions
\captionsetup{justification=centerlast,font=small,labelfont=sc,margin=50pt}

%----------------------------------------------------------------------------------------
%	DEFINE CUSTOM THESIS INFORMATION COMMANDS
%----------------------------------------------------------------------------------------

\DeclareDocumentCommand{\thesistitle} { o m }{
	\IfBooleanTF{#1} {\DeclareDocumentCommand{\shorttitle}{ }{#1}
	{\DeclareDocumentCommand{\shorttitle}{}{#2}}}
	\DeclareDocumentCommand{\@title}{ }{#2}
	\DeclareDocumentCommand{\ttitle}{ }{#2}
}
\DeclareDocumentCommand{\thesistitlecs} { m }{
	\DeclareDocumentCommand{\ttitlecs}{ }{#1}
}
\DeclareDocumentCommand { \author     } { m } { \DeclareDocumentCommand    { \authorname } { } {#1}
\DeclareDocumentCommand { \@author    } {   } {#1}   }
\NewDocumentCommand     { \authornodegree } { m } { \DeclareDocumentCommand { \authornamenodegree } { } {#1}  }
\NewDocumentCommand     { \supervisor } { m } { \DeclareDocumentCommand { \supname       } { } {#1}  }
\NewDocumentCommand     { \examiner   } { m } { \DeclareDocumentCommand { \examname      } { } {#1}  }
\NewDocumentCommand     { \degree     } { m } { \DeclareDocumentCommand { \degreename    } { } {#1}  }
\NewDocumentCommand     { \addresses  } { m } { \DeclareDocumentCommand { \addressname   } { } {#1}  }
\NewDocumentCommand     { \university } { m } { \DeclareDocumentCommand { \univname      } { } {#1}  }
\NewDocumentCommand     { \department } { m } { \DeclareDocumentCommand { \deptname      } { } {#1}  }
\NewDocumentCommand     { \group      } { m } { \DeclareDocumentCommand { \groupname     } { } {#1}  }
\NewDocumentCommand     { \faculty    } { m } { \DeclareDocumentCommand { \facname       } { } {#1}  }
\NewDocumentCommand     { \subject    } { m } { \DeclareDocumentCommand { \subjectname   } { } {#1}  }
\NewDocumentCommand     { \keywords   } { m } { \DeclareDocumentCommand { \keywordnames  } { } {#1}  }
\NewDocumentCommand     { \keywordscs   } { m } { \DeclareDocumentCommand { \keywordnamescs  } { } {#1}  }

\newcommand{\checktoopen}{% New command to move content to the next page which prints to the next odd page if twosided mode is active  
	\if@openright\cleardoublepage\else\clearpage\fi
	\ifdef{\phantomsection}{\phantomsection}{}% The \phantomsection command is necessary for hyperref to jump to the correct page
}

\NewDocumentCommand{\bhrule}{}{\typeout{--------------------}}
\NewDocumentCommand{\tttypeout}{m}{\bhrule\typeout{\space #1}\bhrule}

\newcommand{\HRule}{\rule{.9\linewidth}{.6pt}} % New command to make the lines in the title page
\newcommand{\decoRule}{\rule{.8\textwidth}{.4pt}} % New command for a rule to be used under figures

\setcounter{tocdepth}{3} % The depth to which the document sections are printed to the table of contents
\ProvideDocumentCommand{\addchaptertocentry}{ m }{%
	\addcontentsline{toc}{chapter}{#1}%
}

%----------------------------------------------------------------------------------------
%	COLOURS
%----------------------------------------------------------------------------------------

\usepackage{xcolor} % Required for specifying custom colours

\colorlet{mdtRed}{red!50!black}

%----------------------------------------------------------------------------------------
%	MARGINS
%----------------------------------------------------------------------------------------

\RequirePackage{geometry}
\geometry{
	headheight=4ex,
	includehead,
	includefoot
}

\raggedbottom

%----------------------------------------------------------------------------------------
%	PENALTIES
%----------------------------------------------------------------------------------------

\doublehyphendemerits=10000 % No consecutive line hyphens
\brokenpenalty=10000 % No broken words across columns/pages
\widowpenalty=9999 % Almost no widows at bottom of page
\clubpenalty=9999 % Almost no orphans at top of page
\interfootnotelinepenalty=9999 % Almost never break footnotes

%----------------------------------------------------------------------------------------
%	HEADERS AND FOOTERS
%----------------------------------------------------------------------------------------

\RequirePackage[markcase=used]{scrlayer-scrpage}
\providepairofpagestyles{thesisSimple}{%
	\clearpairofpagestyles%
	\automark[chapter]{chapter}
	\ihead{\headmark}% Inner header
	\ohead[\pagemark]{\pagemark}% Outer header
}
\ifoot{}% Inner footer
\ofoot{}% Outer footer
\pagestyle{thesisSimple}
\providepairofpagestyles[thesisSimple]{thesis}{%
	\automark*[section]{}%
}
\providepairofpagestyles[thesisSimple]{review}{%
	\ofoot[\shorttitle/\authorname]{\shorttitle/\authorname}
	\ifoot[\today]{\today}
}
\pagestyle{thesis}
\ifbool{headsepline}{\KOMAoption{headsepline}{true}}{}
\PreventPackageFromLoading[\ClassError{\classname}{Package `fancyhdr' is
incompatible\MessageBreak with this class}{The pagesyles are defined 
	using package `scrlayer-scrpage', please consult the\MessageBreak 
KOMA-script documentation for details.}]{fancyhdr}


\NewDocumentCommand{\blank@p@gestyle}{}{empty}
\NewDocumentCommand{\blankpagestyle}{ m }{%
	\ClassWarning{\classname}{\string\blankpagestyle\space is
	obsolete,\MessageBreak use \string\setblankpagestyle \space  instead}\DeclareDocumentCommand{\blank@p@gestyle}{}{#1}
}
\NewDocumentCommand{\setblankpagestyle}{ m }{\DeclareDocumentCommand{\blank@p@gestyle}{}{#1}}

\DeclareDocumentCommand\cleardoublepage{}{\clearpage\if@twoside \ifodd\c@page\else
	\hbox{}
	\thispagestyle{\blank@p@gestyle}
	\newpage
	\if@twocolumn\hbox{}\newpage\fi\fi\fi%
}

%----------------------------------------------------------------------------------------
%	ABBREVIATIONS PAGE DESIGN
%----------------------------------------------------------------------------------------

\newcommand{\abbrevname}{List of Abbreviations}
\providecaptionname{english,british,american}{\abbrevname}{List of Abbreviations}
\providecaptionname{ngerman,german,austrian,naustrian}{\abbrevname}{Abk\"urzungsverzeichnis}
\NewDocumentEnvironment{abbreviations}{ m }{%
	\ifbool{nolistspace}{\begingroup\singlespacing}{}
	\ifbool{listtoc}{\addchap{\abbrevname}}{\addchap*{\abbrevname}}
	\begin{longtable}{#1}
	}{%
	\end{longtable}
	\addtocounter{table}{-1} % Don't count this table as one of the document tables
	\ifbool{nolistspace}{\endgroup}{}
}

%----------------------------------------------------------------------------------------
%	ABSTRACT PAGE DESIGN
%----------------------------------------------------------------------------------------

\DeclareDocumentCommand{\abstractauthorfont}{}{}
\DeclareDocumentCommand{\abstracttitlefont}{}{}
\newcommand{\byname}{by}
\newcommand{\abstractname}{Abstract}
\newcommand{\abstractnamecs}{Abstrakt}
\newcommand{\keywordstitle}{Keywords:}
\newcommand{\keywordstitlecs}{Kl\'i\v{c}ov\'a slova:}
\providecaptionname{german,ngerman,austrian,naustrian}{\byname}{von}
\providecaptionname{american,australian,british,canadian,english,newzealand,UKenglish,USenglish}{\byname}{by}
\ifbool{consistentlayout}{
	\DeclareDocumentEnvironment{abstract}{ O{} }{%
		\addchap*{\abstractname}%
		{\chapteralign\normalsize\abstractauthorfont \authornamenodegree \par} % Author name
		\vspace{\baselineskip}
		{\chapteralign\parbox{.7\linewidth}{\chapteralign\normalsize\itshape\abstracttitlefont\@title}\par}% Thesis title
		\bigskip\noindent\ignorespaces
	}%
	{}%end alt-abstract
}{%
	\DeclareDocumentEnvironment{abstract}{ }{
		\checktoopen
		\tttypeout{\abstractname}
		\thispagestyle{plain}
		\begin{center}
			{\huge\textit{\abstractname} \par}
			\bigskip
			{\normalsize\bfseries \ttitle \par} % Thesis title
			\medskip
			{\normalsize \authornamenodegree \par} % Author name
			\bigskip
		\end{center}
	}
	{
		\vfill\null
	}
}

\DeclareDocumentEnvironment{abstractcs}{ }{
	\checktoopen
	\tttypeout{\abstractnamecs}
	\thispagestyle{plain}
	\begin{center}
		{\huge\textit{\abstractnamecs} \par}
		\bigskip
		{\normalsize\bfseries \ttitlecs \par} % Thesis title in czech
		\medskip
		{\normalsize \authornamenodegree \par} % Author name
		\bigskip
	\end{center}
}
{
	\vfill\null
}

%----------------------------------------------------------------------------------------
%	ACKNOWLEDGEMENTS PAGE DESIGN
%----------------------------------------------------------------------------------------

\usepackage{xcolor}
\colorlet{mdtRed}{red!50!black}
\newcommand{\acknowledgementname}{Acknowledgements}
\providecaptionname{american,australian,british,canadian,english,newzealand,UKenglish,USenglish} {\acknowledgementname}{Acknowledgements} % Acknowledgement text for English countries
\providecaptionname{german,ngerman,austrian,naustrian}{\acknowledgementname}{Danksagung} % Acknowledgement text for Germanic countries

\ifbool{consistentlayout}{
	\DeclareDocumentEnvironment{acknowledgements}{}{%
		\tttypeout{\acknowledgementname}
		\addchap*{\acknowledgementname}
	}
}
{
	\DeclareDocumentEnvironment{acknowledgements}{}{%
		\checktoopen
		\tttypeout{\acknowledgementname}
		\thispagestyle{plain}
		\begin{center}{\huge\textit{\acknowledgementname}\par\vspace{10pt}}\end{center}
	}
	{
		\vfil\vfil\null
	}
}

%----------------------------------------------------------------------------------------
%	DECLARATION PAGE DESIGN
%----------------------------------------------------------------------------------------

\newcommand{\authorshipname}{Declaration of Authorship}
\providecaptionname{american,australian,british,canadian,english,newzealand,UKenglish,USenglish}{\authorshipname}{Declaration} % Declaration of Authorship text for English countries
\providecaptionname{german,ngerman,austrian,naustrian}{\authorshipname}{Eidesstattliche Erkl\"arung} % Declaration of Authorship text for Germanic countries

\ifbool{consistentlayout}{
	\DeclareDocumentEnvironment{declaration}{}{
		\addchap*{\authorshipname}
		}{}%
}{
	\DeclareDocumentEnvironment{declaration}{}{
		\checktoopen

		\noindent\begin{minipage}{0.19\textwidth}% adapt widths of minipages to your needs
		\includegraphics[width=\linewidth]{figures/logo-cvut}
		\end{minipage}%
		\hfill%
		\begin{minipage}{0.75\textwidth}
			{\scshape \univname}\\[-0.3cm]
			\rule{\linewidth}{0.4pt}\\
			\facname\\ % Faculty name
			\addressname\\
		\end{minipage}\\[2cm]

		\tttypeout{\authorshipname}
		\thispagestyle{plain}
		%\null\vfil
		\begin{center}{\scshape\noindent\LARGE\bfseries\authorshipname\par\vspace{10pt}}\end{center}
	}{}
}

%----------------------------------------------------------------------------------------
%	DEDICATION PAGE DESIGN
%----------------------------------------------------------------------------------------

\ifbool{consistentlayout}{
	\DeclareDocumentCommand{\dedicatory}{
		m O{\vspace*{.7\textheight} }  }{
			\checktoopen\tttypeout{Dedicatory}
			\markboth{}{}
			#2
			{\hfill\parbox{.4\textwidth}{\flushright#1\par}}
		}
}{
	\newcommand\dedicatory[1]{
		\checktoopen
		\tttypeout{Dedicatory}
		\null\vfil
		\thispagestyle{plain}
		\begin{center}{\Large\slshape #1}\end{center}
		\vfil\null
	}
}


%----------------------------------------------------------------------------------------
%	PHYSICAL CONSTANTS PAGE DESIGN
%----------------------------------------------------------------------------------------

\newcommand{\constantsname}{Physical Constants}
\providecaptionname{english,british,american}{\constantsname}{Physical Constants}
\providecaptionname{ngerman,german,austrian,naustrian}{\constantsname}{Physikalische Konstanten}

\NewDocumentEnvironment{constants}{ m }{%
	\ifbool{nolistspace}{\begingroup\singlespacing}{}
	\ifbool{listtoc}{\addchap{\constantsname}}{\addchap*{\constantsname}}
	\begin{longtable}{#1}
	}{%
	\end{longtable}
	\addtocounter{table}{-1} % Don't count this table as one of the document tables
	\ifbool{nolistspace}{\endgroup}{}
}

%----------------------------------------------------------------------------------------
%	SYMBOLS PAGE DESIGN
%----------------------------------------------------------------------------------------

\newcommand{\symbolsname}{List of Symbols}
\providecaptionname{english,british,american}{\symbolsname}{List of Symbols}
\providecaptionname{ngerman,german,austrian,naustrian}{\symbolsname}{Symbolverzeichnis}

\NewDocumentEnvironment{symbols}{ m }{%
	\ifbool{nolistspace}{\begingroup\singlespacing}{}
	\ifbool{listtoc}{\addchap{\symbolsname}}{\addchap*{\symbolsname}}
	\begin{longtable}{#1}
	}{%
	\end{longtable}
	\addtocounter{table}{-1} % Don't count this table as one of the document tables
	\ifbool{nolistspace}{\endgroup}{}
}

%----------------------------------------------------------------------------------------

\ifbool{hyperrefsupport}{% If the nohyperref class option has not been specified
\AtEndPreamble{\RequirePackage{hyperref}
\hypersetup{pdfpagemode={UseOutlines},
bookmarksopen=true,
bookmarksopenlevel=0,
hypertexnames=false,
colorlinks=true, % Set to false to disable coloring links
%hidelinks=true, % Uncomment to disable coloring and outlines of links for print-friendly version
citecolor=magenta, % The color of citations
linkcolor=red, % The color of references to document elements (sections, figures, etc)
urlcolor=mdtRed, % The color of hyperlinks (URLs)
pdfstartview={FitV},
unicode,
breaklinks=true,
}

\pdfstringdefDisableCommands{% If there is an explicit linebreak in a section heading (or anything printed to the pdf-bookmarks), it is replaced by a space
	\let\\\space%
}
	}
}{%nothing
}

%----------------------------------------------------------------------------------------

\endinput
% lazyLizardTracer
