gap> START_TEST( "IsWellDefinedForMorphismsWithGivenSourceAndRange" );

#
gap> LoadPackage( "CAP", false );
true

#
gap> T := TerminalCategoryWithMultipleObjects( );
TerminalCategoryWithMultipleObjects( )
gap> a := "a" / T;;
gap> b := "b" / T;;
gap> alpha := ZeroMorphism( a, b );;
gap> IsWellDefinedForMorphisms( alpha );
true
gap> IsWellDefinedForMorphismsWithGivenSourceAndRange( a, alpha, b );
true
gap> IsWellDefinedForMorphismsWithGivenSourceAndRange( b, alpha, a );
false

#
gap> op := Opposite( T );;
gap> a_op := a / op;;
gap> b_op := b / op;;
gap> alpha_op := Opposite( alpha );;
gap> IsWellDefinedForMorphisms( alpha_op );
true
gap> IsWellDefinedForMorphismsWithGivenSourceAndRange( a_op, alpha_op, b_op );
false
gap> IsWellDefinedForMorphismsWithGivenSourceAndRange( b_op, alpha_op, a_op );
true

#
gap> STOP_TEST( "IsWellDefinedForMorphismsWithGivenSourceAndRange" );
