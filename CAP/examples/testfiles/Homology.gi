#! @Chapter Examples and Tests

#! @Section Spectral Sequences


LoadPackage( "ModulePresentationsForCAP" );
LoadPackage( "HomologicalAlgebraForCAP" );
LoadPackage( "RingsForHomalg" );

#ActivateDerivationInfo();
#! @Example
ZZ := HomalgRingOfIntegersInSingular( );
#! Z
C1 := FreeLeftPresentation( 1, ZZ );
#! <An object in Category of left presentations of Z>
C2 := FreeLeftPresentation( 2, ZZ );
#! <An object in Category of left presentations of Z>
h1 := PresentationMorphism( C2, HomalgMatrix( [ [ 0 ], [ 4 ] ], ZZ ), C1 );
#! <A morphism in Category of left presentations of Z>
h2 := PresentationMorphism( C2, HomalgMatrix( [ [ 0 ], [ 2 ] ], ZZ ), C1 );
#! <A morphism in Category of left presentations of Z>
v1 := PresentationMorphism( C2, HomalgMatrix( [ [ 2, 0 ], [ 1, 2 ] ], ZZ ), C2 );
#! <A morphism in Category of left presentations of Z>
v2 := PresentationMorphism( C1, HomalgMatrix( [ [ 4 ] ], ZZ ), C1 );
#! <A morphism in Category of left presentations of Z>
cocomplex_h1 := CocomplexFromMorphismList( [ h1 ] );
#! <An object in Cocomplex category of Category of left presentations of Z>
cocomplex_h2 := CocomplexFromMorphismList( [ h2 ] );
#! <An object in Cocomplex category of Category of left presentations of Z>
cocomplex_mor := CochainMap( cocomplex_h2, [ v1, v2 ], cocomplex_h1 );
#! <A morphism in Cocomplex category of Category of left presentations of Z>
Zmod := CapCategory( C1 );
#! Category of left presentations of Z
CH0 := CohomologyFunctor( Zmod, 0 );
#! 0-th cohomology functor of Category of left presentations of Z
cmor0 := ApplyFunctor( CH0, cocomplex_mor );
#! <A morphism in Category of left presentations of Z>
Display( UnderlyingMatrix( cmor0 ) );
#! 2
CH1 := CohomologyFunctor( Zmod, 1 );
#! 1-th cohomology functor of Category of left presentations of Z
cmor1 := ApplyFunctor( CH1, cocomplex_mor );
#! <A morphism in Category of left presentations of Z>
Display( UnderlyingMatrix( cmor1 ) );
#! 4
ToComplex := CocomplexToComplexFunctor( Zmod );
#! Cocomplex to complex functor of Category of left presentations of Z
complex_mor := ApplyFunctor( ToComplex, cocomplex_mor );
#! <A morphism in Complex category of Category of left presentations of Z>
H0 := HomologyFunctor( Zmod, 0 );
#! 0-th homology functor of Category of left presentations of Z
mor0 := ApplyFunctor( H0, complex_mor );
#! <A morphism in Category of left presentations of Z>
Display( UnderlyingMatrix( mor0 ) );
#! 2
Hm1 := HomologyFunctor( Zmod, -1 );
#! -1-th homology functor of Category of left presentations of Z
mor1 := ApplyFunctor( Hm1, complex_mor );
#! <A morphism in Category of left presentations of Z>
Display( UnderlyingMatrix( mor1 ) );
#! 4
#! @EndExample


