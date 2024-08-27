gap> START_TEST( "basic" );

#
gap> LoadPackage( "ModulePresentationsForCAP", false );
true

#
gap> R := HomalgRingOfIntegers( );;
gap> fpres := LeftPresentations( R );;
gap> M := AsLeftPresentation( fpres, HomalgMatrix( [ [ 2 ] ], 1, 1, R ) );
<An object in Category of left presentations of Z>
gap> N := AsLeftPresentation( fpres, HomalgMatrix( [ [ 3 ] ], 1, 1, R ) );
<An object in Category of left presentations of Z>
gap> id := IdentityMorphism( M );
<An identity morphism in Category of left presentations of Z>
gap> IsEqualForMorphisms( id, PreCompose( id, id ) );
true

#
gap> STOP_TEST( "basic" );
