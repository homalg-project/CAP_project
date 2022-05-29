# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Declarations
#

Perform(
## This is the CAP_INTERNAL_CATEGORICAL_PROPERTIES_LIST
    [
      [ "IsCartesianCategory", "IsCocartesianCategory" ],
      [ "IsStrictCartesianCategory", "IsStrictCocartesianCategory" ],
    ],
    AddCategoricalProperty );

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsCartesianCategory  := Concatenation( [
"DirectProduct",
"ProjectionInFactorOfDirectProductWithGivenDirectProduct",
"UniversalMorphismIntoDirectProductWithGivenDirectProduct",
"TerminalObject",
"UniversalMorphismIntoTerminalObjectWithGivenTerminalObject",
], CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.EveryCategory );

DeclareOperation( "BinaryDirectProduct",
        [ IsCapCategory, IsCapCategoryObject, IsCapCategoryObject ] );
