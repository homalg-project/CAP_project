# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



InstallValue( COCARTESIAN_COCLOSED_CATEGORIES_METHOD_NAME_RECORD, rec(

CoexponentialOnObjects := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "object",
  input_arguments_names := [ "cat", "a", "b" ],
  dual_operation := "ExponentialOnObjects",
  dual_arguments_reversed := true,
  # Test in CocartesianCoclosedCategoriesTest
),

CoexponentialOnMorphisms := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "alpha", "beta" ],
  output_source_getter_string := "CoexponentialOnObjects( cat, Source( alpha ), Range( beta ) )",
  output_source_getter_preconditions := [ [ "CoexponentialOnObjects", 1 ] ],
  output_range_getter_string := "CoexponentialOnObjects( cat, Range( alpha ), Source( beta ) )",
  output_range_getter_preconditions := [ [ "CoexponentialOnObjects", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "ExponentialOnMorphisms",
  dual_arguments_reversed := true,
  # Test in CocartesianCoclosedCategoriesTest
),

CoexponentialOnMorphismsWithGivenCoexponentials := rec(
  filter_list := [ "category", "object", "morphism", "morphism", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "alpha", "beta", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "ExponentialOnMorphismsWithGivenExponentials",
  dual_arguments_reversed := true,
),

CocartesianEvaluationMorphism := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_source_getter_string := "a",
  output_range_getter_string := "BinaryCoproduct( cat, CoexponentialOnObjects( cat, a, b ), b )",
  output_range_getter_preconditions := [ [ "Coproduct", 1 ], [ "CoexponentialOnObjects", 1 ] ],
  with_given_object_position := "Range",
  dual_operation := "CartesianEvaluationMorphism",
  dual_arguments_reversed := true,
  # Test in CocartesianCoclosedCategoriesTest
),

CocartesianEvaluationMorphismWithGivenRange := rec(
  filter_list := [ "category", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b", "r" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "CartesianEvaluationMorphismWithGivenSource",
  dual_preprocessor_func := { cat, a, b, r } -> NTuple( 4, Opposite( cat ), Opposite( b ), Opposite( a ), Opposite( r ) ),
  dual_arguments_reversed := false,
),

CocartesianCoevaluationMorphism := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b" ],
  output_range_getter_string := "a",
  output_range_getter_preconditions := [ ],
  output_source_getter_string := "CoexponentialOnObjects( cat, BinaryCoproduct( cat, a, b ), b )",
  output_source_getter_preconditions := [ [ "CoexponentialOnObjects", 1 ], [ "Coproduct", 1 ] ],
  output_range_getter_string := "a",
  with_given_object_position := "Source",
  dual_operation := "CartesianCoevaluationMorphism",
  dual_arguments_reversed := false,
  # Test in CocartesianCoclosedCategoriesTest
),

CocartesianCoevaluationMorphismWithGivenSource := rec(
  filter_list := [ "category", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b", "s" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "a",
  output_range_getter_preconditions := [ ],
  dual_operation := "CartesianCoevaluationMorphismWithGivenRange",
  dual_arguments_reversed := false,
),

CoproductToCoexponentialAdjunctionMap := rec(
  filter_list := [ "category", "object", "object", "morphism" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "c", "b", "g" ],
  output_range_getter_string := "c",
  output_range_getter_preconditions := [ ],
  dual_operation := "DirectProductToExponentialAdjunctionMap",
  dual_arguments_reversed := false,
  # Test in CocartesianCoclosedCategoriesTest
),

CoproductToCoexponentialAdjunctionMapWithGivenCoexponential := rec(
  filter_list := [ "category", "object", "object", "morphism", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "c", "b", "g", "i" ],
  output_source_getter_string := "i",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "c",
  output_range_getter_preconditions := [ ],
  dual_operation := "DirectProductToExponentialAdjunctionMapWithGivenExponential",
  dual_arguments_reversed := false,
),

CoexponentialToCoproductAdjunctionMap := rec(
  filter_list := [ "category", "object", "object", "morphism" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b", "f" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  dual_operation := "ExponentialToDirectProductAdjunctionMap",
  dual_preprocessor_func := { cat, a, b, f } -> NTuple( 4, Opposite( cat ), Opposite( b ), Opposite( a ), Opposite( f ) ),
  dual_arguments_reversed := false,
  # Test in CocartesianCoclosedCategoriesTest
),

CoexponentialToCoproductAdjunctionMapWithGivenCoproduct := rec(
  filter_list := [ "category", "object", "object", "morphism", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b", "f", "t" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "t",
  output_range_getter_preconditions := [ ],
  dual_operation := "ExponentialToDirectProductAdjunctionMapWithGivenDirectProduct",
  dual_preprocessor_func := { cat, a, b, f, t } -> NTuple( 4, Opposite( cat ), Opposite( b ), Opposite( a ), Opposite( f ), Opposite( t ) ),
  dual_arguments_reversed := false,
),

CocartesianPreCoComposeMorphism := rec(
  filter_list := [ "category", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b", "c" ],
  output_source_getter_string := "CoexponentialOnObjects( cat, a, c )",
  output_source_getter_preconditions := [ [ "CoexponentialOnObjects", 1 ] ],
  output_range_getter_string := "BinaryCoproduct( cat, CoexponentialOnObjects( cat, b, c ), CoexponentialOnObjects( cat, a, b ) )",
  output_range_getter_preconditions := [ [ "Coproduct", 1 ], [ "CoexponentialOnObjects", 2 ] ],
  with_given_object_position := "both",
  dual_operation := "CartesianPreComposeMorphism",
  dual_arguments_reversed := true,
  # Test in CocartesianCoclosedCategoriesTest
),

CocartesianPreCoComposeMorphismWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "a", "b", "c", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "CartesianPreComposeMorphismWithGivenObjects",
  dual_arguments_reversed := true,
),

CocartesianPostCoComposeMorphism := rec(
  filter_list := [ "category", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b", "c" ],
  output_source_getter_string := "CoexponentialOnObjects( cat, a, c )",
  output_source_getter_preconditions := [ [ "CoexponentialOnObjects", 1 ] ],
  output_range_getter_string := "BinaryCoproduct( cat, CoexponentialOnObjects( cat, a, b ), CoexponentialOnObjects( cat, b, c ) )",
  output_range_getter_preconditions := [ [ "Coproduct", 1 ], [ "CoexponentialOnObjects", 2 ] ],
  with_given_object_position := "both",
  dual_operation := "CartesianPostComposeMorphism",
  dual_arguments_reversed := true,
  # Test in CocartesianCoclosedCategoriesTest
),

CocartesianPostCoComposeMorphismWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "a", "b", "c", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "CartesianPostComposeMorphismWithGivenObjects",
  dual_arguments_reversed := true,
),

CocartesianDualOnObjects := rec(
  filter_list := [ "category", "object" ],
  return_type := "object",
  input_arguments_names := [ "cat", "a" ],
  dual_operation := "CartesianDualOnObjects",
  # Test in CocartesianCoclosedCategoriesTest
),

CocartesianDualOnMorphisms := rec(
  filter_list := [ "category", "morphism" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "alpha" ],
  output_source_getter_string := "CocartesianDualOnObjects( cat, Range( alpha ) )",
  output_source_getter_preconditions := [ [ "CocartesianDualOnObjects", 1 ] ],
  output_range_getter_string := "CocartesianDualOnObjects( cat, Source( alpha ) )",
  output_range_getter_preconditions := [ [ "CocartesianDualOnObjects", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "CartesianDualOnMorphisms",
  # Test in CocartesianCoclosedCategoriesTest
),

CocartesianDualOnMorphismsWithGivenCocartesianDuals := rec(
  filter_list := [ "category", "object", "morphism", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "alpha", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "CartesianDualOnMorphismsWithGivenCartesianDuals",
  dual_arguments_reversed := true,
),

CocartesianEvaluationForCocartesianDual := rec(
  filter_list := [ "category", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a" ],
  output_source_getter_string := "InitialObject( cat )",
  output_source_getter_preconditions := [ [ "InitialObject", 1 ] ],
  output_range_getter_string := "BinaryCoproduct( cat, CocartesianDualOnObjects( cat, a ), a )",
  output_range_getter_preconditions := [ [ "Coproduct", 1 ], [ "CocartesianDualOnObjects", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "CartesianEvaluationForCartesianDual",
  # Test in CocartesianCoclosedCategoriesTest
),

CocartesianEvaluationForCocartesianDualWithGivenCoproduct := rec(
  filter_list := [ "category", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "a", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "CartesianEvaluationForCartesianDualWithGivenDirectProduct",
  dual_arguments_reversed := true,
),

MorphismFromCocartesianBidual := rec(
  filter_list := [ "category", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a" ],
  output_range_getter_string := "a",
  output_range_getter_preconditions := [ ],
  output_source_getter_string := "CocartesianDualOnObjects( cat, CocartesianDualOnObjects( cat, a ) )",
  output_source_getter_preconditions := [ [ "CocartesianDualOnObjects", 2 ] ],
  output_range_getter_string := "a",
  with_given_object_position := "Source",
  dual_operation := "MorphismToCartesianBidual",
  # Test in CocartesianCoclosedCategoriesTest
),

MorphismFromCocartesianBidualWithGivenCocartesianBidual := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "s" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "a",
  output_range_getter_preconditions := [ ],
  dual_operation := "MorphismToCartesianBidualWithGivenCartesianBidual",
  dual_arguments_reversed := false,
),

CoexponentialCoproductCompatibilityMorphism := rec(
  filter_list := [ "category", "list_of_objects" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "list" ],
  output_source_getter_string := "CoexponentialOnObjects( cat, BinaryCoproduct( cat, list[1], list[2] ), BinaryCoproduct( cat, list[3], list[4] ) )",
  output_source_getter_preconditions := [ [ "CoexponentialOnObjects", 1 ], [ "Coproduct", 2 ] ],
  output_range_getter_string := "BinaryCoproduct( cat, CoexponentialOnObjects( cat, list[1], list[3] ), CoexponentialOnObjects( cat, list[2], list[4] ) )",
  output_range_getter_preconditions := [ [ "Coproduct", 1 ], [ "CoexponentialOnObjects", 2 ] ],
  with_given_object_position := "both",
  dual_operation := "DirectProductExponentialCompatibilityMorphism",
  dual_preprocessor_func := { cat, list } -> Pair( Opposite( cat ), [ Opposite( list[3] ), Opposite( list[1] ), Opposite( list[4] ), Opposite( list[2] ) ] ),
  dual_arguments_reversed := false,
  # Test in CocartesianCoclosedCategoriesTest
),

CoexponentialCoproductCompatibilityMorphismWithGivenObjects := rec(
  filter_list := [ "category", "object", "list_of_objects", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "source", "list", "range" ],
  output_source_getter_string := "source",
  output_range_getter_string := "range",
  dual_operation := "DirectProductExponentialCompatibilityMorphismWithGivenObjects",
  dual_preprocessor_func :=
    { cat, s, list, r } -> NTuple( 4, Opposite( cat ), Opposite( r ), [ Opposite( list[3] ), Opposite( list[1] ), Opposite( list[4] ), Opposite( list[2] ) ], Opposite( s ) ),
  dual_arguments_reversed := false,
),

CocartesianDualityCoproductCompatibilityMorphism := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b" ],
  output_source_getter_string := "CocartesianDualOnObjects( cat, BinaryCoproduct( cat, a, b ) )",
  output_source_getter_preconditions := [ [ "CocartesianDualOnObjects", 1 ], [ "Coproduct", 1 ] ],
  output_range_getter_string := "BinaryCoproduct( cat, CocartesianDualOnObjects( cat, a ), CocartesianDualOnObjects( cat, b ) )",
  output_range_getter_preconditions := [ [ "Coproduct", 1 ], [ "CocartesianDualOnObjects", 2 ] ],
  with_given_object_position := "both",
  dual_operation := "DirectProductCartesianDualityCompatibilityMorphism",
  dual_arguments_reversed := false,
  # Test in CocartesianCoclosedCategoriesTest
),

CocartesianDualityCoproductCompatibilityMorphismWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "a", "b", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "DirectProductCartesianDualityCompatibilityMorphismWithGivenObjects",
  dual_with_given_objects_reversed := true,
),

MorphismFromCoexponentialToCoproduct := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b" ],
  output_source_getter_string := "CoexponentialOnObjects( cat, a, b )",
  output_source_getter_preconditions := [ [ "CoexponentialOnObjects", 1 ] ],
  output_range_getter_string := "BinaryCoproduct( cat, CocartesianDualOnObjects( cat, b ), a )",
  output_range_getter_preconditions := [ [ "Coproduct", 1 ], [ "CocartesianDualOnObjects", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "MorphismFromDirectProductToExponential",
  dual_arguments_reversed := true,
  # Test in CocartesianCoclosedCategoriesTest
),

MorphismFromCoexponentialToCoproductWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "a", "b", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "MorphismFromDirectProductToExponentialWithGivenObjects",
  dual_arguments_reversed := true,
),

IsomorphismFromCocartesianDualObjectToCoexponentialFromInitialObject := rec(
  filter_list := [ "category", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a" ],
  output_source_getter_string := "CocartesianDualOnObjects( cat, a )",
  output_source_getter_preconditions := [ [ "CocartesianDualOnObjects", 1 ] ],
  output_range_getter_string := "CoexponentialOnObjects( cat, InitialObject( cat ), a )",
  output_range_getter_preconditions := [ [ "CoexponentialOnObjects", 1 ], [ "InitialObject", 1 ] ],
  dual_operation := "IsomorphismFromExponentialIntoTerminalObjectToCartesianDualObject",
  # Test in CocartesianCoclosedCategoriesTest
),

IsomorphismFromCoexponentialFromInitialObjectToCocartesianDualObject := rec(
  filter_list := [ "category", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a" ],
  output_source_getter_string := "CoexponentialOnObjects( cat, InitialObject( cat ), a )",
  output_source_getter_preconditions := [ [ "CoexponentialOnObjects", 1 ], [ "InitialObject", 1 ] ],
  output_range_getter_string := "CocartesianDualOnObjects( cat, a )",
  output_range_getter_preconditions := [ [ "CocartesianDualOnObjects", 1 ] ],
  dual_operation := "IsomorphismFromCartesianDualObjectToExponentialIntoTerminalObject",
  # Test in CocartesianCoclosedCategoriesTest
),

UniversalPropertyOfCocartesianDual := rec(
  filter_list := [ "category", "object", "object", "morphism" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "t", "a", "alpha" ],
  output_range_getter_string := "t",
  output_range_getter_preconditions := [ ],
  dual_operation := "UniversalPropertyOfCartesianDual",
  dual_arguments_reversed := false,
  # Test in CocartesianCoclosedCategoriesTest
),

CocartesianLambdaIntroduction := rec(
  filter_list := [ "category", "morphism" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "alpha" ],
  dual_operation := "CartesianLambdaIntroduction",
  # Test in CocartesianCoclosedCategoriesTest
),

CocartesianLambdaElimination := rec(
  filter_list := [ "category", "object", "object", "morphism" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b", "alpha" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "b",
  output_range_getter_preconditions := [ ],
  dual_operation := "CartesianLambdaElimination",
  dual_preprocessor_func := { cat, a, b, alpha } -> NTuple( 4, Opposite( cat ), Opposite( b ), Opposite( a ), Opposite( alpha ) ),
  dual_arguments_reversed := false,
  # Test in CocartesianCoclosedCategoriesTest
),

IsomorphismFromObjectToCoexponential := rec(
  filter_list := [ "category", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_source_getter_string := "a",
  output_range_getter_string := "CoexponentialOnObjects( cat, a, InitialObject( cat ) )",
  output_range_getter_preconditions := [ [ "CoexponentialOnObjects", 1 ], [ "InitialObject", 1 ] ],
  with_given_object_position := "Range",
  dual_operation := "IsomorphismFromExponentialToObject",
  # Test in CocartesianCoclosedCategoriesTest
),

IsomorphismFromObjectToCoexponentialWithGivenCoexponential := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "r" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "IsomorphismFromExponentialToObjectWithGivenExponential",
  dual_arguments_reversed := false,
),

IsomorphismFromCoexponentialToObject := rec(
  filter_list := [ "category", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a" ],
  output_range_getter_string := "a",
  output_range_getter_preconditions := [ ],
  output_source_getter_string := "CoexponentialOnObjects( cat, a, InitialObject( cat ) )",
  output_source_getter_preconditions := [ [ "CoexponentialOnObjects", 1 ], [ "InitialObject", 1 ] ],
  output_range_getter_string := "a",
  with_given_object_position := "Source",
  dual_operation := "IsomorphismFromObjectToExponential",
  # Test in CocartesianCoclosedCategoriesTest
),

IsomorphismFromCoexponentialToObjectWithGivenCoexponential := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "s" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "a",
  output_range_getter_preconditions := [ ],
  dual_operation := "IsomorphismFromObjectToExponentialWithGivenExponential",
  dual_arguments_reversed := false,
),

) );

# collect closed and coclosed operations
BindGlobal( "CARTESIAN_CLOSED_AND_COCARTESIAN_COCLOSED_CATEGORIES_METHOD_NAME_RECORD", rec( ) );

Perform( RecNames( CARTESIAN_CLOSED_CATEGORIES_METHOD_NAME_RECORD ), function ( name )
    
    CARTESIAN_CLOSED_AND_COCARTESIAN_COCLOSED_CATEGORIES_METHOD_NAME_RECORD.(name) := CARTESIAN_CLOSED_CATEGORIES_METHOD_NAME_RECORD.(name);
    
end );

Perform( RecNames( COCARTESIAN_COCLOSED_CATEGORIES_METHOD_NAME_RECORD ), function ( name )
    
    CARTESIAN_CLOSED_AND_COCARTESIAN_COCLOSED_CATEGORIES_METHOD_NAME_RECORD.(name) := COCARTESIAN_COCLOSED_CATEGORIES_METHOD_NAME_RECORD.(name);
    
end );

CAP_INTERNAL_ENHANCE_NAME_RECORD( CARTESIAN_CLOSED_AND_COCARTESIAN_COCLOSED_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_GENERATE_DOCUMENTATION_FROM_METHOD_NAME_RECORD(
    CARTESIAN_CLOSED_CATEGORIES_METHOD_NAME_RECORD,
    "CartesianCategories",
    "CartesianClosedCategories.autogen.gd", "Cartesian Categories",
    "Add-methods"
);

CAP_INTERNAL_GENERATE_DOCUMENTATION_FROM_METHOD_NAME_RECORD(
    COCARTESIAN_COCLOSED_CATEGORIES_METHOD_NAME_RECORD,
    "CartesianCategories",
    "CocartesianCoclosedCategories.autogen.gd", "Cocartesian Categories",
    "Add-methods"
);

CAP_INTERNAL_REGISTER_METHOD_NAME_RECORD_OF_PACKAGE( CARTESIAN_CLOSED_AND_COCARTESIAN_COCLOSED_CATEGORIES_METHOD_NAME_RECORD, "CartesianCategories" );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( CARTESIAN_CLOSED_AND_COCARTESIAN_COCLOSED_CATEGORIES_METHOD_NAME_RECORD );
