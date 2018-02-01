LoadPackage( "ModulePresentationsForCAP" );
LoadPackage( "RingsForHomalg" );
LoadPackage( "GeneralizedMorphismsForCAP" );

Q := HomalgFieldOfRationalsInSingular();
S := Q * "x,y";
A := LeftPresentations( S );
InfoOfInstalledOperationsOfCategory( A );
ListPrimitivelyInstalledOperationsOfCategory( A );
ListInstalledOperationsOfCategory( A );


Read( "IsSupportedInOrigin.g" );
C := FullSubcategoryByMembershipFunction( A, IsSupportedInOrigin );
Coh := A / C;
InfoOfInstalledOperationsOfCategory( Coh );
ListPrimitivelyInstalledOperationsOfCategory( Coh );
ListInstalledOperationsOfCategory( Coh );

Sh := CanonicalProjection( Coh );
InstallFunctor( Sh, "Sheafification" );
M := AsLeftPresentation( HomalgMatrix( [ [ "x*y" ] ], S ) );
N := AsLeftPresentation( HomalgMatrix( [ [ "x" ] ], S ) );
O := AsLeftPresentation( HomalgMatrix( [ [ "y" ] ], S ) );
phi := PresentationMorphism( M, HomalgMatrix( [ [ 1, 1 ] ], S ), DirectSum( N, O ) );
IsIsomorphism( phi );
Sphi := Sheafification( phi );
IsIsomorphism( Sphi );
