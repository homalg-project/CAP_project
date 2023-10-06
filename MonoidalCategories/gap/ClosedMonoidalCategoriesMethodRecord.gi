# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

InstallValue( CLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD, rec(

InternalHomOnObjects := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "object",
  input_arguments_names := [ "cat", "a", "b" ],
  dual_operation := "InternalCoHomOnObjects",
  dual_arguments_reversed := true,
  # Test in ClosedMonoidalCategoriesTest
),

InternalHomOnMorphisms := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "alpha", "beta" ],
  output_source_getter_string := "InternalHomOnObjects( cat, Range( alpha ), Source( beta ) )",
  output_source_getter_preconditions := [ [ "InternalHomOnObjects", 1 ] ],
  output_range_getter_string := "InternalHomOnObjects( cat, Source( alpha ), Range( beta ) )",
  output_range_getter_preconditions := [ [ "InternalHomOnObjects", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "InternalCoHomOnMorphisms",
  dual_arguments_reversed := true,
  # Test in ClosedMonoidalCategoriesTest
),

InternalHomOnMorphismsWithGivenInternalHoms := rec(
  filter_list := [ "category", "object", "morphism", "morphism", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "alpha", "beta", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "InternalCoHomOnMorphismsWithGivenInternalCoHoms",
  dual_arguments_reversed := true,
),

EvaluationMorphism := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b" ],
  output_range_getter_string := "b",
  output_range_getter_preconditions := [ ],
  output_source_getter_string := "TensorProductOnObjects( cat, InternalHomOnObjects( cat, a, b ), a )",
  output_source_getter_preconditions := [ [ "TensorProductOnObjects", 1 ], [ "InternalHomOnObjects", 1 ] ],
  output_range_getter_string := "b",
  with_given_object_position := "Source",
  dual_operation := "CoclosedEvaluationMorphism",
  dual_arguments_reversed := true,
  # Test in ClosedMonoidalCategoriesTest
),

EvaluationMorphismWithGivenSource := rec(
  filter_list := [ "category", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b", "s" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "b",
  output_range_getter_preconditions := [ ],
  dual_operation := "CoclosedEvaluationMorphismWithGivenRange",
  dual_preprocessor_func := { cat, a, b, s } -> NTuple( 4, Opposite( cat ), Opposite( b ), Opposite( a ), Opposite( s ) ),
  dual_arguments_reversed := false,
),

CoevaluationMorphism := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_source_getter_string := "a",
  output_range_getter_string := "InternalHomOnObjects( cat, b, TensorProductOnObjects( cat, a, b ) )",
  output_range_getter_preconditions := [ [ "InternalHomOnObjects", 1 ], [ "TensorProductOnObjects", 1 ] ],
  with_given_object_position := "Range",
  dual_operation := "CoclosedCoevaluationMorphism",
  dual_arguments_reversed := false,
  # Test in ClosedMonoidalCategoriesTest
),

CoevaluationMorphismWithGivenRange := rec(
  filter_list := [ "category", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b", "r" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "CoclosedCoevaluationMorphismWithGivenSource",
  dual_arguments_reversed := false,
),

TensorProductToInternalHomAdjunctionMap := rec(
  filter_list := [ "category", "object", "object", "morphism" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b", "f" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "InternalHomOnObjects( cat, b, Range( f ) )",
  output_range_getter_preconditions := [ [ "InternalHomOnObjects", 1 ] ],
  with_given_object_position := "Range",
  dual_operation := "TensorProductToInternalCoHomAdjunctionMap",
  dual_arguments_reversed := false,
  # Test in ClosedMonoidalCategoriesTest
),

TensorProductToInternalHomAdjunctionMapWithGivenInternalHom := rec(
  filter_list := [ "category", "object", "object", "morphism", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b", "f", "i" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "i",
  output_range_getter_preconditions := [ ],
  dual_operation := "TensorProductToInternalCoHomAdjunctionMapWithGivenInternalCoHom",
  dual_arguments_reversed := false,
),

InternalHomToTensorProductAdjunctionMap := rec(
  filter_list := [ "category", "object", "object", "morphism" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "b", "c", "g" ],
  output_source_getter_string := "TensorProductOnObjects( cat, Source( g ), b )",
  output_source_getter_preconditions := [ [ "TensorProductOnObjects", 1 ] ],
  output_range_getter_string := "c",
  output_range_getter_preconditions := [ ],
  with_given_object_position := "Source",
  dual_operation := "InternalCoHomToTensorProductAdjunctionMap",
  dual_preprocessor_func := { cat, a, b, g } -> NTuple( 4, Opposite( cat ), Opposite( b ), Opposite( a ), Opposite( g ) ),
  dual_arguments_reversed := false,
  # Test in ClosedMonoidalCategoriesTest
),

InternalHomToTensorProductAdjunctionMapWithGivenTensorProduct := rec(
  filter_list := [ "category", "object", "object", "morphism", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "b", "c", "g", "t" ],
  output_source_getter_string := "t",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "c",
  output_range_getter_preconditions := [ ],
  dual_operation := "InternalCoHomToTensorProductAdjunctionMapWithGivenTensorProduct",
  dual_preprocessor_func := { cat, a, b, g, t } -> NTuple( 4, Opposite( cat ), Opposite( b ), Opposite( a ), Opposite( g ),Opposite( t ) ),
  dual_arguments_reversed := false,
),

MonoidalPreComposeMorphism := rec(
  filter_list := [ "category", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b", "c" ],
  output_source_getter_string := "TensorProductOnObjects( cat, InternalHomOnObjects( cat, a, b ), InternalHomOnObjects( cat, b, c ) )",
  output_source_getter_preconditions := [ [ "TensorProductOnObjects", 1 ], [ "InternalHomOnObjects", 2 ] ],
  output_range_getter_string := "InternalHomOnObjects( cat, a, c )",
  output_range_getter_preconditions := [ [ "InternalHomOnObjects", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "MonoidalPreCoComposeMorphism",
  dual_arguments_reversed := true,
  # Test in ClosedMonoidalCategoriesTest
),

MonoidalPreComposeMorphismWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "a", "b", "c", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "MonoidalPreCoComposeMorphismWithGivenObjects",
  dual_arguments_reversed := true,
),

MonoidalPostComposeMorphism := rec(
  filter_list := [ "category", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b", "c" ],
  output_source_getter_string := "TensorProductOnObjects( cat, InternalHomOnObjects( cat, b, c ), InternalHomOnObjects( cat, a, b ) )",
  output_source_getter_preconditions := [ [ "TensorProductOnObjects", 1 ], [ "InternalHomOnObjects", 2 ] ],
  output_range_getter_string := "InternalHomOnObjects( cat, a, c )",
  output_range_getter_preconditions := [ [ "InternalHomOnObjects", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "MonoidalPostCoComposeMorphism",
  dual_arguments_reversed := true,
  # Test in ClosedMonoidalCategoriesTest
),

MonoidalPostComposeMorphismWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "a", "b", "c", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "MonoidalPostCoComposeMorphismWithGivenObjects",
  dual_arguments_reversed := true,
),

DualOnObjects := rec(
  filter_list := [ "category", "object" ],
  return_type := "object",
  input_arguments_names := [ "cat", "a" ],
  dual_operation := "CoDualOnObjects",
  # Test in ClosedMonoidalCategoriesTest
),

DualOnMorphisms := rec(
  filter_list := [ "category", "morphism" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "alpha" ],
  output_source_getter_string := "DualOnObjects( cat, Range( alpha ) )",
  output_source_getter_preconditions := [ [ "DualOnObjects", 1 ] ],
  output_range_getter_string := "DualOnObjects( cat, Source( alpha ) )",
  output_range_getter_preconditions := [ [ "DualOnObjects", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "CoDualOnMorphisms",
  # Test in ClosedMonoidalCategoriesTest
),

DualOnMorphismsWithGivenDuals := rec(
  filter_list := [ "category", "object", "morphism", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "alpha", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "CoDualOnMorphismsWithGivenCoDuals",
  dual_arguments_reversed := true,
),

EvaluationForDual := rec(
  filter_list := [ "category", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a" ],
  output_source_getter_string := "TensorProductOnObjects( cat, DualOnObjects( cat, a ), a )",
  output_source_getter_preconditions := [ [ "TensorProductOnObjects", 1 ], [ "DualOnObjects", 1 ] ],
  output_range_getter_string := "TensorUnit( cat )",
  output_range_getter_preconditions := [ [ "TensorUnit", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "CoclosedEvaluationForCoDual",
  # Test in ClosedMonoidalCategoriesTest
),

EvaluationForDualWithGivenTensorProduct := rec(
  filter_list := [ "category", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "a", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "CoclosedEvaluationForCoDualWithGivenTensorProduct",
  dual_arguments_reversed := true,
),

MorphismToBidual := rec(
  filter_list := [ "category", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_source_getter_string := "a",
  output_range_getter_string := "DualOnObjects( cat, DualOnObjects( cat, a ) )",
  output_range_getter_preconditions := [ [ "DualOnObjects", 2 ] ],
  with_given_object_position := "Range",
  dual_operation := "MorphismFromCoBidual",
  # Test in ClosedMonoidalCategoriesTest
),

MorphismToBidualWithGivenBidual := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "r" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "MorphismFromCoBidualWithGivenCoBidual",
  dual_arguments_reversed := false,
),

TensorProductInternalHomCompatibilityMorphism := rec(
  filter_list := [ "category", "list_of_objects" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "list" ],
  output_source_getter_string := "TensorProductOnObjects( cat, InternalHomOnObjects( cat, list[1], list[2] ), InternalHomOnObjects( cat, list[3], list[4] ) )",
  output_source_getter_preconditions := [ [ "TensorProductOnObjects", 1 ], [ "InternalHomOnObjects", 2 ] ],
  output_range_getter_string := "InternalHomOnObjects( cat, TensorProductOnObjects( cat, list[1], list[3] ), TensorProductOnObjects( cat, list[2], list[4] ) )",
  output_range_getter_preconditions := [ [ "InternalHomOnObjects", 1 ], [ "TensorProductOnObjects", 2 ] ],
  with_given_object_position := "both",
  dual_operation := "InternalCoHomTensorProductCompatibilityMorphism",
  dual_preprocessor_func := { cat, list } -> Pair( Opposite( cat ), [ Opposite( list[2] ), Opposite( list[4] ), Opposite( list[1] ), Opposite( list[3] ) ] ),
  dual_arguments_reversed := false,
  # Test in ClosedMonoidalCategoriesTest
),

TensorProductInternalHomCompatibilityMorphismWithGivenObjects := rec(
  filter_list := [ "category", "object", "list_of_objects", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "source", "list", "range" ],
  output_source_getter_string := "source",
  output_range_getter_string := "range",
  dual_operation := "InternalCoHomTensorProductCompatibilityMorphismWithGivenObjects",
  dual_preprocessor_func :=
    { cat, s, list, r } -> NTuple( 4, Opposite( cat ), Opposite( r ), [ Opposite( list[2] ), Opposite( list[4] ), Opposite( list[1] ), Opposite( list[3] ) ], Opposite( s ) ),
  dual_arguments_reversed := false,
),

TensorProductDualityCompatibilityMorphism := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b" ],
  output_source_getter_string := "TensorProductOnObjects( cat, DualOnObjects( cat, a ), DualOnObjects( cat, b ) )",
  output_source_getter_preconditions := [ [ "TensorProductOnObjects", 1 ], [ "DualOnObjects", 2 ] ],
  output_range_getter_string := "DualOnObjects( cat, TensorProductOnObjects( cat, a, b ) )",
  output_range_getter_preconditions := [ [ "DualOnObjects", 1 ], [ "TensorProductOnObjects", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "CoDualityTensorProductCompatibilityMorphism",
  dual_arguments_reversed := false,
  # Test in ClosedMonoidalCategoriesTest
),

TensorProductDualityCompatibilityMorphismWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "a", "b", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "CoDualityTensorProductCompatibilityMorphismWithGivenObjects",
  dual_with_given_objects_reversed := true,
),

MorphismFromTensorProductToInternalHom := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b" ],
  output_source_getter_string := "TensorProductOnObjects( cat, DualOnObjects( cat, a ), b )",
  output_source_getter_preconditions := [ [ "TensorProductOnObjects", 1 ], [ "DualOnObjects", 1 ] ],
  output_range_getter_string := "InternalHomOnObjects( cat, a, b )",
  output_range_getter_preconditions := [ [ "InternalHomOnObjects", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "MorphismFromInternalCoHomToTensorProduct",
  dual_arguments_reversed := true,
  # Test in ClosedMonoidalCategoriesTest
),

MorphismFromTensorProductToInternalHomWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "a", "b", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "MorphismFromInternalCoHomToTensorProductWithGivenObjects",
  dual_arguments_reversed := true,
),

IsomorphismFromInternalHomIntoTensorUnitToDualObject := rec(
  filter_list := [ "category", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a" ],
  output_source_getter_string := "InternalHomOnObjects( cat, a, TensorUnit( cat ) )",
  output_source_getter_preconditions := [ [ "InternalHomOnObjects", 1 ], [ "TensorUnit", 1 ] ],
  output_range_getter_string := "DualOnObjects( cat, a )",
  output_range_getter_preconditions := [ [ "DualOnObjects", 1 ] ],
  dual_operation := "IsomorphismFromCoDualObjectToInternalCoHomFromTensorUnit",
  # Test in ClosedMonoidalCategoriesTest
),

IsomorphismFromDualObjectToInternalHomIntoTensorUnit := rec(
  filter_list := [ "category", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a" ],
  output_source_getter_string := "DualOnObjects( cat, a )",
  output_source_getter_preconditions := [ [ "DualOnObjects", 1 ] ],
  output_range_getter_string := "InternalHomOnObjects( cat, a, TensorUnit( cat ) )",
  output_range_getter_preconditions := [ [ "InternalHomOnObjects", 1 ], [ "TensorUnit", 1 ] ],
  dual_operation := "IsomorphismFromInternalCoHomFromTensorUnitToCoDualObject",
  # Test in ClosedMonoidalCategoriesTest
),

UniversalPropertyOfDual := rec(
  filter_list := [ "category", "object", "object", "morphism" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "t", "a", "alpha" ],
  output_source_getter_string := "t",
  output_source_getter_preconditions := [ ],
  dual_operation := "UniversalPropertyOfCoDual",
  dual_arguments_reversed := false,
  # Test in ClosedMonoidalCategoriesTest
),

UniversalPropertyOfDualWithGivenDualObject:= rec(
  filter_list := [ "category", "object", "object", "morphism", "object" ],
  input_arguments_names := [ "cat", "t", "a", "alpha", "d" ],
  output_source_getter_string := "t",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "d",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "UniversalPropertyOfCoDualWithGivenCoDualObject",
  dual_arguments_reversed := false,
),

LambdaIntroduction := rec(
  filter_list := [ "category", "morphism" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "alpha" ],
  dual_operation := "CoLambdaIntroduction",
  # Test in ClosedMonoidalCategoriesTest
),

LambdaElimination := rec(
  filter_list := [ "category", "object", "object", "morphism" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b", "alpha" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "b",
  output_range_getter_preconditions := [ ],
  dual_operation := "CoLambdaElimination",
  dual_preprocessor_func := { cat, a, b, alpha } -> NTuple( 4, Opposite( cat ), Opposite( b ), Opposite( a ), Opposite( alpha ) ),
  dual_arguments_reversed := false,
  # Test in ClosedMonoidalCategoriesTest
),

IsomorphismFromObjectToInternalHom := rec(
  filter_list := [ "category", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_source_getter_string := "a",
  output_range_getter_string := "InternalHomOnObjects( cat, TensorUnit( cat ), a )",
  output_range_getter_preconditions := [ [ "InternalHomOnObjects", 1 ], [ "TensorUnit", 1 ] ],
  with_given_object_position := "Range",
  dual_operation := "IsomorphismFromInternalCoHomToObject",
  # Test in ClosedMonoidalCategoriesTest
),

IsomorphismFromObjectToInternalHomWithGivenInternalHom := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "r" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "IsomorphismFromInternalCoHomToObjectWithGivenInternalCoHom",
  dual_arguments_reversed := false,
),

IsomorphismFromInternalHomToObject := rec(
  filter_list := [ "category", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a" ],
  output_range_getter_string := "a",
  output_range_getter_preconditions := [ ],
  output_source_getter_string := "InternalHomOnObjects( cat, TensorUnit( cat ), a )",
  output_source_getter_preconditions := [ [ "InternalHomOnObjects", 1 ], [ "TensorUnit", 1 ] ],
  output_range_getter_string := "a",
  with_given_object_position := "Source",
  dual_operation := "IsomorphismFromObjectToInternalCoHom",
  # Test in ClosedMonoidalCategoriesTest
),

IsomorphismFromInternalHomToObjectWithGivenInternalHom := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "s" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "a",
  output_range_getter_preconditions := [ ],
  dual_operation := "IsomorphismFromObjectToInternalCoHomWithGivenInternalCoHom",
  dual_arguments_reversed := false,
),

) );
