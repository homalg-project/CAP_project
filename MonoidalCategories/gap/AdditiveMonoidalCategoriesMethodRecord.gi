# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

InstallValue( DISTRIBUTIVE_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD, rec(

LeftDistributivityExpanding := rec(
  filter_list := [ "category", "object", "list_of_objects" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "L" ],
  output_source_getter_string := "TensorProductOnObjects( cat, a, DirectSum( cat, L ) )",
  output_source_getter_preconditions := [ [ "TensorProductOnObjects", 1 ], [ "DirectSum", 1 ] ],
  output_range_getter_string := "DirectSum( cat, List( L, summand -> TensorProductOnObjects( cat, a, summand ) ) )",
  output_range_getter_preconditions := [ [ "DirectSum", 1 ], [ "TensorProductOnObjects", 2 ] ],
  with_given_object_position := "both",
  dual_operation := "LeftDistributivityFactoring",
  dual_arguments_reversed := false,
  # Test in AdditiveMonoidalCategoriesTest
),

LeftDistributivityExpandingWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "list_of_objects", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "a", "L", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "LeftDistributivityFactoringWithGivenObjects",
  dual_with_given_objects_reversed := true,
),

LeftDistributivityFactoring := rec(
  filter_list := [ "category", "object", "list_of_objects" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "L" ],
  output_source_getter_string := "DirectSum( cat, List( L, summand -> TensorProductOnObjects( cat, a, summand ) ) )",
  output_source_getter_preconditions := [ [ "DirectSum", 1 ], [ "TensorProductOnObjects", 2 ] ],
  output_range_getter_string := "TensorProductOnObjects( cat, a, DirectSum( cat, L ) )",
  output_range_getter_preconditions := [ [ "TensorProductOnObjects", 1 ], [ "DirectSum", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "LeftDistributivityExpanding",
  dual_arguments_reversed := false,
  # Test in AdditiveMonoidalCategoriesTest
),

LeftDistributivityFactoringWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "list_of_objects", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "a", "L", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "LeftDistributivityExpandingWithGivenObjects",
  dual_with_given_objects_reversed := true,
),

RightDistributivityExpanding := rec(
  filter_list := [ "category", "list_of_objects", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "L", "a" ],
  output_source_getter_string := "TensorProductOnObjects( cat, DirectSum( cat, L ), a )",
  output_source_getter_preconditions := [ [ "TensorProductOnObjects", 1 ], [ "DirectSum", 1 ] ],
  output_range_getter_string := "DirectSum( cat, List( L, summand -> TensorProductOnObjects( cat, summand, a ) ) )",
  output_range_getter_preconditions := [ [ "DirectSum", 1 ], [ "TensorProductOnObjects", 2 ] ],
  with_given_object_position := "both",
  dual_operation := "RightDistributivityFactoring",
  dual_arguments_reversed := false,
  # Test in AdditiveMonoidalCategoriesTest
),

RightDistributivityExpandingWithGivenObjects := rec(
  filter_list := [ "category", "object", "list_of_objects", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "L", "a", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "RightDistributivityFactoringWithGivenObjects",
  dual_with_given_objects_reversed := true,
),

RightDistributivityFactoring := rec(
  filter_list := [ "category", "list_of_objects", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "L", "a" ],
  output_source_getter_string := "DirectSum( cat, List( L, summand -> TensorProductOnObjects( cat, summand, a ) ) )",
  output_source_getter_preconditions := [ [ "DirectSum", 1 ], [ "TensorProductOnObjects", 2 ] ],
  output_range_getter_string := "TensorProductOnObjects( cat, DirectSum( cat, L ), a )",
  output_range_getter_preconditions := [ [ "TensorProductOnObjects", 1 ], [ "DirectSum", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "RightDistributivityExpanding",
  dual_arguments_reversed := false,
  # Test in AdditiveMonoidalCategoriesTest
),

RightDistributivityFactoringWithGivenObjects := rec(
  filter_list := [ "category", "object", "list_of_objects", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "L", "a", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "RightDistributivityExpandingWithGivenObjects",
  dual_with_given_objects_reversed := true,
),

) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( DISTRIBUTIVE_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_GENERATE_DECLARATIONS_AND_INSTALLATIONS_FROM_METHOD_NAME_RECORD(
    DISTRIBUTIVE_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD,
    "MonoidalCategories",
    "AdditiveMonoidalCategoriesMethodRecord",
    "Monoidal Categories",
    "Add-methods"
);

CAP_INTERNAL_REGISTER_METHOD_NAME_RECORD_OF_PACKAGE( DISTRIBUTIVE_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD, "MonoidalCategories" );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( DISTRIBUTIVE_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );
