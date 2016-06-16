LoadPackage( "ModulePresentationsForCAP" );
LoadPackage( "RingsForHomalg" );
LoadPackage( "GeneralizedMorphismsForCAP" );

Q := HomalgFieldOfRationalsInSingular();
S := Q * "x,y";

Read( "IsSupportedInOrigin.g" );

A := LeftPresentations( S );
InfoOfInstalledOperationsOfCategory( A );

C := Subcategory( A, IsSupportedInOrigin );
Coh := A / C;
InfoOfInstalledOperationsOfCategory( Coh );

Sh := CanonicalProjection( Coh );
InstallFunctor( Sh, "Sheafification" );
M := AsLeftPresentation( HomalgMatrix( [ [ "x*y" ] ], S ) );
N := AsLeftPresentation( HomalgMatrix( [ [ "x" ] ], S ) );
O := AsLeftPresentation( HomalgMatrix( [ [ "y" ] ], S ) );
phi := PresentationMorphism( M, HomalgMatrix( [ [ 1, 1 ] ], S ), DirectSum( N, O ) );
IsIsomorphism( phi );
IsIsomorphism( Sheafification( phi ) );