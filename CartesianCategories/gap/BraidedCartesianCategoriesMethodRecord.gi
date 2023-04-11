# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#

InstallValue( BRAIDED_CARTESIAN_CATEGORIES_METHOD_NAME_RECORD, rec(

CartesianBraiding := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "b" ], [ "s", "r" ] ],
  output_source_getter_string := "BinaryDirectProduct( cat, a, b )",
  output_source_getter_preconditions := [ [ "DirectProduct", 1 ] ],
  output_range_getter_string := "BinaryDirectProduct( cat, b, a )",
  output_range_getter_preconditions := [ [ "DirectProduct", 1 ] ],
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "CocartesianBraidingInverse",
  dual_arguments_reversed := false,
),

CartesianBraidingWithGivenDirectProducts := rec(
  filter_list := [ "category", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "r" ], [ "s", "r" ] ],
  return_type := "morphism",
  dual_operation := "CocartesianBraidingInverseWithGivenCoproducts",
  dual_with_given_objects_reversed := true,
),

CartesianBraidingInverse := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "b" ], [ "s", "r" ] ],
  output_source_getter_string := "BinaryDirectProduct( cat, b, a )",
  output_source_getter_preconditions := [ [ "DirectProduct", 1 ] ],
  output_range_getter_string := "BinaryDirectProduct( cat, a, b )",
  output_range_getter_preconditions := [ [ "DirectProduct", 1 ] ],
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "CocartesianBraiding",
  dual_arguments_reversed := false,
),

CartesianBraidingInverseWithGivenDirectProducts := rec(
  filter_list := [ "category", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "r" ], [ "s", "r" ] ],
  return_type := "morphism",
  dual_operation := "CocartesianBraidingWithGivenCoproducts",
  dual_with_given_objects_reversed := true,
),

) );
