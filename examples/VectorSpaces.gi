
LoadPackage( "CategoriesForHomalg" );

LoadPackage( "MatricesForHomalg" );

###################################
##
#! @Types and Representations
##
###################################

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

###################################
##
#! @Attributes
##
###################################
                
DeclareAttribute( "Dimension",
                  IsHomalgRationalVectorSpaceRep );

#######################################
##
#! @Operations
##
#######################################
                  
DeclareOperation( "QVectorSpace",
                  [ IsInt ] );

DeclareOperation( "VectorSpaceMorphism",
                  [ IsHomalgRationalVectorSpaceRep, IsObject, IsHomalgRationalVectorSpaceRep ] );

                  
vecspaces := CreateHomalgCategory( "VectorSpaces" );

VECTORSPACES_FIELD := HomalgFieldOfRationals( );

#######################################
##
#! @Categorical Implementations
##
#######################################

##
InstallMethod( QVectorSpace,
               [ IsInt ],
               
  function( dim )
    local space;
    
    space := rec( );
    
    ObjectifyWithAttributes( space, TheTypeOfHomalgRationalVectorSpaces,
                             Dimension, dim 
    );

    # is this the right place?
    Add( vecspaces, space );
    
    return space;
    
end );

##
InstallMethod( VectorSpaceMorphism,
                  [ IsHomalgRationalVectorSpaceRep, IsObject, IsHomalgRationalVectorSpaceRep ],
                  
  function( source, matrix, range )
    local morphism;
    
    morphism := rec( Morphism := HomalgMatrix( matrix, Dimension( source ), Dimension( range ), VECTORSPACES_FIELD ) );
    
    ObjectifyWithAttributes( morphism, TheTypeOfHomalgRationalVectorSpaceMorphism,
                             Source, source,
                             Range, range 
    );

    Add( vecspaces, morphism );
    
    return morphism;
    
end );

##
AddIdentityMorphism( vecspaces,
                     
  function( obj )

    #why is this Eval necessary?
    return VectorSpaceMorphism( obj, HomalgIdentityMatrix( Dimension( obj ), VECTORSPACES_FIELD ), obj );
    
end );

##
AddPreCompose( vecspaces,

  function( mor_left, mor_right )
    local composition;

    composition := mor_left!.Morphism * mor_right!.Morphism;

    return VectorSpaceMorphism( Source( mor_left ), composition, Range( mor_right ) );

end );

##
AddZeroObject( vecspaces,

  function( )

    return QVectorSpace( 0 );

end );

##
AddMorphismIntoZeroObject( vecspaces,

  function( obj )
    local morphism;

    morphism := VectorSpaceMorphism( obj, HomalgZeroMatrix( Dimension( obj ), 0, VECTORSPACES_FIELD ), ZeroObject( obj ) );

    return morphism;

end );

##
AddMorphismFromZeroObject( vecspaces,

  function( obj )
    local morphism;

    morphism := VectorSpaceMorphism( ZeroObject( obj ), HomalgZeroMatrix( 0, Dimension( obj ), VECTORSPACES_FIELD ), obj );

    return morphism;

end );

##
AddMonoAsKernelLift( vecspaces,

  function( monomorphism, test_morphism )

    return VectorSpaceMorphism( Source( test_morphism ), RightDivide( test_morphism!.Morphism, monomorphism!.Morphism ), Source( monomorphism ) );

end );

##
AddEpiAsCokernelColift( vecspaces,
  
  function( epimorphism, test_morphism )
    
    return VectorSpaceMorphism( Range( epimorphism ), LeftDivide( epimorphism!.Morphism, test_morphism!.Morphism ), Range( test_morphism ) );
    
end );

##
AddKernelEmb( vecspaces,

  function( morphism )
    local kernel_emb, kernel_obj;
    
    kernel_emb := SyzygiesOfRows( morphism!.Morphism );
    
    kernel_obj := QVectorSpace( NrRows( kernel_emb ) );
    
    return VectorSpaceMorphism( kernel_obj, kernel_emb, Source( morphism ) );
    
end );

# ##
# AddDirectSum_OnObjects( vecspaces,
#                         
#   function( a, b )
#     local dim;
#     
#     dim := Dimension( a ) + Dimension( b );
#     
#     return QVectorSpace( dim );
#     
# end );
# 
# ##
# AddInjectionFromFirstSummand( vecspaces,
#                               
#   function( sum_obj )
#     local dim1, dim2, first_summand, matrix;
#     
#     first_summand := FirstSummand( sum_obj );
#     
#     dim1 := Dimension( first_summand );
#     
#     dim2 := Dimension( SecondSummand( sum_obj ) );
#     
#     matrix := TransposedMat( Concatenation( IdentityMat( dim1 ), NullMat( dim2, dim2 ) ) );
#     
#     return VectorSpaceMorphism( first_summand, matrix, sum_obj );
#     
# end );

#######################################
##
#! @View and Display
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
# 
#     Print( String( obj!.Morphism ) );
  
    Display( obj!.Morphism );

end );

#######################################
##
#! @Test
##
#######################################

T := QVectorSpace( 2 );

B := QVectorSpace( 2 );

A :=  QVectorSpace( 1 );

tau := VectorSpaceMorphism( T, [ [ 1, 1 ], [ 1, 1 ] ], B );

theta := VectorSpaceMorphism( A, [ [ 2, -2 ] ], T );

KernelLift( tau, theta );



