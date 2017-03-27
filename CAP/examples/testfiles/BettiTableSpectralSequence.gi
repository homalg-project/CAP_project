LoadPackage( "ModulePresentationsForCAP" );

LoadPackage( "HomologicalAlgebraForCAP" );

LoadPackage( "RingsForHomalg" );

QQ := HomalgFieldOfRationalsInSingular( );

R := QQ * "x,y";

SetRecursionTrapInterval( 10000 );

## Construction of the ascending filtered complex

#C_0
category := LeftPresentations( R );

S := FreeLeftPresentation( 1, R );

object_func := function( i ) return S; end;

morphism_func := function( i ) return IdentityMorphism( S ); end;

C0 := ZFunctorObjectExtendedByInitialAndIdentity( object_func, morphism_func, category, 0, 4 );

# C0 := AsAscendingFilteredObject( C0 );


#C_1
S2 := FreeLeftPresentation( 2, R );

C1 := ZFunctorObjectFromMorphismList( [ InjectionOfCofactorOfDirectSum( [ S2, S ], 1 ) ], 2 );

C1 := ZFunctorObjectExtendedByInitialAndIdentity( C1, 2, 3 );

# C1 := AsAscendingFilteredObject( C1 );


C2 := ZFunctorObjectFromMorphismList( [ InjectionOfCofactorOfDirectSum( [ S, S ], 1 ) ], 3 );

C2 := ZFunctorObjectExtendedByInitialAndIdentity( C2, 3, 4 );

# C2 := AsAscendingFilteredObject( C2 );


#delta1: C0 <-- C1

delta_1_3 := PresentationMorphism( C1[3], HomalgMatrix( [ [ "x^2" ], [ "xy" ], [ "y^3"] ], 3, 1, R ), C0[3] );

delta_1_2 := PresentationMorphism( C1[2], HomalgMatrix( [ [ "x^2" ], [ "xy" ] ], 2, 1, R ), C0[2] );

delta1 := ZFunctorMorphism( C1, [ UniversalMorphismFromInitialObject( C0[1] ), UniversalMorphismFromInitialObject( C0[1] ), delta_1_2, delta_1_3 ], 0, C0 );

delta1 := ZFunctorMorphismExtendedByInitialAndIdentity( delta1, 0, 3 );

delta1 := AsAscendingFilteredMorphism( delta1 );

#delta2: C1 <-- C2

delta_2_3 := PresentationMorphism( C2[3], HomalgMatrix( [ [ "y", "-x", "0" ] ], 1, 3, R ), C1[3] );

delta_2_4 := PresentationMorphism( C2[4], HomalgMatrix( [ [ "y", "-x", "0" ], [ "0", "y^2", "-x" ] ], 2, 3, R ), C1[4] );

delta2 := ZFunctorMorphism( C2, [  UniversalMorphismFromInitialObject( C1[2] ), delta_2_3, delta_2_4 ], 2, C1 );

delta2 := ZFunctorMorphismExtendedByInitialAndIdentity( delta2, 2, 4 );

delta2 := AsAscendingFilteredMorphism( delta2 );

SetIsAdditiveCategory( CategoryOfAscendingFilteredObjects( category ), true );

complex := ZFunctorObjectFromMorphismList( [ delta2, delta1 ], -2 );

complex := AsComplex( complex );

F := FunctorLessGeneratorsLeft( R );

AscToDescFunctor := AscendingToDescendingFilteredObjectFunctor( category );

cocomplex := ZFunctorObjectFromMorphismList( [ ApplyFunctor( AscToDescFunctor, delta2 ), ApplyFunctor( AscToDescFunctor, delta1 ) ], -2 );

SetIsAdditiveCategory( CategoryOfDescendingFilteredObjects( category ), true );

cocomplex := AsCocomplex( cocomplex );

#Display( UnderlyingMatrix( Differential( cocomplex, -1 )[-2] ) );
## Tests for cohomological case
# s := SpectralSequenceDifferentialOfAscendingFilteredComplex( cocomplex, 3, 3, -2 );

## Tests for homological case:
# s := SpectralSequenceEntryOfAscendingFilteredComplex( complex, 0, 0, 0 );
# Display( UnderlyingMatrix( ApplyFunctor( F, UnderlyingHonestObject( Source( s ) ) ) ) );
# 
# s := SpectralSequenceEntryOfAscendingFilteredComplex( complex, 1, 0, 0 );
# Display( UnderlyingMatrix( ApplyFunctor( F, UnderlyingHonestObject( Source( s ) ) ) ) );
# 
# s := SpectralSequenceEntryOfAscendingFilteredComplex( complex, 2, 0, 0 );
# Display( UnderlyingMatrix( ApplyFunctor( F, UnderlyingHonestObject( Source( s ) ) ) ) );
# 
# s := SpectralSequenceEntryOfAscendingFilteredComplex( complex, 3, 0, 0 );
# Display( UnderlyingMatrix( ApplyFunctor( F, UnderlyingHonestObject( Source( s ) ) ) ) );
# 
# s := SpectralSequenceEntryOfAscendingFilteredComplex( complex, 4, 0, 0 );
# Display( UnderlyingMatrix( ApplyFunctor( F, UnderlyingHonestObject( Source( s ) ) ) ) );
# 
# s := SpectralSequenceEntryOfAscendingFilteredComplex( complex, 5, 0, 0 );
# Display( UnderlyingMatrix( ApplyFunctor( F, UnderlyingHonestObject( Source( s ) ) ) ) );
# 
# s := SpectralSequenceDifferentialOfAscendingFilteredComplex( complex, 3, 3, -2 );
# 
# Display( UnderlyingMatrix( ApplyFunctor( F, s ) ) );
