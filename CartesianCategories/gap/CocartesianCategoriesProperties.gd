# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Declarations
#

Perform(
## This is the CAP_INTERNAL_CATEGORICAL_PROPERTIES_LIST
    [
      [ "IsCocartesianCategory", "IsCartesianCategory" ],
      [ "IsStrictCocartesianCategory", "IsStrictCartesianCategory" ],
    ],
    AddCategoricalProperty );

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsCocartesianCategory  := Concatenation( [
"Coproduct",
"InjectionOfCofactorOfCoproductWithGivenCoproduct",
"UniversalMorphismFromCoproductWithGivenCoproduct",
"InitialObject",
"UniversalMorphismFromInitialObjectWithGivenInitialObject",
], CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.EveryCategory );

## For internal use only:
## we need an operation name different from `Coproduct`, since CompilerForCAP
## seems to be unable to compile the CAP operation `Coproduct`
## if declared in a way different from that in the method record
DeclareOperation( "BinaryCoproduct",
        [ IsCapCategory, IsCapCategoryObject, IsCapCategoryObject ] );

##
CAP_INTERNAL_ADD_REPLACEMENTS_FOR_METHOD_RECORD(
  rec(
    BinaryCoproduct :=
      [ [ "Coproduct", 1 ] ]
  )
);
