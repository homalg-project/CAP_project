
LoadPackage( "CategoriesForHomalg" );

DeclareRepresentation( "IsHomalgRationalVectorSpaceRep",
                       IsHomalgCategoryObjectRep,
                       [ ] );

BindGlobal( "TheTypeOfHomalgRationalVectorSpaces",
        NewType( TheFamilyOfHomalgCategoryObjects,
                IsHomalgRationalVectorSpaceRep ) );

DeclareRepresentation( "IsHomalgRationalVectorSpaceMorphismRep",
                       IsHomalgCategoryMorphismRep,
                       [ ] );

BindGlobal( "TheTypeOfHomalgRationalVectorSpaceMorphism",
        NewType( TheFamilyOfHomalgCategoryMorphisms,
                IsHomalgRationalVectorSpaceMorphismRep ) );


DeclareAttribute( "Dimension",
                  IsHomalgRationalVectorSpaceRep );

DeclareOperation( "QVectorSpace",
                  [ IsInt ] );

InstallMethod( QVectorSpace,
               [ IsInt ],
               
  function( dim )
    local space;
    
    space := rec( );
    
    ObjectifyWithAttributes( space, TheTypeOfHomalgRationalVectorSpaces,
                             Dimension, dim 
    );
    
    return space;
    
end );

DeclareOperation( "VectorSpaceMorphism",
                  [ IsHomalgRationalVectorSpaceRep, IsObject, IsHomalgRationalVectorSpaceRep ] );

InstallMethod( VectorSpaceMorphism,
                  [ IsHomalgRationalVectorSpaceRep, IsObject, IsHomalgRationalVectorSpaceRep ],
                  
  function( source, matrix, range )
    local morphism;
    
    morphism := rec( value := matrix );
    
    if IsMatrix( matrix ) and ( Length( matrix ) <> Dimension( source ) or ( Length( matrix ) > 0 and ( Length( matrix[ 1 ] ) <> Dimension( range ) ) ) ) then
        
        Error( "incorrect dimensions" );
        
    elif not( IsMatrix( matrix ) or matrix = 0 ) then
        
        Error( "incorrect input" );
        
    fi;
    
    ObjectifyWithAttributes( morphism, TheTypeOfHomalgRationalVectorSpaceMorphism,
                             Source, source,
                             Range, range 
    );
    
    return morphism;
    
end );

vecspaces := CreateHomalgCategory( "VectorSpaces" );

AddIdentityMorphism( vecspaces,
                     
  function( obj )
    local id_morphism;
    
    id_morphism := VectorSpaceMorphism( obj, IdentityMat( Dimension( obj ) ), obj );
    
    return id_morphism;
    
end );

AddPreCompose( vecspaces,
               
  function( mor_left, mor_right )
    local matr, new_morph;
    
    if mor_left!.value = 0 or mor_right!.value = 0 then
        
        matr := 0;
        
    else
        
        matr :=  mor_left!.value * mor_right!.value;
        
    fi;
    
    new_morph := VectorSpaceMorphism( Source( mor_left ), matr, Range( mor_right ) );
    
    return new_morph;
    
end );

AddZeroObject( vecspaces,
               
  function( )
    
    return QVectorSpace( 0 );
    
end );

AddMorphismIntoZeroObject( vecspaces,
                           
  function( obj )
    local dim, category, mat, morphism;
    
    dim := Dimension( obj );
    
    ## IDEA: one can write vecspaces here.
    ##       it doesn't really matter
    category := HomalgCategory( obj );
    
    morphism := VectorSpaceMorphism( obj, 0, ZeroObject( obj ) );
    
    return morphism;
    
end );

AddMorphismFromZeroObject( vecspaces,
                           
  function( obj )
    local dim, category, mat, morphism;
    
    dim := Dimension( obj );
    
    ## IDEA: one can write vecspaces here.
    ##       it doesn't really matter
    category := HomalgCategory( obj );
    
    morphism := VectorSpaceMorphism( ZeroObject( obj ), 0, obj );
    
    return morphism;
    
end );

v := QVectorSpace( 3 );

Add( vecspaces, v );

id := IdentityMorphism( v );

x1 := QVectorSpace( 1 );
x2 := QVectorSpace( 1 );
x3 := QVectorSpace( 1 );

x := VectorSpaceMorphism( x1, [[ 2 ]], x2 );
y := VectorSpaceMorphism( x2, [[ 3 ]], x3 );

Add( vecspaces, x );
Add( vecspaces, y );

InstallMethod( ViewObj,
               [ IsHomalgRationalVectorSpaceRep ],
               
  function( obj )
    
    Print( "<A rational vector space of dimension ", String( Dimension( obj ) ), ">" );
    
end );

InstallMethod( ViewObj,
               [ IsHomalgRationalVectorSpaceMorphismRep ],
               
  function( obj )
    
    Print( "<A rational vector space homomorphism with matrix " );
    
    Print( String( obj!.value ) );
    
    Print( ">" );
    
end );
