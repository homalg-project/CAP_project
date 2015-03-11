LoadPackage( "ModulePresentationsForHomalg" );

LoadPackage( "RingsForHomalg" );

## Initialisation

ZZ := HomalgRingOfIntegersInSingular( );

C1 := FreeLeftPresentation( 1, ZZ );

C2 := FreeLeftPresentation( 2, ZZ );

h1 := PresentationMorphism( C2, HomalgMatrix( [ [ 0 ], [ 4 ] ], ZZ ), C1 );

h2 := PresentationMorphism( C2, HomalgMatrix( [ [ 0 ], [ 2 ] ], ZZ ), C1 );

v1 := PresentationMorphism( C2, HomalgMatrix( [ [ 2, 0 ], [ 1, 2 ] ], ZZ ), C2 );

v2 := PresentationMorphism( C1, HomalgMatrix( [ [ 4 ] ], ZZ ), C1 );

cocomplex_h1 := ZFunctorObjectFromMorphismList( [ h1 ], 0 );

cocomplex_h2 := ZFunctorObjectFromMorphismList( [ h2 ], 0 );

cocomplex_mor := ZFunctorMorphism( cocomplex_h2, [ v1, v2 ], 0, cocomplex_h1 );

cocomplex_h1 := AsCocomplex( cocomplex_h1 );

cocomplex_h2 := AsCocomplex( cocomplex_h2 );

cocomplex_mor := CochainMap( cocomplex_h2, cocomplex_mor, cocomplex_h1 );

Zmod := CapCategory( C1 );

CH0 := CohomologyFunctor( Zmod, 0 );

cmor0 := ApplyFunctor( CH0, cocomplex_mor );
Display( UnderlyingMatrix( cmor0 ) );

CH1 := CohomologyFunctor( Zmod, 1 );

cmor1 := ApplyFunctor( CH1, cocomplex_mor );
Display( UnderlyingMatrix( cmor1 ) );

ToComplex := CocomplexToComplexFunctor( Zmod );

complex_mor := ApplyFunctor( ToComplex, cocomplex_mor );

H0 := HomologyFunctor( Zmod, 0 );

mor0 := ApplyFunctor( H0, complex_mor );
Display( UnderlyingMatrix( mor0 ) );

Hm1 := HomologyFunctor( Zmod, -1 );

mor1 := ApplyFunctor( Hm1, complex_mor );
Display( UnderlyingMatrix( mor1 ) );



