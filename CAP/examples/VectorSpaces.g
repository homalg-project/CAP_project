
LoadPackage( "CAP" );

LoadPackage( "DeductiveSystemForCAP" );

LoadPackage( "MatricesForHomalg" );

#ProfileFunctionsInGlobalVariables( true );
#ProfileOperationsAndMethods( true );
#ProfileGlobalFunctions( true );

ProfileMethods( IsEqualForCache );

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

#######################################
##
## Operations
##
#######################################

DeclareOperation( "QVectorSpace",
                  [ IsInt ] );

DeclareOperation( "VectorSpaceMorphism",
                  [ IsHomalgRationalVectorSpaceRep, IsObject, IsHomalgRationalVectorSpaceRep ] );

vecspaces := CreateCapCategory( "VectorSpaces" );

SetIsAbelianCategory( vecspaces, true );

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
    
    space := ObjectifyWithAttributes( rec( ), TheTypeOfHomalgRationalVectorSpaces,
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
    
    objectified_morphism := ObjectifyWithAttributes( morphism, TheTypeOfHomalgRationalVectorSpaceMorphism,
                                                     Source, source,
                                                     Range, range
    );

    Add( vecspaces, objectified_morphism );
    
    return objectified_morphism;
    
end );

AddIsEqualForMorphisms( vecspaces,

  function( a, b )
  
    return a!.morphism = b!.morphism;
  
end );

AddIsCongruentForMorphisms( vecspaces,

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
AddLiftAlongMonomorphism( vecspaces,

  function( monomorphism, test_morphism )

    return VectorSpaceMorphism( Source( test_morphism ), RightDivide( test_morphism!.morphism, monomorphism!.morphism ), Source( monomorphism ) );

end );

##
AddColiftAlongEpimorphism( vecspaces,
  
  function( epimorphism, test_morphism )
    
    return VectorSpaceMorphism( Range( epimorphism ), LeftDivide( epimorphism!.morphism, test_morphism!.morphism ), Range( test_morphism ) );
    
end );

##
AddKernelObject( vecspaces,

  function( morphism )
    local homalg_matrix;

    homalg_matrix := morphism!.morphism;
  
    return QVectorSpace( NrRows( homalg_matrix ) - RowRankOfMatrix( homalg_matrix ) );

end );

##
AddKernelEmbedding( vecspaces,

  function( morphism )
    local kernel_emb, kernel_obj;
    
    kernel_emb := SyzygiesOfRows( morphism!.morphism );
    
    kernel_obj := QVectorSpace( NrRows( kernel_emb ) );
    
    return VectorSpaceMorphism( kernel_obj, kernel_emb, Source( morphism ) );
    
end );

##
AddKernelEmbeddingWithGivenKernelObject( vecspaces,

  function( morphism, kernel )
    local kernel_emb;

    kernel_emb := SyzygiesOfRows( morphism!.morphism );

    return VectorSpaceMorphism( kernel, kernel_emb, Source( morphism ) );

end );

##
AddCokernelObject( vecspaces,

  function( morphism )
    local homalg_matrix;

    homalg_matrix := morphism!.morphism;

    return QVectorSpace( NrColumns( homalg_matrix ) - RowRankOfMatrix( homalg_matrix ) );

end );


##
AddCokernelProjection( vecspaces,

  function( morphism )
    local cokernel_proj, cokernel_obj;

    cokernel_proj := SyzygiesOfColumns( morphism!.morphism );

    cokernel_obj := QVectorSpace( NrColumns( cokernel_proj ) );

    return VectorSpaceMorphism( Range( morphism ), cokernel_proj, cokernel_obj );

end );

##
AddCokernelProjectionWithGivenCokernelObject( vecspaces,

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
#     dim := Sum( List( object_product_list, c -> Dimension( c ) ) );
#     
#     return QVectorSpace( dim );
#   
# end );

##
## the user may assume that Length( object_product_list ) > 1
AddInjectionOfCofactorOfDirectSum( vecspaces,

  function( object_product_list, injection_number )
    local components, dim, dim_pre, dim_post, dim_cofactor, coproduct, number_of_objects, injection_of_cofactor;
    
    components := object_product_list;
    
    number_of_objects := Length( components );
    
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
## the user may assume that Length( object_product_list ) > 1
AddInjectionOfCofactorOfDirectSumWithGivenDirectSum( vecspaces,

  function( object_product_list, injection_number, coproduct )
    local components, dim_pre, dim_post, dim_cofactor, number_of_objects, injection_of_cofactor;
    
    components := object_product_list;
    
    number_of_objects := Length( object_product_list );
    
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
AddUniversalMorphismFromDirectSum( vecspaces,

  function( diagram, sink )
    local dim, coproduct, components, universal_morphism, morphism;
    
    components := sink;
    
    dim := Sum( components, c -> Dimension( Source( c ) ) );
    
    coproduct := QVectorSpace( dim );
    
    universal_morphism := sink[1]!.morphism;
    
    for morphism in components{ [ 2 .. Length( components ) ] } do
    
      universal_morphism := UnionOfRows( universal_morphism, morphism!.morphism );
  
    od;
  
    return VectorSpaceMorphism( coproduct, universal_morphism, Range( sink[1] ) );
  
end );

##
AddUniversalMorphismFromDirectSumWithGivenDirectSum( vecspaces,

  function( diagram, sink, coproduct )
    local components, universal_morphism, morphism;
    
    components := sink;
    
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
    
    dim := Sum( List( object_product_list, c -> Dimension( c ) ) );
    
    return QVectorSpace( dim );
  
end );

# ##
# AddDirectProduct( vecspaces,
# 
#   function( object_product_list )
#     local dim;
#     
#     dim := Sum( List( object_product_list, c -> Dimension( c ) ) );
#     
#     return QVectorSpace( dim );
#   
# end );

#
# the user may assume that Length( object_product_list ) > 1
AddProjectionInFactorOfDirectSum( vecspaces,

  function( object_product_list, projection_number )
    local components, dim, dim_pre, dim_post, dim_factor, direct_product, number_of_objects, projection_in_factor;
    
    components := object_product_list;
    
    number_of_objects := Length( components );
    
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
## the user may assume that Length( object_product_list ) > 1
AddProjectionInFactorOfDirectSumWithGivenDirectSum( vecspaces,

  function( object_product_list, projection_number, direct_product )
    local components, dim_pre, dim_post, dim_factor, number_of_objects, projection_in_factor;
    
    components := object_product_list;
    
    number_of_objects := Length( components );
    
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

AddUniversalMorphismIntoDirectSum( vecspaces,

  function( diagram, sink )
    local dim, direct_product, components, universal_morphism, morphism;
    
    components := sink;
    
    dim := Sum( components, c -> Dimension( Range( c ) ) );
    
    direct_product := QVectorSpace( dim );
    
    universal_morphism := sink[1]!.morphism;
    
    for morphism in components{ [ 2 .. Length( components ) ] } do
    
      universal_morphism := UnionOfColumns( universal_morphism, morphism!.morphism );
  
    od;
  
    return VectorSpaceMorphism( Source( sink[1] ), universal_morphism, direct_product );
  
end );

AddUniversalMorphismIntoDirectSumWithGivenDirectSum( vecspaces,

  function( diagram, sink, direct_product )
    local components, universal_morphism, morphism;
    
    components := sink;
    
    universal_morphism := sink[1]!.morphism;
    
    for morphism in components{ [ 2 .. Length( components ) ] } do
    
      universal_morphism := UnionOfColumns( universal_morphism, morphism!.morphism );
  
    od;
  
    return VectorSpaceMorphism( Source( sink[1] ), universal_morphism, direct_product );
  
end );

##
AddUniversalMorphismIntoZeroObject( vecspaces,

  function( sink )
    local morphism;

    morphism := VectorSpaceMorphism( sink, HomalgZeroMatrix( Dimension( sink ), 0, VECTORSPACES_FIELD ), QVectorSpace( 0 ) );

    return morphism;

end );

##
AddUniversalMorphismIntoZeroObjectWithGivenZeroObject( vecspaces,

  function( sink, terminal_object )
    local morphism;

    morphism := VectorSpaceMorphism( sink, HomalgZeroMatrix( Dimension( sink ), 0, VECTORSPACES_FIELD ), terminal_object );

    return morphism;

end );

##
AddZeroObject( vecspaces,

  function( )

    return QVectorSpace( 0 );

end );

##
AddUniversalMorphismFromZeroObject( vecspaces,

  function( source )
    local morphism;

    morphism := VectorSpaceMorphism( QVectorSpace( 0 ), HomalgZeroMatrix( 0, Dimension( source ), VECTORSPACES_FIELD ), source );

    return morphism;

end );

##
AddUniversalMorphismFromZeroObjectWithGivenZeroObject( vecspaces,

  function( source, initial_object )
    local morphism;

    morphism := VectorSpaceMorphism( initial_object, HomalgZeroMatrix( 0, Dimension( source ), VECTORSPACES_FIELD ), source );

    return morphism;

end );

##
AddIsWellDefinedForObjects( vecspaces,

  function( vectorspace )
  
    return IsHomalgRationalVectorSpaceRep( vectorspace ) and Dimension( vectorspace ) >= 0;
  
end );

##
AddIsWellDefinedForMorphisms( vecspaces,

  function( morphism )
    local matrix;
    
    if not IsHomalgRationalVectorSpaceMorphismRep( morphism ) then
      return false;
    fi;
    
    matrix := morphism!.morphism;
    
    return     IsHomalgMatrix( matrix )
           and NrRows( matrix ) = Dimension( Source( morphism ) )
           and NrColumns( matrix ) = Dimension( Range( morphism ) );
    
end );
# 
# AddIsZeroForObjects( vecspaces,
# 
#   function( obj )
#   
#     return Dimension( obj ) = 0;
#   
# end );
# 
# AddIsMonomorphism( vecspaces,
# 
#   function( morphism )
#   
#     return RowRankOfMatrix( morphism!.morphism ) = Dimension( Source( morphism ) );
#   
# end );
# 
# AddIsEpimorphism( vecspaces,
# 
#   function( morphism )
#   
#     return ColumnRankOfMatrix( morphism!.morphism ) = Dimension( Range( morphism ) );
#   
# end );
# 
# AddIsIsomorphism( vecspaces,
# 
#   function( morphism )
#   
#     return Dimension( Range( morphism ) ) = Dimension( Source( morphism ) ) 
#            and ColumnRankOfMatrix( morphism!.morphism ) = Dimension( Range( morphism ) );
#   
# end );

# ##
# AddImageObject( vecspaces,
# 
#   function( morphism )
#   
#     return QVectorSpace( RowRankOfMatrix( morphism!.morphism ) );
#   
# end );

AddIsEqualForObjects( vecspaces,
  
  function( vecspace_1, vecspace_2 )
    
    return Dimension( vecspace_1 ) = Dimension( vecspace_2 );
    
end );

Finalize( vecspaces );

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
## Snake-Lemma test
##
#######################################

eta := VectorSpaceMorphism( T, [ [ 1, 1 ], [ 2, 2 ] ], T );

eta := InDeductiveSystem( eta );

SetIsAbelianCategory( CapCategory( eta ), true );

#######################################
##
## Functorial methods tests
##
#######################################

A := QVectorSpace( 2 );

A_p := QVectorSpace( 2 );

B := QVectorSpace( 2 );

B_p := QVectorSpace( 2 );

alpha := VectorSpaceMorphism( A, [ [ 0, 0 ], [ 0, 1 ] ], B );

alpha_p := VectorSpaceMorphism( A_p, [ [ 0, 0 ], [ 0, 1 ] ], B_p );

mu := VectorSpaceMorphism( A, [ [ 1, 0 ], [ 0, 0 ] ], A_p );

nu := VectorSpaceMorphism( B, [ [ 1, 0 ], [ 0, 0 ] ], B_p );

# KernelObjectFunctorial( mu, alpha, nu );

#######################################
##
## Functors
##
#######################################

Tensor_Product_For_VecSpaces := CapFunctor( "Tensor_Product_For_VecSpaces", Product( vecspaces, vecspaces ), vecspaces );

AddObjectFunction( Tensor_Product_For_VecSpaces,
                   
  function( vecspace_pair )
    
    return QVectorSpace( Dimension( vecspace_pair[ 1 ] ) * Dimension( vecspace_pair[ 2 ] ) );
    
end );

AddMorphismFunction( Tensor_Product_For_VecSpaces,
                     
  function( new_source, morphism, new_range )
    
    return VectorSpaceMorphism( new_source, KroneckerMat( morphism[ 1 ]!.morphism, morphism[ 2 ]!.morphism ), new_range );
    
end );

Change_Components := CapFunctor( "change_components", Product( vecspaces, vecspaces ), Product( vecspaces, vecspaces ) );

AddObjectFunction( Change_Components,
                   
  function( vecspace_pair )
    
    return Product( vecspace_pair[ 2 ], vecspace_pair[ 1 ] );
    
end );

AddMorphismFunction( Change_Components,
                   
  function( new_source, morphism_pair, new_range )
    
    return Product( morphism_pair[ 2 ], morphism_pair[ 1 ] );
    
end );

####################################
##
## Generalized morphisms
##
####################################

## use tau as associated morphism

# tau_source_aid := VectorSpaceMorphism( Source( tau ), [ [ 1, 1, 0 ], [ 0, 1, 1 ] ], QVectorSpace( 3 ) );
# 
# tau_range_aid := VectorSpaceMorphism( QVectorSpace( 3 ), [ [ 1, 0 ], [ 1, 1 ], [ 0, 1 ] ], Range( tau ) );
# 
# GeneralizedMorphism( tau_source_aid, tau, tau_range_aid );
# 
# ## 
# 
# BB := QVectorSpace( 3 );
# 
# factor := VectorSpaceMorphism( BB, [ [ 1, -1 ], [ 3, 7 ], [ 21, 4 ] ], QVectorSpace( 2 ) );
# 
# sub := VectorSpaceMorphism( QVectorSpace( 2 ), [ [ 1, -1, 2 ], [ 3, -1, 11 ] ], BB );
# 
# # factor := VectorSpaceMorphism( BB, [ [ 1 ], [ 3 ], [ 21 ] ], QVectorSpace( 1 ) );
# # 
# # sub := VectorSpaceMorphism( QVectorSpace( 2 ), [ [ 1, -1, 2 ], [ 3, -1, 11 ] ], BB );
# 
# # factor := VectorSpaceMorphism( BB, [  ], QVectorSpace( 0 ) );
# # 
# # sub := VectorSpaceMorphism( QVectorSpace( 2 ), [ [ 1, -1, 2 ], [ 3, -1, 11 ] ], BB );
# 
# # factor := VectorSpaceMorphism( BB, [ [ 1 ], [ 3 ], [ 21 ] ], QVectorSpace( 1 ) );
# # 
# # sub := VectorSpaceMorphism( QVectorSpace( 0 ), [ ], BB );
# 
# phi_tilde_associated := VectorSpaceMorphism( A, [ [ 1, 2, 0 ] ], C );
# 
# phi_tilde_source_aid := VectorSpaceMorphism( A, [ [ 1, 2 ] ], B );
# 
# phi_tilde := GeneralizedMorphismWithSourceAid( phi_tilde_source_aid, phi_tilde_associated );
# 
# psi_tilde_associated := IdentityMorphism( B );
# 
# psi_tilde_source_aid := VectorSpaceMorphism( B, [ [ 1, 0, 0 ] ,[ 0, 1, 0 ] ], C );
# 
# psi_tilde := GeneralizedMorphismWithSourceAid( psi_tilde_source_aid, psi_tilde_associated );
# 
# PreCompose( phi_tilde, psi_tilde );
# 
# phi2_tilde_associated := VectorSpaceMorphism( A, [ [ 1, 5 ] ], B );
# 
# phi2_tilde_range_aid := VectorSpaceMorphism( C, [ [ 1, 0 ], [ 0, 1 ], [ 1, 1 ] ], B );
# 
# phi2_tilde := GeneralizedMorphismWithRangeAid( phi2_tilde_associated, phi2_tilde_range_aid );
# 
# psi2_tilde_associated := VectorSpaceMorphism( C, [ [ 1 ], [ 3 ], [ 4 ] ], A );
# 
# psi2_tilde_range_aid := VectorSpaceMorphism( B, [ [ 1 ], [ 1 ] ], A );
# 
# psi2_tilde := GeneralizedMorphismWithRangeAid( psi2_tilde_associated, psi2_tilde_range_aid );
# 
# composition := PreCompose( phi2_tilde, psi2_tilde );

# phi3_associated := VectorSpaceMorphism( B, [ [ 1, 0 ], [ 0, 1 ] ], B );
# 
# phi3_range_aid := VectorSpaceMorphism( C, [ [ 1, 0 ], [ 0, 1 ], [ 0, 0 ] ], B );
# 
# psi3_associated := VectorSpaceMorphism( B, [ [ 1, 0 ], [ 0, 1 ] ], B );
# 
# psi3_source_aid := VectorSpaceMorphism( B, [ [ 0,1,0],[0,0,1]], C );
# 
# phi3 := GeneralizedMorphismWithRangeAid( phi3_associated, phi3_range_aid );
# 
# psi3 := GeneralizedMorphismWithSourceAid( psi3_source_aid, psi3_associated );
# 
# PreCompose( phi3, psi3 );

####################################
##
## Natural transformation
##
####################################

##
identity_functor := IdentityMorphism( AsCatObject( vecspaces ) );

##
zero_object := CapFunctor( "Zero functor of VectorSpaces", vecspaces, vecspaces );

AddObjectFunction( zero_object,
                   
  function( obj )
    
    return ZeroObject( obj );
    
end );

AddMorphismFunction( zero_object,
                     
  function( zero1, morphism, zero2 )
    
    return VectorSpaceMorphism( zero1, [ ], zero2 );
    
end );

id_to_zero := NaturalTransformation( "One to zero in VectorSpaces", identity_functor, zero_object );

# psi3 := GeneralizedMorphismWithSourceAid( psi3_source_aid, psi3_associated );
# 
# PreCompose( phi3, psi3 );

AddNaturalTransformationFunction( id_to_zero,
                                  
  function( one_obj, obj, zero )
    
    return MorphismIntoZeroObject( obj );
    
end );

##
double_functor := CapFunctor( "Double of Vecspaces", vecspaces, vecspaces );

AddObjectFunction( double_functor,
                   
  function( obj )
    
    return QVectorSpace( 2 * Dimension( obj ) );
    
end );

AddMorphismFunction( double_functor,
                     
  function( new_source, mor, new_range )
    local matr, matr1;
    
    matr := EntriesOfHomalgMatrixAsListList( mor!.morphism );
    
    matr := Concatenation( List( matr, i -> Concatenation( i, ListWithIdenticalEntries( Length( i ), 0 ) ) ), 
                           List( matr, i -> Concatenation( ListWithIdenticalEntries( Length( i ), 0 ), i ) ) );
    
    return VectorSpaceMorphism( new_source, matr, new_range );
    
end );

id_to_double := NaturalTransformation( "Id to double in vecspaces", identity_functor, double_functor );

AddNaturalTransformationFunction( id_to_double,
                                  
  function( new_source, obj, new_range )
    local dim, matr;
    
    dim := Dimension( obj );
    
    matr := IdentityMat( dim );
    
    matr := List( matr, i -> Concatenation( i, i ) );
    
    return VectorSpaceMorphism( new_source, matr, new_range );
    
end );

double_swap_components := NaturalTransformation( "double swap components", double_functor, double_functor );

AddNaturalTransformationFunction( double_swap_components,
  
  function( doubled_source, obj, doubled_range )
    local zero_morphism, one_morphism;
    
    zero_morphism := ZeroMorphism( obj, obj );
    
    one_morphism := IdentityMorphism( obj );
    
    return MorphismBetweenDirectSums( [ [ zero_morphism, one_morphism ], [ one_morphism, zero_morphism ] ] );
    
end );

composition_of_double_swap_components := VerticalPreCompose( double_swap_components, double_swap_components );

ApplyNaturalTransformation( composition_of_double_swap_components, A );

# theorem_string := "\alpha:Mor, \beta:Mor ~|~ \IsMonomorphism( \alpha ) \vdash \IsMonomorphism( \ProjectionInFactorOfFiberProduct( [ \alpha, \beta ], 2 ) )";
# 
# ADD_THEOREM_TO_CATEGORY( vecspaces, PARSE_THEOREM_FROM_LATEX( theorem_string ) );

# @Theorem
# A | ( For all x in A : IsZero( x ) = true ) => IsZero( DirectProduct( A ) ) = true.
# A:\Obj ~|~ \IsZero( A ) \vdash \IsInjective( A )
# @EndTheorem
# @Proof
# bla bla bla bla
# # @EndProof
# 
# eval_rule := rec( command := "PreCompose",
#                   commands_to_check := [ [ [ 1 ], "UniversalMorphismIntoFiberProduct" ],
#                                          [ [ 2 ], "ProjectionInFactorOfFiberProduct" ] ],
#                   cells_to_check := [ [ [ 1, 1, 1 ], [ 2, 1, 1 ] ],
#                                       [ [ 1, 1, 2 ], [ 2, 1, 2 ] ],
#                                       [ [ 2, 2 ], 2 ]
#                                     ],
#                   part_to_replace := [ 1, 2, 1 ],
#                   ## TODO:
#                   part_for_is_well_defined := [ [ "IsCongruentForMorphisms", [ [ "PreCompose", [ [ 1, 2, 1 ], [ 1, 1, 1 ] ] ], [ "PreCompose", [ [ 1, 2, 2 ], [ 1, 1, 2 ] ] ] ] ] ] );
# 
# eval_rule := REMOVE_CHARACTERS_FROM_LATEX( "A, B:Obj, tau_A, tau_B:Mor |~ &()vdash &Precompose(InjectionOfCofactorOfCoproduct( [A, B], 1 ),&UniversalMorphismFromCoproduct( [A,B], [tau_A, tau_B] ) ) = tau_A" );
