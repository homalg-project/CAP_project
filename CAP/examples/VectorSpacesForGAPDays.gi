LoadPackage( "CAP" );

LoadPackage( "MatricesForHomalg" );

###################################
##
## Types and Representations
##
###################################

DeclareRepresentation( "IsHomalgRationalVectorSpaceRep",
                       IsCapCategoryObjectRep,
                       [ ] );

BindGlobal( "TheTypeOfHomalgRationalVectorSpaces",
        NewType( TheFamilyOfCapCategoryObjects,
                IsHomalgRationalVectorSpaceRep ) );

DeclareRepresentation( "IsHomalgRationalVectorSpaceMorphismRep",
                       IsCapCategoryMorphismRep,
                       [ ] );

BindGlobal( "TheTypeOfHomalgRationalVectorSpaceMorphism",
        NewType( TheFamilyOfCapCategoryMorphisms,
                IsHomalgRationalVectorSpaceMorphismRep ) );

###################################
##
## Attributes
##
###################################

DeclareAttribute( "Dimension",
                  IsHomalgRationalVectorSpaceRep );

VECTORSPACES_FIELD := HomalgFieldOfRationals( );

###################################
##
## Creating the category
##
###################################

BindGlobal( "QVectorSpaces", CreateCapCategory( "QVectorSpaces" ) );

###################################
##
## Constructors for objects and morphisms
##
###################################

DeclareOperation( "QVectorSpace",
                  [ IsInt ] );

DeclareOperation( "QVectorSpaceMorphism",
                  [ IsHomalgRationalVectorSpaceRep, IsObject, IsHomalgRationalVectorSpaceRep ] );

##
InstallMethod( QVectorSpace,
               [ IsInt ],
               
  function( dim )
    local space;
    
    space := rec( );
    
    ObjectifyWithAttributes( space, TheTypeOfHomalgRationalVectorSpaces,
                             Dimension, dim 
    );
    
    Add( QVectorSpaces, space );
    
    return space;
    
end );

##
InstallMethod( QVectorSpaceMorphism,
                  [ IsHomalgRationalVectorSpaceRep, IsObject, IsHomalgRationalVectorSpaceRep ],
                  
  function( source, matrix, range )
    local morphism;
    
    if not IsHomalgMatrix( matrix ) then
        
        morphism := HomalgMatrix( matrix, Dimension( source ), Dimension( range ), VECTORSPACES_FIELD );
        
    else
        
        morphism := matrix;
        
    fi;
    
    morphism := rec( morphism := morphism );
    
    ObjectifyWithAttributes( morphism, TheTypeOfHomalgRationalVectorSpaceMorphism,
                             Source, source,
                             Range, range 
    );
    
    Add( QVectorSpaces, morphism );
    
    return morphism;
    
end );

#######################################
##
## View and Display
##
#######################################

InstallMethod( ViewObj,
               [ IsHomalgRationalVectorSpaceRep ],
               
  function( obj )
    
    Print( "<A rational vector space of dimension ", String( Dimension( obj ) ), ">" );
    
end );

InstallMethod( ViewObj,
               [ IsHomalgRationalVectorSpaceMorphismRep ],
               
  function( obj )
    
    Print( "A rational vector space homomorphism with matrix: \n" );
    
    Display( obj!.morphism );
    
end );

#######################################
##
## Add some methods
##
#######################################

##
AddLiftAlongMonomorphism( QVectorSpaces,

  function( monomorphism, test_morphism )

    return QVectorSpaceMorphism( Source( test_morphism ), RightDivide( test_morphism!.morphism, monomorphism!.morphism ), Source( monomorphism ) );

end );

##
AddColiftAlongEpimorphism( QVectorSpaces,
  
  function( epimorphism, test_morphism )
    
    return QVectorSpaceMorphism( Range( epimorphism ), LeftDivide( epimorphism!.morphism, test_morphism!.morphism ), Range( test_morphism ) );
    
end );

##
AddKernelObject( QVectorSpaces,

  function( morphism )
    local homalg_matrix;

    homalg_matrix := morphism!.morphism;
  
    return QVectorSpace( NrRows( homalg_matrix ) - RowRankOfMatrix( homalg_matrix ) );

end );

##
AddKernelEmbeddingWithGivenKernelObject( QVectorSpaces,

  function( morphism, kernel )
    local kernel_emb;

    kernel_emb := SyzygiesOfRows( morphism!.morphism );

    return QVectorSpaceMorphism( kernel, kernel_emb, Source( morphism ) );

end );

##
AddCokernelObject( QVectorSpaces,

  function( morphism )
    local homalg_matrix;

    homalg_matrix := morphism!.morphism;

    return QVectorSpace( NrColumns( homalg_matrix ) - RowRankOfMatrix( homalg_matrix ) );

end );

##
AddCokernelProjectionWithGivenCokernelObject( QVectorSpaces,

  function( morphism, cokernel )
    local cokernel_proj;

    cokernel_proj := SyzygiesOfColumns( morphism!.morphism );

    return QVectorSpaceMorphism( Range( morphism ), cokernel_proj, cokernel );

end );