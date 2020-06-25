#
# CompilerForCAP: This package allows to "compile" the code of CAP categories.
#
# This file is a script which compiles the package manual and prints overfull hbox warnings.
#
if fail = LoadPackage("AutoDoc", "2019.05.20") then
    Error("AutoDoc version 2019.05.20 or newer is required.");
fi;

AutoDoc(rec(
    gapdoc := rec(
        LaTeXOptions := rec(
            LateExtraPreamble := """
                \RecustomVerbatimEnvironment{Verbatim}{BVerbatim}{}
                """
        ),
    ),
    scaffold := rec(
        entities := [ "GAP4", "CAP" ],
    ),
    autodoc := rec( files := [ "doc/Doc.autodoc" ] ),
    extract_examples := rec( units := "Single" ),
));

QUIT;
