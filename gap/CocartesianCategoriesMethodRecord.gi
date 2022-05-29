# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#

InstallValue( COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD, rec(

## Basic Operations for Cocartesian Categories

CoproductOnMorphisms := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  io_type := [ [ "alpha", "beta" ], [ "s", "r" ] ],
  output_source_getter_string := "BinaryCoproduct( cat, Source( alpha ), Source( beta ) )",
  output_range_getter_string := "BinaryCoproduct( cat, Range( alpha ), Range( beta ) )",
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "DirectProductOnMorphisms",
  dual_arguments_reversed := false,
),

CoproductOnMorphismsWithGivenCoproducts := rec(
  filter_list := [ "category", "object", "morphism", "morphism", "object" ],
  io_type := [ [ "s", "alpha", "beta", "r" ], [ "s", "r" ] ],
  return_type := "morphism",
  dual_operation := "DirectProductOnMorphismsWithGivenDirectProducts",
  dual_preprocessor_func :=
    { cat, s, alpha, beta, r } -> [ Opposite( cat ), Opposite( r ), Opposite( alpha ), Opposite( beta ), Opposite( s ) ],
  dual_arguments_reversed := false,
),

CocartesianAssociatorRightToLeft := rec(
  filter_list := [ "category", "object", "object", "object" ],
  io_type := [ [ "a", "b", "c" ], [ "s", "r" ] ],
  output_source_getter_string := "BinaryCoproduct( cat, a, BinaryCoproduct( cat, b, c ) )",
  output_range_getter_string := "BinaryCoproduct( cat, BinaryCoproduct( cat, a, b ), c )",
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "CartesianAssociatorLeftToRight",
  dual_arguments_reversed := false,
),

CocartesianAssociatorRightToLeftWithGivenCoproducts := rec(
  filter_list := [ "category", "object", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "c", "r" ], [ "s", "r" ] ],
  return_type := "morphism",
  dual_operation := "CartesianAssociatorLeftToRightWithGivenDirectProducts",
  dual_preprocessor_func :=
    { cat, s, a, b, c, r } -> [ Opposite( cat ), Opposite( r ), Opposite( a ), Opposite( b ), Opposite( c ), Opposite( s ) ],
  dual_arguments_reversed := false,
),

CocartesianAssociatorLeftToRight := rec(
  filter_list := [ "category", "object", "object", "object" ],
  io_type := [ [ "a", "b", "c" ], [ "s", "r" ] ],
  output_source_getter_string := "BinaryCoproduct( cat, BinaryCoproduct( cat, a, b ), c )",
  output_range_getter_string := "BinaryCoproduct( cat, a, BinaryCoproduct( cat, b, c ) )",
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "CartesianAssociatorRightToLeft",
  dual_arguments_reversed := false,
),

CocartesianAssociatorLeftToRightWithGivenCoproducts := rec(
  filter_list := [ "category", "object", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "c", "r" ], [ "s", "r" ] ],
  return_type := "morphism",
  dual_operation := "CartesianAssociatorRightToLeftWithGivenDirectProducts",
  dual_preprocessor_func := { cat, s, a, b, c, r } -> [ Opposite( cat ), Opposite( r ), Opposite( a ), Opposite( b ), Opposite( c ), Opposite( s ) ],
  dual_arguments_reversed := false,
),

CocartesianLeftUnitor := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "s", "a" ] ],
  output_source_getter_string := "BinaryCoproduct( cat, InitialObject( cat ), a )",
  output_range_getter_string := "a",
  with_given_object_position := "Source",
  return_type := "morphism",
  dual_operation := "CartesianLeftUnitorInverse",
),

CocartesianLeftUnitorWithGivenCoproduct := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "s" ], [ "s", "a" ] ],
  return_type := "morphism",
  dual_operation := "CartesianLeftUnitorInverseWithGivenDirectProduct",
  dual_arguments_reversed := false,
),

CocartesianLeftUnitorInverse := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "a", "r" ] ],
  output_source_getter_string := "a",
  output_range_getter_string := "BinaryCoproduct( cat, InitialObject( cat ), a )",
  with_given_object_position := "Range",
  return_type := "morphism",
  dual_operation := "CartesianLeftUnitor",
),

CocartesianLeftUnitorInverseWithGivenCoproduct := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "r" ], [ "a", "r" ] ],
  return_type := "morphism",
  dual_operation := "CartesianLeftUnitorWithGivenDirectProduct",
  dual_arguments_reversed := false,
),

CocartesianRightUnitor := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "s", "a" ] ],
  output_source_getter_string := "BinaryCoproduct( cat, a, InitialObject( cat ) )",
  output_range_getter_string := "a",
  with_given_object_position := "Source",
  return_type := "morphism",
  dual_operation := "CartesianRightUnitorInverse",
),

CocartesianRightUnitorWithGivenCoproduct := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "s" ], [ "s", "a" ] ],
  return_type := "morphism",
  dual_operation := "CartesianRightUnitorInverseWithGivenDirectProduct",
  dual_arguments_reversed := false,
),

CocartesianRightUnitorInverse := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "a", "r" ] ],
  output_source_getter_string := "a",
  output_range_getter_string := "BinaryCoproduct( cat, a, InitialObject( cat ) )",
  with_given_object_position := "Range",
  return_type := "morphism",
  dual_operation := "CartesianRightUnitor",
),

CocartesianRightUnitorInverseWithGivenCoproduct := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "r" ], [ "a", "r" ] ],
  return_type := "morphism",
  dual_operation := "CartesianRightUnitorWithGivenDirectProduct",
  dual_arguments_reversed := false,
),

) );

# collect cartesian and cocartesian operations
BindGlobal( "CARTESIAN_AND_COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD", rec( ) );

Perform( RecNames( CARTESIAN_CATEGORIES_METHOD_NAME_RECORD ), function ( name )
    
    CARTESIAN_AND_COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD.(name) := CARTESIAN_CATEGORIES_METHOD_NAME_RECORD.(name);
    
end );

Perform( RecNames( COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD ), function ( name )
    
    CARTESIAN_AND_COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD.(name) := COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD.(name);
    
end );

CAP_INTERNAL_ENHANCE_NAME_RECORD( CARTESIAN_AND_COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_GENERATE_DOCUMENTATION_FROM_METHOD_NAME_RECORD(
    CARTESIAN_CATEGORIES_METHOD_NAME_RECORD,
    "CartesianCategories",
    "CartesianCategories.autogen.gd",
    "Cartesian Categories",
    "Add-methods"
);

CAP_INTERNAL_GENERATE_DOCUMENTATION_FROM_METHOD_NAME_RECORD(
    COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD,
    "CartesianCategories",
    "CocartesianCategories.autogen.gd",
    "Cocartesian Categories",
    "Add-methods"
);

CAP_INTERNAL_REGISTER_METHOD_NAME_RECORD_OF_PACKAGE( CARTESIAN_AND_COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD, "CartesianCategories" );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( CARTESIAN_AND_COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD );
