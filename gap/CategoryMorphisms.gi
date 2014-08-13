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

DeclareRepresentation( "IsHomalgCategoryMorphismRep",
                       IsAttributeStoringRep and IsHomalgCategoryMorphism,
                       [ ] );

BindGlobal( "TheFamilyOfHomalgCategoryMorphisms",
        NewFamily( "TheFamilyOfHomalgCategoryMorphisms" ) );

BindGlobal( "TheTypeOfHomalgCategoryMorphisms",
        NewType( TheFamilyOfHomalgCategoryMorphisms,
                IsHomalgCategoryMorphismRep ) );

######################################
##
## Properties logic
##
######################################

InstallTrueMethod( IsSplitMonomorphism and IsSplitEpimorphism, IsHomalgCategoryMorphism and IsIsomorphism );

InstallTrueMethod( IsAutomorphism, IsHomalgCategoryMorphism and IsOne );

InstallTrueMethod( IsIsomorphism and IsEndomorphism, IsHomalgCategoryMorphism and IsAutomorphism );

InstallTrueMethod( IsMonomorphism, IsHomalgCategoryMorphism and IsSplitMonomorphism );

InstallTrueMethod( IsEpimorphism, IsHomalgCategoryMorphism and IsSplitEpimorphism );

InstallTrueMethod( IsIsomorphism, IsMonomorphism and IsEpimorphism and IsAbelianCategory );#TODO: weaker?

#######################################
##
## Technical implications
##
#######################################

InstallGlobalFunction( INSTALL_TODO_LIST_ENTRIES_FOR_MORPHISM,

  function( category, morphism )
    local entry;
    
    entry := ToDoListEntryToMaintainFollowingAttributes( [ [ morphism, "HomalgCategory" ] ],
                                                         [ category, morphism ],
                                                         CATEGORIES_FOR_HOMALG_CAN_COMPUTE_FILTER_LIST
                                                          );
    
    AddToToDoList( entry );
    
    if IsBound( category!.PROPAGATE_FILTERS_FROM_CATEGORY_TO_MORPHISM ) then
        
        entry := ToDoListEntryToMaintainFollowingAttributes( [ [ morphism, "HomalgCategory" ] ],
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
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetCanComputeIsMonomorphism( category, true );
    
    SetIsMonomorphismFunction( category, func );
    
    InstallMethod( IsMonomorphism,
                   [ IsHomalgCategoryMorphism and MorphismFilter( category ) ],
                   
      function( morphism )
        
        return func( morphism );
        
    end );
      
end );

##
InstallTrueMethod( SetCanComputeIsMonomorphism, CanComputeKernel and CanComputeIsZeroForObjects and IsAdditiveCategory );

InstallMethod( IsMonomorphism,
               [ IsHomalgCategoryMorphism and CanComputeKernel and CanComputeIsZeroForObjects and IsAdditiveCategory ],
               -9999, #FIXME
               
  function( morphism )
    
    return IsZero( KernelObject( morphism ) );
    
end );

##
InstallMethod( AddIsEpimorphism,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetCanComputeIsEpimorphism( category, true );
    
    SetIsEpimorphismFunction( category, func );
    
    InstallMethod( IsEpimorphism,
                   [ IsHomalgCategoryMorphism and MorphismFilter( category ) ],
                   
      function( morphism )
        
        return func( morphism );
        
    end );
      
end );

##
InstallTrueMethod( SetCanComputeIsEpimorphism, CanComputeCokernel and CanComputeIsZeroForObjects and IsAdditiveCategory );

InstallMethod( IsEpimorphism,
               [ IsHomalgCategoryMorphism and CanComputeCokernel and CanComputeIsZeroForObjects and IsAdditiveCategory ],
               -9999, #FIXME
               
  function( morphism )
    
    return IsZero( Cokernel( morphism ) );
    
end );

##
InstallMethod( AddIsIsomorphism,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetCanComputeIsIsomorphism( category, true );
    
    SetIsIsomorphismFunction( category, func );
    
    InstallMethod( IsIsomorphism,
                   [ IsHomalgCategoryMorphism and MorphismFilter( category ) ],
                   
      function( morphism )
        
        return func( morphism );
        
    end );
      
end );

##
InstallTrueMethod( SetCanComputeIsIsomorphism, CanComputeIsMonomorphism and CanComputeIsEpimorphism and IsAbelianCategory );#TODO: weaker?

InstallMethod( IsIsomorphism,
               [ IsHomalgCategoryMorphism and CanComputeIsMonomorphism and CanComputeIsEpimorphism and IsAbelianCategory ],
               -9999, #FIXME
               
  function( morphism )
    
    return IsMonomorphism( morphism ) and IsEpimorphism( morphism );
    
end );

##
InstallMethod( UnderlyingObject,
               [ IsHomalgCategoryMorphism and IsSubobject ],
               
  Source );

##
InstallMethod( UnderlyingObject,
               [ IsHomalgCategoryMorphism and IsFactorobject ],
               
  Range );

InstallTrueMethod( CanComputeEqualityOfSubobjects, CanComputeDominates );

##
InstallMethodWithCacheFromObject( IsEqualAsSubobject,
                                  [ IsHomalgCategoryMorphism and IsSubobject
                                    and SetCanComputeDominates,
                                    IsHomalgCategoryMorphism and IsSubobject ],
                                  
  function( sub1, sub2 );
    
    if not IsIdenticalObj( Range( sub1 ), Range( sub2 ) ) then
        
        return false;
        
    fi;
    
    return Dominates( sub1, sub2 ) and Dominates( sub2, sub2 );
    
end );

InstallTrueMethod( CanComputeEqualityOfFactorobjects, CanComputeCodominates );

##
InstallMethodWithCacheFromObject( IsEqualAsFactorobject,
                                  [ IsHomalgCategoryMorphism and IsFactorobject
                                    and CanComputeCodominates, 
                                    IsHomalgCategoryMorphism and IsFactorobject ],
                                  
  function( factor1, factor2 )
    
    if not IsIdenticalObj( Source( factor1 ), Source( factor2 ) ) then
        
        return false;
        
    fi;
    
    return Codominates( factor1, factor2 ) and Codominates( factor1, factor2 );
    
end );

##
InstallMethod( AddDominates,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetCanComputeDominates( category, true );
    
    SetDominatesFunction( category, func );
    
    InstallMethodWithCache( Dominates,
                            [ IsHomalgCategoryMorphism and MorphismFilter( category ) and IsSubobject,
                              IsHomalgCategoryMorphism and MorphismFilter( category ) and IsSubobject ],
                            
      function( sub1, sub2 )
        
        if not IsIdenticalObj( Range( sub1 ), Range( sub2 ) ) then
            
            Error( "subobjects of different objects are not comparable by dominates" );
            
        fi;
        
        return func( sub1, sub2 );
        
    end : Cache := GET_METHOD_CACHE( category, "Dominates", 2 ) );
      
end );

##
InstallMethod( AddCodominates,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetCanComputeCodominates( category, true );
    
    SetCodominatesFunction( category, func );
    
    InstallMethodWithCache( Codominates,
                            [ IsHomalgCategoryMorphism and MorphismFilter( category ) and IsFactorobject,
                              IsHomalgCategoryMorphism and MorphismFilter( category ) and IsFactorobject ],
                            
      function( factor1, factor2 )
        
        if not IsIdenticalObj( Source( factor1 ), Source( factor2 ) ) then
            
            Error( "factorobjects of different objects are not comparable by codominates" );
            
        fi;
        
        return func( factor1, factor2 );
        
    end : Cache := GET_METHOD_CACHE( category, "Codominates", 2 ) );
      
end );

InstallTrueMethod( CanComputeDominates, CanComputeCokernelProj and CanComputeIsZeroForMorphisms and CanComputePreCompose );

##
InstallMethodWithCacheFromObject( Dominates,
                                  [ IsHomalgCategoryMorphism and IsSubobject 
                                    and CanComputeCokernelProj
                                    and CanComputeIsZeroForMorphisms
                                    and CanComputePreCompose, 
                                    IsHomalgCategoryMorphism and IsSubobject ],
                                    -9000, # FIXME
                                  
  function( sub1, sub2 )
    local cokernel_projection, composition;
    
    cokernel_projection := CokernelProj( sub2 );
    
    composition := PreCompose( sub1, cokernel_projection );
    
    return IsZero( composition );
    
end );

InstallTrueMethod( CanComputeDominates, CanComputeCokernelProj and CanComputeCodominates and IsPreAbelianCategory );

##
InstallMethodWithCacheFromObject( Dominates,
                                  [ IsHomalgCategoryMorphism and IsSubobject
                                    and CanComputeCokernelProj
                                    and CanComputeCodominates
                                    and IsPreAbelianCategory,
                                    IsHomalgCategoryMorphism and IsSubobject ],
                                    -9999, # FIXME (has to be the lowest Dominates fallback method)
                                  
  function( sub1, sub2 )
    local cokernel_projection_1, cokernel_projection_2;
    
    cokernel_projection_1 := CokernelProj( sub1 );
    
    cokernel_projection_2 := CokernelProj( sub2 );
    
    return Codominates( cokernel_projection_1, cokernel_projection_2 );
    
end );

InstallTrueMethod( CanComputeCodominates, CanComputeKernelEmb and CanComputeIsZeroForMorphisms and CanComputePreCompose );

##
InstallMethodWithCacheFromObject( Codominates,
                                  [ IsHomalgCategoryMorphism and IsFactorobject
                                    and CanComputeKernelEmb
                                    and CanComputeIsZeroForMorphisms
                                    and CanComputePreCompose,
                                    IsHomalgCategoryMorphism and IsFactorobject ],
                                    -9000, # FIXME
                                  
  function( factor1, factor2 )
    local kernel_embedding, composition;
    
    kernel_embedding := KernelEmb( factor2 );
    
    composition := PreCompose( kernel_embedding, factor1 );
    
    return IsZero( composition );
    
end );

InstallTrueMethod( CanComputeCodominates, CanComputeKernelEmb and CanComputeDominates and IsPreAbelianCategory );

##
InstallMethodWithCacheFromObject( Codominates,
                                  [ IsHomalgCategoryMorphism and IsFactorobject
                                    and CanComputeKernelEmb
                                    and CanComputeDominates
                                    and IsPreAbelianCategory,
                                    IsHomalgCategoryMorphism and IsFactorobject ],
                                    -9999, # FIXME (has to be the lowest Codominates fallback method)
                                  
  function( factor1, factor2 )
    local kernel_embedding_1, kernel_embedding_2;
    
    kernel_embedding_1 := KernelEmb( factor1 );
    
    kernel_embedding_2 := KernelEmb( factor2 );
    
    return Dominates( kernel_embedding_2, kernel_embedding_1 );
    
end );

######################################
##
## Operations
##
######################################

InstallMethod( Add,
               [ IsHomalgCategory, IsHomalgCategoryMorphism ],
               
  function( category, morphism )
    local obj_filter, filter;
    
    if HasHomalgCategory( morphism ) then
        
        if IsIdenticalObj( HomalgCategory( morphism ), category ) then
            
            return;
            
        else
            
            Error( "this morphism already has a category" );
            
        fi;
        
    fi;
    
    Add( category, Source( morphism ) );
    
    Add( category, Range( morphism ) );
    
    filter := MorphismFilter( category );
    
    SetFilterObj( morphism, filter );
    
    SetHomalgCategory( morphism, category );

    INSTALL_TODO_LIST_ENTRIES_FOR_MORPHISM( category, morphism );
    
end );

######################################
##
## Morphism equality functions
##
######################################

##
InstallMethod( AddEqualityOfMorphisms,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetMorphismEqualityFunction( category, func );
    
    SetCanComputeEqualityOfMorphisms( category, true );
    
    InstallMethodWithCache( EqualityOfMorphisms,
                            [ IsHomalgCategoryMorphism and MorphismFilter( category ), IsHomalgCategoryMorphism and MorphismFilter( category ) ],
                            
      function( morphism_1, morphism_2 )
        local return_value;
        
        if not IsIdenticalObj( Source( morphism_1 ), Source( morphism_2 ) ) or not IsIdenticalObj( Range( morphism_1 ), Range( morphism_2 ) ) then
            
            return false;
            
        fi;
        
        return_value := func( morphism_1, morphism_2 );
        
        if return_value = true then
            
            INSTALL_TODO_LIST_FOR_EQUAL_MORPHISMS( morphism_1, morphism_2 );
            
        fi;
        
        return return_value;
        
    end : Cache := GET_METHOD_CACHE( category, "EqualityOfMorphisms", 2 ) );
    
end );

##
InstallMethod( \=,
               [ IsHomalgCategoryMorphism, IsHomalgCategoryMorphism ],
               
  EqualityOfMorphisms );

##
InstallGlobalFunction( INSTALL_TODO_LIST_FOR_EQUAL_MORPHISMS,
                       
  function( morphism_1, morphism_2 )
    local category, i, entry;
    
    category := HomalgCategory( morphism_1 );
    
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
InstallMethod( AddPropertyToMatchAtEqualityOfMorphisms,
               [ IsHomalgCategory, IsString ],
               
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
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetIsZeroForMorphismsFunction( category, func );
    
    SetCanComputeIsZeroForMorphisms( category, true );
    
    InstallMethod( IsZero,
                   [ IsHomalgCategoryMorphism and MorphismFilter( category ) ],
                   
        func );
    
end );

##
InstallMethod( AddAdditionForMorphisms,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetAdditionForMorphismsFunction( category, func );
    
    SetCanComputeAdditionForMorphisms( category, true );
    
    InstallMethodWithToDoForIsWellDefined( \+,
                                           [ IsHomalgCategoryMorphism and MorphismFilter( category ), IsHomalgCategoryMorphism and MorphismFilter( category ) ],
                   
      function( mor1, mor2 )
        local return_value;
        
        if not IsIdenticalObj( Source( mor1 ), Source( mor2 ) ) or not IsIdenticalObj( Range( mor1 ), Range( mor2 ) ) then
            
            Error( "morphisms are not addable" );
            
        fi;
        
        return_value := func( mor1, mor2 );
        
        Add( category, return_value );
        
        return return_value;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "AdditionForMorphisms", 2 ) );
    
end );

##
InstallMethod( AddAdditiveInverseForMorphisms,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetAdditiveInverseForMorphismsFunction( category, func );
    
    SetCanComputeAdditiveInverseForMorphisms( category, true );
    
    InstallMethodWithToDoForIsWellDefined( AdditiveInverse,
                                           [ IsHomalgCategoryMorphism and MorphismFilter( category ) ],
                   
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
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetZeroMorphismFunction( category, func );
    
    SetCanComputeZeroMorphism( category, true );
    
    InstallMethodWithToDoForIsWellDefined( ZeroMorphism,
                                           [ IsHomalgCategoryObject and ObjectFilter( category ), IsHomalgCategoryObject and ObjectFilter( category ) ],
                                           
      function( source, range )
        local return_value;
        
        return_value := func( source, range );
        
        Add( category, return_value );
        
        return return_value;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "ZeroMorphism", 2 ) );
    
end );

##
InstallMethod( Zero,
               [ IsHomalgCategoryMorphism and SetCanComputeZeroMorphism ],
               
  function( mor )
    
    return ZeroMorphism( Source( mor ), Range( mor ) );
    
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
                                  [ IsHomalgCategoryMorphism and CanComputePreCompose,
                                  IsHomalgCategoryMorphism and CanComputePreCompose ],
               
  function( right_mor, left_mor )
    
    return PreCompose( left_mor, right_mor );
    
end : ArgumentNumber := 1 );

## Inverse
##
InstallTrueMethod( CanComputeInverse, CanComputeMonoAsKernelLift and CanComputeIdentityMorphism );

InstallMethodWithToDoForIsWellDefined( InverseOp,
                                       [ IsHomalgCategoryMorphism and CanComputeMonoAsKernelLift and CanComputeIdentityMorphism ],
                                       -9999, #FIXME
                                       
  function( mor )
    local identity_of_range;
        
        identity_of_range := IdentityMorphism( Range( mor ) );
        
        return MonoAsKernelLift( mor, identity_of_range );
        
end );


##
InstallTrueMethod( CanComputeInverse, CanComputeEpiAsCokernelColift and CanComputeIdentityMorphism );

InstallMethodWithToDoForIsWellDefined( InverseOp,
                                       [ IsHomalgCategoryMorphism and CanComputeEpiAsCokernelColift and CanComputeIdentityMorphism ],
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
InstallMethod( PreCompose,
               [ IsHomalgCategoryMorphism, IsHomalgCategoryMorphism and IsOne ],
               
  function( morphism, id )
    
    if not IsIdenticalObj( Range( morphism ), Source( id ) ) then
        
        Error( "morphisms are not composable" );
        
    fi;
    
    return morphism;
    
end );

## Caching this method is not necessary. It does not create any new object.
InstallMethod( PreCompose,
               [ IsHomalgCategoryMorphism and IsOne, IsHomalgCategoryMorphism ],
               
  function( id, morphism )
    
    if not IsIdenticalObj( Source( morphism ), Range( id ) ) then
        
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
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetCanComputeIsWellDefinedForMorphisms( category, true );
    
    SetIsWellDefinedForMorphismsFunction( category, func );
    
    InstallMethod( IsWellDefined,
                   [ IsHomalgCategoryMorphism and MorphismFilter( category ) ],
                   
      function( morphism )
        
        if not ( IsWellDefined( Source( morphism ) ) and IsWellDefined( Range( morphism ) ) ) then
          
          return false;
          
        fi;
        
        return func( morphism );
        
    end );
      
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
        
        Append( string, Name( HomalgCategory( object ) ) );
        
        return string;
        
    end;
    
    print_graph := CreatePrintingGraph( IsHomalgCategoryMorphism, morphism_function );
    
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
