# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



InstallValue( CODISTRIBUTIVE_COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD, rec(

LeftCocartesianCodistributivityExpanding := rec(
  filter_list := [ "category", "object", "list_of_objects" ],
  input_arguments_names := [ "cat", "a", "L" ],
  output_source_getter_string := "BinaryCoproduct( cat, a, DirectProduct( cat, L ) )",
  output_source_getter_preconditions := [ [ "DirectProduct", 1 ], [ "Coproduct", 1 ] ],
  output_range_getter_string := "DirectProduct( cat, List( L, summand -> BinaryCoproduct( cat, a, summand ) ) )",
  output_range_getter_preconditions := [ [ "DirectProduct", 1 ], [ "Coproduct", 2 ] ],
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "LeftCartesianDistributivityFactoring",
  dual_arguments_reversed := false,
  # Test in CodistributiveCocartesianCategoriesTest
),

LeftCocartesianCodistributivityExpandingWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "list_of_objects", "object" ],
  input_arguments_names := [ "cat", "s", "a", "L", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "LeftCartesianDistributivityFactoringWithGivenObjects",
  dual_with_given_objects_reversed := true,
  # Test in CodistributiveCocartesianCategoriesTest
),

LeftCocartesianCodistributivityExpandingUsingMultiplicities := rec(
  filter_list := [ "category", "object", "list_of_objects", "list_of_integers" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "L", "M" ],
  output_source_getter_string := "TensorProductOnObjects( cat, a, DirectSum( cat, Concatenation( List( [ 1 .. Length( L ) ], i -> ListWithIdenticalEntries( M[i], L[i] ) ) ) ) )",
  output_source_getter_preconditions := [ [ "TensorProductOnObjects", 1 ], [ "DirectSum", 1 ] ],
  output_range_getter_string := "DirectSum( cat, List( Concatenation( List( [ 1 .. Length( L ) ], i -> ListWithIdenticalEntries( M[i], L[i] ) ) ), summand -> TensorProductOnObjects( cat, a, summand ) ) )",
  output_range_getter_preconditions := [ [ "DirectSum", 1 ], [ "TensorProductOnObjects", 2 ] ],
  with_given_object_position := "both",
  dual_operation := "LeftCartesianDistributivityFactoringUsingMultiplicities",
  dual_arguments_reversed := false,
  # Test in AdditiveMonoidalCategoriesTest
),

LeftCocartesianCodistributivityExpandingUsingMultiplicitiesWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "list_of_objects", "list_of_integers", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "a", "L", "M", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "LeftCartesianDistributivityFactoringUsingMultiplicitiesWithGivenObjects",
  dual_with_given_objects_reversed := true,
),

LeftCocartesianCodistributivityFactoring := rec(
  filter_list := [ "category", "object", "list_of_objects" ],
  input_arguments_names := [ "cat", "a", "L" ],
  output_source_getter_string := "DirectProduct( cat, List( L, summand -> BinaryCoproduct( cat, a, summand ) ) )",
  output_source_getter_preconditions := [ [ "DirectProduct", 1 ], [ "Coproduct", 2 ] ],
  output_range_getter_string := "BinaryCoproduct( cat, a, DirectProduct( cat, L ) )",
  output_range_getter_preconditions := [ [ "DirectProduct", 1 ], [ "Coproduct", 1 ] ],
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "LeftCartesianDistributivityExpanding",
  dual_arguments_reversed := false,
  # Test in CodistributiveCocartesianCategoriesTest
),

LeftCocartesianCodistributivityFactoringWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "list_of_objects", "object" ],
  input_arguments_names := [ "cat", "s", "a", "L", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "LeftCartesianDistributivityExpandingWithGivenObjects",
  dual_with_given_objects_reversed := true,
  # Test in CodistributiveCocartesianCategoriesTest
),

LeftCocartesianCodistributivityFactoringUsingMultiplicities := rec(
  filter_list := [ "category", "object", "list_of_objects", "list_of_integers" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "a", "L", "M" ],
  output_source_getter_string := "DirectSum( cat, List( Concatenation( List( [ 1 .. Length( L ) ], i -> ListWithIdenticalEntries( M[i], L[i] ) ) ), summand -> TensorProductOnObjects( cat, a, summand ) ) )",
  output_source_getter_preconditions := [ [ "DirectSum", 1 ], [ "TensorProductOnObjects", 2 ] ],
  output_range_getter_string := "TensorProductOnObjects( cat, a, DirectSum( cat, Concatenation( List( [ 1 .. Length( L ) ], i -> ListWithIdenticalEntries( M[i], L[i] ) ) ) ) )",
  output_range_getter_preconditions := [ [ "TensorProductOnObjects", 1 ], [ "DirectSum", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "LeftCartesianDistributivityExpandingUsingMultiplicities",
  dual_arguments_reversed := false,
  # Test in AdditiveMonoidalCategoriesTest
),

LeftCocartesianCodistributivityFactoringUsingMultiplicitiesWithGivenObjects := rec(
  filter_list := [ "category", "object", "object", "list_of_objects", "list_of_integers", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "a", "L", "M", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "LeftCartesianDistributivityExpandingUsingMultiplicitiesWithGivenObjects",
  dual_with_given_objects_reversed := true,
),

RightCocartesianCodistributivityExpanding := rec(
  filter_list := [ "category", "list_of_objects", "object" ],
  input_arguments_names := [ "cat", "L", "a" ],
  output_source_getter_string := "BinaryCoproduct( cat, DirectProduct( cat, L ), a )",
  output_source_getter_preconditions := [ [ "DirectProduct", 1 ], [ "Coproduct", 1 ] ],
  output_range_getter_string := "DirectProduct( cat, List( L, summand -> BinaryCoproduct( cat, summand, a ) ) )",
  output_range_getter_preconditions := [ [ "DirectProduct", 1 ], [ "Coproduct", 2 ] ],
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "RightCartesianDistributivityFactoring",
  dual_arguments_reversed := false,
  # Test in CodistributiveCocartesianCategoriesTest
),

RightCocartesianCodistributivityExpandingWithGivenObjects := rec(
  filter_list := [ "category", "object", "list_of_objects", "object", "object" ],
  input_arguments_names := [ "cat", "s", "L", "a", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "RightCartesianDistributivityFactoringWithGivenObjects",
  dual_with_given_objects_reversed := true,
  # Test in CodistributiveCocartesianCategoriesTest
),

RightCocartesianCodistributivityExpandingUsingMultiplicities := rec(
  filter_list := [ "category", "list_of_objects", "list_of_integers", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "L", "M", "a" ],
  output_source_getter_string := "TensorProductOnObjects( cat, DirectSum( cat, Concatenation( List( [ 1 .. Length( L ) ], i -> ListWithIdenticalEntries( M[i], L[i] ) ) ) ), a )",
  output_source_getter_preconditions := [ [ "TensorProductOnObjects", 1 ], [ "DirectSum", 1 ] ],
  output_range_getter_string := "DirectSum( cat, List( Concatenation( List( [ 1 .. Length( L ) ], i -> ListWithIdenticalEntries( M[i], L[i] ) ) ), summand -> TensorProductOnObjects( cat, summand, a ) ) )",
  output_range_getter_preconditions := [ [ "DirectSum", 1 ], [ "TensorProductOnObjects", 2 ] ],
  with_given_object_position := "both",
  dual_operation := "RightCartesianDistributivityFactoringUsingMultiplicities",
  dual_arguments_reversed := false,
  # Test in AdditiveMonoidalCategoriesTest
),

RightCocartesianCodistributivityExpandingUsingMultiplicitiesWithGivenObjects := rec(
  filter_list := [ "category", "object", "list_of_objects", "list_of_integers", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "L", "M", "a", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "RightCartesianDistributivityFactoringUsingMultiplicitiesWithGivenObjects",
  dual_with_given_objects_reversed := true,
),

RightCocartesianCodistributivityFactoring := rec(
  filter_list := [ "category", "list_of_objects", "object" ],
  input_arguments_names := [ "cat", "L", "a" ],
  output_source_getter_string := "DirectProduct( cat, List( L, summand -> BinaryCoproduct( cat, summand, a ) ) )",
  output_source_getter_preconditions := [ [ "DirectProduct", 1 ], [ "Coproduct", 2 ] ],
  output_range_getter_string := "BinaryCoproduct( cat, DirectProduct( cat, L ), a )",
  output_range_getter_preconditions := [ [ "DirectProduct", 1 ], [ "Coproduct", 1 ] ],
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "RightCartesianDistributivityExpanding",
  dual_arguments_reversed := false,
  # Test in CodistributiveCocartesianCategoriesTest
),

RightCocartesianCodistributivityFactoringWithGivenObjects := rec(
  filter_list := [ "category", "object", "list_of_objects", "object", "object" ],
  input_arguments_names := [ "cat", "s", "L", "a", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "RightCartesianDistributivityExpandingWithGivenObjects",
  dual_with_given_objects_reversed := true,
  # Test in CodistributiveCocartesianCategoriesTest
),

RightCocartesianCodistributivityFactoringUsingMultiplicities := rec(
  filter_list := [ "category", "list_of_objects", "list_of_integers", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "L", "M", "a" ],
  output_source_getter_string := "DirectSum( cat, List( Concatenation( List( [ 1 .. Length( L ) ], i -> ListWithIdenticalEntries( M[i], L[i] ) ) ), summand -> TensorProductOnObjects( cat, summand, a ) ) )",
  output_source_getter_preconditions := [ [ "DirectSum", 1 ], [ "TensorProductOnObjects", 2 ] ],
  output_range_getter_string := "TensorProductOnObjects( cat, DirectSum( cat, Concatenation( List( [ 1 .. Length( L ) ], i -> ListWithIdenticalEntries( M[i], L[i] ) ) ) ), a )",
  output_range_getter_preconditions := [ [ "TensorProductOnObjects", 1 ], [ "DirectSum", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "RightCartesianDistributivityExpandingUsingMultiplicities",
  dual_arguments_reversed := false,
  # Test in AdditiveMonoidalCategoriesTest
),

RightCocartesianCodistributivityFactoringUsingMultiplicitiesWithGivenObjects := rec(
  filter_list := [ "category", "object", "list_of_objects", "list_of_integers", "object", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "L", "M", "a", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "RightCartesianDistributivityExpandingUsingMultiplicitiesWithGivenObjects",
  dual_with_given_objects_reversed := true,
),

) );

# collect distributive and codistributive operations
BindGlobal( "DISTRIBUTIVE_CARTESIAN_AND_CODISTRIBUTIVE_COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD", rec( ) );

Perform( RecNames( DISTRIBUTIVE_CARTESIAN_CATEGORIES_METHOD_NAME_RECORD ), function ( name )
    
    DISTRIBUTIVE_CARTESIAN_AND_CODISTRIBUTIVE_COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD.(name) := DISTRIBUTIVE_CARTESIAN_CATEGORIES_METHOD_NAME_RECORD.(name);
    
end );

Perform( RecNames( CODISTRIBUTIVE_COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD ), function ( name )
    
    DISTRIBUTIVE_CARTESIAN_AND_CODISTRIBUTIVE_COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD.(name) := CODISTRIBUTIVE_COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD.(name);
    
end );

CAP_INTERNAL_ENHANCE_NAME_RECORD( DISTRIBUTIVE_CARTESIAN_AND_CODISTRIBUTIVE_COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_GENERATE_DECLARATIONS_AND_INSTALLATIONS_FROM_METHOD_NAME_RECORD(
    DISTRIBUTIVE_CARTESIAN_CATEGORIES_METHOD_NAME_RECORD,
    "CartesianCategories",
    "DistributiveCartesianCategoriesMethodRecord",
    "Cartesian Categories",
    "Add-methods"
);

CAP_INTERNAL_GENERATE_DECLARATIONS_AND_INSTALLATIONS_FROM_METHOD_NAME_RECORD(
    CODISTRIBUTIVE_COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD,
    "CartesianCategories",
    "CodistributiveCocartesianCategoriesMethodRecord",
    "Cocartesian Categories",
    "Add-methods"
);

CAP_INTERNAL_REGISTER_METHOD_NAME_RECORD_OF_PACKAGE( DISTRIBUTIVE_CARTESIAN_AND_CODISTRIBUTIVE_COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD, "CartesianCategories" );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( DISTRIBUTIVE_CARTESIAN_AND_CODISTRIBUTIVE_COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD );
