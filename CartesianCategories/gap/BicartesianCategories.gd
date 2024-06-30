# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Declarations
#

# @Chapter Further categorical subdoctrines

#! @Description
#!  The property of the category <A>C</A> being bicartesian.
#! @Arguments C
DeclareProperty( "IsBicartesianCategory", IsCapCategory );

AddCategoricalProperty( [ "IsBicartesianCategory", "IsBicartesianCategory" ] );

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsBicartesianCategory :=
  DuplicateFreeList(
          Concatenation(
                  CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsCartesianCategory,
                  CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsCocartesianCategory ) );

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsBicartesianClosedCategory :=
  DuplicateFreeList(
          Concatenation(
                  CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsCartesianClosedCategory,
                  CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsCocartesianCategory ) );

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsBicartesianCoclosedCategory :=
  DuplicateFreeList(
          Concatenation(
                  CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsCocartesianCoclosedCategory,
                  CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsCartesianCategory ) );

#! @Description
#!  The property of the category <A>C</A> being finite complete.
#! @Arguments C
DeclareProperty( "IsFiniteCompleteCategory", IsCapCategory );

AddCategoricalProperty( [ "IsFiniteCompleteCategory", "IsFiniteCocompleteCategory" ] );

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsFiniteCompleteCategory :=
  DuplicateFreeList(
          Concatenation(
                  CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsCartesianCategory,
                  [ "Equalizer",
                    "EmbeddingOfEqualizerWithGivenEqualizer",
                    "UniversalMorphismIntoEqualizerWithGivenEqualizer",
                    ] ) );

#! @Description
#!  The property of the category <A>C</A> being finite cocomplete.
#! @Arguments C
DeclareProperty( "IsFiniteCocompleteCategory", IsCapCategory );

AddCategoricalProperty( [ "IsFiniteCocompleteCategory", "IsFiniteCompleteCategory" ] );

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsFiniteCocompleteCategory :=
  DuplicateFreeList(
          Concatenation(
                  CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsCocartesianCategory,
                  [ "Coequalizer",
                    "ProjectionOntoCoequalizerWithGivenCoequalizer",
                    "UniversalMorphismFromCoequalizerWithGivenCoequalizer",
                    ] ) );

#! @Description
#!  The property of the category <A>C</A> being finite bicomplete.
#! @Arguments C
DeclareProperty( "IsFiniteBicompleteCategory", IsCapCategory );

AddCategoricalProperty( [ "IsFiniteBicompleteCategory", "IsFiniteBicompleteCategory" ] );

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsFiniteBicompleteCategory :=
  DuplicateFreeList(
          Concatenation(
                  CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsFiniteCompleteCategory,
                  CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsFiniteCocompleteCategory ) );
