# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

InstallValue( BRAIDED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD, rec(

Braiding := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "b" ], [ "s", "r" ] ],
  output_source_getter_string := "TensorProductOnObjects( cat, a, b )",
  output_range_getter_string := "TensorProductOnObjects( cat, b, a )",
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "BraidingInverse",
  dual_arguments_reversed := false,
  # Test in BraidedMonoidalCategoriesTest
),

BraidingWithGivenTensorProducts := rec(
  filter_list := [ "category", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "r" ], [ "s", "r" ] ],
  return_type := "morphism",
  dual_operation := "BraidingInverseWithGivenTensorProducts",
  dual_preprocessor_func := { cat, s, a, b, r } -> NTuple( 5, Opposite( cat ), Opposite( r ), Opposite( a ), Opposite( b ), Opposite( s ) ),
  dual_arguments_reversed := false,
  # Test in BraidedMonoidalCategoriesTest
),

BraidingInverse := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "b" ], [ "s", "r" ] ],
  output_source_getter_string := "TensorProductOnObjects( cat, b, a )",
  output_range_getter_string := "TensorProductOnObjects( cat, a, b )",
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "Braiding",
  dual_arguments_reversed := false,
  # Test in BraidedMonoidalCategoriesTest
),

BraidingInverseWithGivenTensorProducts := rec(
  filter_list := [ "category", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "r" ], [ "s", "r" ] ],
  return_type := "morphism",
  dual_operation := "BraidingWithGivenTensorProducts",
  dual_preprocessor_func := { cat, s, a, b, r } -> NTuple( 5, Opposite( cat ), Opposite( s ), Opposite( a ), Opposite( b ), Opposite( r ) ),
  dual_arguments_reversed := false,
  # Test in BraidedMonoidalCategoriesTest
),

) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( BRAIDED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_GENERATE_DOCUMENTATION_FROM_METHOD_NAME_RECORD(
    BRAIDED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD,
    "MonoidalCategories",
    "BraidedMonoidalCategories.autogen.gd",
    "Monoidal Categories",
    "Add-methods"
);

CAP_INTERNAL_REGISTER_METHOD_NAME_RECORD_OF_PACKAGE( BRAIDED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD, "MonoidalCategories" );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( BRAIDED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );
