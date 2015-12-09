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
    
    AddObject( category, Source( morphism ) );
    
    AddObject( category, Range( morphism ) );
    
    filter := MorphismFilter( category );
    
    SetFilterObj( morphism, filter );
    
    SetCapCategory( morphism, category );
    
end );

InstallMethod( AddMorphism,
               [ IsCapCategory, IsObject ],
               
  function( category, morphism )
    
    SetFilterObj( morphism, IsCapCategoryMorphism );
    
    Add( category, morphism );
    
end );

##
InstallMethod( IsZeroForMorphisms,
               [ IsCapCategoryMorphism ],
                  
IsZero );

##
InstallMethod( AdditionForMorphisms,
               [ IsCapCategoryMorphism, IsCapCategoryMorphism ],
               
\+ );

##
InstallMethod( AdditiveInverseForMorphisms,
                  [ IsCapCategoryMorphism ],
                  
AdditiveInverse );

##
InstallMethod( IsEqualForCacheForMorphisms,
               [ IsCapCategoryMorphism, IsCapCategoryMorphism ],
               
  IsEqualForCache );


######################################
##
## Morphism equality functions
##
######################################

##
InstallMethod( \=,
               [ IsCapCategoryMorphism, IsCapCategoryMorphism ],
               
  function( morphism_1, morphism_2 )
    
    if not IsEqualForObjects( Source( morphism_1 ), Source( morphism_2 ) ) or not IsEqualForObjects( Range( morphism_1 ), Range( morphism_2 ) ) then
        
        return false;
        
    fi;
    
    return IsCongruentForMorphisms( morphism_1, morphism_2 );
    
end );

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
InstallMethod( AddPropertyToMatchAtIsCongruentForMorphisms,
               [ IsCapCategory, IsString ],
               
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
## Convenience method
##
######################################

## FIXME: This might be dangerous
##
InstallMethod( Zero,
               [ IsCapCategoryMorphism ],
               
  function( mor )
    
    return ZeroMorphism( Source( mor ), Range( mor ) );
    
end );

##
InstallMethod( PreCompose,
               [ IsList ],
               
  function( morphism_list )
    local length, result_morphism, i;
    
    length := Length( morphism_list );
    
    if length = 0 then
      
      Error( "non-empty list expected" );
      
    fi;
    
    result_morphism := morphism_list[1];
    
    for i in [ 2 .. length ] do
      
      result_morphism := PreCompose( result_morphism, morphism_list[i] );
      
    od;
    
    return result_morphism;
    
end );

##
InstallMethod( PostCompose,
               [ IsList ],
               
  function( morphism_list )
    local length, result_morphism, i;
    
    length := Length( morphism_list );
    
    if length = 0 then
      
      Error( "non-empty list expected" );
      
    fi;
    
    result_morphism := morphism_list[1];
    
    for i in [ 2 .. length ] do
      
      result_morphism := PostCompose( result_morphism, morphism_list[i] );
      
    od;
    
    return result_morphism;
    
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
## IsWellDefined
##
###########################

##
InstallMethod( IsWellDefinedForMorphisms,
               [ IsCapCategoryMorphism ],
               
  IsWellDefined
);

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
        
        string := "morphism in ";
        
        Append( string, Name( CapCategory( object ) ) );
        
        return string;
        
    end;
    
    print_graph := CreatePrintingGraph( IsCapCategoryMorphism and HasCapCategory, morphism_function );
    
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
    
    AddNodeToGraph( print_graph,
                    rec( Conditions := "IsZero",
                         PrintString := "zero",
                         Adjective := true ) );
    
    InstallPrintFunctionsOutOfPrintingGraph( print_graph, -1 );
    
end );

CAP_INTERNAL_CREATE_MORPHISM_PRINT( );

InstallMethod( String,
               [ IsCapCategoryMorphism and HasCapCategory ],
               
  function( morphism )
    
    return Concatenation( "A morphism in ", Name( CapCategory( morphism ) ) );
    
end );
