
\def \fileversion{v1.0}
\def \filedate{2023/12/13}
\def \docdate{\filedate}

\newcommand \@doctor{Doctor of Philosophy}
\newcommand \@master{Master of Philosophy}
\newcommand \@mres{Master of Research}
\newcommand \@degree@string{\@doctor}

\NeedsTeXFormat{LaTeX2e}[1997/12/01]
\ProvidesClass{ucc_thesis}[\filedate\space\fileversion\space UCL MRes/MPhil/PhD Thesis class]
\DeclareOption{mres}{\renewcommand\@degree@string{\@mres}}
\DeclareOption{MRes}{\renewcommand\@degree@string{\@mres}}
\DeclareOption{mphil}{\renewcommand\@degree@string{\@master}}
\DeclareOption{MPhil}{\renewcommand\@degree@string{\@master}}
\DeclareOption{phd}{\renewcommand\@degree@string{\@doctor}}
\DeclareOption{PhD}{\renewcommand\@degree@string{\@doctor}}
\DeclareOption{twocolumn}{\ClassError{ucc_thesis}{Option `twocolumn' not supported for UCL theses}{}}
\newif \if@draftmode
\@draftmodefalse
\DeclareOption{draft}{\@draftmodetrue\PassOptionsToClass{draft}{book}}
\DeclareOption{final}{\@draftmodefalse\PassOptionsToClass{final}{book}}
\PassOptionsToClass{a4paper}{book}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions
\LoadClass{book}
% This is the package that sets the fonts up as Times New Roman.
\RequirePackage{mathptmx}
% The mathptmx package makes a subset of the math glyphs (mathcal) extremely calligraphically loopy.
% This sets sets the "alphabet" for \mathcal for the OMS encoding block, to the cmsy font, 
%  m series (medium, I think), n weight, which is the ordinary default.
% See issue #19 for some reference links and examples.
\DeclareMathAlphabet{\mathcal}{OMS}{cmsy}{m}{n}
%    \end{macrocode}
%
%  \subsection{Page Layout}
%
%  Define the standard layout of a thesis page.
%
%  First define the page area and it's location on the page. These used to be very exactly controlled
%   in thesis submissions, but standards are a bit more lax these days. 
%
%    "A4 size paper (210 x 297 mm) should be used. Plain white paper must be used, 
%      of good quality and of sufficient opacity for normal reading. 
%    "Both sides of the paper may be used. 
%    "Margins at the binding edge must be not less than 40 mm (1.5 inches) and other margins 
%      not less than 20 mm (.75 inches)." 
%
%    \begin{macrocode}

\setlength \hoffset{-25.4mm}
\setlength \voffset{-25.4mm}
\setlength \textwidth{140mm}
\setlength \textheight{232mm} % I think you need some extra vertical space for headers and page numbers
\setlength \topmargin{20mm}
\setlength \oddsidemargin {39mm} % Allow a mm for the bleed.
\if@twoside
  \setlength \evensidemargin {20mm}
\else
  \setlength \evensidemargin {39mm}
\fi
%    \end{macrocode}
%  \begin{macro}{\ps@headings}
%  Define a new style so that all the standard styles are available.
%    \begin{macrocode}
\def \ps@headings{%
    \def \@oddhead{\normalfont \rmfamily \slshape \hfill \rightmark \hfill \thepage}%
    \def \@evenhead{\normalfont \rmfamily \slshape \thepage \hfill \leftmark \hfill}%
    \let \@oddfoot = \@empty%
    \let \@evenfoot = \@empty%
    \let \@mkboth = \markboth%
    \def \chaptermark##1{%
        \markboth{%
            \ifnum \c@secnumdepth >\m@ne%
                \if@mainmatter%
                    \@chapapp\ \thechapter. \ %
                \fi%
            \fi%
            ##1%
        }{}%
    }%
    \def \sectionmark##1{%
        \markright {%
            \ifnum \c@secnumdepth >\z@%
                \thesection. \ %
            \fi%
            ##1%
        }%
    }%
}
\pagestyle{headings}
%    \end{macrocode}
%  \end{macro}
%  \begin{macro}{\footnoterule}
%  Make the footnote rule go all the way across the page.
%    \begin{macrocode}
\renewcommand \footnoterule {%
    \kern -3\p@%
    \hrule%
    \kern 2.6\p@%
}
%    \end{macrocode}
%  \end{macro}
%  Standard style has no inter-paragraph gap but a paragraph indentation.  Also need to alter
%  the space between the text area and the running head and foot.  Also, stop too much space
%  appearing before and after lists.
%    \begin{macrocode}
\setlength \parindent{2em}
\setlength \parskip  {\z@ \@plus 1\p@}
\setlength \headsep  {16\p@}
\ifcase \@ptsize
    \setlength \footskip{26\p@}
\or
    \setlength \footskip{27\p@}
\or
    \setlength \footskip{28\p@}
\fi
\setlength \partopsep {\z@}
%    \end{macrocode}
%  Do feathering but don't be too worried about exactness.
%    \begin{macrocode}
\tolerance = \@m
\emergencystretch = 10\p@
\vfuzz = 2\p@
\hfuzz = 2\p@
\flushbottom
%    \end{macrocode}
%  "Double or one-and-a-half spacing should be used in typescripts, except for indented 
%   quotations or footnotes where single spacing may be used."
%
%  One and a half is a sensible choice for theses, especially with a wide margin.
%    \begin{macrocode}
\renewcommand \baselinestretch{1.5}
%    \end{macrocode}
%
%  \subsection{Running Heads}
%
%  Note that LaTeX2e is still dicatatorial about using |\uppercase| in various chapter starts.
%  This means making copies of the macros simply to remove the |\uppercase| usage.
%    \begin{macrocode}
\renewcommand \tableofcontents{%
    \if@twocolumn%
        \@restonecoltrue \onecolumn%
    \else%
        \@restonecolfalse%
    \fi%
    \chapter*{%
        \contentsname%
        \@mkboth{\contentsname}{\contentsname}%
    }%
    \@starttoc{toc}%
    \if@restonecol%
        \twocolumn%
    \fi%
}
\renewcommand \listoffigures{%
    \if@twocolumn%
        \@restonecoltrue \onecolumn%
    \else%
        \@restonecolfalse%
    \fi%
    \chapter*{%
        \listfigurename%
        \@mkboth{\listfigurename}{\listfigurename}%
    }%
    \@starttoc{lof}%
    \if@restonecol%
        \twocolumn%
    \fi%
}
\renewcommand \listoftables{%
    \if@twocolumn%
        \@restonecoltrue \onecolumn%
    \else%
        \@restonecolfalse%
    \fi%
    \chapter*{%
        \listtablename%
        \@mkboth{\listtablename}{\listtablename}%
    }%
    \@starttoc{lot}%
    \if@restonecol%
        \twocolumn%
    \fi%
}
\renewenvironment{thebibliography}[1]{%
    \chapter*{%
        \bibname%
        \@mkboth{\bibname}{\bibname}%
    }%
%%%
%%%  Julia Schnabel wanted the following line added since the
%%%  \chapter* call does not put the bibliography into the table of
%%%  contents.
%%%
%%% This line manually adds the Bibliography to the table of contents. 
%%% Adding it like this means that it doesn't get a chapter or appendix number.
    \addcontentsline{toc}{chapter}{\bibname}%
%%%
    \list{\@biblabel{\arabic{enumiv}}}%
         {\settowidth \labelwidth{\@biblabel{#1}}%
          \leftmargin \labelwidth%
          \advance \leftmargin \labelsep%
          \@openbib@code%
          \usecounter{enumiv}%
          \let \p@enumiv = \@empty%
          \renewcommand \theenumiv{\arabic{enumiv}}%
    }%
    \sloppy%
    \clubpenalty 4000%
    \@clubpenalty \clubpenalty%
    \widowpenalty 4000%
    \sfcode`\.=\@m%
}{%
    \def \@noitemerr{\@latex@warning{Empty `thebibliography' environment}}%
    \endlist%
}
\renewenvironment{theindex}{%
    \if@twocolumn%
        \@restonecolfalse%
    \else%
        \@restonecoltrue%
    \fi%
    \columnseprule \z@%
    \columnsep 35\p@%
    \twocolumn[\@makeschapterhead{\indexname}]%
    \@mkboth{\indexname}{\indexname}%
%%%
%%% Julia Schnabel had an earlier version of the theindex environment and this used:
%%%
%%%     \twocolumn%
%%%     \chapter*{\indexname}{%
%%%         \@mkboth{\indexname}{\indexname}%
%%%     }%
%%%     \addcontentsline{toc}{chapter}{\indexname}%
%%%
%%%     the last line being an addition overwhat was there so as to ensure that the index
%%%     appeared in the contents.
%%%
    % \thispagestyle{plain}%
    \pagestyle{fancy}
    \fancyhf{} % Clear header and footer
    % \fancyhead[L]{\rightmark}
    \renewcommand{\headrulewidth}{0pt}
    \fancyfoot[L]{\footnotesize \textit 
        {Medical Resource Scheduling}
    }
    \fancyfoot[C]{\thepage}
    \fancyfoot[R]{\footnotesize Oleksii Dovhaniuk }



    \small%
    \parindent \z@%
    \parskip \z@ \@plus .3\p@%
    \relax%
%%%
%%% It appears that there is an error in the definition of \@idxitem which causes horrid
%%% looking indexes.  Redefine the miscreant so as to insert the missing \par.  NB.  Cannot
%%% use |\renewcommand| since this does not to work on outer block, even if |\global| is
%%% used.
%%%
%%%  As noticed on 1998.03.15, this appears to have been fixed.
%%%
%%%    \gdef \@idxitem{\par \hangindent 40\p@}
%%%
    \let \item = \@idxitem%
}{%
    \if@restonecol%
        \onecolumn%
    \else%
        \clearpage%
    \fi%
}
%    \end{macrocode}
%
%  \subsection{The Title Page}
%
%  \begin{macro}{\maketitle}
%    Making a title page is non-trivial, especially for a display title page; things are
%    carefully synchronised here so don't change randomly.
%
%    (said Russel, before Ian changed something randomly)
%    We want the author variable for the "I have not plagiarised everything" declaration.
%    We also need a new department variable.
%    \begin{macrocode}
    \def\department#1{\gdef\@department{#1}}
    \def\@department{\@latex@warning@no@line{No \noexpand\department given}}
    \renewcommand \maketitle{%
    \setcounter{page}{1}%
    
    \pagestyle{fancy}
    \fancyhf{} % Clear header and footer
    % \fancyhead[L]{\rightmark}
    \fancyhead[L]{\footnotesize Systematic Review}
    \fancyhead[R]{
        \footnotesize \textit{
            Workflow records
        }
    }
    \renewcommand{\headrulewidth}{0pt}
    \fancyfoot[L]{\footnotesize \textit 
    {Advanced Computational Approaches for\\ 
    Medical Resource Scheduling}
    }
    \fancyfoot[C]{\thepage}
    \fancyfoot[R]{\footnotesize Oleksii Dovhaniuk }
    
    \thispagestyle{empty}% 

    \@maketitle%
    \setcounter{footnote}{0}%
    \let \thanks = \relax%
    \gdef \@address{}%
    \gdef \@thanks{}%
    % \gdef \@author{}%
    \gdef \@department{}%
    \gdef \@title{}%
    \let \maketitle = \relax%
}
%    \end{macrocode}
%  \end{macro}
%  \begin{macro}{\@maketitle}
%  Create a separate title page with the usual material on it.
%    \begin{macrocode}
\newcommand \@maketitle{%
    \newpage%
    \null%
    \vspace*{5em}%
%%%
%%%  Julia Schnabel wanted the following added.
%%%
%%%    \renewcommand{\baselinestretch}{2.5}
%%%    \small
%%%    \normalsize
%%%
    \begin{center}%
    
        {\huge \@title}\\[2.5em]%
        {\Large \@author}\\[-.35em]%
        {ORCID: 0009-0003-2247-9323}\\[4.5em]%
    
    \end{center}%
    \vfill%

    % \begin{figure}
    %     \centering
    %     \includegraphics[width=5em]{figures/ucc-crest.png}
    % \end{figure}

    \begin{center}%

        \includegraphics[width=5em]{figures/ucc-crest.png}
        \\[0.5em]
        \large OLLSCOIL NA hÉIREANN, CORCAIGH \\[-0.3em]
        \large \textbf{NATIONAL UNIVERSITY OF IRELAND, CORK} \\[0.35em]
        School of Computer Science \& Information Technology \\[1.5em]
        \textbf{ WORKFLOW RECORDS } \\
    
    \end{center}%
    \vspace{1em}%

    \begin{center}%
        \@date%
    \end{center}%
    
    \vspace{1em}%

    \begin{center}%

        \begin{flushleft}
            \begin{tabular}{@{}p{7cm}l}
                \hfill {Head of School:}    & Prof. Utz Roedig \\
                \hfill {Supervisors:}       & Dr. Sabin Tabirca \\[-0.6em]
                                            & Prof. Mark Corrigan \\
            \end{tabular}
        \end{flushleft}
     
    \end{center}%
    
    
    
    \if@twoside %
      \newpage%
      ~\\
      \newpage%
    \fi
}
%    \end{macrocode}
%  \end{macro}
%
%  \begin{macro}{\makedeclaration}
%    \begin{macrocode}
       \newcommand \makedeclaration {%
         \clearpage%
         I, \@author , confirm that the work presented in this essay is my own.
         Where information has been derived from other sources, I confirm that this has been indicated in the work.
         \gdef \@author{}%
         \clearpage%
       }%
%    \end{macrocode}
%  \end{macro}
%
%  \subsection{Headings}
%
%  Redefine the chapter and section commands in order to change the font of the section heads.
%  Only include in contents and number down to subsections.
%    \begin{macrocode}
\renewcommand \chapter{%
    \if@openright%
        \cleardoublepage%
    \else%
        \clearpage%
    \fi
    % \thispagestyle{empty}%

    \pagestyle{fancy}
    \fancyhf{} % Clear header and footer
    \fancyhead[L]{\footnotesize Systematic Review}
    \fancyhead[R]{
        \footnotesize \textit{
            Workflow records
        }
    }
    % \fancyhead[L]{\rightmark}
    \renewcommand{\headrulewidth}{0pt}
    \fancyfoot[L]{\footnotesize \textit 
        {Medical Resource Scheduling}
    }
    \fancyfoot[C]{\thepage}
    \fancyfoot[R]{\footnotesize Oleksii Dovhaniuk }

    \global \@topnum \z@%
    \@afterindentfalse%
    \secdef \@chapter \@schapter%
}
\def \@makechapterhead#1{%
    \vspace*{40\p@}%
    {\parindent \z@%
     \raggedright%
     \reset@font%
     \ifnum \c@secnumdepth >\m@ne%
         \if@mainmatter%
             \Large \bfseries \@chapapp{} \thechapter%
             \par%
             \vskip 20\p@%
         \fi%
     \fi%
     \huge \bfseries #1%
     \par%
     \nobreak%
     \vskip 40\p@%
    }%
}
\def \@makeschapterhead#1{%
    \vspace*{50\p@}%
    {\parindent \z@%
     \raggedright%
     \reset@font%
     \huge \bfseries #1%
     \par%
     \nobreak%
     \vskip 40\p@%
    }%
}
\renewcommand \section{\@startsection {section}{1}{\z@}%
                                      {-1ex \@plus -.4ex \@minus -.2ex}%
                                      {.6ex \@plus .1ex}%
                                      {\raggedright \reset@font \Large \bfseries}}
\renewcommand \subsection{\@startsection{subsection}{2}{\z@}%
                                        {-.7ex\@plus -.3ex \@minus -.2ex}%
                                        {.4ex \@plus .1ex}%
                                        {\raggedright \reset@font \large \bfseries}}
\renewcommand \subsubsection{\@startsection{subsubsection}{3}{\z@}%
                                        {-.5ex\@plus -.2ex \@minus -.2ex}%
                                        {.3ex \@plus .1ex}%
                                        {\raggedright \reset@font \large}}
\renewcommand \paragraph{\@startsection{paragraph}{4}{\z@}%
                                       {.5ex \@plus .1ex \@minus .2ex}%
                                       {-.2em}%
                                       {\raggedright \reset@font \normalsize \bfseries}}
\renewcommand \subparagraph{\@startsection{subparagraph}{5}{\parindent}%
                                          {-.3ex \@plus .1ex \@minus .2ex}%
                                          {-.2em}%
                                          {\raggedright \reset@font \normalsize \bfseries}}
\setcounter{secnumdepth}{2}
%    \end{macrocode}
%
%  \subsection{Obscure Environments}
%
%  \begin{environment}{abstract}
%  Need to have an abstract environment.
%    \begin{macrocode}
\newcommand \@abstract{Abstract}
\newenvironment{abstract}{%
    \chapter*{\@abstract}%
    \@mkboth{\@abstract}{\@abstract}%
}{%
}
%    \end{macrocode}
%  \end{environment}
%  \begin{environment}{acknowledgement}
%  Also need an environment for doing the acknowlegements.
%    \begin{macrocode}
\newcommand \@acknowledgements{Acknowledgements}
\newenvironment{acknowledgements}{%
    \chapter*{\@acknowledgements}%
    \@mkboth{\@acknowledgements}{\@acknowledgements}%
}{%
}
%    \end{macrocode}
%  \end{environment}
%  \begin{environment}{impact statement}
%  An environment for the Impact Statement
%    \begin{macrocode}
\newcommand \@impactstatement{Impact Statement}
\newenvironment{impactstatement}{%
    \chapter*{\@impactstatement}%
    \@mkboth{\@impactstatement}{\@impactstatement}%
}{%
}
%    \end{macrocode}
%  \end{environment}
%  \Finale
\endinput
%%
%% End of file
