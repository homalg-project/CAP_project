#
# GeneralizedMorphismsForCAP: Implementations of generalized morphisms for the CAP project
#
LoadPackage( "AutoDoc" );

AutoDoc( "GeneralizedMorphismsForCAP" : scaffold := true, autodoc :=
         rec( files := [ "doc/Intros.autodoc" ],
         scan_dirs := [ "gap", "examples", "doc" ] ),
         maketest := rec( folder := ".",
                          commands :=
                            [ "LoadPackage( \"CAP\" );",
                              "LoadPackage( \"IO_ForHomalg\" );",
                              "LoadPackage( \"GaussForHomalg\" );",
                              "LoadPackage( \"GeneralizedMorphismsForCAP\" );",
                              "LoadPackage( \"LinearAlgebraForCAP\" );",
                              "HOMALG_IO.show_banners := false;",
                              "HOMALG_IO.suppress_PID := true;",
                              "HOMALG_IO.use_common_stream := true;",
                             ]
                           )
);


QUIT;
