LoadPackage( "ModulePres" );
LoadPackage( "Homological" );
LoadPackage( "ToricSheaves" );

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

is_artinian_left := function( module )
  local mat;
    
    mat := UnderlyingMatrix( module );
    
    return IsZero( HilbertPolynomial( UnderlyingMatrixOverNonGradedRing( mat ) ) );
    
end;

Coh := GradedLeftPresentations( S ) / is_artinian_left;

SetIsAdditiveCategory( CocomplexCategory( Coh ), true );
SetIsAdditiveCategory( ComplexCategory( Coh ), true );

M := AsGradedLeftPresentation( mat, [ 0, 0, 1, 2, 2, 1 ] );

ShM := AsSerreQuotientCategoryObject( Coh, M );

res1 := FreeResolutionComplex( ShM );
res := res1[ 1 ];
homres := DualOnComplex( res );
CE := CartanEilenbergResolution( homres, FreeResolutionCocomplex );
homCE := DualOnCocomplexCocomplex( CE );
trhomCE := TransposeComplexOfComplex( homCE );

homhomres := DualOnCocomplex( homres );

LG := LiftNaturalTransformationToGradedModulesLeft( NaturalIsomorphismFromIdentityToLessGeneratorsLeft( S ) );
SM := LiftNaturalTransformationToGradedModulesLeft( NaturalIsomorphismFromIdentityToStandardModuleLeft( S ) );

ShLG := LiftNaturalIsoFromIdToSomeToSerreQuotientCategory( Coh, LG );
ShSM := LiftNaturalIsoFromIdToSomeToSerreQuotientCategory( Coh, SM );

filtration := PurityFiltrationBySpectralSequence( trhomCE, 3, homCE, homres, res1[ 2 ] : Functors := [ ShLG, ShSM ] );

