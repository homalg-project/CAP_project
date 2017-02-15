LoadPackage( "ModulePresentationsForCAP" );
LoadPackage( "HomologicalAlgebraForCAP" );

SwitchGeneralizedMorphismStandard( "span" );

Q := HomalgFieldOfRationalsInSingular();

S := GradedRing( Q * "x,y,z" );;

WeightsOfIndeterminates( S );

mat := HomalgMatrix( "[ \
-x^2*z+x*y*z+x*z^2,y^2*z,-x*z+y*z,x-y,0,   0,   \
-x^3+x^2*y+x^2*z,  x*y^2,-x^2+x*y,0,  x-y, -x*y,\
0,                 0,    0,       x*y,-y*z,0,   \
0,                 0,    0,       x^2,-x*z,0,   \
0,                 0,    0,       x*z,-z^2,0,   \
0,                 0,    0,       0,  0,   z    \
]", 6, 6, S );

S0 := GradedFreeLeftPresentation( 1, S );

SetIsAdditiveCategory( CocomplexCategory( CapCategory( S0 ) ), true );
SetIsAdditiveCategory( ComplexCategory( CapCategory( S0 ) ), true );

M := AsGradedLeftPresentation( mat, [ 0, 0, 1, 2, 2, 1 ] );

res1 := FreeResolutionComplex( M );
res := res1[ 1 ];
homres := DualOnComplex( res );
CE := CartanEilenbergResolution( homres, FreeResolutionCocomplex );
homCE := DualOnCocomplexCocomplex( CE );
trhomCE := TransposeComplexOfComplex( homCE );

homhomres := DualOnCocomplex( homres );

LG := LiftNaturalTransformationToGradedModulesLeft( NaturalIsomorphismFromIdentityToLessGeneratorsLeft( S ) );
SM := LiftNaturalTransformationToGradedModulesLeft( NaturalIsomorphismFromIdentityToStandardModuleLeft( S ) );

filtration := PurityFiltrationBySpectralSequence( trhomCE, 4, homCE, homres, res1[ 2 ] : Functors := [ LG, SM ] );

