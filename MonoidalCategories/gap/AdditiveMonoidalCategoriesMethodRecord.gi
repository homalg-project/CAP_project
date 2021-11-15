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
  return_type := "morphism" ),

LeftDistributivityExpandingWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "list_of_objects", "object" ],
  io_type := [ [ "s", "a", "L", "r" ], [ "s", "r" ] ],
  return_type := "morphism" ),

LeftDistributivityFactoring := rec(
  filter_list := [ "category", "object", "list_of_objects" ],
  io_type := [ [ "a", "L" ], [ "s", "r" ] ],
  output_source_getter_string := "DirectSum( cat, List( L, summand -> TensorProductOnObjects( cat, a, summand ) ) )",
  output_range_getter_string := "TensorProductOnObjects( cat, a, DirectSum( cat, L ) )",
  with_given_object_position := "both",
  return_type := "morphism" ),

LeftDistributivityFactoringWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "list_of_objects", "object" ],
  io_type := [ [ "s", "a", "L", "r" ], [ "s", "r" ] ],
  return_type := "morphism" ),

RightDistributivityExpanding := rec(
  filter_list := [ "category", "list_of_objects", "object" ],
  io_type := [ [ "L", "a" ], [ "s", "r" ] ],
  output_source_getter_string := "TensorProductOnObjects( cat, DirectSum( cat, L ), a )",
  output_range_getter_string := "DirectSum( cat, List( L, summand -> TensorProductOnObjects( cat, summand, a ) ) )",
  with_given_object_position := "both",
  return_type := "morphism" ),

RightDistributivityExpandingWithGivenObjects := rec(
  filter_list := [ "category", "object", "list_of_objects", "object", "object" ],
  io_type := [ [ "s", "L", "a", "r" ], [ "s", "r" ] ],
  return_type := "morphism" ),

RightDistributivityFactoring := rec(
  filter_list := [ "category", "list_of_objects", "object" ],
  io_type := [ [ "L", "a" ], [ "s", "r" ] ],
  output_source_getter_string := "DirectSum( cat, List( L, summand -> TensorProductOnObjects( cat, summand, a ) ) )",
  output_range_getter_string := "TensorProductOnObjects( cat, DirectSum( cat, L ), a )",
  with_given_object_position := "both",
  return_type := "morphism" ),

RightDistributivityFactoringWithGivenObjects := rec(
  filter_list := [ "category", "object", "list_of_objects", "object", "object" ],
  io_type := [ [ "s", "L", "a", "r" ], [ "s", "r" ] ],
  return_type := "morphism" ),

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
