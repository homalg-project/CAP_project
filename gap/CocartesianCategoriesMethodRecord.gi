# THIS FILE WAS AUTOMATICALLY GENERATED FROM MonoidalCategories v2021.11-02

# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Implementations
#

InstallValue( COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD, rec(

## Basic Operations for Cocartesian Categories

CoproductOnMorphisms := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  io_type := [ [ "alpha", "beta" ], [ "s", "r" ] ],
  output_source_getter_string := "Coproduct( cat, Source( alpha ), Source( beta ) )",
  output_range_getter_string := "Coproduct( cat, Range( alpha ), Range( beta ) )",
  with_given_object_position := "both",
  return_type := "morphism" ),

CoproductOnMorphismsWithGivenCoproducts := rec(
  filter_list := [ "category", "object", "morphism", "morphism", "object" ],
  io_type := [ [ "s", "alpha", "beta", "r" ], [ "s", "r" ] ],
  return_type := "morphism" ),

CocartesianAssociatorRightToLeft := rec(
  filter_list := [ "category", "object", "object", "object" ],
  io_type := [ [ "a", "b", "c" ], [ "s", "r" ] ],
  output_source_getter_string := "Coproduct( cat, a, Coproduct( cat, b, c ) )",
  output_range_getter_string := "Coproduct( cat, Coproduct( cat, a, b ), c )",
  with_given_object_position := "both",
  return_type := "morphism" ),

CocartesianAssociatorRightToLeftWithGivenCoproducts := rec(
  filter_list := [ "category", "object", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "c", "r" ], [ "s", "r" ] ],
  return_type := "morphism" ),

CocartesianAssociatorLeftToRight := rec(
  filter_list := [ "category", "object", "object", "object" ],
  io_type := [ [ "a", "b", "c" ], [ "s", "r" ] ],
  output_source_getter_string := "Coproduct( cat, Coproduct( cat, a, b ), c )",
  output_range_getter_string := "Coproduct( cat, a, Coproduct( cat, b, c ) )",
  with_given_object_position := "both",
  return_type := "morphism" ),

CocartesianAssociatorLeftToRightWithGivenCoproducts := rec(
  filter_list := [ "category", "object", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "c", "r" ], [ "s", "r" ] ],
  return_type := "morphism" ),

CocartesianLeftUnitor := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "s", "a" ] ],
  output_source_getter_string := "Coproduct( cat, InitialObject( cat ), a )",
  output_range_getter_string := "a",
  with_given_object_position := "Source",
  return_type := "morphism" ),

CocartesianLeftUnitorWithGivenCoproduct := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "s" ], [ "s", "a" ] ],
  return_type := "morphism" ),

CocartesianLeftUnitorInverse := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "a", "r" ] ],
  output_source_getter_string := "a",
  output_range_getter_string := "Coproduct( cat, InitialObject( cat ), a )",
  with_given_object_position := "Range",
  return_type := "morphism" ),

CocartesianLeftUnitorInverseWithGivenCoproduct := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "r" ], [ "a", "r" ] ],
  return_type := "morphism" ),

CocartesianRightUnitor := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "s", "a" ] ],
  output_source_getter_string := "Coproduct( cat, a, InitialObject( cat ) )",
  output_range_getter_string := "a",
  with_given_object_position := "Source",
  return_type := "morphism" ),

CocartesianRightUnitorWithGivenCoproduct := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "s" ], [ "s", "a" ] ],
  return_type := "morphism" ),

CocartesianRightUnitorInverse := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "a", "r" ] ],
  output_source_getter_string := "a",
  output_range_getter_string := "Coproduct( cat, a, InitialObject( cat ) )",
  with_given_object_position := "Range",
  return_type := "morphism" ),

CocartesianRightUnitorInverseWithGivenCoproduct := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "r" ], [ "a", "r" ] ],
  return_type := "morphism" ),

) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_GENERATE_DOCUMENTATION_FROM_METHOD_NAME_RECORD(
    COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD,
    "Toposes",
    "CocartesianCategories.autogen.gd",
    "Cocartesian Categories",
    "Add-methods"
);

CAP_INTERNAL_REGISTER_METHOD_NAME_RECORD_OF_PACKAGE( COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD, "CocartesianCategories" );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD );
