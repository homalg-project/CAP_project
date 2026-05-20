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

LeftCartesianDistributivityExpandingUsingMultiplicities := rec(
  filter_list := [ "category", "object", "list_of_objects", "list_of_integers" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "L", "M" ],
  output_source_getter_string := "TensorProductOnObjects( cat, a, DirectSum( cat, Concatenation( List( [ 1 .. Length( L ) ], i -> ListWithIdenticalEntries( M[i], L[i] ) ) ) ) )",
  output_source_getter_preconditions := [ [ "TensorProductOnObjects", 1 ], [ "DirectSum", 1 ] ],
  output_range_getter_string := "DirectSum( cat, List( Concatenation( List( [ 1 .. Length( L ) ], i -> ListWithIdenticalEntries( M[i], L[i] ) ) ), summand -> TensorProductOnObjects( cat, a, summand ) ) )",
  output_range_getter_preconditions := [ [ "DirectSum", 1 ], [ "TensorProductOnObjects", 2 ] ],
  with_given_object_position := "both",
  dual_operation := "LeftCocartesianCodistributivityFactoringUsingMultiplicities",
  dual_arguments_reversed := false,
  # Test in AdditiveMonoidalCategoriesTest
),

LeftCartesianDistributivityExpandingUsingMultiplicitiesWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "list_of_objects", "list_of_integers", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "a", "L", "M", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "LeftCocartesianCodistributivityFactoringUsingMultiplicitiesWithGivenObjects",
  dual_with_given_objects_reversed := true,
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

LeftCartesianDistributivityFactoringUsingMultiplicities := rec(
  filter_list := [ "category", "object", "list_of_objects", "list_of_integers" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "L", "M" ],
  output_source_getter_string := "DirectSum( cat, List( Concatenation( List( [ 1 .. Length( L ) ], i -> ListWithIdenticalEntries( M[i], L[i] ) ) ), summand -> TensorProductOnObjects( cat, a, summand ) ) )",
  output_source_getter_preconditions := [ [ "DirectSum", 1 ], [ "TensorProductOnObjects", 2 ] ],
  output_range_getter_string := "TensorProductOnObjects( cat, a, DirectSum( cat, Concatenation( List( [ 1 .. Length( L ) ], i -> ListWithIdenticalEntries( M[i], L[i] ) ) ) ) )",
  output_range_getter_preconditions := [ [ "TensorProductOnObjects", 1 ], [ "DirectSum", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "LeftCocartesianCodistributivityExpandingUsingMultiplicities",
  dual_arguments_reversed := false,
  # Test in AdditiveMonoidalCategoriesTest
),

LeftCartesianDistributivityFactoringUsingMultiplicitiesWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "list_of_objects", "list_of_integers", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "a", "L", "M", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "LeftCocartesianCodistributivityExpandingUsingMultiplicitiesWithGivenObjects",
  dual_with_given_objects_reversed := true,
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

RightCartesianDistributivityExpandingUsingMultiplicities := rec(
  filter_list := [ "category", "list_of_objects", "list_of_integers", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "L", "M", "a" ],
  output_source_getter_string := "TensorProductOnObjects( cat, DirectSum( cat, Concatenation( List( [ 1 .. Length( L ) ], i -> ListWithIdenticalEntries( M[i], L[i] ) ) ) ), a )",
  output_source_getter_preconditions := [ [ "TensorProductOnObjects", 1 ], [ "DirectSum", 1 ] ],
  output_range_getter_string := "DirectSum( cat, List( Concatenation( List( [ 1 .. Length( L ) ], i -> ListWithIdenticalEntries( M[i], L[i] ) ) ), summand -> TensorProductOnObjects( cat, summand, a ) ) )",
  output_range_getter_preconditions := [ [ "DirectSum", 1 ], [ "TensorProductOnObjects", 2 ] ],
  with_given_object_position := "both",
  dual_operation := "RightCocartesianCodistributivityFactoringUsingMultiplicities",
  dual_arguments_reversed := false,
  # Test in AdditiveMonoidalCategoriesTest
),

RightCartesianDistributivityExpandingUsingMultiplicitiesWithGivenObjects := rec(
  filter_list := [ "category", "object", "list_of_objects", "list_of_integers", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "L", "M", "a", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "RightCocartesianCodistributivityFactoringUsingMultiplicitiesWithGivenObjects",
  dual_with_given_objects_reversed := true,
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

RightCartesianDistributivityFactoringUsingMultiplicities := rec(
  filter_list := [ "category", "list_of_objects", "list_of_integers", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "L", "M", "a" ],
  output_source_getter_string := "DirectSum( cat, List( Concatenation( List( [ 1 .. Length( L ) ], i -> ListWithIdenticalEntries( M[i], L[i] ) ) ), summand -> TensorProductOnObjects( cat, summand, a ) ) )",
  output_source_getter_preconditions := [ [ "DirectSum", 1 ], [ "TensorProductOnObjects", 2 ] ],
  output_range_getter_string := "TensorProductOnObjects( cat, DirectSum( cat, Concatenation( List( [ 1 .. Length( L ) ], i -> ListWithIdenticalEntries( M[i], L[i] ) ) ) ), a )",
  output_range_getter_preconditions := [ [ "TensorProductOnObjects", 1 ], [ "DirectSum", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "RightCocartesianCodistributivityExpandingUsingMultiplicities",
  dual_arguments_reversed := false,
  # Test in AdditiveMonoidalCategoriesTest
),

RightCartesianDistributivityFactoringUsingMultiplicitiesWithGivenObjects := rec(
  filter_list := [ "category", "object", "list_of_objects", "list_of_integers", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "L", "M", "a", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "RightCocartesianCodistributivityExpandingUsingMultiplicitiesWithGivenObjects",
  dual_with_given_objects_reversed := true,
),

) );
