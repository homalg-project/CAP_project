#
# FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
#
LoadPackage( "AutoDoc" );

AutoDoc( "FreydCategoriesForCAP" :
         scaffold :=
          rec(
            gapdoc_latex_options := rec(
            LateExtraPreamble := "\\usepackage{tikz}\n\\usetikzlibrary{arrows}" )
          ),
         autodoc :=
         rec( files := [ "doc/Intros.autodoc" ],
         scan_dirs := [ "gap", "gap/CategoryOfGradedRowsAndColumns", "examples", "doc" ] ),
         maketest := rec( commands :=
                            [ "LoadPackage( \"CAP\" );",
                              "LoadPackage( \"IO_ForHomalg\" );",
                              "LoadPackage( \"FreydCategoriesForCAP\" );",
                              "LoadPackage( \"RingsForHomalg\" );",
                              "LoadPackage( \"GaussForHomalg\" );",
                              "LoadPackage( \"GeneralizedMorphismsForCAP\" );",
                              "LoadPackage( \"Bialgebroids\" );",
                              "HOMALG_IO.show_banners := false;",
                              "HOMALG_IO.suppress_PID := true;",
                              "HOMALG_IO.use_common_stream := true;",
                             ]
                           )
);


QUIT;

