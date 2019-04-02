LoadPackage("AutoDoc");

AutoDoc( "CAP" :
         scaffold :=
          rec(
            gapdoc_latex_options := rec(
            LateExtraPreamble := Concatenation( "\\usepackage{tikz}\n\\usetikzlibrary{arrows}",
                                  "\\pgfarrowsdeclarecombine{twohead}{twohead}{latex}{latex}{latex}{latex}" ) )
          ),
         autodoc :=
         rec( files := [ "doc/Intros.autodoc" ],
         scan_dirs := [ "doc", "gap", "examples/testfiles" ] ),
         maketest := rec( commands :=
                            [ "LoadPackage( \"CAP\" );",
                              "LoadPackage( \"IO_ForHomalg\" );",
                              "LoadPackage( \"GaussForHomalg\" );",
                              "LoadPackage( \"ModulePresentationsForCAP\" );",
                              "LoadPackage( \"LinearAlgebraForCAP\" );",
                              "LoadPackage( \"RingsForHomalg\" );",
                              "LoadPackage( \"HomologicalAlgebraForCAP\" );",
                              "LoadPackage( \"DeductiveSystemForCAP\" );",
                              "HOMALG_IO.show_banners := false;",
                              "HOMALG_IO.suppress_PID := true;",
                              "HOMALG_IO.use_common_stream := true;",
                             ]
                           )
);

QUIT;
