LoadPackage( "ModulePres" );
LoadPackage( "Homological" );

SwitchGeneralizedMorphismStandard( "span" );

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

res1 := FreeResolutionComplexOfModule( M );
res := res1[ 1 ];
homres := DualOnComplex( res );
CE := CartanEilenbergResolution( homres, FreeResolutionCocomplexOfModule );
homCE := DualOnCocomplexCocomplex( CE );
trhomCE := TransposeComplexOfComplex( homCE );

homhomres := DualOnCocomplex( homres );

LG := LiftNaturalTransformationToGradedModuleFunctorLeft( NaturalIsomorphismFromIdentityToLessGeneratorsLeft( S ) );

resolution_len := ResolutionLength( res );

tot := TotalComplexOfBicomplex( homCE, resolution_len );

connection_at_0 := ConnectingMorphismFromCocomplexToCartanEilenbergResolution( homres, 0, FreeResolutionCocomplexOfModule );
connection_at_1 := ConnectingMorphismFromCocomplexToCartanEilenbergResolution( homres, 1, FreeResolutionCocomplexOfModule );

homcon_at_0 := DualOnMorphisms( connection_at_0 );
homcon_at_1 := DualOnMorphisms( connection_at_1 );

emb0 := EmbeddingInObjectOfTotalComplex( homCE, resolution_len, 0, 1 );
emb1 := EmbeddingInObjectOfTotalComplex( homCE, resolution_len, 1, 1 );

homcon_at_0_in_tot := PreCompose( homcon_at_0, emb0 );
homcon_at_1_in_tot := PreCompose( homcon_at_1, emb1 );

homology_iso := GeneralizedMorphismBetweenHomologies( homhomres, tot, homcon_at_0_in_tot, 0 );

homology_iso := HonestRepresentative( homology_iso );

M_as_homology := HonestRepresentative( PseudoInverse( GeneralizedEmbeddingOfHomology( homhomres, 0 ) ) );

M_to_M_as_homology := ColiftAlongEpimorphism( res1[2], M_as_homology );

M_to_hom_of_tot := PreCompose( M_to_M_as_homology, homology_iso );

entry := SpectralSequenceEntry( trhomCE, 4, -1, 1 );

homology_proj_of_tot := PseudoInverse( GeneralizedEmbeddingOfHomology( tot, 0 ) );

emb01 := EmbeddingInObjectOfTotalComplex( homCE, resolution_len, 0, 2 );

PreCompose( PreCompose( PreCompose( entry, AsGeneralizedMorphism( emb01 ) ), homology_proj_of_tot ), AsGeneralizedMorphism( Inverse( M_to_hom_of_tot ) ) );




