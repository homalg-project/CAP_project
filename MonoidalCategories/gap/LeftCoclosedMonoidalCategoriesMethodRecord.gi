# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

InstallValue( LEFT_COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD, rec(

LeftInternalCoHomOnObjects := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "object",
  input_arguments_names := [ "cat", "a", "b" ],
  dual_operation := "LeftInternalHomOnObjects",
  dual_arguments_reversed := true,
  # Test in LeftCoclosedMonoidalCategoriesTest
),

LeftInternalCoHomOnMorphisms := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "alpha", "beta" ],
  output_source_getter_string := "LeftInternalCoHomOnObjects( cat, Source( alpha ), Range( beta ) )",
  output_source_getter_preconditions := [ [ "LeftInternalCoHomOnObjects", 1 ] ],
  output_range_getter_string := "LeftInternalCoHomOnObjects( cat, Range( alpha ), Source( beta ) )",
  output_range_getter_preconditions := [ [ "LeftInternalCoHomOnObjects", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "LeftInternalHomOnMorphisms",
  dual_arguments_reversed := true,
  # Test in LeftCoclosedMonoidalCategoriesTest
),

LeftInternalCoHomOnMorphismsWithGivenLeftInternalCoHoms := rec(
  filter_list := [ "category", "object", "morphism", "morphism", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "alpha", "beta", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "LeftInternalHomOnMorphismsWithGivenLeftInternalHoms",
  dual_arguments_reversed := true,
),

LeftCoclosedMonoidalEvaluationMorphism := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b" ],
  output_source_getter_string := "b",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "TensorProductOnObjects( cat, LeftInternalCoHomOnObjects( cat, b, a ), a )",
  output_range_getter_preconditions := [ [ "TensorProductOnObjects", 1 ], [ "LeftInternalCoHomOnObjects", 1 ] ],
  with_given_object_position := "Range",
  dual_operation := "LeftClosedMonoidalEvaluationMorphism",
  dual_arguments_reversed := false,
  # Test in LeftCoclosedMonoidalCategoriesTest
),

LeftCoclosedMonoidalEvaluationMorphismWithGivenRange := rec(
  filter_list := [ "category", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b", "r" ],
  output_source_getter_string := "b",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "LeftClosedMonoidalEvaluationMorphismWithGivenSource",
  dual_arguments_reversed := false,
),

LeftCoclosedMonoidalCoevaluationMorphism := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b" ],
  output_source_getter_string := "LeftInternalCoHomOnObjects( cat, TensorProductOnObjects( cat, b, a ), a )",
  output_source_getter_preconditions := [ [ "LeftInternalCoHomOnObjects", 1 ], [ "TensorProductOnObjects", 1 ] ],
  output_range_getter_string := "b",
  output_range_getter_preconditions := [ ],
  with_given_object_position := "Source",
  dual_operation := "LeftClosedMonoidalCoevaluationMorphism",
  dual_arguments_reversed := false,
  # Test in LeftCoclosedMonoidalCategoriesTest
),

LeftCoclosedMonoidalCoevaluationMorphismWithGivenSource := rec(
  filter_list := [ "category", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b", "s" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "b",
  output_range_getter_preconditions := [ ],
  dual_operation := "LeftClosedMonoidalCoevaluationMorphismWithGivenRange",
  dual_arguments_reversed := false,
),

TensorProductToLeftInternalCoHomAdjunctMorphism := rec(
  filter_list := [ "category", "object", "object", "morphism" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "b", "c", "g" ],
  output_source_getter_string := "LeftInternalCoHomOnObjects( cat, Source( g ), c )",
  output_source_getter_preconditions := [ [ "LeftInternalCoHomOnObjects", 1 ] ],
  output_range_getter_string := "b",
  output_range_getter_preconditions := [ ],
  with_given_object_position := "Source",
  dual_operation := "TensorProductToLeftInternalHomAdjunctMorphism",
  dual_arguments_reversed := false,
  # Test in LeftCoclosedMonoidalCategoriesTest
),

TensorProductToLeftInternalCoHomAdjunctMorphismWithGivenLeftInternalCoHom := rec(
  filter_list := [ "category", "object", "object", "morphism", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "b", "c", "g", "i" ],
  output_source_getter_string := "i",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "b",
  output_range_getter_preconditions := [ ],
  dual_operation := "TensorProductToLeftInternalHomAdjunctMorphismWithGivenLeftInternalHom",
  dual_arguments_reversed := false,
),

LeftInternalCoHomToTensorProductAdjunctMorphism := rec(
  filter_list := [ "category", "object", "object", "morphism" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "c", "f" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "TensorProductOnObjects( cat, Range( f ), c )",
  output_range_getter_preconditions := [ [ "TensorProductOnObjects", 1 ] ],
  with_given_object_position := "Range",
  dual_operation := "LeftInternalHomToTensorProductAdjunctMorphism",
  dual_preprocessor_func := { cat, a, c, f } -> NTuple( 4, Opposite( cat ), Opposite( c ), Opposite( a ), Opposite( f ) ),
  dual_arguments_reversed := false,
  # Test in LeftCoclosedMonoidalCategoriesTest
),

LeftInternalCoHomToTensorProductAdjunctMorphismWithGivenTensorProduct := rec(
  filter_list := [ "category", "object", "object", "morphism", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "c", "f", "t" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "t",
  output_range_getter_preconditions := [ ],
  dual_operation := "LeftInternalHomToTensorProductAdjunctMorphismWithGivenTensorProduct",
  dual_preprocessor_func := { cat, a, c, f, t } -> NTuple( 5, Opposite( cat ), Opposite( c ), Opposite( a ), Opposite( f ), Opposite( t ) ),
  dual_arguments_reversed := false,
  # Test in LeftCoclosedMonoidalCategoriesTestWithGiven
),

LeftCoclosedMonoidalPreCoComposeMorphism := rec(
  filter_list := [ "category", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b", "c" ],
  output_source_getter_string := "LeftInternalCoHomOnObjects( cat, a, c )",
  output_source_getter_preconditions := [ [ "LeftInternalCoHomOnObjects", 1 ] ],
  output_range_getter_string := "TensorProductOnObjects( cat, LeftInternalCoHomOnObjects( cat, b, c ), LeftInternalCoHomOnObjects( cat, a, b ) )",
  output_range_getter_preconditions := [ [ "TensorProductOnObjects", 1 ], [ "LeftInternalCoHomOnObjects", 2 ] ],
  with_given_object_position := "both",
  dual_operation := "LeftClosedMonoidalPreComposeMorphism",
  dual_arguments_reversed := true,
  # Test in LeftCoclosedMonoidalCategoriesTest
),

LeftCoclosedMonoidalPreCoComposeMorphismWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "a", "b", "c", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "LeftClosedMonoidalPreComposeMorphismWithGivenObjects",
  dual_arguments_reversed := true,
),

LeftCoclosedMonoidalPostCoComposeMorphism := rec(
  filter_list := [ "category", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b", "c" ],
  output_source_getter_string := "LeftInternalCoHomOnObjects( cat, a, c )",
  output_source_getter_preconditions := [ [ "LeftInternalCoHomOnObjects", 1 ] ],
  output_range_getter_string := "TensorProductOnObjects( cat, LeftInternalCoHomOnObjects( cat, a, b ), LeftInternalCoHomOnObjects( cat, b, c ) )",
  output_range_getter_preconditions := [ [ "TensorProductOnObjects", 1 ], [ "LeftInternalCoHomOnObjects", 2 ] ],
  with_given_object_position := "both",
  dual_operation := "LeftClosedMonoidalPostComposeMorphism",
  dual_arguments_reversed := true,
  # Test in LeftCoclosedMonoidalCategoriesTest
),

LeftCoclosedMonoidalPostCoComposeMorphismWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "a", "b", "c", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "LeftClosedMonoidalPostComposeMorphismWithGivenObjects",
  dual_arguments_reversed := true,
),

LeftCoDualOnObjects := rec(
  filter_list := [ "category", "object" ],
  return_type := "object",
  input_arguments_names := [ "cat", "a" ],
  dual_operation := "LeftDualOnObjects",
  # Test in LeftCoclosedMonoidalCategoriesTest
),

LeftCoDualOnMorphisms := rec(
  filter_list := [ "category", "morphism" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "alpha" ],
  output_source_getter_string := "LeftCoDualOnObjects( cat, Range( alpha ) )",
  output_source_getter_preconditions := [ [ "LeftCoDualOnObjects", 1 ] ],
  output_range_getter_string := "LeftCoDualOnObjects( cat, Source( alpha ) )",
  output_range_getter_preconditions := [ [ "LeftCoDualOnObjects", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "LeftDualOnMorphisms",
  # Test in LeftCoclosedMonoidalCategoriesTest
),

LeftCoDualOnMorphismsWithGivenLeftCoDuals := rec(
  filter_list := [ "category", "object", "morphism", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "alpha", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "LeftDualOnMorphismsWithGivenLeftDuals",
  dual_arguments_reversed := true,
),

LeftCoclosedMonoidalEvaluationForLeftCoDual := rec(
  filter_list := [ "category", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a" ],
  output_source_getter_string := "TensorUnit( cat )",
  output_source_getter_preconditions := [ [ "TensorUnit", 1 ] ],
  output_range_getter_string := "TensorProductOnObjects( cat, LeftCoDualOnObjects( cat, a ), a )",
  output_range_getter_preconditions := [ [ "TensorProductOnObjects", 1 ], [ "LeftCoDualOnObjects", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "LeftClosedMonoidalEvaluationForLeftDual",
  # Test in LeftCoclosedMonoidalCategoriesTest
),

LeftCoclosedMonoidalEvaluationForLeftCoDualWithGivenTensorProduct := rec(
  filter_list := [ "category", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "a", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "LeftClosedMonoidalEvaluationForLeftDualWithGivenTensorProduct",
  dual_arguments_reversed := true,
),

MorphismFromLeftCoBidual := rec(
  filter_list := [ "category", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a" ],
  output_range_getter_string := "a",
  output_range_getter_preconditions := [ ],
  output_source_getter_string := "LeftCoDualOnObjects( cat, LeftCoDualOnObjects( cat, a ) )",
  output_source_getter_preconditions := [ [ "LeftCoDualOnObjects", 2 ] ],
  output_range_getter_string := "a",
  with_given_object_position := "Source",
  dual_operation := "MorphismToLeftBidual",
  # Test in LeftCoclosedMonoidalCategoriesTest
),

MorphismFromLeftCoBidualWithGivenLeftCoBidual := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "s" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "a",
  output_range_getter_preconditions := [ ],
  dual_operation := "MorphismToLeftBidualWithGivenLeftBidual",
  dual_arguments_reversed := false,
),

LeftInternalCoHomTensorProductCompatibilityMorphism := rec(
  filter_list := [ "category", "list_of_objects" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "list" ],
  output_source_getter_string := "LeftInternalCoHomOnObjects( cat, TensorProductOnObjects( cat, list[1], list[2] ), TensorProductOnObjects( cat, list[3], list[4] ) )",
  output_source_getter_preconditions := [ [ "LeftInternalCoHomOnObjects", 1 ], [ "TensorProductOnObjects", 2 ] ],
  output_range_getter_string := "TensorProductOnObjects( cat, LeftInternalCoHomOnObjects( cat, list[1], list[3] ), LeftInternalCoHomOnObjects( cat, list[2], list[4] ) )",
  output_range_getter_preconditions := [ [ "TensorProductOnObjects", 1 ], [ "LeftInternalCoHomOnObjects", 2 ] ],
  with_given_object_position := "both",
  dual_operation := "TensorProductLeftInternalHomCompatibilityMorphism",
  dual_preprocessor_func := { cat, list } -> Pair( Opposite( cat ), [ Opposite( list[3] ), Opposite( list[1] ), Opposite( list[4] ), Opposite( list[2] ) ] ),
  dual_arguments_reversed := false,
  # Test in LeftCoclosedMonoidalCategoriesTest
),

LeftInternalCoHomTensorProductCompatibilityMorphismWithGivenObjects := rec(
  filter_list := [ "category", "object", "list_of_objects", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "source", "list", "range" ],
  output_source_getter_string := "source",
  output_range_getter_string := "range",
  dual_operation := "TensorProductLeftInternalHomCompatibilityMorphismWithGivenObjects",
  dual_preprocessor_func :=
    { cat, s, list, r } -> NTuple( 4, Opposite( cat ), Opposite( r ), [ Opposite( list[3] ), Opposite( list[1] ), Opposite( list[4] ), Opposite( list[2] ) ], Opposite( s ) ),
  dual_arguments_reversed := false,
),

LeftCoDualityTensorProductCompatibilityMorphism := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b" ],
  output_source_getter_string := "LeftCoDualOnObjects( cat, TensorProductOnObjects( cat, a, b ) )",
  output_source_getter_preconditions := [ [ "LeftCoDualOnObjects", 1 ], [ "TensorProductOnObjects", 1 ] ],
  output_range_getter_string := "TensorProductOnObjects( cat, LeftCoDualOnObjects( cat, a ), LeftCoDualOnObjects( cat, b ) )",
  output_range_getter_preconditions := [ [ "TensorProductOnObjects", 1 ], [ "LeftCoDualOnObjects", 2 ] ],
  with_given_object_position := "both",
  dual_operation := "TensorProductLeftDualityCompatibilityMorphism",
  dual_arguments_reversed := false,
  # Test in LeftCoclosedMonoidalCategoriesTest
),

LeftCoDualityTensorProductCompatibilityMorphismWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "a", "b", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "TensorProductLeftDualityCompatibilityMorphismWithGivenObjects",
  dual_with_given_objects_reversed := true,
),

MorphismFromLeftInternalCoHomToTensorProduct := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b" ],
  output_source_getter_string := "LeftInternalCoHomOnObjects( cat, a, b )",
  output_source_getter_preconditions := [ [ "LeftInternalCoHomOnObjects", 1 ] ],
  output_range_getter_string := "TensorProductOnObjects( cat, LeftCoDualOnObjects( cat, b ), a )",
  output_range_getter_preconditions := [ [ "TensorProductOnObjects", 1 ], [ "LeftCoDualOnObjects", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "MorphismFromTensorProductToLeftInternalHom",
  dual_arguments_reversed := true,
  # Test in LeftCoclosedMonoidalCategoriesTest
),

MorphismFromLeftInternalCoHomToTensorProductWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "a", "b", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "MorphismFromTensorProductToLeftInternalHomWithGivenObjects",
  dual_arguments_reversed := true,
),

IsomorphismFromLeftCoDualObjectToLeftInternalCoHomFromTensorUnit := rec(
  filter_list := [ "category", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a" ],
  output_source_getter_string := "LeftCoDualOnObjects( cat, a )",
  output_source_getter_preconditions := [ [ "LeftCoDualOnObjects", 1 ] ],
  output_range_getter_string := "LeftInternalCoHomOnObjects( cat, TensorUnit( cat ), a )",
  output_range_getter_preconditions := [ [ "LeftInternalCoHomOnObjects", 1 ], [ "TensorUnit", 1 ] ],
  dual_operation := "IsomorphismFromLeftInternalHomIntoTensorUnitToLeftDualObject",
  # Test in LeftCoclosedMonoidalCategoriesTest
),

IsomorphismFromLeftInternalCoHomFromTensorUnitToLeftCoDualObject := rec(
  filter_list := [ "category", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a" ],
  output_source_getter_string := "LeftInternalCoHomOnObjects( cat, TensorUnit( cat ), a )",
  output_source_getter_preconditions := [ [ "LeftInternalCoHomOnObjects", 1 ], [ "TensorUnit", 1 ] ],
  output_range_getter_string := "LeftCoDualOnObjects( cat, a )",
  output_range_getter_preconditions := [ [ "LeftCoDualOnObjects", 1 ] ],
  dual_operation := "IsomorphismFromLeftDualObjectToLeftInternalHomIntoTensorUnit",
  # Test in LeftCoclosedMonoidalCategoriesTest
),

UniversalPropertyOfLeftCoDual := rec(
  filter_list := [ "category", "object", "object", "morphism" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "t", "a", "alpha" ],
  output_range_getter_string := "t",
  output_range_getter_preconditions := [ ],
  dual_operation := "UniversalPropertyOfLeftDual",
  dual_arguments_reversed := false,
  # Test in LeftCoclosedMonoidalCategoriesTest
),

LeftCoclosedMonoidalLambdaIntroduction := rec(
  filter_list := [ "category", "morphism" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "alpha" ],
  dual_operation := "LeftClosedMonoidalLambdaIntroduction",
  # Test in LeftCoclosedMonoidalCategoriesTest
),

LeftCoclosedMonoidalLambdaElimination := rec(
  filter_list := [ "category", "object", "object", "morphism" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b", "alpha" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "b",
  output_range_getter_preconditions := [ ],
  dual_operation := "LeftClosedMonoidalLambdaElimination",
  dual_preprocessor_func := { cat, a, b, alpha } -> NTuple( 4, Opposite( cat ), Opposite( b ), Opposite( a ), Opposite( alpha ) ),
  dual_arguments_reversed := false,
  # Test in LeftCoclosedMonoidalCategoriesTest
),

IsomorphismFromObjectToLeftInternalCoHom := rec(
  filter_list := [ "category", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_source_getter_string := "a",
  output_range_getter_string := "LeftInternalCoHomOnObjects( cat, a, TensorUnit( cat ) )",
  output_range_getter_preconditions := [ [ "LeftInternalCoHomOnObjects", 1 ], [ "TensorUnit", 1 ] ],
  with_given_object_position := "Range",
  dual_operation := "IsomorphismFromLeftInternalHomToObject",
  # Test in LeftCoclosedMonoidalCategoriesTest
),

IsomorphismFromObjectToLeftInternalCoHomWithGivenLeftInternalCoHom := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "r" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "IsomorphismFromLeftInternalHomToObjectWithGivenLeftInternalHom",
  dual_arguments_reversed := false,
),

IsomorphismFromLeftInternalCoHomToObject := rec(
  filter_list := [ "category", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a" ],
  output_range_getter_string := "a",
  output_range_getter_preconditions := [ ],
  output_source_getter_string := "LeftInternalCoHomOnObjects( cat, a, TensorUnit( cat ) )",
  output_source_getter_preconditions := [ [ "LeftInternalCoHomOnObjects", 1 ], [ "TensorUnit", 1 ] ],
  output_range_getter_string := "a",
  with_given_object_position := "Source",
  dual_operation := "IsomorphismFromObjectToLeftInternalHom",
  # Test in LeftCoclosedMonoidalCategoriesTest
),

IsomorphismFromLeftInternalCoHomToObjectWithGivenLeftInternalCoHom := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "s" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "a",
  output_range_getter_preconditions := [ ],
  dual_operation := "IsomorphismFromObjectToLeftInternalHomWithGivenLeftInternalHom",
  dual_arguments_reversed := false,
),

) );

# collect closed and coclosed operations
BindGlobal( "LEFT_CLOSED_AND_LEFT_COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD", rec( ) );

Perform( RecNames( LEFT_CLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD ), function ( name )
    
    LEFT_CLOSED_AND_LEFT_COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD.(name) := LEFT_CLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD.(name);
    
end );

Perform( RecNames( LEFT_COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD ), function ( name )
    
    LEFT_CLOSED_AND_LEFT_COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD.(name) := LEFT_COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD.(name);
    
end );

CAP_INTERNAL_ENHANCE_NAME_RECORD( LEFT_CLOSED_AND_LEFT_COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_GENERATE_DECLARATIONS_AND_INSTALLATIONS_FROM_METHOD_NAME_RECORD(
    LEFT_CLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD,
    "MonoidalCategories",
    "LeftClosedMonoidalCategoriesMethodRecord", "Monoidal Categories",
    "Add-methods"
);

CAP_INTERNAL_GENERATE_DECLARATIONS_AND_INSTALLATIONS_FROM_METHOD_NAME_RECORD(
    LEFT_COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD,
    "MonoidalCategories",
    "LeftCoclosedMonoidalCategoriesMethodRecord", "Monoidal Categories",
    "Add-methods"
);

CAP_INTERNAL_REGISTER_METHOD_NAME_RECORD_OF_PACKAGE( LEFT_CLOSED_AND_LEFT_COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD, "MonoidalCategories" );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( LEFT_CLOSED_AND_LEFT_COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );
