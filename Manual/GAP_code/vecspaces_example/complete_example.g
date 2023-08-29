LoadPackage( "CAP" );

LoadPackage( "RingsForHomalg" );

DeclareCategory( "IsSQVecCat",
                 IsCapCategory );

DeclareCategory( "IsSQVecObj",
                 IsCapCategoryObject );

DeclareCategory( "IsSQVecMor",
                 IsCapCategoryMorphism );

DeclareAttribute( "Dimension",
                  IsSQVecObj );

DeclareAttribute( "UnderlyingMatrix", 
                  IsSQVecMor );

DeclareOperation( "SQVecObj",
                  [ IsInt ] );

DeclareOperation( "SQVecMor",
                  [ IsSQVecObj, IsObject, IsSQVecObj ] );

BindGlobal( "SQVec", CreateCapCategory(
                             "Skeletal category of rational vector spaces",
                             IsSQVecCat,
                             IsSQVecObj,
                             IsSQVecMor,
                             IsCapCategoryTwoCell ) );

SetIsAbelianCategory( SQVec, true );

BindGlobal( "QQ", HomalgFieldOfRationals( ) );

##
InstallMethod( SQVecObj,
               [ IsInt ],
               
  function( dim )
        
        if dim < 0 then
            Error( "the given integer must be non-negative");
        fi;
        
        return CreateCapCategoryObjectWithAttributes( SQVec,
                                                      Dimension, dim );
        
end );

##
InstallMethod( SQVecMor,
               [ IsSQVecObj, IsObject, IsSQVecObj ],
                  
  function( source, matrix, range )
    local underlying_matrix;

    if not IsHomalgMatrix( matrix ) then
    
      underlying_matrix := 
        HomalgMatrix( matrix,
                      Dimension( source ),
                      Dimension( range ),
                      QQ );

    else

      underlying_matrix := matrix;

    fi;
    
    return CreateCapCategoryMorphismWithAttributes( SQVec,
                                                    source,
                                                    range,
                                                    UnderlyingMatrix, underlying_matrix );
    
end );

AddIdentityMorphism( SQVec,
                     
  function( cat, a )
    
    return SQVecMor( a,
                     HomalgIdentityMatrix( Dimension( a ), QQ ),
                     a );
    
end );

AddPreCompose( SQVec,

  function( cat, alpha, beta )
    local composition;

    composition := UnderlyingMatrix( alpha ) * UnderlyingMatrix( beta );

    return SQVecMor( Source( alpha ), composition, Range( beta ) );

end );

AddIsEqualForObjects( SQVec,
  
  function( cat, a, b )
    
    return Dimension( a ) = Dimension( b );
    
end );

equality_function := function( cat, alpha, beta )
  return UnderlyingMatrix( alpha ) = UnderlyingMatrix( beta );
end;

AddIsEqualForMorphisms( SQVec, equality_function );

AddIsCongruentForMorphisms( SQVec, equality_function );

AddKernelEmbedding( SQVec,

  function( cat, alpha )
    local kernel_emb, kernel_obj;
    
    kernel_emb := SyzygiesOfRows( UnderlyingMatrix( alpha ) );
    
    kernel_obj := SQVecObj( NrRows( kernel_emb ) );
    
    return SQVecMor( kernel_obj, kernel_emb, Source( alpha ) );
    
end );

AddKernelLift( SQVec,

  function( cat, alpha, test_object, tau )
    local kernel_matrix;
    
    kernel_matrix := SyzygiesOfRows( UnderlyingMatrix( alpha ) );

    return SQVecMor( Source( tau ),
                     RightDivide( UnderlyingMatrix( tau ), kernel_matrix ),
                     SQVecObj( NrRows( kernel_matrix ) ) );
    
end );

##
AddLiftAlongMonomorphism( SQVec,

  function( cat, mu, tau )

    return SQVecMor( Source( tau ),
                     RightDivide( UnderlyingMatrix( tau ), UnderlyingMatrix( mu ) ),
                     Source( mu ) );

end );

##
AddCokernelProjection( SQVec,

  function( cat, alpha )
    local cokernel_proj, cokernel_obj;

    cokernel_proj := SyzygiesOfColumns( UnderlyingMatrix( alpha ) );

    cokernel_obj := SQVecObj( NrColumns( cokernel_proj ) );

    return SQVecMor( Range( alpha ),
                     cokernel_proj,
                     cokernel_obj );

end );

##
AddColiftAlongEpimorphism( SQVec,
  
  function( cat, epsilon, tau )
    
    return SQVecMor( Range( epsilon ),
                     LeftDivide(
                       UnderlyingMatrix( epsilon ),
                       UnderlyingMatrix( tau ) ),
                     Range( tau ) );
    
end );

##
AddZeroObject( SQVec,

  function( cat )

    return SQVecObj( 0 );

end );

##
AddUniversalMorphismIntoZeroObject( SQVec,

  function( cat, source )

    return SQVecMor( source,
                     HomalgZeroMatrix( Dimension( source ), 0, QQ ),
                     SQVecObj( 0 ) );
    
end );

##
AddUniversalMorphismIntoZeroObjectWithGivenZeroObject( SQVec,

  function( cat, source, terminal_object )

    return SQVecMor( source,
                     HomalgZeroMatrix( Dimension( source ), 0, QQ ),
                     terminal_object );
    
end );

##
AddUniversalMorphismFromZeroObject( SQVec,

  function( cat, sink )
    
    return SQVecMor( SQVecObj( 0 ),
                     HomalgZeroMatrix( 0, Dimension( sink ), QQ ),
                     sink );
    
end );

##
AddUniversalMorphismFromZeroObjectWithGivenZeroObject( SQVec,

  function( cat, sink, initial_object )
    
    return SQVecMor( initial_object,
                     HomalgZeroMatrix( 0, Dimension( sink ), QQ ),
                     sink );
    
end );

##
AddAdditionForMorphisms( SQVec,
                         
  function( cat, alpha, beta )
    
    return SQVecMor( Source( alpha ),
                     UnderlyingMatrix( alpha ) + UnderlyingMatrix( beta ),
                     Range( alpha ) );
    
end );

##
AddAdditiveInverseForMorphisms( SQVec,
                                
  function( cat, alpha )
    
    return SQVecMor( Source( alpha ),
                     - UnderlyingMatrix( alpha ),
                     Range( alpha ) );
    
end );

##
AddZeroMorphism( SQVec,
                     
  function( cat, alpha, beta )
    
    return SQVecMor( alpha,
                     HomalgZeroMatrix( Dimension( alpha ),
                                       Dimension( beta ),
                                       QQ ),
                     beta );
    
end );

##
AddDirectSum( SQVec,

  function( cat, object_product_list )
    local dim;
    
    dim := Sum( List( object_product_list, c -> Dimension( c ) ) );
    
    return SQVecObj( dim );
  
end );

##
AddProjectionInFactorOfDirectSumWithGivenDirectSum( SQVec,
  function( cat, object_list, projection_number, direct_sum_object )
    local rank_pre, rank_post, rank_factor, number_of_objects,
    projection_in_factor;
    
    number_of_objects := Length( object_list );
    
    rank_pre := 
      Sum( object_list{ [ 1 .. projection_number - 1 ] },
           c -> Dimension( c ) );
    
    rank_post := 
      Sum( object_list{ [ projection_number + 1 .. number_of_objects ] },
           c -> Dimension( c ) );
    
    rank_factor := Dimension( object_list[ projection_number ] );
    
    projection_in_factor := 
      UnionOfRows( HomalgZeroMatrix( rank_pre, rank_factor, QQ ),
                   HomalgIdentityMatrix( rank_factor, QQ ),
                   HomalgZeroMatrix( rank_post, rank_factor, QQ )
      );
    
    return
      SQVecMor( direct_sum_object,
                projection_in_factor,
                object_list[ projection_number ] );
    
end );

##
AddUniversalMorphismIntoDirectSumWithGivenDirectSum( SQVec,
  function( cat, diagram, test_object, sink, direct_sum )
    local underlying_matrix_of_universal_morphism;
    
    underlying_matrix_of_universal_morphism :=
      UnionOfColumns(
        List( sink, UnderlyingMatrix )
    );
    
    return
      SQVecMor( Source( sink[1] ), 
                underlying_matrix_of_universal_morphism, 
                direct_sum );
  
end );

##
AddInjectionOfCofactorOfDirectSumWithGivenDirectSum( SQVec,
  function( cat, object_list, injection_number, coproduct )
    local rank_pre, rank_post, rank_cofactor, number_of_objects,
          injection_of_cofactor;
    
    number_of_objects := Length( object_list );
    
    rank_pre :=
      Sum( object_list{ [ 1 .. injection_number - 1 ] },
           c -> Dimension( c ) );
    
    rank_post :=
      Sum( object_list{ [ injection_number + 1 .. number_of_objects ] },
           c -> Dimension( c ) );
    
    rank_cofactor := Dimension( object_list[ injection_number ] );
    
    injection_of_cofactor := 
      UnionOfColumns( HomalgZeroMatrix( rank_cofactor, rank_pre ,QQ ),
                      HomalgIdentityMatrix( rank_cofactor, QQ ),
                      HomalgZeroMatrix( rank_cofactor, rank_post, QQ )
      );
    
    return
      SQVecMor( object_list[ injection_number ],
                injection_of_cofactor,
                coproduct );
    
end );

##
AddUniversalMorphismFromDirectSumWithGivenDirectSum( SQVec,
  function( cat, diagram, test_object, sink, coproduct )
    local underlying_matrix_of_universal_morphism;
    
    underlying_matrix_of_universal_morphism :=
      UnionOfRows(
        List( sink, UnderlyingMatrix )
    );
    
    return SQVecMor( coproduct,
                     underlying_matrix_of_universal_morphism,
                     Range( sink[1] ) );
    
end );

Finalize( SQVec );

##
InstallMethod( ViewString,
               [ IsSQVecObj ],

  function( a )

    return Concatenation( "<An object in SQVec of dimension ",
           String( Dimension( a ) ), ">" );

end );

##
InstallMethod( ViewString,
               [ IsSQVecMor ],

  function( morphism )

    return Concatenation( "A morphism in SQVec with underlying matrix:\n",
           StringDisplay( UnderlyingMatrix( morphism ) ) );

end );

## Example

V2 := SQVecObj( 2 );
V3 := SQVecObj( 3 );
alpha := SQVecMor( V2, [ [ 1, 1, 1 ], [ -1, -1, -1 ] ], V3 );

KernelEmbedding( alpha );
CokernelObject( alpha );
CokernelProjection( alpha );
alpha + alpha;
- alpha;

IsMonomorphism( alpha );
IsEpimorphism( alpha );
ImageEmbedding( alpha );

alpha := SQVecMor( V2, [ [ 1, 0, 0 ], [ 0, 1, 1 ] ], V3 );
beta := SQVecMor( V2, [ [ 1, 1, 0 ], [ 0, 0, 1 ] ], V3 );
intersection := MorphismFromFiberProductToSink( [ alpha, beta ] );

snake_lemma_morphism := function( delta, beta, lambda )
    local gamma, iota, epsilon, mu, alpha, pi, p1, p2, q1, q2, u;
    
    gamma := CokernelColift( delta, PreCompose( beta, lambda ) );
    iota := KernelEmbedding( gamma );
    epsilon := CokernelProjection( delta );
    mu := KernelEmbedding( lambda );
    alpha := KernelLift( lambda, PreCompose( delta, beta ) );
    pi := CokernelProjection( alpha );
    
    p1 := ProjectionInFactorOfFiberProduct( [ iota, epsilon ], 1 );

    p2 := ProjectionInFactorOfFiberProduct( [ iota, epsilon ], 2 );

    q1 := InjectionOfCofactorOfPushout( [ mu, pi ], 1 );

    q2 := InjectionOfCofactorOfPushout( [ mu, pi ], 2 );
    
    u := ColiftAlongEpimorphism( p1, PreCompose( [ p2, beta, q1 ] ) );

    return LiftAlongMonomorphism( q2, u );
    
end;

V1 := SQVecObj( 1 );
delta := SQVecMor( V2, [ [ 1, 0 ], [ 0, 0 ] ], V2 );
beta := SQVecMor( V2, [ [ 2, 4, 0 ], [ 3, 5, 0 ] ], V3 );
lambda := SQVecMor( V3, [ [ 0 ], [ 0 ], [ 1 ] ], V1 );
snake_lemma_morphism( delta, beta, lambda );

id_functor := CapFunctor( "Identity of SQVec", SQVec, SQVec );
AddObjectFunction( id_functor, IdFunc );
AddMorphismFunction( id_functor,
  function( obj1, mor, obj2 ) return mor; end );

id_functor := IdentityMorphism( AsCatObject( SQVec ) );

double_functor :=
  CapFunctor( "DoubleOfVecspaces", SQVec, SQVec );

AddObjectFunction( double_functor,
                   
  function( obj )
    
    return SQVecObj( 2 * Dimension( obj ) );
    
end );

AddMorphismFunction( double_functor,
                     
  function( new_source, mor, new_range )
    local matr;
    
    matr := UnderlyingMatrix( mor );
    
    return
      SQVecMor( new_source, DiagMat( [ matr, matr ] ), new_range );
    
end );

ApplyFunctor( double_functor, V2 );
alpha2 := SQVecMor( V3, [ [ 0, 0 ], [ 1, 0 ], [ 0, 1 ] ], V2 );
ApplyFunctor( double_functor, alpha2 );
quadruple_functor := PreCompose( double_functor, double_functor );
ApplyFunctor( quadruple_functor, V2 );
ApplyFunctor( quadruple_functor, alpha2 );

InstallFunctor( double_functor, "DoubleFunctor" );
V4 := DoubleFunctor( V2 );
V4_2 := ApplyFunctor( double_functor, V2 );
IsIdenticalObj( V4, V4_2 );
DoubleFunctor( alpha2 );


double_swap_components := 
  NaturalTransformation( "double swap components",
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
h_composition :=
  HorizontalPreCompose( double_swap_components, double_swap_components );
ApplyNaturalTransformation( h_composition, V2 );
v_composition :=
  VerticalPreCompose( double_swap_components, double_swap_components );
ApplyNaturalTransformation( v_composition, V2 );
