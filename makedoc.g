LoadPackage("AutoDoc");

AutoDoc( "CategoriesForHomalg" : scaffold := true, autodoc :=
         rec( scan_dirs := [ "gap", "examples/testfiles" ] ),
         maketest := rec( folder := ".",
                          commands :=
                            [ "LoadPackage( \"CategoriesForHomalg\" );",
                              "LoadPackage( \"IO_ForHomalg\" );",
                              "LoadPackage( \"GaussForHomalg\" );",
                              "HOMALG_IO.show_banners := false;",
                              "HOMALG_IO.suppress_PID := true;",
                              "HOMALG_IO.use_common_stream := true;",
                             ]
                           )
);

QUIT;
