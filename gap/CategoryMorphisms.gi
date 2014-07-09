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
## Immediate Methods
##
######################################

InstallTrueMethod( IsSplitMonomorphism and IsSplitEpimorphism, IsHomalgCategoryMorphism and IsIsomorphism );

InstallTrueMethod( IsAutomorphism, IsHomalgCategoryMorphism and IsOne );

InstallTrueMethod( IsIsomorphism and IsEndomorphism, IsHomalgCategoryMorphism and IsAutomorphism );

InstallTrueMethod( IsMonomorphism, IsHomalgCategoryMorphism and IsSplitMonomorphism );

InstallTrueMethod( IsEpimorphism, IsHomalgCategoryMorphism and IsSplitEpimorphism );

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

    INSTALL_TODO_LIST_ENTRIES_FOR_OBJECT( category, morphism );
    
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
    
    DECIDE_INSTALL_FUNCTION( category, "EqualityOfMorphisms", 2 );
    
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
        
    end );
    
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
    
    for i in category!.PROPAGATION_LIST_FOR_EQUAL_MORPHISMS do
        
        AddToToDoList( ToDoListEntryForEqualAttributes( morphism_1, i, morphism_2, i ) );
        
    od;
    
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

InstallMethod( Inverse,
               [ IsHomalgCategoryMorphism and CanComputeMonoAsKernelLift and CanComputeIdentityMorphism ],
               -9999, #FIXME
               
  function( mor )
    local identity_of_range;
        
        identity_of_range := IdentityMorphism( Range( mor ) );
        
        return MonoAsKernelLift( mor, identity_of_range );
        
end );


##
InstallTrueMethod( CanComputeInverse, CanComputeEpiAsCokernelColift and CanComputeIdentityMorphism );

InstallMethod( Inverse,
               [ IsHomalgCategoryMorphism and CanComputeEpiAsCokernelColift and CanComputeIdentityMorphism ],
               -9999, #FIXME
                                  
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
