LoadPackage( "CAP" );

LoadPackage( "MatricesForHomalg" );

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

DeclareAttribute( "Dimension",
                  IsHomalgRationalVectorSpaceRep );

DeclareOperation( "QVectorSpace",
                  [ IsInt ] );

DeclareOperation( "VectorSpaceMorphism",
                  [ IsHomalgRationalVectorSpaceRep, IsObject, IsHomalgRationalVectorSpaceRep ] );

BindGlobal( "vecspaces", CreateCapCategory( "VectorSpaces" ) );

SetIsAbelianCategory( vecspaces, true );

BindGlobal( "VECTORSPACES_FIELD", HomalgFieldOfRationals( ) );

##
InstallMethod( QVectorSpace,
               [ IsInt ],
               
  function( dim )
    local space;
    
    space := rec( );
    
    ObjectifyWithAttributes( space, TheTypeOfHomalgRationalVectorSpaces,
                             Dimension, dim 
    );
    
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

AddIdentityMorphism( vecspaces,
                     
  function( obj )

    return VectorSpaceMorphism( obj, HomalgIdentityMatrix( Dimension( obj ), VECTORSPACES_FIELD ), obj );
    
end );

AddPreCompose( vecspaces,

  function( mor_left, mor_right )
    local composition;

    composition := mor_left!.morphism * mor_right!.morphism;

    return VectorSpaceMorphism( Source( mor_left ), composition, Range( mor_right ) );

end );

AddIsEqualForObjects( vecspaces,
  
  function( vecspace_1, vecspace_2 )
    
    return Dimension( vecspace_1 ) = Dimension( vecspace_2 );
    
end );

AddIsEqualForMorphisms( vecspaces,

  function( a, b )
  
    return a!.morphism = b!.morphism;
  
end );

AddKernelEmb( vecspaces,

  function( morphism )
    local kernel_emb, kernel_obj;
    
    kernel_emb := SyzygiesOfRows( morphism!.morphism );
    
    kernel_obj := QVectorSpace( NrRows( kernel_emb ) );
    
    return VectorSpaceMorphism( kernel_obj, kernel_emb, Source( morphism ) );
    
end );

AddKernelLift( vecspaces,

  function( morphism, test_morphism )
    local kernel_matrix;
    
    kernel_matrix := SyzygiesOfRows( morphism!.morphism );

    return VectorSpaceMorphism( Source( test_morphism ),
                                RightDivide( test_morphism!.morphism, kernel_matrix ),
                                QVectorSpace( NrRows( kernel_matrix ) ) );
    
end );

AddLiftAlongMonomorphism( vecspaces,

  function( monomorphism, test_morphism )

    return VectorSpaceMorphism( Source( test_morphism ),
           RightDivide( test_morphism!.morphism, monomorphism!.morphism ),
           Source( monomorphism ) );

end );

AddCokernelProjection( vecspaces,

  function( morphism )
    local cokernel_proj, cokernel_obj;

    cokernel_proj := SyzygiesOfColumns( morphism!.morphism );

    cokernel_obj := QVectorSpace( NrColumns( cokernel_proj ) );

    return VectorSpaceMorphism( Range( morphism ), 
              cokernel_proj, cokernel_obj );

end );

AddColiftAlongEpimorphism( vecspaces,
  
  function( epimorphism, test_morphism )
    
    return VectorSpaceMorphism( Range( epimorphism ),
              LeftDivide( epimorphism!.morphism, test_morphism!.morphism ),
              Range( test_morphism ) );
    
end );

AddZeroObject( vecspaces,

  function( )

    return QVectorSpace( 0 );

end );

AddUniversalMorphismIntoZeroObject( vecspaces,

  function( source )

    return VectorSpaceMorphism( source,
              HomalgZeroMatrix( Dimension( source ), 0, VECTORSPACES_FIELD ),
              QVectorSpace( 0 ) );
    
end );

AddUniversalMorphismIntoZeroObjectWithGivenZeroObject( vecspaces,

  function( source, terminal_object )

    return VectorSpaceMorphism( source,
              HomalgZeroMatrix( Dimension( source ), 0, VECTORSPACES_FIELD ),
              terminal_object );
    
end );

AddUniversalMorphismFromZeroObject( vecspaces,

  function( sink )
    
    return VectorSpaceMorphism( QVectorSpace( 0 ),
              HomalgZeroMatrix( 0, Dimension( sink ), VECTORSPACES_FIELD ),
              sink );
    
end );

AddUniversalMorphismFromZeroObjectWithGivenZeroObject( vecspaces,

  function( sink, initial_object )
    
    return VectorSpaceMorphism( initial_object,
                   HomalgZeroMatrix( 0, Dimension( sink ), VECTORSPACES_FIELD ),
                   sink );
    
end );

AddAdditionForMorphisms( vecspaces,
                         
  function( a, b )
    
    return VectorSpaceMorphism( Source( a ),
              a!.morphism + b!.morphism,
              Range( a ) );
    
end );

AddAdditiveInverseForMorphisms( vecspaces,
                                
  function( a )
    
    return VectorSpaceMorphism( Source( a ),
              - a!.morphism,
              Range( a ) );
    
end );

AddZeroMorphism( vecspaces,
                     
  function( a, b )
    
    return VectorSpaceMorphism( a,
              HomalgZeroMatrix( Dimension( a ),
                                Dimension( b ),
                                VECTORSPACES_FIELD ),
              b );
    
end );

AddDirectSum( vecspaces,

  function( object_product_list )
    local dim;
    
    dim := Sum( List( object_product_list, c -> Dimension( c ) ) );
    
    return QVectorSpace( dim );
  
end );

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

Finalize( vecspaces );


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

## Example

V := QVectorSpace( 2 );

W := QVectorSpace( 3 );

alpha := VectorSpaceMorphism( V, [ [ 1, 1, 1 ], [ -1, -1, -1 ] ], W );

KernelEmb( alpha );

CokernelObject( alpha );

CokernelProjection( alpha );

alpha + alpha;

- alpha;

IsMonomorphism( alpha );

IsEpimorphism( alpha );

alpha_image := ImageEmbedding( alpha );

alpha := VectorSpaceMorphism( V, [ [ 1, 0, 0 ], [ 0, 1, 1 ] ], W );

beta := VectorSpaceMorphism( V, [ [ 1, 1, 0 ], [ 0, 0, 1 ] ], W );

fiberproduct := FiberProduct( alpha, beta );

projection := ProjectionInFactor( fiberproduct, 1 );

intersection := PreCompose( projection, alpha );

# LoadPackage( "HomologicalAlgebraForCAP" );

V1 := QVectorSpace( 1 );

V2 := QVectorSpace( 2 );

V3 := QVectorSpace( 3 );

alpha2 := VectorSpaceMorphism( V3, [ [ 0, 0 ], [ 1, 0 ], [ 0, 1 ] ], V2 );

beta1 := VectorSpaceMorphism( V2, [ [ 1, 0, 0 ], [ 0, 1, 0 ] ], V3 );

gamma1 := VectorSpaceMorphism( V1, [ [ 1, 0 ] ], V2 );

gamma2 := IdentityMorphism( V3 );

gamma3 := VectorSpaceMorphism( V2, [ [ 0 ], [ 1 ] ], V1 );

# snake := SnakeLemmaConnectingHomomorphism( alpha2, gamma1, gamma2, gamma3, beta1 );

id_functor := CapFunctor( "Identity of vecspaces", vecspaces, vecspaces );

AddObjectFunction( id_functor, IdFunc );

AddMorphismFunction( id_functor, function( obj1, mor, obj2 ) return mor; end );

id_functor := IdentityMorphism( AsCatObject( vecspaces ) );

double_functor := CapFunctor( "DoubleOfVecspaces", 
                              vecspaces, vecspaces );

AddObjectFunction( double_functor,
                   
  function( obj )
    
    return QVectorSpace( 2 * Dimension( obj ) );
    
end );

AddMorphismFunction( double_functor,
                     
  function( new_source, mor, new_range )
    local matr, matr1;
    
    matr := EntriesOfHomalgMatrixAsListList( mor!.morphism );
    
    matr := Concatenation( List( matr,
                           i -> Concatenation( i, ListWithIdenticalEntries( Length( i ), 0 ) ) ),
                           List( matr,
                           i -> Concatenation( ListWithIdenticalEntries( Length( i ), 0 ), i ) ) );
    
    return VectorSpaceMorphism( new_source, matr, new_range );
    
end );

V2;

ApplyFunctor( double_functor, V2 );

alpha2;

ApplyFunctor( double_functor, alpha2 );

quadruple_functor := PreCompose( double_functor, double_functor );

ApplyFunctor( double_functor, V2 );

ApplyFunctor( quadruple_functor, alpha2 );

double_swap_components := NaturalTransformation( "double swap components", 
                            double_functor, double_functor );

AddNaturalTransformationFunction( double_swap_components,
  
  function( doubled_source, obj, doubled_range )
    local zero_morphism, one_morphism;
    
    zero_morphism := ZeroMorphism( obj, obj );
    
    one_morphism := IdentityMorphism( obj );
    
    return MorphismBetweenDirectSums( [ [ zero_morphism, one_morphism ],
                                        [ one_morphism, zero_morphism ] ] );
    
end );

ApplyNaturalTransformation( double_swap_components, V2 );

h_composition := HorizontalPreCompose( double_swap_components, double_swap_components );

ApplyNaturalTransformation( h_composition, V2 );

v_composition := VerticalPreCompose( double_swap_components, double_swap_components );

ApplyNaturalTransformation( v_composition, V2 );
