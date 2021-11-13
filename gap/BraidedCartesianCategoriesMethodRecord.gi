# THIS FILE WAS AUTOMATICALLY GENERATED FROM MonoidalCategories v2021.11-02

# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Implementations
#

InstallValue( BRAIDED_CARTESIAN_CATEGORIES_METHOD_NAME_RECORD, rec(

CartesianBraiding := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "b" ], [ "s", "r" ] ],
  output_source_getter_string := "DirectProduct( cat, a, b )",
  output_range_getter_string := "DirectProduct( cat, b, a )",
  with_given_object_position := "both",
  return_type := "morphism" ),

CartesianBraidingWithGivenDirectProducts := rec(
  filter_list := [ "category", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "r" ], [ "s", "r" ] ],
  return_type := "morphism" ),

CartesianBraidingInverse := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "b" ], [ "s", "r" ] ],
  output_source_getter_string := "DirectProduct( cat, b, a )",
  output_range_getter_string := "DirectProduct( cat, a, b )",
  with_given_object_position := "both",
  return_type := "morphism" ),

CartesianBraidingInverseWithGivenDirectProducts := rec(
  filter_list := [ "category", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "r" ], [ "s", "r" ] ],
  return_type := "morphism" ),

) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( BRAIDED_CARTESIAN_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_GENERATE_DOCUMENTATION_FROM_METHOD_NAME_RECORD(
    BRAIDED_CARTESIAN_CATEGORIES_METHOD_NAME_RECORD,
    "Toposes",
    "BraidedCartesianCategories.autogen.gd",
    "Cartesian Categories",
    "Add-methods"
);

CAP_INTERNAL_REGISTER_METHOD_NAME_RECORD_OF_PACKAGE( BRAIDED_CARTESIAN_CATEGORIES_METHOD_NAME_RECORD, "CartesianCategories" );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( BRAIDED_CARTESIAN_CATEGORIES_METHOD_NAME_RECORD );
