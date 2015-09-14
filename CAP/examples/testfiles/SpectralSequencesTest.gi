#! @Chapter Examples and Tests

#! @Section Spectral Sequences

LoadPackage( "ModulePresentationsForCAP" );
LoadPackage( "HomologicalAlgebraForCAP" );
LoadPackage( "RingsForHomalg" );

#! @Example
QQ := HomalgFieldOfRationalsInSingular( );;
R := QQ * "x,y";
#! Q[x,y]
SetRecursionTrapInterval( 10000 );
category := LeftPresentations( R );
#! Category of left presentations of Q[x,y]
S := FreeLeftPresentation( 1, R );
#! <An object in Category of left presentations of Q[x,y]>
object_func := function( i ) return S; end;
#! function( i ) ... end
morphism_func := function( i ) return IdentityMorphism( S ); end;
#! function( i ) ... end
C0 := ZFunctorObjectExtendedByInitialAndIdentity( object_func, morphism_func, category, 0, 4 );
#! <An object in Functors from integers into Category of left presentations of Q[x,y]>
S2 := FreeLeftPresentation( 2, R );
#! <An object in Category of left presentations of Q[x,y]>
C1 := ZFunctorObjectFromMorphismList( [ InjectionOfCofactor( DirectSum( S2, S ), 1 ) ], 2 );
#! <An object in Functors from integers into Category of left presentations of Q[x,y]>
C1 := ZFunctorObjectExtendedByInitialAndIdentity( C1, 2, 3 );
#! <An object in Functors from integers into Category of left presentations of Q[x,y]>
C2 := ZFunctorObjectFromMorphismList( [ InjectionOfCofactor( DirectSum( S, S ), 1 ) ], 3 );
#! <An object in Functors from integers into Category of left presentations of Q[x,y]>
C2 := ZFunctorObjectExtendedByInitialAndIdentity( C2, 3, 4 );
#! <An object in Functors from integers into Category of left presentations of Q[x,y]>
delta_1_3 := PresentationMorphism( C1[3], HomalgMatrix( [ [ "x^2" ], [ "xy" ], [ "y^3"] ], 3, 1, R ), C0[3] );
#! <A morphism in Category of left presentations of Q[x,y]>
delta_1_2 := PresentationMorphism( C1[2], HomalgMatrix( [ [ "x^2" ], [ "xy" ] ], 2, 1, R ), C0[2] );
#! <A morphism in Category of left presentations of Q[x,y]>
delta1 := ZFunctorMorphism( C1, [ UniversalMorphismFromInitialObject( C0[1] ), UniversalMorphismFromInitialObject( C0[1] ), delta_1_2, delta_1_3 ], 0, C0 );
#! <A morphism in Functors from integers into Category of left presentations of Q[x,y]>
delta1 := ZFunctorMorphismExtendedByInitialAndIdentity( delta1, 0, 3 );
#! <A morphism in Functors from integers into Category of left presentations of Q[x,y]>
delta1 := AsAscendingFilteredMorphism( delta1 );
#! <A morphism in Ascending filtered object category of Category of left presentations of Q[x,y]>
delta_2_3 := PresentationMorphism( C2[3], HomalgMatrix( [ [ "y", "-x", "0" ] ], 1, 3, R ), C1[3] );
#! <A morphism in Category of left presentations of Q[x,y]>
delta_2_4 := PresentationMorphism( C2[4], HomalgMatrix( [ [ "y", "-x", "0" ], [ "0", "y^2", "-x" ] ], 2, 3, R ), C1[4] );
#! <A morphism in Category of left presentations of Q[x,y]>
delta2 := ZFunctorMorphism( C2, [  UniversalMorphismFromInitialObject( C1[2] ), delta_2_3, delta_2_4 ], 2, C1 );
#! <A morphism in Functors from integers into Category of left presentations of Q[x,y]>
delta2 := ZFunctorMorphismExtendedByInitialAndIdentity( delta2, 2, 4 );
#! <A morphism in Functors from integers into Category of left presentations of Q[x,y]>
delta2 := AsAscendingFilteredMorphism( delta2 );
#! <A morphism in Ascending filtered object category of Category of left presentations of Q[x,y]>
SetIsAdditiveCategory( CategoryOfAscendingFilteredObjects( category ), true );
complex := ZFunctorObjectFromMorphismList( [ delta2, delta1 ], -2 );
#! <An object in Functors from integers into Ascending filtered object category of Category of left presentations of Q[x,y]>
complex := AsComplex( complex );
#! <An object in Complex category of Ascending filtered object category of Category of left presentations of Q[x,y]>
LessGenFunctor := FunctorLessGeneratorsLeft( R );
#! Less generators for Category of left presentations of Q[x,y]
s := SpectralSequenceEntryOfAscendingFilteredComplex( complex, 0, 0, 0 );
#! <A morphism in Generalized morphism category of Category of left presentations of Q[x,y]>
Display( UnderlyingMatrix( ApplyFunctor( LessGenFunctor, UnderlyingHonestObject( Source( s ) ) ) ) );
#! (an empty 0 x 1 matrix)
s := SpectralSequenceEntryOfAscendingFilteredComplex( complex, 1, 0, 0 );
#! <A morphism in Generalized morphism category of Category of left presentations of Q[x,y]>
Display( UnderlyingMatrix( ApplyFunctor( LessGenFunctor, UnderlyingHonestObject( Source( s ) ) ) ) );
#! (an empty 0 x 1 matrix)
s := SpectralSequenceEntryOfAscendingFilteredComplex( complex, 2, 0, 0 );
#! <A morphism in Generalized morphism category of Category of left presentations of Q[x,y]>
Display( UnderlyingMatrix( ApplyFunctor( LessGenFunctor, UnderlyingHonestObject( Source( s ) ) ) ) );
#! (an empty 0 x 1 matrix)
s := SpectralSequenceEntryOfAscendingFilteredComplex( complex, 3, 0, 0 );
#! <A morphism in Generalized morphism category of Category of left presentations of Q[x,y]>
Display( UnderlyingMatrix( ApplyFunctor( LessGenFunctor, UnderlyingHonestObject( Source( s ) ) ) ) );
#! x*y,
#! x^2
s := SpectralSequenceEntryOfAscendingFilteredComplex( complex, 4, 0, 0 );
#! <A morphism in Generalized morphism category of Category of left presentations of Q[x,y]>
Display( UnderlyingMatrix( ApplyFunctor( LessGenFunctor, UnderlyingHonestObject( Source( s ) ) ) ) );
#! x*y,
#! x^2,
#! y^3
s := SpectralSequenceEntryOfAscendingFilteredComplex( complex, 5, 0, 0 );
#! <A morphism in Generalized morphism category of Category of left presentations of Q[x,y]>
Display( UnderlyingMatrix( ApplyFunctor( LessGenFunctor, UnderlyingHonestObject( Source( s ) ) ) ) );
#! x*y,
#! x^2,
#! y^3
s := SpectralSequenceDifferentialOfAscendingFilteredComplex( complex, 3, 3, -2 );
#! <A morphism in Category of left presentations of Q[x,y]>
Display( UnderlyingMatrix( ApplyFunctor( LessGenFunctor, s ) ) );
#! y^3
AscToDescFunctor := AscendingToDescendingFilteredObjectFunctor( category );
#! Ascending to descending filtered object functor of Category of left presentations of Q[x,y]
cocomplex := ZFunctorObjectFromMorphismList( [ ApplyFunctor( AscToDescFunctor, delta2 ), ApplyFunctor( AscToDescFunctor, delta1 ) ], -2 );
#! <An object in Functors from integers into Descending filtered object category of Category of left presentations of Q[x,y]>
SetIsAdditiveCategory( CategoryOfDescendingFilteredObjects( category ), true );
cocomplex := AsCocomplex( cocomplex );
#! <An object in Cocomplex category of Descending filtered object category of Category of left presentations of Q[x,y]>
s := SpectralSequenceEntryOfDescendingFilteredCocomplex( cocomplex, 0, -2, 1 );
#! <A morphism in Generalized morphism category of Category of left presentations of Q[x,y]>
Display( UnderlyingMatrix( ApplyFunctor( LessGenFunctor, UnderlyingHonestObject( Source( s ) ) ) ) );
#! (an empty 0 x 2 matrix)
s := SpectralSequenceEntryOfDescendingFilteredCocomplex( cocomplex, 1, -2, 1 );
#! <A morphism in Generalized morphism category of Category of left presentations of Q[x,y]>
Display( UnderlyingMatrix( ApplyFunctor( LessGenFunctor, UnderlyingHonestObject( Source( s ) ) ) ) );
#! (an empty 0 x 2 matrix)
s := SpectralSequenceEntryOfDescendingFilteredCocomplex( cocomplex, 2, -2, 1 );
#! <A morphism in Generalized morphism category of Category of left presentations of Q[x,y]>
Display( UnderlyingMatrix( ApplyFunctor( LessGenFunctor, UnderlyingHonestObject( Source( s ) ) ) ) );
#! -y,x
s := SpectralSequenceEntryOfDescendingFilteredCocomplex( cocomplex, 3, -2, 1 );
#! <A morphism in Generalized morphism category of Category of left presentations of Q[x,y]>
Display( UnderlyingMatrix( ApplyFunctor( LessGenFunctor, UnderlyingHonestObject( Source( s ) ) ) ) );
#! (an empty 0 x 0 matrix)
s := SpectralSequenceDifferentialOfDescendingFilteredCocomplex( cocomplex, 2, -2, 1 );
#! <A morphism in Category of left presentations of Q[x,y]>
Display( UnderlyingMatrix( ApplyFunctor( LessGenFunctor, s ) ) );
#! x^2,
#! x*y
#! @EndExample
