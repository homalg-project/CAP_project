# SPDX-License-Identifier: GPL-2.0-or-later
# AdditiveClosuresForCAP: Additive closures for pre-additive categories
#
# This file is a script which compiles the package manual and prints overfull hbox warnings.
#
if fail = LoadPackage( "AutoDoc", "2019.05.20" ) then
    
    Error( "AutoDoc version 2019.05.20 or newer is required." );
    
fi;

AutoDoc( rec(
    dir := "doc_tmp/",
    autodoc := rec(
        files := [ "doc/Doc.autodoc" ],
        scan_dirs := [ "doc", "gap", "examples", "examples/doc", "gap/CategoryOfGradedRowsAndColumns" ],
    ),
    gapdoc := rec(
        LaTeXOptions := rec(
            LateExtraPreamble := """
                \usepackage{tikz}
                \usetikzlibrary{arrows}
                \usetikzlibrary{calc}
                % Many thanks to https://tex.stackexchange.com/questions/22466/how-to-convince-fancyvrb-to-give-overfull-warnings/534486#534486
                \makeatletter
                \def\FV@ListProcessLine#1{%
                  \hbox to \hsize{%
                    \kern\leftmargin
                    \hbox to \linewidth{%
                      \FV@LeftListNumber
                      \FV@LeftListFrame
                      \FancyVerbFormatLine{#1}\hfil % change \hss to \hfil
                      \FV@RightListFrame
                      \FV@RightListNumber}%
                    \hss}}
                \makeatother
            """,
        ),
    ),
    scaffold := rec(
        entities := [ "homalg", "CAP" ],
    ),
) );

QUIT;
