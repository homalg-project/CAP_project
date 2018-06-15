#############################################################################
##
##                                               CAP package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#############################################################################

#############################################
##
## Installation method
##
#############################################

BindGlobal( "CAP_INTERNAL_INSTALL_OPERATIONS_FOR_SERRE_QUOTIENT_BY_SPANS",
  
  function( category )
    local membership_function;
    
    membership_function := SubcategoryMembershipTestFunctionForSerreQuotient( category );
    
    ## Equalities
    
    AddIsCongruentForMorphisms( category,
      
      function( morphism1, morphism2 )
        local underlying_general, new_general, sum_general,
              sum_associated, sum_image;
        
        underlying_general := UnderlyingGeneralizedMorphism( morphism2 );
        
        new_general := AdditiveInverse( underlying_general );
        
        sum_general := AdditionForMorphisms( UnderlyingGeneralizedMorphism( morphism1 ), new_general );
        
        sum_associated := AssociatedMorphism( sum_general );
        
        sum_image := ImageObject( sum_associated );
        
        return membership_function( sum_image );
        
    end );
    
    AddIsEqualForObjects( category,
      
      function( obj1, obj2 )
        
        return IsEqualForObjects( UnderlyingHonestObject( obj1 ), UnderlyingHonestObject( obj2 ) );
        
    end );
    
    AddIsEqualForCacheForObjects( category, IsIdenticalObj );
    AddIsEqualForCacheForMorphisms( category, IsIdenticalObj );
    
    ## Is Zero
    
    AddIsZeroForObjects( category,
      
      function( obj )
        
        return membership_function( UnderlyingHonestObject( obj ) );
        
    end );
    
    ## PreCompose
    
    AddPreCompose( category,
      
      function( morphism1, morphism2 )
        local composition;
        
        composition := PreCompose( UnderlyingGeneralizedMorphism( morphism1 ),
                                   UnderlyingGeneralizedMorphism( morphism2 ) );
        
        return SerreQuotientCategoryBySpansMorphism( category, composition );
        
    end );
    
    ## IdentityMorphism
    
    AddIdentityMorphism( category,
      
      function( object )
        
        return AsSerreQuotientCategoryBySpansMorphism( category, IdentityMorphism( UnderlyingHonestObject( object ) ) );
        
    end );
    
    ## Addition for morphisms
    
    AddAdditionForMorphisms( category,
      
      function( morphism1, morphism2 )
        local underlying_generalized, common_restriction, new_arrow;
        
        underlying_generalized := List( [ morphism1, morphism2 ], UnderlyingGeneralizedMorphism );
        
        common_restriction := CommonRestriction( underlying_generalized );
        
        new_arrow := AdditionForMorphisms( Arrow( common_restriction[ 1 ] ), Arrow( common_restriction[ 2 ] ) );
        
        return SerreQuotientCategoryBySpansMorphism( category, ReversedArrow( common_restriction[ 1 ] ), new_arrow );
        
    end );
    
    ## IsZeroForMorphisms
    ## Can be derived, but there might be a faster solution
#     AddIsZeroForMorphisms( category,
#       
#       function( morphism )
#         local associated, image;
#         
#         associated := AssociatedMorphism( UnderlyingGeneralizedMorphism( morphism ) );
#         
#         image := ImageObject( associated );
#         
#         return membership_function( image );
#         
#     end );
    
    ## Additive inverse for morphisms (works without normalization)
    
    AddAdditiveInverseForMorphisms( category,
      
      function( morphism )
        local general;
        
        general := UnderlyingGeneralizedMorphism( morphism );
        
        return SerreQuotientCategoryBySpansMorphism( category, ReversedArrow( general ), AdditiveInverseForMorphisms( Arrow( general ) ) );
        
    end );
    
    ## Zero morphism
    
    AddZeroMorphism( category,
      
      function( source, range )
        local new_general;
        
        new_general := ZeroMorphism( UnderlyingHonestObject( source ), UnderlyingHonestObject( range ) );
        
        return AsSerreQuotientCategoryBySpansMorphism( category, new_general );
        
    end );
    
    ## Zero object
    
    AddZeroObject( category,
      
      function( )
        local generalized_zero;
        
        generalized_zero := ZeroObject( UnderlyingHonestCategory( category ) );
        
        return AsSerreQuotientCategoryBySpansObject( category, generalized_zero );
        
    end );
    
    ## direct sum
    
    AddDirectSum( category,
      
      function( obj_list )
        local honest_list, honest_sum;
        
        honest_list := List( obj_list, UnderlyingHonestObject );
        
        honest_sum := DirectSum( honest_list );
        
        return AsSerreQuotientCategoryBySpansObject( category, honest_sum );
        
    end );
    
    AddProjectionInFactorOfDirectSumWithGivenDirectSum( category,
      
      function( product_object, component_number, direct_sum_object )
        local underlying_objects, honest_projection;
        
        underlying_objects := List( product_object, UnderlyingHonestObject );
        
        honest_projection := ProjectionInFactorOfDirectSum( underlying_objects, component_number );
        
        return AsSerreQuotientCategoryBySpansMorphism( category, honest_projection );
        
    end );
    
    AddInjectionOfCofactorOfDirectSumWithGivenDirectSum( category,
      
      function( object_product_list, injection_number, direct_sum_object )
        local underlying_objects, honest_injection;
        
        underlying_objects := List( object_product_list, UnderlyingHonestObject );
        
        honest_injection := InjectionOfCofactorOfDirectSum( underlying_objects, injection_number );
        
        return AsSerreQuotientCategoryBySpansMorphism( category, honest_injection );
        
    end );
    
    AddUniversalMorphismIntoDirectSum( category,
      
      function( diagram, morphism_list )
        local generalized_list, arrow_list, reversedarrow_list, new_arrow, new_reversed_arrow, object_list;
        
        generalized_list := List( morphism_list, UnderlyingGeneralizedMorphism );
        
        generalized_list := CommonRestriction( generalized_list );
        
        new_reversed_arrow := ReversedArrow( generalized_list[ 1 ] );
        
        arrow_list := List( generalized_list, Arrow );
        
        new_arrow := UniversalMorphismIntoDirectSum( List( diagram, UnderlyingHonestObject ), arrow_list );
        
        return SerreQuotientCategoryBySpansMorphism( category, new_reversed_arrow, new_arrow );
        
    end );
    
    AddUniversalMorphismFromDirectSum( category,
      
      function( diagram, morphism_list )
        local generalized_list, arrow_list, reversedarrow_list, new_arrow, new_reversed_arrow, object_list;
        
        generalized_list := List( morphism_list, UnderlyingGeneralizedMorphism );
        
        arrow_list := List( generalized_list, Arrow );
        
        reversedarrow_list := List( generalized_list, ReversedArrow );
        
        new_arrow := UniversalMorphismFromDirectSum( List( arrow_list, Source ), arrow_list );
        
        new_reversed_arrow := DirectSumFunctorial( reversedarrow_list );
        
        return SerreQuotientCategoryBySpansMorphism( category, new_reversed_arrow, new_arrow );
        
    end );
    
    ## Kernel
    
    AddKernelEmbedding( category,
      
      function( morphism )
        local underlying_general, kernel_mor;
        
        underlying_general := UnderlyingGeneralizedMorphism( morphism );
        
#         underlying_general := NormalizedSpan( underlying_general );
        
        kernel_mor := KernelEmbedding( Arrow( underlying_general ) );
        
        return AsSerreQuotientCategoryBySpansMorphism( category, PreCompose( kernel_mor, ReversedArrow( underlying_general ) ) );
        
    end );
    
    AddLiftAlongMonomorphism( category,
      
      function( monomorphism, test_morphism )
        local inverse_of_mono, composition;
        
        inverse_of_mono := PseudoInverse( UnderlyingGeneralizedMorphism( monomorphism ) );
        
        composition := PreCompose( UnderlyingGeneralizedMorphism( test_morphism ), inverse_of_mono );
        
        return SerreQuotientCategoryBySpansMorphism( category, composition );
        
    end );
    
    ## Cokernel
    
    AddCokernelProjection( category,
      
      function( morphism )
        local underlying_general, cokernel_mor;
        
        underlying_general := UnderlyingGeneralizedMorphism( morphism );
        
#         underlying_general := NormalizedSpan( underlying_general );
        
        cokernel_mor := CokernelProjection( Arrow( underlying_general ) );
        
        return AsSerreQuotientCategoryBySpansMorphism( category, cokernel_mor );
        
    end );
    
    AddColiftAlongEpimorphism( category,
      
      function( epimorphism, test_morphism )
        local inverse_of_epi, composition;
        
        inverse_of_epi := PseudoInverse( UnderlyingGeneralizedMorphism( epimorphism ) );
        
        composition := PreCompose( inverse_of_epi, UnderlyingGeneralizedMorphism( test_morphism ) );
        
        return SerreQuotientCategoryBySpansMorphism( category, composition );
        
    end );
    
    AddLift( category,
      
      function( test_morphism, monomorphism )
        local inverse_of_mono, composition;
        
        test_morphism := UnderlyingGeneralizedMorphism( test_morphism );
        monomorphism := UnderlyingGeneralizedMorphism( monomorphism );
        
        if not IsHonest( test_morphism ) or not IsHonest( monomorphism ) then
            return fail;
        fi;
        
        test_morphism := HonestRepresentative( test_morphism );
        monomorphism := HonestRepresentative( monomorphism );
        
        composition := Lift( test_morphism, monomorphism );
        
        if composition = fail then
            return fail;
        fi;
        
        return AsSerreQuotientCategoryBySpansMorphism( category, composition );
        
    end );
    
    AddDualOnObjects( category,
      
      function( object )
        
        return AsSerreQuotientCategoryBySpansObject( category, DualOnObjects( UnderlyingHonestObject( object ) ) );
        
    end );
    
    AddDualOnMorphismsWithGivenDuals( category,
      
      function( new_source, morphism, new_range )
        local arrow, reversed_arrow, new_arrow, new_reversed_arrow;
        
        arrow := Arrow( UnderlyingGeneralizedMorphism( morphism ) );
        reversed_arrow := ReversedArrow( UnderlyingGeneralizedMorphism( morphism ) );
        
        arrow := DualOnMorphisms( arrow );
        reversed_arrow := DualOnMorphisms( reversed_arrow );
        
        new_reversed_arrow := ProjectionInFactorOfFiberProduct( [ reversed_arrow, arrow ], 2 );
        new_arrow := ProjectionInFactorOfFiberProduct( [ reversed_arrow, arrow ], 1 );
        
        return SerreQuotientCategoryBySpansMorphism( category, new_reversed_arrow, new_arrow );
        
    end );
    
    AddInverse( category,
      
      function( morphism )
        local underlying_general, inverse;
        
        underlying_general := UnderlyingGeneralizedMorphism( morphism );
        
        inverse := PseudoInverse( underlying_general );
        
        return SerreQuotientCategoryBySpansMorphism( category, inverse );
        
    end );
    
end );

#############################################
##
## Constructor
##
#############################################

InstallMethod( SerreQuotientCategoryBySpans,
               [ IsCapCategory, IsFunction ],
               
  function( category, test_function )
    local name;
    
    name := NameFunction( test_function );
    
    return SerreQuotientCategoryBySpans( category, test_function, Concatenation( "test function with name: ", name ) );
    
end );

InstallMethodWithCacheFromObject( SerreQuotientCategoryBySpans,
                                  [ IsCapCategory, IsFunction, IsString ],
                                  
  function( category, test_function, function_name )
    local serre_category, gen_category, name, preconditions, category_weight_list, i;
    
    if not HasIsFinalized( category ) or not IsFinalized( category ) then
        
        Error( "category must be finalized" );
        return;
        
    fi;
    
    preconditions := [ "IsEqualForObjects",
                       "ImageObject",
                       "AdditiveInverseForMorphisms",
                       "IdentityMorphism",
                       "ZeroMorphism",
                       "DirectSum",
                       "ProjectionInFactorOfDirectSumWithGivenDirectSum",
                       "InjectionOfCofactorOfDirectSumWithGivenDirectSum",
                       "UniversalMorphismFromDirectSum",
                       "UniversalMorphismIntoDirectSum",
                       "DirectSumFunctorialWithGivenDirectSums",
                       "KernelEmbedding",
                       "CokernelProjection" ];
    
    category_weight_list := category!.derivations_weight_list;
    
    for i in preconditions do
        
        if CurrentOperationWeight( category_weight_list, i ) = infinity then
            
            Error( Concatenation( "category must be able to compute ", i ) );
            return;
            
        fi;
        
    od;
    
    name := Name( category );
    
    name := Concatenation( "The Serre quotient category of ", name, " by ", function_name );
    
    serre_category := CreateCapCategory( name );
    
    AddObjectRepresentation( serre_category, IsSerreQuotientCategoryBySpansObject );
    
    AddMorphismRepresentation( serre_category, IsSerreQuotientCategoryBySpansMorphism );
    
    DisableAddForCategoricalOperations( serre_category );
    
    serre_category!.predicate_logic := category!.predicate_logic;
    
    SetFilterObj( serre_category, WasCreatedAsSerreQuotientCategoryBySpans );
    
    SetUnderlyingHonestCategory( serre_category, category );
    
    SetUnderlyingGeneralizedMorphismCategory( serre_category, GeneralizedMorphismCategoryBySpans( category ) );
    
    SetSubcategoryMembershipTestFunctionForSerreQuotient( serre_category, test_function );
    
    SetIsAbelianCategory( serre_category, true );
    
    CAP_INTERNAL_INSTALL_OPERATIONS_FOR_SERRE_QUOTIENT_BY_SPANS( serre_category );
    
    CAP_INTERNAL_INSTALL_OPERATIONS_FOR_SERRE_QUOTIENT( serre_category );
    
    Finalize( serre_category );
    
    return serre_category;
    
end );

InstallMethodWithCacheFromObject( AsSerreQuotientCategoryBySpansObject,
                                  [ IsCapCategory and WasCreatedAsSerreQuotientCategoryBySpans, IsCapCategoryObject ],
                                  
  function( serre_category, object )
    local honest_category, serre_object;
    
    honest_category := UnderlyingHonestCategory( serre_category );
    
    if not IsIdenticalObj( honest_category, CapCategory( object ) ) then
        
        Error( "object does not belong to underlying honest category of serre quotient" );
        
    fi;
    
    serre_object := rec( );
    
    ObjectifyObjectForCAPWithAttributes( serre_object, serre_category,
                             UnderlyingHonestObject, object,
                             UnderlyingGeneralizedObject, GeneralizedMorphismBySpansObject( object ) );
    
    if HasSpecializedObjectFilterForSerreQuotients( serre_category ) then
        
        SetFilterObj( serre_object, SpecializedObjectFilterForSerreQuotients( serre_category ) );
        
    fi;
    
    return serre_object;
    
end );

InstallMethodWithCacheFromObject( SerreQuotientCategoryBySpansMorphism,
                                  [ IsCapCategory and WasCreatedAsSerreQuotientCategoryBySpans, IsGeneralizedMorphismBySpan ],
                                  
  function( serre_category, gen_morphism )
    local honest_category, serre_morphism;
    
    if not IsIdenticalObj( UnderlyingGeneralizedMorphismCategory( serre_category ), CapCategory( gen_morphism ) ) then
        
        Error( "generalized morphism has wrong category" );
        
    fi;
    
    serre_morphism := rec( );
    
    ObjectifyMorphismForCAPWithAttributes( serre_morphism, serre_category,
                             Source, AsSerreQuotientCategoryBySpansObject( serre_category, UnderlyingHonestObject( Source( gen_morphism ) ) ),
                             Range, AsSerreQuotientCategoryBySpansObject( serre_category, UnderlyingHonestObject( Range( gen_morphism ) ) ),
                             UnderlyingGeneralizedMorphism, gen_morphism );
    
    if HasSpecializedMorphismFilterForSerreQuotients( serre_category ) then
        
        SetFilterObj( serre_morphism, SpecializedMorphismFilterForSerreQuotients( serre_category ) );
        
    fi;
    
    return serre_morphism;
    
end );

InstallMethod( SerreQuotientCategoryMorphism,
               [ IsCapCategory and WasCreatedAsSerreQuotientCategoryBySpans, IsGeneralizedMorphismBySpan ],
               
  SerreQuotientCategoryBySpansMorphism );

InstallMethod( SerreQuotientCategoryBySpansMorphism,
               [ IsCapCategory and WasCreatedAsSerreQuotientCategoryBySpans, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ],
                                  
  function( serre_category, source_aid, associated, range_aid )
    
    return SerreQuotientCategoryBySpansMorphism( serre_category, GeneralizedMorphismBySpan( source_aid, associated, range_aid ) );
    
end );

InstallMethod( SerreQuotientCategoryBySpansMorphism,
               [ IsCapCategory and WasCreatedAsSerreQuotientCategoryBySpans, IsCapCategoryMorphism, IsCapCategoryMorphism ],
                                  
  function( serre_category, reversed_arrow, arrow )
    
    return SerreQuotientCategoryBySpansMorphism( serre_category, GeneralizedMorphismBySpan( reversed_arrow, arrow ) );
    
end );

InstallMethod( SerreQuotientCategoryBySpansMorphismWithRangeAid,
               [ IsCapCategory and WasCreatedAsSerreQuotientCategoryBySpans, IsCapCategoryMorphism, IsCapCategoryMorphism ],
                                  
  function( serre_category, associated, range_aid )
    
    return SerreQuotientCategoryBySpansMorphism( serre_category, GeneralizedMorphismBySpanWithRangeAid( associated, range_aid ) );
    
end );

InstallMethodWithCacheFromObject( AsSerreQuotientCategoryBySpansMorphism,
                                  [ IsCapCategory and WasCreatedAsSerreQuotientCategoryBySpans, IsCapCategoryMorphism ],
                                  
  function( serre_category, arrow )
    
    return SerreQuotientCategoryBySpansMorphism( serre_category, AsGeneralizedMorphismBySpan( arrow ) );
    
end );

#############################################
##
## Compatibility layer
##
#############################################

InstallMethod( AsSerreQuotientCategoryObject,
               [ IsCapCategory and WasCreatedAsSerreQuotientCategoryBySpans, IsCapCategoryObject ],
               
  AsSerreQuotientCategoryBySpansObject );

InstallMethod( AsSerreQuotientCategoryMorphism,
               [ IsCapCategory and WasCreatedAsSerreQuotientCategoryBySpans, IsCapCategoryMorphism ],
                                  
  AsSerreQuotientCategoryBySpansMorphism );

InstallMethod( SerreQuotientCategoryMorphism,
               [ IsCapCategory and WasCreatedAsSerreQuotientCategoryBySpans, IsGeneralizedMorphismBySpan ],
               
  SerreQuotientCategoryBySpansMorphism );

InstallMethod( SerreQuotientCategoryMorphism,
               [ IsCapCategory and WasCreatedAsSerreQuotientCategoryBySpans, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ],
                                  
  SerreQuotientCategoryBySpansMorphism );

InstallMethod( SerreQuotientCategoryMorphism,
               [ IsCapCategory and WasCreatedAsSerreQuotientCategoryBySpans, IsCapCategoryMorphism, IsCapCategoryMorphism ],
                                  
  SerreQuotientCategoryBySpansMorphism );

InstallMethod( SerreQuotientCategoryMorphismWithRangeAid,
               [ IsCapCategory and WasCreatedAsSerreQuotientCategoryBySpans, IsCapCategoryMorphism, IsCapCategoryMorphism ],
                                  
  SerreQuotientCategoryBySpansMorphismWithRangeAid );

InstallMethod( SerreQuotientCategoryMorphismWithSourceAid,
               [ IsCapCategory and WasCreatedAsSerreQuotientCategoryBySpans, IsCapCategoryMorphism, IsCapCategoryMorphism ],
                                  
  SerreQuotientCategoryBySpansMorphism );

#############################################
##
## Functor
##
#############################################

InstallMethod( CanonicalProjection,
               [ IsCapCategory and WasCreatedAsSerreQuotientCategoryBySpans ],
               
  function( category )
    local underlying_honest, functor;
    
    underlying_honest := UnderlyingHonestCategory( category );
    
    functor := CapFunctor( Concatenation( "Embedding in ", Name( category ) ), underlying_honest, category );
    
    AddObjectFunction( functor,
        
        i -> AsSerreQuotientCategoryBySpansObject( category, i ) );
    
    AddMorphismFunction( functor,
      
      function( new_source, morphism, new_range )
        
        return AsSerreQuotientCategoryBySpansMorphism( category, morphism );
        
    end );
    
    return functor;
    
end );
