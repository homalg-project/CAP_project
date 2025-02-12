#! @Chapter Examples and Tests

#! @Section Basic Commands

#! @Example
LoadPackage( "LinearAlgebraForCAP", false );
#! true
Q := HomalgFieldOfRationals();;
vec := MatrixCategory( Q );;
a := MatrixCategoryObject( vec, 3 );
#! <A vector space object over Q of dimension 3>
IsProjective( a );
#! true
ap := 3/vec;;
IsEqualForObjects( a, ap );
#! true
b := MatrixCategoryObject( vec, 4 );
#! <A vector space object over Q of dimension 4>
homalg_matrix := HomalgMatrix( [ [ 1, 0, 0, 0 ],
                                  [ 0, 1, 0, -1 ],
                                  [ -1, 0, 2, 1 ] ], 3, 4, Q );;
alpha := VectorSpaceMorphism( a, homalg_matrix, b );
#! <A morphism in Category of matrices over Q>
#! @EndExample

#! @Example
# @drop_example_in_Julia: view/print/display strings of matrices differ between GAP and Julia, see https://github.com/homalg-project/MatricesForHomalg.jl/issues/41
Display( alpha );
#! [ [   1,   0,   0,   0 ],
#!   [   0,   1,   0,  -1 ],
#!   [  -1,   0,   2,   1 ] ]
#!
#! A morphism in Category of matrices over Q
#! @EndExample

#! @Example
alphap := homalg_matrix/vec;;
IsCongruentForMorphisms( alpha, alphap );
#! true
homalg_matrix := HomalgMatrix( [ [ 1, 1, 0, 0 ],
                                  [ 0, 1, 0, -1 ],
                                  [ -1, 0, 2, 1 ] ], 3, 4, Q );;
beta := VectorSpaceMorphism( a, homalg_matrix, b );
#! <A morphism in Category of matrices over Q>
CokernelObject( alpha );
#! <A vector space object over Q of dimension 1>
c := CokernelProjection( alpha );;
Display( EntriesOfHomalgMatrixAsListList( UnderlyingMatrix( c ) ) );
#! [ [ 0 ], [ 1 ], [ -1/2 ], [ 1 ] ]
gamma := UniversalMorphismIntoDirectSum( [ c, c ] );;
Display( EntriesOfHomalgMatrixAsListList( UnderlyingMatrix( gamma ) ) );
#! [ [ 0, 0 ], [ 1, 1 ], [ -1/2, -1/2 ], [ 1, 1 ] ]
colift := CokernelColift( alpha, gamma );;
IsEqualForMorphisms( PreCompose( c, colift ), gamma );
#! true
FiberProduct( alpha, beta );
#! <A vector space object over Q of dimension 2>
F := FiberProduct( alpha, beta );
#! <A vector space object over Q of dimension 2>
p1 := ProjectionInFactorOfFiberProduct( [ alpha, beta ], 1 );
#! <A morphism in Category of matrices over Q>
Display( EntriesOfHomalgMatrixAsListList( UnderlyingMatrix( PreCompose( p1, alpha ) ) ) );
#! [ [ 0, 1, 0, -1 ], [ -1, 0, 2, 1 ] ]
Pushout( alpha, beta );
#! <A vector space object over Q of dimension 5>
i1 := InjectionOfCofactorOfPushout( [ alpha, beta ], 1 );
#! <A morphism in Category of matrices over Q>
i2 := InjectionOfCofactorOfPushout( [ alpha, beta ], 2 );
#! <A morphism in Category of matrices over Q>
u := UniversalMorphismFromDirectSum( [ b, b ], [ i1, i2 ] );
#! <A morphism in Category of matrices over Q>
#! @EndExample

#! @Example
# @drop_example_in_Julia: differences in the output of SyzygiesOfRows, see https://github.com/homalg-project/MatricesForHomalg.jl/issues/50
Display( EntriesOfHomalgMatrixAsListList( UnderlyingMatrix( u ) ) );
#! [ [ 0, 1, 1, 0, 0 ],\
#!  [ 1, 0, 1, 0, -1 ],\
#!  [ -1/2, 0, 1/2, 1, 1/2 ],\
#!  [ 1, 0, 0, 0, 0 ],\
#!  [ 0, 1, 0, 0, 0 ],\
#!  [ 0, 0, 1, 0, 0 ],\
#!  [ 0, 0, 0, 1, 0 ],\
#!  [ 0, 0, 0, 0, 1 ] ]
#! @EndExample

#! @Example
KernelObjectFunctorial( u, IdentityMorphism( Source( u ) ), u ) = IdentityMorphism( MatrixCategoryObject( vec, 3 ) );
#! true
IsZeroForMorphisms( CokernelObjectFunctorial( u, IdentityMorphism( Range( u ) ), u ) );
#! true
DirectProductFunctorial( [ u, u ] ) = DirectSumFunctorial( [ u, u ] );
#! true
CoproductFunctorial( [ u, u ] ) = DirectSumFunctorial( [ u, u ] );
#! true
IsCongruentForMorphisms(
    FiberProductFunctorial( [ u, u ], [ IdentityMorphism( Source( u ) ), IdentityMorphism( Source( u ) ) ], [ u, u ] ),
    IdentityMorphism( FiberProduct( [ u, u ] ) )
);
#! true
IsCongruentForMorphisms(
    PushoutFunctorial( [ u, u ], [ IdentityMorphism( Range( u ) ), IdentityMorphism( Range( u ) ) ], [ u, u ] ),
    IdentityMorphism( Pushout( [ u, u ] ) )
);
#! true
IsCongruentForMorphisms( ((1/2) / Q) * alpha, alpha * ((1/2) / Q) );
#! true
Dimension( HomomorphismStructureOnObjects( a, b ) ) = Dimension( a ) * Dimension( b );
#! true
IsCongruentForMorphisms(
    PreCompose( [ u, DualOnMorphisms( i1 ), DualOnMorphisms( alpha ) ] ),
    InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( Source( u ), Source( alpha ),
         PreCompose(
             InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( DualOnMorphisms( i1 ) ),
             HomomorphismStructureOnMorphisms( u, DualOnMorphisms( alpha ) )
         )
    )
);
#! true
op := Opposite( vec );;
alpha_op := Opposite( op, alpha );
#! <A morphism in Opposite( Category of matrices over Q )>
basis := BasisOfExternalHom( Source( alpha_op ), Range( alpha_op ) );;
coeffs := CoefficientsOfMorphism( alpha_op );;
Display( coeffs );
#! [ 1, 0, 0, 0, 0, 1, 0, -1, -1, 0, 2, 1 ]
IsEqualForMorphisms( alpha_op, LinearCombinationOfMorphisms( Source( alpha_op ), coeffs, basis, Range( alpha_op ) ) );
#! true
vec := CapCategory( alpha );;
t := TensorUnit( vec );;
z := ZeroObject( vec );;
IsCongruentForMorphisms(
    ZeroObjectFunctorial( vec ),
    InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( z, z, ZeroMorphism( t, z ) )
);
#! true
IsCongruentForMorphisms(
    ZeroObjectFunctorial( vec ),
    InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism(
        z, z,
        InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( ZeroObjectFunctorial( vec ) )
    )
);
#! true
right_side := PreCompose( [ i1, DualOnMorphisms( u ), u ] );;
x := SolveLinearSystemInAbCategory( [ [ i1 ] ], [ [ u ] ], [ right_side ] )[1];;
IsCongruentForMorphisms( PreCompose( [ i1, x, u ] ), right_side );
#! true
a_otimes_b := TensorProductOnObjects( a, b );
#! <A vector space object over Q of dimension 12>
hom_ab := InternalHomOnObjects( a, b );
#! <A vector space object over Q of dimension 12>
cohom_ab := InternalCoHomOnObjects( a, b );
#! <A vector space object over Q of dimension 12>
hom_ab = cohom_ab;
#! true
unit_ab := VectorSpaceMorphism(
          a_otimes_b,
          HomalgIdentityMatrix( Dimension( a_otimes_b ), Q ),
          a_otimes_b
          );
#! <A morphism in Category of matrices over Q>
unit_hom_ab := VectorSpaceMorphism(
              hom_ab,
              HomalgIdentityMatrix( Dimension( hom_ab ), Q ),
              hom_ab
            );
#! <A morphism in Category of matrices over Q>
unit_cohom_ab := VectorSpaceMorphism(
                cohom_ab,
                HomalgIdentityMatrix( Dimension( cohom_ab ), Q ),
                cohom_ab
              );
#! <A morphism in Category of matrices over Q>
ev_ab := ClosedMonoidalLeftEvaluationMorphism( a, b );
#! <A morphism in Category of matrices over Q>
coev_ab := ClosedMonoidalLeftCoevaluationMorphism( a, b );
#! <A morphism in Category of matrices over Q>
coev_ba := ClosedMonoidalLeftCoevaluationMorphism( b, a );
#! <A morphism in Category of matrices over Q>
cocl_ev_ab := CoclosedMonoidalLeftEvaluationMorphism( a, b );
#! <A morphism in Category of matrices over Q>
cocl_ev_ba := CoclosedMonoidalLeftEvaluationMorphism( b, a );
#! <A morphism in Category of matrices over Q>
cocl_coev_ab := CoclosedMonoidalLeftCoevaluationMorphism( a, b );
#! <A morphism in Category of matrices over Q>
cocl_coev_ba := CoclosedMonoidalLeftCoevaluationMorphism( b, a );
#! <A morphism in Category of matrices over Q>
UnderlyingMatrix( ev_ab ) = TransposedMatrix( UnderlyingMatrix( cocl_ev_ab ) );
#! true
UnderlyingMatrix( coev_ab ) = TransposedMatrix( UnderlyingMatrix( cocl_coev_ab ) );
#! true
UnderlyingMatrix( coev_ba ) = TransposedMatrix( UnderlyingMatrix( cocl_coev_ba ) );
#! true
tensor_hom_adj_1_hom_ab := InternalHomToTensorProductLeftAdjunctMorphism( a, b, unit_hom_ab );
#! <A morphism in Category of matrices over Q>
cohom_tensor_adj_1_cohom_ab := InternalCoHomToTensorProductLeftAdjunctMorphism( a, b, unit_cohom_ab );
#! <A morphism in Category of matrices over Q>
tensor_hom_adj_1_ab := TensorProductToInternalHomLeftAdjunctMorphism( a, b, unit_ab );
#! <A morphism in Category of matrices over Q>
cohom_tensor_adj_1_ab := TensorProductToInternalCoHomLeftAdjunctMorphism( a, b, unit_ab );
#! <A morphism in Category of matrices over Q>
ev_ab = tensor_hom_adj_1_hom_ab;
#! true
cocl_ev_ba = cohom_tensor_adj_1_cohom_ab;
#! true
coev_ba = tensor_hom_adj_1_ab;
#! true
cocl_coev_ba = cohom_tensor_adj_1_ab;
#! true
c := MatrixCategoryObject( vec, 2 );
#! <A vector space object over Q of dimension 2>
d := MatrixCategoryObject( vec, 1 );
#! <A vector space object over Q of dimension 1>
#! @EndExample

#! @Example
pre_compose := MonoidalPreComposeMorphism( a, b, c );
#! <A morphism in Category of matrices over Q>
post_compose := MonoidalPostComposeMorphism( a, b, c );
#! <A morphism in Category of matrices over Q>
pre_cocompose := MonoidalPreCoComposeMorphism( c, b, a );
#! <A morphism in Category of matrices over Q>
post_cocompose := MonoidalPostCoComposeMorphism( c, b, a );
#! <A morphism in Category of matrices over Q>
UnderlyingMatrix( pre_compose ) = TransposedMatrix( UnderlyingMatrix( pre_cocompose ) );
#! true
UnderlyingMatrix( post_compose ) = TransposedMatrix( UnderlyingMatrix( post_cocompose ) );
#! true
tp_hom_comp := TensorProductInternalHomCompatibilityMorphism( [ a, b, c, d ] );
#! <A morphism in Category of matrices over Q>
cohom_tp_comp := InternalCoHomTensorProductCompatibilityMorphism( [ b, d, a, c ] );
#! <A morphism in Category of matrices over Q>
UnderlyingMatrix( tp_hom_comp ) = TransposedMatrix( UnderlyingMatrix( cohom_tp_comp ) );
#! true
lambda := LambdaIntroduction( alpha );
#! <A morphism in Category of matrices over Q>
lambda_elim := LambdaElimination( a, b, lambda );
#! <A morphism in Category of matrices over Q>
alpha = lambda_elim;
#! true
alpha_op := VectorSpaceMorphism( b, TransposedMatrix( UnderlyingMatrix( alpha ) ), a );
#! <A morphism in Category of matrices over Q>
colambda := CoLambdaIntroduction( alpha_op );
#! <A morphism in Category of matrices over Q>
colambda_elim := CoLambdaElimination( b, a, colambda );
#! <A morphism in Category of matrices over Q>
alpha_op = colambda_elim;
#! true
UnderlyingMatrix( lambda ) = TransposedMatrix( UnderlyingMatrix( colambda ) );
#! true
delta := PreCompose( colambda, lambda);
#! <A morphism in Category of matrices over Q>
Display( EntriesOfHomalgMatrixAsListList( UnderlyingMatrix( TraceMap( delta ) ) ) );
#! [ [ 9 ] ]
Display( EntriesOfHomalgMatrixAsListList( UnderlyingMatrix( CoTraceMap( delta ) ) ) );
#! [ [ 9 ] ]
TraceMap( delta ) = CoTraceMap( delta );
#! true
RankMorphism( a ) = CoRankMorphism( a );
#! true
#! @EndExample
