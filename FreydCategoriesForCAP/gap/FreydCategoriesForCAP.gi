# SPDX-License-Identifier: GPL-2.0-or-later
# FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
#
# Implementations
#

##
InstallGlobalFunction( WEAK_BI_FIBER_PRODUCT_PREFUNCTION,
  function( cat, morphism_1, morphism_2, arg... )
    local current_value;
    
    current_value := IsEqualForObjects( Range( morphism_1 ), Range( morphism_2 ) );
    
    if current_value = fail then
        return [ false, "cannot decide whether the given morphisms have equal ranges" ];
    elif current_value = false then
        return [ false, "the given morphisms must have equal ranges" ];
    fi;
    
    return [ true ];
    
  end
);

##
InstallGlobalFunction( UNIVERSAL_MORPHISM_INTO_WEAK_BI_FIBER_PRODUCT_PREFUNCTION,
  function( cat, morphism_1, morphism_2, test_morphism_1, test_morphism_2, arg... )
    local current_value;
    
    current_value := IsEqualForObjects( Range( morphism_1 ), Range( morphism_2 ) );
    
    if current_value = fail then
        return [ false, "cannot decide whether the first two morphisms have equal ranges" ];
    elif current_value = false then
        return [ false, "the first two morphisms must have equal ranges" ];
    fi;
    
    current_value := IsEqualForObjects( Source( test_morphism_1 ), Source( test_morphism_2 ) );
    
    if current_value = fail then
        return [ false, "cannot decide whether the last two morphisms have equal sources" ];
    elif current_value = false then
        return [ false, "the last two morphisms must have equal sources" ];
    fi;
    
    return [ true ];
    
  end
);

##
InstallGlobalFunction( UNIVERSAL_MORPHISM_INTO_BIASED_WEAK_FIBER_PRODUCT_PREFUNCTION,
  function( cat, morphism_1, morphism_2, test_morphism, arg... )
    local current_value;
    
    current_value := IsEqualForObjects( Range( morphism_1 ), Range( morphism_2 ) );
    
    if current_value = fail then
        return [ false, "cannot decide whether the first two morphisms have equal ranges" ];
    elif current_value = false then
        return [ false, "the first two morphisms must have equal ranges" ];
    fi;
    
    current_value := IsEqualForObjects( Source( morphism_1 ), Range( test_morphism ) );
    
    if current_value = fail then
        return [ false, "cannot decide whether the range of the test morphism is equal to the source of the first morphism " ];
    elif current_value = false then
        return [ false, "the range of the test morphism must equal the source of the first morphism" ];
    fi;
    
    return [ true ];
    
  end
);


##
InstallGlobalFunction( WEAK_BI_PUSHOUT_PREFUNCTION,
  function( cat, morphism_1, morphism_2, arg... )
    local current_value;
    
    current_value := IsEqualForObjects( Source( morphism_1 ), Source( morphism_2 ) );
    
    if current_value = fail then
        return [ false, "cannot decide whether the given morphisms have equal sources" ];
    elif current_value = false then
        return [ false, "the given morphisms must have equal sources" ];
    fi;
    
    return [ true ];
    
  end
);

##
InstallGlobalFunction( UNIVERSAL_MORPHISM_FROM_WEAK_BI_PUSHOUT_PREFUNCTION,
  function( cat, morphism_1, morphism_2, test_morphism_1, test_morphism_2, arg... )
    local current_value;
    
    current_value := IsEqualForObjects( Source( morphism_1 ), Source( morphism_2 ) );
    
    if current_value = fail then
        return [ false, "cannot decide whether the first two morphisms have equal sources" ];
    elif current_value = false then
        return [ false, "the first two morphisms must have equal sources" ];
    fi;
    
    current_value := IsEqualForObjects( Range( test_morphism_1 ), Range( test_morphism_2 ) );
    
    if current_value = fail then
        return [ false, "cannot decide whether the last two morphisms have equal ranges" ];
    elif current_value = false then
        return [ false, "the last two morphisms must have equal ranges" ];
    fi;
    
    return [ true ];
    
  end
);

##
InstallGlobalFunction( UNIVERSAL_MORPHISM_FROM_BIASED_WEAK_PUSHOUT_PREFUNCTION,
  function( cat, morphism_1, morphism_2, test_morphism, arg... )
    local current_value;
    
    current_value := IsEqualForObjects( Source( morphism_1 ), Source( morphism_2 ) );
    
    if current_value = fail then
        return [ false, "cannot decide whether the first two morphisms have equal sources" ];
    elif current_value = false then
        return [ false, "the first two morphisms must have equal sources" ];
    fi;
    
    current_value := IsEqualForObjects( Range( morphism_1 ), Source( test_morphism ) );
    
    if current_value = fail then
        return [ false, "cannot decide whether the range of the first morphism equals the source of the test morphism" ];
    elif current_value = false then
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
  io_type := [ [ "alpha" ], [ "K", "alpha_source" ] ],
  with_given_object_position := "Source",
  return_type := "morphism",
  dual_operation := "WeakCokernelProjection",
  is_merely_set_theoretic := true ),

WeakKernelEmbeddingWithGivenWeakKernelObject := rec(
  filter_list := [ "category", "morphism", "object" ],
  io_type := [ [ "alpha", "K" ], [ "K", "alpha_source" ] ],
  cache_name := "WeakKernelEmbeddingWithGivenWeakKernelObject",
  return_type := "morphism",
  dual_operation := "WeakCokernelProjectionWithGivenWeakCokernelObject",
  is_merely_set_theoretic := true ),

WeakKernelLift := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  io_type := [ [ "alpha", "tau" ], [ "tau_source", "K" ] ],
  cache_name := "WeakKernelLift",
  with_given_object_position := "Range",
  return_type := "morphism",
  dual_operation := "WeakCokernelColift",
  is_merely_set_theoretic := true ),

WeakKernelLiftWithGivenWeakKernelObject := rec(
  filter_list := [ "category", "morphism", "morphism", "object" ],
  io_type := [ [ "alpha", "tau", "K" ], [ "tau_source", "K" ] ],
  cache_name := "WeakKernelLiftWithGivenWeakKernelObject",
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
  io_type := [ [ "alpha" ], [ "alpha_range", "K" ] ],
  with_given_object_position := "Range",
  return_type := "morphism",
  dual_operation := "WeakKernelEmbedding",
  is_merely_set_theoretic := true ),

WeakCokernelProjectionWithGivenWeakCokernelObject := rec(
  filter_list := [ "category", "morphism", "object" ],
  io_type := [ [ "alpha", "K" ], [ "alpha_range", "K" ] ],
  cache_name := "WeakCokernelProjectionWithGivenWeakCokernelObject",
  return_type := "morphism",
  dual_operation := "WeakKernelEmbeddingWithGivenWeakKernelObject",
  is_merely_set_theoretic := true ),

WeakCokernelColift := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  io_type := [ [ "alpha", "tau" ], [ "K", "tau_range" ] ],
  cache_name := "WeakCokernelColift",
  with_given_object_position := "Source",
  return_type := "morphism",
  dual_operation := "WeakKernelLift",
  is_merely_set_theoretic := true ),

WeakCokernelColiftWithGivenWeakCokernelObject := rec(
  filter_list := [ "category", "morphism", "morphism", "object" ],
  io_type := [ [ "alpha", "tau", "K" ], [ "K", "tau_range" ] ],
  cache_name := "WeakCokernelColiftWithGivenWeakCokernelObject",
  return_type := "morphism",
  dual_operation := "WeakKernelLiftWithGivenWeakKernelObject",
  is_merely_set_theoretic := true ),

## Weak bi-fiber product

WeakBiFiberProduct := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  cache_name := "WeakBiFiberProduct",
  dual_operation := "WeakBiPushout",
  pre_function := WEAK_BI_FIBER_PRODUCT_PREFUNCTION,
  return_type := "object",
  is_merely_set_theoretic := true ),

ProjectionInFirstFactorOfWeakBiFiberProduct := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  io_type := [ [ "a", "b" ], [ "P", "a_source" ] ],
  cache_name := "ProjectionInFirstFactorOfWeakBiFiberProduct",
  with_given_object_position := "Source",
  dual_operation := "InjectionOfFirstCofactorOfWeakBiPushout",
  pre_function := WEAK_BI_FIBER_PRODUCT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

ProjectionInFirstFactorOfWeakBiFiberProductWithGivenWeakBiFiberProduct := rec(
  filter_list := [ "category", "morphism", "morphism", "object" ],
  io_type := [ [ "a", "b", "P" ], [ "P", "a_source" ] ],
  cache_name := "ProjectionInFirstFactorOfWeakBiFiberProductWithGivenWeakBiFiberProduct",
  dual_operation := "InjectionOfFirstCofactorOfWeakBiPushoutWithGivenWeakBiPushout",
  pre_function := WEAK_BI_FIBER_PRODUCT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

ProjectionInSecondFactorOfWeakBiFiberProduct := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  io_type := [ [ "a", "b" ], [ "P", "b_source" ] ],
  cache_name := "ProjectionInSecondFactorOfWeakBiFiberProduct",
  with_given_object_position := "Source",
  dual_operation := "InjectionOfSecondCofactorOfWeakBiPushout",
  pre_function := WEAK_BI_FIBER_PRODUCT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

ProjectionInSecondFactorOfWeakBiFiberProductWithGivenWeakBiFiberProduct := rec(
  filter_list := [ "category", "morphism", "morphism", "object" ],
  io_type := [ [ "a", "b", "P" ], [ "P", "b_source" ] ],
  cache_name := "ProjectionInSecondFactorOfWeakBiFiberProductWithGivenWeakBiFiberProduct",
  dual_operation := "InjectionOfSecondCofactorOfWeakBiPushoutWithGivenWeakBiPushout",
  pre_function := WEAK_BI_FIBER_PRODUCT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

UniversalMorphismIntoWeakBiFiberProduct := rec(
  filter_list := [ "category", "morphism", "morphism", "morphism", "morphism" ],
  io_type := [ [ "a", "b", "t", "s" ], [ "t_source", "P" ] ],
  cache_name := "UniversalMorphismIntoWeakBiFiberProduct",
  with_given_object_position := "Range",
  dual_operation := "UniversalMorphismFromWeakBiPushout",
  pre_function := UNIVERSAL_MORPHISM_INTO_WEAK_BI_FIBER_PRODUCT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

UniversalMorphismIntoWeakBiFiberProductWithGivenWeakBiFiberProduct := rec(
  filter_list := [ "category", "morphism", "morphism", "morphism", "morphism", "object" ],
  io_type := [ [ "a", "b", "t", "s", "P", ], [ "t_source", "P" ] ],
  cache_name := "UniversalMorphismIntoWeakBiFiberProductWithGivenWeakBiFiberProduct",
  dual_operation := "UniversalMorphismFromWeakBiPushoutWithGivenWeakBiPushout",
  pre_function := UNIVERSAL_MORPHISM_INTO_WEAK_BI_FIBER_PRODUCT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

WeakBiFiberProductMorphismToDirectSum := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  io_type := [ [ "alpha", "beta" ], [ "F", "S" ] ],
  cache_name := "WeakBiFiberProductMorphismToDirectSum",
  return_type := "morphism",
  dual_operation := "DirectSumMorphismToWeakBiPushout",
),

## Weak pushouts

WeakBiPushout := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  cache_name := "WeakBiPushout",
  dual_operation := "WeakBiFiberProduct",
  pre_function := WEAK_BI_PUSHOUT_PREFUNCTION,
  return_type := "object",
  is_merely_set_theoretic := true ),

InjectionOfFirstCofactorOfWeakBiPushout := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  io_type := [ [ "a", "b" ], [ "a_range", "P" ] ],
  cache_name := "InjectionOfFirstCofactorOfWeakBiPushout",
  with_given_object_position := "Range",
  dual_operation := "ProjectionInFirstFactorOfWeakBiFiberProduct",
  pre_function := WEAK_BI_PUSHOUT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

InjectionOfFirstCofactorOfWeakBiPushoutWithGivenWeakBiPushout := rec(
  filter_list := [ "category", "morphism", "morphism", "object" ],
  io_type := [ [ "a", "b", "P" ], [ "a_range", "P" ] ],
  cache_name := "InjectionOfFirstCofactorOfWeakBiPushoutWithGivenWeakBiPushout",
  dual_operation := "ProjectionInFirstFactorOfWeakBiFiberProductWithGivenWeakBiFiberProduct",
  pre_function := WEAK_BI_PUSHOUT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

InjectionOfSecondCofactorOfWeakBiPushout := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  io_type := [ [ "a", "b" ], [ "b_range", "P" ] ],
  cache_name := "InjectionOfSecondCofactorOfWeakBiPushout",
  with_given_object_position := "Range",
  dual_operation := "ProjectionInSecondFactorOfWeakBiFiberProduct",
  pre_function := WEAK_BI_PUSHOUT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

InjectionOfSecondCofactorOfWeakBiPushoutWithGivenWeakBiPushout := rec(
  filter_list := [ "category", "morphism", "morphism", "object" ],
  io_type := [ [ "a", "b", "P" ], [ "b_range", "P" ] ],
  cache_name := "InjectionOfSecondCofactorOfWeakBiPushoutWithGivenWeakBiPushout",
  dual_operation := "ProjectionInSecondFactorOfWeakBiFiberProductWithGivenWeakBiFiberProduct",
  pre_function := WEAK_BI_PUSHOUT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

UniversalMorphismFromWeakBiPushout := rec(
  filter_list := [ "category", "morphism", "morphism", "morphism", "morphism" ],
  io_type := [ [ "a", "b", "t", "s" ], [ "P", "t_range" ] ],
  cache_name := "UniversalMorphismFromWeakBiPushout",
  with_given_object_position := "Source",
  dual_operation := "UniversalMorphismIntoWeakBiFiberProduct",
  pre_function := UNIVERSAL_MORPHISM_FROM_WEAK_BI_PUSHOUT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

UniversalMorphismFromWeakBiPushoutWithGivenWeakBiPushout := rec(
  filter_list := [ "category", "morphism", "morphism", "morphism", "morphism", "object" ],
  io_type := [ [ "a", "b", "t", "s", "P", ], [ "P", "t_range" ] ],
  cache_name := "UniversalMorphismFromWeakBiPushoutWithGivenWeakBiPushout",
  dual_operation := "UniversalMorphismIntoWeakBiFiberProductWithGivenWeakBiFiberProduct",
  pre_function := UNIVERSAL_MORPHISM_FROM_WEAK_BI_PUSHOUT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

DirectSumMorphismToWeakBiPushout := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  io_type := [ [ "alpha", "beta" ], [ "S", "P" ] ],
  cache_name := "DirectSumMorphismToWeakBiPushout",
  return_type := "morphism",
  dual_operation := "WeakBiFiberProductMorphismToDirectSum",
),

## biased weak fiber product

BiasedWeakFiberProduct := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  cache_name := "BiasedWeakFiberProduct",
  dual_operation := "BiasedWeakPushout",
  pre_function := WEAK_BI_FIBER_PRODUCT_PREFUNCTION,
  return_type := "object",
  is_merely_set_theoretic := true ),

ProjectionOfBiasedWeakFiberProduct := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  io_type := [ [ "a", "b" ], [ "P", "a_source" ] ],
  cache_name := "ProjectionOfBiasedWeakFiberProduct",
  with_given_object_position := "Source",
  dual_operation := "InjectionOfBiasedWeakPushout",
  pre_function := WEAK_BI_FIBER_PRODUCT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

ProjectionOfBiasedWeakFiberProductWithGivenBiasedWeakFiberProduct := rec(
  filter_list := [ "category", "morphism", "morphism", "object" ],
  io_type := [ [ "a", "b", "P" ], [ "P", "a_source" ] ],
  cache_name := "ProjectionOfBiasedWeakFiberProductWithGivenBiasedWeakFiberProduct",
  dual_operation := "InjectionOfBiasedWeakPushoutWithGivenBiasedWeakPushout",
  pre_function := WEAK_BI_FIBER_PRODUCT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

UniversalMorphismIntoBiasedWeakFiberProduct := rec(
  filter_list := [ "category", "morphism", "morphism", "morphism" ],
  io_type := [ [ "a", "b", "t" ], [ "t_source", "P" ] ],
  cache_name := "UniversalMorphismIntoBiasedWeakFiberProduct",
  with_given_object_position := "Range",
  dual_operation := "UniversalMorphismFromBiasedWeakPushout",
  pre_function := UNIVERSAL_MORPHISM_INTO_BIASED_WEAK_FIBER_PRODUCT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

UniversalMorphismIntoBiasedWeakFiberProductWithGivenBiasedWeakFiberProduct := rec(
  filter_list := [ "category", "morphism", "morphism", "morphism", "object" ],
  io_type := [ [ "a", "b", "t", "P", ], [ "t_source", "P" ] ],
  cache_name := "UniversalMorphismIntoBiasedWeakFiberProductWithGivenBiasedWeakFiberProduct",
  dual_operation := "UniversalMorphismFromBiasedWeakPushoutWithGivenBiasedWeakPushout",
  pre_function := UNIVERSAL_MORPHISM_INTO_BIASED_WEAK_FIBER_PRODUCT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

## biased weak pushout

## Weak pushouts

BiasedWeakPushout := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  cache_name := "BiasedWeakPushout",
  dual_operation := "BiasedWeakFiberProduct",
  pre_function := WEAK_BI_PUSHOUT_PREFUNCTION,
  return_type := "object",
  is_merely_set_theoretic := true ),

InjectionOfBiasedWeakPushout := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  io_type := [ [ "a", "b" ], [ "a_range", "P" ] ],
  cache_name := "InjectionOfBiasedWeakPushout",
  with_given_object_position := "Range",
  dual_operation := "ProjectionOfBiasedWeakFiberProduct",
  pre_function := WEAK_BI_PUSHOUT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

InjectionOfBiasedWeakPushoutWithGivenBiasedWeakPushout := rec(
  filter_list := [ "category", "morphism", "morphism", "object" ],
  io_type := [ [ "a", "b", "P" ], [ "a_range", "P" ] ],
  cache_name := "InjectionOfBiasedWeakPushoutWithGivenBiasedWeakPushout",
  dual_operation := "ProjectionOfBiasedWeakFiberProductWithGivenBiasedWeakFiberProduct",
  pre_function := WEAK_BI_PUSHOUT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

UniversalMorphismFromBiasedWeakPushout := rec(
  filter_list := [ "category", "morphism", "morphism", "morphism" ],
  io_type := [ [ "a", "b", "t" ], [ "P", "t_range" ] ],
  cache_name := "UniversalMorphismFromBiasedWeakPushout",
  with_given_object_position := "Source",
  dual_operation := "UniversalMorphismIntoBiasedWeakFiberProduct",
  pre_function := UNIVERSAL_MORPHISM_FROM_BIASED_WEAK_PUSHOUT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

UniversalMorphismFromBiasedWeakPushoutWithGivenBiasedWeakPushout := rec(
  filter_list := [ "category", "morphism", "morphism", "morphism", "object" ],
  io_type := [ [ "a", "b", "t", "P", ], [ "P", "t_range" ] ],
  cache_name := "UniversalMorphismFromBiasedWeakPushoutWithGivenBiasedWeakPushout",
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
  cache_name := "EpimorphismFromSomeProjectiveObjectForKernelObjectWithGivenSomeProjectiveObjectForKernelObject",
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
  cache_name := "MonomorphismToSomeInjectiveObjectForCokernelObjectWithGivenSomeInjectiveObjectForCokernelObject",
  return_type := "morphism",
  output_range_getter_string := "range",
  dual_operation := "EpimorphismFromSomeProjectiveObjectForKernelObjectWithGivenSomeProjectiveObjectForKernelObject",
  is_merely_set_theoretic := true ),

  ) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( FREYD_CATEGORIES_METHOD_NAME_RECORD );

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
    
    return 
      Opposite(
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
