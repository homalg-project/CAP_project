# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
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
                                "gap/MonoidalCategories.autogen.gd",
                                "gap/AdditiveMonoidalCategories.gd",
                                "gap/AdditiveMonoidalCategories.autogen.gd",
                                "gap/BraidedMonoidalCategoriesDoc.gd",
                                "gap/BraidedMonoidalCategories.gd",
                                "gap/BraidedMonoidalCategories.autogen.gd",
                                "gap/SymmetricMonoidalCategoriesDoc.gd",
                                "gap/ClosedMonoidalCategoriesDoc.gd",
                                "gap/ClosedMonoidalCategories.gd",
                                "gap/ClosedMonoidalCategories.autogen.gd",
                                "gap/CoclosedMonoidalCategoriesDoc.gd",
                                "gap/CoclosedMonoidalCategories.gd",
                                "gap/CoclosedMonoidalCategories.autogen.gd",
                                "gap/SymmetricClosedMonoidalCategoriesDoc.gd",
                                "gap/SymmetricCoclosedMonoidalCategoriesDoc.gd",
                                "gap/RigidSymmetricClosedMonoidalCategoriesDoc.gd",
                                "gap/RigidSymmetricClosedMonoidalCategories.gd",
                                "gap/RigidSymmetricClosedMonoidalCategories.autogen.gd",
                                "gap/RigidSymmetricCoclosedMonoidalCategoriesDoc.gd",
                                "gap/RigidSymmetricCoclosedMonoidalCategories.gd",
                                "gap/RigidSymmetricCoclosedMonoidalCategories.autogen.gd",
                                ],
                            scan_dirs := [ ],
                            ),

            maketest := rec( folder := ".",
                             commands :=
                             [ "LoadPackage( \"MonoidalCategories\" );",
                               "LoadPackage( \"GaussForHomalg\" );",
                             ],
                           ),
            )
);

QUIT;
