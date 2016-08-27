############################################################################
##
##                                ActionsForCAP package
##
##  Copyright 2016, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter G-Irreducible Objects
##
#############################################################################

####################################
##
## GAP Category
##
####################################

DeclareRepresentation( "IsGZGradedIrreducibleObjectRep",
                       IsGZGradedIrreducibleObject and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfGZGradedIrreducibleObjects",
        NewFamily( "TheFamilyOfGZGradedIrreducibleObjects" ) );

BindGlobal( "TheTypeOfGZGradedIrreducibleObjects",
        NewType( TheFamilyOfGZGradedIrreducibleObjects,
                IsGZGradedIrreducibleObjectRep ) );

####################################
##
## Constructors
##
####################################

##
InstallMethodWithCache( GZGradedIrreducibleObject,
                        [ IsInt, IsCharacter ],
               
  function( degree, character )
    local irreducible_object, number, underlying_character_table, underlying_irreducible_characters;
    
    irreducible_object := rec( );
    
    underlying_character_table := UnderlyingCharacterTable( character );
    
    underlying_irreducible_characters := Irr( underlying_character_table );
    
    number := PositionProperty( underlying_irreducible_characters, chi -> chi = character );
    
    ObjectifyWithAttributes( irreducible_object, TheTypeOfGZGradedIrreducibleObjects,
                             UnderlyingCharacter, character,
                             UnderlyingCharacterNumber, number,
                             UnderlyingGroup, UnderlyingGroup( character ),
                             UnderlyingCharacterTable, underlying_character_table,
                             UnderlyingIrreducibleCharacters, underlying_irreducible_characters,
                             UnderlyingDegree, degree
    );
    
    return irreducible_object;
    
end );

####################################
##
## Attributes
##
####################################

##
InstallMethod( ExteriorPower,
               [ IsGZGradedIrreducibleObject, IsGZGradedIrreducibleObject ],
               
  function( object, object_2 )
    local new_degree, character, ct, irr, exterior_power, chi, scalar_product, result_list;
    
    result_list := [ ];
    
    if not( UnderlyingCharacterNumber( object ) = UnderlyingCharacterNumber( object_2 ) ) then
        
        return result_list;
        
    fi;
    
    ct := UnderlyingCharacterTable( object );
    
    irr := UnderlyingIrreducibleCharacters( object );
    
    character := UnderlyingCharacter( object );
    
    exterior_power :=
      AntiSymmetricParts( ct, [ character ], 2 );
    
    exterior_power := exterior_power[1];
    
    new_degree := UnderlyingDegree( object ) + UnderlyingDegree( object_2 );
    
    for chi in irr do
        
        scalar_product := ScalarProduct( chi, exterior_power );
        
        if scalar_product > 0 then
            
            Add( result_list, [ scalar_product, GZGradedIrreducibleObject( new_degree, chi ) ] );
            
        fi;
        
    od;
    
    return result_list;
    
end );

####################################
##
## Operations
##
####################################

##
InstallMethod( \=,
               [ IsGZGradedIrreducibleObject, IsGZGradedIrreducibleObject ],
               
  function( object_1, object_2 )
    
    return ( UnderlyingCharacterNumber( object_1 ) = UnderlyingCharacterNumber( object_2 ) )
           and ( UnderlyingDegree( object_1 ) = UnderlyingDegree( object_2 ) );
    
end );

##
InstallMethod( \<,
               [ IsGZGradedIrreducibleObject, IsGZGradedIrreducibleObject ],
               
  function( object_1, object_2 )
    local degree_1, degree_2;
    
    degree_1 := UnderlyingDegree( object_1 );
    
    degree_2 := UnderlyingDegree( object_2 );
    
    if degree_1 < degree_2 then
        
        return true;
        
    elif degree_1 = degree_2 then
        
        return UnderlyingCharacterNumber( object_1 ) < UnderlyingCharacterNumber( object_2 );
        
    else
        
        return false;
        
    fi;
    
end );

##
InstallMethod( Multiplicity,
               [ IsGZGradedIrreducibleObject, IsGZGradedIrreducibleObject, IsGZGradedIrreducibleObject ],
               
  function( object_1, object_2, object_3 )
    local tensor_product;
    
    if not ( UnderlyingDegree( object_1 ) = UnderlyingDegree( object_2 ) + UnderlyingDegree( object_3 ) ) then
        
        return 0;
        
    fi;
    
    tensor_product := UnderlyingCharacter( object_2 ) * UnderlyingCharacter( object_3 );
    
    return ScalarProduct( UnderlyingCharacter( object_1 ), tensor_product );
    
end );

##
InstallMethod( \*,
               [ IsGZGradedIrreducibleObject, IsGZGradedIrreducibleObject ],
               
  function( object_1, object_2 )
    local new_degree, tensor_product, result_list, irr, chi, scalar_product;
    
    tensor_product := UnderlyingCharacter( object_1 ) * UnderlyingCharacter( object_2 );
    
    result_list := [ ];
    
    irr := UnderlyingIrreducibleCharacters( object_1 );
    
    new_degree := UnderlyingDegree( object_1 ) + UnderlyingDegree( object_2 );
    
    for chi in irr do
        
        scalar_product := ScalarProduct( chi, tensor_product );
        
        if scalar_product > 0 then
            
            Add( result_list, [ scalar_product, GZGradedIrreducibleObject( new_degree, chi ) ] );
            
        fi;
        
    od;
    
    return result_list;
    
end );

##
InstallMethod( AssociatorFromData,
               [ IsGZGradedIrreducibleObject, IsGZGradedIrreducibleObject, IsGZGradedIrreducibleObject, IsList, IsFieldForHomalg ],
               
  function( irr_1, irr_2, irr_3, associator_data, field )
    local new_degree, data, irr, size, morphism_list, i, string, homalg_matrix, source, range;
    
    new_degree := Sum( List( [ irr_1, irr_2, irr_3 ], UnderlyingDegree ) );
    
    data :=
        associator_data[UnderlyingCharacterNumber( irr_1 )][UnderlyingCharacterNumber( irr_2 )][UnderlyingCharacterNumber( irr_3 )];
    
    irr := UnderlyingIrreducibleCharacters( irr_1 );
    
    size := Size( irr );
    
    morphism_list := [ ];
    
    if Conductor( field ) > 1 then
        
        CAP_INTERNAL_FIELD_FOR_SEMISIMPLE_CATEGORY.eps := GeneratingRootOfUnityForFieldForHomalg( field );
        
    fi;
    
    for i in [ 1 .. size ] do
        
        if not IsEmpty( data[i] ) then
            
            ## this is the workaround suggested in the documentation of EvalString
            CAP_INTERNAL_FIELD_FOR_SEMISIMPLE_CATEGORY.field := field;
            
            string := ReplacedString( data[i], "field", "CAP_INTERNAL_FIELD_FOR_SEMISIMPLE_CATEGORY.field" );
            
            if Conductor( field ) > 1 then
                
                string := ReplacedString( string, "eps", "CAP_INTERNAL_FIELD_FOR_SEMISIMPLE_CATEGORY.eps" );
                
            fi;
            
            homalg_matrix := EvalString( string );
            
            source := VectorSpaceObject( NrRows( homalg_matrix ), field );
            
            range := VectorSpaceObject( NrColumns( homalg_matrix ), field );
            
            Add( morphism_list, [ VectorSpaceMorphism( source, homalg_matrix, range ), GZGradedIrreducibleObject( new_degree, irr[i] ) ] );
            
        fi;
        
    od;
    
    return morphism_list;
    
end );

####################################
##
## Properties
##
####################################

InstallMethod( IsOne,
               [ IsGZGradedIrreducibleObject ],
               
  function( object )
    
    ## is used for deciding when braiding or associator is trivial. Change name appropriately.
    return IsOne( UnderlyingCharacter( object ) );
    
end );

####################################
##
## View
##
####################################

##
InstallMethod( String,
              [ IsGZGradedIrreducibleObject ],
              
  function( object )
    
    return Concatenation( "[", String( UnderlyingDegree( object ) ), ", ", String( UnderlyingCharacterNumber( object ) ), "]" );
    
end );

##
InstallMethod( ViewObj,
               [ IsGZGradedIrreducibleObject ],

  function( object )

    Print( Concatenation( "<χ_", String( object ), ">" ) );

end );
