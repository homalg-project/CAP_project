# SPDX-License-Identifier: GPL-2.0-or-later
# FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
#
# Implementations
#

##
InstallGlobalFunction( WEAK_BI_FIBER_PRODUCT_PREFUNCTION,
  function( cat, morphism_1, morphism_2, arg... )
    
    if not IsEqualForObjects( Range( morphism_1 ), Range( morphism_2 ) ) then
        return [ false, "the given morphisms must have equal ranges" ];
    fi;
    
    return [ true ];
    
  end
);

##
InstallGlobalFunction( UNIVERSAL_MORPHISM_INTO_WEAK_BI_FIBER_PRODUCT_PREFUNCTION,
  function( cat, morphism_1, morphism_2, test_morphism_1, test_morphism_2, arg... )
    
    if not IsEqualForObjects( Range( morphism_1 ), Range( morphism_2 ) ) then
        return [ false, "the first two morphisms must have equal ranges" ];
    fi;
    
    if not IsEqualForObjects( Source( test_morphism_1 ), Source( test_morphism_2 ) ) then
        return [ false, "the last two morphisms must have equal sources" ];
    fi;
    
    return [ true ];
    
  end
);

##
InstallGlobalFunction( UNIVERSAL_MORPHISM_INTO_BIASED_WEAK_FIBER_PRODUCT_PREFUNCTION,
  function( cat, morphism_1, morphism_2, test_morphism, arg... )
    
    if not IsEqualForObjects( Range( morphism_1 ), Range( morphism_2 ) ) then
        return [ false, "the first two morphisms must have equal ranges" ];
    fi;
    
    if not IsEqualForObjects( Source( morphism_1 ), Range( test_morphism ) ) then
        return [ false, "the range of the test morphism must equal the source of the first morphism" ];
    fi;
    
    return [ true ];
    
  end
);


##
InstallGlobalFunction( WEAK_BI_PUSHOUT_PREFUNCTION,
  function( cat, morphism_1, morphism_2, arg... )
    
    if not IsEqualForObjects( Source( morphism_1 ), Source( morphism_2 ) ) then
        return [ false, "the given morphisms must have equal sources" ];
    fi;
    
    return [ true ];
    
  end
);

##
InstallGlobalFunction( UNIVERSAL_MORPHISM_FROM_WEAK_BI_PUSHOUT_PREFUNCTION,
  function( cat, morphism_1, morphism_2, test_morphism_1, test_morphism_2, arg... )
    
    if not IsEqualForObjects( Source( morphism_1 ), Source( morphism_2 ) ) then
        return [ false, "the first two morphisms must have equal sources" ];
    fi;
    
    if not IsEqualForObjects( Range( test_morphism_1 ), Range( test_morphism_2 ) ) then
        return [ false, "the last two morphisms must have equal ranges" ];
    fi;
    
    return [ true ];
    
  end
);

##
InstallGlobalFunction( UNIVERSAL_MORPHISM_FROM_BIASED_WEAK_PUSHOUT_PREFUNCTION,
  function( cat, morphism_1, morphism_2, test_morphism, arg... )
    
    if not IsEqualForObjects( Source( morphism_1 ), Source( morphism_2 ) ) then
        return [ false, "the first two morphisms must have equal sources" ];
    fi;
    
    if not IsEqualForObjects( Range( morphism_1 ), Source( test_morphism ) ) then
        return [ false, "the range of the first morphism must equal the source of the test morphism" ];
    fi;
    
    return [ true ];
    
  end
);

InstallValue( FREYD_CATEGORIES_METHOD_NAME_RECORD, rec(

## Basic operations for Freyd categories

## Weak kernels

WeakKernelObject := rec(
  filter_list := [ "category", "morphism" ],
  return_type := "object",
  dual_operation := "WeakCokernelObject",
  is_merely_set_theoretic := true ),

WeakKernelEmbedding := rec(
  filter_list := [ "category", "morphism" ],
  input_arguments_names := [ "cat", "alpha" ],
  output_range_getter_string := "Source( alpha )",
  output_range_getter_preconditions := [ ],
  with_given_object_position := "Source",
  return_type := "morphism",
  dual_operation := "WeakCokernelProjection",
  is_merely_set_theoretic := true ),

WeakKernelEmbeddingWithGivenWeakKernelObject := rec(
  filter_list := [ "category", "morphism", "object" ],
  input_arguments_names := [ "cat", "alpha", "K" ],
  output_source_getter_string := "K",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "Source( alpha )",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "WeakCokernelProjectionWithGivenWeakCokernelObject",
  is_merely_set_theoretic := true ),

WeakKernelLift := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  input_arguments_names := [ "cat", "alpha", "tau" ],
  output_source_getter_string := "Source( tau )",
  output_source_getter_preconditions := [ ],
  with_given_object_position := "Range",
  return_type := "morphism",
  dual_operation := "WeakCokernelColift",
  is_merely_set_theoretic := true ),

WeakKernelLiftWithGivenWeakKernelObject := rec(
  filter_list := [ "category", "morphism", "morphism", "object" ],
  input_arguments_names := [ "cat", "alpha", "tau", "K" ],
  output_source_getter_string := "Source( tau )",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "K",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "WeakCokernelColiftWithGivenWeakCokernelObject",
  is_merely_set_theoretic := true ),

## Weak cokernels

WeakCokernelObject := rec(
  filter_list := [ "category", "morphism" ],
  return_type := "object",
  dual_operation := "WeakKernelObject",
  is_merely_set_theoretic := true ),

WeakCokernelProjection := rec(
  filter_list := [ "category", "morphism" ],
  input_arguments_names := [ "cat", "alpha" ],
  output_source_getter_string := "Range( alpha )",
  output_source_getter_preconditions := [ ],
  with_given_object_position := "Range",
  return_type := "morphism",
  dual_operation := "WeakKernelEmbedding",
  is_merely_set_theoretic := true ),

WeakCokernelProjectionWithGivenWeakCokernelObject := rec(
  filter_list := [ "category", "morphism", "object" ],
  input_arguments_names := [ "cat", "alpha", "K" ],
  output_source_getter_string := "Range( alpha )",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "K",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "WeakKernelEmbeddingWithGivenWeakKernelObject",
  is_merely_set_theoretic := true ),

WeakCokernelColift := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  input_arguments_names := [ "cat", "alpha", "tau" ],
  output_range_getter_string := "Range( tau )",
  output_range_getter_preconditions := [ ],
  with_given_object_position := "Source",
  return_type := "morphism",
  dual_operation := "WeakKernelLift",
  is_merely_set_theoretic := true ),

WeakCokernelColiftWithGivenWeakCokernelObject := rec(
  filter_list := [ "category", "morphism", "morphism", "object" ],
  input_arguments_names := [ "cat", "alpha", "tau", "K" ],
  output_source_getter_string := "K",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "Range( tau )",
  output_range_getter_preconditions := [ ],
  return_type := "morphism",
  dual_operation := "WeakKernelLiftWithGivenWeakKernelObject",
  is_merely_set_theoretic := true ),

## Weak bi-fiber product

WeakBiFiberProduct := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  dual_operation := "WeakBiPushout",
  pre_function := WEAK_BI_FIBER_PRODUCT_PREFUNCTION,
  return_type := "object",
  is_merely_set_theoretic := true ),

ProjectionInFirstFactorOfWeakBiFiberProduct := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  input_arguments_names := [ "cat", "a", "b" ],
  output_range_getter_string := "Source( a )",
  output_range_getter_preconditions := [ ],
  with_given_object_position := "Source",
  dual_operation := "InjectionOfFirstCofactorOfWeakBiPushout",
  pre_function := WEAK_BI_FIBER_PRODUCT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

ProjectionInFirstFactorOfWeakBiFiberProductWithGivenWeakBiFiberProduct := rec(
  filter_list := [ "category", "morphism", "morphism", "object" ],
  input_arguments_names := [ "cat", "a", "b", "P" ],
  output_source_getter_string := "P",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "Source( a )",
  output_range_getter_preconditions := [ ],
  dual_operation := "InjectionOfFirstCofactorOfWeakBiPushoutWithGivenWeakBiPushout",
  pre_function := WEAK_BI_FIBER_PRODUCT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

ProjectionInSecondFactorOfWeakBiFiberProduct := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  input_arguments_names := [ "cat", "a", "b" ],
  output_range_getter_string := "Source( b )",
  output_range_getter_preconditions := [ ],
  with_given_object_position := "Source",
  dual_operation := "InjectionOfSecondCofactorOfWeakBiPushout",
  pre_function := WEAK_BI_FIBER_PRODUCT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

ProjectionInSecondFactorOfWeakBiFiberProductWithGivenWeakBiFiberProduct := rec(
  filter_list := [ "category", "morphism", "morphism", "object" ],
  input_arguments_names := [ "cat", "a", "b", "P" ],
  output_source_getter_string := "P",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "Source( b )",
  output_range_getter_preconditions := [ ],
  dual_operation := "InjectionOfSecondCofactorOfWeakBiPushoutWithGivenWeakBiPushout",
  pre_function := WEAK_BI_FIBER_PRODUCT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

UniversalMorphismIntoWeakBiFiberProduct := rec(
  filter_list := [ "category", "morphism", "morphism", "morphism", "morphism" ],
  input_arguments_names := [ "cat", "a", "b", "t", "s" ],
  output_source_getter_string := "Source( t )",
  output_source_getter_preconditions := [ ],
  with_given_object_position := "Range",
  dual_operation := "UniversalMorphismFromWeakBiPushout",
  pre_function := UNIVERSAL_MORPHISM_INTO_WEAK_BI_FIBER_PRODUCT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

UniversalMorphismIntoWeakBiFiberProductWithGivenWeakBiFiberProduct := rec(
  filter_list := [ "category", "morphism", "morphism", "morphism", "morphism", "object" ],
  input_arguments_names := [ "cat", "a", "b", "t", "s", "P" ],
  output_source_getter_string := "Source( t )",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "P",
  output_range_getter_preconditions := [ ],
  dual_operation := "UniversalMorphismFromWeakBiPushoutWithGivenWeakBiPushout",
  pre_function := UNIVERSAL_MORPHISM_INTO_WEAK_BI_FIBER_PRODUCT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

WeakBiFiberProductMorphismToDirectSum := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  input_arguments_names := [ "cat", "alpha", "beta" ],
  return_type := "morphism",
  dual_operation := "DirectSumMorphismToWeakBiPushout",
),

## Weak pushouts

WeakBiPushout := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  dual_operation := "WeakBiFiberProduct",
  pre_function := WEAK_BI_PUSHOUT_PREFUNCTION,
  return_type := "object",
  is_merely_set_theoretic := true ),

InjectionOfFirstCofactorOfWeakBiPushout := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  input_arguments_names := [ "cat", "a", "b" ],
  output_source_getter_string := "Range( a )",
  output_source_getter_preconditions := [ ],
  with_given_object_position := "Range",
  dual_operation := "ProjectionInFirstFactorOfWeakBiFiberProduct",
  pre_function := WEAK_BI_PUSHOUT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

InjectionOfFirstCofactorOfWeakBiPushoutWithGivenWeakBiPushout := rec(
  filter_list := [ "category", "morphism", "morphism", "object" ],
  input_arguments_names := [ "cat", "a", "b", "P" ],
  output_source_getter_string := "Range( a )",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "P",
  output_range_getter_preconditions := [ ],
  dual_operation := "ProjectionInFirstFactorOfWeakBiFiberProductWithGivenWeakBiFiberProduct",
  pre_function := WEAK_BI_PUSHOUT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

InjectionOfSecondCofactorOfWeakBiPushout := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  input_arguments_names := [ "cat", "a", "b" ],
  output_source_getter_string := "Range( b )",
  output_source_getter_preconditions := [ ],
  with_given_object_position := "Range",
  dual_operation := "ProjectionInSecondFactorOfWeakBiFiberProduct",
  pre_function := WEAK_BI_PUSHOUT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

InjectionOfSecondCofactorOfWeakBiPushoutWithGivenWeakBiPushout := rec(
  filter_list := [ "category", "morphism", "morphism", "object" ],
  input_arguments_names := [ "cat", "a", "b", "P" ],
  output_source_getter_string := "Range( b )",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "P",
  output_range_getter_preconditions := [ ],
  dual_operation := "ProjectionInSecondFactorOfWeakBiFiberProductWithGivenWeakBiFiberProduct",
  pre_function := WEAK_BI_PUSHOUT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

UniversalMorphismFromWeakBiPushout := rec(
  filter_list := [ "category", "morphism", "morphism", "morphism", "morphism" ],
  input_arguments_names := [ "cat", "a", "b", "t", "s" ],
  output_range_getter_string := "Range( t )",
  output_range_getter_preconditions := [ ],
  with_given_object_position := "Source",
  dual_operation := "UniversalMorphismIntoWeakBiFiberProduct",
  pre_function := UNIVERSAL_MORPHISM_FROM_WEAK_BI_PUSHOUT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

UniversalMorphismFromWeakBiPushoutWithGivenWeakBiPushout := rec(
  filter_list := [ "category", "morphism", "morphism", "morphism", "morphism", "object" ],
  input_arguments_names := [ "cat", "a", "b", "t", "s", "P" ],
  output_source_getter_string := "P",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "Range( t )",
  output_range_getter_preconditions := [ ],
  dual_operation := "UniversalMorphismIntoWeakBiFiberProductWithGivenWeakBiFiberProduct",
  pre_function := UNIVERSAL_MORPHISM_FROM_WEAK_BI_PUSHOUT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

DirectSumMorphismToWeakBiPushout := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  input_arguments_names := [ "cat", "alpha", "beta" ],
  return_type := "morphism",
  dual_operation := "WeakBiFiberProductMorphismToDirectSum",
),

## biased weak fiber product

BiasedWeakFiberProduct := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  dual_operation := "BiasedWeakPushout",
  pre_function := WEAK_BI_FIBER_PRODUCT_PREFUNCTION,
  return_type := "object",
  is_merely_set_theoretic := true ),

ProjectionOfBiasedWeakFiberProduct := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  input_arguments_names := [ "cat", "a", "b" ],
  output_range_getter_string := "Source( a )",
  output_range_getter_preconditions := [ ],
  with_given_object_position := "Source",
  dual_operation := "InjectionOfBiasedWeakPushout",
  pre_function := WEAK_BI_FIBER_PRODUCT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

ProjectionOfBiasedWeakFiberProductWithGivenBiasedWeakFiberProduct := rec(
  filter_list := [ "category", "morphism", "morphism", "object" ],
  input_arguments_names := [ "cat", "a", "b", "P" ],
  output_source_getter_string := "P",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "Source( a )",
  output_range_getter_preconditions := [ ],
  dual_operation := "InjectionOfBiasedWeakPushoutWithGivenBiasedWeakPushout",
  pre_function := WEAK_BI_FIBER_PRODUCT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

UniversalMorphismIntoBiasedWeakFiberProduct := rec(
  filter_list := [ "category", "morphism", "morphism", "morphism" ],
  input_arguments_names := [ "cat", "a", "b", "t" ],
  output_source_getter_string := "Source( t )",
  output_source_getter_preconditions := [ ],
  with_given_object_position := "Range",
  dual_operation := "UniversalMorphismFromBiasedWeakPushout",
  pre_function := UNIVERSAL_MORPHISM_INTO_BIASED_WEAK_FIBER_PRODUCT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

UniversalMorphismIntoBiasedWeakFiberProductWithGivenBiasedWeakFiberProduct := rec(
  filter_list := [ "category", "morphism", "morphism", "morphism", "object" ],
  input_arguments_names := [ "cat", "a", "b", "t", "P" ],
  output_source_getter_string := "Source( t )",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "P",
  output_range_getter_preconditions := [ ],
  dual_operation := "UniversalMorphismFromBiasedWeakPushoutWithGivenBiasedWeakPushout",
  pre_function := UNIVERSAL_MORPHISM_INTO_BIASED_WEAK_FIBER_PRODUCT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

## biased weak pushout

## Weak pushouts

BiasedWeakPushout := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  dual_operation := "BiasedWeakFiberProduct",
  pre_function := WEAK_BI_PUSHOUT_PREFUNCTION,
  return_type := "object",
  is_merely_set_theoretic := true ),

InjectionOfBiasedWeakPushout := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  input_arguments_names := [ "cat", "a", "b" ],
  output_source_getter_string := "Range( a )",
  output_source_getter_preconditions := [ ],
  with_given_object_position := "Range",
  dual_operation := "ProjectionOfBiasedWeakFiberProduct",
  pre_function := WEAK_BI_PUSHOUT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

InjectionOfBiasedWeakPushoutWithGivenBiasedWeakPushout := rec(
  filter_list := [ "category", "morphism", "morphism", "object" ],
  input_arguments_names := [ "cat", "a", "b", "P" ],
  output_source_getter_string := "Range( a )",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "P",
  output_range_getter_preconditions := [ ],
  dual_operation := "ProjectionOfBiasedWeakFiberProductWithGivenBiasedWeakFiberProduct",
  pre_function := WEAK_BI_PUSHOUT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

UniversalMorphismFromBiasedWeakPushout := rec(
  filter_list := [ "category", "morphism", "morphism", "morphism" ],
  input_arguments_names := [ "cat", "a", "b", "t" ],
  output_range_getter_string := "Range( t )",
  output_range_getter_preconditions := [ ],
  with_given_object_position := "Source",
  dual_operation := "UniversalMorphismIntoBiasedWeakFiberProduct",
  pre_function := UNIVERSAL_MORPHISM_FROM_BIASED_WEAK_PUSHOUT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

UniversalMorphismFromBiasedWeakPushoutWithGivenBiasedWeakPushout := rec(
  filter_list := [ "category", "morphism", "morphism", "morphism", "object" ],
  input_arguments_names := [ "cat", "a", "b", "t", "P" ],
  output_source_getter_string := "P",
  output_source_getter_preconditions := [ ],
  output_range_getter_string := "Range( t )",
  output_range_getter_preconditions := [ ],
  dual_operation := "UniversalMorphismIntoBiasedWeakFiberProductWithGivenBiasedWeakFiberProduct",
  pre_function := UNIVERSAL_MORPHISM_FROM_BIASED_WEAK_PUSHOUT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

## an abelian construction
SomeProjectiveObjectForKernelObject := rec(
  filter_list := [ "category", "morphism" ],
  return_type := "object",
  dual_operation := "SomeInjectiveObjectForCokernelObject",
  is_merely_set_theoretic := true ),

EpimorphismFromSomeProjectiveObjectForKernelObject := rec(
  filter_list := [ "category", "morphism" ],
  input_arguments_names := [ "cat", "alpha" ],
  with_given_object_position := "Source",
  return_type := "morphism",
  dual_operation := "MonomorphismToSomeInjectiveObjectForCokernelObject",
  is_merely_set_theoretic := true ),

EpimorphismFromSomeProjectiveObjectForKernelObjectWithGivenSomeProjectiveObjectForKernelObject := rec(
  filter_list := [ "category", "morphism", "object" ],
  input_arguments_names := [ "cat", "alpha", "source" ],
  return_type := "morphism",
  output_source_getter_string := "source",
  dual_operation := "MonomorphismToSomeInjectiveObjectForCokernelObjectWithGivenSomeInjectiveObjectForCokernelObject",
  is_merely_set_theoretic := true ),

SomeInjectiveObjectForCokernelObject := rec(
  filter_list := [ "category", "morphism" ],
  return_type := "object",
  dual_operation := "SomeProjectiveObjectForKernelObject",
  is_merely_set_theoretic := true ),

MonomorphismToSomeInjectiveObjectForCokernelObject := rec(
  filter_list := [ "category", "morphism" ],
  input_arguments_names := [ "cat", "alpha" ],
  with_given_object_position := "Range",
  return_type := "morphism",
  dual_operation := "EpimorphismFromSomeProjectiveObjectForKernelObject",
  is_merely_set_theoretic := true ),

MonomorphismToSomeInjectiveObjectForCokernelObjectWithGivenSomeInjectiveObjectForCokernelObject := rec(
  filter_list := [ "category", "morphism", "object" ],
  input_arguments_names := [ "cat", "alpha", "range" ],
  return_type := "morphism",
  output_range_getter_string := "range",
  dual_operation := "EpimorphismFromSomeProjectiveObjectForKernelObjectWithGivenSomeProjectiveObjectForKernelObject",
  is_merely_set_theoretic := true ),

  ) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( FREYD_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_GENERATE_DOCUMENTATION_FROM_METHOD_NAME_RECORD(
    FREYD_CATEGORIES_METHOD_NAME_RECORD,
    "FreydCategoriesForCAP",
    "AddFunctions.autogen.gd",
    "Add Functions",
    "Available Add functions"
);

CAP_INTERNAL_REGISTER_METHOD_NAME_RECORD_OF_PACKAGE( FREYD_CATEGORIES_METHOD_NAME_RECORD, "FreydCategoriesForCAP" );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( FREYD_CATEGORIES_METHOD_NAME_RECORD );

####################################
##
## Free abelian category
##
####################################

InstallMethod( AsMorphismInFreeAbelianCategory,
               [ IsCapCategoryMorphism ],
               
  function( morphism )
    
    return Opposite(
        AsFreydCategoryMorphism(
          Opposite(
            AsFreydCategoryMorphism(
              AsAdditiveClosureMorphism( morphism )
            )
          )
       )
      );
    
end );

###################################
##
## Finitely presented functors
##
####################################

##
InstallMethod( CovariantExtAsFreydCategoryObject,
               [ IsCapCategoryObject, IsInt ],
               
  function( object, i )
    local morphism, j;
    
    if i = 0 then
        
        return AsFreydCategoryObject( Opposite( object ) );
        
    fi;
    
    morphism := EpimorphismFromSomeProjectiveObject( object );
    
    for j in [ 2 .. i ] do
        
        morphism := EpimorphismFromSomeProjectiveObjectForKernelObject( morphism );
        
    od;
    
    return FreydCategoryObject( Opposite( KernelEmbedding( morphism ) ) );
    
end );
