LoadPackage( "FreydCategoriesForCAP", false );
LoadPackage( "ModulePresentationsForCAP", false );

QQ := HomalgFieldOfRationalsInSingular( );;
QQxy := QQ * "x,y";;
ring := KoszulDualRing( QQxy );;

rfpres := RightPresentations_as_FreydCategory_CategoryOfColumns( ring : no_precompiled_code := true ); # true or false

m := 1; # 1, 2, 3, 4, 5, 10, 20, 30

I := HomalgIdentityMatrix( m, ring );

M := ObjectConstructor( rfpres, I );

id := IdentityMorphism( M );

Display( "start computation" );
StartTimer( "Lift" );
lift := Lift( id, id );
DisplayTimer( "Lift" );

Assert( 0, IsOne( lift ) );
