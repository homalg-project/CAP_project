# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

InstallValue( BRAIDED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD, rec(

Braiding := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b" ],
  output_source_getter_string := "TensorProductOnObjects( cat, a, b )",
  output_source_getter_preconditions := [ [ "TensorProductOnObjects", 1 ] ],
  output_range_getter_string := "TensorProductOnObjects( cat, b, a )",
  output_range_getter_preconditions := [ [ "TensorProductOnObjects", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "BraidingInverse",
  dual_arguments_reversed := false,
  # Test in BraidedMonoidalCategoriesTest
),

BraidingWithGivenTensorProducts := rec(
  filter_list := [ "category", "object", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "a", "b", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "BraidingInverseWithGivenTensorProducts",
  dual_with_given_objects_reversed := true,
),

BraidingInverse := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "b" ],
  output_source_getter_string := "TensorProductOnObjects( cat, b, a )",
  output_source_getter_preconditions := [ [ "TensorProductOnObjects", 1 ] ],
  output_range_getter_string := "TensorProductOnObjects( cat, a, b )",
  output_range_getter_preconditions := [ [ "TensorProductOnObjects", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "Braiding",
  dual_arguments_reversed := false,
  # Test in BraidedMonoidalCategoriesTest
),

BraidingInverseWithGivenTensorProducts := rec(
  filter_list := [ "category", "object", "object", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "a", "b", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "BraidingWithGivenTensorProducts",
  dual_with_given_objects_reversed := true,
),

) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( BRAIDED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_GENERATE_DECLARATIONS_AND_INSTALLATIONS_FROM_METHOD_NAME_RECORD(
    BRAIDED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD,
    "MonoidalCategories",
    "BraidedMonoidalCategoriesMethodRecord",
    "Monoidal Categories",
    "Add-methods"
);

CAP_INTERNAL_REGISTER_METHOD_NAME_RECORD_OF_PACKAGE( BRAIDED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD, "MonoidalCategories" );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( BRAIDED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );
