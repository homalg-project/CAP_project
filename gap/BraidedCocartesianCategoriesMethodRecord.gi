# THIS FILE WAS AUTOMATICALLY GENERATED

# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Implementations
#

InstallValue( BRAIDED_COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD, rec(

CocartesianBraiding := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "b" ], [ "s", "r" ] ],
  output_source_getter_string := "BinaryCoproduct( cat, a, b )",
  output_range_getter_string := "BinaryCoproduct( cat, b, a )",
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "CocartesianBraidingInverse",
  dual_arguments_reversed := false,
),

CocartesianBraidingWithGivenCoproducts := rec(
  filter_list := [ "category", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "r" ], [ "s", "r" ] ],
  return_type := "morphism",
  dual_operation := "CocartesianBraidingInverseWithGivenCoproducts",
  dual_preprocessor_func := { cat, s, a, b, r } -> [ Opposite( cat ), Opposite( r ), Opposite( a ), Opposite( b ), Opposite( s ) ],
  dual_arguments_reversed := false,
),

CocartesianBraidingInverse := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "b" ], [ "s", "r" ] ],
  output_source_getter_string := "BinaryCoproduct( cat, b, a )",
  output_range_getter_string := "BinaryCoproduct( cat, a, b )",
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "CocartesianBraiding",
  dual_arguments_reversed := false,
),

CocartesianBraidingInverseWithGivenCoproducts := rec(
  filter_list := [ "category", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "r" ], [ "s", "r" ] ],
  return_type := "morphism",
  dual_operation := "CocartesianBraidingWithGivenCoproducts",
  dual_preprocessor_func := { cat, s, a, b, r } -> [ Opposite( cat ), Opposite( s ), Opposite( a ), Opposite( b ), Opposite( r ) ],
  dual_arguments_reversed := false,
),

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
