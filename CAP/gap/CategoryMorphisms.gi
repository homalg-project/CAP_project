#############################################################################
##
##                                               CAP package
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
    
#     entry := ToDoListEntryToMaintainFollowingAttributes( [ [ morphism, "CapCategory" ] ],
#                                                          [ category, morphism ],
#                                                          CAP_INTERNAL_CAN_COMPUTE_FILTER_LIST
#                                                           );
#     
#     AddToToDoList( entry );
    
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
InstallMethod( UnderlyingObject,
               [ IsCapCategoryMorphism and IsSubobject ],
               
  Source );

##
InstallMethod( UnderlyingObject,
               [ IsCapCategoryMorphism and IsFactorobject ],
               
  Range );

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


###########################
##
## PreCompose
##
###########################

## Caching this method is not necessary. It does not create any new object.
## Note: this actually is an in-build relation which is not done by the deductive system.
InstallMethod( PreCompose,
               [ IsCapCategoryMorphism, IsCapCategoryMorphism and IsOne ],
               9999,
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
               9999,
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

## FIXME: these special derivations rely on the fact that they are compatible with the general method
## for EpiMonoFactorization

# InstallMethodWithToDoForIsWellDefined( EpiMonoFactorization,
#                                        [ IsCapCategoryMorphism and IsMonomorphism and CanComputeIdentityMorphism ],
#                                        
#   function( monomorphism )
#     
#     return [ IdentityMorphism( Source( monomorphism ) ), monomorphism ];
#     
# end );
# 
# ##
# InstallMethodWithToDoForIsWellDefined( EpiMonoFactorization,
#                                        [ IsCapCategoryMorphism and IsEpimorphism and CanComputeIdentityMorphism ],
#                                        
#   function( epimorphism )
#     
#     return [ epimorphism, IdentityMorphism( Range( epimorphism ) ) ];
#     
# end );

###########################
##
## Print
##
###########################

##
InstallGlobalFunction( CAP_INTERNAL_CREATE_MORPHISM_PRINT,
                       
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

CAP_INTERNAL_CREATE_MORPHISM_PRINT( );

InstallMethod( String,
               [ IsCapCategoryMorphism ],
               
  function( morphism )
    
    return Concatenation( "A morphism in ", Name( CapCategory( morphism ) ) );
    
end );
