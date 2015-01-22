#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2013, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#############################################################################

######################################
##
## Reps, types, stuff.
##
######################################

DeclareRepresentation( "IsCapCategoryMorphismRep",
                       IsAttributeStoringRep and IsCapCategoryMorphism,
                       [ ] );

BindGlobal( "TheFamilyOfCapCategoryMorphisms",
        NewFamily( "TheFamilyOfCapCategoryMorphisms" ) );

BindGlobal( "TheTypeOfCapCategoryMorphisms",
        NewType( TheFamilyOfCapCategoryMorphisms,
                IsCapCategoryMorphismRep ) );

######################################
##
## Properties logic
##
######################################
# 
# InstallTrueMethod( IsSplitMonomorphism and IsSplitEpimorphism, IsCapCategoryMorphism and IsIsomorphism );
# 
# InstallTrueMethod( IsAutomorphism, IsCapCategoryMorphism and IsOne );
# 
# InstallTrueMethod( IsIsomorphism and IsEndomorphism, IsCapCategoryMorphism and IsAutomorphism );
# 
# InstallTrueMethod( IsMonomorphism, IsCapCategoryMorphism and IsSplitMonomorphism );
# 
# InstallTrueMethod( IsEpimorphism, IsCapCategoryMorphism and IsSplitEpimorphism );
# 
# InstallTrueMethod( IsIsomorphism, IsMonomorphism and IsEpimorphism and IsAbelianCategory );#TODO: weaker?

#######################################
##
## Technical implications
##
#######################################

InstallGlobalFunction( INSTALL_TODO_LIST_ENTRIES_FOR_MORPHISM,

  function( category, morphism )
    local entry;
    
    entry := ToDoListEntryToMaintainFollowingAttributes( [ [ morphism, "CapCategory" ] ],
                                                         [ category, morphism ],
                                                         CATEGORIES_FOR_HOMALG_CAN_COMPUTE_FILTER_LIST
                                                          );
    
    AddToToDoList( entry );
    
    if IsBound( category!.PROPAGATE_FILTERS_FROM_CATEGORY_TO_MORPHISM ) then
        
        entry := ToDoListEntryToMaintainFollowingAttributes( [ [ morphism, "CapCategory" ] ],
                                                             [ category, morphism ],
                                                             category!.PROPAGATE_FILTERS_FROM_CATEGORY_TO_MORPHISM
                                                              );
        
        AddToToDoList( entry );
        
    fi;
    
    ##Well defined
    
    entry := ToDoListEntry( [ [ morphism, "IsWellDefined", true ] ],
                            [ Source, morphism ], "IsWellDefined", true );
    
    AddToToDoList( entry );
    
    entry := ToDoListEntry( [ [ morphism, "IsWellDefined", true ] ],
                            [ Range, morphism ], "IsWellDefined", true );
    
    AddToToDoList( entry );
    
end );

InstallValue( PROPAGATION_LIST_FOR_EQUAL_MORPHISMS,
              [  
                 "IsMonomorphism",
                 "IsEpimorphism",
                 "IsIsomorphism",
                 "IsEndomorphism",
                 "IsAutomorphism",
                 "IsSplitMonomorphism",
                 "IsSplitEpimorphism",
                 "IsOne",
                 "IsIdempotent",
                 # ..
              ] );

######################################
##
## Subobjects and factorobjects
##
######################################

##
InstallMethod( AddIsMonomorphism,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    SetCanComputeIsMonomorphism( category, true );
    
    SetIsMonomorphismFunction( category, func );
    
    InstallMethod( IsMonomorphism,
                   [ IsCapCategoryMorphism and MorphismFilter( category ) ],
                   
      function( morphism )
        
        return func( morphism );
        
    end );
      
end );

##
InstallTrueMethod( CanComputeIsMonomorphism, CanComputeKernel and CanComputeIsZeroForObjects and IsAdditiveCategory );

InstallMethod( IsMonomorphism,
               [ IsCapCategoryMorphism and CanComputeKernel and CanComputeIsZeroForObjects and IsAdditiveCategory ],
               -9900, #FIXME
               
  function( morphism )
    
    return IsZero( KernelObject( morphism ) );
    
end );

##
InstallTrueMethod( CanComputeIsMonomorphism, 
                   CanComputeIsIsomorphism
                   and CanComputeIdentityMorphism
                   and CanComputeProjectionInFactorOfPullback
                   and CanComputePreCompose
                   and CanComputeUniversalMorphismIntoPullback );

InstallMethod( IsMonomorphism,
               [ IsCapCategoryMorphism
                 and CanComputeIsIsomorphism
                 and CanComputeIdentityMorphism
                 and CanComputeProjectionInFactorOfPullback
                 and CanComputePreCompose
                 and CanComputeUniversalMorphismIntoPullback ],
                 -9999, #FIXME
                 
  function( morphism )
    local pullback_diagram, pullback_projection_1, pullback_projection_2, identity, diagonal_morphism;
      
      pullback_diagram := Product( morphism, morphism );
      
      pullback_projection_1 := ProjectionInFactor( pullback_diagram, 1 );
      
      pullback_projection_2 := ProjectionInFactor( pullback_diagram, 2 );
      
      identity := IdentityMorphism( Source( morphism ) );
      
      diagonal_morphism := UniversalMorphismIntoPullback( pullback_diagram, identity, identity );
      
      return IsIsomorphism( diagonal_morphism );
    
end );

##
InstallMethod( AddIsEpimorphism,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    SetCanComputeIsEpimorphism( category, true );
    
    SetIsEpimorphismFunction( category, func );
    
    InstallMethod( IsEpimorphism,
                   [ IsCapCategoryMorphism and MorphismFilter( category ) ],
                   
      function( morphism )
        
        return func( morphism );
        
    end );
      
end );

#
InstallTrueMethod( CanComputeIsEpimorphism, CanComputeCokernel and CanComputeIsZeroForObjects and IsAdditiveCategory );

InstallMethod( IsEpimorphism,
               [ IsCapCategoryMorphism and CanComputeCokernel and CanComputeIsZeroForObjects and IsAdditiveCategory ],
               -9900, #FIXME
               
  function( morphism )
    
    return IsZero( Cokernel( morphism ) );
    
end );

##
InstallTrueMethod( CanComputeIsEpimorphism,
                   CanComputeIsIsomorphism
                   and CanComputeIdentityMorphism
                   and CanComputeInjectionOfCofactorOfPushout
                   and CanComputePreCompose
                   and CanComputeUniversalMorphismFromPushout );

InstallMethod( IsEpimorphism,
               [ IsCapCategoryMorphism
                 and CanComputeIsIsomorphism
                 and CanComputeIdentityMorphism
                 and CanComputeInjectionOfCofactorOfPushout
                 and CanComputePreCompose
                 and CanComputeUniversalMorphismFromPushout ],
                 -9999, #FIXME
                 
  function( morphism )
    local pushout_diagram, pushout_injection_1, pushout_injection_2, identity, codiagonal_morphism;
      
      pushout_diagram := Product( morphism, morphism );
      
      pushout_injection_1 := InjectionOfCofactor( pushout_diagram, 1 );
      
      pushout_injection_2 := InjectionOfCofactor( pushout_diagram, 2 );
      
      identity := IdentityMorphism( Range( morphism ) );
      
      codiagonal_morphism := UniversalMorphismFromPushout( pushout_diagram, identity, identity );
      
      return IsIsomorphism( codiagonal_morphism );
    
end );

##
InstallMethod( AddIsIsomorphism,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    SetCanComputeIsIsomorphism( category, true );
    
    SetIsIsomorphismFunction( category, func );
    
    InstallMethod( IsIsomorphism,
                   [ IsCapCategoryMorphism and MorphismFilter( category ) ],
                   
      function( morphism )
        
        return func( morphism );
        
    end );
      
end );

##
InstallTrueMethod( SetCanComputeIsIsomorphism, CanComputeIsMonomorphism and CanComputeIsEpimorphism and IsAbelianCategory );#TODO: weaker?

InstallMethod( IsIsomorphism,
               [ IsCapCategoryMorphism and CanComputeIsMonomorphism and CanComputeIsEpimorphism and IsAbelianCategory ],
               -9999, #FIXME
               
  function( morphism )
    
    return IsMonomorphism( morphism ) and IsEpimorphism( morphism );
    
end );

##
InstallMethod( UnderlyingObject,
               [ IsCapCategoryMorphism and IsSubobject ],
               
  Source );

##
InstallMethod( UnderlyingObject,
               [ IsCapCategoryMorphism and IsFactorobject ],
               
  Range );

InstallTrueMethod( CanComputeEqualityOfSubobjects, CanComputeDominates );

##
InstallMethodWithCacheFromObject( IsEqualAsSubobject,
                                  [ IsCapCategoryMorphism and IsSubobject
                                    and SetCanComputeDominates,
                                    IsCapCategoryMorphism and IsSubobject ],
                                  
  function( sub1, sub2 );
    
    ##or should this be IsIdenticalObj?
    if not IsEqualForObjects( Range( sub1 ), Range( sub2 ) ) then
        
        return false;
        
    fi;
    
    return Dominates( sub1, sub2 ) and Dominates( sub2, sub1 );
    
end );

InstallTrueMethod( CanComputeEqualityOfFactorobjects, CanComputeCodominates );

##
InstallMethodWithCacheFromObject( IsEqualAsFactorobject,
                                  [ IsCapCategoryMorphism and IsFactorobject
                                    and CanComputeCodominates, 
                                    IsCapCategoryMorphism and IsFactorobject ],
                                  
  function( factor1, factor2 )
    
    ##or should this be IsIdenticalObj?
    if not IsEqualForObjects( Source( factor1 ), Source( factor2 ) ) then
        
        return false;
        
    fi;
    
    return Codominates( factor1, factor2 ) and Codominates( factor1, factor2 );
    
end );

##
InstallMethod( AddDominates,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    SetCanComputeDominates( category, true );
    
    SetDominatesFunction( category, func );
    
    InstallMethodWithCache( Dominates,
                            [ IsCapCategoryMorphism and MorphismFilter( category ) and IsSubobject,
                              IsCapCategoryMorphism and MorphismFilter( category ) and IsSubobject ],
                            
      function( sub1, sub2 )
        
        ##or should this be IsIdenticalObj?
        if not IsEqualForObjects( Range( sub1 ), Range( sub2 ) ) then
            
            Error( "subobjects of different objects are not comparable by dominates" );
            
        fi;
        
        return func( sub1, sub2 );
        
    end : Cache := GET_METHOD_CACHE( category, "Dominates", 2 ) );
      
end );

##
InstallMethod( AddCodominates,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    SetCanComputeCodominates( category, true );
    
    SetCodominatesFunction( category, func );
    
    InstallMethodWithCache( Codominates,
                            [ IsCapCategoryMorphism and MorphismFilter( category ) and IsFactorobject,
                              IsCapCategoryMorphism and MorphismFilter( category ) and IsFactorobject ],
                            
      function( factor1, factor2 )
        
        ##or should this be IsIdenticalObj?
        if not IsEqualForObjects( Source( factor1 ), Source( factor2 ) ) then
            
            Error( "factorobjects of different objects are not comparable by codominates" );
            
        fi;
        
        return func( factor1, factor2 );
        
    end : Cache := GET_METHOD_CACHE( category, "Codominates", 2 ) );
      
end );


InstallTrueMethod( CanComputeDominates, CanComputeCokernelProj and CanComputeCodominates and IsPreAbelianCategory );

##
InstallMethodWithCacheFromObject( Dominates,
                                  [ IsCapCategoryMorphism and IsSubobject
                                    and CanComputeCokernelProj
                                    and CanComputeCodominates
                                    and IsPreAbelianCategory,
                                    IsCapCategoryMorphism and IsSubobject ],
                                    -9999, # FIXME (has to be the lowest Dominates fallback method)
                                  
  function( sub1, sub2 )
    local cokernel_projection_1, cokernel_projection_2;
    
    cokernel_projection_1 := CokernelProj( sub1 );
    
    cokernel_projection_2 := CokernelProj( sub2 );
    
    return Codominates( cokernel_projection_1, cokernel_projection_2 );
    
end );

InstallTrueMethod( CanComputeDominates, CanComputeCokernelProj and CanComputeIsZeroForMorphisms and CanComputePreCompose );

##
InstallMethodWithCacheFromObject( Dominates,
                                  [ IsCapCategoryMorphism and IsSubobject 
                                    and CanComputeCokernelProj
                                    and CanComputeIsZeroForMorphisms
                                    and CanComputePreCompose, 
                                    IsCapCategoryMorphism and IsSubobject ],
                                    -9000, # FIXME
                                  
  function( sub1, sub2 )
    local cokernel_projection, composition;
    
    cokernel_projection := CokernelProj( sub2 );
    
    composition := PreCompose( sub1, cokernel_projection );
    
    return IsZero( composition );
    
end );


InstallTrueMethod( CanComputeCodominates, CanComputeKernelEmb and CanComputeDominates and IsPreAbelianCategory );

##
InstallMethodWithCacheFromObject( Codominates,
                                  [ IsCapCategoryMorphism and IsFactorobject
                                    and CanComputeKernelEmb
                                    and CanComputeDominates
                                    and IsPreAbelianCategory,
                                    IsCapCategoryMorphism and IsFactorobject ],
                                    -9999, # FIXME (has to be the lowest Codominates fallback method)
                                  
  function( factor1, factor2 )
    local kernel_embedding_1, kernel_embedding_2;
    
    kernel_embedding_1 := KernelEmb( factor1 );
    
    kernel_embedding_2 := KernelEmb( factor2 );
    
    return Dominates( kernel_embedding_2, kernel_embedding_1 );
    
end );

InstallTrueMethod( CanComputeCodominates, CanComputeKernelEmb and CanComputeIsZeroForMorphisms and CanComputePreCompose );

##
InstallMethodWithCacheFromObject( Codominates,
                                  [ IsCapCategoryMorphism and IsFactorobject
                                    and CanComputeKernelEmb
                                    and CanComputeIsZeroForMorphisms
                                    and CanComputePreCompose,
                                    IsCapCategoryMorphism and IsFactorobject ],
                                    -9000, # FIXME
                                  
  function( factor1, factor2 )
    local kernel_embedding, composition;
    
    kernel_embedding := KernelEmb( factor2 );
    
    composition := PreCompose( kernel_embedding, factor1 );
    
    return IsZero( composition );
    
end );

######################################
##
## Operations
##
######################################

InstallMethod( Add,
               [ IsCapCategory, IsCapCategoryMorphism ],
               
  function( category, morphism )
    local obj_filter, filter;
    
    if HasCapCategory( morphism ) then
        
        if IsIdenticalObj( CapCategory( morphism ), category ) then
            
            return;
            
        else
            
            Error( "this morphism already has a category" );
            
        fi;
        
    fi;
    
    Add( category, Source( morphism ) );
    
    Add( category, Range( morphism ) );
    
    filter := MorphismFilter( category );
    
    SetFilterObj( morphism, filter );
    
    SetCapCategory( morphism, category );

    INSTALL_TODO_LIST_ENTRIES_FOR_MORPHISM( category, morphism );
    
end );

######################################
##
## Morphism equality functions
##
######################################

##
InstallMethod( AddIsEqualForMorphisms,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    SetMorphismEqualityFunction( category, func );
    
    SetCanComputeIsEqualForMorphisms( category, true );
    
    InstallMethodWithCache( IsEqualForMorphisms,
                            [ IsCapCategoryMorphism and MorphismFilter( category ), IsCapCategoryMorphism and MorphismFilter( category ) ],
                            
      function( morphism_1, morphism_2 )
        local return_value;
        
        if not IsEqualForObjects( Source( morphism_1 ), Source( morphism_2 ) ) or not IsEqualForObjects( Range( morphism_1 ), Range( morphism_2 ) ) then
            
            return false;
            
        fi;
        
        return_value := func( morphism_1, morphism_2 );
        
        if return_value = true then
            
            INSTALL_TODO_LIST_FOR_EQUAL_MORPHISMS( morphism_1, morphism_2 );
            
        fi;
        
        return return_value;
        
    end : Cache := GET_METHOD_CACHE( category, "IsEqualForMorphisms", 2 ) );
    
end );

##
InstallMethod( \=,
               [ IsCapCategoryMorphism, IsCapCategoryMorphism ],
               
  IsEqualForMorphisms );

##
InstallGlobalFunction( INSTALL_TODO_LIST_FOR_EQUAL_MORPHISMS,
                       
  function( morphism_1, morphism_2 )
    local category, i, entry;
    
    category := CapCategory( morphism_1 );
    
    for i in PROPAGATION_LIST_FOR_EQUAL_MORPHISMS do
        
        AddToToDoList( ToDoListEntryForEqualAttributes( morphism_1, i, morphism_2, i ) );
        
    od;
    
    if IsBound( category!.PROPAGATION_LIST_FOR_EQUAL_MORPHISMS ) then
        
        for i in category!.PROPAGATION_LIST_FOR_EQUAL_MORPHISMS do
            
            AddToToDoList( ToDoListEntryForEqualAttributes( morphism_1, i, morphism_2, i ) );
            
        od;
        
    fi;
    
end );

##
InstallMethod( AddPropertyToMatchAtIsEqualForMorphisms,
               [ IsCapCategory, IsString ],
               
  function( category, name )
    
    if not IsBound( category!.PROPAGATION_LIST_FOR_EQUAL_MORPHISMS ) then
        
        category!.PROPAGATION_LIST_FOR_EQUAL_MORPHISMS := [ ];
        
    fi;
    
    if Position( category!.PROPAGATION_LIST_FOR_EQUAL_MORPHISMS, name ) = fail then
        
        Add( category!.PROPAGATION_LIST_FOR_EQUAL_MORPHISMS, name );
        
    fi;
    
end );

##
InstallMethod( AddIsZeroForMorphisms,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    SetIsZeroForMorphismsFunction( category, func );
    
    SetCanComputeIsZeroForMorphisms( category, true );
    
    InstallMethod( IsZero,
                   [ IsCapCategoryMorphism and MorphismFilter( category ) ],
                   
        func );
    
end );

##
InstallMethod( AddAdditionForMorphisms,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    SetAdditionForMorphismsFunction( category, func );
    
    SetCanComputeAdditionForMorphisms( category, true );
    
    InstallMethodWithToDoForIsWellDefined( \+,
                                           [ IsCapCategoryMorphism and MorphismFilter( category ), IsCapCategoryMorphism and MorphismFilter( category ) ],
                   
      function( mor1, mor2 )
        local return_value;
        
        if not IsEqualForObjects( Source( mor1 ), Source( mor2 ) ) or not IsEqualForObjects( Range( mor1 ), Range( mor2 ) ) then
            
            Error( "morphisms are not addable" );
            
        fi;
        
        return_value := func( mor1, mor2 );
        
        Add( category, return_value );
        
        return return_value;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "AdditionForMorphisms", 2 ) );
    
end );

##
InstallMethod( AddAdditiveInverseForMorphisms,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    SetAdditiveInverseForMorphismsFunction( category, func );
    
    SetCanComputeAdditiveInverseForMorphisms( category, true );
    
    InstallMethodWithToDoForIsWellDefined( AdditiveInverse,
                                           [ IsCapCategoryMorphism and MorphismFilter( category ) ],
                   
      function( mor )
        local additive_inverse;
        
        additive_inverse := func( mor );
        
        Add( category, additive_inverse );
        
        ## FIXME: Propagation
        
        return additive_inverse;
        
    end );
    
end );

##
InstallMethod( AddZeroMorphism,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    SetZeroMorphismFunction( category, func );
    
    SetCanComputeZeroMorphism( category, true );
    
    InstallMethodWithToDoForIsWellDefined( ZeroMorphism,
                                           [ IsCapCategoryObject and ObjectFilter( category ), IsCapCategoryObject and ObjectFilter( category ) ],
                                           
      function( source, range )
        local return_value;
        
        return_value := func( source, range );
        
        Add( category, return_value );
        
        SetIsZero( return_value, true );
        
        return return_value;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "ZeroMorphism", 2 ) );
    
end );

##
InstallMethod( Zero,
               [ IsCapCategoryMorphism and SetCanComputeZeroMorphism ],
               
  function( mor )
    
    return ZeroMorphism( Source( mor ), Range( mor ) );
    
end );

######################################
##
## Morphism transport
##
######################################

## mor: x -> y
## equality_source: x -> x'
## equality_range: y -> y'
## TransportHom( mor, equality_source, equality_range ): x' -> y'
##
InstallMethodWithCacheFromObject( TransportHom,
                                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ],
                                  
  function( mor, equality_source, equality_range )
    
    return PreCompose(
             Inverse( equality_source ),
             PreCompose( mor, equality_range )
           );
    
end );
######################################
##
## Implied operations
##
######################################

## PostCompose
##
InstallTrueMethod( CanComputePostCompose, CanComputePreCompose );

InstallMethodWithCacheFromObject( PostCompose,
                                  [ IsCapCategoryMorphism and CanComputePreCompose,
                                  IsCapCategoryMorphism and CanComputePreCompose ],
               
  function( right_mor, left_mor )
    
    return PreCompose( left_mor, right_mor );
    
end : ArgumentNumber := 1 );

## Inverse
##
InstallTrueMethod( CanComputeInverse, CanComputeMonoAsKernelLift and CanComputeIdentityMorphism );

InstallMethodWithToDoForIsWellDefined( InverseOp,
                                       [ IsCapCategoryMorphism and CanComputeMonoAsKernelLift and CanComputeIdentityMorphism ],
                                       -9999, #FIXME
                                       
  function( mor )
    local identity_of_range;
        
        identity_of_range := IdentityMorphism( Range( mor ) );
        
        return MonoAsKernelLift( mor, identity_of_range );
        
end );


##
InstallTrueMethod( CanComputeInverse, CanComputeEpiAsCokernelColift and CanComputeIdentityMorphism );

InstallMethodWithToDoForIsWellDefined( InverseOp,
                                       [ IsCapCategoryMorphism and CanComputeEpiAsCokernelColift and CanComputeIdentityMorphism ],
                                       -9998, #FIXME
                                       
  function( mor )
    local identity_of_source;
    
    identity_of_source := IdentityMorphism( Source( mor ) );
    
    return EpiAsCokernelColift( mor, identity_of_source );
      
end );

###########################
##
## PreCompose
##
###########################

## Caching this method is not necessary. It does not create any new object.
## Note: this actually is an in-build relation which is not done by the deductive system.
InstallMethod( PreCompose,
               [ IsCapCategoryMorphism, IsCapCategoryMorphism and IsOne ],
               
  function( morphism, id )
    
    if not IsEqualForObjects( Range( morphism ), Source( id ) ) then
        
        Error( "morphisms are not composable" );
        
    fi;
    
    return morphism;
    
end );

## Caching this method is not necessary. It does not create any new object.
## Note: this actually is an in-build relation which is not done by the deductive system.
InstallMethod( PreCompose,
               [ IsCapCategoryMorphism and IsOne, IsCapCategoryMorphism ],
               
  function( id, morphism )
    
    if not IsEqualForObjects( Source( morphism ), Range( id ) ) then
        
        Error( "morphisms are not composable" );
        
    fi;
    
    return morphism;
    
end );

###########################
##
## IsWellDefined
##
###########################

##
InstallMethod( AddIsWellDefinedForMorphisms,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    SetCanComputeIsWellDefinedForMorphisms( category, true );
    
    SetIsWellDefinedForMorphismsFunction( category, func );
    
    InstallMethod( IsWellDefined,
                   [ IsCapCategoryMorphism and MorphismFilter( category ) ],
                   
      function( morphism )
        
        if not ( IsWellDefined( Source( morphism ) ) and IsWellDefined( Range( morphism ) ) ) then
          
          return false;
          
        fi;
        
        return func( morphism );
        
    end );
      
end );

###########################
##
## EpiMonoFactorization
##
###########################

##
InstallMethodWithToDoForIsWellDefined( EpiMonoFactorization,
                                       [ IsMonomorphism and CanComputeIdentityMorphism ],
                                       
  function( monomorphism )
    
    return Product( IdentityMorphism( Source( monomorphism ) ), monomorphism );
    
end );

##
InstallMethodWithToDoForIsWellDefined( EpiMonoFactorization,
                                       [ IsEpimorphism and CanComputeIdentityMorphism ],
                                       
  function( epimorphism )
    
    return Product( epimorphism, IdentityMorphism( Range( epimorphism ) ) );
    
end );

## FIXME: IsAbelianCategory too restrictive
InstallTrueMethod( CanComputeEpiMonoFactorization, IsAbelianCategory and CanComputeKernelEmb and CanComputeCokernelProj and CanComputeCokernelColift );

InstallMethodWithToDoForIsWellDefined( EpiMonoFactorization,
                                       [ IsCapCategoryMorphism ],
                                       
  function( morphism )
    local kernel_embedding, epimorphism, monomorphism;
    
    kernel_embedding := KernelEmb( morphism );
    
    epimorphism := CokernelProj( kernel_embedding );
    
    monomorphism := CokernelColift( kernel_embedding, morphism );
    
    return Product( epimorphism, monomorphism );
    
end );

###########################
##
## Print
##
###########################

##
InstallGlobalFunction( CATEGORIES_FOR_HOMALG_CREATE_MORPHISM_PRINT,
                       
  function( )
    local print_graph, morphism_function;
    
    morphism_function := function( object )
      local string;
        
        string := "morphism in the category ";
        
        Append( string, Name( CapCategory( object ) ) );
        
        return string;
        
    end;
    
    print_graph := CreatePrintingGraph( IsCapCategoryMorphism, morphism_function );
    
    AddRelationToGraph( print_graph,
                        rec( Source := [ rec( Conditions := "IsIsomorphism",
                                              PrintString := "iso",
                                              Adjective := true ) ],
                             Range := [ rec( Conditions := "IsSplitMonomorphism",
                                             PrintString := "split mono",
                                             TypeOfView := "ViewObj",
                                             ComputeLevel := "AllWithCompute",
                                             Adjective := true ),
                                        rec( Conditions := "IsSplitEpimorphism",
                                             PrintString := "split epi",
                                             Adjective := true ) ] ) );
    
    AddRelationToGraph( print_graph,
                        rec( Source := [ rec( Conditions := "IsOne",
                                              PrintString := "identity",
                                              Adjective := true ) ],
                             Range := [ rec( Conditions := "IsAutomorphism",
                                             PrintString := "auto",
                                             Adjective := true ),
                                        "IsIsomorphism" ] ) );
    
    AddRelationToGraph( print_graph,
                        rec( Source := [ "IsAutomorphism" ],
                             Range := [ "IsIsomorphism",
                                        rec( Conditions := "IsEndomorphism",
                                             PrintString := "endo",
                                             Adjective := true ) ] ) );
    
    AddRelationToGraph( print_graph,
                        rec( Source := [ "IsSplitMonomorphism" ],
                             Range := [ rec( Conditions := "IsMonomorphism",
                                             PrintString := "mono",
                                             Adjective := true ) ] ) );
    
    AddRelationToGraph( print_graph,
                        rec( Source := [ "IsSplitEpimorphism" ],
                             Range := [ rec( Conditions := "IsEpimorphism",
                                             PrintString := "epi",
                                             Adjective := true ) ] ) );
    
    InstallPrintFunctionsOutOfPrintingGraph( print_graph );
    
end );

CATEGORIES_FOR_HOMALG_CREATE_MORPHISM_PRINT( );

InstallMethod( String,
               [ IsCapCategoryMorphism ],
               
  function( morphism )
    
    return Concatenation( "A morphism in ", Name( CapCategory( morphism ) ) );
    
end );
