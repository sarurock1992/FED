%%
%%% sice.cls (pLaTeX2e)
%%   for Transactions of the Society of Instrument and Control Engineers
%%    by Motoaki Sato (ULS and Company), 2006-2012. 
%%     E-mail: teppei@uls.co.jp, http://www.uls.co.jp/
\NeedsTeXFormat{pLaTeX2e}
\ProvidesClass{sice}
%%[2006/03/08 v1.00 for Transactions of SICE]
%%[2006/06/29 v1.01 for Transactions of SICE]
  [2012/09/05 v1.02 for Transactions of SICE]

\newif\if@usejistfm \@usejistfmfalse
\DeclareOption{usejistfm}{\@usejistfmtrue}

\def\sice@warning{\ClassWarningNoLine{sice}}
\def\siceline@warning{\ClassWarning{sice}}

\newdimen\@JQ
 \@JQ=0.7392507pt
\newdimen\@Q
 \@Q=0.71144pt
\newdimen\@EM
 \@EM=.03125em

\newif\ifjidori \jidoritrue
\newif\if@english \@englishfalse
\DeclareOption{English}{\@englishtrue\jidorifalse}
\newif\if@shortpaper \@shortpaperfalse
\DeclareOption{Shortpaper}{\@shortpapertrue\@technicalnotefalse}
\newif\if@technicalnote \@technicalnotefalse
\DeclareOption{Technicalnote}{\@shortpapertrue\@technicalnotetrue}

\newif\if@usejistfm \@usejistfmfalse
\DeclareOption{usejistfm}{\@usejistfmtrue}

\newif\if@Proof \@Prooffalse
\DeclareOption{Proof}{\@Prooftrue}
\newif\if@cameraready \@camerareadyfalse
\DeclareOption{cameraready}{\@camerareadytrue}

\newcounter{@paper}
\newcommand{\@ptsize}{}
\newif\if@restonecol

%% for 2.1.4 and non pLaTeX2e compatibility
\@ifundefined{hour}{}{%
 \hour\time \divide\hour by 60\relax
 \@tempcnta\hour \multiply\@tempcnta 60\relax
 \minute\time \advance\minute-\@tempcnta
}
\newif\if@enablejfam \@enablejfamtrue
\newif\if@mathrmmc \@mathrmmcfalse
\DeclareOption{a4paper}{\setcounter{@paper}{1}%
  \setlength\paperheight {297mm}%
  \setlength\paperwidth  {210mm}}
%\DeclareOption{a4j}{\setcounter{@paper}{1}\@stysizetrue
%  \setlength\paperheight {297mm}%
%  \setlength\paperwidth  {210mm}}
\DeclareOption{10pt}{\renewcommand{\@ptsize}{0}}
\DeclareOption{11pt}{\renewcommand{\@ptsize}{1}}
\DeclareOption{12pt}{\renewcommand{\@ptsize}{2}}
\DeclareOption{tombow}{%
  \tombowtrue \tombowdatetrue
  \setlength{\@tombowwidth}{.1\p@}%
  \@bannertoken{%
     \jobname\space:\space\number\year/\number\month/\number\day
      (\number\hour:\number\minute)}
  \maketombowbox}
\DeclareOption{tombo}{%
  \tombowtrue \tombowdatefalse
  \setlength{\@tombowwidth}{.1\p@}%
  \maketombowbox}
\DeclareOption{mentuke}{%
  \tombowtrue \tombowdatefalse
  \setlength{\@tombowwidth}{\z@}%
  \maketombowbox}
\DeclareOption{tate}{%
  \AtBeginDocument{\tate\message{《縦組モード》}%
                   \adjustbaseline}%
}
\DeclareOption{oneside}{\@twosidefalse}
\DeclareOption{twoside}{\@twosidetrue}
\DeclareOption{onecolumn}{\@twocolumnfalse}
\DeclareOption{twocolumn}{\@twocolumntrue}
\DeclareOption{leqno}{\input{leqno.clo}}
\DeclareOption{fleqn}{%\input{fleqn.clo}
 \sice@warning{fleqn is incorporated into this class file}}
\DeclareOption{openbib}{%
  \AtEndOfPackage{%
   \renewcommand\@openbib@code{%
      \advance\leftmargin\bibindent
      \itemindent -\bibindent
      \listparindent \itemindent
      \parsep \z@
      }%
   \renewcommand\newblock{\par}}}
\DeclareOption{disablejfam}{\@enablejfamfalse}
\DeclareOption{draft}{\setlength\overfullrule{5pt}}
\DeclareOption{final}{\setlength\overfullrule{0pt}}
\ExecuteOptions{a4paper,twoside,twocolumn,final}% 10pt,
\ProcessOptions\relax

\if@usejistfm
\DeclareFontShape{JY1}{mc}{m}{n}{%
  <5>     sfixed * [5.1748] jis %  7Q
  <6>     sfixed * [5.9141] jis %  8Q
  <7>     sfixed * [7.3926] jis % 10Q
  <8>     sfixed * [8.1318] jis % 11Q
  <9>     sfixed * [8.8711] jis % 12Q
  <10>    sfixed * [9.6104] jis % 13Q
  <10.95> sfixed * [11.089] jis % 15Q
  <12>    sfixed * [13.307] jis % 18Q
  <14.4>  sfixed * [14.785] jis % 20Q
  <17.28> sfixed * [17.742] jis % 24Q
  <20.74> sfixed * [20.699] jis % 28Q
  <24.88> sfixed * [23.656] jis % 32Q
  <->                       jis % 14Q, 16Q, 36Q, and so on
}{}
\DeclareFontShape{JY1}{mc}{bx}{n}{%
  <5>     sfixed * [5.1748] jisg
  <6>     sfixed * [5.9141] jisg
  <7>     sfixed * [7.3926] jisg
  <8>     sfixed * [8.1318] jisg
  <9>     sfixed * [8.8711] jisg
  <10>    sfixed * [9.6104] jisg
  <10.95> sfixed * [11.089] jisg
  <12>    sfixed * [13.307] jisg
  <14.4>  sfixed * [14.785] jisg
  <17.28> sfixed * [17.742] jisg
  <20.74> sfixed * [20.699] jisg
  <24.88> sfixed * [23.656] jisg
  <->                       jisg
}{}
\DeclareFontShape{JY1}{gt}{m}{n}{%
  <5>     sfixed * [5.1748] jisg
  <6>     sfixed * [5.9141] jisg
  <7>     sfixed * [7.3926] jisg
  <8>     sfixed * [8.1318] jisg
  <9>     sfixed * [8.8711] jisg
  <10>    sfixed * [9.6104] jisg
  <10.95> sfixed * [11.089] jisg
  <12>    sfixed * [13.307] jisg
  <14.4>  sfixed * [14.785] jisg
  <17.28> sfixed * [17.742] jisg
  <20.74> sfixed * [20.699] jisg
  <24.88> sfixed * [23.656] jisg
  <->                       jisg
}{}
\DeclareFontShape{JY1}{gt}{bx}{n}{%
  <5>     sfixed * [5.1748] jisg
  <6>     sfixed * [5.9141] jisg
  <7>     sfixed * [7.3926] jisg
  <8>     sfixed * [8.1318] jisg
  <9>     sfixed * [8.8711] jisg
  <10>    sfixed * [9.6104] jisg
  <10.95> sfixed * [11.089] jisg
  <12>    sfixed * [13.307] jisg
  <14.4>  sfixed * [14.785] jisg
  <17.28> sfixed * [17.742] jisg
  <20.74> sfixed * [20.699] jisg
  <24.88> sfixed * [23.656] jisg
  <->                       jisg
}{}
\else
\DeclareFontShape{JY1}{mc}{m}{n}{%
  <5>     sfixed * [5.1748] min5  %  7Q
  <6>     sfixed * [5.9141] min6  %  8Q
  <7>     sfixed * [7.3926] min7  % 10Q
  <8>     sfixed * [8.1318] min8  % 11Q
  <9>     sfixed * [8.8711] min9  % 12Q
  <10>    sfixed * [9.6104] min10 % 13Q
  <10.95> sfixed * [11.089] min10 % 15Q
  <12>    sfixed * [13.307] min10 % 18Q
  <14.4>  sfixed * [14.785] min10 % 20Q
  <17.28> sfixed * [17.742] min10 % 24Q
  <20.74> sfixed * [20.699] min10 % 28Q
  <24.88> sfixed * [23.656] min10 % 32Q
  <->                       min10 % 14Q, 16Q, 36Q, and so on
}{}
\DeclareFontShape{JY1}{mc}{bx}{n}{%
  <5>     sfixed * [5.1748] goth5
  <6>     sfixed * [5.9141] goth6
  <7>     sfixed * [7.3926] goth7
  <8>     sfixed * [8.1318] goth8
  <9>     sfixed * [8.8711] goth9
  <10>    sfixed * [9.6104] goth10
  <10.95> sfixed * [11.089] goth10
  <12>    sfixed * [13.307] goth10
  <14.4>  sfixed * [14.785] goth10
  <17.28> sfixed * [17.742] goth10
  <20.74> sfixed * [20.699] goth10
  <24.88> sfixed * [23.656] goth10
  <->                       goth10
}{}
\DeclareFontShape{JY1}{gt}{m}{n}{%
  <5>     sfixed * [5.1748] goth5
  <6>     sfixed * [5.9141] goth6
  <7>     sfixed * [7.3926] goth7
  <8>     sfixed * [8.1318] goth8
  <9>     sfixed * [8.8711] goth9
  <10>    sfixed * [9.6104] goth10
  <10.95> sfixed * [11.089] goth10
  <12>    sfixed * [13.307] goth10
  <14.4>  sfixed * [14.785] goth10
  <17.28> sfixed * [17.742] goth10
  <20.74> sfixed * [20.699] goth10
  <24.88> sfixed * [23.656] goth10
  <->                       goth10
}{}
\DeclareFontShape{JY1}{gt}{bx}{n}{%
  <5>     sfixed * [5.1748] goth5
  <6>     sfixed * [5.9141] goth6
  <7>     sfixed * [7.3926] goth7
  <8>     sfixed * [8.1318] goth8
  <9>     sfixed * [8.8711] goth9
  <10>    sfixed * [9.6104] goth10
  <10.95> sfixed * [11.089] goth10
  <12>    sfixed * [13.307] goth10
  <14.4>  sfixed * [14.785] goth10
  <17.28> sfixed * [17.742] goth10
  <20.74> sfixed * [20.699] goth10
  <24.88> sfixed * [23.656] goth10
  <->                       goth10
}{}
\fi

%% JY1 it
\DeclareFontShape{JY1}{mc}{m}{it}{<->ssub*mc/m/n}{}
\DeclareFontShape{JY1}{mc}{bx}{it}{<->ssub*gt/m/n}{}
\DeclareFontShape{JY1}{gt}{m}{it}{<->ssub*gt/m/n}{}
\DeclareFontShape{JY1}{gt}{bx}{it}{<->ssub*gt/m/n}{}
%%
\DeclareFontShape{JY1}{mc}{b}{it}{<->ssub*mc/m/n}{}
\DeclareFontShape{JY1}{gt}{b}{it}{<->ssub*mc/m/n}{}
%% JT1 it
\DeclareFontShape{JT1}{mc}{m}{it}{<->ssub*mc/m/n}{}
\DeclareFontShape{JT1}{mc}{bx}{it}{<->ssub*gt/m/n}{}
\DeclareFontShape{JT1}{gt}{m}{it}{<->ssub*gt/m/n}{}
\DeclareFontShape{JT1}{gt}{bx}{it}{<->ssub*gt/m/n}{}
%%
\DeclareFontShape{JT1}{mc}{b}{it}{<->ssub*mc/m/n}{}
\DeclareFontShape{JT1}{gt}{b}{it}{<->ssub*mc/m/n}{}
%% sc
\DeclareFontShape{JY1}{mc}{m}{sc}{<->ssub*mc/m/n}{}
\DeclareFontShape{JT1}{mc}{m}{sc}{<->ssub*mc/m/n}{}
%% sl
\DeclareFontShape{JY1}{mc}{bx}{sl}{<->ssub*mc/m/n}{}
\DeclareFontShape{JT1}{mc}{bx}{sl}{<->ssub*mc/m/n}{}

%% from /usr/local/teTeX/share/texmf/tex/latex/base/ot1cmr.fd
\DeclareFontShape{OT1}{cmr}{m}{n}%
     {%
      <-6>cmr5%
      <6-7>cmr6%
      <7-8>cmr7%
      <8-9>cmr8%
      <9-10>cmr9%
      <10-12>cmr10%
      <12-17>cmr12%
      <17->cmr17%
      }{}
\DeclareFontShape{OT1}{cmr}{m}{sl}%
     {%
      <-9>cmsl8%
      <9-10>cmsl9%
      <10-12>cmsl10%
      <12->cmsl12%
      }{}
\DeclareFontShape{OT1}{cmr}{m}{it}%
     {%
      <-8>cmti7%
      <8-9>cmti8%
      <9-10>cmti9%
      <10-12>cmti10%
      <12->cmti12%
      }{}
\DeclareFontShape{OT1}{cmr}{m}{sc}%
     {%
      <->cmcsc10%
      }{}
\DeclareFontShape{OT1}{cmr}{m}{ui}
     {%
      <->cmu10%
      }{}
\DeclareFontShape{OT1}{cmr}{b}{n}
     {%
      <->cmb10%
      }{}
\DeclareFontShape{OT1}{cmr}{bx}{n}
     {%
      <-6>cmbx5%
      <6-7>cmbx6%
      <7-8>cmbx7%
      <8-9>cmbx8%
      <9-10>cmbx9%
      <10-12>cmbx10%
      <12->cmbx12%
      }{}
\DeclareFontShape{OT1}{cmr}{bx}{sl}
     {%
      <->cmbxsl10%
      }{}
\DeclareFontShape{OT1}{cmr}{bx}{it}
     {%
      <->cmbxti10%
      }{}
\DeclareFontShape{OT1}{cmr}{bx}{ui}
     {%
      <->sub*cmr/m/ui
      }{}

\renewcommand{\normalsize}{%
 \@setfontsize\normalsize\@ixpt{20\@Q}%
 \abovedisplayskip .5\baselineskip
  \@plus .25\baselineskip \@minus .15\baselineskip
 \abovedisplayshortskip \z@ \@plus 1\p@
 \belowdisplayshortskip .3\baselineskip
  \@plus .15\baselineskip \@minus .1\baselineskip
 \belowdisplayskip \abovedisplayskip
 \let\@listi\@listI}
\normalsize
\setbox0\hbox{\char\euc"A1A1}% "
\setlength\Cht{\ht0}
\setlength\Cdp{\dp0}
\setlength\Cwd{\wd0}
\setlength\Cvs{\baselineskip}
\setlength\Chs{\wd0}

\newcommand{\small}{%
 \@setfontsize\small\@viiipt{15\@Q}%
 \abovedisplayskip .5\baselineskip
  \@plus .25\baselineskip \@minus .15\baselineskip
 \abovedisplayshortskip \z@ \@plus 1\p@
 \belowdisplayshortskip .3\baselineskip
  \@plus .15\baselineskip \@minus .1\baselineskip
 \def\@listi{\leftmargin\leftmargini
             \topsep .5\baselineskip
              \@plus .25\baselineskip \@minus .15\baselineskip
             \parsep\z@
             \itemsep\parsep}%
 \belowdisplayskip\abovedisplayskip
}

\newcommand{\footnotesize}{%
 \@setfontsize\footnotesize\@viipt{15\@Q}%
 \abovedisplayskip .5\baselineskip
  \@plus .25\baselineskip \@minus .15\baselineskip
 \abovedisplayshortskip \z@ \@plus 1\p@
 \belowdisplayshortskip .3\baselineskip
  \@plus .15\baselineskip \@minus .1\baselineskip
 \def\@listi{\leftmargin\leftmargini
             \topsep .5\baselineskip
              \@plus .25\baselineskip \@minus .15\baselineskip
             \parsep\z@
             \itemsep\parsep}%
 \belowdisplayskip\abovedisplayskip}

\newcommand{\scriptsize}{\@setfontsize\scriptsize\@viipt{14\@Q}}
\newcommand{\tiny}{\@setfontsize\tiny\@vipt{13\@Q}}
\newcommand{\large}{\@setfontsize\large\@xpt{20\@Q}}
\newcommand{\Large}{\@setfontsize\Large\@xipt{27\@Q}}
\newcommand{\LARGE}{\@setfontsize\LARGE\@xiipt{28\@Q}}
\newcommand{\huge}{\@setfontsize\huge\@xivpt{32\@Q}}
%\newcommand{\Huge}{\@setfontsize\Huge\@xxvpt{33}}

\headheight 2.75mm
\headsep 4.5mm
\topskip 1\Cht
\footskip 6mm

\setlength\maxdepth{.5\topskip}
\textwidth 171mm % 27x2+3 at 12Q (57zw)
%\@settopoint\textwidth
\textheight 48\Cvs
\advance \textheight \topskip
\advance \textheight .1mm
%\@settopoint\textheight % 690.0pt/690.16597pt
\topmargin\z@
%\@settopoint\topmargin
\setlength\marginparsep{10\p@}
\setlength\marginparpush{5\p@}
\marginparwidth 2in
%\@settopoint\marginparwidth

%\iftombow
 \topmargin\paperheight
 \advance \topmargin -\textheight
 \advance \topmargin -\headheight
 \advance \topmargin -\headsep
 \advance \topmargin -\footskip
 \divide \topmargin \tw@
 \advance \topmargin -1in
 %\@settopoint\topmargin
 \oddsidemargin\paperwidth
 \advance \oddsidemargin -\textwidth
 \divide \oddsidemargin \tw@
 \advance \oddsidemargin -1in
 %\@settopoint\oddsidemargin
 \evensidemargin\oddsidemargin
 %\@settopoint\evensidemargin
%\fi

\footnotesep 2.625mm
\skip\footins .75\Cvs \@plus 4.95mm minus 1mm
\floatsep 1\Cvs \@plus 1.5mm \@minus 2mm
\textfloatsep 1.5\Cvs \@plus 2mm \@minus 3mm
\intextsep 1.5\Cvs \@plus 2mm \@minus 3mm
\dblfloatsep 1\Cvs \@plus 1.5mm \@minus 2mm
\dbltextfloatsep 1.5\Cvs \@plus 2mm \@minus 3mm

\setlength\@fptop{0\p@ \@plus 1fil}
\setlength\@fpsep{8\p@ \@plus 2fil}
\setlength\@fpbot{0\p@ \@plus 1fil}
\setlength\@dblfptop{0\p@ \@plus 1fil}
\setlength\@dblfpsep{8\p@ \@plus 2fil}
\setlength\@dblfpbot{0\p@ \@plus 1fil}
\setlength\partopsep{\z@}% 

\def\@listi{\leftmargin\leftmargini
 %\parsep 4\p@ \@plus2\p@ \@minus\p@
 %\topsep 8\p@ \@plus2\p@ \@minus4\p@
 %\itemsep4\p@ \@plus2\p@ \@minus\p@
 \topsep.5\baselineskip \@plus .25\baselineskip \@minus .15\baselineskip
 \parsep\z@
 \itemsep\parsep
}
\let\@listI\@listi
\@listi
\def\@listii{\leftmargin\leftmarginii
   \labelwidth\leftmarginii \advance\labelwidth-\labelsep
   %\topsep  4\p@ \@plus2\p@ \@minus\p@
   %\parsep  2\p@ \@plus\p@  \@minus\p@
   \topsep.25\baselineskip \@plus .15\baselineskip \@minus .1\baselineskip
   \parsep\z@
   \itemsep\parsep}
\def\@listiii{\leftmargin\leftmarginiii
   \labelwidth\leftmarginiii \advance\labelwidth-\labelsep
   %\topsep 2\p@ \@plus\p@ \@minus\p@
   %\parsep\z@
   \topsep.25\baselineskip \@plus .15\baselineskip \@minus .1\baselineskip
   \parsep\z@
   \partopsep\z@
   \itemsep\topsep}
\def\@listiv {\leftmargin\leftmarginiv
              \labelwidth\leftmarginiv
              \advance\labelwidth-\labelsep}
\def\@listv  {\leftmargin\leftmarginv
              \labelwidth\leftmarginv
              \advance\labelwidth-\labelsep}
\def\@listvi {\leftmargin\leftmarginvi
              \labelwidth\leftmarginvi
              \advance\labelwidth-\labelsep}

\columnsep 9mm
\columnseprule 0\p@
\lineskip 1\p@ 
\normallineskip 1\p@
\renewcommand{\baselinestretch}{}
\parskip\z@
\parindent1zw

\@lowpenalty   51
\@medpenalty  151
\@highpenalty 301

\setcounter{topnumber}{5}
\setcounter{bottomnumber}{5}
\setcounter{totalnumber}{10}
\setcounter{dbltopnumber}{5}
\renewcommand{\topfraction}{.95}
\renewcommand{\bottomfraction}{.95}
\renewcommand{\textfraction}{.05}
\renewcommand{\floatpagefraction}{.05}
\renewcommand{\dbltopfraction}{.95}
\renewcommand{\dblfloatpagefraction}{.05}

\def\fmt@month#1{%
 \ifx\tmp@month\empty Xxx\else
  \ifcase#1 Xxx\or January\or February\or March\or April\or
   May\or June\or July\or August\or September\or October\or
    November\or December\else
   \@ctrerr\fi\relax
 \fi
}

\def\received#1#2#3{%
 \begingroup
  \def\tmp@month{#2}%
  \protected@xdef\@received{%
   \@received
   \protect\footnotetext[0]{%
    \if@english (\else\hskip-1.25mm （\fi Received\ 
     \fmt@month{#2}\ 
     #3, #1\if@english )\else{}）\fi}%
  }%
 \endgroup
 \gdef\@receivedyear{#1}}

\def\revised#1#2#3{%
 \begingroup
  \def\tmp@month{#2}%
  \protected@xdef\@revised{%
   \@revised
   \protect\footnotetext[0]{%
    \if@english (\else\hskip-1.25mm （\fi Revised\ 
     \fmt@month{#2}\ 
     #3, #1\if@english )\else{}）\fi}%
  }%
 \endgroup}

\def\@received{}
\def\@receivedyear{}
\def\@revised{}

\def\Vol#1{%
 \edef\@tempb{\zap@space#1 \@empty}%
 \afterassignment\remove@to@nnil
 \count@ 0\@tempb\relax\@nnil
 \ifnum\count@=\z@ % case of \Vol{0}
  \gdef\@Vol{xx}%
 \else
  \gdef\@Vol{\zap@space#1 \@empty}%
 \fi
}
\def\@Vol{xx}

\def\No#1{%
 \def\@tempa{#1}%
 \ifx\@tempa\empty
  \gdef\@No{xx}%
  \gdef\@@No{xx}%
  \gdef\@@@No{0}%
 \else
  \edef\@tempb{\zap@space#1 \@empty}%
  \afterassignment\remove@to@nnil
  \count@ 0\@tempb\relax\@nnil
  \ifnum\count@=\z@ % case of \No{0}
   \gdef\@No{xx}%
   \gdef\@@No{xx}%
   \gdef\@@@No{0}%
  \else
   \gdef\@No{\zap@space#1 \@empty}%
   \gdef\@@No{\two@digits{\@No}}%
   \gdef\@@@No{\zap@space#1 \@empty}%
  \fi
 \fi
}
\def\@No{xx}
\def\@@No{xx}
\def\@@@No{0}

\def\Year#1{%
 \def\@tempa{#1}%
 \ifx\@tempa\empty
  \gdef\@Year{20xx}%
  \gdef\@@Year{xx}%
 \else
  \gdef\@Year{#1}%
  \afterassignment\remove@to@nnil
   \count@ 0#1\relax\@nnil
  \ifnum\count@=\z@ % case of \Year{0}
   \gdef\@Year{20xx}%
  \else
   \@tempcnta=#1\relax
   \advance \@tempcnta -2000\relax
   \xdef\@@Year{\two@digits{\the\@tempcnta}}%
  \fi
 \fi
}
\def\@Year{20xx}
\def\@@Year{xx}

\def\@footpage{%
 \ifnum \value{page} < 10\relax
  \gdef\@@footpage{000\thepage}%
 \else
  \ifnum \value{page} < 100\relax
   \gdef\@@footpage{00\thepage}%
  \else
   \ifnum \value{page} < 1000\relax
    \gdef\@@footpage{0\thepage}%
   \else
    \gdef\@@footpage{\thepage}%
   \fi
  \fi
 \fi
}

\def\sice@copyright{\scriptsize \raise.2mm\hbox{\copyright}}
\def\@@receivedyear{%
 \ifx\@receivedyear\empty
  \@Year
 \else
  \@receivedyear
 \fi
}

\if@Proof
 \def\@Rtop{\rlap{\smash{\rule[-\headsep]{0.05mm}{10mm}%
  \rule[-\headsep]{10mm}{0.05mm}}}}
 \def\@Ltop{\llap{\smash{\rule[-\headsep]{10mm}{0.05mm}%
  \rule[-\headsep]{0.05mm}{10mm}}}}
 \def\@Rbot{\rlap{\smash{\raisebox{1\footskip}
  {\rule[-10mm]{0.05mm}{10mm}\rule{10mm}{0.05mm}}}}}
 \def\@Lbot{\llap{\smash{\raisebox{1\footskip}
  {\rule{10mm}{0.05mm}\rule[-10mm]{0.05mm}{10mm}}}}}
\else
 \let\@Rtop\relax\let\@Ltop\relax\let\@Rbot\relax\let\@Lbot\relax
\fi

\if@cameraready
 \def\nombre@font{\useroman{T1}{pnc}{b}{it}\small}
\else
 \def\nombre@font{\small\bfseries\slshape}
\fi
\def\head@font{\normalfont\small}

\def\ps@SICE{%
 \let\@mkboth\@gobbletwo
 \def\@evenhead{\@Ltop
  \rlap{\hskip3mm\nombre@font \thepage}\hfil
  {\head@font T.\,SICE\hskip2.75mm Vol.\@Vol\hskip2.75mm 
   No.\@No\hskip2.75mm \fmt@month{\@@@No}\hskip2.75mm\@Year}\hfil
  \@Rtop}%
 \def\@oddhead{\@Ltop\hfil
  {\head@font 計測自動制御学会論文集\hskip2.75mm 第\@Vol 巻\hskip2.75mm
  第\@No 号\hskip2.75mm \@Year 年\@No 月}\hfil
  \llap{\nombre@font \thepage\hskip3mm}%
  \@Rtop}%
 \def\@evenfoot{\@Lbot\hfil\@Rbot}%
 \let\@oddfoot\@evenfoot
}

%% first page (\maketitle)
\def\ps@sice{%
 \let\@mkboth\@gobbletwo
 \def\@oddhead{\@Ltop\hfil\@Rtop}%
 \let\@evenhead\@oddhead
 \def\@evenfoot{\@Lbot\hfil
  \@footpage{\normalfont\scriptsize
   TR\ 
   00\@@No/\@@Year/\@Vol\@@No--\@@footpage\,\sice@copyright\,\@@receivedyear\ 
   SICE}%
  \hfil\@Rbot}%
 \let\@oddfoot\@evenfoot
}

\def\sice@fnsymbol#1{%
 \afterassignment\remove@to@nnil
  \count@ 0#1\relax\@nnil
 \ifnum\count@=\z@
  \sice@warning{some \string\affiliate\space is not assigned}%
  \mathrm{xx}%
 \else
  \relax
  \ifnum\chk@alcnt>9\relax
   \ifcase #1\or {*}1\or {*}2\or {*}3\or {*}4\or {*}5\or {*}6\or {*}7\or
    {*}8\or {*}9\or {*}10\or {*}11\or {*}12\or {*}13\or {*}14\or {*}15\or
     \dagger\else\@ctrerr\fi\relax
  \else
   \ifcase #1\or {*}\or {*}{*}\or {*}{*}{*}\or {*}{*}{*}{*}\or
    {*}{*}{*}{*}{*}\or {*}{*}{*}{*}{*}{*}\or {*}{*}{*}{*}{*}{*}{*}\or
    {*}{*}{*}{*}{*}{*}{*}{*}\or {*}{*}{*}{*}{*}{*}{*}{*}{*}\or
    \or \or \or \or \or \or \dagger\else\@ctrerr\fi\relax
  \fi
 \fi
}

\def\maketitle{\par
 \ifnum \@alcnt=\chk@alcnt\else
  \sice@warning{no or extra \string\affiliate\space is specified}%
 \fi
 \begingroup
  \def\thefootnote{\fnsymbol{footnote}}%
  \let\@fnsymbol\sice@fnsymbol
  \def\@makefnmark{\hbox{$^{\@thefnmark}$}}%
  \long\def\@makefntext##1{\small
   \ifnum\chk@alcnt>9\relax
    \@tempdima2zw
    \@tempdimb\@tempdima
    \advance \@tempdimb .5zw
   \else
    \divide \chk@alcnt \tw@
    \advance \chk@alcnt \@ne
    \@tempdima=\chk@alcnt zw
    \@tempdimb\@tempdima
    \advance \@tempdimb .5zw
   \fi
   \everypar={\hangafter=1\relax\hangindent\@tempdimb}%
   \noindent
   \hbox to \@tempdima{\hss $^{\@thefnmark}$}%
    \hskip.5zw ##1}%
  %%
  \twocolumn[\@maketitle]%
  \thispagestyle{sice}
   \@titlenote
   \@subtitlenote
   \@Jaffiliate
   \@Eaffiliate
   \@received
   \@revised
 \endgroup
 \setcounter{footnote}{0}%
 \global\let\maketitle\relax
 \global\let\@maketitle\relax
 \global\let\@jtitle\@empty
 \global\let\@jsubtitle\@empty
 \global\let\@etitle\@empty
 \global\let\@esubtitle\@empty
 \global\let\@Jaffiliate\@empty
 \global\let\@Eaffiliate\@empty
 \global\let\@titlenote\@empty
 \global\let\@subtitlenote\@empty
 \global\let\@received\@empty
 \global\let\@revised\@empty
 \let\affiliate\relax\let\eaffiliate\relax
 \@authorcnt\z@
 \loop\ifnum \@authorcnt < \total@nr
  \advance \@authorcnt \@ne
   \expandafter\let\csname @Jauthorname\number\@authorcnt\endcsname\relax
   \expandafter\let\csname @Eauthorname\number\@authorcnt\endcsname\relax
   \expandafter\let\csname al@\number\@authorcnt\endcsname\relax
 \repeat
}

\newdimen\@tempdimc

\def\make@titlehead{%
 \@tempdimc1mm
 \leavevmode
 \hbox to \hsize{%
  \if@shortpaper
   \if@english % patch a
    \raise 4.75mm
    \hbox{%
     \vtop{\vskip-\@tempdimc
      \hbox{\lower1mm\hbox{\bfseries 〈%
       \if@technicalnote
        Technical Note%
       \else
        Short Paper%
       \fi
      〉}}%
      \hbox{%
      \vtop{\hbox{\@special@issue}\vskip-\@tempdimc
       \hbox{%
        \vbox to 7mm{\hsize=1.5mm
         \hrule \@width 1.5mm \@height .2mm
         \vss
         \hbox to 1.5mm{\vrule \@width .2mm \@height 7mm\hss}%
         \vss
         \hrule \@width 1.5mm \@height .2mm
        }%
         \vbox{%
          \hbox to 53.5mm{\small\bfseries
           Trans.\ of the Society of Instrument}% 48.5mm
           \vskip-.9mm
          \hbox to 53.5mm{\small\bfseries\hss and Control Engineers\hss}%
           \vskip-1.55mm
          \hbox to 53.5mm{\tiny\hss Vol.\@Vol, No.\@No, 
            \thepage/\pageref{sice@lastpage}\ (\@Year)\hss}%
         }%
        \vbox to 7mm{\hsize=1.5mm
         \hrule \@width1.5mm \@height .2mm
         \vss
         \hbox to 1.5mm{\hss\vrule \@width .2mm \@height 7mm}%
         \vss
         \hrule \@width1.5mm \@height .2mm
        }%
       }%
      }}%
     }%
    }%
   \else
    \raise 4.75mm\hbox{%
     \vtop{\hbox{\@special@issue}%
      \vskip-\@tempdimc
      \hbox{\small\bfseries 〈%
       \if@technicalnote
        開発・技術ノート%
       \else
        ショート・ペーパー%
       \fi
      〉}}%
    }%
   \fi
  \else
   \if@english
    \raise4.75mm\hbox{%
    \vtop{\hbox{\@special@issue}\vskip-\@tempdimc
     \hbox{%
      \vbox to 7mm{\hsize=1.5mm
       \hrule \@width 1.5mm \@height .2mm
       \vss
       \hbox to 1.5mm{\vrule \@width .2mm \@height 7mm\hss}%
       \vss
       \hrule \@width 1.5mm \@height .2mm
      }%
       \vbox{%
        \hbox to 53.5mm{\small\bfseries
         Trans.\ of the Society of Instrument}% 48.5mm
         \vskip-.9mm
        \hbox to 53.5mm{\small\bfseries\hss and Control Engineers\hss}%
         \vskip-1.55mm
        \hbox to 53.5mm{\tiny\hss Vol.\@Vol, No.\@No, 
          \thepage/\pageref{sice@lastpage}\ (\@Year)\hss}%
       }%
      \vbox to 7mm{\hsize=1.5mm
       \hrule \@width1.5mm \@height .2mm
       \vss
       \hbox to 1.5mm{\hss\vrule \@width .2mm \@height 7mm}%
       \vss
       \hrule \@width1.5mm \@height .2mm
      }%
     }%
    }}%
   \else
    \raise 4.75mm\hbox{%
    \vtop{\hbox{\@special@issue}}}%
   \fi
  \fi
  %%
  \hss
  %%
  \if@shortpaper
   \if@english
    \lower2mm
   \fi
  \fi
  \hbox{%
   \vbox to 5.75mm{\hsize=1.5mm
    \hrule \@width 1.5mm \@height .2mm
    \vss
    \hbox to 1.5mm{\vrule \@width .2mm \@height 5.75mm\hss}%
    \vss
    \hrule \@width1.5mm \@height .2mm
   }%
   \setbox\@tempboxa\hbox{%
    Vol.\@Vol, No.\@No, \thepage/\pageref{sice@lastpage}%
    （\@Year ）\hskip-1.25mm\mbox{}}%
    \ifdim\wd\@tempboxa > 41.25mm
     \parbox[b]{\wd\@tempboxa}{\kintou{\wd\@tempboxa}%
      {\small\bfseries 計測自動制御学会論文集}\\[-.5mm]
      \mbox{}\hfil\box\@tempboxa\hfil}%
    \else
     \parbox[b]{41.25mm}{%
      \kintou{41.25mm}{\small\bfseries 計測自動制御学会論文集}\\[-.5mm]
      \mbox{}\hfil\box\@tempboxa\hfil}%
    \fi
   \vbox to 5.75mm{\hsize=1.5mm
    \hrule \@width1.5mm \@height .2mm
    \vss
    \hbox to 1.5mm{\hss\vrule \@width .2mm \@height 5.75mm}%
    \vss
    \hrule \@width1.5mm \@height .2mm
   }%
  }%
 }%
}

\def\jauthor@font{\fontsize{14\@JQ}{26\@Q}\selectfont}

\def\@maketitle{%
 \parindent\z@
 \setbox\@tempboxa\vbox{%
  \vskip1mm
  \bgroup
   \small
   \make@titlehead
  \egroup
  \if@english
   \ifx\@special@issue\empty
    \vskip3\@Q
   \else
    \vskip11\@Q
   \fi
  \else
   \if@shortpaper
    \vskip4\@Q
   \else
    \vskip3\@Q
   \fi
  \fi
  \if@shortpaper
   \if@english
    \bgroup
     \large\baselineskip=19\@Q \centering
     \@etitle\par
    \egroup
    \bgroup
     \normalsize \centering
     \@esubtitle\par
    \egroup
    \vskip8\@Q
    \bgroup
     \large\baselineskip=19\@Q \centering
     \@outputEauthorlist\par
    \egroup
   \else
    \bgroup
     \Large\bfseries \centering
     \@jtitle\par
    \egroup
    \bgroup
     \ifx\@jsubtitle\empty
     \else
      \large\bfseries \centering
      \vskip5\@Q
      \@jsubtitle\par
     \fi
    \egroup
    \vskip1\@Q
    \bgroup
     \normalsize\jauthor@font \centering
     \@outputJauthorlist\par
    \egroup
    \vskip13\@Q
    \bgroup
     \large\baselineskip=19\@Q \centering
     \@etitle\par
    \egroup
    \bgroup
     \normalsize \centering
     \@esubtitle\par
    \egroup
    \vskip8\@Q
    \bgroup
     \large\baselineskip=19\@Q \centering
     \@outputEauthorlist\par
    \egroup
   \fi
   \vskip6\@Q
  \else
   \if@english
    \bgroup
     \huge\bfseries \centering
     \@etitle\par
    \egroup
    \bgroup
     \ifx\@esubtitle\empty
     \else
      \LARGE \centering
      \vskip2\@Q
      \@esubtitle\par
     \fi
    \egroup
    \vskip9\@Q
    \bgroup
     \Large\baselineskip=26\@Q \centering
     \@outputEauthorlist\par
    \egroup
    \vskip 24\@Q
   \else
    \bgroup
     \huge\bfseries \centering
     \@jtitle\par
    \egroup
    \bgroup
     \ifx\@jsubtitle\empty
     \else
      \LARGE\bfseries \centering
      \vskip5\@Q
      \@jsubtitle\par
     \fi
    \egroup
    \vskip9\@Q
    \bgroup
     \Large\normalfont \centering
     \@outputJauthorlist
     \vskip22\@Q
     \@etitle\par
    \egroup
    \bgroup
     \ifx\@esubtitle\empty
     \else
      \vskip2\@Q
      \large\baselineskip=19\@Q \centering
      \@esubtitle\par
     \fi
    \egroup
    \vskip18\@Q
    \bgroup
     \large\baselineskip=19\@Q \centering
     \@outputEauthorlist\par
    \egroup
    \vskip2\Cvs
   \fi
  \fi
  %%
  \ifvoid\@abstractbox
   \vskip-\Cvs
  \else
   \hfil\box\@abstractbox\par
  \fi
  \ifvoid\@keywordsbox
  \else
   \vskip13\@Q
   \hfil\box\@keywordsbox\par
  \fi
  %%\vskip26\@Q
 }%
 %%
 \@tempdima \ht\@tempboxa
 \advance \@tempdima \dp\@tempboxa
 \@tempdimb \@tempdima
 \divide \@tempdimb \Cvs
 \@tempcnta=\@tempdimb
 \@tempdimb \@tempcnta\Cvs
 \advance \@tempdima -\@tempdimb
 \ifdim \@tempdimb > .5\Cvs
  \advance \@tempcnta \@ne
 \fi
 %%
 \newpage\null
 \boxmaxdepth\z@
 \lineskiplimit\z@
 \lineskip\z@
 \vbox to \@tempcnta\Cvs{%
  \box\@tempboxa
 \vss}%
 \vskip\Cvs
 \vskip\belowtitlesep
}

\newdimen\belowtitlesep
\belowtitlesep\z@

\newif\if@specialissue \@specialissuefalse
\def\specialissue{\@ifnextchar[% ]
 {\@specialissuetrue\@specialissue}{\@specialissue[特集\hskip3mm]}%
}

\def\@specialissue[#1]#2{%
 \gdef\@special@issue{%
  \vtop{\hrule \@height.1mm
   \hbox{%
    \vrule \@width.1mm \@height 6mm
    \vbox to 6mm{\vss
     \hbox{\hskip1.5mm #1#2\if@specialissue ---\fi\hskip1.5mm\null}%
    \vss}%
    \vrule \@width.1mm \@height 6mm
   }%
   \hrule \@height.1mm
  }\global\@tempdimc-1mm}}
\def\@special@issue{}

\def\titlenote#1{%
 \protected@xdef\@titlenote{%
  \@titlenote\protect\footnotetext[16]{#1}}%
}
\def\@titlenote{}

\def\subtitlenote#1{%
 \protected@xdef\@subtitlenote{%
  \@subtitlenote\protect\footnotetext[16]{#1}}%
}
\def\@subtitlenote{}

\def\titlenote@mark{%
 \unskip\hskip0pt
 $^{\dagger}$%
}

\long\def\jtitle#1{%
 \gdef\@jtitle{#1%
  \ifx\@titlenote\empty\else\titlenote@mark\fi
 }%
}
\def\@jtitle{}

\long\def\jsubtitle#1{%
 \gdef\@jsubtitle{#1%
  \ifx\@subtitlenote\empty\else\titlenote@mark\fi
 }%
}
\def\@jsubtitle{}

\long\def\etitle#1{\gdef\@etitle{#1}}
\def\@etitle{}

\long\def\esubtitle#1{\gdef\@esubtitle{#1}}
\def\@esubtitle{}

\newtoks\@authorlist
\newcount\@authorcnt
\newcount\@alcnt
\newcount\total@nr
\newbox\@tempboxb
\newbox\@tempboxc
\newbox\@tempboxd

\newcount\chk@alcnt
\newcount\@SPRcnta
\newcount\@SPRcntb
\newcount\@SPRcntc

\def\authorlist#1{%
 \if@english
  \let\authorentry\eauthorentry
  \let\affiliate\eaffiliate
 \fi
 \@authorlist={#1}\the\@authorlist\relax
}

\def\get@al#1{%
 \def\al@none{none}\def\@tempaffi{#1}%
 \ifx\al@none\@tempaffi\else
  \@for\get@label:=#1\do{%
   \@ifundefined{chk@\get@label}{\global\advance \chk@alcnt \@ne
    \expandafter\gdef\csname chk@\get@label\endcsname{}%
   }{}%
   \expandafter\def\expandafter\save@al\expandafter{%
    \csname al@\get@label\endcsname}%
   \advance \@tempcnta \@ne
   \protected@xdef\plural@affi{\plural@affi
    \ifnum\@tempcnta=\@ne
     $^{\protect\sice@fnsymbol{\save@al}}$%
    \else
     $^{,\protect\sice@fnsymbol{\save@al}}$%
    \fi
   }%
  }%
 \fi
}
\def\plural@affi{}

\def\name@expandafter#1#2{%
 \def\next{#1}%
 \edef\@tempa{#2}%
 \ifx\@tempa\@empty
  \sice@warning{author's name is empty}%
  \def\@tempa{\@empty}%
 \fi
 \expandafter\next\@tempa}
\def\chk@name#1{\name@expandafter\@chk@name{#1}\@nil}
\def\@chk@name#1#2\@nil{\def\get@oneword{#1}}

\def\fmt@Jan#1{%
 \@temptokena{#1}%
 %% check of exceptions
 \chk@name{\the\@temptokena}%
 \setbox\@tempboxd\hbox{\get@oneword}%
 \ifdim \wd\@tempboxd=1zw %% japanese
  \setbox\@tempboxc\hbox{\spaceskip=100mm #1}%
  \ifdim \wd\@tempboxc < 100mm
   \sice@warning{Author's name "#1" doesn't have a space}%
   \def\@authorname{\the\@temptokena}%
  \else
   \setbox\@tempboxc\hbox{#1}%
   \ifdim \wd\@tempboxc > 7zw
    \def\tr@name##1 ##2\@nil{##1\hskip1zw ##2}%
   \else
    \def\@checkbox##1 ##2\@nil{%
     \setbox\@tempboxa\hbox{##1}\setbox\@tempboxb\hbox{##2}}%
    \edef\@tempcheck{\expandafter\@checkbox #1\@nil}%
    \@tempcheck
    \def\tr@name##1 ##2\@nil{\leavevmode\hbox{%
     \ifdim \wd\@tempboxa < 3zw
      \hbox to 3zw{\kanjiskip=1zw \@plus 1zw ##1\hss}%
     \else
      \hbox to 3zw{##1\hss}%
     \fi
     \hskip 1zw
     \ifdim \wd\@tempboxb < 3zw
      \hbox to 3zw{\hss\kanjiskip=1zw \@plus 1zw ##2}%
     \else
      \hbox to 3zw{\hss ##2}%
     \fi
    }}%
   \fi
   \protected@xdef\@authorname{\expandafter\tr@name #1\@nil\null}%
  \fi
 \else %% engish
  \def\tr@name##1 ##2\@nil{##1 {\protect\scshape ##2}}%
  \protected@xdef\@authorname{\expandafter\tr@name #1\@nil\null}%
 \fi
}

\def\authorentry#1#2#3{%
 \def\tmp@an{#1}%
 \ifx\tmp@an\empty
 \else
  \@tempcnta\z@
  \advance \@authorcnt \@ne
  %% author label
  \get@al{#3}%
  \def\al@none{0}%
  %% author's name in Japanese
  %%\@temptokena{#1}
  \fmt@Jan{#1}% \the\@temptokena
  \expandafter\protected@xdef\csname @Jauthorname\number\@authorcnt\endcsname{%
   \@authorname\unskip\kern\z@\plural@affi
  }%
  %% author's name in English, same as \eauthorentry
  \def\tr@name##1 ##2\@nil{##1 {\protect\scshape ##2}}%
  \protected@edef\@authorname{\expandafter\tr@name #2\@nil\null}%
  \expandafter\protected@xdef\csname @Eauthorname\number\@authorcnt\endcsname{%
   \@authorname\unskip\kern\z@\plural@affi
  }%
  \global\total@nr=\@authorcnt
  \def\@tempcheck{}%
  \def\plural@affi{}%
 \fi
}

\def\eauthorentry#1#2{%
 \def\tmp@an{#1}%
 \ifx\tmp@an\empty
 \else
  \@tempcnta\z@
  \advance \@authorcnt \@ne
  %% author label
  \get@al{#2}%
  \def\al@none{0}%
  %% author's name in English, same as \authorentry
  \def\tr@name##1 ##2\@nil{##1 {\protect\scshape ##2}}%
  \protected@edef\@authorname{\expandafter\tr@name #1\@nil\null}%
  \expandafter\protected@xdef\csname @Eauthorname\number\@authorcnt\endcsname{%
   \@authorname\unskip\kern\z@\plural@affi
  }%
  \global\total@nr=\@authorcnt
  \def\plural@affi{}%
 \fi
}

\def\@outputJauthorlist{%
 \ifnum \total@nr > 12\relax
  \sice@warning{too many authors}%
 \fi
 %%
 \align@author{・}{\\}{・}{@Jauthorname}%
}

\def\@outputEauthorlist{%
 \align@author{,\ }{,\\}{\ and\ }{@Eauthorname}%
}

\def\align@author#1#2#3#4{%
 \@authorcnt\z@
 \@SPRcntc=\total@nr
 \advance \@SPRcntc -\@ne
 \loop\ifnum \@authorcnt < \total@nr
  \advance \@authorcnt \@ne
  \expandafter\def\csname SPR\number\@authorcnt\endcsname{#1}%
  \ifnum \total@nr = \@ne
   \expandafter\def\csname SPR\number\@authorcnt\endcsname{}%
  \else
   \ifnum \total@nr < 4\relax
   \else
    \ifnum \total@nr < 6\relax
     \@SPRcnta=\total@nr
     \advance \@SPRcnta -\tw@
     \expandafter\def\csname SPR\number\@SPRcnta\endcsname{#2}%
    \else
     \ifnum \total@nr < 8\relax
      \@SPRcnta=\total@nr
      \advance \@SPRcnta -\thr@@
      \expandafter\def\csname SPR\number\@SPRcnta\endcsname{#2}%
     \else
      \ifnum \total@nr = 8\relax
       \@SPRcnta=\total@nr
       \advance \@SPRcnta -4\relax
       \expandafter\def\csname SPR\number\@SPRcnta\endcsname{#2}%
      \else
       \ifnum \total@nr < 11\relax
        \@SPRcnta=\total@nr
        \@SPRcntb=\total@nr
        \advance \@SPRcnta -\thr@@
        \advance \@SPRcntb -6\relax
        \expandafter\def\csname SPR\number\@SPRcnta\endcsname{#2}%
        \expandafter\def\csname SPR\number\@SPRcntb\endcsname{#2}%
       \else
        \ifnum \total@nr = 11\relax
         \@SPRcnta=\total@nr
         \@SPRcntb=\total@nr
         \advance \@SPRcnta -\thr@@
         \advance \@SPRcntb -7\relax
         \expandafter\def\csname SPR\number\@SPRcnta\endcsname{#2}%
         \expandafter\def\csname SPR\number\@SPRcntb\endcsname{#2}%
        \else
         \ifnum \total@nr = 12\relax
          \@SPRcnta=\total@nr
          \@SPRcntb=\total@nr
          \advance \@SPRcnta -4\relax
          \advance \@SPRcntb -8\relax
          \expandafter\def\csname SPR\number\@SPRcnta\endcsname{#2}%
          \expandafter\def\csname SPR\number\@SPRcntb\endcsname{#2}%
         \else
          \ifnum \total@nr < 15\relax
           \expandafter\def\csname SPR4\endcsname{#2}%
           \expandafter\def\csname SPR8\endcsname{#2}%
           \expandafter\def\csname SPR11\endcsname{#2}%
          \else
           \ifnum \total@nr < 17\relax
            \expandafter\def\csname SPR4\endcsname{#2}%
            \expandafter\def\csname SPR8\endcsname{#2}%
            \expandafter\def\csname SPR12\endcsname{#2}%
           \else
            \ifnum \total@nr < 19\relax
	     \expandafter\def\csname SPR4\endcsname{#2}%
	     \expandafter\def\csname SPR8\endcsname{#2}%
	     \expandafter\def\csname SPR12\endcsname{#2}%
	     \expandafter\def\csname SPR15\endcsname{#2}%
            \else % 19, 20
	     \expandafter\def\csname SPR4\endcsname{#2}%
	     \expandafter\def\csname SPR8\endcsname{#2}%
	     \expandafter\def\csname SPR12\endcsname{#2}%
	     \expandafter\def\csname SPR16\endcsname{#2}%
            \fi
           \fi
          \fi
         \fi
        \fi
       \fi
      \fi
     \fi
    \fi
   \fi
  \fi
  \expandafter\def\csname SPR\number\@SPRcntc\endcsname{#3}%
  \expandafter\def\csname SPR\number\total@nr\endcsname{}%
  %%
  \csname #4\number\@authorcnt\endcsname
  \expandafter\def\csname #4\number\@authorcnt\endcsname{}%
  \csname SPR\number\@authorcnt\endcsname
 \repeat
}

\def\affiliate[#1]#2#3{%
 \advance \@alcnt \@ne
 \expandafter\xdef\csname al@#1\endcsname{\the\@alcnt}% 
 \bgroup
  \protected@xdef\@Jaffiliate{\@Jaffiliate
   \protect\footnotetext[\csname al@#1\endcsname]{#2}}%
  \protected@xdef\@Eaffiliate{\@Eaffiliate
   \protect\footnotetext[\csname al@#1\endcsname]{#3}}%
 \egroup
}
\def\@Jaffiliate{}
\def\@Eaffiliate{}

\def\eaffiliate[#1]#2{%
 \advance \@alcnt \@ne
 \expandafter\xdef\csname al@#1\endcsname{\the\@alcnt}% 
 \bgroup
  \protected@xdef\@Eaffiliate{\@Eaffiliate
   \protect\footnotetext[\csname al@#1\endcsname]{#2}}%
 \egroup
}

\newbox\@abstractbox
\newbox\@keywordsbox

\def\abstract{%
 \global\setbox\@abstractbox\hbox\bgroup
  \begin{minipage}[t]{159mm}% 12Q x 53zw
  \if@shortpaper
   \small
  \else
   \normalsize\baselineskip16\@Q
  \fi
  \parindent1zw
  \ignorespaces
}
\def\endabstract{%
   \unskip\inhibitglue
  \end{minipage}%
 \egroup\ignorespaces}

\def\keywords{%
 \global\setbox\@keywordsbox\hbox\bgroup
  \begin{minipage}[t]{159mm}% 12Q x 53zw
  \if@shortpaper
   \small
  \else
   \normalsize\baselineskip16\@Q
  \fi
  \@hangfrom{\bfseries Key Words:\ }%
  \kern\z@\ignorespaces
}
\def\endkeywords{%
   \unskip\inhibitglue
  \end{minipage}%
 \egroup\ignorespaces}

\setcounter{secnumdepth}{3}

%%\newcounter{part}
\newcounter{section}
\newcounter{subsection}[section]
\newcounter{subsubsection}[subsection]
\newcounter{paragraph}[subsubsection]
\newcounter{subparagraph}[paragraph]
%%\renewcommand{\thepart}{\@Roman\c@part}
\renewcommand{\thesection}{\@arabic\c@section}
\renewcommand{\thesubsection}{\thesection.\protect\,\@arabic\c@subsection}
\renewcommand{\thesubsubsection}{%
 \thesubsection.\protect\,\@arabic\c@subsubsection}
\renewcommand{\theparagraph}{%
 \thesubsubsection.\protect\,\@arabic\c@paragraph}
\renewcommand{\thesubparagraph}{%
 \theparagraph.\protect\,\@arabic\c@subparagraph}

\def\@afterheading{%
 \global\@nobreaktrue
 \everypar{%
  \if@nobreak
   \global\@nobreakfalse
   \clubpenalty \z@
    \if@afterindent
    \else
     {\setbox\z@=\lastbox}%
    \fi
  \else
   \clubpenalty\@clubpenalty
   \everypar{}%
  \fi}%
}

%% \@startsection{NAME}{LEVEL}{INDENT}{BEFORESKIP}{AFTERSKIP}{STYLE}
\def\@startsection#1#2#3#4#5#6{%
  \if@noskipsec \leavevmode \fi
  \par
  \@tempskipa #4\relax
  \@afterindenttrue
  \ifdim \@tempskipa < \z@ \@tempskipa -\@tempskipa \@afterindentfalse\fi
  \if@nobreak
   \everypar{}%
  \else
   %%\addpenalty\@secpenalty
   \ifnum#2=\@ne  %% 1/*/1 or 0.5/*/0.5
    \vskip-\prevdepth \prevdepth\z@ \vskip\Cvs
    \advance\@tempskipa-\Cvs
    \vspace*{\@tempskipa}
   \else
    \addvspace\@tempskipa
   \fi
  \fi
 \@ifstar{\@ssect{#3}{#4}{#5}{#6}}{\@dblarg{\@sect{#1}{#2}{#3}{#4}{#5}{#6}}}}

%% \@sect{NAME}{LEVEL}{INDENT}{BEFORESKIP}{AFTERSKIP}{STYLE}[ARG1]{ARG2}
%% \ifdim \@tempskipa>\z@ --> \ifdim \@tempskipa<\z@
\def\@sect#1#2#3#4#5#6[#7]#8{%
 \ifnum #2>\c@secnumdepth
  \let\@svsec\@empty
 \else
  \refstepcounter{#1}%
  \protected@edef\@svsec{%
   \@seccntformat{#1}\csname after@#1num\endcsname
   \if@english\hskip1em\else\hskip1zw\fi}%
 \fi
  \@tempskipa #5\relax
  \ifdim \@tempskipa<\z@
   \def\@svsechd{%
     #6{\hskip #3\relax
     \@svsec #8}}%
  \else
   \begingroup
    #6{%
      \let\@makefnmark\sec@makefnmark
      \parindent\z@
      \sec@fmt{#2}{#3}{#8}\@@par
      }%
   \endgroup
  \fi
  \@xsect{#5}%
}

\def\sice@shortstack{\@ifnextchar[% ]
 \@sice@shortstack{\@sice@shortstack[c]}}
\def\@sice@shortstack[#1]{%
  \leavevmode
  \vbox\bgroup
    %%\baselineskip-\p@\lineskip 3\p@
    \let\mb@l\hss\let\mb@r\hss
    \expandafter\let\csname mb@#1\endcsname\relax
    \let\\\@stackcr
    \@ishortstack}

\def\sec@fmt#1#2#3{%% #1=num #2=indent #3=arg
 \@tempcntb\c@footnote
 \if@appendix
  \if@english
   \ifnum #1=\@ne
    \setbox\@tempboxa\hbox{\@svsec\sice@shortstack[l]{#3}}%
    \c@footnote\@tempcntb
    \ifdim \wd\@tempboxa < \columnwidth
     \leftskip\columnwidth
     \advance \leftskip -\wd\@tempboxa
     \divide \leftskip \tw@
     \rightskip\leftskip
     \@hangfrom{\hskip #2\relax\@svsec}%
      \interlinepenalty\@M #3%
    \else
     \@hangfrom{\hskip #2\relax\@svsec}%
      \interlinepenalty\@M #3%
    \fi
   \else
    \@hangfrom{\hskip #2\relax\@svsec}\interlinepenalty\@M #3%
   \fi
  \else
   \@hangfrom{\hskip #2\relax\@svsec}\interlinepenalty\@M #3%
  \fi
 \else
  \ifnum #1=\@ne
   \setbox\@tempboxa\hbox{\sice@shortstack[l]{#3}}%
   \c@footnote\@tempcntb
   \ifdim \wd\@tempboxa < 5zw
    \ifjidori
     \centering
     \@svsec\interlinepenalty\@M\kintou{5zw}{#3\hfil}%
    \else
     \centering
     \@svsec\interlinepenalty\@M #3%
    \fi
   \else
    \setbox\@tempboxb\hbox{\@svsec\sice@shortstack[l]{#3}}%
    \ifdim \wd\@tempboxb < \columnwidth
     \leftskip\columnwidth
     \advance \leftskip -\wd\@tempboxb
     \divide \leftskip \tw@
     \rightskip\leftskip
     \@hangfrom{\hskip #2\relax\@svsec}%
      \interlinepenalty\@M #3%
    \else
     \@hangfrom{\hskip #2\relax\@svsec}%
      \interlinepenalty\@M #3%
    \fi
   \fi
  \else %% subsection
   \@hangfrom{\hskip #2\relax\@svsec}\interlinepenalty\@M #3%
  \fi
 \fi
}

%% \@ssect{INDENT}{BEFORESKIP}{AFTERSKIP}{STYLE}{ARG} ==
%% \ifdim \@tempskipa>\z@ --> \ifdim \@tempskipa<\z@
\def\@ssect#1#2#3#4#5{%
 \@tempskipa #3\relax
 \ifdim \@tempskipa<\z@
  \def\@svsechd{#4{\hskip #1\relax #5}}%
 \else
  \begingroup
    #4{%
      \let\@makefnmark\sec@makefnmark
      \parindent\z@
      \ssec@fmt{#2}{#1}{#5}\@@par
      }%
  \endgroup
 \fi
 \@xsect{#3}%
}

\def\ssec@fmt#1#2#3{%% #1=beforeskip #2=indent #3=arg
 \@tempcntb\c@footnote
 \if@appendix
  \if@english
   \@tempskipa#1\relax
   \ifdim\@tempskipa=.5\Cvs %% section
    \setbox\@tempboxa\hbox{Appendix~\sice@shortstack[l]{#3}}%
    \c@footnote\@tempcntb
    \ifdim \wd\@tempboxa < \columnwidth
     \leftskip\columnwidth
     \advance \leftskip -\wd\@tempboxa
     \divide \leftskip \tw@
     \rightskip\leftskip
     \@hangfrom{Appendix~}%
      \interlinepenalty\@M #3%
    \else
     \@hangfrom{Appendix~}%
      \interlinepenalty\@M #3%
    \fi
   \else
    \@hangfrom{\hskip #2\relax}\interlinepenalty\@M #3%
   \fi
  \else
   \@hangfrom{\hskip #2\relax}\interlinepenalty\@M #3%
  \fi
 \else
  \@tempskipa#1\relax
  \ifdim\@tempskipa=.5\Cvs %% section
   \setbox\@tempboxa\hbox{\sice@shortstack[l]{#3}}%
   \c@footnote\@tempcntb
   \ifdim \wd\@tempboxa < 5zw
    \ifjidori
     \centering
     \kintou{5zw}{#3\hfil}%
    \else
     \centering #3%
    \fi
   \else
    \ifdim \wd\@tempboxa < \columnwidth
     \leftskip\columnwidth
     \advance \leftskip -\wd\@tempboxa
     \divide \leftskip \tw@
     \rightskip\leftskip
     #3%
    \else
     #3%
    \fi
   \fi
  \else %% subsection
   \@hangfrom{\hskip #2\relax}\interlinepenalty\@M #3%
  \fi
 \fi
}

%% \ifdim \@tempskipa>\z@ --> \ifdim \@tempskipa<\z@
\def\@xsect#1{%
  \@tempskipa #1\relax
  \ifdim \@tempskipa<\z@
    \@nobreakfalse
    \global\@noskipsectrue
    \everypar{%
      \if@noskipsec
        \global\@noskipsecfalse
       {\setbox\z@\lastbox}%
        \clubpenalty\@M
        \begingroup \@svsechd \endgroup
        \unskip
        \@tempskipa #1\relax
        \hskip -\@tempskipa
        \pagebreak[2]%
      \else
        \clubpenalty \@clubpenalty
        \everypar{}%
      \fi}%
  \else
    \par \nobreak
    \vskip \@tempskipa
    \@afterheading
  \fi
  \ignorespaces}

\def\@seccntformat#1{\csname the#1\endcsname}
\def\after@sectionnum{.}

\def\sec@font{\large\bfseries\baselineskip\Cvs\mathversion{bold}}

\newcommand{\section}{\@startsection{section}{1}{\z@}%
 {.5\Cvs \@plus.3\Cvs \@minus.05\Cvs}%
 {.5\Cvs \@plus.3\Cvs \@minus.05\Cvs}%
 {\reset@font\sec@font}}
\newcommand{\subsection}{\@startsection{subsection}{2}{1zw}%
 {\z@ \@plus.3\Cvs \@minus.05\Cvs}%
 {\z@ \@plus.3\Cvs \@minus.05\Cvs}%
 {\reset@font\normalsize\bfseries\mathversion{bold}}}
\newcommand{\subsubsection}{\@startsection{subsubsection}{3}{1zw}%
 {\z@ \@plus.3\Cvs \@minus.05\Cvs}%
 {\z@ \@plus.3\Cvs \@minus.05\Cvs}%
 {\reset@font\normalsize\normalfont}}
\newcommand{\paragraph}{\@startsection{paragraph}{4}{\z@}%
 {\z@ \@plus.3\Cvs \@minus.05\Cvs}%
 {\z@ \@plus.3\Cvs \@minus.05\Cvs}%
 {\reset@font\normalsize\bfseries\mathversion{bold}}}
\newcommand{\subparagraph}{\@startsection{subparagraph}{5}{1zw}%
 {\z@ \@plus.3\Cvs \@minus.05\Cvs}%
 {\z@ \@plus.3\Cvs \@minus.05\Cvs}%
 {\reset@font\normalsize\bfseries\mathversion{bold}}}

\newif\if@appendix\@appendixfalse
\newcommand{\appendix}{%
 \@appendixtrue
 \if@english
 \else
  \section*{\normalsize\bfseries\centering 《付\hskip36\@Q 録》}
  \renewcommand{\section}{\@startsection{section}{1}{3.25mm}%
   {\z@ \@plus.3\Cvs \@minus.05\Cvs}%
   {\z@ \@plus.3\Cvs \@minus.05\Cvs}%
   {\reset@font\sec@font}}%
  \renewcommand{\subsection}{\@startsection{subsection}{2}{1zw}%
   {\z@ \@plus.3\Cvs \@minus.05\Cvs}%
   {\z@ \@plus.3\Cvs \@minus.05\Cvs}%
   {\reset@font\normalsize\normalfont}}%
 \fi
 \setcounter{section}{0}%
 \setcounter{subsection}{0}%
 \setcounter{secnumdepth}{2}%
 \setcounter{equation}{0}%
 \setcounter{figure}{0}%
 \setcounter{table}{0}%
 \setcounter{photo}{0}%
 \@addtoreset{equation}{section}%
 \def\theequation{\@Alph\c@section.\protect\,\@arabic\c@equation}%
 \if@english
  \def\thesection{Appendix~\@Alph\c@section}%
 \else
  \def\thesection{\@Alph\c@section}%
 \fi
 \def\thesubsection{\@Alph\c@section.\protect\,\@arabic\c@subsection}%
 \def\fnum@figure{Fig.\protect\,A.\@arabic\c@figure}%
 \def\fnum@table{Table~A.\@arabic\c@table}%
 \def\fnum@photo{Photo.\protect\,A.\@arabic\c@photo}%
}

\if@twocolumn
 \setlength\leftmargini {2zw}% 2em
\else
 \setlength\leftmargini {2zw}% 2.5em
\fi
\setlength\leftmarginii  {2zw}% 2.2em
\setlength\leftmarginiii {2zw}% 1.87em
\setlength\leftmarginiv  {2zw}% 1.7em
\if@twocolumn
 \setlength\leftmarginv {1zw}% .5em
 \setlength\leftmarginvi{1zw}% .5em
\else
 \setlength\leftmarginv {1zw}% 1em
 \setlength\leftmarginvi{1zw}% 1em
\fi
\setlength  \labelsep  {.5zw}% .25zw
\setlength  \labelwidth{\leftmargini}
\addtolength\labelwidth{-\labelsep}

\@beginparpenalty\z@ %% -\@lowpenalty
\@endparpenalty\z@ %%   -\@lowpenalty
\@itempenalty\z@ %%     -\@lowpenalty

%% from latex.ltx
\def\@item[#1]{%
  \if@noparitem
    \@donoparitem
  \else
    \if@inlabel
      \indent \par
    \fi
    \ifhmode
      \unskip\unskip \par
    \fi
    \if@newlist
      \if@nobreak
        \@nbitem
      \else
        \addpenalty\@beginparpenalty
        \addvspace\@topsep
        \addvspace{-\parskip}%
      \fi
    \else
      \addpenalty\@itempenalty
      \addvspace\itemsep
    \fi
    \global\@inlabeltrue
  \fi
  \everypar{%
    \@minipagefalse
    \global\@newlistfalse
    \if@inlabel
      \global\@inlabelfalse
      {\setbox\z@\lastbox
       \ifvoid\z@
         \kern-\itemindent
       \fi}%
      \box\@labels
      \penalty\z@
    \fi
    \if@nobreak
      \@nobreakfalse
      \clubpenalty\z@ %% \@M --> \z@
    \else
      \clubpenalty \@clubpenalty
      \everypar{}%
    \fi}%
  \if@noitemarg
    \@noitemargfalse
    \if@nmbrlist
      \refstepcounter\@listctr
    \fi
  \fi
  \sbox\@tempboxa{\makelabel{#1}}%
  \global\setbox\@labels\hbox{%
    \unhbox\@labels
    \hskip \itemindent
    \hskip -\labelwidth
    \hskip -\labelsep
    \ifdim \wd\@tempboxa >\labelwidth
      \box\@tempboxa
    \else
      \hbox to\labelwidth {\unhbox\@tempboxa}%
    \fi
    \hskip \labelsep}%
  \ignorespaces\inhibitglue
}

\renewcommand{\theenumi}{\@arabic\c@enumi}
\renewcommand{\theenumii}{\@alph\c@enumii}
\renewcommand{\theenumiii}{\@Roman\c@enumiii}
\renewcommand{\theenumiv}{\@Alph\c@enumiv}
\newcommand{\labelenumi}{%
 \if@english \hss (\else\inhibitglue （\hfil\fi
  \theenumi\if@english )\else\hfil{}）\inhibitglue\fi}
\newcommand{\labelenumii}{%
 \if@english \hss (\else\inhibitglue （\hfil\fi
  \theenumii\if@english )\else\hfil{}）\inhibitglue\fi}
\newcommand{\labelenumiii}{\theenumiii.}
\newcommand{\labelenumiv}{\theenumiv.}
\renewcommand{\p@enumii}{\theenumi}
\renewcommand{\p@enumiii}{\theenumi(\theenumii)}
\renewcommand{\p@enumiv}{\p@enumiii\theenumiii}

\renewenvironment{enumerate}
  {\ifnum \@enumdepth >\thr@@\@toodeep\else
   \advance\@enumdepth\@ne
   \edef\@enumctr{enum\romannumeral\the\@enumdepth}%
   \list{\csname label\@enumctr\endcsname}{%
         \topsep\z@\parsep\z@\partopsep\z@\itemsep\z@
         \leftmargin1zw
         \labelwidth2zw
         \labelsep1zw
         \itemindent3zw
         \listparindent1zw
         \usecounter{\@enumctr}%
         \ifnum \@enumdepth=\thr@@
          \def\makelabel##1{\hss\llap{##1}}
	 \else
          \def\makelabel##1{\hbox to 2zw{##1}}
         \fi
        }%
  \fi}{\endlist}

\newcommand{\labelitemi}{\leavevmode
 \if@english\else\raise.075zh\fi\hbox to 1zw{\hss\textbullet\hss}}
\newcommand{\labelitemii}{\leavevmode
 \if@english\else\raise.075zh\fi\hbox to 1zw{\hss $\circ$\hss}}
\newcommand{\labelitemiii}{\leavevmode
 \if@english\else\raise.075zh\fi\hbox to 1zw{\hss \textasteriskcentered\hss}}
\newcommand{\labelitemiv}{\leavevmode
 \if@english\else\raise.075zh\fi\hbox to 1zw{\hss \textperiodcentered\hss}}

\renewenvironment{itemize}
  {\ifnum \@itemdepth >\thr@@\@toodeep\else
   \advance\@itemdepth\@ne
   \edef\@itemitem{labelitem\romannumeral\the\@itemdepth}%
   \expandafter
   \list{\csname \@itemitem\endcsname}{%
         \topsep\z@\parsep\z@\partopsep\z@\itemsep\z@
         \leftmargin1zw
         \labelwidth1zw
         \labelsep\z@
         \itemindent1zw
         \listparindent1zw
         \def\makelabel##1{\hss\llap{##1}}%
        }%
  \fi}{\endlist}

\def\descriptionlabel#1{%
 \setbox0\hbox{\bfseries #1}%
 \dimen0=\wd0 \dimen1=1zw
 \divide \dimen0 \dimen1\relax
 \multiply \dimen0 \dimen1\relax
 \ifdim \dimen0<\wd0 \advance \dimen0 \dimen1\fi
 \hbox to \dimen0{\box0 \hfil}\hfil}

\def\description{%
 \list{}{\topsep\z@\parsep\z@\partopsep\z@\itemsep\z@
         \leftmargin1zw
         \labelwidth\leftmargin
         \labelsep1zw
         \listparindent1zw
         \advance \labelwidth -\labelsep
         \let\makelabel\descriptionlabel
         }%
}
\let\enddescription\endlist

\newenvironment{verse}
  {\let\\\@centercr
   \list{}{\itemsep\z@
           \topsep.5\baselineskip\parsep\z@\partopsep\z@
           \itemindent -1zw
           \listparindent\itemindent
           \rightmargin\leftmargin
           \advance\leftmargin 1zw}%
           \item\relax}{\endlist}
\newenvironment{quotation}
  {\list{}{%
           \topsep.5\baselineskip\parsep\z@\partopsep\z@\itemsep\z@
           \listparindent1zw
           \itemindent\listparindent
           \rightmargin\leftmargin
           }%
           \item\relax}{\endlist}
\newenvironment{quote}
  {\list{}{%
           \topsep.5\baselineskip\parsep\z@\partopsep\z@\itemsep\z@
           \rightmargin\leftmargin}%
           \item\relax}{\endlist}

\gdef\tabbing{\lineskip \z@skip\let\>\@rtab\let\<\@ltab\let\=\@settab
     \let\+\@tabplus\let\-\@tabminus\let\`\@tabrj\let\'\@tablab
     \let\\=\@tabcr
     \@hightab\@firsttab
     \global\@nxttabmar\@firsttab
     \dimen\@firsttab\@totalleftmargin
     \global\@tabpush\z@ \global\@rjfieldfalse
     \topsep.5\Cvs\parsep\z@\partopsep\z@
     \trivlist \item\relax
     \if@minipage\else\vskip\parskip\fi
     \setbox\@tabfbox\hbox{%
       \rlap{\hskip\@totalleftmargin\indent\the\everypar}}%
     \def\@itemfudge{\box\@tabfbox}%
     \@startline\ignorespaces}

\newdimen\verbatimskip
  \verbatimskip.5\baselineskip
\newdimen\verbatimleftmargin
  \verbatimleftmargin\z@
\newdimen\verbatimbaselineskip
  \verbatimbaselineskip\baselineskip
\def\verbatimsize{\normalsize}

\def\@verbatim{%
 \interlinepenalty\z@
 \topsep\verbatimskip
 \partopsep\z@\parsep\z@\itemsep\z@
 \trivlist \item\relax
  \if@minipage\else
   \vskip\baselineskip
   \vskip-\verbatimbaselineskip
   %\vskip\parskip
  \fi
  \leftskip\@totalleftmargin
  \if@minipage\else
   \advance \leftskip by \verbatimleftmargin
  \fi
  \rightskip\z@skip
  \parindent\z@\parfillskip\@flushglue\parskip\z@skip
  \@@par
  \@tempswafalse
  \def\par{%
    \if@tempswa
      \leavevmode \null \@@par\penalty\interlinepenalty
    \else
      \@tempswatrue
      \ifhmode\@@par\penalty\interlinepenalty\fi
    \fi}%
  \let\do\@makeother \dospecials
  \obeylines 
   \verbatimsize \baselineskip\verbatimbaselineskip
   \verbatim@font \@noligs
  \everypar \expandafter{\the\everypar \unpenalty}%
}

%% \def\verbatim@font{\normalfont\ttfamily}

\newcounter{figure}
\renewcommand{\thefigure}{\@arabic\c@figure}
\def\fps@figure{tbp}
\def\ftype@figure{1}
\def\ext@figure{lof}
\def\fnum@figure{\figurename\protect\,\thefigure}
\newenvironment{figure}
               {\floatenv\capwidth\columnwidth
                \abovecaptionskip1.5mm\belowcaptionskip\z@\@float{figure}}
               {\end@float}
\newenvironment{figure*}
               {\floatenv\capwidth.67\textwidth
                \abovecaptionskip1.5mm\belowcaptionskip\z@\@dblfloat{figure}}
               {\end@dblfloat}

\newcounter{table}
\renewcommand{\thetable}{\@arabic\c@table}
\def\fps@table{tbp}
\def\ftype@table{2}
\def\ext@table{lot}
\def\fnum@table{\tablename~\thetable}
\newenvironment{table}
               {\floatenv\capwidth\columnwidth
                \abovecaptionskip\z@\belowcaptionskip1.5mm\@float{table}}
               {\end@float}
\newenvironment{table*}
               {\floatenv\capwidth.67\textwidth
                \abovecaptionskip\z@\belowcaptionskip1.5mm\@dblfloat{table}}
               {\end@dblfloat}

\newcounter{photo}
\renewcommand{\thephoto}{\@arabic\c@photo}
\def\fps@photo{tbp}
\def\ftype@photo{4}
\def\ext@photo{lof}
\def\fnum@photo{\photoname\protect\,\thephoto}
\newenvironment{photo}
               {\floatenv\capwidth\columnwidth
                \abovecaptionskip1.5mm\belowcaptionskip\z@\@float{photo}}
               {\end@float}
\newenvironment{photo*}
               {\floatenv\capwidth.67\textwidth
                \abovecaptionskip1.5mm\belowcaptionskip\z@\@dblfloat{photo}}
               {\end@dblfloat}

\newlength\abovecaptionskip
\newlength\belowcaptionskip

\def\@floatboxreset{%
 \reset@font
 \small\tabcolsep.5zw
 \@setminipage
}

\def\floatenv{%
 \let\center\Center
 \def\verbatimsize{\small}%
}
\def\Center{\topsep\z@\parsep\z@\partopsep\z@\itemsep\z@
 \trivlist \centering\item\relax}
\def\endCenter{\endtrivlist}

\long\def\@caption#1[#2]#3{\par
 %%\addcontentsline{\csname ext@#1\endcsname}{#1}%
 %% {\protect\numberline{\csname the#1\endcsname}{\ignorespaces #2}}%
 \begingroup
  \@parboxrestore
  \if@minipage
   \@setminipage
  \fi
  \small
  \@makecaption{\csname fnum@#1\endcsname}{\ignorespaces #3}\par
 \endgroup}

\newdimen\capwidth

\long\def\@makecaption#1#2{%
 \vskip\abovecaptionskip
 \setbox\@tempboxa\hbox{{\bfseries #1}\hskip1zw\sice@shortstack[l]{#2}}%
 \@tempdima \ht\@tempboxa
 \advance \@tempdima \dp\@tempboxa
 \setbox\@tempboxb\hbox{\bfseries #1\hskip1zw}%
 \ifdim \@tempdima > \baselineskip
  \ifdim \wd\@tempboxa > \capwidth
   \hfil\parbox[t]{\capwidth}{\hangindent\wd\@tempboxb 
    {\bfseries #1}\hskip1zw #2}\par
    \hrule \@height \z@
  \else
   \hfil\parbox[t]{\wd\@tempboxa}{\hangindent\wd\@tempboxb 
    {\bfseries #1}\hskip1zw #2}\par
    \hrule \@height \z@
  \fi
 \else
  \ifdim \wd\@tempboxa > \capwidth
   \hfil\parbox[t]{\capwidth}{\hangindent\wd\@tempboxb 
    {\bfseries #1}\hskip1zw #2}\par
    \hrule \@height \z@
  \else
   \hbox to\hsize{\hss\box\@tempboxa\hss}%
  \fi
 \fi
 \vspace{\belowcaptionskip}%
}

\setlength\arraycolsep{5\p@}
\setlength\tabcolsep{.5zw}
\setlength\arrayrulewidth{.1mm}
\setlength\doublerulesep{1\p@}
\setlength\tabbingsep{\labelsep}
\skip\@mpfootins = \skip\footins
\setlength\fboxsep{.25zw}
\setlength\fboxrule{.1mm}

\renewcommand{\theequation}{\@arabic\c@equation}

\if@enablejfam
  \if@compatibility\else
    \DeclareSymbolFont{mincho}{JY1}{mc}{m}{n}
    \DeclareSymbolFontAlphabet{\mathmc}{mincho}
    \SetSymbolFont{mincho}{bold}{JY1}{gt}{m}{n}
    \jfam\symmincho
    \DeclareMathAlphabet{\mathgt}{JY1}{gt}{m}{n}
  \fi
  \if@mathrmmc
    \AtBeginDocument{%
     \reDeclareMathAlphabet{\mathrm}{\mathrm}{\mathmc}
     \reDeclareMathAlphabet{\mathbf}{\mathbf}{\mathgt}
    }%
  \fi
\else
  \DeclareRobustCommand{\mathmc}{%
    \@latex@error{Command \noexpand\mathmc invalid with\space
       `disablejfam' class option.}\@eha
  }
  \DeclareRobustCommand{\mathgt}{%
    \@latex@error{Command \noexpand\mathgt invalid with\space
       `disablejfam' class option.}\@eha
  }
\fi

\DeclareOldFontCommand{\mc}{\normalfont\mcfamily}{\mathmc}
\DeclareOldFontCommand{\gt}{\normalfont\gtfamily}{\mathgt}
\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}
\DeclareRobustCommand*{\cal}{\@fontswitch\relax\mathcal}
\DeclareRobustCommand*{\mit}{\@fontswitch\relax\mathnormal}

\def\acknowledgment{\par
 \if@english
  \section*{Acknowledgment}
 \else
  \textbf{謝辞}\hskip1zw
 \fi
}
\def\endacknowledgment{\par}

\newdimen\bibindent
\setlength\bibindent{1.5zw}
\newcommand{\newblock}{\hskip .11em\@plus.33em\@minus.07em}

\newenvironment{thebibliography}[1]
 {\small
  \if@english
   \section*{\small\bfseries\centering \refname}
  \else
   \section*{\small\bfseries\centering \kintou{7zw}{\refname}}
  \fi %% 
  \list{\@biblabel{\@arabic\c@enumiv}}%
       {\settowidth\labelwidth{\@biblabel{#1}}%
        \topsep\z@\parsep\z@\partopsep\z@\itemsep\z@
        \leftmargin2zw
        \labelsep.5zw
        \@openbib@code
        \usecounter{enumiv}%
        \let\p@enumiv\@empty
        \renewcommand\theenumiv{\@arabic\c@enumiv}%
       }%
   \sloppy
   \@clubpenalty\clubpenalty
   \sfcode`\.\@m
 }%
 {\def\@noitemerr{\@latex@warning{Empty `thebibliography' environment}}%
  \endlist}

\def\@biblabel#1{%
 \hbox to 1.5zw{\hss #1% (（
  \if@english )\else ）\fi}}

\let\@openbib@code\@empty

\newenvironment{biography}{%
 \small\normalfont
 \parindent\z@
 \vskip\baselineskip
 \penalty\@medpenalty
 \hbox to \hsize{\leaders
  \hbox{\vrule \@width.1mm \@height 1mm\hskip.4mm}\hfil}%
 \penalty\@M
 \if@english
  \let\@profile\@eprofile
  \let\n@profile\n@eprofile
  \vskip2mm
 \else
  \vskip3.25mm
  \hfil {\large\normalfont ［\kintou{7zw}{著者紹介}］}\par
  \penalty\@M
  \vskip3.25mm
 \fi
 }{\vskip-1mm
   \hbox to \hsize{\leaders
    \hbox{\vrule \@width.1mm \@height 1mm\hskip.4mm}\hfil}\par
  }

\def\profile{\@ifstar{\n@profile}{\@profile}}

%% \t{oo} causes error
\def\sice@sc#1{#1\tiny}

\newcounter{profile}

\def\fmt@pro@Jname#1#2{%
 \bgroup
  \normalsize\bfseries
  \setbox\@tempboxc\hbox{\spaceskip=100mm #2}%
  \ifdim \wd\@tempboxc < 100mm
   \sice@warning{\string\profile\space "#2" does not have a space}%
   #2%
  \else
   \@temptokena{#2}%
   \chk@name{\the\@temptokena}% check of exceptions
   \setbox\@tempboxd\hbox{\get@oneword}%
   \ifdim \wd\@tempboxd=1zw
    \setbox\@tempboxc\hbox{#2}%
    \ifdim \wd\@tempboxc > 7zw
     \def\tr@name##1 ##2\@nil{##1\hskip 1zw ##2}%
    \else
     \def\@checkbox##1 ##2\@nil{%
      \setbox\@tempboxa\hbox{##1}\setbox\@tempboxb\hbox{##2}}%
     \protected@edef\@tempcheck{\expandafter\@checkbox #2\@nil}%
     \@tempcheck
     \def\tr@name##1 ##2\@nil{\leavevmode\hbox{%
      \ifdim \wd\@tempboxa < 3zw
       \hbox to 3zw{\kanjiskip=1zw \@plus 1zw ##1\hss}%
      \else
       \hbox to 3zw{##1\hss}%
      \fi
      \hskip1zw
      \ifdim \wd\@tempboxb < 3zw
       \hbox to 3zw{\hss\kanjiskip=1zw \@plus 1zw ##2}%
      \else
       \hbox to 3zw{\hss ##2}%
      \fi
     }}%
    \fi
   \else
    \def\tr@name##1 ##2\@nil{##1 \protect\uppercase{\protect\sice@sc ##2}}%
   \fi
   \protected@edef\@authorname{\expandafter\tr@name #2\@nil\null}%
   \@authorname
  \fi
 \egroup
 \if #1m\relax
  {\normalsize\normalfont （正会員）}%
 \else
  \if #1s\relax
   {\normalsize\normalfont （学生会員）}%
  \else
   \if #1n\relax
    \relax
   \else
    \if #1h\relax
     {\normalsize\normalfont （名誉会員）}%
    \else
     \if #1f\relax
      {\normalsize\normalfont （正会員・フェロー）}%
     \else
      \if #1F\relax
       {\normalsize\normalfont （フェロー）}%
      \else
       \relax
      \fi
     \fi
    \fi
   \fi
  \fi
 \fi
 \vskip1mm
}

\def\fmt@pro@pic#1{%
 \begin{minipage}[t]{16mm}%
  \leavevmode\lower17.5mm
  \vbox to 20mm{%
   \IfFileExists{a\the\c@profile.eps}{%
    \resizebox{16mm}{20mm}{\includegraphics{a\the\c@profile.eps}}%
   }{%
     \hrule \@height .1mm
     \hbox to 16mm{\vrule \@width .1mm \@height 19.8mm\hss
                   \vrule \@width .1mm \@height 19.8mm}%
     \hrule \@height .1mm
    }%
  }%
 \end{minipage}%
 \hfill
 \begin{minipage}[t]{60.5mm}% 22zw
  \hskip2.75mm
  #1\par
 \end{minipage}%
}

\long\def\@profile#1#2#3{%
 \stepcounter{profile}%
 \vbox{%
  \fmt@pro@Jname{#1}{#2}%
  \fmt@pro@pic{#3}%
 }%
 \vskip6.5mm
}

\long\def\n@profile#1#2#3{%
 \stepcounter{profile}%
 \vbox{%
  \fmt@pro@Jname{#1}{#2}%
  \begin{minipage}[t]{\columnwidth}
   \hskip2.75mm
   #3\par
  \end{minipage}%
 }%
 \vskip6.5mm
}

\def\fmt@pro@Ename#1#2{%
 \bgroup
  \normalsize\bfseries 
  \def\tr@name##1 ##2\@nil{##1 \protect\uppercase{\protect\sice@sc ##2}}%
  \protected@edef\@authorname{\expandafter\tr@name #2\@nil\null}%
  \@authorname\ 
 \egroup
 \if #1m\relax
  {\normalsize (Member)}%
 \else
  \if #1s\relax
   {\normalsize (Student Member)}%
  \else
   \if #1n\relax
    \relax
   \else
    \if #1h\relax
     {\normalsize (Honorary Member)}%
    \else
     \if #1f\relax
      {\normalsize (Member, Fellow)}%
     \else
      \if #1F\relax
       {\normalsize (Fellow)}%
      \else
       \relax
      \fi
     \fi
    \fi
   \fi
  \fi
 \fi
 \vskip1mm
}

\long\def\@eprofile#1#2#3{%
 \stepcounter{profile}%
 \vbox{%
  \fmt@pro@Ename{#1}{#2}%
  \fmt@pro@pic{#3}%
 }%
 \vskip6.5mm
}

\long\def\n@eprofile#1#2#3{%
 \stepcounter{profile}%
 \vbox{%
  \fmt@pro@Ename{#1}{#2}%
  \begin{minipage}[t]{\columnwidth}
   \hskip2.75mm
   #3\par
  \end{minipage}%
 }%
 \vskip6.5mm
}

\renewcommand{\footnoterule}{%
  \kern-3\p@
  \hrule \@width \columnwidth
  \kern 2.6\p@}

\newcommand\@makefntext[1]{\small
 \everypar={\hangafter=1\relax\hangindent=1zw}%
 \parindent2zw
 \if@english
  \noindent
  \hskip1zw
  \hbox to 2zw{(\@thefnmark)\hss}%
 \else
  \noindent
  \hskip1zw
  \hbox to 3.5zw{（注\@thefnmark{}）\hss}%
 \fi
 #1}

\def\@makefnmark{%
 \if@english
  \hbox{$^{\mbox{\tiny (\@thefnmark )}}$}%
 \else
  \hbox{$^{\mbox{\fontsize{9\@JQ}{\z@}\selectfont （注\@thefnmark{}）}}$}%
 \fi
}

\def\sec@makefnmark{%
 \if@english
  \hbox to \z@{\normalfont $^{\mbox{\tiny (\@thefnmark)}}$\hss}%
 \else
  \hbox to \z@{\normalfont $^{\mbox{\fontsize{9\@JQ}{\z@}\selectfont
   （注\@thefnmark{}）}}$\hss}%
 \fi
}

%% from fleqn.clo
%%   /usr/local/teTeX/share/texmf/tex/latex/base/fleqn.clo
%\ProvidesFile{fleqn.clo}
%        [1998/08/17 v1.1c Standard LaTeX option
%                                   (flush left equations)]
\newdimen\mathindent
\AtEndOfClass{\mathindent2zw}
\renewcommand\[{\relax
                \ifmmode\@badmath
                \else
                  \@InListEnv
                  \begin{trivlist}%
                    \@beginparpenalty\predisplaypenalty
                    \@endparpenalty\postdisplaypenalty
                    \item[]\leavevmode
                    \hb@xt@\linewidth\bgroup $\m@th\displaystyle %$
                      \hskip\mathindent\bgroup
                \fi}
\renewcommand\]{\relax
                \ifmmode
                      \egroup $\hfil% $
                    \egroup
                  \end{trivlist}%
                \else \@badmath
                \fi}
\renewenvironment{equation}%
    {\@beginparpenalty\predisplaypenalty
     \@endparpenalty\postdisplaypenalty
     \refstepcounter{equation}%
     \@InListEnv
     \trivlist \item[]\leavevmode
       \hb@xt@\linewidth\bgroup $\m@th% $
         \displaystyle
         \hskip\mathindent}%
        {$\hfil % $
         \displaywidth\linewidth\hbox{\@eqnnum}%
       \egroup
     \endtrivlist}
\renewenvironment{eqnarray}{%
    \stepcounter{equation}%
    \def\@currentlabel{\p@equation\theequation}%
    \global\@eqnswtrue\m@th
    \global\@eqcnt\z@
    \tabskip\mathindent
    \let\\=\@eqncr
    \@InListEnv
    \setlength\abovedisplayskip{\topsep}%
    \ifvmode
      \addtolength\abovedisplayskip{\partopsep}%
    \fi
    \addtolength\abovedisplayskip{\parskip}%
    \setlength\belowdisplayskip{\abovedisplayskip}%
    \setlength\belowdisplayshortskip{\abovedisplayskip}%
    \setlength\abovedisplayshortskip{\abovedisplayskip}%
    $$\everycr{}\halign to\linewidth% $$
    \bgroup
      \hskip\@centering
      $\displaystyle\tabskip\z@skip{##}$\@eqnsel&%
      \global\@eqcnt\@ne \hskip.8\arraycolsep \hfil${##}$\hfil&%
      \global\@eqcnt\tw@ \hskip.8\arraycolsep
        $\displaystyle{##}$\hfil \tabskip\@centering&%
      \global\@eqcnt\thr@@
        \hb@xt@\z@\bgroup\hss##\egroup\tabskip\z@skip\cr}%
      {\@@eqncr
    \egroup
    \global\advance\c@equation\m@ne$$% $$
    \@ignoretrue
    }
%%\endinput
%%
%% End of file `fleqn.clo'.

\def\@InListEnv{%
 \ifdim\topsep=\z@
  \@listi
 \fi
}

\def\@eqnnum{{\normalfont\normalcolor
 \if@english
  (\theequation)\else
   \inhibitglue （{\theequation}）\inhibitglue\fi
  \hskip1zw\mbox{}}}

\def\@ethmbracket{%
 \gdef\@LTheorem{\hskip4.125mm\bgroup\bfseries\relax}%
 \gdef\@RTheorem{\egroup}%
 \gdef\@LDefinition{\hskip4.125mm\bgroup\bfseries\relax}%
 \gdef\@RDefinition{\egroup}%
 \gdef\@LLemma{\hskip4.125mm\bgroup\bfseries\relax}%
 \gdef\@RLemma{\egroup}%
 \gdef\@LAssumption{\hskip4.125mm\bgroup\bfseries\relax}%
 \gdef\@RAssumption{\egroup}%
 \gdef\@LProof{\hskip4.125mm\bgroup\bfseries\relax}%
 \gdef\@RProof{\egroup}%
 \gdef\@LProposition{\hskip4.125mm\bgroup\bfseries\relax}%
 \gdef\@RProposition{\egroup}%
 \gdef\@LExample{\hskip4.125mm\bgroup\bfseries\relax}%
 \gdef\@RExample{\egroup}%
 \gdef\@LSample{\hskip4.125mm\bgroup\bfseries\relax}%
 \gdef\@RSample{\egroup}%
 \gdef\@LNote{\hskip4.125mm\bgroup\bfseries\relax}%
 \gdef\@RNote{\egroup}%
 \thmbracket{\hskip4.125mm\bgroup\bfseries\relax}{\egroup}%
}

\def\@thmbracket{%
 \gdef\@L定理{《\bgroup\bfseries\relax}\gdef\@R定理{\egroup{}》}%
 \gdef\@L定義{【\bgroup\bfseries\relax}\gdef\@R定義{\egroup{}】}%
 \gdef\@L補題{［\bgroup\bfseries\relax}\gdef\@R補題{\egroup{}］}%
 \gdef\@L仮定{［\bgroup\bfseries\relax}\gdef\@R仮定{\egroup{}］}%
 \gdef\@L証明{（}\gdef\@R証明{）}%
 \gdef\@L命題{［}\gdef\@R命題{］}%
 \gdef\@L例題{〔}\gdef\@R例題{〕}%
 \gdef\@L例{〔}\gdef\@R例{〕}%
 \gdef\@L注意{（}\gdef\@R注意{）}%
}

\def\@begintheorem#1#2{%
 \if@english\@ethmbracket\else\@thmbracket\fi
 \let\thedefinition\relax
 \let\theproof\relax
 \let\theproposition\relax
 \let\theexample\relax
 \let\thesample\relax
 \let\thenote\relax
 \topsep\z@\parsep\z@\itemsep\z@\partopsep\z@
 \labelsep1zw
 \let\makelabel\@theoremlabel
 \trivlist
 \item[\hskip\labelsep \inhibitglue
  \@ifundefined{@L#1}{\@thmlbracket}{\csname @L#1\endcsname}%
   \if@english #1\if #2\relax .\else\ #2.\fi\else #1#2\fi
  \@ifundefined{@R#1}{\@thmrbracket}{\csname @R#1\endcsname}%
  \inhibitglue
  ]}

\def\@opargbegintheorem#1#2#3{%
 \if@english\@ethmbracket\else\@thmbracket\fi
 \let\thedefinition\relax
 \let\theproof\relax
 \let\theproposition\relax
 \let\theexample\relax
 \let\thesample\relax
 \let\thenote\relax
 \topsep\z@\parsep\z@\itemsep\z@\partopsep\z@
 \labelsep1zw
 \let\makelabel\@theoremlabel
 \trivlist
  \item[\hskip\labelsep \inhibitglue
   \@ifundefined{@L#1}{\@thmlbracket}{\csname @L#1\endcsname}%
   \if@english #1\ #2\else #1#2\fi\relax
   \@ifundefined{@R#1}{\@thmrbracket}{\csname @R#1\endcsname}%
   \if@english \ (\else \inhibitglue （\fi
    #3%
   \if@english ).\else ）\inhibitglue\fi]}
\let\@endtheorem\endlist
\def\@thmcountersep{.}

\def\thmbracket#1#2{\gdef\@thmlbracket{#1}\gdef\@thmrbracket{#2}}
\thmbracket{［}{］}

\def\@theoremlabel#1{%
 \setbox0=\hbox{#1}%
 \dimen0=\wd0 \dimen1=1zw
 \divide \dimen0 \dimen1
 \multiply \dimen0 \dimen1
 \ifdim \dimen0<\wd0
  \advance \dimen0 \dimen1
 \fi
 \hbox to \dimen0{\box0 \hfil}\hfil
}

\newif\if西暦 \西暦false
\def\西暦{\西暦true}
\def\和暦{\西暦false}
\newcount\heisei \heisei\year \advance\heisei-1988\relax
\def\today{{%
  \iftdir
    \if西暦
      \kansuji\number\year 年
      \kansuji\number\month 月
      \kansuji\number\day 日
    \else
      平成\ifnum\heisei=1 元年\else\kansuji\number\heisei 年\fi
      \kansuji\number\month 月
      \kansuji\number\day 日
    \fi
  \else
    \if西暦
      \number\year~年
      \number\month~月
      \number\day~日
    \else
      平成\ifnum\heisei=1 元年\else\number\heisei~年\fi
      \number\month~月
      \number\day~日
    \fi
  \fi}}

%%\newcommand{\prepartname}{第}
%%\newcommand{\postpartname}{部}
%%\newcommand{\contentsname}{目 次}
%%\newcommand{\listfigurename}{図 目 次}
%%\newcommand{\listtablename}{表 目 次}
\newcommand{\refname}{\if@english References\else 参考文献\fi}
%%\newcommand{\indexname}{索 引}
\newcommand{\figurename}{Fig.}
\newcommand{\tablename}{Table}
\newcommand{\photoname}{Photo.}
%%\newcommand{\appendixname}{付 録}
%%\newcommand{\abstractname}{概 要}

%%## citesort.sty ##%%
\newcount\@minsofar
\newcount\@min
\newcount\@cite@temp
\def\@citex[#1]#2{%
\if@filesw \immediate \write \@auxout {\string \citation {#2}}\fi
\@tempcntb\m@ne \let\@h@ld\relax \def\@citea{}%
\@min\m@ne%
\@cite{%
  \@for \@citeb:=#2\do {\@ifundefined {b@\@citeb}%
    {\@h@ld\@citea\@tempcntb\m@ne{\bfseries ?}%
    \@warning {Citation `\@citeb ' on page \thepage \space undefined}}%
{\@minsofar\z@ \@for \@scan@cites:=#2\do {%
  \@ifundefined{b@\@scan@cites}%
    {\@cite@temp\m@ne}
    {\@cite@temp\number\csname b@\@scan@cites \endcsname \relax}%
 \ifnum\@cite@temp > \@min% select the next one to list
    \ifnum\@minsofar = \z@
      \@minsofar\number\@cite@temp
      \edef\@scan@copy{\@scan@cites}\else
    \ifnum\@cite@temp < \@minsofar
      \@minsofar\number\@cite@temp
      \edef\@scan@copy{\@scan@cites}\fi\fi\fi}\@tempcnta\@min
  \ifnum\@minsofar > \z@ % some more
    \advance\@tempcnta\@ne
    \@min\@minsofar
    \ifnum\@tempcnta=\@minsofar %   Number follows previous--hold on to it
      \ifx\@h@ld\relax
        \edef \@h@ld{\@citea\csname b@\@scan@copy\endcsname}%
      \else
       \edef\@h@ld{%
        \ifmmode %(
         )\if@english \sim\else 〜\fi
        \else % (
         )\if@english $\sim$\else 〜\fi
        \fi\csname b@\@scan@copy\endcsname}%
      \fi
    \else \@h@ld\@citea\csname b@\@scan@copy\endcsname
          \let\@h@ld\relax
  \fi % no more
 \fi}%
 \def\@citea{%(
  ),\penalty\@highpenalty\,}}\@h@ld}{#1}}

%% from "cite.sty", with a little modified
\def\@cite#1#2{\leavevmode\unskip
  \ifnum\lastpenalty=\z@\penalty\@M\fi
  \,\smash{%
   $^{\mbox{\tiny {\multiply\@highpenalty 3 #1%
      \if@tempswa,\penalty\@highpenalty\ #2\fi %(
    })}}$}\spacefactor\@m}
%% end of cite.sty

\let\org@cite\@cite
\def\cite{\@ifnextchar[% ]
 {\@tempswatrue\let\@cite\org@cite\@citex}
 {\@tempswafalse\let\@cite\org@cite\@citex[]}}
\def\Cite{\@ifnextchar[% ]
 {\@tempswatrue\let\@cite\@Cite\@citex}
 {\@tempswafalse\let\@cite\@Cite\@citex[]}}

\def\@Cite#1#2{\leavevmode %% \unskip
  \ifnum\lastpenalty=\z@\penalty\@highpenalty\fi% highpenalty before
  {\multiply\@highpenalty 3 #1%             % triple-highpenalties within
      \if@tempswa,\penalty\@highpenalty\ #2\fi % and before note.%(
    })\spacefactor\@m}

\newcount\@Float@temp

\def\Fig{\@Ref{Fig}}
\def\Figure{\@Refnp{Figure}}
\def\Table{\@Refnp{Table}}
\def\Photo{\@Ref{Photo}}

\def\@Ref#1{\gdef\R@f{#1}\gdef\@Reftype{#1.\,}%
 \@Reffloat}% \gdef\@Reftypes{#1s.\,}
\def\@Refnp#1{\def\@Temp{#1}\def\@@Temp{Figure}%
 \ifx\@Temp\@@Temp\gdef\R@f{Fig}\else\gdef\R@f{#1}\fi
 \gdef\@Reftype{#1\ }\@Reffloat}% \gdef\@Reftypes{#1s\ }
\def\@Reftype{}
%\def\@Reftypes{}

\def\Figapp{\@Refapp{Fig}}
\def\Figureapp{\@Refnpapp{Figure}}
\def\Tableapp{\@Refnpapp{Table}}
\def\Photoapp{\@Refapp{Photo}}

\def\@Refapp#1{\gdef\R@f{#1app}\gdef\@Reftype{#1.\,A.\,}%
 \@Reffloat}% \gdef\@Reftypes{#1s.\,A.\,}
\def\@Refnpapp#1{\def\@Temp{#1}\def\@@Temp{Figure}%
 \ifx\@Temp\@@Temp\gdef\R@f{Figapp}\else\gdef\R@f{#1app}\fi
 \gdef\@Reftype{#1\ A.\,}\@Reffloat}% \gdef\@Reftypes{#1s\ A.\,}

\def\@Reffloat#1{%
 \leavevmode
 \@tempcnta\z@
 \@for\count@Float:=#1\do{%
  \advance \@tempcnta \@ne
   \@ifundefined{bf@\count@Float}%
    {\expandafter\def\csname bf@\count@Float\endcsname{}%
     \def\@BorR{\bfseries }}%
    {\def\@BorR{\relax}}%
 }%
 %\ifnum \@tempcnta > \@ne
 % {\@BorR \@Reftypes}%
 %\else
 {\@BorR \@Reftype}%
 %\fi
 %%
 \@tempcntb\m@ne \let\@h@ld\relax \def\@Floata{}%
 \@min\m@ne
 \@for\@Float:=#1\do{\@ifundefined{r@\@Float}{\@tempcntb\m@ne{\bfseries ?}}%
  {\@minsofar\z@ \@for\@scan@Floats:=#1\do{%
   \@ifundefined{r@\@scan@Floats}{\@Float@temp\m@ne}%
    {\edef\@tempa{\@nameuse{r@\@scan@Floats}}%
      \edef\num@Float{\expandafter\@car\@tempa \@nil}% \null
      \@Float@temp\num@Float \relax}%
    \ifnum\@Float@temp > \@min
     \ifnum\@minsofar = \z@
       \@minsofar\number\@Float@temp
       \edef\@scan@copy{\@scan@Floats}% 
     \else
      \ifnum\@Float@temp < \@minsofar
       \@minsofar\number\@Float@temp
       \edef\@scan@copy{\@scan@Floats}%
      \fi
     \fi
    \fi}%
   \@tempcnta\@min
   \ifnum\@minsofar > \z@
    \advance\@tempcnta\@ne
    \@min\@minsofar
     \ifnum\@tempcnta=\@minsofar
      \ifx\@h@ld\relax
       \edef\@tempa{\@nameuse{r@\@scan@copy}}%
	\edef\num@Float{\expandafter\@car\@tempa \@nil}% \null
	 \@ifundefined{Float@\R@f\num@Float}%
	  {\expandafter\gdef\csname Float@\R@f\num@Float\endcsname{}%
	 \let\oldnum@Float=\num@Float
	 \def\num@Float{{\noexpand\bfseries \oldnum@Float}}}{\relax}%
	 \edef\@h@ld{\@Floata\num@Float}%
      \else
       \edef\@tempa{\@nameuse{r@\@scan@copy}}%
	\edef\num@Float{\expandafter\@car\@tempa \@nil}% \null
	 \@ifundefined{Float@\R@f\num@Float}% 
	  {\expandafter\gdef\csname Float@\R@f\num@Float\endcsname{}%
	 \let\oldnum@Float=\num@Float
	 \def\num@Float{{\noexpand\bfseries \oldnum@Float}}}{\relax}%
	 \edef\@h@ld{\if@english --\else{}〜\fi\num@Float}% 
      \fi
     \else
      \edef\@tempa{\@nameuse{r@\@scan@copy}}%
       \edef\num@Float{\expandafter\@car\@tempa \@nil}% \null
	\@ifundefined{Float@\R@f\num@Float}%
	 {\expandafter\gdef\csname Float@\R@f\num@Float\endcsname{}%
	\let\oldnum@Float=\num@Float%
	\edef\num@Float{{\noexpand\bfseries \oldnum@Float}}}{\relax}%
	\@h@ld\@Floata\num@Float%
      \let\@h@ld\relax
     \fi
   \fi
  }%
  \def\@Floata{\if@english, \else{}，\fi}%
 }%
 \@h@ld}

\def\onelineskip{\par\vspace{1\baselineskip}\par}
\def\halflineskip{\par\vspace{.5\baselineskip}\par}

\def\ddash{\hbox to 2zw{\/---\hss ---\/}}
\def\FRAC#1#2{\leavevmode\kern-.1em
  \raise.5ex\hbox{\the\scriptfont0 #1}\kern-.1em
  /\kern-.15em\lower.25ex\hbox{\the\scriptfont0 #2}}
\def\RN#1{\uppercase\expandafter{\romannumeral#1}}

\def\MARU#1{\raisebox{0.1zh}{{%
 \leavevmode\ooalign{\hfil\lower.168ex\hbox{#1}\hfil\crcr\mathhexbox20D}}}}

\def\kintou#1#2{%
 \leavevmode\hbox to #1{%
  \kanjiskip\z@ \@plus 1fill \@minus 1fill\xkanjiskip\kanjiskip #2}}

\def\ruby#1#2{\leavevmode \setbox0=\hbox{#1}\setbox1=\hbox{\tiny #2}%
 \ifdim\wd0>\wd1 \dimen0=\wd0 \else \dimen0=\wd1 \fi
 \leavevmode
 \smash{\hbox{\kanjiskip=\fill
 \vbox{\hbox to \dimen0{\tiny \hfil#2\hfil}%
  \nointerlineskip \hbox to \dimen0{\hfil#1\hfil}}}}}

\def\QED{{\fboxsep\z@\fboxrule.1mm
 \unskip\nobreak\hfil\penalty50
 \hskip2.75mm\hbox{}\nobreak\hfil 
  \mbox{\smash{\fbox{\rule{0mm}{3mm}\rule{1.5mm}{0mm}}}\hskip1zw}%
 \parfillskip\z@ \finalhyphendemerits\z@\par}}

\def\BQED{{\fboxsep\z@\fboxrule.1mm
 \unskip\nobreak\hfil\penalty50
 \hskip2.75mm\hbox{}\nobreak\hfil \mbox{\smash{\rule{1.5mm}{3mm}}\hskip1zw}%
 \parfillskip\z@ \finalhyphendemerits\z@\par}}

\postbreakpenalty`（=10000
\prebreakpenalty`）=10000
\postbreakpenalty`［=10000
\prebreakpenalty`］=10000
\postbreakpenalty`〈=10000
\prebreakpenalty`〉=10000
\prebreakpenalty`"=10000
\prebreakpenalty`℃=10000
\prebreakpenalty`　=10000
\prebreakpenalty`・=10000
\prebreakpenalty`〜=10000
\prebreakpenalty`ー=10000
\prebreakpenalty`？=10000
\prebreakpenalty`！=10000
\postbreakpenalty"5C=10000
\postbreakpenalty`【=10000
\prebreakpenalty`】=10000
\postbreakpenalty`〔=10000
\prebreakpenalty`〕=10000
\postbreakpenalty`『=10000
\prebreakpenalty`』=10000

\def\sloppy{\tolerance9999\hbadness9999\hfuzz.5\p@ \vfuzz.5\p@}

\hbadness4000
\vbadness10001
\tolerance4000\pretolerance\m@ne
\clubpenalty\z@
\widowpenalty\z@

\AtBeginDocument{%
 %% for AmS
 \displaywidowpenalty\z@
 \interdisplaylinepenalty\z@
 \predisplaypenalty\z@
 \postdisplaypenalty\z@
 %% nidanfloat
 \@ifundefined{dblbotfraction}{}{%
  \renewcommand\dblbotfraction{0.9}% 0.5
  \setcounter{dblbotnumber}{4}% 2
 }%
 %% here.sty
 \@ifundefined{@HHfloat}{}{%
  \def\@HHfloat#1[H]{%
   \expandafter\let\csname end#1\endcsname\end@Hfloat
   \vskip\intextsep
   \vbox\bgroup\def\@captype{#1}\parindent\z@
   \@floatboxreset %% added
   \ignorespaces}%
  \def\end@Hfloat{\egroup\vskip-1zh %% added
   \vskip \intextsep}%
 }%
 %% ams
 \@ifundefined{maketag@@@}{}%
  {% from amsmath v2.13
   %%\let\@mathmargin\mathindent
   \@mathmargin2zw \@plus\z@ \@minus\z@
   \multlinegap2zw
   \def\maketag@@@#1{\hbox{\m@th\normalfont #1}\hskip1zw}%
   \def\tagform@#1{\maketag@@@{%
    \inhibitglue （\ignorespaces#1\unskip\@@italiccorr ）\inhibitglue}}%
   \def\eqref#1{\textup{\tagform@{\ref{#1}}\unskip}}%
  }%
}

\AtEndDocument{%
 \clearpage
 \addtocounter{page}{-1}%
 \immediate\write\@auxout
  {\string\newlabel{sice@lastpage}{{}{\thepage}}}%
 %\addtocounter{page}{1}%
}

\pagestyle{SICE}
\pagenumbering{arabic}
%\raggedbottom
\if@twocolumn
 \twocolumn
 \sloppy
 \flushbottom
\else
 \onecolumn
\fi
\if@twoside
 \@mparswitchtrue
\else
 \@mparswitchfalse
\fi

\endinput
