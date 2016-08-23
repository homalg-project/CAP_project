LoadPackage( "ActionsForCAP" );
LoadPackage( "RingsForHomalg" );
Q := HomalgFieldOfRationalsInSingular();

G := SymmetricGroup( 3 );

G_IRREDUCIBLE_INTERNAL_RECORD := rec(
  irr := Irr( G ),
  ct := CharacterTable( G )
);

## G Irreducible objects

## gd
DeclareCategory( "IsGIrreducibleObject",
                 IsObject );

DeclareAttribute( "GIrreducibleObject", IsCharacter );

DeclareOperation( "Multiplicity", [ IsGIrreducibleObject, IsGIrreducibleObject, IsGIrreducibleObject ] );

DeclareOperation( "\<", [ IsGIrreducibleObject, IsGIrreducibleObject ] );

DeclareOperation( "\*", [ IsGIrreducibleObject, IsGIrreducibleObject ] );

DeclareAttribute( "UnderlyingCharacter", IsGIrreducibleObject );

DeclareAttribute( "UnderlyingCharacterNumber", IsGIrreducibleObject );

DeclareAttribute( "SecondExteriorPower", IsGIrreducibleObject );

## gi
DeclareRepresentation( "IsGIrreducibleObjectRep",
                       IsGIrreducibleObject and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfGIrreducibleObjects",
        NewFamily( "TheFamilyOfGIrreducibleObjects" ) );

BindGlobal( "TheTypeOfGIrreducibleObjects",
        NewType( TheFamilyOfGIrreducibleObjects,
                IsGIrreducibleObjectRep ) );

InstallMethod( GIrreducibleObject,
               [ IsCharacter ],
               
  function( character )
    local s3_irreducible_object, number;
    
    s3_irreducible_object := rec( );
    
    number := PositionProperty( G_IRREDUCIBLE_INTERNAL_RECORD.irr, chi -> chi = character );
    
    ObjectifyWithAttributes( s3_irreducible_object, TheTypeOfGIrreducibleObjects,
                             UnderlyingCharacter, character,
                             UnderlyingCharacterNumber, number
    );
    
    return s3_irreducible_object;
    
end );

InstallMethod( \=,
               [ IsGIrreducibleObject, IsGIrreducibleObject ],
               
  function( object_1, object_2 )
    
    return UnderlyingCharacterNumber( object_1 ) = UnderlyingCharacterNumber( object_2 );
    
end );

InstallMethod( \<,
               [ IsGIrreducibleObject, IsGIrreducibleObject ],
               
  function( object_1, object_2 )
    
    return UnderlyingCharacterNumber( object_1 ) < UnderlyingCharacterNumber( object_2 );
    
end );

InstallMethod( Multiplicity,
               [ IsGIrreducibleObject, IsGIrreducibleObject, IsGIrreducibleObject ],
               
  function( object_1, object_2, object_3 )
    local tensor_product;
    
    tensor_product := UnderlyingCharacter( object_2 ) * UnderlyingCharacter( object_3 );
    
    return ScalarProduct( UnderlyingCharacter( object_1 ), tensor_product );
    
end );

InstallMethod( SecondExteriorPower,
               [ IsGIrreducibleObject ],
               
  function( object )
    local character, exterior_power, chi, scalar_product, result_list;
    
    character := UnderlyingCharacter( object );
    
    exterior_power :=
      AntiSymmetricParts( G_IRREDUCIBLE_INTERNAL_RECORD.ct, [ character ], 2 );
    
    exterior_power := exterior_power[1];
    
    result_list := [ ];
    
    for chi in G_IRREDUCIBLE_INTERNAL_RECORD.irr do
        
        scalar_product := ScalarProduct( chi, exterior_power );
        
        if scalar_product > 0 then
            
            Add( result_list, [ scalar_product, GIrreducibleObject( chi ) ] );
            
        fi;
        
    od;
    
    return result_list;
    
end );

InstallMethod( \*,
               [ IsGIrreducibleObject, IsGIrreducibleObject ],
               
  function( object_1, object_2 )
  local tensor_product, result_list, chi, scalar_product;
  
  tensor_product := UnderlyingCharacter( object_1 ) * UnderlyingCharacter( object_2 );
  
  result_list := [ ];
  
  for chi in G_IRREDUCIBLE_INTERNAL_RECORD.irr do
      
      scalar_product := ScalarProduct( chi, tensor_product );
      
      if scalar_product > 0 then
          
          Add( result_list, [ scalar_product, GIrreducibleObject( chi ) ] );
          
      fi;
      
  od;
  
  return result_list;
  
end );

InstallMethod( String,
              [ IsGIrreducibleObject ],
              
  function( object )
    
    return String( UnderlyingCharacterNumber( object ) );
    
end );
##
InstallMethod( ViewObj,
               [ IsGIrreducibleObject ],

  function( object )

    Print( Concatenation( "<χ_", String( object ), ">" ) );

end );

## G category

membership_function := IsGIrreducibleObject;

chi_1 := GIrreducibleObject( G_IRREDUCIBLE_INTERNAL_RECORD.irr[1] );

chi_2 := GIrreducibleObject( G_IRREDUCIBLE_INTERNAL_RECORD.irr[2] );

chi_3 := GIrreducibleObject( G_IRREDUCIBLE_INTERNAL_RECORD.irr[3] );

semisimple_cat := SemisimpleCategory( Q, membership_function, chi_3 );

a := SemisimpleCategoryObject( [ [ 1, chi_1 ], [ 2, chi_2 ], [ 3, chi_3 ] ], semisimple_cat );

b := SemisimpleCategoryObject( [ [ 1, chi_2 ], [ 2, chi_3 ] ], semisimple_cat );

alpha := VectorSpaceMorphism( VectorSpaceObject( 2, Q ), HomalgMatrix( [ [ 1 ], [ -1 ] ], 2, 1, Q ), VectorSpaceObject( 1, Q ) );

beta := VectorSpaceMorphism( VectorSpaceObject( 3, Q ), HomalgMatrix( [ [ 1, 2 ], [ 3, 4 ], [ 5, 6 ] ], 3, 2, Q ), VectorSpaceObject( 2, Q ) );

mor := SemisimpleCategoryMorphism( a, [ [ MorphismIntoZeroObject( VectorSpaceObject( 1, Q ) ), chi_1 ], [ alpha, chi_2 ], [ beta, chi_3 ] ], b  );


