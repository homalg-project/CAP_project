# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



InstallValue( DISTRIBUTIVE_CARTESIAN_CATEGORIES_METHOD_NAME_RECORD, rec(

LeftCartesianDistributivityExpanding := rec(
  filter_list := [ "category", "object", "list_of_objects" ],
  input_arguments_names := [ "cat", "a", "L" ],
  output_source_getter_string := "BinaryDirectProduct( cat, a, Coproduct( cat, L ) )",
  output_source_getter_preconditions := [ [ "Coproduct", 1 ], [ "DirectProduct", 1 ] ],
  output_range_getter_string := "Coproduct( cat, List( L, summand -> BinaryDirectProduct( cat, a, summand ) ) )",
  output_range_getter_preconditions := [ [ "Coproduct", 1 ], [ "DirectProduct", 2 ] ],
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "LeftCocartesianCodistributivityFactoring",
  dual_arguments_reversed := false,
  # Test in DistributiveCartesianCategoriesTest
),

LeftCartesianDistributivityExpandingWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "list_of_objects", "object" ],
  input_arguments_names := [ "cat", "s", "a", "L", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "LeftCocartesianCodistributivityFactoringWithGivenObjects",
  dual_with_given_objects_reversed := true,
  # Test in DistributiveCartesianCategoriesTest
),

LeftCartesianDistributivityFactoring := rec(
  filter_list := [ "category", "object", "list_of_objects" ],
  input_arguments_names := [ "cat", "a", "L" ],
  output_source_getter_string := "Coproduct( cat, List( L, summand -> BinaryDirectProduct( cat, a, summand ) ) )",
  output_source_getter_preconditions := [ [ "Coproduct", 1 ], [ "DirectProduct", 2 ] ],
  output_range_getter_string := "BinaryDirectProduct( cat, a, Coproduct( cat, L ) )",
  output_range_getter_preconditions := [ [ "Coproduct", 1 ], [ "DirectProduct", 1 ] ],
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "LeftCocartesianCodistributivityExpanding",
  dual_arguments_reversed := false,
  # Test in DistributiveCartesianCategoriesTest
),

LeftCartesianDistributivityFactoringWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "list_of_objects", "object" ],
  input_arguments_names := [ "cat", "s", "a", "L", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "LeftCocartesianCodistributivityExpandingWithGivenObjects",
  dual_with_given_objects_reversed := true,
  # Test in DistributiveCartesianCategoriesTest
),

RightCartesianDistributivityExpanding := rec(
  filter_list := [ "category", "list_of_objects", "object" ],
  input_arguments_names := [ "cat", "L", "a" ],
  output_source_getter_string := "BinaryDirectProduct( cat, Coproduct( cat, L ), a )",
  output_source_getter_preconditions := [ [ "Coproduct", 1 ], [ "DirectProduct", 1 ] ],
  output_range_getter_string := "Coproduct( cat, List( L, summand -> BinaryDirectProduct( cat, summand, a ) ) )",
  output_range_getter_preconditions := [ [ "Coproduct", 1 ], [ "DirectProduct", 2 ] ],
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "RightCocartesianCodistributivityFactoring",
  dual_arguments_reversed := false,
  # Test in DistributiveCartesianCategoriesTest
),

RightCartesianDistributivityExpandingWithGivenObjects := rec(
  filter_list := [ "category", "object", "list_of_objects", "object", "object" ],
  input_arguments_names := [ "cat", "s", "L", "a", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "RightCocartesianCodistributivityFactoringWithGivenObjects",
  dual_with_given_objects_reversed := true,
  # Test in DistributiveCartesianCategoriesTest
),

RightCartesianDistributivityFactoring := rec(
  filter_list := [ "category", "list_of_objects", "object" ],
  input_arguments_names := [ "cat", "L", "a" ],
  output_source_getter_string := "Coproduct( cat, List( L, summand -> BinaryDirectProduct( cat, summand, a ) ) )",
  output_source_getter_preconditions := [ [ "Coproduct", 1 ], [ "DirectProduct", 2 ] ],
  output_range_getter_string := "BinaryDirectProduct( cat, Coproduct( cat, L ), a )",
  output_range_getter_preconditions := [ [ "Coproduct", 1 ], [ "DirectProduct", 1 ] ],
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "RightCocartesianCodistributivityExpanding",
  dual_arguments_reversed := false,
  # Test in DistributiveCartesianCategoriesTest
),

RightCartesianDistributivityFactoringWithGivenObjects := rec(
  filter_list := [ "category", "object", "list_of_objects", "object", "object" ],
  input_arguments_names := [ "cat", "s", "L", "a", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "RightCocartesianCodistributivityExpandingWithGivenObjects",
  dual_with_given_objects_reversed := true,
  # Test in DistributiveCartesianCategoriesTest
),

) );
