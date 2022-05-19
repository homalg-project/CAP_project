# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

InstallValue( DISTRIBUTIVE_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD, rec(

LeftDistributivityExpanding := rec(
  filter_list := [ "category", "object", "list_of_objects" ],
  io_type := [ [ "a", "L" ], [ "s", "r" ] ],
  output_source_getter_string := "TensorProductOnObjects( cat, a, DirectSum( cat, L ) )",
  output_range_getter_string := "DirectSum( cat, List( L, summand -> TensorProductOnObjects( cat, a, summand ) ) )",
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "LeftDistributivityFactoring",
  dual_arguments_reversed := false,
  # Test in AdditiveMonoidalCategoriesTest
),

LeftDistributivityExpandingWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "list_of_objects", "object" ],
  io_type := [ [ "s", "a", "L", "r" ], [ "s", "r" ] ],
  return_type := "morphism",
  dual_operation := "LeftDistributivityFactoringWithGivenObjects",
  dual_preprocessor_func := { cat, s, a, L, r } -> NTuple( 5, Opposite( cat ), Opposite( r ), Opposite( a ), List( L, Opposite ), Opposite( s ) ),
  dual_arguments_reversed := false,
  # Test in AdditiveMonoidalCategoriesTest
),

LeftDistributivityFactoring := rec(
  filter_list := [ "category", "object", "list_of_objects" ],
  io_type := [ [ "a", "L" ], [ "s", "r" ] ],
  output_source_getter_string := "DirectSum( cat, List( L, summand -> TensorProductOnObjects( cat, a, summand ) ) )",
  output_range_getter_string := "TensorProductOnObjects( cat, a, DirectSum( cat, L ) )",
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "LeftDistributivityExpanding",
  dual_arguments_reversed := false,
  # Test in AdditiveMonoidalCategoriesTest
),

LeftDistributivityFactoringWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "list_of_objects", "object" ],
  io_type := [ [ "s", "a", "L", "r" ], [ "s", "r" ] ],
  return_type := "morphism",
  dual_operation := "LeftDistributivityExpandingWithGivenObjects",
  dual_preprocessor_func := { cat, s, a, L, r } -> NTuple( 5, Opposite( cat ), Opposite( r ), Opposite( a ), List( L, Opposite ), Opposite( s ) ),
  dual_arguments_reversed := false,
  # Test in AdditiveMonoidalCategoriesTest
),

RightDistributivityExpanding := rec(
  filter_list := [ "category", "list_of_objects", "object" ],
  io_type := [ [ "L", "a" ], [ "s", "r" ] ],
  output_source_getter_string := "TensorProductOnObjects( cat, DirectSum( cat, L ), a )",
  output_range_getter_string := "DirectSum( cat, List( L, summand -> TensorProductOnObjects( cat, summand, a ) ) )",
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "RightDistributivityFactoring",
  dual_arguments_reversed := false,
  # Test in AdditiveMonoidalCategoriesTest
),

RightDistributivityExpandingWithGivenObjects := rec(
  filter_list := [ "category", "object", "list_of_objects", "object", "object" ],
  io_type := [ [ "s", "L", "a", "r" ], [ "s", "r" ] ],
  return_type := "morphism",
  dual_operation := "RightDistributivityFactoringWithGivenObjects",
  dual_preprocessor_func := { cat, s, L, a, r } -> NTuple( 5, Opposite( cat ), Opposite( r ), List( L, Opposite ), Opposite( a ), Opposite( s ) ),
  dual_arguments_reversed := false,
  # Test in AdditiveMonoidalCategoriesTest
),

RightDistributivityFactoring := rec(
  filter_list := [ "category", "list_of_objects", "object" ],
  io_type := [ [ "L", "a" ], [ "s", "r" ] ],
  output_source_getter_string := "DirectSum( cat, List( L, summand -> TensorProductOnObjects( cat, summand, a ) ) )",
  output_range_getter_string := "TensorProductOnObjects( cat, DirectSum( cat, L ), a )",
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "RightDistributivityExpanding",
  dual_arguments_reversed := false,
  # Test in AdditiveMonoidalCategoriesTest
),

RightDistributivityFactoringWithGivenObjects := rec(
  filter_list := [ "category", "object", "list_of_objects", "object", "object" ],
  io_type := [ [ "s", "L", "a", "r" ], [ "s", "r" ] ],
  return_type := "morphism",
  dual_operation := "RightDistributivityExpandingWithGivenObjects",
  dual_preprocessor_func := { cat, s, L, a, r } -> NTuple( 5, Opposite( cat ), Opposite( r ), List( L, Opposite ), Opposite( a ), Opposite( s ) ),
  dual_arguments_reversed := false,
  # Test in AdditiveMonoidalCategoriesTest
),

) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( DISTRIBUTIVE_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_GENERATE_DOCUMENTATION_FROM_METHOD_NAME_RECORD(
    DISTRIBUTIVE_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD,
    "MonoidalCategories",
    "AdditiveMonoidalCategories.autogen.gd",
    "Monoidal Categories",
    "Add-methods"
);

CAP_INTERNAL_REGISTER_METHOD_NAME_RECORD_OF_PACKAGE( DISTRIBUTIVE_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD, "MonoidalCategories" );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( DISTRIBUTIVE_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );
