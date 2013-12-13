
LoadPackage( "CategoriesForHomalg" );

DeclareRepresentation( "IsHomalgRationalVectorSpaceRep",
                       IsHomalgCategoryObject,
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

DeclareOperation( "QVectorSpace",
                  [ ] );

InstallMethod( QVectorSpace,
               [ ],
               
  function( )
    local space;
    
    space := rec( );
    
    ObjectifyWithAttributes( space, TheTypeOfHomalgRationalVectorSpaces );
    
    return space;
    
end );

DeclareOperation( "VectorSpaceMorphism",
                  [ IsHomalgRationalVectorSpaceRep, IsInt, IsHomalgRationalVectorSpaceRep ] );

InstallMethod( VectorSpaceMorphism,
                  [ IsHomalgRationalVectorSpaceRep, IsInt, IsHomalgRationalVectorSpaceRep ],
                  
  function( source, value, range )
    local morphism;
    
    morphism := rec( value := value );
    
    ObjectifyWithAttributes( morphism, TheTypeOfHomalgRationalVectorSpaceMorphism,
                             Source, source,
                             Range, range 
    );
    
    SetName( morphism, String( value ) );
    
    return morphism;
    
end );

vecspaces := CreateHomalgCategory( "VectorSpaces" );

AddIdentityMorphism( vecspaces,
                     
  function( obj )
    local id_morphism;
    
    id_morphism := VectorSpaceMorphism( obj, 1, obj );
    
    return id_morphism;
    
end );

AddPreCompose( vecspaces,
               
  function( mor_left, mor_right )
    local new_morph;
    
    new_morph := VectorSpaceMorphism( Source( mor_left ), mor_left!.value * mor_right!.value, Range( mor_right ) );
    
    return new_morph;
    
end );