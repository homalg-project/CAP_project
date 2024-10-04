# SPDX-License-Identifier: GPL-2.0-or-later
# GeneralizedMorphismsForCAP: Implementations of generalized morphisms for the CAP project
#
# Implementations
#

#############################################
##
## Installation method
##
#############################################

BindGlobal( "CAP_INTERNAL_INSTALL_OPERATIONS_FOR_SERRE_QUOTIENT_BY_SPANS",
  
  function( category )
    local honest_category, membership_function;
    
    membership_function := SubcategoryMembershipTestFunctionForSerreQuotient( category );
    
    ## Equalities
    
    AddIsCongruentForMorphisms( category,
      
      function( cat, morphism1, morphism2 )
        local underlying_generalized_category, underlying_general, new_general, sum_general,
              sum_associated, sum_image;
        
        underlying_generalized_category := UnderlyingGeneralizedMorphismCategory( cat );
        
        underlying_general := UnderlyingGeneralizedMorphism( morphism2 );
        
        new_general := AdditiveInverse( underlying_generalized_category, underlying_general );
        
        sum_general := AdditionForMorphisms( underlying_generalized_category, UnderlyingGeneralizedMorphism( morphism1 ), new_general );
        
        sum_associated := AssociatedMorphism( sum_general );
        
        sum_image := ImageObject( underlying_generalized_category, sum_associated );
        
        return membership_function( sum_image );
        
    end );
    
    AddIsEqualForObjects( category,
      
      function( cat, obj1, obj2 )
        
        return IsEqualForObjects( UnderlyingHonestCategory( cat ), UnderlyingHonestObject( obj1 ), UnderlyingHonestObject( obj2 ) );
        
    end );
    
    ## Is Zero
    
    AddIsZeroForObjects( category,
      
      function( cat, obj )
        
        return membership_function( UnderlyingHonestObject( obj ) );
        
    end );
    
    ## PreCompose
    
    AddPreCompose( category,
      
      function( cat, morphism1, morphism2 )
        local underlying_generalized_category, composition;
        
        underlying_generalized_category := UnderlyingGeneralizedMorphismCategory( cat );
        
        composition := PreCompose( underlying_generalized_category,
                                   UnderlyingGeneralizedMorphism( morphism1 ),
                                   UnderlyingGeneralizedMorphism( morphism2 ) );
        
        return SerreQuotientCategoryBySpansMorphism( cat, composition );
        
    end );
    
    ## IdentityMorphism
    
    AddIdentityMorphism( category,
      
      function( cat, object )
        
        return AsSerreQuotientCategoryBySpansMorphism( cat,
                                                       IdentityMorphism( UnderlyingHonestCategory( cat ),
                                                       UnderlyingHonestObject( object ) ) );
        
    end );
    
    ## Addition for morphisms
    
    AddAdditionForMorphisms( category,
      
      function( cat, morphism1, morphism2 )
        local underlying_generalized_category, underlying_generalized, common_restriction, new_arrow;
        
        underlying_generalized_category := UnderlyingHonestCategory( cat );
        
        underlying_generalized := List( [ morphism1, morphism2 ], UnderlyingGeneralizedMorphism );
        
        common_restriction := CommonRestriction( underlying_generalized );
        
        new_arrow := AdditionForMorphisms( underlying_generalized_category,
                                           Arrow( common_restriction[ 1 ] ),
                                           Arrow( common_restriction[ 2 ] ) );
        
        return SerreQuotientCategoryBySpansMorphism( cat, ReversedArrow( common_restriction[ 1 ] ), new_arrow );
        
    end );
    
    ## IsZeroForMorphisms
    ## Can be derived, but there might be a faster solution
#     AddIsZeroForMorphisms( category,
#       
#       function( cat, morphism )
#         local honest_category, associated, image;
#         
#         honest_category := UnderlyingHonestCategory( cat );
#         
#         associated := AssociatedMorphism( UnderlyingGeneralizedMorphism( morphism ) );
#         
#         image := ImageObject( honest_category, associated );
#         
#         return membership_function( image );
#         
#     end );
    
    ## Additive inverse for morphisms (works without normalization)
    
    AddAdditiveInverseForMorphisms( category,
      
      function( cat, morphism )
        local underlying_generalized_category, general;
        
        underlying_generalized_category := UnderlyingGeneralizedMorphismCategory( cat );
        
        general := UnderlyingGeneralizedMorphism( morphism );
        
        return SerreQuotientCategoryBySpansMorphism( cat,
                                                     ReversedArrow( general ),
                                                     AdditiveInverseForMorphisms( underlying_generalized_category, Arrow( general ) ) );
        
    end );
    
    ## Zero morphism
    
    AddZeroMorphism( category,
      
      function( cat, source, range )
        local honest_category, new_general;
        
        honest_category := UnderlyingHonestCategory( cat );
        
        new_general := ZeroMorphism( honest_category,
                                     UnderlyingHonestObject( source ),
                                     UnderlyingHonestObject( range ) );
        
        return AsSerreQuotientCategoryBySpansMorphism( cat, new_general );
        
    end );
    
    ## Zero object
    
    AddZeroObject( category,
      
      function( cat )
        local generalized_zero;
        
        generalized_zero := ZeroObject( UnderlyingHonestCategory( cat ) );
        
        return AsSerreQuotientCategoryBySpansObject( cat, generalized_zero );
        
    end );
    
    ## direct sum
    
    AddDirectSum( category,
      
      function( cat, obj_list )
        local honest_category, honest_list, honest_sum;
        
        honest_category := UnderlyingHonestCategory( cat );
        
        honest_list := List( obj_list, UnderlyingHonestObject );
        
        honest_sum := DirectSum( honest_category, honest_list );
        
        return AsSerreQuotientCategoryBySpansObject( cat, honest_sum );
        
    end );
    
    AddProjectionInFactorOfDirectSumWithGivenDirectSum( category,
      
      function( cat, product_object, component_number, direct_sum_object )
        local honest_category, underlying_objects, honest_projection;
        
        honest_category := UnderlyingHonestCategory( cat );
        
        underlying_objects := List( product_object, UnderlyingHonestObject );
        
        honest_projection := ProjectionInFactorOfDirectSum( honest_category,
                                                            underlying_objects,
                                                            component_number );
        
        return AsSerreQuotientCategoryBySpansMorphism( cat, honest_projection );
        
    end );
    
    AddInjectionOfCofactorOfDirectSumWithGivenDirectSum( category,
      
      function( cat, object_product_list, injection_number, direct_sum_object )
        local honest_category, underlying_objects, honest_injection;
        
        honest_category := UnderlyingHonestCategory( cat );
        
        underlying_objects := List( object_product_list, UnderlyingHonestObject );
        
        honest_injection := InjectionOfCofactorOfDirectSum( honest_category,
                                                            underlying_objects,
                                                            injection_number );
        
        return AsSerreQuotientCategoryBySpansMorphism( cat, honest_injection );
        
    end );
    
    AddUniversalMorphismIntoDirectSum( category,
      
      function( cat, diagram, test_object, morphism_list )
        local honest_category, generalized_list, arrow_list, reversedarrow_list, new_arrow, new_reversed_arrow, object_list;
        
        honest_category := UnderlyingHonestCategory( cat );
        
        generalized_list := List( morphism_list, UnderlyingGeneralizedMorphism );
        
        generalized_list := CommonRestriction( generalized_list );
        
        new_reversed_arrow := ReversedArrow( generalized_list[ 1 ] );
        
        arrow_list := List( generalized_list, Arrow );
        
        new_arrow := UniversalMorphismIntoDirectSum( honest_category, List( diagram, UnderlyingHonestObject ), arrow_list );
        
        return SerreQuotientCategoryBySpansMorphism( cat, new_reversed_arrow, new_arrow );
        
    end );
    
    AddUniversalMorphismFromDirectSum( category,
      
      function( cat, diagram, test_object, morphism_list )
        local honest_category, generalized_list, arrow_list, reversedarrow_list, new_arrow, new_reversed_arrow, object_list;
        
        honest_category := UnderlyingHonestCategory( cat );
        
        generalized_list := List( morphism_list, UnderlyingGeneralizedMorphism );
        
        arrow_list := List( generalized_list, Arrow );
        
        reversedarrow_list := List( generalized_list, ReversedArrow );
        
        new_arrow := UniversalMorphismFromDirectSum( honest_category, List( arrow_list, Source ), arrow_list );
        
        new_reversed_arrow := DirectSumFunctorial( honest_category, reversedarrow_list );
        
        return SerreQuotientCategoryBySpansMorphism( cat, new_reversed_arrow, new_arrow );
        
    end );
    
    ## Kernel
    
    AddKernelEmbedding( category,
      
      function( cat, morphism )
        local honest_category, underlying_general, kernel_mor;
        
        honest_category := UnderlyingHonestCategory( cat );
        
        underlying_general := UnderlyingGeneralizedMorphism( morphism );
        
#         underlying_general := NormalizedSpan( underlying_general );
        
        kernel_mor := KernelEmbedding( honest_category, Arrow( underlying_general ) );
        
        return AsSerreQuotientCategoryBySpansMorphism( cat, PreCompose( honest_category, kernel_mor, ReversedArrow( underlying_general ) ) );
        
    end );
    
    AddLiftAlongMonomorphism( category,
      
      function( cat, monomorphism, test_morphism )
        local underlying_generalized_category, inverse_of_mono, composition;
        
        underlying_generalized_category := UnderlyingGeneralizedMorphismCategory( cat );
        
        inverse_of_mono := PseudoInverse( UnderlyingGeneralizedMorphism( monomorphism ) );
        
        composition := PreCompose( underlying_generalized_category, UnderlyingGeneralizedMorphism( test_morphism ), inverse_of_mono );
        
        return SerreQuotientCategoryBySpansMorphism( cat, composition );
        
    end );
    
    ## Cokernel
    
    AddCokernelProjection( category,
      
      function( cat, morphism )
        local honest_category, underlying_general, cokernel_mor;
        
        honest_category := UnderlyingHonestCategory( cat );
        
        underlying_general := UnderlyingGeneralizedMorphism( morphism );
        
#         underlying_general := NormalizedSpan( underlying_general );
        
        cokernel_mor := CokernelProjection( honest_category, Arrow( underlying_general ) );
        
        return AsSerreQuotientCategoryBySpansMorphism( cat, cokernel_mor );
        
    end );
    
    AddColiftAlongEpimorphism( category,
      
      function( cat, epimorphism, test_morphism )
        local underlying_generalized_category, inverse_of_epi, composition;
        
        underlying_generalized_category := UnderlyingGeneralizedMorphismCategory( cat );
        
        inverse_of_epi := PseudoInverse( UnderlyingGeneralizedMorphism( epimorphism ) );
        
        composition := PreCompose( underlying_generalized_category, inverse_of_epi, UnderlyingGeneralizedMorphism( test_morphism ) );
        
        return SerreQuotientCategoryBySpansMorphism( cat, composition );
        
    end );
    
    AddLift( category,
      
      function( cat, test_morphism, monomorphism )
        local honest_category, inverse_of_mono, composition;
        
        honest_category := UnderlyingHonestCategory( cat );
        
        test_morphism := UnderlyingGeneralizedMorphism( test_morphism );
        monomorphism := UnderlyingGeneralizedMorphism( monomorphism );
        
        if not IsHonest( test_morphism ) or not IsHonest( monomorphism ) then
            return fail;
        fi;
        
        test_morphism := HonestRepresentative( test_morphism );
        monomorphism := HonestRepresentative( monomorphism );
        
        composition := Lift( honest_category, test_morphism, monomorphism );
        
        if composition = fail then
            return fail;
        fi;
        
        return AsSerreQuotientCategoryBySpansMorphism( cat, composition );
        
    end );
    
    AddLeftDualOnObjects( category,
      
      function( cat, object )
        
        return AsSerreQuotientCategoryBySpansObject( cat, LeftDualOnObjects( UnderlyingHonestCategory( cat ),
                                                                         UnderlyingHonestObject( object ) ) );
        
    end );
    
    AddLeftDualOnMorphismsWithGivenLeftDuals( category,
      
      function( cat, new_source, morphism, new_range )
        local honest_category, arrow, reversed_arrow, new_arrow, new_reversed_arrow;
        
        honest_category := UnderlyingHonestCategory( cat );
        
        arrow := Arrow( UnderlyingGeneralizedMorphism( morphism ) );
        reversed_arrow := ReversedArrow( UnderlyingGeneralizedMorphism( morphism ) );
        
        arrow := LeftDualOnMorphisms( honest_category, arrow );
        reversed_arrow := LeftDualOnMorphisms( honest_category, reversed_arrow );
        
        new_reversed_arrow := ProjectionInFactorOfFiberProduct( honest_category, [ reversed_arrow, arrow ], 2 );
        new_arrow := ProjectionInFactorOfFiberProduct( honest_category, [ reversed_arrow, arrow ], 1 );
        
        return SerreQuotientCategoryBySpansMorphism( cat, new_reversed_arrow, new_arrow );
        
    end );
    
    AddInverseForMorphisms( category,
      
      function( cat, morphism )
        local underlying_general, inverse;
        
        underlying_general := UnderlyingGeneralizedMorphism( morphism );
        
        inverse := PseudoInverse( underlying_general );
        
        return SerreQuotientCategoryBySpansMorphism( cat, inverse );
        
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
    local serre_category, gen_category, name, preconditions, i;
    
    if not IsFinalized( category ) then
        
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
    
    for i in preconditions do
        
        if not CanCompute( category, i ) then
            
            Error( Concatenation( "category must be able to compute ", i ) );
            return;
            
        fi;
        
    od;
    
    name := Name( category );
    
    name := Concatenation( "The Serre quotient category of ", name, " by ", function_name );
    
    serre_category := CreateCapCategoryWithDataTypes(
                              name,
                              IsSerreQuotientCategory,
                              IsSerreQuotientCategoryBySpansObject,
                              IsSerreQuotientCategoryBySpansMorphism and HasUnderlyingGeneralizedMorphism,
                              IsCapCategoryTwoCell,
                              fail,
                              fail,
                              fail );
    
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
    
    serre_object := CreateCapCategoryObjectWithAttributes( serre_category,
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
    
    serre_morphism := CreateCapCategoryMorphismWithAttributes( serre_category,
                                                               AsSerreQuotientCategoryBySpansObject( serre_category, UnderlyingHonestObject( Source( gen_morphism ) ) ),
                                                               AsSerreQuotientCategoryBySpansObject( serre_category, UnderlyingHonestObject( Range( gen_morphism ) ) ),
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
    
    functor := CapFunctor( Concatenation( "Localization functor of ", Name( category ) ), underlying_honest, category );
    
    AddObjectFunction( functor,
        
        i -> AsSerreQuotientCategoryBySpansObject( category, i ) );
    
    AddMorphismFunction( functor,
      
      function( new_source, morphism, new_range )
        
        return AsSerreQuotientCategoryBySpansMorphism( category, morphism );
        
    end );
    
    return functor;
    
end );
