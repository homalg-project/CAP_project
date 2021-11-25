# THIS FILE WAS AUTOMATICALLY GENERATED FROM MonoidalCategories v2021.11-04

# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Implementations
#

InstallValue( DISTRIBUTIVE_CARTESIAN_CATEGORIES_METHOD_NAME_RECORD, rec(

LeftCartesianDistributivityExpanding := rec(
  filter_list := [ "category", "object", "list_of_objects" ],
  io_type := [ [ "a", "L" ], [ "s", "r" ] ],
  output_source_getter_string := "DirectProduct( a, Coproduct( cat, L ) )",
  output_range_getter_string := "Coproduct( cat, List( L, summand -> DirectProduct( a, summand ) ) )",
  with_given_object_position := "both",
  return_type := "morphism" ),

LeftCartesianDistributivityExpandingWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "list_of_objects", "object" ],
  io_type := [ [ "s", "a", "L", "r" ], [ "s", "r" ] ],
  return_type := "morphism" ),

LeftCartesianDistributivityFactoring := rec(
  filter_list := [ "category", "object", "list_of_objects" ],
  io_type := [ [ "a", "L" ], [ "s", "r" ] ],
  output_source_getter_string := "Coproduct( cat, List( L, summand -> DirectProduct( a, summand ) ) )",
  output_range_getter_string := "DirectProduct( a, Coproduct( cat, L ) )",
  with_given_object_position := "both",
  return_type := "morphism" ),

LeftCartesianDistributivityFactoringWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "list_of_objects", "object" ],
  io_type := [ [ "s", "a", "L", "r" ], [ "s", "r" ] ],
  return_type := "morphism" ),

RightCartesianDistributivityExpanding := rec(
  filter_list := [ "category", "list_of_objects", "object" ],
  io_type := [ [ "L", "a" ], [ "s", "r" ] ],
  output_source_getter_string := "DirectProduct( Coproduct( cat, L ), a )",
  output_range_getter_string := "Coproduct( cat, List( L, summand -> DirectProduct( summand, a ) ) )",
  with_given_object_position := "both",
  return_type := "morphism" ),

RightCartesianDistributivityExpandingWithGivenObjects := rec(
  filter_list := [ "category", "object", "list_of_objects", "object", "object" ],
  io_type := [ [ "s", "L", "a", "r" ], [ "s", "r" ] ],
  return_type := "morphism" ),

RightCartesianDistributivityFactoring := rec(
  filter_list := [ "category", "list_of_objects", "object" ],
  io_type := [ [ "L", "a" ], [ "s", "r" ] ],
  output_source_getter_string := "Coproduct( cat, List( L, summand -> DirectProduct( summand, a ) ) )",
  output_range_getter_string := "DirectProduct( Coproduct( cat, L ), a )",
  with_given_object_position := "both",
  return_type := "morphism" ),

RightCartesianDistributivityFactoringWithGivenObjects := rec(
  filter_list := [ "category", "object", "list_of_objects", "object", "object" ],
  io_type := [ [ "s", "L", "a", "r" ], [ "s", "r" ] ],
  return_type := "morphism" ),

) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( DISTRIBUTIVE_CARTESIAN_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_GENERATE_DOCUMENTATION_FROM_METHOD_NAME_RECORD(
    DISTRIBUTIVE_CARTESIAN_CATEGORIES_METHOD_NAME_RECORD,
    "Toposes",
    "DistributiveCartesianCategories.autogen.gd",
    "Cartesian Categories",
    "Add-methods"
);

CAP_INTERNAL_REGISTER_METHOD_NAME_RECORD_OF_PACKAGE( DISTRIBUTIVE_CARTESIAN_CATEGORIES_METHOD_NAME_RECORD, "CartesianCategories" );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( DISTRIBUTIVE_CARTESIAN_CATEGORIES_METHOD_NAME_RECORD );
