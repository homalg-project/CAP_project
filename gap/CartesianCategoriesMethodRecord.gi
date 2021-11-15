# THIS FILE WAS AUTOMATICALLY GENERATED FROM MonoidalCategories v2021.11-02

# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Implementations
#

InstallValue( CARTESIAN_CATEGORIES_METHOD_NAME_RECORD, rec(

## Basic Operations for Cartesian Categories

DirectProductOnMorphisms := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  io_type := [ [ "alpha", "beta" ], [ "s", "r" ] ],
  output_source_getter_string := "DirectProduct( Source( alpha ), Source( beta ) )",
  output_range_getter_string := "DirectProduct( Range( alpha ), Range( beta ) )",
  with_given_object_position := "both",
  return_type := "morphism" ),

DirectProductOnMorphismsWithGivenDirectProducts := rec(
  filter_list := [ "category", "object", "morphism", "morphism", "object" ],
  io_type := [ [ "s", "alpha", "beta", "r" ], [ "s", "r" ] ],
  return_type := "morphism" ),

CartesianAssociatorRightToLeft := rec(
  filter_list := [ "category", "object", "object", "object" ],
  io_type := [ [ "a", "b", "c" ], [ "s", "r" ] ],
  output_source_getter_string := "DirectProduct( a, DirectProduct( b, c ) )",
  output_range_getter_string := "DirectProduct( DirectProduct( a, b ), c )",
  with_given_object_position := "both",
  return_type := "morphism" ),

CartesianAssociatorRightToLeftWithGivenDirectProducts := rec(
  filter_list := [ "category", "object", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "c", "r" ], [ "s", "r" ] ],
  return_type := "morphism" ),

CartesianAssociatorLeftToRight := rec(
  filter_list := [ "category", "object", "object", "object" ],
  io_type := [ [ "a", "b", "c" ], [ "s", "r" ] ],
  output_source_getter_string := "DirectProduct( DirectProduct( a, b ), c )",
  output_range_getter_string := "DirectProduct( a, DirectProduct( b, c ) )",
  with_given_object_position := "both",
  return_type := "morphism" ),

CartesianAssociatorLeftToRightWithGivenDirectProducts := rec(
  filter_list := [ "category", "object", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "c", "r" ], [ "s", "r" ] ],
  return_type := "morphism" ),

CartesianLeftUnitor := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "s", "a" ] ],
  output_source_getter_string := "DirectProduct( TerminalObject( cat ), a )",
  output_range_getter_string := "a",
  with_given_object_position := "Source",
  return_type := "morphism" ),

CartesianLeftUnitorWithGivenDirectProduct := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "s" ], [ "s", "a" ] ],
  return_type := "morphism" ),

CartesianLeftUnitorInverse := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "a", "r" ] ],
  output_source_getter_string := "a",
  output_range_getter_string := "DirectProduct( TerminalObject( cat ), a )",
  with_given_object_position := "Range",
  return_type := "morphism" ),

CartesianLeftUnitorInverseWithGivenDirectProduct := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "r" ], [ "a", "r" ] ],
  return_type := "morphism" ),

CartesianRightUnitor := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "s", "a" ] ],
  output_source_getter_string := "DirectProduct( a, TerminalObject( cat ) )",
  output_range_getter_string := "a",
  with_given_object_position := "Source",
  return_type := "morphism" ),

CartesianRightUnitorWithGivenDirectProduct := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "s" ], [ "s", "a" ] ],
  return_type := "morphism" ),

CartesianRightUnitorInverse := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "a", "r" ] ],
  output_source_getter_string := "a",
  output_range_getter_string := "DirectProduct( a, TerminalObject( cat ) )",
  with_given_object_position := "Range",
  return_type := "morphism" ),

CartesianRightUnitorInverseWithGivenDirectProduct := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "r" ], [ "a", "r" ] ],
  return_type := "morphism" ),

) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( CARTESIAN_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_GENERATE_DOCUMENTATION_FROM_METHOD_NAME_RECORD(
    CARTESIAN_CATEGORIES_METHOD_NAME_RECORD,
    "Toposes",
    "CartesianCategories.autogen.gd",
    "Cartesian Categories",
    "Add-methods"
);

CAP_INTERNAL_REGISTER_METHOD_NAME_RECORD_OF_PACKAGE( CARTESIAN_CATEGORIES_METHOD_NAME_RECORD, "CartesianCategories" );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( CARTESIAN_CATEGORIES_METHOD_NAME_RECORD );
