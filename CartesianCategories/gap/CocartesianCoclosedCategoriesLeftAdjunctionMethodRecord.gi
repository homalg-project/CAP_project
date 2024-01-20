# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



BindGlobal( "COCARTESIAN_COCLOSED_CATEGORIES_LEFT_ADJUNCTION_METHOD_NAME_RECORD", rec(

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
  output_source_getter_string := "CoexponentialOnObjects( cat, Source( g ), b )",
  output_source_getter_preconditions := [ [ "CoexponentialOnObjects", 1 ] ],
  output_range_getter_string := "c",
  output_range_getter_preconditions := [ ],
  with_given_object_position := "Source",
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
  output_range_getter_string := "BinaryCoproduct( cat, Range( f ), b )",
  output_range_getter_preconditions := [ [ "Coproduct", 1 ] ],
  with_given_object_position := "Range",
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

) );

# collect closed and coclosed operations
BindGlobal( "CARTESIAN_CLOSED_AND_COCARTESIAN_COCLOSED_CATEGORIES_LEFT_ADJUNCTION_METHOD_NAME_RECORD", rec( ) );

Perform( RecNames( CARTESIAN_CLOSED_CATEGORIES_LEFT_ADJUNCTION_METHOD_NAME_RECORD ), function ( name )
    
    CARTESIAN_CLOSED_AND_COCARTESIAN_COCLOSED_CATEGORIES_LEFT_ADJUNCTION_METHOD_NAME_RECORD.(name) := CARTESIAN_CLOSED_CATEGORIES_LEFT_ADJUNCTION_METHOD_NAME_RECORD.(name);
    
end );

Perform( RecNames( COCARTESIAN_COCLOSED_CATEGORIES_LEFT_ADJUNCTION_METHOD_NAME_RECORD ), function ( name )
    
    CARTESIAN_CLOSED_AND_COCARTESIAN_COCLOSED_CATEGORIES_LEFT_ADJUNCTION_METHOD_NAME_RECORD.(name) := COCARTESIAN_COCLOSED_CATEGORIES_LEFT_ADJUNCTION_METHOD_NAME_RECORD.(name);
    
end );

CAP_INTERNAL_ENHANCE_NAME_RECORD( CARTESIAN_CLOSED_AND_COCARTESIAN_COCLOSED_CATEGORIES_LEFT_ADJUNCTION_METHOD_NAME_RECORD );

CAP_INTERNAL_GENERATE_DOCUMENTATION_FROM_METHOD_NAME_RECORD(
    CARTESIAN_CLOSED_CATEGORIES_LEFT_ADJUNCTION_METHOD_NAME_RECORD,
    "CartesianCategories",
    "CartesianClosedCategoriesLeftAdjunction.autogen.gd", "Cartesian Categories",
    "Add-methods"
);

CAP_INTERNAL_GENERATE_DOCUMENTATION_FROM_METHOD_NAME_RECORD(
    COCARTESIAN_COCLOSED_CATEGORIES_LEFT_ADJUNCTION_METHOD_NAME_RECORD,
    "CartesianCategories",
    "CocartesianCoclosedCategoriesLeftAdjunction.autogen.gd", "Cocartesian Categories",
    "Add-methods"
);

CAP_INTERNAL_REGISTER_METHOD_NAME_RECORD_OF_PACKAGE( CARTESIAN_CLOSED_AND_COCARTESIAN_COCLOSED_CATEGORIES_LEFT_ADJUNCTION_METHOD_NAME_RECORD, "CartesianCategories" );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( CARTESIAN_CLOSED_AND_COCARTESIAN_COCLOSED_CATEGORIES_LEFT_ADJUNCTION_METHOD_NAME_RECORD );
