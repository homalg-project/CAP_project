# THIS FILE WAS AUTOMATICALLY GENERATED
# FROM MonoidalCategories v2021.12-01
# USING CategoryConstructor v2021.12-01

# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Implementations
#

# Preprocessor functions for dual operations
BindGlobal( "PreProcessorFuncCocartesianAssociatorRightToLeftWithGivenCoproducts",
              { cat, s, a, b, c, r } -> [ Opposite( cat ), Opposite( r ), Opposite( a ), Opposite( b ), Opposite( c ), Opposite( s ) ]
);

BindGlobal( "PreProcessorFuncCocartesianAssociatorLeftToRightWithGivenCoproducts",
              { cat, s, a, b, c, r } -> [ Opposite( cat ), Opposite( r ), Opposite( a ), Opposite( b ), Opposite( c ), Opposite( s ) ]
);

InstallValue( COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD, rec(

## Basic Operations for Cocartesian Categories

CoproductOnMorphisms := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  io_type := [ [ "alpha", "beta" ], [ "s", "r" ] ],
  output_source_getter_string := "Coproduct( Source( alpha ), Source( beta ) )",
  output_range_getter_string := "Coproduct( Range( alpha ), Range( beta ) )",
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "CoproductOnMorphisms",
  dual_arguments_reversed := false,
),

CoproductOnMorphismsWithGivenCoproducts := rec(
  filter_list := [ "category", "object", "morphism", "morphism", "object" ],
  io_type := [ [ "s", "alpha", "beta", "r" ], [ "s", "r" ] ],
  return_type := "morphism",
  dual_operation := "CoproductOnMorphismsWithGivenCoproducts",
  dual_arguments_reversed := false,
),

CocartesianAssociatorRightToLeft := rec(
  filter_list := [ "category", "object", "object", "object" ],
  io_type := [ [ "a", "b", "c" ], [ "s", "r" ] ],
  output_source_getter_string := "Coproduct( a, Coproduct( b, c ) )",
  output_range_getter_string := "Coproduct( Coproduct( a, b ), c )",
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "CocartesianAssociatorLeftToRight",
  dual_arguments_reversed := false,
),

CocartesianAssociatorRightToLeftWithGivenCoproducts := rec(
  filter_list := [ "category", "object", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "c", "r" ], [ "s", "r" ] ],
  return_type := "morphism",
  dual_operation := "CocartesianAssociatorLeftToRightWithGivenCoproducts",
  dual_preprocessor_func := PreProcessorFuncCocartesianAssociatorRightToLeftWithGivenCoproducts,
  dual_arguments_reversed := false,
),

CocartesianAssociatorLeftToRight := rec(
  filter_list := [ "category", "object", "object", "object" ],
  io_type := [ [ "a", "b", "c" ], [ "s", "r" ] ],
  output_source_getter_string := "Coproduct( Coproduct( a, b ), c )",
  output_range_getter_string := "Coproduct( a, Coproduct( b, c ) )",
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "CocartesianAssociatorRightToLeft",
  dual_arguments_reversed := false,
),

CocartesianAssociatorLeftToRightWithGivenCoproducts := rec(
  filter_list := [ "category", "object", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "c", "r" ], [ "s", "r" ] ],
  return_type := "morphism",
  dual_operation := "CocartesianAssociatorRightToLeftWithGivenCoproducts",
  dual_preprocessor_func := PreProcessorFuncCocartesianAssociatorLeftToRightWithGivenCoproducts,
  dual_arguments_reversed := false,
),

CocartesianLeftUnitor := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "s", "a" ] ],
  output_source_getter_string := "Coproduct( InitialObject( cat ), a )",
  output_range_getter_string := "a",
  with_given_object_position := "Source",
  return_type := "morphism",
  dual_operation := "CocartesianLeftUnitorInverse",
),

CocartesianLeftUnitorWithGivenCoproduct := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "s" ], [ "s", "a" ] ],
  return_type := "morphism",
  dual_operation := "CocartesianLeftUnitorInverseWithGivenCoproduct",
  dual_arguments_reversed := false,
),

CocartesianLeftUnitorInverse := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "a", "r" ] ],
  output_source_getter_string := "a",
  output_range_getter_string := "Coproduct( InitialObject( cat ), a )",
  with_given_object_position := "Range",
  return_type := "morphism",
  dual_operation := "CocartesianLeftUnitor",
),

CocartesianLeftUnitorInverseWithGivenCoproduct := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "r" ], [ "a", "r" ] ],
  return_type := "morphism",
  dual_operation := "CocartesianLeftUnitorWithGivenCoproduct",
  dual_arguments_reversed := false,
),

CocartesianRightUnitor := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "s", "a" ] ],
  output_source_getter_string := "Coproduct( a, InitialObject( cat ) )",
  output_range_getter_string := "a",
  with_given_object_position := "Source",
  return_type := "morphism",
  dual_operation := "CocartesianRightUnitorInverse",
),

CocartesianRightUnitorWithGivenCoproduct := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "s" ], [ "s", "a" ] ],
  return_type := "morphism",
  dual_operation := "CocartesianRightUnitorInverseWithGivenCoproduct",
  dual_arguments_reversed := false,
),

CocartesianRightUnitorInverse := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "a", "r" ] ],
  output_source_getter_string := "a",
  output_range_getter_string := "Coproduct( a, InitialObject( cat ) )",
  with_given_object_position := "Range",
  return_type := "morphism",
  dual_operation := "CocartesianRightUnitor",
),

CocartesianRightUnitorInverseWithGivenCoproduct := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "r" ], [ "a", "r" ] ],
  return_type := "morphism",
  dual_operation := "CocartesianRightUnitorWithGivenCoproduct",
  dual_arguments_reversed := false,
),

) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_GENERATE_DOCUMENTATION_FROM_METHOD_NAME_RECORD(
    COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD,
    "Toposes",
    "CocartesianCategories.autogen.gd",
    "Cocartesian Categories",
    "Add-methods"
);

CAP_INTERNAL_REGISTER_METHOD_NAME_RECORD_OF_PACKAGE( COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD, "Toposes" );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD );
