#############################################################################
##
##     FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
##
##  Copyright 2018, Sebastian Posur, University of Siegen
##
##
##
#############################################################################

##
InstallGlobalFunction( WEAK_BI_FIBER_PRODUCT_PREFUNCTION,
  function( morphism_1, morphism_2, arg... )
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
  function( morphism_1, morphism_2, test_morphism_1, test_morphism_2, arg... )
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
  function( morphism_1, morphism_2, test_morphism, arg... )
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
  function( morphism_1, morphism_2, arg... )
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
  function( morphism_1, morphism_2, test_morphism_1, test_morphism_2, arg... )
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
  function( morphism_1, morphism_2, test_morphism, arg... )
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
  installation_name := "WeakKernelObject",
  filter_list := [ "morphism" ],
  universal_type := "Limit",
  return_type := "object",
  dual_operation := "WeakCokernelObject",
  is_merely_set_theoretic := true ),

WeakKernelEmbedding := rec(
  installation_name := "WeakKernelEmbedding",
  filter_list := [ "morphism" ],
  io_type := [ [ "alpha" ], [ "K", "alpha_source" ] ],
  universal_object_position := "Source",
  universal_type := "Limit",
  return_type := "morphism",
  dual_operation := "WeakCokernelProjection",
  is_merely_set_theoretic := true ),

WeakKernelEmbeddingWithGivenWeakKernelObject := rec(
  installation_name := "WeakKernelEmbeddingWithGivenWeakKernelObject",
  filter_list := [ "morphism", "object" ],
  io_type := [ [ "alpha", "K" ], [ "K", "alpha_source" ] ],
  cache_name := "WeakKernelEmbeddingWithGivenWeakKernelObject",
  universal_type := "Limit",
  return_type := "morphism",
  dual_operation := "WeakCokernelProjectionWithGivenWeakCokernelObject",
  is_merely_set_theoretic := true ),

WeakKernelLift := rec(
  installation_name := "WeakKernelLift",
  filter_list := [ "morphism", "morphism" ],
  io_type := [ [ "alpha", "tau" ], [ "tau_source", "K" ] ],
  cache_name := "WeakKernelLift",
  universal_object_position := "Range",
  universal_type := "Limit",
  return_type := "morphism",
  dual_operation := "WeakCokernelColift",
  is_merely_set_theoretic := true ),

WeakKernelLiftWithGivenWeakKernelObject := rec(
  installation_name := "WeakKernelLiftWithGivenWeakKernelObject",
  filter_list := [ "morphism", "morphism", "object" ],
  io_type := [ [ "alpha", "tau", "K" ], [ "tau_source", "K" ] ],
  cache_name := "WeakKernelLiftWithGivenWeakKernelObject",
  universal_type := "Limit",
  return_type := "morphism",
  dual_operation := "WeakCokernelColiftWithGivenWeakCokernelObject",
  is_merely_set_theoretic := true ),

## Weak cokernels

WeakCokernelObject := rec(
  installation_name := "WeakCokernelObject",
  filter_list := [ "morphism" ],
  universal_type := "Colimit",
  return_type := "object",
  dual_operation := "WeakKernelObject",
  is_merely_set_theoretic := true ),

WeakCokernelProjection := rec(
  installation_name := "WeakCokernelProjection",
  filter_list := [ "morphism" ],
  io_type := [ [ "alpha" ], [ "alpha_range", "K" ] ],
  universal_object_position := "Range",
  universal_type := "Colimit",
  return_type := "morphism",
  dual_operation := "WeakKernelEmbedding",
  is_merely_set_theoretic := true ),

WeakCokernelProjectionWithGivenWeakCokernelObject := rec(
  installation_name := "WeakCokernelProjectionWithGivenWeakCokernelObject",
  filter_list := [ "morphism", "object" ],
  io_type := [ [ "alpha", "K" ], [ "alpha_range", "K" ] ],
  cache_name := "WeakCokernelProjectionWithGivenWeakCokernelObject",
  universal_type := "Colimit",
  return_type := "morphism",
  dual_operation := "WeakKernelEmbeddingWithGivenWeakKernelObject",
  is_merely_set_theoretic := true ),

WeakCokernelColift := rec(
  installation_name := "WeakCokernelColift",
  filter_list := [ "morphism", "morphism" ],
  io_type := [ [ "alpha", "tau" ], [ "K", "tau_range" ] ],
  cache_name := "WeakCokernelColift",
  universal_object_position := "Source",
  universal_type := "Colimit",
  return_type := "morphism",
  dual_operation := "WeakKernelLift",
  is_merely_set_theoretic := true ),

WeakCokernelColiftWithGivenWeakCokernelObject := rec(
  installation_name := "WeakCokernelColiftWithGivenWeakCokernelObject",
  filter_list := [ "morphism", "morphism", "object" ],
  io_type := [ [ "alpha", "tau", "K" ], [ "K", "tau_range" ] ],
  cache_name := "WeakCokernelColiftWithGivenWeakCokernelObject",
  universal_type := "Colimit",
  return_type := "morphism",
  dual_operation := "WeakKernelLiftWithGivenWeakKernelObject",
  is_merely_set_theoretic := true ),

## Weak bi-fiber product
## FIXME: create universal_type substitute

WeakBiFiberProduct := rec(
  installation_name := "WeakBiFiberProduct",
  filter_list := [ "morphism", "morphism" ],
  cache_name := "WeakBiFiberProduct",
  universal_type := "Limit",
  dual_operation := "WeakBiPushout",
  pre_function := WEAK_BI_FIBER_PRODUCT_PREFUNCTION,
  return_type := "object",
  is_merely_set_theoretic := true ),

ProjectionInFirstFactorOfWeakBiFiberProduct := rec(
  installation_name := "ProjectionInFirstFactorOfWeakBiFiberProduct",
  filter_list := [ "morphism", "morphism" ],
  io_type := [ [ "a", "b" ], [ "P", "a_source" ] ],
  number_of_diagram_arguments := 2,
  cache_name := "ProjectionInFirstFactorOfWeakBiFiberProduct",
  universal_object_position := "Source",
  universal_type := "Limit",
  dual_operation := "InjectionOfFirstCofactorOfWeakBiPushout",
  pre_function := WEAK_BI_FIBER_PRODUCT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

ProjectionInFirstFactorOfWeakBiFiberProductWithGivenWeakBiFiberProduct := rec(
  installation_name := "ProjectionInFirstFactorOfWeakBiFiberProductWithGivenWeakBiFiberProduct",
  filter_list := [ "morphism", "morphism", "object" ],
  io_type := [ [ "a", "b", "P" ], [ "P", "a_source" ] ],
  number_of_diagram_arguments := 2,
  cache_name := "ProjectionInFirstFactorOfWeakBiFiberProductWithGivenWeakBiFiberProduct",
  universal_object_position := "Source",
  universal_type := "Limit",
  dual_operation := "InjectionOfFirstCofactorOfWeakBiPushoutWithGivenWeakBiPushout",
  pre_function := WEAK_BI_FIBER_PRODUCT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

ProjectionInSecondFactorOfWeakBiFiberProduct := rec(
  installation_name := "ProjectionInSecondFactorOfWeakBiFiberProduct",
  filter_list := [ "morphism", "morphism" ],
  io_type := [ [ "a", "b" ], [ "P", "b_source" ] ],
  number_of_diagram_arguments := 2,
  cache_name := "ProjectionInSecondFactorOfWeakBiFiberProduct",
  universal_object_position := "Source",
  universal_type := "Limit",
  dual_operation := "InjectionOfSecondCofactorOfWeakBiPushout",
  pre_function := WEAK_BI_FIBER_PRODUCT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

ProjectionInSecondFactorOfWeakBiFiberProductWithGivenWeakBiFiberProduct := rec(
  installation_name := "ProjectionInSecondFactorOfWeakBiFiberProductWithGivenWeakBiFiberProduct",
  filter_list := [ "morphism", "morphism", "object" ],
  io_type := [ [ "a", "b", "P" ], [ "P", "b_source" ] ],
  number_of_diagram_arguments := 2,
  cache_name := "ProjectionInSecondFactorOfWeakBiFiberProductWithGivenWeakBiFiberProduct",
  universal_object_position := "Source",
  universal_type := "Limit",
  dual_operation := "InjectionOfSecondCofactorOfWeakBiPushoutWithGivenWeakBiPushout",
  pre_function := WEAK_BI_FIBER_PRODUCT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

UniversalMorphismIntoWeakBiFiberProduct := rec(
  installation_name := "UniversalMorphismIntoWeakBiFiberProduct",
  filter_list := [ "morphism", "morphism", "morphism", "morphism" ],
  io_type := [ [ "a", "b", "t", "s" ], [ "t_source", "P" ] ],
  number_of_diagram_arguments := 2,
  cache_name := "UniversalMorphismIntoWeakBiFiberProduct",
  universal_object_position := "Range",
  universal_type := "Limit",
  dual_operation := "UniversalMorphismFromWeakBiPushout",
  pre_function := UNIVERSAL_MORPHISM_INTO_WEAK_BI_FIBER_PRODUCT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

UniversalMorphismIntoWeakBiFiberProductWithGivenWeakBiFiberProduct := rec(
  installation_name := "UniversalMorphismIntoWeakBiFiberProductWithGivenWeakBiFiberProduct",
  filter_list := [ "morphism", "morphism", "morphism", "morphism", "object" ],
  io_type := [ [ "a", "b", "t", "s", "P", ], [ "t_source", "P" ] ],
  number_of_diagram_arguments := 2,
  cache_name := "UniversalMorphismIntoWeakBiFiberProductWithGivenWeakBiFiberProduct",
  universal_type := "Limit",
  dual_operation := "UniversalMorphismFromWeakBiPushoutWithGivenWeakBiPushout",
  pre_function := UNIVERSAL_MORPHISM_INTO_WEAK_BI_FIBER_PRODUCT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

WeakBiFiberProductMorphismToDirectSum := rec(
  installation_name := "WeakBiFiberProductMorphismToDirectSum",
  filter_list := [ "morphism", "morphism" ],
  io_type := [ [ "alpha", "beta" ], [ "F", "S" ] ],
  cache_name := "WeakBiFiberProductMorphismToDirectSum",
  return_type := "morphism",
  dual_operation := "DirectSumMorphismToWeakBiPushout",
  no_with_given := true ),

## Weak pushouts

WeakBiPushout := rec(
  installation_name := "WeakBiPushout",
  filter_list := [ "morphism", "morphism" ],
  cache_name := "WeakBiPushout",
  universal_type := "Colimit",
  dual_operation := "WeakBiFiberProduct",
  pre_function := WEAK_BI_PUSHOUT_PREFUNCTION,
  return_type := "object",
  is_merely_set_theoretic := true ),

InjectionOfFirstCofactorOfWeakBiPushout := rec(
  installation_name := "InjectionOfFirstCofactorOfWeakBiPushout",
  filter_list := [ "morphism", "morphism" ],
  io_type := [ [ "a", "b" ], [ "a_range", "P" ] ],
  number_of_diagram_arguments := 2,
  cache_name := "InjectionOfFirstCofactorOfWeakBiPushout",
  universal_object_position := "Range",
  universal_type := "Colimit",
  dual_operation := "ProjectionInFirstFactorOfWeakBiFiberProduct",
  pre_function := WEAK_BI_PUSHOUT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

InjectionOfFirstCofactorOfWeakBiPushoutWithGivenWeakBiPushout := rec(
  installation_name := "InjectionOfFirstCofactorOfWeakBiPushoutWithGivenWeakBiPushout",
  filter_list := [ "morphism", "morphism", "object" ],
  io_type := [ [ "a", "b", "P" ], [ "a_range", "P" ] ],
  number_of_diagram_arguments := 2,
  cache_name := "InjectionOfFirstCofactorOfWeakBiPushoutWithGivenWeakBiPushout",
  universal_object_position := "Range",
  universal_type := "Colimit",
  dual_operation := "ProjectionInFirstFactorOfWeakBiFiberProductWithGivenWeakBiFiberProduct",
  pre_function := WEAK_BI_PUSHOUT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

InjectionOfSecondCofactorOfWeakBiPushout := rec(
  installation_name := "InjectionOfSecondCofactorOfWeakBiPushout",
  filter_list := [ "morphism", "morphism" ],
  io_type := [ [ "a", "b" ], [ "b_range", "P" ] ],
  number_of_diagram_arguments := 2,
  cache_name := "InjectionOfSecondCofactorOfWeakBiPushout",
  universal_object_position := "Range",
  universal_type := "Colimit",
  dual_operation := "ProjectionInSecondFactorOfWeakBiFiberProduct",
  pre_function := WEAK_BI_PUSHOUT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

InjectionOfSecondCofactorOfWeakBiPushoutWithGivenWeakBiPushout := rec(
  installation_name := "InjectionOfSecondCofactorOfWeakBiPushoutWithGivenWeakBiPushout",
  filter_list := [ "morphism", "morphism", "object" ],
  io_type := [ [ "a", "b", "P" ], [ "b_range", "P" ] ],
  number_of_diagram_arguments := 2,
  cache_name := "InjectionOfSecondCofactorOfWeakBiPushoutWithGivenWeakBiPushout",
  universal_object_position := "Range",
  universal_type := "Colimit",
  dual_operation := "ProjectionInSecondFactorOfWeakBiFiberProductWithGivenWeakBiFiberProduct",
  pre_function := WEAK_BI_PUSHOUT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

UniversalMorphismFromWeakBiPushout := rec(
  installation_name := "UniversalMorphismFromWeakBiPushout",
  filter_list := [ "morphism", "morphism", "morphism", "morphism" ],
  io_type := [ [ "a", "b", "t", "s" ], [ "P", "t_range" ] ],
  number_of_diagram_arguments := 2,
  cache_name := "UniversalMorphismFromWeakBiPushout",
  universal_object_position := "Source",
  universal_type := "Colimit",
  dual_operation := "UniversalMorphismIntoWeakBiFiberProduct",
  pre_function := UNIVERSAL_MORPHISM_FROM_WEAK_BI_PUSHOUT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

UniversalMorphismFromWeakBiPushoutWithGivenWeakBiPushout := rec(
  installation_name := "UniversalMorphismFromWeakBiPushoutWithGivenWeakBiPushout",
  filter_list := [ "morphism", "morphism", "morphism", "morphism", "object" ],
  io_type := [ [ "a", "b", "t", "s", "P", ], [ "P", "t_range" ] ],
  number_of_diagram_arguments := 2,
  cache_name := "UniversalMorphismFromWeakBiPushoutWithGivenWeakBiPushout",
  universal_type := "Colimit",
  dual_operation := "UniversalMorphismIntoWeakBiFiberProductWithGivenWeakBiFiberProduct",
  pre_function := UNIVERSAL_MORPHISM_FROM_WEAK_BI_PUSHOUT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

DirectSumMorphismToWeakBiPushout := rec(
  installation_name := "DirectSumMorphismToWeakBiPushout",
  filter_list := [ "morphism", "morphism" ],
  io_type := [ [ "alpha", "beta" ], [ "S", "P" ] ],
  cache_name := "DirectSumMorphismToWeakBiPushout",
  return_type := "morphism",
  dual_operation := "WeakBiFiberProductMorphismToDirectSum",
  no_with_given := true ),

## biased weak fiber product
## FIXME: create universal_type substitute

BiasedWeakFiberProduct := rec(
  installation_name := "BiasedWeakFiberProduct",
  filter_list := [ "morphism", "morphism" ],
  cache_name := "BiasedWeakFiberProduct",
  universal_type := "Limit",
  dual_operation := "BiasedWeakPushout",
  pre_function := WEAK_BI_FIBER_PRODUCT_PREFUNCTION,
  return_type := "object",
  is_merely_set_theoretic := true ),

ProjectionOfBiasedWeakFiberProduct := rec(
  installation_name := "ProjectionOfBiasedWeakFiberProduct",
  filter_list := [ "morphism", "morphism" ],
  io_type := [ [ "a", "b" ], [ "P", "a_source" ] ],
  number_of_diagram_arguments := 2,
  cache_name := "ProjectionOfBiasedWeakFiberProduct",
  universal_object_position := "Source",
  universal_type := "Limit",
  dual_operation := "InjectionOfBiasedWeakPushout",
  pre_function := WEAK_BI_FIBER_PRODUCT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

ProjectionOfBiasedWeakFiberProductWithGivenBiasedWeakFiberProduct := rec(
  installation_name := "ProjectionOfBiasedWeakFiberProductWithGivenBiasedWeakFiberProduct",
  filter_list := [ "morphism", "morphism", "object" ],
  io_type := [ [ "a", "b", "P" ], [ "P", "a_source" ] ],
  number_of_diagram_arguments := 2,
  cache_name := "ProjectionOfBiasedWeakFiberProductWithGivenBiasedWeakFiberProduct",
  universal_object_position := "Source",
  universal_type := "Limit",
  dual_operation := "InjectionOfBiasedWeakPushoutWithGivenBiasedWeakPushout",
  pre_function := WEAK_BI_FIBER_PRODUCT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

UniversalMorphismIntoBiasedWeakFiberProduct := rec(
  installation_name := "UniversalMorphismIntoBiasedWeakFiberProduct",
  filter_list := [ "morphism", "morphism", "morphism" ],
  io_type := [ [ "a", "b", "t" ], [ "t_source", "P" ] ],
  number_of_diagram_arguments := 2,
  cache_name := "UniversalMorphismIntoBiasedWeakFiberProduct",
  universal_object_position := "Range",
  universal_type := "Limit",
  dual_operation := "UniversalMorphismFromBiasedWeakPushout",
  pre_function := UNIVERSAL_MORPHISM_INTO_BIASED_WEAK_FIBER_PRODUCT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

UniversalMorphismIntoBiasedWeakFiberProductWithGivenBiasedWeakFiberProduct := rec(
  installation_name := "UniversalMorphismIntoBiasedWeakFiberProductWithGivenBiasedWeakFiberProduct",
  filter_list := [ "morphism", "morphism", "morphism", "object" ],
  io_type := [ [ "a", "b", "t", "P", ], [ "t_source", "P" ] ],
  number_of_diagram_arguments := 2,
  cache_name := "UniversalMorphismIntoBiasedWeakFiberProductWithGivenBiasedWeakFiberProduct",
  universal_type := "Limit",
  dual_operation := "UniversalMorphismFromBiasedWeakPushoutWithGivenBiasedWeakPushout",
  pre_function := UNIVERSAL_MORPHISM_INTO_BIASED_WEAK_FIBER_PRODUCT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

## biased weak pushout

## Weak pushouts

BiasedWeakPushout := rec(
  installation_name := "BiasedWeakPushout",
  filter_list := [ "morphism", "morphism" ],
  cache_name := "BiasedWeakPushout",
  universal_type := "Colimit",
  dual_operation := "BiasedWeakFiberProduct",
  pre_function := WEAK_BI_PUSHOUT_PREFUNCTION,
  return_type := "object",
  is_merely_set_theoretic := true ),

InjectionOfBiasedWeakPushout := rec(
  installation_name := "InjectionOfBiasedWeakPushout",
  filter_list := [ "morphism", "morphism" ],
  io_type := [ [ "a", "b" ], [ "a_range", "P" ] ],
  number_of_diagram_arguments := 2,
  cache_name := "InjectionOfBiasedWeakPushout",
  universal_object_position := "Range",
  universal_type := "Colimit",
  dual_operation := "ProjectionOfBiasedWeakFiberProduct",
  pre_function := WEAK_BI_PUSHOUT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

InjectionOfBiasedWeakPushoutWithGivenBiasedWeakPushout := rec(
  installation_name := "InjectionOfBiasedWeakPushoutWithGivenBiasedWeakPushout",
  filter_list := [ "morphism", "morphism", "object" ],
  io_type := [ [ "a", "b", "P" ], [ "a_range", "P" ] ],
  number_of_diagram_arguments := 2,
  cache_name := "InjectionOfBiasedWeakPushoutWithGivenBiasedWeakPushout",
  universal_object_position := "Range",
  universal_type := "Colimit",
  dual_operation := "ProjectionOfBiasedWeakFiberProductWithGivenBiasedWeakFiberProduct",
  pre_function := WEAK_BI_PUSHOUT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

UniversalMorphismFromBiasedWeakPushout := rec(
  installation_name := "UniversalMorphismFromBiasedWeakPushout",
  filter_list := [ "morphism", "morphism", "morphism" ],
  io_type := [ [ "a", "b", "t", "s" ], [ "P", "t_range" ] ],
  number_of_diagram_arguments := 2,
  cache_name := "UniversalMorphismFromBiasedWeakPushout",
  universal_object_position := "Source",
  universal_type := "Colimit",
  dual_operation := "UniversalMorphismIntoBiasedWeakFiberProduct",
  pre_function := UNIVERSAL_MORPHISM_FROM_BIASED_WEAK_PUSHOUT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

UniversalMorphismFromBiasedWeakPushoutWithGivenBiasedWeakPushout := rec(
  installation_name := "UniversalMorphismFromBiasedWeakPushoutWithGivenBiasedWeakPushout",
  filter_list := [ "morphism", "morphism", "morphism", "object" ],
  io_type := [ [ "a", "b", "t", "P", ], [ "P", "t_range" ] ],
  number_of_diagram_arguments := 2,
  cache_name := "UniversalMorphismFromBiasedWeakPushoutWithGivenBiasedWeakPushout",
  universal_type := "Colimit",
  dual_operation := "UniversalMorphismIntoBiasedWeakFiberProductWithGivenBiasedWeakFiberProduct",
  pre_function := UNIVERSAL_MORPHISM_FROM_BIASED_WEAK_PUSHOUT_PREFUNCTION,
  return_type := "morphism",
  is_merely_set_theoretic := true ),

## an abelian construction
SomeProjectiveObjectForKernelObject := rec(
  installation_name := "SomeProjectiveObjectForKernelObject",
  filter_list := [ "morphism" ],
  return_type := "object",
  dual_operation := "SomeInjectiveObjectForCokernelObject",
  is_merely_set_theoretic := true ),

EpimorphismFromSomeProjectiveObjectForKernelObject := rec(
  installation_name := "EpimorphismFromSomeProjectiveObjectForKernelObject",
  filter_list := [ "morphism" ],
  io_type := [ [ "alpha" ], [ "epsilon" ] ],
  universal_object_position := "Source",
  universal_type := "Limit", #FIXME: this is not a limit, but on a technical level, it behaves as if it was
  return_type := "morphism",
  dual_operation := "MonomorphismToSomeInjectiveObjectForCokernelObject",
  is_merely_set_theoretic := true ),

EpimorphismFromSomeProjectiveObjectForKernelObjectWithGivenSomeProjectiveObjectForKernelObject := rec(
  installation_name := "EpimorphismFromSomeProjectiveObjectForKernelObjectWithGivenSomeProjectiveObjectForKernelObject",
  filter_list := [ "morphism", "object" ],
  io_type := [ [ "alpha", "P" ], [ "epsilon" ] ],
  universal_type := "Limit", #FIXME: this is not a limit, but on a technical level, it behaves as if it was
  cache_name := "EpimorphismFromSomeProjectiveObjectForKernelObjectWithGivenSomeProjectiveObjectForKernelObject",
  return_type := "morphism",
  dual_operation := "MonomorphismToSomeInjectiveObjectForCokernelObjectWithGivenSomeInjectiveObjectForCokernelObject",
  is_merely_set_theoretic := true ),

SomeInjectiveObjectForCokernelObject := rec(
  installation_name := "SomeInjectiveObjectForCokernelObject",
  filter_list := [ "morphism" ],
  return_type := "object",
  dual_operation := "SomeProjectiveObjectForKernelObject",
  is_merely_set_theoretic := true ),

MonomorphismToSomeInjectiveObjectForCokernelObject := rec(
  installation_name := "MonomorphismToSomeInjectiveObjectForCokernelObject",
  filter_list := [ "morphism" ],
  io_type := [ [ "alpha" ], [ "iota" ] ],
  universal_object_position := "Range",
  universal_type := "Colimit", #FIXME: this is not a colimit, but on a technical level, it behaves as if it was
  return_type := "morphism",
  dual_operation := "EpimorphismFromSomeProjectiveObjectForKernelObject",
  is_merely_set_theoretic := true ),

MonomorphismToSomeInjectiveObjectForCokernelObjectWithGivenSomeInjectiveObjectForCokernelObject := rec(
  installation_name := "MonomorphismToSomeInjectiveObjectForCokernelObjectWithGivenSomeInjectiveObjectForCokernelObject",
  filter_list := [ "morphism", "object" ],
  io_type := [ [ "alpha", "I" ], [ "iota" ] ],
  universal_type := "Colift", #FIXME: this is not a limit, but on a technical level, it behaves as if it was
  cache_name := "MonomorphismToSomeInjectiveObjectForCokernelObjectWithGivenSomeInjectiveObjectForCokernelObject",
  return_type := "morphism",
  dual_operation := "EpimorphismFromSomeProjectiveObjectForKernelObjectWithGivenSomeProjectiveObjectForKernelObject",
  is_merely_set_theoretic := true ),

  ) );

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
