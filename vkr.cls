% \iffalse meta-comment
% 
% \fi
%%
%% LaTeX class file.
%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{vkr}[VKR class]

%\setlength\paperheight{297mm} % размеры страницы A4
%\setlength\paperwidth{210mm}

\if@compatibility\else
\DeclareOption{draft}{\setlength\overfullrule{5pt}}
\fi
\if@compatibility\else
\DeclareOption{final}{\setlength\overfullrule{0pt}}
\fi
\ExecuteOptions{final}
\ProcessOptions

% Режимы работы
\newif\ifВКР
\newif\ifПрактика
\newif\ifКурсовая

\newcommand{\interval}{1.7}

\renewcommand\normalsize{ % стандартный размер шрифта
  \@setfontsize\normalsize\@xivpt{14pt} % 
  \abovedisplayskip 14.4\p@ \@plus 3\p@ \@minus 3\p@ % отступы вокруг формул
  \abovedisplayshortskip \z@ \@plus 3\p@
  \belowdisplayshortskip 7.2\p@ \@plus 3\p@ \@minus 3\p@
}

\pagenumbering{arabic}  % but no page numbers are printed because:
\pagestyle{empty}       % this is actually already in the kernel

\usepackage{fontspec} % шрифт Times
\setmainfont{Times New Roman}

% Размеры шрифтов
\newcommand\footnotesize{ % подстрочный размер
  \@setfontsize\footnotesize\@xpt{15pt}
}
\newcommand\large{\@setfontsize\large\@xviipt{22}} % большой шрифт
\newcommand\tiny{\@setfontsize\tiny\@vipt{6pt}} % мелкий шрифт
\newcommand\small{\@setfontsize\small\@xipt{13.6}}%
\newcommand\scriptsize{\@setfontsize\scriptsize\@viiipt{9.5}}
\newcommand\Large{\@setfontsize\Large\@xviipt{22}}
\newcommand\LARGE{\@setfontsize\LARGE\@xxpt{25}}
\newcommand\huge{\@setfontsize\huge\@xxvpt{30}}
\newcommand\Huge{\@setfontsize\Huge\@xxvpt{30}}


% Параграфы
\renewcommand\baselinestretch{\interval} % полуторный интервал
\setlength\lineskip{1\p@} % минимальное расстояние между линиями
\setlength\normallineskip{1\p@}
\setlength\parskip{0\p@} % нулевое вертикальное расстояние между параграфами
\setlength\parindent{1.25cm} % отступ первой стоки параграфа
\@lowpenalty 51 % параметры переноса на новую строку
\@medpenalty 151
\@highpenalty 301

% Разметка страницы
\newlength\pagetop
\newlength\pagebottom
\newlength\pageleft
\newlength\pageright
\newlength\pwidth % ширина A4
\newlength\pheight % высота A4
\setlength\pagetop{2cm}
\setlength\pagebottom{2cm}
\setlength\pageleft{3cm}
\setlength\pageright{1.5cm}
\setlength\pwidth{210mm}
\setlength\pheight{297mm}

\def\setuppage#1#2#3#4#5#6{%
  \paperheight=#6 % размеры страницы A4
  \paperwidth=#5
  \pdfpagewidth=#5
  \pdfpageheight=#6
  \pagestyle{plain}
  \setlength{\hoffset}{-1in} % установка точки отсчета - левый верхний угол
  \setlength{\voffset}{-1in}
  \setlength\headheight{#1} % размер верхнего поля
  \setlength\headsep{0pt} % нет заголовка
  \setlength\topskip{14\p@} % базовая линия для первой строки на странице
  \setlength\footskip{0.5#2} % нижний отступ
  \setlength\maxdepth{0.5\topskip} % 
  \setlength{\topmargin}{0pt} % верхний margin
  \setlength{\textwidth}{\paperwidth} % расчет ширины текста
  \addtolength{\textwidth}{-#3} % левое поле
  \addtolength{\textwidth}{-#4} % правое поле
  \setlength\textheight{\paperheight} % расчет вертикальной длины текста
  \addtolength{\textheight}{-\headheight}
  \addtolength{\textheight}{-\footskip}
  \addtolength{\textheight}{-0.5#2} % место для номера страницы
  \setlength{\evensidemargin}{#3} % левое поле
  \setlength{\oddsidemargin}{#3}
  \setlength{\linewidth}{\textwidth}
  \setlength{\columnwidth}{\textwidth}
  \setlength{\@colht}\textheight
  \setlength{\@colroom}\textheight
}
\setuppage\pagetop\pagebottom\pageleft\pageright\pwidth\pheight

% Изображения и таблицы (плавающие элементы)

\setlength\floatsep{8mm} % отступ друг от друга
\setlength\textfloatsep{8mm}  % отступ от текста (изображение сверху или снизу)
\setlength\intextsep{8mm} % отступ от текста внутри текста

% Подвал

%\renewcommand\@thefoot{\hfil\thepage\hfil} % вывод номера страницы по центру
\def\@oddfoot{\hfil\thepage\hfil}
\def\@evenfoot{\hfil\thepage\hfil}

% Титульная страница

\newcommand{\fillcenter}[2][\fill]{%
	\lhrulefill{#1}%
	\makebox[0pt]{#2}\lhrulefill{#1}}
	
\newcommand{\fillleft}[2][\fill]{%
	\underline{#2}\lhrulefill{#1}}
	
\newcommand{\lhrulefill}[1]{%
	\leavevmode
	\leaders\hrule height -.67ex depth \dimexpr .67ex+.4pt\relax % define the leader
	\hskip\glueexpr#1/2\relax\relax % how much it should extend
	\kern0pt
}

\newsavebox\saved@arstrutbox 
\newcommand*{\setarstrut}[1]{% команда для уменьшения высоты строки в таблице
	\noalign{%
		\begingroup
                \renewcommand{\baselinestretch}{1}
		\global\setbox\saved@arstrutbox\copy\@arstrutbox
		#1%
		\global\setbox\@arstrutbox\hbox{%
			\vrule \@height\arraystretch\ht\strutbox
			\@depth\arraystretch \dp\strutbox
			\@width\z@
		}%
		\endgroup
	}%
}
\newcommand*{\restorearstrut}{% восстановление высоты строки
	\noalign{%
                \renewcommand{\baselinestretch}{\interval}
		\global\setbox\@arstrutbox\copy\saved@arstrutbox
	}%
}

\newenvironment{titlepage}
    {%
      \newpage
      \thispagestyle{empty}%
      %\setcounter{page}\z@
    }%
    {\newpage
    }

\newcommand\maketitle{\begin{titlepage}% % титульная страница
  \begin{center}
\large\textbf{Минобрнауки России}

\large\textbf{Юго-Западный государственный университет}
\vfill
\normalsize{Кафедра программной инженерии}
\vfill
\ifВКР{
  \large\textbf{ВЫПУСКНАЯ КВАЛИФИКАЦИОННАЯ РАБОТА}\\
  \large\textbf{ПО ПРОГРАММЕ БАКАЛАВРИАТА}\\
  \vfill
  \normalsize\fillcenter{09.03.04 Программная инженерия}\\
  \renewcommand{\baselinestretch}{1}
  \footnotesize{(код, наименование ОПОП ВО: направление подготовки, направленность (профиль))}
  \renewcommand{\baselinestretch}{\interval}

  \normalsize\fillcenter{«Разработка программно-информационных систем»}\\
}\fi
\ifПрактика{
	\large\textbf{ОТЧЕТ}\\
	\normalsize\noindent\fillcenter{о преддипломной (производственной) практике}\\
        \renewcommand{\baselinestretch}{1}
	\footnotesize{наименование вида и типа практики}

        \renewcommand{\baselinestretch}{\interval}	
	\normalsize на (в) \fillcenter{\ГдеПроводитсяПрактика}
        \vskip -0.3cm        
	\footnotesize{наименование предприятия, организации, учреждения}

        \normalsize Студента\hspace{0.5cm}\fillleft{\Курс курса, группы \Группа}\\

        \renewcommand{\baselinestretch}{1}
	\footnotesize{курса, группы}	
        \renewcommand{\baselinestretch}{\interval}	

        \normalsize\fillcenter{\АвторПолностьюРод}
        \vskip -0.3cm        
	\footnotesize{фамилия, имя, отчество}
}\fi
\ifКурсовая{
  \vskip 1.5em
  \large\textbf{КУРСОВАЯ РАБОТА (ПРОЕКТ)}\\
  \vskip 1.5em
	\normalsize\noindent по дисциплине \fillcenter\Дисциплина\\
        \renewcommand{\baselinestretch}{1}
	\footnotesize{наименование дисциплины}

        \renewcommand{\baselinestretch}{\interval}	  
	\normalsize\noindent на тему \fillcenter\Тема
        
        \fillcenter\ТемаВтораяСтрока

        \normalsize\noindent Направление подготовки (специальность) \fillcenter\КодСпециальности\\
        \renewcommand{\baselinestretch}{1}
	\footnotesize{\hspace{0.5\linewidth}(код, наименование)}

%        \renewcommand{\baselinestretch}{\interval}
        
        \normalsize\noindent\fillcenter\Специальность
        
          \begin{xltabular}{\textwidth}{p{5.5cm}>{\centering\arraybackslash}X>{\centering\arraybackslash}X}
            Автор работы (проекта) & \fillcenter\Автор & \lhrulefill{\fill}\\
            \setarstrut{\footnotesize}
            &  \footnotesize{(инициалы, фамилия)} & \footnotesize{(подпись, дата)}\\
            \restorearstrut
          Группа  \fillcenter{\Группа}&&\\
          \end{xltabular}
          \vfill
        \begin{xltabular}{\textwidth}{p{7.0cm}>{\centering\arraybackslash}X>{\centering\arraybackslash}X}
            Руководитель работы (проекта) & \fillcenter\Руководитель & \lhrulefill{\fill}\\
            \setarstrut{\footnotesize}
            &  \footnotesize{(инициалы, фамилия)} & \footnotesize{(подпись, дата)}\\
            \restorearstrut
        \end{xltabular}
          \vskip -2em
        \begin{xltabular}{\textwidth}{p{6.5cm}>{\centering\arraybackslash}X>{\centering\arraybackslash}X}
            Работа (проект) защищена & \lhrulefill{\fill} &\\
            \setarstrut{\footnotesize}
            & \footnotesize{(дата)}&\\
            \restorearstrut
        \end{xltabular}
        \vskip -2em
        \begin{flushleft}
        \normalsize\noindent\hspace{0.1cm} Оценка \underline{\hspace{5cm}}
        \end{flushleft}
  \vskip 2em
}\fi
\ifВКР{
  \normalsize\fillcenter\Тема\\
  \fillcenter\ТемаВтораяСтрока\\
  \renewcommand{\baselinestretch}{1}
  \footnotesize{(название темы)}
  \renewcommand{\baselinestretch}{\interval}

  \normalsize\fillcenter{Дипломный проект}\\
  \renewcommand{\baselinestretch}{1}
  \footnotesize{(вид ВКР: дипломная работа или дипломный проект)}
  \renewcommand{\baselinestretch}{\interval}
}\fi
\vfill
  \end{center}
\ifВКР{  
  \begin{tabular}{p{5.8cm}C{4.8cm}C{4.8cm}}
    Автор ВКР & \lhrulefill{\fill} & \fillcenter\Автор\\
    \setarstrut{\footnotesize}
    & \footnotesize{(подпись, дата)} & \footnotesize{(инициалы, фамилия)}\\
    \restorearstrut
    Группа  \underline{\hspace{0.5cm}\Группа \hspace{0.5cm}} & &\\
    \\
    Руководитель ВКР & \lhrulefill{\fill} & \fillcenter\Руководитель\\
    \setarstrut{\footnotesize}
    & \footnotesize{(подпись, дата)} & \footnotesize{(инициалы, фамилия)}\\
    \restorearstrut
    Нормоконтроль & \lhrulefill{\fill} & \fillcenter\Нормоконтроль\\
    \setarstrut{\footnotesize}
    & \footnotesize{(подпись, дата)} & \footnotesize{(инициалы, фамилия)}\\
    \restorearstrut
  \end{tabular}

  \noindent\begin{tabular}{p{5.8cm}C{4.8cm}C{4.8cm}}
  ВКР допущена к защите:& &\\
  Заведующий кафедрой & \lhrulefill{\fill} & \fillcenter\ЗавКаф\\
  \setarstrut{\footnotesize}
  & \footnotesize{(подпись, дата)} & \footnotesize{(инициалы, фамилия)}\\
  \restorearstrut
  \end{tabular}
}\fi
\ifПрактика{
  \renewcommand{\baselinestretch}{1}
  \begin{tabular}{C{6.5cm}p{2cm}C{6.5cm}}
    \normalsize Руководитель практики от предприятия, организации, учреждения & & \normalsize Оценка \underline{\hspace{4cm}} \\
		
    \fillcenter{\ДолжнРуководительПрактПредпр}\newline
    \footnotesize{должность, звание, степень}&&\\
    \fillcenter{\РуководительПрактПредпр}\newline\footnotesize{фамилия и. о.}&&\underline{\hspace{3cm}\hspace{3cm}}\newline\footnotesize{подпись, дата}\\
    \\
    \normalsize Руководитель практики от университета & & \normalsize Оценка \underline{\hspace{4cm}} \\
		
    \fillcenter{\ДолжнРуководительПрактУнивер}\newline
    \footnotesize{должность, звание, степень}&&\\
    \fillcenter{\РуководительПрактУнивер}\newline\footnotesize{фамилия и. о.}&&\underline{\hspace{3cm}\hspace{3cm}}\newline\footnotesize{подпись, дата}\\
  \end{tabular}
}\fi
\ifВКР{}\else{
  \vfill
  \begin{xltabular}{\textwidth}{p{4.5cm}>{\centering\arraybackslash}X>{\centering\arraybackslash}X}
    \normalsize Члены комиссии & \lhrulefill{\fill} & \lhrulefill{\fill} \\
    \setarstrut{\footnotesize}
    &\footnotesize{подпись, дата} & \footnotesize{фамилия и. о.}\\
    \restorearstrut
    & \lhrulefill{\fill} & \lhrulefill{\fill} \\
    \setarstrut{\footnotesize}
    &\footnotesize{подпись, дата} & \footnotesize{фамилия и. о.}\\
    \restorearstrut
    & \lhrulefill{\fill} & \lhrulefill{\fill} \\
    \setarstrut{\footnotesize}
    &\footnotesize{подпись, дата} & \footnotesize{фамилия и. о.}\\
    \restorearstrut
  \end{xltabular}
}\fi
\renewcommand{\baselinestretch}{\interval}
\vfill
\begin{center}
\normalsize{Курск \the\year{} г.}
\end{center}
  \end{titlepage}
}

% Разделы

\setcounter{secnumdepth}{4} % Число уровней

\newcounter{section}
\newcounter{subsection}[section]
\newcounter{subsubsection}[subsection]
\newcounter{paragraph}[subsubsection]

\renewcommand\thesection{\@arabic\c@section}
\renewcommand\thesubsection{\thesection.\@arabic\c@subsection}
\renewcommand\thesubsubsection{\thesubsection .\@arabic\c@subsubsection}
\renewcommand\theparagraph{\thesubsubsection.\@arabic\c@paragraph}

\def\@startsection#1#2#3#4#5#6#7{% 7-й параметр - стиль команды с *
  \if@noskipsec \leavevmode \fi
  \par
  \@tempskipa #4\relax
  \@afterindenttrue
  \ifdim \@tempskipa <\z@
    \@tempskipa -\@tempskipa \@afterindentfalse
  \fi
  \if@nobreak
    \everypar{}%
  \else
    \addpenalty\@secpenalty\addvspace\@tempskipa
  \fi
  \@ifstar
    {\@ssect{#3}{#4}{#5}{#7}}%
    {\@dblarg{\@sect{#1}{#2}{#3}{#4}{#5}{#6}}}}

\newcommand\nohyph{% запрет переносов в параграфе
  \pretolerance=10000
  \tolerance=2000 
  \emergencystretch=10pt
}
 
\newcommand\section{
  \setcounter{figure}{0}%
  \setcounter{table}{0}%
  \@startsection {section}{1}{\parindent}%
                                   {4mm}%
                                   {4mm}%
                                   {\newpage\normalsize\bfseries}
                                   {\newpage\centering\normalsize}}
\newcommand\subsection{\@startsection{subsection}{2}{\parindent}%
                                     {4mm}%
                                     {4mm}%
                                     {\normalsize\nohyph\bfseries}{}}
\newcommand\subsubsection{\@startsection{subsubsection}{3}{\parindent}%
                                     {4mm}%
                                     {4mm}%
                                     {\normalsize\nohyph\bfseries}{}}
\newcommand\paragraph{\@startsection{paragraph}{4}{\parindent}%
                                     {4mm}%
                                     {4mm}%
                                    {\normalsize\bfseries}{}}

\def\@sect#1#2#3#4#5#6[#7]#8{%
  \ifnum #2>\c@secnumdepth
    \let\@svsec\@empty
  \else
    \refstepcounter{#1}%
    \protected@edef\@svsec{\@seccntformat{#1}\relax}%
  \fi
  \@tempskipa #5\relax
  \ifdim \@tempskipa>\z@
    \begingroup
      #6{%
        \@svsec \interlinepenalty \@M #8\@@par}%
    \endgroup
    \csname #1mark\endcsname{#7}%
    \addcontentsline{toc}{#1}{%
      \ifnum #2>\c@secnumdepth \else
        \protect\numberline{\csname the#1\endcsname}%
      \fi
      #7}%
  \else
    \def\@svsechd{%
      #6{\hskip #3\relax
      \@svsec #8}%
      \csname #1mark\endcsname{#7}%
      \addcontentsline{toc}{#1}{%
        \ifnum #2>\c@secnumdepth \else
          \protect\numberline{\csname the#1\endcsname}%
        \fi
        #7}}%
  \fi
  \@xsect{#5}}

% перечисления, списки
\setlength\leftmargini  {\parindent}
\leftmargin  \leftmargini
\setlength  \labelsep  {.5em}
\setlength  \labelwidth{1.1em}
\addtolength\leftmargin{\labelwidth}
\renewcommand\theenumi{\@arabic\c@enumi}
\renewcommand\theenumii{\@alph\c@enumii}
\renewcommand\theenumiii{\@roman\c@enumiii}
\renewcommand\theenumiv{\@Alph\c@enumiv}
\newcommand\labelenumi{\theenumi.}
\newcommand\labelenumii{(\theenumii)}
\newcommand\labelenumiii{\theenumiii.}
\newcommand\labelenumiv{\theenumiv.}
\renewcommand\p@enumii{\theenumi}
\renewcommand\p@enumiii{\theenumi(\theenumii)}
\renewcommand\p@enumiv{\p@enumiii\theenumiii}
\newcommand\labelitemi{--}
\newcommand\labelitemii{\normalfont\bfseries \textendash}
\newcommand\labelitemiii{\textasteriskcentered}
\newcommand\labelitemiv{\textperiodcentered}

% Реферат
\newcommand{\abstract}[1]{%
  \section*{#1}
}

% Приложения
\global\let\appendixbegin\@empty
\newcommand{\appendix}[1]{
  \ifx\appendixbegin\@empty{
    \global\let\appendixbegin\relax
    \setcounter{section}{1}
  }\fi%
  \renewcommand{\thesection}{\Asbuk{section}}
  \section*{ПРИЛОЖЕНИЕ \thesection\ \\ #1}
  \addcontentsline{toc}{section}{ПРИЛОЖЕНИЕ \thesection\ #1}
  \ifx\appendixbegin\@empty{}\else{
    \refstepcounter{section}}\fi
}

\newcommand\applabel[1]{% создает команду для печати буквы приложения
  \addtocounter{section}{-1}
  \def\@@b{\Asbuk{section}}
  \immediate\write\@auxout
      {\string\gdef\csname#1\endcsname\expandafter{\Asbuk{section}}}
  \stepcounter{section}
}

\newcommand\appref[1]{% ссылка на букву
  \ifdefined #1
  #1
  \fi
}
  
% Рисунки

\setlength\arraycolsep{5\p@}
\setlength\tabcolsep{6\p@}
\setlength\arrayrulewidth{.4\p@}
\setlength\doublerulesep{2\p@}
\setlength\tabbingsep{\labelsep}
\skip\@mpfootins = \skip\footins
\setlength\fboxsep{3\p@}
\setlength\fboxrule{.4\p@}


\newcounter{figure}
\newcounter{figurecnt} %всего рисунков
\renewcommand \thefigure{\thesection.\@arabic\c@figure}
\def\fps@figure{tbp}
\def\ftype@figure{1} % тип объекта
\def\ext@figure{lof} % файл для списка рисунков
\def\fnum@figure{\figurename\nobreakspace\thefigure}
\newcommand\figurename{}
\newenvironment{figure}
               {
                 \ifx\appendixbegin\@empty{\refstepcounter{figurecnt}}\fi
                 \vspace{8mm}
                 \@float{figure}}
               {\end@float}

\newlength\abovecaptionskip
\newlength\belowcaptionskip
\setlength\abovecaptionskip{10\p@}
\setlength\belowcaptionskip{-0.6em}

% функция проверки вхождения подстроки #1 в строку #2
\def\instring#1#2{TT\fi\begingroup
  \edef\x{\endgroup\noexpand\in@{#1}{#2}}\x\ifin@}

\long\def\@makecaption#1#2{% заголовки для рисунков и таблиц
  \vskip\abovecaptionskip
  \sbox\@tempboxa{#1 -- #2}%
  \ifdim \wd\@tempboxa >\hsize
    #1 -- #2\par
  \else
    \global \@minipagefalse
    \if\instring{Таб}{#1}
    \hb@xt@\hsize{\box\@tempboxa\hfil}% заголовок таблицы по левому краю
    \else
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}% заголовок рисунка по центру
    \fi
  \fi
  \vskip\belowcaptionskip}

% Таблицы
\newcounter{table}
\newcounter{tablecnt} %всего таблиц
\renewcommand\thetable{\thesection.\@arabic\c@table}
\def\fps@table{tbp}
\def\ftype@table{2}
\def\ext@table{lot}
\def\fnum@table{\tablename\nobreakspace\thetable}
\newenvironment{table}
               {
                 \if@app{\refstepcounter{tablecnt}}{}\fi
                 \@float{table}}
{\end@float}

% Положение рисунков и таблиц
\renewcommand{\topfraction}{0.9}	% max fraction of floats at top
\renewcommand{\bottomfraction}{0.8}
\setcounter{topnumber}{2}
\setcounter{bottomnumber}{2}
\setcounter{totalnumber}{4}     % 2 may work better
\renewcommand{\textfraction}{0.07}	% allow minimal text w. figs
    %   Parameters for FLOAT pages (not text pages):
\renewcommand{\floatpagefraction}{0.7}	% require fuller float pages
	% N.B.: floatpagefraction MUST be less than topfraction !!

% Содержание

\newcommand\@pnumwidth{1.55em}
\newcommand\@tocrmarg{2.55em}
\newcommand\@dotsep{4.5}
\setcounter{tocdepth}{4}

\newcommand\tableofcontents{%
    \setcounter{tablecnt}{0}
    \setcounter{figurecnt}{0}
    \section*{СОДЕРЖАНИЕ}%
    \@starttoc{toc}%
    \списокПлакатовСодержание
    }

\newcommand*\l@section{\@dottedtocline{1}{0pt}{1.3em}}
\newcommand*\l@subsection{\@dottedtocline{2}{0pt}{1.6em}}
\newcommand*\l@subsubsection{\@dottedtocline{3}{0pt}{2.6em}}
\newcommand*\l@paragraph{\@dottedtocline{4}{0pt}{3.3em}}

\def\@dottedtocline#1#2#3#4#5{%
  \ifnum #1>\c@tocdepth \else
    \vskip \z@ \@plus.2\p@
    {\leftskip #2\relax \rightskip \@tocrmarg \parfillskip -\rightskip
     \parindent #2\relax\@afterindenttrue
     \interlinepenalty\@M
     \leavevmode
     \@tempdima #3\relax
     {#4}% здесь не делается box для текста заголовка
     \leaders\hbox{$\m@th
        \mkern \@dotsep mu\hbox{}\mkern \@dotsep
        mu$}\hfill
     \nobreak
     \hb@xt@\@pnumwidth{\hfil\normalfont \normalcolor #5}%
     \par}%
  \fi}

\raggedbottom

% работа содержит \formbytotal{tablecnt}{рисун}{ок}{ка}{ков} % основа слова, окончания для согласования с 1 (рисун_ок), 2  (рисун_ка) и 5 (рисун_ков)
\def\formbytotal#1#2#3#4#5{%
  \newcount\c
  \c \value{#1}\relax
	\newcount\last
	\newcount\pnul
	\last \c\relax
	\divide \last 10
	\pnul \last\relax
	\divide\pnul 10
	\multiply \pnul-10
	\advance \pnul\last
	\multiply \last-10
	\advance \last\c
	\arabic{#1}~#2%
	\ifnum\pnul=1#5\else%
	\ifcase\last#5\or#3\or#4\or#4\or#4\else#5\fi
	\fi
}

% подсчет страниц
\newcounter{lastpage}
\setcounter{lastpage}{0}
% пишем в aux файл команду установки счетчика на номер последней страницы
% aux файл автоматически читается в начале документа
\AtEndDocument{\immediate\write\@auxout%
  {\string\setcounter{lastpage}{\the\c@page}
    \string\setcounter{числоПлакатов}{\arabic{числоПлакатов}}
    \string\setcounter{figurecnt}{\arabic{figurecnt}}
    \string\setcounter{tablecnt}{\arabic{tablecnt}}
    \string\setcounter{bibcount}{\arabic{bibcount}}
  }
}

% Плакаты
\newenvironment{плакат}
               {
                 \begin{figure}[H]
                   \begin{center}
               \stepcounter{числоПлакатов}}
               {\end{center}\end{figure}}
\newcounter{числоПлакатов}               
\newcommand{\заголовок}[1]{%
  \добавитьПлакат{\arabic{числоПлакатов}}{#1}%
  \добавитьПлакатСодержание{\arabic{числоПлакатов}}{#1}%
  \caption{#1}}

\def\добавитьПлакат#1#2{% добавляет в aux команду записи в lop файл
  \immediate\write\@auxout
      {\string\@writefile{lop}{\печатьПлакат{Лист #1. #2.}}}
}

\def\добавитьПлакатСодержание#1#2{% добавляет в aux команду записи в lop файл
  \immediate\write\@auxout
      {\string\@writefile{lpc}{\печатьПлакатСодержание{#1}{#2}}}
}

\def\печатьПлакат#1{% вывод строки списка плакатов
  \par #1}

\def\печатьПлакатСодержание#1#2{%
  \noindent #2 (Графический материал / #2.png) \hfill Лист #1\break}

% читает и вставляет файл плакатов (main.lop), перезаписывает его и открывает
\def\списокПлакатов{%
  \begingroup
    \makeatletter
    \@input{\jobname.lop}%
    \if@filesw
      \expandafter\newwrite\csname tf@lop\endcsname
      \immediate\openout \csname tf@lop\endcsname \jobname.lop\relax
    \fi
    \@nobreakfalse
    \endgroup
}

% генерирует список плакатов после содержания
\def\списокПлакатовСодержание{%
  \begingroup
    \makeatletter
    \@input{\jobname.lpc}%
    \if@filesw
      \expandafter\newwrite\csname tf@lpc\endcsname
      \immediate\openout \csname tf@lpc\endcsname \jobname.lpc\relax
    \fi
    \@nobreakfalse
    \endgroup
}
\sloppy % авто увеличение пробелов между словами при невозможности переносов
\clubpenalties 2 10000 150 % запрет одной оторванной строки сверху
\widowpenalties 2 10000 150 % и снизу

% список литературы
\newcounter{bibcount} % счетчик литературы
\newenvironment{thebibliography}[1]
     {\section*{\refname}%
       \@mkboth{\MakeUppercase\refname}{\MakeUppercase\refname}%
       \setcounter{bibcount}{0}
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
             	\setlength{\topsep}{0pt}                  
		\setlength{\partopsep}{0pt}
		\setlength{\itemsep}{0pt}
		\setlength{\parsep}{0pt}
		\setlength{\parskip}{0pt}
		\setlength{\itemindent}{1.75cm}
		\setlength{\leftmargin}{0pt}
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}

\def\@biblabel#1{#1.} % формат номера в списке
     
\let\@openbib@code\@empty

\let\oldbib\bibitem
\def\bibitem#1{%
  \refstepcounter{bibcount} % счетчик литературы
  \oldbib{#1}
}

% описания
\newenvironment{description}
               {\list{}{\labelwidth\z@ \itemindent-\leftmargin
                        \let\makelabel\descriptionlabel}}
               {\endlist}
\newcommand*\descriptionlabel[1]{\hspace\labelsep
                                \normalfont\bfseries #1}

\frenchspacing % пробел после двоеточия
\endinput
     
