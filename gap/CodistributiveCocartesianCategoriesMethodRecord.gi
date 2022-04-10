# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



InstallValue( DISTRIBUTIVE_COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD, rec(

LeftCocartesianCodistributivityExpanding := rec(
  filter_list := [ "category", "object", "list_of_objects" ],
  io_type := [ [ "a", "L" ], [ "s", "r" ] ],
  output_source_getter_string := "BinaryCoproduct( cat, a, DirectProduct( cat, L ) )",
  output_range_getter_string := "DirectProduct( cat, List( L, summand -> BinaryCoproduct( cat, a, summand ) ) )",
  with_given_object_position := "both",
  return_type := "morphism" ),

LeftCocartesianCodistributivityExpandingWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "list_of_objects", "object" ],
  io_type := [ [ "s", "a", "L", "r" ], [ "s", "r" ] ],
  return_type := "morphism" ),

LeftCocartesianCodistributivityFactoring := rec(
  filter_list := [ "category", "object", "list_of_objects" ],
  io_type := [ [ "a", "L" ], [ "s", "r" ] ],
  output_source_getter_string := "DirectProduct( cat, List( L, summand -> BinaryCoproduct( cat, a, summand ) ) )",
  output_range_getter_string := "BinaryCoproduct( cat, a, DirectProduct( cat, L ) )",
  with_given_object_position := "both",
  return_type := "morphism" ),

LeftCocartesianCodistributivityFactoringWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "list_of_objects", "object" ],
  io_type := [ [ "s", "a", "L", "r" ], [ "s", "r" ] ],
  return_type := "morphism" ),

RightCocartesianCodistributivityExpanding := rec(
  filter_list := [ "category", "list_of_objects", "object" ],
  io_type := [ [ "L", "a" ], [ "s", "r" ] ],
  output_source_getter_string := "BinaryCoproduct( cat, DirectProduct( cat, L ), a )",
  output_range_getter_string := "DirectProduct( cat, List( L, summand -> BinaryCoproduct( cat, summand, a ) ) )",
  with_given_object_position := "both",
  return_type := "morphism" ),

RightCocartesianCodistributivityExpandingWithGivenObjects := rec(
  filter_list := [ "category", "object", "list_of_objects", "object", "object" ],
  io_type := [ [ "s", "L", "a", "r" ], [ "s", "r" ] ],
  return_type := "morphism" ),

RightCocartesianCodistributivityFactoring := rec(
  filter_list := [ "category", "list_of_objects", "object" ],
  io_type := [ [ "L", "a" ], [ "s", "r" ] ],
  output_source_getter_string := "DirectProduct( cat, List( L, summand -> BinaryCoproduct( cat, summand, a ) ) )",
  output_range_getter_string := "BinaryCoproduct( cat, DirectProduct( cat, L ), a )",
  with_given_object_position := "both",
  return_type := "morphism" ),

RightCocartesianCodistributivityFactoringWithGivenObjects := rec(
  filter_list := [ "category", "object", "list_of_objects", "object", "object" ],
  io_type := [ [ "s", "L", "a", "r" ], [ "s", "r" ] ],
  return_type := "morphism" ),

) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( DISTRIBUTIVE_COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_GENERATE_DOCUMENTATION_FROM_METHOD_NAME_RECORD(
    DISTRIBUTIVE_COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD,
    "Toposes",
    "CodistributiveCocartesianCategories.autogen.gd",
    "Cocartesian Categories",
    "Add-methods"
);

CAP_INTERNAL_REGISTER_METHOD_NAME_RECORD_OF_PACKAGE( DISTRIBUTIVE_COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD, "Toposes" );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( DISTRIBUTIVE_COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD );
