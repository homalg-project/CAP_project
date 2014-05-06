
LoadPackage( "CategoriesForHomalg" );

LoadPackage( "MatricesForHomalg" );

###################################
##
## Types and Representations
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
## Attributes
##
###################################
                
DeclareAttribute( "Dimension",
                  IsHomalgRationalVectorSpaceRep );

#######################################
##
## Operations
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
## Categorical Implementations
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

    Add( vecspaces, morphism );
    
    return morphism;
    
end );

##
AddIdentityMorphism( vecspaces,
                     
  function( obj )

    return VectorSpaceMorphism( obj, HomalgIdentityMatrix( Dimension( obj ), VECTORSPACES_FIELD ), obj );
    
end );

##
AddPreCompose( vecspaces,

  function( mor_left, mor_right )
    local composition;

    composition := mor_left!.morphism * mor_right!.morphism;

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

    return VectorSpaceMorphism( Source( test_morphism ), RightDivide( test_morphism!.morphism, monomorphism!.morphism ), Source( monomorphism ) );

end );

##
AddEpiAsCokernelColift( vecspaces,
  
  function( epimorphism, test_morphism )
    
    return VectorSpaceMorphism( Range( epimorphism ), LeftDivide( epimorphism!.morphism, test_morphism!.morphism ), Range( test_morphism ) );
    
end );

##
AddKernel( vecspaces,

  function( morphism )
    local homalg_matrix;

    homalg_matrix := morphism!.morphism;
  
    return QVectorSpace( NrRows( homalg_matrix ) - RowRankOfMatrix( homalg_matrix ) );

end );

##
AddKernelEmb( vecspaces,

  function( morphism )
    local kernel_emb, kernel_obj;
    
    kernel_emb := SyzygiesOfRows( morphism!.morphism );
    
    kernel_obj := QVectorSpace( NrRows( kernel_emb ) );
    
    return VectorSpaceMorphism( kernel_obj, kernel_emb, Source( morphism ) );
    
end );

##
AddKernelEmbWithGivenKernel( vecspaces,

  function( morphism, kernel )
    local kernel_emb;

    kernel_emb := SyzygiesOfRows( morphism!.morphism );

    return VectorSpaceMorphism( kernel, kernel_emb, Source( morphism ) );

end );

##
AddCokernel( vecspaces,

  function( morphism )
    local homalg_matrix;

    homalg_matrix := morphism!.morphism;

    return QVectorSpace( NrColumns( homalg_matrix ) - RowRankOfMatrix( homalg_matrix ) );

end );


##
AddCokernelProj( vecspaces,

  function( morphism )
    local cokernel_proj, cokernel_obj;

    cokernel_proj := SyzygiesOfColumns( morphism!.morphism );

    cokernel_obj := QVectorSpace( NrColumns( cokernel_proj ) );

    return VectorSpaceMorphism( Range( morphism ), cokernel_proj, cokernel_obj );

end );

##
AddCokernelProjWithGivenCokernel( vecspaces,

  function( morphism, cokernel )
    local cokernel_proj;

    cokernel_proj := SyzygiesOfRows( morphism!.morphism );

    return VectorSpaceMorphism( Range( morphism ), cokernel_proj, cokernel );

end );

##
AddDirectProduct( vecspaces,

  function( a, b )
    local dim;

    dim := Dimension( a ) + Dimension( b );

    return QVectorSpace( dim );

end );

##
AddProjectionInFirstFactorOfDirectProduct( vecspaces,

  function( a, b )
    local direct_product, projection_in_first_factor;
    
    direct_product := QVectorSpace( Dimension( a ) + Dimension( b ) );

    projection_in_first_factor := UnionOfRows( HomalgIdentityMatrix( Dimension( a ), VECTORSPACES_FIELD ),
                                               HomalgZeroMatrix( Dimension( b ), Dimension( a ), VECTORSPACES_FIELD ) );
    
    return VectorSpaceMorphism( direct_product, projection_in_first_factor, a );

end );

##
AddProjectionInFirstFactorOfDirectProductWithGivenDirectProduct( vecspaces,

  function( a, direct_product )
    local projection_in_first_factor;

    projection_in_first_factor := UnionOfRows( HomalgIdentityMatrix( Dimension( a ), VECTORSPACES_FIELD ),
                                               HomalgZeroMatrix( Dimension( direct_product ) - Dimension( a ), Dimension( a ), VECTORSPACES_FIELD ) );


    return VectorSpaceMorphism( direct_product, projection_in_first_factor, a );

end );

##
AddProjectionInSecondFactorOfDirectProduct( vecspaces,

  function( a, b )
    local direct_product, projection_in_first_factor;

    direct_product := QVectorSpace( Dimension( a ) + Dimension( b ) );

    projection_in_first_factor := UnionOfRows( HomalgZeroMatrix( Dimension( b ), Dimension( a ), VECTORSPACES_FIELD ),
                                               HomalgIdentityMatrix( Dimension( a ), VECTORSPACES_FIELD )
                                             );

    return VectorSpaceMorphism( direct_product, projection_in_first_factor, a );

end );

##
AddProjectionInSecondFactorOfDirectProductWithGivenDirectProduct( vecspaces,

  function( a, direct_product )
    local projection_in_first_factor;

    projection_in_first_factor := UnionOfRows( HomalgZeroMatrix( Dimension( direct_product ) - Dimension( a ), Dimension( a ), VECTORSPACES_FIELD ),
                                               HomalgIdentityMatrix( Dimension( a ), VECTORSPACES_FIELD )
                                             );

    return VectorSpaceMorphism( direct_product, projection_in_first_factor, a );

end );

##
AddUniversalMorphismIntoDirectProduct( vecspaces,

  function( mor_to_A, mor_to_B )
    local direct_product;

    direct_product := QVectorSpace( Dimension( Range( mor_to_A ) ) + Dimension( Range( mor_to_B ) ) );
  
    return VectorSpaceMorphism( Source( mor_to_A ), UnionOfColumns( mor_to_A!.morphism, mor_to_B!.morphism ), direct_product );

end );

##
AddUniversalMorphismIntoDirectProductWithGivenDirectProduct( vecspaces,

  function( mor_to_A, mor_to_B, direct_product )

    return VectorSpaceMorphism( Source( mor_to_A ), UnionOfColumns( mor_to_A!.morphism, mor_to_B!.morphism ), direct_product );

end );

##
AddTerminalObject( vecspaces,

  function( )

    return QVectorSpace( 0 );

end );

##
AddUniversalMorphismIntoTerminalObject( vecspaces,

  function( sink )
    local morphism;

    morphism := VectorSpaceMorphism( sink, HomalgZeroMatrix( Dimension( sink ), 0, VECTORSPACES_FIELD ), QVectorSpace( 0 ) );

    return morphism;

end );

##
AddUniversalMorphismIntoTerminalObjectWithGivenTerminalObject( vecspaces,

  function( sink, terminal_object )
    local morphism;

    morphism := VectorSpaceMorphism( sink, HomalgZeroMatrix( Dimension( sink ), 0, VECTORSPACES_FIELD ), terminal_object );

    return morphism;

end );

##
AddInitialObject( vecspaces,

  function( )

    return QVectorSpace( 0 );

end );

##
AddUniversalMorphismFromInitialObject( vecspaces,

  function( source )
    local morphism;

    morphism := VectorSpaceMorphism( QVectorSpace( 0 ), HomalgZeroMatrix( 0, Dimension( source ), VECTORSPACES_FIELD ), source );

    return morphism;

end );

##
AddUniversalMorphismFromInitialObjectWithGivenInitialObject( vecspaces,

  function( source, initial_object )
    local morphism;

    morphism := VectorSpaceMorphism( initial_object, HomalgZeroMatrix( 0, Dimension( source ), VECTORSPACES_FIELD ), source );

    return morphism;

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
# 
#     Print( String( obj!.morphism ) );
  
    Display( obj!.morphism );

end );

#######################################
##
## Test
##
#######################################

T := QVectorSpace( 2 );

B := QVectorSpace( 2 );

A := QVectorSpace( 1 );


# KernelLift Test:
tau := VectorSpaceMorphism( T, [ [ 1, 1 ], [ 1, 1 ] ], B );

theta := VectorSpaceMorphism( A, [ [ 2, -2 ] ], T );

# KernelLift( tau, theta );
# 
# # Inverse Test
# alpha := VectorSpaceMorphism( T, [ [ 1, 2 ], [ 3, 4 ] ], B );
# 
# Inverse( alpha );
# 
# #CokernelColift Test:
# tau2 := VectorSpaceMorphism( B, [ [ 1, 1 ], [ 1, 1 ] ], T );
# 
# CokernelColift( theta, tau2 );

# Universal morphism of direct product

alpha := VectorSpaceMorphism( T, [ [ 3 ], [ 4 ] ], A );

beta := VectorSpaceMorphism( T, [ [ 1, 1 ], [ 1, 1 ] ], B );

gamma := VectorSpaceMorphism( T, [ [ 1, 2 ], [ 3, 4 ] ], B );

#######################################
##
## Functors
##
#######################################

Tensor_Product := HomalgFunctor( "tensor_product", Product( vecspaces, vecspaces ), vecspaces );

AddObjectFunction( Tensor_Product,
                   
  function( vecspace_pair )
    
    return QVectorSpace( Dimension( vecspace_pair[ 1 ] ) * Dimension( vecspace_pair[ 2 ] ) );
    
end );

AddMorphismFunction( Tensor_Product,
                     
  function( new_source, morphism, new_range )
    
    return VectorSpaceMorphism( new_source, KroneckerMat( morphism[ 1 ]!.morphism, morphism[ 2 ]!.morphism ), new_range );
    
end );

Change_Components := HomalgFunctor( "change_components", Product( vecspaces, vecspaces ), Product( vecspaces, vecspaces ) );

AddObjectFunction( Change_Components,
                   
  function( vecspace_pair )
    
    return Product( vecspace_pair[ 2 ], vecspace_pair[ 1 ] );
    
end );

AddMorphismFunction( Change_Components,
                   
  function( new_source, morphism_pair, new_range )
    
    return Product( morphism_pair[ 2 ], morphism_pair[ 1 ] );
    
end );
