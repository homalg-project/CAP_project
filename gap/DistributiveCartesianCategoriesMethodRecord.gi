# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



InstallValue( DISTRIBUTIVE_CARTESIAN_CATEGORIES_METHOD_NAME_RECORD, rec(

LeftCartesianDistributivityExpanding := rec(
  filter_list := [ "category", "object", "list_of_objects" ],
  io_type := [ [ "a", "L" ], [ "s", "r" ] ],
  output_source_getter_string := "BinaryDirectProduct( cat, a, Coproduct( cat, L ) )",
  output_range_getter_string := "Coproduct( cat, List( L, summand -> BinaryDirectProduct( cat, a, summand ) ) )",
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "LeftCocartesianCodistributivityFactoring",
  dual_arguments_reversed := false,
  # Test in DistributiveCartesianCategoriesTest
),

LeftCartesianDistributivityExpandingWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "list_of_objects", "object" ],
  io_type := [ [ "s", "a", "L", "r" ], [ "s", "r" ] ],
  return_type := "morphism",
  dual_operation := "LeftCocartesianCodistributivityFactoringWithGivenObjects",
  dual_preprocessor_func := { cat, s, a, L, r } -> [ Opposite( cat ), Opposite( r ), Opposite( a ), Opposite( L ), Opposite( s ) ],
  dual_arguments_reversed := false,
  # Test in DistributiveCartesianCategoriesTest
),

LeftCartesianDistributivityFactoring := rec(
  filter_list := [ "category", "object", "list_of_objects" ],
  io_type := [ [ "a", "L" ], [ "s", "r" ] ],
  output_source_getter_string := "Coproduct( cat, List( L, summand -> BinaryDirectProduct( cat, a, summand ) ) )",
  output_range_getter_string := "BinaryDirectProduct( cat, a, Coproduct( cat, L ) )",
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "LeftCocartesianCodistributivityExpanding",
  dual_arguments_reversed := false,
  # Test in DistributiveCartesianCategoriesTest
),

LeftCartesianDistributivityFactoringWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "list_of_objects", "object" ],
  io_type := [ [ "s", "a", "L", "r" ], [ "s", "r" ] ],
  return_type := "morphism",
  dual_operation := "LeftCocartesianCodistributivityExpandingWithGivenObjects",
  dual_preprocessor_func := { cat, s, a, L, r } -> [ Opposite( cat ), Opposite( r ), Opposite( a ), Opposite( L ), Opposite( s ) ],
  dual_arguments_reversed := false,
  # Test in DistributiveCartesianCategoriesTest
),

RightCartesianDistributivityExpanding := rec(
  filter_list := [ "category", "list_of_objects", "object" ],
  io_type := [ [ "L", "a" ], [ "s", "r" ] ],
  output_source_getter_string := "BinaryDirectProduct( cat, Coproduct( cat, L ), a )",
  output_range_getter_string := "Coproduct( cat, List( L, summand -> BinaryDirectProduct( cat, summand, a ) ) )",
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "RightCocartesianCodistributivityFactoring",
  dual_arguments_reversed := false,
  # Test in DistributiveCartesianCategoriesTest
),

RightCartesianDistributivityExpandingWithGivenObjects := rec(
  filter_list := [ "category", "object", "list_of_objects", "object", "object" ],
  io_type := [ [ "s", "L", "a", "r" ], [ "s", "r" ] ],
  return_type := "morphism",
  dual_operation := "RightCocartesianCodistributivityFactoringWithGivenObjects",
  dual_preprocessor_func := { cat, s, L, a, r } -> [ Opposite( cat ), Opposite( r ), Opposite( L ), Opposite( a ), Opposite( s ) ],
  dual_arguments_reversed := false,
  # Test in DistributiveCartesianCategoriesTest
),

RightCartesianDistributivityFactoring := rec(
  filter_list := [ "category", "list_of_objects", "object" ],
  io_type := [ [ "L", "a" ], [ "s", "r" ] ],
  output_source_getter_string := "Coproduct( cat, List( L, summand -> BinaryDirectProduct( cat, summand, a ) ) )",
  output_range_getter_string := "BinaryDirectProduct( cat, Coproduct( cat, L ), a )",
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "RightCocartesianCodistributivityExpanding",
  dual_arguments_reversed := false,
  # Test in DistributiveCartesianCategoriesTest
),

RightCartesianDistributivityFactoringWithGivenObjects := rec(
  filter_list := [ "category", "object", "list_of_objects", "object", "object" ],
  io_type := [ [ "s", "L", "a", "r" ], [ "s", "r" ] ],
  return_type := "morphism",
  dual_operation := "RightCocartesianCodistributivityExpandingWithGivenObjects",
  dual_preprocessor_func := { cat, s, L, a, r } -> [ Opposite( cat ), Opposite( r ), Opposite( L ), Opposite( a ), Opposite( s ) ],
  dual_arguments_reversed := false,
  # Test in DistributiveCartesianCategoriesTest
),

) );
