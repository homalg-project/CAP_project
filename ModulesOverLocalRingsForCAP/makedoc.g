#
# ModulesOverLocalRingsForCAP: Category of modules over a local ring modeled by Serre quotients for CAP
LoadPackage( "AutoDoc" );

AutoDoc( "ModulesOverLocalRingsForCAP" : scaffold := true, autodoc :=
         rec( files := [ "doc/Intros.autodoc" ],
         scan_dirs := [ "gap", "examples", "doc" ] ),
         maketest := rec( commands :=
                            [ "LoadPackage( \"CAP\" );",
                              "LoadPackage( \"IO_ForHomalg\" );",
                              "LoadPackage( \"GaussForHomalg\" );",
                              "LoadPackage( \"ModulesOverLocalRingsForCAP\" );",
                              "LoadPackage( \"RingsForHomalg\" );",
                              "HOMALG_IO.show_banners := false;",
                              "HOMALG_IO.suppress_PID := true;",
                              "HOMALG_IO.use_common_stream := true;",
                             ]
                           )
);


QUIT;

