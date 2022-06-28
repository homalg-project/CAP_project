# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

InstallValue( COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD, rec(

InternalCoHomOnObjects := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "b" ], [ "i" ] ],
  return_type := "object",
  dual_operation := "InternalHomOnObjects",
  dual_arguments_reversed := true,
  # Test in CoclosedMonoidalCategoriesTest
),

InternalCoHomOnMorphisms := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  io_type := [ [ "alpha", "beta" ], [ "s", "r" ] ],
  output_source_getter_string := "InternalCoHomOnObjects( cat, Source( alpha ), Range( beta ) )",
  output_range_getter_string := "InternalCoHomOnObjects( cat, Range( alpha ), Source( beta ) )",
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "InternalHomOnMorphisms",
  dual_arguments_reversed := true,
  # Test in CoclosedMonoidalCategoriesTest
),

InternalCoHomOnMorphismsWithGivenInternalCoHoms := rec(
  filter_list := [ "category", "object", "morphism", "morphism", "object" ],
  io_type := [ [ "s", "alpha", "beta", "r" ], [ "s", "r" ] ],
  return_type := "morphism",
  dual_operation := "InternalHomOnMorphismsWithGivenInternalHoms",
  dual_arguments_reversed := true,
  # Test in CoclosedMonoidalCategoriesTest
),

CoclosedEvaluationMorphism := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "b" ], [ "a", "r" ] ],
  output_source_getter_string := "a",
  output_range_getter_string := "TensorProductOnObjects( cat, InternalCoHomOnObjects( cat, a, b ), b )",
  with_given_object_position := "Range",
  return_type := "morphism",
  dual_operation := "EvaluationMorphism",
  dual_arguments_reversed := true,
  # Test in CoclosedMonoidalCategoriesTest
),

CoclosedEvaluationMorphismWithGivenRange := rec(
  filter_list := [ "category", "object", "object", "object" ],
  io_type := [ [ "a", "b", "r" ], [ "a", "r" ] ],
  return_type := "morphism",
  dual_operation := "EvaluationMorphismWithGivenSource",
  dual_preprocessor_func := { cat, a, b, r } -> NTuple( 4, Opposite( cat ), Opposite( b ), Opposite( a ), Opposite( r ) ),
  dual_arguments_reversed := false,
  # Test in CoclosedMonoidalCategoriesTest
),

CoclosedCoevaluationMorphism := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "b" ], [ "s", "a" ] ],
  output_source_getter_string := "InternalCoHomOnObjects( cat, TensorProductOnObjects( cat, a, b ), b )",
  output_range_getter_string := "a",
  with_given_object_position := "Source",
  return_type := "morphism",
  dual_operation := "CoevaluationMorphism",
  dual_arguments_reversed := false,
  # Test in CoclosedMonoidalCategoriesTest
),

CoclosedCoevaluationMorphismWithGivenSource := rec(
  filter_list := [ "category", "object", "object", "object" ],
  io_type := [ [ "a", "b", "s" ], [ "s", "a" ] ],
  return_type := "morphism",
  dual_operation := "CoevaluationMorphismWithGivenRange",
  dual_arguments_reversed := false,
  # Test in CoclosedMonoidalCategoriesTest
),

TensorProductToInternalCoHomAdjunctionMap := rec(
  filter_list := [ "category", "object", "object", "morphism" ],
  io_type := [ [ "c", "b", "g" ], [ "i", "c" ] ],
  return_type := "morphism",
  dual_operation := "TensorProductToInternalHomAdjunctionMap",
  dual_arguments_reversed := false,
  # Test in CoclosedMonoidalCategoriesTest
),

InternalCoHomToTensorProductAdjunctionMap := rec(
  filter_list := [ "category", "object", "object", "morphism" ],
  io_type := [ [ "a", "b", "f" ], [ "a", "t" ] ],
  return_type := "morphism",
  dual_operation := "InternalHomToTensorProductAdjunctionMap",
  dual_preprocessor_func := { cat, a, b, f } -> NTuple( 4, Opposite( cat ), Opposite( b ), Opposite( a ), Opposite( f ) ),
  dual_arguments_reversed := false,
  # Test in CoclosedMonoidalCategoriesTest
),

MonoidalPreCoComposeMorphism := rec(
  filter_list := [ "category", "object", "object", "object" ],
  io_type := [ [ "a", "b", "c" ], [ "s", "r" ] ],
  output_source_getter_string := "InternalCoHomOnObjects( cat, a, c )",
  output_range_getter_string := "TensorProductOnObjects( cat, InternalCoHomOnObjects( cat, b, c ), InternalCoHomOnObjects( cat, a, b ) )",
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "MonoidalPreComposeMorphism",
  dual_arguments_reversed := true,
  # Test in CoclosedMonoidalCategoriesTest
),

MonoidalPreCoComposeMorphismWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "c", "r" ], [ "s", "r" ] ],
  return_type := "morphism",
  dual_operation := "MonoidalPreComposeMorphismWithGivenObjects",
  dual_arguments_reversed := true,
  # Test in CoclosedMonoidalCategoriesTest
),

MonoidalPostCoComposeMorphism := rec(
  filter_list := [ "category", "object", "object", "object" ],
  io_type := [ [ "a", "b", "c" ], [ "s", "r" ] ],
  output_source_getter_string := "InternalCoHomOnObjects( cat, a, c )",
  output_range_getter_string := "TensorProductOnObjects( cat, InternalCoHomOnObjects( cat, a, b ), InternalCoHomOnObjects( cat, b, c ) )",
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "MonoidalPostComposeMorphism",
  dual_arguments_reversed := true,
  # Test in CoclosedMonoidalCategoriesTest
),

MonoidalPostCoComposeMorphismWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "c", "r" ], [ "s", "r" ] ],
  return_type := "morphism",
  dual_operation := "MonoidalPostComposeMorphismWithGivenObjects",
  dual_arguments_reversed := true,
  # Test in CoclosedMonoidalCategoriesTest
),

CoDualOnObjects := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "acd" ] ],
  return_type := "object",
  dual_operation := "DualOnObjects",
  # Test in CoclosedMonoidalCategoriesTest
),

CoDualOnMorphisms := rec(
  filter_list := [ "category", "morphism" ],
  io_type := [ [ "alpha" ], [ "s", "r" ] ],
  output_source_getter_string := "CoDualOnObjects( cat, Range( alpha ) )",
  output_range_getter_string := "CoDualOnObjects( cat, Source( alpha ) )",
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "DualOnMorphisms",
  # Test in CoclosedMonoidalCategoriesTest
),

CoDualOnMorphismsWithGivenCoDuals := rec(
  filter_list := [ "category", "object", "morphism", "object" ],
  io_type := [ [ "s", "alpha", "r" ], [ "s", "r" ] ],
  return_type := "morphism",
  dual_operation := "DualOnMorphismsWithGivenDuals",
  dual_arguments_reversed := true,
  # Test in CoclosedMonoidalCategoriesTest
),

CoclosedEvaluationForCoDual := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "s", "r" ] ],
  output_source_getter_string := "TensorUnit( cat )",
  output_range_getter_string := "TensorProductOnObjects( cat, CoDualOnObjects( cat, a ), a )",
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "EvaluationForDual",
  # Test in CoclosedMonoidalCategoriesTest
),

CoclosedEvaluationForCoDualWithGivenTensorProduct := rec(
  filter_list := [ "category", "object", "object", "object" ],
  io_type := [ [ "s", "a", "r" ], [ "s", "r" ] ],
  return_type := "morphism",
  dual_operation := "EvaluationForDualWithGivenTensorProduct",
  dual_arguments_reversed := true,
  # Test in CoclosedMonoidalCategoriesTest
),

MorphismFromCoBidual := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "s", "a" ] ],
  output_source_getter_string := "CoDualOnObjects( cat, CoDualOnObjects( cat, a ) )",
  output_range_getter_string := "a",
  with_given_object_position := "Source",
  return_type := "morphism",
  dual_operation := "MorphismToBidual",
  # Test in CoclosedMonoidalCategoriesTest
),

MorphismFromCoBidualWithGivenCoBidual := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "s" ], [ "s", "a" ] ],
  return_type := "morphism",
  dual_operation := "MorphismToBidualWithGivenBidual",
  dual_arguments_reversed := false,
  # Test in CoclosedMonoidalCategoriesTest
),

InternalCoHomTensorProductCompatibilityMorphism := rec(
  filter_list := [ "category", "list_of_objects" ],
  input_arguments_names := [ "cat", "list" ],
  output_source_getter_string := "InternalCoHomOnObjects( cat, TensorProductOnObjects( cat, list[1], list[2] ), TensorProductOnObjects( cat, list[3], list[4] ) )",
  output_range_getter_string := "TensorProductOnObjects( cat, InternalCoHomOnObjects( cat, list[1], list[3] ), InternalCoHomOnObjects( cat, list[2], list[4] ) )",
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "TensorProductInternalHomCompatibilityMorphism",
  dual_preprocessor_func := { cat, list } -> Pair( Opposite( cat ), [ Opposite( list[3] ), Opposite( list[1] ), Opposite( list[4] ), Opposite( list[2] ) ] ),
  dual_arguments_reversed := false,
  # Test in CoclosedMonoidalCategoriesTest
),

InternalCoHomTensorProductCompatibilityMorphismWithGivenObjects := rec(
  filter_list := [ "category", "object", "list_of_objects", "object" ],
  input_arguments_names := [ "cat", "source", "list", "range" ],
  output_source_getter_string := "source",
  output_range_getter_string := "range",
  return_type := "morphism",
  dual_operation := "TensorProductInternalHomCompatibilityMorphismWithGivenObjects",
  dual_preprocessor_func :=
    { cat, s, list, r } -> NTuple( 4, Opposite( cat ), Opposite( r ), [ Opposite( list[3] ), Opposite( list[1] ), Opposite( list[4] ), Opposite( list[2] ) ], Opposite( s ) ),
  dual_arguments_reversed := false,
  # Test in CoclosedMonoidalCategoriesTest
),

CoDualityTensorProductCompatibilityMorphism := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "b" ], [ "s", "r" ] ],
  output_source_getter_string := "CoDualOnObjects( cat, TensorProductOnObjects( cat, a, b ) )",
  output_range_getter_string := "TensorProductOnObjects( cat, CoDualOnObjects( cat, a ), CoDualOnObjects( cat, b ) )",
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "TensorProductDualityCompatibilityMorphism",
  dual_arguments_reversed := false,
  # Test in CoclosedMonoidalCategoriesTest
),

CoDualityTensorProductCompatibilityMorphismWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "r" ], [ "s", "r" ] ],
  return_type := "morphism",
  dual_operation := "TensorProductDualityCompatibilityMorphismWithGivenObjects",
  dual_preprocessor_func := { cat, s, a, b, r } -> NTuple( 5, Opposite( cat ), Opposite( r ), Opposite( a ), Opposite( b ), Opposite( s ) ),
  dual_arguments_reversed := false,
  # Test in CoclosedMonoidalCategoriesTest
),

MorphismFromInternalCoHomToTensorProduct := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "b" ], [ "s", "r" ] ],
  output_source_getter_string := "InternalCoHomOnObjects( cat, a, b )",
  output_range_getter_string := "TensorProductOnObjects( cat, CoDualOnObjects( cat, b ), a )",
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "MorphismFromTensorProductToInternalHom",
  dual_arguments_reversed := true,
  # Test in CoclosedMonoidalCategoriesTest
),

MorphismFromInternalCoHomToTensorProductWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "r" ], [ "s", "r" ] ],
  return_type := "morphism",
  dual_operation := "MorphismFromTensorProductToInternalHomWithGivenObjects",
  dual_arguments_reversed := true,
  # Test in CoclosedMonoidalCategoriesTest
),

IsomorphismFromCoDualObjectToInternalCoHomFromTensorUnit := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "d", "i" ] ],
  output_source_getter_string := "CoDualOnObjects( cat, a )",
  output_range_getter_string := "InternalCoHomOnObjects( cat, TensorUnit( cat ), a )",
  return_type := "morphism",
  dual_operation := "IsomorphismFromInternalHomIntoTensorUnitToDualObject",
  # Test in CoclosedMonoidalCategoriesTest
),

IsomorphismFromInternalCoHomFromTensorUnitToCoDualObject := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "i", "d" ] ],
  output_source_getter_string := "InternalCoHomOnObjects( cat, TensorUnit( cat ), a )",
  output_range_getter_string := "CoDualOnObjects( cat, a )",
  return_type := "morphism",
  dual_operation := "IsomorphismFromDualObjectToInternalHomIntoTensorUnit",
  # Test in CoclosedMonoidalCategoriesTest
),

UniversalPropertyOfCoDual := rec(
  filter_list := [ "category", "object", "object", "morphism" ],
  io_type := [ [ "t", "a", "alpha" ], [ "d", "t" ] ],
  return_type := "morphism",
  dual_operation := "UniversalPropertyOfDual",
  dual_arguments_reversed := false,
  # Test in CoclosedMonoidalCategoriesTest
),

CoLambdaIntroduction := rec(
  filter_list := [ "category", "morphism" ],
  io_type := [ [ "alpha" ], [ "u", "i" ] ],
  return_type := "morphism",
  dual_operation := "LambdaIntroduction",
  # Test in CoclosedMonoidalCategoriesTest
),

CoLambdaElimination := rec(
  filter_list := [ "category", "object", "object", "morphism" ],
  io_type := [ [ "a", "b", "alpha" ], [ "a", "b" ] ],
  return_type := "morphism",
  dual_operation := "LambdaElimination",
  dual_preprocessor_func := { cat, a, b, alpha } -> NTuple( 4, Opposite( cat ), Opposite( b ), Opposite( a ), Opposite( alpha ) ),
  dual_arguments_reversed := false,
  # Test in CoclosedMonoidalCategoriesTest
),

IsomorphismFromObjectToInternalCoHom := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "a", "r" ] ],
  output_source_getter_string := "a",
  output_range_getter_string := "InternalCoHomOnObjects( cat, a, TensorUnit( cat ) )",
  with_given_object_position := "Range",
  return_type := "morphism",
  dual_operation := "IsomorphismFromInternalHomToObject",
  # Test in CoclosedMonoidalCategoriesTest
),

IsomorphismFromObjectToInternalCoHomWithGivenInternalCoHom := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "r" ], [ "a", "r" ] ],
  return_type := "morphism",
  dual_operation := "IsomorphismFromInternalHomToObjectWithGivenInternalHom",
  dual_arguments_reversed := false,
  # Test in CoclosedMonoidalCategoriesTest
),

IsomorphismFromInternalCoHomToObject := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "s", "a" ] ],
  output_source_getter_string := "InternalCoHomOnObjects( cat, a, TensorUnit( cat ) )",
  output_range_getter_string := "a",
  with_given_object_position := "Source",
  return_type := "morphism",
  dual_operation := "IsomorphismFromObjectToInternalHom",
  # Test in CoclosedMonoidalCategoriesTest
),

IsomorphismFromInternalCoHomToObjectWithGivenInternalCoHom := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "s" ], [ "s", "a" ] ],
  return_type := "morphism",
  dual_operation := "IsomorphismFromObjectToInternalHomWithGivenInternalHom",
  dual_arguments_reversed := false,
  # Test in CoclosedMonoidalCategoriesTest
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

CAP_INTERNAL_GENERATE_DOCUMENTATION_FROM_METHOD_NAME_RECORD(
    CLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD,
    "MonoidalCategories",
    "ClosedMonoidalCategories.autogen.gd", "Monoidal Categories",
    "Add-methods"
);

CAP_INTERNAL_GENERATE_DOCUMENTATION_FROM_METHOD_NAME_RECORD(
    COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD,
    "MonoidalCategories",
    "CoclosedMonoidalCategories.autogen.gd", "Monoidal Categories",
    "Add-methods"
);

CAP_INTERNAL_REGISTER_METHOD_NAME_RECORD_OF_PACKAGE( CLOSED_AND_COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD, "MonoidalCategories" );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( CLOSED_AND_COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );
