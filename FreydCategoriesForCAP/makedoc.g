#
# FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
#
LoadPackage( "AutoDoc" );

AutoDoc( "FreydCategoriesForCAP" : scaffold := true, autodoc :=
         rec( files := [ "doc/Intros.autodoc" ],
         scan_dirs := [ "gap", "examples", "doc" ] ),
         maketest := rec( commands :=
                            [ "LoadPackage( \"CAP\" );",
                              "LoadPackage( \"IO_ForHomalg\" );",
                              "LoadPackage( \"FreydCategoriesForCAP\" );",
                              "LoadPackage( \"RingsForHomalg\" );",
                              "LoadPackage( \"GaussForHomalg\" );",
                              "HOMALG_IO.show_banners := false;",
                              "HOMALG_IO.suppress_PID := true;",
                              "HOMALG_IO.use_common_stream := true;",
                             ]
                           )
);


QUIT;

