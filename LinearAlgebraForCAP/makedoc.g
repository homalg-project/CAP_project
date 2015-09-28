#
# LinearAlgebraForCAP: Category of Matrices over a Field for CAP
#
LoadPackage( "AutoDoc" );

AutoDoc( "LinearAlgebraForCAP" : scaffold := true, autodoc :=
         rec( files := [ "doc/Intros.autodoc" ],
         scan_dirs := [ "gap", "doc" ] ),
         maketest := rec( folder := ".",
                          commands :=
                            [ "LoadPackage( \"CAP\" );",
                              "LoadPackage( \"IO_ForHomalg\" );",
                              "LoadPackage( \"GaussForHomalg\" );",
                              "LoadPackage( \"ModulePresentationsForCAP\" );",
                              "LoadPackage( \"RingsForHomalg\" );",
                              "LoadPackage( \"HomologicalAlgebraForCAP\" );",
                              "LoadPackage( \"DeductiveSystemForCAP\" );",
			      "LoadPackage( \"LinearAlgebraForCAP\" );",
                              "HOMALG_IO.show_banners := false;",
                              "HOMALG_IO.suppress_PID := true;",
                              "HOMALG_IO.use_common_stream := true;",
                             ]
                           )
);


QUIT;
