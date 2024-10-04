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

BindGlobal( "CAP_INTERNAL_INSTALL_OPERATIONS_FOR_SERRE_QUOTIENT_BY_COSPANS",
  
  function( category )
    local membership_function;
    
    membership_function := SubcategoryMembershipTestFunctionForSerreQuotient( category );
    
    ## Equalities
    
    AddIsCongruentForMorphisms( category,
      
      function( cat, morphism1, morphism2 )
        local underlying_generalized_category, underlying_general, new_morphism_aid, new_general, sum_general,
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
        
        return SerreQuotientCategoryByCospansMorphism( cat, composition );
        
    end );
    
    ## IdentityMorphism
    
    AddIdentityMorphism( category,
      
      function( cat, object )
        
        return AsSerreQuotientCategoryByCospansMorphism( cat,
                                                         IdentityMorphism( UnderlyingHonestCategory( cat ),
                                                         UnderlyingHonestObject( object ) ) );
        
    end );
    
    ## Addition for morphisms
    
    AddAdditionForMorphisms( category,
      
      function( cat, morphism1, morphism2 )
        local underlying_generalized_category, sum;
        
        underlying_generalized_category := UnderlyingGeneralizedMorphismCategory( cat );
        
        sum := AdditionForMorphisms( underlying_generalized_category,
                                     UnderlyingGeneralizedMorphism( morphism1 ),
                                     UnderlyingGeneralizedMorphism( morphism2 ) );
        
        return SerreQuotientCategoryByCospansMorphism( cat, sum );
        
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
        local underlying_generalized_category, new_general;
        
        underlying_generalized_category := UnderlyingGeneralizedMorphismCategory( cat );
        
        new_general := AdditiveInverseForMorphisms( underlying_generalized_category, UnderlyingGeneralizedMorphism( morphism ) );
        
        return SerreQuotientCategoryByCospansMorphism( cat, new_general );
        
    end );
    
    ## Zero morphism
    
    AddZeroMorphism( category,
      
      function( cat, source, range )
        local underlying_generalized_category, new_general;
        
        underlying_generalized_category := UnderlyingGeneralizedMorphismCategory( cat );
        
        new_general := ZeroMorphism( underlying_generalized_category,
                                     UnderlyingGeneralizedObject( source ),
                                     UnderlyingGeneralizedObject( range ) );
        
        return SerreQuotientCategoryByCospansMorphism( cat, new_general );
        
    end );
    
    ## Zero object
    
    AddZeroObject( category,
      
      function( cat )
        local generalized_zero;
        
        generalized_zero := ZeroObject( UnderlyingHonestCategory( cat ) );
        
        return AsSerreQuotientCategoryByCospansObject( cat, generalized_zero );
        
    end );
    
    ## direct sum
    
    AddDirectSum( category,
      
      function( cat, obj_list )
        local honest_category, honest_list, honest_sum;
        
        honest_category := UnderlyingHonestCategory( cat );
        
        honest_list := List( obj_list, UnderlyingHonestObject );
        
        honest_sum := DirectSum( cat, honest_list );
        
        return AsSerreQuotientCategoryByCospansObject( cat, honest_sum );
        
    end );
    
    AddProjectionInFactorOfDirectSumWithGivenDirectSum( category,
      
      function( cat, product_object, component_number, direct_sum_object )
        local honest_category, underlying_objects, underlying_direct_sum, honest_projection;
        
        honest_category := UnderlyingHonestCategory( cat );
        
        underlying_objects := List( product_object, UnderlyingHonestObject );
        
        underlying_direct_sum := UnderlyingHonestObject( direct_sum_object );
        
        honest_projection := ProjectionInFactorOfDirectSumWithGivenDirectSum( honest_category,
                                                                              underlying_objects,
                                                                              component_number,
                                                                              underlying_direct_sum );
        
        return AsSerreQuotientCategoryByCospansMorphism( cat, honest_projection );
        
    end );
    
    AddInjectionOfCofactorOfDirectSumWithGivenDirectSum( category,
      
      function( cat, object_product_list, injection_number, direct_sum_object )
        local honest_category, underlying_objects, underlying_direct_sum, honest_injection;
        
        honest_category := UnderlyingHonestCategory( cat );
        
        underlying_objects := List( object_product_list, UnderlyingHonestObject );
        
        underlying_direct_sum := UnderlyingHonestObject( direct_sum_object );
        
        honest_injection := AddInjectionOfCofactorOfDirectSumWithGivenDirectSum( honest_category,
                                                                                 underlying_objects,
                                                                                 injection_number,
                                                                                 underlying_direct_sum );
        
        return AsSerreQuotientCategoryByCospansMorphism( cat, honest_injection );
        
    end );
    
    AddUniversalMorphismIntoDirectSum( category,
      
      function( cat, diagram, test_object, morphism_list )
        local honest_category, generalized_list, arrow_list, reversedarrow_list, new_arrow, new_reversed_arrow, object_list;
        
        honest_category := UnderlyingHonestCategory( cat );
        
        generalized_list := List( morphism_list, UnderlyingGeneralizedMorphism );
        
        arrow_list := List( generalized_list, Arrow );
        
        new_arrow := UniversalMorphismIntoDirectSum( honest_category, List( arrow_list, Range ), arrow_list );
        
        reversedarrow_list := List( generalized_list, ReversedArrow );
        
        new_reversed_arrow := DirectSumFunctorial( honest_category, reversedarrow_list );
        
        return SerreQuotientCategoryByCospansMorphism( cat, new_arrow, new_reversed_arrow );
        
    end );
    
    ## Needs work
    AddUniversalMorphismFromDirectSum( category,
      
      function( cat, diagram, test_object, morphism_list )
        local honest_category, generalized_list, arrow_list, reversedarrow_list, new_arrow, new_reversed_arrow, object_list;
        
        honest_category := UnderlyingHonestCategory( cat );
        
        generalized_list := List( morphism_list, UnderlyingGeneralizedMorphism );
        
        generalized_list := CommonCoastriction( generalized_list );
        
        arrow_list := List( generalized_list, Arrow );
        
        new_arrow := UniversalMorphismFromDirectSum( honest_category, List( diagram, UnderlyingHonestObject ), arrow_list );
        
        new_reversed_arrow := ReversedArrow( generalized_list[ 1 ] );
        
        return SerreQuotientCategoryByCospansMorphism( cat, new_arrow, new_reversed_arrow );
        
    end );
    
    ## Kernel
    
    AddKernelEmbedding( category,
      
      function( cat, morphism )
        local honest_category, underlying_general, kernel_mor;
        
        honest_category := UnderlyingHonestCategory( cat );
        
        underlying_general := UnderlyingGeneralizedMorphism( morphism );
        
        kernel_mor := KernelEmbedding( honest_category, Arrow( underlying_general ) );
        
        return AsSerreQuotientCategoryByCospansMorphism( cat, kernel_mor );
        
    end );
    
    AddLiftAlongMonomorphism( category,
      
      function( cat, monomorphism, test_morphism )
        local underlying_generalized_category, inverse_of_mono, composition;
        
        underlying_generalized_category := UnderlyingGeneralizedMorphismCategory( cat );
        
        inverse_of_mono := PseudoInverse( UnderlyingGeneralizedMorphism( monomorphism ) );
        
        composition := PreCompose( underlying_generalized_category, UnderlyingGeneralizedMorphism( test_morphism ), inverse_of_mono );
        
        return SerreQuotientCategoryByCospansMorphism( cat, composition );
        
    end );
    
    ## Cokernel
    
    AddCokernelProjection( category,
      
      function( cat, morphism )
        local honest_category, underlying_general, cokernel_mor, triple;
        
        honest_category := UnderlyingHonestCategory( cat );
        
        underlying_general := UnderlyingGeneralizedMorphism( morphism );
        
        triple := DomainAssociatedMorphismCodomainTriple( underlying_general );
        
        cokernel_mor := CokernelProjection( honest_category, triple[ 2 ] );
        
        return AsSerreQuotientCategoryByCospansMorphism( cat, PreCompose( honest_category, triple[ 3 ], cokernel_mor ) );
        
    end );
    
    AddColiftAlongEpimorphism( category,
      
      function( cat, epimorphism, test_morphism )
        local underlying_generalized_category, inverse_of_epi, composition;
        
        underlying_generalized_category := UnderlyingGeneralizedMorphismCategory( cat );
        
        inverse_of_epi := PseudoInverse( UnderlyingGeneralizedMorphism( epimorphism ) );
        
        composition := PreCompose( underlying_generalized_category, inverse_of_epi, UnderlyingGeneralizedMorphism( test_morphism ) );
        
        return SerreQuotientCategoryByCospansMorphism( cat, composition );
        
    end );
    
end );

#############################################
##
## Constructor
##
#############################################

InstallMethod( SerreQuotientCategoryByCospans,
               [ IsCapCategory, IsFunction ],
               
  function( category, test_function )
    local name;
    
    name := NameFunction( test_function );
    
    return SerreQuotientCategoryByCospans( category, test_function, Concatenation( "test function with name: ", name ) );
    
end );

InstallMethodWithCacheFromObject( SerreQuotientCategoryByCospans,
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
                              IsSerreQuotientCategoryByCospansObject,
                              IsSerreQuotientCategoryByCospansMorphism and HasUnderlyingGeneralizedMorphism,
                              IsCapCategoryTwoCell,
                              fail,
                              fail,
                              fail );
    
    serre_category!.predicate_logic := category!.predicate_logic;
    
    SetFilterObj( serre_category, WasCreatedAsSerreQuotientCategoryByCospans );
    
    SetUnderlyingHonestCategory( serre_category, category );
    
    SetUnderlyingGeneralizedMorphismCategory( serre_category, GeneralizedMorphismCategoryByCospans( category ) );
    
    SetSubcategoryMembershipTestFunctionForSerreQuotient( serre_category, test_function );
    
    SetIsAbelianCategory( serre_category, true );
    
    CAP_INTERNAL_INSTALL_OPERATIONS_FOR_SERRE_QUOTIENT_BY_COSPANS( serre_category );
    
    CAP_INTERNAL_INSTALL_OPERATIONS_FOR_SERRE_QUOTIENT( serre_category );
    
    Finalize( serre_category );
    
    return serre_category;
    
end );

InstallMethodWithCacheFromObject( AsSerreQuotientCategoryByCospansObject,
                                  [ IsCapCategory and WasCreatedAsSerreQuotientCategoryByCospans, IsCapCategoryObject ],
                                  
  function( serre_category, object )
    local honest_category, serre_object;
    
    honest_category := UnderlyingHonestCategory( serre_category );
    
    if not IsIdenticalObj( honest_category, CapCategory( object ) ) then
        
        Error( "object does not belong to underlying honest category of serre quotient" );
        
    fi;
    
    serre_object := CreateCapCategoryObjectWithAttributes( serre_category,
                                                           UnderlyingHonestObject, object,
                                                           UnderlyingGeneralizedObject, GeneralizedMorphismByCospansObject( object ) );
    
    if HasSpecializedObjectFilterForSerreQuotients( serre_category ) then
        
        SetFilterObj( serre_object, SpecializedObjectFilterForSerreQuotients( serre_category ) );
        
    fi;
    
    return serre_object;
    
end );

InstallMethodWithCacheFromObject( SerreQuotientCategoryByCospansMorphism,
                                  [ IsCapCategory and WasCreatedAsSerreQuotientCategoryByCospans, IsGeneralizedMorphismByCospan ],
                                  
  function( serre_category, gen_morphism )
    local honest_category, serre_morphism;
    
    if not IsIdenticalObj( UnderlyingGeneralizedMorphismCategory( serre_category ), CapCategory( gen_morphism ) ) then
        
        Error( "generalized morphism has wrong category" );
        
    fi;
    
    serre_morphism := CreateCapCategoryMorphismWithAttributes( serre_category,
                                                               AsSerreQuotientCategoryByCospansObject( serre_category, UnderlyingHonestObject( Source( gen_morphism ) ) ),
                                                               AsSerreQuotientCategoryByCospansObject( serre_category, UnderlyingHonestObject( Range( gen_morphism ) ) ),
                                                               UnderlyingGeneralizedMorphism, gen_morphism );
    
    if HasSpecializedMorphismFilterForSerreQuotients( serre_category ) then
        
        SetFilterObj( serre_morphism, SpecializedMorphismFilterForSerreQuotients( serre_category ) );
        
    fi;
    
    return serre_morphism;
    
end );

InstallMethod( SerreQuotientCategoryByCospansMorphism,
               [ IsCapCategory and WasCreatedAsSerreQuotientCategoryByCospans, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ],
                                  
  function( serre_category, source_aid, associated, range_aid )
    
    return SerreQuotientCategoryByCospansMorphism( serre_category, GeneralizedMorphismByCospan( source_aid, associated, range_aid ) );
    
end );

InstallMethod( SerreQuotientCategoryByCospansMorphismWithSourceAid,
               [ IsCapCategory and WasCreatedAsSerreQuotientCategoryByCospans, IsCapCategoryMorphism, IsCapCategoryMorphism ],
                                  
  function( serre_category, source_aid, associated )
    
    return SerreQuotientCategoryByCospansMorphism( serre_category, GeneralizedMorphismByCospanWithSourceAid( source_aid, associated ) );
    
end );

InstallMethod( SerreQuotientCategoryByCospansMorphism,
               [ IsCapCategory and WasCreatedAsSerreQuotientCategoryByCospans, IsCapCategoryMorphism, IsCapCategoryMorphism ],
                                  
  function( serre_category, reversed_arrow, arrow )
    
    return SerreQuotientCategoryByCospansMorphism( serre_category, GeneralizedMorphismByCospan( reversed_arrow, arrow ) );
    
end );

InstallMethodWithCacheFromObject( AsSerreQuotientCategoryByCospansMorphism,
                                  [ IsCapCategory and WasCreatedAsSerreQuotientCategoryByCospans, IsCapCategoryMorphism ],
                                  
  function( serre_category, associated )
    
    return SerreQuotientCategoryByCospansMorphism( serre_category, AsGeneralizedMorphismByCospan( associated ) );
    
end );

#############################################
##
## Compatibility layer
##
#############################################

InstallMethod( AsSerreQuotientCategoryObject,
               [ IsCapCategory and WasCreatedAsSerreQuotientCategoryByCospans, IsCapCategoryObject ],
               
  AsSerreQuotientCategoryByCospansObject );

InstallMethod( AsSerreQuotientCategoryMorphism,
               [ IsCapCategory and WasCreatedAsSerreQuotientCategoryByCospans, IsCapCategoryMorphism ],
                                  
  AsSerreQuotientCategoryByCospansMorphism );

InstallMethod( SerreQuotientCategoryMorphism,
               [ IsCapCategory and WasCreatedAsSerreQuotientCategoryByCospans, IsGeneralizedMorphismByCospan ],
               
  SerreQuotientCategoryByCospansMorphism );

InstallMethod( SerreQuotientCategoryMorphism,
               [ IsCapCategory and WasCreatedAsSerreQuotientCategoryByCospans, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ],
                                  
  SerreQuotientCategoryByCospansMorphism );

InstallMethod( SerreQuotientCategoryMorphism,
               [ IsCapCategory and WasCreatedAsSerreQuotientCategoryByCospans, IsCapCategoryMorphism, IsCapCategoryMorphism ],
                                  
  SerreQuotientCategoryByCospansMorphism );

InstallMethod( SerreQuotientCategoryMorphismWithRangeAid,
               [ IsCapCategory and WasCreatedAsSerreQuotientCategoryByCospans, IsCapCategoryMorphism, IsCapCategoryMorphism ],
                                  
  SerreQuotientCategoryByCospansMorphism );

InstallMethod( SerreQuotientCategoryMorphismWithSourceAid,
               [ IsCapCategory and WasCreatedAsSerreQuotientCategoryByCospans, IsCapCategoryMorphism, IsCapCategoryMorphism ],
                                  
  SerreQuotientCategoryByCospansMorphismWithSourceAid );

#############################################
##
## Functor
##
#############################################

InstallMethod( CanonicalProjection,
               [ IsCapCategory and WasCreatedAsSerreQuotientCategoryByCospans ],
               
  function( category )
    local underlying_honest, functor;
    
    underlying_honest := UnderlyingHonestCategory( category );
    
    functor := CapFunctor( Concatenation( "Localization functor of ", Name( category ) ), underlying_honest, category );
    
    AddObjectFunction( functor,
        
        i -> AsSerreQuotientCategoryByCospansObject( category, i ) );
    
    AddMorphismFunction( functor,
      
      function( new_source, morphism, new_range )
        
        return AsSerreQuotientCategoryByCospansMorphism( category, morphism );
        
    end );
    
    return functor;
    
end );
