LoadPackage( "ModulePres" );
Q := HomalgFieldOfRationalsInSingular();
R := Q*"x,y";
S := GradedRing( R );
WeightsOfIndeterminates( S );
eins := last[1];
M := HomalgMatrix( "[x^2,xy,y^2]", 3,1, S );
XX := GradedFreeLeftPresentation( 1, S );
S0 := GradedFreeLeftPresentation( 1, S );
S1 := GradedFreeLeftPresentation( 3, S, [ 2*eins, 2*eins, 2*eins ] );
alpha := GradedPresentationMorphism( S1, M, S0 );
M := CokernelObject( alpha );
FFhomo := ResolutionFunctorToComplex( GradedLeftPresentations( S ), CoverByFreeModule );
FF := ResolutionFunctorToCocomplex( GradedLeftPresentations( S ), CoverByFreeModule );
res := ApplyFunctor( FFhomo, M );
SetIsAdditiveCategory( CocomplexCategory( CapCategory( S0 ) ), true );
SetIsAdditiveCategory( ComplexCategory( CapCategory( S0 ) ), true );


res := FreeResolutionComplexOfModule( M );
res := res[ 1 ];
homres := InternalHomOnComplexWithObject( res, S0 );
CE := CartanEilenbergResolution( homres, FreeResolutionCocomplexOfModule );
homCE := InternalHomOnCocomplexCocomplexWithObject( CE, S0 );

CE := CartanEilenbergResolution( res, FF );


alpha := KernelEmbedding( alpha );
beta := CokernelProjection( alpha );

Pp := ApplyFunctor( FF, Source( alpha ) );
epsp := Differential( Pp, 0 );

Ppp := ApplyFunctor( FF, Range( beta ) );
epspp := Differential( Ppp, 0 );

ll := HorseShoeLemma( Pp, Ppp, epsp, alpha, beta, epspp );

new_res := ll[ 1 ];

Differential( new_res, -1 );

