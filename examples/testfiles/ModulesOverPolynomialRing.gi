LoadPackage( "ModulePresentationsForHomalg" );

LoadPackage( "RingsForHomalg" );

Q := HomalgFieldOfRationalsInSingular( );

R := Q * "x,y";

F := FreeLeftPresentation( 1, R );

I1 := AsLeftPresentation( HomalgMatrix( [ [ "x" ] ], R ) );

I2 := AsLeftPresentation( HomalgMatrix( [ [ "y" ] ], R ) );

eps1 := PresentationMorphism( F, HomalgMatrix( [ [ 1 ] ], R ), I1 );

eps2 := PresentationMorphism( F, HomalgMatrix( [ [ 1 ] ], R ), I2 );

F := InDeductiveSystem( F );

I1 := InDeductiveSystem( I1 );

I2 := InDeductiveSystem( I2 );

eps1 := InDeductiveSystem( eps1 );

eps2 := InDeductiveSystem( eps2 );

kernelemb1 := KernelEmb( eps1 );

kernelemb2 := KernelEmb( eps2 );

P := FiberProduct( kernelemb1, kernelemb2 );

pi1 := ProjectionInFactor( P, 1 );

composite := PreCompose( pi1, kernelemb1 );