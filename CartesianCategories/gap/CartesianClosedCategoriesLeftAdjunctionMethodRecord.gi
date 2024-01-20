# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



BindGlobal( "CARTESIAN_CLOSED_CATEGORIES_LEFT_ADJUNCTION_METHOD_NAME_RECORD", rec(

CartesianEvaluationMorphism := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b" ],
  output_range_getter_string := "b",
  output_range_getter_preconditions := [ ],
  output_source_getter_string := "BinaryDirectProduct( cat, ExponentialOnObjects( cat, a, b ), a )",
  output_source_getter_preconditions := [ [ "DirectProduct", 1 ], [ "ExponentialOnObjects", 1 ] ],
  output_range_getter_string := "b",
  with_given_object_position := "Source",
  dual_operation := "CocartesianEvaluationMorphism",
  dual_arguments_reversed := true,
  # Test in CartesianClosedCategoriesTest
),

CartesianEvaluationMorphismWithGivenSource := rec(
  filter_list := [ "category", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b", "s" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "b",
  output_range_getter_preconditions := [ ],
  dual_operation := "CocartesianEvaluationMorphismWithGivenRange",
  dual_preprocessor_func := { cat, a, b, s } -> NTuple( 4, Opposite( cat ), Opposite( b ), Opposite( a ), Opposite( s ) ),
  dual_arguments_reversed := false,
),

CartesianCoevaluationMorphism := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_source_getter_string := "a",
  output_range_getter_string := "ExponentialOnObjects( cat, b, BinaryDirectProduct( cat, a, b ) )",
  output_range_getter_preconditions := [ [ "ExponentialOnObjects", 1 ], [ "DirectProduct", 1 ] ],
  with_given_object_position := "Range",
  dual_operation := "CocartesianCoevaluationMorphism",
  dual_arguments_reversed := false,
  # Test in CartesianClosedCategoriesTest
),

CartesianCoevaluationMorphismWithGivenRange := rec(
  filter_list := [ "category", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b", "r" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "CocartesianCoevaluationMorphismWithGivenSource",
  dual_arguments_reversed := false,
),

DirectProductToExponentialAdjunctionMap := rec(
  filter_list := [ "category", "object", "object", "morphism" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b", "f" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "ExponentialOnObjects( cat, b, Range( f ) )",
  output_range_getter_preconditions := [ [ "ExponentialOnObjects", 1 ] ],
  with_given_object_position := "Range",
  dual_operation := "CoproductToCoexponentialAdjunctionMap",
  dual_arguments_reversed := false,
  # Test in CartesianClosedCategoriesTest
),

DirectProductToExponentialAdjunctionMapWithGivenExponential := rec(
  filter_list := [ "category", "object", "object", "morphism", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b", "f", "i" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "i",
  output_range_getter_preconditions := [ ],
  dual_operation := "CoproductToCoexponentialAdjunctionMapWithGivenCoexponential",
  dual_arguments_reversed := false,
),

ExponentialToDirectProductAdjunctionMap := rec(
  filter_list := [ "category", "object", "object", "morphism" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "b", "c", "g" ],
  output_source_getter_string := "BinaryDirectProduct( cat, Source( g ), b )",
  output_source_getter_preconditions := [ [ "DirectProduct", 1 ] ],
  output_range_getter_string := "c",
  output_range_getter_preconditions := [ ],
  with_given_object_position := "Source",
  dual_operation := "CoexponentialToCoproductAdjunctionMap",
  dual_preprocessor_func := { cat, a, b, g } -> NTuple( 4, Opposite( cat ), Opposite( b ), Opposite( a ), Opposite( g ) ),
  dual_arguments_reversed := false,
  # Test in CartesianClosedCategoriesTest
),

ExponentialToDirectProductAdjunctionMapWithGivenDirectProduct := rec(
  filter_list := [ "category", "object", "object", "morphism", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "b", "c", "g", "t" ],
  output_source_getter_string := "t",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "c",
  output_range_getter_preconditions := [ ],
  dual_operation := "CoexponentialToCoproductAdjunctionMapWithGivenCoproduct",
  dual_preprocessor_func := { cat, a, b, g, t } -> NTuple( 4, Opposite( cat ), Opposite( b ), Opposite( a ), Opposite( g ),Opposite( t ) ),
  dual_arguments_reversed := false,
),

) );
