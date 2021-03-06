%%
%%
%%
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{sty/swathesis}[2014/05/28 v0.5
^^J LaTeX document class for theses at the SWA Group]

% Options.
%
% Language
%  en  -  english (default)
%  de  -  german
%
% Modes
%  draft     - drafting mode, esp for todos
%  fulldraft - drafting mode, also for listings/graphics, faster
%  final     - final mode
%
% Thesis
%  master
%  bachelor
%  phd
%
% Fonts
%  lmodern   - Latin Modern, like TeX default (default)
%  palatino  - Heavier, slightly more readable
%  garamond  - Lighter than palatino, heavier than latin modern, more readable.
%
% Other
%  print - do not color links
%
\RequirePackage{etoolbox}

\newif\if@swa@german
\newif\if@swa@lncs
\providecommand*\@swa@font{}
\providecommand*\printmode{false}
\providecommand*\swa@miscoptions{}
%

\DeclareOption{bachelor}{\@swa@lncstrue\gdef\swa@degree{bachelor}}
\DeclareOption{master}{\@swa@lncsfalse\gdef\swa@degree{master}}
\DeclareOption{phd}{\@swa@lncsfalse\gdef\swa@degree{phd}}

\DeclareOption{draft}{%
  \PassOptionsToPackage{final}{graphics}
  \PassOptionsToPackage{final}{listings}
  \gappto\swa@miscoptions{draft,}}
\DeclareOption{fulldraft}{\gappto\swa@miscoptions{draft,}}


\DeclareOption{en}{\@swa@germanfalse}

\DeclareOption{de}{\@swa@germantrue}

\DeclareOption{palatino}{\renewcommand*\@swa@font{palatino}}
\DeclareOption{garamond}{\renewcommand*\@swa@font{garamond}}
\DeclareOption{lmodern}{\renewcommand*\@swa@font{lmodern}}
\DeclareOption{print}{\renewcommand*\printmode{true}}

\DeclareOption{zebralistings}{\PassOptionsToPackage{zebra}{sty/swa-listings}}

\DeclareOption*{\gappto\swa@miscoptions{\CurrentOption,}}


\ExecuteOptions{master,en,palatino}
\ProcessOptions\relax



\RequirePackage{expl3}
\RequirePackage{sty/swa-platform}


\newcommand*\location[1]{\renewcommand\@location{#1}}
\providecommand*\@location{}

\ifthenelse{\boolean{@swa@lncs}}{%
  \gdef\swa@cls{llncs}%
  \gappto\swa@miscoptions{a4paper,runningheads,}
}{%
  \gdef\swa@cls{scrbook}%
}
\ifx\swa@miscoptions\empty\relax\else
  \PassOptionsToClass{\swa@miscoptions}{\swa@cls}
\fi
\LoadClass{\swa@cls}


\RequirePackage{sty/swa-language}
\RequirePackage{sty/swa-document}


\RequirePackage{sty/swa-graphics}
\RequirePackage{sty/swa-listings}

\RequirePackage{sty/swa-font}

\ifthenelse{\boolean{@swa@lncs}}{
  \robustify{\email}
}{%
  % only in the koma case
  \RequirePackage{sty/swa-abstract}
  \RequirePackage{sty/swa-bibliography}
}

\ifthenelse{\equal{\swa@degree}{phd}}{
  \PassOptionsToPackage{shortcuts,nopostdot,nonumberlist,acronym,xindy}{glossaries}
  \RequirePackage{glossaries}
  \setacronymstyle{long-sc-short}
  \AtEndPreamble{\makeglossaries}
  \AtEndDocument{\glsaddallunused}
}{
  \RequirePackage{sty/swa-acronyms}
}
\RequirePackage{sty/swa-statement}


\newcommand\hairspace{\ifmmode\mskip1mu\else\kern0.08em\fi}
\RequirePackage{xspace}



%\recalctypearea
\raggedbottom

\AtEndOfClass{
  \InputIfFileExists {\jobname-names.tex}{
    \ClassInfo{swathesis}{Using names-file `\jobname-names.tex'}
  }{
    \ClassInfo{swathesis}{Not using a names-file.}
  }
}

%%% Local Variables: 
%%% mode: latex
%%% End: 
