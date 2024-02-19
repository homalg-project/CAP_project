# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

InstallValue( LEFT_CLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD, rec(

LeftInternalHomOnObjects := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "object",
  input_arguments_names := [ "cat", "a", "b" ],
  dual_operation := "LeftInternalCoHomOnObjects",
  dual_arguments_reversed := true,
  # Test in LeftClosedMonoidalCategoriesTest
),

LeftInternalHomOnMorphisms := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "alpha", "beta" ],
  output_source_getter_string := "LeftInternalHomOnObjects( cat, Range( alpha ), Source( beta ) )",
  output_source_getter_preconditions := [ [ "LeftInternalHomOnObjects", 1 ] ],
  output_range_getter_string := "LeftInternalHomOnObjects( cat, Source( alpha ), Range( beta ) )",
  output_range_getter_preconditions := [ [ "LeftInternalHomOnObjects", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "LeftInternalCoHomOnMorphisms",
  dual_arguments_reversed := true,
  # Test in LeftClosedMonoidalCategoriesTest
),

LeftInternalHomOnMorphismsWithGivenLeftInternalHoms := rec(
  filter_list := [ "category", "object", "morphism", "morphism", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "alpha", "beta", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "LeftInternalCoHomOnMorphismsWithGivenLeftInternalCoHoms",
  dual_arguments_reversed := true,
),

LeftClosedMonoidalEvaluationMorphism := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b" ],
  output_source_getter_string := "TensorProductOnObjects( cat, LeftInternalHomOnObjects( cat, a, b ), a )",
  output_source_getter_preconditions := [ [ "TensorProductOnObjects", 1 ], [ "LeftInternalHomOnObjects", 1 ] ],
  output_range_getter_string := "b",
  output_range_getter_preconditions := [ ],
  with_given_object_position := "Source",
  dual_operation := "LeftCoclosedMonoidalEvaluationMorphism",
  dual_arguments_reversed := false,
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
  dual_arguments_reversed := false,
),

LeftClosedMonoidalCoevaluationMorphism := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b" ],
  output_source_getter_string := "b",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "LeftInternalHomOnObjects( cat, a, TensorProductOnObjects( cat, b, a ) )",
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
  output_source_getter_string := "b",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "LeftCoclosedMonoidalCoevaluationMorphismWithGivenSource",
  dual_arguments_reversed := false,
),

TensorProductToLeftInternalHomAdjunctMorphism := rec(
  filter_list := [ "category", "object", "object", "morphism" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b", "f" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "LeftInternalHomOnObjects( cat, b, Range( f ) )",
  output_range_getter_preconditions := [ [ "LeftInternalHomOnObjects", 1 ] ],
  with_given_object_position := "Range",
  dual_operation := "TensorProductToLeftInternalCoHomAdjunctMorphism",
  dual_arguments_reversed := false,
  # Test in LeftClosedMonoidalCategoriesTest
),

TensorProductToLeftInternalHomAdjunctMorphismWithGivenLeftInternalHom := rec(
  filter_list := [ "category", "object", "object", "morphism", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b", "f", "i" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "i",
  output_range_getter_preconditions := [ ],
  dual_operation := "TensorProductToLeftInternalCoHomAdjunctMorphismWithGivenLeftInternalCoHom",
  dual_arguments_reversed := false,
),

LeftInternalHomToTensorProductAdjunctMorphism := rec(
  filter_list := [ "category", "object", "object", "morphism" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "b", "c", "g" ],
  output_source_getter_string := "TensorProductOnObjects( cat, Source( g ), b )",
  output_source_getter_preconditions := [ [ "TensorProductOnObjects", 1 ] ],
  output_range_getter_string := "c",
  output_range_getter_preconditions := [ ],
  with_given_object_position := "Source",
  dual_operation := "LeftInternalCoHomToTensorProductAdjunctMorphism",
  dual_preprocessor_func := { cat, a, b, g } -> NTuple( 4, Opposite( cat ), Opposite( b ), Opposite( a ), Opposite( g ) ),
  dual_arguments_reversed := false,
  # Test in LeftClosedMonoidalCategoriesTest
),

LeftInternalHomToTensorProductAdjunctMorphismWithGivenTensorProduct := rec(
  filter_list := [ "category", "object", "object", "morphism", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "b", "c", "g", "t" ],
  output_source_getter_string := "t",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "c",
  output_range_getter_preconditions := [ ],
  dual_operation := "LeftInternalCoHomToTensorProductAdjunctMorphismWithGivenTensorProduct",
  dual_preprocessor_func := { cat, a, b, g, t } -> NTuple( 5, Opposite( cat ), Opposite( b ), Opposite( a ), Opposite( g ), Opposite( t ) ),
  dual_arguments_reversed := false,
  # Test in LeftClosedMonoidalCategoriesTestWithGiven
),

LeftClosedMonoidalPreComposeMorphism := rec(
  filter_list := [ "category", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b", "c" ],
  output_source_getter_string := "TensorProductOnObjects( cat, LeftInternalHomOnObjects( cat, a, b ), LeftInternalHomOnObjects( cat, b, c ) )",
  output_source_getter_preconditions := [ [ "TensorProductOnObjects", 1 ], [ "LeftInternalHomOnObjects", 2 ] ],
  output_range_getter_string := "LeftInternalHomOnObjects( cat, a, c )",
  output_range_getter_preconditions := [ [ "LeftInternalHomOnObjects", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "LeftCoclosedMonoidalPreCoComposeMorphism",
  dual_arguments_reversed := true,
  # Test in LeftClosedMonoidalCategoriesTest
),

LeftClosedMonoidalPreComposeMorphismWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "a", "b", "c", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "LeftCoclosedMonoidalPreCoComposeMorphismWithGivenObjects",
  dual_arguments_reversed := true,
),

LeftClosedMonoidalPostComposeMorphism := rec(
  filter_list := [ "category", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b", "c" ],
  output_source_getter_string := "TensorProductOnObjects( cat, LeftInternalHomOnObjects( cat, b, c ), LeftInternalHomOnObjects( cat, a, b ) )",
  output_source_getter_preconditions := [ [ "TensorProductOnObjects", 1 ], [ "LeftInternalHomOnObjects", 2 ] ],
  output_range_getter_string := "LeftInternalHomOnObjects( cat, a, c )",
  output_range_getter_preconditions := [ [ "LeftInternalHomOnObjects", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "LeftCoclosedMonoidalPostCoComposeMorphism",
  dual_arguments_reversed := true,
  # Test in LeftClosedMonoidalCategoriesTest
),

LeftClosedMonoidalPostComposeMorphismWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "a", "b", "c", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "LeftCoclosedMonoidalPostCoComposeMorphismWithGivenObjects",
  dual_arguments_reversed := true,
),

LeftDualOnObjects := rec(
  filter_list := [ "category", "object" ],
  return_type := "object",
  input_arguments_names := [ "cat", "a" ],
  dual_operation := "LeftCoDualOnObjects",
  # Test in LeftClosedMonoidalCategoriesTest
),

LeftDualOnMorphisms := rec(
  filter_list := [ "category", "morphism" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "alpha" ],
  output_source_getter_string := "LeftDualOnObjects( cat, Range( alpha ) )",
  output_source_getter_preconditions := [ [ "LeftDualOnObjects", 1 ] ],
  output_range_getter_string := "LeftDualOnObjects( cat, Source( alpha ) )",
  output_range_getter_preconditions := [ [ "LeftDualOnObjects", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "LeftCoDualOnMorphisms",
  # Test in LeftClosedMonoidalCategoriesTest
),

LeftDualOnMorphismsWithGivenLeftDuals := rec(
  filter_list := [ "category", "object", "morphism", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "alpha", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "LeftCoDualOnMorphismsWithGivenLeftCoDuals",
  dual_arguments_reversed := true,
),

LeftClosedMonoidalEvaluationForLeftDual := rec(
  filter_list := [ "category", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a" ],
  output_source_getter_string := "TensorProductOnObjects( cat, LeftDualOnObjects( cat, a ), a )",
  output_source_getter_preconditions := [ [ "TensorProductOnObjects", 1 ], [ "LeftDualOnObjects", 1 ] ],
  output_range_getter_string := "TensorUnit( cat )",
  output_range_getter_preconditions := [ [ "TensorUnit", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "LeftCoclosedMonoidalEvaluationForLeftCoDual",
  # Test in LeftClosedMonoidalCategoriesTest
),

LeftClosedMonoidalEvaluationForLeftDualWithGivenTensorProduct := rec(
  filter_list := [ "category", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "a", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "LeftCoclosedMonoidalEvaluationForLeftCoDualWithGivenTensorProduct",
  dual_arguments_reversed := true,
),

MorphismToLeftBidual := rec(
  filter_list := [ "category", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_source_getter_string := "a",
  output_range_getter_string := "LeftDualOnObjects( cat, LeftDualOnObjects( cat, a ) )",
  output_range_getter_preconditions := [ [ "LeftDualOnObjects", 2 ] ],
  with_given_object_position := "Range",
  dual_operation := "MorphismFromLeftCoBidual",
  # Test in LeftClosedMonoidalCategoriesTest
),

MorphismToLeftBidualWithGivenLeftBidual := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "r" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "MorphismFromLeftCoBidualWithGivenLeftCoBidual",
  dual_arguments_reversed := false,
),

TensorProductLeftInternalHomCompatibilityMorphism := rec(
  filter_list := [ "category", "list_of_objects" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "list" ],
  output_source_getter_string := "TensorProductOnObjects( cat, LeftInternalHomOnObjects( cat, list[1], list[2] ), LeftInternalHomOnObjects( cat, list[3], list[4] ) )",
  output_source_getter_preconditions := [ [ "TensorProductOnObjects", 1 ], [ "LeftInternalHomOnObjects", 2 ] ],
  output_range_getter_string := "LeftInternalHomOnObjects( cat, TensorProductOnObjects( cat, list[1], list[3] ), TensorProductOnObjects( cat, list[2], list[4] ) )",
  output_range_getter_preconditions := [ [ "LeftInternalHomOnObjects", 1 ], [ "TensorProductOnObjects", 2 ] ],
  with_given_object_position := "both",
  dual_operation := "LeftInternalCoHomTensorProductCompatibilityMorphism",
  dual_preprocessor_func := { cat, list } -> Pair( Opposite( cat ), [ Opposite( list[2] ), Opposite( list[4] ), Opposite( list[1] ), Opposite( list[3] ) ] ),
  dual_arguments_reversed := false,
  # Test in LeftClosedMonoidalCategoriesTest
),

TensorProductLeftInternalHomCompatibilityMorphismWithGivenObjects := rec(
  filter_list := [ "category", "object", "list_of_objects", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "source", "list", "range" ],
  output_source_getter_string := "source",
  output_range_getter_string := "range",
  dual_operation := "LeftInternalCoHomTensorProductCompatibilityMorphismWithGivenObjects",
  dual_preprocessor_func :=
    { cat, s, list, r } -> NTuple( 4, Opposite( cat ), Opposite( r ), [ Opposite( list[2] ), Opposite( list[4] ), Opposite( list[1] ), Opposite( list[3] ) ], Opposite( s ) ),
  dual_arguments_reversed := false,
),

TensorProductLeftDualityCompatibilityMorphism := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b" ],
  output_source_getter_string := "TensorProductOnObjects( cat, LeftDualOnObjects( cat, a ), LeftDualOnObjects( cat, b ) )",
  output_source_getter_preconditions := [ [ "TensorProductOnObjects", 1 ], [ "LeftDualOnObjects", 2 ] ],
  output_range_getter_string := "LeftDualOnObjects( cat, TensorProductOnObjects( cat, a, b ) )",
  output_range_getter_preconditions := [ [ "LeftDualOnObjects", 1 ], [ "TensorProductOnObjects", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "LeftCoDualityTensorProductCompatibilityMorphism",
  dual_arguments_reversed := false,
  # Test in LeftClosedMonoidalCategoriesTest
),

TensorProductLeftDualityCompatibilityMorphismWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "a", "b", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "LeftCoDualityTensorProductCompatibilityMorphismWithGivenObjects",
  dual_with_given_objects_reversed := true,
),

MorphismFromTensorProductToLeftInternalHom := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b" ],
  output_source_getter_string := "TensorProductOnObjects( cat, LeftDualOnObjects( cat, a ), b )",
  output_source_getter_preconditions := [ [ "TensorProductOnObjects", 1 ], [ "LeftDualOnObjects", 1 ] ],
  output_range_getter_string := "LeftInternalHomOnObjects( cat, a, b )",
  output_range_getter_preconditions := [ [ "LeftInternalHomOnObjects", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "MorphismFromLeftInternalCoHomToTensorProduct",
  dual_arguments_reversed := true,
  # Test in LeftClosedMonoidalCategoriesTest
),

MorphismFromTensorProductToLeftInternalHomWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "a", "b", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "MorphismFromLeftInternalCoHomToTensorProductWithGivenObjects",
  dual_arguments_reversed := true,
),

IsomorphismFromLeftInternalHomIntoTensorUnitToLeftDualObject := rec(
  filter_list := [ "category", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a" ],
  output_source_getter_string := "LeftInternalHomOnObjects( cat, a, TensorUnit( cat ) )",
  output_source_getter_preconditions := [ [ "LeftInternalHomOnObjects", 1 ], [ "TensorUnit", 1 ] ],
  output_range_getter_string := "LeftDualOnObjects( cat, a )",
  output_range_getter_preconditions := [ [ "LeftDualOnObjects", 1 ] ],
  dual_operation := "IsomorphismFromLeftCoDualObjectToLeftInternalCoHomFromTensorUnit",
  # Test in LeftClosedMonoidalCategoriesTest
),

IsomorphismFromLeftDualObjectToLeftInternalHomIntoTensorUnit := rec(
  filter_list := [ "category", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a" ],
  output_source_getter_string := "LeftDualOnObjects( cat, a )",
  output_source_getter_preconditions := [ [ "LeftDualOnObjects", 1 ] ],
  output_range_getter_string := "LeftInternalHomOnObjects( cat, a, TensorUnit( cat ) )",
  output_range_getter_preconditions := [ [ "LeftInternalHomOnObjects", 1 ], [ "TensorUnit", 1 ] ],
  dual_operation := "IsomorphismFromLeftInternalCoHomFromTensorUnitToLeftCoDualObject",
  # Test in LeftClosedMonoidalCategoriesTest
),

UniversalPropertyOfLeftDual := rec(
  filter_list := [ "category", "object", "object", "morphism" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "t", "a", "alpha" ],
  output_source_getter_string := "t",
  output_source_getter_preconditions := [ ],
  dual_operation := "UniversalPropertyOfLeftCoDual",
  dual_arguments_reversed := false,
  # Test in LeftClosedMonoidalCategoriesTest
),

LeftClosedMonoidalLambdaIntroduction := rec(
  filter_list := [ "category", "morphism" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "alpha" ],
  dual_operation := "LeftCoclosedMonoidalLambdaIntroduction",
  # Test in LeftClosedMonoidalCategoriesTest
),

LeftClosedMonoidalLambdaElimination := rec(
  filter_list := [ "category", "object", "object", "morphism" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b", "alpha" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "b",
  output_range_getter_preconditions := [ ],
  dual_operation := "LeftCoclosedMonoidalLambdaElimination",
  dual_preprocessor_func := { cat, a, b, alpha } -> NTuple( 4, Opposite( cat ), Opposite( b ), Opposite( a ), Opposite( alpha ) ),
  dual_arguments_reversed := false,
  # Test in LeftClosedMonoidalCategoriesTest
),

IsomorphismFromObjectToLeftInternalHom := rec(
  filter_list := [ "category", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_source_getter_string := "a",
  output_range_getter_string := "LeftInternalHomOnObjects( cat, TensorUnit( cat ), a )",
  output_range_getter_preconditions := [ [ "LeftInternalHomOnObjects", 1 ], [ "TensorUnit", 1 ] ],
  with_given_object_position := "Range",
  dual_operation := "IsomorphismFromLeftInternalCoHomToObject",
  # Test in LeftClosedMonoidalCategoriesTest
),

IsomorphismFromObjectToLeftInternalHomWithGivenLeftInternalHom := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "r" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "IsomorphismFromLeftInternalCoHomToObjectWithGivenLeftInternalCoHom",
  dual_arguments_reversed := false,
),

IsomorphismFromLeftInternalHomToObject := rec(
  filter_list := [ "category", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a" ],
  output_range_getter_string := "a",
  output_range_getter_preconditions := [ ],
  output_source_getter_string := "LeftInternalHomOnObjects( cat, TensorUnit( cat ), a )",
  output_source_getter_preconditions := [ [ "LeftInternalHomOnObjects", 1 ], [ "TensorUnit", 1 ] ],
  output_range_getter_string := "a",
  with_given_object_position := "Source",
  dual_operation := "IsomorphismFromObjectToLeftInternalCoHom",
  # Test in LeftClosedMonoidalCategoriesTest
),

IsomorphismFromLeftInternalHomToObjectWithGivenLeftInternalHom := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "s" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "a",
  output_range_getter_preconditions := [ ],
  dual_operation := "IsomorphismFromObjectToLeftInternalCoHomWithGivenLeftInternalCoHom",
  dual_arguments_reversed := false,
),

) );
