# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

InstallValue( MONOIDAL_CATEGORIES_METHOD_NAME_RECORD, rec(

## Basic Operations for Monoidal Categories

TensorProductOnMorphisms := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "alpha", "beta" ],
  output_source_getter_string := "TensorProductOnObjects( cat, Source( alpha ), Source( beta ) )",
  output_source_getter_preconditions := [ [ "TensorProductOnObjects", 1 ] ],
  output_range_getter_string := "TensorProductOnObjects( cat, Range( alpha ), Range( beta ) )",
  output_range_getter_preconditions := [ [ "TensorProductOnObjects", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "TensorProductOnMorphisms",
  dual_arguments_reversed := false,
  compatible_with_congruence_of_morphisms := true,
  # Test in MonoidalCategoriesTest
),

TensorProductOnMorphismsWithGivenTensorProducts := rec(
  filter_list := [ "category", "object", "morphism", "morphism", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "alpha", "beta", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "TensorProductOnMorphismsWithGivenTensorProducts",
  dual_with_given_objects_reversed := true,
  compatible_with_congruence_of_morphisms := true,
),

AssociatorRightToLeft := rec(
  filter_list := [ "category", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b", "c" ],
  output_source_getter_string := "TensorProductOnObjects( cat, a, TensorProductOnObjects( cat, b, c ) )",
  output_source_getter_preconditions := [ [ "TensorProductOnObjects", 2 ] ],
  output_range_getter_string := "TensorProductOnObjects( cat, TensorProductOnObjects( cat, a, b ), c )",
  output_range_getter_preconditions := [ [ "TensorProductOnObjects", 2 ] ],
  with_given_object_position := "both",
  dual_operation := "AssociatorLeftToRight",
  dual_arguments_reversed := false,
  # Test in MonoidalCategoriesTest
),

AssociatorRightToLeftWithGivenTensorProducts := rec(
  filter_list := [ "category", "object", "object", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "a", "b", "c", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "AssociatorLeftToRightWithGivenTensorProducts",
  dual_with_given_objects_reversed := true,
),

AssociatorLeftToRight := rec(
  filter_list := [ "category", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b", "c" ],
  output_source_getter_string := "TensorProductOnObjects( cat, TensorProductOnObjects( cat, a, b ), c )",
  output_source_getter_preconditions := [ [ "TensorProductOnObjects", 2 ] ],
  output_range_getter_string := "TensorProductOnObjects( cat, a, TensorProductOnObjects( cat, b, c ) )",
  output_range_getter_preconditions := [ [ "TensorProductOnObjects", 2 ] ],
  with_given_object_position := "both",
  dual_operation := "AssociatorRightToLeft",
  dual_arguments_reversed := false,
  # Test in MonoidalCategoriesTest
),

AssociatorLeftToRightWithGivenTensorProducts := rec(
  filter_list := [ "category", "object", "object", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "a", "b", "c", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "AssociatorRightToLeftWithGivenTensorProducts",
  dual_with_given_objects_reversed := true,
),

LeftUnitor := rec(
  filter_list := [ "category", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a" ],
  output_range_getter_string := "a",
  output_range_getter_preconditions := [ ],
  output_source_getter_string := "TensorProductOnObjects( cat, TensorUnit( cat ), a )",
  output_source_getter_preconditions := [ [ "TensorProductOnObjects", 1 ], [ "TensorUnit", 1 ] ],
  output_range_getter_string := "a",
  with_given_object_position := "Source",
  dual_operation := "LeftUnitorInverse",
  # Test in MonoidalCategoriesTest
),

LeftUnitorWithGivenTensorProduct := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "s" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "a",
  output_range_getter_preconditions := [ ],
  dual_operation := "LeftUnitorInverseWithGivenTensorProduct",
  dual_arguments_reversed := false,
),

LeftUnitorInverse := rec(
  filter_list := [ "category", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_source_getter_string := "a",
  output_range_getter_string := "TensorProductOnObjects( cat, TensorUnit( cat ), a )",
  output_range_getter_preconditions := [ [ "TensorProductOnObjects", 1 ], [ "TensorUnit", 1 ] ],
  with_given_object_position := "Range",
  dual_operation := "LeftUnitor",
  # Test in MonoidalCategoriesTest
),

LeftUnitorInverseWithGivenTensorProduct := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "r" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "LeftUnitorWithGivenTensorProduct",
  dual_arguments_reversed := false,
),

RightUnitor := rec(
  filter_list := [ "category", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a" ],
  output_range_getter_string := "a",
  output_range_getter_preconditions := [ ],
  output_source_getter_string := "TensorProductOnObjects( cat, a, TensorUnit( cat ) )",
  output_source_getter_preconditions := [ [ "TensorProductOnObjects", 1 ], [ "TensorUnit", 1 ] ],
  output_range_getter_string := "a",
  with_given_object_position := "Source",
  dual_operation := "RightUnitorInverse",
  # Test in MonoidalCategoriesTest
),

RightUnitorWithGivenTensorProduct := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "s" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "a",
  output_range_getter_preconditions := [ ],
  dual_operation := "RightUnitorInverseWithGivenTensorProduct",
  dual_arguments_reversed := false,
),

RightUnitorInverse := rec(
  filter_list := [ "category", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_source_getter_string := "a",
  output_range_getter_string := "TensorProductOnObjects( cat, a, TensorUnit( cat ) )",
  output_range_getter_preconditions := [ [ "TensorProductOnObjects", 1 ], [ "TensorUnit", 1 ] ],
  with_given_object_position := "Range",
  dual_operation := "RightUnitor",
  # Test in MonoidalCategoriesTest
),

RightUnitorInverseWithGivenTensorProduct := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "r" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "RightUnitorWithGivenTensorProduct",
  dual_arguments_reversed := false,
),

) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_GENERATE_DECLARATIONS_AND_INSTALLATIONS_FROM_METHOD_NAME_RECORD(
    MONOIDAL_CATEGORIES_METHOD_NAME_RECORD,
    "MonoidalCategories",
    "MonoidalCategoriesMethodRecord",
    "Monoidal Categories",
    "Add-methods"
);

CAP_INTERNAL_REGISTER_METHOD_NAME_RECORD_OF_PACKAGE( MONOIDAL_CATEGORIES_METHOD_NAME_RECORD, "MonoidalCategories" );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );
