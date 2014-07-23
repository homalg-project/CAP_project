
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

SetIsAdditiveCategory( vecspaces, true );

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

AddEqualityOfMorphisms( vecspaces,

  function( a, b )
  
    return a!.morphism = b!.morphism;
  
end );

AddIsZeroForMorphisms( vecspaces,

  function( a )
    
    return IsZero( a!.morphism );
    
end );

AddAdditionForMorphisms( vecspaces,
                         
  function( a, b )
    
    return VectorSpaceMorphism( Source( a ), a!.morphism + b!.morphism, Range( a ) );
    
end );

AddAdditiveInverseForMorphisms( vecspaces,
                                
  function( a )
    
    return VectorSpaceMorphism( Source( a ), - a!.morphism, Range( a ) );
    
end );

AddZeroMorphism( vecspaces,
                     
  function( a, b )
    
    return VectorSpaceMorphism( a, HomalgZeroMatrix( Dimension( a ), Dimension( b ), VECTORSPACES_FIELD ), b );
    
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

    cokernel_proj := SyzygiesOfColumns( morphism!.morphism );

    return VectorSpaceMorphism( Range( morphism ), cokernel_proj, cokernel );

end );

# ##
# AddCoproduct( vecspaces,
# 
#   function( object_product_list )
#     local dim;
#     
#     dim := Sum( List( object_product_list!.Components, c -> Dimension( c ) ) );
#     
#     return QVectorSpace( dim );
#   
# end );

##
## the user may assume that Length( object_product_list!.Components ) > 1
AddInjectionOfCofactor( vecspaces,

  function( object_product_list, injection_number )
    local components, dim, dim_pre, dim_post, dim_cofactor, coproduct, number_of_objects, injection_of_cofactor;
    
    components := Components( object_product_list );
    
    number_of_objects := Length( Components( object_product_list ) );
    
    dim := Sum( components, c -> Dimension( c ) );
    
    dim_pre := Sum( components{ [ 1 .. injection_number - 1 ] }, c -> Dimension( c ) );
    
    dim_post := Sum( components{ [ injection_number + 1 .. number_of_objects ] }, c -> Dimension( c ) );
    
    dim_cofactor := Dimension( object_product_list[ injection_number ] );
    
    coproduct := QVectorSpace( dim );
    
    injection_of_cofactor := HomalgZeroMatrix( dim_cofactor, dim_pre ,VECTORSPACES_FIELD );
    
    injection_of_cofactor := UnionOfColumns( injection_of_cofactor, 
                                         HomalgIdentityMatrix( dim_cofactor, VECTORSPACES_FIELD ) );
    
    injection_of_cofactor := UnionOfColumns( injection_of_cofactor, 
                                         HomalgZeroMatrix( dim_cofactor, dim_post, VECTORSPACES_FIELD ) );
    
    return VectorSpaceMorphism( object_product_list[ injection_number ], injection_of_cofactor, coproduct );

end );

##
## the user may assume that Length( object_product_list!.Components ) > 1
AddInjectionOfCofactorWithGivenCoproduct( vecspaces,

  function( object_product_list, coproduct, injection_number )
    local components, dim_pre, dim_post, dim_cofactor, number_of_objects, injection_of_cofactor;
    
    components := Components( object_product_list );
    
    number_of_objects := Length( Components( object_product_list ) );
    
    dim_pre := Sum( components{ [ 1 .. injection_number - 1 ] }, c -> Dimension( c ) );
    
    dim_post := Sum( components{ [ injection_number + 1 .. number_of_objects ] }, c -> Dimension( c ) );
    
    dim_cofactor := Dimension( object_product_list[ injection_number ] );
    
    injection_of_cofactor := HomalgZeroMatrix( dim_cofactor, dim_pre ,VECTORSPACES_FIELD );
    
    injection_of_cofactor := UnionOfColumns( injection_of_cofactor, 
                                         HomalgIdentityMatrix( dim_cofactor, VECTORSPACES_FIELD ) );
    
    injection_of_cofactor := UnionOfColumns( injection_of_cofactor, 
                                         HomalgZeroMatrix( dim_cofactor, dim_post, VECTORSPACES_FIELD ) );
    
    return VectorSpaceMorphism( object_product_list[ injection_number ], injection_of_cofactor, coproduct );

end );

##
AddUniversalMorphismFromCoproduct( vecspaces,

  function( sink )
    local dim, coproduct, components, universal_morphism, morphism;
    
    components := Components( sink );
    
    dim := Sum( components, c -> Dimension( Source( c ) ) );
    
    coproduct := QVectorSpace( dim );
    
    universal_morphism := sink[1]!.morphism;
    
    for morphism in components{ [ 2 .. Length( components ) ] } do
    
      universal_morphism := UnionOfRows( universal_morphism, morphism!.morphism );
  
    od;
  
    return VectorSpaceMorphism( coproduct, universal_morphism, Range( sink[1] ) );
  
end );

##
AddUniversalMorphismFromCoproductWithGivenCoproduct( vecspaces,

  function( sink, coproduct )
    local components, universal_morphism, morphism;
    
    components := Components( sink );
    
    universal_morphism := sink[1]!.morphism;
    
    for morphism in components{ [ 2 .. Length( components ) ] } do
    
      universal_morphism := UnionOfRows( universal_morphism, morphism!.morphism );
  
    od;
  
    return VectorSpaceMorphism( coproduct, universal_morphism, Range( sink[1] ) );
  
end );

##
AddDirectSum( vecspaces,

  function( object_product_list )
    local dim;
    
    dim := Sum( List( object_product_list!.Components, c -> Dimension( c ) ) );
    
    return QVectorSpace( dim );
  
end );

# ##
# AddDirectProduct( vecspaces,
# 
#   function( object_product_list )
#     local dim;
#     
#     dim := Sum( List( object_product_list!.Components, c -> Dimension( c ) ) );
#     
#     return QVectorSpace( dim );
#   
# end );

#
# the user may assume that Length( object_product_list!.Components ) > 1
AddProjectionInFactor( vecspaces,

  function( object_product_list, projection_number )
    local components, dim, dim_pre, dim_post, dim_factor, direct_product, number_of_objects, projection_in_factor;
    
    components := Components( object_product_list );
    
    number_of_objects := Length( Components( object_product_list ) );
    
    dim := Sum( components, c -> Dimension( c ) );
    
    dim_pre := Sum( components{ [ 1 .. projection_number - 1 ] }, c -> Dimension( c ) );
    
    dim_post := Sum( components{ [ projection_number + 1 .. number_of_objects ] }, c -> Dimension( c ) );
    
    dim_factor := Dimension( object_product_list[ projection_number ] );
    
    direct_product := QVectorSpace( dim );
    
    projection_in_factor := HomalgZeroMatrix( dim_pre, dim_factor, VECTORSPACES_FIELD );
    
    projection_in_factor := UnionOfRows( projection_in_factor, 
                                         HomalgIdentityMatrix( dim_factor, VECTORSPACES_FIELD ) );
    
    projection_in_factor := UnionOfRows( projection_in_factor, 
                                         HomalgZeroMatrix( dim_post, dim_factor, VECTORSPACES_FIELD ) );
    
    return VectorSpaceMorphism( direct_product, projection_in_factor, object_product_list[ projection_number ] );

end );

##
## the user may assume that Length( object_product_list!.Components ) > 1
AddProjectionInFactorWithGivenDirectProduct( vecspaces,

  function( object_product_list, direct_product, projection_number )
    local components, dim_pre, dim_post, dim_factor, number_of_objects, projection_in_factor;
    
    components := Components( object_product_list );
    
    number_of_objects := Length( Components( object_product_list ) );
    
    dim_pre := Sum( components{ [ 1 .. projection_number - 1 ] }, c -> Dimension( c ) );
    
    dim_post := Sum( components{ [ projection_number + 1 .. number_of_objects ] }, c -> Dimension( c ) );
    
    dim_factor := Dimension( object_product_list[ projection_number ] );
    
    projection_in_factor := HomalgZeroMatrix( dim_pre, dim_factor, VECTORSPACES_FIELD );
    
    projection_in_factor := UnionOfRows( projection_in_factor, 
                                         HomalgIdentityMatrix( dim_factor, VECTORSPACES_FIELD ) );
    
    projection_in_factor := UnionOfRows( projection_in_factor, 
                                         HomalgZeroMatrix( dim_post, dim_factor, VECTORSPACES_FIELD ) );
    
    return VectorSpaceMorphism( direct_product, projection_in_factor, object_product_list[ projection_number ] );

end );

AddUniversalMorphismIntoDirectProduct( vecspaces,

  function( sink )
    local dim, direct_product, components, universal_morphism, morphism;
    
    components := Components( sink );
    
    dim := Sum( components, c -> Dimension( Range( c ) ) );
    
    direct_product := QVectorSpace( dim );
    
    universal_morphism := sink[1]!.morphism;
    
    for morphism in components{ [ 2 .. Length( components ) ] } do
    
      universal_morphism := UnionOfColumns( universal_morphism, morphism!.morphism );
  
    od;
  
    return VectorSpaceMorphism( Source( sink[1] ), universal_morphism, direct_product );
  
end );

AddUniversalMorphismIntoDirectProductWithGivenDirectProduct( vecspaces,

  function( sink, direct_product )
    local components, universal_morphism, morphism;
    
    components := Components( sink );
    
    universal_morphism := sink[1]!.morphism;
    
    for morphism in components{ [ 2 .. Length( components ) ] } do
    
      universal_morphism := UnionOfColumns( universal_morphism, morphism!.morphism );
  
    od;
  
    return VectorSpaceMorphism( Source( sink[1] ), universal_morphism, direct_product );
  
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
# AddImage( vecspaces,
# 
#   function( morphism )
#   
#     return QVectorSpace( RowRankOfMatrix( morphism!.morphism ) );
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

C := QVectorSpace( 3 );

D := QVectorSpace( 1 );

f := VectorSpaceMorphism( B, [ [ 1 ], [ 1 ] ], A );

g := VectorSpaceMorphism( C, [ [ 1 ], [ -1 ], [ 1 ] ], A );

t1 := VectorSpaceMorphism( D, [ [ 1, 1 ] ], B );

t2 := VectorSpaceMorphism( D, [ [ 1, 0, 1 ] ], C );

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

Tensor_Product_For_VecSpaces := HomalgFunctor( "Tensor_Product_For_VecSpaces", Product( vecspaces, vecspaces ), vecspaces );

AddObjectFunction( Tensor_Product_For_VecSpaces,
                   
  function( vecspace_pair )
    
    return QVectorSpace( Dimension( vecspace_pair[ 1 ] ) * Dimension( vecspace_pair[ 2 ] ) );
    
end );

AddMorphismFunction( Tensor_Product_For_VecSpaces,
                     
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
