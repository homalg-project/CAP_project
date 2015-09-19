LoadPackage( "ModulePresentationsForCAP" );
LoadPackage( "HomologicalAlgebraForCAP" );
LoadPackage( "RingsForHomalg" );

## Initialisation

ZZ := HomalgRingOfIntegersInSingular( );



A1 := FreeLeftPresentation( 1, ZZ );

A2 := FreeLeftPresentation( 2, ZZ );

B := FreeLeftPresentation( 3, ZZ );

alpha1 := PresentationMorphism( A1, HomalgMatrix( [ [ 1, 0, 0 ] ], ZZ ), B );

alpha2 := PresentationMorphism( A2, HomalgMatrix( [ [ 1, 0, 0 ], [ 0, 1, 0 ] ], ZZ ), B );

# alpha1 := InDeductiveSystem( alpha1 );
# 
# alpha2 := InDeductiveSystem( alpha2 );
# 
# B := InDeductiveSystem( B );
# 
# SetIsAbelianCategory( CapCategory( B ), true );


cokernel_proj_1 := CokernelProjection( alpha1 );

cokernel_proj_2 := CokernelProjection( alpha2 );

identity_B := IdentityMorphism( B );

iota := LiftAlongMonomorphism( alpha2, alpha1 );

eps := CokernelColift( alpha1, cokernel_proj_2 );

c := SnakeLemmaConnectingHomomorphism( cokernel_proj_1, iota, identity_B, eps, alpha2 );

cl := ApplyFunctor( FunctorLessGeneratorsLeft( ZZ ), c );
