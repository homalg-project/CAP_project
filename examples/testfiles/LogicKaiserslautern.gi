LoadPackage( "ModulePresentationsForHomalg" );

LoadPackage( "RingsForHomalg" );

Q := HomalgFieldOfRationalsInSingular( );

R := Q * "x,y";

F := FreeLeftPresentation( 1, R );

alpha1_eval := PresentationMorphism( F, HomalgMatrix( "[ [ x ] ]", R ), F );

alpha2_eval := PresentationMorphism( F, HomalgMatrix( "[ [ y ] ]", R ), F );

## Initializing the deductive system

alpha1 := InDeductiveSystem( alpha1_eval );

alpha2 := InDeductiveSystem( alpha2_eval );

## Formal computation

P := FiberProduct( alpha1, alpha2 );

pi1 := ProjectionInFactor( P, 1 );

composite := PreCompose( pi1, alpha1 );

PrintHistory( composite );

IsMonomorphism( alpha1 );

IsMonomorphism( alpha2 );

HasEvaluation( composite );

HasIsMonomorphism( composite );

IsMonomorphism( composite );

HasEvaluation( composite );

Evaluation( composite );

HasEvaluation( composite );
