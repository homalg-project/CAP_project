# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# This file is a script which compiles the package manual.
#
if fail = LoadPackage( "AutoDoc", "2019.05.20" ) then
    
    Error( "AutoDoc version 2019.05.20 or newer is required." );
    
fi;

AutoDoc( rec(
    autodoc := rec(
        files :=
                   [ "doc/Doc.autodoc",
                     # Cartesian
                     "gap/CartesianCategoriesDoc.gd",
                     "gap/CartesianCategories.gd",
                     "gap/DistributiveCartesianCategories.gd",
                     "gap/BraidedCartesianCategories.gd",
                     "gap/CartesianClosedCategoriesDoc.gd",
                     "gap/CartesianClosedCategories.gd",
                     # Cartesian Add-methods
                     "gap/CartesianCategories.autogen.gd",
                     "gap/DistributiveCartesianCategories.autogen.gd",
                     "gap/BraidedCartesianCategories.autogen.gd",
                     "gap/CartesianClosedCategories.autogen.gd",
                     # Cocartesian
                     "gap/CocartesianCategoriesDoc.gd",
                     "gap/CocartesianCategories.gd",
                     "gap/DistributiveCocartesianCategories.gd",
                     "gap/BraidedCocartesianCategories.gd",
                     "gap/CocartesianCoclosedCategoriesDoc.gd",
                     "gap/CocartesianCoclosedCategories.gd",
                     # Cocartesian Add-methods
                     "gap/CocartesianCategories.autogen.gd",
                     "gap/BraidedCocartesianCategories.autogen.gd",
                     "gap/CocartesianCoclosedCategories.autogen.gd",
                     "gap/DistributiveCocartesianCategories.autogen.gd",
                     # Topos
                     "gap/Topos.gd",
                     # Topos Add-methods
                     "gap/Topos.autogen.gd",
                     # Tools
                     "gap/Tools.gd",
                     ],
        scan_dirs := [ "doc", "gap", "examples", "examples/doc" ],
    ),
    extract_examples := rec(
        units := "Single",
    ),
    gapdoc := rec(
        LaTeXOptions := rec(
            LateExtraPreamble := """
                \usepackage{mathtools}
            """,
        ),
    ),
    scaffold := rec(
        entities := [ "homalg", "CAP" ],
    ),
) );

QUIT;
