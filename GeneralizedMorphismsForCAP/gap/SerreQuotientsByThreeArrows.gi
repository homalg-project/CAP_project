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

BindGlobal( "CAP_INTERNAL_INSTALL_OPERATIONS_FOR_SERRE_QUOTIENT_BY_THREE_ARROWS",
  
  function( category )
    local membership_function;
    
    membership_function := SubcategoryMembershipTestFunctionForSerreQuotient( category );
    
    ## Equalities
    
    AddIsCongruentForMorphisms( category,
      
      function( morphism1, morphism2 )
        local underlying_general, new_morphism_aid, new_general, sum_general,
              sum_associated, sum_image;
        
        underlying_general := UnderlyingGeneralizedMorphism( morphism2 );
        
        new_morphism_aid := AdditiveInverse( Arrow( underlying_general ) );
        
        new_general := GeneralizedMorphismByThreeArrows( SourceAid( underlying_general ), new_morphism_aid, RangeAid( underlying_general ) );
        
        sum_general := AdditionForMorphisms( UnderlyingGeneralizedMorphism( morphism1 ), new_general );
        
        sum_associated := AssociatedMorphism( sum_general );
        
        sum_image := ImageObject( sum_associated );
        
        return membership_function( sum_image );
        
    end );
    
    AddIsEqualForObjects( category,
      
      function( obj1, obj2 )
        
        return IsEqualForObjects( UnderlyingHonestObject( obj1 ), UnderlyingHonestObject( obj2 ) );
        
    end );
    
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
        
        return SerreQuotientCategoryByThreeArrowsMorphism( category, composition );
        
    end );
    
    ## IdentityMorphism
    
    AddIdentityMorphism( category,
      
      function( object )
        
        return AsSerreQuotientCategoryByThreeArrowsMorphism( category, IdentityMorphism( UnderlyingHonestObject( object ) ) );
        
    end );
    
    ## Addition for morphisms
    
    AddAdditionForMorphisms( category,
      
      function( morphism1, morphism2 )
        local sum;
        
        sum := AdditionForMorphisms( UnderlyingGeneralizedMorphism( morphism1 ),
                                     UnderlyingGeneralizedMorphism( morphism2 ) );
        
        return SerreQuotientCategoryByThreeArrowsMorphism( category, sum );
        
    end );
    
    ## IsZeroForMorphisms
    
    AddIsZeroForMorphisms( category,
      
      function( morphism )
        local associated, image;
        
        associated := AssociatedMorphism( UnderlyingGeneralizedMorphism( morphism ) );
        
        image := ImageObject( associated );
        
        return membership_function( image );
        
    end );
    
    ## Additive inverse for morphisms (works without normalization)
    
    AddAdditiveInverseForMorphisms( category,
      
      function( morphism )
        local underlying_general, new_morphism_aid, new_general;
        
        underlying_general := UnderlyingGeneralizedMorphism( morphism );
        
        new_morphism_aid := AdditiveInverse( Arrow( underlying_general ) );
        
        new_general := GeneralizedMorphismByThreeArrows( SourceAid( underlying_general ), new_morphism_aid, RangeAid( underlying_general ) );
        
        return SerreQuotientCategoryByThreeArrowsMorphism( category, new_general );
        
    end );
    
    ## Zero morphism
    
    AddZeroMorphism( category,
      
      function( source, range )
        local source_aid, range_aid, morphism_aid;
        
        source := UnderlyingHonestObject( source );
        
        range := UnderlyingHonestObject( range );
        
        source_aid := IdentityMorphism( source );
        
        range_aid := IdentityMorphism( range );
        
        morphism_aid := ZeroMorphism( source, range );
        
        return SerreQuotientCategoryByThreeArrowsMorphism( category, source_aid, morphism_aid, range_aid );
        
    end );
    
    ## Zero object
    
    AddZeroObject( category,
      
      function( )
        local generalized_zero;
        
        generalized_zero := ZeroObject( UnderlyingHonestCategory( category ) );
        
        return AsSerreQuotientCategoryByThreeArrowsObject( category, generalized_zero );
        
    end );
    
    ## direct sum
    
    AddDirectSum( category,
      
      function( obj_list )
        local honest_list, honest_sum;
        
        honest_list := List( obj_list, UnderlyingHonestObject );
        
        honest_sum := CallFuncList( DirectSum, honest_list );
        
        return AsSerreQuotientCategoryByThreeArrowsObject( category, honest_sum );
        
    end );
    
    AddProjectionInFactorOfDirectSumWithGivenDirectSum( category,
      
      function( product_object, component_number, direct_sum_object )
        local underlying_objects, underlying_direct_sum, honest_projection;
        
        underlying_objects := List( product_object, UnderlyingHonestObject );
        
        underlying_direct_sum := UnderlyingHonestObject( direct_sum_object );
        
        honest_projection := ProjectionInFactorOfDirectSumWithGivenDirectSum( underlying_objects, component_number, underlying_direct_sum );
        
        return AsSerreQuotientCategoryByThreeArrowsMorphism( category, honest_projection );
        
    end );
    
    AddInjectionOfCofactorOfDirectSumWithGivenDirectSum( category,
      
      function( object_product_list, injection_number, direct_sum_object )
        local underlying_objects, underlying_direct_sum, honest_injection;
        
        underlying_objects := List( object_product_list, UnderlyingHonestObject );
        
        underlying_direct_sum := UnderlyingHonestObject( direct_sum_object );
        
        honest_injection := InjectionOfCofactorOfDirectSumWithGivenDirectSum( underlying_objects, injection_number, underlying_direct_sum );
        
        return AsSerreQuotientCategoryByThreeArrowsMorphism( category, honest_injection );
        
    end );
    
    AddUniversalMorphismIntoDirectSum( category,
      
      function( diagram, morphism_list )
        local generalized_morphisms, source_aid, associated, range_aid, associated_list;
        
        generalized_morphisms := List( morphism_list, UnderlyingGeneralizedMorphism );
        
        generalized_morphisms := CommonRestriction( generalized_morphisms );
        
        generalized_morphisms := List( generalized_morphisms, DomainAssociatedMorphismCodomainTriple );
        
        source_aid := generalized_morphisms[ 1 ][ 1 ];
        
        associated_list := List( generalized_morphisms, i -> i[ 2 ] );
        
        associated := UniversalMorphismIntoDirectSum( associated_list );
        
        range_aid := DirectSumFunctorial( List( generalized_morphisms, i -> i[ 3 ] ) );
        
        return SerreQuotientCategoryByThreeArrowsMorphism( category, source_aid, associated, range_aid );
        
    end );
    
    AddUniversalMorphismFromDirectSum( category,
      
      function( diagram, morphism_list )
        local generalized_morphisms, source_aid, associated, range_aid;
        
        generalized_morphisms := List( morphism_list, UnderlyingGeneralizedMorphism );
        
        generalized_morphisms := CommonCoastriction( generalized_morphisms );
        
        generalized_morphisms := List( generalized_morphisms, DomainAssociatedMorphismCodomainTriple );
        
        range_aid := generalized_morphisms[ 1 ][ 3 ];
        
        associated := UniversalMorphismFromDirectSum( List( generalized_morphisms, i -> i[ 2 ] ) );
        
        source_aid := DirectSumFunctorial( List( generalized_morphisms, i -> i[ 1 ] ) );
        
        return SerreQuotientCategoryByThreeArrowsMorphism( category, source_aid, associated, range_aid );
        
    end );
    
    ## Kernel
    
    AddKernelEmbedding( category,
      
      function( morphism )
        local underlying_general, kernel_mor;
        
        underlying_general := UnderlyingGeneralizedMorphism( morphism );
        
        kernel_mor := KernelEmbedding( AssociatedMorphism( underlying_general ) );
        
        kernel_mor := PreCompose( kernel_mor, DomainEmbedding( underlying_general ) );
        
        return AsSerreQuotientCategoryByThreeArrowsMorphism( category, kernel_mor );
        
    end );
    
    AddLiftAlongMonomorphism( category,
      
      function( monomorphism, test_morphism )
        local inverse_of_mono, composition;
        
        inverse_of_mono := PseudoInverse( UnderlyingGeneralizedMorphism( monomorphism ) );
        
        composition := PreCompose( UnderlyingGeneralizedMorphism( test_morphism ), inverse_of_mono );
        
        return SerreQuotientCategoryByThreeArrowsMorphism( category, composition );
        
    end );
    
    ## Cokernel
    
    AddCokernelProjection( category,
      
      function( morphism )
        local underlying_general, cokernel_mor;
        
        underlying_general := UnderlyingGeneralizedMorphism( morphism );
        
        cokernel_mor := CokernelProjection( AssociatedMorphism( underlying_general ) );
        
        cokernel_mor := PreCompose( CodomainProjection( underlying_general ), cokernel_mor );
        
        return AsSerreQuotientCategoryByThreeArrowsMorphism( category, cokernel_mor );
        
    end );
    
    AddColiftAlongEpimorphism( category,
      
      function( epimorphism, test_morphism )
        local inverse_of_epi, composition;
        
        inverse_of_epi := PseudoInverse( UnderlyingGeneralizedMorphism( epimorphism ) );
        
        composition := PreCompose( inverse_of_epi, UnderlyingGeneralizedMorphism( test_morphism ) );
        
        return SerreQuotientCategoryByThreeArrowsMorphism( category, composition );
        
    end );
    
end );

#############################################
##
## Constructor
##
#############################################

InstallMethod( SerreQuotientCategoryByThreeArrows,
               [ IsCapCategory, IsFunction ],
               
  function( category, test_function )
    local name;
    
    name := NameFunction( test_function );
    
    return SerreQuotientCategoryByThreeArrows( category, test_function, Concatenation( "test function with name: ", name ) );
    
end );

InstallMethodWithCacheFromObject( SerreQuotientCategoryByThreeArrows,
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
    
    SetFilterObj( serre_category, IsSerreQuotientCategory );
    
    AddObjectRepresentation( serre_category, IsSerreQuotientCategoryByThreeArrowsObject );
    
    AddMorphismRepresentation( serre_category, IsSerreQuotientCategoryByThreeArrowsMorphism and HasUnderlyingGeneralizedMorphism );
    
    serre_category!.predicate_logic := category!.predicate_logic;
    
    SetFilterObj( serre_category, WasCreatedAsSerreQuotientCategoryByThreeArrows );
    
    SetUnderlyingHonestCategory( serre_category, category );
    
    SetUnderlyingGeneralizedMorphismCategory( serre_category, GeneralizedMorphismCategoryByThreeArrows( category ) );
    
    SetSubcategoryMembershipTestFunctionForSerreQuotient( serre_category, test_function );
    
    SetIsAbelianCategory( serre_category, true );
    
    CAP_INTERNAL_INSTALL_OPERATIONS_FOR_SERRE_QUOTIENT_BY_THREE_ARROWS( serre_category );
    
    CAP_INTERNAL_INSTALL_OPERATIONS_FOR_SERRE_QUOTIENT( serre_category );
    
    Finalize( serre_category );
    
    return serre_category;
    
end );

InstallMethodWithCacheFromObject( AsSerreQuotientCategoryByThreeArrowsObject,
                                  [ IsCapCategory and WasCreatedAsSerreQuotientCategoryByThreeArrows, IsCapCategoryObject ],
                                  
  function( serre_category, object )
    local honest_category, serre_object;
    
    honest_category := UnderlyingHonestCategory( serre_category );
    
    if not IsIdenticalObj( honest_category, CapCategory( object ) ) then
        
        Error( "object does not belong to underlying honest category of serre quotient" );
        
    fi;
    
    serre_object := ObjectifyObjectForCAPWithAttributes( rec( ), serre_category,
                                                         UnderlyingHonestObject, object,
                                                         UnderlyingGeneralizedObject, GeneralizedMorphismByThreeArrowsObject( object ) );
    
    if HasSpecializedObjectFilterForSerreQuotients( serre_category ) then
        
        SetFilterObj( serre_object, SpecializedObjectFilterForSerreQuotients( serre_category ) );
        
    fi;
    
    return serre_object;
    
end );

InstallMethodWithCacheFromObject( SerreQuotientCategoryByThreeArrowsMorphism,
                                  [ IsCapCategory and WasCreatedAsSerreQuotientCategoryByThreeArrows, IsGeneralizedMorphismByThreeArrows ],
                                  
  function( serre_category, gen_morphism )
    local honest_category, serre_morphism;
    
    if not IsIdenticalObj( UnderlyingGeneralizedMorphismCategory( serre_category ), CapCategory( gen_morphism ) ) then
        
        Error( "generalized morphism has wrong category" );
        
    fi;
    
    serre_morphism := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec( ), serre_category,
                             AsSerreQuotientCategoryByThreeArrowsObject( serre_category, UnderlyingHonestObject( Source( gen_morphism ) ) ),
                             AsSerreQuotientCategoryByThreeArrowsObject( serre_category, UnderlyingHonestObject( Range( gen_morphism ) ) ),
                             UnderlyingGeneralizedMorphism, gen_morphism );
    
    if HasSpecializedMorphismFilterForSerreQuotients( serre_category ) then
        
        SetFilterObj( serre_morphism, SpecializedMorphismFilterForSerreQuotients( serre_category ) );
        
    fi;
    
    return serre_morphism;
    
end );

InstallMethod( SerreQuotientCategoryMorphism,
               [ IsCapCategory and WasCreatedAsSerreQuotientCategoryByThreeArrows, IsGeneralizedMorphismByThreeArrows ],
               
  SerreQuotientCategoryByThreeArrowsMorphism );

InstallMethod( SerreQuotientCategoryByThreeArrowsMorphism,
               [ IsCapCategory and WasCreatedAsSerreQuotientCategoryByThreeArrows, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ],
                                  
  function( serre_category, source_aid, associated, range_aid )
    
    return SerreQuotientCategoryByThreeArrowsMorphism( serre_category, GeneralizedMorphismByThreeArrows( source_aid, associated, range_aid ) );
    
end );

InstallMethod( SerreQuotientCategoryByThreeArrowsMorphismWithSourceAid,
               [ IsCapCategory and WasCreatedAsSerreQuotientCategoryByThreeArrows, IsCapCategoryMorphism, IsCapCategoryMorphism ],
                                  
  function( serre_category, source_aid, associated )
    
    return SerreQuotientCategoryByThreeArrowsMorphism( serre_category, GeneralizedMorphismByThreeArrowsWithSourceAid( source_aid, associated ) );
    
end );

InstallMethod( SerreQuotientCategoryByThreeArrowsMorphismWithRangeAid,
               [ IsCapCategory and WasCreatedAsSerreQuotientCategoryByThreeArrows, IsCapCategoryMorphism, IsCapCategoryMorphism ],
                                  
  function( serre_category, associated, range_aid )
    
    return SerreQuotientCategoryByThreeArrowsMorphism( serre_category, GeneralizedMorphismByThreeArrowsWithRangeAid( associated, range_aid ) );
    
end );

InstallMethodWithCacheFromObject( AsSerreQuotientCategoryByThreeArrowsMorphism,
                                  [ IsCapCategory and WasCreatedAsSerreQuotientCategoryByThreeArrows, IsCapCategoryMorphism ],
                                  
  function( serre_category, associated )
    
    return SerreQuotientCategoryByThreeArrowsMorphism( serre_category, AsGeneralizedMorphismByThreeArrows( associated ) );
    
end );

#############################################
##
## Compatibility layer
##
#############################################

InstallMethod( AsSerreQuotientCategoryObject,
               [ IsCapCategory and WasCreatedAsSerreQuotientCategoryByThreeArrows, IsCapCategoryObject ],
               
  AsSerreQuotientCategoryByThreeArrowsObject );

InstallMethod( AsSerreQuotientCategoryMorphism,
               [ IsCapCategory and WasCreatedAsSerreQuotientCategoryByThreeArrows, IsCapCategoryMorphism ],
                                  
  AsSerreQuotientCategoryByThreeArrowsMorphism );

InstallMethod( SerreQuotientCategoryMorphism,
               [ IsCapCategory and WasCreatedAsSerreQuotientCategoryByThreeArrows, IsGeneralizedMorphismByThreeArrows ],
               
  SerreQuotientCategoryByThreeArrowsMorphism );

InstallMethod( SerreQuotientCategoryMorphism,
               [ IsCapCategory and WasCreatedAsSerreQuotientCategoryByThreeArrows, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ],
                                  
  SerreQuotientCategoryByThreeArrowsMorphism );

InstallMethod( SerreQuotientCategoryMorphismWithRangeAid,
               [ IsCapCategory and WasCreatedAsSerreQuotientCategoryByThreeArrows, IsCapCategoryMorphism, IsCapCategoryMorphism ],
                                  
  SerreQuotientCategoryByThreeArrowsMorphismWithRangeAid );

InstallMethod( SerreQuotientCategoryMorphismWithSourceAid,
               [ IsCapCategory and WasCreatedAsSerreQuotientCategoryByThreeArrows, IsCapCategoryMorphism, IsCapCategoryMorphism ],
                                  
  SerreQuotientCategoryByThreeArrowsMorphismWithSourceAid );

#############################################
##
## Functor
##
#############################################

InstallMethod( CanonicalProjection,
               [ IsCapCategory and WasCreatedAsSerreQuotientCategoryByThreeArrows ],
               
  function( category )
    local underlying_honest, functor;
    
    underlying_honest := UnderlyingHonestCategory( category );
    
    functor := CapFunctor( Concatenation( "Localization functor of ", Name( category ) ), underlying_honest, category );
    
    AddObjectFunction( functor,
        
        i -> AsSerreQuotientCategoryByThreeArrowsObject( category, i ) );
    
    AddMorphismFunction( functor,
      
      function( new_source, morphism, new_range )
        
        return AsSerreQuotientCategoryByThreeArrowsMorphism( category, morphism );
        
    end );
    
    return functor;
    
end );
