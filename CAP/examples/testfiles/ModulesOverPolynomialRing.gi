LoadPackage( "ModulePresentationsForCAP" );

LoadPackage( "RingsForHomalg" );

## Initialisation

Q := HomalgFieldOfRationalsInSingular( );

R := Q * "x,y";

# R := R / "y - x - 1";

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

## Computation

kernelemb1 := KernelEmbedding( eps1 );

kernelemb2 := KernelEmbedding( eps2 );

P := FiberProduct( kernelemb1, kernelemb2 );

pi1 := ProjectionInFactor( P, 1 );

composite := PreCompose( pi1, kernelemb1 );

e := Evaluation( composite );
