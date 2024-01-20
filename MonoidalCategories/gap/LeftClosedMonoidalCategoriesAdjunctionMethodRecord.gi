# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

BindGlobal( "LEFT_CLOSED_MONOIDAL_CATEGORIES_ADJUNCTION_METHOD_NAME_RECORD", rec(

LeftClosedMonoidalEvaluationMorphism := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b" ],
  output_range_getter_string := "b",
  output_range_getter_preconditions := [ ],
  output_source_getter_string := "TensorProductOnObjects( cat, LeftInternalHomOnObjects( cat, a, b ), a )",
  output_source_getter_preconditions := [ [ "TensorProductOnObjects", 1 ], [ "LeftInternalHomOnObjects", 1 ] ],
  output_range_getter_string := "b",
  with_given_object_position := "Source",
  dual_operation := "LeftCoclosedMonoidalEvaluationMorphism",
  dual_arguments_reversed := true,
  # Test in LeftClosedMonoidalCategoriesTest
),

LeftClosedMonoidalEvaluationMorphismWithGivenSource := rec(
  filter_list := [ "category", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b", "s" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "b",
  output_range_getter_preconditions := [ ],
  dual_operation := "LeftCoclosedMonoidalEvaluationMorphismWithGivenRange",
  dual_preprocessor_func := { cat, a, b, s } -> NTuple( 4, Opposite( cat ), Opposite( b ), Opposite( a ), Opposite( s ) ),
  dual_arguments_reversed := false,
),

LeftClosedMonoidalCoevaluationMorphism := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_source_getter_string := "a",
  output_range_getter_string := "LeftInternalHomOnObjects( cat, b, TensorProductOnObjects( cat, a, b ) )",
  output_range_getter_preconditions := [ [ "LeftInternalHomOnObjects", 1 ], [ "TensorProductOnObjects", 1 ] ],
  with_given_object_position := "Range",
  dual_operation := "LeftCoclosedMonoidalCoevaluationMorphism",
  dual_arguments_reversed := false,
  # Test in LeftClosedMonoidalCategoriesTest
),

LeftClosedMonoidalCoevaluationMorphismWithGivenRange := rec(
  filter_list := [ "category", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b", "r" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "LeftCoclosedMonoidalCoevaluationMorphismWithGivenSource",
  dual_arguments_reversed := false,
),

TensorProductToLeftInternalHomAdjunctionMap := rec(
  filter_list := [ "category", "object", "object", "morphism" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b", "f" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "LeftInternalHomOnObjects( cat, b, Range( f ) )",
  output_range_getter_preconditions := [ [ "LeftInternalHomOnObjects", 1 ] ],
  with_given_object_position := "Range",
  dual_operation := "TensorProductToLeftInternalCoHomAdjunctionMap",
  dual_arguments_reversed := false,
  # Test in LeftClosedMonoidalCategoriesTest
),

TensorProductToLeftInternalHomAdjunctionMapWithGivenLeftInternalHom := rec(
  filter_list := [ "category", "object", "object", "morphism", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b", "f", "i" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "i",
  output_range_getter_preconditions := [ ],
  dual_operation := "TensorProductToLeftInternalCoHomAdjunctionMapWithGivenLeftInternalCoHom",
  dual_arguments_reversed := false,
),

LeftInternalHomToTensorProductAdjunctionMap := rec(
  filter_list := [ "category", "object", "object", "morphism" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "b", "c", "g" ],
  output_source_getter_string := "TensorProductOnObjects( cat, Source( g ), b )",
  output_source_getter_preconditions := [ [ "TensorProductOnObjects", 1 ] ],
  output_range_getter_string := "c",
  output_range_getter_preconditions := [ ],
  with_given_object_position := "Source",
  dual_operation := "LeftInternalCoHomToTensorProductAdjunctionMap",
  dual_preprocessor_func := { cat, a, b, g } -> NTuple( 4, Opposite( cat ), Opposite( b ), Opposite( a ), Opposite( g ) ),
  dual_arguments_reversed := false,
  # Test in LeftClosedMonoidalCategoriesTest
),

LeftInternalHomToTensorProductAdjunctionMapWithGivenTensorProduct := rec(
  filter_list := [ "category", "object", "object", "morphism", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "b", "c", "g", "t" ],
  output_source_getter_string := "t",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "c",
  output_range_getter_preconditions := [ ],
  dual_operation := "LeftInternalCoHomToTensorProductAdjunctionMapWithGivenTensorProduct",
  dual_preprocessor_func := { cat, a, b, g, t } -> NTuple( 4, Opposite( cat ), Opposite( b ), Opposite( a ), Opposite( g ),Opposite( t ) ),
  dual_arguments_reversed := false,
),

) );
