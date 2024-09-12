# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

InstallValue( COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD, rec(

InternalCoHomOnObjects := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "object",
  input_arguments_names := [ "cat", "a", "b" ],
  dual_operation := "InternalHomOnObjects",
  dual_arguments_reversed := true,
  # Test in CoclosedMonoidalCategoriesTest
),

InternalCoHomOnMorphisms := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "alpha", "beta" ],
  output_source_getter_string := "InternalCoHomOnObjects( cat, Source( alpha ), Range( beta ) )",
  output_source_getter_preconditions := [ [ "InternalCoHomOnObjects", 1 ] ],
  output_range_getter_string := "InternalCoHomOnObjects( cat, Range( alpha ), Source( beta ) )",
  output_range_getter_preconditions := [ [ "InternalCoHomOnObjects", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "InternalHomOnMorphisms",
  dual_arguments_reversed := true,
  # Test in CoclosedMonoidalCategoriesTest
),

InternalCoHomOnMorphismsWithGivenInternalCoHoms := rec(
  filter_list := [ "category", "object", "morphism", "morphism", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "alpha", "beta", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "InternalHomOnMorphismsWithGivenInternalHoms",
  dual_arguments_reversed := true,
),

CoclosedMonoidalRightEvaluationMorphism := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b" ],
  output_source_getter_string := "b",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "TensorProductOnObjects( cat, a, InternalCoHomOnObjects( cat, b, a ) )",
  output_range_getter_preconditions := [ [ "TensorProductOnObjects", 1 ], [ "InternalCoHomOnObjects", 1 ] ],
  with_given_object_position := "Range",
  dual_operation := "ClosedMonoidalRightEvaluationMorphism",
  dual_arguments_reversed := false,
  # Test in CoclosedMonoidalCategoriesTest
),

CoclosedMonoidalRightEvaluationMorphismWithGivenRange := rec(
  filter_list := [ "category", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b", "r" ],
  output_source_getter_string := "b",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "ClosedMonoidalRightEvaluationMorphismWithGivenSource",
  dual_arguments_reversed := false,
),

CoclosedMonoidalRightCoevaluationMorphism := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b" ],
  output_source_getter_string := "InternalCoHomOnObjects( cat, TensorProductOnObjects( cat, a, b ), a )",
  output_source_getter_preconditions := [ [ "InternalCoHomOnObjects", 1 ], [ "TensorProductOnObjects", 1 ] ],
  output_range_getter_string := "b",
  output_range_getter_preconditions := [ ],
  with_given_object_position := "Source",
  dual_operation := "ClosedMonoidalRightCoevaluationMorphism",
  dual_arguments_reversed := false,
  # Test in CoclosedMonoidalCategoriesTest
),

CoclosedMonoidalRightCoevaluationMorphismWithGivenSource := rec(
  filter_list := [ "category", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b", "s" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "b",
  output_range_getter_preconditions := [ ],
  dual_operation := "ClosedMonoidalRightCoevaluationMorphismWithGivenRange",
  dual_arguments_reversed := false,
),

TensorProductToInternalCoHomRightAdjunctMorphism := rec(
  filter_list := [ "category", "object", "object", "morphism" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "b", "c", "g" ],
  output_source_getter_string := "InternalCoHomOnObjects( cat, Source( g ), b )",
  output_source_getter_preconditions := [ [ "InternalCoHomOnObjects", 1 ] ],
  output_range_getter_string := "c",
  output_range_getter_preconditions := [ ],
  with_given_object_position := "Source",
  dual_operation := "TensorProductToInternalHomRightAdjunctMorphism",
  dual_arguments_reversed := false,
  # Test in CoclosedMonoidalCategoriesTest
),

TensorProductToInternalCoHomRightAdjunctMorphismWithGivenInternalCoHom := rec(
  filter_list := [ "category", "object", "object", "morphism", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "b", "c", "g", "i" ],
  output_source_getter_string := "i",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "c",
  output_range_getter_preconditions := [ ],
  dual_operation := "TensorProductToInternalHomRightAdjunctMorphismWithGivenInternalHom",
  dual_arguments_reversed := false,
),

InternalCoHomToTensorProductRightAdjunctMorphism := rec(
  filter_list := [ "category", "object", "object", "morphism" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b", "f" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "TensorProductOnObjects( cat, b, Range( f ) )",
  output_range_getter_preconditions := [ [ "TensorProductOnObjects", 1 ] ],
  with_given_object_position := "Range",
  dual_operation := "InternalHomToTensorProductRightAdjunctMorphism",
  dual_preprocessor_func := { cat, a, b, f } -> NTuple( 4, Opposite( cat ), Opposite( b ), Opposite( a ), Opposite( f ) ),
  dual_arguments_reversed := false,
  # Test in CoclosedMonoidalCategoriesTest
),

InternalCoHomToTensorProductRightAdjunctMorphismWithGivenTensorProduct := rec(
  filter_list := [ "category", "object", "object", "morphism", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b", "f", "t" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "t",
  output_range_getter_preconditions := [ ],
  dual_operation := "InternalHomToTensorProductRightAdjunctMorphismWithGivenTensorProduct",
  dual_preprocessor_func := { cat, a, b, f, t } -> NTuple( 5, Opposite( cat ), Opposite( b ), Opposite( a ), Opposite( f ), Opposite( t ) ),
  dual_arguments_reversed := false,
  # Test in CoclosedMonoidalCategoriesTestWithGiven
),

CoclosedMonoidalLeftEvaluationMorphism := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b" ],
  output_source_getter_string := "b",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "TensorProductOnObjects( cat, InternalCoHomOnObjects( cat, b, a ), a )",
  output_range_getter_preconditions := [ [ "TensorProductOnObjects", 1 ], [ "InternalCoHomOnObjects", 1 ] ],
  with_given_object_position := "Range",
  dual_operation := "ClosedMonoidalLeftEvaluationMorphism",
  dual_arguments_reversed := false,
  # Test in CoclosedMonoidalCategoriesTest
),

CoclosedMonoidalLeftEvaluationMorphismWithGivenRange := rec(
  filter_list := [ "category", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b", "r" ],
  output_source_getter_string := "b",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "ClosedMonoidalLeftEvaluationMorphismWithGivenSource",
  dual_arguments_reversed := false,
),

CoclosedMonoidalLeftCoevaluationMorphism := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b" ],
  output_source_getter_string := "InternalCoHomOnObjects( cat, TensorProductOnObjects( cat, b, a ), a )",
  output_source_getter_preconditions := [ [ "InternalCoHomOnObjects", 1 ], [ "TensorProductOnObjects", 1 ] ],
  output_range_getter_string := "b",
  output_range_getter_preconditions := [ ],
  with_given_object_position := "Source",
  dual_operation := "ClosedMonoidalLeftCoevaluationMorphism",
  dual_arguments_reversed := false,
  # Test in CoclosedMonoidalCategoriesTest
),

CoclosedMonoidalLeftCoevaluationMorphismWithGivenSource := rec(
  filter_list := [ "category", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b", "s" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "b",
  output_range_getter_preconditions := [ ],
  dual_operation := "ClosedMonoidalLeftCoevaluationMorphismWithGivenRange",
  dual_arguments_reversed := false,
),

TensorProductToInternalCoHomLeftAdjunctMorphism := rec(
  filter_list := [ "category", "object", "object", "morphism" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "b", "c", "g" ],
  output_source_getter_string := "InternalCoHomOnObjects( cat, Source( g ), c )",
  output_source_getter_preconditions := [ [ "InternalCoHomOnObjects", 1 ] ],
  output_range_getter_string := "b",
  output_range_getter_preconditions := [ ],
  with_given_object_position := "Source",
  dual_operation := "TensorProductToInternalHomLeftAdjunctMorphism",
  dual_arguments_reversed := false,
  # Test in CoclosedMonoidalCategoriesTest
),

TensorProductToInternalCoHomLeftAdjunctMorphismWithGivenInternalCoHom := rec(
  filter_list := [ "category", "object", "object", "morphism", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "b", "c", "g", "i" ],
  output_source_getter_string := "i",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "b",
  output_range_getter_preconditions := [ ],
  dual_operation := "TensorProductToInternalHomLeftAdjunctMorphismWithGivenInternalHom",
  dual_arguments_reversed := false,
),

InternalCoHomToTensorProductLeftAdjunctMorphism := rec(
  filter_list := [ "category", "object", "object", "morphism" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "c", "f" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "TensorProductOnObjects( cat, Range( f ), c )",
  output_range_getter_preconditions := [ [ "TensorProductOnObjects", 1 ] ],
  with_given_object_position := "Range",
  dual_operation := "InternalHomToTensorProductLeftAdjunctMorphism",
  dual_preprocessor_func := { cat, a, c, f } -> NTuple( 4, Opposite( cat ), Opposite( c ), Opposite( a ), Opposite( f ) ),
  dual_arguments_reversed := false,
  # Test in CoclosedMonoidalCategoriesTest
),

InternalCoHomToTensorProductLeftAdjunctMorphismWithGivenTensorProduct := rec(
  filter_list := [ "category", "object", "object", "morphism", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "c", "f", "t" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "t",
  output_range_getter_preconditions := [ ],
  dual_operation := "InternalHomToTensorProductLeftAdjunctMorphismWithGivenTensorProduct",
  dual_preprocessor_func := { cat, a, c, f, t } -> NTuple( 5, Opposite( cat ), Opposite( c ), Opposite( a ), Opposite( f ), Opposite( t ) ),
  dual_arguments_reversed := false,
),

MonoidalPreCoComposeMorphism := rec(
  filter_list := [ "category", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b", "c" ],
  output_source_getter_string := "InternalCoHomOnObjects( cat, a, c )",
  output_source_getter_preconditions := [ [ "InternalCoHomOnObjects", 1 ] ],
  output_range_getter_string := "TensorProductOnObjects( cat, InternalCoHomOnObjects( cat, b, c ), InternalCoHomOnObjects( cat, a, b ) )",
  output_range_getter_preconditions := [ [ "TensorProductOnObjects", 1 ], [ "InternalCoHomOnObjects", 2 ] ],
  with_given_object_position := "both",
  dual_operation := "MonoidalPreComposeMorphism",
  dual_arguments_reversed := true,
  # Test in CoclosedMonoidalCategoriesTest
),

MonoidalPreCoComposeMorphismWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "a", "b", "c", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "MonoidalPreComposeMorphismWithGivenObjects",
  dual_arguments_reversed := true,
),

MonoidalPostCoComposeMorphism := rec(
  filter_list := [ "category", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b", "c" ],
  output_source_getter_string := "InternalCoHomOnObjects( cat, a, c )",
  output_source_getter_preconditions := [ [ "InternalCoHomOnObjects", 1 ] ],
  output_range_getter_string := "TensorProductOnObjects( cat, InternalCoHomOnObjects( cat, a, b ), InternalCoHomOnObjects( cat, b, c ) )",
  output_range_getter_preconditions := [ [ "TensorProductOnObjects", 1 ], [ "InternalCoHomOnObjects", 2 ] ],
  with_given_object_position := "both",
  dual_operation := "MonoidalPostComposeMorphism",
  dual_arguments_reversed := true,
  # Test in CoclosedMonoidalCategoriesTest
),

MonoidalPostCoComposeMorphismWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "a", "b", "c", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "MonoidalPostComposeMorphismWithGivenObjects",
  dual_arguments_reversed := true,
),

CoDualOnObjects := rec(
  filter_list := [ "category", "object" ],
  return_type := "object",
  input_arguments_names := [ "cat", "a" ],
  dual_operation := "DualOnObjects",
  # Test in CoclosedMonoidalCategoriesTest
),

CoDualOnMorphisms := rec(
  filter_list := [ "category", "morphism" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "alpha" ],
  output_source_getter_string := "CoDualOnObjects( cat, Range( alpha ) )",
  output_source_getter_preconditions := [ [ "CoDualOnObjects", 1 ] ],
  output_range_getter_string := "CoDualOnObjects( cat, Source( alpha ) )",
  output_range_getter_preconditions := [ [ "CoDualOnObjects", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "DualOnMorphisms",
  # Test in CoclosedMonoidalCategoriesTest
),

CoDualOnMorphismsWithGivenCoDuals := rec(
  filter_list := [ "category", "object", "morphism", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "alpha", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "DualOnMorphismsWithGivenDuals",
  dual_arguments_reversed := true,
),

CoclosedEvaluationForCoDual := rec(
  filter_list := [ "category", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a" ],
  output_source_getter_string := "TensorUnit( cat )",
  output_source_getter_preconditions := [ [ "TensorUnit", 1 ] ],
  output_range_getter_string := "TensorProductOnObjects( cat, CoDualOnObjects( cat, a ), a )",
  output_range_getter_preconditions := [ [ "TensorProductOnObjects", 1 ], [ "CoDualOnObjects", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "EvaluationForDual",
  # Test in CoclosedMonoidalCategoriesTest
),

CoclosedEvaluationForCoDualWithGivenTensorProduct := rec(
  filter_list := [ "category", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "a", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "EvaluationForDualWithGivenTensorProduct",
  dual_arguments_reversed := true,
),

MorphismFromCoBidual := rec(
  filter_list := [ "category", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a" ],
  output_range_getter_string := "a",
  output_range_getter_preconditions := [ ],
  output_source_getter_string := "CoDualOnObjects( cat, CoDualOnObjects( cat, a ) )",
  output_source_getter_preconditions := [ [ "CoDualOnObjects", 2 ] ],
  output_range_getter_string := "a",
  with_given_object_position := "Source",
  dual_operation := "MorphismToBidual",
  # Test in CoclosedMonoidalCategoriesTest
),

MorphismFromCoBidualWithGivenCoBidual := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "s" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "a",
  output_range_getter_preconditions := [ ],
  dual_operation := "MorphismToBidualWithGivenBidual",
  dual_arguments_reversed := false,
),

InternalCoHomTensorProductCompatibilityMorphism := rec(
  filter_list := [ "category", "list_of_objects" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "list" ],
  output_source_getter_string := "InternalCoHomOnObjects( cat, TensorProductOnObjects( cat, list[1], list[2] ), TensorProductOnObjects( cat, list[3], list[4] ) )",
  output_source_getter_preconditions := [ [ "InternalCoHomOnObjects", 1 ], [ "TensorProductOnObjects", 2 ] ],
  output_range_getter_string := "TensorProductOnObjects( cat, InternalCoHomOnObjects( cat, list[1], list[3] ), InternalCoHomOnObjects( cat, list[2], list[4] ) )",
  output_range_getter_preconditions := [ [ "TensorProductOnObjects", 1 ], [ "InternalCoHomOnObjects", 2 ] ],
  with_given_object_position := "both",
  dual_operation := "TensorProductInternalHomCompatibilityMorphism",
  dual_preprocessor_func := { cat, list } -> Pair( Opposite( cat ), [ Opposite( list[3] ), Opposite( list[1] ), Opposite( list[4] ), Opposite( list[2] ) ] ),
  dual_arguments_reversed := false,
  # Test in CoclosedMonoidalCategoriesTest
),

InternalCoHomTensorProductCompatibilityMorphismWithGivenObjects := rec(
  filter_list := [ "category", "object", "list_of_objects", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "source", "list", "range" ],
  output_source_getter_string := "source",
  output_range_getter_string := "range",
  dual_operation := "TensorProductInternalHomCompatibilityMorphismWithGivenObjects",
  dual_preprocessor_func :=
    { cat, s, list, r } -> NTuple( 4, Opposite( cat ), Opposite( r ), [ Opposite( list[3] ), Opposite( list[1] ), Opposite( list[4] ), Opposite( list[2] ) ], Opposite( s ) ),
  dual_arguments_reversed := false,
),

CoDualityTensorProductCompatibilityMorphism := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b" ],
  output_source_getter_string := "CoDualOnObjects( cat, TensorProductOnObjects( cat, a, b ) )",
  output_source_getter_preconditions := [ [ "CoDualOnObjects", 1 ], [ "TensorProductOnObjects", 1 ] ],
  output_range_getter_string := "TensorProductOnObjects( cat, CoDualOnObjects( cat, a ), CoDualOnObjects( cat, b ) )",
  output_range_getter_preconditions := [ [ "TensorProductOnObjects", 1 ], [ "CoDualOnObjects", 2 ] ],
  with_given_object_position := "both",
  dual_operation := "TensorProductDualityCompatibilityMorphism",
  dual_arguments_reversed := false,
  # Test in CoclosedMonoidalCategoriesTest
),

CoDualityTensorProductCompatibilityMorphismWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "a", "b", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "TensorProductDualityCompatibilityMorphismWithGivenObjects",
  dual_with_given_objects_reversed := true,
),

MorphismFromInternalCoHomToTensorProduct := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b" ],
  output_source_getter_string := "InternalCoHomOnObjects( cat, a, b )",
  output_source_getter_preconditions := [ [ "InternalCoHomOnObjects", 1 ] ],
  output_range_getter_string := "TensorProductOnObjects( cat, CoDualOnObjects( cat, b ), a )",
  output_range_getter_preconditions := [ [ "TensorProductOnObjects", 1 ], [ "CoDualOnObjects", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "MorphismFromTensorProductToInternalHom",
  dual_arguments_reversed := true,
  # Test in CoclosedMonoidalCategoriesTest
),

MorphismFromInternalCoHomToTensorProductWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "a", "b", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "MorphismFromTensorProductToInternalHomWithGivenObjects",
  dual_arguments_reversed := true,
),

IsomorphismFromCoDualObjectToInternalCoHomFromTensorUnit := rec(
  filter_list := [ "category", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a" ],
  output_source_getter_string := "CoDualOnObjects( cat, a )",
  output_source_getter_preconditions := [ [ "CoDualOnObjects", 1 ] ],
  output_range_getter_string := "InternalCoHomOnObjects( cat, TensorUnit( cat ), a )",
  output_range_getter_preconditions := [ [ "InternalCoHomOnObjects", 1 ], [ "TensorUnit", 1 ] ],
  dual_operation := "IsomorphismFromInternalHomIntoTensorUnitToDualObject",
  # Test in CoclosedMonoidalCategoriesTest
),

IsomorphismFromInternalCoHomFromTensorUnitToCoDualObject := rec(
  filter_list := [ "category", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a" ],
  output_source_getter_string := "InternalCoHomOnObjects( cat, TensorUnit( cat ), a )",
  output_source_getter_preconditions := [ [ "InternalCoHomOnObjects", 1 ], [ "TensorUnit", 1 ] ],
  output_range_getter_string := "CoDualOnObjects( cat, a )",
  output_range_getter_preconditions := [ [ "CoDualOnObjects", 1 ] ],
  dual_operation := "IsomorphismFromDualObjectToInternalHomIntoTensorUnit",
  # Test in CoclosedMonoidalCategoriesTest
),

UniversalPropertyOfCoDual := rec(
  filter_list := [ "category", "object", "object", "morphism" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "t", "a", "alpha" ],
  output_range_getter_string := "t",
  output_range_getter_preconditions := [ ],
  dual_operation := "UniversalPropertyOfDual",
  dual_arguments_reversed := false,
  # Test in CoclosedMonoidalCategoriesTest
),

CoLambdaIntroduction := rec(
  filter_list := [ "category", "morphism" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "alpha" ],
  dual_operation := "LambdaIntroduction",
  # Test in CoclosedMonoidalCategoriesTest
),

CoLambdaElimination := rec(
  filter_list := [ "category", "object", "object", "morphism" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b", "alpha" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "b",
  output_range_getter_preconditions := [ ],
  dual_operation := "LambdaElimination",
  dual_preprocessor_func := { cat, a, b, alpha } -> NTuple( 4, Opposite( cat ), Opposite( b ), Opposite( a ), Opposite( alpha ) ),
  dual_arguments_reversed := false,
  # Test in CoclosedMonoidalCategoriesTest
),

IsomorphismFromObjectToInternalCoHom := rec(
  filter_list := [ "category", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_source_getter_string := "a",
  output_range_getter_string := "InternalCoHomOnObjects( cat, a, TensorUnit( cat ) )",
  output_range_getter_preconditions := [ [ "InternalCoHomOnObjects", 1 ], [ "TensorUnit", 1 ] ],
  with_given_object_position := "Range",
  dual_operation := "IsomorphismFromInternalHomToObject",
  # Test in CoclosedMonoidalCategoriesTest
),

IsomorphismFromObjectToInternalCoHomWithGivenInternalCoHom := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "r" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "IsomorphismFromInternalHomToObjectWithGivenInternalHom",
  dual_arguments_reversed := false,
),

IsomorphismFromInternalCoHomToObject := rec(
  filter_list := [ "category", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a" ],
  output_range_getter_string := "a",
  output_range_getter_preconditions := [ ],
  output_source_getter_string := "InternalCoHomOnObjects( cat, a, TensorUnit( cat ) )",
  output_source_getter_preconditions := [ [ "InternalCoHomOnObjects", 1 ], [ "TensorUnit", 1 ] ],
  output_range_getter_string := "a",
  with_given_object_position := "Source",
  dual_operation := "IsomorphismFromObjectToInternalHom",
  # Test in CoclosedMonoidalCategoriesTest
),

IsomorphismFromInternalCoHomToObjectWithGivenInternalCoHom := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "s" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "a",
  output_range_getter_preconditions := [ ],
  dual_operation := "IsomorphismFromObjectToInternalHomWithGivenInternalHom",
  dual_arguments_reversed := false,
),

) );

# collect closed and coclosed operations
BindGlobal( "CLOSED_AND_COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD", rec( ) );

Perform( RecNames( CLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD ), function ( name )
    
    CLOSED_AND_COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD.(name) := CLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD.(name);
    
end );

Perform( RecNames( COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD ), function ( name )
    
    CLOSED_AND_COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD.(name) := COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD.(name);
    
end );

CAP_INTERNAL_ENHANCE_NAME_RECORD( CLOSED_AND_COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_GENERATE_DECLARATIONS_AND_INSTALLATIONS_FROM_METHOD_NAME_RECORD(
    CLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD,
    "MonoidalCategories",
    "ClosedMonoidalCategoriesMethodRecord", "Monoidal Categories",
    "Add-methods"
);

CAP_INTERNAL_GENERATE_DECLARATIONS_AND_INSTALLATIONS_FROM_METHOD_NAME_RECORD(
    COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD,
    "MonoidalCategories",
    "CoclosedMonoidalCategoriesMethodRecord", "Monoidal Categories",
    "Add-methods"
);

CAP_INTERNAL_REGISTER_METHOD_NAME_RECORD_OF_PACKAGE( CLOSED_AND_COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD, "MonoidalCategories" );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( CLOSED_AND_COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );
