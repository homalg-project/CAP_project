# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#

InstallValue( CARTESIAN_CATEGORIES_METHOD_NAME_RECORD, rec(

## Basic Operations for Cartesian Categories

CartesianDiagonal := rec(
  filter_list := [ "category", "object", "integer" ],
  input_arguments_names := [ "cat", "a", "n" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_source_getter_string := "a",
  output_range_getter_string := "DirectProduct( cat, ListWithIdenticalEntries( n, a ) )",
  output_range_getter_preconditions := [ [ "DirectProduct", 1 ] ],
  return_type := "morphism",
  dual_operation := "CocartesianCodiagonal",
  dual_arguments_reversed := false,
),

CartesianDiagonalWithGivenCartesianPower := rec(
  filter_list := [ "category", "object", "integer", "object" ],
  input_arguments_names := [ "cat", "a", "n", "cartesian_power" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_source_getter_string := "a",
  output_range_getter_string := "cartesian_power",
  return_type := "morphism",
  dual_operation := "CocartesianCodiagonalWithGivenCocartesianMultiple",
  dual_arguments_reversed := false,
),

DirectProductOnMorphisms := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  input_arguments_names := [ "cat", "alpha", "beta" ],
  output_source_getter_string := "BinaryDirectProduct( cat, Source( alpha ), Source( beta ) )",
  output_source_getter_preconditions := [ [ "DirectProduct", 1 ] ],
  output_range_getter_string := "BinaryDirectProduct( cat, Range( alpha ), Range( beta ) )",
  output_range_getter_preconditions := [ [ "DirectProduct", 1 ] ],
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "CoproductOnMorphisms",
  dual_arguments_reversed := false,
),

DirectProductOnMorphismsWithGivenDirectProducts := rec(
  filter_list := [ "category", "object", "morphism", "morphism", "object" ],
  input_arguments_names := [ "cat", "s", "alpha", "beta", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "CoproductOnMorphismsWithGivenCoproducts",
  dual_with_given_objects_reversed := true,
),

DirectProductOfMorphismAndIdentity := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "alpha", "id_b" ],
  pre_function := function( cat, alpha, id_b )
    if not IsEqualForObjects( cat, Source( id_b ), Range( id_b ) ) or
       not IsCongruentForMorphisms( cat, id_b, IdentityMorphism( cat, Source( id_b ) ) ) then
        
        return [ false, "the second morphism must be an identity morphism" ];
        
    fi;
    
    return [ true ];
    
  end,
  output_source_getter_string := "BinaryDirectProduct( cat, Source( alpha ), Source( id_b ) )",
  output_source_getter_preconditions := [ [ "DirectProduct", 1 ] ],
  output_range_getter_string := "BinaryDirectProduct( cat, Range( alpha ), Range( id_b ) )",
  output_range_getter_preconditions := [ [ "DirectProduct", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "CoproductOfMorphismAndIdentity",
  dual_arguments_reversed := false,
),

DirectProductOfMorphismAndIdentityWithGivenDirectProducts := rec(
  filter_list := [ "category", "object", "morphism", "morphism", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "alpha", "id_b", "r" ],
  pre_function := function( cat, source, alpha, id_b, range )
    if not IsEqualForObjects( cat, Source( id_b ), Range( id_b ) ) or
       not IsCongruentForMorphisms( cat, id_b, IdentityMorphism( cat, Source( id_b ) ) ) then
        
        return [ false, "the second morphism must be an identity morphism" ];
        
    fi;
    
    return [ true ];
    
  end,
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "CoproductOfMorphismAndIdentityWithGivenCoproducts",
  dual_with_given_objects_reversed := true,
),

DirectProductOfIdentityAndMorphism := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "id_a", "beta" ],
  pre_function := function( cat, id_a, beta )
    if not IsEqualForObjects( cat, Source( id_a ), Range( id_a ) ) or
       not IsCongruentForMorphisms( cat, id_a, IdentityMorphism( cat, Source( id_a ) ) ) then
        
        return [ false, "the first morphism must be an identity morphism" ];
        
    fi;
    
    return [ true ];
    
  end,
  output_source_getter_string := "BinaryDirectProduct( cat, Source( id_a ), Source( beta ) )",
  output_source_getter_preconditions := [ [ "DirectProduct", 1 ] ],
  output_range_getter_string := "BinaryDirectProduct( cat, Range( id_a ), Range( beta ) )",
  output_range_getter_preconditions := [ [ "DirectProduct", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "CoproductOfIdentityAndMorphism",
  dual_arguments_reversed := false,
),

DirectProductOfIdentityAndMorphismWithGivenDirectProducts := rec(
  filter_list := [ "category", "object", "morphism", "morphism", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "s", "id_a", "beta", "r" ],
  pre_function := function( cat, source, id_a, beta, range )
    if not IsEqualForObjects( cat, Source( id_a ), Range( id_a ) ) or
       not IsCongruentForMorphisms( cat, id_a, IdentityMorphism( cat, Source( id_a ) ) ) then
        
        return [ false, "the first morphism must be an identity morphism" ];
        
    fi;
    
    return [ true ];
    
  end,
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  dual_operation := "CoproductOfIdentityAndMorphismWithGivenCoproducts",
  dual_with_given_objects_reversed := true,
),

CartesianAssociatorRightToLeft := rec(
  filter_list := [ "category", "object", "object", "object" ],
  input_arguments_names := [ "cat", "a", "b", "c" ],
  output_source_getter_string := "BinaryDirectProduct( cat, a, BinaryDirectProduct( cat, b, c ) )",
  output_source_getter_preconditions := [ [ "DirectProduct", 2 ] ],
  output_range_getter_string := "BinaryDirectProduct( cat, BinaryDirectProduct( cat, a, b ), c )",
  output_range_getter_preconditions := [ [ "DirectProduct", 2 ] ],
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "CocartesianAssociatorLeftToRight",
  dual_arguments_reversed := false,
),

CartesianAssociatorRightToLeftWithGivenDirectProducts := rec(
  filter_list := [ "category", "object", "object", "object", "object", "object" ],
  input_arguments_names := [ "cat", "s", "a", "b", "c", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "CocartesianAssociatorLeftToRightWithGivenCoproducts",
  dual_with_given_objects_reversed := true,
),

CartesianAssociatorLeftToRight := rec(
  filter_list := [ "category", "object", "object", "object" ],
  input_arguments_names := [ "cat", "a", "b", "c" ],
  output_source_getter_string := "BinaryDirectProduct( cat, BinaryDirectProduct( cat, a, b ), c )",
  output_source_getter_preconditions := [ [ "DirectProduct", 2 ] ],
  output_range_getter_string := "BinaryDirectProduct( cat, a, BinaryDirectProduct( cat, b, c ) )",
  output_range_getter_preconditions := [ [ "DirectProduct", 2 ] ],
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "CocartesianAssociatorRightToLeft",
  dual_arguments_reversed := false,
),

CartesianAssociatorLeftToRightWithGivenDirectProducts := rec(
  filter_list := [ "category", "object", "object", "object", "object", "object" ],
  input_arguments_names := [ "cat", "s", "a", "b", "c", "r" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "CocartesianAssociatorRightToLeftWithGivenCoproducts",
  dual_with_given_objects_reversed := true,
),

CartesianLeftUnitor := rec(
  filter_list := [ "category", "object" ],
  input_arguments_names := [ "cat", "a" ],
  output_range_getter_string := "a",
  output_range_getter_preconditions := [ ],
  output_source_getter_string := "BinaryDirectProduct( cat, TerminalObject( cat ), a )",
  output_source_getter_preconditions := [ [ "TerminalObject", 1 ], [ "DirectProduct", 1 ] ],
  output_range_getter_string := "a",
  with_given_object_position := "Source",
  return_type := "morphism",
  dual_operation := "CocartesianLeftUnitorInverse",
),

CartesianLeftUnitorWithGivenDirectProduct := rec(
  filter_list := [ "category", "object", "object" ],
  input_arguments_names := [ "cat", "a", "s" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "a",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "CocartesianLeftUnitorInverseWithGivenCoproduct",
  dual_arguments_reversed := false,
),

CartesianLeftUnitorInverse := rec(
  filter_list := [ "category", "object" ],
  input_arguments_names := [ "cat", "a" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_source_getter_string := "a",
  output_range_getter_string := "BinaryDirectProduct( cat, TerminalObject( cat ), a )",
  output_range_getter_preconditions := [ [ "TerminalObject", 1 ], [ "DirectProduct", 1 ] ],
  with_given_object_position := "Range",
  return_type := "morphism",
  dual_operation := "CocartesianLeftUnitor",
),

CartesianLeftUnitorInverseWithGivenDirectProduct := rec(
  filter_list := [ "category", "object", "object" ],
  input_arguments_names := [ "cat", "a", "r" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "CocartesianLeftUnitorWithGivenCoproduct",
  dual_arguments_reversed := false,
),

CartesianRightUnitor := rec(
  filter_list := [ "category", "object" ],
  input_arguments_names := [ "cat", "a" ],
  output_range_getter_string := "a",
  output_range_getter_preconditions := [ ],
  output_source_getter_string := "BinaryDirectProduct( cat, a, TerminalObject( cat ) )",
  output_source_getter_preconditions := [ [ "TerminalObject", 1 ], [ "DirectProduct", 1 ] ],
  output_range_getter_string := "a",
  with_given_object_position := "Source",
  return_type := "morphism",
  dual_operation := "CocartesianRightUnitorInverse",
),

CartesianRightUnitorWithGivenDirectProduct := rec(
  filter_list := [ "category", "object", "object" ],
  input_arguments_names := [ "cat", "a", "s" ],
  output_source_getter_string := "s",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "a",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "CocartesianRightUnitorInverseWithGivenCoproduct",
  dual_arguments_reversed := false,
),

CartesianRightUnitorInverse := rec(
  filter_list := [ "category", "object" ],
  input_arguments_names := [ "cat", "a" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_source_getter_string := "a",
  output_range_getter_string := "BinaryDirectProduct( cat, a, TerminalObject( cat ) )",
  output_range_getter_preconditions := [ [ "TerminalObject", 1 ], [ "DirectProduct", 1 ] ],
  with_given_object_position := "Range",
  return_type := "morphism",
  dual_operation := "CocartesianRightUnitor",
),

CartesianRightUnitorInverseWithGivenDirectProduct := rec(
  filter_list := [ "category", "object", "object" ],
  input_arguments_names := [ "cat", "a", "r" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "r",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "CocartesianRightUnitorWithGivenCoproduct",
  dual_arguments_reversed := false,
),

) );
