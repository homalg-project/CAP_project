LoadPackage("AutoDoc");

AutoDoc( "CAP" : scaffold := true, autodoc :=
         rec( files := [ "doc/Intros.autodoc" ],
         scan_dirs := [ "gap", "examples/testfiles", "doc" ] ),
         maketest := rec( folder := ".",
                          commands :=
                            [ "LoadPackage( \"CAP\" );",
                              "LoadPackage( \"IO_ForHomalg\" );",
                              "LoadPackage( \"GaussForHomalg\" );",
                              "LoadPackage( \"ModulePresentationsForCAP\" );",
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
