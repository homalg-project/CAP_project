# THIS FILE WAS AUTOMATICALLY GENERATED
# FROM MonoidalCategories v2021.11-04
# USING CategoryConstructor v2021.11-07

# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Implementations
#

InstallValue( BRAIDED_COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD, rec(

CocartesianBraiding := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "b" ], [ "s", "r" ] ],
  output_source_getter_string := "Coproduct( a, b )",
  output_range_getter_string := "Coproduct( b, a )",
  with_given_object_position := "both",
  return_type := "morphism" ),

CocartesianBraidingWithGivenCoproducts := rec(
  filter_list := [ "category", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "r" ], [ "s", "r" ] ],
  return_type := "morphism" ),

CocartesianBraidingInverse := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "b" ], [ "s", "r" ] ],
  output_source_getter_string := "Coproduct( b, a )",
  output_range_getter_string := "Coproduct( a, b )",
  with_given_object_position := "both",
  return_type := "morphism" ),

CocartesianBraidingInverseWithGivenCoproducts := rec(
  filter_list := [ "category", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "r" ], [ "s", "r" ] ],
  return_type := "morphism" ),

) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( BRAIDED_COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_GENERATE_DOCUMENTATION_FROM_METHOD_NAME_RECORD(
    BRAIDED_COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD,
    "Toposes",
    "BraidedCocartesianCategories.autogen.gd",
    "Cocartesian Categories",
    "Add-methods"
);

CAP_INTERNAL_REGISTER_METHOD_NAME_RECORD_OF_PACKAGE( BRAIDED_COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD, "Toposes" );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( BRAIDED_COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD );
