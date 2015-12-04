#
# CAPCategoryOfProjectiveGradedModules: Category of projective graded modules over a graded ring
#

LoadPackage( "AutoDoc" );

AutoDoc( "CAPCategoryOfProjectiveGradedModules" : scaffold := true, autodoc :=
         rec( files := [ "doc/Intros.autodoc",
                         "gap/CAPCategoryOfProjectiveGradedLeftModules.gd",
                         "gap/CAPCategoryOfProjectiveGradedRightModules.gd",
                         "gap/CAPCategoryOfProjectiveGradedModulesObject.gd",
                         "gap/CAPCategoryOfProjectiveGradedModulesMorphism.gd",
                         "gap/SemigroupAndConeWrapper.gd",
                         "gap/Tools.gd",
                         "gap/CAPCategoryOfProjectiveGradedModulesFunctors.gd",
                         "gap/CAPCategoryOfProjectiveGradedModulesNaturalTransformations.gd",
                         "examples/Example.g"
                         ],
             scan_dirs := []
             ),
         maketest := rec( folder := ".",
                          commands :=
                            [ "LoadPackage( \"CAP\" );",
                              "LoadPackage( \"IO_ForHomalg\" );",
                              "LoadPackage( \"GaussForHomalg\" );",
                              "LoadPackage( \"CAPCategoryOfProjectiveGradedModules\" );",
                              "HOMALG_IO.show_banners := false;",
                              "HOMALG_IO.suppress_PID := true;",
                              "HOMALG_IO.use_common_stream := true;",
                             ]
                           )
);


QUIT;