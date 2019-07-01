#
# MonoidalCategories
#
# This file is a script which compiles the package manual.
#
if fail = LoadPackage("AutoDoc", "2016.02.16") then
    Error("AutoDoc version 2016.02.16 or newer is required.");
fi;

AutoDoc( 
        rec(
            scaffold := rec( gapdoc_latex_options := rec( 
                             LateExtraPreamble := "\\usepackage{amsmath}\\usepackage[T1]{fontenc}\n\\usepackage{tikz}\n\\usetikzlibrary{shapes,arrows,matrix}\n\\usepackage{faktor}" 
                                                        ),
                             entities := [ "GAP4", "CAP", "homalg" ],
                             ),
            
            autodoc := rec( files := [
                                "doc/Doc.autodoc",
                                "gap/MonoidalCategoriesDoc.gd",
                                "gap/MonoidalCategoriesTensorProductOnObjectsAndUnitObject.gd",
                                "gap/MonoidalCategories.gd",
                                "gap/AdditiveMonoidalCategories.gd",
                                "gap/BraidedMonoidalCategoriesDoc.gd",
                                "gap/BraidedMonoidalCategories.gd",
                                "gap/SymmetricMonoidalCategoriesDoc.gd",
                                "gap/ClosedMonoidalCategoriesDoc.gd",
                                "gap/ClosedMonoidalCategories.gd",
                                "gap/SymmetricClosedMonoidalCategoriesDoc.gd",
                                "gap/RigidSymmetricClosedMonoidalCategoriesDoc.gd",
                                "gap/RigidSymmetricClosedMonoidalCategories.gd",
                                ],
                            scan_dirs := [ ],
                            ),

            maketest := rec( folder := ".",
                             commands :=
                             [ "LoadPackage( \"MonoidalCategories\" );",
                               "LoadPackage( \"MatricesForHomalg\" );",
                               "LoadPackage( \"GaussForHomalg\" );",
                             ],
                           ),
            )
);

QUIT;
