LoadPackage("AutoDoc");

AutoDoc( "CAP" : scaffold := true, autodoc :=
         rec( scan_dirs := [ "gap", "examples/testfiles" ] ),
         maketest := rec( folder := ".",
                          commands :=
                            [ "LoadPackage( \"CAP\" );",
                              "LoadPackage( \"IO_ForHomalg\" );",
                              "LoadPackage( \"GaussForHomalg\" );",
			      "LoadPackage( \"ModulePresentationsForHomalg\" );",
			      "LoadPackage( \"RingsForHomalg\" );",
			      "LoadPackage( \"HomologicalAlgebraForCAP\" );",
                              "HOMALG_IO.show_banners := false;",
                              "HOMALG_IO.suppress_PID := true;",
                              "HOMALG_IO.use_common_stream := true;",
                             ]
                           )
);

QUIT;
