#! @Chapter Examples and Tests

#! @Section Basic Commands

LoadPackage( "LinearAlgebraForCAP" );;

#! @Example
Q := HomalgFieldOfRationals();;
a := VectorSpaceObject( 3, Q );
#! <A vector space object over Q of dimension 3>
HasIsProjective( a ) and IsProjective( a );
#! true
vec := MatrixCategory( Q );;
ap := 3/vec;;
IsEqualForObjects( a, ap );
#! true
b := VectorSpaceObject( 4, Q );
#! <A vector space object over Q of dimension 4>
homalg_matrix := HomalgMatrix( [ [ 1, 0, 0, 0 ],
                                  [ 0, 1, 0, -1 ],
                                  [ -1, 0, 2, 1 ] ], 3, 4, Q );
#! <A 3 x 4 matrix over an internal ring>
alpha := VectorSpaceMorphism( a, homalg_matrix, b );
#! <A morphism in Category of matrices over Q>
Display( alpha );
#! [ [   1,   0,   0,   0 ],
#!   [   0,   1,   0,  -1 ],
#!   [  -1,   0,   2,   1 ] ]
#!
#! A morphism in Category of matrices over Q
alphap := homalg_matrix/vec;;
IsCongruentForMorphisms( alpha, alphap );
#! true
homalg_matrix := HomalgMatrix( [ [ 1, 1, 0, 0 ],
                                  [ 0, 1, 0, -1 ],
                                  [ -1, 0, 2, 1 ] ], 3, 4, Q );
#! <A 3 x 4 matrix over an internal ring>
beta := VectorSpaceMorphism( a, homalg_matrix, b );
#! <A morphism in Category of matrices over Q>
CokernelObject( alpha );
#! <A vector space object over Q of dimension 1>
c := CokernelProjection( alpha );;
Display( c );
#! [ [     0 ],
#!   [     1 ],
#!   [  -1/2 ],
#!   [     1 ] ]
#!
#! A split epimorphism in Category of matrices over Q
gamma := UniversalMorphismIntoDirectSum( [ c, c ] );;
Display( gamma );
#! [ [     0,     0 ],
#!   [     1,     1 ],
#!   [  -1/2,  -1/2 ],
#!   [     1,     1 ] ]
#!
#! A morphism in Category of matrices over Q
colift := CokernelColift( alpha, gamma );;
IsEqualForMorphisms( PreCompose( c, colift ), gamma );
#! true
FiberProduct( alpha, beta );
#! <A vector space object over Q of dimension 2>
F := FiberProduct( alpha, beta );
#! <A vector space object over Q of dimension 2>
p1 := ProjectionInFactorOfFiberProduct( [ alpha, beta ], 1 );
#! <A morphism in Category of matrices over Q>
Display( PreCompose( p1, alpha ) );
#! [ [   0,   1,   0,  -1 ],
#!   [  -1,   0,   2,   1 ] ]
#!
#! A morphism in Category of matrices over Q
Pushout( alpha, beta );
#! <A vector space object over Q of dimension 5>
i1 := InjectionOfCofactorOfPushout( [ alpha, beta ], 1 );
#! <A morphism in Category of matrices over Q>
i2 := InjectionOfCofactorOfPushout( [ alpha, beta ], 2 );
#! <A morphism in Category of matrices over Q>
u := UniversalMorphismFromDirectSum( [ b, b ], [ i1, i2 ] );
#! <A morphism in Category of matrices over Q>
Display( u );
#! [ [     0,     1,     1,     0,     0 ],
#!   [     1,     0,     1,     0,    -1 ],
#!   [  -1/2,     0,   1/2,     1,   1/2 ],
#!   [     1,     0,     0,     0,     0 ],
#!   [     0,     1,     0,     0,     0 ],
#!   [     0,     0,     1,     0,     0 ],
#!   [     0,     0,     0,     1,     0 ],
#!   [     0,     0,     0,     0,     1 ] ]
#!
#! A morphism in Category of matrices over Q
KernelObjectFunctorial( u, IdentityMorphism( Source( u ) ), u ) = IdentityMorphism( VectorSpaceObject( 3, Q ) );
#! true
IsZero( CokernelObjectFunctorial( u, IdentityMorphism( Range( u ) ), u ) );
#! true
DirectProductFunctorial( [ u, u ] ) = DirectSumFunctorial( [ u, u ] );
#! true
CoproductFunctorial( [ u, u ] ) = DirectSumFunctorial( [ u, u ] );
#! true
IsOne( FiberProductFunctorial( [ u, u ], [ IdentityMorphism( Source( u ) ), IdentityMorphism( Source( u ) ) ], [ u, u ] ) );
#! true
IsOne( PushoutFunctorial( [ u, u ], [ IdentityMorphism( Range( u ) ), IdentityMorphism( Range( u ) ) ], [ u, u ] ) );
#! true
IsCongruentForMorphisms( (1/2) * alpha, alpha * (1/2) );
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
alpha_op := Opposite( alpha );
#! <A morphism in Opposite( Category of matrices over Q )>
basis := BasisOfExternalHom( Source( alpha_op ), Range( alpha_op ) );;
coeffs := CoefficientsOfMorphism( alpha_op );
#! [ 1, 0, 0, 0, 0, 1, 0, -1, -1, 0, 2, 1 ]
IsEqualForMorphisms( alpha_op, coeffs * basis );
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
1_ab := VectorSpaceMorphism(
          a_otimes_b,
          HomalgIdentityMatrix( Dimension( a_otimes_b ), Q ),
          a_otimes_b
          );
#! <A morphism in Category of matrices over Q>
1_hom_ab := VectorSpaceMorphism(
              hom_ab,
              HomalgIdentityMatrix( Dimension( hom_ab ), Q ),
              hom_ab
            );
#! <A morphism in Category of matrices over Q>
1_cohom_ab := VectorSpaceMorphism(
                cohom_ab,
                HomalgIdentityMatrix( Dimension( cohom_ab ), Q ),
                cohom_ab
              );
#! <A morphism in Category of matrices over Q>
ev_ab := EvaluationMorphism( a, b );
#! <A morphism in Category of matrices over Q>
coev_ab := CoevaluationMorphism( a, b );
#! <A morphism in Category of matrices over Q>
cocl_ev_ab := CoclosedEvaluationMorphism( a, b );
#! <A morphism in Category of matrices over Q>
cocl_ev_ba := CoclosedEvaluationMorphism( b, a );
#! <A morphism in Category of matrices over Q>
cocl_coev_ab := CoclosedCoevaluationMorphism( a, b );
#! <A morphism in Category of matrices over Q>
UnderlyingMatrix( ev_ab ) = TransposedMatrix( UnderlyingMatrix( cocl_ev_ba ) );
#! true
UnderlyingMatrix( coev_ab ) = TransposedMatrix( UnderlyingMatrix( cocl_coev_ab ) );
#! true
tensor_hom_adj_1_hom_ab := InternalHomToTensorProductAdjunctionMap( a, b, 1_hom_ab );
#! <A morphism in Category of matrices over Q>
cohom_tensor_adj_1_cohom_ab := InternalCoHomToTensorProductAdjunctionMap( a, b, 1_cohom_ab );
#! <A morphism in Category of matrices over Q>
tensor_hom_adj_1_ab := TensorProductToInternalHomAdjunctionMap( a, b, 1_ab );
#! <A morphism in Category of matrices over Q>
cohom_tensor_adj_1_ab := TensorProductToInternalCoHomAdjunctionMap( a, b, 1_ab );
#! <A morphism in Category of matrices over Q>
ev_ab = tensor_hom_adj_1_hom_ab;
#! true
cocl_ev_ab = cohom_tensor_adj_1_cohom_ab;
#! true
coev_ab = tensor_hom_adj_1_ab;
#! true
cocl_coev_ab = cohom_tensor_adj_1_ab;
#! true
c := VectorSpaceObject(2,Q);
#! <A vector space object over Q of dimension 2>
d := VectorSpaceObject(1,Q);
#! <A vector space object over Q of dimension 1>
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
Display( TraceMap( delta ) );
#! [ [  9 ] ]
#!
#! A morphism in Category of matrices over Q
Display( CoTraceMap( delta ) );
#! [ [  9 ] ]
#!
#! A morphism in Category of matrices over Q
TraceMap( delta ) = CoTraceMap( delta );
#! true
RankMorphism( a ) = CoRankMorphism( a );
#! true
#! @EndExample
