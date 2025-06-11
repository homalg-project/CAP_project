# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#
BindGlobal( "CAP_INTERNAL_CORE_METHOD_NAME_RECORD", rec(
ObjectConstructor := rec(
  filter_list := [ "category", "object_datum" ],
  return_type := "object",
  compatible_with_congruence_of_morphisms := false,
),

ObjectDatum := rec(
  filter_list := [ "category", "object" ],
  return_type := "object_datum",
),

MorphismConstructor := rec(
  filter_list := [ "category", "object", "morphism_datum", "object" ],
  return_type := "morphism",
  compatible_with_congruence_of_morphisms := false,
),

MorphismDatum := rec(
  filter_list := [ "category", "morphism" ],
  return_type := "morphism_datum",
  compatible_with_congruence_of_morphisms := false,
),

SetOfObjectsOfCategory := rec(
  filter_list := [ "category" ],
  return_type := "list_of_objects",
  dual_operation := "SetOfObjectsOfCategory",
),

SetOfMorphismsOfFiniteCategory := rec(
  filter_list := [ "category" ],
  return_type := "list_of_morphisms",
  dual_operation := "SetOfMorphismsOfFiniteCategory",
),

LiftAlongMonomorphism := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  input_arguments_names := [ "cat", "iota", "tau" ],
  output_source_getter_string := "Source( tau )",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "Source( iota )",
  output_range_getter_preconditions := [ ],
  pre_function := function( cat, iota, tau )
    
    if not IsEqualForObjects( cat, Range( iota ), Range( tau ) ) then
        
        return [ false, "the two morphisms must have equal ranges" ];
        
    fi;
    
    return [ true ];
  end,
  return_type := "morphism",
  dual_operation := "ColiftAlongEpimorphism",
  compatible_with_congruence_of_morphisms := true,
),

IsLiftableAlongMonomorphism := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  pre_function := function( cat, iota, tau )
    
    if not IsEqualForObjects( cat, Range( iota ), Range( tau ) ) then
        
        return [ false, "the two morphisms must have equal ranges" ];
        
    fi;
    
    return [ true ];
  end,
  return_type := "bool",
  dual_operation := "IsColiftableAlongEpimorphism",
  compatible_with_congruence_of_morphisms := true,
),

ColiftAlongEpimorphism := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  input_arguments_names := [ "cat", "epsilon", "tau" ],
  output_source_getter_string := "Range( epsilon )",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "Range( tau )",
  output_range_getter_preconditions := [ ],
  pre_function := function( cat, epsilon, tau )
    
    if not IsEqualForObjects( cat, Source( epsilon ), Source( tau ) ) then
        
        return [ false, "the two morphisms must have equal sources" ];
        
    fi;
    
    return [ true ];
  end,
  return_type := "morphism",
  dual_operation := "LiftAlongMonomorphism",
  compatible_with_congruence_of_morphisms := true,
),

IsColiftableAlongEpimorphism := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  pre_function := function( cat, epsilon, tau )
    
    if not IsEqualForObjects( cat, Source( epsilon ), Source( tau ) ) then
        
        return [ false, "the two morphisms must have equal sources" ];
        
    fi;
    
    return [ true ];
  end,
  return_type := "bool",
  dual_operation := "IsLiftableAlongMonomorphism",
  compatible_with_congruence_of_morphisms := true,
),

Lift := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  input_arguments_names := [ "cat", "alpha", "beta" ],
  output_source_getter_string := "Source( alpha )",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "Source( beta )",
  output_range_getter_preconditions := [ ],
  pre_function := function( cat, iota, tau )
    
    if not IsEqualForObjects( cat, Range( iota ), Range( tau ) ) then
        
        return [ false, "the two morphisms must have equal ranges" ];
        
    fi;
    
    return [ true ];
  end,
  return_type := "morphism",
  dual_operation := "Colift",
  dual_arguments_reversed := true,
  is_merely_set_theoretic := true,
  compatible_with_congruence_of_morphisms := false,
),

IsLiftable := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  pre_function := "Lift",
  return_type := "bool",
  dual_operation := "IsColiftable",
  dual_arguments_reversed := true,
  compatible_with_congruence_of_morphisms := false,
),

Colift := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  input_arguments_names := [ "cat", "alpha", "beta" ],
  output_source_getter_string := "Range( alpha )",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "Range( beta )",
  output_range_getter_preconditions := [ ],
  pre_function := function( cat, epsilon, tau )
    
    if not IsEqualForObjects( cat, Source( epsilon ), Source( tau ) ) then
        
        return [ false, "the two morphisms must have equal sources" ];
        
    fi;
    
    return [ true ];
  end,
  return_type := "morphism",
  dual_operation := "Lift",
  dual_arguments_reversed := true,
  is_merely_set_theoretic := true,
  compatible_with_congruence_of_morphisms := false,
),

IsColiftable := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  pre_function := "Colift",
  return_type := "bool",
  dual_operation := "IsLiftable",
  dual_arguments_reversed := true,
  compatible_with_congruence_of_morphisms := false,
),

ProjectiveLift := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  input_arguments_names := [ "cat", "alpha", "beta" ],
  output_source_getter_string := "Source( alpha )",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "Source( beta )",
  output_range_getter_preconditions := [ ],
  pre_function := function( cat, iota, tau )
    
    if not IsEqualForObjects( cat, Range( iota ), Range( tau ) ) then
        
        return [ false, "the two morphisms must have equal ranges" ];
        
    fi;
    
    return [ true ];
  end,
  return_type := "morphism",
  dual_arguments_reversed := true,
  dual_operation := "InjectiveColift",
  compatible_with_congruence_of_morphisms := false,
),

InjectiveColift := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  input_arguments_names := [ "cat", "alpha", "beta" ],
  output_source_getter_string := "Range( alpha )",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "Range( beta )",
  output_range_getter_preconditions := [ ],
  pre_function := function( cat, epsilon, tau )
    
    if not IsEqualForObjects( cat, Source( epsilon ), Source( tau ) ) then
        
        return [ false, "the two morphisms must have equal sources" ];
        
    fi;
    
    return [ true ];
  end,
  return_type := "morphism",
  dual_arguments_reversed := true,
  dual_operation := "ProjectiveLift",
  compatible_with_congruence_of_morphisms := false,
),

IdentityMorphism := rec(
  filter_list := [ "category", "object" ],
  input_arguments_names := [ "cat", "a" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "a",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "IdentityMorphism" ),

InverseForMorphisms := rec(
# Type check for IsIsomorphism
  filter_list := [ "category", "morphism" ],
  input_arguments_names := [ "cat", "alpha" ],
  output_source_getter_string := "Range( alpha )",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "Source( alpha )",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "InverseForMorphisms",
  compatible_with_congruence_of_morphisms := true,
),

PreInverseForMorphisms := rec(
  filter_list := [ "category", "morphism" ],
  input_arguments_names := [ "cat", "alpha" ],
  output_source_getter_string := "Range( alpha )",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "Source( alpha )",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "PostInverseForMorphisms",
  is_merely_set_theoretic := true
),

PostInverseForMorphisms := rec(
  filter_list := [ "category", "morphism" ],
  input_arguments_names := [ "cat", "alpha" ],
  output_source_getter_string := "Range( alpha )",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "Source( alpha )",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "PreInverseForMorphisms",
  is_merely_set_theoretic := true
),

KernelObject := rec(
  filter_list := [ "category", "morphism" ],
  input_arguments_names := [ "cat", "alpha" ],
  return_type := "object",
  dual_operation := "CokernelObject",
  compatible_with_congruence_of_morphisms := false,
  functorial := "KernelObjectFunctorial",
),

KernelEmbedding := rec(
  filter_list := [ "category", "morphism" ],
  input_arguments_names := [ "cat", "alpha" ],
  output_range_getter_string := "Source( alpha )",
  output_range_getter_preconditions := [ ],
  with_given_object_position := "Source",
  return_type := "morphism",
  dual_operation := "CokernelProjection",
  compatible_with_congruence_of_morphisms := false,
),

KernelEmbeddingWithGivenKernelObject := rec(
  filter_list := [ "category", "morphism", "object" ],
  input_arguments_names := [ "cat", "alpha", "P" ],
  output_source_getter_string := "P",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "Source( alpha )",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "CokernelProjectionWithGivenCokernelObject",
  compatible_with_congruence_of_morphisms := false,
),

MorphismFromKernelObjectToSink := rec(
  filter_list := [ "category", "morphism" ],
  input_arguments_names := [ "cat", "alpha" ],
  output_range_getter_string := "Range( alpha )",
  output_range_getter_preconditions := [ ],
  with_given_object_position := "Source",
  dual_operation := "MorphismFromSourceToCokernelObject",
  return_type := "morphism",
  compatible_with_congruence_of_morphisms := false,
),

MorphismFromKernelObjectToSinkWithGivenKernelObject := rec(
  filter_list := [ "category", "morphism", "object" ],
  input_arguments_names := [ "cat", "alpha", "P" ],
  output_source_getter_string := "P",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "Range( alpha )",
  output_range_getter_preconditions := [ ],
  dual_operation := "MorphismFromSourceToCokernelObjectWithGivenCokernelObject",
  return_type := "morphism",
  compatible_with_congruence_of_morphisms := false,
),

KernelLift := rec(
  filter_list := [ "category", "morphism", "object", "morphism" ],
  input_arguments_names := [ "cat", "alpha", "T", "tau" ],
  output_source_getter_string := "T",
  output_source_getter_preconditions := [ ],
  with_given_object_position := "Range",
  return_type := "morphism",
  dual_operation := "CokernelColift",
  compatible_with_congruence_of_morphisms := false,
),

KernelLiftWithGivenKernelObject := rec(
  filter_list := [ "category", "morphism", "object", "morphism", "object" ],
  input_arguments_names := [ "cat", "alpha", "T", "tau", "P" ],
  output_source_getter_string := "T",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "P",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "CokernelColiftWithGivenCokernelObject",
  compatible_with_congruence_of_morphisms := false,
),

CokernelObject := rec(
  filter_list := [ "category", "morphism" ],
  input_arguments_names := [ "cat", "alpha" ],
  return_type := "object",
  dual_operation := "KernelObject",
  compatible_with_congruence_of_morphisms := false,
  functorial := "CokernelObjectFunctorial",
),

CokernelProjection := rec(
  filter_list := [ "category", "morphism" ],
  input_arguments_names := [ "cat", "alpha" ],
  output_source_getter_string := "Range( alpha )",
  output_source_getter_preconditions := [ ],
  with_given_object_position := "Range",
  return_type := "morphism",
  dual_operation := "KernelEmbedding",
  compatible_with_congruence_of_morphisms := false,
),

CokernelProjectionWithGivenCokernelObject := rec(
  filter_list := [ "category", "morphism", "object" ],
  input_arguments_names := [ "cat", "alpha", "P" ],
  output_source_getter_string := "Range( alpha )",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "P",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "KernelEmbeddingWithGivenKernelObject",
  compatible_with_congruence_of_morphisms := false,
),

MorphismFromSourceToCokernelObject := rec(
  filter_list := [ "category", "morphism" ],
  input_arguments_names := [ "cat", "alpha" ],
  output_source_getter_string := "Source( alpha )",
  output_source_getter_preconditions := [ ],
  with_given_object_position := "Range",
  dual_operation := "MorphismFromKernelObjectToSink",
  return_type := "morphism",
  compatible_with_congruence_of_morphisms := false,
),

MorphismFromSourceToCokernelObjectWithGivenCokernelObject := rec(
  filter_list := [ "category", "morphism", "object" ],
  input_arguments_names := [ "cat", "alpha", "P" ],
  output_source_getter_string := "Source( alpha )",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "P",
  output_range_getter_preconditions := [ ],
  dual_operation := "MorphismFromKernelObjectToSinkWithGivenKernelObject",
  return_type := "morphism",
  compatible_with_congruence_of_morphisms := false,
),

CokernelColift := rec(
  filter_list := [ "category", "morphism", "object", "morphism" ],
  input_arguments_names := [ "cat", "alpha", "T", "tau" ],
  output_range_getter_string := "T",
  output_range_getter_preconditions := [ ],
  with_given_object_position := "Source",
  return_type := "morphism",
  dual_operation := "KernelLift",
  compatible_with_congruence_of_morphisms := false,
),

CokernelColiftWithGivenCokernelObject := rec(
  filter_list := [ "category", "morphism", "object", "morphism", "object" ],
  input_arguments_names := [ "cat", "alpha", "T", "tau", "P" ],
  output_source_getter_string := "P",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "T",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "KernelLiftWithGivenKernelObject",
  compatible_with_congruence_of_morphisms := false,
),

PreCompose := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  input_arguments_names := [ "cat", "alpha", "beta" ],
  output_source_getter_string := "Source( alpha )",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "Range( beta )",
  output_range_getter_preconditions := [ ],
  
  pre_function := function( cat, mor_left, mor_right )
    
    if not IsEqualForObjects( cat, Range( mor_left ), Source( mor_right ) ) then
        
        return [ false, "morphisms not composable" ];
        
    fi;
    
    return [ true ];
  end,
  return_type := "morphism",
  dual_operation := "PostCompose",
  compatible_with_congruence_of_morphisms := true,
),

SumOfMorphisms := rec(
  filter_list := [ "category", "object", "list_of_morphisms", "object" ],
  input_arguments_names := [ "cat", "source", "list_of_morphisms", "range" ],
  pre_function := function( cat, source, list_of_morphisms, range )
    local m;
    
    for m in list_of_morphisms do
        
        if not IsEqualForObjects( cat, source, Source( m ) ) or not IsEqualForObjects( cat, range, Range( m ) ) then
            
            return [ false, "some of the morphisms are not compatible with the provided source and range objects" ];
            
        fi;
        
    od;
    
    return [ true ];
    
  end,
  return_type := "morphism",
  output_source_getter_string := "source",
  output_range_getter_string := "range",
  dual_operation := "SumOfMorphisms",
  dual_arguments_reversed := true,
  compatible_with_congruence_of_morphisms := true,
),

LinearCombinationOfMorphisms := rec(
  filter_list := [ "category", "object", "list_of_elements_of_commutative_ring_of_linear_structure", "list_of_morphisms", "object" ],
  input_arguments_names := [ "cat", "source", "list_of_ring_elements", "list_of_morphisms", "range" ],
  pre_function := function( cat, source, list_of_ring_elements, list_of_morphisms, range )
    local m;
    
    if not Length( list_of_ring_elements ) = Length( list_of_morphisms ) then
        
        return [ false, "the length of the lists of coefficients and morphisms must be the same" ];
        
    fi;
    
    for m in list_of_morphisms do
        
        if not IsEqualForObjects( cat, source, Source( m ) ) or not IsEqualForObjects( cat, range, Range( m ) ) then
            
            return [ false, "some of the morphisms are not compatible with the provided source and range objects" ];
            
        fi;
        
    od;
    
    return [ true ];
    
  end,
  return_type := "morphism",
  output_source_getter_string := "source",
  output_range_getter_string := "range",
  dual_operation := "LinearCombinationOfMorphisms",
  dual_preprocessor_func := function( arg )
      local list;
      list := CAP_INTERNAL_OPPOSITE_RECURSIVE( arg );
      return NTuple( 5, list[1], list[5], list[3], list[4], list[2] );
  end,
  compatible_with_congruence_of_morphisms := true,
),

PreComposeList := rec(
  filter_list := [ "category", "object", "list_of_morphisms", "object" ],
  input_arguments_names := [ "cat", "source", "list_of_morphisms", "range" ],
  pre_function := function( cat, source, list_of_morphisms, range )
    local i;
    
    if IsEmpty( list_of_morphisms ) then
        
        if not IsEqualForObjects( cat, source, range ) then
            
            return [ false, "the given source and range are not equal while the given list of morphisms to compose is empty" ];
            
        fi;
        
    else
        
        if not IsEqualForObjects( cat, source, Source( First( list_of_morphisms ) ) ) then
            
            return [ false, "the given source is not equal to the source of the first morphism" ];
            
        elif not IsEqualForObjects( cat, range, Range( Last( list_of_morphisms ) ) ) then
            
            return [ false, "the given range is not equal to the range of the last morphism" ];
            
        fi;
        
    fi;
    
    for i in [ 1 .. Length( list_of_morphisms ) - 1 ] do
        
        if not IsEqualForObjects( cat, Range( list_of_morphisms[i] ), Source( list_of_morphisms[i + 1] ) ) then
            
            return [ false, "morphisms not composable" ];
            
        fi;
        
    od;
    
    return [ true ];
    
  end,
  return_type := "morphism",
  output_source_getter_string := "source",
  output_range_getter_string := "range",
  dual_operation := "PostComposeList",
  dual_arguments_reversed := true,
  compatible_with_congruence_of_morphisms := true,
),

PostCompose := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  input_arguments_names := [ "cat", "beta", "alpha" ],
  output_source_getter_string := "Source( alpha )",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "Range( beta )",
  output_range_getter_preconditions := [ ],
  
  pre_function := function( cat, mor_right, mor_left )
    
    if not IsEqualForObjects( cat, Range( mor_left ), Source( mor_right ) ) then
        
        return [ false, "morphisms not composable" ];
        
    fi;
    
    return [ true ];
  end,
  
  return_type := "morphism",
  dual_operation := "PreCompose",
  compatible_with_congruence_of_morphisms := true,
),

PostComposeList := rec(
  filter_list := [ "category", "object", "list_of_morphisms", "object" ],
  input_arguments_names := [ "cat", "source", "list_of_morphisms", "range" ],
  pre_function := function( cat, source, list_of_morphisms, range )
    local i;
    
    if IsEmpty( list_of_morphisms ) then
        
        if not IsEqualForObjects( cat, source, range ) then
            
            return [ false, "the given source and range are not equal while the given list of morphisms to compose is empty" ];
            
        fi;
        
    else
        
        if not IsEqualForObjects( cat, source, Source( Last( list_of_morphisms ) ) ) then
            
            return [ false, "the given source is not equal to the source of the last morphism" ];
            
        elif not IsEqualForObjects( cat, range, Range( First( list_of_morphisms ) ) ) then
            
            return [ false, "the given range is not equal to the range of the first morphism" ];
            
        fi;
        
    fi;
    
    for i in [ 1 .. Length( list_of_morphisms ) - 1 ] do
        
        if not IsEqualForObjects( cat, Range( list_of_morphisms[i + 1] ), Source( list_of_morphisms[i] ) ) then
            
            return [ false, "morphisms not composable" ];
            
        fi;
        
    od;
    
    return [ true ];
    
  end,
  return_type := "morphism",
  output_source_getter_string := "source",
  output_range_getter_string := "range",
  dual_operation := "PreComposeList",
  dual_arguments_reversed := true,
  compatible_with_congruence_of_morphisms := true,
),

ZeroObject := rec(
  filter_list := [ "category" ],
  input_arguments_names := [ "cat" ],
  return_type := "object",
  dual_operation := "ZeroObject",
  functorial := "ZeroObjectFunctorial",
),

ZeroObjectFunctorial := rec(
  filter_list := [ "category" ],
  input_arguments_names := [ "cat" ],
  return_type := "morphism",
  output_source_getter_string := "ZeroObject( cat )",
  output_source_getter_preconditions := [ [ "ZeroObject", 1 ] ],
  output_range_getter_string := "ZeroObject( cat )",
  output_range_getter_preconditions := [ [ "ZeroObject", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "ZeroObjectFunctorial",
  dual_arguments_reversed := true
),

ZeroObjectFunctorialWithGivenZeroObjects := rec(
  filter_list := [ "category", "object", "object" ],
  input_arguments_names := [ "cat", "P", "Pp" ],
  output_source_getter_string := "P",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "Pp",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "ZeroObjectFunctorialWithGivenZeroObjects",
  dual_arguments_reversed := true
),

UniversalMorphismFromZeroObject := rec(
  filter_list := [ "category", "object" ],
  input_arguments_names := [ "cat", "T" ],
  output_range_getter_string := "T",
  output_range_getter_preconditions := [ ],
  with_given_object_position := "Source",
  return_type := "morphism",
  dual_operation := "UniversalMorphismIntoZeroObject" ),
  
UniversalMorphismFromZeroObjectWithGivenZeroObject := rec(
  filter_list := [ "category", "object", "object" ],
  input_arguments_names := [ "cat", "T", "P" ],
  output_source_getter_string := "P",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "T",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "UniversalMorphismIntoZeroObjectWithGivenZeroObject" ),

UniversalMorphismIntoZeroObject := rec(
  filter_list := [ "category", "object" ],
  input_arguments_names := [ "cat", "T" ],
  output_source_getter_string := "T",
  output_source_getter_preconditions := [ ],
  with_given_object_position := "Range",
  return_type := "morphism",
  dual_operation := "UniversalMorphismFromZeroObject" ),

UniversalMorphismIntoZeroObjectWithGivenZeroObject := rec(
  filter_list := [ "category", "object", "object" ],
  input_arguments_names := [ "cat", "T", "P" ],
  output_source_getter_string := "T",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "P",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "UniversalMorphismFromZeroObjectWithGivenZeroObject" ),

IsomorphismFromZeroObjectToInitialObject := rec(
  filter_list := [ "category" ],
  return_type := "morphism",
  dual_operation := "IsomorphismFromTerminalObjectToZeroObject",
),

IsomorphismFromInitialObjectToZeroObject := rec(
  filter_list := [ "category" ],
  return_type := "morphism",
  dual_operation := "IsomorphismFromZeroObjectToTerminalObject",
),

IsomorphismFromZeroObjectToTerminalObject := rec(
  filter_list := [ "category" ],
  return_type := "morphism",
  dual_operation := "IsomorphismFromInitialObjectToZeroObject",
),

IsomorphismFromTerminalObjectToZeroObject := rec(
  filter_list := [ "category" ],
  return_type := "morphism",
  dual_operation := "IsomorphismFromZeroObjectToInitialObject",
),

ZeroMorphism := rec(
  filter_list := [ "category", "object", "object" ],
  input_arguments_names := [ "cat", "a", "b" ],
  output_source_getter_string := "a",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "b",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_arguments_reversed := true,
  dual_operation := "ZeroMorphism" ),

DirectSum := rec(
  filter_list := [ "category", "list_of_objects" ],
  input_arguments_names := [ "cat", "objects" ],
  return_type := "object",
  dual_operation := "DirectSum",
  functorial := "DirectSumFunctorial",
),

ProjectionInFactorOfDirectSum := rec(
  filter_list := [ "category", "list_of_objects", "integer" ],
  input_arguments_names := [ "cat", "objects", "k" ],
  output_range_getter_string := "objects[k]",
  output_range_getter_preconditions := [ ],
  with_given_object_position := "Source",
  return_type := "morphism",
  dual_operation := "InjectionOfCofactorOfDirectSum" ),

ProjectionInFactorOfDirectSumWithGivenDirectSum := rec(
  filter_list := [ "category", "list_of_objects", "integer", "object" ],
  input_arguments_names := [ "cat", "objects", "k", "P" ],
  output_source_getter_string := "P",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "objects[k]",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "InjectionOfCofactorOfDirectSumWithGivenDirectSum" ),

UniversalMorphismIntoDirectSum := rec(
  filter_list := [ "category", "list_of_objects", "object", "list_of_morphisms" ],
  input_arguments_names := [ "cat", "objects", "T", "tau" ],
  output_source_getter_string := "T",
  output_source_getter_preconditions := [ ],
  with_given_object_position := "Range",
  dual_operation := "UniversalMorphismFromDirectSum",
  
  pre_function := function( cat, diagram, test_object, source )
    local current_morphism;
    
    for current_morphism in source do
        
        if not IsEqualForObjects( cat, Source( current_morphism ), test_object ) then
            
            return [ false, "sources of morphisms must be equal to the test object in given source diagram" ];
            
        fi;
        
    od;
    
    return [ true ];
    
  end,
  return_type := "morphism",
  compatible_with_congruence_of_morphisms := true,
),

UniversalMorphismIntoDirectSumWithGivenDirectSum := rec(
  filter_list := [ "category", "list_of_objects", "object", "list_of_morphisms", "object" ],
  input_arguments_names := [ "cat", "objects", "T", "tau", "P" ],
  output_source_getter_string := "T",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "P",
  output_range_getter_preconditions := [ ],
  dual_operation := "UniversalMorphismFromDirectSumWithGivenDirectSum",
  
  pre_function := function( cat, diagram, test_object, source, direct_sum )
    local current_morphism;
    
    for current_morphism in source do
        
        if not IsEqualForObjects( cat, Source( current_morphism ), test_object ) then
            
            return [ false, "sources of morphisms must be equal to the test object in given source diagram" ];
            
        fi;
        
    od;
    
    return [ true ];
    
  end,
  return_type := "morphism",
  compatible_with_congruence_of_morphisms := true,
),

InjectionOfCofactorOfDirectSum := rec(
  filter_list := [ "category", "list_of_objects", "integer" ],
  input_arguments_names := [ "cat", "objects", "k" ],
  output_source_getter_string := "objects[k]",
  output_source_getter_preconditions := [ ],
  with_given_object_position := "Range",
  return_type := "morphism",
  dual_operation := "ProjectionInFactorOfDirectSum" ),

InjectionOfCofactorOfDirectSumWithGivenDirectSum := rec(
  filter_list := [ "category", "list_of_objects", "integer", "object" ],
  input_arguments_names := [ "cat", "objects", "k", "P" ],
  output_source_getter_string := "objects[k]",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "P",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "ProjectionInFactorOfDirectSumWithGivenDirectSum" ),

UniversalMorphismFromDirectSum := rec(
  filter_list := [ "category", "list_of_objects", "object", "list_of_morphisms" ],
  input_arguments_names := [ "cat", "objects", "T", "tau" ],
  output_range_getter_string := "T",
  output_range_getter_preconditions := [ ],
  with_given_object_position := "Source",
  dual_operation := "UniversalMorphismIntoDirectSum",
  
  pre_function := function( cat, diagram, test_object, sink )
    local current_morphism;
    
    for current_morphism in sink do
        
        if not IsEqualForObjects( cat, Range( current_morphism ), test_object ) then
            
            return [ false, "ranges of morphisms must be equal to the test object in given sink diagram" ];
            
        fi;
        
    od;
    
    return [ true ];
    
  end,
  return_type := "morphism",
  compatible_with_congruence_of_morphisms := true,
),

UniversalMorphismFromDirectSumWithGivenDirectSum := rec(
  filter_list := [ "category", "list_of_objects", "object", "list_of_morphisms", "object" ],
  input_arguments_names := [ "cat", "objects", "T", "tau", "P" ],
  output_source_getter_string := "P",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "T",
  output_range_getter_preconditions := [ ],
  dual_operation := "UniversalMorphismIntoDirectSumWithGivenDirectSum",
  
  pre_function := function( cat, diagram, test_object, sink, direct_sum )
    local current_morphism;
    
    for current_morphism in sink do
        
        if not IsEqualForObjects( cat, Range( current_morphism ), test_object ) then
            
            return [ false, "ranges of morphisms must be equal to the test object in given sink diagram" ];
            
        fi;
        
    od;
    
    return [ true ];
    
  end,
  return_type := "morphism",
  compatible_with_congruence_of_morphisms := true,
),

TerminalObject := rec(
  filter_list := [ "category" ],
  input_arguments_names := [ "cat" ],
  return_type := "object",
  dual_operation := "InitialObject",
  functorial := "TerminalObjectFunctorial",
),

UniversalMorphismIntoTerminalObject := rec(
  filter_list := [ "category", "object" ],
  input_arguments_names := [ "cat", "T" ],
  output_source_getter_string := "T",
  output_source_getter_preconditions := [ ],
  with_given_object_position := "Range",
  return_type := "morphism",
  dual_operation := "UniversalMorphismFromInitialObject" ),

UniversalMorphismIntoTerminalObjectWithGivenTerminalObject := rec(
  filter_list := [ "category", "object", "object" ],
  input_arguments_names := [ "cat", "T", "P" ],
  output_source_getter_string := "T",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "P",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "UniversalMorphismFromInitialObjectWithGivenInitialObject" ),

InitialObject := rec(
  filter_list := [ "category" ],
  input_arguments_names := [ "cat" ],
  return_type := "object",
  dual_operation := "TerminalObject",
  functorial := "InitialObjectFunctorial",
),

UniversalMorphismFromInitialObject := rec(
  filter_list := [ "category", "object" ],
  input_arguments_names := [ "cat", "T" ],
  output_range_getter_string := "T",
  output_range_getter_preconditions := [ ],
  with_given_object_position := "Source",
  return_type := "morphism",
  dual_operation := "UniversalMorphismIntoTerminalObject" ),

UniversalMorphismFromInitialObjectWithGivenInitialObject := rec(
  filter_list := [ "category", "object", "object" ],
  input_arguments_names := [ "cat", "T", "P" ],
  output_source_getter_string := "P",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "T",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "UniversalMorphismIntoTerminalObjectWithGivenTerminalObject" ),

DirectProduct := rec(
  filter_list := [ "category", "list_of_objects" ],
  input_arguments_names := [ "cat", "objects" ],
  return_type := "object",
  dual_operation := "Coproduct",
  functorial := "DirectProductFunctorial",
),

ProjectionInFactorOfDirectProduct := rec(
  filter_list := [ "category", "list_of_objects", "integer" ],
  input_arguments_names := [ "cat", "objects", "k" ],
  output_range_getter_string := "objects[k]",
  output_range_getter_preconditions := [ ],
  with_given_object_position := "Source",
  return_type := "morphism",
  dual_operation := "InjectionOfCofactorOfCoproduct" ),

ProjectionInFactorOfDirectProductWithGivenDirectProduct := rec(
  filter_list := [ "category", "list_of_objects", "integer", "object" ],
  input_arguments_names := [ "cat", "objects", "k", "P" ],
  output_source_getter_string := "P",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "objects[k]",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "InjectionOfCofactorOfCoproductWithGivenCoproduct" ),

UniversalMorphismIntoDirectProduct := rec(
  filter_list := [ "category", "list_of_objects", "object", "list_of_morphisms" ],
  input_arguments_names := [ "cat", "objects", "T", "tau" ],
  output_source_getter_string := "T",
  output_source_getter_preconditions := [ ],
  with_given_object_position := "Range",
  dual_operation := "UniversalMorphismFromCoproduct",
  
  pre_function := function( cat, diagram, test_object, source )
    local current_morphism;
    
    for current_morphism in source do
        
        if not IsEqualForObjects( cat, Source( current_morphism ), test_object ) then
            
            return [ false, "sources of morphisms must be equal to the test object in given source diagram" ];
            
        fi;
        
    od;
    
    return [ true ];
    
  end,
  return_type := "morphism",
  compatible_with_congruence_of_morphisms := true,
),

UniversalMorphismIntoDirectProductWithGivenDirectProduct := rec(
  filter_list := [ "category", "list_of_objects", "object", "list_of_morphisms", "object" ],
  input_arguments_names := [ "cat", "objects", "T", "tau", "P" ],
  output_source_getter_string := "T",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "P",
  output_range_getter_preconditions := [ ],
  dual_operation := "UniversalMorphismFromCoproductWithGivenCoproduct",
  
  pre_function := function( cat, diagram, test_object, source, direct_product )
    local current_morphism;
    
    for current_morphism in source do
        
        if not IsEqualForObjects( cat, Source( current_morphism ), test_object ) then
            
            return [ false, "sources of morphisms must be equal to the test object in given source diagram" ];
            
        fi;
        
    od;
    
    return [ true ];
    
  end,
  return_type := "morphism",
  compatible_with_congruence_of_morphisms := true,
),

ComponentOfMorphismIntoDirectProduct := rec(
  filter_list := [ "category", "morphism", "list_of_objects", "integer" ],
  input_arguments_names := [ "cat", "alpha", "P", "i" ],
  output_source_getter_string := "Source( alpha )",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "P[i]",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "ComponentOfMorphismFromCoproduct" ),

IsCongruentForMorphisms := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  dual_operation := "IsCongruentForMorphisms",
  
  pre_function := function( cat, morphism_1, morphism_2 )
    
    if not IsEqualForObjects( cat, Source( morphism_1 ), Source( morphism_2 ) ) then
        
        return [ false, "sources are not equal" ];
        
    fi;
        
    if not IsEqualForObjects( cat, Range( morphism_1 ), Range( morphism_2 ) ) then
        
        return [ false, "ranges are not equal" ];
        
    fi;
    
    return [ true ];
    
  end,
  
  redirect_function := function( cat, morphism_1, morphism_2 )
    
    if IsIdenticalObj( morphism_1, morphism_2 ) then
      
      return [ true, true ];
      
    else
      
      return [ false ];
      
    fi;
    
  end,
  
  post_function := function( cat, morphism_1, morphism_2, return_value )
    
    if cat!.predicate_logic_propagation_for_morphisms and
       cat!.predicate_logic and return_value = true then
          
          INSTALL_TODO_LIST_FOR_EQUAL_MORPHISMS( morphism_1, morphism_2 );
          
    fi;
    
  end,
  
  return_type := "bool",
  compatible_with_congruence_of_morphisms := true,
),

IsEqualForMorphisms := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  dual_operation := "IsEqualForMorphisms",
  
  pre_function := function( cat, morphism_1, morphism_2 )
    
    if not IsEqualForObjects( cat, Source( morphism_1 ), Source( morphism_2 ) ) then
        
        return [ false, "sources are not equal" ];
        
    fi;
        
    if not IsEqualForObjects( cat, Range( morphism_1 ), Range( morphism_2 ) ) then
        
        return [ false, "ranges are not equal" ];
        
    fi;
    
    return [ true ];
    
  end,
  
  redirect_function := function( cat, morphism_1, morphism_2 )
    
    if IsIdenticalObj( morphism_1, morphism_2 ) then
      
      return [ true, true ];
      
    else
      
      return [ false ];
      
    fi;
    
  end,
  
  return_type := "bool",
  compatible_with_congruence_of_morphisms := false,
),

IsEqualForMorphismsOnMor := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  dual_operation := "IsEqualForMorphismsOnMor",
  
  redirect_function := function( cat, morphism_1, morphism_2 )
    
    if IsIdenticalObj( morphism_1, morphism_2 ) then
      
      return [ true, true ];
      
    else
      
      return [ false ];
      
    fi;
    
  end,
  
  return_type := "bool",
  compatible_with_congruence_of_morphisms := false,
),

IsEqualForObjects := rec(
  filter_list := [ "category", "object", "object" ],
  dual_operation := "IsEqualForObjects",
  
  redirect_function := function( cat, object_1, object_2 )
    
    if IsIdenticalObj( object_1, object_2 ) then
      
      return [ true, true ];
      
    else
      
      return [ false ];
      
    fi;
    
  end,
  
  post_function := function( cat, object_1, object_2, return_value )
    
    if cat!.predicate_logic_propagation_for_objects and
       cat!.predicate_logic and return_value = true and not IsIdenticalObj( object_1, object_2 ) then
        
        INSTALL_TODO_LIST_FOR_EQUAL_OBJECTS( object_1, object_2 );
        
    fi;
    
  end,
  
  return_type := "bool" ),
  
IsEqualForCacheForObjects := rec(
  filter_list := [ "category", "object", "object" ],
  dual_operation := "IsEqualForCacheForObjects",
  return_type := "bool" ),

IsEqualForCacheForMorphisms := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  dual_operation := "IsEqualForCacheForMorphisms",
  return_type := "bool",
  compatible_with_congruence_of_morphisms := false,
),

IsIsomorphicForObjects := rec(
  filter_list := [ "category", "object", "object" ],
  input_arguments_names := [ "cat", "object_1", "object_2" ],
  return_type := "bool",
  dual_operation := "IsIsomorphicForObjects",
  # The witness SomeIsomorphismBetweenObjects needs reversed arguments.
  # This shows that reversing the arguments is the correct dualization,
  # even if the relation is symmetric.
  dual_arguments_reversed := true,
  redirect_function := function( cat, object_1, object_2 )
    
    # As any CAP operation, IsIsomorphicForObjects must be compatible with IsEqualForObjects.
    # This implies that IsIsomorphicForObjects must be coarser than IsEqualForObjects:
    # One can see this by first choosing object_2 := object_1 and the varying one argument with regard to IsEqualForObjects.
    if IsEqualForObjects( object_1, object_2 ) then
        
        return [ true, true ];
        
    else
        
        return [ false ];
        
    fi;
    
  end,
),

SomeIsomorphismBetweenObjects := rec(
  filter_list := [ "category", "object", "object" ],
  input_arguments_names := [ "cat", "object_1", "object_2" ],
  return_type := "morphism",
  output_source_getter_string := "object_1",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "object_2",
  output_range_getter_preconditions := [ ],
  dual_operation := "SomeIsomorphismBetweenObjects",
  dual_arguments_reversed := true,
),

IsZeroForMorphisms := rec(
  filter_list := [ "category", "morphism" ],
  return_type := "bool",
  dual_operation := "IsZeroForMorphisms",
  is_reflected_by_faithful_functor := true,
  compatible_with_congruence_of_morphisms := true,
),

AdditionForMorphisms := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  input_arguments_names := [ "cat", "alpha", "beta" ],
  output_source_getter_string := "Source( alpha )",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "Range( alpha )",
  output_range_getter_preconditions := [ ],
  dual_operation := "AdditionForMorphisms",
  
  pre_function := function( cat, morphism_1, morphism_2 )
    
    if not IsEqualForObjects( cat, Source( morphism_1 ), Source( morphism_2 ) ) then
        
        return [ false, "sources are not equal" ];
        
    fi;
        
    if not IsEqualForObjects( cat, Range( morphism_1 ), Range( morphism_2 ) ) then
        
        return [ false, "ranges are not equal" ];
        
    fi;
    
    return [ true ];
    
  end,
  return_type := "morphism",
  compatible_with_congruence_of_morphisms := true,
),

SubtractionForMorphisms := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  input_arguments_names := [ "cat", "alpha", "beta" ],
  output_source_getter_string := "Source( alpha )",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "Range( alpha )",
  output_range_getter_preconditions := [ ],
  dual_operation := "SubtractionForMorphisms",
  
  pre_function := function( cat, morphism_1, morphism_2 )
    
    if not IsEqualForObjects( cat, Source( morphism_1 ), Source( morphism_2 ) ) then
        
        return [ false, "sources are not equal" ];
        
    fi;
        
    if not IsEqualForObjects( cat, Range( morphism_1 ), Range( morphism_2 ) ) then
        
        return [ false, "ranges are not equal" ];
        
    fi;
    
    return [ true ];
    
  end,
  return_type := "morphism",
  compatible_with_congruence_of_morphisms := true,
),

MultiplyWithElementOfCommutativeRingForMorphisms := rec(
  filter_list := [ "category", "element_of_commutative_ring_of_linear_structure", "morphism" ],
  input_arguments_names := [ "cat", "r", "alpha" ],
  output_source_getter_string := "Source( alpha )",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "Range( alpha )",
  output_range_getter_preconditions := [ ],
  
  pre_function := function( cat, r, morphism )
    
    if not r in CommutativeRingOfLinearCategory( cat ) then
      
      return [ false, "the first argument is not an element of the ring of the category of the morphism" ];
      
    fi;
    
    return [ true ];
  end,
  dual_operation := "MultiplyWithElementOfCommutativeRingForMorphisms",
  return_type := "morphism",
  compatible_with_congruence_of_morphisms := true,
),

AdditiveInverseForMorphisms := rec(
  filter_list := [ "category", "morphism" ],
  input_arguments_names := [ "cat", "alpha" ],
  output_source_getter_string := "Source( alpha )",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "Range( alpha )",
  output_range_getter_preconditions := [ ],
  dual_operation := "AdditiveInverseForMorphisms",
  return_type := "morphism",
  compatible_with_congruence_of_morphisms := true,
),

Coproduct := rec(
  filter_list := [ "category", "list_of_objects" ],
  input_arguments_names := [ "cat", "objects" ],
  return_type := "object",
  dual_operation := "DirectProduct",
  functorial := "CoproductFunctorial",
),

InjectionOfCofactorOfCoproduct := rec(
  filter_list := [ "category", "list_of_objects", "integer" ],
  input_arguments_names := [ "cat", "objects", "k" ],
  output_source_getter_string := "objects[k]",
  output_source_getter_preconditions := [ ],
  with_given_object_position := "Range",
  return_type := "morphism",
  dual_operation := "ProjectionInFactorOfDirectProduct" ),

InjectionOfCofactorOfCoproductWithGivenCoproduct := rec(
  filter_list := [ "category", "list_of_objects", "integer", "object" ],
  input_arguments_names := [ "cat", "objects", "k", "P" ],
  output_source_getter_string := "objects[k]",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "P",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "ProjectionInFactorOfDirectProductWithGivenDirectProduct" ),

UniversalMorphismFromCoproduct := rec(
  filter_list := [ "category", "list_of_objects", "object", "list_of_morphisms" ],
  input_arguments_names := [ "cat", "objects", "T", "tau" ],
  output_range_getter_string := "T",
  output_range_getter_preconditions := [ ],
  with_given_object_position := "Source",
  dual_operation := "UniversalMorphismIntoDirectProduct",
  
  pre_function := function( cat, diagram, test_object, sink )
    local current_morphism;
    
    for current_morphism in sink do
        
        if not IsEqualForObjects( cat, Range( current_morphism ), test_object ) then
            
            return [ false, "ranges of morphisms must be equal to the test object in given sink diagram" ];
            
        fi;
        
    od;
    
    return [ true ];
    
  end,
  return_type := "morphism",
  compatible_with_congruence_of_morphisms := true,
),

UniversalMorphismFromCoproductWithGivenCoproduct := rec(
  filter_list := [ "category", "list_of_objects", "object", "list_of_morphisms", "object" ],
  input_arguments_names := [ "cat", "objects", "T", "tau", "P" ],
  output_source_getter_string := "P",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "T",
  output_range_getter_preconditions := [ ],
  dual_operation := "UniversalMorphismIntoDirectProductWithGivenDirectProduct",
  
  pre_function := function( cat, diagram, test_object, sink, coproduct )
    local current_morphism;
    
    for current_morphism in sink do
        
        if not IsEqualForObjects( cat, Range( current_morphism ), test_object ) then
            
            return [ false, "ranges of morphisms must be equal to the test object in given sink diagram" ];
            
        fi;
        
    od;
    
    return [ true ];
    
  end,
  return_type := "morphism",
  compatible_with_congruence_of_morphisms := true,
),

ComponentOfMorphismFromCoproduct := rec(
  filter_list := [ "category", "morphism", "list_of_objects", "integer" ],
  input_arguments_names := [ "cat", "alpha", "I", "i" ],
  output_source_getter_string := "I[i]",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "Range( alpha )",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "ComponentOfMorphismIntoDirectProduct" ),

IsEqualAsSubobjects := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  return_type := "bool",
  dual_operation := "IsEqualAsFactorobjects",
  compatible_with_congruence_of_morphisms := true,
),

IsEqualAsFactorobjects := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  return_type := "bool",
  dual_operation := "IsEqualAsSubobjects",
  compatible_with_congruence_of_morphisms := true,
),

IsDominating := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  dual_operation := "IsCodominating",
  
  pre_function := function( cat, sub1, sub2 )
    
    if not IsEqualForObjects( cat, Range( sub1 ), Range( sub2 ) ) then
        
        return [ false, "subobjects of different objects are not comparable by dominates" ];
        
    fi;
    
    return [ true ];
  end,
  return_type := "bool",
  compatible_with_congruence_of_morphisms := true,
),

IsCodominating := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  dual_operation := "IsDominating",
  
  pre_function := function( cat, factor1, factor2 )
    
    if not IsEqualForObjects( cat, Source( factor1 ), Source( factor2 ) ) then
        
        return [ false, "factors of different objects are not comparable by codominates" ];
        
    fi;
    
    return [ true ];
  end,
  return_type := "bool",
  compatible_with_congruence_of_morphisms := true,
),

Equalizer := rec(
  filter_list := [ "category", "object", "list_of_morphisms" ],
  input_arguments_names := [ "cat", "Y", "morphisms" ],
  return_type := "object",
  dual_operation := "Coequalizer",
  
  pre_function := function( cat, cobase, diagram )
    local base, current_morphism;
    
    if IsEmpty( diagram ) then
        
        return [ true ];
        
    fi;
    
    for current_morphism in diagram{[ 1 .. Length( diagram ) ]} do
        
        if not IsEqualForObjects( cat, Source( current_morphism ), cobase ) then
            return [ false, "the given morphisms of the equalizer diagram must have equal sources" ];
        fi;
        
    od;
    
    base := Range( diagram[1] );
    
    for current_morphism in diagram{[ 2 .. Length( diagram ) ]} do
        
        if not IsEqualForObjects( cat, Range( current_morphism ), base ) then
            return [ false, "the given morphisms of the equalizer diagram must have equal ranges" ];
        fi;
        
    od;
    
    return [ true ];
  end,
  compatible_with_congruence_of_morphisms := false,
  functorial := "EqualizerFunctorial",
),

EmbeddingOfEqualizer := rec(
  filter_list := [ "category", "object", "list_of_morphisms" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "Y", "morphisms" ],
  output_range_getter_string := "Y",
  output_range_getter_preconditions := [ ],
  with_given_object_position := "Source",
  dual_operation := "ProjectionOntoCoequalizer",
  
  pre_function := "Equalizer",
  compatible_with_congruence_of_morphisms := false,
),

EmbeddingOfEqualizerWithGivenEqualizer := rec(
  filter_list := [ "category", "object", "list_of_morphisms", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "Y", "morphisms", "P" ],
  output_source_getter_string := "P",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "Y",
  output_range_getter_preconditions := [ ],
  dual_operation := "ProjectionOntoCoequalizerWithGivenCoequalizer",
  compatible_with_congruence_of_morphisms := false,
),

MorphismFromEqualizerToSink := rec(
  filter_list := [ "category", "object", "list_of_morphisms" ],
  input_arguments_names := [ "cat", "Y", "morphisms" ],
  output_range_getter_string := "Range( morphisms[1] )",
  output_range_getter_preconditions := [ ],
  with_given_object_position := "Source",
  dual_operation := "MorphismFromSourceToCoequalizer",
  return_type := "morphism",
  compatible_with_congruence_of_morphisms := false,
),

MorphismFromEqualizerToSinkWithGivenEqualizer := rec(
  filter_list := [ "category", "object", "list_of_morphisms", "object" ],
  input_arguments_names := [ "cat", "Y", "morphisms", "P" ],
  output_source_getter_string := "P",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "Range( morphisms[1] )",
  output_range_getter_preconditions := [ ],
  dual_operation := "MorphismFromSourceToCoequalizerWithGivenCoequalizer",
  return_type := "morphism",
  compatible_with_congruence_of_morphisms := false,
),

UniversalMorphismIntoEqualizer := rec(
  filter_list := [ "category", "object", "list_of_morphisms", "object", "morphism" ],
  input_arguments_names := [ "cat", "Y", "morphisms", "T", "tau" ],
  output_source_getter_string := "T",
  output_source_getter_preconditions := [ ],
  with_given_object_position := "Range",
  return_type := "morphism",
  dual_operation := "UniversalMorphismFromCoequalizer",
  
  pre_function := function( cat, cobase, diagram, test_object, tau )
    local base, current_morphism, current_morphism_position;
    
    if IsEmpty( diagram ) then
        
        return [ true ];
        
    fi;
    
    for current_morphism in diagram{[ 1 .. Length( diagram ) ]} do
        
        if not IsEqualForObjects( cat, Source( current_morphism ), cobase ) then
            return [ false, "the given morphisms of the equalizer diagram must have equal sources" ];
        fi;
        
    od;
    
    base := Range( diagram[1] );
    
    for current_morphism in diagram{[ 2 .. Length( diagram ) ]} do
        
        if not IsEqualForObjects( cat, Range( current_morphism ), base ) then
            return [ false, "the given morphisms of the equalizer diagram must have equal ranges" ];
        fi;
        
    od;
    
    for current_morphism_position in [ 1 .. Length( diagram ) ] do
        
        if not IsEqualForObjects( cat, Source( diagram[ current_morphism_position ] ), Range( tau ) ) then
            return [ false, Concatenation( "in diagram position ", String( current_morphism_position ), ": source and range are not equal" ) ];
        fi;
        
    od;
    
    return [ true ];
  end,
  compatible_with_congruence_of_morphisms := false,
),

UniversalMorphismIntoEqualizerWithGivenEqualizer := rec(
  filter_list := [ "category", "object", "list_of_morphisms", "object", "morphism", "object" ],
  input_arguments_names := [ "cat", "Y", "morphisms", "T", "tau", "P" ],
  output_source_getter_string := "T",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "P",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "UniversalMorphismFromCoequalizerWithGivenCoequalizer",
  compatible_with_congruence_of_morphisms := false,
),

IsomorphismFromEqualizerToKernelOfJointPairwiseDifferencesOfMorphismsIntoDirectProduct := rec(
  filter_list := [ "category", "object", "list_of_morphisms" ],
  input_arguments_names := [ "cat", "A", "D" ],
  return_type := "morphism",
  dual_operation := "IsomorphismFromCokernelOfJointPairwiseDifferencesOfMorphismsFromCoproductToCoequalizer",
),

IsomorphismFromKernelOfJointPairwiseDifferencesOfMorphismsIntoDirectProductToEqualizer := rec(
  filter_list := [ "category", "object", "list_of_morphisms" ],
  input_arguments_names := [ "cat", "A", "D" ],
  return_type := "morphism",
  dual_operation := "IsomorphismFromCoequalizerToCokernelOfJointPairwiseDifferencesOfMorphismsFromCoproduct",
),

FiberProduct := rec(
  filter_list := [ "category", "list_of_morphisms" ],
  input_arguments_names := [ "cat", "morphisms" ],
  dual_operation := "Pushout",
  
  pre_function := function( cat, diagram )
    local base, current_morphism;
    
    if IsEmpty( diagram ) then
        
        return [ true ];
        
    fi;
    
    base := Range( diagram[1] );
    
    for current_morphism in diagram{[ 2 .. Length( diagram ) ]} do
        
        if not IsEqualForObjects( cat, Range( current_morphism ), base ) then
            return [ false, "the given morphisms of the fiber product diagram must have equal ranges" ];
        fi;
        
    od;
    
    return [ true ];
  end,
  return_type := "object",
  compatible_with_congruence_of_morphisms := false,
  functorial := "FiberProductFunctorial",
),

ProjectionInFactorOfFiberProduct := rec(
  filter_list := [ "category", "list_of_morphisms", "integer" ],
  input_arguments_names := [ "cat", "morphisms", "k" ],
  output_range_getter_string := "Source( morphisms[k] )",
  output_range_getter_preconditions := [ ],
  with_given_object_position := "Source",
  dual_operation := "InjectionOfCofactorOfPushout",
  
  pre_function := function( cat, diagram, projection_number )
    local base, current_morphism;
    
    if projection_number < 1 or projection_number > Length( diagram ) then
        return[ false, Concatenation( "there does not exist a ", String( projection_number ), "th projection" ) ];
    fi;
    
    base := Range( diagram[1] );
    
    for current_morphism in diagram{[ 2 .. Length( diagram ) ]} do
        
        if not IsEqualForObjects( cat, Range( current_morphism ), base ) then
            return [ false, "the given morphisms of the fiber product diagram must have equal ranges" ];
        fi;
        
    od;
    
    return [ true ];
  end,
  return_type := "morphism",
  compatible_with_congruence_of_morphisms := false,
),

ProjectionInFactorOfFiberProductWithGivenFiberProduct := rec(
  filter_list := [ "category", "list_of_morphisms", "integer", "object" ],
  input_arguments_names := [ "cat", "morphisms", "k", "P" ],
  output_source_getter_string := "P",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "Source( morphisms[k] )",
  output_range_getter_preconditions := [ ],
  dual_operation := "InjectionOfCofactorOfPushoutWithGivenPushout",
  
  pre_function := function( cat, diagram, projection_number, pullback )
    local base, current_morphism;
    
    if projection_number < 1 or projection_number > Length( diagram ) then
        return[ false, Concatenation( "there does not exist a ", String( projection_number ), "th projection" ) ];
    fi;
    
    base := Range( diagram[1] );
    
    for current_morphism in diagram{[ 2 .. Length( diagram ) ]} do
        
        if not IsEqualForObjects( cat, Range( current_morphism ), base ) then
            return [ false, "the given morphisms of the fiber product diagram must have equal ranges" ];
        fi;
        
    od;
    
    return [ true ];
  end,
  return_type := "morphism",
  compatible_with_congruence_of_morphisms := false,
),

MorphismFromFiberProductToSink := rec(
  filter_list := [ "category", "list_of_morphisms" ],
  input_arguments_names := [ "cat", "morphisms" ],
  output_range_getter_string := "Range( morphisms[1] )",
  output_range_getter_preconditions := [ ],
  with_given_object_position := "Source",
  dual_operation := "MorphismFromSourceToPushout",
  
  pre_function := function( cat, diagram )
    local base, current_morphism;
    
    base := Range( diagram[1] );
    
    for current_morphism in diagram{[ 2 .. Length( diagram ) ]} do
        
        if not IsEqualForObjects( cat, Range( current_morphism ), base ) then
            return [ false, "the given morphisms of the fiber product diagram must have equal ranges" ];
        fi;
        
    od;
    
    return [ true ];
  end,
  return_type := "morphism",
  compatible_with_congruence_of_morphisms := false,
),

MorphismFromFiberProductToSinkWithGivenFiberProduct := rec(
  filter_list := [ "category", "list_of_morphisms", "object" ],
  input_arguments_names := [ "cat", "morphisms", "P" ],
  output_source_getter_string := "P",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "Range( morphisms[1] )",
  output_range_getter_preconditions := [ ],
  dual_operation := "MorphismFromSourceToPushoutWithGivenPushout",
  
  pre_function := function( cat, diagram, pullback )
    local base, current_morphism;
    
    base := Range( diagram[1] );
    
    for current_morphism in diagram{[ 2 .. Length( diagram ) ]} do
        
        if not IsEqualForObjects( cat, Range( current_morphism ), base ) then
            return [ false, "the given morphisms of the fiber product diagram must have equal ranges" ];
        fi;
        
    od;
    
    return [ true ];
  end,
  return_type := "morphism",
  compatible_with_congruence_of_morphisms := false,
),

UniversalMorphismIntoFiberProduct := rec(
  filter_list := [ "category", "list_of_morphisms", "object", "list_of_morphisms" ],
  input_arguments_names := [ "cat", "morphisms", "T", "tau" ],
  output_source_getter_string := "T",
  output_source_getter_preconditions := [ ],
  with_given_object_position := "Range",
  dual_operation := "UniversalMorphismFromPushout",
  
  pre_function := function( cat, diagram, test_object, source )
    local base, current_morphism, current_morphism_position;
    
    if Length( diagram ) <> Length( source ) then
        return [ false, "fiber product diagram and test diagram must have equal length" ];
    fi;
    
    if IsEmpty( diagram ) then
        
        return [ true ];
        
    fi;
    
    base := Range( diagram[1] );
    
    for current_morphism in diagram{[ 2 .. Length( diagram ) ]} do
        
        if not IsEqualForObjects( cat, Range( current_morphism ), base ) then
            return [ false, "the given morphisms of the fiber product diagram must have equal ranges" ];
        fi;
        
    od;
    
    for current_morphism in source do
        
        if not IsEqualForObjects( cat, Source( current_morphism ), test_object ) then
            return [ false, "the given morphisms of the test source do not have sources equal to the test object" ];
        fi;
        
    od;
    
    for current_morphism_position in [ 1 .. Length( diagram ) ] do
        
        if not IsEqualForObjects( cat, Source( diagram[ current_morphism_position ] ), Range( source[ current_morphism_position ] ) ) then
            return [ false, Concatenation( "in diagram position ", String( current_morphism_position ), ": source and range are not equal" ) ];
        fi;
        
    od;
    
    return [ true ];
  end,
  return_type := "morphism",
  compatible_with_congruence_of_morphisms := false,
),

UniversalMorphismIntoFiberProductWithGivenFiberProduct := rec(
  filter_list := [ "category", "list_of_morphisms", "object", "list_of_morphisms", "object" ],
  input_arguments_names := [ "cat", "morphisms", "T", "tau", "P" ],
  output_source_getter_string := "T",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "P",
  output_range_getter_preconditions := [ ],
  dual_operation := "UniversalMorphismFromPushoutWithGivenPushout",
  
  pre_function := function( cat, diagram, test_object, source, pullback )
    local base, current_morphism, current_morphism_position;
    
    if Length( diagram ) <> Length( source ) then
        return [ false, "fiber product diagram and test diagram must have equal length" ];
    fi;
    
    if IsEmpty( diagram ) then
        
        return [ true ];
        
    fi;
    
    base := Range( diagram[1] );
    
    for current_morphism in diagram{[ 2 .. Length( diagram ) ]} do
        
        if not IsEqualForObjects( cat, Range( current_morphism ), base ) then
            return [ false, "the given morphisms of the fiber product diagram must have equal ranges" ];
        fi;
        
    od;
    
    for current_morphism in source do
        
        if not IsEqualForObjects( cat, Source( current_morphism ), test_object ) then
            return [ false, "the given morphisms of the test source do not have sources equal to the test object" ];
        fi;
        
    od;
    
    for current_morphism_position in [ 1 .. Length( diagram ) ] do
        
        if not IsEqualForObjects( cat, Source( diagram[ current_morphism_position ] ), Range( source[ current_morphism_position ] ) ) then
            return [ false, Concatenation( "in diagram position ", String( current_morphism_position ), ": source and range are not equal" ) ];
        fi;
        
    od;
    
    return [ true ];
  end,
  return_type := "morphism",
  compatible_with_congruence_of_morphisms := false,
),

Coequalizer := rec(
  filter_list := [ "category", "object", "list_of_morphisms" ],
  input_arguments_names := [ "cat", "Y", "morphisms" ],
  return_type := "object",
  dual_operation := "Equalizer",
  
  pre_function := function( cat, cobase, diagram )
    local base, current_morphism;
    
    if IsEmpty( diagram ) then
        
        return [ true ];
        
    fi;
    
    base := Source( diagram[1] );
    
    for current_morphism in diagram{[ 2 .. Length( diagram ) ]} do
        
        if not IsEqualForObjects( cat, Source( current_morphism ), base ) then
            return [ false, "the given morphisms of the coequalizer diagram must have equal sources" ];
        fi;
        
    od;
    
    for current_morphism in diagram{[ 1 .. Length( diagram ) ]} do
        
        if not IsEqualForObjects( cat, Range( current_morphism ), cobase ) then
            return [ false, "the given morphisms of the coequalizer diagram must have equal ranges" ];
        fi;
        
    od;
    
    return [ true ];
  end,
  compatible_with_congruence_of_morphisms := false,
  functorial := "CoequalizerFunctorial",
),

ProjectionOntoCoequalizer := rec(
  filter_list := [ "category", "object", "list_of_morphisms" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "Y", "morphisms" ],
  output_source_getter_string := "Y",
  output_source_getter_preconditions := [ ],
  with_given_object_position := "Range",
  dual_operation := "EmbeddingOfEqualizer",
  
  pre_function := "Coequalizer",
  compatible_with_congruence_of_morphisms := false,
),

ProjectionOntoCoequalizerWithGivenCoequalizer := rec(
  filter_list := [ "category", "object", "list_of_morphisms", "object" ],
  return_type := "morphism",
  input_arguments_names := [ "cat", "Y", "morphisms", "P" ],
  output_source_getter_string := "Y",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "P",
  output_range_getter_preconditions := [ ],
  dual_operation := "EmbeddingOfEqualizerWithGivenEqualizer",
  compatible_with_congruence_of_morphisms := false,
),

MorphismFromSourceToCoequalizer := rec(
  filter_list := [ "category", "object", "list_of_morphisms" ],
  input_arguments_names := [ "cat", "Y", "morphisms" ],
  output_source_getter_string := "Source( morphisms[1] )",
  output_source_getter_preconditions := [ ],
  with_given_object_position := "Range",
  dual_operation := "MorphismFromEqualizerToSink",
  return_type := "morphism",
  compatible_with_congruence_of_morphisms := false,
),

MorphismFromSourceToCoequalizerWithGivenCoequalizer := rec(
  filter_list := [ "category", "object", "list_of_morphisms", "object" ],
  input_arguments_names := [ "cat", "Y", "morphisms", "P" ],
  output_source_getter_string := "Source( morphisms[1] )",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "P",
  output_range_getter_preconditions := [ ],
  dual_operation := "MorphismFromEqualizerToSinkWithGivenEqualizer",
  return_type := "morphism",
  compatible_with_congruence_of_morphisms := false,
),

UniversalMorphismFromCoequalizer := rec(
  filter_list := [ "category", "object", "list_of_morphisms", "object", "morphism" ],
  input_arguments_names := [ "cat", "Y", "morphisms", "T", "tau" ],
  output_range_getter_string := "T",
  output_range_getter_preconditions := [ ],
  with_given_object_position := "Source",
  return_type := "morphism",
  dual_operation := "UniversalMorphismIntoEqualizer",
  
  pre_function := function( cat, cobase, diagram, test_object, tau )
    local base, current_morphism, current_morphism_position;
    
    if IsEmpty( diagram ) then
        
        return [ true ];
        
    fi;
    
    base := Source( diagram[1] );
    
    for current_morphism in diagram{[ 2 .. Length( diagram ) ]} do
        
        if not IsEqualForObjects( cat, Source( current_morphism ), base ) then
            return [ false, "the given morphisms of the coequalizer diagram must have equal sources" ];
        fi;
        
    od;
    
    for current_morphism in diagram{[ 1 .. Length( diagram ) ]} do
        
        if not IsEqualForObjects( cat, Range( current_morphism ), cobase ) then
            return [ false, "the given morphisms of the coequalizer diagram must have equal ranges" ];
        fi;
        
    od;
    
    for current_morphism_position in [ 1 .. Length( diagram ) ] do
        
        if not IsEqualForObjects( cat, Range( diagram[ current_morphism_position ] ), Source( tau ) ) then
            return [ false, Concatenation( "in diagram position ", String( current_morphism_position ), ": range and source are not equal" ) ];
        fi;
        
    od;
    
    return [ true ];
  end,
  compatible_with_congruence_of_morphisms := false,
),

UniversalMorphismFromCoequalizerWithGivenCoequalizer := rec(
  filter_list := [ "category", "object", "list_of_morphisms", "object", "morphism", "object" ],
  input_arguments_names := [ "cat", "Y", "morphisms", "T", "tau", "P" ],
  output_source_getter_string := "P",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "T",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "UniversalMorphismIntoEqualizerWithGivenEqualizer",
  compatible_with_congruence_of_morphisms := false,
),

IsomorphismFromCoequalizerToCokernelOfJointPairwiseDifferencesOfMorphismsFromCoproduct := rec(
  filter_list := [ "category", "object", "list_of_morphisms" ],
  input_arguments_names := [ "cat", "A", "D" ],
  return_type := "morphism",
  dual_operation := "IsomorphismFromKernelOfJointPairwiseDifferencesOfMorphismsIntoDirectProductToEqualizer",
),

IsomorphismFromCokernelOfJointPairwiseDifferencesOfMorphismsFromCoproductToCoequalizer := rec(
  filter_list := [ "category", "object", "list_of_morphisms" ],
  input_arguments_names := [ "cat", "A", "D" ],
  return_type := "morphism",
  dual_operation := "IsomorphismFromEqualizerToKernelOfJointPairwiseDifferencesOfMorphismsIntoDirectProduct",
),

Pushout := rec(
  filter_list := [ "category", "list_of_morphisms" ],
  input_arguments_names := [ "cat", "morphisms" ],
  dual_operation := "FiberProduct",
  
  pre_function := function( cat, diagram )
    local cobase, current_morphism;
    
    if IsEmpty( diagram ) then
        
        return [ true ];
        
    fi;
    
    cobase := Source( diagram[1] );
    
    for current_morphism in diagram{[ 2 .. Length( diagram ) ]} do
        
        if not IsEqualForObjects( cat, Source( current_morphism ), cobase ) then
            return [ false, "the given morphisms of the pushout diagram must have equal sources" ];
        fi;
        
    od;
    
    return [ true ];
  end,
  return_type := "object",
  compatible_with_congruence_of_morphisms := false,
  functorial := "PushoutFunctorial",
),

InjectionOfCofactorOfPushout := rec(
  filter_list := [ "category", "list_of_morphisms", "integer" ],
  input_arguments_names := [ "cat", "morphisms", "k" ],
  output_source_getter_string := "Range( morphisms[k] )",
  output_source_getter_preconditions := [ ],
  with_given_object_position := "Range",
  dual_operation := "ProjectionInFactorOfFiberProduct",
  
  pre_function := function( cat, diagram, injection_number )
    local cobase, current_morphism;
    
    if injection_number < 1 or injection_number > Length( diagram ) then
        return[ false, Concatenation( "there does not exist a ", String( injection_number ), "th injection" ) ];
    fi;
    
    cobase := Source( diagram[1] );
    
    for current_morphism in diagram{[ 2 .. Length( diagram ) ]} do
        
        if not IsEqualForObjects( cat, Source( current_morphism ), cobase ) then
            return [ false, "the given morphisms of the pushout diagram must have equal sources" ];
        fi;
        
    od;
    
    return [ true ];
  end,
  return_type := "morphism",
  compatible_with_congruence_of_morphisms := false,
),

InjectionOfCofactorOfPushoutWithGivenPushout := rec(
  filter_list := [ "category", "list_of_morphisms", "integer", "object" ],
  input_arguments_names := [ "cat", "morphisms", "k", "P" ],
  output_source_getter_string := "Range( morphisms[k] )",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "P",
  output_range_getter_preconditions := [ ],
  dual_operation := "ProjectionInFactorOfFiberProductWithGivenFiberProduct",
  
  pre_function := function( cat, diagram, injection_number, pushout )
    local cobase, current_morphism;
    
    if injection_number < 1 or injection_number > Length( diagram ) then
        return[ false, Concatenation( "there does not exist a ", String( injection_number ), "th injection" ) ];
    fi;
    
    cobase := Source( diagram[1] );
    
    for current_morphism in diagram{[ 2 .. Length( diagram ) ]} do
        
        if not IsEqualForObjects( cat, Source( current_morphism ), cobase ) then
            return [ false, "the given morphisms of the pushout diagram must have equal sources" ];
        fi;
        
    od;
    
    return [ true ];
  end,
  return_type := "morphism",
  compatible_with_congruence_of_morphisms := false,
),

MorphismFromSourceToPushout := rec(
  filter_list := [ "category", "list_of_morphisms" ],
  input_arguments_names := [ "cat", "morphisms" ],
  output_source_getter_string := "Source( morphisms[1] )",
  output_source_getter_preconditions := [ ],
  with_given_object_position := "Range",
  dual_operation := "MorphismFromFiberProductToSink",
  
  pre_function := function( cat, diagram )
    local cobase, current_morphism;
    
    cobase := Source( diagram[1] );
    
    for current_morphism in diagram{[ 2 .. Length( diagram ) ]} do
        
        if not IsEqualForObjects( cat, Source( current_morphism ), cobase ) then
            return [ false, "the given morphisms of the pushout diagram must have equal sources" ];
        fi;
        
    od;
    
    return [ true ];
  end,
  return_type := "morphism",
  compatible_with_congruence_of_morphisms := false,
),

MorphismFromSourceToPushoutWithGivenPushout := rec(
  filter_list := [ "category", "list_of_morphisms", "object" ],
  input_arguments_names := [ "cat", "morphisms", "P" ],
  output_source_getter_string := "Source( morphisms[1] )",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "P",
  output_range_getter_preconditions := [ ],
  dual_operation := "MorphismFromFiberProductToSinkWithGivenFiberProduct",
  
  pre_function := function( cat, diagram, pushout )
    local cobase, current_morphism;
    
    cobase := Source( diagram[1] );
    
    for current_morphism in diagram{[ 2 .. Length( diagram ) ]} do
        
        if not IsEqualForObjects( cat, Source( current_morphism ), cobase ) then
            return [ false, "the given morphisms of the pushout diagram must have equal sources" ];
        fi;
        
    od;
    
    return [ true ];
  end,
  return_type := "morphism",
  compatible_with_congruence_of_morphisms := false,
),

UniversalMorphismFromPushout := rec(
  filter_list := [ "category", "list_of_morphisms", "object", "list_of_morphisms" ],
  input_arguments_names := [ "cat", "morphisms", "T", "tau" ],
  output_range_getter_string := "T",
  output_range_getter_preconditions := [ ],
  with_given_object_position := "Source",
  dual_operation := "UniversalMorphismIntoFiberProduct",
  
  pre_function := function( cat, diagram, test_object, sink )
    local cobase, current_morphism, current_morphism_position;
    
    if Length( diagram ) <> Length( sink ) then
        return [ false, "pushout diagram and test diagram must have equal length" ];
    fi;
    
    if IsEmpty( diagram ) then
        
        return [ true ];
        
    fi;
    
    cobase := Source( diagram[1] );
    
    for current_morphism in diagram{[ 2 .. Length( diagram ) ]} do
        
        if not IsEqualForObjects( cat, Source( current_morphism ), cobase ) then
            return [ false, "the given morphisms of the fiber pushout must have equal sources" ];
        fi;
        
    od;
    
    for current_morphism in sink do
        
        if not IsEqualForObjects( cat, Range( current_morphism ), test_object ) then
            return [ false, "the given morphisms of the test sink do not have ranges equal to the test object" ];
        fi;
        
    od;
    
    for current_morphism_position in [ 1 .. Length( diagram ) ] do
        
        if not IsEqualForObjects( cat, Range( diagram[ current_morphism_position ] ), Source( sink[ current_morphism_position ] ) ) then
            return [ false, Concatenation( "in diagram position ", String( current_morphism_position ), ": source and range are not equal" ) ];
        fi;
        
    od;
    
    return [ true ];
  end,
  return_type := "morphism",
  compatible_with_congruence_of_morphisms := false,
),

UniversalMorphismFromPushoutWithGivenPushout := rec(
  filter_list := [ "category", "list_of_morphisms", "object", "list_of_morphisms", "object" ],
  input_arguments_names := [ "cat", "morphisms", "T", "tau", "P" ],
  output_source_getter_string := "P",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "T",
  output_range_getter_preconditions := [ ],
  dual_operation := "UniversalMorphismIntoFiberProductWithGivenFiberProduct",
  
  pre_function := function( cat, diagram, test_object, sink, pushout )
    local cobase, current_morphism, current_morphism_position;
    
    if Length( diagram ) <> Length( sink ) then
        return [ false, "pushout diagram and test diagram must have equal length" ];
    fi;
    
    if IsEmpty( diagram ) then
        
        return [ true ];
        
    fi;
    
    cobase := Source( diagram[1] );
    
    for current_morphism in diagram{[ 2 .. Length( diagram ) ]} do
        
        if not IsEqualForObjects( cat, Source( current_morphism ), cobase ) then
            return [ false, "the given morphisms of the fiber pushout must have equal sources" ];
        fi;
        
    od;
    
    for current_morphism in sink do
        
        if not IsEqualForObjects( cat, Range( current_morphism ), test_object ) then
            return [ false, "the given morphisms of the test sink do not have ranges equal to the test object" ];
        fi;
        
    od;
    
    for current_morphism_position in [ 1 .. Length( diagram ) ] do
        
        if not IsEqualForObjects( cat, Range( diagram[ current_morphism_position ] ), Source( sink[ current_morphism_position ] ) ) then
            return [ false, Concatenation( "in diagram position ", String( current_morphism_position ), ": source and range are not equal" ) ];
        fi;
        
    od;
    
    return [ true ];
  end,
  return_type := "morphism",
  compatible_with_congruence_of_morphisms := false,
),

ImageObject := rec(
  filter_list := [ "category", "morphism" ],
  return_type := "object",
  dual_operation := "CoimageObject",
  functorial := "ImageObjectFunctorial",
),

ImageEmbedding := rec(
  filter_list := [ "category", "morphism" ],
  input_arguments_names := [ "cat", "alpha" ],
  output_range_getter_string := "Range( alpha )",
  output_range_getter_preconditions := [ ],
  with_given_object_position := "Source",
  return_type := "morphism",
  dual_operation := "CoimageProjection" ),

ImageEmbeddingWithGivenImageObject := rec(
  filter_list := [ "category", "morphism", "object" ],
  input_arguments_names := [ "cat", "alpha", "I" ],
  output_source_getter_string := "I",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "Range( alpha )",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "CoimageProjectionWithGivenCoimageObject" ),

CoimageObject := rec(
  filter_list := [ "category", "morphism" ],
  return_type := "object",
  dual_operation := "ImageObject",
  functorial := "CoimageObjectFunctorial",
),

CoimageProjection := rec(
  filter_list := [ "category", "morphism" ],
  input_arguments_names := [ "cat", "alpha" ],
  output_source_getter_string := "Source( alpha )",
  output_source_getter_preconditions := [ ],
  with_given_object_position := "Range",
  return_type := "morphism",
  dual_operation := "ImageEmbedding" ),

CoimageProjectionWithGivenCoimageObject := rec(
  filter_list := [ "category", "morphism", "object" ],
  input_arguments_names := [ "cat", "alpha", "C" ],
  output_source_getter_string := "Source( alpha )",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "C",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "ImageEmbeddingWithGivenImageObject" ),

AstrictionToCoimage := rec(
  filter_list := [ "category", "morphism" ],
  input_arguments_names := [ "cat", "alpha" ],
  output_range_getter_string := "Range( alpha )",
  output_range_getter_preconditions := [ ],
  with_given_object_position := "Source",
  return_type := "morphism",
  dual_operation := "CoastrictionToImage" ),

AstrictionToCoimageWithGivenCoimageObject := rec(
  filter_list := [ "category", "morphism", "object" ],
  input_arguments_names := [ "cat", "alpha", "C" ],
  output_source_getter_string := "C",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "Range( alpha )",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "CoastrictionToImageWithGivenImageObject" ),

UniversalMorphismIntoCoimage := rec(
  filter_list := [ "category", "morphism", "pair_of_morphisms" ],
  input_arguments_names := [ "cat", "alpha", "tau" ],
  output_source_getter_string := "Range( tau[1] )",
  output_source_getter_preconditions := [ ],
  with_given_object_position := "Range",
  dual_preprocessor_func := function( cat, alpha, tau )
    return Triple( OppositeCategory( cat ), Opposite( alpha ), Pair( Opposite( tau[2] ), Opposite( tau[1] ) ) );
  end,
  pre_function := function( cat, morphism, test_factorization )
    
    if not IsEqualForObjects( cat, Source( morphism ), Source( test_factorization[ 1 ] ) ) then
        return [ false, "source of morphism and test factorization are not equal" ];
    fi;
    
    if not IsEqualForObjects( cat, Range( morphism ), Range( test_factorization[ 2 ] ) ) then
        return [ false, "range of morphism and test factorization are not equal" ];
    fi;
    
    if not IsEqualForObjects( cat, Range( test_factorization[ 1 ] ), Source( test_factorization[ 2 ] ) ) then
        return [ false, "source and range of test factorization are not equal" ];
    fi;
    
    return [ true ];
  end,
  return_type := "morphism",
  dual_operation := "UniversalMorphismFromImage" ),

UniversalMorphismIntoCoimageWithGivenCoimageObject := rec(
  filter_list := [ "category", "morphism", "pair_of_morphisms", "object" ],
  input_arguments_names := [ "cat", "alpha", "tau", "C" ],
  output_source_getter_string := "Range( tau[1] )",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "C",
  output_range_getter_preconditions := [ ],
  dual_preprocessor_func := function( cat, alpha, tau, C )
    return NTuple( 4, OppositeCategory( cat ), Opposite( alpha ), Pair( Opposite( tau[2] ), Opposite( tau[1] ) ), Opposite( C ) );
  end,
  pre_function := function( cat, morphism, test_factorization, image )
    
    if not IsEqualForObjects( cat, Source( morphism ), Source( test_factorization[ 1 ] ) ) then
        return [ false, "source of morphism and test factorization are not equal" ];
    fi;
    
    if not IsEqualForObjects( cat, Range( morphism ), Range( test_factorization[ 2 ] ) ) then
        return [ false, "range of morphism and test factorization are not equal" ];
    fi;
    
    if not IsEqualForObjects( cat, Range( test_factorization[ 1 ] ), Source( test_factorization[ 2 ] ) ) then
        return [ false, "source and range of test factorization are not equal" ];
    fi;
    
    return [ true ];
  end,
  return_type := "morphism",
  dual_operation := "UniversalMorphismFromImageWithGivenImageObject" ),

MorphismFromCoimageToImage := rec(
  filter_list := [ "category", "morphism" ],
  input_arguments_names := [ "cat", "alpha" ],
  output_source_getter_string := "CoimageObject( cat, alpha )",
  output_source_getter_preconditions := [ [ "CoimageObject", 1 ] ],
  output_range_getter_string := "ImageObject( cat, alpha )",
  output_range_getter_preconditions := [ [ "ImageObject", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "MorphismFromCoimageToImage",
  return_type := "morphism" ),

MorphismFromCoimageToImageWithGivenObjects := rec(
  filter_list := [ "category", "object", "morphism", "object" ],
  input_arguments_names := [ "cat", "C", "alpha", "I" ],
  output_source_getter_string := "C",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "I",
  output_range_getter_preconditions := [ ],
  dual_operation := "MorphismFromCoimageToImageWithGivenObjects",
  dual_arguments_reversed := true,
  return_type := "morphism" ),

InverseOfMorphismFromCoimageToImage := rec(
  filter_list := [ "category", "morphism" ],
  input_arguments_names := [ "cat", "alpha" ],
  output_source_getter_string := "ImageObject( cat, alpha )",
  output_source_getter_preconditions := [ [ "ImageObject", 1 ] ],
  output_range_getter_string := "CoimageObject( cat, alpha )",
  output_range_getter_preconditions := [ [ "CoimageObject", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "InverseOfMorphismFromCoimageToImage",
  return_type := "morphism" ),

InverseOfMorphismFromCoimageToImageWithGivenObjects := rec(
  filter_list := [ "category", "object", "morphism", "object" ],
  input_arguments_names := [ "cat", "I", "alpha", "C" ],
  output_source_getter_string := "I",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "C",
  output_range_getter_preconditions := [ ],
  dual_operation := "InverseOfMorphismFromCoimageToImageWithGivenObjects",
  dual_arguments_reversed := true,
  return_type := "morphism" ),

IsWellDefinedForMorphisms := rec(
  filter_list := [ "category", "morphism" ],
  input_arguments_names := [ "cat", "alpha" ],
  dual_operation := "IsWellDefinedForMorphisms",
  
  redirect_function := function( cat, morphism )
    local source, range;
    
    source := Source( morphism );
    
    range := Range( morphism );
    
    if not ( IsWellDefinedForObjects( cat, source ) and IsWellDefinedForObjects( cat, range ) ) then
      
      return [ true, false ];
      
      
    else
      
      return [ false ];
      
    fi;
    
  end,
  
  return_type := "bool" ),

IsWellDefinedForMorphismsWithGivenSourceAndRange := rec(
  filter_list := [ "category", "object", "morphism", "object" ],
  input_arguments_names := [ "cat", "source", "alpha", "range" ],
  return_type := "bool",
  dual_operation := "IsWellDefinedForMorphismsWithGivenSourceAndRange",
  dual_arguments_reversed := true,
),

IsWellDefinedForObjects := rec(
  filter_list := [ "category", "object" ],
  dual_operation := "IsWellDefinedForObjects",
  return_type := "bool" ),

IsZeroForObjects := rec(
  filter_list := [ "category", "object" ],
  return_type := "bool",
  dual_operation := "IsZeroForObjects",
),

IsMonomorphism := rec(
  filter_list := [ "category", "morphism" ],
  return_type := "bool",
  dual_operation := "IsEpimorphism",
  is_reflected_by_faithful_functor := true,
),

IsEpimorphism := rec(
  filter_list := [ "category", "morphism" ],
  return_type := "bool",
  dual_operation := "IsMonomorphism",
  is_reflected_by_faithful_functor := true,
),

IsIsomorphism := rec(
  filter_list := [ "category", "morphism" ],
  dual_operation := "IsIsomorphism",
  return_type := "bool",
),

IsEndomorphism := rec(
  filter_list := [ "category", "morphism" ],
  return_type := "bool",
  dual_operation := "IsEndomorphism",
),

IsAutomorphism := rec(
  filter_list := [ "category", "morphism" ],
  return_type := "bool",
  dual_operation := "IsAutomorphism",
),

IsOne := rec(
  filter_list := [ "category", "morphism" ],
  return_type := "bool",
  dual_operation := "IsOne",
  pre_function := function( cat, morphism )
    
    if not IsEqualForObjects( cat, Source( morphism ), Range( morphism ) ) then
        
        return [ false, "source and range of the given morphism are not equal" ];
        
    fi;
    
    return [ true ];
  end,
),

IsSplitMonomorphism := rec(
  filter_list := [ "category", "morphism" ],
  return_type := "bool",
  dual_operation := "IsSplitEpimorphism",
),

IsSplitEpimorphism := rec(
  filter_list := [ "category", "morphism" ],
  return_type := "bool",
  dual_operation := "IsSplitMonomorphism",
),

IsIdempotent := rec(
   pre_function := function( cat, morphism )
    
    # do not use IsEndomorphism( morphism ) here because you don't know if
    # the user has given an own IsEndomorphism function
    if not IsEqualForObjects( cat, Source( morphism ), Range( morphism ) ) then
      
      return [ false, "the given morphism has to be an endomorphism" ];
      
    fi;
    
    return [ true ];
  end,
  filter_list := [ "category", "morphism" ],
  return_type := "bool",
  dual_operation := "IsIdempotent",
),

IsBijectiveObject := rec(
  filter_list := [ "category", "object" ],
  return_type := "bool",
  dual_operation := "IsBijectiveObject",
),

IsProjective := rec(
  filter_list := [ "category", "object" ],
  return_type := "bool",
  dual_operation := "IsInjective",
),

IsInjective := rec(
  filter_list := [ "category", "object" ],
  return_type := "bool",
  dual_operation := "IsProjective",
),

IsTerminal := rec(
  filter_list := [ "category", "object" ],
  return_type := "bool",
  dual_operation := "IsInitial",
),

IsInitial := rec(
  filter_list := [ "category", "object" ],
  return_type := "bool",
  dual_operation := "IsTerminal",
),

IsEqualToIdentityMorphism := rec(
  filter_list := [ "category", "morphism" ],
  return_type := "bool",
  dual_operation := "IsEqualToIdentityMorphism",
),

IsEqualToZeroMorphism := rec(
  filter_list := [ "category", "morphism" ],
  return_type := "bool",
  dual_operation := "IsEqualToZeroMorphism",
),

CoastrictionToImage := rec(
  filter_list := [ "category", "morphism" ],
  input_arguments_names := [ "cat", "alpha" ],
  output_source_getter_string := "Source( alpha )",
  output_source_getter_preconditions := [ ],
  with_given_object_position := "Range",
  return_type := "morphism",
  dual_operation := "AstrictionToCoimage" ),

CoastrictionToImageWithGivenImageObject := rec(
  filter_list := [ "category", "morphism", "object" ],
  input_arguments_names := [ "cat", "alpha", "I" ],
  output_source_getter_string := "Source( alpha )",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "I",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "AstrictionToCoimageWithGivenCoimageObject" ),

UniversalMorphismFromImage := rec(
  filter_list := [ "category", "morphism", "pair_of_morphisms" ],
  input_arguments_names := [ "cat", "alpha", "tau" ],
  output_range_getter_string := "Range( tau[1] )",
  output_range_getter_preconditions := [ ],
  with_given_object_position := "Source",
  dual_operation := "UniversalMorphismIntoCoimage",
  dual_preprocessor_func := function( cat, alpha, tau )
    return Triple( OppositeCategory( cat ), Opposite( alpha ), Pair( Opposite( tau[2] ), Opposite( tau[1] ) ) );
  end,
  pre_function := function( cat, morphism, test_factorization )
    
    if not IsEqualForObjects( cat, Source( morphism ), Source( test_factorization[ 1 ] ) ) then
        return [ false, "source of morphism and test factorization are not equal" ];
    fi;
    
    if not IsEqualForObjects( cat, Range( morphism ), Range( test_factorization[ 2 ] ) ) then
        return [ false, "range of morphism and test factorization are not equal" ];
    fi;
    
    if not IsEqualForObjects( cat, Range( test_factorization[ 1 ] ), Source( test_factorization[ 2 ] ) ) then
        return [ false, "source and range of test factorization are not equal" ];
    fi;
    
    return [ true ];
  end,
  return_type := "morphism" ),

UniversalMorphismFromImageWithGivenImageObject := rec(
  filter_list := [ "category", "morphism", "pair_of_morphisms", "object" ],
  input_arguments_names := [ "cat", "alpha", "tau", "I" ],
  output_source_getter_string := "I",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "Range( tau[1] )",
  output_range_getter_preconditions := [ ],
  dual_operation := "UniversalMorphismIntoCoimageWithGivenCoimageObject",
  dual_preprocessor_func := function( cat, alpha, tau, I )
    return NTuple( 4, OppositeCategory( cat ), Opposite( alpha ), Pair( Opposite( tau[2] ), Opposite( tau[1] ) ), Opposite( I ) );
  end,
  pre_function := function( cat, morphism, test_factorization, image )
    
    if not IsEqualForObjects( cat, Source( morphism ), Source( test_factorization[ 1 ] ) ) then
        return [ false, "source of morphism and test factorization are not equal" ];
    fi;
    
    if not IsEqualForObjects( cat, Range( morphism ), Range( test_factorization[ 2 ] ) ) then
        return [ false, "range of morphism and test factorization are not equal" ];
    fi;
    
    if not IsEqualForObjects( cat, Range( test_factorization[ 1 ] ), Source( test_factorization[ 2 ] ) ) then
        return [ false, "source and range of test factorization are not equal" ];
    fi;
    
    return [ true ];
  end,
  return_type := "morphism" ),

KernelObjectFunctorial := rec(
  filter_list := [ "category", "morphism", "morphism", "morphism" ],
  input_arguments_names := [ "cat", "alpha", "mu", "alphap" ],
  return_type := "morphism",
  output_source_getter_string := "KernelObject( cat, alpha )",
  output_source_getter_preconditions := [ [ "KernelObject", 1 ] ],
  output_range_getter_string := "KernelObject( cat, alphap )",
  output_range_getter_preconditions := [ [ "KernelObject", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "CokernelObjectFunctorial",
  dual_arguments_reversed := true,
  compatible_with_congruence_of_morphisms := false,
),

KernelObjectFunctorialWithGivenKernelObjects := rec(
  filter_list := [ "category", "object", "morphism", "morphism", "morphism", "object" ],
  input_arguments_names := [ "cat", "P", "alpha", "mu", "alphap", "Pp" ],
  output_source_getter_string := "P",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "Pp",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "CokernelObjectFunctorialWithGivenCokernelObjects",
  dual_arguments_reversed := true,
  compatible_with_congruence_of_morphisms := false,
),

CokernelObjectFunctorial := rec(
  filter_list := [ "category", "morphism", "morphism", "morphism" ],
  input_arguments_names := [ "cat", "alpha", "mu", "alphap" ],
  return_type := "morphism",
  output_source_getter_string := "CokernelObject( cat, alpha )",
  output_source_getter_preconditions := [ [ "CokernelObject", 1 ] ],
  output_range_getter_string := "CokernelObject( cat, alphap )",
  output_range_getter_preconditions := [ [ "CokernelObject", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "KernelObjectFunctorial",
  dual_arguments_reversed := true,
  compatible_with_congruence_of_morphisms := false,
),

CokernelObjectFunctorialWithGivenCokernelObjects := rec(
  filter_list := [ "category", "object", "morphism", "morphism", "morphism", "object" ],
  input_arguments_names := [ "cat", "P", "alpha", "mu", "alphap", "Pp" ],
  output_source_getter_string := "P",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "Pp",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "KernelObjectFunctorialWithGivenKernelObjects",
  dual_arguments_reversed := true,
  compatible_with_congruence_of_morphisms := false,
),

TerminalObjectFunctorial := rec(
  filter_list := [ "category" ],
  input_arguments_names := [ "cat" ],
  return_type := "morphism",
  output_source_getter_string := "TerminalObject( cat )",
  output_source_getter_preconditions := [ [ "TerminalObject", 1 ] ],
  output_range_getter_string := "TerminalObject( cat )",
  output_range_getter_preconditions := [ [ "TerminalObject", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "InitialObjectFunctorial",
  dual_arguments_reversed := true,
),

TerminalObjectFunctorialWithGivenTerminalObjects := rec(
  filter_list := [ "category", "object", "object" ],
  input_arguments_names := [ "cat", "P", "Pp" ],
  output_source_getter_string := "P",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "Pp",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "InitialObjectFunctorialWithGivenInitialObjects",
  dual_arguments_reversed := true,
),

InitialObjectFunctorial := rec(
  filter_list := [ "category" ],
  input_arguments_names := [ "cat" ],
  return_type := "morphism",
  output_source_getter_string := "InitialObject( cat )",
  output_source_getter_preconditions := [ [ "InitialObject", 1 ] ],
  output_range_getter_string := "InitialObject( cat )",
  output_range_getter_preconditions := [ [ "InitialObject", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "TerminalObjectFunctorial",
  dual_arguments_reversed := true,
),

InitialObjectFunctorialWithGivenInitialObjects := rec(
  filter_list := [ "category", "object", "object" ],
  input_arguments_names := [ "cat", "P", "Pp" ],
  output_source_getter_string := "P",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "Pp",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "TerminalObjectFunctorialWithGivenTerminalObjects",
  dual_arguments_reversed := true,
),

DirectProductFunctorial := rec(
  filter_list := [ "category", "list_of_objects", "list_of_morphisms", "list_of_objects" ],
  input_arguments_names := [ "cat", "objects", "L", "objectsp" ],
  return_type := "morphism",
  output_source_getter_string := "DirectProduct( cat, objects )",
  output_source_getter_preconditions := [ [ "DirectProduct", 1 ] ],
  output_range_getter_string := "DirectProduct( cat, objectsp )",
  output_range_getter_preconditions := [ [ "DirectProduct", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "CoproductFunctorial",
  dual_arguments_reversed := true,
  compatible_with_congruence_of_morphisms := true,
),

DirectProductFunctorialWithGivenDirectProducts := rec(
  filter_list := [ "category", "object", "list_of_objects", "list_of_morphisms", "list_of_objects", "object" ],
  input_arguments_names := [ "cat", "P", "objects", "L", "objectsp", "Pp" ],
  output_source_getter_string := "P",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "Pp",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "CoproductFunctorialWithGivenCoproducts",
  dual_arguments_reversed := true,
  compatible_with_congruence_of_morphisms := true,
),

CoproductFunctorial := rec(
  filter_list := [ "category", "list_of_objects", "list_of_morphisms", "list_of_objects" ],
  input_arguments_names := [ "cat", "objects", "L", "objectsp" ],
  return_type := "morphism",
  output_source_getter_string := "Coproduct( cat, objects )",
  output_source_getter_preconditions := [ [ "Coproduct", 1 ] ],
  output_range_getter_string := "Coproduct( cat, objectsp )",
  output_range_getter_preconditions := [ [ "Coproduct", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "DirectProductFunctorial",
  dual_arguments_reversed := true,
  compatible_with_congruence_of_morphisms := true,
),

CoproductFunctorialWithGivenCoproducts := rec(
  filter_list := [ "category", "object", "list_of_objects", "list_of_morphisms", "list_of_objects", "object" ],
  input_arguments_names := [ "cat", "P", "objects", "L", "objectsp", "Pp" ],
  output_source_getter_string := "P",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "Pp",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "DirectProductFunctorialWithGivenDirectProducts",
  dual_arguments_reversed := true,
  compatible_with_congruence_of_morphisms := true,
),

DirectSumFunctorial := rec(
  filter_list := [ "category", "list_of_objects", "list_of_morphisms", "list_of_objects" ],
  input_arguments_names := [ "cat", "objects", "L", "objectsp" ],
  return_type := "morphism",
  output_source_getter_string := "DirectSum( cat, objects )",
  output_source_getter_preconditions := [ [ "DirectSum", 1 ] ],
  output_range_getter_string := "DirectSum( cat, objectsp )",
  output_range_getter_preconditions := [ [ "DirectSum", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "DirectSumFunctorial",
  dual_arguments_reversed := true,
  compatible_with_congruence_of_morphisms := true,
),

DirectSumFunctorialWithGivenDirectSums := rec(
  filter_list := [ "category", "object", "list_of_objects", "list_of_morphisms", "list_of_objects", "object" ],
  input_arguments_names := [ "cat", "P", "objects", "L", "objectsp", "Pp" ],
  output_source_getter_string := "P",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "Pp",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "DirectSumFunctorialWithGivenDirectSums",
  dual_arguments_reversed := true,
  compatible_with_congruence_of_morphisms := true,
),

EqualizerFunctorial := rec(
  filter_list := [ "category", "list_of_morphisms", "morphism", "list_of_morphisms" ],
  input_arguments_names := [ "cat", "morphisms", "mu", "morphismsp" ],
  return_type := "morphism",
  output_source_getter_string := "Equalizer( cat, Source( mu ), morphisms )",
  output_source_getter_preconditions := [ [ "Equalizer", 1 ] ],
  output_range_getter_string := "Equalizer( cat, Range( mu ), morphismsp )",
  output_range_getter_preconditions := [ [ "Equalizer", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "CoequalizerFunctorial",
  dual_arguments_reversed := true,
  compatible_with_congruence_of_morphisms := false,
),

EqualizerFunctorialWithGivenEqualizers := rec(
  filter_list := [ "category", "object", "list_of_morphisms", "morphism", "list_of_morphisms", "object" ],
  input_arguments_names := [ "cat", "P", "morphisms", "mu", "morphismsp", "Pp" ],
  output_source_getter_string := "P",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "Pp",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "CoequalizerFunctorialWithGivenCoequalizers",
  dual_arguments_reversed := true,
  compatible_with_congruence_of_morphisms := false,
),

CoequalizerFunctorial := rec(
  filter_list := [ "category", "list_of_morphisms", "morphism", "list_of_morphisms" ],
  input_arguments_names := [ "cat", "morphisms", "mu", "morphismsp" ],
  return_type := "morphism",
  output_source_getter_string := "Coequalizer( cat, Source( mu ), morphisms )",
  output_source_getter_preconditions := [ [ "Coequalizer", 1 ] ],
  output_range_getter_string := "Coequalizer( cat, Range( mu ), morphismsp )",
  output_range_getter_preconditions := [ [ "Coequalizer", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "EqualizerFunctorial",
  dual_arguments_reversed := true,
  compatible_with_congruence_of_morphisms := false,
),

CoequalizerFunctorialWithGivenCoequalizers := rec(
  filter_list := [ "category", "object", "list_of_morphisms", "morphism", "list_of_morphisms", "object" ],
  input_arguments_names := [ "cat", "P", "morphisms", "mu", "morphismsp", "Pp" ],
  output_source_getter_string := "P",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "Pp",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "EqualizerFunctorialWithGivenEqualizers",
  dual_arguments_reversed := true,
  compatible_with_congruence_of_morphisms := false,
),

FiberProductFunctorial := rec(
  filter_list := [ "category", "list_of_morphisms", "list_of_morphisms", "list_of_morphisms" ],
  input_arguments_names := [ "cat", "morphisms", "L", "morphismsp" ],
  return_type := "morphism",
  output_source_getter_string := "FiberProduct( cat, morphisms )",
  output_source_getter_preconditions := [ [ "FiberProduct", 1 ] ],
  output_range_getter_string := "FiberProduct( cat, morphismsp )",
  output_range_getter_preconditions := [ [ "FiberProduct", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "PushoutFunctorial",
  dual_arguments_reversed := true,
  compatible_with_congruence_of_morphisms := false,
),

FiberProductFunctorialWithGivenFiberProducts := rec(
  filter_list := [ "category", "object", "list_of_morphisms", "list_of_morphisms", "list_of_morphisms", "object" ],
  input_arguments_names := [ "cat", "P", "morphisms", "L", "morphismsp", "Pp" ],
  output_source_getter_string := "P",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "Pp",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "PushoutFunctorialWithGivenPushouts",
  dual_arguments_reversed := true,
  compatible_with_congruence_of_morphisms := false,
),

PushoutFunctorial := rec(
  filter_list := [ "category", "list_of_morphisms", "list_of_morphisms", "list_of_morphisms" ],
  input_arguments_names := [ "cat", "morphisms", "L", "morphismsp" ],
  return_type := "morphism",
  output_source_getter_string := "Pushout( cat, morphisms )",
  output_source_getter_preconditions := [ [ "Pushout", 1 ] ],
  output_range_getter_string := "Pushout( cat, morphismsp )",
  output_range_getter_preconditions := [ [ "Pushout", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "FiberProductFunctorial",
  dual_arguments_reversed := true,
  compatible_with_congruence_of_morphisms := false,
),

PushoutFunctorialWithGivenPushouts := rec(
  filter_list := [ "category", "object", "list_of_morphisms", "list_of_morphisms", "list_of_morphisms", "object" ],
  input_arguments_names := [ "cat", "P", "morphisms", "L", "morphismsp", "Pp" ],
  output_source_getter_string := "P",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "Pp",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "FiberProductFunctorialWithGivenFiberProducts",
  dual_arguments_reversed := true,
  compatible_with_congruence_of_morphisms := false,
),

ImageObjectFunctorial := rec(
  filter_list := [ "category", "morphism", "morphism", "morphism" ],
  input_arguments_names := [ "cat", "alpha", "nu", "alphap" ],
  return_type := "morphism",
  output_source_getter_string := "ImageObject( cat, alpha )",
  output_source_getter_preconditions := [ [ "ImageObject", 1 ] ],
  output_range_getter_string := "ImageObject( cat, alphap )",
  output_range_getter_preconditions := [ [ "ImageObject", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "CoimageObjectFunctorial",
  dual_arguments_reversed := true,
),

ImageObjectFunctorialWithGivenImageObjects := rec(
  filter_list := [ "category", "object", "morphism", "morphism", "morphism", "object" ],
  input_arguments_names := [ "cat", "I", "alpha", "nu", "alphap", "Ip" ],
  output_source_getter_string := "I",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "Ip",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "CoimageObjectFunctorialWithGivenCoimageObjects",
  dual_arguments_reversed := true,
),

CoimageObjectFunctorial := rec(
  filter_list := [ "category", "morphism", "morphism", "morphism" ],
  input_arguments_names := [ "cat", "alpha", "mu", "alphap" ],
  return_type := "morphism",
  output_source_getter_string := "CoimageObject( cat, alpha )",
  output_source_getter_preconditions := [ [ "CoimageObject", 1 ] ],
  output_range_getter_string := "CoimageObject( cat, alphap )",
  output_range_getter_preconditions := [ [ "CoimageObject", 1 ] ],
  with_given_object_position := "both",
  dual_operation := "ImageObjectFunctorial",
  dual_arguments_reversed := true,
),

CoimageObjectFunctorialWithGivenCoimageObjects := rec(
  filter_list := [ "category", "object", "morphism", "morphism", "morphism", "object" ],
  input_arguments_names := [ "cat", "C", "alpha", "mu", "alphap", "Cp" ],
  output_source_getter_string := "C",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "Cp",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "ImageObjectFunctorialWithGivenImageObjects",
  dual_arguments_reversed := true,
),

HorizontalPreCompose := rec(
  filter_list := [ "category", "twocell", "twocell" ],
  dual_operation := "HorizontalPostCompose",
  
  pre_function := function( cat, twocell_1, twocell_2 )
    
    if not IsEqualForObjects( cat, Range( Source( twocell_1 ) ), Source( Source( twocell_2 ) ) ) then
        return [ false, "2-cells are not horizontally composable" ];
    fi;
    
    return [ true ];
  end,
  return_type := "twocell" ),

HorizontalPostCompose := rec(
  filter_list := [ "category", "twocell", "twocell" ],
  dual_operation := "HorizontalPreCompose",
  
  pre_function := function( cat, twocell_2, twocell_1 )
    
    if not IsEqualForObjects( cat, Range( Source( twocell_1 ) ), Source( Source( twocell_2 ) ) ) then
        return [ false, "2-cells are not horizontally composable" ];
    fi;
    
    return [ true ];
  end,
  return_type := "twocell" ),

VerticalPreCompose := rec(
  filter_list := [ "category", "twocell", "twocell" ],
  dual_operation := "VerticalPostCompose",
  
  pre_function := function( cat, twocell_1, twocell_2 )
    
    if not IsEqualForMorphisms( Range( twocell_1 ), Source( twocell_2 ) ) then
        return [ false, "2-cells are not vertically composable" ];
    fi;
    
    return [ true ];
  end,
  return_type := "twocell" ),

VerticalPostCompose := rec(
  filter_list := [ "category", "twocell", "twocell" ],
  dual_operation := "VerticalPreCompose",
  
  pre_function := function( cat, twocell_2, twocell_1 )
    
    if not IsEqualForMorphisms( Range( twocell_1 ), Source( twocell_2 ) ) then
        return [ false, "2-cells are not vertically composable" ];
    fi;
    
    return [ true ];
  end,
  return_type := "twocell" ),

IdentityTwoCell := rec(
  filter_list := [ "category", "morphism" ],
  dual_operation := "IdentityTwoCell",
  return_type := "twocell" ),

IsWellDefinedForTwoCells := rec(
  filter_list := [ "category", "twocell" ],
  dual_operation := "IsWellDefinedForTwoCells",
  
  redirect_function := function( cat, twocell )
    
    if not( IsWellDefined( Source( twocell ) ) and IsWellDefined( Range( twocell ) ) ) then
      
      return [ true, false ];
      
    fi;
    
    return [ false ];
    
  end,
  
  return_type := "bool" ),
  
JointPairwiseDifferencesOfMorphismsIntoDirectProduct := rec(
  filter_list := [ "category", "object", "list_of_morphisms" ],
  input_arguments_names := [ "cat", "A", "D" ],
  output_source_getter_string := "A",
  output_source_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "JointPairwiseDifferencesOfMorphismsFromCoproduct",
),

IsomorphismFromFiberProductToEqualizerOfDirectProductDiagram := rec(
  filter_list := [ "category", "list_of_morphisms" ],
  input_arguments_names := [ "cat", "D" ],
  return_type := "morphism",
  dual_operation := "IsomorphismFromCoequalizerOfCoproductDiagramToPushout",
),
  
IsomorphismFromEqualizerOfDirectProductDiagramToFiberProduct := rec(
  filter_list := [ "category", "list_of_morphisms" ],
  input_arguments_names := [ "cat", "D" ],
  return_type := "morphism",
  dual_operation := "IsomorphismFromPushoutToCoequalizerOfCoproductDiagram",
),
  
IsomorphismFromPushoutToCoequalizerOfCoproductDiagram := rec(
  filter_list := [ "category", "list_of_morphisms" ],
  input_arguments_names := [ "cat", "D" ],
  return_type := "morphism",
  dual_operation := "IsomorphismFromEqualizerOfDirectProductDiagramToFiberProduct",
),
  
IsomorphismFromCoequalizerOfCoproductDiagramToPushout := rec(
  filter_list := [ "category", "list_of_morphisms" ],
  input_arguments_names := [ "cat", "D" ],
  return_type := "morphism",
  dual_operation := "IsomorphismFromFiberProductToEqualizerOfDirectProductDiagram",
),

IsomorphismFromImageObjectToKernelOfCokernel := rec(
  filter_list := [ "category", "morphism" ],
  input_arguments_names := [ "cat", "alpha" ],
  return_type := "morphism",
  dual_operation := "IsomorphismFromCokernelOfKernelToCoimage",
),

IsomorphismFromKernelOfCokernelToImageObject := rec(
  filter_list := [ "category", "morphism" ],
  input_arguments_names := [ "cat", "alpha" ],
  return_type := "morphism",
  dual_operation := "IsomorphismFromCoimageToCokernelOfKernel",
),

IsomorphismFromCoimageToCokernelOfKernel := rec(
  filter_list := [ "category", "morphism" ],
  input_arguments_names := [ "cat", "alpha" ],
  return_type := "morphism",
  dual_operation := "IsomorphismFromKernelOfCokernelToImageObject",
),

IsomorphismFromCokernelOfKernelToCoimage := rec(
  filter_list := [ "category", "morphism" ],
  input_arguments_names := [ "cat", "alpha" ],
  return_type := "morphism",
  dual_operation := "IsomorphismFromImageObjectToKernelOfCokernel",
),

IsomorphismFromDirectSumToDirectProduct := rec(
  filter_list := [ "category", "list_of_objects" ],
  input_arguments_names := [ "cat", "D" ],
  return_type := "morphism",
  dual_operation := "IsomorphismFromCoproductToDirectSum",
),

IsomorphismFromDirectSumToCoproduct := rec(
  filter_list := [ "category", "list_of_objects" ],
  input_arguments_names := [ "cat", "D" ],
  return_type := "morphism",
  dual_operation := "IsomorphismFromDirectProductToDirectSum",
),

IsomorphismFromDirectProductToDirectSum := rec(
  filter_list := [ "category", "list_of_objects" ],
  input_arguments_names := [ "cat", "D" ],
  return_type := "morphism",
  dual_operation := "IsomorphismFromDirectSumToCoproduct",
),

IsomorphismFromCoproductToDirectSum := rec(
  filter_list := [ "category", "list_of_objects" ],
  input_arguments_names := [ "cat", "D" ],
  return_type := "morphism",
  dual_operation := "IsomorphismFromDirectSumToDirectProduct",
),

JointPairwiseDifferencesOfMorphismsFromCoproduct := rec(
  filter_list := [ "category", "object", "list_of_morphisms" ],
  input_arguments_names := [ "cat", "A", "D" ],
  output_range_getter_string := "A",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "JointPairwiseDifferencesOfMorphismsIntoDirectProduct",
),

SomeProjectiveObject := rec(
  filter_list := [ "category", "object" ],
  return_type := "object",
  dual_operation := "SomeInjectiveObject",
  is_merely_set_theoretic := true ),

EpimorphismFromSomeProjectiveObject := rec(
  filter_list := [ "category", "object" ],
  input_arguments_names := [ "cat", "A" ],
  output_range_getter_string := "A",
  output_range_getter_preconditions := [ ],
  with_given_object_position := "Source",
  return_type := "morphism",
  dual_operation := "MonomorphismIntoSomeInjectiveObject",
  is_merely_set_theoretic := true ),

EpimorphismFromSomeProjectiveObjectWithGivenSomeProjectiveObject := rec(
  filter_list := [ "category", "object", "object" ],
  input_arguments_names := [ "cat", "A", "P" ],
  output_source_getter_string := "P",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "A",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "MonomorphismIntoSomeInjectiveObjectWithGivenSomeInjectiveObject",
  is_merely_set_theoretic := true ),

SomeInjectiveObject := rec(
  filter_list := [ "category", "object" ],
  return_type := "object",
  dual_operation := "SomeProjectiveObject",
  is_merely_set_theoretic := true ),

MonomorphismIntoSomeInjectiveObject := rec(
  filter_list := [ "category", "object" ],
  input_arguments_names := [ "cat", "A" ],
  output_source_getter_string := "A",
  output_source_getter_preconditions := [ ],
  with_given_object_position := "Range",
  return_type := "morphism",
  dual_operation := "EpimorphismFromSomeProjectiveObject",
  is_merely_set_theoretic := true ),

MonomorphismIntoSomeInjectiveObjectWithGivenSomeInjectiveObject := rec(
  filter_list := [ "category", "object", "object" ],
  input_arguments_names := [ "cat", "A", "I" ],
  output_source_getter_string := "A",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "I",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "EpimorphismFromSomeProjectiveObjectWithGivenSomeProjectiveObject",
  is_merely_set_theoretic := true ),

ComponentOfMorphismIntoDirectSum := rec(
  filter_list := [ "category", "morphism", "list_of_objects", "integer" ],
  input_arguments_names := [ "cat", "alpha", "S", "i" ],
  output_source_getter_string := "Source( alpha )",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "S[i]",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "ComponentOfMorphismFromDirectSum" ),

ComponentOfMorphismFromDirectSum := rec(
  filter_list := [ "category", "morphism", "list_of_objects", "integer" ],
  input_arguments_names := [ "cat", "alpha", "S", "i" ],
  output_source_getter_string := "S[i]",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "Range( alpha )",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "ComponentOfMorphismIntoDirectSum" ),

MorphismBetweenDirectSums := rec(
  filter_list := [ "category", "list_of_objects", "list_of_lists_of_morphisms", "list_of_objects" ],
  input_arguments_names := [ "cat", "source_diagram", "mat", "range_diagram" ],
  return_type := "morphism",
  output_source_getter_string := "DirectSum( cat, source_diagram )",
  output_source_getter_preconditions := [ [ "DirectSum", 1 ] ],
  output_range_getter_string := "DirectSum( cat, range_diagram )",
  output_range_getter_preconditions := [ [ "DirectSum", 1 ] ],
  with_given_object_position := "both",
  pre_function := function( cat, source_diagram, listlist, range_diagram )
    local i, j;
      
      if Length( listlist ) <> Length( source_diagram ) then
          
          return [ false, "the number of rows does not match the length of the source diagram" ];
          
      fi;
      
      for i in [ 1 .. Length( listlist ) ] do
          
          if Length( listlist[i] ) <> Length( range_diagram ) then
              
              return [ false, Concatenation( "the ", String(i), ". row has not the same length as the range diagram" ) ];
              
          fi;
          
          for j in [ 1 .. Length( range_diagram ) ] do
              
              if not IsEqualForObjects( cat, source_diagram[i], Source( listlist[i][j] ) ) then
                  
                  return [ false, Concatenation( "the sources of the morphisms in the ", String(i), ". row must be equal to the ", String(i), ". entry of the source diagram" ) ];
                  
              fi;
              
              if not IsEqualForObjects( cat, range_diagram[j], Range( listlist[i][j] ) ) then
                  
                  return [ false, Concatenation( "the ranges of the morphisms in the ", String(j), ". column must be equal to the ", String(j), ". entry of the range diagram" ) ];
                  
              fi;
              
          od;
          
      od;
      
      return [ true ];
      
  end,
  dual_operation := "MorphismBetweenDirectSums",
  dual_preprocessor_func := function( arg )
      local list;
      list := CAP_INTERNAL_OPPOSITE_RECURSIVE( arg );
      
      return NTuple( 4, list[1], list[4], TransposedMatWithGivenDimensions( Length( list[2] ), Length( list[4] ), list[3] ), list[2] );
  end
),

MorphismBetweenDirectSumsWithGivenDirectSums := rec(
  filter_list := [ "category", "object", "list_of_objects", "list_of_lists_of_morphisms", "list_of_objects", "object" ],
  input_arguments_names := [ "cat", "S", "source_diagram", "mat", "range_diagram", "T" ],
  output_source_getter_string := "S",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "T",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "MorphismBetweenDirectSumsWithGivenDirectSums",
  dual_preprocessor_func := function( arg )
      local list;
      list := CAP_INTERNAL_OPPOSITE_RECURSIVE( arg );
      return NTuple( 6, list[1], list[6], list[5], TransposedMatWithGivenDimensions( Length( list[3] ), Length( list[5] ), list[4] ), list[3], list[2] );
  end
),

IsHomSetInhabited := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "bool",
  dual_operation := "IsHomSetInhabited",
  dual_arguments_reversed := true,
),

HomomorphismStructureOnObjects := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "object_in_range_category_of_homomorphism_structure",
  dual_operation := "HomomorphismStructureOnObjects",
  dual_arguments_reversed := true,
  dual_postprocessor_func := IdFunc
),

HomomorphismStructureOnMorphisms := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  input_arguments_names := [ "cat", "alpha", "beta" ],
  output_source_getter_string := "HomomorphismStructureOnObjects( cat, Range( alpha ), Source( beta ) )",
  output_source_getter_preconditions := [ [ "HomomorphismStructureOnObjects", 1 ] ],
  output_range_getter_string := "HomomorphismStructureOnObjects( cat, Source( alpha ), Range( beta ) )",
  output_range_getter_preconditions := [ [ "HomomorphismStructureOnObjects", 1 ] ],
  with_given_object_position := "both",
  return_type := "morphism_in_range_category_of_homomorphism_structure",
  dual_operation := "HomomorphismStructureOnMorphisms",
  dual_preprocessor_func := function( cat, alpha, beta )
    return Triple( OppositeCategory( cat ), Opposite( beta ), Opposite( alpha ) );
  end,
  dual_postprocessor_func := IdFunc,
),

HomomorphismStructureOnMorphismsWithGivenObjects := rec(
  filter_list := [ "category", "object_in_range_category_of_homomorphism_structure", "morphism", "morphism", "object_in_range_category_of_homomorphism_structure" ],
  input_arguments_names := [ "cat", "source", "alpha", "beta", "range" ],
  output_source_getter_string := "source",
  output_range_getter_string := "range",
  return_type := "morphism_in_range_category_of_homomorphism_structure",
  dual_operation := "HomomorphismStructureOnMorphismsWithGivenObjects",
  dual_preprocessor_func := function( cat, source, alpha, beta, range )
    return NTuple( 5, OppositeCategory( cat ), source, Opposite( beta ), Opposite( alpha ), range );
  end,
  dual_postprocessor_func := IdFunc,
),

DistinguishedObjectOfHomomorphismStructure := rec(
  filter_list := [ "category" ],
  return_type := "object_in_range_category_of_homomorphism_structure",
  dual_operation := "DistinguishedObjectOfHomomorphismStructure",
  dual_postprocessor_func := IdFunc ),

InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure := rec(
  filter_list := [ "category", "morphism" ],
  input_arguments_names := [ "cat", "alpha" ],
  output_source_getter_string := "DistinguishedObjectOfHomomorphismStructure( cat )",
  output_source_getter_preconditions := [ [ "DistinguishedObjectOfHomomorphismStructure", 1 ] ],
  output_range_getter_string := "HomomorphismStructureOnObjects( cat, Source( alpha ), Range( alpha ) )",
  output_range_getter_preconditions := [ [ "HomomorphismStructureOnObjects", 1 ] ],
  with_given_object_position := "both",
  return_type := "morphism_in_range_category_of_homomorphism_structure",
  dual_operation := "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure",
  dual_postprocessor_func := IdFunc
),

InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects := rec(
  filter_list := [ "category", "object_in_range_category_of_homomorphism_structure", "morphism", "object_in_range_category_of_homomorphism_structure" ],
  input_arguments_names := [ "cat", "source", "alpha", "range" ],
  return_type := "morphism_in_range_category_of_homomorphism_structure",
  output_source_getter_string := "source",
  output_range_getter_string := "range",
  dual_operation := "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects",
  dual_preprocessor_func := function( cat, distinguished_object, alpha, hom_source_range )
    return NTuple( 4, OppositeCategory( cat ), distinguished_object, Opposite( alpha ), hom_source_range );
  end,
  dual_postprocessor_func := IdFunc
),

InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism := rec(
  filter_list := [ "category", "object", "object", "morphism_in_range_category_of_homomorphism_structure" ],
  input_arguments_names := [ "cat", "source", "range", "alpha" ],
  return_type := "morphism",
  output_source_getter_string := "source",
  output_range_getter_string := "range",
  dual_operation := "InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism",
  dual_preprocessor_func := function( cat, A, B, morphism )
    return NTuple( 4, OppositeCategory( cat ), Opposite( B ), Opposite( A ), morphism );
  end
),

SolveLinearSystemInAbCategory := rec(
  filter_list := [ "category", "list_of_lists_of_morphisms", "list_of_lists_of_morphisms", "list_of_morphisms" ],
  return_type := "list_of_morphisms",
  pre_function := function( cat, left_coeffs, right_coeffs, rhs )
    
    if not Length( left_coeffs ) > 0 then
        return [ false, "the list of left coefficients is empty" ];
    fi;
    
    if not Length( left_coeffs ) = Length( right_coeffs ) then
        return [ false, "the list of left coefficients and the list of right coefficients do not have the same length" ];
    fi;
    
    if not Length( left_coeffs ) = Length( rhs ) then
        return [ false, "the list of left coefficients does not have the same length as the right hand side" ];
    fi;
    
    if not ForAll( Concatenation( left_coeffs, right_coeffs ), x -> IsList( x ) and Length( x ) = Length( left_coeffs[1] ) ) then
        return [ false, "the left coefficients and the right coefficients must be given by lists of lists of the same length containing morphisms in the current category" ];
    fi;
    
    return [ true ];
    
  end,
  pre_function_full := function( cat, left_coeffs, right_coeffs, rhs )
    local nr_columns_left, nr_columns_right;
    
    if not ForAll( [ 1 .. Length( left_coeffs ) ], i -> ForAll( left_coeffs[i], coeff -> IsEqualForObjects( cat, Source( coeff ), Source( rhs[i] ) ) <> false ) ) then
        return [ false, "the sources of the left coefficients must correspond to the sources of the right hand side" ];
    fi;
    
    if not ForAll( [ 1 .. Length( right_coeffs ) ], i -> ForAll( right_coeffs[i], coeff -> IsEqualForObjects( cat, Range( coeff ), Range( rhs[i] ) ) <> false ) ) then
        return [ false, "the ranges of the right coefficients must correspond to the ranges of the right hand side" ];
    fi;
    
    nr_columns_left := Length( left_coeffs[1] );
    
    if not ForAll( [ 1 .. nr_columns_left ], j -> ForAll( left_coeffs, x -> IsEqualForObjects( cat, Range( x[j] ), Range( left_coeffs[1][j] ) ) <> false ) ) then
        return [ false, "all ranges in a column of the left coefficients must be equal" ];
    fi;
    
    nr_columns_right := Length( right_coeffs[1] );
    
    if not ForAll( [ 1 .. nr_columns_right ], j -> ForAll( right_coeffs, x -> IsEqualForObjects( cat, Source( x[j] ), Source( right_coeffs[1][j] ) ) <> false ) ) then
        return [ false, "all sources in a column of the right coefficients must be equal" ];
    fi;
    
    return [ true ];
    
  end,
),

MereExistenceOfSolutionOfLinearSystemInAbCategory := rec(
  filter_list := [ "category", "list_of_lists_of_morphisms", "list_of_lists_of_morphisms", "list_of_morphisms" ],
  return_type := "bool",
  pre_function := "SolveLinearSystemInAbCategory",
  pre_function_full := "SolveLinearSystemInAbCategory"
),

MereExistenceOfUniqueSolutionOfLinearSystemInAbCategory := rec(
  filter_list := [ "category", "list_of_lists_of_morphisms", "list_of_lists_of_morphisms", "list_of_morphisms" ],
  return_type := "bool",
  pre_function := "SolveLinearSystemInAbCategory",
  pre_function_full := "SolveLinearSystemInAbCategory"
),

MereExistenceOfUniqueSolutionOfHomogeneousLinearSystemInAbCategory := rec(
  filter_list := [ "category", "list_of_lists_of_morphisms", "list_of_lists_of_morphisms" ],
  return_type := "bool",
  pre_function := "BasisOfSolutionsOfHomogeneousLinearSystemInLinearCategory",
  pre_function_full := "BasisOfSolutionsOfHomogeneousLinearSystemInLinearCategory"
),

BasisOfSolutionsOfHomogeneousLinearSystemInLinearCategory := rec(
  filter_list := [ "category", "list_of_lists_of_morphisms", "list_of_lists_of_morphisms" ],
  return_type := "list_of_lists_of_morphisms",
  pre_function := function( cat, left_coeffs, right_coeffs )

    if not Length( left_coeffs ) > 0 then
        return [ false, "the list of left coefficients is empty" ];
    fi;

    if not Length( left_coeffs ) = Length( right_coeffs ) then
        return [ false, "the list of left coefficients and the list of right coefficients do not have the same length" ];
    fi;

    if not ForAll( Concatenation( left_coeffs, right_coeffs ), x -> IsList( x ) and Length( x ) = Length( left_coeffs[1] ) ) then
        return [ false, "the left coefficients and the right coefficients must be given by lists of lists of morphisms of the same length" ];
    fi;

    return [ true ];

  end,
  pre_function_full := function( cat, left_coeffs, right_coeffs )
    local nr_columns_left, nr_columns_right;

    nr_columns_left := Length( left_coeffs[1] );

    if not ForAll( [ 1 .. nr_columns_left ],
            j -> ForAll( left_coeffs, x -> IsEqualForObjects( cat, Target( x[j] ), Target( left_coeffs[1][j] ) ) <> false ) ) then
        return [ false, "all targets in any column of the left coefficients must be equal" ];
    fi;

    nr_columns_right := Length( right_coeffs[1] );

    if not ForAll( [ 1 .. nr_columns_right ],
            j -> ForAll( right_coeffs, x -> IsEqualForObjects( cat, Source( x[j] ), Source( right_coeffs[1][j] ) ) <> false ) ) then
        return [ false, "all sources in any column of the right coefficients must be equal" ];
    fi;

    return [ true ];

  end,
),

BasisOfSolutionsOfHomogeneousDoubleLinearSystemInLinearCategory := rec(
  filter_list := [ "category", "list_of_lists_of_morphisms", "list_of_lists_of_morphisms", "list_of_lists_of_morphisms", "list_of_lists_of_morphisms" ],
  return_type := "list_of_lists_of_morphisms",
),

MorphismsOfExternalHom := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "list_of_morphisms",
  dual_operation := "MorphismsOfExternalHom",
  dual_arguments_reversed := true
),

BasisOfExternalHom := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "list_of_morphisms",
  dual_operation := "BasisOfExternalHom",
  dual_arguments_reversed := true
),

CoefficientsOfMorphism := rec(
  filter_list := [ "category", "morphism" ],
  return_type := "list_of_elements_of_commutative_ring_of_linear_structure",
  dual_operation := "CoefficientsOfMorphism",
  dual_postprocessor_func := IdFunc
),

RandomObjectByInteger := rec(
  filter_list := [ "category", "integer" ],
  input_arguments_names := [ "cat", "n" ],
  return_type := "object",
  dual_operation := "RandomObjectByInteger",
),

RandomMorphismByInteger := rec(
  filter_list := [ "category", "integer" ],
  input_arguments_names := [ "cat", "n" ],
  return_type := "morphism",
  dual_operation := "RandomMorphismByInteger",
),

RandomMorphismWithFixedSourceByInteger := rec(
  filter_list := [ "category", "object", "integer" ],
  input_arguments_names := [ "cat", "A", "n" ],
  output_source_getter_string := "A",
  output_source_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "RandomMorphismWithFixedRangeByInteger",
),

RandomMorphismWithFixedRangeByInteger := rec(
  filter_list := [ "category", "object", "integer" ],
  input_arguments_names := [ "cat", "B", "n" ],
  output_range_getter_string := "B",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "RandomMorphismWithFixedSourceByInteger",
),

RandomMorphismWithFixedSourceAndRangeByInteger := rec(
  filter_list := [ "category", "object", "object", "integer" ],
  input_arguments_names := [ "cat", "A", "B", "n" ],
  output_source_getter_string := "A",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "B",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "RandomMorphismWithFixedSourceAndRangeByInteger",
  dual_preprocessor_func := function( cat, A, B, n )
      return NTuple( 4, OppositeCategory( cat ), Opposite( B ), Opposite( A ), n );
  end
),

RandomObjectByList := rec(
  filter_list := [ "category", "arbitrary_list" ],
  input_arguments_names := [ "cat", "L" ],
  return_type := "object"
),

RandomMorphismByList := rec(
  filter_list := [ "category", "arbitrary_list" ],
  input_arguments_names := [ "cat", "L" ],
  return_type := "morphism"
),

RandomMorphismWithFixedSourceByList := rec(
  filter_list := [ "category", "object", "arbitrary_list" ],
  input_arguments_names := [ "cat", "A", "L" ],
  output_source_getter_string := "A",
  output_source_getter_preconditions := [ ],
  return_type := "morphism",
),

RandomMorphismWithFixedRangeByList := rec(
  filter_list := [ "category", "object", "arbitrary_list" ],
  input_arguments_names := [ "cat", "B", "L" ],
  output_range_getter_string := "B",
  output_range_getter_preconditions := [ ],
  return_type := "morphism"
),

RandomMorphismWithFixedSourceAndRangeByList := rec(
  filter_list := [ "category", "object", "object", "arbitrary_list" ],
  input_arguments_names := [ "cat", "A", "B", "L" ],
  output_source_getter_string := "A",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "B",
  output_range_getter_preconditions := [ ],
  return_type := "morphism"
),

HomologyObject := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  input_arguments_names := [ "cat", "alpha", "beta" ],
  return_type := "object",
  pre_function := function( cat, alpha, beta )
      if not IsEqualForObjects( cat, Range( alpha ), Source( beta ) ) then
            
            return [ false, "the range of the first morphism has to be equal to the source of the second morphism" ];
            
      fi;
      
      return [ true ];
      
  end,
  dual_operation := "HomologyObject",
  dual_arguments_reversed := true
),

HomologyObjectFunctorialWithGivenHomologyObjects := rec(
  filter_list := [ "category", "object", "5_tuple_of_morphisms", "object" ],
  input_arguments_names := [ "cat", "H_1", "L", "H_2" ],
  return_type := "morphism",
  pre_function := function( cat, H_1, L, H2 )
      local alpha, beta, epsilon, gamma, delta;
      
      alpha := L[1];
      
      beta := L[2];
      
      epsilon := L[3];
      
      gamma := L[4];
      
      delta := L[5];
      
      if not IsEqualForObjects( cat, Range( alpha ), Source( beta ) ) then
            
            return [ false, "the range of the first morphism has to be equal to the source of the second morphism" ];
            
      fi;
      
      if not IsEqualForObjects( cat, Range( gamma ), Source( delta ) ) then
            
            return [ false, "the range of the fourth morphism has to be equal to the source of the fifth morphism" ];
            
      fi;
      
      if not IsEqualForObjects( cat, Source( epsilon ), Source( beta ) ) then
            
            return [ false, "the source of the third morphism has to be equal to the source of the second morphism" ];
            
      fi;
      
      if not IsEqualForObjects( cat, Range( epsilon ), Range( gamma ) ) then
            
            return [ false, "the range of the third morphism has to be equal to the range of the fourth morphism" ];
            
      fi;
      
      return [ true ];
      
  end,
  dual_operation := "HomologyObjectFunctorialWithGivenHomologyObjects",
  dual_preprocessor_func := function( arg )
      local list;
      list := CAP_INTERNAL_OPPOSITE_RECURSIVE( arg );
      return NTuple( 4, list[1], list[4], Reversed( list[3] ), list[2] );
  end
),

IsomorphismFromHomologyObjectToItsConstructionAsAnImageObject := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  input_arguments_names := [ "cat", "alpha", "beta" ],
  return_type := "morphism" ),

IsomorphismFromItsConstructionAsAnImageObjectToHomologyObject := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  input_arguments_names := [ "cat", "alpha", "beta" ],
  return_type := "morphism" ),
  
## SimplifyObject*
SimplifyObject := rec(
  filter_list := [ "category", "object", "nonneg_integer_or_infinity" ],
  input_arguments_names := [ "cat", "A", "n" ],
  return_type := "object",
  dual_operation := "SimplifyObject",
  redirect_function := function( cat, A, n )
    
    if n = 0 then
        return [ true, A ];
    fi;
    
    return [ false ];
    
  end,
  pre_function := function( cat, A, n )
    
    if not ( IsPosInt( n ) or IsInfinity( n ) ) then
        return [ false, "the second argument must be a non-negative integer or infinity" ];
    fi;
    
    return [ true ];
    
  end 
  ),

SimplifyObject_IsoFromInputObject := rec(
  filter_list := [ "category", "object", "nonneg_integer_or_infinity" ],
  input_arguments_names := [ "cat", "A", "n" ],
  output_source_getter_string := "A",
  output_source_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "SimplifyObject_IsoToInputObject",
  redirect_function := function( cat, A, n )
    
    if n = 0 then
        return [ true, IdentityMorphism( A ) ];
    fi;
    
    return [ false ];
    
  end,
  pre_function := "SimplifyObject"
  ),

SimplifyObject_IsoToInputObject := rec(
  filter_list := [ "category", "object", "nonneg_integer_or_infinity" ],
  input_arguments_names := [ "cat", "A", "n" ],
  output_range_getter_string := "A",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "SimplifyObject_IsoFromInputObject",
  redirect_function := "SimplifyObject_IsoFromInputObject",
  pre_function := "SimplifyObject"
  ),

## SimplifyMorphism
SimplifyMorphism := rec(
  filter_list := [ "category", "morphism", "nonneg_integer_or_infinity" ],
  input_arguments_names := [ "cat", "mor", "n" ],
  output_source_getter_string := "Source( mor )",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "Range( mor )",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "SimplifyMorphism",
  redirect_function := "SimplifyObject",
  pre_function := "SimplifyObject"
  ),

## SimplifySource*
SimplifySource := rec(
  filter_list := [ "category", "morphism", "nonneg_integer_or_infinity" ],
  input_arguments_names := [ "cat", "mor", "n" ],
  output_range_getter_string := "Range( mor )",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "SimplifyRange",
  redirect_function := "SimplifyObject",
  pre_function := "SimplifyObject"
  ),

SimplifySource_IsoToInputObject := rec(
  filter_list := [ "category", "morphism", "nonneg_integer_or_infinity" ],
  input_arguments_names := [ "cat", "mor", "n" ],
  output_range_getter_string := "Source( mor )",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "SimplifyRange_IsoFromInputObject",
  redirect_function := function( cat, alpha, n )
    
    if n = 0 then
        return [ true, IdentityMorphism( Source( alpha ) ) ];
    fi;
    
    return [ false ];
    
  end,
  pre_function := "SimplifyObject"
  ),
  
SimplifySource_IsoFromInputObject := rec(
  filter_list := [ "category", "morphism", "nonneg_integer_or_infinity" ],
  input_arguments_names := [ "cat", "mor", "n" ],
  output_source_getter_string := "Source( mor )",
  output_source_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "SimplifyRange_IsoToInputObject",
  redirect_function := "SimplifySource_IsoToInputObject",
  pre_function := "SimplifyObject"
  ),

## SimplifyRange*
SimplifyRange := rec(
  filter_list := [ "category", "morphism", "nonneg_integer_or_infinity" ],
  input_arguments_names := [ "cat", "mor", "n" ],
  output_source_getter_string := "Source( mor )",
  output_source_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "SimplifySource",
  redirect_function := "SimplifyObject",
  pre_function := "SimplifyObject"
  ),

SimplifyRange_IsoToInputObject := rec(
  filter_list := [ "category", "morphism", "nonneg_integer_or_infinity" ],
  input_arguments_names := [ "cat", "mor", "n" ],
  output_range_getter_string := "Range( mor )",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "SimplifySource_IsoFromInputObject",
  redirect_function := function( cat, alpha, n )
    
    if n = 0 then
        return [ true, IdentityMorphism( Range( alpha ) ) ];
    fi;
    
    return [ false ];
    
  end,
  pre_function := "SimplifyObject"
  ),
  
SimplifyRange_IsoFromInputObject := rec(
  filter_list := [ "category", "morphism", "nonneg_integer_or_infinity" ],
  input_arguments_names := [ "cat", "mor", "n" ],
  output_source_getter_string := "Range( mor )",
  output_source_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "SimplifySource_IsoToInputObject",
  redirect_function := "SimplifySource_IsoToInputObject",
  pre_function := "SimplifyObject"
  ),

## SimplifySourceAndRange*
SimplifySourceAndRange := rec(
  filter_list := [ "category", "morphism", "nonneg_integer_or_infinity" ],
  input_arguments_names := [ "cat", "mor", "n" ],
  return_type := "morphism",
  dual_operation := "SimplifySourceAndRange",
  redirect_function := "SimplifyObject",
  pre_function := "SimplifyObject"
  ),

SimplifySourceAndRange_IsoToInputSource := rec(
  filter_list := [ "category", "morphism", "nonneg_integer_or_infinity" ],
  input_arguments_names := [ "cat", "mor", "n" ],
  output_range_getter_string := "Source( mor )",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "SimplifySourceAndRange_IsoFromInputRange",
  redirect_function := "SimplifySource_IsoToInputObject",
  pre_function := "SimplifyObject"
  ),
  
SimplifySourceAndRange_IsoFromInputSource := rec(
  filter_list := [ "category", "morphism", "nonneg_integer_or_infinity" ],
  input_arguments_names := [ "cat", "mor", "n" ],
  output_source_getter_string := "Source( mor )",
  output_source_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "SimplifySourceAndRange_IsoToInputRange",
  redirect_function := "SimplifySource_IsoToInputObject",
  pre_function := "SimplifyObject"
  ),

SimplifySourceAndRange_IsoToInputRange := rec(
  filter_list := [ "category", "morphism", "nonneg_integer_or_infinity" ],
  input_arguments_names := [ "cat", "mor", "n" ],
  output_range_getter_string := "Range( mor )",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "SimplifySourceAndRange_IsoFromInputSource",
  redirect_function := "SimplifySource_IsoToInputObject",
  pre_function := "SimplifyObject"
  ),
  
SimplifySourceAndRange_IsoFromInputRange := rec(
  filter_list := [ "category", "morphism", "nonneg_integer_or_infinity" ],
  input_arguments_names := [ "cat", "mor", "n" ],
  output_source_getter_string := "Range( mor )",
  output_source_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "SimplifySourceAndRange_IsoToInputSource",
  redirect_function := "SimplifySource_IsoToInputObject",
  pre_function := "SimplifyObject"
  ),

## SimplifyEndo*
SimplifyEndo := rec(
  filter_list := [ "category", "morphism", "nonneg_integer_or_infinity" ],
  input_arguments_names := [ "cat", "mor", "n" ],
  return_type := "morphism",
  dual_operation := "SimplifyEndo",
  redirect_function := "SimplifyObject",
  pre_function := function( cat, endo, n )
    
    if not ( IsPosInt( n ) or IsInfinity( n ) ) then
        return [ false, "the second argument must be a non-negative integer or infinity" ];
    fi;
    
    if not IsEndomorphism( endo ) then
        return [ false, "the first argument must be an endomorphism" ];
    fi;
    
    return [ true ];
    
  end 
  ),

SimplifyEndo_IsoFromInputObject := rec(
  filter_list := [ "category", "morphism", "nonneg_integer_or_infinity" ],
  input_arguments_names := [ "cat", "mor", "n" ],
  output_source_getter_string := "Source( mor )",
  output_source_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "SimplifyEndo_IsoToInputObject",
  redirect_function := "SimplifySource_IsoToInputObject",
  pre_function := "SimplifyEndo"
  ),

SimplifyEndo_IsoToInputObject := rec(
  filter_list := [ "category", "morphism", "nonneg_integer_or_infinity" ],
  input_arguments_names := [ "cat", "mor", "n" ],
  output_range_getter_string := "Range( mor )",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "SimplifyEndo_IsoFromInputObject",
  redirect_function := "SimplifySource_IsoToInputObject",
  pre_function := "SimplifyEndo"
  ),

SomeReductionBySplitEpiSummand := rec(
  filter_list := [ "category", "morphism" ],
  input_arguments_names := [ "cat", "alpha" ],
  return_type := "morphism",
  ),

SomeReductionBySplitEpiSummand_MorphismToInputRange := rec(
  filter_list := [ "category", "morphism" ],
  input_arguments_names := [ "cat", "alpha" ],
  return_type := "morphism",
  ),

SomeReductionBySplitEpiSummand_MorphismFromInputRange := rec(
  filter_list := [ "category", "morphism" ],
  input_arguments_names := [ "cat", "alpha" ],
  return_type := "morphism",
  ),

ProjectiveDimension := rec(
  filter_list := [ "category", "object" ],
  return_type := "nonneg_integer_or_infinity",
  dual_operation := "InjectiveDimension",
  ),

InjectiveDimension := rec(
  filter_list := [ "category", "object" ],
  return_type := "nonneg_integer_or_infinity",
  dual_operation := "ProjectiveDimension",
  ),

AdditiveGenerators := rec(
  filter_list := [ "category" ],
  return_type := "list_of_objects",
  dual_operation := "AdditiveGenerators",
),

IndecomposableProjectiveObjects := rec(
  filter_list := [ "category" ],
  return_type := "list_of_objects",
  dual_operation := "IndecomposableInjectiveObjects",
),

IndecomposableInjectiveObjects := rec(
  filter_list := [ "category" ],
  return_type := "list_of_objects",
  dual_operation := "IndecomposableProjectiveObjects",
),

ProjectiveCoverObject := rec(
  filter_list := [ "category", "object" ],
  return_type := "object",
  dual_operation := "InjectiveEnvelopeObject",
  is_merely_set_theoretic := true ),

EpimorphismFromProjectiveCoverObject := rec(
  filter_list := [ "category", "object" ],
  input_arguments_names := [ "cat", "A" ],
  output_range_getter_string := "A",
  output_range_getter_preconditions := [ ],
  with_given_object_position := "Source",
  return_type := "morphism",
  dual_operation := "MonomorphismIntoInjectiveEnvelopeObject",
  is_merely_set_theoretic := true ),

EpimorphismFromProjectiveCoverObjectWithGivenProjectiveCoverObject := rec(
  filter_list := [ "category", "object", "object" ],
  input_arguments_names := [ "cat", "A", "P" ],
  output_source_getter_string := "P",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "A",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "MonomorphismIntoInjectiveEnvelopeObjectWithGivenInjectiveEnvelopeObject",
  is_merely_set_theoretic := true ),

InjectiveEnvelopeObject := rec(
  filter_list := [ "category", "object" ],
  return_type := "object",
  dual_operation := "ProjectiveCoverObject",
  is_merely_set_theoretic := true ),

MonomorphismIntoInjectiveEnvelopeObject := rec(
  filter_list := [ "category", "object" ],
  input_arguments_names := [ "cat", "A" ],
  output_source_getter_string := "A",
  output_source_getter_preconditions := [ ],
  with_given_object_position := "Range",
  return_type := "morphism",
  dual_operation := "EpimorphismFromProjectiveCoverObject",
  is_merely_set_theoretic := true ),

MonomorphismIntoInjectiveEnvelopeObjectWithGivenInjectiveEnvelopeObject := rec(
  filter_list := [ "category", "object", "object" ],
  input_arguments_names := [ "cat", "A", "I" ],
  output_source_getter_string := "A",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "I",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "EpimorphismFromProjectiveCoverObjectWithGivenProjectiveCoverObject",
  is_merely_set_theoretic := true ),

) );

BindGlobal( "CAP_INTERNAL_METHOD_NAME_RECORD_LIMITS", [
rec(
  object_specification := [ "varobject" ],
  morphism_specification := [  ],
  limit_object_name := "DirectProduct",
  colimit_object_name := "Coproduct",
),

rec(
  object_specification := [ "varobject" ],
  morphism_specification := [  ],
  limit_object_name := "DirectSum",
  colimit_object_name := "DirectSum",
),

rec(
  object_specification := [ "fixedobject", "varobject" ],
  morphism_specification := [ [ 2, "varmorphism", 1 ] ],
  limit_object_name := "FiberProduct",
  colimit_object_name := "Pushout",
),

rec(
  object_specification := [ "fixedobject", "fixedobject" ],
  morphism_specification := [ [ 1, "varmorphism", 2 ] ],
  limit_object_name := "Equalizer",
  limit_projection_name := "EmbeddingOfEqualizer",
  colimit_object_name := "Coequalizer",
  colimit_injection_name := "ProjectionOntoCoequalizer",
),

rec(
  object_specification := [ "fixedobject", "fixedobject" ],
  morphism_specification := [ [ 1, "fixedmorphism", 2 ], [ 1, "zeromorphism", 2 ] ],
  limit_object_name := "KernelObject",
  limit_projection_name := "KernelEmbedding",
  limit_universal_morphism_name := "KernelLift",
  colimit_object_name := "CokernelObject",
  colimit_injection_name := "CokernelProjection",
  colimit_universal_morphism_name := "CokernelColift",
),

rec(
  object_specification := [ ],
  morphism_specification := [ ],
  limit_object_name := "TerminalObject",
  colimit_object_name := "InitialObject",
),

rec(
  object_specification := [ ],
  morphism_specification := [ ],
  limit_object_name := "ZeroObject",
  colimit_object_name := "ZeroObject",
)

] );

CAP_INTERNAL_ENHANCE_NAME_RECORD_LIMITS( CAP_INTERNAL_METHOD_NAME_RECORD_LIMITS );

CAP_INTERNAL_VALIDATE_LIMITS_IN_NAME_RECORD( CAP_INTERNAL_CORE_METHOD_NAME_RECORD, CAP_INTERNAL_METHOD_NAME_RECORD_LIMITS );

CAP_INTERNAL_ENHANCE_NAME_RECORD( CAP_INTERNAL_CORE_METHOD_NAME_RECORD );

CAP_INTERNAL_GENERATE_DECLARATIONS_AND_INSTALLATIONS_FROM_METHOD_NAME_RECORD(
    CAP_INTERNAL_CORE_METHOD_NAME_RECORD,
    "CAP",
    "MethodRecord",
    "Add Functions",
    "Available Add functions"
);

CAP_INTERNAL_REGISTER_METHOD_NAME_RECORD_OF_PACKAGE( CAP_INTERNAL_CORE_METHOD_NAME_RECORD, "CAP" );

#= comment for Julia
CAP_INTERNAL_GENERATE_CONVENIENCE_METHODS_FOR_LIMITS( "CAP", CAP_INTERNAL_CORE_METHOD_NAME_RECORD, CAP_INTERNAL_METHOD_NAME_RECORD_LIMITS );
# =#

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( CAP_INTERNAL_CORE_METHOD_NAME_RECORD );
