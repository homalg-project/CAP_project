#! This example shows that it might be useful to have a variant
#! of ReducedBasisOfRowModule that takes the degree of a polynomial
#! into account.

LoadPackage( "ModulePresentationsForCAP" );

LoadPackage( "RingsForHomalg" );

F5 := HomalgRingOfIntegersInSingular( 5 );;
R := F5 * "x,y,z,v,w";;
category := CategoryOfLeftModulePresentationsOverLocalRing( R, [ "x", "y", "z", "v", "w" ] );;
i1 := HomalgMatrix( "[ x-z, y-w ]", 2, 1, R );;
i2 := HomalgMatrix( "[ y^6*v^2*w-y^3*v*w^20+1, x*y^4*z^4*w-z^5*w^5+x^3*y*z^2-1 ]", 2, 1, R );;
M1 := AsLeftPresentation( i1 );;
M2 := AsLeftPresentation( i2 );;
OI0 := CokernelObject( Annihilator( DirectSum( M1, M2 ) ) );;
mat := UnderlyingMatrix( OI0 );;
entries_basis := EntriesOfHomalgMatrix( BasisOfRowModule( mat ) );;
List( entries_basis, Degree );
#! [ 11, 11, 25, 25, 30, 30, 31, 31, 31, 31, 32, 32, 33, 33, 33, 33, 34, 34, 34, 34, 34, 35, 35, 35, 36, 36, 36, 36, 37, 38 ]
List( EntriesOfHomalgMatrix( ReducedBasisOfRowModule( mat ) ), Degree );
#! [ 25, 25, 31, 31 ]
small_basis := HomalgMatrix( entries_basis{[1..4]}, 4, 1, R );;
List( EntriesOfHomalgMatrix( small_basis ), Degree );
#! [ 11, 11, 25, 25 ]
DecideZero( small_basis, mat );
#! <A 4 x 1 zero matrix over an external ring>
DecideZero( mat, small_basis );
#! <A 4 x 1 zero matrix over an external ring>
