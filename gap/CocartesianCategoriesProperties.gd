# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Declarations
#

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsCocartesianCategory  := Concatenation( [
"Coproduct",
"InjectionOfCofactorOfCoproductWithGivenCoproduct",
"UniversalMorphismFromCoproductWithGivenCoproduct",
"InitialObject",
"UniversalMorphismFromInitialObjectWithGivenInitialObject",
], CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.EveryCategory );

Perform(
## This is the CAP_INTERNAL_CATEGORICAL_PROPERTIES_LIST
    [
      [ "IsCocartesianCategory", "IsCartesianCategory" ],
      [ "IsStrictCocartesianCategory", "IsStrictCartesianCategory" ],
    ],
    AddCategoricalProperty );

InstallTrueMethod( IsCocartesianCategory, IsAbelianCategory );
