LoadPackage( "ModulePres" );
LoadPackage( "Homological" );

Qxyzt := HomalgFieldOfRationalsInSingular( ) * "x,y,z,t";

S := GradedRing( Qxyzt );

WeightsOfIndeterminates( S );

wmat := HomalgMatrix( "[ \
x*y,  y*z,    z*t,        0,           0,          0,\
x^3*z,x^2*z^2,0,          x*z^2*t,     -z^2*t^2,   0,\
x^4,  x^3*z,  0,          x^2*z*t,     -x*z*t^2,   0,\
0,    0,      x*y,        -y^2,        x^2-t^2,    0,\
0,    0,      x^2*z,      -x*y*z,      y*z*t,      0,\
0,    0,      x^2*y-x^2*t,-x*y^2+x*y*t,y^2*t-y*t^2,0,\
0,    0,      0,          0,           -1,         1 \
]", 7, 6, S );

S0 := GradedFreeLeftPresentation( 1, S );

SetIsAdditiveCategory( CocomplexCategory( CapCategory( S0 ) ), true );
SetIsAdditiveCategory( ComplexCategory( CapCategory( S0 ) ), true );

M := AsGradedLeftPresentation( wmat );

res := FreeResolutionComplexOfModule( M );
res := res[ 1 ];
homres := DualOnComplex( res );
CE := CartanEilenbergResolution( homres, FreeResolutionCocomplexOfModule );
homCE := DualOnCocomplexCocomplex( CE );
trhomCE := TransposeComplexOfComplex( homCE );

LG := LiftNaturalTransformationToGradedModuleFunctorLeft( NaturalIsomorphismFromIdentityToLessGeneratorsLeft( S ) );


SwitchGeneralizedMorphismStandard( "threearrow" );

entry1 := SpectralSequenceEntry( trhomCE, 3, -1, 1 );

underlying_object1 := UnderlyingHonestObject( Source( entry1 ) );

ViewObj( UnderlyingMatrix( underlying_object1 ) );
Print( "\n" );
Display( ApplyFunctor( LG, underlying_object1 ) );


SwitchGeneralizedMorphismStandard( "span" );

trhomCE := TransposeComplexOfComplex( homCE );

entry2 := SpectralSequenceEntry( trhomCE, 3, -1, 1 );

underlying_object2 := UnderlyingHonestObject( Source( entry2 ) );

ViewObj( UnderlyingMatrix( underlying_object2 ) );
Print( "\n" );
Display( ApplyFunctor( LG, underlying_object2 ) );


SwitchGeneralizedMorphismStandard( "cospan" );

trhomCE := TransposeComplexOfComplex( homCE );

entry3 := SpectralSequenceEntry( trhomCE, 3, -1, 1 );

underlying_object3 := UnderlyingHonestObject( Source( entry3 ) );

ViewObj( UnderlyingMatrix( underlying_object3 ) );
Print( "\n" );
Display( ApplyFunctor( LG, underlying_object3 ) );
