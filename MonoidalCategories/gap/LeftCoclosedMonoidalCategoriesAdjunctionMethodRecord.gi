# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

BindGlobal( "LEFT_COCLOSED_MONOIDAL_CATEGORIES_ADJUNCTION_METHOD_NAME_RECORD", rec(

LeftCoclosedMonoidalEvaluationMorphism := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_source_getter_string := "a",
  output_range_getter_string := "TensorProductOnObjects( cat, LeftInternalCoHomOnObjects( cat, a, b ), b )",
  output_range_getter_preconditions := [ [ "TensorProductOnObjects", 1 ], [ "LeftInternalCoHomOnObjects", 1 ] ],
  with_given_object_position := "Range",
  dual_operation := "LeftClosedMonoidalEvaluationMorphism",
  dual_arguments_reversed := true,
  # Test in LeftCoclosedMonoidalCategoriesTest
),

LeftCoclosedMonoidalEvaluationMorphismWithGivenRange := rec(
  filter_list := [ "category", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b", "r" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "LeftClosedMonoidalEvaluationMorphismWithGivenSource",
  dual_preprocessor_func := { cat, a, b, r } -> NTuple( 4, Opposite( cat ), Opposite( b ), Opposite( a ), Opposite( r ) ),
  dual_arguments_reversed := false,
),

LeftCoclosedMonoidalCoevaluationMorphism := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b" ],
  output_range_getter_string := "a",
  output_range_getter_preconditions := [ ],
  output_source_getter_string := "LeftInternalCoHomOnObjects( cat, TensorProductOnObjects( cat, a, b ), b )",
  output_source_getter_preconditions := [ [ "LeftInternalCoHomOnObjects", 1 ], [ "TensorProductOnObjects", 1 ] ],
  output_range_getter_string := "a",
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
  output_range_getter_string := "a",
  output_range_getter_preconditions := [ ],
  dual_operation := "LeftClosedMonoidalCoevaluationMorphismWithGivenRange",
  dual_arguments_reversed := false,
),

TensorProductToLeftInternalCoHomAdjunctionMap := rec(
  filter_list := [ "category", "object", "object", "morphism" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "c", "b", "g" ],
  output_source_getter_string := "LeftInternalCoHomOnObjects( cat, Source( g ), b )",
  output_source_getter_preconditions := [ [ "LeftInternalCoHomOnObjects", 1 ] ],
  output_range_getter_string := "c",
  output_range_getter_preconditions := [ ],
  with_given_object_position := "Source",
  dual_operation := "TensorProductToLeftInternalHomAdjunctionMap",
  dual_arguments_reversed := false,
  # Test in LeftCoclosedMonoidalCategoriesTest
),

TensorProductToLeftInternalCoHomAdjunctionMapWithGivenLeftInternalCoHom := rec(
  filter_list := [ "category", "object", "object", "morphism", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "c", "b", "g", "i" ],
  output_source_getter_string := "i",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "c",
  output_range_getter_preconditions := [ ],
  dual_operation := "TensorProductToLeftInternalHomAdjunctionMapWithGivenLeftInternalHom",
  dual_arguments_reversed := false,
),

LeftInternalCoHomToTensorProductAdjunctionMap := rec(
  filter_list := [ "category", "object", "object", "morphism" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b", "f" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "TensorProductOnObjects( cat, Range( f ), b )",
  output_range_getter_preconditions := [ [ "TensorProductOnObjects", 1 ] ],
  with_given_object_position := "Range",
  dual_operation := "LeftInternalHomToTensorProductAdjunctionMap",
  dual_preprocessor_func := { cat, a, b, f } -> NTuple( 4, Opposite( cat ), Opposite( b ), Opposite( a ), Opposite( f ) ),
  dual_arguments_reversed := false,
  # Test in LeftCoclosedMonoidalCategoriesTest
),

LeftInternalCoHomToTensorProductAdjunctionMapWithGivenTensorProduct := rec(
  filter_list := [ "category", "object", "object", "morphism", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b", "f", "t" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "t",
  output_range_getter_preconditions := [ ],
  dual_operation := "LeftInternalHomToTensorProductAdjunctionMapWithGivenTensorProduct",
  dual_preprocessor_func := { cat, a, b, f, t } -> NTuple( 4, Opposite( cat ), Opposite( b ), Opposite( a ), Opposite( f ), Opposite( t ) ),
  dual_arguments_reversed := false,
),

) );

# collect closed and coclosed operations
BindGlobal( "LEFT_CLOSED_AND_LEFT_COCLOSED_MONOIDAL_CATEGORIES_ADJUNCTION_METHOD_NAME_RECORD", rec( ) );

Perform( RecNames( LEFT_CLOSED_MONOIDAL_CATEGORIES_ADJUNCTION_METHOD_NAME_RECORD ), function ( name )
    
    LEFT_CLOSED_AND_LEFT_COCLOSED_MONOIDAL_CATEGORIES_ADJUNCTION_METHOD_NAME_RECORD.(name) := LEFT_CLOSED_MONOIDAL_CATEGORIES_ADJUNCTION_METHOD_NAME_RECORD.(name);
    
end );

Perform( RecNames( LEFT_COCLOSED_MONOIDAL_CATEGORIES_ADJUNCTION_METHOD_NAME_RECORD ), function ( name )
    
    LEFT_CLOSED_AND_LEFT_COCLOSED_MONOIDAL_CATEGORIES_ADJUNCTION_METHOD_NAME_RECORD.(name) := LEFT_COCLOSED_MONOIDAL_CATEGORIES_ADJUNCTION_METHOD_NAME_RECORD.(name);
    
end );

CAP_INTERNAL_ENHANCE_NAME_RECORD( LEFT_CLOSED_AND_LEFT_COCLOSED_MONOIDAL_CATEGORIES_ADJUNCTION_METHOD_NAME_RECORD );

CAP_INTERNAL_GENERATE_DOCUMENTATION_FROM_METHOD_NAME_RECORD(
    LEFT_CLOSED_MONOIDAL_CATEGORIES_ADJUNCTION_METHOD_NAME_RECORD,
    "MonoidalCategories",
    "LeftClosedMonoidalCategoriesAdjunction.autogen.gd", "Monoidal Categories",
    "Add-methods"
);

CAP_INTERNAL_GENERATE_DOCUMENTATION_FROM_METHOD_NAME_RECORD(
    LEFT_COCLOSED_MONOIDAL_CATEGORIES_ADJUNCTION_METHOD_NAME_RECORD,
    "MonoidalCategories",
    "LeftCoclosedMonoidalCategoriesAdjunction.autogen.gd", "Monoidal Categories",
    "Add-methods"
);

CAP_INTERNAL_REGISTER_METHOD_NAME_RECORD_OF_PACKAGE( LEFT_CLOSED_AND_LEFT_COCLOSED_MONOIDAL_CATEGORIES_ADJUNCTION_METHOD_NAME_RECORD, "MonoidalCategories" );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( LEFT_CLOSED_AND_LEFT_COCLOSED_MONOIDAL_CATEGORIES_ADJUNCTION_METHOD_NAME_RECORD );
