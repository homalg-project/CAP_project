#
# GroupRepresentationsForCAP: Skeletal category of group representations for CAP
#
# This file is a script which compiles the package manual.
#
LoadPackage( "AutoDoc" );

AutoDoc( "GroupRepresentationsForCAP" : scaffold := true, autodoc :=
         rec( files := [ "doc/Intros.autodoc" ],
         scan_dirs := [ "gap", "examples", "doc", "examples/doc" ] ),
         maketest := rec( folder := ".",
                          commands :=
                            [ "LoadPackage( \"CAP\" );",
                              "LoadPackage( \"IO_ForHomalg\" );",
                              "LoadPackage( \"GaussForHomalg\" );",
                              "LoadPackage( \"LinearAlgebraForCAP\" );",
                              "LoadPackage( \"GroupRepresentationsForCAP\" );",
                              "HOMALG_IO.show_banners := false;",
                              "HOMALG_IO.suppress_PID := true;",
                              "HOMALG_IO.use_common_stream := true;",
                             ]
                           )
);


QUIT;

